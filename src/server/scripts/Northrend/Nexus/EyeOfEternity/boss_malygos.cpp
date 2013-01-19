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

/* Script Data Start
SDName: Boss malygos
Script Data End */

// TO-DOs:
// Implement a better pathing for Malygos.
// Find sniffed spawn position for chest
// Implement a better way to disappear the gameobjects
// Implement achievements
// Remove hack that re-adds targets to the aggro list after they enter to a vehicle when it works as expected
// Improve whatever can be improved :)

#include "ScriptPCH.h"
#include "eye_of_eternity.h"
#include "ScriptedEscortAI.h"

enum Achievements
{
    ACHIEV_TIMED_START_EVENT                      = 20387,
};

enum Events
{
    // =========== PHASE ONE ===============
    EVENT_ARCANE_BREATH = 1,
    EVENT_ARCANE_STORM  = 2,
    EVENT_VORTEX        = 3,
    EVENT_POWER_SPARKS  = 4,

    // =========== PHASE TWO ===============
    EVENT_SURGE_POWER   = 5, // wowhead is wrong, Surge of Power is casted instead of Arcane Pulse (source sniffs!)
    EVENT_SUMMON_ARCANE = 6,

    // =========== PHASE THREE ===============
    EVENT_SURGE_POWER_PHASE_3 = 7,
    EVENT_STATIC_FIELD = 8,
    EVENT_ARCANE_PULSE = 14,

    // =============== YELLS ===============
    EVENT_YELL_0 = 9,
    EVENT_YELL_1 = 10,
    EVENT_YELL_2 = 11,
    EVENT_YELL_3 = 12,
    EVENT_YELL_4 = 13,

    // =============== TRANSITIONS ===============
    EVENT_START_PHASE_2=15,
    EVENT_START_PHASE_3,
    EVENT_DESTROY_PLATFORM,

    EVENT_BERSERK,
    EVENT_ALEX_BEAM
};

enum Phases
{
    PHASE_ONE = 1,
    PHASE_TWO = 2,
    PHASE_THREE = 3,
    PHASE_ONE_ENDING,
    PHASE_TWO_ENDING
};

enum Spells
{
    SPELL_ARCANE_BREATH = 56272,
    SPELL_ARCANE_STORM  = 57459,
    SPELL_BERSERK       = 47008,

    SPELL_VORTEX_1 = 56237, // seems that frezze object animation
    SPELL_VORTEX_2 = 55873, // visual effect
    SPELL_VORTEX_3 = 56105, // this spell must handle all the script - casted by the boss and to himself
    //SPELL_VORTEX_4 = 55853, // damage | used to enter to the vehicle - defined in eye_of_eternity.h
    //SPELL_VORTEX_5 = 56263, // damage | used to enter to the vehicle - defined in eye_of_eternity.h
    SPELL_VORTEX_6 = 73040, // teleport - (casted to all raid) | caster 30090 | target player

    SPELL_PORTAL_VISUAL_CLOSED = 55949,
    SPELL_SUMMON_POWER_PARK = 56142, // instead, malyg should cast just 56140
    SPELL_POWER_SPARK_DEATH = 55852,
    SPELL_POWER_SPARK_MALYGOS = 56152,
    SPELL_POWER_SPARK_VISUAL = 55845,

    SPELL_SURGE_POWER = 56505, // used in phase 2
    SPELL_SUMMON_ARCANE_BOMB = 56429,
    SPELL_ARCANE_BOMB_DUMMY = 56430,
    SPELL_ARCANE_BOMB_2 = 56431,
    SPELL_ARCANE_OVERLOAD = 56432,
    //SPELL_SUMMOM_RED_DRAGON = 56070, // in eye_of_eternity.h
    SPELL_SURGE_POWER_PHASE_3 = 57407,
    SPELL_STATIC_FIELD = 57430,
    SPELL_ARCANE_PULSE = 57432,
    SPELL_DESTROY_PLATFORM_PRE = 58842, // lights all over the platform
    SPELL_DESTROY_PLATFROM_BOOM = 59084, // Big Blue boom
    SPELL_DESTROY_PLATFORM_EVENT = 59099,
    SPELL_ALEXSTRASZA_GIFT_BEAM = 61028,

    SPELL_RANDOM_PORTAL = 56047,
    SPELL_PORTAL_BEAM = 56046,

    SPELL_ARCANE_BOMB               = 56431,
    SPELL_DEEP_BREATH               = 60071,
    SPELL_SURGE_OF_POWER_BREATH     = 56505,
    SPELL_ARCANE_OVERLOAD_PROTECT   = 56438,
};

enum Movements
{
    MOVE_VORTEX = 1,
    MOVE_PHASE_TWO,
    MOVE_DEEP_BREATH_ROTATION,
    MOVE_INIT_PHASE_ONE,
    MOVE_CENTER_PLATFORM,
    MOVE_INTRO,
    MOVE_DEEP_BREATH_EXECUTION,
    MOVE_PHASE_TWO_ENDING
};

enum Seats
{
    SEAT_0 = 0,
};

enum Factions
{
    FACTION_FRIENDLY = 35,
    FACTION_HOSTILE = 14
};

enum Actions
{
    ACTION_HOVER_DISK_START_WP_1,
    ACTION_HOVER_DISK_START_WP_2
};

enum MalygosEvents
{
    DATA_SUMMON_DEATHS, // phase 2
    DATA_PHASE
};

enum allOther
  {
    SHELL_MIN_X                     = 722,
    SHELL_MAX_X                     = 768,
    SHELL_MIN_Y                     = 1290,
    SHELL_MAX_Y                     = 1339,


  };

#define FLOOR_Z         266.18f
#define TEN_MINUTES 600000
#define NPC_SURGE_OF_POWER 30334
#define NPC_VORTEX 30090

enum MalygosSays
{
    SAY_AGGRO_P_ONE,
    SAY_KILLED_PLAYER_P_ONE,
    SAY_END_P_ONE,
    SAY_AGGRO_P_TWO,
    SAY_ANTI_MAGIC_SHELL,
    SAY_MAGIC_BLAST, // vortex
    SAY_KILLED_PLAYER_P_TWO,
    SAY_END_P_TWO,
    SAY_INTRO_P_THREE,
    SAY_AGGRO_P_THREE,
    SAY_SURGE_POWER,
    SAY_BUFF_SPARK,
    SAY_KILLED_PLAYER_P_THREE,
    SAY_SPELL_CASTING_P_THREE,
    SAY_DEATH,
    SAY_DEEP_BREATH_WARNING, // 15
    SAY_DEEP_BREATH, // 16
    SAY_POWER_SPARK, //17
    SAY_INTRO, // 18
    WHISPER_SURGE_PH3 // 19
};

#define MAX_HOVER_DISK_WAYPOINTS 18

// Sniffed data (x, y,z)
const Position HoverDiskWaypoints[MAX_HOVER_DISK_WAYPOINTS] =
{
   {782.9821f, 1296.652f, 282.1114f, 0.0f},
   {779.5459f, 1287.228f, 282.1393f, 0.0f},
   {773.0028f, 1279.52f, 282.4164f, 0.0f},
   {764.3626f, 1274.476f, 282.4731f, 0.0f},
   {754.3961f, 1272.639f, 282.4171f, 0.0f},
   {744.4422f, 1274.412f, 282.222f, 0.0f},
   {735.575f, 1279.742f, 281.9674f, 0.0f},
   {729.2788f, 1287.187f, 281.9943f, 0.0f},
   {726.1191f, 1296.688f, 282.2997f, 0.0f},
   {725.9396f, 1306.531f, 282.2448f, 0.0f},
   {729.3045f, 1316.122f, 281.9108f, 0.0f},
   {735.8322f, 1323.633f, 282.1887f, 0.0f},
   {744.4616f, 1328.999f, 281.9948f, 0.0f},
   {754.4739f, 1330.666f, 282.049f, 0.0f},
   {764.074f, 1329.053f, 281.9949f, 0.0f},
   {772.8409f, 1323.951f, 282.077f, 0.0f},
   {779.5085f, 1316.412f, 281.9145f, 0.0f},
   {782.8365f, 1306.778f, 282.3035f, 0.0f},
};

#define GROUND_Z 267.5f

// Source: Sniffs (x, y,z)
#define MALYGOS_MAX_WAYPOINTS 16
const Position MalygosPhaseTwoWaypoints[MALYGOS_MAX_WAYPOINTS] =
{
    {812.7299f, 1391.672f, 283.2763f, 0.0f},
    {848.2912f, 1358.61f, 283.2763f, 0.0f},
    {853.9227f, 1307.911f, 283.2763f, 0.0f},
    {847.1437f, 1265.538f, 283.2763f, 0.0f},
    {839.9229f, 1245.245f, 283.2763f, 0.0f},
    {827.3463f, 1221.818f, 283.2763f, 0.0f},
    {803.2727f, 1203.851f, 283.2763f, 0.0f},
    {772.9372f, 1197.981f, 283.2763f, 0.0f},
    {732.1138f, 1200.647f, 283.2763f, 0.0f},
    {693.8761f, 1217.995f, 283.2763f, 0.0f},
    {664.5038f, 1256.539f, 283.2763f, 0.0f},
    {650.1497f, 1303.485f, 283.2763f, 0.0f},
    {662.9109f, 1350.291f, 283.2763f, 0.0f},
    {677.6391f, 1377.607f, 283.2763f, 0.0f},
    {704.8198f, 1401.162f, 283.2763f, 0.0f},
    {755.2642f, 1417.1f, 283.2763f, 0.0f},
};

struct Locations
{
  float x, y, z, o;
  uint32 id;
};


static Locations OtherLoc[]=
  {
    {808, 1301, 268, 0},                // Phase 3 position
    {749, 1244, 332, 1.544f},           // Vortex FarSight loc
    {754.29f, 1301.18f, 266.17f, 0},    // Center of the platform, ground.
    {823, 1241, 299, 0},                // Alexstrasza's  position
    {749, 1244, 266.17f, 5.33f}         // Aggro position after Subphase fly down
  };


#define MAX_SCIONS 4
#define MAX_NEXUS_LORDS 2
#define MAX_SUMMONS_PHASE_TWO (MAX_SCIONS+MAX_NEXUS_LORDS)

#define MAX_MALYGOS_POS 2
const Position MalygosPositions[MAX_MALYGOS_POS] =
{
    {754.544f, 1301.71f, 320.0f, 0.0f},
    {754.39f, 1301.27f, 292.91f, 0.0f},
};

class boss_malygos : public CreatureScript
{
public:
    boss_malygos() : CreatureScript("boss_malygos") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_malygosAI(creature);
    }

    struct boss_malygosAI : public BossAI
    {
        boss_malygosAI(Creature* creature) : BossAI(creature, DATA_MALYGOS_EVENT)
        {
            // If we enter in combat when MovePoint generator is active, it overrwrites our homeposition
            _homePosition = creature->GetHomePosition();
        }

        void Reset()
        {
		  //std::cout << "Reset" << std::endl;

            _Reset();

            _bersekerTimer = 0;
            _currentPos = 0;

            SetPhase(PHASE_ONE, true);

            _delayedMovementTimer = 8000;
            _delayedMovement = false;

            _summonDeaths = 0;

            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
	    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

            _cannotMove = true;//used only in phase 3, so why set it here?
            introTimer = 3000;

            me->SetFlying(true);

	    m_uiWipeCheckTimer = 2500;

            if (instance)
                instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);

	    isc = false;
        }

        uint32 GetData(uint32 data)
        {
            if (data == DATA_SUMMON_DEATHS)
                return _summonDeaths;
            else if (data == DATA_PHASE)
                return _phase;

            return 0;
        }

      void AttackStart(Unit* pWho)
      {
	if (pWho && me->Attack(pWho, true))
	  {
	    me->AddThreat(pWho, 1.0f);
	    me->SetInCombatWith(pWho);
	    pWho->SetInCombatWith(me);
	  }
      }

      void DoSpawnShell()
      {
	float x = (float)urand(SHELL_MIN_X,SHELL_MAX_X);
	float y = (float)urand(SHELL_MIN_Y,SHELL_MAX_Y);
	if(Creature *pShell = me->SummonCreature(NPC_ARCANE_OVERLOAD, x, y, FLOOR_Z, 0, TEMPSUMMON_TIMED_DESPAWN, 45000))
	  {
	    pShell->CastSpell(pShell, SPELL_ARCANE_BOMB, true);
	  }
      }

      void CastSpellToTrigger(uint32 uiSpellId, bool triggered = true, bool triggerCast = false)
      {
	if(Creature *pTrigger = me->SummonCreature(NPC_VORTEX, OtherLoc[2].x, OtherLoc[2].y, OtherLoc[2].z, 0, TEMPSUMMON_TIMED_DESPAWN, 10000))
	  {
	    if(!triggerCast)
	      {
		pTrigger->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
		pTrigger->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
		pTrigger->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
		pTrigger->setFaction(me->getFaction());
		pTrigger->CastSpell(pTrigger, uiSpellId, triggered);
	      }
	    else
	      {
		pTrigger->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
		DoCast(pTrigger, uiSpellId, triggered);
	      }
	  }
      }


      void SendDeepBreathCast()
      {
	WorldPacket data(SMSG_SPELL_GO, 50);
	data.append(me->GetPackGUID());

	data.append(me->GetPackGUID());
	data << uint8(1);
	data << uint32(SPELL_DEEP_BREATH);
	data << uint32(256);
	data << uint32(getMSTime());

	data << uint8(0);
	data << uint8(0);
	data << uint8(0);

	me->SendMessageToSet(&data, false);
      }


      void CastSurgeOfPower()
      {
	Creature* SurgeOfPower = NULL;

	SurgeOfPower = GetClosestCreatureWithEntry(me, NPC_SURGE_OF_POWER, 200.0f, true);
	if(!SurgeOfPower)
	  {
	    SurgeOfPower = me->SummonCreature(NPC_SURGE_OF_POWER, 754.29f, 1301.18f, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 10000);
	    if(!SurgeOfPower)
	      {
		return;
	      }
	  }

	SurgeOfPower->SetFlying(true);
	SurgeOfPower->SetHealth(100000);
	SurgeOfPower->setFaction(14);
	SurgeOfPower->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
	SurgeOfPower->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
	SurgeOfPower->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
	SurgeOfPower->SetDisplayId(11686);

	me->CastSpell(SurgeOfPower, 56505, false);

	SurgeOfPower->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
      }


        void SetData(uint32 data, uint32 value)
        {
           if (data == DATA_SUMMON_DEATHS && _phase == PHASE_TWO && me->isInCombat())
            {
                _summonDeaths = value;

                if (_summonDeaths >= MAX_SUMMONS_PHASE_TWO)
		  PreparePhaseThree();
            }
        }

        void EnterEvadeMode()
        {
            me->SetHomePosition(_homePosition);

            //me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
            me->SetFlying(true);

            BossAI::EnterEvadeMode();

            if (instance)
                instance->SetBossState(DATA_MALYGOS_EVENT, FAIL);
        }

        void SetPhase(uint8 phase, bool setEvents = false)
        {
            //events.Reset(); // makes him forget to enrage

            events.SetPhase(phase);
            _phase = phase;

            if (setEvents)
                SetPhaseEvents();
        }

        void SpellHitTarget(Unit* target, const SpellInfo* pSpell)
        {
            if (pSpell->Id == SPELL_RANDOM_PORTAL)
            {
                Talk(SAY_INTRO);
                //me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING); // For smooth intro movement, will be removed by MoveChase

                float x, y, z;
                target->GetContactPoint(me, x, y, z, 10);
                me->GetMotionMaster()->MovePoint(MOVE_INTRO, x, y, z+10);
                introPortalGUID = target->GetGUID();
            }
        }

        void PreparePhaseThree()
        {
            SetPhase(PHASE_TWO_ENDING, true);
            _delayedMovement = false;
            // this despawns Hover Disks
            summons.DespawnAll();
            // players that used Hover Disk are no in the aggro list
            me->SetInCombatWithZone();

            // pos sniffed
            me->GetMotionMaster()->MoveIdle();
            me->GetMotionMaster()->MovePoint(MOVE_PHASE_TWO_ENDING, MalygosPositions[0].GetPositionX(), MalygosPositions[0].GetPositionY(), MalygosPositions[0].GetPositionZ());
        }

        void StartPhaseThree()
        {
            if (!instance)
                return;

            SetPhase(PHASE_THREE, true);
	    if (Creature* m_uiSafeZone = me->SummonCreature(30494, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 360000)) //safe zone.. raid do not leave combat while mounting
	      {
		m_uiSafeZone->AI()->AttackStart(me);
		m_uiSafeZone->SetDisplayId(11686);
	      }

            std::list<HostileReference*> &m_threatlist = me->getThreatManager().getThreatList();
            for (std::list<HostileReference*>::const_iterator itr = m_threatlist.begin(); itr!= m_threatlist.end(); ++itr)
            {
                if (Unit* target = (*itr)->getTarget())
                {
                    if (target->GetTypeId() != TYPEID_PLAYER)
                        continue;

                    // The rest is handled in the AI of the vehicle.
                    target->CastSpell(target, SPELL_SUMMOM_RED_DRAGON, true);
                }
            }

            if (GameObject* go = GameObject::GetGameObject(*me, instance->GetData64(DATA_PLATFORM)))
                go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DESTROYED); // In sniffs it has this flag, but i don't know how is applied.

            // I think he should descend a little
            me->RemoveAurasByType(SPELL_AURA_MOD_RESISTANCE); // CoE, FF
            me->RemoveAurasByType(SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS); //Hunter's Mark

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void SetPhaseEvents()
        {
            switch (_phase)
            {
                case PHASE_ONE:
                    events.ScheduleEvent(EVENT_ARCANE_BREATH, urand(15, 20)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_ARCANE_STORM, urand(5, 10)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_VORTEX, urand(30, 40)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_POWER_SPARKS, urand(30, 35)*IN_MILLISECONDS, 0, _phase);
                    break;
                case PHASE_ONE_ENDING:
                    events.ScheduleEvent(EVENT_YELL_0, 0, 0, _phase);
                    events.ScheduleEvent(EVENT_START_PHASE_2, 20*IN_MILLISECONDS, 0, _phase);
                    break;
                case PHASE_TWO:
                    events.ScheduleEvent(EVENT_YELL_1, 4*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_SURGE_POWER, urand(60, 70)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_SUMMON_ARCANE, urand(2, 5)*IN_MILLISECONDS, 0, _phase);
                    //events.ScheduleEvent(EVENT_ARCANE_STORM, urand(5, 10)*IN_MILLISECONDS, 0, _phase);
                    break;
                case PHASE_TWO_ENDING:
                    events.ScheduleEvent(EVENT_YELL_2, 0, 0, _phase);
                    //events.ScheduleEvent(EVENT_DESTROY_PLATFORM, 6*IN_MILLISECONDS, 0, _phase);//in movementinform
                    //events.ScheduleEvent(EVENT_START_PHASE_3, 10*IN_MILLISECONDS, 0, _phase);
                    break;
                case PHASE_THREE:
                    events.ScheduleEvent(EVENT_YELL_3, 2*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_YELL_4, 16*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_SURGE_POWER_PHASE_3, urand(14, 23)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_STATIC_FIELD, urand(20, 30)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_ARCANE_STORM, urand(15, 20)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_ARCANE_PULSE, 10*IN_MILLISECONDS, 0, _phase); //?
                    break;
                default:
                    break;
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();

            me->SetFlying(false);
            //me->RemoveUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
            //me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

	      Talk(SAY_AGGRO_P_ONE);

            //DoCast(SPELL_BERSEKER);
            events.ScheduleEvent(EVENT_BERSERK, 10*MINUTE*IN_MILLISECONDS);

            if (instance)
                instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            switch (_phase)
            {
                case PHASE_ONE_ENDING:
                    Talk(SAY_KILLED_PLAYER_P_ONE);
                    break;
                case PHASE_TWO_ENDING:
                    Talk(SAY_KILLED_PLAYER_P_TWO);
                    break;
                case PHASE_THREE:
                    Talk(SAY_KILLED_PLAYER_P_THREE);
                    break;
            }
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_POWER_SPARK_MALYGOS)
            {
                if (Creature* creature = caster->ToCreature())
                    creature->DespawnOrUnsummon();

                Talk(SAY_BUFF_SPARK);
            }
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!me->isInCombat())
                return;

            if (who->GetEntry() == NPC_POWER_SPARK && !who->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
            {
                // not sure about the distance | I think it is better check this here than in the UpdateAI function...
                if (who->GetDistance(me) <= 1)
                    who->CastSpell(me, SPELL_POWER_SPARK_MALYGOS, true);
            }
        }

        void PrepareForVortex()
        {
            me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
            me->SetFlying(true);

            me->GetMotionMaster()->MovementExpired();
            me->GetMotionMaster()->MovePoint(MOVE_VORTEX, MalygosPositions[1].GetPositionX(), MalygosPositions[1].GetPositionY(), MalygosPositions[1].GetPositionZ());
            // continues in MovementInform function.
        }

        void ExecuteVortex()
        {
            DoCast(me, SPELL_VORTEX_1, true);
            DoCast(me, SPELL_VORTEX_2, true);

            // the vortex execution continues in the dummy effect of this spell (see its script)
            DoCast(me, SPELL_VORTEX_3, true);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE  && type != EFFECT_MOTION_TYPE)
                return;

            switch (id)
            {
                case MOVE_VORTEX:
		  //std::cout << "MOVE_VORTEX" << std::endl;
                    me->GetMotionMaster()->MoveIdle();
                    ExecuteVortex();
                    break;
                case MOVE_DEEP_BREATH_ROTATION:
		  //std::cout << "MOVE_DEEP_BREATH_ROTATION" << std::endl;
		  _currentPos = _currentPos == MALYGOS_MAX_WAYPOINTS - 1 ? 0 : _currentPos+1;
                    //me->GetMotionMaster()->MovementExpired(); //it looks ugly when he is stopping
                    //me->GetMotionMaster()->MovePoint(MOVE_DEEP_BREATH_ROTATION, MalygosPhaseTwoWaypoints[currentPos]);
                    me->AddUnitState(UNIT_STATE_ROTATING); //So he does not turn towards his victim. Will be removed by movement generators ... hopefully :D
                    //me->SetUInt64Value(UNIT_FIELD_TARGET, 0);
                    _delayedMovementTimer = 0;
                    _delayedMovement = true;
                    break;
                case MOVE_INIT_PHASE_ONE:
		  //std::cout << "MOVE_INIT_PHASE_ONE" << std::endl;
		  introTimer = 0;
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    me->SetInCombatWithZone();
		    if (!me->isInCombat())
                        EnterEvadeMode();
                    break;
                case MOVE_CENTER_PLATFORM:
		  //std::cout << "MOVE_CENTER_PLATFORM" << std::endl;
                    // Malygos is already flying here, there is no need to set it again.
                    _cannotMove = false;
                    // malygos will move into center of platform and then he does not chase dragons, he just turns to his current target.
                    me->GetMotionMaster()->MoveIdle();
                    break;
	    case MOVE_DEEP_BREATH_EXECUTION:
		  //std::cout << "MOVE_DEEP_BREATH_EXECUTION" << std::endl;
                    for (Map::PlayerList::const_iterator i = instance->instance->GetPlayers().begin(); i != instance->instance->GetPlayers().end(); ++i)
                       Talk(SAY_DEEP_BREATH, i->getSource()->GetGUID());
                    //Talk(SAY_DEEP_BREATH);
                   me->GetMotionMaster()->MoveIdle();
                    _delayedMovementTimer = 8000;
                    _delayedMovement = true;
                    DoCast(SPELL_SURGE_POWER);
                    events.ScheduleEvent(EVENT_SURGE_POWER, urand(60, 70)*IN_MILLISECONDS, 0, PHASE_TWO);
                    break;
                case MOVE_INTRO:
		  //std::cout << "MOVE_INTRO" << std::endl;
                    if (Creature* portal = Unit::GetCreature(*me, introPortalGUID))
                      DoCast(portal, SPELL_PORTAL_BEAM);
                    introTimer=20*IN_MILLISECONDS;
                    break;
                case MOVE_PHASE_TWO_ENDING:
		  //std::cout << "MOVE_PHASE_TWO_ENDING" << std::endl;
                    DoCast(SPELL_DESTROY_PLATFORM_PRE);
                    events.ScheduleEvent(EVENT_DESTROY_PLATFORM, 6*IN_MILLISECONDS, 0, PHASE_TWO_ENDING);
                    events.ScheduleEvent(EVENT_START_PHASE_3, 8200, 0, PHASE_TWO_ENDING);
                    break;
                case EVENT_FALL_GROUND:
		  //std::cout << "EVENT_FALL_GROUND" << std::endl;
                    me->RemoveCorpse();
                    break;

            }
        }

      void PreparePhaseTwo()
      {
		  //std::cout << "PreparePhaseTwo" << std::endl;
           SetPhase(PHASE_ONE_ENDING, true);

            //me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
           me->SetFlying(true);
           me->GetMotionMaster()->MovePoint(MOVE_CENTER_PLATFORM, MalygosPositions[1].GetPositionX(), MalygosPositions[1].GetPositionY(), MalygosPositions[1].GetPositionZ());
		  //std::cout << "PreparePhaseTwo end" << std::endl;
      }

        void StartPhaseTwo()
        {
		  //std::cout << "StartPhaseTwo" << std::endl;
            SetPhase(PHASE_TWO, true);


            me->SetFlying(true);

	    	    me->GetMotionMaster()->Clear(false);
	      me->GetMotionMaster()->MovePoint(MOVE_DEEP_BREATH_ROTATION, MalygosPhaseTwoWaypoints[0]);

	    Creature* summon;
            for (uint8 i=0;i<MAX_SCIONS;++i)
            {
               summon = me->SummonCreature(NPC_HOVER_DISK_CASTER, HoverDiskWaypoints[i*MAX_HOVER_DISK_WAYPOINTS/MAX_SCIONS]);
               if (summon && summon->IsAIEnabled)
                    summon->AI()->DoAction(i*MAX_HOVER_DISK_WAYPOINTS/MAX_SCIONS);
           }

	    for (uint8 i = 0; i < MAX_NEXUS_LORDS; ++i)
	      {
		// not sure about its position.
               summon = me->SummonCreature(NPC_HOVER_DISK_MELEE, HoverDiskWaypoints[urand(0,MAX_HOVER_DISK_WAYPOINTS-1)]);
		if (summon)
		  summon->SetInCombatWithZone();
	      }

	    //            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
		  //std::cout << "StartPhaseTwo end" << std::endl;
        }

        void UpdateAI(uint32 const diff)
        {

	  if (introTimer && me->GetMotionMaster()->GetCurrentMovementGeneratorType() == IDLE_MOTION_TYPE)
            {
                if (introTimer <= diff)
                   DoCast(SPELL_RANDOM_PORTAL);
                else introTimer -= diff;
            }

	  if(_phase == PHASE_THREE)
	    {
	      if(m_uiWipeCheckTimer < diff)
		{
		  if(instance)
		    {
		      Map* pMap = me->GetMap();
		      if(!pMap)
			{
			  return;
			}

		      bool player_found = false;
		      Map::PlayerList const &lPlayers = pMap->GetPlayers();
		      for(Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
			{
			  player_found = true;
			  break;
			}

		      if(!player_found)
			{
			  Creature* pTrigger = GetClosestCreatureWithEntry(me, 30494, 100.0f);
			  if(pTrigger)
			    {
			      pTrigger->DespawnOrUnsummon();
			    }

			  me->AI()->EnterEvadeMode();
			}
		    }
		  m_uiWipeCheckTimer = 2500;
		}
	      else
		  m_uiWipeCheckTimer -= diff;
	    }


            if (!UpdateVictim())
	      {
		  //std::cout << "!UpdateVictim" << std::endl;
                return;
	      }

            events.Update(diff);

            if (_phase == PHASE_THREE)
            {
                if (!_cannotMove)
                {
                    // it can change if the player falls from the vehicle.
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != IDLE_MOTION_TYPE)
                    {
                        me->GetMotionMaster()->MovementExpired();
                        me->GetMotionMaster()->MoveIdle();
                    }
                } else
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
                    {
                        me->GetMotionMaster()->MovementExpired();
                        me->GetMotionMaster()->MovePoint(MOVE_CENTER_PLATFORM, MalygosPositions[0].GetPositionX(), MalygosPositions[0].GetPositionY(), MalygosPositions[0].GetPositionZ());
                    }
                }
            }

            // we need a better way for pathing
            if (_delayedMovement)
            {
                if (_delayedMovementTimer <= diff)
                {
                    me->GetMotionMaster()->MovePoint(MOVE_DEEP_BREATH_ROTATION, MalygosPhaseTwoWaypoints[_currentPos]);
                    _delayedMovementTimer = 8000;
                    _delayedMovement = false;
                } _delayedMovementTimer -= diff;
            }
	    //	    else
	    //	  std::cout << "!_delayedMovement" << std::endl;
	    //            // at 50 % health malygos switch to phase 2
	      //  if (me->GetHealthPct() <= 50.0f && _phase == PHASE_ONE)
            //    StartPhaseTwo();

            // the boss is handling vortex
	    if (me->HasAura(SPELL_VORTEX_2))
	      {
		  //std::cout << "me->HasAura(SPELL_VORTEX_2)" << std::endl;

                return;
	      }


            // at 50 % health malygos switch to phase 2
            if (me->GetHealthPct() <= 50.0f && _phase == PHASE_ONE)
                PreparePhaseTwo();

            // We can't cast if we are casting already.
            if (me->HasUnitState(UNIT_STATE_CASTING))
	      {
		  //std::cout << "me->HasUnitState(UNIT_STATE_CASTING)" << std::endl;

                return;
	      }

	    if (me->IsNonMeleeSpellCasted(false))
            {
		  //std::cout << "me->IsNonMeleeSpellCasted(false)" << std::endl;

               //me->MonsterYell("IsNonMeleeSpellCasted is true but I don't have UNIT_STAT_CASTING !",LANG_UNIVERSAL,0);
                return;
           }


            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_YELL_2:
                        Talk(SAY_END_P_TWO);
                        break;
                    case EVENT_YELL_3:
                        Talk(SAY_INTRO_P_THREE);
                        break;
                    case EVENT_YELL_4:
		      Talk(SAY_AGGRO_P_THREE);// does he really say that? I haven't seen it on youtube
                        break;
                    case EVENT_YELL_0:
                        Talk(SAY_END_P_ONE);
                        break;
                    case EVENT_YELL_1:
                        Talk(SAY_AGGRO_P_TWO);
                        break;
                    case EVENT_ARCANE_BREATH:
		    {
		      if (Unit *u = me->getVictim())
                        DoCast(u, SPELL_ARCANE_BREATH);
		      events.ScheduleEvent(EVENT_ARCANE_BREATH, urand(35, 60)*IN_MILLISECONDS, 0, PHASE_ONE);
		      break;
		    }
                    case EVENT_ARCANE_STORM:
		  //std::cout << "EVENT_ARCANE_STORM" << std::endl;
		      DoCast(SPELL_ARCANE_STORM);
                        events.ScheduleEvent(EVENT_ARCANE_STORM, urand(8, 10)*IN_MILLISECONDS, 0, _phase);
                        break;
                    case EVENT_VORTEX:
		      Talk(SAY_MAGIC_BLAST);
                        PrepareForVortex();
                        events.ScheduleEvent(EVENT_VORTEX, urand(60, 80)*IN_MILLISECONDS, 0, PHASE_ONE);
			events.ScheduleEvent(EVENT_ARCANE_STORM, urand(18, 20)*IN_MILLISECONDS, 0, _phase); // about 5s after vortex ends
                       events.ScheduleEvent(EVENT_ARCANE_BREATH, urand(25, 60)*IN_MILLISECONDS, 0, PHASE_ONE); //better would be just delay by 10s or something, but ...
                        break;
                    case EVENT_POWER_SPARKS:
                        instance->SetData(DATA_POWER_SPARKS_HANDLING, 0);
                        events.ScheduleEvent(EVENT_POWER_SPARKS, urand(30, 35)*IN_MILLISECONDS, 0, PHASE_ONE);
                        break;
                    case EVENT_SURGE_POWER:
		  //std::cout << "EVENT_SURGE_POWER" << std::endl;
			Talk(SAY_DEEP_BREATH_WARNING);
                        me->GetMotionMaster()->MovePoint(MOVE_DEEP_BREATH_EXECUTION, MalygosPositions[0].GetPositionX(), MalygosPositions[0].GetPositionY(), MalygosPositions[0].GetPositionZ());
                        _delayedMovement = false;
			SendDeepBreathCast();
			CastSpellToTrigger(SPELL_SURGE_OF_POWER_BREATH, true, true);
			CastSurgeOfPower();
                        events.RescheduleEvent(EVENT_SURGE_POWER, urand(5, 6)*IN_MILLISECONDS, 0, PHASE_TWO);
			if (!isc)
			  {
			    events.RescheduleEvent(EVENT_SUMMON_ARCANE, urand(8, 16)*IN_MILLISECONDS, 0, PHASE_TWO);
			    isc = true;
			  }
                        break;
                    case EVENT_SUMMON_ARCANE:
		      //Talk(SAY_ANTI_MAGIC_SHELL); // does he really say that? I haven't seen it on youtube
		  //std::cout << "EVENT_SUMMON_ARCANE" << std::endl;
                        me->GetMotionMaster()->MovementExpired();
                        _delayedMovementTimer = 1500;
                        _delayedMovement = true;
                        //DoCast(SPELL_SUMMON_ARCANE_BOMB);
			DoSpawnShell();
			events.ScheduleEvent(EVENT_SUMMON_ARCANE, urand(12, 16)*IN_MILLISECONDS, 0, PHASE_TWO);
                        break;
                    case EVENT_SURGE_POWER_PHASE_3:
		      //Talk(SAY_SURGE_POWER); // does he really say that? I haven't seen it on youtube ... instead he should whisper to his target
                        if (Unit* TargetPhaseThree = GetTargetPhaseThree())
                        {
                            me->SetUInt64Value(UNIT_FIELD_TARGET, TargetPhaseThree->GetGUID());
                            Talk(WHISPER_SURGE_PH3, TargetPhaseThree->GetCharmerOrOwnerOrOwnGUID());
                            DoCast(TargetPhaseThree, SPELL_SURGE_POWER_PHASE_3);
                        }
                        events.ScheduleEvent(EVENT_SURGE_POWER_PHASE_3, urand(7, 23)*IN_MILLISECONDS, 0, PHASE_THREE);
                        break;
                    case EVENT_STATIC_FIELD:
		    {
		      Talk(SAY_SPELL_CASTING_P_THREE); // does he really say that? I haven't seen it on youtube
		      if (Unit* TargetPhaseThree = GetTargetPhaseThree())
                        DoCast(TargetPhaseThree, SPELL_STATIC_FIELD);
		      events.ScheduleEvent(EVENT_STATIC_FIELD, urand(20, 30)*IN_MILLISECONDS, 0, PHASE_THREE);
		      return;
		    }
                    case EVENT_ARCANE_PULSE:
                       DoCastAOE(SPELL_ARCANE_PULSE, true);
                        events.ScheduleEvent(EVENT_ARCANE_PULSE, 1*IN_MILLISECONDS, 0, PHASE_THREE);
                        break;
                    case EVENT_DESTROY_PLATFORM:
                        DoCast(me, SPELL_DESTROY_PLATFROM_BOOM);
                        //DoCast(SPELL_DESTROY_PLATFORM_EVENT);
                        break;
                    case EVENT_START_PHASE_2:
		  //std::cout << "EVENT_START_PHASE_2" << std::endl;
                       StartPhaseTwo();
                        break;
                    case EVENT_START_PHASE_3:
                        StartPhaseThree();
                        break;
                    case EVENT_BERSERK:
                        DoCast(me, SPELL_BERSERK, true);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        Unit* GetTargetPhaseThree()
        {
            Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0);

            // we are a drake
            if (target->GetVehicleKit())
                return target;

            // we are a player using a drake (or at least you should)
            if (target->GetTypeId() == TYPEID_PLAYER)
            {
                if (Unit* base = target->GetVehicleBase())
                    return base;
            }

            // is a player falling from a vehicle?
            return NULL;
        }

        void JustDied(Unit* /*killer*/)
        {
	  Map* map = me->GetMap();
	  if (map && map->IsDungeon())
	    {
	      std::list<Player*> PlayerList;
	      Map::PlayerList const& Players = map->GetPlayers();
	      for (Map::PlayerList::const_iterator itr = Players.begin(); itr != Players.end(); ++itr)
		{
		  if (Player* player = itr->getSource())
		    if (player->isDead())
		      player->ResurrectPlayer(1.0f);
		}
	    }
	  //	  DoCastAOE(SPELL_MASS_RESURRECTION);
            Talk(SAY_DEATH);
            _JustDied();
            //me->ClearUnitState(UNIT_STAT_ROOT);
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveCharge(me->GetPositionX(), me->GetPositionY(), 55.0f, SPEED_CHARGE, EVENT_FALL_GROUND);
            //me->GetMotionMaster()->MoveFall(ground_Z, EVENT_FALL_GROUND);
	    //            me->setDeathState(DEAD_FALLING);
            me->setDeathState(DEAD);
        }

    private:
      uint8 _phase;
      uint32 _bersekerTimer;
      uint8 _currentPos; // used for phase 2 rotation...
      bool _delayedMovement; // used in phase 2.
      uint32 _delayedMovementTimer; // used in phase 2
      uint8 _summonDeaths;
      Position _homePosition; // it can get bugged because core thinks we are pathing
      bool _mustTalk;
      bool _cannotMove;
      uint32 introTimer;
      uint64 introPortalGUID;
      uint32 m_uiWipeCheckTimer;
      bool isc;
    };
};

class spell_malygos_vortex_dummy : public SpellScriptLoader
{
public:
    spell_malygos_vortex_dummy() : SpellScriptLoader("spell_malygos_vortex_dummy") {}

    class spell_malygos_vortex_dummy_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_malygos_vortex_dummy_SpellScript)

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();

            if (!caster)
                return;

            // each player will enter to the trigger vehicle (entry 30090) already spawned (each one can hold up to 5 players, it has 5 seats)
            // the players enter to the vehicles casting SPELL_VORTEX_4 OR SPELL_VORTEX_5
            if (InstanceScript* instance = caster->GetInstanceScript())
                instance->SetData(DATA_VORTEX_HANDLING, 0);

            // the rest of the vortex execution continues when SPELL_VORTEX_2 is removed.
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_malygos_vortex_dummy_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_malygos_vortex_dummy_SpellScript();
    }
};

class spell_malygos_vortex_visual : public SpellScriptLoader
{
    public:
        spell_malygos_vortex_visual() : SpellScriptLoader("spell_malygos_vortex_visual") { }

        class spell_malygos_vortex_visual_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_malygos_vortex_visual_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                {
                    std::list<HostileReference*> &m_threatlist = caster->getThreatManager().getThreatList();
                    for (std::list<HostileReference*>::const_iterator itr = m_threatlist.begin(); itr!= m_threatlist.end(); ++itr)
                    {
                        if (Unit* target = (*itr)->getTarget())
                        {
                            Player* targetPlayer = target->ToPlayer();

                            if (!targetPlayer || targetPlayer->isGameMaster())
                                continue;

                            if (InstanceScript* instance = caster->GetInstanceScript())
                            {
                                // teleport spell - i am not sure but might be it must be casted by each vehicle when its passenger leaves it
                                if (Creature* trigger = caster->GetMap()->GetCreature(instance->GetData64(DATA_TRIGGER)))
                                    trigger->CastSpell(targetPlayer, SPELL_VORTEX_6, true);
                            }
                        }
                    }

                    if (Creature* malygos = caster->ToCreature())
                    {
                        // This is a hack, we have to re add players to the threat list because when they enter to the vehicles they are removed.
                        // Anyway even with this issue, the boss does not enter in evade mode - this prevents iterate an empty list in the next vortex execution.
                        malygos->SetInCombatWithZone();

                        malygos->RemoveUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
                        malygos->SetFlying(false);
			if (Unit *u = caster->getVictim())
			  malygos->GetMotionMaster()->MoveChase(u);
                        malygos->RemoveAura(SPELL_VORTEX_1);
                        malygos->resetAttackTimer(); //so he won't hit the tank while he is falling
                    }
                }

            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_malygos_vortex_visual_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_malygos_vortex_visual_AuraScript();
        }
};

class npc_portal_eoe: public CreatureScript
{
public:
    npc_portal_eoe() : CreatureScript("npc_portal_eoe") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_portal_eoeAI(creature);
    }

    struct npc_portal_eoeAI : public ScriptedAI
    {
        npc_portal_eoeAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = creature->GetInstanceScript();
        }

        void Reset()
        {
            _summonTimer = urand(5, 7)*IN_MILLISECONDS;
	    DoCast(me, SPELL_PORTAL_VISUAL_CLOSED, true);
        }

      void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
       {
           if (spell->Id == SPELL_PORTAL_OPENED)
                me->RemoveAura(SPELL_PORTAL_VISUAL_CLOSED);
      }

        void UpdateAI(uint32 const diff)
        {
            if (!me->HasAura(SPELL_PORTAL_VISUAL_CLOSED) &&
                !me->HasAura(SPELL_PORTAL_OPENED))
	      Reset();

            if (!me->HasAura(SPELL_PORTAL_OPENED))
                return;


            if (_instance)
            {
                if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
                {
                    if (malygos->AI()->GetData(DATA_PHASE) != PHASE_ONE)
                    {
                        me->RemoveAura(SPELL_PORTAL_OPENED);
                    }
                }
            }

	    if (_summonTimer)
	      {
                if (_summonTimer <= diff)
                {
                    if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
                        for (Map::PlayerList::const_iterator i = _instance->instance->GetPlayers().begin(); i != _instance->instance->GetPlayers().end(); ++i)
                            malygos->AI()->Talk(SAY_POWER_SPARK, i->getSource()->GetGUID());
                   DoCast(SPELL_SUMMON_POWER_PARK);
                    _summonTimer = 0;
                } else _summonTimer -= diff;
            }
	}

        void JustSummoned(Creature* summon)
        {
            summon->SetInCombatWithZone();
        }

    private:
        uint32 _summonTimer;
        InstanceScript* _instance;
    };
};


class npc_power_spark: public CreatureScript
{
public:
    npc_power_spark() : CreatureScript("npc_power_spark") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_power_sparkAI(creature);
    }

    struct npc_power_sparkAI : public ScriptedAI
    {
        npc_power_sparkAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = creature->GetInstanceScript();

            me->AddAura(SPELL_POWER_SPARK_VISUAL,me);
        }

        void EnterEvadeMode()
        {
            me->DespawnOrUnsummon();
        }

        void UpdateAI(uint32 const /*diff*/)
        {
	  if (!_instance || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;

            if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
            {
                if (malygos->AI()->GetData(DATA_PHASE) != PHASE_ONE)
                {
                    me->DespawnOrUnsummon();
                    return;
                }

                if (malygos->HasAura(SPELL_VORTEX_1))
                {
                    me->GetMotionMaster()->MoveIdle();
                    return;
                }

               if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() < MAX_DB_MOTION_TYPE)
                    me->GetMotionMaster()->MoveFollow(malygos, me->GetObjectSize() - malygos->GetObjectSize(),0.0f);
            }
        }

      void AttackStart(Unit* /*who*/) {}

        void DamageTaken(Unit* /*done_by*/, uint32& damage)
        {
	  if (damage > me->GetHealth())
            {
                damage = 0;
                DoCast(me, SPELL_POWER_SPARK_DEATH, true);
		me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                me->RemoveAura(SPELL_POWER_SPARK_VISUAL);
                me->GetMotionMaster()->Clear(false);
                if (me->GetPositionZ() > GROUND_Z)
                    me->GetMotionMaster()->MoveCharge(me->GetPositionX(), me->GetPositionY(), GROUND_Z);
            }
        }

    private:
        InstanceScript* _instance;
    };
};

class npc_hover_disk : public CreatureScript
{
public:
    npc_hover_disk() : CreatureScript("npc_hover_disk") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_hover_diskAI(creature);
    }

    struct npc_hover_diskAI : public npc_escortAI
    {
        npc_hover_diskAI(Creature* creature) : npc_escortAI(creature)
        {
            if (me->GetEntry() == NPC_HOVER_DISK_CASTER)
                me->SetReactState(REACT_PASSIVE);
             else
                me->SetInCombatWithZone();
	    units = NULL;
	    lostUnits = false;
            _instance = creature->GetInstanceScript();
        }


        void PassengerBoarded(Unit* unit, int8 /*seat*/, bool apply)
        {
            if (apply)
            {
                if (unit->GetTypeId() == TYPEID_UNIT)
                {
		  units = unit;
                    me->setFaction(FACTION_HOSTILE);
                    unit->ToCreature()->SetInCombatWithZone();
                }
            }
            else
            {
	      units = NULL;
                // Error found: This is not called if the passenger is a player

                if (unit->GetTypeId() == TYPEID_UNIT)
                {
                    // This will only be called if the passenger dies
                    if (_instance)
                    {
                        if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
                            malygos->AI()->SetData(DATA_SUMMON_DEATHS, malygos->AI()->GetData(DATA_SUMMON_DEATHS)+1);
                    }

                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                }

                me->GetMotionMaster()->MoveIdle();

		//                if (me->GetEntry() == NPC_HOVER_DISK_MELEE || me->GetEntry() == NPC_HOVER_DISK_CASTER)
                {
                    // Hack: Fall ground function can fail (remember the platform is a gameobject), we will teleport the disk to the ground
                    if (me->GetPositionZ() > GROUND_Z)
		      me->GetMotionMaster()->MoveCharge(me->GetPositionX(), me->GetPositionY(), GROUND_Z);
		    //                        me->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), GROUND_Z, 0);
                    me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                    me->setFaction(FACTION_FRIENDLY);
                    //me->AI()->EnterEvadeMode();
                }
            }
        }

        void EnterEvadeMode()
        {
            // we dont evade
        }

        void DoAction(int32 const action)
        {
            if (me->GetEntry() != NPC_HOVER_DISK_CASTER || action >= MAX_HOVER_DISK_WAYPOINTS)
                return;

            uint8 wp_num=action;

            for (uint8 i = 0; i < MAX_HOVER_DISK_WAYPOINTS; ++i)
            {
                if (wp_num >= MAX_HOVER_DISK_WAYPOINTS)
                    wp_num=0;
                AddWaypoint(i, HoverDiskWaypoints[wp_num].GetPositionX(), HoverDiskWaypoints[wp_num].GetPositionY(), HoverDiskWaypoints[wp_num].GetPositionZ());
                ++wp_num;
            }

            Start(true, false, 0, 0, false, true);
        }

        void UpdateEscortAI(const uint32 /*diff*/)
        {
	  if (lostUnits)
	    return;
	  std::cout << "check" << std::endl;
            // we dont do melee damage!
	  if (units)
	    if (!units->isAlive())
	      {
		lostUnits = true;
		//		SetEscortPaused(true);
		//		me->GetMotionMaster()->MovePoint(1, me->GetPositionX(), me->GetPositionY(), GROUND_Z);
		if (Creature *pShell = me->SummonCreature(me->GetEntry(), me->GetPositionX(), me->GetPositionY(), FLOOR_Z + 1, 0, TEMPSUMMON_TIMED_DESPAWN, 300000))
		  {
		  }
		me->DespawnOrUnsummon();
		std::cout << "check ok !" << std::endl;
	      }
        }

        void WaypointReached(uint32 /*i*/)
        {

        }

    private:
      InstanceScript* _instance;
      Unit *units;
      bool lostUnits;
    };
};


// The reason of this AI is to make the creature able to enter in combat otherwise the spell casting of SPELL_ARCANE_OVERLOAD fails.
/*class npc_arcane_overload : public CreatureScript
{
public:
    npc_arcane_overload() : CreatureScript("npc_arcane_overload") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_arcane_overloadAI (creature);
    }

    struct npc_arcane_overloadAI : public ScriptedAI
    {
        npc_arcane_overloadAI(Creature* creature) : ScriptedAI(creature) {}

        void AttackStart(Unit* who)
        {
            //DoStartNoMovement(who); //nonsense!
        }

        void Reset()
        {
            if (Creature* malygos = Unit::GetCreature(*me, me->GetInstanceScript()->GetData64(DATA_MALYGOS)))
            {
                malygos->SetUInt64Value(UNIT_FIELD_TARGET, me->GetGUID());
                malygos->CastSpell(me, SPELL_ARCANE_BOMB_DUMMY, true);
            }
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_ARCANE_BOMB_DUMMY)
            {
                DoCast(me, SPELL_ARCANE_BOMB_2, true);
                DoCast(me, SPELL_ARCANE_OVERLOAD, true);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            // we dont do melee damage!
        }

    };
};*/


class npc_arcane_overload : public CreatureScript
{
public:
  npc_arcane_overload() : CreatureScript("npc_arcane_overload") { }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_arcane_overloadAI (pCreature);
  }

  struct npc_arcane_overloadAI : public ScriptedAI
  {
    npc_arcane_overloadAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
      m_pInstance = (InstanceScript*)pCreature->GetInstanceScript();
      me->SetFlying(true);
      Reset();
    }

    InstanceScript* m_pInstance;

    uint32 m_uiProtectTimer;
    bool m_uiAOCasted;
    float range;

    void Reset()
    {
      m_uiProtectTimer = 250;
      m_uiAOCasted = false;
      range = 45.0f;
      me->SetFlying(true);
    }

    void AttackStart(Unit* who)
    {
      DoStartNoMovement(who); //nonsense!
    }

void ProtectAllPlayersInRange(float range)
{
  Map* pMap = me->GetMap();
  if(!pMap)
    {
      return;
    }

  // The range of the bubble is 12 yards, decreases to 0 yards, linearly, over time.
  float realRange = (range / 45.0f) * 12.0f;

  Map::PlayerList const &lPlayers = pMap->GetPlayers();
  for(Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
    {
      if(!itr->getSource()->isAlive())
	{
	  continue;
	}

      if(!itr->getSource()->IsWithinDist2d(me->GetPositionX(), me->GetPositionY(), realRange))
	{
	  // Remove aura if is within 12 yards (So got the aura via it's default aura range)
	  // but isn't in range of the shrunk bubble (So shouldn't get the aura, because it's range already decreased)
	  if(itr->getSource()->IsWithinDist2d(me->GetPositionX(), me->GetPositionY(), 12))
	    {
	      itr->getSource()->RemoveAurasDueToSpell(SPELL_ARCANE_OVERLOAD_PROTECT);
	    }
	}
      else
	{
	  // Add the aura if still within shrunk bubble range
	  me->AddAura(SPELL_ARCANE_OVERLOAD_PROTECT, itr->getSource());
	}
    }
}

void UpdateAI(const uint32 uiDiff)
{
  if(!m_uiAOCasted)
    {
      DoCast(me,SPELL_ARCANE_OVERLOAD);
      m_uiAOCasted = true;
    }
  /*  if(m_uiProtectTimer <= uiDiff)
    {
      ProtectAllPlayersInRange(range);
      range -= 0.5f;
      m_uiProtectTimer = 250;
    }
  else
    {
      m_uiProtectTimer -= uiDiff;
      }*/
}
};
};


// SmartAI does not work correctly for this (vehicles)
class npc_wyrmrest_skytalon : public CreatureScript
{
public:
    npc_wyrmrest_skytalon() : CreatureScript("npc_wyrmrest_skytalon") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_wyrmrest_skytalonAI (creature);
    }

    struct npc_wyrmrest_skytalonAI : public NullCreatureAI
    {
        npc_wyrmrest_skytalonAI(Creature* creature) : NullCreatureAI(creature)
        {
            _instance = creature->GetInstanceScript();

            _timer = 1600;
            _entered = false;
	    me->NearTeleportTo(me->GetPositionX(), me->GetPositionY(),  me->GetPositionZ()-50, me->GetOrientation());
        }

        void PassengerBoarded(Unit* /*unit*/, int8 /*seat*/, bool apply)
        {
            if (!apply)
                me->DespawnOrUnsummon();
        }

        // we can't call this in reset function, it fails.
        void MakePlayerEnter()
        {
            if (!_instance)
                return;

            if (Unit* summoner = me->ToTempSummon()->GetSummoner())
            {
                if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
                {
                    summoner->CastSpell(me, SPELL_RIDE_RED_DRAGON, true);
                    float victimThreat = malygos->getThreatManager().getThreat(summoner);
                    malygos->getThreatManager().resetAllAggro();
                    malygos->AI()->AttackStart(me);
                    malygos->AddThreat(me, victimThreat);
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!_entered)
            {
                if (_timer <= diff)
                {
                    MakePlayerEnter();
                    _entered = true;
                } else
                    _timer -= diff;
            }
        }

    private:
        InstanceScript* _instance;
        uint32 _timer;
        bool _entered;
    };
};

enum AlexstraszaYells
{
    SAY_ONE,
    SAY_TWO,
    SAY_THREE,
    SAY_FOUR
};

class npc_alexstrasza_eoe : public CreatureScript
{
public:
    npc_alexstrasza_eoe() : CreatureScript("npc_alexstrasza_eoe") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_alexstrasza_eoeAI (creature);
    }

    struct npc_alexstrasza_eoeAI : public ScriptedAI
    {
        npc_alexstrasza_eoeAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset()
        {
            _events.Reset();
	    //            _events.ScheduleEvent(EVENT_YELL_1, 0);
	    _events.ScheduleEvent(EVENT_ALEX_BEAM, 10*IN_MILLISECONDS);
            me->SetByteFlag(UNIT_FIELD_BYTES_1, 3, 0x02); // so she will be flying, not standing in the air
            me->SetVisible(false);

        }

        void UpdateAI(uint32 const diff)
        {
	  _events.Update(diff);
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
		case EVENT_ALEX_BEAM:
                        me->SetVisible(true);
                        if (me->GetInstanceScript())
                            me->GetInstanceScript()->SetData(DATA_GIFT,0);
                        DoCast(SPELL_ALEXSTRASZA_GIFT_BEAM);
                        _events.ScheduleEvent(EVENT_YELL_1, 4*IN_MILLISECONDS);
                        break;
                    case EVENT_YELL_1:
                        Talk(SAY_ONE);
                        _events.ScheduleEvent(EVENT_YELL_2, 5*IN_MILLISECONDS);
                        break;
                    case EVENT_YELL_2:
                        Talk(SAY_TWO);
                        _events.ScheduleEvent(EVENT_YELL_3, 4*IN_MILLISECONDS);
                        break;
                    case EVENT_YELL_3:
                        Talk(SAY_THREE);
                        _events.ScheduleEvent(EVENT_YELL_4, 22*IN_MILLISECONDS);
                        break;
                    case EVENT_YELL_4:
                        Talk(SAY_FOUR);
                        break;
                }
            }
        }
    private:
        EventMap _events;
    };
};

class achievement_denyin_the_scion : public AchievementCriteriaScript
{
    public:
        achievement_denyin_the_scion() : AchievementCriteriaScript("achievement_denyin_the_scion") {}

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (Unit* disk = source->GetVehicleBase())
                if (disk->GetEntry() == NPC_HOVER_DISK_CASTER || disk->GetEntry() == NPC_HOVER_DISK_MELEE)
                    return true;
            return false;
        }
};

//56548
class spell_malygos_deep_breath : public SpellScriptLoader
{
    public:
        spell_malygos_deep_breath() : SpellScriptLoader("spell_malygos_deep_breath") { }

        class spell_malygos_deep_breath_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_malygos_deep_breath_SpellScript)

            void FilterTargets(std::list<Unit*>& targetList)
            {
                for (std::list<Unit*>::iterator itr = targetList.begin() ; itr != targetList.end();)
                {
                    if ((*itr)->GetVehicle() || (*itr)->IsVehicle()) // maybe use ispet() or something instead of isvehicle
                        itr = targetList.erase(itr);
                    else
                        ++itr;
                }
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_malygos_deep_breath_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript *GetSpellScript() const
        {
            return new spell_malygos_deep_breath_SpellScript();
        }
};

//56438
class spell_arcane_overload : public SpellScriptLoader
{
    public:
        spell_arcane_overload() : SpellScriptLoader("spell_arcane_overload") { }

        class spell_arcane_overload_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_arcane_overload_SpellScript)

            void FilterTargets(std::list<Unit*>& targetList)
            {
                Unit* caster = GetCaster();
                if (!caster)
                    return;

		//                float radius=caster->GetFloatValue(OBJECT_FIELD_SCALE_X)*GetSpellRadius(GetSpellInfo(), EFFECT_0, false) - caster->GetObjectSize();
                float radius=caster->GetFloatValue(OBJECT_FIELD_SCALE_X)* GetSpellInfo()->Effects[EFFECT_0].CalcRadius() - caster->GetObjectSize();
                for (std::list<Unit*>::iterator itr = targetList.begin() ; itr != targetList.end();)
                {
                    if ((*itr)->IsWithinDist(caster, radius))
                        ++itr;
                    else
                        itr = targetList.erase(itr);
                }
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_arcane_overload_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript *GetSpellScript() const
        {
            return new spell_arcane_overload_SpellScript();
        }
};

void AddSC_boss_malygos()
{
    new boss_malygos();
    new npc_portal_eoe();
    new npc_power_spark();
    new npc_hover_disk();
    new npc_arcane_overload();
    new npc_wyrmrest_skytalon();
    new spell_malygos_vortex_dummy();
    new spell_malygos_vortex_visual();
    new npc_alexstrasza_eoe();
    new achievement_denyin_the_scion();
    new spell_malygos_deep_breath();
    new spell_arcane_overload();
}
