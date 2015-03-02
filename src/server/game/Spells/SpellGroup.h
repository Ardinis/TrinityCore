#ifndef _SPELLGROUP_H   
#define _SPELLGROUP_H 

#include <set>
#include <map>

enum SpellGroup
{
    SPELL_GROUP_NONE = 0,
    SPELL_GROUP_ELIXIR_BATTLE = 1,
    SPELL_GROUP_ELIXIR_GUARDIAN = 2,
    SPELL_GROUP_ELIXIR_UNSTABLE = 3,
    SPELL_GROUP_ELIXIR_SHATTRATH = 4,
    SPELL_GROUP_CORE_RANGE_MAX = 5,
};

struct ModifierAura {
    uint32 spell_id;
    float amount;
};

struct ModifierAuraComparator {
    bool operator()(const ModifierAura& a, const ModifierAura& b) const;
};

typedef std::multiset<ModifierAura,ModifierAuraComparator> ModifierAuraGroup;
typedef std::map<SpellGroup, ModifierAuraGroup> ModifierAuraGroupMap;

#endif /*_SPELLGROUP_H*/

