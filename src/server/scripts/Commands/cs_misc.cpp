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
            { "dev",            SEC_ADMINISTRATOR,  false,  &HandleDevCommand,          "", NULL },
            { "wintrade",           SEC_ADMINISTRATOR,      false, &HandleWintradeCommand,               "", NULL },
            { NULL,             0,                  false,  NULL,                       "", NULL }
        };
        return commandTable;
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
};

void AddSC_misc_commandscript()
{
    new misc_commandscript();
}
