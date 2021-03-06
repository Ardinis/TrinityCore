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
 * Scripts for spells with SPELLFAMILY_DEATHKNIGHT and SPELLFAMILY_GENERIC spells used by deathknight players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_dk_".
 */

#include "Spell.h"

enum DeathKnightSpells
{
    DK_SPELL_RUNIC_POWER_ENERGIZE               = 49088,
    DK_SPELL_ANTI_MAGIC_SHELL_TALENT            = 51052,
    DK_SPELL_CORPSE_EXPLOSION_TRIGGERED         = 43999,
    DK_SPELL_CORPSE_EXPLOSION_VISUAL            = 51270,
    DK_SPELL_GHOUL_EXPLODE                      = 47496,
    DK_SPELL_SCOURGE_STRIKE_TRIGGERED           = 70890,
    DK_SPELL_BLOOD_BOIL_TRIGGERED               = 65658,
    DK_SPELL_WILL_OF_THE_NECROPOLIS_TALENT_R1   = 49189,
    DK_SPELL_WILL_OF_THE_NECROPOLIS_AURA_R1     = 52284,
    DK_SPELL_BLOOD_PRESENCE                     = 48266,
    DK_SPELL_IMPROVED_BLOOD_PRESENCE_TRIGGERED  = 63611,
    DK_SPELL_UNHOLY_PRESENCE                    = 48265,
    DK_SPELL_IMPROVED_UNHOLY_PRESENCE_TRIGGERED = 63611,
    SPELL_DK_ITEM_T8_MELEE_4P_BONUS             = 64736,
    DK_SPELL_BLACK_ICE_R1                       = 49140,
};

// 50462 - Anti-Magic Shell (on raid member)
class spell_dk_anti_magic_shell_raid : public SpellScriptLoader
{
    public:
        spell_dk_anti_magic_shell_raid() : SpellScriptLoader("spell_dk_anti_magic_shell_raid") { }

        class spell_dk_anti_magic_shell_raid_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_anti_magic_shell_raid_AuraScript);

            uint32 absorbPct;

            bool Load()
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // TODO: this should absorb limited amount of damage, but no info on calculation formula
                amount = -1;
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                 absorbAmount = CalculatePctN(dmgInfo.GetDamage(), absorbPct);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_anti_magic_shell_raid_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_shell_raid_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_anti_magic_shell_raid_AuraScript();
        }
};

// 48707 - Anti-Magic Shell (on self)
class spell_dk_anti_magic_shell_self : public SpellScriptLoader
{
    public:
        spell_dk_anti_magic_shell_self() : SpellScriptLoader("spell_dk_anti_magic_shell_self") { }

        class spell_dk_anti_magic_shell_self_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_anti_magic_shell_self_AuraScript);

            uint32 absorbPct, hpPct;
            bool Load()
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                if (GetCaster()->HasSpell(49224))
                    absorbPct += 8;
                if (GetCaster()->HasSpell(49610))
                    absorbPct += 16;
                if (GetCaster()->HasSpell(49611))
                    absorbPct += 25;
                hpPct = GetSpellInfo()->Effects[EFFECT_1].CalcValue(GetCaster());
                return true;
            }

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(DK_SPELL_RUNIC_POWER_ENERGIZE))
                    return false;
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                amount = GetCaster()->CountPctFromMaxHealth(hpPct);
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                absorbAmount = std::min(CalculatePctN(dmgInfo.GetDamage(), absorbPct), GetTarget()->CountPctFromMaxHealth(hpPct));
            }

            void Trigger(AuraEffect* aurEff, DamageInfo & /*dmgInfo*/, uint32 & absorbAmount)
            {
                Unit* target = GetTarget();
                // damage absorbed by Anti-Magic Shell energizes the DK with additional runic power.
                // This, if I'm not mistaken, shows that we get back ~20% of the absorbed damage as runic power.
                int32 bp = absorbAmount * 2 / 10;
                target->CastCustomSpell(target, DK_SPELL_RUNIC_POWER_ENERGIZE, &bp, NULL, NULL, true, NULL, aurEff);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_anti_magic_shell_self_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_shell_self_AuraScript::Absorb, EFFECT_0);
                 AfterEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_shell_self_AuraScript::Trigger, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_anti_magic_shell_self_AuraScript();
        }
};

// 50461 - Anti-Magic Zone
class spell_dk_anti_magic_zone : public SpellScriptLoader
{
    public:
        spell_dk_anti_magic_zone() : SpellScriptLoader("spell_dk_anti_magic_zone") { }

        class spell_dk_anti_magic_zone_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_anti_magic_zone_AuraScript);

            uint32 absorbPct;

            bool Load()
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                return true;
            }

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(DK_SPELL_ANTI_MAGIC_SHELL_TALENT))
                    return false;
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                SpellInfo const* talentSpell = sSpellMgr->GetSpellInfo(DK_SPELL_ANTI_MAGIC_SHELL_TALENT);
                amount = talentSpell->Effects[EFFECT_0].CalcValue(GetCaster());
                if (Player* player = GetCaster()->ToPlayer())
                     amount += int32(2 * player->GetTotalAttackPowerValue(BASE_ATTACK));
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                 absorbAmount = CalculatePctN(dmgInfo.GetDamage(), absorbPct);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_anti_magic_zone_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_zone_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_anti_magic_zone_AuraScript();
        }
};

// 49158 Corpse Explosion (51325, 51326, 51327, 51328)
class spell_dk_corpse_explosion : public SpellScriptLoader
{
    public:
        spell_dk_corpse_explosion() : SpellScriptLoader("spell_dk_corpse_explosion") { }

        class spell_dk_corpse_explosion_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_corpse_explosion_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
	      if (!sSpellMgr)
		return false;
                if (!sSpellMgr->GetSpellInfo(DK_SPELL_CORPSE_EXPLOSION_TRIGGERED) || !sSpellMgr->GetSpellInfo(DK_SPELL_GHOUL_EXPLODE))
                    return false;
                if (!sSpellMgr->GetSpellInfo(DK_SPELL_CORPSE_EXPLOSION_VISUAL))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                {
                    int32 bp = 0;
                    if (unitTarget->isAlive())  // Living ghoul as a target
                    {
                        bp = int32(unitTarget->CountPctFromMaxHealth(25));
                        unitTarget->CastCustomSpell(unitTarget, DK_SPELL_GHOUL_EXPLODE, &bp, NULL, NULL, false);
                    }
                    else                        // Some corpse
                    {
                        bp = GetEffectValue();
                        GetCaster()->CastCustomSpell(unitTarget, GetSpellInfo()->Effects[EFFECT_1].CalcValue(), &bp, NULL, NULL, true);
                        // Corpse Explosion (Suicide)
                        unitTarget->CastSpell(unitTarget, DK_SPELL_CORPSE_EXPLOSION_TRIGGERED, true);
                    }
                    // Set corpse look
                    GetCaster()->CastSpell(unitTarget, DK_SPELL_CORPSE_EXPLOSION_VISUAL, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dk_corpse_explosion_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_corpse_explosion_SpellScript();
        }
};

// 47496 - Explode, Ghoul spell for Corpse Explosion
class spell_dk_ghoul_explode : public SpellScriptLoader
{
    public:
        spell_dk_ghoul_explode() : SpellScriptLoader("spell_dk_ghoul_explode") { }

        class spell_dk_ghoul_explode_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_ghoul_explode_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(DK_SPELL_CORPSE_EXPLOSION_TRIGGERED))
                    return false;
                return true;
            }

            void Suicide(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                {
                    // Corpse Explosion (Suicide)
                    unitTarget->CastSpell(unitTarget, DK_SPELL_CORPSE_EXPLOSION_TRIGGERED, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dk_ghoul_explode_SpellScript::Suicide, EFFECT_1, SPELL_EFFECT_SCHOOL_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_ghoul_explode_SpellScript();
        }
};

class spell_dk_death_gate : public SpellScriptLoader
{
    public:
        spell_dk_death_gate() : SpellScriptLoader("spell_dk_death_gate") {}

        class spell_dk_death_gate_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_gate_SpellScript);

            SpellCastResult CheckClass()
            {
                if (GetCaster()->getClass() != CLASS_DEATH_KNIGHT)
                {
                    SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_BE_DEATH_KNIGHT);
                    return SPELL_FAILED_CUSTOM_ERROR;
                }

                return SPELL_CAST_OK;
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, GetEffectValue(), false);
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_dk_death_gate_SpellScript::CheckClass);
                OnEffectHitTarget += SpellEffectFn(spell_dk_death_gate_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_gate_SpellScript();
        }
};

class spell_dk_death_pact : public SpellScriptLoader
{
    public:
        spell_dk_death_pact() : SpellScriptLoader("spell_dk_death_pact") { }

        class spell_dk_death_pact_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_pact_SpellScript);

            SpellCastResult CheckCast()
            {
                // Check if we have valid targets, otherwise skip spell casting here
                if (Player* player = GetCaster()->ToPlayer())
                    for (Unit::ControlList::const_iterator itr = player->m_Controlled.begin(); itr != player->m_Controlled.end(); ++itr)
                        if (Creature* undeadPet = (*itr)->ToCreature())
                            if (undeadPet->isAlive() &&
                                undeadPet->GetOwnerGUID() == player->GetGUID() &&
                                undeadPet->GetCreatureType() == CREATURE_TYPE_UNDEAD &&
                                undeadPet->IsWithinDist(player, 100.0f, false))
                                return SPELL_CAST_OK;

                return SPELL_FAILED_NO_PET;
            }

            void FilterTargets(std::list<Unit*>& unitList)
            {
                Unit* unit_to_add = NULL;
                for (std::list<Unit*>::iterator itr = unitList.begin() ; itr != unitList.end(); ++itr)
                {
                    if ((*itr)->GetTypeId() == TYPEID_UNIT
                        && (*itr)->GetOwnerGUID() == GetCaster()->GetGUID()
                        && (*itr)->ToCreature()->GetCreatureInfo()->type == CREATURE_TYPE_UNDEAD)
                    {
                        unit_to_add = (*itr);
                        break;
                    }
                }

                unitList.clear();
                if (unit_to_add)
                    unitList.push_back(unit_to_add);
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_dk_death_pact_SpellScript::CheckCast);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_dk_death_pact_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_pact_SpellScript();
        }
};

// 55090 Scourge Strike (55265, 55270, 55271)
class spell_dk_scourge_strike : public SpellScriptLoader
{
    public:
        spell_dk_scourge_strike() : SpellScriptLoader("spell_dk_scourge_strike") { }

        class spell_dk_scourge_strike_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_scourge_strike_SpellScript);
            
            public:
            
            spell_dk_scourge_strike_SpellScript() : m_coef(0.0f) { }

            private:
            
            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                return true;
            }

            void GetGlyphScourgeStrikeAuraEffects(Unit const * caster, Unit const * target, Unit::AuraEffectList & auras)
            {
                Unit::AuraEffectList const & aurasA = target->GetAuraEffectsByType(SPELL_AURA_DUMMY);
                for (Unit::AuraEffectList::const_iterator itr = aurasA.begin(); itr != aurasA.end(); ++itr)
                {
                    if (((*itr)->GetCasterGUID() != caster->GetGUID()) || ((*itr)->GetEffIndex() != EFFECT_0))
                        continue;

                    SpellInfo const * spellProto = (*itr)->GetSpellInfo();
                    if ((spellProto->SpellIconID == 23) && (SpellFamilyNames(spellProto->SpellFamilyName) == SPELLFAMILY_GENERIC))
                        auras.push_back(*itr);
                }
            }

            AuraEffect * GetGlyphScourgeStrikeAuraEffect(uint32 diseaseId, Unit::AuraEffectList const & auras)
            {
                for (Unit::AuraEffectList::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
                    if (diseaseId == ((*itr)->GetAmount() >> 4))
                        return (*itr);

                return NULL;
            }


            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                static const AuraType diseaseAuraTypes[] =
                    {
                        SPELL_AURA_PERIODIC_DAMAGE, // Frost Fever and Blood Plague
                        SPELL_AURA_LINKED,          // Crypt Fever and Ebon Plague
                        SPELL_AURA_NONE
                    };

                Unit * caster = GetCaster();
                Unit * target = GetHitUnit();

                if ((!target) || (!caster))
                    return;

                uint32 diseases = 0;
                int32 extratime, maxtime;
                AuraEffect const * aurEffA;

                Unit::AuraEffectList aurasA;
                GetGlyphScourgeStrikeAuraEffects(caster, caster, aurasA);

                bool hasGlyph = bool(aurasA.size());

                if (hasGlyph)
                {
                    aurEffA = *aurasA.begin();
                    extratime = aurEffA->GetAmount();
                    maxtime = aurEffA->GetSpellInfo()->Effects[EFFECT_1].CalcValue(caster);

                    aurasA.clear();
                    GetGlyphScourgeStrikeAuraEffects(caster, target, aurasA);
                }


                for (AuraType const * itrA = &diseaseAuraTypes[0]; itrA && itrA[0] != SPELL_AURA_NONE; ++itrA)
                {
                    Unit::AuraEffectList const & aurasB = target->GetAuraEffectsByType(*itrA);
                    for (Unit::AuraEffectList::const_iterator itrB = aurasB.begin(); itrB != aurasB.end(); ++itrB)
                        if (((*itrB)->GetSpellInfo()->Dispel == DISPEL_DISEASE) &&
                            ((*itrB)->GetCasterGUID() == caster->GetGUID()))
                        {
                            ++diseases;

                            if (!hasGlyph)
                                continue;

                            Aura * aura = (*itrB)->GetBase();

                            int32 applytime = int32(aura->GetApplyTime() & 0x7FFFFFFF);
                            int32 duration = std::min(aura->GetDuration() + (extratime * IN_MILLISECONDS), aura->GetMaxDuration());

                            if (AuraEffect * aurEffB = GetGlyphScourgeStrikeAuraEffect(aura->GetId(), aurasA))
                            {
                                aurEffB->GetBase()->SetDuration(duration);

                                if (applytime != aurEffB->GetBase()->GetMaxDuration())
                                    aurEffB->SetAmount(aurEffB->GetAmount() & ~(0xF));

                                if (maxtime <= (aurEffB->GetAmount() & 0xF))
                                    continue;

                                aura->SetDuration(duration);

                                aurEffB->GetBase()->SetMaxDuration(applytime);
                                aurEffB->SetAmount(aurEffB->GetAmount() + extratime);

                                continue;
                            }
                            int32 bp0 = (aura->GetId() << 4) + extratime;
                            caster->CastCustomSpell(target, aurEffA->GetId(), &bp0, NULL, NULL, true);

                            Unit::AuraEffectList tmp;
                            GetGlyphScourgeStrikeAuraEffects(caster, target, tmp);

                            if (AuraEffect * aurEffB = GetGlyphScourgeStrikeAuraEffect(aura->GetId(), tmp))
                            {
                                aura->SetDuration(duration);

                                aurEffB->GetBase()->SetMaxDuration(applytime);
                                aurEffB->GetBase()->SetDuration(duration);
                            }
                        }
                }

                m_coef = float(GetEffectValue() * diseases) / 100.0f;
            }
            
            void HandleAfterHit() {
                int32 bp0 = GetHitDamage() * m_coef;
                Unit *caster = GetCaster();
                Unit *target = GetHitUnit();
                if (caster && target && (bp0 > 0)) {
                /* -- already taken into account in Unit::SpellDamageBonusWhatever 
                    if (AuraEffect* aurEff = caster->GetAuraEffectOfRankedSpell(DK_SPELL_BLACK_ICE_R1, EFFECT_0))
                        AddPctN(bp0, aurEff->GetAmount());
                */
                    caster->CastCustomSpell(target, DK_SPELL_SCOURGE_STRIKE_TRIGGERED, &bp0, NULL, NULL, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dk_scourge_strike_SpellScript::HandleDummy, EFFECT_2, SPELL_EFFECT_DUMMY);
                AfterHit += SpellHitFn(spell_dk_scourge_strike_SpellScript::HandleAfterHit);
            }
            private:
                float m_coef;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_scourge_strike_SpellScript();
        }
};

// 49145 - Spell Deflection
class spell_dk_spell_deflection : public SpellScriptLoader
{
    public:
        spell_dk_spell_deflection() : SpellScriptLoader("spell_dk_spell_deflection") { }

        class spell_dk_spell_deflection_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_spell_deflection_AuraScript);

            uint32 absorbPct;

            bool Load()
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // Set absorbtion amount to unlimited
                amount = -1;
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                // You have a chance equal to your Parry chance
                if ((dmgInfo.GetDamageType() == SPELL_DIRECT_DAMAGE) && roll_chance_f(GetTarget()->GetUnitParryChance()))
                    absorbAmount = CalculatePctN(dmgInfo.GetDamage(), absorbPct);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_spell_deflection_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_spell_deflection_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_spell_deflection_AuraScript();
        }
};

// 48721 Blood Boil
class spell_dk_blood_boil : public SpellScriptLoader
{
    public:
        spell_dk_blood_boil() : SpellScriptLoader("spell_dk_blood_boil") { }

        class spell_dk_blood_boil_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_blood_boil_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(DK_SPELL_BLOOD_BOIL_TRIGGERED))
                    return false;
                return true;
            }

            bool Load()
            {
                _executed = false;
                return GetCaster()->GetTypeId() == TYPEID_PLAYER && GetCaster()->getClass() == CLASS_DEATH_KNIGHT;
            }

            void HandleAfterHit()
            {
                if (_executed || !GetHitUnit())
                    return;

                _executed = true;
                GetCaster()->CastSpell(GetCaster(), DK_SPELL_BLOOD_BOIL_TRIGGERED, true);
            }

            void Register()
            {
                AfterHit += SpellHitFn(spell_dk_blood_boil_SpellScript::HandleAfterHit);
            }

            bool _executed;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_blood_boil_SpellScript();
        }
};

// 52284 - Will of the Necropolis
class spell_dk_will_of_the_necropolis : public SpellScriptLoader
{
    public:
        spell_dk_will_of_the_necropolis() : SpellScriptLoader("spell_dk_will_of_the_necropolis") { }

        class spell_dk_will_of_the_necropolis_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_will_of_the_necropolis_AuraScript);

            bool Validate(SpellInfo const* spellEntry)
            {
                // can't use other spell than will of the necropolis due to spell_ranks dependency
                if (sSpellMgr->GetFirstSpellInChain(DK_SPELL_WILL_OF_THE_NECROPOLIS_AURA_R1) != sSpellMgr->GetFirstSpellInChain(spellEntry->Id))
                    return false;

                uint8 rank = sSpellMgr->GetSpellRank(spellEntry->Id);
                if (!sSpellMgr->GetSpellWithRank(DK_SPELL_WILL_OF_THE_NECROPOLIS_TALENT_R1, rank, true))
                    return false;

                return true;
            }

            uint32 absorbPct;

            bool Load()
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // Set absorbtion amount to unlimited
                amount = -1;
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                // min pct of hp is stored in effect 0 of talent spell
                uint32 rank = sSpellMgr->GetSpellRank(GetSpellInfo()->Id);
                SpellInfo const* talentProto = sSpellMgr->GetSpellInfo(sSpellMgr->GetSpellWithRank(DK_SPELL_WILL_OF_THE_NECROPOLIS_TALENT_R1, rank));

                int32 remainingHp = int32(GetTarget()->GetHealth() - dmgInfo.GetDamage());
                int32 minHp = int32(GetTarget()->CountPctFromMaxHealth(talentProto->Effects[EFFECT_0].CalcValue(GetCaster())));

                // Damage that would take you below [effect0] health or taken while you are at [effect0]
                if (remainingHp < minHp)
                    absorbAmount = CalculatePctN(dmgInfo.GetDamage(), absorbPct);
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_will_of_the_necropolis_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_will_of_the_necropolis_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_will_of_the_necropolis_AuraScript();
        }
};

// 50365, 50371 Improved Blood Presence
class spell_dk_improved_blood_presence : public SpellScriptLoader
{
public:
    spell_dk_improved_blood_presence() : SpellScriptLoader("spell_dk_improved_blood_presence") { }

    class spell_dk_improved_blood_presence_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_dk_improved_blood_presence_AuraScript);

        bool Validate(SpellInfo const* /*entry*/)
        {
            if (!sSpellMgr || !sSpellMgr->GetSpellInfo(DK_SPELL_BLOOD_PRESENCE) || !sSpellMgr->GetSpellInfo(DK_SPELL_IMPROVED_BLOOD_PRESENCE_TRIGGERED))
                return false;
            return true;
        }

        void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (!target->HasAura(DK_SPELL_BLOOD_PRESENCE) && !target->HasAura(DK_SPELL_IMPROVED_BLOOD_PRESENCE_TRIGGERED))
            {
                int32 basePoints1 = aurEff->GetAmount();
                target->CastCustomSpell(target, 63611, NULL, &basePoints1, NULL, true, 0, aurEff);
            }
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (!target->HasAura(DK_SPELL_BLOOD_PRESENCE))
                target->RemoveAura(DK_SPELL_IMPROVED_BLOOD_PRESENCE_TRIGGERED);
        }

        void Register()
        {
            AfterEffectApply += AuraEffectApplyFn(spell_dk_improved_blood_presence_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_dk_improved_blood_presence_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_dk_improved_blood_presence_AuraScript();
    }
};

// 50391, 50392 Improved Unholy Presence
class spell_dk_improved_unholy_presence : public SpellScriptLoader
{
public:
    spell_dk_improved_unholy_presence() : SpellScriptLoader("spell_dk_improved_unholy_presence") { }

    class spell_dk_improved_unholy_presence_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_dk_improved_unholy_presence_AuraScript);

        bool Validate(SpellInfo const* /*entry*/)
        {
            if (!sSpellMgr || !sSpellMgr->GetSpellInfo(DK_SPELL_UNHOLY_PRESENCE) || !sSpellMgr->GetSpellInfo(DK_SPELL_IMPROVED_UNHOLY_PRESENCE_TRIGGERED))
                return false;
            return true;
        }

        void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (target->HasAura(DK_SPELL_UNHOLY_PRESENCE) && !target->HasAura(DK_SPELL_IMPROVED_UNHOLY_PRESENCE_TRIGGERED))
            {
                // Not listed as any effect, only base points set in dbc
                int32 basePoints0 = aurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue();
                target->CastCustomSpell(target, DK_SPELL_IMPROVED_UNHOLY_PRESENCE_TRIGGERED, &basePoints0, &basePoints0, &basePoints0, true, 0, aurEff);
            }
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (target->HasAura(DK_SPELL_UNHOLY_PRESENCE))
                target->RemoveAura(DK_SPELL_IMPROVED_UNHOLY_PRESENCE_TRIGGERED);
        }

        void Register()
        {
            AfterEffectApply += AuraEffectApplyFn(spell_dk_improved_unholy_presence_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_dk_improved_unholy_presence_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_dk_improved_unholy_presence_AuraScript();
    }
};

enum DeathStrike
{
    ICON_ID_IMPROVED_DEATH_STRIKE   = 2751,
    SPELL_DEATH_STRIKE_HEAL         = 45470,
};

class spell_dk_death_strike : public SpellScriptLoader
{
    public:
        spell_dk_death_strike() : SpellScriptLoader("spell_dk_death_strike") { }

        class spell_dk_death_strike_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_strike_SpellScript);

            bool Validate(SpellInfo const* /*SpellEntry*/)
            {
                if (!sSpellMgr || !sSpellMgr->GetSpellInfo(SPELL_DEATH_STRIKE_HEAL))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    uint32 count = target->GetDiseasesByCaster(caster->GetGUID());
                    int32 bp = int32(count * caster->CountPctFromMaxHealth(int32(GetSpellInfo()->Effects[EFFECT_0].DamageMultiplier)));
                    // Improved Death Strike
                    if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_AURA_ADD_PCT_MODIFIER, SPELLFAMILY_DEATHKNIGHT, ICON_ID_IMPROVED_DEATH_STRIKE, 0))
                        AddPctN(bp, caster->CalculateSpellDamage(caster, aurEff->GetSpellInfo(), 2));
                    caster->CastCustomSpell(caster, SPELL_DEATH_STRIKE_HEAL, &bp, NULL, NULL, false);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dk_death_strike_SpellScript::HandleDummy, EFFECT_2, SPELL_EFFECT_DUMMY);
            }

        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_strike_SpellScript();
        }
};

enum DeathCoil
{
    SPELL_DEATH_COIL_DAMAGE     = 47632,
    SPELL_DEATH_COIL_HEAL       = 47633,
    SPELL_SIGIL_VENGEFUL_HEART  = 64962,
};

class spell_dk_death_coil : public SpellScriptLoader
{
    public:
        spell_dk_death_coil() : SpellScriptLoader("spell_dk_death_coil") { }

        class spell_dk_death_coil_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_coil_SpellScript);

            bool Validate(SpellInfo const* /*SpellEntry*/)
            {
                return true;
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                int32 damage = GetEffectValue();
                Unit* caster = GetCaster();
                if (!caster)
                    return;
                Player *player = caster->ToPlayer();
                if (!player)
                    return;
                if (Unit* target = GetHitUnit())
                {
                    if (caster->IsFriendlyTo(target))
                    {
                        int32 bp = int32(damage * 1.5f);
                        caster->CastCustomSpell(target, SPELL_DEATH_COIL_HEAL, &bp, NULL, NULL, true);
                    }
                    else
                    {
                        if (AuraEffect const* auraEffect = caster->GetAuraEffect(SPELL_SIGIL_VENGEFUL_HEART, EFFECT_1))
                            damage += auraEffect->GetBaseAmount();
                        caster->CastCustomSpell(target, SPELL_DEATH_COIL_DAMAGE, &damage, NULL, NULL, true);
                    }
                }
            }

            SpellCastResult CheckCast()
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetTargetUnit())
                {
                    if (!caster->IsFriendlyTo(target) && !caster->isInFront(target, 50, M_PI))
                        return SPELL_FAILED_UNIT_NOT_INFRONT;

                    if (target->IsFriendlyTo(caster) && target->GetCreatureType() != CREATURE_TYPE_UNDEAD)
                        return SPELL_FAILED_BAD_TARGETS;
                }
                else
                    return SPELL_FAILED_BAD_TARGETS;

                return SPELL_CAST_OK;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_dk_death_coil_SpellScript::CheckCast);
                OnEffectHitTarget += SpellEffectFn(spell_dk_death_coil_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }

        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_coil_SpellScript();
        }
};

class spell_dk_death_grip : public SpellScriptLoader
{
    public:
        spell_dk_death_grip() : SpellScriptLoader("spell_dk_death_grip") { }

        class spell_dk_death_grip_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dk_death_grip_SpellScript);

            void HandleDummy(SpellEffIndex effIndex)
            {
                int32 damage = GetEffectValue();
                Spell* baseSpell = GetSpell();
                Position pos;
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    GetSummonPosition(effIndex, pos, 0.0f, 0);

                    if (!target->HasAuraType(SPELL_AURA_DEFLECT_SPELLS)) // Deterrence
                    {
                        Unit* spellTarget = GetSpell()->m_targets.GetUnitTarget();
                        if (spellTarget && GetCaster() == target) // Spell reflect case
                            GetCaster()->CastSpell(spellTarget->GetPositionX(), spellTarget->GetPositionY(), spellTarget->GetPositionZ(), damage, true);
                        else
                            target->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), damage, true);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dk_death_grip_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }

        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dk_death_grip_SpellScript();
        }
};

class spell_dk_avoidance_passive : public SpellScriptLoader
{
    public:
        spell_dk_avoidance_passive() : SpellScriptLoader("spell_dk_avoidance_passive") { }

        class spell_dk_avoidance_passive_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_avoidance_passive_AuraScript);

            bool Load()
            {
                if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                    return false;
                return true;
            }

            void CalculateAvoidanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    Unit* owner = pet->GetOwner();
                    if (!owner)
                        return;

                    // Night of the dead
                    if (owner->HasAura(55623))
                        amount = 90;
                    else if (owner->HasAura(55620))
                        amount = 45;
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_avoidance_passive_AuraScript::CalculateAvoidanceAmount, EFFECT_0, SPELL_AURA_MOD_CREATURE_AOE_DAMAGE_AVOIDANCE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_avoidance_passive_AuraScript();
        }
};

class spell_dk_pet_scaling_01 : public SpellScriptLoader
{
    public:
        spell_dk_pet_scaling_01() : SpellScriptLoader("spell_dk_pet_scaling_01") { }

        class spell_dk_pet_scaling_01_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_pet_scaling_01_AuraScript);

            bool Load()
            {
                if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                    return false;
                _tempHealth = 0;
                return true;
            }

            void CalculateStaminaAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isGuardian())
                        return;

                    Unit* owner = pet->GetOwner();
                    if (!owner)
                        return;

                    float mod = 0.3f;

                    // Ravenous Dead
                    AuraEffect const* aurEff = NULL;
                    // Check just if owner has Ravenous Dead since it's effect is not an aura
                    aurEff = owner->GetAuraEffect(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, SPELLFAMILY_DEATHKNIGHT, 3010, 0);
                    if (aurEff)
                    {
                        mod += CalculatePctN(mod, aurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue());                   // Ravenous Dead edits the original scale
                    }
                    // Glyph of the Ghoul
                    aurEff = owner->GetAuraEffect(58686, 0);
                    if (aurEff)
                        mod += CalculatePctN(1.0f, aurEff->GetAmount());                                                    // Glyph of the Ghoul adds a flat value to the scale mod
                    float ownerBonus = float(owner->GetStat(STAT_STAMINA));
                    ownerBonus *= mod;
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

            void CalculateStrengthAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    if (!pet->isGuardian())
                        return;

                    Unit* owner = pet->GetOwner();
                    if (!owner)
                        return;

                    float mod = 0.7f;

                    // Ravenous Dead
                    AuraEffect const* aurEff = NULL;
                    // Check just if owner has Ravenous Dead since it's effect is not an aura
                    aurEff = owner->GetAuraEffect(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, SPELLFAMILY_DEATHKNIGHT, 3010, 0);
                    if (aurEff)
                    {
                        mod += CalculatePctN(mod, aurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue());                   // Ravenous Dead edits the original scale
                    }
                    // Glyph of the Ghoul
                    aurEff = owner->GetAuraEffect(58686, 0);
                    if (aurEff)
                        mod += CalculatePctN(1.0f, aurEff->GetAmount());                                                    // Glyph of the Ghoul adds a flat value to the scale mod
                    float ownerBonus = float(owner->GetStat(STAT_STRENGTH)) * mod;
                    amount += ownerBonus;
                }
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_dk_pet_scaling_01_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                AfterEffectApply += AuraEffectApplyFn(spell_dk_pet_scaling_01_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling_01_AuraScript::CalculateStaminaAmount, EFFECT_0, SPELL_AURA_MOD_STAT);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling_01_AuraScript::CalculateStrengthAmount, EFFECT_1, SPELL_AURA_MOD_STAT);
            }

	private:
	  uint32 _tempHealth;

        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_pet_scaling_01_AuraScript();
        }
};

class spell_dk_pet_scaling_02 : public SpellScriptLoader
{
    public:
        spell_dk_pet_scaling_02() : SpellScriptLoader("spell_dk_pet_scaling_02") { }

        class spell_dk_pet_scaling_02_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_pet_scaling_02_AuraScript);

            bool Load()
            {
                if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                    return false;
                return true;
            }

            void CalculateAmountMeleeHaste(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;
                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    // For others recalculate it from:
                    float HasteMelee = 0.0f;
                    // Increase hit from SPELL_AURA_MOD_HIT_CHANCE
                    HasteMelee += (1-owner->m_modAttackSpeedPct[BASE_ATTACK])*100;

                    amount += int32(HasteMelee);
                }
            }

            void CalculateBonusDamagePct(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;

                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    Unit::AuraEffectList const& auraDamagePctList = owner->GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
                    for (Unit::AuraEffectList::const_iterator itr = auraDamagePctList.begin(); itr != auraDamagePctList.end(); ++itr)
                        if ((*itr)->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL)
                            amount += (*itr)->GetAmount();
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling_02_AuraScript::CalculateAmountMeleeHaste, EFFECT_1, SPELL_AURA_MELEE_SLOW);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling_02_AuraScript::CalculateBonusDamagePct, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_pet_scaling_02_AuraScript();
        }
};

class spell_dk_pet_scaling_03 : public SpellScriptLoader
{
    public:
        spell_dk_pet_scaling_03() : SpellScriptLoader("spell_dk_pet_scaling_03") { }

        class spell_dk_pet_scaling_03_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_pet_scaling_03_AuraScript);

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

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling_03_AuraScript::CalculateAmountMeleeHit, EFFECT_0, SPELL_AURA_MOD_HIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling_03_AuraScript::CalculateAmountSpellHit, EFFECT_1, SPELL_AURA_MOD_SPELL_HIT_CHANCE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_pet_scaling_03_AuraScript();
        }
};

class spell_dk_rune_weapon_scaling_02 : public SpellScriptLoader
{
    public:
        spell_dk_rune_weapon_scaling_02() : SpellScriptLoader("spell_dk_rune_weapon_scaling_02") { }

        class spell_dk_rune_weapon_scaling_02_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dk_rune_weapon_scaling_02_AuraScript);

            bool Load()
            {
                if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                    return false;
                return true;
            }

            void CalculateDamageDoneAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (Unit* pet = GetUnitOwner())
                {
                    Unit* owner = pet->GetOwner();
                    if (!owner)
                        return;

                    if (pet->isGuardian())
                        ((Guardian*)pet)->SetBonusDamage(owner->GetTotalAttackPowerValue(BASE_ATTACK));

                    amount += owner->CalculateDamage(BASE_ATTACK, true, true);;
                }
            }

            void CalculateAmountMeleeHaste(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (!GetCaster() || !GetCaster()->GetOwner())
                    return;
                if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
                {
                    // For others recalculate it from:
                    float HasteMelee = 0.0f;
                    // Increase hit from SPELL_AURA_MOD_HIT_CHANCE
                    HasteMelee += (1-owner->m_modAttackSpeedPct[BASE_ATTACK])*100;

                    amount += int32(HasteMelee);
                }
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_rune_weapon_scaling_02_AuraScript::CalculateDamageDoneAmount, EFFECT_0, SPELL_AURA_MOD_DAMAGE_DONE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_rune_weapon_scaling_02_AuraScript::CalculateAmountMeleeHaste, EFFECT_1, SPELL_AURA_MELEE_SLOW);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dk_rune_weapon_scaling_02_AuraScript();
        }
};

void AddSC_deathknight_spell_scripts()
{
    new spell_dk_anti_magic_shell_raid();
    new spell_dk_anti_magic_shell_self();
    new spell_dk_anti_magic_zone();
    new spell_dk_corpse_explosion();
    new spell_dk_ghoul_explode();
    new spell_dk_death_gate();
    new spell_dk_death_pact();
    new spell_dk_scourge_strike();
    new spell_dk_spell_deflection();
    new spell_dk_blood_boil();
    new spell_dk_will_of_the_necropolis();
    new spell_dk_improved_blood_presence();
    new spell_dk_improved_unholy_presence();
    new spell_dk_death_strike();
    new spell_dk_death_coil();
    new spell_dk_death_grip();
    //    new spell_dk_avoidance_passive();
    new spell_dk_pet_scaling_01();
    new spell_dk_pet_scaling_02();
    new spell_dk_pet_scaling_03();
    new spell_dk_rune_weapon_scaling_02();
}
