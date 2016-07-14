/*
 * Copyright (C) 2008-2016 Frostmourne <http://www.frostmourne.eu/>
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

#include "SoloQueue.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "BattlegroundQueue.h"
#include "Chat.h"
#include "Language.h"
#include "Player.h"
#include "ScriptMgr.h"

SoloQueue::SoloQueue()
{
    queuedHealers.clear();
    queuedMelees.clear();
    queuedRanges.clear();
    allPlayersInQueue.clear();
    updateTimer.SetInterval(1000);
}

SoloQueue::~SoloQueue()
{
}

SoloQueue* SoloQueue::instance()
{
    static SoloQueue instance;
    return &instance;
}

void SoloQueue::AddPlayer(Player* player, bool reQueue)
{
    if (CheckRequirements(player))
    {
        if (ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5))))
        {
            SoloQueueInfo* soloInfo = new SoloQueueInfo();
            soloInfo->playerGuid = player->GetGUID();
            soloInfo->rating = at->GetRating();
            soloInfo->ArenaMatchmakerRating = player->GetMMR(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5));
            soloInfo->teamId = at->GetId();
            soloInfo->team = player->GetTeam();
            soloInfo->lastMmrUpdate = sWorld->GetGameTime();
            soloInfo->characterClass = player->getClass();
            player->soloQueueSpec = player->GetActiveSpec();
            if (!reQueue)
                player->soloQueueJoinTime = getMSTime();

            switch (GetPlayerTalentCategory(player))
            {
                case TALENT_CAT_HEALER:
                    queuedHealers.insert(MMRQueueStorageType::value_type(soloInfo->ArenaMatchmakerRating, soloInfo));
                    allPlayersInQueue.insert(PlayerQueueStorageType::value_type(player->GetGUID(), soloInfo));
                    break;
                case TALENT_CAT_MELEE:
                    queuedMelees.insert(MMRQueueStorageType::value_type(soloInfo->ArenaMatchmakerRating, soloInfo));
                    allPlayersInQueue.insert(PlayerQueueStorageType::value_type(player->GetGUID(), soloInfo));
                    break;
                case TALENT_CAT_RANGE:
                    queuedRanges.insert(MMRQueueStorageType::value_type(soloInfo->ArenaMatchmakerRating, soloInfo));
                    allPlayersInQueue.insert(PlayerQueueStorageType::value_type(player->GetGUID(), soloInfo));
                    break;
                case TALENT_CAT_UNKNOWN:
                    ChatHandler(player->GetSession()).PSendSysMessage("Talent spec unknown! Please contact a developer or try again...");
                    return;
                default:
                    break;
            }

            if (Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA))
            {
                bg->SetRated(true);
                uint32 queueSlot = player->AddBattlegroundQueueId(BATTLEGROUND_QUEUE_3v3_SOLO);

                WorldPacket data;
                sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, GetAverageSoloQueueWaitTime(), reQueue ? GetMSTimeDiffToNow(player->soloQueueJoinTime) : 0, ARENA_TYPE_3v3_SOLO, 0);
                player->GetSession()->SendPacket(&data);
            }

            if (reQueue)
                ChatHandler(player->GetSession()).PSendSysMessage("Someone has left the solo queue... The solo queue system will now try to find new group members!");
            else
                ChatHandler(player->GetSession()).PSendSysMessage("You are now listed for random solo arena! The solo queue system will now try to find group members based on your MMR!");
        }
    }
}

bool SoloQueue::RemovePlayer(uint64 playerGuid)
{
    allPlayersInQueue.erase(playerGuid);

    for (MMRQueueStorageType::iterator itr = queuedRanges.begin(); itr != queuedRanges.end(); ++itr)
        if (itr->second->playerGuid == playerGuid)
        {
            delete itr->second;
            queuedRanges.erase(itr);
            return true;
        }

    for (MMRQueueStorageType::iterator itr = queuedHealers.begin(); itr != queuedHealers.end(); ++itr)
        if (itr->second->playerGuid == playerGuid)
        {
            delete itr->second;
            queuedHealers.erase(itr);
            return true;
        }

    for (MMRQueueStorageType::iterator itr = queuedMelees.begin(); itr != queuedMelees.end(); ++itr)
        if (itr->second->playerGuid == playerGuid)
        {
            delete itr->second;
            queuedMelees.erase(itr);
            return true;
        }
    return false;
}

void SoloQueue::Update(uint32 diff)
{
    updateTimer.Update(diff);
    if (!updateTimer.Passed())
        return;

    updateTimer.Reset();

    time_t now = sWorld->GetGameTime();
    // Update MMR range for all players
    for (PlayerQueueStorageType::iterator itr = allPlayersInQueue.begin(); itr != allPlayersInQueue.end(); itr++)
    {
        if (now > itr->second->lastMmrUpdate && now - itr->second->lastMmrUpdate >= 35)
            IncreasePlayerMMrRange(itr->second);
    }

    uint32 maxRatingDiff = sBattlegroundMgr->GetMaxRatingDifference();
    for (std::multimap<uint32, SoloQueueInfo*>::iterator itr3 = queuedHealers.begin(); itr3 != queuedHealers.end();)
    {
        std::multimap<uint32, SoloQueueInfo*>::iterator itr = itr3;
        itr3++;
        std::list<SoloQueueInfo*> playerList;
        uint32 completeRange = maxRatingDiff + itr->second->ratingRange;
        uint32 minMMRHeal = std::max(0, int32(itr->second->ArenaMatchmakerRating - completeRange));
        uint32 maxMMRHeal = std::min(int32(itr->second->ArenaMatchmakerRating + completeRange), 4000);

        FillGroup(playerList, minMMRHeal, maxMMRHeal, itr->second->ArenaMatchmakerRating, false, itr->second->characterClass);
        FillGroup(playerList, minMMRHeal, maxMMRHeal, itr->second->ArenaMatchmakerRating, true, itr->second->characterClass);

        if (sWorld->getBoolConfig(CONFIG_ARENA_SOLO_QUEUE_ALLOW_MMH_AND_RRH))
        {
            // MHC wasn't possible lets try RRH
            if (playerList.size() < 2)
            {
                playerList.clear();
                FillGroup(playerList, minMMRHeal, maxMMRHeal, itr->second->ArenaMatchmakerRating, false, itr->second->characterClass, 2);
            }

            // RRH wasn't possible lets try MMH
            if (playerList.size() < 2)
            {
                playerList.clear();
                FillGroup(playerList, minMMRHeal, maxMMRHeal, itr->second->ArenaMatchmakerRating, true, itr->second->characterClass, 2);
            }
        }

        playerList.push_back(itr->second);

        if (playerList.size() == 3 || sBattlegroundMgr->isArenaTesting())
        {
            if (Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA))
            {
                bg->SetRated(true);
                BattlegroundTypeId bgTypeId = bg->GetTypeID();
                BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, ARENA_TYPE_3v3_SOLO);
                if (PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL)))
                {
                    BattlegroundQueue &bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
                    GroupQueueInfo* ginfo = bgQueue.AddSoloQueueGroup(playerList, bracketEntry->GetBracketId(), ALLIANCE);
                    sBattlegroundMgr->ScheduleQueueUpdate(ginfo->ArenaMatchmakerRating, ARENA_TYPE_3v3_SOLO, bgQueueTypeId, bgTypeId, bracketEntry->GetBracketId());

                    // everything is done - remove players from solo queue
                    for (std::list<SoloQueueInfo*>::iterator itr2 = playerList.begin(); itr2 != playerList.end(); itr2++)
                    {
                        SoloQueueInfo* soloInfo = *itr2;
                        if (soloInfo->playerGuid == itr->second->playerGuid)
                            continue;
                        RemovePlayer(soloInfo->playerGuid);
                    }
                    // we cant remove the heal with RemovePlayer because we still using the itr here
                    allPlayersInQueue.erase(itr->second->playerGuid);
                    delete itr->second;
                    queuedHealers.erase(itr);
                }
            }
        }
    }
}

uint32 SoloQueue::GetPlayerCountInQueue(SoloQueueTalentCategory talentCategory, bool allPlayers)
{
    if (allPlayers)
        return allPlayersInQueue.size();

    switch (talentCategory)
    {
        case TALENT_CAT_HEALER:
            return queuedHealers.size();
        case TALENT_CAT_MELEE:
            return queuedMelees.size();
        case TALENT_CAT_RANGE:
            return queuedRanges.size();
        default:
            break;
    }
    return 0;
}

uint8 SoloQueue::GetPlayerTalentCategory(Player* player)
{
    if (player->HasHealSpec())
        return TALENT_CAT_HEALER;
    else if (player->HasMeleeSpec(true))
        return TALENT_CAT_MELEE;
    else if (player->HasCasterSpec(true))
        return TALENT_CAT_RANGE;

    return TALENT_CAT_UNKNOWN;
}

bool SoloQueue::CheckRequirements(Player* player)
{
    if (sBattlegroundMgr->isTesting())
        return true;

    if (!player->CanJoinToBattleground())
    {
        WorldPacket data;
        sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_GROUP_JOIN_BATTLEGROUND_DESERTERS);
        player->SendDirectMessage(&data);
        return false;
    }

    if (player->GetAverageItemLevel() < 232)
    {
        ChatHandler(player->GetSession()).PSendSysMessage("Your current average item level is: %u! You should have at least an average item level of 232!", player->GetAverageItemLevel());
        return false;
    }

    if (!player->HasFreeBattlegroundQueueId())
    {
        ChatHandler(player->GetSession()).SendSysMessage("You cant join more than 2 battleground queues!");
        return false;
    }

    if (player->GetFreeTalentPoints() > 0)
    {
        ChatHandler(player->GetSession()).PSendSysMessage("You have currently %u free talent points. Please spend all your talent points before queueing arena.", player->GetFreeTalentPoints());
        return false;
    }

    if (player->InBattleground())
    {
        ChatHandler(player->GetSession()).SendSysMessage("You can't use solo queue while you are in a battleground");
        return false;
    }

    if (player->isUsingLfg())
    {
        ChatHandler(player->GetSession()).SendSysMessage("You can't join solo queue while you are using the dungeon finder!");
        return false;
    }

    if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_2v2) ||
        player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3) ||
        player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5))
    {
        ChatHandler(player->GetSession()).SendSysMessage("You are already listed for another rated arena match!");
        return false;
    }

    if (IsPlayerInSoloQueue(player))
    {
        ChatHandler(player->GetSession()).SendSysMessage("You cant join solo queue multiple times!");
        return false;
    }

    if (player->HasAura(15007)) // Resurrection Sickness
    {
        ChatHandler(player->GetSession()).SendSysMessage("You cant join solo queue with resurrection sickness!");
        return false;
    }

    Item* newItem = NULL;
    for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        if (slot == EQUIPMENT_SLOT_OFFHAND || slot == EQUIPMENT_SLOT_RANGED || slot == EQUIPMENT_SLOT_TABARD || slot == EQUIPMENT_SLOT_BODY)
            continue;

        newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
        if (newItem == NULL)
        {
            ChatHandler(player->GetSession()).SendSysMessage("Your character is not fully equipped!");
            return false;
        }
    }
    return true;
}

bool SoloQueue::IsPlayerInSoloQueue(Player* player)
{
    if (allPlayersInQueue.find(player->GetGUID()) != allPlayersInQueue.end()
        || player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_1v1_SOLO)
        || player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3_SOLO))
        return true;
    return false;
}

void SoloQueue::IncreasePlayerMMrRange(SoloQueueInfo* playerInfo)
{
    if (playerInfo->ratingRangeIncreaseCounter > 0)
    {
        playerInfo->ratingRange += 100;
        uint32 completeRange = sBattlegroundMgr->GetMaxRatingDifference() + playerInfo->ratingRange;
        uint32 minRating = std::max(0, int32(playerInfo->ArenaMatchmakerRating - completeRange));
        uint32 maxRating = std::min(int32(playerInfo->ArenaMatchmakerRating + completeRange), 4000);

        if (maxRating < 4000 || minRating > 0)
            if (Player* player = ObjectAccessor::FindPlayer(playerInfo->playerGuid))
                ChatHandler(player->GetSession()).PSendSysMessage("The solo queue system will now try to find group members between %i and %i Matchmaking Rating", minRating, maxRating);
    }
    playerInfo->ratingRangeIncreaseCounter += 1;
    playerInfo->lastMmrUpdate = sWorld->GetGameTime();
}

void SoloQueue::FillGroup(std::list<SoloQueueInfo*>& playerList, uint32 minMMR, uint32 maxMMR, uint32 healMMR, bool melees, uint8 healerClass, int8 playerAmount)
{
    MMRQueueStorageType list = melees ? queuedMelees : queuedRanges;
    int8 listedPlayers = 0;
    uint32 maxRatingDiff = sBattlegroundMgr->GetMaxRatingDifference();
    bool allowClassStacking = sWorld->getBoolConfig(CONFIG_ARENA_SOLO_QUEUE_ALLOW_CLASS_STACKING);

    for (MMRQueueStorageType::iterator itr = list.begin(); itr != list.end(); itr++)
    {
        uint32 completeRange = maxRatingDiff + (*itr).second->ratingRange;
        uint32 minMMRQueued = std::max(0, int32((*itr).second->ArenaMatchmakerRating - completeRange));
        uint32 maxMMRQueued = std::min(int32((*itr).second->ArenaMatchmakerRating + completeRange), 4000);

        if (IsInMmrRange(minMMRQueued, maxMMRQueued, healMMR) || IsInMmrRange(minMMR, maxMMR, (*itr).second->ArenaMatchmakerRating))
        {
            if (allowClassStacking
                || (((*itr).second->characterClass != healerClass && playerList.empty()) || (!playerList.empty() && (playerList.front()->characterClass != (*itr).second->characterClass)) && (*itr).second->characterClass != healerClass))
            {
                playerList.push_back((*itr).second);
                if (++listedPlayers == playerAmount)
                    break;
            }
        }
    }
}

uint32 SoloQueue::GetAverageSoloQueueWaitTime()
{
    if (waitTimes.empty())
        return 0;

    uint32 avgTime = 0;
    for (std::list<uint32>::iterator itr = waitTimes.begin(); itr != waitTimes.end(); itr++)
    {
        uint32 time = *itr;
        avgTime += time;
    }

    return ceil(avgTime / waitTimes.size());
}

void SoloQueue::AddSoloQueueWaitTime(uint32 time)
{
    waitTimes.push_back(time);

    if (waitTimes.size() > 10)
        waitTimes.pop_front();
}
