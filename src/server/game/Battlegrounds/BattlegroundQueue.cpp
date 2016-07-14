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

#include "BattlegroundQueue.h"
#include "ArenaTeam.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "ObjectMgr.h"
#include "ArenaTeamMgr.h"
#include "Log.h"
#include "Group.h"
#include "DynConfigMgr.h"

/*********************************************************/
/***            BATTLEGROUND QUEUE SYSTEM              ***/
/*********************************************************/

BattlegroundQueue::BattlegroundQueue()
{
    for (uint32 i = 0; i < BG_TEAMS_COUNT; ++i)
    {
        for (uint32 j = 0; j < MAX_BATTLEGROUND_BRACKETS; ++j)
        {
            m_SumOfWaitTimes[i][j] = 0;
            m_WaitTimeLastPlayer[i][j] = 0;
            for (uint32 k = 0; k < COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME; ++k)
                m_WaitTimes[i][j][k] = 0;
        }
    }
}

BattlegroundQueue::~BattlegroundQueue()
{
    m_events.KillAllEvents(false);

    m_QueuedPlayers.clear();
    for (int i = 0; i < MAX_BATTLEGROUND_BRACKETS; ++i)
    {
        for (uint32 j = 0; j < BG_QUEUE_GROUP_TYPES_COUNT; ++j)
        {
            for (GroupsQueueType::iterator itr = m_QueuedGroups[i][j].begin(); itr!= m_QueuedGroups[i][j].end(); ++itr)
                delete (*itr);
            m_QueuedGroups[i][j].clear();
        }
    }
}

/*********************************************************/
/***      BATTLEGROUND QUEUE SELECTION POOLS           ***/
/*********************************************************/

// selection pool initialization, used to clean up from prev selection
void BattlegroundQueue::SelectionPool::Init()
{
    SelectedGroups.clear();
    PlayerCount = 0;
}

// remove group info from selection pool
// returns true when we need to try to add new group to selection pool
// returns false when selection pool is ok or when we kicked smaller group than we need to kick
// sometimes it can be called on empty selection pool
bool BattlegroundQueue::SelectionPool::KickGroup(uint32 size)
{
    //find maxgroup or LAST group with size == size and kick it
    bool found = false;
    GroupsQueueType::iterator groupToKick = SelectedGroups.begin();
    for (GroupsQueueType::iterator itr = groupToKick; itr != SelectedGroups.end(); ++itr)
    {
        if (abs((int32)((*itr)->Players.size() - size)) <= 1)
        {
            groupToKick = itr;
            found = true;
        }
        else if (!found && (*itr)->Players.size() >= (*groupToKick)->Players.size())
            groupToKick = itr;
    }
    //if pool is empty, do nothing
    if (GetPlayerCount())
    {
        //update player count
        GroupQueueInfo* ginfo = (*groupToKick);
        SelectedGroups.erase(groupToKick);
        PlayerCount -= ginfo->Players.size();
        //return false if we kicked smaller group or there are enough players in selection pool
        if (ginfo->Players.size() <= size + 1)
            return false;
    }
    return true;
}

// add group to selection pool
// used when building selection pools
// returns true if we can invite more players, or when we added group to selection pool
// returns false when selection pool is full
bool BattlegroundQueue::SelectionPool::AddGroup(GroupQueueInfo* ginfo, uint32 desiredCount)
{
    //if group is larger than desired count - don't allow to add it to pool
    if (!ginfo->IsInvitedToBGInstanceGUID && desiredCount >= PlayerCount + ginfo->Players.size())
    {
        SelectedGroups.push_back(ginfo);
        // increase selected players count
        PlayerCount += ginfo->Players.size();
        return true;
    }
    if (PlayerCount < desiredCount)
        return true;
    return false;
}

/*********************************************************/
/***               BATTLEGROUND QUEUES                 ***/
/*********************************************************/

// add group or player (grp == NULL) to bg queue with the given leader and bg specifications
GroupQueueInfo* BattlegroundQueue::AddGroup(Player* leader, Group* grp, BattlegroundTypeId BgTypeId, PvPDifficultyEntry const*  bracketEntry, uint8 ArenaType, bool isRated, bool isPremade, uint32 ArenaRating, uint32 MatchmakerRating, uint32 arenateamid)
{
    BattlegroundBracketId bracketId =  bracketEntry->GetBracketId();

    // create new ginfo
    GroupQueueInfo* ginfo            = new GroupQueueInfo;
    ginfo->BgTypeId                  = BgTypeId;
    ginfo->ArenaType                 = ArenaType;
    ginfo->ArenaTeamId               = arenateamid;
    ginfo->IsRated                   = isRated;
    ginfo->IsInvitedToBGInstanceGUID = 0;
    ginfo->JoinTime                  = getMSTime();
    ginfo->RemoveInviteTime          = 0;
    ginfo->Team                      = leader->GetTeam();
    ginfo->ArenaTeamRating           = ArenaRating;
    ginfo->ArenaMatchmakerRating     = MatchmakerRating;
    ginfo->OpponentsTeamRating       = 0;
    ginfo->OpponentsMatchmakerRating = 0;
    ginfo->ratingRange               = 0;
    ginfo->ratingRangeIncreaseCounter= 0;
    ginfo->xfaction		     = false;
    ginfo->xfaction_allowed	     = true;

    ginfo->Players.clear();

    //compute index (if group is premade or joined a rated match) to queues
    uint32 index = 0;
    if (!isRated && !isPremade)
        index += BG_TEAMS_COUNT;
    if (ginfo->Team == HORDE)
        index++;
    sLog->outDebug(LOG_FILTER_BATTLEGROUND, "Adding Group to BattlegroundQueue bgTypeId : %u, bracket_id : %u, index : %u", BgTypeId, bracketId, index);

    uint32 lastOnlineTime = getMSTime();

    //announce world (this don't need mutex)
    if (isRated && sWorld->getBoolConfig(CONFIG_ARENA_QUEUE_ANNOUNCER_ENABLE))
    {
        ArenaTeam* Team = sArenaTeamMgr->GetArenaTeamById(arenateamid);
        if (Team)
            sWorld->SendWorldText(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_JOIN, Team->GetName().c_str(), ginfo->ArenaType, ginfo->ArenaType, ginfo->ArenaTeamRating);
    }

    //add players from group to ginfo
    {
        if (leader && leader->isInterfactionAllowed()) {
            ginfo->xfaction_allowed = false;
            ChatHandler(leader->GetSession()).PSendSysMessage("[BG] Votre refus de passer dans la faction adverse a bien ete pris en compte. Le temps d'attente pourra etre plus eleve.");
        }
        //ACE_Guard<ACE_Recursive_Thread_Mutex> guard(m_Lock);
        if (grp)
        {
            for (GroupReference* itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
            {
                Player* member = itr->getSource();
                if (!member)
                    continue;   // this should never happen
                PlayerQueueInfo& pl_info = m_QueuedPlayers[member->GetGUID()];
                pl_info.LastOnlineTime   = lastOnlineTime;
                pl_info.GroupInfo        = ginfo;
                // add the pinfo to ginfo's list
                ginfo->Players[member->GetGUID()]  = &pl_info;
            }
        }
        else
        {
            PlayerQueueInfo& pl_info = m_QueuedPlayers[leader->GetGUID()];
            pl_info.LastOnlineTime   = lastOnlineTime;
            pl_info.GroupInfo        = ginfo;
            ginfo->Players[leader->GetGUID()]  = &pl_info;
        }

        //add GroupInfo to m_QueuedGroups
        m_QueuedGroups[bracketId][index].push_back(ginfo);

        //announce to world, this code needs mutex
        if (!isRated && !isPremade && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_ENABLE))
        {
            if (Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(ginfo->BgTypeId))
            {
                char const* bgName = bg->GetName();
                uint32 MinPlayers = bg->GetMinPlayersPerTeam();
                uint32 qHorde = 0;
                uint32 qAlliance = 0;
                uint32 q_min_level = bracketEntry->minLevel;
                uint32 q_max_level = bracketEntry->maxLevel;
                GroupsQueueType::const_iterator itr;
                for (itr = m_QueuedGroups[bracketId][BG_QUEUE_NORMAL_ALLIANCE].begin(); itr != m_QueuedGroups[bracketId][BG_QUEUE_NORMAL_ALLIANCE].end(); ++itr)
                    if (!(*itr)->IsInvitedToBGInstanceGUID)
                        qAlliance += (*itr)->Players.size();
                for (itr = m_QueuedGroups[bracketId][BG_QUEUE_NORMAL_HORDE].begin(); itr != m_QueuedGroups[bracketId][BG_QUEUE_NORMAL_HORDE].end(); ++itr)
                    if (!(*itr)->IsInvitedToBGInstanceGUID)
                        qHorde += (*itr)->Players.size();

                // Show queue status to player only (when joining queue)
                if (sWorld->getBoolConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_PLAYERONLY))
                {
                    ChatHandler(leader).PSendSysMessage(LANG_BG_QUEUE_ANNOUNCE_SELF, bgName, q_min_level, q_max_level,
                        qAlliance, (MinPlayers > qAlliance) ? MinPlayers - qAlliance : (uint32)0, qHorde, (MinPlayers > qHorde) ? MinPlayers - qHorde : (uint32)0);
                }
                // System message
                else
                {
                    sWorld->SendWorldText(LANG_BG_QUEUE_ANNOUNCE_WORLD, bgName, q_min_level, q_max_level,
                        qAlliance, (MinPlayers > qAlliance) ? MinPlayers - qAlliance : (uint32)0, qHorde, (MinPlayers > qHorde) ? MinPlayers - qHorde : (uint32)0);
                }
            }
        }
        //release mutex
    }

    return ginfo;
}

GroupQueueInfo* BattlegroundQueue::AddSoloQueueGroup(std::list<SoloQueueInfo*> playerList, BattlegroundBracketId bracketId, uint32 team)
{
    // create new ginfo
    GroupQueueInfo* ginfo = new GroupQueueInfo;
    ginfo->BgTypeId = BATTLEGROUND_AA;
    ginfo->ArenaType = ARENA_TYPE_3v3_SOLO;
    ginfo->ArenaTeamId = urand(50000, 100000);
    ginfo->IsRated = true;
    ginfo->IsInvitedToBGInstanceGUID = 0;
    ginfo->JoinTime = getMSTime();
    ginfo->RemoveInviteTime = 0;
    ginfo->ArenaTeamRating = 0;
    ginfo->ArenaMatchmakerRating = 0;
    ginfo->OpponentsTeamRating = 0;
    ginfo->OpponentsMatchmakerRating = 0;
    ginfo->Team = team;
    ginfo->isSoloQueueGroup = true;
    ginfo->Players.clear();
    ginfo->ratingRange               = 0;
    ginfo->ratingRangeIncreaseCounter= 0;
    ginfo->xfaction		     = false;
    ginfo->xfaction_allowed	     = true;

    uint32 index = 0;
    if (ginfo->Team == HORDE)
        index++;

    uint32 lastOnlineTime = getMSTime();

    for (std::list<SoloQueueInfo* >::iterator itr = playerList.begin(); itr != playerList.end(); itr++)
    {
        SoloQueueInfo* playerInfo = *itr;
        PlayerQueueInfo& pl_info = m_QueuedPlayers[playerInfo->playerGuid];
        pl_info.LastOnlineTime = lastOnlineTime;
        pl_info.GroupInfo = ginfo;
        // add the pinfo to ginfo's list
        ginfo->Players[playerInfo->playerGuid] = &pl_info;
        ginfo->ArenaTeamRating += ceil(playerInfo->rating / 3);
        ginfo->ArenaMatchmakerRating += ceil(playerInfo->ArenaMatchmakerRating / 3);
    }

    sLog->outDebug(LOG_FILTER_BATTLEGROUND, "Adding Solo Queue Group to BattlegroundQueue bgTypeId : 6, bracket_id : %u, index : %u", bracketId, index);
    sLog->outError("Adding Solo Queue Group to BattlegroundQueue bgTypeId : 6, bracket_id : %u, index : %u", bracketId, index);

    //add GroupInfo to m_QueuedGroups
    {
        m_QueuedGroups[bracketId][index].push_back(ginfo);
    }

    return ginfo;
}

void BattlegroundQueue::PlayerInvitedToBGUpdateAverageWaitTime(GroupQueueInfo* ginfo, BattlegroundBracketId bracket_id)
{
    uint32 timeInQueue = getMSTimeDiff(ginfo->JoinTime, getMSTime());
    uint8 team_index = TEAM_ALLIANCE;                    //default set to TEAM_ALLIANCE - or non rated arenas!
    if (!ginfo->ArenaType)
    {
        if (ginfo->Team == HORDE)
            team_index = TEAM_HORDE;
    }
    else
    {
        if (ginfo->IsRated)
            team_index = TEAM_HORDE;                     //for rated arenas use TEAM_HORDE
    }

    //store pointer to arrayindex of player that was added first
    uint32* lastPlayerAddedPointer = &(m_WaitTimeLastPlayer[team_index][bracket_id]);
    //remove his time from sum
    m_SumOfWaitTimes[team_index][bracket_id] -= m_WaitTimes[team_index][bracket_id][(*lastPlayerAddedPointer)];
    //set average time to new
    m_WaitTimes[team_index][bracket_id][(*lastPlayerAddedPointer)] = timeInQueue;
    //add new time to sum
    m_SumOfWaitTimes[team_index][bracket_id] += timeInQueue;
    //set index of last player added to next one
    (*lastPlayerAddedPointer)++;
    (*lastPlayerAddedPointer) %= COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME;
}

uint32 BattlegroundQueue::GetAverageQueueWaitTime(GroupQueueInfo* ginfo, BattlegroundBracketId bracket_id) const
{
    uint8 team_index = BG_TEAM_ALLIANCE;                    //default set to BG_TEAM_ALLIANCE - or non rated arenas!
    if (!ginfo->ArenaType)
    {
        if (ginfo->Team == HORDE)
            team_index = BG_TEAM_HORDE;
    }
    else
    {
        if (ginfo->IsRated)
            team_index = BG_TEAM_HORDE;                     //for rated arenas use BG_TEAM_HORDE
    }
    //check if there is enought values(we always add values > 0)
    if (m_WaitTimes[team_index][bracket_id][COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME - 1])
        return (m_SumOfWaitTimes[team_index][bracket_id] / COUNT_OF_PLAYERS_TO_AVERAGE_WAIT_TIME);
    else
        //if there aren't enough values return 0 - not available
        return 0;
}

//remove player from queue and from group info, if group info is empty then remove it too
void BattlegroundQueue::RemovePlayer(uint64 guid, bool decreaseInvitedCount)
{
    //Player* player = ObjectAccessor::FindPlayer(guid);

    int32 bracket_id = -1;                                     // signed for proper for-loop finish
    QueuedPlayersMap::iterator itr;

    //remove player from map, if he's there
    itr = m_QueuedPlayers.find(guid);
    if (itr == m_QueuedPlayers.end())
    {
        sLog->outError("BattlegroundQueue: couldn't find player to remove GUID: %u", GUID_LOPART(guid));
        return;
    }

    GroupQueueInfo* group = itr->second.GroupInfo;
    GroupsQueueType::iterator group_itr, group_itr_tmp;
    // mostly people with the highest levels are in battlegrounds, thats why
    // we count from MAX_BATTLEGROUND_QUEUES - 1 to 0
    // variable index removes useless searching in other team's queue
    uint32 index = ((group->Team == HORDE) != (group->xfaction)) ? BG_TEAM_HORDE : BG_TEAM_ALLIANCE;

    for (int32 bracket_id_tmp = MAX_BATTLEGROUND_BRACKETS - 1; bracket_id_tmp >= 0 && bracket_id == -1; --bracket_id_tmp)
    {
        //we must check premade and normal team's queue - because when players from premade are joining bg,
        //they leave groupinfo so we can't use its players size to find out index
        for (uint32 j = index; j < BG_QUEUE_GROUP_TYPES_COUNT; j += BG_QUEUE_NORMAL_ALLIANCE)
        {
            for (group_itr_tmp = m_QueuedGroups[bracket_id_tmp][j].begin(); group_itr_tmp != m_QueuedGroups[bracket_id_tmp][j].end(); ++group_itr_tmp)
            {
                if ((*group_itr_tmp) == group)
                {
                    bracket_id = bracket_id_tmp;
                    group_itr = group_itr_tmp;
                    //we must store index to be able to erase iterator
                    index = j;
                    break;
                }
            }
        }
    }

    //player can't be in queue without group, but just in case
    if (bracket_id == -1)
    {
        sLog->outError("BattlegroundQueue: ERROR Cannot find groupinfo for player GUID: %u", GUID_LOPART(guid));
        return;
    }
    sLog->outDebug(LOG_FILTER_BATTLEGROUND, "BattlegroundQueue: Removing player GUID %u, from bracket_id %u", GUID_LOPART(guid), (uint32)bracket_id);

    // ALL variables are correctly set
    // We can ignore leveling up in queue - it should not cause crash
    // remove player from group
    // if only one player there, remove group

    // remove player queue info from group queue info
    std::map<uint64, PlayerQueueInfo*>::iterator pitr = group->Players.find(guid);
    if (pitr != group->Players.end())
        group->Players.erase(pitr);

    // if invited to bg, and should decrease invited count, then do it
    if (decreaseInvitedCount && group->IsInvitedToBGInstanceGUID)
        if (Battleground* bg = sBattlegroundMgr->GetBattleground(group->IsInvitedToBGInstanceGUID, group->BgTypeId == BATTLEGROUND_AA ? BATTLEGROUND_TYPE_NONE : group->BgTypeId)) {
            bg->DecreaseInvitedCount(group->Team);
        }

    // remove player queue info
    sLog->outString("removePlayer from queue: %u", guid);
    m_QueuedPlayers.erase(itr);

    // announce to world if arena team left queue for rated match, show only once
    if (group->ArenaType && group->IsRated && group->Players.empty() && sWorld->getBoolConfig(CONFIG_ARENA_QUEUE_ANNOUNCER_ENABLE))
        if (ArenaTeam* Team = sArenaTeamMgr->GetArenaTeamById(group->ArenaTeamId))
            sWorld->SendWorldText(LANG_ARENA_QUEUE_ANNOUNCE_WORLD_EXIT, Team->GetName().c_str(), group->ArenaType, group->ArenaType, group->ArenaTeamRating);

    uint32 teamId = group->isSoloQueueGroup ? Player::GetArenaTeamIdFromDB(guid, ARENA_TEAM_5v5) : group->ArenaTeamId;

    // if player leaves queue and he is invited to rated arena match, then he have to lose
    if (group->IsInvitedToBGInstanceGUID && group->IsRated && decreaseInvitedCount)
    {
        if (ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(teamId))
        {
            sLog->outDebug(LOG_FILTER_BATTLEGROUND, "UPDATING memberLost's personal arena rating for %u by opponents rating: %u", GUID_LOPART(guid), group->OpponentsTeamRating);
            if (Player* player = ObjectAccessor::FindPlayer(guid))
                at->MemberLost(player, group->OpponentsMatchmakerRating);
            else
                at->OfflineMemberLost(guid, group->OpponentsMatchmakerRating);

            if (group->isSoloQueueGroup)
            {
                int32 dummy = 0;
                at->LostAgainst(group->ArenaMatchmakerRating, group->OpponentsMatchmakerRating, dummy);
                if (Player* player = ObjectAccessor::FindPlayer(guid))
                    player->CastCustomSpell(26013, SPELLVALUE_BASE_POINT0, 1, player, true);
            }

            at->SaveToDB();
            at->NotifyStatsChanged();
        }
    }

    // remove group queue info if needed
    if (group->Players.empty())
    {
        m_QueuedGroups[bracket_id][index].erase(group_itr);
        delete group;
    }
    // if group wasn't empty, so it wasn't deleted, and player have left a rated
    // queue -> everyone from the group should leave too
    // don't remove recursively if already invited to bg!
    else if (!group->IsInvitedToBGInstanceGUID && group->IsRated)
    {
        // remove next player, this is recursive
        // first send removal information
        if (Player* plr2 = ObjectAccessor::FindPlayer(group->Players.begin()->first))
        {
            Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(group->BgTypeId);
            BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(group->BgTypeId, group->ArenaType);
            uint32 queueSlot = plr2->GetBattlegroundQueueIndex(bgQueueTypeId);
            plr2->RemoveBattlegroundQueueId(bgQueueTypeId); // must be called this way, because if you move this call to
                                                            // queue->removeplayer, it causes bugs
            WorldPacket data;
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_NONE, 0, 0, 0);
            plr2->GetSession()->SendPacket(&data);

            if (group->isSoloQueueGroup)
                sSoloQueueMgr->AddPlayer(plr2, true);
        }
        // then actually delete, this may delete the group as well!
        RemovePlayer(group->Players.begin()->first, decreaseInvitedCount);
    }
}

//returns true when player pl_guid is in queue and is invited to bgInstanceGuid
bool BattlegroundQueue::IsPlayerInvited(uint64 pl_guid, const uint32 bgInstanceGuid, const uint32 removeTime)
{
    QueuedPlayersMap::const_iterator qItr = m_QueuedPlayers.find(pl_guid);
    return (qItr != m_QueuedPlayers.end()
        && qItr->second.GroupInfo->IsInvitedToBGInstanceGUID == bgInstanceGuid
        && qItr->second.GroupInfo->RemoveInviteTime == removeTime);
}

bool BattlegroundQueue::GetPlayerGroupInfoData(uint64 guid, GroupQueueInfo* ginfo)
{
    QueuedPlayersMap::const_iterator qItr = m_QueuedPlayers.find(guid);
    if (qItr == m_QueuedPlayers.end())
        return false;
    *ginfo = *(qItr->second.GroupInfo);
    return true;
}

bool BattlegroundQueue::InviteGroupToBG(GroupQueueInfo* ginfo, Battleground* bg, uint32 side)
{
    // set side if needed
    if (side)
        ginfo->Team = side;

    if (!ginfo->IsInvitedToBGInstanceGUID)
    {
        // not yet invited
        // set invitation
        ginfo->IsInvitedToBGInstanceGUID = bg->GetInstanceID();
        BattlegroundTypeId bgTypeId = bg->GetTypeID();
        BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, bg->GetArenaType());
        BattlegroundBracketId bracket_id = bg->GetBracketId();

        // set ArenaTeamId for rated matches
        if (bg->isArena() && bg->isRated())
            bg->SetArenaTeamIdForTeam(ginfo->Team, ginfo->ArenaTeamId);

        ginfo->RemoveInviteTime = getMSTime() + INVITE_ACCEPT_WAIT_TIME;

        // loop through the players
        for (std::map<uint64, PlayerQueueInfo*>::iterator itr = ginfo->Players.begin(); itr != ginfo->Players.end(); ++itr)
        {
            // get the player
            Player* player = ObjectAccessor::FindPlayer(itr->first);
            // if offline, skip him, this should not happen - player is removed from queue when he logs out
            if (!player)
                continue;

            // invite the player
            PlayerInvitedToBGUpdateAverageWaitTime(ginfo, bracket_id);
            //sBattlegroundMgr->InvitePlayer(player, bg, ginfo->Team);

            if (bg->isSoloQueueArena())
                sSoloQueueMgr->AddSoloQueueWaitTime(GetMSTimeDiffToNow(player->soloQueueJoinTime));

            // set invited player counters
            bg->IncreaseInvitedCount(ginfo->Team);

            player->SetInviteForBattlegroundQueueType(bgQueueTypeId, ginfo->IsInvitedToBGInstanceGUID);

            // create remind invite events
            BGQueueInviteEvent* inviteEvent = new BGQueueInviteEvent(player->GetGUID(), ginfo->IsInvitedToBGInstanceGUID, bgTypeId, ginfo->ArenaType, ginfo->RemoveInviteTime);
            m_events.AddEvent(inviteEvent, m_events.CalculateTime(INVITATION_REMIND_TIME));
            // create automatic remove events
            BGQueueRemoveEvent* removeEvent = new BGQueueRemoveEvent(player->GetGUID(), ginfo->IsInvitedToBGInstanceGUID, bgTypeId, bgQueueTypeId, ginfo->RemoveInviteTime);
            m_events.AddEvent(removeEvent, m_events.CalculateTime(INVITE_ACCEPT_WAIT_TIME));

            WorldPacket data;

            uint32 queueSlot = player->GetBattlegroundQueueIndex(bgQueueTypeId);

            sLog->outDebug(LOG_FILTER_BATTLEGROUND, "Battleground: invited player %s (%u) to BG instance %u queueindex %u bgtype %u, I can't help it if they don't press the enter battle button.", player->GetName(), player->GetGUIDLow(), bg->GetInstanceID(), queueSlot, bg->GetTypeID());

            // send status packet
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_JOIN, INVITE_ACCEPT_WAIT_TIME, 0, ginfo->ArenaType);
            player->GetSession()->SendPacket(&data);
        }
        return true;
    }

    return false;
}

/*
This function is inviting players to already running battlegrounds
Invitation type is based on config file
large groups are disadvantageous, because they will be kicked first if invitation type = 1
*/

// DEPRECATED FUNCTION
void BattlegroundQueue::FillPlayersToBG(Battleground* bg, BattlegroundBracketId bracket_id)
{
    int32 hordeFree = bg->GetFreeSlotsForTeam(HORDE);
    int32 aliFree   = bg->GetFreeSlotsForTeam(ALLIANCE);

    //iterator for iterating through bg queue
    GroupsQueueType::const_iterator Ali_itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].begin();
    //count of groups in queue - used to stop cycles
    uint32 aliCount = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].size();
    //index to queue which group is current
    uint32 aliIndex = 0;
    for (; aliIndex < aliCount && m_SelectionPools[BG_TEAM_ALLIANCE].AddGroup((*Ali_itr), aliFree); aliIndex++)
        ++Ali_itr;
    //the same thing for horde
    GroupsQueueType::const_iterator Horde_itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].begin();
    uint32 hordeCount = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].size();
    uint32 hordeIndex = 0;

    //BGINTER : Ajouter groupes a la bonne faction
    for (; hordeIndex < hordeCount && m_SelectionPools[BG_TEAM_HORDE].AddGroup((*Horde_itr), hordeFree); hordeIndex++)
        ++Horde_itr;

    //if ofc like BG queue invitation is set in config, then we are happy
    if (sWorld->getIntConfig(CONFIG_BATTLEGROUND_INVITATION_TYPE) == 0)
        return;

    /*
    if we reached this code, then we have to solve NP - complete problem called Subset sum problem
    So one solution is to check all possible invitation subgroups, or we can use these conditions:
    1. Last time when BattlegroundQueue::Update was executed we invited all possible players - so there is only small possibility
        that we will invite now whole queue, because only 1 change has been made to queues from the last BattlegroundQueue::Update call
    2. Other thing we should consider is group order in queue
    */

    // At first we need to compare free space in bg and our selection pool
    int32 diffAli   = aliFree   - int32(m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount());
    int32 diffHorde = hordeFree - int32(m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount());
    while (abs(diffAli - diffHorde) > 1 && (m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount() > 0 || m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount() > 0))
    {
        //each cycle execution we need to kick at least 1 group
        if (diffAli < diffHorde)
        {
            //kick alliance group, add to pool new group if needed
            if (m_SelectionPools[BG_TEAM_ALLIANCE].KickGroup(diffHorde - diffAli))
            {
                for (; aliIndex < aliCount && m_SelectionPools[BG_TEAM_ALLIANCE].AddGroup((*Ali_itr), (aliFree >= diffHorde) ? aliFree - diffHorde : 0); aliIndex++)
                    ++Ali_itr;
            }
            //if ali selection is already empty, then kick horde group, but if there are less horde than ali in bg - break;
            if (!m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount())
            {
                if (aliFree <= diffHorde + 1)
                    break;
                m_SelectionPools[BG_TEAM_HORDE].KickGroup(diffHorde - diffAli);
            }
        }
        else
        {
            //kick horde group, add to pool new group if needed
            if (m_SelectionPools[BG_TEAM_HORDE].KickGroup(diffAli - diffHorde))
            {
                for (; hordeIndex < hordeCount && m_SelectionPools[BG_TEAM_HORDE].AddGroup((*Horde_itr), (hordeFree >= diffAli) ? hordeFree - diffAli : 0); hordeIndex++)
                    ++Horde_itr;
            }
            if (!m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount())
            {
                if (hordeFree <= diffAli + 1)
                    break;
                m_SelectionPools[BG_TEAM_ALLIANCE].KickGroup(diffAli - diffHorde);
            }
        }
        //count diffs after small update
        diffAli   = aliFree   - int32(m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount());
        diffHorde = hordeFree - int32(m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount());
    }
}

// this method checks if premade versus premade battleground is possible
// then after 30 mins (default) in queue it moves premade group to normal queue
// it tries to invite as much players as it can - to MaxPlayersPerTeam, because premade groups have more than MinPlayersPerTeam players
bool BattlegroundQueue::CheckPremadeMatch(BattlegroundBracketId bracket_id, uint32 MinPlayersPerTeam, uint32 MaxPlayersPerTeam)
{
    //check match
    if (!m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].empty() && !m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].empty())
    {
        //start premade match
        //if groups aren't invited
        GroupsQueueType::const_iterator ali_group, horde_group;
        for (ali_group = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].begin(); ali_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].end(); ++ali_group)
            if (!(*ali_group)->IsInvitedToBGInstanceGUID)
                break;
        for (horde_group = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].begin(); horde_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].end(); ++horde_group)
            if (!(*horde_group)->IsInvitedToBGInstanceGUID)
                break;

        if (ali_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].end() && horde_group != m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].end())
        {
            m_SelectionPools[BG_TEAM_ALLIANCE].AddGroup((*ali_group), MaxPlayersPerTeam);
            m_SelectionPools[BG_TEAM_HORDE].AddGroup((*horde_group), MaxPlayersPerTeam);
            //add groups/players from normal queue to size of bigger group
            uint32 maxPlayers = std::min(m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount(), m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount());
            GroupsQueueType::const_iterator itr;
            for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
            {
                for (itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].begin(); itr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].end(); ++itr)
                {
                    //if itr can join BG and player count is less that maxPlayers, then add group to selectionpool
                    if (!(*itr)->IsInvitedToBGInstanceGUID && !m_SelectionPools[i].AddGroup((*itr), maxPlayers))
                        break;
                }
            }
            //premade selection pools are set
            return true;
        }
    }
    // now check if we can move group from Premade queue to normal queue (timer has expired) or group size lowered!!
    // this could be 2 cycles but i'm checking only first team in queue - it can cause problem -
    // if first is invited to BG and seconds timer expired, but we can ignore it, because players have only 80 seconds to click to enter bg
    // and when they click or after 80 seconds the queue info is removed from queue
    uint32 time_before = getMSTime() - sWorld->getIntConfig(CONFIG_BATTLEGROUND_PREMADE_GROUP_WAIT_FOR_MATCH);
    for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
    {
        if (!m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].empty())
        {
            GroupsQueueType::iterator itr = m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].begin();
            if (!(*itr)->IsInvitedToBGInstanceGUID && ((*itr)->JoinTime < time_before || (*itr)->Players.size() < MinPlayersPerTeam))
            {
                //we must insert group to normal queue and erase pointer from premade queue
                m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].push_front((*itr));
                m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE + i].erase(itr);
            }
        }
    }
    //selection pools are not set
    return false;
}

// this method tries to create battleground or arena with MinPlayersPerTeam against MinPlayersPerTeam
// this function is now used only for arena
bool BattlegroundQueue::CheckNormalMatch(Battleground* bg_template, BattlegroundBracketId bracket_id, uint32 minPlayers, uint32 maxPlayers)
{
    GroupsQueueType::const_iterator itr_team[BG_TEAMS_COUNT];
    for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
    {
        itr_team[i] = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].begin();
        for (; itr_team[i] != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + i].end(); ++(itr_team[i]))
        {
            if (!(*(itr_team[i]))->IsInvitedToBGInstanceGUID)
            {
                // BGINTER : ajouter a la bonne faction
                m_SelectionPools[i].AddGroup(*(itr_team[i]), maxPlayers);
                if (m_SelectionPools[i].GetPlayerCount() >= minPlayers)
                    break;
            }
        }
    }
    //try to invite same number of players - this cycle may cause longer wait time even if there are enough players in queue, but we want ballanced bg
    uint32 j = BG_TEAM_ALLIANCE;
    if (m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount() < m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount())
        j = BG_TEAM_HORDE;
    if (sWorld->getIntConfig(CONFIG_BATTLEGROUND_INVITATION_TYPE) != 0
        && m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount() >= minPlayers && m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount() >= minPlayers)
    {
        //we will try to invite more groups to team with less players indexed by j
        ++(itr_team[j]);                                         //this will not cause a crash, because for cycle above reached break;
        for (; itr_team[j] != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + j].end(); ++(itr_team[j]))
        {
            if (!(*(itr_team[j]))->IsInvitedToBGInstanceGUID)
                if (!m_SelectionPools[j].AddGroup(*(itr_team[j]), m_SelectionPools[(j + 1) % BG_TEAMS_COUNT].GetPlayerCount()))
                    break;
        }
        // do not allow to start bg with more than 2 players more on 1 faction
        if (abs((int32)(m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount() - m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount())) > 2)
            return false;
    }
    //allow 1v0 if debug bg
    if (sBattlegroundMgr->isTesting() && bg_template->isBattleground() && (m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount() || m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount()))
        return true;
    //return true if there are enough players in selection pools - enable to work .debug bg command correctly
    return m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount() >= minPlayers && m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount() >= minPlayers;
}

// this method will check if we can invite players to same faction skirmish match
bool BattlegroundQueue::CheckSkirmishForSameFaction(BattlegroundBracketId bracket_id, uint32 minPlayersPerTeam)
{
    if (m_SelectionPools[BG_TEAM_ALLIANCE].GetPlayerCount() < minPlayersPerTeam && m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount() < minPlayersPerTeam)
        return false;
    uint32 teamIndex = BG_TEAM_ALLIANCE;
    uint32 otherTeam = BG_TEAM_HORDE;
    uint32 otherTeamId = HORDE;
    if (m_SelectionPools[BG_TEAM_HORDE].GetPlayerCount() == minPlayersPerTeam)
    {
        teamIndex = BG_TEAM_HORDE;
        otherTeam = BG_TEAM_ALLIANCE;
        otherTeamId = ALLIANCE;
    }
    //clear other team's selection
    m_SelectionPools[otherTeam].Init();
    //store last ginfo pointer
    GroupQueueInfo* ginfo = m_SelectionPools[teamIndex].SelectedGroups.back();
    //set itr_team to group that was added to selection pool latest
    GroupsQueueType::iterator itr_team = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + teamIndex].begin();
    for (; itr_team != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + teamIndex].end(); ++itr_team)
        if (ginfo == *itr_team)
            break;
    if (itr_team == m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + teamIndex].end())
        return false;
    GroupsQueueType::iterator itr_team2 = itr_team;
    ++itr_team2;
    //invite players to other selection pool
    for (; itr_team2 != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + teamIndex].end(); ++itr_team2)
    {
        //if selection pool is full then break;
        if (!(*itr_team2)->IsInvitedToBGInstanceGUID && !m_SelectionPools[otherTeam].AddGroup(*itr_team2, minPlayersPerTeam))
            break;
    }
    if (m_SelectionPools[otherTeam].GetPlayerCount() != minPlayersPerTeam)
        return false;

    //here we have correct 2 selections and we need to change one teams team and move selection pool teams to other team's queue
    for (GroupsQueueType::iterator itr = m_SelectionPools[otherTeam].SelectedGroups.begin(); itr != m_SelectionPools[otherTeam].SelectedGroups.end(); ++itr)
    {
        //set correct team
        (*itr)->Team = otherTeamId;
        //add team to other queue
        m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + otherTeam].push_front(*itr);
        //remove team from old queue
        GroupsQueueType::iterator itr2 = itr_team;
        ++itr2;
        for (; itr2 != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + teamIndex].end(); ++itr2)
        {
            if (*itr2 == *itr)
            {
                m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE + teamIndex].erase(itr2);
                break;
            }
        }
    }
    return true;
}

void BattlegroundQueue::UpdateEvents(uint32 diff)
{
    m_events.Update(diff);
}

void BattlegroundQueue::IncreaseTeamMMrRange(GroupQueueInfo* ginfo)
{
    if (ginfo->ratingRangeIncreaseCounter > 0)
    {
        ginfo->ratingRange += 100;
        uint32 completeRange = sBattlegroundMgr->GetMaxRatingDifference() + ginfo->ratingRange;
        for (std::map<uint64, PlayerQueueInfo*>::iterator itr = ginfo->Players.begin(); itr != ginfo->Players.end(); ++itr)
        {
            uint32 minRating = std::max(0, int32(ginfo->ArenaMatchmakerRating - completeRange));
            uint32 maxRating = std::min(int32(ginfo->ArenaMatchmakerRating + completeRange), 4000);
            if (Player* plr = sObjectAccessor->FindPlayer(itr->first))
                ChatHandler(plr->GetSession()).PSendSysMessage("Le systeme de Matchmaking va maintenant essayer de trouver des adversaires entre %i et %i de MMR.", minRating, maxRating);
        }
    }
    ginfo->ratingRangeIncreaseCounter += 1;
}

struct GroupSet {
    GroupSet(GroupQueueInfo *_gq, bool _xfaction) : gq(_gq), xfaction(_xfaction) { next = NULL; };
    GroupQueueInfo *gq;
    bool xfaction;
    GroupSet *next;
};

struct TabCell {
    // bool indicates if group is crossfaction
    TabCell() : xfcount(0), gs(NULL) { };
    GroupSet *gs;
    uint8 xfcount; // penalty due to crossfaction player count
};


/*
 * Default objective function for balanced BG groups optimization.
 *
 * List of optimization criteria (in decreasing priority)
 * criteria 1: keep the difference between alliance/horde players below 2, if it is not possible, keep the difference as small as possible
 * criteria 2: maximize the number of invited players
 *
 */

struct ObjectiveFunction {
    enum Scores {
        BEST_SCORE = 0,
        WORST_SCORE = 0xFFFFFFFF,
    };
    int32 _current;
    uint32 _width;
    ObjectiveFunction(int32 current, uint32 width) : _current(current), _width(width) { };

    uint32 operator()(uint32 a2, uint32 h2) {
      uint32 score = 0;
      uint32 balance_penalty = 0;
      int32 balance = (a2 - h2) + _current;
      if (abs(balance) > _width) {
          // add penalty for imbalanced BG
          balance_penalty = abs(balance) << 8;
      }
      score |= balance_penalty;
      score |= (256 - (a2 + h2));
      return (score);
    }
};


/*
 * Objective function handling crossfaction BGs. Added criteria :
 * criteria 3: minimize the number of cross-faction players
 */
struct XFObjectiveFunction : ObjectiveFunction {
    XFObjectiveFunction(int32 current, uint32 width) : ObjectiveFunction(current, width) { };
    uint32 operator()(TabCell &cell, uint32 a2, uint32 h2) {
        if (!cell.gs)
            return ObjectiveFunction::WORST_SCORE;
        return (ObjectiveFunction::operator()(a2, h2) << 8) | cell.xfcount;
    }
};

struct SmartDeleter {
    std::list<GroupSet*> l;
    ~SmartDeleter() {
        for (std::list<GroupSet*>::iterator itr = l.begin(); itr != l.end(); itr++) {
            GroupSet *gs = *itr;
            delete gs;
        }
    };
};

int BattlegroundQueue::SelectGroups(BattlegroundBracketId bracket_id, int32 current_balance, int32 a2_min, int32 h2_min, int32 a2_max, int32 h2_max) {
    SmartDeleter sd;

    sLog->outString("[%d] SelectGroups current_balance=%d a2min=%d h2min=%d a2max=%d h2max=%d", bracket_id, current_balance, a2_min, h2_min, a2_max, h2_max);
    int group_count = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].size() + m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].size();
    std::vector<std::vector<TabCell> > array(a2_max + 1 , std::vector<TabCell>(h2_max + 1));

    int32 players_in_queue = 0;

    bool quit = false;
    for (int8 q = BG_QUEUE_NORMAL_ALLIANCE; (q <= BG_QUEUE_NORMAL_HORDE) && !quit; q++) {
        for (GroupsQueueType::const_iterator itr = m_QueuedGroups[bracket_id][q].begin(); (itr != m_QueuedGroups[bracket_id][q].end()) && !quit; itr++) {
            GroupQueueInfo *gq = (*itr);
            if (!gq->IsInvitedToBGInstanceGUID) {
                players_in_queue += gq->Players.size();
                if (players_in_queue >= std::max(a2_max, h2_max))
                    quit = true;
            }
        }
    }

    if (players_in_queue == 0)
        return -1; // whaAAT?

    int32 a2_size = std::min(a2_max, players_in_queue);
    int32 h2_size = std::min(h2_max, players_in_queue);
    /*
     * Find group set with best (lowest) objective function score
     */
    XFObjectiveFunction obj(current_balance, DynConfigMgr::getValue(DynConfigMgr::CONFIG_BG_BALANCE));
    TabCell bestCell;
    uint32 obj_bestcell = ObjectiveFunction::WORST_SCORE;
    uint32 start = getMSTime();
    for (int8 q = BG_QUEUE_NORMAL_ALLIANCE; (q <= BG_QUEUE_NORMAL_HORDE); q++) {
        for (GroupsQueueType::const_iterator itr = m_QueuedGroups[bracket_id][q].begin(); (itr != m_QueuedGroups[bracket_id][q].end()); itr++) {
            GroupQueueInfo *gq = (*itr);
            if (!gq->IsInvitedToBGInstanceGUID) {
                for (int i = a2_size; i >= 0; i--) {
                    for (int j = h2_size; j >= 0; j--) {
                        bool xfaction_allowed = (DynConfigMgr::getValue(DynConfigMgr::CONFIG_BG_INTERFACTION) == 1) && (gq->xfaction_allowed);
                        for (int xfaction = 0; xfaction < (xfaction_allowed ? 2 : 1); xfaction++) {
                            int i2 = i;
                            int j2 = j;
                            if ((gq->Team == ALLIANCE) == (xfaction == 0)) {
                                i2 += gq->Players.size();
                            } else {
                                j2 += gq->Players.size();
                            }
                            if ((i2 <= a2_size) && (j2 <= h2_size)) {
                                TabCell newCell;
                                if ((i > 0) || (j > 0))
                                    newCell.gs = array[i][j].gs;
                                if (newCell.gs || ((i == 0) && (j == 0))) {
                                    GroupSet *new_gs = new GroupSet(gq, bool(xfaction));
                                    sd.l.push_back(new_gs);
                                    new_gs->next = newCell.gs;
                                    newCell.gs = new_gs;
                                    newCell.xfcount += bool(xfaction) ? gq->Players.size() : 0;
                                    uint32 obj_newcell = obj(newCell, i2, j2);
                                    if (obj(array[i2][j2], i2, j2) > obj_newcell) {
                                        array[i2][j2] = newCell;
                                        if (obj_bestcell > obj_newcell) {
                                            bestCell = newCell;
                                            obj_bestcell = obj_newcell;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    sLog->outString("SelectGroups() took %u ms", getMSTime() - start);

    if (obj_bestcell == ObjectiveFunction::WORST_SCORE) {
        sLog->outString("[%d] Can't find any suitable groupset", bracket_id);
        return -1; // couldn't find any acceptable group set
    }

	// Check if we have enough players
	int alliance_total = 0, horde_total = 0;
	for (GroupSet *gs = bestCell.gs; gs != NULL; gs = gs->next) {
		GroupQueueInfo *gq = gs->gq;
		if ((gq->Team == ALLIANCE) != gs->xfaction) {
			alliance_total += gq->Players.size();
		} else {
			horde_total += gq->Players.size();
		}
	}
	if ((a2_min > alliance_total) || (h2_min > horde_total)) {
		sLog->outString("[%d] Best set contains a2=%d h2=%d but a2min=%d and h2min=%d", bracket_id, alliance_total, horde_total, a2_min, h2_min);
		return -1; // not enough players
	}

    // if BG was unbalanced, ensure that new balance is better than the old one
    uint32 new_imbalance = (obj_bestcell >> 16);
    if ((abs(current_balance) > DynConfigMgr::getValue(DynConfigMgr::CONFIG_BG_BALANCE)) && (new_imbalance >= abs(current_balance))) {
        sLog->outString("[%d] Best set has |balance| = %d but current balance is %d", bracket_id, new_imbalance, current_balance);
        return -1; // new BG balance would be worse (or the same)
    }

    // if BG was balanced, ensure that new balance is within acceptable bounds
    if ((abs(current_balance) <= DynConfigMgr::getValue(DynConfigMgr::CONFIG_BG_BALANCE)) && new_imbalance) {
        sLog->outString("[%d] Best set has balance %d and current balance is %d", bracket_id, new_imbalance, current_balance);
        return -1; // new BG balance out of bounds
    }

    // all checks passed: add players to selection pool
    for (GroupSet *gs = bestCell.gs; gs != NULL; gs = gs->next) {
        GroupQueueInfo *gq = gs->gq;
        gq->xfaction = gs->xfaction; // Player is flagged as crossfaction and invited to BG. Actual faction change will occur when he accepts the invitation.
        bool alliance = (gq->Team == ALLIANCE) != gq->xfaction;
        gq->Team = alliance ? ALLIANCE : HORDE;
        sLog->outString("[%d] Inviting group size %d faction %s (crossfaction : %s)", bracket_id, gq->Players.size(), alliance ? "alliance" : "horde", gq->xfaction ? "yes" : "no");
        if (m_SelectionPools[alliance ? BG_TEAM_ALLIANCE : BG_TEAM_HORDE].AddGroup(gq, alliance ? a2_max : h2_max) == false) {
            sLog->outString("BattlegroundQueue::SelectGroups(): AddedGroup() returned false. This should not happen (abort BG group selection).");
            return -1;
        }
    }
    return std::min(alliance_total, horde_total);
}


/*
this method is called when group is inserted, or player / group is removed from BG Queue - there is only one player's status changed, so we don't use while (true) cycles to invite whole queue
it must be called after fully adding the members of a group to ensure group joining
should be called from Battleground::RemovePlayer function in some cases
*/
void BattlegroundQueue::BattlegroundQueueUpdate(uint32 /*diff*/, BattlegroundTypeId bgTypeId, BattlegroundBracketId bracket_id, uint8 arenaType, bool isRated, uint32 arenaRating)
{
    //if no players in queue - do nothing
    if (m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].empty() &&
        m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].empty() &&
        m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].empty() &&
        m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].empty())
        return;


    sLog->outString("NEed to update queue for bracket %d", bracket_id);
    //battleground with free slot for player should be always in the beggining of the queue
    // maybe it would be better to create bgfreeslotqueue for each bracket_id
    bool can_create_bg = true;
    uint32 aliMinGroup = 41;
    uint32 hordeMinGroup = 41;

    for (GroupsQueueType::const_iterator itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].begin(); itr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_ALLIANCE].end(); itr++) {
        GroupQueueInfo *gq = (*itr);
        if (gq->Players.size() < aliMinGroup)
            aliMinGroup = gq->Players.size();
    }

    for (GroupsQueueType::const_iterator itr = m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].begin(); itr != m_QueuedGroups[bracket_id][BG_QUEUE_NORMAL_HORDE].end(); itr++) {
        GroupQueueInfo *gq = (*itr);
        if (gq->Players.size() < hordeMinGroup)
            hordeMinGroup = gq->Players.size();
    }

    BGFreeSlotQueueType::iterator itr, next;
    for (itr = sBattlegroundMgr->BGFreeSlotQueue[bgTypeId].begin(); itr != sBattlegroundMgr->BGFreeSlotQueue[bgTypeId].end(); itr = next)
    {
        next = itr;
        ++next;
        // DO NOT allow queue manager to invite new player to arena
        if ((*itr)->isBattleground() && (*itr)->GetTypeID() == bgTypeId && (*itr)->GetBracketId() == bracket_id &&
            (*itr)->GetStatus() > STATUS_WAIT_QUEUE && (*itr)->GetStatus() < STATUS_WAIT_LEAVE)
        {
            Battleground* bg = *itr; //we have to store battleground pointer here, because when battleground is full, it is removed from free queue (not yet implemented!!)
            // and iterator is invalid
			sLog->outString("Looking in existing bg: %s freeSlots(alliance)=%d freeSlots(horde)=%d", bg->GetName(), bg->GetFreeSlotsForTeam(ALLIANCE), bg->GetFreeSlotsForTeam(HORDE));

            if ((aliMinGroup < bg->GetFreeSlotsForTeam(ALLIANCE)) || (hordeMinGroup < bg->GetFreeSlotsForTeam(HORDE))) {
                /*
                 * If we execute this, it means that it exists players/groups that could fit in an existing BG, but cannot
                 * enter due to alliance/horde ratio issues.
                 * In this case, if CONFIG_ALLOW_NON_FULL_BG is 1, we allow these players to form a new BG (resulting in shorter
                 * wait time, but potentially multiple non-full BGs).
                 * If CONFIG_ALLOW_NON_FULL_BG is 0, we do not allow the players to form a new BG. It leads to longer wait time,
                 * but we make sure that no new BG will be created if queued players can fit in an existing BG.
                 */
                if (DynConfigMgr::getValue(DynConfigMgr::CONFIG_ALLOW_NON_FULL_BG) == 0) {
                    can_create_bg = false;
                    sLog->outString("[%d] Disallow BG creation because existing BGs are not full (per configuration)", bracket_id);
                }

            }

            // clear selection pools
            m_SelectionPools[BG_TEAM_ALLIANCE].Init();
            m_SelectionPools[BG_TEAM_HORDE].Init();

            // call a function that does the job for us
            // FillPlayersToBG(bg, bracket_id);
            int current_balance = bg->GetPlayersCountByTeam(ALLIANCE) - bg->GetPlayersCountByTeam(HORDE);
            int sel = SelectGroups(bracket_id, current_balance, 0, 0, bg->GetFreeSlotsForTeam(ALLIANCE), bg->GetFreeSlotsForTeam(HORDE));
            if (sel == -1)
                sLog->outString("[%d] Failed to fill existing BG : %s", bracket_id, bg->GetName());

            // now everything is set, invite players
            for (GroupsQueueType::const_iterator citr = m_SelectionPools[BG_TEAM_ALLIANCE].SelectedGroups.begin(); citr != m_SelectionPools[BG_TEAM_ALLIANCE].SelectedGroups.end(); ++citr)
                InviteGroupToBG((*citr), bg, (*citr)->Team);
            for (GroupsQueueType::const_iterator citr = m_SelectionPools[BG_TEAM_HORDE].SelectedGroups.begin(); citr != m_SelectionPools[BG_TEAM_HORDE].SelectedGroups.end(); ++citr)
                InviteGroupToBG((*citr), bg, (*citr)->Team);

            if (!bg->HasFreeSlots())
            {
                // remove BG from BGFreeSlotQueue
                bg->RemoveFromBGFreeSlotQueue();
            }
        }
    }

    // finished iterating through the bgs with free slots, maybe we need to create a new bg

    Battleground* bg_template = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);
    if (!bg_template)
    {
        sLog->outError("Battleground: Update: bg template not found for %u", bgTypeId);
        return;
    }

    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketById(bg_template->GetMapId(), bracket_id);
    if (!bracketEntry)
    {
        sLog->outError("Battleground: Update: bg bracket entry not found for map %u bracket id %u", bg_template->GetMapId(), bracket_id);
        return;
    }

    // get the min. players per team, properly for larger arenas as well. (must have full teams for arena matches!)
    uint32 MinPlayersPerTeam = bg_template->GetMinPlayersPerTeam();
    uint32 MaxPlayersPerTeam = bg_template->GetMaxPlayersPerTeam();
    if (sBattlegroundMgr->isTesting())
        MinPlayersPerTeam = 1;
    if (bg_template->isArena())
    {
        if (sBattlegroundMgr->isArenaTesting())
        {
            MaxPlayersPerTeam = 1;
            MinPlayersPerTeam = 1;
        }
        else
        {
            //this switch can be much shorter
            MaxPlayersPerTeam = arenaType;
            MinPlayersPerTeam = arenaType;
            /*switch (arenaType)
            {
            case ARENA_TYPE_2v2:
                MaxPlayersPerTeam = 2;
                MinPlayersPerTeam = 2;
                break;
            case ARENA_TYPE_3v3:
                MaxPlayersPerTeam = 3;
                MinPlayersPerTeam = 3;
                break;
            case ARENA_TYPE_5v5:
                MaxPlayersPerTeam = 5;
                MinPlayersPerTeam = 5;
                break;
            }*/
        }
    }

    m_SelectionPools[BG_TEAM_ALLIANCE].Init();
    m_SelectionPools[BG_TEAM_HORDE].Init();

    if (bg_template->isBattleground())
    {
        //check if there is premade against premade match
        if (CheckPremadeMatch(bracket_id, MinPlayersPerTeam, MaxPlayersPerTeam))
        {
            //create new battleground
            Battleground* bg2 = sBattlegroundMgr->CreateNewBattleground(bgTypeId, bracketEntry, 0, false);
            if (!bg2)
            {
                sLog->outError("BattlegroundQueue::Update - Cannot create battleground: %u", bgTypeId);
                return;
            }
            //invite those selection pools
            for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
                for (GroupsQueueType::const_iterator citr = m_SelectionPools[BG_TEAM_ALLIANCE + i].SelectedGroups.begin(); citr != m_SelectionPools[BG_TEAM_ALLIANCE + i].SelectedGroups.end(); ++citr)
                    InviteGroupToBG((*citr), bg2, (*citr)->Team);
            //start bg
            bg2->StartBattleground();
            //clear structures
            m_SelectionPools[BG_TEAM_ALLIANCE].Init();
            m_SelectionPools[BG_TEAM_HORDE].Init();
        }
    }

    // now check if there are in queues enough players to start new game of (normal battleground, or non-rated arena)
    if (!isRated)
    {
        int playersPerTeam = 0;
        bool create = false;
        if (bg_template->isArena()) { // non-rated arena only (rated arena handled elsewere)
            create = CheckNormalMatch(bg_template, bracket_id, MinPlayersPerTeam, MaxPlayersPerTeam) || CheckSkirmishForSameFaction(bracket_id, MinPlayersPerTeam);
        } else { // BG
            //MinPlayersPerTeam = 1; // TEST (TODO: remove)
            if (can_create_bg) {
                sLog->outString("[%d] Attempting to create battleground", bracket_id);
                playersPerTeam = SelectGroups(bracket_id, 0, MinPlayersPerTeam, MinPlayersPerTeam, MaxPlayersPerTeam, MaxPlayersPerTeam);
                create = (playersPerTeam != -1);
                if (!create)
                    sLog->outString("[%d] Failed to create BG : %s", bracket_id, bg_template->GetName());
            }
        }

        // if there are enough players in pools, start new battleground or non rated arena
        if (create)
        {
            // we successfully created a pool
            Battleground* bg2 = sBattlegroundMgr->CreateNewBattleground(bgTypeId, bracketEntry, arenaType, false, playersPerTeam);
            if (!bg2)
            {
                sLog->outError("BattlegroundQueue::Update - Cannot create battleground: %u", bgTypeId);
                return;
            }

            // invite those selection pools
            for (uint32 i = 0; i < BG_TEAMS_COUNT; i++)
                for (GroupsQueueType::const_iterator citr = m_SelectionPools[BG_TEAM_ALLIANCE + i].SelectedGroups.begin(); citr != m_SelectionPools[BG_TEAM_ALLIANCE + i].SelectedGroups.end(); ++citr)
                    InviteGroupToBG((*citr), bg2, (*citr)->Team);
            // start bg
            bg2->StartBattleground();
        }
    }
    else if (bg_template->isArena())
    {
        // Check if Queues are empty
        if (m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].empty() && m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].empty())
            return;

        // found out the minimum and maximum ratings the newly added team should battle against
        // arenaRating is the rating of the latest joined team, or 0
        // 0 is on (automatic update call) and we must set it to team's with longest wait time
        if (!arenaRating)
        {
            for (uint8 queueGroupType = BG_QUEUE_PREMADE_ALLIANCE; queueGroupType < BG_QUEUE_NORMAL_ALLIANCE; queueGroupType++)
            {
                GroupsQueueType::iterator citr = m_QueuedGroups[bracket_id][queueGroupType].begin();
                while (citr != m_QueuedGroups[bracket_id][queueGroupType].end())
                {
                    GroupQueueInfo* front1 = *citr;
                    if (front1->IsInvitedToBGInstanceGUID)
                    {
                        citr++;
                        continue;
                    }

                    if (getMSTimeDiff(front1->JoinTime, getMSTime()) > (30 * IN_MILLISECONDS * (front1->ratingRangeIncreaseCounter + 1)))
                        IncreaseTeamMMrRange(front1);

                    arenaRating = front1->ArenaMatchmakerRating;
                    //set rating range
                    uint32 arenaMinRating = (arenaRating <= sBattlegroundMgr->GetMaxRatingDifference()) ? 0 : arenaRating - sBattlegroundMgr->GetMaxRatingDifference();
                    arenaMinRating = std::max(0, int32(arenaMinRating - front1->ratingRange));
                    uint32 arenaMaxRating = arenaRating + sBattlegroundMgr->GetMaxRatingDifference();
                    arenaMaxRating = std::min(int32(arenaMaxRating + front1->ratingRange), 4000);
                    // if max rating difference is set and the time past since server startup is greater than the rating discard time
                    // (after what time the ratings aren't taken into account when making teams) then
                    // the discard time is current_time - time_to_discard, teams that joined after that, will have their ratings taken into account
                    // else leave the discard time on 0, this way all ratings will be discarded
                    //                    uint32 discardTime = getMSTime() - sBattlegroundMgr->GetRatingDiscardTimer();

                    // we need to find 2 teams which will play next game
                    GroupsQueueType::iterator itr_teams[BG_TEAMS_COUNT];
                    uint8 found = 0;
                    itr_teams[found++] = citr;
                    citr++;


                    for (uint8 i = BG_QUEUE_PREMADE_ALLIANCE; i < BG_QUEUE_NORMAL_ALLIANCE && found < 2; i++)
                    {
                        // take the group that joined first
                        GroupsQueueType::iterator itr2 = m_QueuedGroups[bracket_id][i].begin();
                        for (; itr2 != m_QueuedGroups[bracket_id][i].end(); ++itr2)
                        {
                            // if group match conditions, then add it to pool
                            if (!(*itr2)->IsInvitedToBGInstanceGUID
                                && (((*itr2)->ArenaMatchmakerRating >= arenaMinRating && (*itr2)->ArenaMatchmakerRating <= arenaMaxRating))
                                && (*itr_teams[0])->ArenaTeamId != (*itr2)->ArenaTeamId)
                            {
                                itr_teams[found++] = itr2;
                                break;
                            }
                        }
                    }

                    //if we have 2 teams, then start new arena and invite players!
                    if (found == 2)
                    {
                        GroupQueueInfo* aTeam = *itr_teams[TEAM_ALLIANCE];
                        GroupQueueInfo* hTeam = *itr_teams[TEAM_HORDE];
                        if (citr != m_QueuedGroups[bracket_id][queueGroupType].end() && itr_teams[TEAM_HORDE] == citr)
                            citr++;

                        Battleground* arena = sBattlegroundMgr->CreateNewBattleground(bgTypeId, bracketEntry, arenaType, true);
                        if (!arena)
                        {
                            sLog->outError("BattlegroundQueue::Update couldn't create arena instance for rated arena match!");
                            return;
                        }

                        aTeam->OpponentsTeamRating = hTeam->ArenaTeamRating;
                        hTeam->OpponentsTeamRating = aTeam->ArenaTeamRating;
                        aTeam->OpponentsMatchmakerRating = hTeam->ArenaMatchmakerRating;
                        hTeam->OpponentsMatchmakerRating = aTeam->ArenaMatchmakerRating;
                        sLog->outDebug(LOG_FILTER_BATTLEGROUND, "setting oposite teamrating for team %u to %u", aTeam->ArenaTeamId, aTeam->OpponentsTeamRating);
                        sLog->outDebug(LOG_FILTER_BATTLEGROUND, "setting oposite teamrating for team %u to %u", hTeam->ArenaTeamId, hTeam->OpponentsTeamRating);

                        // now we must move team if we changed its faction to another faction queue, because then we will spam log by errors in Queue::RemovePlayer
                        if (aTeam->Team != ALLIANCE)
                        {
                            m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].push_front(aTeam);
                            m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].erase(itr_teams[TEAM_ALLIANCE]);
                        }
                        if (hTeam->Team != HORDE)
                        {
                            m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_HORDE].push_front(hTeam);
                            m_QueuedGroups[bracket_id][BG_QUEUE_PREMADE_ALLIANCE].erase(itr_teams[TEAM_HORDE]);
                        }

                        // Mark arena as solo queue arena for EndBattleground handling
                        if (arenaType == ARENA_TYPE_3v3_SOLO)
                            arena->SetIsSoloQueueArena(true);

                        arena->SetArenaMatchmakerRating(ALLIANCE, aTeam->ArenaMatchmakerRating);
                        arena->SetArenaMatchmakerRating(   HORDE, hTeam->ArenaMatchmakerRating);
                        InviteGroupToBG(aTeam, arena, ALLIANCE);
                        InviteGroupToBG(hTeam, arena, HORDE);

                        sLog->outDebug(LOG_FILTER_BATTLEGROUND, "Starting rated arena match!");
                        arena->StartBattleground();
                    }
                }
            }
        }
    }
}

/*********************************************************/
/***            BATTLEGROUND QUEUE EVENTS              ***/
/*********************************************************/

bool BGQueueInviteEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    Player* player = ObjectAccessor::FindPlayer(m_PlayerGuid);
    // player logged off (we should do nothing, he is correctly removed from queue in another procedure)
    if (!player)
        return true;

    Battleground* bg = sBattlegroundMgr->GetBattleground(m_BgInstanceGUID, m_BgTypeId);
    //if battleground ended and its instance deleted - do nothing
    if (!bg)
        return true;

    BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bg->GetTypeID(), bg->GetArenaType());
    uint32 queueSlot = player->GetBattlegroundQueueIndex(bgQueueTypeId);
    if (queueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES)         // player is in queue or in battleground
    {
        // check if player is invited to this bg
        BattlegroundQueue &bgQueue = sBattlegroundMgr->m_BattlegroundQueues[bgQueueTypeId];
        if (bgQueue.IsPlayerInvited(m_PlayerGuid, m_BgInstanceGUID, m_RemoveTime))
        {
            WorldPacket data;
            //we must send remaining time in queue
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_JOIN, INVITE_ACCEPT_WAIT_TIME - INVITATION_REMIND_TIME, 0, m_ArenaType);
            player->GetSession()->SendPacket(&data);
        }
    }
    return true;                                            //event will be deleted
}

void BGQueueInviteEvent::Abort(uint64 /*e_time*/)
{
    //do nothing
}

/*
    this event has many possibilities when it is executed:
    1. player is in battleground (he clicked enter on invitation window)
    2. player left battleground queue and he isn't there any more
    3. player left battleground queue and he joined it again and IsInvitedToBGInstanceGUID = 0
    4. player left queue and he joined again and he has been invited to same battleground again -> we should not remove him from queue yet
    5. player is invited to bg and he didn't choose what to do and timer expired - only in this condition we should call queue::RemovePlayer
    we must remove player in the 5. case even if battleground object doesn't exist!
*/
bool BGQueueRemoveEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    Player* player = ObjectAccessor::FindPlayer(m_PlayerGuid);
    if (!player)
        // player logged off (we should do nothing, he is correctly removed from queue in another procedure)
        return true;

    Battleground* bg = sBattlegroundMgr->GetBattleground(m_BgInstanceGUID, m_BgTypeId);
    //battleground can be deleted already when we are removing queue info
    //bg pointer can be NULL! so use it carefully!

    uint32 queueSlot = player->GetBattlegroundQueueIndex(m_BgQueueTypeId);
    if (queueSlot < PLAYER_MAX_BATTLEGROUND_QUEUES)         // player is in queue, or in Battleground
    {
        // check if player is in queue for this BG and if we are removing his invite event
        BattlegroundQueue &bgQueue = sBattlegroundMgr->m_BattlegroundQueues[m_BgQueueTypeId];
        if (bgQueue.IsPlayerInvited(m_PlayerGuid, m_BgInstanceGUID, m_RemoveTime))
        {
            sLog->outDebug(LOG_FILTER_BATTLEGROUND, "Battleground: removing player %u from bg queue for instance %u because of not pressing enter battle in time.", player->GetGUIDLow(), m_BgInstanceGUID);

            player->RemoveBattlegroundQueueId(m_BgQueueTypeId);
            bgQueue.RemovePlayer(m_PlayerGuid, true);
            //update queues if battleground isn't ended
            /*
            if (bg && bg->isBattleground() && bg->GetStatus() != STATUS_WAIT_LEAVE)
                sBattlegroundMgr->ScheduleQueueUpdate(0, 0, m_BgQueueTypeId, m_BgTypeId, bg->GetBracketId());
            */

            WorldPacket data;
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_NONE, 0, 0, 0);
            player->GetSession()->SendPacket(&data);
        }
    }

    //event will be deleted
    return true;
}

void BGQueueRemoveEvent::Abort(uint64 /*e_time*/)
{
    //do nothing
}

uint32 BattlegroundQueue::GetQueuedGroups() const
{
    Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
    if (!bg)
        return 0;

    PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), 80);
    if (!bracketEntry)
        return 0;

    BattlegroundBracketId bracketId = bracketEntry->GetBracketId();
    return m_QueuedGroups[bracketId][BG_QUEUE_PREMADE_ALLIANCE].size() + m_QueuedGroups[bracketId][BG_QUEUE_PREMADE_HORDE].size();
}
