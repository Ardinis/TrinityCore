#include "ScriptMgr.h"
#include "GameEventMgr.h"

enum EventMorph
{
  HALLOWEEN = 12,
  MIDSUMMER_FIRE_FESTIVAL = 1,
  WINTER_VEIL = 2,
};

class player_event : public PlayerScript
{
    public:
        player_event() : PlayerScript("player_event")
  {
  }


  void Transmform(std::string& msg, Player* player)
  {
    if (IsEventActive((uint16)HALLOWEEN))
    {
      if (msg.find("goule") != std::string::npos)
      {
          uint16 display_id = 414;
          player->SetDisplayId(display_id);
      }
      if (msg.find("sorciere") != std::string::npos)
      {
          uint16 display_id = 984;
          player->SetDisplayId(display_id);
      }
      if (msg.find("fantome") != std::string::npos)
      {
          uint16 display_id = 146;
          player->SetDisplayId(display_id);
      }
      if (msg.find("citrouille") != std::string::npos)
      {
          uint16 display_id = 21822;
          player->SetDisplayId(display_id);
      }
      if (msg.find("vampire") != std::string::npos)
      {
          uint16 display_id = 25338;
          player->SetDisplayId(display_id);
      }
      if (msg.find("zombie") != std::string::npos)
      {
          uint16 display_id = 10256;
          player->SetDisplayId(display_id);
      }
      if (msg.find("chauve souris") != std::string::npos)
      {
          uint16 display_id = 11071;
          player->SetDisplayId(display_id);
      }
      if (msg.find("squelette") != std::string::npos)
      {
          uint16 display_id = 11403;
          player->SetDisplayId(display_id);
      }
      if (msg.find("garou") != std::string::npos)
      {
          uint16 display_id = 26787;
          player->SetDisplayId(display_id);
      }
      if (msg.find("araigne") != std::string::npos)
      {
          uint16 display_id = 1087;
          player->SetDisplayId(display_id);
      }
      if (msg.find("liche") != std::string::npos)
      {
          uint16 display_id = 7919;
          player->SetDisplayId(display_id);
      }

      if (msg.find("demorph") != std::string::npos)
          player->SetDisplayId(player->GetNativeDisplayId());
    }
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg)
  {
    Transmform(msg, player);
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* receiver)
  {
    Transmform(msg, player);
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group)
  {
    Transmform(msg, player);
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild)
  {
    Transmform(msg, player);
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel)
  {
    Transmform(msg, player);
  }

    void OnLogin(Player* player)
    {
        uint32 gladAchievement = 2091;
        uint32 duelAchievement = 2092;
        uint32 rivalAchievement = 2093;
        uint32 compAchievement = 2090;
        uint32 gladTitle = 42;
        uint32 duellisteTitle = 43;
        uint32 rivalTitle = 44;
        uint32 compTitle = 45;

        switch (player->GetGUID())
        {
            // glad titr�
            case 542102:
            case 574602:
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(128))
                    player->SetTitle(titleInfo);
                // glad simple
            case 102703:
            case 446405:
            case 61050:
            case 199034:
            case 93405:
            case 145880:
            case 541401:
            {
                for (int i = 0; i < 4; i++)
                    if (AchievementEntry const* achievementEntry = sAchievementStore.LookupEntry(gladAchievement+i))
                        player->CompletedAchievement(achievementEntry);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle))
                    player->SetTitle(titleInfo);
                for (int i = 1; i < 4; i++)
                    if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle+i))
                        player->SetTitle(titleInfo, true);
                break;
            }
            case 96038:
            {
                for (int i = 0; i < 4; i++)
                    if (AchievementEntry const* achievementEntry = sAchievementStore.LookupEntry(gladAchievement+i))
                        player->CompletedAchievement(achievementEntry);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle))
                    player->SetTitle(titleInfo);
                for (int i = 0; i < 4; i++)
                    if (gladTitle+i != gladTitle && gladTitle+i != duellisteTitle)
                        if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle+i))
                            player->SetTitle(titleInfo, true);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(duellisteTitle))
                    player->SetTitle(titleInfo);
                break;
            }
            // duelliste1
            case 95057:
            case 437264:
            case 57687:
            case 69420:
            case 80853:
            {
                for (int i = 1; i < 4; i++)
                    if (AchievementEntry const* achievementEntry = sAchievementStore.LookupEntry(gladAchievement+i))
                        player->CompletedAchievement(achievementEntry);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(duellisteTitle))
                    player->SetTitle(titleInfo);
                for (int i = 0; i < 4; i++)
                    if (i != 1)
                        if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle+i))
                            player->SetTitle(titleInfo, true);
                break;
            }
            // rival
            case 49021:
            case 58488:
            {
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(128))
                    player->SetTitle(titleInfo);
                for (int i = 0; i < 4; i++)
                    if (AchievementEntry const* achievementEntry = sAchievementStore.LookupEntry(gladAchievement+i))
                        player->CompletedAchievement(achievementEntry);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle))
                    player->SetTitle(titleInfo);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(rivalTitle))
                    player->SetTitle(titleInfo);
                for (int i = 1; i < 4; i++)
                    if (gladTitle+i != rivalTitle && gladTitle+i != rivalTitle)
                        if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle+i))
                            player->SetTitle(titleInfo, true);
                break;
            }
            case 101344:
            case 176353:
            {
                for (int i = 2; i < 4; i++)
                    if (AchievementEntry const* achievementEntry = sAchievementStore.LookupEntry(gladAchievement+i))
                        player->CompletedAchievement(achievementEntry);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(rivalTitle))
                    player->SetTitle(titleInfo);
                for (int i = 0; i < 4; i++)
                    if (i != 2)
                        if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle+i))
                            player->SetTitle(titleInfo, true);
                break;
            }
            // competiteur
            case 88424:
            case 448355:
            {
                for (int i = 1; i < 4; i++)
                    if (AchievementEntry const* achievementEntry = sAchievementStore.LookupEntry(gladAchievement+i))
                        player->CompletedAchievement(achievementEntry);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(duellisteTitle))
                    player->SetTitle(titleInfo);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(compTitle))
                    player->SetTitle(titleInfo);
                for (int i = 0; i < 4; i++)
                    if (gladTitle+i != duellisteTitle && gladTitle+i != compTitle)
                        if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle+i))
                            player->SetTitle(titleInfo, true);
                break;
            }
            case 111064:
            case 44899:
            case 439653:
            {
                if (AchievementEntry const* achievementEntry = sAchievementStore.LookupEntry(compAchievement))
                    player->CompletedAchievement(achievementEntry);
                if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(compTitle))
                    player->SetTitle(titleInfo);
                for (int i = 0; i < 4; i++)
                    if (i != 3)
                        if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle+i))
                            player->SetTitle(titleInfo, true);
                break;
            }
            default:
            {
                for (int i = 0; i < 4; i++)
                    if (CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(gladTitle+i))
                        player->SetTitle(titleInfo, true);
                break;
            }
        }
    }
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
		    if (cameleon->GetTypeId() == TYPEID_PLAYER)
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
