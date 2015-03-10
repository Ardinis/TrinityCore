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

#include "DynConfigMgr.h"

extern uint32 realmID;

uint32 DynConfigMgr::getValue(uint32 id) {
  if (id >= CONFIG_COUNT) {
    return 0;
  }
  return conftab[id];
}

bool DynConfigMgr::setValue(uint32 id, uint32 val) {
  if (id >= CONFIG_COUNT) {
    sLog->outError("DynConfigMgr::setValue(): Invalid ID %u", id);
    return false;
  }
  conftab[id] = val;
  PreparedStatement *stmt = LoginDatabase.GetPreparedStatement(LOGIN_CONFIG_SET);
  stmt->setUInt32(0, id);
  stmt->setUInt32(1, realmID);
  stmt->setUInt32(2, val);
  LoginDatabase.Execute(stmt);
}

bool DynConfigMgr::reload() {
  PreparedStatement *stmt = LoginDatabase.GetPreparedStatement(LOGIN_CONFIG_LOAD);
  stmt->setUInt32(0, realmID);
  PreparedQueryResult res = LoginDatabase.Query(stmt);
  
  if (res) {
    do {
      Field *fields = res->Fetch();
      if (!fields) {
        sLog->outError("DynConfigMgr::reload(): Fields is NULL");
        return false;
      }
      uint32 id = fields[0].GetUInt32();
      uint32 val = fields[1].GetUInt32();
      if (id >= CONFIG_COUNT) {
        sLog->outError("DynConfigMgr::reload(): Invalid ID %d", id);
        return false;
      }
      conftab[id] = val;
      
    } while (res->NextRow());
  }
  sLog->outString("DynConfigMgr: reloaded.");
  return true;
}
            
uint32 DynConfigMgr::conftab[CONFIG_COUNT];
