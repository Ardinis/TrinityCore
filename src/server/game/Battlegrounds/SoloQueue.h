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

#ifndef SOLO_QUEUE_H
#define SOLO_QUEUE_H

enum SoloQueueTalentCategory
{
    TALENT_CAT_UNKNOWN  = 0,
    TALENT_CAT_RANGE    = 1,
    TALENT_CAT_HEALER   = 2,
    TALENT_CAT_MELEE    = 3
};

struct SoloQueueInfo                                                                // stores information about the group in queue (also used when joined as solo!)
{
    uint64  playerGuid;                                                             // player guid
    uint32  rating;                                                                 // Solo Team rating
    uint32  ArenaMatchmakerRating;                                                  // Player MMR
    uint32  teamId;                                                                 // Solo Arena Team Id
    uint32  ratingRange = 0;                                                        // Rating range for team forming
    uint32  ratingRangeIncreaseCounter = 0;                                         // Rating increase counter for team forming
    uint32  lastMmrUpdate = 0;                                                      // Rating update timer
    uint32  team;                                                                   // ALLIANCE or HORDE
    uint8   characterClass;                                                         // Used for class stacking option
};

#define sSoloQueueMgr SoloQueue::instance()

class SoloQueue
{
    public:
        SoloQueue();
        ~SoloQueue();
        void Update(uint32 diff);
        uint32 GetPlayerCountInQueue(SoloQueueTalentCategory talentCategory, bool allPlayers = false);
        void AddPlayer(Player* player, bool reQueue = false);
        void AddSoloQueueWaitTime(uint32 time);
        uint32 GetAverageSoloQueueWaitTime();
        bool RemovePlayer(uint64 guid);
        bool IsPlayerInSoloQueue(Player* player);
        bool CheckRequirements(Player* player);
        static SoloQueue* instance();
        void fetchQueueList();

        uint32 cache3v3Queue[4];
        uint32 lastFetchQueueList;

    private:
        void IncreasePlayerMMrRange(SoloQueueInfo* playerInfo);
        void FillGroup(std::list<SoloQueueInfo*>& playerList, uint32 minMMR, uint32 maxMMR, uint32 healMMR, bool melees, uint8 healerClass, int8 playerAmount = 1);
        static bool IsInMmrRange(uint32 min, uint32 max, uint32 mmr) { return mmr >= min && mmr <= max; };
        static uint8 GetPlayerTalentCategory(Player* player);
        typedef std::multimap<uint32 /*mmr*/, SoloQueueInfo*> MMRQueueStorageType;
        typedef std::map<uint64, SoloQueueInfo*> PlayerQueueStorageType;
        std::list<uint32> waitTimes;
        MMRQueueStorageType queuedHealers;
        MMRQueueStorageType queuedMelees;
        MMRQueueStorageType queuedRanges;
        PlayerQueueStorageType allPlayersInQueue;
        IntervalTimer updateTimer;
};

#endif
