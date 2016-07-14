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

#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "BattlegroundQueue.h"
#include "Language.h"
#include "ScriptMgr.h"
#include "SoloQueue.h"

class npc_solo_queue : public CreatureScript
{
public:
    npc_solo_queue() : CreatureScript("npc_solo_queue")
    {
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        return player->SendSoloQueueGossip(creature);
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->OnSoloQueueGossip(creature, action);
        OnGossipHello(player, creature);
        return true;
    }
};

class RemovePlayerFromQueue : public PlayerScript
{
public:
    RemovePlayerFromQueue() : PlayerScript("RemovePlayerFromSoloQueue") { }

    void OnLogout(Player* player) override
    {
        sSoloQueueMgr->RemovePlayer(player->GetGUID());
    }

    void OnGossipSelect(Player* player, uint32 menu_id, uint32 /*sender*/, uint32 action) override
    {
        if (menu_id != MENU_ID_SOLO_QUEUE)
            return ;

        player->OnSoloQueueGossip(NULL, action);
        player->PlayerTalkClass->ClearMenus();
        player->SendSoloQueueGossip(NULL);
    }
};



void AddSC_npc_soloqueue()
{
    new npc_solo_queue();
    new RemovePlayerFromQueue();
}
