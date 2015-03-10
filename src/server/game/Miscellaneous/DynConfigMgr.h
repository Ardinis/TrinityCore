#ifndef DYNCONFIGMGR_H
#define DYNCONFIGMGR_H 1
#include "Common.h"

class DynConfigMgr {
    public:
        enum ConfigTypes {
            CONFIG_TEST0 = 0,
            CONFIG_TEST1 = 1,
            CONFIG_COUNT = 2,
        };
        
    
    static uint32 getValue(uint32 id);
    static bool setValue(uint32 id, uint32 val);
    static bool reload();

    private:
    static uint32 conftab[CONFIG_COUNT];
};
#endif
