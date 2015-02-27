#ifndef PROFILINGMGR_H
#define PROFILINGMGR_H 1
#include "Common.h"

class ProfilingMgr {
    public:
        enum ProfilingEnums {
            MAX_MAP = 1024,
        };
        inline static void setMapCurTime(uint32 mapid, uint32 time) {
            if (mapid >= MAX_MAP)
                return;
            timetab[mapid] = time;
            
        }
	inline static void setLastUpdatedGrid(uint32 mapid, uint32 gridx, uint32 gridy) {
		if (mapid >= MAX_MAP)
			return;
		gridtabx[mapid] = gridx;
		gridtaby[mapid] = gridy;
	}

        static uint32 getMaxTime(uint32 mapid, bool old);
	static void getLastUpdatedGrid(uint32 mapid, uint32 &gridx, uint32 &gridy, bool old);
        static void recordMaxTime();
        static void rotateMaxTime();
        static void Initialize();
        static void eraseMaxTime();
        
    private:
        static uint32 timetab[MAX_MAP];
        static uint32 oldtab[MAX_MAP];
        static uint32 maxtab[MAX_MAP];
	static uint32 gridtabx[MAX_MAP];
	static uint32 gridtaby[MAX_MAP];
	static uint32 oldgridtabx[MAX_MAP];
	static uint32 oldgridtaby[MAX_MAP];
	static uint32 maxgridtabx[MAX_MAP];
	static uint32 maxgridtaby[MAX_MAP];
    
};
#endif
