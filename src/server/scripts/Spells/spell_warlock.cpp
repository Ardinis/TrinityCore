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
 * Scripts for spells with SPELLFAMILY_WARLOCK and SPELLFAMILY_GENERIC spells used by warlock players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_warl_".
 */

#include "SpellScript.h"
#include "Vehicle.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "GridNotifiers.h"
#include "SpellScript.h"
#include "ScriptMgr.h"
#include "CreatureAIImpl.h"

enum WarlockSpells
{
    WARLOCK_DEMONIC_EMPOWERMENT_SUCCUBUS    = 54435,
    WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER  = 54443,
    WARLOCK_DEMONIC_EMPOWERMENT_FELGUARD    = 54508,
    WARLOCK_DEMONIC_EMPOWERMENT_FELHUNTER   = 54509,
    WARLOCK_DEMONIC_EMPOWERMENT_IMP         = 54444,
    WARLOCK_IMPROVED_HEALTHSTONE_R1         = 18692,
    WARLOCK_IMPROVED_HEALTHSTONE_R2         = 18693,
	WARLOCK_FELHUNTER_SHADOWBITE_R1         = 54049,
	WARLOCK_FELHUNTER_SHADOWBITE_R2         = 54050,
	WARLOCK_FELHUNTER_SHADOWBITE_R3         = 54051,
	WARLOCK_FELHUNTER_SHADOWBITE_R4         = 54052,
	WARLOCK_FELHUNTER_SHADOWBITE_R5         = 54053,
	WARLOCK_IMPROVED_FELHUNTER_R1           = 54037,
	WARLOCK_IMPROVED_FELHUNTER_R2           = 54038,
	WARLOCK_IMPROVED_FELHUNTER_EFFECT       = 54425,

    WARLOCK_PET_PASSIVE                     = 35695,
    WARLOCK_DEMONIC_TACTICS                 = 30242,
    WARLOCK_AVOIDANCE_PASSIVE               = 32233,

    ENTRY_IMP                               = 416,
    ENTRY_VOIDWALKER                        = 1860,
    ENTRY_SUCCUBUS                          = 1863,
    ENTRY_FELHUNTER                         = 417,
    ENTRY_FELGUARD                          = 17252,
    ENTRY_DOOMGUARD                         = 11859
};

// 47193 Demonic Empowerment
class spell_warl_demonic_empowerment : public SpellScriptLoader
{
    public:
        spell_warl_demonic_empowerment() : SpellScriptLoader("spell_warl_demonic_empowerment") { }

        class spell_warl_demonic_empowerment_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_demonic_empowerment_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(WARLOCK_DEMONIC_EMPOWERMENT_SUCCUBUS) || !sSpellMgr->GetSpellInfo(WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER) || !sSpellMgr->GetSpellInfo(WARLOCK_DEMONIC_EMPOWERMENT_FELGUARD) || !sSpellMgr->GetSpellInfo(WARLOCK_DEMONIC_EMPOWERMENT_FELHUNTER) || !sSpellMgr->GetSpellInfo(WARLOCK_DEMONIC_EMPOWERMENT_IMP))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
	      if (!sSpellMgr)
		return;
                if (Creature* targetCreature = GetHitCreature())
                {
                    if (targetCreature->isPet())
                    {
                        CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(targetCreature->GetEntry());
                        switch (ci->family)
                        {
                        case CREATURE_FAMILY_SUCCUBUS:
                            targetCreature->CastSpell(targetCreature, WARLOCK_DEMONIC_EMPOWERMENT_SUCCUBUS, true);
                            break;
                        case CREATURE_FAMILY_VOIDWALKER:
                        {
                            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER);
                            int32 hp = int32(targetCreature->CountPctFromMaxHealth(GetCaster()->CalculateSpellDamage(targetCreature, spellInfo, 0)));
                            targetCreature->CastCustomSpell(targetCreature, WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER, &hp, NULL, NULL, true);
                            //unitTarget->CastSpell(unitTarget, 54441, true);
                            break;
                        }
                        case CREATURE_FAMILY_FELGUARD:
                            targetCreature->CastSpell(targetCreature, WARLOCK_DEMONIC_EMPOWERMENT_FELGUARD, true);
                            break;
                        case CREATURE_FAMILY_FELHUNTER:
                            targetCreature->CastSpell(targetCreature, WARLOCK_DEMONIC_EMPOWERMENT_FELHUNTER, true);
                            break;
                        case CREATURE_FAMILY_IMP:
                            targetCreature->CastSpell(targetCreature, WARLOCK_DEMONIC_EMPOWERMENT_IMP, true);
                            break;
                        }
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_demonic_empowerment_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_demonic_empowerment_SpellScript();
        }
};

// 6201 Create Healthstone (and ranks)
class spell_warl_create_healthstone : public SpellScriptLoader
{
    public:
        spell_warl_create_healthstone() : SpellScriptLoader("spell_warl_create_healthstone") { }

        class spell_warl_create_healthstone_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_create_healthstone_SpellScript);

            static uint32 const iTypes[8][3];

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(WARLOCK_IMPROVED_HEALTHSTONE_R1) || !sSpellMgr->GetSpellInfo(WARLOCK_IMPROVED_HEALTHSTONE_R2))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
	      if (!sSpellMgr)
		return;
                if (Unit* unitTarget = GetHitUnit())
                {
                    uint32 rank = 0;
                    // Improved Healthstone
                    if (AuraEffect const* aurEff = unitTarget->GetDummyAuraEffect(SPELLFAMILY_WARLOCK, 284, 0))
                    {
                        switch (aurEff->GetId())
                        {
                            case WARLOCK_IMPROVED_HEALTHSTONE_R1: rank = 1; break;
                            case WARLOCK_IMPROVED_HEALTHSTONE_R2: rank = 2; break;
                            default:
                                sLog->outError("Unknown rank of Improved Healthstone id: %d", aurEff->GetId());
                                break;
                        }
                    }
                    uint8 spellRank = sSpellMgr->GetSpellRank(GetSpellInfo()->Id);
                    if (spellRank > 0 && spellRank <= 8)
                        CreateItem(effIndex, iTypes[spellRank - 1][rank]);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_create_healthstone_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_create_healthstone_SpellScript();
        }
};

uint32 const spell_warl_create_healthstone::spell_warl_create_healthstone_SpellScript::iTypes[8][3] = {
    { 5512, 19004, 19005},              // Minor Healthstone
    { 5511, 19006, 19007},              // Lesser Healthstone
    { 5509, 19008, 19009},              // Healthstone
    { 5510, 19010, 19011},              // Greater Healthstone
    { 9421, 19012, 19013},              // Major Healthstone
    {22103, 22104, 22105},              // Master Healthstone
    {36889, 36890, 36891},              // Demonic Healthstone
    {36892, 36893, 36894}               // Fel Healthstone
};

// 47422 Everlasting Affliction
class spell_warl_everlasting_affliction : public SpellScriptLoader
{
    public:
        spell_warl_everlasting_affliction() : SpellScriptLoader("spell_warl_everlasting_affliction") { }

        class spell_warl_everlasting_affliction_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_everlasting_affliction_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                    // Refresh corruption on target
                    if (AuraEffect* aur = unitTarget->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_WARLOCK, 0x2, 0, 0, GetCaster()->GetGUID()))
                        aur->GetBase()->RefreshDuration();
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_everlasting_affliction_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_everlasting_affliction_SpellScript();
        }
};

// 18541 Ritual of Doom Effect
class spell_warl_ritual_of_doom_effect : public SpellScriptLoader
{
public:
    spell_warl_ritual_of_doom_effect() : SpellScriptLoader("spell_warl_ritual_of_doom_effect") { }

    class spell_warl_ritual_of_doom_effect_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_warl_ritual_of_doom_effect_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            caster->CastSpell(caster, GetEffectValue(), true);
        }

        void Register()
        {
            OnEffectHit += SpellEffectFn(spell_warl_ritual_of_doom_effect_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_warl_ritual_of_doom_effect_SpellScript();
    }
};

class spell_warl_seed_of_corruption : public SpellScriptLoader
{
    public:
        spell_warl_seed_of_corruption() : SpellScriptLoader("spell_warl_seed_of_corruption") { }

        class spell_warl_seed_of_corruption_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_seed_of_corruption_SpellScript);

            void FilterTargets(std::list<Unit*>& unitList)
            {
                if (GetTargetUnit())
                    unitList.remove(GetTargetUnit());
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_warl_seed_of_corruption_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_seed_of_corruption_SpellScript();
        }
};

// Shadow Bite
class spell_warl_shadow_bite : public SpellScriptLoader
{
public:
    spell_warl_shadow_bite() : SpellScriptLoader("spell_warl_shadow_bite") { }

    class spell_warl_shadow_bite_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_warl_shadow_bite_SpellScript)
        bool Validate(SpellInfo const * /*spellEntry*/)
        {
	  if (!sSpellMgr)
	    return false;
            if (!sSpellMgr->GetSpellInfo(WARLOCK_FELHUNTER_SHADOWBITE_R1))
                return false;
            if (!sSpellMgr->GetSpellInfo(WARLOCK_FELHUNTER_SHADOWBITE_R2))
                return false;
            if (!sSpellMgr->GetSpellInfo(WARLOCK_FELHUNTER_SHADOWBITE_R3))
                return false;
            if (!sSpellMgr->GetSpellInfo(WARLOCK_FELHUNTER_SHADOWBITE_R4))
                return false;
            if (!sSpellMgr->GetSpellInfo(WARLOCK_FELHUNTER_SHADOWBITE_R5))
                return false;
            if (!sSpellMgr->GetSpellInfo(WARLOCK_IMPROVED_FELHUNTER_R1))
                return false;
            if (!sSpellMgr->GetSpellInfo(WARLOCK_IMPROVED_FELHUNTER_R2))
                return false;
            if (!sSpellMgr->GetSpellInfo(WARLOCK_IMPROVED_FELHUNTER_EFFECT))
                return false;
            return true;
        }

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            //Unit *caster = GetCaster();
            // Get DoTs on target by owner (15% increase by dot)
            // need to get this here from SpellEffects.cpp ?
            // damage *= float(100.f  15.f * caster->getVictim()->GetDoTsByCaster(caster->GetOwnerGUID())) / 100.f;
        }

        // For Improved Felhunter
        void HandleAfterHitEffect()
        {
            Unit *caster = GetCaster();
            if(!caster) { return; };

            // break if our caster is not a pet
            if(!(caster->GetTypeId() == TYPEID_UNIT && caster->ToCreature()->isPet())) { return; };

            // break if pet has no owner and/or owner is not a player
            Unit *owner = caster->GetOwner();
            if(!(owner && (owner->GetTypeId() == TYPEID_PLAYER))) { return; };

            int32 amount;
            // rank 1 - 4%
            if(owner->HasAura(WARLOCK_IMPROVED_FELHUNTER_R1)) { amount = 5; };

            // rank 2 - 8%
            if(owner->HasAura(WARLOCK_IMPROVED_FELHUNTER_R2)) { amount = 9; };

            // Finally return the Mana to our Caster
            if(AuraEffect * aurEff = owner->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_WARLOCK, 214, 0))
                caster->CastCustomSpell(caster,WARLOCK_IMPROVED_FELHUNTER_EFFECT,&amount,NULL,NULL,true,NULL,aurEff,caster->GetGUID());
        }

        void Register()
        {
            //OnEffectHitTarget = SpellEffectFn(spell_warl_shadow_bite_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            AfterHit += SpellHitFn(spell_warl_shadow_bite_SpellScript::HandleAfterHitEffect);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_warl_shadow_bite_SpellScript();
    }
};

class spell_warl_banish : public SpellScriptLoader
{
    public:
        spell_warl_banish() : SpellScriptLoader("spell_warl_banish") { }

        class spell_warl_banish_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_banish_SpellScript);

            bool Load()
            {
                _removed = false;
                return true;
            }

            void HandleBanish()
            {
                if (Unit* target = GetHitUnit())
                {
                    if (target->GetAuraEffect(SPELL_AURA_SCHOOL_IMMUNITY, SPELLFAMILY_WARLOCK, 0, 0x08000000, 0))
                    {
                        //No need to remove old aura since its removed due to not stack by current Banish aura
                        PreventHitDefaultEffect(EFFECT_0);
                        PreventHitDefaultEffect(EFFECT_1);
                        PreventHitDefaultEffect(EFFECT_2);
                        _removed = true;
                    }
                }
            }

            void RemoveAura()
            {
                if (_removed)
                    PreventHitAura();
            }

            void Register()
            {
                BeforeHit += SpellHitFn(spell_warl_banish_SpellScript::HandleBanish);
                AfterHit += SpellHitFn(spell_warl_banish_SpellScript::RemoveAura);
            }

            bool _removed;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_warl_banish_SpellScript();
        }
};

class spell_warl_demonic_circle_summon : public SpellScriptLoader
{
public:
    spell_warl_demonic_circle_summon() : SpellScriptLoader("spell_warl_demonic_circle_summon") { }

    class spell_warl_demonic_circle_summon_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_warl_demonic_circle_summon_SpellScript)

        SpellCastResult CheckIfInvalidPosition()
        {
            Unit* caster = GetCaster();
            switch (caster->GetMapId())
            {
                case 617: // Dalaran Sewers
                    // casting on starting pipes
                    if (caster->GetPositionZ() > 13.0f)
                        return SPELL_FAILED_NOT_HERE;
                    break;
                case 618: // Ring of Valor
                    if(caster->GetDistance2d(763.632385f, -306.162384f) < 1.5f || // casting over a small pilar
                        caster->GetDistance2d(763.611145f, -261.856750f) < 1.5f ||
                        caster->GetDistance2d(723.644287f, -284.493256f) < 4.0f || // casting over a big pilar
                        caster->GetDistance2d(802.211609f, -284.493256f) < 4.0f ||
                        caster->GetPositionZ() < 28.0f) // casting on the elevator
                        return SPELL_FAILED_NOT_HERE;
                    break;
            }

            return SPELL_CAST_OK;
        }

        void Register()
        {
            OnCheckCast += SpellCheckCastFn(spell_warl_demonic_circle_summon_SpellScript::CheckIfInvalidPosition);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_warl_demonic_circle_summon_SpellScript();
    }
};

class spell_warl_pet_scaling_01 : public SpellScriptLoader
{
      public:
          spell_warl_pet_scaling_01() : SpellScriptLoader("spell_warl_pet_scaling_01") { }

          class spell_warl_pet_scaling_01_AuraScript : public AuraScript
          {
              PrepareAuraScript(spell_warl_pet_scaling_01_AuraScript);

              bool Load()
              {
                  if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                      return false;
                  _tempBonus = 0;
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

                      float ownerBonus = 0.0f;

                      ownerBonus = CalculatePctN(owner->GetStat(STAT_STAMINA), 75);

                      amount += ownerBonus;
                 }
              }


              void ApplyEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
              {
                  if (Unit* pet = GetUnitOwner())
                      if (_tempBonus)
                      {
                          if (PetLevelInfo const* pInfo = sObjectMgr->GetPetLevelInfo(pet->GetEntry(), pet->getLevel()))
                          {
                              uint32 healthMod = 0;
                              uint32 baseHealth = pInfo->health;
                              switch (pet->GetEntry())
                              {
                                  case ENTRY_IMP:
                                      healthMod = uint32(_tempBonus * 8.4f);
                                      break;
                                  case ENTRY_FELGUARD:
                                  case ENTRY_VOIDWALKER:
                                      healthMod = _tempBonus * 11;
                                      break;
                                  case ENTRY_SUCCUBUS:
                                      healthMod = uint32(_tempBonus * 9.1f);
                                      break;
                                  case ENTRY_FELHUNTER:
                                      healthMod = uint32(_tempBonus * 9.5f);
                                      break;
                                  default:
                                      healthMod = 0;
                                      break;
                              }
                              if (healthMod)
                                  pet->ToPet()->SetCreateHealth(baseHealth + healthMod);
                          }
                      }
              }

              void RemoveEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
              {
                  if (Unit* pet = GetUnitOwner())
                      if (pet->isPet() && pet->ToPet())
                      {
                          if (PetLevelInfo const* pInfo = sObjectMgr->GetPetLevelInfo(pet->GetEntry(), pet->getLevel()))
                              pet->ToPet()->SetCreateHealth(pInfo->health);
                      }
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
                      int32 fire  = int32(owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_FIRE)) - owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + SPELL_SCHOOL_FIRE);
                      int32 shadow = int32(owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_SHADOW)) - owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + SPELL_SCHOOL_SHADOW);
                      int32 maximum  = (fire > shadow) ? fire : shadow;
                      if (maximum < 0)
                          maximum = 0;
                      float bonusAP = maximum * 0.57f;

                      amount += bonusAP;

                      // Glyph of felguard
                      if (pet->GetEntry() == ENTRY_FELGUARD)
                      {
                          if (AuraEffect* aurEffect = owner->GetAuraEffect(56246, EFFECT_0))
                          {
                              float base_attPower = pet->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE) * pet->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_PCT);
                              amount += CalculatePctN(amount + base_attPower, aurEffect->GetAmount());
                          }
                      }
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

                      //the damage bonus used for pets is either fire or shadow damage, whatever is higher
                      int32 fire  = int32(owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_FIRE)) - owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + SPELL_SCHOOL_FIRE);
                      int32 shadow = int32(owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_SHADOW)) - owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + SPELL_SCHOOL_SHADOW);
                      int32 maximum  = (fire > shadow) ? fire : shadow;
                      if (maximum < 0)
                          maximum = 0;
                      float bonusDamage = maximum * 0.15f;

                      amount += bonusDamage;
                    }
              }


              void Register()
              {
                  OnEffectRemove += AuraEffectRemoveFn(spell_warl_pet_scaling_01_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                  AfterEffectApply += AuraEffectApplyFn(spell_warl_pet_scaling_01_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                  DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_01_AuraScript::CalculateStaminaAmount, EFFECT_0, SPELL_AURA_MOD_STAT);
                  DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_01_AuraScript::CalculateAttackPowerAmount, EFFECT_1, SPELL_AURA_MOD_ATTACK_POWER);
                  DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_01_AuraScript::CalculateDamageDoneAmount, EFFECT_2, SPELL_AURA_MOD_DAMAGE_DONE);
              }

          private:
              uint32 _tempBonus;

         };

          AuraScript* GetAuraScript() const
          {
              return new spell_warl_pet_scaling_01_AuraScript();
          }
 };

 class spell_warl_pet_scaling_02 : public SpellScriptLoader
{
      public:
          spell_warl_pet_scaling_02() : SpellScriptLoader("spell_warl_pet_scaling_02") { }

          class spell_warl_pet_scaling_02_AuraScript : public AuraScript
          {
              PrepareAuraScript(spell_warl_pet_scaling_02_AuraScript);

              bool Load()
              {
                  if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                      return false;
                  _tempBonus = 0;
                  return true;
              }

              void CalculateIntellectAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
              {
                  if (Unit* pet = GetUnitOwner())
                    {
                          if (!pet->isPet())
	                        return;

                      Unit* owner = pet->ToPet()->GetOwner();
                     if (!owner)
                           return;

                      float ownerBonus = 0.0f;

                      ownerBonus = CalculatePctN(owner->GetStat(STAT_INTELLECT), 30);

                      amount += ownerBonus;
                 }
              }

              void ApplyEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
              {
                  if (Unit* pet = GetUnitOwner())
                      if (pet->isPet() && pet->ToPet())
                          if (_tempBonus)
                          {
                              if (PetLevelInfo const* pInfo = sObjectMgr->GetPetLevelInfo(pet->GetEntry(), pet->getLevel()))
                              {
                                  uint32 manaMod = 0;
                                  uint32 baseMana = pInfo->mana;
                                  switch (pet->GetEntry())
                                  {
                                  case ENTRY_IMP:
                                      manaMod = uint32(_tempBonus * 4.9f);
                                      break;
                                  case ENTRY_VOIDWALKER:
                                  case ENTRY_SUCCUBUS:
                                  case ENTRY_FELHUNTER:
                                  case ENTRY_FELGUARD:
                                      manaMod = uint32(_tempBonus * 11.5f);
                                      break;
                                  default:
                                      manaMod = 0;
                                      break;
                                  }
                                  if (manaMod)
                                      pet->ToPet()->SetCreateMana(baseMana + manaMod);
                              }
                          }
              }

              void RemoveEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
              {
                  if (Unit* pet = GetUnitOwner())
                      if (pet->isPet() && pet->ToPet())
                      {
                          if (PetLevelInfo const* pInfo = sObjectMgr->GetPetLevelInfo(pet->GetEntry(), pet->getLevel()))
                              pet->ToPet()->SetCreateMana(pInfo->mana);
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

              void Register()
              {
                  OnEffectRemove += AuraEffectRemoveFn(spell_warl_pet_scaling_02_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                  AfterEffectApply += AuraEffectApplyFn(spell_warl_pet_scaling_02_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                  DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_02_AuraScript::CalculateIntellectAmount, EFFECT_0, SPELL_AURA_MOD_STAT);
                  DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_02_AuraScript::CalculateArmorAmount, EFFECT_1, SPELL_AURA_MOD_RESISTANCE);
                  DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_02_AuraScript::CalculateFireResistanceAmount, EFFECT_2, SPELL_AURA_MOD_RESISTANCE);
              }

          private:
              uint32 _tempBonus;

          };

  AuraScript* GetAuraScript() const
  {
    return new spell_warl_pet_scaling_02_AuraScript();
  }
 };

class spell_warl_pet_scaling_03 : public SpellScriptLoader
{
public:
    spell_warl_pet_scaling_03() : SpellScriptLoader("spell_warl_pet_scaling_03") { }

    class spell_warl_pet_scaling_03_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warl_pet_scaling_03_AuraScript);

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
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_03_AuraScript::CalculateFrostResistanceAmount, EFFECT_0, SPELL_AURA_MOD_RESISTANCE);
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_03_AuraScript::CalculateArcaneResistanceAmount, EFFECT_1, SPELL_AURA_MOD_RESISTANCE);
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_03_AuraScript::CalculateNatureResistanceAmount, EFFECT_2, SPELL_AURA_MOD_RESISTANCE);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_warl_pet_scaling_03_AuraScript();
    }
};


class spell_warl_pet_scaling_04 : public SpellScriptLoader
{
public:
  spell_warl_pet_scaling_04() : SpellScriptLoader("spell_warl_pet_scaling_04") { }

  class spell_warl_pet_scaling_04_AuraScript : public AuraScript
  {
    PrepareAuraScript(spell_warl_pet_scaling_04_AuraScript);

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

    void Register()
    {
      DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_04_AuraScript::CalculateShadowResistanceAmount, EFFECT_0, SPELL_AURA_MOD_RESISTANCE);
    }
  };

  AuraScript* GetAuraScript() const
  {
    return new spell_warl_pet_scaling_04_AuraScript();
  }
};

class spell_warl_pet_scaling_05 : public SpellScriptLoader
{
public:
  spell_warl_pet_scaling_05() : SpellScriptLoader("spell_warl_pet_scaling_05") { }

  class spell_warl_pet_scaling_05_AuraScript : public AuraScript
  {
    PrepareAuraScript(spell_warl_pet_scaling_05_AuraScript);

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
	// Increase hit from SPELL_AURA_MOD_SPELL_HIT_CHANCE
	HitMelee += owner->GetTotalAuraModifier(SPELL_AURA_MOD_SPELL_HIT_CHANCE);
	// Increase hit spell from spell hit ratings
	HitMelee += owner->GetRatingBonusValue(CR_HIT_SPELL);

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
          // Increase hit from SPELL_AURA_MOD_SPELL_HIT_CHANCE
          Expertise += owner->GetTotalAuraModifier(SPELL_AURA_MOD_SPELL_HIT_CHANCE);
          // Increase hit spell from spell hit ratings
          Expertise += owner->GetRatingBonusValue(CR_HIT_SPELL);

          amount += int32(Expertise);
      }
    }

    void Register()
    {
      DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_05_AuraScript::CalculateAmountMeleeHit, EFFECT_0, SPELL_AURA_MOD_HIT_CHANCE);
      DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_05_AuraScript::CalculateAmountSpellHit, EFFECT_1, SPELL_AURA_MOD_SPELL_HIT_CHANCE);
      DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_05_AuraScript::CalculateAmountExpertise, EFFECT_2, SPELL_AURA_MOD_EXPERTISE);
    }
  };

  AuraScript* GetAuraScript() const
  {
    return new spell_warl_pet_scaling_05_AuraScript();
  }
};

class spell_warl_pet_passive : public SpellScriptLoader
{
public:
  spell_warl_pet_passive() : SpellScriptLoader("spell_warl_pet_passive") { }

  class spell_warl_pet_passive_AuraScript : public AuraScript
  {
    PrepareAuraScript(spell_warl_pet_passive_AuraScript);

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
        if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
        {
            // For others recalculate it from:
            float CritSpell = 0.0f;
            // Crit from Intellect
            CritSpell += owner->GetSpellCritFromIntellect();
            // Increase crit from SPELL_AURA_MOD_SPELL_CRIT_CHANCE
            CritSpell += owner->GetTotalAuraModifier(SPELL_AURA_MOD_SPELL_CRIT_CHANCE);
            // Increase crit from SPELL_AURA_MOD_CRIT_PCT
            CritSpell += owner->GetTotalAuraModifier(SPELL_AURA_MOD_CRIT_PCT);
            // Increase crit spell from spell crit ratings
            CritSpell += owner->GetRatingBonusValue(CR_CRIT_SPELL);

            if (AuraApplication* improvedDemonicTacticsApp = owner->GetAuraApplicationOfRankedSpell(54347))
                if (Aura* improvedDemonicTactics = improvedDemonicTacticsApp->GetBase())
                  if (AuraEffect* improvedDemonicTacticsEffect = improvedDemonicTactics->GetEffect(EFFECT_0))
                      amount += CalculatePctN(CritSpell, improvedDemonicTacticsEffect->GetAmount());
      }
    }

    void CalculateAmountCritMelee(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
      if (!GetCaster() || !GetCaster()->GetOwner())
	return;
      if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
      {
	// For others recalculate it from:
	float CritMelee = 0.0f;
	// Crit from Agility
	CritMelee += owner->GetMeleeCritFromAgility();
	// Increase crit from SPELL_AURA_MOD_WEAPON_CRIT_PERCENT
	CritMelee += owner->GetTotalAuraModifier(SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
	// Increase crit from SPELL_AURA_MOD_CRIT_PCT
	CritMelee += owner->GetTotalAuraModifier(SPELL_AURA_MOD_CRIT_PCT);
	// Increase crit melee from melee crit ratings
	CritMelee += owner->GetRatingBonusValue(CR_CRIT_MELEE);

	if (AuraApplication* improvedDemonicTacticsApp = owner->GetAuraApplicationOfRankedSpell(54347))
	  if (Aura* improvedDemonicTactics = improvedDemonicTacticsApp->GetBase())
	    if (AuraEffect* improvedDemonicTacticsEffect = improvedDemonicTactics->GetEffect(EFFECT_0))
	      amount += CalculatePctN(CritMelee, improvedDemonicTacticsEffect->GetAmount());
      }
    }

    void Register()
    {
      DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_AuraScript::CalculateAmountCritSpell, EFFECT_0, SPELL_AURA_MOD_SPELL_CRIT_CHANCE);
      DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_AuraScript::CalculateAmountCritMelee, EFFECT_1, SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
    }
  };

  AuraScript* GetAuraScript() const
  {
    return new spell_warl_pet_passive_AuraScript();
  }
};

class spell_warl_pet_passive_damage_done : public SpellScriptLoader
{
public:
  spell_warl_pet_passive_damage_done() : SpellScriptLoader("spell_warl_pet_passive_damage_done") { }

  class spell_warl_pet_passive_damage_done_AuraScript : public AuraScript
  {
    PrepareAuraScript(spell_warl_pet_passive_damage_done_AuraScript);

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
	switch (GetCaster()->GetEntry())
	{
	case ENTRY_VOIDWALKER:
	  amount += -16;
	  break;
	case ENTRY_FELHUNTER:
	  amount += -20;
	  break;
	case ENTRY_SUCCUBUS:
	case ENTRY_FELGUARD:
	  amount += 5;
	  break;
	}
      }
    }

    void Register()
    {
      DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_damage_done_AuraScript::CalculateAmountDamageDone, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
      DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_damage_done_AuraScript::CalculateAmountDamageDone, EFFECT_1, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
    }
  };

  AuraScript* GetAuraScript() const
  {
    return new spell_warl_pet_passive_damage_done_AuraScript();
  }
};


class spell_warl_pet_passive_voidwalker : public SpellScriptLoader
{
public:
  spell_warl_pet_passive_voidwalker() : SpellScriptLoader("spell_warl_pet_passive_voidwalker") { }

  class spell_warl_pet_passive_voidwalker_AuraScript : public AuraScript
  {
    PrepareAuraScript(spell_warl_pet_passive_voidwalker_AuraScript);

    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
      if (Unit* pet = GetUnitOwner())
      {
	if (!pet->isPet())
	  return;

	Unit* owner = pet->ToPet()->GetOwner();
	if (!owner)
	  return;

	if (AuraEffect* aurEffect = owner->GetAuraEffect(56247, EFFECT_0))
	  amount += aurEffect->GetAmount();
      }
    }

    void Register()
    {
      DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_voidwalker_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE);
    }
  };

  AuraScript* GetAuraScript() const
  {
    return new spell_warl_pet_passive_voidwalker_AuraScript();
  }
};



void AddSC_warlock_spell_scripts()
{
    new spell_warl_demonic_empowerment();
    new spell_warl_create_healthstone();
    new spell_warl_everlasting_affliction();
    new spell_warl_ritual_of_doom_effect();
    new spell_warl_seed_of_corruption();
    new spell_warl_shadow_bite();
    new spell_warl_banish();
    new spell_warl_demonic_circle_summon();
    new spell_warl_pet_scaling_01();
    new spell_warl_pet_scaling_02();
    new spell_warl_pet_scaling_03();
    new spell_warl_pet_scaling_04();
    new spell_warl_pet_scaling_05();
    new spell_warl_pet_passive();
    new spell_warl_pet_passive_voidwalker();
    new spell_warl_pet_passive_damage_done();
}
