#include "ArenaSeason.h"


ArenaSeason::ArenaSeason()
{
    sLog->outString("Loading Extra Season Infos...");
    uint32 oldMSTime = getMSTime();
    QueryResult result = CharacterDatabase.Query("SELECT guid, wins FROM arena_extra_season_infos");
    if (!result)
        sLog->outString(">> Loaded 0 extra arena season infos. DB table `arena_extra_season_infos` is empty.");
    else
    {
        uint32 count = 0;

        do
        {
            if (Field* fields = result->Fetch())
                arenaSeasonExtraInfos[fields[0].GetUInt32()] = fields[1].GetUInt32();
        }
        while (result->NextRow());
        sLog->outString(">> Loaded %u arena extra infos in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    }
}

ArenaSeason::~ArenaSeason()
{

}

void ArenaSeason::updatePlayerScore(uint32 guid, bool win)
{// _arenaSeasonExtraInfos-
    if (win)
        arenaSeasonExtraInfos[guid] += 1;
    else
        arenaSeasonExtraInfos[guid] = 0;
    if (arenaSeasonExtraInfos[guid] && arenaSeasonExtraInfos[guid] % 2 == 0) // 2 victory
    {
        if (ItemTemplate const* item_proto = sObjectMgr->GetItemTemplate(TOKEN_ARENA_SEASON))
        {
            Player *player = ObjectAccessor::FindPlayer(MAKE_NEW_GUID(guid, 0, HIGHGUID_PLAYER));
            if (!player || !player->StoreNewItemInBestSlots(TOKEN_ARENA_SEASON, 1))
            {
                if (Item* item = Item::CreateItem(TOKEN_ARENA_SEASON, 1))
                {
                    SQLTransaction trans = CharacterDatabase.BeginTransaction();
                    std::string subject = player->GetSession()->GetTrinityString(LANG_NOT_EQUIPPED_ITEM);
                    MailDraft draft(subject, "Certains items ont eu un probleme.");
                    item->SaveToDB(trans);
                    draft.AddItem(item);
                    draft.SendMailTo(trans, player, MailSender(player, MAIL_STATIONERY_GM), MAIL_CHECK_MASK_COPIED);
                    CharacterDatabase.CommitTransaction(trans);
                }
            }
        }
    }
    CharacterDatabase.PExecute("UPDATE arena_extra_season_infos SET wins = %u WHERE guid = %u", arenaSeasonExtraInfos[guid], guid);
}
