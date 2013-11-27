#ifndef __ARENASEASON_H__
#define __ARENASEASON_H__

#include "Log.h"
#include "Object.h"
#include "Bag.h"
#include "Creature.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "Corpse.h"
#include "QuestDef.h"
#include "ItemPrototype.h"
#include "NPCHandler.h"
#include "DatabaseEnv.h"
#include "Mail.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "ObjectDefines.h"
#include <ace/Singleton.h>
#include "VehicleDefines.h"
#include <string>
#include <map>
#include <limits>
#include "ConditionMgr.h"
#include <functional>

#define TOKEN_ARENA_SEASON 100000

class ArenaSeason
{
 public:
    ArenaSeason();
    ~ArenaSeason();
    void updatePlayerScore(uint32 guid, bool win);

 private:
    std::map<uint32, uint32 > arenaSeasonExtraInfos;
};


#endif
