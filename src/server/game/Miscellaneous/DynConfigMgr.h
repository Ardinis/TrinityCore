#ifndef DYNCONFIGMGR_H
#define DYNCONFIGMGR_H 1
#include "Common.h"

class DynConfigMgr {
    public:
        enum ConfigTypes {
            CONFIG_UNDERMAP_CHECK = 0,
            CONFIG_CHEAT_ALERT = 1,
            CONFIG_COMBAT_CHECK = 2,
            CONFIG_BG_INTERFACTION = 3,
            CONFIG_BG_UPDATE_INTERVAL = 4,
            CONFIG_ALLOW_NON_FULL_BG = 5,
            CONFIG_BG_BALANCE = 6,
            CONFIG_COUNT = 7,
        };
        
    
    static uint32 getValue(uint32 id);
    static bool setValue(uint32 id, uint32 val);
    static bool reload();

    private:
    static uint32 conftab[CONFIG_COUNT];
};
#endif
