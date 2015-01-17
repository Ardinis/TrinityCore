/*
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

#include "RecupMgr.h"
#include "RecupMgrAuto.h"
#include "DatabaseEnv.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"

#define NUM_TRAINERS 12

const uint32 RecupMgr::weaponskill_spells[] = {81,196,197,198,199,200,201,202,227,264,266,1180,2567,5011,15590,0};
const RecupMgr::TPLocation RecupMgr::TPDest = {
	// Dalaran
	571,
	5804.15f,
	624.771f,
	647.767f,
	0.0f
};

            
const RecupMgr::TPLocation RecupMgr::AccueilVisiteurs = {
	37,
	286.2f,
        -129.5f,
        275.5f,
        4.2f
};
        

#ifndef _WIN32                    
// riding skills: 75, 150, 225, 300                            
const uint32 *RecupMgr::racial_mounts[] =  {
	NULL, // None
	(uint32[]) {5656,18776,25471,25473}, // Human
	(uint32[]) {46099,18796,25474,25477}, // Orc
	(uint32[]) {5872,18786,25471,25473}, // Dwarf
	(uint32[]) {47100,18766,25471,25473}, // NightElf
	(uint32[]) {46308,13334,25474,25477}, // Forsaken
	(uint32[]) {15290,18794,25474,25477}, // Tauren
	(uint32[]) {8595,18772,25471,25473}, // Gnome
	(uint32[]) {8588,18788,25474,25477}, // Troll
	NULL, // Goblin/None
	(uint32[]) {29221,28936,25474,25477}, // Blood Elf
	(uint32[]) {28481,29745,25471,25473}, // Dranei
	NULL,
};
#else
const uint32 *RecupMgr::racial_mounts[] =  { NULL, };
#endif

                                                
const uint32 RecupMgr::riding_spells[] = { 33388, 33391, 34090, 34091 };
#ifndef _WIN32                    
const uint32 *RecupMgr::class_trainers[] =  {
	NULL, // None
	(uint32[]) {16771,0}, // Warrior
	(uint32[]) {17121,16679,0}, // Paladin
	(uint32[]) {16738,0}, // Hunter
	(uint32[]) {13283,0}, // Rogue
	(uint32[]) {17511,0}, // Priest
	(uint32[]) {29195, 29194, 29196, 0}, // Death Knight
	(uint32[]) {17219,13417,0}, // Shaman
	(uint32[]) {28956, 0}, // Mage
	(uint32[]) {5495,0}, // Warlock
	NULL, // None
	(uint32[]) {16721,0}, // Druid
	NULL,
};
#else
const uint32 *RecupMgr::class_trainers[] =  { NULL, };
#endif

//TODO: Fouttre aussi la le truc qui est appelle depuis NPCHandler.cpp
//Renvoie true si le sort est ignore en client-side
static bool IsSpellIgnored(Player *player, uint32 spell) {
    switch(player->getClass()) {
        case CLASS_WARLOCK:
            if (spell == 2567)
                return true;
            break;
        default:
            break;
    }
    return false;
}

bool RecupMgr::DoLearnWeapons(Player *player) {
        int i;
        for (i = 0; weaponskill_spells[i] != 0; i++) {
                if (IsSpellIgnored(player, weaponskill_spells[i]))
                    continue;
                if (player->IsSpellFitByClassAndRace(weaponskill_spells[i]))
                        if (!GiveSkill(player, weaponskill_spells[i], 400))
                                return false;
        }
        return true;
}

        
void RecupMgr::SetRecupStatus(Player *player, int status) {
	uint64 guid = player->GetGUID();
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_SET_RECUP_STATUS);
	stmt->setUInt32(1, guid);
	stmt->setUInt32(0, status);
	CharacterDatabase.Execute(stmt);
// Pas besoin du flag: pas de zone de recup sur paragon
//	player->SetNoWorldPort((status == RECUP_STATUS_IN_PROGRESS));

}

bool RecupMgr::IsDoubleStuff(Player *plr) {
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_ILEVEL);
	stmt->setUInt32(0, plr->GetGUID());
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	if (!res)
		return false;
	Field* fields = res->Fetch();
	if (!fields)
		return false;
		
	return (fields[0].GetUInt32() & 1);
}

int RecupMgr::GetRecupStatus(Player *plr) {
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_STATUS);
	stmt->setUInt32(0, plr->GetGUID());
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	if (!res)
		return -1;
	Field* fields = res->Fetch();
	if (!fields)
		return -1;
        if ((RecupMgrAuto::GetRecupMode(plr) == 1) && (RecupMgr::GetRecupValidation(plr) != 1))
                return RECUP_STATUS_VALIDATION; //recup non validee
		
	return (fields[0].GetUInt32());
}

int RecupMgr::GetRecupValidation(Player *plr) {
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_VALIDATION);
	stmt->setUInt32(0, plr->GetGUID());
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	if (!res)
		return -1;
	Field* fields = res->Fetch();
	if (!fields)
		return -1;
		
	return (fields[0].GetUInt32());
}
bool RecupMgr::GiveMounts(Player *player) {
#ifdef _WIN32
        return false;
#else
        int riding = player->GetSkillValue(SKILL_RIDING);
        int i;
        
        for (i = 0; i < 4; i++)
                if (riding >= ((i+1)*75))
                        if (!GiveItem(player, racial_mounts[player->getRace()][i]))
                                return false;
        return true;
#endif
}

void RecupMgr::DoLearnRidingSpells(Player *player) {
        int riding = player->GetSkillValue(SKILL_RIDING);
        int i;
        
        for (i = 1; i < 4; i++)
                if (riding >= ((i+1)*75))
                        player->learnSpell(riding_spells[i], false);
}

bool RecupMgr::GiveSkill(Player *player, int id_metier, int level) {
	player->learnSpell(id_metier, false);
	for (int i = 0; i <sSkillLineAbilityStore.GetNumRows(); i++) {
		SkillLineAbilityEntry const* ability = sSkillLineAbilityStore.LookupEntry(i);
		if (ability && (ability->spellId == id_metier)) {
			player->SetSkill(ability->skillId, 0, level, ((level < 75) ? 75 : level));
			return DoTradeSpecificActions(player, id_metier, level);
		}
	}
//	sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "skill", player->GetGUID(), id_metier, 0, "Joueur %s, impossible de trouver la competence %d", player->GetName(), id_metier);
	return false;
}
bool RecupMgr::HandleLinkRecupTable(Player *player) {
	uint64 guid = player->GetGUID();
	int pet_id = 0;
	std::string pet_name = "";
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_DATA);
	stmt->setUInt32(0, guid);
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	typedef std::pair<uint32,uint32> ItemPair;
        typedef std::list< ItemPair > ItemPairs;
        ItemPairs items;

	if (!res) {
//	sLog->outVisitLog("RECUP: Guid %u, ne trouve pas la table link_recup", player->GetGUIDLow());
		return false;
        }
		
	do {
		Field *fields = res->Fetch();
		uint32 field_type = fields[0].GetUInt32();
		uint32 field_subtype = fields[1].GetUInt32();
		uint32 field_numparam = fields[2].GetUInt32();
		std::string field_txtparam = fields[3].GetString();
		switch(field_type) {
			case FIELD_TYPE_MONEY:
				player->SetMoney(field_numparam);
				break;
			case FIELD_TYPE_ITEM:
			{
            
			    if (!field_subtype) {
//			        sLog->outVisitLog("RECUP: Guid %u, item invalide (itemid = 0)", player->GetGUIDLow());
//			        sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "item", player->GetGUID(), 0, 0, "Joueur %s, item recup %d invalide", player->GetName(), 0);
			        return false;
			    }
			    ItemTemplate const* item_proto = sObjectMgr->GetItemTemplate(field_subtype);
			    if (!item_proto) {
//			        sLog->outVisitLog("RECUP: Guid %u, item n'existe pas (itemid = %u)", player->GetGUIDLow(), field_subtype);
//			        sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "item", player->GetGUID(), field_subtype, 0, "Joueur %s, item recup %d invalide", player->GetName(), field_subtype);
			        return false;
                            }

                            if ((field_numparam < 1) || ((item_proto->MaxCount > 0 ) && (field_numparam > uint32(item_proto->MaxCount)))) {
//                                sLog->outVisitLog("RECUP: Guid %u, nombre d'item invalide (itemid = %u, nombre = %u)", player->GetGUIDLow(), field_subtype, field_numparam);
//                                sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "item", player->GetGUID(), field_subtype, field_numparam, "Joueur %s, item recup %d quantite invalide %d", player->GetName(), field_subtype, field_numparam);
                                return false;
                            }

                            while (field_numparam > item_proto->GetMaxStackSize()) {
                                items.push_back(ItemPair(field_subtype,item_proto->GetMaxStackSize()));
                                field_numparam -= item_proto->GetMaxStackSize();
                            }

                            items.push_back(ItemPair(field_subtype, field_numparam));
                            break;
                        }
			case FIELD_TYPE_COMPETENCE:
				if (!GiveSkill(player, field_subtype, field_numparam))
					return false;
				break;
			case FIELD_TYPE_DOUBLE_SPE:
				if (field_numparam == 1) {
					player->CastSpell(player, SPELL_DOUBLE_SPE, true);
					player->learnSpell(SPELL_SPE_1, false);
					player->learnSpell(SPELL_SPE_2, false);
				}
				break;
			case FIELD_TYPE_LEVEL:
				player->GiveLevel(field_numparam);
				player->InitTalentForLevel();
				player->SetUInt32Value(PLAYER_XP, 0);
				break;
			
			case FIELD_TYPE_HUNTER_PET:
				pet_id = field_numparam;
				pet_name = field_txtparam;
				break;
			case FIELD_TYPE_RESERVED:
				break;
			case FIELD_TYPE_DONE:
				break;
			case FIELD_TYPE_SPELL:
				player->learnSpell(field_subtype, false);
				break;
			case FIELD_TYPE_ILEVEL: 
				{
					//Si ca a marche alors on permet la recup
					field_numparam &= (~1); // enlever flag double stuff
					Aura *aura = player->AddAura(SPELL_RECUP_HELPER, player);
					AuraEffect *aurEff = aura->GetEffect(EFFECT_0);
					aurEff->SetAmount(field_numparam);
					ApplyRecupAura(player, field_numparam);
				}
				break;
			case FIELD_TYPE_REPUT:
                                for (std::map<uint32, uint32>::const_iterator it = sObjectMgr->FactionChange_Reputation.begin(); it != sObjectMgr->FactionChange_Reputation.end(); ++it)
                                {
            			    uint32 reputation_alliance = it->first;
                                    uint32 reputation_horde = it->second;
                                    if ((player->GetTeam() == ALLIANCE) && (field_subtype == reputation_horde)) {
                                        field_subtype = reputation_alliance;
                                    } else if ((player->GetTeam() == HORDE) && (field_subtype == reputation_alliance)) {
                                        field_subtype = reputation_horde;
                                    }
                                }
                                player->GetReputationMgr().SetOneFactionReputation(sFactionStore.LookupEntry(field_subtype), field_numparam, false);
				break;
			default:
//                        	sLog->outVisitLog("RECUP: Guid %u, recup champ inconnu %u", player->GetGUIDLow(), field_type);
				break;
		}
	} while (res->NextRow());
	if ((pet_id != 0) && (player->getClass() == CLASS_HUNTER)) {
		if (!GiveHunterPet(player, pet_id, player->getLevel(), pet_name))
			return false;
	}
	
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
	return true;
}

bool RecupMgr::RecheckMoney(Player *player) {
	uint64 guid = player->GetGUID();
	int pet_id = 0;
	std::string pet_name = "";
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_DATA);
	stmt->setUInt32(0, guid);
	PreparedQueryResult res = CharacterDatabase.Query(stmt);
	if (!res) {
//	sLog->outVisitLog("RECUP: Guid %u, ne trouve pas la table link_recup", player->GetGUIDLow());
		return false;
        }
		
	do {
		Field *fields = res->Fetch();
		uint32 field_type = fields[0].GetUInt32();
		uint32 field_subtype = fields[1].GetUInt32();
		uint32 field_numparam = fields[2].GetUInt32();
		std::string field_txtparam = fields[3].GetString();
		switch(field_type) {
			case FIELD_TYPE_MONEY:
				player->SetMoney(field_numparam);
				break;
			default:
			        break;
		}
	} while (res->NextRow());
	return true;
}

bool RecupMgr::DoLearnClass(Player *player) {
#ifdef _WIN32
    return false;
#else
	int plrclass = player->getClass();
	if ((plrclass >= NUM_TRAINERS) || (class_trainers[plrclass] == NULL)) {
//                sLog->outVisitLog("RECUP: Guid %u, classe inconnue", player->GetGUIDLow());
//                sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "class", player->GetGUID(), plrclass, 0, "Joueur %s, classe inconnue (%d)", player->GetName(), plrclass);
		return false;
        }
		
	for (int i = 0; class_trainers[plrclass][i] != 0; i++) {
		int j;
		for (j = 0; j < 10; j++) {
			int num_trained = 0;
			player->GetSession()->SendTrainerList(class_trainers[plrclass][i], "", true, &num_trained);	
			if (num_trained == 0)
				break;
		}
	}
#endif
}

bool RecupMgr::GiveItem(Player *player, int itemid) {
	ItemPosCountVec dest;
	uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemid, 1);
	if (msg != EQUIP_ERR_OK) {
//                sLog->outVisitLog("RECUP Erreur non-fatale: Guid %u, ne peut pas donner l'item %u", player->GetGUIDLow(), itemid);
//                sLog->outUnified(LOG_WARNING, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "item", player->GetGUID(), itemid, 0, "Joueur %s, ne peut pas donner l'item %d", player->GetName(), itemid);
                
		return true;
        }
						
	Item* item = player->StoreNewItem(dest, itemid, true);
	if (!item) {
//	        sLog->outVisitLog("RECUP Erreur non-fatale: Guid %u, ne peut pas creer l'item %u", player->GetGUIDLow(), itemid);
//                sLog->outUnified(LOG_WARNING, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "item", player->GetGUID(), itemid, 0, "Joueur %s, ne peut pas creer l'item %d", player->GetName(), itemid);
	        return true;
	}
	
	//set soulbound
        item->SetBinding(true);
        item->SetNotRefundable(player);
        item->ClearSoulboundTradeable(player);
        player->RemoveTradeableItem(item);
                                                
	player->SendNewItem(item, 1, true, false);
	return true;
}

bool RecupMgr::DoTradeSpecificActions(Player *player, uint32 trade_spell, uint32 trade_level, bool give_items) {
    switch(trade_spell) {
        case SPELL_METIER_ENCHANT:
        case SPELL_METIER_ECHANT2:
            if ((trade_level >= 450) && (give_items))
                if (!GiveItem(player, BATONNET_EN_TITANE))
                    return false;
            break;
        default:
            break;
    }
    return true;
}

bool RecupMgr::DoClassSpecificActions(Player *player, bool give_items)  {
	switch(player->getClass()) {
		case CLASS_DEATH_KNIGHT:
			player->learnSpell(SPELL_DEATH_GATE, false);
			player->learnSpell(SPELL_RUNEFORGER, false);
			player->learnSpell(SPELL_DK_MOUNT, false);
			break;
		case CLASS_SHAMAN:
		        if (give_items) {
    			    if (!GiveItem(player, TOTEM_EARTH) ||
				    !GiveItem(player, TOTEM_FIRE)  ||
                                    !GiveItem(player, TOTEM_WATER) ||
				    !GiveItem(player, TOTEM_AIR))
    				return false;
                        }
                        player->learnSpell(58757, false);
                        player->learnSpell(58753, false);
                        player->learnSpell(58704, false);
			
			break;
		case CLASS_PALADIN:
			player->learnSpell(SPELL_REDEMPTION, false);
			break;
		case CLASS_WARLOCK:
			player->learnSpell(SPELL_VOIDWALKER, false);
			player->learnSpell(SPELL_SUCCUBUS, false);
			player->learnSpell(SPELL_FELHUNTER, false);
			player->learnSpell(SPELL_FELGUARD, false );
			break;
		default:
			break;
	}
	return true;
	
}      

  
bool RecupMgr::DoVisite(Player *player) {
        int i;

	// level
	player->GiveLevel(80);
	player->InitTalentForLevel();
	player->SetUInt32Value(PLAYER_XP, 0);

	// sorts de classe                                                                        
	if (DoLearnClass(player))
		return false;
		
	if (!DoClassSpecificActions(player))
		return false;
		
        if (!DoLearnWeapons(player))
                return false;
        
        if (!GiveSkill(player, riding_spells[0], 300))
                return false;
        for (i = 1; i < 4; i++)
                player->learnSpell(riding_spells[i], false);
        player->learnSpell(SPELL_TEMPS_FROID, false);
        
        if (!GiveMounts(player))
                return false;
        
        // Faculatif: donner sacs
        for (i = 0; i < 4; i++)
         GiveItem(player, BAG_FROSTWEAVE);

        //double spe
        player->CastSpell(player, SPELL_DOUBLE_SPE, true);
	player->learnSpell(SPELL_SPE_1, false);
	player->learnSpell(SPELL_SPE_2, false);
                
        player->SetMoney(5000000); // NEED PO
        player->SaveToDB();
//        sLog->outVisitLog("VISITE: Joueur %s (GUID %u), Guilde %u, IP %s", player->GetName(), player->GetGUIDLow(), player->GetGuildId(), player->GetSession()->GetRemoteAddress().c_str());
//        sLog->outUnified(LOG_INFO, player->GetSession()->GetRemoteAddress().c_str(), "visite", "debut", player->GetGUID(), 0, 0, "Joueur %s, debut de la visite", player->GetName());
	return true;

}
bool RecupMgr::DoRecup(Player *player) {

        int i;

        return false; // Desactive sur paragon
        
	// table link_recup qui vient du site
	if (!HandleLinkRecupTable(player))
		return false;

	//Learn class spells
	if (DoLearnClass(player))
		return false;
		
	if (!DoClassSpecificActions(player))
		return false;
		
        DoLearnRidingSpells(player);
        
        if (!GiveMounts(player)) 
                return false;

        // Faculatif: donner sacs
        for (i = 0; i < 4; i++)
                GiveItem(player, BAG_FROSTWEAVE);

	player->SaveToDB();
	SetRecupStatus(player, RECUP_STATUS_IN_PROGRESS);
//        sLog->outVisitLog("RECUP OK: Joueur %s (GUID %u), IP %s", player->GetName(), player->GetGUIDLow(), player->GetSession()->GetRemoteAddress().c_str());
//        sLog->outUnified(LOG_INFO, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "general", player->GetGUID(), 0, 0, "Joueur %s, recuperation OK", player->GetName());
	return true;
}

static void handle_item_aux(Item *it, int *invtype) {
    const ItemTemplate *t = it->GetTemplate();
    if (t == NULL)
        return;
    if ((t->InventoryType < 0) || (t->InventoryType >= MAX_INVTYPE))
        return;
    invtype[t->InventoryType]++;
}

bool RecupMgr::HasNonAllowedItems(Player *player) {

        bool double_stuff = IsDoubleStuff(player);
        int invtype[MAX_INVTYPE];
        for (int i = 0; i < 29; i++) {
            invtype[i] = 0;
        }
        
        
	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < BANK_SLOT_BAG_END; i++)
		if (Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			if (!IsAllowedItem(pItem)) {
			        if (double_stuff) {
			            handle_item_aux(pItem, invtype);
			        } else {
//                                    sLog->outVisitLog("Le joueur GUID %u est bloque a cause de l'item ID %u (sac principal)", player->GetGUIDLow(), pItem->GetEntry());
//                                    sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "sortir", player->GetGUID(), pItem->GetEntry(), 0, "Joueur %s, bloque a cause de l'item %d (sac principal perso OU banque)", player->GetName(), pItem->GetEntry());
                                    player->GetSession()->SendNotification("Vous etes bloque a cause de l'item avec ID %u (sac principal)", pItem->GetEntry());
				    return true;
				}
                        }

	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
		if (Bag* pBag = player->GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
				if (Item* pItem = pBag->GetItemByPos(j))
					if (!IsAllowedItem(pItem)) {
					    if (double_stuff) {
					        handle_item_aux(pItem, invtype);
					    } else {
//                                    sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "sortir", player->GetGUID(), pItem->GetEntry(), i - INVENTORY_SLOT_BAG_START, "Joueur %s, bloque a cause de l'item %d (sac perso numero %d)", player->GetName(), pItem->GetEntry(), i - INVENTORY_SLOT_BAG_START);
                                    player->GetSession()->SendNotification("Vous etes bloque a cause de l'item avec ID %u (sacs supplementaires)", pItem->GetEntry());
						return true;
                                            }
                                        }

	for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
		if (Bag* pBag = player->GetBagByPos(i))
			for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
				if (Item* pItem = pBag->GetItemByPos(j))
					if (!IsAllowedItem(pItem)) {
					    if (double_stuff) {
					        handle_item_aux(pItem, invtype);
                                            } else {
//                                    sLog->outVisitLog("Le joueur GUID %u est bloque a cause de l'item ID %u (banque)", player->GetGUIDLow(), pItem->GetEntry());
//                                    sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "sortir", player->GetGUID(), pItem->GetEntry(), i - BANK_SLOT_BAG_START, "Joueur %s, bloque a cause de l'item %d (sac banque numero %d)", player->GetName(), pItem->GetEntry(), i - BANK_SLOT_BAG_START);
                                    player->GetSession()->SendNotification("Vous etes bloque a cause de l'item avec ID %u (banque)", pItem->GetEntry());
						return true;	
                                            }
                                        }

                                       
                                       
   if (double_stuff) {
       for (int i = 0; i < MAX_INVTYPE; i++) {	
		   switch(i) {

			// 1 
			/* case INVTYPE_NON_EQUIP: */ 
			case INVTYPE_HEAD: 
			case INVTYPE_NECK: 
			case INVTYPE_SHOULDERS: 
			/* case INVTYPE_BODY: */
			case INVTYPE_WAIST: 
			case INVTYPE_LEGS: 
			case INVTYPE_FEET: 
			case INVTYPE_WRISTS: 
			case INVTYPE_HANDS: 
			case INVTYPE_SHIELD: 
			case INVTYPE_CLOAK: 
//			case INVTYPE_2HWEAPON: 
			// case INVTYPE_BAG: 
			// case INVTYPE_TABARD: 
			// case INVTYPE_QUIVER: 
			// case INVTYPE_AMMO: 
			case INVTYPE_RELIC: 
			case INVTYPE_WEAPONOFFHAND: 
			case INVTYPE_HOLDABLE: 
			case INVTYPE_RANGEDRIGHT: 
			case INVTYPE_RANGED: 
			
			  if (invtype[i] > 1) {
                                player->GetSession()->SendNotification("Vous avez dans vos sacs plus d'une piece d'armure (ou arme a deux mains, ou main gauche) du meme type.");
				return true; 
                          }
			  break;

			// 2
			case INVTYPE_FINGER:
			  if (invtype[i] > 2) {
			      player->GetSession()->SendNotification("Vous avez dans vos sacs plus de deux bagues.");
			    return true;
			  }
                          break;
			case INVTYPE_TRINKET: 
			  if (invtype[i] > 2) {
                                player->GetSession()->SendNotification("Vous avez dans vos sacs plus de deux bijoux.");
				return true;
                              }
			  break;

			//check plus tard
			//robe+chest <= 1
			case INVTYPE_ROBE: 
			case INVTYPE_CHEST: 
			
			case INVTYPE_WEAPONMAINHAND: 
			case INVTYPE_THROWN: 
			case INVTYPE_WEAPON: 
			case INVTYPE_2HWEAPON:
			  break;

			default:
			  if (invtype[i] > 0) {
			        player->GetSession()->SendNotification("Vous avez dans vos sacs un ou plusieurs objets ne faisant pas partie du stuff vendu ici.");
				return true;
                          }
			  break;
			}

       
           if ((invtype[INVTYPE_CHEST] + invtype[INVTYPE_ROBE]) > 1) {
              player->GetSession()->SendNotification("Vous avez dans vos sacs un ou plusieurs objets de type torse/robe en trop.");
             return true;
           }
           int weapon_slots = 3; // (invtype[INVTYPE_2HWEAPON] > 0) ? 1 : 3;
           if ((invtype[INVTYPE_2HWEAPON] + invtype[INVTYPE_SHIELD] + invtype[INVTYPE_WEAPONMAINHAND] + invtype[INVTYPE_WEAPONOFFHAND] + invtype[INVTYPE_HOLDABLE] + invtype[INVTYPE_THROWN] + invtype[INVTYPE_RANGED] + invtype[INVTYPE_RANGEDRIGHT] + invtype[INVTYPE_WEAPON] + invtype[INVTYPE_RELIC]) > weapon_slots) {
             player->GetSession()->SendNotification("Vous avez dans vos sacs trop d'objets de type arme/bouclier/a distance/main gauche/...");
             return true;
           }
           
         
       }
   }
   return false;
}


int RecupMgr::MainBagSpace(Player *player) {
        int space = 0;
	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
		if (!player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
		    space++;
   return space;
}

void RecupMgr::SendItemByMail(Player *plr, uint32 itemid, int count) {

    std::string subject = "Récupération";
    std::string text = "Voici les objets supplémentaires de votre récupération. Bon jeu sur Oxygen! ";
    
    MailSender sender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM);

    // fill mail
    MailDraft draft(subject, text);

    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    Item *item = Item::CreateItem(itemid, count, 0);
    item->SaveToDB(trans);
    draft.AddItem(item);

    draft.SendMailTo(trans, MailReceiver(plr, GUID_LOPART(plr->GetGUID())), sender);
    CharacterDatabase.CommitTransaction(trans);

}

void RecupMgr::ApplyRecupAura(Player *player, int ilevel) {
        //Auras pour voir les PNJ de recup
        Aura *aura = player->AddAura(SPELL_RECUP_HELPER, player);
        AuraEffect *aurEff = aura->GetEffect(EFFECT_0);
        aurEff->SetAmount(ilevel);
        int faction_phase = (player->GetTeam() == ALLIANCE) ? SPELL_RECUP_PHASING_ALLIANCE : SPELL_RECUP_PHASING_HORDE;
        if (ilevel >= 258) {
                player->AddAura(faction_phase + 2, player);
        } else if (ilevel >= 232) {
                player->AddAura(faction_phase + 1, player);
        } else if (ilevel >= 200) {
                player->AddAura(faction_phase, player);
        } 
        player->AddAura(SPELL_RECUP_PHASING_GLYPHES_ETC, player);
}


//Verifie les vendor flag
bool RecupMgr::IsAllowedItem(Item *pItem) {
  return false; // Pas de recup par palliers sur Paragon
// return !pItem->HasFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_VENDOR_RECUP);
}

bool RecupMgr::GiveHunterPet(Player *player, int pet_id, int pet_level, std::string pet_name, int slot) {
	CreatureTemplate const *cinfo = sObjectMgr->GetCreatureTemplate(pet_id);
	if (!cinfo) {
//                sLog->outVisitLog("RECUP: Guid %u, le pet n'a pas de template", player->GetGUIDLow());
//                sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "pet", player->GetGUID(), pet_id, 0, "Joueur %s, le pet a recup n'a pas de template (%d)", player->GetName(), pet_id);
		return false;
        }
		
	Pet* pet = new Pet(player, HUNTER_PET);

	if (!pet->CreateBaseAtTamed(cinfo, player->GetMap(), player->GetPhaseMask())) {
		delete pet;
//                sLog->outVisitLog("RECUP: Guid %u, le pet ne peut pas etre apprivoise", player->GetGUIDLow());
//                sLog->outUnified(LOG_ERROR, player->GetSession()->GetRemoteAddress().c_str(), "recupmanuel", "pet", player->GetGUID(), pet_id, 0, "Joueur %s, le pet a recup n'est pas apprivoisable (%d)", player->GetName(), pet_id);
		return false;
	}

	pet->Relocate(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation());
	pet->SetDisplayId(cinfo->GetFirstValidModelId());
	pet->SetName(pet_name);
	player->InitTamedPet(pet, pet_level, SPELL_TAME_BEAST_FOR_CREATE);

	// prepare visual effect for levelup
	pet->SetUInt32Value(UNIT_FIELD_LEVEL, pet_level - 1);

	// add to world
	pet->GetMap()->AddToMap(pet->ToCreature());

	// visual effect for levelup
	pet->SetUInt32Value(UNIT_FIELD_LEVEL, pet_level);
	
	// caster have pet now
	player->SetMinion(pet, true);

	pet->InitTalentForLevel();
	
	if (slot == PET_SAVE_AS_CURRENT) {
	        pet->SavePetToDB(PET_SAVE_AS_CURRENT);
	        player->ToPlayer()->PetSpellInitialize();
        } else {
                player->RemovePet(pet, PetSaveMode(slot));
        }
	return true;
}
