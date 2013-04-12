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
 * Scripts for spells with SPELLFAMILY_HUNTER, SPELLFAMILY_PET and SPELLFAMILY_GENERIC spells used by hunter players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_hun_".
 */

#include "SpellAuraEffects.h"
#include "GridNotifiers.h"

enum HunterSpells
{
    HUNTER_SPELL_READINESS                       = 23989,
    DRAENEI_SPELL_GIFT_OF_THE_NAARU              = 59543,
    HUNTER_SPELL_BESTIAL_WRATH                   = 19574,
    HUNTER_PET_SPELL_LAST_STAND_TRIGGERED        = 53479,
    HUNTER_PET_HEART_OF_THE_PHOENIX              = 55709,
    HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED    = 54114,
    HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF       = 55711,
    HUNTER_PET_SPELL_CARRION_FEEDER_TRIGGERED    = 54045,
    HUNTER_SPELL_INVIGORATION_TRIGGERED          = 53398,
    HUNTER_SPELL_MASTERS_CALL_TRIGGERED          = 62305,
    HUNTER_SPELL_CHIMERA_SHOT_SERPENT            = 53353,
    HUNTER_SPELL_CHIMERA_SHOT_VIPER              = 53358,
    HUNTER_SPELL_CHIMERA_SHOT_SCORPID            = 53359,
    HUNTER_SPELL_ASPECT_OF_THE_BEAST_PET         = 61669,
    HUNTER_SPELL_KILL_COMMAND_CRIT_10            = 60110,
    HUNTER_SPELL_KILL_COMMAND_CRIT_20            = 60113,
    HUNTER_SPELL_FOCUSED_FIRE_1                  = 35029,
    HUNTER_SPELL_FOCUSED_FIRE_2                  = 35030,
    HUNTER_SPELL_ANIMAL_HANDLER                  = 34453
};

// 13161 Aspect of the Beast
class spell_hun_aspect_of_the_beast : public SpellScriptLoader
{
    public:
        spell_hun_aspect_of_the_beast() : SpellScriptLoader("spell_hun_aspect_of_the_beast") { }

        class spell_hun_aspect_of_the_beast_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_aspect_of_the_beast_AuraScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*entry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(HUNTER_SPELL_ASPECT_OF_THE_BEAST_PET))
                    return false;
                return true;
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Player* caster = GetCaster()->ToPlayer())
                    if (Pet* pet = caster->GetPet())
                        pet->RemoveAurasDueToSpell(HUNTER_SPELL_ASPECT_OF_THE_BEAST_PET);
            }

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Player* caster = GetCaster()->ToPlayer())
                    if (caster->GetPet())
                        caster->CastSpell(caster, HUNTER_SPELL_ASPECT_OF_THE_BEAST_PET, true);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_hun_aspect_of_the_beast_AuraScript::OnApply, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_aspect_of_the_beast_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_aspect_of_the_beast_AuraScript();
        }
};

// 53209 Chimera Shot
class spell_hun_chimera_shot : public SpellScriptLoader
{
    public:
        spell_hun_chimera_shot() : SpellScriptLoader("spell_hun_chimera_shot") { }

        class spell_hun_chimera_shot_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_chimera_shot_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            Unit* unitTarget = GetHitUnit();
            if (!unitTarget)
                return;

            uint32 spellId = 0;
            int32 basePoint = 0;
            Unit::AuraApplicationMap& Auras = unitTarget->GetAppliedAuras();
            for (Unit::AuraApplicationMap::iterator i = Auras.begin(); i != Auras.end(); ++i)
            {
                Aura* aura = i->second->GetBase();
                if (aura->GetCasterGUID() != caster->GetGUID())
                    continue;

                // Search only Serpent Sting, Viper Sting, Scorpid Sting auras
                flag96 familyFlag = aura->GetSpellInfo()->SpellFamilyFlags;
                if (!(familyFlag[1] & 0x80 || familyFlag[0] & 0xC000))
                    continue;
                if (AuraEffect const* aurEff = aura->GetEffect(0))
                {
                    // Serpent Sting - Instantly deals 40% of the damage done by your Serpent Sting.
                    if (familyFlag[0] & 0x4000)
                    {
                        int32 TickCount = aurEff->GetTotalTicks();
                        spellId = HUNTER_SPELL_CHIMERA_SHOT_SERPENT;
                        basePoint = caster->SpellDamageBonus(unitTarget, aura->GetSpellInfo(), aurEff->GetAmount(), DOT, aura->GetStackAmount());
                        ApplyPctN(basePoint, TickCount * 40);
                    }
                    // Viper Sting - Instantly restores mana to you equal to 60% of the total amount drained by your Viper Sting.
                    else if (familyFlag[1] & 0x80)
                    {
                        Aura* aura = i->second->GetBase();
                        if (aura->GetCasterGUID() != caster->GetGUID())
                            continue;

                        // Search only Serpent Sting, Viper Sting, Scorpid Sting auras
                        flag96 familyFlag = aura->GetSpellInfo()->SpellFamilyFlags;
                        if (!(familyFlag[1] & 0x00000080 || familyFlag[0] & 0x0000C000))
                            continue;
                        if (AuraEffect const* aurEff = aura->GetEffect(0))
                        {
                            // Serpent Sting - Instantly deals 40% of the damage done by your Serpent Sting.
                            if (familyFlag[0] & 0x4000)
                            {
                                int32 TickCount = aurEff->GetTotalTicks();
                                spellId = HUNTER_SPELL_CHIMERA_SHOT_SERPENT;
                                basePoint = caster->SpellDamageBonus(unitTarget, aura->GetSpellInfo(), aurEff->GetAmount(), DOT, aura->GetStackAmount());
                                ApplyPctN(basePoint, TickCount * 40);
                            }
                            // Viper Sting - Instantly restores mana to you equal to 60% of the total amount drained by your Viper Sting.
                            else if (familyFlag[1] & 0x00000080)
                            {
                                int32 TickCount = aura->GetEffect(0)->GetTotalTicks();
                                spellId = HUNTER_SPELL_CHIMERA_SHOT_VIPER;

                                // Amount of one aura tick
                                basePoint = int32(CalculatePctN(unitTarget->GetMaxPower(POWER_MANA), aurEff->GetAmount()));
                                int32 casterBasePoint = aurEff->GetAmount() * unitTarget->GetMaxPower(POWER_MANA) / 50; // TODO: WTF? caster uses unitTarget?
                                if (basePoint > casterBasePoint)
                                    basePoint = casterBasePoint;
                                ApplyPctN(basePoint, TickCount * 60);
                            }
                            // Scorpid Sting - Attempts to Disarm the target for 10 sec. This effect cannot occur more than once per 1 minute.
                            //else if (familyFlag[0] & 0x00008000)
                            else if (familyFlag[0] & 0x8000)
								spellId = HUNTER_SPELL_CHIMERA_SHOT_SCORPID;
                            // ?? nothing say in spell desc (possibly need addition check)
                            //if (familyFlag & 0x0000010000000000LL || // dot
                            //    familyFlag & 0x0000100000000000LL)   // stun
                            //{
                            //    spellId = 53366; // 53366 Chimera Shot - Wyvern
                            //}

                            // Refresh aura duration
                            aura->RefreshDuration();
                            aura->RecalculateAmountOfEffects();
                        }
                        break;
                    }
                    // Scorpid Sting - Attempts to Disarm the target for 10 sec. This effect cannot occur more than once per 1 minute.
                    else if (familyFlag[0] & 0x8000)
                        spellId = HUNTER_SPELL_CHIMERA_SHOT_SCORPID;
                    // ?? nothing say in spell desc (possibly need addition check)
                    //if (familyFlag & 0x0000010000000000LL || // dot
                    //    familyFlag & 0x0000100000000000LL)   // stun
                    //{
                    //    spellId = 53366; // 53366 Chimera Shot - Wyvern
                    //}

                    // Refresh aura duration
                    aura->RefreshDuration();
                }
            }
            if (spellId && caster->ToPlayer())
           {
               if (spellId == HUNTER_SPELL_CHIMERA_SHOT_SCORPID && !caster->ToPlayer()->HasSpellCooldown(spellId))
               {
                   caster->CastSpell(unitTarget, spellId, true);
                   // Scorpid Sting - Add 1 minute cooldown
                   caster->ToPlayer()->AddSpellCooldown(spellId,0,uint32(time(NULL) + 60));
               }
               else
                   caster->CastCustomSpell(unitTarget, spellId, &basePoint, 0, 0, true);
           }
        }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_chimera_shot_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_chimera_shot_SpellScript();
        }
};

// 53412 Invigoration
class spell_hun_invigoration : public SpellScriptLoader
{
    public:
        spell_hun_invigoration() : SpellScriptLoader("spell_hun_invigoration") { }

        class spell_hun_invigoration_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_invigoration_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(HUNTER_SPELL_INVIGORATION_TRIGGERED))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                    if (AuraEffect* aurEff = unitTarget->GetDummyAuraEffect(SPELLFAMILY_HUNTER, 3487, 0))
                        if (roll_chance_i(aurEff->GetAmount()))
                            unitTarget->CastSpell(unitTarget, HUNTER_SPELL_INVIGORATION_TRIGGERED, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_invigoration_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_invigoration_SpellScript();
        }
};

class spell_hun_last_stand_pet : public SpellScriptLoader
{
    public:
        spell_hun_last_stand_pet() : SpellScriptLoader("spell_hun_last_stand_pet") { }

        class spell_hun_last_stand_pet_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_last_stand_pet_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(HUNTER_PET_SPELL_LAST_STAND_TRIGGERED))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                int32 healthModSpellBasePoints0 = int32(caster->CountPctFromMaxHealth(30));
                caster->CastCustomSpell(caster, HUNTER_PET_SPELL_LAST_STAND_TRIGGERED, &healthModSpellBasePoints0, NULL, NULL, true, NULL);
            }

            void Register()
            {
                // add dummy effect spell handler to pet's Last Stand
                OnEffectHitTarget += SpellEffectFn(spell_hun_last_stand_pet_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_last_stand_pet_SpellScript();
        }
};

class spell_hun_masters_call : public SpellScriptLoader
{
    public:
        spell_hun_masters_call() : SpellScriptLoader("spell_hun_masters_call") { }

        class spell_hun_masters_call_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_masters_call_SpellScript);

            bool Validate(SpellInfo const* spellEntry)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(HUNTER_SPELL_MASTERS_CALL_TRIGGERED) || !sSpellMgr->GetSpellInfo(spellEntry->Effects[EFFECT_0].CalcValue()) || !sSpellMgr->GetSpellInfo(spellEntry->Effects[EFFECT_1].CalcValue()))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                {
		  if (target->HasUnitState(UNIT_STATE_CONFUSED | UNIT_STATE_STUNNED | UNIT_STATE_FLEEING))
		    return ;
		  // Cannot be processed while pet is dead
		  TriggerCastFlags castMask = TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_CASTER_AURASTATE);
		  target->CastSpell(target, GetEffectValue(), castMask);
		  target->CastSpell(target, HUNTER_SPELL_MASTERS_CALL_TRIGGERED, castMask);
		  // there is a possibility that this effect should access effect 0 (dummy) target, but i dubt that
		  // it's more likely that on on retail it's possible to call target selector based on dbc values
		  // anyways, we're using GetTargetUnit() here and it's ok
		  if (Unit* ally = GetTargetUnit())
		  {
		    if (ally->HasUnitState(UNIT_STATE_CONFUSED | UNIT_STATE_STUNNED | UNIT_STATE_FLEEING))
		      return ;
		    target->CastSpell(ally, GetEffectValue(), castMask);
		    target->CastSpell(ally, GetSpellInfo()->Effects[EFFECT_0].CalcValue(), castMask);
		  }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_masters_call_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_masters_call_SpellScript();
        }
};

class spell_hun_readiness : public SpellScriptLoader
{
    public:
        spell_hun_readiness() : SpellScriptLoader("spell_hun_readiness") { }

        class spell_hun_readiness_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_readiness_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
	      if (!sSpellMgr)
		return;
                Player* caster = GetCaster()->ToPlayer();
                // immediately finishes the cooldown on your other Hunter abilities except Bestial Wrath
                const SpellCooldowns& cm = caster->ToPlayer()->GetSpellCooldownMap();
                for (SpellCooldowns::const_iterator itr = cm.begin(); itr != cm.end();)
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);

                    ///! If spellId in cooldown map isn't valid, the above will return a null pointer.
                    if (spellInfo &&
                        spellInfo->SpellFamilyName == SPELLFAMILY_HUNTER &&
                        spellInfo->Id != HUNTER_SPELL_READINESS &&
                        spellInfo->Id != HUNTER_SPELL_BESTIAL_WRATH &&
			spellInfo->Id != DRAENEI_SPELL_GIFT_OF_THE_NAARU &&
                        spellInfo->GetRecoveryTime() > 0)
                        caster->RemoveSpellCooldown((itr++)->first, true);
                    else
                        ++itr;
                }
            }

            void Register()
            {
                // add dummy effect spell handler to Readiness
                OnEffectHitTarget += SpellEffectFn(spell_hun_readiness_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_readiness_SpellScript();
        }
};

// 37506 Scatter Shot
class spell_hun_scatter_shot : public SpellScriptLoader
{
    public:
        spell_hun_scatter_shot() : SpellScriptLoader("spell_hun_scatter_shot") { }

        class spell_hun_scatter_shot_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_scatter_shot_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                // break Auto Shot and autohit
                caster->InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
                caster->AttackStop();
                caster->SendAttackSwingCancelAttack();
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_scatter_shot_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_scatter_shot_SpellScript();
        }
};

// 53302, 53303, 53304 Sniper Training
enum eSniperTrainingSpells
{
    SPELL_SNIPER_TRAINING_R1        = 53302,
    SPELL_SNIPER_TRAINING_BUFF_R1   = 64418,
};

class spell_hun_sniper_training : public SpellScriptLoader
{
    public:
        spell_hun_sniper_training() : SpellScriptLoader("spell_hun_sniper_training") { }

        class spell_hun_sniper_training_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_sniper_training_AuraScript);

            bool Validate(SpellInfo const* /*entry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(SPELL_SNIPER_TRAINING_R1) || !sSpellMgr->GetSpellInfo(SPELL_SNIPER_TRAINING_BUFF_R1))
                    return false;
                return true;
            }

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
		if (!sSpellMgr)
		  return;
                if (aurEff->GetAmount() <= 0)
                {
                    Unit* caster = GetCaster();
                    uint32 spellId = SPELL_SNIPER_TRAINING_BUFF_R1 + GetId() - SPELL_SNIPER_TRAINING_R1;
                    if (Unit* target = GetTarget())
                        if (!target->HasAura(spellId))
                        {
                            SpellInfo const* triggeredSpellInfo = sSpellMgr->GetSpellInfo(spellId);
                            Unit* triggerCaster = triggeredSpellInfo->NeedsToBeTriggeredByCaster() ? caster : target;
                            triggerCaster->CastSpell(target, triggeredSpellInfo, true, 0, aurEff);
                        }
                }
            }

            void HandleUpdatePeriodic(AuraEffect* aurEff)
            {
                if (Player* playerTarget = GetUnitOwner()->ToPlayer())
                {
                    int32 baseAmount = aurEff->GetBaseAmount();
                    int32 amount = playerTarget->isMoving() ?
                    playerTarget->CalculateSpellDamage(playerTarget, GetSpellInfo(), aurEff->GetEffIndex(), &baseAmount) :
                    aurEff->GetAmount() - 1;
                    aurEff->SetAmount(amount);
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_hun_sniper_training_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
                OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_hun_sniper_training_AuraScript::HandleUpdatePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_sniper_training_AuraScript();
        }
};

class spell_hun_pet_heart_of_the_phoenix : public SpellScriptLoader
{
    public:
        spell_hun_pet_heart_of_the_phoenix() : SpellScriptLoader("spell_hun_pet_heart_of_the_phoenix") { }

        class spell_hun_pet_heart_of_the_phoenix_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_pet_heart_of_the_phoenix_SpellScript);

            bool Load()
            {
                if (!GetCaster()->isPet())
                    return false;
                return true;
            }

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED) || !sSpellMgr->GetSpellInfo(HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* owner = caster->GetOwner())
                    if (!caster->HasAura(HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF))
                    {
                        owner->CastCustomSpell(HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED, SPELLVALUE_BASE_POINT0, 100, caster, true);
                        caster->CastSpell(caster, HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF, true);
                    }
            }

            void Register()
            {
                // add dummy effect spell handler to pet's Last Stand
                OnEffectHitTarget += SpellEffectFn(spell_hun_pet_heart_of_the_phoenix_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_pet_heart_of_the_phoenix_SpellScript();
        }
};

class spell_hun_pet_carrion_feeder : public SpellScriptLoader
{
    public:
        spell_hun_pet_carrion_feeder() : SpellScriptLoader("spell_hun_pet_carrion_feeder") { }

        class spell_hun_pet_carrion_feeder_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_pet_carrion_feeder_SpellScript);

            bool Load()
            {
                if (!GetCaster()->isPet())
                    return false;
                return true;
            }

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(HUNTER_PET_SPELL_CARRION_FEEDER_TRIGGERED))
                    return false;
                return true;
            }

            SpellCastResult CheckIfCorpseNear()
            {
                Unit* caster = GetCaster();
                float max_range = GetSpellInfo()->GetMaxRange(false);
                WorldObject* result = NULL;
                // search for nearby enemy corpse in range
                Trinity::AnyDeadUnitSpellTargetInRangeCheck check(caster, max_range, GetSpellInfo(), TARGET_SELECT_CHECK_ENEMY);
                Trinity::WorldObjectSearcher<Trinity::AnyDeadUnitSpellTargetInRangeCheck> searcher(caster, result, check);
                caster->GetMap()->VisitFirstFound(caster->m_positionX, caster->m_positionY, max_range, searcher);
                if (!result)
                    return SPELL_FAILED_NO_EDIBLE_CORPSES;
                return SPELL_CAST_OK;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                caster->CastSpell(caster, HUNTER_PET_SPELL_CARRION_FEEDER_TRIGGERED, false);
            }

            void Register()
            {
                // add dummy effect spell handler to pet's Last Stand
                OnEffectHit += SpellEffectFn(spell_hun_pet_carrion_feeder_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnCheckCast += SpellCheckCastFn(spell_hun_pet_carrion_feeder_SpellScript::CheckIfCorpseNear);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_pet_carrion_feeder_SpellScript();
        }
};


// 34477 Misdirection
class spell_hun_misdirection : public SpellScriptLoader
{
    public:
        spell_hun_misdirection() : SpellScriptLoader("spell_hun_misdirection") { }

        class spell_hun_misdirection_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_misdirection_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
		  if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_DEFAULT)
                        caster->SetReducedThreatPercent(0, 0);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_misdirection_AuraScript::OnRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_misdirection_AuraScript();
        }
};

// 35079 Misdirection proc
class spell_hun_misdirection_proc : public SpellScriptLoader
{
    public:
        spell_hun_misdirection_proc() : SpellScriptLoader("spell_hun_misdirection_proc") { }

        class spell_hun_misdirection_proc_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_misdirection_proc_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetCaster())
                    GetCaster()->SetReducedThreatPercent(0, 0);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_misdirection_proc_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_misdirection_proc_AuraScript();
        }
};

class spell_hun_pet_scaling_01 : public SpellScriptLoader
{
    public:
        spell_hun_pet_scaling_01() : SpellScriptLoader("spell_hun_pet_scaling_01") { }

        class spell_hun_pet_scaling_01_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_pet_scaling_01_AuraScript);

            bool Load()
            {
                _tempHealth = 0;
                return true;
            }

            void CalculateStaminaAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isPet())
                        return;

                    Unit* owner = pet->ToPet()->GetOwner();
                    if (!owner)
                        return;

                    float mod = 0.45f;
                    float ownerBonus = 0.0f;

                    PetSpellMap::const_iterator itr = (pet->ToPet()->m_spells.find(62758)); // Wild Hunt rank 1
                    if (itr == pet->ToPet()->m_spells.end())
                        itr = pet->ToPet()->m_spells.find(62762); // Wild Hunt rank 2

                    if (itr != pet->ToPet()->m_spells.end()) // If pet has Wild Hunt
                    {
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first); // Then get the SpellProto and add the dummy effect value
                        mod += (float)((float)(spellInfo->Effects[EFFECT_0].CalcValue()) / 100.0f);
                    }

                    ownerBonus = owner->GetStat(STAT_STAMINA)*mod;

                    amount += ownerBonus;
                }
            }

            void ApplyEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* pet = GetUnitOwner())
                    if (_tempHealth)
                        pet->SetHealth(_tempHealth);
            }

            void RemoveEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* pet = GetUnitOwner())
                    _tempHealth = pet->GetHealth();
            }

            void CalculateAttackPowerAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isPet())
                        return;

                    Unit* owner = pet->ToPet()->GetOwner();
                    if (!owner)
                        return;

                    float mod = 0.22f;                                                 //Hunter contribution modifier
                    float bonusAP = 0.0f;
                    float bonusAPWild = 0.0f;

                    PetSpellMap::const_iterator itr = (pet->ToPet()->m_spells.find(62758)); // Wild Hunt rank 1
                    if (itr == pet->ToPet()->m_spells.end())
                        itr = pet->ToPet()->m_spells.find(62762); // Wild Hunt rank 2

                    if (itr != pet->ToPet()->m_spells.end()) // If pet has Wild Hunt
                    {
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first); // Then get the SpellProto and add the dummy effect value
                        mod += (float)((float)(spellInfo->Effects[EFFECT_1].CalcValue()) / 100.0f);
                    }


                    bonusAP = owner->GetTotalAttackPowerValue(RANGED_ATTACK) * mod;

                    amount += bonusAP;
                }
            }

            void CalculateDamageDoneAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isPet())
                        return;

                    Unit* owner = pet->ToPet()->GetOwner();
                    if (!owner)
                        return;

                    float mod = 1.0f;                                                 //Hunter contribution modifier
                    float bonusDamage = 0.0f;

                    PetSpellMap::const_iterator itr = (pet->ToPet()->m_spells.find(62758)); // Wild Hunt rank 1
                    if (itr == pet->ToPet()->m_spells.end())
                        itr = pet->ToPet()->m_spells.find(62762); // Wild Hunt rank 2

                    if (itr != pet->ToPet()->m_spells.end()) // If pet has Wild Hunt
                    {
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first); // Then get the SpellProto and add the dummy effect value
                        mod += CalculatePctN(1.0f, spellInfo->Effects[EFFECT_1].CalcValue());
                    }

                    bonusDamage = owner->GetTotalAttackPowerValue(RANGED_ATTACK) * 0.1287f * mod;

                    amount += bonusDamage;
		    //		    if (owner->HasAura(25077))
                }
            }

            void Register()
            {
	      OnEffectRemove += AuraEffectRemoveFn(spell_hun_pet_scaling_01_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
	      AfterEffectApply += AuraEffectApplyFn(spell_hun_pet_scaling_01_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_01_AuraScript::CalculateStaminaAmount, EFFECT_0, SPELL_AURA_MOD_STAT);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_01_AuraScript::CalculateAttackPowerAmount, EFFECT_1, SPELL_AURA_MOD_ATTACK_POWER);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_01_AuraScript::CalculateDamageDoneAmount, EFFECT_2, SPELL_AURA_MOD_DAMAGE_DONE);
            }

	private:
	  uint32 _tempHealth;
        };


        AuraScript* GetAuraScript() const
        {
            return new spell_hun_pet_scaling_01_AuraScript();
        }
};

class spell_hun_pet_scaling_02 : public SpellScriptLoader
{
    public:
        spell_hun_pet_scaling_02() : SpellScriptLoader("spell_hun_pet_scaling_02") { }

        class spell_hun_pet_scaling_02_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_pet_scaling_02_AuraScript);

            void CalculateFrostResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isPet())
                        return;

                    Unit* owner = pet->ToPet()->GetOwner();
                    if (!owner)
                        return;

                    float ownerBonus = 0.0f;

                    ownerBonus = CalculatePctN(owner->GetResistance(SPELL_SCHOOL_FROST), 40);

                    amount += ownerBonus;
                }
            }

            void CalculateFireResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isPet())
                        return;

                    Unit* owner = pet->ToPet()->GetOwner();
                    if (!owner)
                        return;

                    float ownerBonus = 0.0f;

                    ownerBonus = CalculatePctN(owner->GetResistance(SPELL_SCHOOL_FIRE), 40);

                    amount += ownerBonus;
                }
            }

            void CalculateNatureResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isPet())
                        return;

                    Unit* owner = pet->ToPet()->GetOwner();
                    if (!owner)
                        return;

                    float ownerBonus = 0.0f;

                    ownerBonus = CalculatePctN(owner->GetResistance(SPELL_SCHOOL_NATURE), 40);

                    amount += ownerBonus;
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_02_AuraScript::CalculateFrostResistanceAmount, EFFECT_1, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_02_AuraScript::CalculateFireResistanceAmount, EFFECT_0, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_02_AuraScript::CalculateNatureResistanceAmount, EFFECT_2, SPELL_AURA_MOD_RESISTANCE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_pet_scaling_02_AuraScript();
        }
};

class spell_hun_pet_scaling_03 : public SpellScriptLoader
{
    public:
        spell_hun_pet_scaling_03() : SpellScriptLoader("spell_hun_pet_scaling_03") { }

        class spell_hun_pet_scaling_03_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_pet_scaling_03_AuraScript);

            void CalculateShadowResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isPet())
                        return;

                    Unit* owner = pet->ToPet()->GetOwner();
                    if (!owner)
                        return;

                    float ownerBonus = 0.0f;

                    ownerBonus = CalculatePctN(owner->GetResistance(SPELL_SCHOOL_SHADOW), 40);

                    amount += ownerBonus;
                }
            }

            void CalculateArcaneResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isPet())
                        return;

                    Unit* owner = pet->ToPet()->GetOwner();
                    if (!owner)
                        return;

                    float ownerBonus = 0.0f;

                    ownerBonus = CalculatePctN(owner->GetResistance(SPELL_SCHOOL_ARCANE), 40);

                    amount += ownerBonus;
                }
            }

            void CalculateArmorAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isPet())
                        return;

                    Unit* owner = pet->ToPet()->GetOwner();
                    if (!owner)
                        return;

                    float ownerBonus = 0.0f;

                    ownerBonus = CalculatePctN(owner->GetArmor(), 35);

                    amount += ownerBonus;
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_03_AuraScript::CalculateShadowResistanceAmount, EFFECT_0, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_03_AuraScript::CalculateArcaneResistanceAmount, EFFECT_1, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_03_AuraScript::CalculateArmorAmount, EFFECT_2, SPELL_AURA_MOD_RESISTANCE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_pet_scaling_03_AuraScript();
        }
};

class spell_hun_pet_scaling_04 : public SpellScriptLoader
{
    public:
        spell_hun_pet_scaling_04() : SpellScriptLoader("spell_hun_pet_scaling_04") { }

        class spell_hun_pet_scaling_04_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_pet_scaling_04_AuraScript);

            bool Load()
            {
                if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                    return false;
                return true;
            }

            void CalculateAmountMeleeHit(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;
                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    // For others recalculate it from:
                    float HitMelee = 0.0f;
                    // Increase hit from SPELL_AURA_MOD_HIT_CHANCE
                    HitMelee += owner->GetTotalAuraModifier(SPELL_AURA_MOD_HIT_CHANCE);
                    // Increase hit melee from meele hit ratings
                    HitMelee += owner->GetRatingBonusValue(CR_HIT_MELEE);

                    amount += int32(HitMelee);
                }
            }

            void CalculateAmountSpellHit(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;
                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    // For others recalculate it from:
                    float HitSpell = 0.0f;
                    // Increase hit from SPELL_AURA_MOD_SPELL_HIT_CHANCE
                    HitSpell += owner->GetTotalAuraModifier(SPELL_AURA_MOD_SPELL_HIT_CHANCE);
                    // Increase hit spell from spell hit ratings
                    HitSpell += owner->GetRatingBonusValue(CR_HIT_SPELL);

                    amount += int32(HitSpell);
                }
            }

            void CalculateAmountExpertise(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;
                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    // For others recalculate it from:
                    float Expertise = 0.0f;
                    // Increase hit from SPELL_AURA_MOD_EXPERTISE
                    Expertise += owner->GetTotalAuraModifier(SPELL_AURA_MOD_EXPERTISE);
                    // Increase Expertise from Expertise ratings
                    Expertise += owner->GetRatingBonusValue(CR_EXPERTISE);

                    amount += int32(Expertise);
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_04_AuraScript::CalculateAmountMeleeHit, EFFECT_0, SPELL_AURA_MOD_HIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_04_AuraScript::CalculateAmountSpellHit, EFFECT_1, SPELL_AURA_MOD_SPELL_HIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_04_AuraScript::CalculateAmountExpertise, EFFECT_2, SPELL_AURA_MOD_EXPERTISE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_pet_scaling_04_AuraScript();
        }
};

class spell_hun_pet_passive_crit : public SpellScriptLoader
{
    public:
        spell_hun_pet_passive_crit() : SpellScriptLoader("spell_hun_pet_passive_crit") { }

        class spell_hun_pet_passive_crit_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_pet_passive_crit_AuraScript);

            bool Load()
            {
                if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                    return false;
                return true;
            }

            void CalculateAmountCritSpell(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;
		return ;
                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    // For others recalculate it from:
                    float CritMelee = 0.0f;
		    if (GetCaster()->HasAura(53205))
		    {
		      SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(53205); // Then get the SpellProto and add the dummy effect values
		      CritMelee += (float)((float)(spellInfo->Effects[EFFECT_0].CalcValue()) / 100.0f);
		    }
		    else if (GetCaster()->HasAura(53204))
                    {
                      SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(53204); // Then get the SpellProto and add the dummy effect values
                      CritMelee += (float)((float)(spellInfo->Effects[EFFECT_0].CalcValue()) / 100.0f);
                    }
		    else if (GetCaster()->HasAura(53203))
                    {
                      SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(53203); // Then get the SpellProto and add the dummy effect values
                      CritMelee += (float)((float)(spellInfo->Effects[EFFECT_0].CalcValue()) / 100.0f);
                    }

                    amount += CritMelee;
                }
            }

            void CalculateAmountCritMelee(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;
		return ;
                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    // For others recalculate it from:
                    float CritMelee = 0.0f;
		    if (GetCaster()->HasAura(53205))
		    {
		      SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(53205); // Then get the SpellProto and add the dummy effect values
		      CritMelee += (float)((float)(spellInfo->Effects[EFFECT_0].CalcValue()) / 100.0f);
		      std::cout << "MELEE CRIT END " << CritMelee << std::endl;
		    }
		    else if (GetCaster()->HasAura(53204))
                    {
                      SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(53204); // Then get the SpellProto and add the dummy effect values
                      CritMelee += (float)((float)(spellInfo->Effects[EFFECT_0].CalcValue()) / 100.0f);
                    }
		    else if (GetCaster()->HasAura(53203))
                    {
                      SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(53203); // Then get the SpellProto and add the dummy effect values
                      CritMelee += (float)((float)(spellInfo->Effects[EFFECT_0].CalcValue()) / 100.0f);
                    }
                    amount += CritMelee;
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_passive_crit_AuraScript::CalculateAmountCritSpell, EFFECT_1, SPELL_AURA_MOD_SPELL_CRIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_passive_crit_AuraScript::CalculateAmountCritMelee, EFFECT_0, SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_pet_passive_crit_AuraScript();
        }
};

class spell_hun_pet_passive_damage_done : public SpellScriptLoader
{
    public:
        spell_hun_pet_passive_damage_done() : SpellScriptLoader("spell_hun_pet_passive_damage_done") { }

        class spell_hun_pet_passive_damage_done_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_pet_passive_damage_done_AuraScript);

            bool Load()
            {
                if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                    return false;
                return true;
            }

            void CalculateAmountDamageDone(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;
                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    //  Pet's base damage changes depending on happiness
                    if (GetCaster()->isPet() && GetCaster()->ToPet()->isHunterPet())
                    {
                        switch (GetCaster()->ToPet()->GetHappinessState())
                        {
                            case HAPPY:
                                // 125% of normal damage
                                amount += 25.0f;
                                break;
                            case CONTENT:
                                // 100% of normal damage, nothing to modify
                                break;
                            case UNHAPPY:
                                // 75% of normal damage
                                amount += -25.0f;
                                break;
                        }
                    }
		    // Cobra Reflexes
		    if (AuraEffect* cobraReflexes = GetCaster()->GetAuraEffectOfRankedSpell(61682, EFFECT_0))
		      amount -= cobraReflexes->GetAmount();
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_passive_damage_done_AuraScript::CalculateAmountDamageDone, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_pet_passive_damage_done_AuraScript();
        }
};

class spell_hun_animal_handler : public SpellScriptLoader
{
    public:
        spell_hun_animal_handler() : SpellScriptLoader("spell_hun_animal_handler") { }

        class spell_hun_animal_handler_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_animal_handler_AuraScript);

            bool Load()
            {
                if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                    return false;
                return true;
            }

            void CalculateAmountDamageDone(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;
                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    if (AuraEffect* aurEffect = owner->GetAuraEffectOfRankedSpell(HUNTER_SPELL_ANIMAL_HANDLER, EFFECT_1))
                        amount = aurEffect->GetAmount();
                    else
                        amount = 0;
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_animal_handler_AuraScript::CalculateAmountDamageDone, EFFECT_0, SPELL_AURA_MOD_ATTACK_POWER_PCT);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_animal_handler_AuraScript();
        }
};

class spell_hun_kill_command : public SpellScriptLoader
{
public:
    spell_hun_kill_command() : SpellScriptLoader("spell_hun_kill_command") { }

    class spell_hun_kill_command_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hun_kill_command_AuraScript)
        void ApplyEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* m_target = GetTarget())
            {
                if (GetCaster()->HasAura(HUNTER_SPELL_FOCUSED_FIRE_2))
                    m_target->CastSpell(m_target, HUNTER_SPELL_KILL_COMMAND_CRIT_20, true);
                else if (GetCaster()->HasAura(HUNTER_SPELL_FOCUSED_FIRE_1))
                    m_target->CastSpell(m_target, HUNTER_SPELL_KILL_COMMAND_CRIT_10, true);
            }

        }

        void RemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* m_target = GetTarget())
            {
                m_target->RemoveAurasDueToSpell(HUNTER_SPELL_KILL_COMMAND_CRIT_10);
                m_target->RemoveAurasDueToSpell(HUNTER_SPELL_KILL_COMMAND_CRIT_20);
            }
        }

        void Register()
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_hun_kill_command_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_ADD_PCT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
            OnEffectApply += AuraEffectApplyFn(spell_hun_kill_command_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_ADD_PCT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_hun_kill_command_AuraScript();
    }
};

void AddSC_hunter_spell_scripts()
{
    new spell_hun_aspect_of_the_beast();
    new spell_hun_chimera_shot();
    new spell_hun_invigoration();
    new spell_hun_last_stand_pet();
    new spell_hun_masters_call();
    new spell_hun_readiness();
    new spell_hun_scatter_shot();
    new spell_hun_sniper_training();
    new spell_hun_pet_heart_of_the_phoenix();
    new spell_hun_pet_carrion_feeder();
    new spell_hun_misdirection();
    new spell_hun_misdirection_proc();
    new spell_hun_pet_scaling_01();
    new spell_hun_pet_scaling_02();
    new spell_hun_pet_scaling_03();
    new spell_hun_pet_scaling_04();
    new spell_hun_pet_passive_crit();
    new spell_hun_pet_passive_damage_done();
    new spell_hun_animal_handler();
    new spell_hun_kill_command();
}
