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

/*
* Comment: No Waves atm and the doors spells are crazy...
*
* When your group enters the main room (the one after the bridge), you will notice a group of 3 Nerubians.
* When you engage them, 2 more groups like this one spawn behind the first one - it is important to pull the first group back,
* so you don't aggro all 3. Hadronox will be under you, fighting Nerubians.
*
* This is the timed gauntlet - waves of non-elite spiders
* will spawn from the 3 doors located a little above the main room, and will then head down to fight Hadronox. After clearing the
* main room, it is recommended to just stay in it, kill the occasional non-elites that will attack you instead of the boss, and wait for
* Hadronox to make his way to you. When Hadronox enters the main room, she will web the doors, and no more non-elites will spawn.
*/

#include "ScriptPCH.h"
#include "azjol_nerub.h"

enum Spells
{
    SPELL_ACID_CLOUD                              = 53400, // Victim
    SPELL_LEECH_POISON                            = 53030, // Victim
    SPELL_PIERCE_ARMOR                            = 53418, // Victim
    SPELL_WEB_GRAB                                = 57731, // Victim
    SPELL_WEB_FRONT_DOORS                         = 53177, // Self
    SPELL_WEB_SIDE_DOORS                          = 53185, // Self
    H_SPELL_ACID_CLOUD                            = 59419,
    H_SPELL_LEECH_POISON                          = 59417,
    H_SPELL_WEB_GRAB                              = 59421
};

#define PAUSE 42

#define ACTION_RESTART 0
#define ACTION_START 2
#define ACTION_TOILE 1

#define NPC_HADRANOX_TRIGGER1 234721
#define NPC_HADRANOX_TRIGGER2 234720

class HadranoxTriggerSearcher
{
public:
  HadranoxTriggerSearcher(Creature const* source, float range) : _source(source), _range(range) {}

  bool operator()(Unit* unit)
  {
    if (!unit->isAlive())
      return false;

    switch (unit->GetEntry())
    {
    case NPC_HADRANOX_TRIGGER1:
    case NPC_HADRANOX_TRIGGER2:
      break;
    default:
      return false;
    }


    if (!unit->IsWithinDist(_source, _range, false))
      return false;

    return true;
  }

private:
  Creature const* _source;
  float _range;
};

class boss_hadronox : public CreatureScript
{
public:
    boss_hadronox() : CreatureScript("boss_hadronox") { }

    struct boss_hadronoxAI : public ScriptedAI
    {
        boss_hadronoxAI(Creature* c) : ScriptedAI(c)
        {
            instance = c->GetInstanceScript();
            fMaxDistance = 50.0f;
            bFirstTime = true;
        }

        InstanceScript* instance;

        uint32 uiAcidTimer;
        uint32 uiLeechTimer;
        uint32 uiPierceTimer;
        uint32 uiGrabTimer;
        uint32 uiDoorsTimer;
        uint32 uiCheckDistanceTimer;

      uint32 entoilageEvent;

        bool bFirstTime;

        float fMaxDistance;

      bool eventHF;

        void Reset()
        {
            me->SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, 9.0f);
            me->SetFloatValue(UNIT_FIELD_COMBATREACH, 9.0f);

            uiAcidTimer = urand(10*IN_MILLISECONDS, 14*IN_MILLISECONDS);
            uiLeechTimer = urand(3*IN_MILLISECONDS, 9*IN_MILLISECONDS);
            uiPierceTimer = urand(1*IN_MILLISECONDS, 3*IN_MILLISECONDS);
            uiGrabTimer = urand(15*IN_MILLISECONDS, 19*IN_MILLISECONDS);
            uiDoorsTimer = urand(20*IN_MILLISECONDS, 30*IN_MILLISECONDS);
            uiCheckDistanceTimer = 2*IN_MILLISECONDS;
	    entoilageEvent = 30000;

            if (instance && (instance->GetData(DATA_HADRONOX_EVENT) != DONE && !bFirstTime))
                instance->SetData(DATA_HADRONOX_EVENT, FAIL);

            bFirstTime = false;
	    eventHF = true;

	    instance->SetData(DATA_HADRONOX_PRE_EVENT, NOT_STARTED);
	    std::list<Creature*> temp;
	    HadranoxTriggerSearcher check(me, 900.0f);
	    Trinity::CreatureListSearcher<HadranoxTriggerSearcher> searcher(me, temp, check);
	    me->VisitNearbyGridObject(900.0f, searcher);
	    for (std::list<Creature*>::iterator itr = temp.begin(); itr != temp.end(); ++itr)
	      (*itr)->AI()->DoAction(ACTION_START);

        }

        //when Hadronox kills any enemy (that includes a party member) she will regain 10% of her HP if the target had Leech Poison on
        void KilledUnit(Unit* Victim)
        {
            // not sure if this aura check is correct, I think it is though
            if (!Victim || !Victim->HasAura(DUNGEON_MODE(SPELL_LEECH_POISON, H_SPELL_LEECH_POISON)) || !me->isAlive())
                return;

            me->ModifyHealth(int32(me->CountPctFromMaxHealth(10)));
        }

        void JustDied(Unit* /*Killer*/)
        {
            if (instance)
	    {
                instance->SetData(DATA_HADRONOX_EVENT, DONE);
		if (eventHF)
		{
		  if (IsHeroic())
		    instance->DoCompleteAchievement(1297);
		  //valide HF
		}
	    }
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (instance)
                instance->SetData(DATA_HADRONOX_EVENT, IN_PROGRESS);
            me->SetInCombatWithZone();
        }

        void CheckDistance(float dist, const uint32 uiDiff)
        {
            if (!me->isInCombat())
                return;

            float x=0.0f, y=0.0f, z=0.0f;
            me->GetRespawnPosition(x, y, z);

            if (uiCheckDistanceTimer <= uiDiff)
                uiCheckDistanceTimer = 5*IN_MILLISECONDS;
            else
            {
                uiCheckDistanceTimer -= uiDiff;
                return;
            }
            if (me->IsInEvadeMode() || !me->getVictim())
                return;
            if (me->GetDistance(x, y, z) > dist)
                EnterEvadeMode();
        }

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim()) return;

            // Without he comes up through the air to players on the bridge after krikthir if players crossing this bridge!
            CheckDistance(fMaxDistance, diff);

	    if (entoilageEvent <= diff)
	    {
	      std::list<Creature*> temp;
	      HadranoxTriggerSearcher check(me, 900.0f);
	      Trinity::CreatureListSearcher<HadranoxTriggerSearcher> searcher(me, temp, check);
	      me->VisitNearbyGridObject(900.0f, searcher);
	      for (std::list<Creature*>::iterator itr = temp.begin(); itr != temp.end(); ++itr)
		(*itr)->AI()->DoAction(ACTION_TOILE);
	      eventHF = false;
	      entoilageEvent = 3600000;
	    }
	    else entoilageEvent -= diff;

            if (me->HasAura(SPELL_WEB_FRONT_DOORS) || me->HasAura(SPELL_WEB_SIDE_DOORS))
            {
                if (IsCombatMovementAllowed())
                    SetCombatMovement(false);
            }
            else if (!IsCombatMovementAllowed())
                SetCombatMovement(true);

            if (uiPierceTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_PIERCE_ARMOR);
                uiPierceTimer = 8*IN_MILLISECONDS;
            } else uiPierceTimer -= diff;

            if (uiAcidTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    DoCast(target, SPELL_ACID_CLOUD);

                uiAcidTimer = urand(20*IN_MILLISECONDS, 30*IN_MILLISECONDS);
            } else uiAcidTimer -= diff;

            if (uiLeechTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    DoCast(target, SPELL_LEECH_POISON);

                uiLeechTimer = urand(11*IN_MILLISECONDS, 14*IN_MILLISECONDS);
            } else uiLeechTimer -= diff;

            if (uiGrabTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0)) // Draws all players (and attacking Mobs) to itself.
                    DoCast(target, SPELL_WEB_GRAB);

                uiGrabTimer = urand(15*IN_MILLISECONDS, 30*IN_MILLISECONDS);
            } else uiGrabTimer -= diff;

            if (uiDoorsTimer <= diff)
            {
                uiDoorsTimer = urand(30*IN_MILLISECONDS, 60*IN_MILLISECONDS);
            } else uiDoorsTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_hadronoxAI(creature);
    }
};

#define ANUBAR_CHAMPION 29062
#define ANUBAR_NECRO 29064
#define ANUBAR_DEMON 29063

class npc_trigger_hadranox_event : public CreatureScript
{
public:
  npc_trigger_hadranox_event() : CreatureScript("npc_trigger_hadranox_event") { }

struct npc_trigger_hadranox_eventAI : public Scripted_NoMovementAI
  {
    npc_trigger_hadranox_eventAI(Creature* creature) : Scripted_NoMovementAI(creature)
    {
      instance = creature->GetInstanceScript();
      me->GetPosition(&pos);
      instance->SetData(DATA_HADRONOX_PRE_EVENT, NOT_STARTED);
      Reset();
    }

    void Reset()
    {
      summonTimer = 5000;
      stopSummon = false;
      restart = false;
    }

    void EnterCombat(Unit* /*who*/){}

    void AttackStart(Unit* /*who*/){}


    void DoAction(int32 const action)
    {
      switch (action)
      {
      case ACTION_START:
	summonTimer = 5000;
	stopSummon = false;
	restart = false;
	break;
      case ACTION_RESTART:
	summonTimer = 45000;
	stopSummon = false;
	restart = true;
	break;
      case ACTION_TOILE:
	stopSummon = true;
	break;
      }
    }

    void DoSummonNerrubar(bool st)
    {
      if (st)
      {
	me->SummonCreature(ANUBAR_CHAMPION, pos);
	me->SummonCreature(ANUBAR_DEMON, pos);
      }
      else
      {
	me->SummonCreature(ANUBAR_NECRO, pos);
	me->SummonCreature(ANUBAR_DEMON, pos);
      }
    }

    void UpdateAI(const uint32 diff)
    {
      if (summonTimer < diff)
      {
	if (restart)
	  instance->SetData(DATA_HADRONOX_PRE_EVENT, IN_PROGRESS);
	if (instance->GetData(DATA_HADRONOX_PRE_EVENT) == PAUSE || stopSummon)
	{
	  summonTimer = 5000;
	  return ;
	}
	DoSummonNerrubar(sumType);
	sumType != sumType;
	summonTimer = 5000;
      }
      else summonTimer -= diff;
    }

private :

  InstanceScript* instance;
  Position pos;
    bool sumType, stopSummon, restart;
    uint32 summonTimer;

  };


  CreatureAI* GetAI(Creature* creature) const
  {
    return new npc_trigger_hadranox_eventAI(creature);
  }
};

#define MAX_POS_EVENT 10

Position const EventPos[11]   =
{
  {514.44f, 586.84f, 736.50f, 0.0f},
  {543.44f, 584.84f, 732.50f, 0.0f},
  {543.80f, 565.36f, 732.0f, 0.0f},
  {570.95f, 570.35f, 726.76f, 0.0f},
  {598.93f, 578.77f, 724.37f, 0.0f},
  {608.01f, 562.32f, 718.92f, 0.0f},
  {618.36f, 521.89f, 696.0f, 0.0f}, // ?? not sure of this point
  {602.74f, 510.37f, 694.79f, 0.0f},
  {566.58f, 512.39f, 700.0f, 0.0f},
  {554.29f, 518.39f, 692.0f, 0.0f},
  {540.92f, 524.60f, 689.39f, 0.0f},
};

class npc_hadranox_anubar : public CreatureScript
{
public:
  npc_hadranox_anubar() : CreatureScript("npc_hadranox_anubar") { }

struct npc_hadranox_anubarAI : public ScriptedAI
  {
    npc_hadranox_anubarAI(Creature* creature) : ScriptedAI(creature)
    {
      instance = creature->GetInstanceScript();
      Reset();
    }

    void Reset()
    {
      if (me->GetPositionX() < 500)
	curPos = 0;
      else
	curPos = 1;
      doIt = false;
      nextStep = true;
      me->SetReactState(REACT_PASSIVE);
      c = me->FindNearestCreature(28921, 1000);
      if (c == NULL || !c->isAlive())
	me->DespawnOrUnsummon();
    }

    void MovementInform(uint32 type, uint32 point)
    {
      if (type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE)
	return;
      curPos++;
      nextStep = true;
    }

    void DamageTaken(Unit* attacker, uint32& /*damage*/)
    {
      me->SetReactState(REACT_AGGRESSIVE);
      curPos = MAX_POS_EVENT;
    }

    void EnterCombat(Unit* /*who*/){}

    void UpdateAI(const uint32 diff)
    {
      if (instance->GetData(DATA_HADRONOX_PRE_EVENT) == PAUSE)
	me->DespawnOrUnsummon();

      if (nextStep && curPos <= MAX_POS_EVENT)
      {
	me->GetMotionMaster()->MovePoint(42, EventPos[curPos]);
	nextStep = false;
      }
      if (curPos > MAX_POS_EVENT && !doIt)
      {
	if (instance->GetData(DATA_HADRONOX_PRE_EVENT) != IN_PROGRESS)
	  me->DespawnOrUnsummon();
	else
	{
	  me->SetReactState(REACT_AGGRESSIVE);
	  me->AI()->AttackStart(c);
	  doIt = true;
	}
      }
    }

private :

  InstanceScript* instance;
    int curPos;
    bool nextStep;
    bool doIt;
    Creature *c;

  };


  CreatureAI* GetAI(Creature* creature) const
  {
    return new npc_hadranox_anubarAI(creature);
  }
};

class npc_hadranox_scarab : public CreatureScript
{
public:
  npc_hadranox_scarab() : CreatureScript("npc_hadranox_scarab") { }

struct npc_hadranox_scarabAI : public ScriptedAI
  {
    npc_hadranox_scarabAI(Creature* creature) : ScriptedAI(creature)
    {
      instance = creature->GetInstanceScript();
      Reset();
    }

    void Reset()
    {
      me->SetReactState(REACT_AGGRESSIVE);
      start = false;
    }

    void JustDied(Unit* /*Killer*/)
    {

    }

    void DamageTaken(Unit* /*attacker*/, uint32& /*damage*/)
    {
      if (!start)
      {
	instance->SetData(DATA_HADRONOX_PRE_EVENT, PAUSE);
	std::list<Creature*> temp;
	HadranoxTriggerSearcher check(me, 900.0f);
	Trinity::CreatureListSearcher<HadranoxTriggerSearcher> searcher(me, temp, check);
	me->VisitNearbyGridObject(900.0f, searcher);
	for (std::list<Creature*>::iterator itr = temp.begin(); itr != temp.end(); ++itr)
	  (*itr)->AI()->DoAction(ACTION_RESTART);
	//_enterCombat(who);
	start = true;
      }
    }

    void UpdateAI(const uint32 diff)
    {
      DoMeleeAttackIfReady();
    }

private :

  InstanceScript* instance;
    bool start;
  };


  CreatureAI* GetAI(Creature* creature) const
  {
    return new npc_hadranox_scarabAI(creature);
  }
};

void AddSC_boss_hadronox()
{
    new boss_hadronox();
    new npc_trigger_hadranox_event();
    new npc_hadranox_anubar();
    new npc_hadranox_scarab();
}
