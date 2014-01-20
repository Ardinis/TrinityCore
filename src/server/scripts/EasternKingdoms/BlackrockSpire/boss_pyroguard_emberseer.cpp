/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"

enum Text
{
    EMOTE_ONE_STACK                 = 0,
    EMOTE_TEN_STACK                 = 1,
    EMOTE_FREE_OF_BONDS             = 2,
    YELL_FREE_OF_BONDS              = 3
};

enum Spells
{
    SPELL_ENCAGED_EMBERSEER         = 15282, // Self on spawn
    SPELL_FIRE_SHIELD_TRIGGER       = 13377, // Self on spawn missing from 335 dbc
    SPELL_FREEZE_ANIM               = 16245, // Self on event start
    SPELL_EMBERSEER_GROWING         = 16048, // Self on event start
    SPELL_EMBERSEER_FULL_STRENGTH   = 16047, // Emberseer Full Strength
    SPELL_FIRENOVA                  = 23462, // Combat
    SPELL_FLAMEBUFFET               = 23341, // Combat
    SPELL_PYROBLAST                 = 17274  // Combat
};

enum Events
{
    EVENT_FIRENOVA                  = 1,
    EVENT_FLAMEBUFFET               = 2,
    EVENT_PYROBLAST                 = 3
};


class boss_pyroguard_emberseer : public CreatureScript
{
public:
    boss_pyroguard_emberseer() : CreatureScript("boss_pyroguard_emberseer") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_pyroguard_emberseerAI(creature);
    }

    struct boss_pyroguard_emberseerAI : public BossAI
    {
        boss_pyroguard_emberseerAI(Creature* creature) : BossAI(creature, DATA_PYROGAURD_EMBERSEER) {}

        bool battack;

        void Reset()
        {
            OpenDoors(false);
            battack = false;
            (me->FindNearestGameObject(GO_EMBERSEER_RUNE_1, 60.0f))->SetGoState(GO_STATE_ACTIVE);
            (me->FindNearestGameObject(GO_EMBERSEER_RUNE_2, 60.0f))->SetGoState(GO_STATE_ACTIVE);
            (me->FindNearestGameObject(GO_EMBERSEER_RUNE_3, 60.0f))->SetGoState(GO_STATE_ACTIVE);
            (me->FindNearestGameObject(GO_EMBERSEER_RUNE_4, 60.0f))->SetGoState(GO_STATE_ACTIVE);
            (me->FindNearestGameObject(GO_EMBERSEER_RUNE_5, 60.0f))->SetGoState(GO_STATE_ACTIVE);
            (me->FindNearestGameObject(GO_EMBERSEER_RUNE_6, 60.0f))->SetGoState(GO_STATE_ACTIVE);
            (me->FindNearestGameObject(GO_EMBERSEER_RUNE_7, 60.0f))->SetGoState(GO_STATE_ACTIVE);
            std::list<Creature*> sIncarcerator;
            me->GetCreatureListWithEntryInGrid(sIncarcerator ,10316, 60.0f);
            for (std::list<Creature*>::iterator itr = sIncarcerator.begin(); itr != sIncarcerator.end(); ++itr)
            {
                (*itr)->Respawn(true);
            }
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NOT_SELECTABLE);
            DoCast(me, SPELL_ENCAGED_EMBERSEER);
            //DoCast(me, SPELL_FIRE_SHIELD_TRIGGER);
            _Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_FIRENOVA,    6 * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_FLAMEBUFFET, 3 * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_PYROBLAST,  14 * IN_MILLISECONDS);
        }

        void JustDied(Unit* /*killer*/)
        {
            OpenDoors(true);
            _JustDied();
            if (InstanceScript* instance = me->GetInstanceScript()) // porte de l'arene
                if (uint64 door = instance->GetData64(GO_GYTH_ENTRY_DOOR))
                    instance->DoUseDoorOrButton(door);
        }

        void OpenDoors(bool Boss_Killed)
        {
            if (uint64 door1 = instance->GetData64(GO_EMBERSEER_IN))
                instance->DoUseDoorOrButton(door1);
            else
                me->MonsterSay("oups, ca va pas :/ ", 0,0);
            if (uint64 door2 = instance->GetData64(GO_DOORS))
                instance->DoUseDoorOrButton(door2);
            if (Boss_Killed)
                if (uint64 door3 = instance->GetData64(GO_EMBERSEER_OUT))
                    instance->DoUseDoorOrButton(door3);
        }

        void UpdateAI(uint32 const diff)
        {
            if ((!me->FindNearestCreature(NPC_INCARCERATOR ,50.0f, true)) && (battack == false))
            {
                if (Player* player = me->SelectNearestPlayer(60.0f))
                {
                    me->Attack(player, true);
                    battack = true;
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NOT_SELECTABLE);
                    me->RemoveAllAuras();
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_FIRENOVA:
                    DoCastVictim(SPELL_FIRENOVA);
                    events.ScheduleEvent(EVENT_FIRENOVA, 6 * IN_MILLISECONDS);
                    break;
                case EVENT_FLAMEBUFFET:
                    DoCastVictim(SPELL_FLAMEBUFFET);
                    events.ScheduleEvent(EVENT_FLAMEBUFFET, 14 * IN_MILLISECONDS);
                    break;
                case EVENT_PYROBLAST:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        DoCast(target, SPELL_PYROBLAST);
                    events.ScheduleEvent(EVENT_PYROBLAST, 15 * IN_MILLISECONDS);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_emberseer_visual : public SpellScriptLoader
{
public:
    spell_emberseer_visual() : SpellScriptLoader("spell_emberseer_visual") { }

    class spell_emberseer_visual_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_emberseer_visual_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit* player = GetCaster())
            {
                (player->FindNearestGameObject(GO_EMBERSEER_RUNE_1, 60.0f))->SetGoState(GO_STATE_READY);
                (player->FindNearestGameObject(GO_EMBERSEER_RUNE_2, 60.0f))->SetGoState(GO_STATE_READY);
                (player->FindNearestGameObject(GO_EMBERSEER_RUNE_3, 60.0f))->SetGoState(GO_STATE_READY);
                (player->FindNearestGameObject(GO_EMBERSEER_RUNE_4, 60.0f))->SetGoState(GO_STATE_READY);
                (player->FindNearestGameObject(GO_EMBERSEER_RUNE_5, 60.0f))->SetGoState(GO_STATE_READY);
                (player->FindNearestGameObject(GO_EMBERSEER_RUNE_6, 60.0f))->SetGoState(GO_STATE_READY);
                (player->FindNearestGameObject(GO_EMBERSEER_RUNE_7, 60.0f))->SetGoState(GO_STATE_READY);
                std::list<Creature*> sIncarcerator;
                player->GetCreatureListWithEntryInGrid(sIncarcerator ,10316, 60.0f);
                for (std::list<Creature*>::iterator itr = sIncarcerator.begin(); itr != sIncarcerator.end(); ++itr)
                {
                    (*itr)->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_UNK_15);
                    (*itr)->Attack(player, true);
                }
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_emberseer_visual_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_emberseer_visual_SpellScript();
    }
};

void AddSC_boss_pyroguard_emberseer()
{
    new boss_pyroguard_emberseer();
    new spell_emberseer_visual();
}
