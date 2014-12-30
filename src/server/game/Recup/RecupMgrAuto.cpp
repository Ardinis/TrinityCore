/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 * Copyright (C) 2013-2014 Oxygen Server <http://www.oxygen-servers.fr/>
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

#include "RecupMgrAuto.h"
#include "DatabaseEnv.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "AchievementMgr.h"

/*
        perso:
	 MONEY : pareil - OK
	 ITEM : pareil - OK
	 LEVEL : pareil - OK
	 HUNTER_PET : pareil - OK
	 REPUT : pareil - OK
	 HF : OK [utilisé que dans la récup auto] On donne le HF au joueur. 
	 MAP : OK [utilisé que dans la récup auto] On marque l'area comme explorée, et on donne également le fly si jamais y'a un fly dans la zone (vérifier la faction du fly omfg!) 
	 QUEST : OK [utliisé que dans la récup auto] On marque la quete comme finie. 
	 HF partiel : OK 
	 
	guilde: 
	 GUILD/GUILD_ITEM : Rien pour l'instant, ca sera traité après. 
*/


/*
	COMPETENCE/SKILL : [pareil que récup classique, a part pour le give d'items batonnets etc] on apprends le métier, 
	et le spell correspondant au rank (maitre, artisan, ..). PAS les recettes. Et on file pas non plus d'items (batonnet etc). 
	OK
*/

/* /!\ Ca prend le skill-id et pas le spell-id */
bool RecupMgrAuto::GiveSkillById(Player *player, int id_metier, int level) {
        bool found = false;
	for (int i = 0; i <sSkillLineAbilityStore.GetNumRows(); i++) {
		SkillLineAbilityEntry const* ability = sSkillLineAbilityStore.LookupEntry(i);
		if (ability && (ability->skillId == id_metier)) {
		        found = true;
		        if (!ability->racemask || (ability->racemask & player->getRaceMask()))
		                player->SetSkill(ability->skillId, 0, level, ((level < 75) ? 75 : level));
		}
	}
	if (!found)
//	    sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "competence", player->GetGUID(), id_metier, 0, "Impossible de trouver la competence: %d", id_metier);
//        	sLog->outVisitLog("RECUP: Guid %u Skill %u : Impossible de trouver la competence", player->GetGUIDLow(), id_metier);
        return found;
}



bool RecupMgrAuto::DoRecupAuto(Player *player) {
	int i;
	uint32 start = getMSTime();

	//En premier, on regarde si c'est une recup totale, ou non (perso pas dans une guilde)
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_ILEVEL);
	stmt->setUInt32(0, player->GetGUID());
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	if (!res)
		return false;
	Field* fields = res->Fetch();
	if (!fields)
		return false;
	
	uint32 ilevel = fields[0].GetUInt32();
        
        ApplyRecupAura(player, ilevel);


	// table link_recup qui vient du site
	/*
	if (!HandleLinkRecupTableAuto(player, ilevel))
		return false;
        */
        if (player->recup_task) {
//            sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "perso", player->GetGUID(), 0, 0, "Le joueur a deja une recuperation en cours!");
            return false;
        }
        player->recup_task = BackgroundRecupTask::Factory(player, ilevel);
        return (player->recup_task != NULL);
}






//Recup Totale à la fin avec link_recup
bool RecupMgrAuto::HandleLinkRecupTableAuto(Player *player, int ilevel) {
// 
}




/*
Le champ "numparam" indique le mode de récup ( 0 == récup classique,
1 == récup automatique). Si le champ n'existe pas, alors par défaut c'est valeur 0 (récup classique). 
*/
int RecupMgrAuto::GetRecupMode(Player *plr) {
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_MODE);
	stmt->setUInt32(0, plr->GetGUID());
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	if (!res)
		return 0;
	Field* fields = res->Fetch();
	if (!fields)
		return 0;
		
	return (fields[0].GetUInt32());
}

int RecupMgrAuto::GetRecupGuildStatus(Player *plr) {
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_GUILD_STATUS);
	stmt->setUInt32(0, plr->GetGUID());
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	if (!res)
		return -1;
	Field* fields = res->Fetch();
	if (!fields)
		return -1;
		
	return (fields[0].GetUInt32());
}

void RecupMgrAuto::SetRecupGuildStatus(Player *plr, uint32 status) {
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_SET_RECUP_GUILD_STATUS);
	stmt->setUInt32(0, status);
	stmt->setUInt32(1, plr->GetGUID());
	CharacterDatabase.Execute(stmt);
}


bool RecupMgrAuto::recup_enable = false;

bool RecupMgrAuto::isInList(int type, uint32 id) {
	if ((type < 0) || (type >= recup_lists.size())) {
	
//	        sLog->outUnified(LOG_WARNING, NULL, "recupauto", "perso", 0, type, id, "Consultation d'une blacklist/whitelist inexistante!");
		return false;
	}
	return (recup_lists[type].find(id) != recup_lists[type].end());
}

bool RecupMgrAuto::LoadFromDB() {
	//(re)-load depuis la DB;
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_MAX_RECUP_LIST);
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	if (!res) {
//		sLog->outError("Impossible de charger les tables de blacklist/whitelists de recup!");
		return false;
	}
	Field *fields = res->Fetch();
	if (fields == NULL) {
//		sLog->outError("Impossible de charger les tables de blacklist/whitelists de recup!");
		return false;
	}
	uint32 list_size = fields[0].GetUInt32() + 1;      

	recup_lists.resize(list_size);

	
	for (int i = 0; i < list_size; i++) {
		PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_LIST);
		stmt->setUInt32(0, i);
		PreparedQueryResult res = CharacterDatabase.Query(stmt);
		if (!res) {
//			sLog->outError("Impossible de charger la table de blacklist/whitelist %d", i);
			return false;
		}
		recup_lists[i].clear();
		do {
		        Field *fields = res->Fetch();
		        if (!fields)
		                break;
			uint32 id = fields[0].GetUInt32();
				recup_lists[i].insert(id);
		} while (res->NextRow());
	}
	PreparedStatement *stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_REMPLACE);
	PreparedQueryResult res2 = CharacterDatabase.Query(stmt2);
	if (!res2) {
//	        sLog->outError("Impossible de charger la table de remplacement de stuff");
	        return false;
	}
	recup_remplace.clear();
	do {
	        Field *fields = res2->Fetch();
	        if (!fields)
	                break;
	        uint32 id = fields[0].GetUInt32();
	        uint32 new_id = fields[1].GetUInt32();
	        recup_remplace[id] = new_id;
	} while (res2->NextRow());
	return true;
	
}

void RecupMgrAuto::fillGuildBank(Player *player,Guild *guild) {
	SQLTransaction trans;
	bool ok = true;
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_GUILD_ITEMS);
	stmt->setUInt32(0, player->GetGUID());
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	if (!res) {
//	        sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "itemguilde", player->GetGUID(), 0, 0, "Erreur recuperation item BDG (guilde: %s)", guild->GetName().c_str());
                //sLog->outVisitLog("[RECUP] Erreur recup guilde, joueur=%s (guid %u), guilde=%s", player->GetName(), player->GetGUIDLow(), guild->GetName().c_str());
                if (player->GetSession()) 
                        player->GetSession()->SendNotification("Erreur de recuperation de guilde (ITEM), veuillez faire une requete MJ.");
                ok = false;
                SetRecupGuildStatus(player, 2);
                return;
	}
	trans=CharacterDatabase.BeginTransaction();
	uint32 slot_id[6];
	memset(slot_id, 0, sizeof(slot_id));
	do {
	        Field *fields = res->Fetch();
	        if (!fields)
	                break;
                uint32 tab  = fields[0].GetUInt32() - FIELD_TYPE_GUILD_ITEM_ONGLET_1;
                uint32 item_id = fields[1].GetUInt32();
                uint32 item_count = fields[2].GetUInt32();
                ItemTemplate const* item_proto = sObjectMgr->GetItemTemplate(item_id);
                if (tab > 8)
                    continue; // parano
                if (RecupMgrAuto::isInList(RecupMgrAuto::RECUP_LIST_ITEM, item_id) || !item_proto || (item_count < 1))
                        continue; // item invalide / blackliste ou autre connerie
                while (item_count) {
                        uint32 current_stack = (item_count > item_proto->GetMaxStackSize()) ? item_proto->GetMaxStackSize() : item_count;
                        Item *item = Item::CreateItem(item_id, current_stack, NULL);
                        if (!item) {
//                                sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "itemguilde", player->GetGUID(), item_id, 0, "Erreur de creation d'item BDG (guilde: %s item_id: %d)", guild->GetName().c_str(), item_id);
                                ok = false;
                        }
                        
                        if (slot_id[tab] == 0) {
                            while (guild->_GetPurchasedTabsSize() <= tab) {
                                guild->HandleBuyBankTab(player->GetSession(), guild->_GetPurchasedTabsSize(), false);
                            }
                        }
                        if (!guild->GetBankTab(tab)->SetItem(trans, slot_id[tab], item)) {
//                                sLog->outVisitLog("[RECUP] Guilde %s, impossible d'ajouter l'item BDG %u", guild->GetName().c_str(), item_id);
                                ok = false;
                        }
                        slot_id[tab]++;
                        item_count -= current_stack;
                }
	} while (res->NextRow());
	stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_GUILD_GOLD);
	stmt->setUInt32(0, player->GetGUID());
	res = CharacterDatabase.Query(stmt);
	if (!res) {
//                sLog->outVisitLog("[RECUP] Erreur recup guilde, joueur=%s (guid %u), guilde=%s", player->GetName(), player->GetGUIDLow(), guild->GetName().c_str());
                ok = false;
                if (player->GetSession())
                        player->GetSession()->SendNotification("Erreur de recuperation de guilde (PO), veuillez faire une requete MJ.");
	} else {
        	Field *fields = res->Fetch();
        	if (fields) {
        	        uint64 bank_money = fields[0].GetUInt64();
        	        guild->_ModifyBankMoney(trans, bank_money, true);
        	}
        }
	CharacterDatabase.CommitTransaction(trans);
	SetRecupGuildStatus(player, ok ? 1 : 2);
	if (ok) {
//	        sLog->outUnified(LOG_INFO, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "guilde", player->GetGUID(), 0, 0, "Recuperation guilde OK: %s", guild->GetName().c_str());
	        player->GetSession()->SendNotification("La recuperation de guilde a reussi.");
	} else {
	    player->GetSession()->SendNotification("Une erreur s'est produite, veuillez faire une requete MJ.");
	}
}

void RecupMgrAuto::BuildFactionReverseIndex() {
	FactionEntry const* factionEntry;

	for (unsigned int i = 1; i < sFactionStore.GetNumRows(); i++)
	{
                factionEntry = sFactionStore.LookupEntry(i);
                if (!factionEntry)
                        continue;
		RecupMgrAuto::reput_list[factionEntry->reputationListID] = factionEntry->ID;
	}

}

void RecupMgrAuto::GiveFlyMasters(Player *player) {
        for (uint32 i = 1; i < sTaxiNodesStore.GetNumRows(); ++i)
        {
                if (taxi_flag.find(i) == taxi_flag.end())
                        continue;
                uint16 taxi_areaflag = taxi_flag[i];
                
                
                uint32 offset = taxi_areaflag / 32;
                uint32 bitpos = taxi_areaflag % 32;
                if (offset >= PLAYER_EXPLORED_ZONES_SIZE) {
//                        sLog->outVisitLog("RecpuMgrAuto::GiveFlyMasters(): TaxiNode %d mauvais areaflag %u\n", i, taxi_areaflag);
                        continue;
                }
                

                uint8  field   = (uint8)((i - 1) / 32);
                uint32 submask = 1<<((i-1)%32);

                if (player->GetTeam() == ALLIANCE) {
                        if ((sAllianceTaxiNodesMask[field] & submask) == 0)
                                continue;
                } else /* HORDE */ {
                        if ((sHordeTaxiNodesMask[field] & submask) == 0)
                                continue;
                }
                
                //Verifie qu'on a le droit d'interagir avec le flymaster associe
                

                if (player->GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset) & (1 << bitpos)) {
                        player->m_taxi.SetTaximaskNode(i);
                }
                
        }

}

void RecupMgrAuto::BuildFlyMastersIndex() {
        for (uint32 i = 1; i < sTaxiNodesStore.GetNumRows(); i++)
        {
                TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(i);
                if (!node)
                        continue;
                        
                if (!MapManager::IsValidMapCoord(node->map_id, node->x, node->y, node->z, 0.0f))
                        continue;
//                sLog->outVisitLog("[%u] teste node: %d [1", getMSTime(), i);
                
                
                bool isOutdoors_osef;
                const MapEntry *map_entry = sMapStore.LookupEntry(node->map_id);
                if (!map_entry || map_entry->Instanceable()) {
//                        sLog->outVisitLog("RecupMgrAuto::GiveFlyMasters(): Le flymaster (taxinode=%d) est sur une map invalide (mapid=%d)\n", i, node->map_id);
                        continue;
                }

//                sLog->outVisitLog("[%u] teste node: %d [2", getMSTime(), i);
                Map *baseMap = sMapMgr->FindBaseNonInstanceMap(node->map_id);
                if (baseMap == NULL) {
//                        sLog->outVisitLog("RecupMgrAuto::GiveFlyMasters(): la BaseMap %d n'est pas chargee. Chargement de la map.\n", node->map_id);
                        baseMap = sMapMgr->CreateBaseMap(node->map_id);
                        if (baseMap == NULL) {
//                                sLog->outVisitLog("RecupMgrAuto::GiveFlyMasters(): Le FlyMaster (taxinode=%d) est sur une map introuvable (mapid=%d)\n", i, node->map_id);
                                continue;
                        }
                }
//                sLog->outVisitLog("[%u] teste node: %d [3", getMSTime(), i);
                
                uint16 taxi_areaflag = baseMap->GetAreaFlag(node->x, node->y, node->z, &isOutdoors_osef);
//                sLog->outVisitLog("[%u] teste node: %d [4", getMSTime(), i);
                
                
                taxi_flag[i] = taxi_areaflag;
                
                
        }
}


BackgroundRecupTask* BackgroundRecupTask::Factory(Player *player, int ilevel) {
        BackgroundRecupTask *dr = new BackgroundRecupTask(player, ilevel);
        if (!dr->res) {
//	        sLog->outVisitLog("RECUP: Guid %u, ne trouve pas la table link_recup", player->GetGUIDLow());
	        delete dr;
	        return NULL;
        }
        return dr;
        
}

std::vector<std::set<uint32> > RecupMgrAuto::recup_lists;
std::map<int32, uint32> RecupMgrAuto::reput_list;
std::map<uint32, uint16> RecupMgrAuto::taxi_flag;
std::map<uint32, uint32> RecupMgrAuto::recup_remplace;


int BackgroundRecupTask::Process() {
    int count = 0;
    uint32 time_start = getMSTime();
    invoc_count ++;
		
	do { 
	    uint32 now = getMSTime();
	    if ((now - time_start) > 10) {
//	        sLog->outVisitLog("BackgroundRecupTask: Rends la main apres %u traitements (diff=%u)", count, now - time_start);
	        return 1;
	    }
	    
	        count++;
	        
	        
	        
		Field *fields = res->Fetch();
		uint32 field_type = fields[0].GetUInt32();
		uint32 field_subtype = fields[1].GetUInt32();
		uint64 field_numparam = fields[2].GetUInt64();
		std::string field_txtparam = fields[3].GetString();
		switch(field_type) {

			case RecupMgrAuto::FIELD_TYPE_MONEY:
				player->SetMoney(field_numparam);
				break;
                        case RecupMgrAuto::FIELD_TYPE_BANK_TABS:
                                player->SetBankBagSlotCount(field_numparam);
                                break;
                                
                        case RecupMgrAuto::FIELD_TYPE_HONOR_POINT:
                                player->SetHonorPoints(field_numparam);
                                break;
                        
                        case RecupMgrAuto::FIELD_TYPE_ARENA_POINT:
                                player->SetArenaPoints(field_numparam);
                                break;

			case RecupMgrAuto::FIELD_TYPE_ITEM:
			{
            
                                    
                            if (RecupMgrAuto::isInList(RecupMgrAuto::RECUP_LIST_ITEM, field_subtype))
                                    continue; // blacklisted
                
                            if (RecupMgrAuto::recup_remplace.find(field_subtype) != RecupMgrAuto::recup_remplace.end()) {
                                    //remplacement d'item
                                    field_subtype = RecupMgrAuto::recup_remplace[field_subtype];
                            }      
			    if (!field_subtype) {
//			        sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "itemperso", player->GetGUID(), 0, 0, "Joueur %s, item recup %d invalide", player->GetName(), 0);
			        return 2;
			    }
			    ItemTemplate const* item_proto = sObjectMgr->GetItemTemplate(field_subtype);
			    if (!item_proto) {
//			        sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "itemperso", player->GetGUID(), field_subtype, 0, "Joueur %s, item recup %d invalide", player->GetName(), field_subtype);
			        continue;
                            }
                            
                            if ((ilevel != 0) && (item_proto->ItemLevel >= 200))
                                    continue; // recup par palliers

                            if ((field_numparam < 1) || ((item_proto->MaxCount > 0 ) && (field_numparam > uint32(item_proto->MaxCount)))) {
//			        sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "itemperso", player->GetGUID(), field_subtype, field_numparam, "Joueur %s, item recup %d quantite invalide %d", player->GetName(), field_subtype, field_numparam);
                                return 2;
                            }

                            while (field_numparam > item_proto->GetMaxStackSize()) {
                                items.push_back(ItemPair(field_subtype,item_proto->GetMaxStackSize()));
                                field_numparam -= item_proto->GetMaxStackSize();
                            }

                            items.push_back(ItemPair(field_subtype, field_numparam));
                            break;
                        }

			case RecupMgrAuto::FIELD_TYPE_COMPETENCE:
			
				if (!RecupMgrAuto::GiveSkillById(player, field_subtype, field_numparam))
					return 2;
                        
				break;

			case RecupMgrAuto::FIELD_TYPE_LEVEL:
			        if ((field_numparam <= 0) || (field_numparam > 80)) {
//			                sLog->outVisitLog("RECUP: Guid %u, niveau invalide %d\n", player->GetGUIDLow(), field_numparam);
//			                sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "niveau", player->GetGUID(), field_numparam, 0, "Joueur %s, niveau recup invalide %d", player->GetName(), field_numparam);
			                return 2;
			        }
				player->GiveLevel(field_numparam);
				player->InitTalentForLevel();
				player->SetUInt32Value(PLAYER_XP, 0);
				break;
			
			case RecupMgrAuto::FIELD_TYPE_HUNTER_PET:
			        
			        pet_list.push_back(std::make_pair(field_numparam, field_txtparam));
				break;

			case RecupMgrAuto::FIELD_TYPE_RESERVED:
				break;

			case RecupMgrAuto::FIELD_TYPE_DONE:
				break;
                        case RecupMgrAuto::FIELD_TYPE_KILLS:
                            player->SetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, field_numparam);
                            break;

			case RecupMgrAuto::FIELD_TYPE_SPELL: // Montures et mini-pets non ? A verifier
				/*
				SPELL : [différent de la récup classique!] On apprends le spell au joueur, UNIQUEMENT pour les recettes de métier, 
				la double spé!!
				*/
				{
				 const SpellInfo *_spell = sSpellMgr->GetSpellInfo(field_subtype);
				 if (!_spell)
				         break;
				if (!player->IsSpellFitByClassAndRace(field_subtype))
				        break;
				        
				if (RecupMgrAuto::isInList(RecupMgrAuto::RECUP_LIST_MONTURE_MINIPET, field_subtype)) {
				        player->learnSpell(field_subtype, false);
				}
				//Double Spé
				if (field_subtype == RecupMgrAuto::SPELL_SPE_2) // à vérifier
				{
					player->CastSpell(player, RecupMgrAuto::SPELL_DOUBLE_SPE, true);
					player->learnSpell(RecupMgrAuto::SPELL_SPE_1, false);
					player->learnSpell(RecupMgrAuto::SPELL_SPE_2, false);
				}
				//vol par temps froid
				if (field_subtype == RecupMgrAuto::SPELL_TEMPS_FROID) {
				        player->learnSpell(RecupMgrAuto::SPELL_TEMPS_FROID, false);
				}

				//competence et metier
        				 //Recette de metier : flags SPELL_ATTR0_TRADESPELL
         				if ((_spell->Attributes & SPELL_ATTR0_TRADESPELL) || (_spell->HasEffect(SPELL_EFFECT_TRADE_SKILL)))
        				 {
         					player->learnSpell(field_subtype, false);
         				 }
         				 //Spell de competence/metier : verifier si ca correspond a un skill
         				 const SpellLearnSkillNode *spell_skill = sSpellMgr->GetSpellLearnSkill(field_subtype);
         				 if (spell_skill) {
         				         player->learnSpell(field_subtype, false);
         				         trades.push_back(std::make_pair(field_subtype, spell_skill->skill));
         				 }
				}
				break;


			case RecupMgrAuto::FIELD_TYPE_REPUT:
				{
					uint32 translated_faction;
					if (RecupMgrAuto::reput_list.find(field_subtype) == RecupMgrAuto::reput_list.end()) {
//						sLog->outVisitLog("[WARN] La faction %d est introuvable\n", field_subtype);
//						sLog->outUnified(LOG_WARNING, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "reput", player->GetGUID(), field_subtype, 0, "Joueur %s, reputation %d invalide", player->GetName(), field_subtype);
						break;
					}
					translated_faction = RecupMgrAuto::reput_list[field_subtype];
	                                for (std::map<uint32, uint32>::const_iterator it = sObjectMgr->FactionChange_Reputation.begin(); it != sObjectMgr->FactionChange_Reputation.end(); ++it)
	                                {
	            			    uint32 reputation_alliance = it->first;
	                                    uint32 reputation_horde = it->second;
	                                    if ((player->GetTeam() == ALLIANCE) && (translated_faction == reputation_horde)) {
	                                        translated_faction = reputation_alliance;
	                                    } else if ((player->GetTeam() == HORDE) && (translated_faction == reputation_alliance)) {
	                                        translated_faction = reputation_horde;
	                                    }
	                                }
	                                const FactionEntry *faction_entry  = sFactionStore.LookupEntry(translated_faction);
	                                if (!faction_entry) {
//						sLog->outUnified(LOG_WARNING, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "reput", player->GetGUID(), field_subtype, 0, "Joueur %s, reputation %d introuvable dans la liste de permutation alliance/horde", player->GetName(), field_subtype);
	                                        return 2;
                                        }
                                        int32 reput_rank = field_numparam;
                                        reput_rank += player->GetReputationMgr().GetBaseReputation(faction_entry); //hack
	                                RecupMgrAuto::GiveFaction(player, faction_entry, reput_rank);
                                }

			break;

			case RecupMgrAuto::FIELD_TYPE_MODE: //Voir si on utilise recup classique ou recup auto, a gerer des le debut
			break;

			case RecupMgrAuto::FIELD_TYPE_HF: //En attente des blacklist
			{
			        //Exemple de verification blacklist
			        if (!RecupMgrAuto::isInList(RecupMgrAuto::RECUP_LIST_ACHIEVEMENT, field_subtype)) { 
				        AchievementEntry const* achiev = sAchievementStore.LookupEntry(field_subtype);
				        if (!achiev) {
//				                sLog->outVisitLog("RECUP: Guid %u, HF invalide %d\n", player->GetGUIDLow(), field_subtype);
//				                sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "hf", player->GetGUID(), field_subtype, 0, "Joueur %s, recup HF %d invalide", player->GetName(), field_subtype);
				                return 2;
				        }
				        
				        player->CompletedAchievement(achiev);
				}
                        }
			break;
			case RecupMgrAuto::FIELD_TYPE_ACHIEVEMENT_CRITERIA:
                        {
                                AchievementCriteriaEntry const* criteria = sAchievementCriteriaStore.LookupEntry(field_subtype);
                                if (!criteria) {
//                                        sLog->outVisitLog("[WARN] Le critere de HF %d est introuvable\n", field_subtype);
//				                sLog->outUnified(LOG_WARNING, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "hf", player->GetGUID(), field_subtype, 0, "Joueur %s, recup critere HF %d invalide", player->GetName(), field_subtype);
                                        break;
                                }
                                if (!RecupMgrAuto::isInList(RecupMgrAuto::RECUP_LIST_CRITERIA, field_subtype)) {
                                        RecupMgrAuto::GiveCriteria(player, criteria, field_numparam);
                                }
			        
                        }
                        break;

			case RecupMgrAuto::FIELD_TYPE_MAP: 
				/*
				Le champ "subtype" indique l'AreaFlag correspondant a l'area explorée (c'est l'AreaFlag, différent de AreaID!). 
				On utilise dans le core sAreaStore.LookupEntry(areaFlag) pour avoir des infos dessus. Voir la fonction 
				Player::CheckAreaExploreAndOutdoor pour savoir comment on met des zones explorées pour le joueur. 

				On se sert également des maps explorées pour savoir si on donne un itineraire de fly ou pas. 
				Si le fly-master est dans une zone explorée alors on considere que le joueur connait ce point de fly. 
				Il y a la fonction Map::GetAreaFlag(x,y,z) pour avoir l'areaflag correspondant a un point dans la carte 
				(pour savoir donc l'areaflag du PNJ de fly, et verifier si le joueur a exploré l'area possedant cet areaflag). 
				Pour avoir la liste des pnj de fly, voir les pnj ayant le flag "UNIT_NPC_FLAG_FLIGHTMASTER". 
				Pour savoir comment apprendre un fly, voir Player::SetTaximaskNode() 
				*/
				{
				        uint32 offset = field_subtype / 32;
				        uint32 bitpos = field_subtype % 32;
				        if (offset >= PLAYER_EXPLORED_ZONES_SIZE) {
//				                sLog->outError("[!!!] Tentative d'abus de la part d'un serveur malveillant (Recup GUID %d)\n", player->GetGUID());
//				                sLog->outUnified(LOG_CRITICAL, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "map", player->GetGUID(), offset, 0, "[ALERTE] Tentative de hack de la part d'un serveur d'origine malveillant. Donnees techniques: offset=ud bitpos=%u", offset, bitpos);
                                                break;
				        }
				        uint32 areaFlags = player->GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset);
				        areaFlags |= (1 << bitpos);
				        player->SetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset, areaFlags);
				}

			break;

			case RecupMgrAuto::FIELD_TYPE_QUEST: //à vérifier
			        if (sObjectMgr->GetQuestTemplate(field_subtype) && !RecupMgrAuto::isInList(RecupMgrAuto::RECUP_LIST_QUEST, field_subtype) && ((ilevel == 0) || !RecupMgrAuto::isInList(RecupMgrAuto::RECUP_LIST_QUEST_PALLIER, field_subtype))) {
			                RecupMgrAuto::CompleteQuest(player, field_subtype);
				}
                            if (ilevel != 0)
                                    continue; // recup par palliers
			break;

			case RecupMgrAuto::FIELD_TYPE_GUILD_STATUS:

			break;


			default:
//                sLog->outVisitLog("RECUP: Guid %u, recup champ inconnu %u", player->GetGUIDLow(), field_type);
			break;
		}
	} while (res->NextRow());
	

	for (std::list<std::pair<uint32,uint32> >::iterator itr = trades.begin(); itr != trades.end(); itr++) {
	        uint32 skill_level = player->GetSkillValue((*itr).second);
	        if (skill_level > 0)
        	        RecupMgrAuto::DoTradeSpecificActions(player, (*itr).first, skill_level, (ilevel != 0));
	}

	//Gestion des pets
	if ((player->getClass() == CLASS_HUNTER) && (pet_list.size() > 0)) {
        	if (pet_list.size() > (MAX_PET_STABLES + 1)) {
//        	        sLog->outVisitLog("RECUP: Guid %u, il y a trop de familiers (%d)", player->GetGUIDLow(), pet_list.size());
//        	        sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "pet", player->GetGUID(), pet_list.size(), 0, "Joueur %s, recup trop de familiers (%d)", player->GetName(), pet_list.size());
        	        return 2;
        	}
        	if (pet_list.size() > (player->m_stableSlots + 1)) {
        	        player->m_stableSlots = pet_list.size() - 1;
        	}
        	int slot = 0;
        	uint32 pet_id = 0;
        	std::string pet_name = "";
        	for (std::list<PetRecup>::iterator itr = pet_list.begin(); itr != pet_list.end(); ++itr) {
        	        if (slot == 0) {
        	                pet_id = (*itr).first;
        	                pet_name = (*itr).second;
        	        } else {
        	                //Familier ecurie
                	        if (!RecupMgrAuto::GiveHunterPet(player, (*itr).first, player->getLevel(), (*itr).second, slot))
                	                return 2;
                        }
                        slot ++;
                }
                if (pet_id != 0) {
                        //Familier actif
                        if (!RecupMgrAuto::GiveHunterPet(player, pet_id, player->getLevel(), pet_name, 0))
                                return 2;
                }
        }
	
	//Gestion des items par mail
	if (!items.empty()) {

    	    std::string subject = "Récupération";
            std::string text = "Voici les objets supplémentaires de votre récupération. Bon jeu sur Oxygen! ";
            MailSender sender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM);
            
            MailDraft *draft = NULL;
            SQLTransaction trans;

            //Envoyer les items courrier
            int items_in_mail = 0;
            for (ItemPairs::const_iterator itr = items.begin(); itr != items.end(); ++itr) {
        	if (items_in_mail == 0) {
	            //creer courrier
	            draft = new MailDraft(subject, text);
	            trans = CharacterDatabase.BeginTransaction();
                }
	        
    	        //ajoute l'item au courrier en cours
                Item *item = Item::CreateItem(itr->first, itr->second, player);
                item->SaveToDB(trans);
                draft->AddItem(item);
                
	        items_in_mail++;
	        if (items_in_mail == MAX_MAIL_ITEMS) {
	            //finir ce courrier
	            draft->SendMailTo(trans, MailReceiver(player, GUID_LOPART(player->GetGUID())), sender);
	            CharacterDatabase.CommitTransaction(trans);
	            delete draft;
	            items_in_mail = 0;
    	        }
    	    }
    	    if (items_in_mail > 0) {
    	        //envoyer le dernier courrier
    	        draft->SendMailTo(trans, MailReceiver(player, GUID_LOPART(player->GetGUID())), sender);
    	        CharacterDatabase.CommitTransaction(trans);
    	        delete draft;
    	    }
        }
	//Learn class spells
	if (RecupMgrAuto::DoLearnClass(player))
		return false;
		
	if (!RecupMgrAuto::DoClassSpecificActions(player, (ilevel != 0)))
		return false;
		
        //Donner les flys
        RecupMgrAuto::GiveFlyMasters(player);

        RecupMgrAuto::DoLearnRidingSpells(player);
        
        if (!RecupMgrAuto::GiveMounts(player)) 
                return false;

        // Faculatif: donner sacs
        for (int i = 0; i < 4; i++)
                RecupMgrAuto::GiveItem(player, RecupMgrAuto::BAG_FROSTWEAVE);

	player->SaveToDB();
	RecupMgrAuto::SetRecupStatus(player, RecupMgrAuto::RECUP_STATUS_IN_PROGRESS);
//        sLog->outVisitLog("RECUP OK: Joueur %s (GUID %u), IP %s, nombre d'invocations de BackgroundRecupTask::Process() : %u (temps derniere etape=%u)", player->GetName(), player->GetGUIDLow(), player->GetSession()->GetRemoteAddress().c_str(), invoc_count, getMSTime() - time_start);
        player->GetSession()->SendNotification("La premiere etape de la recuperation a reussi.");

//Log::outUnified(LogSeverity s, uint32 ip, char *compo, char *action, uint32 user, uint32 target, uint32 param, const char *str, ...)

//      sLog->outUnified(LOG_INFO, player->GetSession()->GetRemoteAddress().c_str(), "recupauto", "perso", player->GetGUID(), 0, 0, "Debut de la recuperation OK (nombre d'invocations de BackgroundRecupTask::Process() : %u, temps derniere etape=%u)", invoc_count, getMSTime() - time_start);
      
        
	return 0;
}

    
void RecupMgrAuto::GiveFaction(Player *player, const FactionEntry *faction_entry, uint32 reput_rank) {
    player->GetReputationMgr().SetOneFactionReputation(faction_entry, reput_rank, false);

}
void RecupMgrAuto::GiveCriteria(Player *player, const AchievementCriteriaEntry *criteria, uint32 progress) {
    player->GetAchievementMgr().SetCriteriaProgress(criteria, progress, AchievementMgr::PROGRESS_SET);
}
void RecupMgrAuto::CompleteQuest(Player *player, uint32 quest_id) {
    player->m_RewardedQuests.insert(quest_id);
    player->m_RewardedQuestsSave[quest_id] = true;
}

