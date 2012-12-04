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

#include "ScriptPCH.h"
#include "pit_of_saron.h"
#include "Vehicle.h"

enum Yells
{
    SAY_AMBUSH_1                    = -1658050,
    SAY_AMBUSH_2                    = -1658051,
    SAY_GAUNTLET_START              = -1658052,
    SAY_TYRANNUS_INTRO_1            = -1658053,
    SAY_GORKUN_INTRO_2              = -1658054,
    SAY_TYRANNUS_INTRO_3            = -1658055,

    SAY_AGGRO                       = -1658056,
    SAY_SLAY_1                      = -1658057,
    SAY_SLAY_2                      = -1658058,
    SAY_DEATH                       = -1658059,
    SAY_MARK_RIMEFANG_1             = -1658060,
    SAY_MARK_RIMEFANG_2             = -1658061,
    SAY_DARK_MIGHT_1                = -1658062,
    SAY_DARK_MIGHT_2                = -1658063,

    SAY_GORKUN_OUTRO_1              = -1658064,
    SAY_GORKUN_OUTRO_2              = -1658065,
    SAY_JAYNA_OUTRO_3               = -1658066,
    SAY_SYLVANAS_OUTRO_3            = -1658067,
    SAY_JAYNA_OUTRO_4               = -1658068,
    SAY_SYLVANAS_OUTRO_4            = -1658069,
    SAY_JAYNA_OUTRO_5               = -1658070,
};

enum Spells
{
    SPELL_OVERLORD_BRAND            = 69172,
    SPELL_OVERLORD_BRAND_HEAL       = 69190,
    SPELL_OVERLORD_BRAND_DAMAGE     = 69189,
    SPELL_FORCEFUL_SMASH            = 69155,
    SPELL_UNHOLY_POWER              = 69167,
    SPELL_MARK_OF_RIMEFANG          = 69275,
    SPELL_HOARFROST                 = 69246,

    //cave
    SPELL_ICICLE_FALL               = 69428,
    SPELL_FALL_DAMAGE               = 62236,
    SPELL_ICICLE                    = 62234,

    SPELL_ICY_BLAST                 = 69232,
    SPELL_ICY_BLAST_AURA            = 69238,

    SPELL_EJECT_ALL_PASSENGERS      = 50630,
    SPELL_FULL_HEAL                 = 43979,
};

enum Events
{
    EVENT_OVERLORD_BRAND    = 1,
    EVENT_FORCEFUL_SMASH    = 2,
    EVENT_UNHOLY_POWER      = 3,
    EVENT_MARK_OF_RIMEFANG  = 4,

    // Rimefang
    EVENT_MOVE_NEXT         = 5,
    EVENT_HOARFROST         = 6,
    EVENT_ICY_BLAST         = 7,

    EVENT_INTRO_1           = 8,
    EVENT_INTRO_2           = 9,
    EVENT_INTRO_3           = 10,
    EVENT_COMBAT_START      = 11,
};

enum Phases
{
    PHASE_NONE      = 0,
    PHASE_INTRO     = 1,
    PHASE_COMBAT    = 2,
    PHASE_OUTRO     = 3,
};

enum Actions
{
    ACTION_START_INTRO      = 1,
    ACTION_START_RIMEFANG   = 2,
    ACTION_START_OUTRO      = 3,
    ACTION_END_COMBAT       = 4,
};

#define GUID_HOARFROST 1

static const Position rimefangPos[10] =
{
    {1017.299f, 168.9740f, 642.9259f, 0.000000f},
    {1047.868f, 126.4931f, 665.0453f, 0.000000f},
    {1069.828f, 138.3837f, 665.0453f, 0.000000f},
    {1063.042f, 164.5174f, 665.0453f, 0.000000f},
    {1031.158f, 195.1441f, 665.0453f, 0.000000f},
    {1019.087f, 197.8038f, 665.0453f, 0.000000f},
    {967.6233f, 168.9670f, 665.0453f, 0.000000f},
    {969.1198f, 140.4722f, 665.0453f, 0.000000f},
    {986.7153f, 141.6424f, 665.0453f, 0.000000f},
    {1012.601f, 142.4965f, 665.0453f, 0.000000f},
};

static const Position miscPos = {1018.376f, 167.2495f, 628.2811f, 0.000000f};   //tyrannus combat start position

class boss_tyrannus : public CreatureScript
{
    public:
        boss_tyrannus() : CreatureScript("boss_tyrannus") { }

        struct boss_tyrannusAI : public BossAI
        {
            boss_tyrannusAI(Creature* creature) : BossAI(creature, DATA_TYRANNUS)
            {
            }

            void InitializeAI()
            {
                if (!instance || static_cast<InstanceMap*>(me->GetMap())->GetScriptId() != sObjectMgr->GetScriptId(PoSScriptName))
                    me->IsAIEnabled = false;
                else if (instance->GetBossState(DATA_TYRANNUS) != DONE)
                    Reset();
                else
                    me->DespawnOrUnsummon();
            }

            void Reset()
            {
                events.Reset();
                events.SetPhase(PHASE_NONE);
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                instance->SetBossState(DATA_TYRANNUS, NOT_STARTED);
            }

            Creature* GetRimefang()
            {
                return ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_RIMEFANG));
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoScriptText(SAY_AGGRO, me);
            }

            void AttackStart(Unit* victim)
            {
                if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    return;

                if (victim && me->Attack(victim, true) && !(events.GetPhaseMask() & (1 << PHASE_INTRO)))
                    me->GetMotionMaster()->MoveChase(victim);
            }

            void EnterEvadeMode()
            {
                instance->SetBossState(DATA_TYRANNUS, FAIL);
                if (Creature* rimefang = GetRimefang())
                    rimefang->AI()->EnterEvadeMode();

                me->DespawnOrUnsummon();
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
            }

            void JustDied(Unit* /*killer*/)
            {
                DoScriptText(SAY_DEATH, me);
                instance->SetBossState(DATA_TYRANNUS, DONE);

                // Prevent corpse despawning
                if (TempSummon* summ = me->ToTempSummon())
                    summ->SetTempSummonType(TEMPSUMMON_DEAD_DESPAWN);

                // Stop combat for Rimefang
                if (Creature* rimefang = GetRimefang())
                    rimefang->AI()->DoAction(ACTION_END_COMBAT);
            }

            void DoAction(const int32 actionId)
            {
                if (actionId == ACTION_START_INTRO)
                {
                    DoScriptText(SAY_TYRANNUS_INTRO_1, me);
                    events.SetPhase(PHASE_INTRO);
                    events.ScheduleEvent(EVENT_INTRO_1, 14000, 0, PHASE_INTRO);
                    events.ScheduleEvent(EVENT_INTRO_2, 22000, 0, PHASE_INTRO);
                    events.ScheduleEvent(EVENT_INTRO_3, 34000, 0, PHASE_INTRO);
                    events.ScheduleEvent(EVENT_COMBAT_START, 36000, 0, PHASE_INTRO);
                    instance->SetBossState(DATA_TYRANNUS, IN_PROGRESS);
                }
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim() && !(events.GetPhaseMask() & (1 << PHASE_INTRO)))
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_INTRO_1:
                            //DoScriptText(SAY_GORKUN_INTRO_2, pGorkunOrVictus);
                            break;
                        case EVENT_INTRO_2:
                            DoScriptText(SAY_TYRANNUS_INTRO_3, me);
                            break;
                        case EVENT_INTRO_3:
                            me->ExitVehicle();
                            me->GetMotionMaster()->MovePoint(0, miscPos);
                            break;
                        case EVENT_COMBAT_START:
                            if (Creature* rimefang = me->GetCreature(*me, instance->GetData64(DATA_RIMEFANG)))
                                rimefang->AI()->DoAction(ACTION_START_RIMEFANG);    //set rimefang also infight
                            events.SetPhase(PHASE_COMBAT);
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            me->SetReactState(REACT_AGGRESSIVE);
                            DoCast(me, SPELL_FULL_HEAL);
                            DoZoneInCombat();
                            events.ScheduleEvent(EVENT_OVERLORD_BRAND, urand(5000, 7000));
                            events.ScheduleEvent(EVENT_FORCEFUL_SMASH, urand(14000, 16000));
                            events.ScheduleEvent(EVENT_MARK_OF_RIMEFANG, urand(25000, 27000));
                            break;
                        case EVENT_OVERLORD_BRAND:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true))
                                DoCast(target, SPELL_OVERLORD_BRAND);
                            events.ScheduleEvent(EVENT_OVERLORD_BRAND, urand(11000, 12000));
                            break;
                        case EVENT_FORCEFUL_SMASH:
                            DoCastVictim(SPELL_FORCEFUL_SMASH);
                            events.ScheduleEvent(EVENT_UNHOLY_POWER, 1000);
                            break;
                        case EVENT_UNHOLY_POWER:
                            DoScriptText(SAY_DARK_MIGHT_1, me);
                            DoScriptText(SAY_DARK_MIGHT_2, me);
                            DoCast(me, SPELL_UNHOLY_POWER);
                            events.ScheduleEvent(EVENT_FORCEFUL_SMASH, urand(40000, 48000));
                            break;
                        case EVENT_MARK_OF_RIMEFANG:
                            DoScriptText(SAY_MARK_RIMEFANG_1, me);
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true))
                            {
                                DoScriptText(SAY_MARK_RIMEFANG_2, me, target);
                                DoCast(target, SPELL_MARK_OF_RIMEFANG);
                            }
                            events.ScheduleEvent(EVENT_MARK_OF_RIMEFANG, urand(24000, 26000));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_tyrannusAI(creature);
        }
};

class boss_rimefang : public CreatureScript
{
    public:
        boss_rimefang() : CreatureScript("boss_rimefang") { }

        struct boss_rimefangAI : public ScriptedAI
        {
            boss_rimefangAI(Creature* creature) : ScriptedAI(creature), _vehicle(creature->GetVehicleKit())
            {
                ASSERT(_vehicle);
            }

            void Reset()
            {
                _events.Reset();
                _events.SetPhase(PHASE_NONE);
                _currentWaypoint = 0;
                _hoarfrostTargetGUID = 0;
                me->SetFlying(true);
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            void JustReachedHome()
            {
                _vehicle->InstallAllAccessories(false);
            }

            void DoAction(const int32 actionId)
            {
                if (actionId == ACTION_START_RIMEFANG)
                {
                    _events.SetPhase(PHASE_COMBAT);
                    DoZoneInCombat();
                    _events.ScheduleEvent(EVENT_MOVE_NEXT, 500, 0, PHASE_COMBAT);
                    _events.ScheduleEvent(EVENT_ICY_BLAST, 15000, 0, PHASE_COMBAT);
                }
                else if (actionId == ACTION_END_COMBAT)
                    _EnterEvadeMode();
            }

            void SetGUID(uint64 guid, int32 type)
            {
                if (type == GUID_HOARFROST)
                {
                    _hoarfrostTargetGUID = guid;
                    _events.ScheduleEvent(EVENT_HOARFROST, 1000);
                }
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim() && !(_events.GetPhaseMask() & (1 << PHASE_COMBAT)))
                    return;

                _events.Update(diff);

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_MOVE_NEXT:
                            if (_currentWaypoint >= 10 || _currentWaypoint == 0)
                                _currentWaypoint = 1;
                            me->GetMotionMaster()->MovePoint(0, rimefangPos[_currentWaypoint]);
                            ++_currentWaypoint;
                            _events.ScheduleEvent(EVENT_MOVE_NEXT, 2000, 0, PHASE_COMBAT);
                            break;
                        case EVENT_ICY_BLAST:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_ICY_BLAST);
                            _events.ScheduleEvent(EVENT_ICY_BLAST, 15000, 0, PHASE_COMBAT);
                            break;
                        case EVENT_HOARFROST:
                            if (Unit* target = me->GetUnit(*me, _hoarfrostTargetGUID))
                            {
                                DoCast(target, SPELL_HOARFROST);
                                _hoarfrostTargetGUID = 0;
                            }
                            break;
                        default:
                            break;
                    }
                }
            }

        private:
            Vehicle* _vehicle;
            uint64 _hoarfrostTargetGUID;
            EventMap _events;
            uint8 _currentWaypoint;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_rimefangAI(creature);
        }
};

class player_overlord_brandAI : public PlayerAI
{
    public:
        player_overlord_brandAI(Player* player) : PlayerAI(player)
        {
            tyrannus = NULL;
        }

        void SetGUID(uint64 guid, int32 /*type*/)
        {
            tyrannus = ObjectAccessor::GetCreature(*me, guid);
            if (!tyrannus)
                me->IsAIEnabled = false;
        }

        void DamageDealt(Unit* /*victim*/, uint32& damage, DamageEffectType /*damageType*/)
        {
            if (tyrannus->getVictim())
                me->CastCustomSpell(SPELL_OVERLORD_BRAND_DAMAGE, SPELLVALUE_BASE_POINT0, damage, tyrannus->getVictim(), true, NULL, NULL, tyrannus->GetGUID());
        }

        void HealDone(Unit* /*target*/, uint32& addHealth)
        {
            me->CastCustomSpell(SPELL_OVERLORD_BRAND_HEAL, SPELLVALUE_BASE_POINT0, int32(addHealth*5.5f), tyrannus, true, NULL, NULL, tyrannus->GetGUID());
        }

        void UpdateAI(const uint32 /*diff*/) { }

    private:
        Creature* tyrannus;
};

class spell_tyrannus_overlord_brand : public SpellScriptLoader
{
    public:
        spell_tyrannus_overlord_brand() : SpellScriptLoader("spell_tyrannus_overlord_brand") { }

        class spell_tyrannus_overlord_brand_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_tyrannus_overlord_brand_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->GetTypeId() != TYPEID_PLAYER)
                    return;

                oldAI = GetTarget()->GetAI();
                GetTarget()->SetAI(new player_overlord_brandAI(GetTarget()->ToPlayer()));
                GetTarget()->GetAI()->SetGUID(GetCasterGUID());
                oldAIState = GetTarget()->IsAIEnabled;
                GetTarget()->IsAIEnabled = true;
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->GetTypeId() != TYPEID_PLAYER)
                    return;

                delete GetTarget()->GetAI();
                GetTarget()->SetAI(oldAI);
                GetTarget()->IsAIEnabled = oldAIState;
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_tyrannus_overlord_brand_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_tyrannus_overlord_brand_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }

            UnitAI* oldAI;
            bool oldAIState;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_tyrannus_overlord_brand_AuraScript();
        }
};

class spell_tyrannus_mark_of_rimefang : public SpellScriptLoader
{
    public:
        spell_tyrannus_mark_of_rimefang() : SpellScriptLoader("spell_tyrannus_mark_of_rimefang") { }

        class spell_tyrannus_mark_of_rimefang_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_tyrannus_mark_of_rimefang_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* caster = GetCaster();
                if (!caster || caster->GetTypeId() != TYPEID_UNIT)
                    return;

                if (InstanceScript* instance = caster->GetInstanceScript())
                    if (Creature* rimefang = ObjectAccessor::GetCreature(*caster, instance->GetData64(DATA_RIMEFANG)))
                        rimefang->AI()->SetGUID(GetTarget()->GetGUID(), GUID_HOARFROST);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_tyrannus_mark_of_rimefang_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_tyrannus_mark_of_rimefang_AuraScript();
        }
};

class at_tyrannus_event_starter : public AreaTriggerScript
{
    public:
        at_tyrannus_event_starter() : AreaTriggerScript("at_tyrannus_event_starter") { }

        bool OnTrigger(Player* player, const AreaTriggerEntry* /*at*/)
        {
            InstanceScript* instance = player->GetInstanceScript();
            if (player->isGameMaster() || !instance)
                return false;

            if (instance->GetBossState(DATA_TYRANNUS) != IN_PROGRESS && instance->GetBossState(DATA_TYRANNUS) != DONE)
                if (Creature* tyrannus = ObjectAccessor::GetCreature(*player, instance->GetData64(DATA_TYRANNUS)))
                {
                    tyrannus->AI()->DoAction(ACTION_START_INTRO);
                    return true;
                }

            return false;
        }
};

class npc_tyrannus_icicle : public CreatureScript
{
public:
  npc_tyrannus_icicle() : CreatureScript("npc_tyrannus_icicle") { }

  struct npc_tyrannus_icicleAI : public ScriptedAI
  {
    npc_tyrannus_icicleAI(Creature *creature) : ScriptedAI(creature), _instanceScript(creature->GetInstanceScript())
    {
      InitializeAI();
    }

    void InitializeAI()
    {
      if (!_instanceScript || static_cast<InstanceMap*>(me->GetMap())->GetScriptId() != sObjectMgr->GetScriptId(PoSScriptName))
	me->IsAIEnabled = false;
      Reset();
    }

    uint32 IcicleTimer;
    uint32 IcicleDTimer;

    void Reset()
    {
      me->SetReactState(REACT_PASSIVE);
      IcicleTimer = urand(urand(10000, 15000), urand(20000, 30000));
      IcicleDTimer = 3600000;
      me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
      me->GetMotionMaster()->MoveRandom(10.0f);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage)
    {
      damage = 0;
    }

    void UpdateAI(const uint32(diff))
    {
      if(_instanceScript->GetBossState(DATA_TYRANNUS) != DONE)
      {
	if (IcicleTimer <= diff)
	{
	  //	  DoCast(me, SPELL_FALL_DAMAGE);
	  //	  DoCast(me, SPELL_ICICLE_FALL);
	  DoCast(me, SPELL_ICICLE);
	  //  me->GetMotionMaster()->Clear();
	  // me->StopMoving();
	  // DoCast(me, 62462);
	  IcicleTimer = urand(10000, 15000);
	  IcicleDTimer = 4000;
	} else IcicleTimer -= diff;
	if (IcicleDTimer <= diff)
	{
	  //	  DoCast(me, SPELL_FALL_DAMAGE);
	  //	  DoCast(me, SPELL_ICICLE_FALL);
	  //	  DoCast(me, SPELL_ICICLE);
	  IcicleDTimer = 3600000;
	  me->GetMotionMaster()->MoveRandom(10.0f);
	} else IcicleDTimer -= diff;
      }
    }

  private:
    InstanceScript* _instanceScript;
  };

  CreatureAI* GetAI(Creature* creature) const
  {
    return new npc_tyrannus_icicleAI(creature);
  }
};
/*
DELETE FROM `creature_template` WHERE (`entry`=36847);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES (36847, 0, 0, 0, 0, 0, 28470, 1126, 0, 0, 'Collapsing Icicle', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1.14286, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 33587200, 8, 0, 0, 0, 0, 0, 336, 504, 126, 4, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, 'npc_tyrannus_icicle', 12340);

DELETE FROM `creature` WHERE `id`=36847;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
  (139286, 36847, 658, 3, 1, 0, 0, 1074.55, 19.4549, 633.102, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139287, 36847, 658, 3, 1, 0, 0, 1083.67, 6.56424, 633.7, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139288, 36847, 658, 3, 1, 0, 0, 1010.18, -141.198, 621.042, 2.49582, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139289, 36847, 658, 3, 1, 0, 0, 1074.55, 19.4549, 633.102, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139290, 36847, 658, 3, 1, 0, 0, 1069.24, -10.6545, 633.781, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139291, 36847, 658, 3, 1, 0, 0, 1021.05, -122.354, 624.375, 2.84489, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139292, 36847, 658, 3, 1, 0, 0, 1058.88, -51.0677, 633.797, 4.60767, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139293, 36847, 658, 3, 1, 0, 0, 1048.24, -75.2014, 633.003, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139294, 36847, 658, 3, 1, 0, 0, 1021.05, -122.354, 624.375, 2.84489, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139295, 36847, 658, 3, 1, 0, 0, 1038.08, -106.852, 628.901, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139296, 36847, 658, 3, 1, 0, 0, 1056.59, -109.167, 630.891, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139297, 36847, 658, 3, 1, 0, 0, 1059.43, -39.0729, 633.943, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139298, 36847, 658, 3, 1, 0, 0, 981.66, -134.417, 607.866, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139299, 36847, 658, 3, 1, 0, 0, 951.469, -96.0486, 595.238, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139300, 36847, 658, 3, 1, 0, 0, 1072.91, -40.8993, 633.59, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139301, 36847, 658, 3, 1, 0, 0, 985.663, -128.326, 608.254, 0.15708, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139302, 36847, 658, 3, 1, 0, 0, 1000.3, -126.005, 615.862, 2.07694, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139303, 36847, 658, 3, 1, 0, 0, 1058.25, -53.5122, 633.705, 3.75246, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139304, 36847, 658, 3, 1, 0, 0, 948.851, -111.17, 595.13, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139305, 36847, 658, 3, 1, 0, 0, 1074.6, 71.1458, 631.068, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139306, 36847, 658, 3, 1, 0, 0, 1068.62, 52.066, 631.293, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139307, 36847, 658, 3, 1, 0, 0, 1080.09, 43.467, 630, 0.506145, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139308, 36847, 658, 3, 1, 0, 0, 1008.45, -127.712, 620.498, 2.49582, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139309, 36847, 658, 3, 1, 0, 0, 1072.91, -40.8993, 633.59, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139310, 36847, 658, 3, 1, 0, 0, 1049.65, -74.033, 633.078, 4.36332, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139311, 36847, 658, 3, 1, 0, 0, 1069.24, -10.6545, 633.781, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139312, 36847, 658, 3, 1, 0, 0, 1056.59, -109.167, 630.891, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139313, 36847, 658, 3, 1, 0, 0, 1068.64, 27.0972, 631.282, 4.08407, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139314, 36847, 658, 3, 1, 0, 0, 1018.17, -130.429, 623.537, 0.15708, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139315, 36847, 658, 3, 1, 0, 0, 948.851, -111.17, 595.13, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139316, 36847, 658, 3, 1, 0, 0, 1058.25, -53.5122, 633.705, 3.75246, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139317, 36847, 658, 3, 1, 0, 0, 957.536, -110.778, 595.604, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139318, 36847, 658, 3, 1, 0, 0, 948.851, -111.17, 595.13, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139319, 36847, 658, 3, 1, 0, 0, 1083.67, 6.56424, 633.7, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139320, 36847, 658, 3, 1, 0, 0, 1074.55, 19.4549, 633.102, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139321, 36847, 658, 3, 1, 0, 0, 1018.17, -130.429, 623.537, 0.15708, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139322, 36847, 658, 3, 1, 0, 0, 946.724, -105.462, 594.994, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139323, 36847, 658, 3, 1, 0, 0, 1060.56, -77.3542, 633.758, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139324, 36847, 658, 3, 1, 0, 0, 951.465, -102.632, 594.968, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139325, 36847, 658, 3, 1, 0, 0, 1071.78, -19.1458, 633.174, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139326, 36847, 658, 3, 1, 0, 0, 1048.24, -75.2014, 633.003, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139327, 36847, 658, 3, 1, 0, 0, 1062.55, -23.7222, 634.076, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139328, 36847, 658, 3, 1, 0, 0, 980.286, -118.993, 601.536, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139329, 36847, 658, 3, 1, 0, 0, 1068.78, -70.4063, 633.396, 3.66519, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139330, 36847, 658, 3, 1, 0, 0, 1071.78, -19.1458, 633.174, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139331, 36847, 658, 3, 1, 0, 0, 1029.76, -114.705, 626.664, 2.94961, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139332, 36847, 658, 3, 1, 0, 0, 1068.78, -70.4063, 633.396, 3.66519, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139333, 36847, 658, 3, 1, 0, 0, 1048.78, -115.236, 629.419, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139334, 36847, 658, 3, 1, 0, 0, 1065.23, 116.997, 628.366, 4.93928, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139335, 36847, 658, 3, 1, 0, 0, 1071.78, -19.1458, 633.174, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139336, 36847, 658, 3, 1, 0, 0, 1059.43, -39.0729, 633.943, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139337, 36847, 658, 3, 1, 0, 0, 990.997, -124.531, 609.625, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139338, 36847, 658, 3, 1, 0, 0, 1058.25, -53.5122, 633.705, 3.75246, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139339, 36847, 658, 3, 1, 0, 0, 1048.24, -75.2014, 633.003, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139340, 36847, 658, 3, 1, 0, 0, 1082.01, 29.5747, 630.368, 4.08407, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139341, 36847, 658, 3, 1, 0, 0, 1067.68, -13.2049, 633.712, 4.53786, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139342, 36847, 658, 3, 1, 0, 0, 1079.75, 38.0608, 629.712, 4.60767, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139343, 36847, 658, 3, 1, 0, 0, 1074.6, 71.1458, 631.068, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139344, 36847, 658, 3, 1, 0, 0, 946.724, -105.462, 594.994, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139345, 36847, 658, 3, 1, 0, 0, 1073.01, 58.1354, 631.722, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139346, 36847, 658, 3, 1, 0, 0, 980.286, -118.993, 601.536, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139347, 36847, 658, 3, 1, 0, 0, 951.465, -102.632, 594.968, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139348, 36847, 658, 3, 1, 0, 0, 1021.05, -122.354, 624.375, 2.84489, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139349, 36847, 658, 3, 1, 0, 0, 1071.71, -55.4722, 633.578, 3.75246, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139350, 36847, 658, 3, 1, 0, 0, 1039.86, -115.92, 628.833, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139351, 36847, 658, 3, 1, 0, 0, 1029.76, -114.705, 626.664, 2.94961, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139352, 36847, 658, 3, 1, 0, 0, 1068.64, 27.0972, 631.282, 4.08407, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139353, 36847, 658, 3, 1, 0, 0, 947.764, -97.849, 595.385, 5.74213, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139354, 36847, 658, 3, 1, 0, 0, 958.288, -120.444, 596.854, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139355, 36847, 658, 3, 1, 0, 0, 1038.08, -106.852, 628.901, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139356, 36847, 658, 3, 1, 0, 0, 1071.71, -55.4722, 633.578, 3.75246, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139357, 36847, 658, 3, 1, 0, 0, 1048.78, -115.236, 629.419, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139358, 36847, 658, 3, 1, 0, 0, 1069.24, -10.6545, 633.781, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139359, 36847, 658, 3, 1, 0, 0, 1076.03, -25.5486, 633.157, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139360, 36847, 658, 3, 1, 0, 0, 1041.26, -98.5243, 630.805, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139361, 36847, 658, 3, 1, 0, 0, 1076.67, -16.7396, 632.985, 4.45059, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139362, 36847, 658, 3, 1, 0, 0, 1068.78, -70.4063, 633.396, 3.66519, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139363, 36847, 658, 3, 1, 0, 0, 1076.03, -25.5486, 633.157, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139364, 36847, 658, 3, 1, 0, 0, 1018.17, -130.429, 623.537, 0.15708, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139365, 36847, 658, 3, 1, 0, 0, 970.95, -128.878, 601.532, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139366, 36847, 658, 3, 1, 0, 0, 1048.78, -115.236, 629.419, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139367, 36847, 658, 3, 1, 0, 0, 1071.78, -19.1458, 633.174, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139368, 36847, 658, 3, 1, 0, 0, 1018.17, -130.429, 623.537, 0.15708, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139369, 36847, 658, 3, 1, 0, 0, 1039.86, -115.92, 628.833, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139370, 36847, 658, 3, 1, 0, 0, 1068.78, -70.4063, 633.396, 3.66519, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139371, 36847, 658, 3, 1, 0, 0, 1082.01, 29.5747, 630.368, 4.08407, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139372, 36847, 658, 3, 1, 0, 0, 1056.59, -109.167, 630.891, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139373, 36847, 658, 3, 1, 0, 0, 1073.6, 89.8524, 631.606, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139374, 36847, 658, 3, 1, 0, 0, 1048.78, -115.236, 629.419, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139375, 36847, 658, 3, 1, 0, 0, 1068.78, -70.4063, 633.396, 3.66519, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139376, 36847, 658, 3, 1, 0, 0, 1070.19, 8.39063, 635.596, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139377, 36847, 658, 3, 1, 0, 0, 1070.62, -84.4514, 633.036, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139378, 36847, 658, 3, 1, 0, 0, 948.851, -111.17, 595.13, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139379, 36847, 658, 3, 1, 0, 0, 1070.62, -84.4514, 633.036, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139380, 36847, 658, 3, 1, 0, 0, 981.66, -134.417, 607.866, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139381, 36847, 658, 3, 1, 0, 0, 1050.19, 109.042, 628.479, 5.5676, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139382, 36847, 658, 3, 1, 0, 0, 1074.6, 71.1458, 631.068, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139383, 36847, 658, 3, 1, 0, 0, 1027.41, -134.373, 624.973, 2.84489, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139384, 36847, 658, 3, 1, 0, 0, 1068.64, 27.0972, 631.282, 4.08407, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139385, 36847, 658, 3, 1, 0, 0, 1059.43, -39.0729, 633.943, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139386, 36847, 658, 3, 1, 0, 0, 1015.34, -122.51, 622.795, 3.7001, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139387, 36847, 658, 3, 1, 0, 0, 1041.45, -125.929, 627.413, 3.59538, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139388, 36847, 658, 3, 1, 0, 0, 990.997, -124.531, 609.625, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139389, 36847, 658, 3, 1, 0, 0, 1059.53, 59.9618, 631.987, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139390, 36847, 658, 3, 1, 0, 0, 1037.52, -125.868, 627.045, 2.94961, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139391, 36847, 658, 3, 1, 0, 0, 951.469, -96.0486, 595.238, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139392, 36847, 658, 3, 1, 0, 0, 1069.24, -10.6545, 633.781, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139393, 36847, 658, 3, 1, 0, 0, 1048.78, -115.236, 629.419, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139394, 36847, 658, 3, 1, 0, 0, 1066.98, 43.559, 630.154, 0.506145, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139395, 36847, 658, 3, 1, 0, 0, 1069.6, 38.2292, 629.868, 4.95674, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139396, 36847, 658, 3, 1, 0, 0, 996.191, -138.967, 615.289, 2.07694, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139397, 36847, 658, 3, 1, 0, 0, 1069.48, -85.151, 633.061, 4.2237, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139398, 36847, 658, 3, 1, 0, 0, 1056.59, -109.167, 630.891, 0.10472, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139399, 36847, 658, 3, 1, 0, 0, 1010.18, -141.198, 621.042, 2.49582, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139400, 36847, 658, 3, 1, 0, 0, 1000.3, -126.005, 615.862, 2.07694, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139401, 36847, 658, 3, 1, 0, 0, 1029.76, -114.705, 626.664, 2.94961, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139402, 36847, 658, 3, 1, 0, 0, 1010.18, -141.198, 621.042, 2.49582, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139403, 36847, 658, 3, 1, 0, 0, 1008.45, -127.712, 620.498, 2.49582, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139404, 36847, 658, 3, 1, 0, 0, 958.288, -120.444, 596.854, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139405, 36847, 658, 3, 1, 0, 0, 1083.67, 6.56424, 633.7, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139406, 36847, 658, 3, 1, 0, 0, 947.764, -97.849, 595.385, 5.74213, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139407, 36847, 658, 3, 1, 0, 0, 958.288, -120.444, 596.854, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139408, 36847, 658, 3, 1, 0, 0, 1068.78, -70.4063, 633.396, 3.66519, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139409, 36847, 658, 3, 1, 0, 0, 1000.3, -126.005, 615.862, 2.07694, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139410, 36847, 658, 3, 1, 0, 0, 1076.03, -25.5486, 633.157, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139411, 36847, 658, 3, 1, 0, 0, 966.177, -115.295, 597.076, 5.74213, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139412, 36847, 658, 3, 1, 0, 0, 1070.19, 8.39063, 635.596, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139413, 36847, 658, 3, 1, 0, 0, 1027.41, -134.373, 624.973, 2.84489, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139414, 36847, 658, 3, 1, 0, 0, 1069.37, -52.0087, 633.837, 4.5204, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139415, 36847, 658, 3, 1, 0, 0, 1060.12, 88.0052, 630.991, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139416, 36847, 658, 3, 1, 0, 0, 990.997, -124.531, 609.625, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139417, 36847, 658, 3, 1, 0, 0, 1064.83, -44.6389, 634.187, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139418, 36847, 658, 3, 1, 0, 0, 1039.86, -115.92, 628.833, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139419, 36847, 658, 3, 1, 0, 0, 1060.12, 88.0052, 630.991, 0.890118, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139420, 36847, 658, 3, 1, 0, 0, 980.286, -118.993, 601.536, 1.64061, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139421, 36847, 658, 3, 1, 0, 0, 1037.52, -125.868, 627.045, 2.94961, 604800, 0, 0, 42, 0, 0, 0, 0, 0),
  (139422, 36847, 658, 3, 1, 0, 0, 1062.55, -23.7222, 634.076, 0.628319, 604800, 0, 0, 42, 0, 0, 0, 0, 0);
*/

class spell_tyrannus_icy_blast : public SpellScriptLoader
{
public:
  spell_tyrannus_icy_blast() : SpellScriptLoader("spell_tyrannus_icy_blast") { }

  class spell_tyrannus_icy_blast_SpellScript : public SpellScript
  {
    PrepareSpellScript(spell_tyrannus_icy_blast_SpellScript);

    bool Validate(SpellInfo const* /*spell*/)
    {
      if (!sSpellMgr->GetSpellInfo(SPELL_ICY_BLAST_AURA))
	return false;
      return true;
    }

    void HandleTriggerMissile(SpellEffIndex effIndex)
    {
      PreventHitDefaultEffect(effIndex);
      if (Position const* pos = GetTargetDest())
	if (TempSummon* summon = GetCaster()->SummonCreature(NPC_ICY_BLAST, *pos, TEMPSUMMON_TIMED_DESPAWN, 40000))
	  summon->CastSpell(summon, SPELL_ICY_BLAST_AURA, true);
    }

    void Register()
    {
      OnEffectHitTarget += SpellEffectFn(spell_tyrannus_icy_blast_SpellScript::HandleTriggerMissile, EFFECT_1, SPELL_EFFECT_TRIGGER_MISSILE);
    }
  };

  SpellScript* GetSpellScript() const
  {
    return new spell_tyrannus_icy_blast_SpellScript();
  }
};


void AddSC_boss_tyrannus()
{
    new boss_tyrannus();
    new boss_rimefang();
    new spell_tyrannus_overlord_brand();
    new spell_tyrannus_mark_of_rimefang();
    new spell_tyrannus_icy_blast();
    new at_tyrannus_event_starter();
    new npc_tyrannus_icicle();
}
