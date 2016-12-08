#include "ScriptPCH.h"
#include "TransmoMgr.h"

enum Lang
{
	GOSSIP_MENU_NOT_ENABLED		= 52000,
	GOSSIP_MAIN_MENU			= 52001,
	GOSSIP_REMOVE_TRANSMO		= 52002,
	GOSSIP_LIST_TRANSMO			= 52003,
	GOSSIP_NO_ITEM_TO_TRANSMO	= 52004
};

enum Menu
{
};

#define GOSSIP_SENDER_TRANSMO 1

class npc_transmo : public CreatureScript
{
public:
	npc_transmo() : CreatureScript("npc_transmo") {}

  bool OnGossipHello(Player* player, Creature* creature)
  {
    if (!sTransmoMgr->IsEnable())
    {
      player->SEND_GOSSIP_MENU(GOSSIP_MENU_NOT_ENABLED, creature->GetGUID());
      return true;
    }

    for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_TABARD; slot++)
    {
      if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
      {
	if (sTransmoMgr->IsAllowedQuality(item->GetTemplate()->Quality))
	  if (const char* slotName = GetSlotName(slot))
	    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, slotName, GOSSIP_SENDER_TRANSMO, slot);
      }
    }

    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_INTERACT_1, "Tout reinitaliser", GOSSIP_SENDER_TRANSMO+1, 0, "Etes-vous sure de vouloir annuler la transmogrification de tous vos items ?", 0, false);
    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Au revoir", GOSSIP_SENDER_TRANSMO+2, 0);
    player->SEND_GOSSIP_MENU(GOSSIP_MAIN_MENU, creature->GetGUID());
    return true;
  }

  bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
  {
    if (!player || !creature)
      return false;

    player->PlayerTalkClass->ClearMenus();
    if (!sTransmoMgr->IsEnable())
    {
      player->CLOSE_GOSSIP_MENU();
      return true;
    }

    switch (sender)
    {
    case GOSSIP_SENDER_TRANSMO:
    {
      if (Item *olditem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, action))
      {
	uint32 guidlow = olditem->GetGUIDLow();
	if (player->HaveTransmoByItem(olditem->GetGUIDLow()))
	{
	  if (Item* newSkinItem = player->GetItemByEntry(player->GetTransmoByItem(olditem->GetGUIDLow())))
	  {
	    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_INTERACT_1, "Reinitialiser au skin original", GOSSIP_SENDER_TRANSMO+3, guidlow, "Etes-vous sure de vouloir retirer la transmogrification de cet item ?", 0, false);
	    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "<- Menu", GOSSIP_SENDER_TRANSMO+4, 0);
	    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Au revoir", GOSSIP_SENDER_TRANSMO+2, 0);
	    SendRemoveTransmoNpcText(player, newSkinItem->GetTemplate());
	    player->SEND_GOSSIP_MENU(GOSSIP_REMOVE_TRANSMO, creature->GetGUID());
	    return true;
	  }

	  player->RemoveTransmo(olditem->GetGUIDLow());
	}
	uint8 itemcount = 0;
	char token[250] = "\n";
	if (sTransmoMgr->NeedToken())
	  snprintf(token, 250, "\n\n\n%u x %s", sTransmoMgr->GetTokenCount(), GetItemName(sObjectMgr->GetItemTemplate(sTransmoMgr->GetTokenId()), player->GetSession(), true).c_str());
	for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
	{
	  if (Item* newitem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
	  {
	    if (player->CanTransmo(olditem, newitem))
	    {
	      uint32 newitemEntry = newitem->GetEntry()+10;
	      int price = 400000;
	      if (ItemTemplate const* pProto = olditem->GetTemplate())
		if (pProto->BuyPrice > 0)
		  price += pProto->SellPrice;
	      price /= 10000;
	      std::string s;
	      std::stringstream out;
	      out << price;
	      s = out.str();
	      std::string box =  "Vous etes sur le point de transmogrifier votre item en :\r\n\r\n"+GetItemName(newitem->GetTemplate(), player->GetSession(), true)+"\r\n\r\nCet item va vous etre lie, vous ne pourrez plus echanger cet item.\r\nVoulez vous continuer ?" + "|TInterface\ICONS\INV_Misc_Coin_02.blp:32|t" + " Prix : " + s.c_str() + " pieces d'or";
	      player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_INTERACT_1, GetItemName(newitem->GetTemplate(), player->GetSession(), true), newitemEntry, guidlow, box, 0, false);
	      ++itemcount;
	    }
	  }
	}
	for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
	{
	  if (Bag* bag = player->GetBagByPos(i))
	  {
	    for (uint32 j = 0; j < bag->GetBagSize(); j++)
	    {
	      if (Item* newitem = player->GetItemByPos(i, j))
	      {
		if (player->CanTransmo(olditem, newitem))
		{
		  uint32 newitemEntry = newitem->GetEntry()+10;
		  int price = 400000;
		  if (ItemTemplate const* pProto = olditem->GetTemplate())
		    if (pProto->BuyPrice > 0)
		      price += pProto->SellPrice;
		  price /= 10000;
		  std::string s;
		  std::stringstream out;
		  out << price;
		  s = out.str();
		  std::string box =  "Vous etes sur le point de transmogrifier votre item en :\r\n\r\n"+GetItemName(newitem->GetTemplate(), player->GetSession(), true)+"\r\n\r\nCet item va vous etre lie, vous ne pourrez plus echanger cet item.\r\nVoulez vous continuer ?" + "|TInterface\ICONS\INV_Misc_Coin_02.blp:32|t" + " Prix : " + s.c_str() + " pieces d'or";
		  player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_INTERACT_1, GetItemName(newitem->GetTemplate(), player->GetSession(), true), newitemEntry, guidlow, box, 0, false);
		  ++itemcount;
		}
	      }
	    }
	  }
	}

	player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "<- Menu", GOSSIP_SENDER_TRANSMO+4, 0);
	player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Au revoir", GOSSIP_SENDER_TRANSMO+2, 0);
	if (itemcount == 0)
	{
	  player->SEND_GOSSIP_MENU(GOSSIP_NO_ITEM_TO_TRANSMO, creature->GetGUID());
	  return true;
	}
	player->SEND_GOSSIP_MENU(GOSSIP_LIST_TRANSMO, creature->GetGUID());
	return true;
      }
      break;
    }
    case GOSSIP_SENDER_TRANSMO+1:
    {
      player->RemoveAllTransmo();
      player->GetSession()->SendAreaTriggerMessage("Tous vos item ont etes reinitialises avec succes !");
      break;
    }
    case GOSSIP_SENDER_TRANSMO+2:
    {
      break;
    }
    case GOSSIP_SENDER_TRANSMO+3:
    {
      player->RemoveTransmo(action);
      if (Item* item = player->GetItemByGuid(MAKE_NEW_GUID(action, 0, HIGHGUID_ITEM)))
	player->GetSession()->SendAreaTriggerMessage("%s a ete reinitialise avec succes !", GetItemName(item->GetTemplate(), player->GetSession(), true).c_str());
      break;
    }
    case GOSSIP_SENDER_TRANSMO+4:
    {
      OnGossipHello(player, creature);
      return true;
    }
    default:
    {
      Item *newitem = player->GetItemByEntry(sender-10);
      Item *olditem = player->GetItemByGuid(MAKE_NEW_GUID(action, 0, HIGHGUID_ITEM));
      if (!newitem || !olditem)
      {
	player->GetSession()->SendNotification("ERROR: vous avez tente de tricher, une notification vien d'etre envoyee.");
	break;
      }

     if (ItemTemplate const* pProto = olditem->GetTemplate())
     {
       if (pProto->SellPrice < 0)
       {
	 player->GetSession()->SendAreaTriggerMessage("l'objet %s n'est pas transmogrifiable %s", GetItemName(newitem->GetTemplate(), player->GetSession(), true).c_str());
	 break;
       }
       if (!player->HasEnoughMoney(pProto->SellPrice + 400000))
       {
	 player->GetSession()->SendNotification("Vous n'avez pas assez d'argent.");
	 break;
       }
       //decrement money
       player->SetMoney(player->GetMoney() - pProto->SellPrice - 400000);
     }

      player->AddTransmo(action, newitem->GetEntry());
      newitem->SetNotRefundable(player);
      newitem->SetBinding(true);
      if (const char* slotName = GetSlotName(olditem->GetSlot()))
	player->GetSession()->SendAreaTriggerMessage("%s transmogrifie", slotName);
      else
	player->GetSession()->SendAreaTriggerMessage("%s transmogrifie", GetItemName(olditem->GetTemplate(), player->GetSession(), true).c_str());
      break;
    }
    }

    player->CLOSE_GOSSIP_MENU();
    return true;
  }

private:
  const char * GetSlotName(uint8 slot)
  {
    switch (slot)
    {
    case EQUIPMENT_SLOT_HEAD      : return "Tete";
    case EQUIPMENT_SLOT_SHOULDERS : return "Epaules";
    case EQUIPMENT_SLOT_BODY      : return "Chemise";
    case EQUIPMENT_SLOT_CHEST     : return "Torse";
    case EQUIPMENT_SLOT_WAIST     : return "Taille";
    case EQUIPMENT_SLOT_LEGS      : return "Jambes";
    case EQUIPMENT_SLOT_FEET      : return "Pieds";
    case EQUIPMENT_SLOT_WRISTS    : return "Poignets";
    case EQUIPMENT_SLOT_HANDS     : return "Mains";
    case EQUIPMENT_SLOT_BACK      : return "Dos";
    case EQUIPMENT_SLOT_MAINHAND  : return "Main droite";
    case EQUIPMENT_SLOT_OFFHAND   : return "Main gauche";
    case EQUIPMENT_SLOT_RANGED    : return "Distance";
    default: return NULL;
    }
  }

  std::string GetItemName(const ItemTemplate* itemTemplate, WorldSession* session, bool color = false)
  {
    std::string name = itemTemplate->Name1;
    std::string colorname;
    int loc_idx = session->GetSessionDbLocaleIndex();
    if (loc_idx >= 0)
      if (ItemLocale const* il = sObjectMgr->GetItemLocale(itemTemplate->ItemId))
	sObjectMgr->GetLocaleString(il->Name, loc_idx, name);

    if (color)
    {
      colorname = GetItemColor(itemTemplate->Quality) + "[" + name + "]|r";
      return colorname;
    }

    return name;
  }

  std::string GetItemColor(uint32 quality)
  {
    switch(quality)
    {
    case ITEM_QUALITY_POOR: return "|cff9d9d9d";
    case ITEM_QUALITY_NORMAL: return "|cffffffff";
    case ITEM_QUALITY_UNCOMMON: return "|cff1eff00";
    case ITEM_QUALITY_RARE: return "|cff0070dd";
    case ITEM_QUALITY_EPIC: return "|cffa335ee";
    case ITEM_QUALITY_LEGENDARY: return "|cffff8000";
    case ITEM_QUALITY_ARTIFACT:
    case ITEM_QUALITY_HEIRLOOM: return "|cffe6cc80";
    default: return "|cff9d9d9d";
    }
  }

  void SendRemoveTransmoNpcText(Player *player, const ItemTemplate* itemTemplate)
  {
    std::stringstream text;

    text << "Une transmogrification est deja en cours sur :" << std::endl << GetItemName(itemTemplate, player->GetSession(), true);

    WorldPacket data(SMSG_NPC_TEXT_UPDATE, 100);

    data << uint32(GOSSIP_REMOVE_TRANSMO);
    data << float(0);
    data << text.str();
    data << text.str();
    data << uint32(0);
    data << uint32(0);
    data << uint32(0);
    data << uint32(0);
    data << uint32(0);
    data << uint32(0);
    data << uint32(0);

    player->GetSession()->SendPacket(&data);
  }
};

void AddSC_npc_transmo()
{
  new npc_transmo();
}
