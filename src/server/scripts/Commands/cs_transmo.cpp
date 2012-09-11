#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "../Custom/TransmoMgr.h"

class transmo_commandscript : public CommandScript
{
public:
    transmo_commandscript() : CommandScript("transmo_commandscript") { }

	ChatCommand* GetCommands() const
    {
        static ChatCommand transmoCommandTable[] =
        {
            { "add",            SEC_ADMINISTRATOR,     false, &HandleTransmoAddCommand,			"", NULL },
            { "remove",         SEC_ADMINISTRATOR,     false, &HandleTransmoRemoveCommand,      "", NULL },
            { NULL,             0,                     false, NULL,                             "", NULL }
        };

        static ChatCommand commandTable[] =
        {
            { "transmo",        SEC_ADMINISTRATOR,     false, NULL,                             "", transmoCommandTable },
            { NULL,             0,                     false, NULL,                             "", NULL }
        };
        return commandTable;
    }

	static bool HandleTransmoAddCommand(ChatHandler* handler, char const* args)
	{
		if (!*args)
            return false;

		Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

		char* c_oldslot = strtok((char*)args, " ");
		char* c_newitemId = strtok(NULL, " ");
		if (!c_oldslot || !c_newitemId)
			return false;

		uint32 olditemSlot = atol(c_oldslot);
		if (olditemSlot >= EQUIPMENT_SLOT_TABARD)
		{
			handler->SendSysMessage("Error: Bad slot Id");
			handler->SetSentErrorMessage(true);
			return true;
		}
		Item* olditem = target->GetItemByPos(INVENTORY_SLOT_BAG_0, olditemSlot);
		if (!olditem)
		{
			handler->PSendSysMessage("Error: No item in slot: %u", olditemSlot);
			handler->SetSentErrorMessage(true);
			return true;
		}

		char* cId = handler->extractKeyFromLink(c_newitemId, "Hitem");
        if (!cId)
            return false;

		uint32 newitemId = atol(cId);
		Item* newitemItem = target->GetItemByEntry(newitemId);
		if (!newitemItem)
		{
			handler->PSendSysMessage("Error: you don't have this item (ID: %u)", newitemId);
            handler->SetSentErrorMessage(true);
			return true;
		}
		if (!target->AddTransmo(olditem->GetGUIDLow(), newitemId))
		{
			handler->SendSysMessage("Error!");
            handler->SetSentErrorMessage(true);
			return true;
		}
		else
			handler->PSendSysMessage("%s, Have now Item(%u) transmogrified with itemId: %u", target->GetName(), olditem->GetEntry(), newitemId);

		return true;
	}

	static bool HandleTransmoRemoveCommand(ChatHandler* handler, char const* args)
	{
		if (!args)
			return false;

		Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

		std::string argstr = args;
		if (argstr == "all")
		{
			target->RemoveAllTransmo();

			handler->PSendSysMessage("All items of player %s will no longer be transmogrified", target->GetName());
			return true;
		}

		uint64 itemGuidorSlot = atoi(args);
		if (Item *item = target->GetItemByGuid(itemGuidorSlot))
		{
			if (target->HaveTransmoByItem(item->GetGUIDLow()))
			{
				target->RemoveTransmo(item->GetGUIDLow());
				handler->PSendSysMessage("items Id %u of player %s will no longer be transmogrified", item->GetEntry(), target->GetName());
				return true;
			}
			else
			{
				handler->PSendSysMessage("Error: This item (Id: %u, Guid: %u) is not transmogrified", item->GetEntry(), itemGuidorSlot);
				return true;
			}
		}
		else if (itemGuidorSlot < EQUIPMENT_SLOT_TABARD)
		{
			if (Item* item = target->GetItemByPos(INVENTORY_SLOT_BAG_0, itemGuidorSlot))
			{
				if (target->HaveTransmoByItem(item->GetGUIDLow()))
				{
					target->RemoveTransmo(item->GetGUIDLow());
					handler->PSendSysMessage("items Id %u (Slot: %u) of player %s will no longer be transmogrified", item->GetEntry(), itemGuidorSlot, target->GetName());
					return true;
				}
				else
				{
					handler->PSendSysMessage("Error: This item (Id: %u, Guid: %u, Slot: %u) is not transmogrified", item->GetEntry(), item->GetGUID(), itemGuidorSlot);
					return true;
				}
			}
		}
			
		handler->SendSysMessage("Error: Bad item Guid or Bad item Slot");

		return true;
	}
};

void AddSC_transmo_commandscript()
{
    new transmo_commandscript();
}