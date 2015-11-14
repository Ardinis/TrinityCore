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

/* ScriptData
Name: titles_commandscript
%Complete: 100
Comment: All titles related commands
Category: commandscripts
EndScriptData */

#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"

class titles_commandscript : public CommandScript
{
public:
    titles_commandscript() : CommandScript("titles_commandscript") { }

    ChatCommand* GetCommands() const
    {
        static ChatCommand titlesSetCommandTable[] =
        {
            { "mask",           SEC_GAMEMASTER,     false, &HandleTitlesSetMaskCommand,        "", NULL },
            { NULL,             0,                  false, NULL,                               "", NULL }
        };
        static ChatCommand titlesCommandTable[] =
        {
            { "add",            SEC_GAMEMASTER,     false, &HandleTitlesAddCommand,            "", NULL },
            { "current",        SEC_GAMEMASTER,     false, &HandleTitlesCurrentCommand,        "", NULL },
            { "remove",         SEC_GAMEMASTER,     false, &HandleTitlesRemoveCommand,         "", NULL },
            { "set",            SEC_GAMEMASTER,     false, NULL,              "", titlesSetCommandTable },
            { "distribute",     SEC_ADMINISTRATOR,  false, &HandleTitlesDistributeCommand,     "", NULL },
            { NULL,             0,                  false, NULL,                               "", NULL }
        };
        static ChatCommand commandTable[] =
        {
            { "titles",         SEC_GAMEMASTER,     false, NULL,                 "", titlesCommandTable },
            { NULL,             0,                  false, NULL,                               "", NULL }
        };
        return commandTable;
    }

    static bool HandleTitlesCurrentCommand(ChatHandler* handler, const char* args)
    {
        // number or [name] Shift-click form |color|Htitle:title_id|h[name]|h|r
        char* id_p = handler->extractKeyFromLink((char*)args, "Htitle");
        if (!id_p)
            return false;

        int32 id = atoi(id_p);
        if (id <= 0)
        {
            handler->PSendSysMessage(LANG_INVALID_TITLE_ID, id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(id);
        if (!titleInfo)
        {
            handler->PSendSysMessage(LANG_INVALID_TITLE_ID, id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string tNameLink = handler->GetNameLink(target);

        target->SetTitle(titleInfo);                            // to be sure that title now known
        target->SetUInt32Value(PLAYER_CHOSEN_TITLE, titleInfo->bit_index);

        handler->PSendSysMessage(LANG_TITLE_CURRENT_RES, id, titleInfo->name[handler->GetSessionDbcLocale()], tNameLink.c_str());

        return true;
    }

    static bool HandleTitlesAddCommand(ChatHandler* handler, const char* args)
    {
        // number or [name] Shift-click form |color|Htitle:title_id|h[name]|h|r
        char* id_p = handler->extractKeyFromLink((char*)args, "Htitle");
        if (!id_p)
            return false;

        int32 id = atoi(id_p);
        if (id <= 0)
        {
            handler->PSendSysMessage(LANG_INVALID_TITLE_ID, id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(id);
        if (!titleInfo)
        {
            handler->PSendSysMessage(LANG_INVALID_TITLE_ID, id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string tNameLink = handler->GetNameLink(target);

        char const* targetName = target->GetName();
        char titleNameStr[80];
        snprintf(titleNameStr, 80, titleInfo->name[handler->GetSessionDbcLocale()], targetName);

        target->SetTitle(titleInfo);
        handler->PSendSysMessage(LANG_TITLE_ADD_RES, id, titleNameStr, tNameLink.c_str());

        return true;
    }

    static bool HandleTitlesRemoveCommand(ChatHandler* handler, const char* args)
    {
        // number or [name] Shift-click form |color|Htitle:title_id|h[name]|h|r
        char* id_p = handler->extractKeyFromLink((char*)args, "Htitle");
        if (!id_p)
            return false;

        int32 id = atoi(id_p);
        if (id <= 0)
        {
            handler->PSendSysMessage(LANG_INVALID_TITLE_ID, id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(id);
        if (!titleInfo)
        {
            handler->PSendSysMessage(LANG_INVALID_TITLE_ID, id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        target->SetTitle(titleInfo, true);

        std::string tNameLink = handler->GetNameLink(target);

        char const* targetName = target->GetName();
        char titleNameStr[80];
        snprintf(titleNameStr, 80, titleInfo->name[handler->GetSessionDbcLocale()], targetName);

        handler->PSendSysMessage(LANG_TITLE_REMOVE_RES, id, titleNameStr, tNameLink.c_str());

        if (!target->HasTitle(target->GetInt32Value(PLAYER_CHOSEN_TITLE)))
        {
            target->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, tNameLink.c_str());
        }

        return true;
    }

    //Edit Player KnownTitles
    static bool HandleTitlesSetMaskCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint64 titles = 0;

        sscanf((char*)args, UI64FMTD, &titles);

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        uint64 titles2 = titles;

        for (uint32 i = 1; i < sCharTitlesStore.GetNumRows(); ++i)
            if (CharTitlesEntry const* tEntry = sCharTitlesStore.LookupEntry(i))
                titles2 &= ~(uint64(1) << tEntry->bit_index);

        titles &= ~titles2;                                     // remove not existed titles

        target->SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES, titles);
        handler->SendSysMessage(LANG_DONE);

        if (!target->HasTitle(target->GetInt32Value(PLAYER_CHOSEN_TITLE)))
        {
            target->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, handler->GetNameLink(target).c_str());
        }

        return true;
    }


    // misc
#define V3_GLADIATOR_CUTOFF      2
#define V3_DUEL_CUTOFF           8
#define V3_RIVAL_CUTOFF         15
#define V3_CHALLANGER_CUTOFF    30
#define V2_GLADIATOR_CUTOFF      3
#define V2_DUEL_CUTOFF           8
#define V2_RIVAL_CUTOFF         10
#define V2_CHALLANGER_CUTOFF    15
#define MAX_RATING_DIFFERENCE  100
// title
#define GLADIATOR_TITLE_ID     42
#define DUEL_TITLE_ID          43
#define RIVAL_TITLE_ID         44
#define CHALLANGER_TITLE_ID    45
// quest items
#define RANK_ONE_TITLE_QUEST   300000
#define GLADIATOR_TITLE_QUEST  0
#define DUEL_TITLE_QUEST       0
#define RIVAL_TITLE_QUEST      0
#define CHALLANGER_TITLE_QUEST 0

    static bool HandleTitlesDistributeCommand(ChatHandler *handler, const char* args)
    {
        if (!args)
        {
            handler->PSendSysMessage("Write '.titles distribute ireallywanttodistribute' to distribute season end titles");
            return true;
        }

        char *validate = strtok((char*)args, " ");
        if (!validate || strcmp(validate, "ireallywanttodistribute"))
        {
            handler->PSendSysMessage("Write '.titles distribute ireallywanttodistribute' to distribute season end titles");
            return true;
        }
        handler->PSendSysMessage("Starting to distribute titles...");

        handler->PSendSysMessage("Processing 2v2 teams...");
        sObjectMgr->_arenaReward->reward2C2Season();
        handler->PSendSysMessage("Processing 2v2 Success");

        handler->PSendSysMessage("Processing 3v3 teams...");
        sObjectMgr->_arenaReward->reward3C3Season();
        handler->PSendSysMessage("Processing 3v3 Success");

        handler->PSendSysMessage("Initialize rewarded lists...");
        sObjectMgr->_arenaReward->Initialize();
        handler->PSendSysMessage("Initialize rewarded lists Success");

        handler->PSendSysMessage("Reset season cap...");
        sObjectMgr->_arenaReward->resetSeason();
        handler->PSendSysMessage("Reset season cap Success");
        return true;
    }

};



void AddSC_titles_commandscript()
{
    new titles_commandscript();
}
