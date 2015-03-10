#ifndef ROLLING_DOT_H
#define ROLLING_DOT_H

#include "Unit.h"
#include "SpellInfo.h"

enum RollingRefreshTypes {
    ROLLING_SOFT_REFRESH = 0,
    ROLLING_HARD_REFRESH = 1,
};

enum RollingStatTypes {
    ROLLING_STAT_START = 0,
    ROLLING_SPELL_POWER = 0,
    ROLLING_PCT_DAMAGE = 1,
    ROLLING_CRIT_CHANCE = 2,
    ROLLING_CRIT_AMOUNT = 3,
    ROLLING_ATTACK_POWER = 4,
    ROLLING_STAT_COUNT = 5,
};

class RollingDot {
  private:
    float savedStats[ROLLING_STAT_COUNT];
    const SpellInfo *m_spellInfo;
    
    static RollingRefreshTypes stat2refresh[ROLLING_STAT_COUNT];
  public:
    RollingDot(const SpellInfo *spellProto) : m_spellInfo(spellProto) {
        for (RollingStatTypes i = ROLLING_STAT_START; i < ROLLING_STAT_COUNT; i = RollingStatTypes(int(i) + 1)) {
            savedStats[i] = -1;
        }
    }
    
    // Get saved value is available, compute it directly otherwise.
    inline static float getValue(RollingStatTypes type, const Unit *caster, Unit *target, const SpellInfo *spellProto, RollingDot *rdot = NULL) {
        if ((rdot == NULL) || (rdot->savedStats[type] < 0)) {
            return computeStat(type, caster, target, spellProto);
        } else {
            return rdot->savedStats[type];
        }
    }
    
    static float computeStat(RollingStatTypes type, const Unit *caster, Unit *target, const SpellInfo *spellProto);
    
    // (re-)compute and save all needed stats on soft refresh
    void doSoftRefresh(const Unit *caster, Unit *target);
    
    // (re-)compute and safe all needed stats on hard refresh
    void doHardRefresh(const Unit *caster, Unit *target);
};
#endif
