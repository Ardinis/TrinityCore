/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "MapInstanced.h"
#include "ObjectMgr.h"
#include "MapManager.h"
#include "Battleground.h"
#include "VMapFactory.h"
#include "MMapFactory.h"
#include "InstanceSaveMgr.h"
#include "World.h"
#include "Group.h"
#include "LFGMgr.h"
#include "InstanceScript.h"
#include "Transport.h"

#ifndef _WIN32
#include <setjmp.h>

extern __thread sigjmp_buf *crash_recovery;
extern __thread uint32 currently_updated;
extern __thread bool in_handler;
#endif

void generate_coredump();


MapInstanced::MapInstanced(uint32 id, time_t expiry) : Map(id, expiry, 0, DUNGEON_DIFFICULTY_NORMAL)
{
    // initialize instanced maps list
    m_InstancedMaps.clear();
    // fill with zero
    memset(&GridMapReference, 0, MAX_NUMBER_OF_GRIDS*MAX_NUMBER_OF_GRIDS*sizeof(uint16));
}

void MapInstanced::InitVisibilityDistance()
{
    if (m_InstancedMaps.empty())
        return;
    //initialize visibility distances for all instance copies
    for (InstancedMaps::iterator i = m_InstancedMaps.begin(); i != m_InstancedMaps.end(); ++i)
    {
        (*i).second->InitVisibilityDistance();
    }
}

void MapInstanced::Update(const uint32 t)
{
    // take care of loaded GridMaps (when unused, unload it!)
    Map::Update(t);

    // update the instanced maps
    InstancedMaps::iterator i = m_InstancedMaps.begin();

    while (i != m_InstancedMaps.end())
    {
		bool crash = false;
		bool killed = false;

		#ifndef _WIN32
			crash = i->second->ToInstanceMap() && i->second->ToInstanceMap()->HasCrashed();
			killed = i->second->ToInstanceMap() && i->second->ToInstanceMap()->HasBeenKilled();
		#endif

		if (crash) {
			/* kick players */ 
			Map::PlayerList const pList = i->second->GetPlayers();
			for (PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
			{
				Player* player = itr->getSource();
				if (!player || !player->GetSession())
					continue;
					// NOT THREAD-SAFE
					// En fait si, vu que on touche qu'a des objets qui appartiennent à la map qui a crash, donc ca peut pas etre utilisé par d'autres threads
					// vu qu'il n'y a qu'une thread par map... Je sais pas ce que j'avais fumé ce jour la.
					player->SaveToDB();
					player->CleanupChannels();
					player->UninviteFromGroup();
					player->GetSession()->KickPlayer();
					sWorld->ForceKillSession(player->GetSession());
					player->SetDoNotSave(true);
			}

			
			/* Forget map grid objcets */ 
			i->second->ObliviateGridObjects();
			i->second->ObliviateWorldObjects();

			std::ostringstream tmpstr;
			std::string buf = "";
			tmpstr << i->second->GetInstanceId();
			buf = "Para-Chute(TM) : " + std::string(i->second->GetMapName()) + ", ID " + tmpstr.str() + ": Plantage du script d'instance, Crash évité. Le petit coup de lag est du à l'écriture des informations de debug.";
			sWorld->SendWorldText(LANG_SYSTEMMESSAGE, buf.c_str());

			m_InstancedMaps.erase(i++);
    
			
			
		} else if (killed) {
#ifndef _WIN32
                sigjmp_buf env;
                crash_recovery = &env;
                currently_updated = i->second->ToInstanceMap()->GetId();
                InstanceMap *mymap = i->second->ToInstanceMap();
                
                
                // Decommenter ca si on veut generer un coredump en cas de killinstance
                // Pour l'instant ca sert pas à grand chose, vu qu'il faudrait au moins avoir une liste des pointeurs
                // vers les objets de la map, et vers l'instancescript (TODO)
                // generate_coredump();
                
                sLog->outError("KillInstance done on %s (ID %u)", i->second->GetMapName(), i->second->GetInstanceId());
                
                if (sigsetjmp(env,1)) {
                    crash_recovery = NULL;
                    i->second->ToInstanceMap()->SetHasCrashed(true);
                    in_handler = false;
                    sLog->outError("warning: crash during instance cleanup (handled)");
                    continue; // proceed to next instancemap, current map will be Oblivated at next MapInstanced::Update() 
                }
#endif

                        //teleport players to graveyard
			Map::PlayerList const pList = i->second->GetPlayers();
			for (PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
			{
			        // NOT THREAD-SAFE
                                // En fait si, vu que on touche qu'a des objets qui appartiennent à la map qui a crash, donc ca peut pas etre utilisé par d'autres threads
                                // vu qu'il n'y a qu'une thread par map... Je sais pas ce que j'avais fumé ce jour la.
				Player* player = itr->getSource();
				if (!player || !player->GetSession())
					continue;
                                player->GetSession()->KickPlayer();
                                player->GetSession()->LogoutPlayer(true);
			}
			
                if (!i->second->HavePlayers())
                    DestroyInstance(i);
                

#ifndef _WIN32
                crash_recovery = NULL;
#endif

        } else if (i->second->CanUnload(t))
        {
            if (!DestroyInstance(i))                             // iterator incremented
            {
                //m_unloadTimer
            }
        }
        else
        {
            // update only here, because it may schedule some bad things before delete
            if (sMapMgr->GetMapUpdater()->activated())
                sMapMgr->GetMapUpdater()->schedule_update(*i->second, t);
            else
                i->second->Update(t);
            ++i;
        }
    }
}

void MapInstanced::DelayedUpdate(const uint32 diff)
{
    for (InstancedMaps::iterator i = m_InstancedMaps.begin(); i != m_InstancedMaps.end(); ++i)
        i->second->DelayedUpdate(diff);

    Map::DelayedUpdate(diff); // this may be removed
}

/*
void MapInstanced::RelocationNotify()
{
    for (InstancedMaps::iterator i = m_InstancedMaps.begin(); i != m_InstancedMaps.end(); ++i)
        i->second->RelocationNotify();
}
*/

void MapInstanced::UnloadAll()
{
    // Unload instanced maps
    for (InstancedMaps::iterator i = m_InstancedMaps.begin(); i != m_InstancedMaps.end(); ++i)
        i->second->UnloadAll();

    // Delete the maps only after everything is unloaded to prevent crashes
    for (InstancedMaps::iterator i = m_InstancedMaps.begin(); i != m_InstancedMaps.end(); ++i)
        delete i->second;

    m_InstancedMaps.clear();

    // Unload own grids (just dummy(placeholder) grids, neccesary to unload GridMaps!)
    Map::UnloadAll();
}

/*
- return the right instance for the object, based on its InstanceId
- create the instance if it's not created already
- the player is not actually added to the instance (only in InstanceMap::Add)
*/
Map* MapInstanced::CreateInstanceForPlayer(const uint32 mapId, Player* player)
{
    if (GetId() != mapId || !player)
        return NULL;

    Map* map = NULL;
    uint32 NewInstanceId = 0;                       // instanceId of the resulting map

    if (IsBattlegroundOrArena())
    {
        // instantiate or find existing bg map for player
        // the instance id is set in battlegroundid
        NewInstanceId = player->GetBattlegroundId();
        if (!NewInstanceId) return NULL;
        map = sMapMgr->FindMap(mapId, NewInstanceId);
        if (!map)
        {
            if (Battleground* bg = player->GetBattleground())
                map = CreateBattleground(NewInstanceId, bg);
            else
            {
                player->TeleportToBGEntryPoint();
                return NULL;
            }
        }
    }
    else
    {
        InstancePlayerBind* pBind = player->GetBoundInstance(GetId(), player->GetDifficulty(IsRaid()));
        InstanceSave* pSave = pBind ? pBind->save : NULL;

        // the player's permanent player bind is taken into consideration first
        // then the player's group bind and finally the solo bind.
        if (!pBind || !pBind->perm)
        {
            InstanceGroupBind* groupBind = NULL;
            Group* group = player->GetGroup();
            // use the player's difficulty setting (it may not be the same as the group's)
            if (group)
            {
                groupBind = group->GetBoundInstance(this);
                if (groupBind)
                    pSave = groupBind->save;
            }
        }
        if (pSave)
        {
            // solo/perm/group
            NewInstanceId = pSave->GetInstanceId();
            map = FindInstanceMap(NewInstanceId);
            // it is possible that the save exists but the map doesn't
            if (!map)
			{
                map = CreateInstance(NewInstanceId, pSave, pSave->GetDifficulty());
				if (player->GetGroup() && player->GetGroup()->isLFGGroup() && map && ((InstanceMap*)map)->GetInstanceScript())
				{
					if (uint32 dungeonId = sLFGMgr->GetDungeon(player->GetGroup()->GetGUID(), true))
						if (LFGDungeonEntry const* dungeon = sLFGDungeonStore.LookupEntry(dungeonId))
							if (dungeon->map == map->GetId() && dungeon->difficulty == map->GetDifficulty())
								((InstanceMap*)map)->GetInstanceScript()->SetIsLfg(true);
				}
			}
        }
        else
        {
            // if no instanceId via group members or instance saves is found
            // the instance will be created for the first time
            NewInstanceId = sMapMgr->GenerateInstanceId();

            Difficulty diff = player->GetGroup() ? player->GetGroup()->GetDifficulty(IsRaid()) : player->GetDifficulty(IsRaid());
            //Seems it is now possible, but I do not know if it should be allowed
            //ASSERT(!FindInstanceMap(NewInstanceId));
            map = FindInstanceMap(NewInstanceId);
            if (!map)
			{
                map = CreateInstance(NewInstanceId, NULL, diff);
				if (player->GetGroup() && player->GetGroup()->isLFGGroup() && map && ((InstanceMap*)map)->GetInstanceScript())
				{
					if (uint32 dungeonId = sLFGMgr->GetDungeon(player->GetGroup()->GetGUID(), true))
						if (LFGDungeonEntry const* dungeon = sLFGDungeonStore.LookupEntry(dungeonId))
							if (dungeon->map == map->GetId() && dungeon->difficulty == map->GetDifficulty())
								((InstanceMap*)map)->GetInstanceScript()->SetIsLfg(true);
				}
			}
        }
    }

    return map;
}

InstanceMap* MapInstanced::CreateInstance(uint32 InstanceId, InstanceSave* save, Difficulty difficulty)
{
    // load/create a map
    TRINITY_GUARD(ACE_Thread_Mutex, Lock);

    // make sure we have a valid map id
    const MapEntry* entry = sMapStore.LookupEntry(GetId());
    if (!entry)
    {
        sLog->outError("CreateInstance: no entry for map %d", GetId());
        ASSERT(false);
    }
    const InstanceTemplate* iTemplate = sObjectMgr->GetInstanceTemplate(GetId());
    if (!iTemplate)
    {
        sLog->outError("CreateInstance: no instance template for map %d", GetId());
        ASSERT(false);
    }

    // some instances only have one difficulty
    GetDownscaledMapDifficultyData(GetId(), difficulty);

    sLog->outDebug(LOG_FILTER_MAPS, "MapInstanced::CreateInstance: %s map instance %d for %d created with difficulty %s", save?"":"new ", InstanceId, GetId(), difficulty?"heroic":"normal");

    InstanceMap* map = new InstanceMap(GetId(), GetGridExpiry(), InstanceId, difficulty, this);
    ASSERT(map->IsDungeon());

    bool load_data = save != NULL;
    map->CreateInstanceData(load_data);

    m_InstancedMaps[InstanceId] = map;
    return map;
}

BattlegroundMap* MapInstanced::CreateBattleground(uint32 InstanceId, Battleground* bg)
{
    // load/create a map
    TRINITY_GUARD(ACE_Thread_Mutex, Lock);

    sLog->outDebug(LOG_FILTER_MAPS, "MapInstanced::CreateBattleground: map bg %d for %d created.", InstanceId, GetId());

    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), bg->GetMinLevel());

    uint8 spawnMode;

    if (bracketEntry)
        spawnMode = bracketEntry->difficulty;
    else
        spawnMode = REGULAR_DIFFICULTY;

    BattlegroundMap* map = new BattlegroundMap(GetId(), GetGridExpiry(), InstanceId, this, spawnMode);
    ASSERT(map->IsBattlegroundOrArena());
    map->SetBG(bg);
    bg->SetBgMap(map);

    m_InstancedMaps[InstanceId] = map;
    return map;
}

// increments the iterator after erase
bool MapInstanced::DestroyInstance(InstancedMaps::iterator &itr)
{
    itr->second->RemoveAllPlayers();
    if (itr->second->HavePlayers())
    {
        ++itr;
        return false;
    }

    itr->second->UnloadAll();
    // should only unload VMaps if this is the last instance and grid unloading is enabled
    if (m_InstancedMaps.size() <= 1 && sWorld->getBoolConfig(CONFIG_GRID_UNLOAD))
    {
        VMAP::VMapFactory::createOrGetVMapManager()->unloadMap(itr->second->GetId());
        MMAP::MMapFactory::createOrGetMMapManager()->unloadMap(itr->second->GetId());
        // in that case, unload grids of the base map, too
        // so in the next map creation, (EnsureGridCreated actually) VMaps will be reloaded
        Map::UnloadAll();
    }

    // Free up the instance id and allow it to be reused for bgs and arenas (other instances are handled in the InstanceSaveMgr)
    if (itr->second->IsBattlegroundOrArena())
        sMapMgr->FreeInstanceId(itr->second->GetInstanceId());


    // HACK: Disable transport update for destroyed maps
    if (itr->second->GetId() == 631) {
      MapManager::TransportMap& tmap = sMapMgr->m_TransportsByInstanceIdMap;
      for (MapManager::TransportSet::iterator itr2 = sMapMgr->m_TransportsByInstanceIdMap[itr->first].begin(); itr2 != sMapMgr->m_TransportsByInstanceIdMap[itr->first].end(); ++itr2) {
        Transport *trans = *itr2;
        if (trans != NULL) {
          if (trans->GetMap() == itr->second) {
            trans->DisableTransport();
          }
        }
      }
    }
            
    // erase map
    delete itr->second;
    m_InstancedMaps.erase(itr++);

    return true;
}

bool MapInstanced::CanEnter(Player* /*player*/)
{
    //ASSERT(false);
    return true;
}
