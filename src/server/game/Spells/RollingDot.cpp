RollingRefreshTypes RollingDot::stat2refresh[ROLLING_STAT_COUNT] = {
        ROLLING_SOFT_REFRESH, // recompute spellpower on soft refresh (and hard refresh)
        ROLLING_HARD_REFRESH, // recompute +pct buff bonus on hard refresh only
        ROLLING_HARD_REFRESH, // recompute crit chance on hard refresh only
        ROLLING_HARD_REFRESH, // recompute crit amount on hard refresh only
        ROLLING_SOFT_REFRESH, // recompute AP bonus on soft refresh (and hard refresh)
};

float RollingDot::computeStat(RollingStatTypes type, const Unit *caster, Unit *target, const SpellInfo *spellProto) {
    float value = 0.0f;
    if (!caster || !target || !spellProto) {
        sLog->outError("RollingDot: invalid caster/target/spell");
        return value;
    }
    
    switch(type) {
        case ROLLING_SPELL_POWER:
            // why the fuck Unit::SpellBaseDamageBonus & co are not const ? 
            value = const_cast<Unit*>(caster)->SpellBaseDamageBonus(spellProto->GetSchoolMask());
            break;
        case ROLLING_PCT_DAMAGE:
            value = const_cast<Unit*>(caster)->SpellDamageBonusDonePct(spellProto);
            break;
        case ROLLING_CRIT_CHANCE:
            value = caster->CalcCritChance(target, spellProto, spellProto->GetSchoolMask());
            break;
        case ROLLING_CRIT_AMOUNT:
            value = (caster->GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_CRIT_DAMAGE_BONUS, spellProto->GetSchoolMask()) - 1.0f) * 100;
            break;
        case ROLLING_ATTACK_POWER: {
                WeaponAttackType attType = (spellProto->IsRangedWeaponSpell() && spellProto->DmgClass != SPELL_DAMAGE_CLASS_MELEE) ? RANGED_ATTACK : BASE_ATTACK;
                value = float(caster->GetTotalAuraModifier(attType == BASE_ATTACK ? SPELL_AURA_MELEE_ATTACK_POWER_ATTACKER_BONUS : SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS));
                value += caster->GetTotalAttackPowerValue(attType);
            }
            break; 
        default:
            sLog->outError("RollingDot: unknown stat type %d", type);
            return value;
    };
    return value;
    
}

void RollingDot::doSoftRefresh(const Unit *caster, Unit *target) {
    for (RollingStatTypes i = ROLLING_STAT_START; i < ROLLING_STAT_COUNT; i = RollingStatTypes(int(i) + 1)) {
        if (stat2refresh[i] == ROLLING_SOFT_REFRESH)
            savedStats[i] = computeStat(i, caster, target, m_spellInfo);
    }
}

void RollingDot::doHardRefresh(const Unit *caster, Unit *target) {
    for (RollingStatTypes i = ROLLING_STAT_START; i < ROLLING_STAT_COUNT; i = RollingStatTypes(int(i) + 1)) {
        savedStats[i] = computeStat(i, caster,target, m_spellInfo);
    }
}
