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
        if (!validate || strcmp(validate, "on"))
        {
            handler->PSendSysMessage("Write '.titles distribute ireallywanttodistribute' to distribute season end titles");
            return true;
        }

        FILE* file;
        file = fopen("distributeTitles.log", "a");
        if (!file)
        {
            handler->PSendSysMessage("Could not open log file");
            return true;
        }

        FILE* sqlFile;
        sqlFile = fopen("titleSQL.log", "a");
        if (!sqlFile)
        {
            handler->PSendSysMessage("Could not open title sql");
            return true;
        }

        fprintf(file, "\n\n\nNEW DISTRIBUTION");
        fflush(file);
        fprintf(file, "\nStarting to distribute titles");
        fflush(file);
        handler->PSendSysMessage("Starting to distribute titles...");
        int titRank = 0;
        //
        // 2v2
        //
        fprintf(file, "\nProcessing 2v2 teams...");
        fflush(file);
        fprintf(sqlFile, "\nGenerating 2v2 inserts...");
        fflush(sqlFile);
        handler->PSendSysMessage("Processing 2v2 teams...");
        // Get 2v2 team top 33
        QueryResult result = CharacterDatabase.PQuery("select name, arenaTeamId, rating "
                                                      "from arena_team "
                                                      "where type = 2 "
                                                      "order by rating desc "
                                                      "limit %u", V2_CHALLANGER_CUTOFF);

        if (result)
        {
            uint32 count = 0;
            uint32 skipcount = 0;
            uint32 rank = 0;
            do
            {
                ++rank;
                Field* fields = result->Fetch();

                std::string teamname = fields[0].GetString();
                CharacterDatabase.EscapeString(teamname);
                uint32 teamid = fields[1].GetUInt32();
                uint32 teamrating = fields[2].GetUInt32();

                uint32 titleid = 0;
                uint32 questitem = 0;
                if (rank <= V2_GLADIATOR_CUTOFF)
                {
                    if (titRank == 0)
                    {
                        fprintf(file, "\n\n ######################### V2 GLADIATOR ! #########################");
                        fflush(file);
                    }
                    titRank = 1;
                    titleid = GLADIATOR_TITLE_ID;
                    questitem = GLADIATOR_TITLE_QUEST;
                }
                else if (rank <= V2_DUEL_CUTOFF)
                {
                    if (titRank == 1)
                    {
                        fprintf(file, "\n\n  ######################### V2 DUELIST ! #########################");
                        fflush(file);
                    }
                    titRank = 2;
                    titleid = DUEL_TITLE_ID;
                    questitem = DUEL_TITLE_QUEST;
                }
                else if (rank <= V2_RIVAL_CUTOFF)
                {
                    if (titRank == 2)
                    {
                        fprintf(file, "\n\n  ######################### V2 RIVAL ! #########################");
                        fflush(file);
                    }
                    titRank = 3;
                    titleid = RIVAL_TITLE_ID;
                    questitem = RIVAL_TITLE_QUEST;
                }
                else if (rank <= V2_CHALLANGER_CUTOFF)
                {
                    if (titRank == 3)
                    {
                        fprintf(file, "\n\n  ######################### V2 GHALLANGER ! #########################");
                        fflush(file);
                    }
                    titRank = 4;
                    titleid = CHALLANGER_TITLE_ID;
                    questitem = CHALLANGER_TITLE_QUEST;
                }

                fprintf(file, "\n\n  Processing team '%s' (ID: %u) (rating: %u) (rank: %u)", teamname.c_str(), teamid, teamrating, rank);
                fflush(file);

                // Get team members for each 2v2 team
                QueryResult res2 = CharacterDatabase.PQuery("select arena_team_member.guid, arena_team_member.personalRating from arena_team_member "
                                                            "join character_arena_stats on arena_team_member.guid = character_arena_stats.guid "
                                                            "where arena_team_member.arenateamid = '%u' and character_arena_stats.slot = 0", teamid);
                if (res2)
                {
                    do
                    {
                        Field* fld2 = res2->Fetch();
                        uint32 playerid = fld2[0].GetUInt32();
                        uint32 playerrating = fld2[1].GetUInt32();

                        if (playerrating + MAX_RATING_DIFFERENCE < teamrating)
                        {
                            fprintf(file, "\n    Skipping player (guid: %u) (personal rating: %u)", playerid, playerrating);
                            fflush(file);
                            ++skipcount;
                            continue;
                        } else
                        {
                            fprintf(file, "\n    Player (guid: %u) (personal rating: %u) Title: %u Mount: %u", playerid, playerrating, titleid, questitem);
                            fflush(file);

                            fprintf(file, "\n.send mail %u 'Felicitations !' 'Vous avez ete selectionnez pour la remise des recompenses de saison d'arenes en V2. Vous devrez neanmoin etre present ou vous faire remplacer le X a X h. Merci et bon jeu sur Paragon !", playerid);
                            fflush(file);

                            ++count;
                        }
                    }
                    while (res2->NextRow());
                }
            }
            while (result->NextRow());
            handler->PSendSysMessage("Titles rewarded to %u 2v2 teams (%u players)", result->GetRowCount(), count);
            fprintf(file, "\nTitles rewarded to %u 2v2 teams (%u players rewarded) (%u players skipped)", result->GetRowCount(), count, skipcount);
            fflush(file);
        }
        else
        {
            handler->PSendSysMessage("No 2v2 teams found");
            fprintf(file, "\nNo 2v2 teams found");
            fflush(file);
        }


        //
        // 3v3
        //
        fprintf(file, "\nProcessing 3v3 teams...");
        fflush(file);
        fprintf(sqlFile, "\nGenerating 3v3 inserts...");
        fflush(sqlFile);
        handler->PSendSysMessage("Processing 3v3 teams...");
        titRank = 0;
        // Get 3v3 team top 33
        result = CharacterDatabase.PQuery("select name, arenaTeamId, rating "
                                          "from arena_team "
                                          "where type = 3 "
                                          "order by rating desc "
                                          "limit %u", V3_CHALLANGER_CUTOFF);

        if (result)
        {
            uint32 count = 0;
            uint32 skipcount = 0;
            uint32 rank = 0;
            do
            {
                ++rank;
                Field* fields = result->Fetch();

                std::string teamname = fields[0].GetString();
                CharacterDatabase.EscapeString(teamname);
                uint32 teamid = fields[1].GetUInt32();
                uint32 teamrating = fields[2].GetUInt32();

                uint32 titleid = 0;
                uint32 questitem = 0;
                if (rank <= V3_GLADIATOR_CUTOFF)
                {
                    if (titRank == 0)
                    {
                        fprintf(file, "\n\n  ######################### V3 GLADIATOR ! #########################");
                        fflush(file);
                    }
                    titRank = 1;
                    titleid = GLADIATOR_TITLE_ID;
                    questitem = GLADIATOR_TITLE_QUEST;
                }
                else if (rank <= V3_DUEL_CUTOFF)
                {
                    if (titRank == 1)
                    {
                        fprintf(file, "\n\n  ######################### V3 DUELISTE ! #########################");
                        fflush(file);
                    }
                    titRank = 2;
                    titleid = DUEL_TITLE_ID;
                    questitem = DUEL_TITLE_QUEST;
                }
                else if (rank <= V3_RIVAL_CUTOFF)
                {
                    if (titRank == 2)
                    {
                        fprintf(file, "\n\n  ######################### V3 RIVAL ! #########################");
                        fflush(file);
                    }
                    titRank = 3;
                    titleid = RIVAL_TITLE_ID;
                    questitem = RIVAL_TITLE_QUEST;
                }
                else if (rank <= V3_CHALLANGER_CUTOFF)
                {
                    if (titRank == 3)
                    {
                        fprintf(file, "\n\n  ######################### V3 CHALLENGER ! #########################");
                        fflush(file);
                    }
                    titRank = 4;
                    titleid = CHALLANGER_TITLE_ID;
                    questitem = CHALLANGER_TITLE_QUEST;
                }

                fprintf(file, "\n  Processing team '%s' (ID: %u) (rating: %u) (rank: %u)", teamname.c_str(), teamid, teamrating, rank);
                fflush(file);

                // Get team members for each 2v2 team
                QueryResult res2 = CharacterDatabase.PQuery("select arena_team_member.guid, arena_team_member.personalRating from arena_team_member "
                                                            "join character_arena_stats on arena_team_member.guid = character_arena_stats.guid "
                                                            "where arena_team_member.arenateamid = '%u' and character_arena_stats.slot = 1", teamid);

                if (res2)
                {
                    do
                    {
                        Field* fld2 = res2->Fetch();
                        uint32 playerid = fld2[0].GetUInt32();
                        uint32 playerrating = fld2[1].GetUInt32();

                        if (playerrating + MAX_RATING_DIFFERENCE < teamrating)
                        {
                            fprintf(file, "\n    Skipping player (guid: %u) (personal rating: %u)", playerid, playerrating);
                            fflush(file);
                            ++skipcount;
                            continue;
                        } else
                        {
                            fprintf(file, "\n    Player (guid: %u) (personal rating: %u) Title: %u Mount %u", playerid, playerrating, titleid, questitem);
                            fflush(file);

                            fprintf(file, "\n.send mail %u 'Felicitations !' 'Vous avez ete selectionnez pour la remise des recompenses de saison d'arenes en V3. Vous devrez neanmoin etre present ou vous faire remplacer le X a X h. Merci et bon jeu sur Paragon !", playerid);
                            fflush(file);
                            ++count;
                        }
                    }
                    while (res2->NextRow());
                }
            }
            while (result->NextRow());
            handler->PSendSysMessage("Titles rewarded to %u 3v3 teams (%u players)", result->GetRowCount(), count);
            fprintf(file, "\nTitles rewarded to %u 3v3 teams (%u players rewarded) (%u players skipped)", result->GetRowCount(), count, skipcount);
            fflush(file);
        }
        else
        {
            handler->PSendSysMessage("No 3v3 teams found");
            fprintf(file, "\nNo 3v3 teams found");
            fflush(file);
        }

        fprintf(file, "\nDistribution ended");
        fclose(file);
        return true;
    }

};



void AddSC_titles_commandscript()
{
    new titles_commandscript();
}
