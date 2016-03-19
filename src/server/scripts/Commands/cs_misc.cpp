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
        Player *player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;
        player->SaveToCATADB(true);
        std::string mess = "Votre personnage à �té migrévous pouvez des à présent le retrouver sur notre royaume catalysm. ";
        handler->PSendSysMessage(mess.c_str());
        return true;
    }


};

void AddSC_misc_commandscript()
{
    new misc_commandscript();
}
