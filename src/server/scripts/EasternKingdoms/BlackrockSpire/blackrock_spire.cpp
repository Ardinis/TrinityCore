#include "ScriptMgr.h"
#include "blackrock_spire.h"
#include "Player.h"

/*#####
# go_room_rune
#####*/

class go_room_rune : public GameObjectScript
{
public:
    go_room_rune() : GameObjectScript("go_room_rune") { }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            instance->SetData(DATA_RUNE, go->GetEntry());
        return false;
    }

};

void AddSC_blackrock_spire()
{
    new go_room_rune();
}
