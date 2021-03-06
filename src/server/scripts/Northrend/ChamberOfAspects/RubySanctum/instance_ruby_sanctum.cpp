/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
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

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "ruby_sanctum.h"


DoorData const doorData[] =
{
    {GO_FIRE_FIELD,     DATA_BALTHARUS_THE_WARBORN, DOOR_TYPE_PASSAGE,  BOUNDARY_E   },
    {0,                 0,                          DOOR_TYPE_ROOM,     BOUNDARY_NONE},
};

class instance_ruby_sanctum : public InstanceMapScript
{
    public:
        instance_ruby_sanctum() : InstanceMapScript("instance_ruby_sanctum", 724) { }

        struct instance_ruby_sanctum_InstanceMapScript : public InstanceScript
        {
            instance_ruby_sanctum_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
            {
                SetBossNumber(EncounterCount);
                LoadDoorData(doorData);
                BaltharusTheWarbornGUID  = 0;
                GeneralZarithrianGUID    = 0;
                SavianaRagefireGUID      = 0;
                HalionGUID               = 0;
                TwilightHalionGUID       = 0;
                OrbCarrierGUID[0]        = 0;
                OrbCarrierGUID[1]        = 0;
                OrbRotationFocusGUID     = 0;
                HalionControllerGUID     = 0;
                CombatStalkerGUID        = 0;
                CrystalChannelTargetGUID = 0;
                XerestraszaGUID          = 0;
                BaltharusSharedHealth    = 0;
                FlameWallsGUID           = 0;
                FlameRingGUID            = 0;

                memset(ZarithrianSpawnStalkerGUID, 0, 2 * sizeof(uint64));
                memset(BurningTreeGUID, 0, 4 * sizeof(uint64));

		hallionHealthTotal = 0;
		hallionRealDamageTotal = 0;
		hallionTwilightDamageTotal = 0;
		corpo = 0;
		OrbCnt = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_BALTHARUS_THE_WARBORN:
                        BaltharusTheWarbornGUID = creature->GetGUID();
                        break;
                    case NPC_GENERAL_ZARITHRIAN:
                        GeneralZarithrianGUID = creature->GetGUID();
                        break;
                    case NPC_SAVIANA_RAGEFIRE:
                        SavianaRagefireGUID = creature->GetGUID();
                        break;
                    case NPC_HALION:
                        HalionGUID = creature->GetGUID();
                        break;
                    case NPC_TWILIGHT_HALION:
                        TwilightHalionGUID = creature->GetGUID();
                        break;
                    case NPC_HALION_CONTROLLER:
                        HalionControllerGUID = creature->GetGUID();
                        break;
                    case NPC_ORB_CARRIER:
                        OrbCarrierGUID[OrbCnt] = creature->GetGUID();
                        OrbCnt++;
                        if (OrbCnt >= 2)
                            OrbCnt = 0;
                        break;
                    case NPC_ORB_ROTATION_FOCUS:
                        OrbRotationFocusGUID = creature->GetGUID();
                        break;
                    case NPC_COMBAT_STALKER:
                        CombatStalkerGUID = creature->GetGUID();
                        break;
                    case NPC_BALTHARUS_TARGET:
                        CrystalChannelTargetGUID = creature->GetGUID();
                        break;
                    case NPC_XERESTRASZA:
                        XerestraszaGUID = creature->GetGUID();
                        break;
                    case NPC_ZARITHRIAN_SPAWN_STALKER:
                        if (!ZarithrianSpawnStalkerGUID[0])
                            ZarithrianSpawnStalkerGUID[0] = creature->GetGUID();
                        else
                            ZarithrianSpawnStalkerGUID[1] = creature->GetGUID();
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_FIRE_FIELD:
                        AddDoor(go, true);
                        break;
                    case GO_FLAME_WALLS:
                        FlameWallsGUID = go->GetGUID();
                        if (GetBossState(DATA_SAVIANA_RAGEFIRE) == DONE && GetBossState(DATA_BALTHARUS_THE_WARBORN) == DONE)
                            HandleGameObject(FlameWallsGUID, true, go);
                        break;
                    case GO_FLAME_RING:
                        FlameRingGUID = go->GetGUID();
                        break;
                    case GO_TWILIGHT_FLAME_RING:
                        TwilightFlameRingGUID = go->GetGUID();
                        break;
                    case GO_BURNING_TREE_1:
                        BurningTreeGUID[0] = go->GetGUID();
                        if (GetBossState(DATA_GENERAL_ZARITHRIAN) == DONE)
                            HandleGameObject(BurningTreeGUID[0], true);
                        break;
                    case GO_BURNING_TREE_2:
                        BurningTreeGUID[1] = go->GetGUID();
                        if (GetBossState(DATA_GENERAL_ZARITHRIAN) == DONE)
                            HandleGameObject(BurningTreeGUID[1], true);
                        break;
                    case GO_BURNING_TREE_3:
                        BurningTreeGUID[2] = go->GetGUID();
                        if (GetBossState(DATA_GENERAL_ZARITHRIAN) == DONE)
                            HandleGameObject(BurningTreeGUID[2], true);
                        break;
                    case GO_BURNING_TREE_4:
                        BurningTreeGUID[3] = go->GetGUID();
                        if (GetBossState(DATA_GENERAL_ZARITHRIAN) == DONE)
                            HandleGameObject(BurningTreeGUID[3], true);
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectRemove(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_FIRE_FIELD:
                        AddDoor(go, false);
                        break;
                    default:
                        break;
                }
            }

	  void UpdateWorldState(bool command, uint32 value)
	  {
	    Map::PlayerList const &players = instance->GetPlayers();

            if (command)
	      {
                for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
		  if(Player* pPlayer = i->getSource())
		    if(pPlayer->isAlive())
		      {
			pPlayer->SendUpdateWorldState(UPDATE_STATE_UI_SHOW,0);
			if (pPlayer->HasAura(74807))
			  pPlayer->SendUpdateWorldState(UPDATE_STATE_UI_COUNT_T, 100 - value);
			else pPlayer->SendUpdateWorldState(UPDATE_STATE_UI_COUNT_R, value);
			pPlayer->SendUpdateWorldState(UPDATE_STATE_UI_SHOW,1);
		      }
	      }
            else
	      {
		for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
		  if(Player* pPlayer = i->getSource())
                    if(pPlayer->isAlive())
		      pPlayer->SendUpdateWorldState(UPDATE_STATE_UI_SHOW,0);
	      }
	  }

            uint64 GetData64(uint32 type)
            {
                switch (type)
                {
                    case DATA_BALTHARUS_THE_WARBORN:
                        return BaltharusTheWarbornGUID;
                    case DATA_CRYSTAL_CHANNEL_TARGET:
                        return CrystalChannelTargetGUID;
                    case DATA_XERESTRASZA:
                        return XerestraszaGUID;
                    case DATA_SAVIANA_RAGEFIRE:
                        return SavianaRagefireGUID;
                    case DATA_GENERAL_ZARITHRIAN:
                        return GeneralZarithrianGUID;
                    case DATA_ZARITHRIAN_SPAWN_STALKER_1:
                    case DATA_ZARITHRIAN_SPAWN_STALKER_2:
                        return ZarithrianSpawnStalkerGUID[type - DATA_ZARITHRIAN_SPAWN_STALKER_1];
                    case DATA_HALION:
                        return HalionGUID;
                    case DATA_TWILIGHT_HALION:
                        return TwilightHalionGUID;
                    case DATA_ORB_CARRIER:
                        return OrbCarrierGUID[0];
                    case DATA_ORB_CARRIER_HM:
                        return OrbCarrierGUID[1];
                    case DATA_ORB_ROTATION_FOCUS:
                        return OrbRotationFocusGUID;
                    case DATA_HALION_CONTROLLER:
                        return HalionControllerGUID;
                    case DATA_BURNING_TREE_1:
                    case DATA_BURNING_TREE_2:
                    case DATA_BURNING_TREE_3:
                    case DATA_BURNING_TREE_4:
                        return BurningTreeGUID[type - DATA_BURNING_TREE_1];
                    case DATA_FLAME_RING:
                        return FlameRingGUID;
                    case DATA_TWILIGHT_FLAME_RING:
                        return TwilightFlameRingGUID;
                    case DATA_COMBAT_STALKER:
                        return CombatStalkerGUID;
                    default:
                        break;
                }

                return 0;
            }

            bool SetBossState(uint32 type, EncounterState state)
            {
                if (!InstanceScript::SetBossState(type, state))
                    return false;

                switch (type)
                {
                    case DATA_BALTHARUS_THE_WARBORN:
                    {
                        if (state == DONE && GetBossState(DATA_SAVIANA_RAGEFIRE) == DONE)
                        {
                            HandleGameObject(FlameWallsGUID, true);
                            if (Creature* zarithrian = instance->GetCreature(GeneralZarithrianGUID))
                                zarithrian->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                        }
                        break;
                    }
                    case DATA_SAVIANA_RAGEFIRE:
                    {
                        if (state == DONE && GetBossState(DATA_BALTHARUS_THE_WARBORN) == DONE)
                        {
                            HandleGameObject(FlameWallsGUID, true);
                            if (Creature* zarithrian = instance->GetCreature(GeneralZarithrianGUID))
                                zarithrian->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                        }
                        break;
                    }
                    case DATA_GENERAL_ZARITHRIAN:
                        if (GetBossState(DATA_SAVIANA_RAGEFIRE) == DONE && GetBossState(DATA_BALTHARUS_THE_WARBORN) == DONE)
                            HandleGameObject(FlameWallsGUID, state != IN_PROGRESS);
                        if (state == DONE)
                            if (Creature* halionController = instance->SummonCreature(NPC_HALION_CONTROLLER, HalionControllerSpawnPos))
                                halionController->AI()->DoAction(ACTION_INTRO_HALION);
                        break;
                    case DATA_HALION:
                    {
                        if (state == IN_PROGRESS)
                            break;

                        DoUpdateWorldState(WORLDSTATE_CORPOREALITY_TOGGLE, 0);
                        DoUpdateWorldState(WORLDSTATE_CORPOREALITY_TWILIGHT, 0);
                        DoUpdateWorldState(WORLDSTATE_CORPOREALITY_MATERIAL, 0);

                        HandleGameObject(FlameRingGUID, true);
                        HandleGameObject(TwilightFlameRingGUID, true);
                        break;
                    }
                    default:
                        break;
                }

                return true;
            }

	  void OnPlayerEnter(Player* player)
	  {
	    if (Creature* zarithrian = instance->GetCreature(GeneralZarithrianGUID))
	      {
		if (zarithrian->isAlive())
		  return ;
	      }
	    else
	      return;
	    //	    if (Creature* hallion = instance->GetCreature(HalionGUID))
	    //   return ;
	    if (GetBossState(DATA_HALION) == DONE)
	      return ;

	    if (Creature* controller = instance->GetCreature(HalionControllerGUID))
	      return;

	    if (Creature* halionController = instance->SummonCreature(NPC_HALION_CONTROLLER, HalionControllerSpawnPos))
	      halionController->AI()->DoAction(ACTION_INTRO_HALION);
	  }
            void SetData(uint32 type, uint32 data)
            {
	      switch(type)
		{
		case DATA_HALION_REAL_DAMAGED_INIT:
		  hallionRealDamageTotal = 0;
		  break;
		case DATA_HALION_TWILIGHT_DAMAGED_INIT:
		  hallionTwilightDamageTotal = 0;
		  break;
		case DATA_HALION_REAL_DAMAGED_TOTAL:
		  hallionRealDamageTotal += data;
		  break;
		case DATA_HALION_TWILIGHT_DAMAGED_TOTAL:
		  hallionTwilightDamageTotal += data;
		  break;
		case DATA_HALION_HEALTH_TOTAL_INIT:
		  hallionHealthTotal = data;
		  break;
		case DATA_HALION_HEALTH_TOTAL:
		  if (hallionHealthTotal > data)
		    hallionHealthTotal -= data;
		  else
		    hallionHealthTotal = 1;
		  break;
		case DATA_BALTHARUS_SHARED_HEALTH:
		  BaltharusSharedHealth = data;
		  break;
		case DATA_CORPO:
		  corpo = data;
		  break;
		case TYPE_COUNTER:
		  if (data == 0)
		    UpdateWorldState(false,0);
		  else UpdateWorldState(true,data);
		  break;
		}
	      /*		if (data == DONE)
		  {
		    OUT_SAVE_INST_DATA;

		    std::ostringstream saveStream;

		    for(uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
		      saveStream << m_auiEncounter[i] << " ";

		    strSaveData = saveStream.str();

		    SaveToDB();
		    OUT_SAVE_INST_DATA_COMPLETE;
		    }*/
            }

            uint32 GetData(uint32 type)
            {
	      switch(type)
		{
		case DATA_HALION_REAL_DAMAGED_TOTAL:
		  return hallionRealDamageTotal;
		  break;
		case DATA_HALION_TWILIGHT_DAMAGED_TOTAL:
		  return hallionTwilightDamageTotal;
		  break;
		case DATA_HALION_HEALTH_TOTAL:
		  return hallionHealthTotal;
		case DATA_BALTHARUS_SHARED_HEALTH:
		  return BaltharusSharedHealth;
		case DATA_CORPO:
		  return corpo;
		default:
		  return 0;
		}
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "R S " << GetBossSaveData();

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            void FillInitialWorldStates(WorldPacket& data)
            {
                data << uint32(WORLDSTATE_CORPOREALITY_MATERIAL) << uint32(50);
                data << uint32(WORLDSTATE_CORPOREALITY_TWILIGHT) << uint32(50);
                data << uint32(WORLDSTATE_CORPOREALITY_TOGGLE) << uint32(0);
            }

            void Load(char const* str)
            {
                if (!str)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(str);

                char dataHead1, dataHead2;

                std::istringstream loadStream(str);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'R' && dataHead2 == 'S')
                {
                    for (uint8 i = 0; i < EncounterCount; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                            tmpState = NOT_STARTED;

                        SetBossState(i, EncounterState(tmpState));
                    }
                }
                else
                    OUT_LOAD_INST_DATA_FAIL;

                OUT_LOAD_INST_DATA_COMPLETE;
            }

        protected:
            uint64 BaltharusTheWarbornGUID;
            uint64 GeneralZarithrianGUID;
            uint64 SavianaRagefireGUID;
            uint64 HalionGUID;
            uint64 TwilightHalionGUID;
            uint64 HalionControllerGUID;
            uint64 OrbCarrierGUID[2];
            uint64 OrbRotationFocusGUID;
            uint64 CrystalChannelTargetGUID;
            uint64 XerestraszaGUID;
            uint64 FlameWallsGUID;
            uint64 ZarithrianSpawnStalkerGUID[2];
            uint64 BurningTreeGUID[4];
            uint64 FlameRingGUID;
            uint64 TwilightFlameRingGUID;
            uint64 CombatStalkerGUID;

            uint32 BaltharusSharedHealth;

	  uint32 hallionHealthTotal;
	  uint32 hallionRealDamageTotal;
	  uint32 hallionTwilightDamageTotal;
	  uint32 corpo;

	  uint8 OrbCnt;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_ruby_sanctum_InstanceMapScript(map);
        }
};

void AddSC_instance_ruby_sanctum()
{
    new instance_ruby_sanctum();
}
