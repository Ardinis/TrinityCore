#ifndef RECUPMGR_H
#define RECUPMGR_H 1
#include "Common.h"


class RecupMgr {
    public:
        typedef struct {
            uint32 map;
            float x;
            float y;
            float z;
            float o;
        } TPLocation;

        enum RecupPhasing {
            SPELL_RECUP_HELPER = 199998,
            SPELL_RECUP_PHASING_BEGIN = 200000,
            SPELL_RECUP_PHASING_ALLIANCE = 200000, 
            SPELL_RECUP_PHASING_HORDE = 200003, 
            SPELL_RECUP_PHASING_END = 200006,
            SPELL_RECUP_PHASING_GLYPHES_ETC = 200042,
        };
        
        enum RecupStatus {
            RECUP_STATUS_NONE = -1,
            RECUP_STATUS_NOT_STARTED = 0,
            RECUP_STATUS_IN_PROGRESS = 1,
            RECUP_STATUS_FINISHED = 2,
            RECUP_STATUS_FAILED = 3,
        };
        
        enum RecupChecks {
            RECUP_CHECK_INTERVAL = 5000,
            RECUP_MAX_DIST_SQUARED = 45*45,
        };

        static const TPLocation AccueilVisiteurs;
        static const TPLocation TPDest;

        static int MainBagSpace(Player *player);        
        static void SetRecupStatus(Player *player, int status);
        static int GetRecupStatus(Player *plr);
        static int GetRecupValidation(Player *plr);
        static bool IsDoubleStuff(Player *plr);
        static bool DoVisite(Player *player);
        static bool DoRecup(Player *player);
        static bool HasNonAllowedItems(Player *player);
        static bool RecheckMoney(Player *player);
        
        
    private:
        
        static bool GiveSkill(Player *player, int id_metier, int level);
        static bool HandleLinkRecupTable(Player *player);
        static bool DoLearnWeapons(Player *player);
        
    protected:

        enum RecupFieldType {
            FIELD_TYPE_MONEY = 1,
            FIELD_TYPE_ITEM = 2,
            FIELD_TYPE_COMPETENCE = 3,
            FIELD_TYPE_DOUBLE_SPE = 4,
            FIELD_TYPE_LEVEL = 5,
            FIELD_TYPE_HUNTER_PET = 6,
            FIELD_TYPE_RESERVED = 7,
            FIELD_TYPE_DONE = 8,
            FIELD_TYPE_SPELL = 9,
            FIELD_TYPE_ILEVEL = 10,
            FIELD_TYPE_REPUT = 11,
            FIELD_TYPE_DOUBLE_STUFF = 12,
			FIELD_TYPE_MODE = 13,
			FIELD_TYPE_HF = 14,
			FIELD_TYPE_MAP= 15,
			FIELD_TYPE_QUEST = 16,
			FIELD_TYPE_GUILD_STATUS = 19,
			FIELD_TYPE_ACHIEVEMENT_CRITERIA=21,
			FIELD_TYPE_GUILD_GOLD=22,
			FIELD_TYPE_BANK_TABS = 23,
			FIELD_TYPE_HONOR_POINT = 24,
			FIELD_TYPE_ARENA_POINT = 25,
			FIELD_TYPE_KILLS = 26,
			FIELD_TYPE_GUILD_ITEM_ONGLET_1 = 100,
			FIELD_TYPE_GUILD_ITEM_ONGLET_2 = 101,
			FIELD_TYPE_GUILD_ITEM_ONGLET_3 = 102,
			FIELD_TYPE_GUILD_ITEM_ONGLET_4 = 103,
			FIELD_TYPE_GUILD_ITEM_ONGLET_5 = 104,
			FIELD_TYPE_GUILD_ITEM_ONGLET_6 = 105,
            };


        enum RecupSpells {
            SPELL_DEATH_GATE = 50977,
            SPELL_REDEMPTION = 7328,
            SPELL_VOIDWALKER = 697,
            SPELL_SUCCUBUS = 712,
            SPELL_FELHUNTER = 691,
            SPELL_FELGUARD = 30146,
            SPELL_TAME_BEAST = 1515,
            SPELL_TAME_BEAST_FOR_CREATE = 13481,
            SPELL_DOUBLE_SPE = 63624,
            SPELL_SPE_1 = 63644,
            SPELL_SPE_2 = 63645,
            SPELL_TEMPS_FROID = 54197,
            SPELL_METIER_ENCHANT = 7411,
            SPELL_METIER_ECHANT2 = 51313,
            SPELL_RUNEFORGER = 53428,
            SPELL_DK_MOUNT = 48778,
            
        };

        enum RecupItems {
            TOTEM_EARTH = 5175,
            TOTEM_FIRE = 5176,
            TOTEM_WATER = 5177,
            TOTEM_AIR = 5178,
            BAG_FROSTWEAVE = 41599,
            BATONNET_EN_TITANE = 44452,
        };
        
        static void SendItemByMail(Player *plr, uint32 itemid, int count);

        static const uint32 weaponskill_spells[];
        static const uint32 riding_spells[];
        static const uint32 *class_trainers[];
        static const uint32 *racial_mounts[];
        
        static bool GiveHunterPet(Player *player, int pet_id, int pet_level, std::string pet_name, int mode = 0);
        static bool GiveItem(Player *player, int itemid);
        static void ApplyRecupAura(Player *player, int ilevel);

        static bool DoLearnClass(Player *player);
        static bool DoClassSpecificActions(Player *player, bool give_items = true);
        static bool DoTradeSpecificActions(Player *player, uint32 trade_spell, uint32 trade_level, bool give_items = true);
        static bool IsAllowedItem(Item *pItem);
        static bool GiveMounts(Player *player);
        static void DoLearnRidingSpells(Player *player);
};

#endif
