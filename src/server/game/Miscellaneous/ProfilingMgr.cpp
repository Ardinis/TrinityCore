/*
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

#include "ProfilingMgr.h"
void ProfilingMgr::recordMaxTime() {
            for (int i = 0; i < MAX_MAP; i++) {
                maxtab[i] = timetab[i];
		maxgridtabx[i] = gridtabx[i];
		maxgridtaby[i] = gridtaby[i];
            }
}
        
void ProfilingMgr::rotateMaxTime() {
            for (int i = 0; i < MAX_MAP; i++) {
                oldtab[i] = maxtab[i];
                maxtab[i] = 0;
		oldgridtabx[i] = maxgridtabx[i];
		maxgridtabx[i] = 0;
		oldgridtaby[i] = maxgridtaby[i];
		maxgridtaby[i] = 0;
            }
}
void ProfilingMgr::Initialize() {
            for (int i = 0; i < MAX_MAP; i++) {
                timetab[i] = 0;
                maxtab[i] = 0;
                oldtab[i] = 0;
		gridtabx[i] = 0;
		gridtaby[i] = 0;
		oldgridtabx[i] = 0;
		oldgridtaby[i] = 0;
            }
}

void ProfilingMgr::eraseMaxTime() {
            for (int i = 0; i < MAX_MAP; i++) {
                timetab[i] = 0;
		gridtabx[i] = 0;
		gridtaby[i] = 0;
            }
}

uint32 ProfilingMgr::getMaxTime(uint32 mapid, bool old) {
    if (mapid >= MAX_MAP)
        return 0;
    return (old ? oldtab : maxtab)[mapid];
}
void ProfilingMgr::getLastUpdatedGrid(uint32 mapid, uint32 &gridx, uint32 &gridy, bool old) {
    if (mapid >= MAX_MAP)
        return ;
    if (old) {
	gridx = oldgridtabx[mapid];
	gridy = oldgridtaby[mapid];	
    } else {
	gridx = maxgridtabx[mapid];
	gridy = maxgridtaby[mapid];
    }

}


uint32 ProfilingMgr::timetab[MAX_MAP];
uint32 ProfilingMgr::oldtab[MAX_MAP];
uint32 ProfilingMgr::maxtab[MAX_MAP];
uint32 ProfilingMgr::maxgridtabx[MAX_MAP];
uint32 ProfilingMgr::maxgridtaby[MAX_MAP];
uint32 ProfilingMgr::oldgridtabx[MAX_MAP];
uint32 ProfilingMgr::oldgridtaby[MAX_MAP];
uint32 ProfilingMgr::gridtabx[MAX_MAP];
uint32 ProfilingMgr::gridtaby[MAX_MAP];
