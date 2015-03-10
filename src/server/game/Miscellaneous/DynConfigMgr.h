#ifndef DYNCONFIGMGR_H
#define DYNCONFIGMGR_H 1
#include "Common.h"

class DynConfigMgr {
    public:
        enum ConfigTypes {
            CONFIG_UNDERMAP_CHECK = 0,
            CONFIG_CHEAT_ALERT = 1,
			CONFIG_COMBAT_CHECK = 2,
            CONFIG_COUNT = 3,
        };
        
    
    static uint32 getValue(uint32 id);
    static bool setValue(uint32 id, uint32 val);
    static bool reload();

    private:
    static uint32 conftab[CONFIG_COUNT];
};
#endif
