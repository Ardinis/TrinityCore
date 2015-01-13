/*
 * Recuperation automatique
 * Pour Oxygen-Servers
 */
 
#ifndef RECUPMGRAUTO_H
#define RECUPMGRAUTO_H 1
#include "Common.h"
#include "Guild.h"
#include "RecupMgr.h"



class RecupMgrAuto : public RecupMgr {
        friend class BackgroundRecupTask;
        friend class Object;
	public:


		static bool DoRecupAuto(Player *player);
		static int GetRecupMode(Player *plr);
		static bool LoadFromDB();
		static void BuildFactionReverseIndex();
		static bool isInList(int type, uint32 id);
		static int GetRecupGuildStatus(Player *plr);
		static void SetRecupGuildStatus(Player *plr, uint32 status);
		static void BuildFlyMastersIndex();
		static void fillGuildBank(Player *player, Guild *guild);
                static void GiveFaction(Player *player, const FactionEntry *faction_entry, uint32 reput_rank);
                static void GiveCriteria(Player *player, const AchievementCriteriaEntry *criteria, uint32 progress);
                static void CompleteQuest(Player *player, uint32 quest_id);

	private:

	//specifique aux recups auto
        enum RecupListType {
            RECUP_LIST_ACHIEVEMENT = 0,
            RECUP_LIST_MONTURE_MINIPET = 1,
            RECUP_LIST_ITEM = 2,
            RECUP_LIST_CRITERIA = 3,
            RECUP_LIST_QUEST = 4,
            RECUP_LIST_SKILL = 5,
            RECUP_LIST_QUEST_PALLIER = 6,
            RECUP_LIST_REPUTATION = 7,
        };


		static bool GiveSkillById(Player *player, int id_metier, int level);
		static bool HandleLinkRecupTableAuto(Player *player, int ilevel);
		static void GiveFlyMasters(Player *player);

		static bool recup_enable;
		static std::vector<std::set<uint32> > recup_lists;
		static std::map<int32, uint32> reput_list;
		static std::map<uint32, uint16> taxi_flag;
		static std::map<uint32, uint32> recup_remplace;
		 
};
class BackgroundRecupTask {
    friend class RecupMgrAuto;
    
    public:
        static BackgroundRecupTask* Factory(Player *_player, int ilevel);
        
        BackgroundRecupTask(Player *_player, int _ilevel) {
            player = _player;
            ilevel = _ilevel;
	    uint64 guid = player->GetGUID();       
	    PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_GET_RECUP_DATA);
	    stmt->setUInt32(0, guid);
	    res = CharacterDatabase.Query(stmt);
	    invoc_count = 0;
        }
        
        ~BackgroundRecupTask() {
        }
        int Process();
    
    private:

        PreparedQueryResult res;
	typedef std::pair<uint32,uint32> ItemPair;
        typedef std::list< ItemPair > ItemPairs;
        typedef std::pair<uint32, std::string> PetRecup;
        std::list<PetRecup> pet_list;
        std::list<std::pair<uint32, uint32> > trades;
        ItemPairs items;
        int ilevel;
        int invoc_count;
        Player *player;

};

#endif
