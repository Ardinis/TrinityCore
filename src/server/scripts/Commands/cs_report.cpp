#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "Player.h"
#include "Opcodes.h"
#include "Chat.h"
#include "ObjectAccessor.h"
#include "Language.h"
#include "AccountMgr.h"
#include "SystemConfig.h"
#include "revision.h"
#include "Util.h"
#include "math.h"

class report_commandscript : public CommandScript
{
public:
    report_commandscript() : CommandScript("report_commandscript") { }

    ChatCommand* GetCommands() const
    {
        static ChatCommand reportCommandTable[] =
        {
            { "quest",            SEC_ADMINISTRATOR,  false, &HandleReportQuest,                    "", NULL },
            { "complete",       SEC_ADMINISTRATOR,  false, &HandleReportComplete,               "", NULL },
            { "remove",         SEC_ADMINISTRATOR,  false, &HandleReportRemove,                 "", NULL },
            { "info",         SEC_ADMINISTRATOR,  false, &HandleReportInfo,                 "", NULL },
            { NULL,             0,                  false, NULL,                               "", NULL }
        };
        static ChatCommand commandTable[] =
        {
            { "report",          SEC_ADMINISTRATOR,  false, NULL,                  "", reportCommandTable },
            { NULL,             0,                  false, NULL,                               "", NULL }
        };
        return commandTable;
    }

    static bool HandleReportQuest(ChatHandler* handler, const char* args)
    {
        Player *player = handler->GetSession()->GetPlayer();
        int32 statut = 0;
        int32 count = 1;
        bool alreadyReportByPlayer = true;
        if (!args)
            return false;
        char* qId = handler->extractKeyFromLink((char *)(args), "Hquest");
        if (!qId)
            return false;
        if (qId[0] >= '0' || qId[0] >= '9')
            if (uint32 quest = atoi(qId))
            {
                if (!quest)
                    return false;
                QueryResult result = WorldDatabase.PQuery("SELECT status, count FROM report_quest WHERE id='%d'", quest);
                if (!result)
                    return createReport(quest, count, 0, player->GetGUID(), handler);
                Field *fields = result->Fetch();
                statut = fields[0].GetInt32();
                count = fields[1].GetInt32();
                QueryResult resultit = CharacterDatabase.PQuery("SELECT guid FROM char_report_quests WHERE quest='%d' and guid = '%d'", quest, player->GetGUID());
                if (!resultit)
                    alreadyReportByPlayer = false;
                else
                    alreadyReportByPlayer = true;
                switch(statut)
                {
                case 0:
                    handler->PSendSysMessage(LANG_REPORT_QUEST_STATUT_UNVERIFIED);
                    break;
                case 1:
                    if (!ValidQuest(quest, player, handler))
                        return false;
                    handler->PSendSysMessage(LANG_REPORT_QUEST_STATUT_BUG);
                    break;
                case 2:
                    handler->PSendSysMessage(LANG_REPORT_QUEST_STATUT_NOT_BUG);
                    break;
                default :
                    break;
                }
                if (alreadyReportByPlayer)
                    return true;
                count++;
                CharacterDatabase.PExecute("INSERT INTO char_report_quests(guid, quest) VALUES('%d', '%d')", player->GetGUID(), quest);
                WorldDatabase.PExecute("UPDATE report_quest SET count = '%d' where id='%d'"	, count, quest);
                return true;
            }
        return false;
    }

    static bool HandleReportRemove(ChatHandler* handler, const char* args)
    {
        Player *player = handler->GetSession()->GetPlayer();
        int32 statut = 0;
        if (!args)
            return false;
        char* qId = handler->extractKeyFromLink((char *)(args), "Hquest");
        if (!qId)
            return false;
        if (qId[0] >= '0' || qId[0] >= '9')
            if (uint32 quest = atoi(qId))
            {
                if (!quest)
                    return false;
                QueryResult result = WorldDatabase.PQuery("SELECT status, count FROM report_quest WHERE id='%d'", quest);
                if (!result)
                    return createReport(quest, 1, 2, player->GetGUID(), handler);
                Field *fields = result->Fetch();
                statut = fields[0].GetInt32();
                if (statut != 2)
                {
                    WorldDatabase.PQuery("UPDATE report_quest SET status = 2 where id='%d'", quest);
                    handler->PSendSysMessage(LANG_REPORT_QUEST_REMOVE_SUCCESS);
                }
                else
                    handler->PSendSysMessage(LANG_REPORT_QUEST_REMOVE_FAIL);
                return true;
            }
        return false;
    }

    static bool HandleReportInfo(ChatHandler* handler, const char* args)
    {
        Player *player = handler->GetSession()->GetPlayer();
        int32 statut = 0;
        if (!args)
            return false;
        char* qId = handler->extractKeyFromLink((char *)(args), "Hquest");
        if (!qId)
            return false;
        if (qId[0] >= '0' || qId[0] >= '9')
            if (uint32 quest = atoi(qId))
            {
                if (!quest)
                    return false;
                QueryResult result = WorldDatabase.PQuery("SELECT status, count FROM report_quest WHERE id='%d'", quest);
                if (!result)
                {
                    handler->PSendSysMessage(LANG_REPORT_NOT_REPORT);
                    return true;
                }
                Field *fields = result->Fetch();
                statut = fields[0].GetInt32();
                switch(statut)
                {
                case 0:
                    handler->PSendSysMessage(LANG_REPORT_NOT_VERIFIED);
                    break;
                case 1:
                    handler->PSendSysMessage(LANG_REPORT_REPORT_BUG);
                    break;
                case 2:
                    handler->PSendSysMessage(LANG_REPORT_NOT_BUG);
                    break;
                default:
                    break;
                }
                return true;
            }
        return false;
    }

    static bool HandleReportComplete(ChatHandler* handler, const char* args)
    {
        Player *player = handler->GetSession()->GetPlayer();
        int32 statut = 0;
        if (!args)
            return false;
        char* qId = handler->extractKeyFromLink((char *)(args), "Hquest");
        if (!qId)
            return false;
        if (qId[0] >= '0' || qId[0] >= '9')
            if (uint32 quest = atoi(qId))
            {
                if (!quest)
                    return false;
                QueryResult result = WorldDatabase.PQuery("SELECT status, count FROM report_quest WHERE id='%d'", quest);
                if (!result)
                    return createReport(quest, 1, 1, player->GetGUID(), handler);
                Field *fields = result->Fetch();
                statut = fields[0].GetInt32();
                if (statut != 1)
                {
                    WorldDatabase.PQuery("UPDATE report_quest SET status = 1 where id='%d'", quest);
                    handler->PSendSysMessage(LANG_REPORT_QUEST_COMPLETE_SUCCESS);
                }
                else
                    handler->PSendSysMessage(LANG_REPORT_QUEST_COMPLETE_FAIL);
                return true;
            }
        return false;
    }


  static bool ValidQuest(uint32 quest, Player *player, ChatHandler* handler)
  {
      uint32 entry = quest;
      Quest const* pQuest = sObjectMgr->GetQuestTemplate(entry);
      if (!pQuest || player->GetQuestStatus(entry) == QUEST_STATUS_NONE)
      {
          handler->PSendSysMessage(LANG_REPORT_QUEST_NOT_FOUND);
          return false;
      }

      for (uint8 x = 0; x < QUEST_ITEM_OBJECTIVES_COUNT; ++x)
      {
          uint32 id = pQuest->RequiredItemId[x];
          uint32 count = pQuest->RequiredItemCount[x];
          if (!id || !count)
              continue;

          uint32 curItemCount = player->GetItemCount(id, true);

          ItemPosCountVec dest;
          uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, id, count-curItemCount);
          if (msg == EQUIP_ERR_OK)
          {
              Item* item = player->StoreNewItem(dest, id, true);
              player->SendNewItem(item, count-curItemCount, true, false);
          }
      }

      // All creature/GO slain/casted (not required, but otherwise it will display "Creature slain 0/10")
      for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
      {
          int32 creature = pQuest->RequiredNpcOrGo[i];
          uint32 creaturecount = pQuest->RequiredNpcOrGoCount[i];

          if (uint32 spell_id = pQuest->RequiredSpellCast[i])
          {
              for (uint16 z = 0; z < creaturecount; ++z)
                  player->CastedCreatureOrGO(creature, 0, spell_id);
          }
          else if (creature > 0)
          {
              if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(creature))
                  for (uint16 z = 0; z < creaturecount; ++z)
                      player->KilledMonster(cInfo, 0);
          }
          else if (creature < 0)
          {
              for (uint16 z = 0; z < creaturecount; ++z)
                  player->CastedCreatureOrGO(creature, 0, 0);
          }
      }

      // If the quest requires reputation to complete
      if (uint32 repFaction = pQuest->GetRepObjectiveFaction())
      {
          uint32 repValue = pQuest->GetRepObjectiveValue();
          uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
          if (curRep < repValue)
              if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
                  player->GetReputationMgr().SetReputation(factionEntry, repValue);
      }

      // If the quest requires a SECOND reputation to complete
      if (uint32 repFaction = pQuest->GetRepObjectiveFaction2())
      {
          uint32 repValue2 = pQuest->GetRepObjectiveValue2();
          uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
          if (curRep < repValue2)
              if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
                  player->GetReputationMgr().SetReputation(factionEntry, repValue2);
      }

      // If the quest requires money
      int32 ReqOrRewMoney = pQuest->GetRewOrReqMoney();
      if (ReqOrRewMoney < 0)
          player->ModifyMoney(-ReqOrRewMoney);
      player->CompleteQuest(entry);
      return true;
  }

    static bool createReport(uint32 quest, int32 count, int status, uint64 guid, ChatHandler* handler)
    {
        WorldDatabase.PExecute("INSERT INTO report_quest(id, count, status, comment) VALUES('%d', '%d', '%d', '%s')", quest, count, status, "");
        CharacterDatabase.PExecute("INSERT INTO char_report_quests(guid, quest) VALUES('%d', '%d')", guid, quest);
        handler->PSendSysMessage(LANG_REPORT_QUEST_FIRST_REPORT);
        switch (status)
        {
        case 0:
            break;
        case 1:
            handler->PSendSysMessage(LANG_REPORT_QUEST_COMPLETE_SUCCESS);
            break;
        case 2:
            handler->PSendSysMessage(LANG_REPORT_QUEST_REMOVE_SUCCESS);
            break;
        default:
            break;
        }
        return true;
    }
};

void AddSC_report_commandscript()
{
    new report_commandscript();
}
