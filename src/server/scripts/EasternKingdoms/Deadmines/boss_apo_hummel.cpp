#include "ScriptPCH.h"
#include "LFGMgr.h"

class boss_apo_hummel : public CreatureScript
{
    public:
        boss_apo_hummel() : CreatureScript("boss_apo_hummel") { }

        struct boss_apo_hummelAI : public ScriptedAI
        {
            boss_apo_hummelAI(Creature* c) : ScriptedAI(c)
            {
            }

            void JustDied(Unit* /*killer*/)
            {
                // TODO: unhack
                Map* map = me->GetMap();
                if (map && map->IsDungeon())
                {
                    Map::PlayerList const& players = map->GetPlayers();
                    if (!players.isEmpty())
                        for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
                            if (Player* player = i->getSource())
                                if (player->GetDistance(me) < 120.0f)
                                    sLFGMgr->RewardDungeonDoneFor(288, player);
                }
            }
		};

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_apo_hummelAI(creature);
        }
};

void AddSC_boss_apo_hummel()
{
    new boss_apo_hummel();
}