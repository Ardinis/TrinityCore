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

#include "ScriptPCH.h"
#include "Chat.h"
#include "Group.h"

#define MENU_ID 123

class misc_commandscript : public CommandScript
{
public:
    misc_commandscript() : CommandScript("misc_commandscript") { }

    ChatCommand* GetCommands() const
    {
        static ChatCommand commandTable[] =
        {
            { "dev",                SEC_ADMINISTRATOR,      false,  &HandleDevCommand,          "", NULL },
            { "wintrade",           SEC_ADMINISTRATOR,      false,  &HandleWintradeCommand,     "", NULL },
            { "xp",                 SEC_PLAYER,             false,  &HandleXPRateCommand,       "", NULL },
            { "copy",               SEC_PLAYER,             false,  &HandleCopyCharacterCommand,       "", NULL },
            { "listcombat",         SEC_ADMINISTRATOR,      false, &HandleListCombatCommand,                  "", NULL },
            { "togglefaction",      SEC_ADMINISTRATOR,      false, &HandleToggleFactionCommand,                  "", NULL },
            { "guildRanked",        SEC_PLAYER,      false, &HandleGuildRankedCharacterCommand,                  "", NULL },
            { NULL,                 0,                      false,  NULL,                       "", NULL }
        };
        return commandTable;
    }
    static bool HandleToggleFactionCommand(ChatHandler* handler, char const* args)
    {
        WorldObject *object = NULL;
        Unit *unit = NULL;
        object = handler->getSelectedUnit();
        unit = object->ToUnit();
        if (unit == NULL) {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (unit->ToPlayer()) {
            Player *player = unit->ToPlayer();
            if (player->isCrossFaction()) {
                player->SetCrossFaction(false);
                handler->PSendSysMessage("Le joueur est maintenant dans sa faction d'origine.");
            } else {
                player->SetCrossFaction(true);
                handler->PSendSysMessage("Le joueur est maintenant temporairement dans la faction opposee.");
            }
            //sObjectAccessor->AddUpdateObject(player); //refresh
            /*
            player->SendUpdateToPlayer(player);
            player->SendUpdateToPlayer(handler->GetSession()->GetPlayer());
            */

            return true;
        }
    }

    static bool HandleListCombatCommand(ChatHandler* handler, char const* args)
    {
        WorldObject *object = NULL;
        Unit *unit = NULL;
        object = handler->getSelectedUnit();
        unit = object->ToUnit();
        if (unit == NULL) {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }
	if (unit->ToPlayer()) {
	    Player *player = unit->ToPlayer();
	    HostileRefManager &manager = player->getHostileRefManager();
	    if (manager.isEmpty()) {
	        handler->PSendSysMessage("Ce joueur n'est hai par aucune creature");
	    }
            for (HostileRefManager::iterator iter= manager.begin(); iter != manager.end(); ++iter) {
                ThreatManager *tm = iter->getSource();
                if (tm) {
                    Unit *hater = tm->getOwner();
                    if (hater) {

                        handler->PSendSysMessage("Joueur hai par la creature: %s (GUID %u)", hater->GetName(), hater->GetGUID());
                    } else handler->PSendSysMessage("Joueur hai par une creature inconnue (ThreatManager::getOwner() == NULL, ceci ne devrait pas se produire)");
                }
            }
            handler->PSendSysMessage("CombatTimer actuel du joueur: %u millisecondes", player->GetCombatTimer());
	} else if (unit->ToCreature()) {

	    Creature *creature = unit->ToCreature();
	    if (creature->CanHaveThreatList()) {
	        Unit *target = creature->getThreatManager().getHostilTarget();
	        if (target) {
	            handler->PSendSysMessage("Cette creature est en combat, la 1ere cible sur la table d'aggro est: %s (GUID %u)", target->GetName(), target->GetGUID());
                } else if (!creature->isInCombat()) {
                    handler->PSendSysMessage("Cette creature n'est pas en combat.");
                } else {
                    handler->PSendSysMessage("Cette creature n'a pas de cible, mais est en combat! (ceci ne devrait pas arriver, a part pour des boss / creatures avec script)");
                }
	    }
	} else {
	    sLog->outError("listcombat: ni creature ni joueur ?? (ne devrait pas arriver!)");
	    return false;
	}

    }

    static bool HandleDevCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            if (handler->GetSession()->GetPlayer()->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER))
                handler->GetSession()->SendNotification(LANG_DEV_ON);
            else
                handler->GetSession()->SendNotification(LANG_DEV_OFF);
            return true;
        }

        std::string argstr = (char*)args;

        if (argstr == "on")
        {
            handler->GetSession()->GetPlayer()->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER);
            handler->GetSession()->SendNotification(LANG_DEV_ON);
            return true;
        }

        if (argstr == "off")
        {
            handler->GetSession()->GetPlayer()->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER);
            handler->GetSession()->SendNotification(LANG_DEV_OFF);
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleWintradeCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 minDmg = atoi((char*)args);
        std::map<std::string, uint32 > wintrade;

        QueryResult result;
        for (int cnt = 0; cnt < 4; cnt++)
        {
            switch (cnt)
            {
                case 0:
                    result = WorldDatabase.PQuery("SELECT winpl1,   COUNT(winpl1) from arena_log where windmg <= %u or loosedmg <= %u Group By winpl1", minDmg, minDmg);
                    break;
                case 1:
                    result = WorldDatabase.PQuery("SELECT winpl2,   COUNT(winpl2) from arena_log where windmg <= %u or loosedmg <= %u Group By winpl2", minDmg, minDmg);
                    break;
                case 2:
                    result = WorldDatabase.PQuery("SELECT loosepl1,   COUNT(loosepl1) from arena_log where windmg <= %u or loosedmg <= %u Group By loosepl1 ", minDmg, minDmg);
                    break;
                case 3:
                    result = WorldDatabase.PQuery("SELECT loosepl2,   COUNT(loosepl2) from arena_log where windmg <= %u or loosedmg <= %u Group By loosepl2", minDmg, minDmg);
                    break;
                default:
                    return false;
            }
            if (!result)
                return false;
            do
            {
                if (Field* fields = result->Fetch())
                {
                    std::string name = fields[0].GetString();
                    uint32 wintradeCount = fields[1].GetUInt32();
                    wintrade[fields[0].GetString()] += fields[1].GetUInt32();
                }
            } while (result->NextRow());
        }
        for (std::map<std::string, uint32 >::iterator it = wintrade.begin(); it != wintrade.end(); ++it)
        {
            std::string name = it->first;
            uint32 wintradeCount = it->second;
            WorldDatabase.DirectPExecute("REPLACE INTO arena_filter VALUES('%s', %u)", name.c_str(), wintradeCount);
        }
        return true;
    }

    static bool HandleXPRateCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 rate = atoi((char*)args);
        int realRate = rate > 3 ? 3 : rate;
        if (realRate < 1)
            realRate = 1;
        handler->GetSession()->GetPlayer()->SetXPRate(realRate);
        std::string mess = "Votre xp sera desormais en rate X ";
        std::stringstream ss;
        ss << realRate;
        mess += ss.str();
        handler->PSendSysMessage(mess.c_str());
        return true;
    }

    static bool HandleCopyCharacterCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        std::string argstr = (char*)args;

        if (argstr == "cataclysm")
        {
            Player *player = handler->GetSession()->GetPlayer();
            if (!player)
                return false;
            if (!player->CanMigrateToCata())
                return false;
            player->SaveToCATADB(true);
            handler->PSendSysMessage("Felicitation ! votre personnage a bien ete copie sur l'extension Cataclysm.");
            return true;
        }
        return false;
    }

    static bool HandleGuildRankedCharacterCommand(ChatHandler* handler, char const* args)
    {
        Player *player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;
        player->PlayerTalkClass->ClearMenus();
        player->CLOSE_GOSSIP_MENU();
        player->ADD_GOSSIP_ITEM(0, "[Passif] - M. Popularite La reputation gagnee avec des quetes ou en tuant des monstres est augmentee de 5%", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        player->ADD_GOSSIP_ITEM(0, "[Passif] - Tresorerie  A chaque fois que lon ramasse de l argent sur un ennemi, 5% supplementaire est genere et mis dans la banque de guilde.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        player->ADD_GOSSIP_ITEM(0, "[Passif] - TrÃ©soreriA chaque fois que l on ramasse de l argent sur un ennemi, 10% supplÃ©mentaire est gÃ©nÃ©rÃ© et mis dans la banque de guilde.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
        player->ADD_GOSSIP_ITEM(0, "[Passif] - G du courrier  Le courrier en jeu envoyÃ© par un membre de la guilde arrive instantanÃ©ment.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
        player->ADD_GOSSIP_ITEM(0, "[Passif] - Mention honorable  Augmente les points d honneur gagnÃ©s de 10%.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
        player->ADD_GOSSIP_ITEM(0, "Banque mobile", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
        player->ADD_GOSSIP_ITEM(0, "Groupe de voyage", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+7);
        player->ADD_GOSSIP_ITEM(0, "RÃ©surrection de masse", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+8);
        // SetMenuId must be after clear menu and before send menu!!
        player->PlayerTalkClass->GetGossipMenu().SetMenuId(MENU_ID);        // Sets menu ID so we can identify our menu in Select hook. Needs unique number for the menu
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, player->GetGUID());
        return true;
    }


};

#define CUSTOM_PACK_SPELL_SUMMON_RAID 2000002
#define CUSTOM_PACK_SPELL_REZ_RAID 2000003

class example_PlayerGossip : public PlayerScript
{
    public:
    example_PlayerGossip() : PlayerScript("example_PlayerGossip") {}

    void OnGossipSelect(Player* player, uint32 menu_id, uint32 /*sender*/, uint32 action) override
    {
        if (menu_id != MENU_ID) // Not the menu coded here? stop.
            return;

        player->PlayerTalkClass->ClearMenus();

        switch(action)
        {
        case GOSSIP_ACTION_INFO_DEF+6:
            player->GetSession()->SendShowBank(player->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+7:
            if (player->HasSpellCooldown(CUSTOM_PACK_SPELL_SUMMON_RAID))
                break;
            if (Group *group = player->GetGroup())
            {
                SummonPlayerRaid(player);
                player->GetSession()->SendAreaTriggerMessage("Your raid has been invited to teleport at your location.");
                player->AddSpellCooldown(CUSTOM_PACK_SPELL_SUMMON_RAID, 0, time(NULL) + 3600);
            }
            else
                ChatHandler(player).SendSysMessage("You are not grouped");
            break;
        case GOSSIP_ACTION_INFO_DEF+8:
            if (player->HasSpellCooldown(CUSTOM_PACK_SPELL_REZ_RAID))
                break;
            if (Group *group = player->GetGroup())
            {
                player->CastSpell(player, CUSTOM_PACK_SPELL_REZ_RAID, true);
                player->AddSpellCooldown(CUSTOM_PACK_SPELL_REZ_RAID, 0, time(NULL) + 1800);
            }
            else
                ChatHandler(player).SendSysMessage("You are not grouped");
            break;
        }
        player->CLOSE_GOSSIP_MENU();
    }

    void SummonPlayerRaid(Player *player)
    {
        if (Group *group = player->GetGroup())
        {
            const Group::MemberSlotList members = group->GetMemberSlots();
            for (Group::member_citerator itr = members.begin(); itr != members.end(); ++itr)
                if (itr->guid != player->GetGUID())
                    if (Player* target = ObjectAccessor::FindPlayer(itr->guid))
                    {
                        // Evil Twin (ignore player summon, but hide this for summoner)
                        if (target->HasAura(23445))
                            return;

                        float x, y, z;
                        player->GetPosition(x, y, z);

                        target->SetSummonPoint(player->GetMapId(), x, y, z);

                        WorldPacket data(SMSG_SUMMON_REQUEST, 8+4+4);
                        data << uint64(player->GetGUID());                    // summoner guid
                        data << uint32(player->GetZoneId());                  // summoner zone
                        data << uint32(MAX_PLAYER_SUMMON_DELAY*IN_MILLISECONDS); // auto decline after msecs
                        target->GetSession()->SendPacket(&data);
                    }
        }
    }

};

void AddSC_misc_commandscript()
{
    new example_PlayerGossip();
    new misc_commandscript();
}
