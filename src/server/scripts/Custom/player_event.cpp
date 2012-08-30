#include "ScriptMgr.h"


class player_event : public PlayerScript
{
    public:
        player_event() : PlayerScript("player_event") 
  { 
  }


  /*  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("grml") != std::string::npos)
      {
	uint16 display_id = 25149;
	player->SetDisplayId(display_id);
      }
    if (msg.find("grognie") != std::string::npos)
      {
	uint16 display_id = 29348;
	player->SetDisplayId(display_id);
      }
    if (msg.find("bourbie") != std::string::npos)
      {
	uint16 display_id = 15369;
	player->SetDisplayId(display_id);
      }
    if (msg.find("gloubie") != std::string::npos)
      {
	uint16 display_id = 15984;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* receiver)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
      }*/



};

#define NPC_CUSTOM_PACK_ENTRY 10000000
#define CUSTOM_PACK_SPELL 2000099
#define CLONE_MINI_MOI 45204
#define CLONE_MINI_MOI_NAME 69837

class item_mini_moi : public ItemScript
{
public:
  item_mini_moi() : ItemScript("item_mini_moi") { }

  bool OnUse(Player* player, Item* pItem, SpellCastTargets const& targets)
  {
    if (!player || !player->IsInWorld() || !player->isAlive())
      return true;

    Unit* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*player, player->GetCritterGUID());
    if (pet && pet->GetEntry() == NPC_CUSTOM_PACK_ENTRY)
      {
	if (pet->GetTypeId() == TYPEID_UNIT && pet->ToCreature()->isSummon())
	  pet->ToTempSummon()->UnSummon();

	return true;
      }

    /*    if (player->InArena())
      {
	player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pItem, NULL);
	return true;
      }

    if (player->HasUnitState(UNIT_STATE_CANNOT_AUTOATTACK))
      {
	player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pItem, NULL);
	return true;
	}*/

    player->CastSpell(player, CUSTOM_PACK_SPELL, true);
    pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*player, player->GetCritterGUID());
    if (pet && pet->GetEntry() == NPC_CUSTOM_PACK_ENTRY)
      {
	if (pet->ToCreature())
	  {
	    if (pet->ToCreature()->isSummon())
	      {
		if (Unit *cameleon = targets.GetUnitTarget())
		  {
		    cameleon->CastSpell(pet, 45204, true);
		    pet->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
		  }
		else
		  {
		    player->CastSpell(pet, 45204, true);
                    pet->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
		  }
	      }
	  }
      }
    //    targets.GetUnitTarget();
    return false;
  }
};



/* SQL

DELETE FROM spell_dbc WHERE entry = 2000099;
INSERT INTO `spell_dbc` VALUES ('2000099', '0', '0', '268435712', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '101', '0', '0', '0', '0', '6', '1', '0', '-1', '0', '0', '28', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '18', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10000000', '0', '0', '41', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', 'Invoque un mini-moi');
DELETE FROM `item_template` WHERE entry='10000000';
INSERT INTO `item_template` VALUES ('10000000', '15', '0', '-1', 'Mini moi', '16065', '5', '0', '0', '1', '0', '0', '0', '-1', '-1', '174', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '46350', '0', '0', '0', '1000', '0', '-1', '0', '0', '0', '0', '-1', '0', '-1', '0', '0', '0', '0', '-1', '0', '-1', '0', '0', '0', '0', '-1', '0', '-1', '0', '0', '0', '0', '-1', '0', '-1', '1', 'Invoque un mini-moi.', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '-1', '0', '0', '0', '0', 'item_mini_moi', '0', '0', '0', '0', '1');
INSERT INTO `creature_template` VALUES ('10000000', '0', '0', '0', '0', '0', '22399', '0', '22399', '0', 'mini-moi', 'Paragon pet', null, '0', '81', '81', '0', '35', '35', '1', '1', '1', '1', '3', '10000', '10000', '1', '35', '35', '4224', '1', '1', '130', '8', '0', '0', '0', '0', '0', '0', '0', '0', '12', '130', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '1700', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', 'npc_mini_moi', '0');

 */

void AddSC_player_event()
{
    new player_event();
    new item_mini_moi();
}
