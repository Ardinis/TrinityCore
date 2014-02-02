#include "ScriptMgr.h"
#include "blackrock_spire.h"
#include "Player.h"

#define NEFA_WAVE_1"Excellent... Il semble que ces pitoyables petits insectes soient arrivés en temps et en heure pour nourrir ma légion. Bienvenue, mortels!"
#define NEFA_WAVE_1_B   "Qu'il ne reste pas une seule goutte de leur sang sur le sable de l'arčne, mes enfants. Faites festin de leur âme."
#define NEFA_WAVE_3     "Inconcevable !"
#define NEFA_WAVE_4     "Utilisez le souffle glaciale, imbéciles !"
#define NEFA_WAVE_5     "La Légion Main-Noire fera des accessoires de mode avec votre peau!"
#define NEFA_WAVE_6     "Imbécccccciles, tuez celui en robe!"
#define NEFA_WAVE_7     "Ne me forcez pas la main, enfants! J'utiliserai vos peaux pour doubler mes bottes."
#define NEFA_WAVE_8     "CELA NE PEUT ETRE! Rend, Occupez vous de ces insectes!"
#define NEFA_WAVE_8_B"Le chef ne fera de vous qu'une bouchée, mortels! Préparez-vous!"
#define NEFA_WAVE_8_C"Vous allez connaitre ma puissance!"
#define NEFA_DEAD_1"Les mortels sont tombés! Le nouvel âge de la Légion Rochenoire pointe ŕ l'horizon..."

#define REND_WAVE_5     "Je vous arracherai les membres et vous battrai avec jusqu'ŕ ce que vous rampiez ŕ mes pieds."
#define REND_WAVE_8"Avec plaisir..."

#define POPX      208.04f
#define POPY      -421.08f
#define POPZ      110.94f
#define POPO      3.11f

enum npc
{
    NPC_DRACONIDE         = 10447,
    NPC_WHELP             = 10442,
    NPC_BLACKHAND         = 10317
};

enum events
{
    EVENT_START_WAVE         = 1,
    EVENT_SAY_WAVE           = 2,
    EVENT_SAY_8_A            = 3,
    EVENT_SAY_8_B            = 4,
    EVENT_POP                = 5
};

class boss_victor_nefarius_stade : public CreatureScript
{
public:
    boss_victor_nefarius_stade() : CreatureScript("boss_victor_nefarius_stade") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_victor_nefarius_stadeAI (creature);
    }

    struct boss_victor_nefarius_stadeAI : public BossAI
    {
        boss_victor_nefarius_stadeAI(Creature* creature) : BossAI(creature, NPC_VICTOR_NEFARIUS)
        {
            start = false;
            interwave = false;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE);
            if (InstanceScript* instance = me->GetInstanceScript())
                instance->SetData(DATA_GYTH,NOT_STARTED);
        }

        uint64 nwave;
        uint64 start;
        bool interwave;
        Creature* Rend;
        Creature* Gyth;

        void Reset()
        {
            me->MonsterYell(NEFA_DEAD_1, 0,0);
            nwave = 0;
            start = false;
            interwave = false;
            if (Rend = me->FindNearestCreature(NPC_WARCHIEF_REND_BLACKHAND, 100.0f, true))
            {
                Rend->SetVisible(false);
                Rend->DespawnOrUnsummon(10);
            }
            if (Gyth = me->FindNearestCreature(NPC_GYTH, 100.0f, true))
            {
                Gyth->SetVisible(false);
                Gyth->DespawnOrUnsummon(10);
            }
            if (InstanceScript* instance = me->GetInstanceScript()) // porte de l'arene
                if (uint64 door = instance->GetData64(GO_GYTH_ENTRY_DOOR))
                    instance->DoUseDoorOrButton(door);
        }

        void EnterCombat(Unit* /*who*/)
        {
            start = true;
            nwave = 0;
            me->MonsterYell(NEFA_WAVE_1,0,0);
            if (InstanceScript* instance = me->GetInstanceScript()) // porte de l'arene
                if (uint64 door = instance->GetData64(GO_GYTH_ENTRY_DOOR))
                    instance->DoUseDoorOrButton(door);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who && who->GetTypeId() == TYPEID_PLAYER && who->GetDistance(me) < 40)
                if ((start == false) && (instance->GetData(DATA_GYTH) != DONE))
                    if (me->getFaction() != 35)
                        me->Attack(who, true);
        }

        void opendoor()
        {
            if (InstanceScript* instance = me->GetInstanceScript())
                if (uint64 door = instance->GetData64(GO_GYTH_COMBAT_DOOR))
                    instance->DoUseDoorOrButton(door);

            events.ScheduleEvent(EVENT_POP, 3* IN_MILLISECONDS);
        }

        void pop()
        {
            Creature* Spawned = NULL;
            Unit* target = NULL;

            Spawned = me->SummonCreature(NPC_DRACONIDE, POPX, POPY, POPZ, POPO, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
            target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true);
            if (target && Spawned)
                Spawned->Attack(target, true);

            Spawned = me->SummonCreature(NPC_WHELP, POPX, POPY, POPZ, POPO, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
            target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true);
            if (target && Spawned)
                Spawned->Attack(target, true);

            Spawned = me->SummonCreature(NPC_WHELP, POPX, POPY, POPZ, POPO, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
            target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true);
            if (target && Spawned)
                Spawned->Attack(target, true);

            Spawned = me->SummonCreature(NPC_WHELP, POPX, POPY, POPZ, POPO, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
            target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true);
            if (target && Spawned)
                Spawned->Attack(target, true);

            Spawned = me->SummonCreature(NPC_BLACKHAND, POPX, POPY, POPZ, POPO, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
            target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true);
            if (target && Spawned)
                Spawned->Attack(target, true);

            interwave = false;
        }

        void startwave() // pop de Gyth si vague 8 et ouverture porte.
        {
            Creature* Spawned = NULL;
            Unit* target = NULL;

            if (nwave == 8)
            {
                Creature* Rend;

                if (InstanceScript* instance = me->GetInstanceScript())
                    if (uint64 door = instance->GetData64(GO_GYTH_COMBAT_DOOR))
                        instance->DoUseDoorOrButton(door);

                if (Rend = me->FindNearestCreature(NPC_WARCHIEF_REND_BLACKHAND, 100.0f, true))
                    Rend->DespawnOrUnsummon(50);

                Spawned = me->SummonCreature(NPC_GYTH, POPX, POPY, POPZ, POPO, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1800000);
                target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true);
                if (target && Spawned)
                    Spawned->AI()->AttackStart(target);
            }
            else
                opendoor();
        }

        void SayingEmote() // texte relatifs auc vagues
        {
            switch(nwave)
            {
            case 1:
                me->MonsterYell(NEFA_WAVE_1_B, 0,0);
                break;
            case 3:
                me->MonsterYell(NEFA_WAVE_3, 0,0);
                break;
            case 4:
                me->MonsterYell(NEFA_WAVE_4, 0,0);
                break;
            case 5:
                me->MonsterYell(NEFA_WAVE_5, 0,0);
                break;
            case 6:
                me->MonsterYell(NEFA_WAVE_6, 0,0);
                break;
            case 7:
                me->MonsterYell(NEFA_WAVE_7, 0,0);
                break;
            case 8:
                me->MonsterYell(NEFA_WAVE_8, 0,0);
                me->MonsterYell(REND_WAVE_8, 0,0);
                events.ScheduleEvent(EVENT_SAY_8_A, 4 * IN_MILLISECONDS);
                break;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (!start)
                return;

            events.Update(diff);

            //si vague terminée ou pas commencée
            if ((!me->FindNearestCreature(NPC_WHELP, 150.0f, true)) && (!me->FindNearestCreature(NPC_DRACONIDE, 150.0f, true)) && (!me->FindNearestCreature(NPC_GYTH, 150.0f, true)) && (interwave == false))
            {
                nwave++;
                events.ScheduleEvent(EVENT_SAY_WAVE, 5 * IN_MILLISECONDS);
                interwave = true;
            }

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_SAY_WAVE: // texte relatif ŕ la vague
                    SayingEmote();
                    events.ScheduleEvent(EVENT_START_WAVE, 4 * IN_MILLISECONDS);
                    break;
                case EVENT_START_WAVE: //départ vague (ouverture porte)
                    startwave();
                    break;
                case EVENT_SAY_8_A:
                    me->MonsterYell(NEFA_WAVE_8_B, 0,0);
                    events.ScheduleEvent(EVENT_SAY_8_B, 3 * IN_MILLISECONDS);
                    break;
                case EVENT_SAY_8_B:
                    me->MonsterYell(NEFA_WAVE_8_C, 0,0);
                    break;
                case EVENT_POP: // suite de départ vague (pop des mobs)
                    pop();
                }
            }

        }
    };
};

void AddSC_boss_victor_nefarius_stade()
{
    new boss_victor_nefarius_stade();
}
