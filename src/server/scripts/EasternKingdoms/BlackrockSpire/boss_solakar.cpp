#include "ScriptMgr.h"
#include "blackrock_spire.h"
#include "Player.h"

enum npc
{
    NPC_DRAKE           = 10161
};

class boss_solakar : public CreatureScript
{
public:
    boss_solakar() : CreatureScript("boss_solakar") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_solakarAI(creature);
    }

    struct boss_solakarAI : public BossAI
    {
        boss_solakarAI(Creature* creature) : BossAI(creature, NPC_SOLAKAR) {}

        void Reset()
        {
            _Reset();
        }

        void EnterCombat(Unit* /*victim*/)
        {
            events.ScheduleEvent(1, 3 * IN_MILLISECONDS);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!me->getVictim())
                return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case 1:
                    (me->SummonCreature(10161, 67.70f, -309.59f, 91.45f, 5.58f, TEMPSUMMON_DEAD_DESPAWN, 900000))->Attack(me->getVictim(), true);
                    events.ScheduleEvent(1, 8 * IN_MILLISECONDS);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_gob_solakar : public GameObjectScript
{
public:
    boss_gob_solakar() : GameObjectScript("boss_gob_solakar") { }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        go->SummonCreature(NPC_SOLAKAR, 67.70f, -309.59f, 91.45f, 5.58f, TEMPSUMMON_DEAD_DESPAWN, 900000);
        return false;
    }

};

void AddSC_boss_solakar()
{
    new boss_gob_solakar();
    new boss_solakar();
}
