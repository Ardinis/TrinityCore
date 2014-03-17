/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Npcs_Special
SD%Complete: 100
SDComment: To be used for special NPCs that are located globally.
SDCategory: NPCs
EndScriptData
*/

/* ContentData
npc_air_force_bots       80%    support for misc (invisible) guard bots in areas where player allowed to fly. Summon guards after a preset time if tagged by spell
npc_lunaclaw_spirit      80%    support for quests 6001/6002 (Body and Heart)
npc_chicken_cluck       100%    support for quest 3861 (Cluck!)
npc_dancing_flames      100%    midsummer event NPC
npc_guardian            100%    guardianAI used to prevent players from accessing off-limits areas. Not in use by SD2
npc_garments_of_quests   80%    NPC's related to all Garments of-quests 5621, 5624, 5625, 5648, 565
npc_injured_patient     100%    patients for triage-quests (6622 and 6624)
npc_doctor              100%    Gustaf Vanhowzen and Gregory Victor, quest 6622 and 6624 (Triage)
npc_mount_vendor        100%    Regular mount vendors all over the world. Display gossip if player doesn't meet the requirements to buy
npc_rogue_trainer        80%    Scripted trainers, so they are able to offer item 17126 for class quest 6681
npc_sayge               100%    Darkmoon event fortune teller, buff player based on answers given
npc_snake_trap_serpents  80%    AI for snakes that summoned by Snake Trap
npc_shadowfiend         100%   restore 5% of owner's mana when shadowfiend die from damage
npc_locksmith            75%    list of keys needs to be confirmed
npc_firework            100%    NPC's summoned by rockets and rocket clusters, for making them cast visual
npc_argent_squire       100%    Script for the Argent Squire/Gruntling
EndContentData */

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "World.h"
#include "Vehicle.h"

/*########
# npc_air_force_bots
#########*/

enum SpawnType
{
    SPAWNTYPE_TRIPWIRE_ROOFTOP,                             // no warning, summon Creature at smaller range
    SPAWNTYPE_ALARMBOT,                                     // cast guards mark and summon npc - if player shows up with that buff duration < 5 seconds attack
};

struct SpawnAssociation
{
    uint32 thisCreatureEntry;
    uint32 spawnedCreatureEntry;
    SpawnType spawnType;
};

enum eEnums
{
    SPELL_GUARDS_MARK               = 38067,
    AURA_DURATION_TIME_LEFT         = 5000
};

float const RANGE_TRIPWIRE          = 15.0f;
float const RANGE_GUARDS_MARK       = 50.0f;

SpawnAssociation spawnAssociations[] =
{
    {2614,  15241, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Alliance)
    {2615,  15242, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Horde)
    {21974, 21976, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Area 52)
    {21993, 15242, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Horde - Bat Rider)
    {21996, 15241, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Alliance - Gryphon)
    {21997, 21976, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Goblin - Area 52 - Zeppelin)
    {21999, 15241, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Alliance)
    {22001, 15242, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Horde)
    {22002, 15242, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Ground (Horde)
    {22003, 15241, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Ground (Alliance)
    {22063, 21976, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Goblin - Area 52)
    {22065, 22064, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Ethereal - Stormspire)
    {22066, 22067, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Scryer - Dragonhawk)
    {22068, 22064, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Ethereal - Stormspire)
    {22069, 22064, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Stormspire)
    {22070, 22067, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Scryer)
    {22071, 22067, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Scryer)
    {22078, 22077, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Aldor)
    {22079, 22077, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Aldor - Gryphon)
    {22080, 22077, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Aldor)
    {22086, 22085, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Sporeggar)
    {22087, 22085, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Sporeggar - Spore Bat)
    {22088, 22085, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Sporeggar)
    {22090, 22089, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Toshley's Station - Flying Machine)
    {22124, 22122, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Cenarion)
    {22125, 22122, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Cenarion - Stormcrow)
    {22126, 22122, SPAWNTYPE_ALARMBOT}                      //Air Force Trip Wire - Rooftop (Cenarion Expedition)
};

class npc_air_force_bots : public CreatureScript
{
public:
    npc_air_force_bots() : CreatureScript("npc_air_force_bots") { }

    struct npc_air_force_botsAI : public ScriptedAI
    {
        npc_air_force_botsAI(Creature* creature) : ScriptedAI(creature)
        {
            SpawnAssoc = NULL;
            SpawnedGUID = 0;

            // find the correct spawnhandling
            static uint32 entryCount = sizeof(spawnAssociations) / sizeof(SpawnAssociation);

            for (uint8 i = 0; i < entryCount; ++i)
            {
                if (spawnAssociations[i].thisCreatureEntry == creature->GetEntry())
                {
                    SpawnAssoc = &spawnAssociations[i];
                    break;
                }
            }

            if (!SpawnAssoc)
                sLog->outErrorDb("TCSR: Creature template entry %u has ScriptName npc_air_force_bots, but it's not handled by that script", creature->GetEntry());
            else
            {
                CreatureTemplate const* spawnedTemplate = sObjectMgr->GetCreatureTemplate(SpawnAssoc->spawnedCreatureEntry);

                if (!spawnedTemplate)
                {
                    SpawnAssoc = NULL;
                    sLog->outErrorDb("TCSR: Creature template entry %u does not exist in DB, which is required by npc_air_force_bots", SpawnAssoc->spawnedCreatureEntry);
                    return;
                }
            }
        }

        SpawnAssociation* SpawnAssoc;
        uint64 SpawnedGUID;

        void Reset() {}

        Creature* SummonGuard()
        {
            Creature* summoned = me->SummonCreature(SpawnAssoc->spawnedCreatureEntry, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);

            if (summoned)
                SpawnedGUID = summoned->GetGUID();
            else
            {
                sLog->outErrorDb("TCSR: npc_air_force_bots: wasn't able to spawn Creature %u", SpawnAssoc->spawnedCreatureEntry);
                SpawnAssoc = NULL;
            }

            return summoned;
        }

        Creature* GetSummonedGuard()
        {
            Creature* creature = Unit::GetCreature(*me, SpawnedGUID);

            if (creature && creature->isAlive())
                return creature;

            return NULL;
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!SpawnAssoc)
                return;

            if (me->IsValidAttackTarget(who))
            {
                Player* playerTarget = who->ToPlayer();

                // airforce guards only spawn for players
                if (!playerTarget)
                    return;

                Creature* lastSpawnedGuard = SpawnedGUID == 0 ? NULL : GetSummonedGuard();

                // prevent calling Unit::GetUnit at next MoveInLineOfSight call - speedup
                if (!lastSpawnedGuard)
                    SpawnedGUID = 0;

                switch (SpawnAssoc->spawnType)
                {
                    case SPAWNTYPE_ALARMBOT:
                    {
                        if (!who->IsWithinDistInMap(me, RANGE_GUARDS_MARK))
                            return;

                        Aura* markAura = who->GetAura(SPELL_GUARDS_MARK);
                        if (markAura)
                        {
                            // the target wasn't able to move out of our range within 25 seconds
                            if (!lastSpawnedGuard)
                            {
                                lastSpawnedGuard = SummonGuard();

                                if (!lastSpawnedGuard)
                                    return;
                            }

                            if (markAura->GetDuration() < AURA_DURATION_TIME_LEFT)
                                if (!lastSpawnedGuard->getVictim())
                                    lastSpawnedGuard->AI()->AttackStart(who);
                        }
                        else
                        {
                            if (!lastSpawnedGuard)
                                lastSpawnedGuard = SummonGuard();

                            if (!lastSpawnedGuard)
                                return;

                            lastSpawnedGuard->CastSpell(who, SPELL_GUARDS_MARK, true);
                        }
                        break;
                    }
                    case SPAWNTYPE_TRIPWIRE_ROOFTOP:
                    {
                        if (!who->IsWithinDistInMap(me, RANGE_TRIPWIRE))
                            return;

                        if (!lastSpawnedGuard)
                            lastSpawnedGuard = SummonGuard();

                        if (!lastSpawnedGuard)
                            return;

                        // ROOFTOP only triggers if the player is on the ground
                        if (!playerTarget->IsFlying() && !lastSpawnedGuard->getVictim())
                            lastSpawnedGuard->AI()->AttackStart(who);

                        break;
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_air_force_botsAI(creature);
    }
};

/*######
## npc_lunaclaw_spirit
######*/

enum
{
    QUEST_BODY_HEART_A      = 6001,
    QUEST_BODY_HEART_H      = 6002,

    TEXT_ID_DEFAULT         = 4714,
    TEXT_ID_PROGRESS        = 4715
};

#define GOSSIP_ITEM_GRANT   "You have thought well, spirit. I ask you to grant me the strength of your body and the strength of your heart."

class npc_lunaclaw_spirit : public CreatureScript
{
public:
    npc_lunaclaw_spirit() : CreatureScript("npc_lunaclaw_spirit") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_BODY_HEART_A) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(QUEST_BODY_HEART_H) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_GRANT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        player->SEND_GOSSIP_MENU(TEXT_ID_DEFAULT, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            player->SEND_GOSSIP_MENU(TEXT_ID_PROGRESS, creature->GetGUID());
            player->AreaExploredOrEventHappens(player->GetTeam() == ALLIANCE ? QUEST_BODY_HEART_A : QUEST_BODY_HEART_H);
        }
        return true;
    }
};

/*########
# npc_chicken_cluck
#########*/

#define EMOTE_HELLO         -1070004
#define EMOTE_CLUCK_TEXT    -1070006

#define QUEST_CLUCK         3861
#define FACTION_FRIENDLY    35
#define FACTION_CHICKEN     31

class npc_chicken_cluck : public CreatureScript
{
public:
    npc_chicken_cluck() : CreatureScript("npc_chicken_cluck") { }

    struct npc_chicken_cluckAI : public ScriptedAI
    {
        npc_chicken_cluckAI(Creature* c) : ScriptedAI(c) {}

        uint32 ResetFlagTimer;

        void Reset()
        {
            ResetFlagTimer = 120000;
            me->setFaction(FACTION_CHICKEN);
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
        }

        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(uint32 const diff)
        {
            // Reset flags after a certain time has passed so that the next player has to start the 'event' again
            if (me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER))
            {
                if (ResetFlagTimer <= diff)
                {
                    EnterEvadeMode();
                    return;
                }
                else
                    ResetFlagTimer -= diff;
            }

            if (UpdateVictim())
                DoMeleeAttackIfReady();
        }

        void ReceiveEmote(Player* player, uint32 emote)
        {
            switch (emote)
            {
                case TEXT_EMOTE_CHICKEN:
                    if (player->GetQuestStatus(QUEST_CLUCK) == QUEST_STATUS_NONE && rand() % 30 == 1)
                    {
                        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                        me->setFaction(FACTION_FRIENDLY);
                        DoScriptText(EMOTE_HELLO, me);
                    }
                    break;
                case TEXT_EMOTE_CHEER:
                    if (player->GetQuestStatus(QUEST_CLUCK) == QUEST_STATUS_COMPLETE)
                    {
                        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                        me->setFaction(FACTION_FRIENDLY);
                        DoScriptText(EMOTE_CLUCK_TEXT, me);
                    }
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_chicken_cluckAI(creature);
    }

    bool OnQuestAccept(Player* /*player*/, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_CLUCK)
            CAST_AI(npc_chicken_cluck::npc_chicken_cluckAI, creature->AI())->Reset();

        return true;
    }

    bool OnQuestComplete(Player* /*player*/, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_CLUCK)
            CAST_AI(npc_chicken_cluck::npc_chicken_cluckAI, creature->AI())->Reset();

        return true;
    }
};

/*######
## npc_dancing_flames
######*/

#define SPELL_BRAZIER       45423
#define SPELL_SEDUCTION     47057
#define SPELL_FIERY_AURA    45427

class npc_dancing_flames : public CreatureScript
{
public:
    npc_dancing_flames() : CreatureScript("npc_dancing_flames") { }

    struct npc_dancing_flamesAI : public ScriptedAI
    {
        npc_dancing_flamesAI(Creature* c) : ScriptedAI(c) {}

        bool Active;
        uint32 CanIteract;

        void Reset()
        {
            Active = true;
            CanIteract = 3500;
            DoCast(me, SPELL_BRAZIER, true);
            DoCast(me, SPELL_FIERY_AURA, false);
            float x, y, z;
            me->GetPosition(x, y, z);
            me->Relocate(x, y, z + 0.94f);
            me->AddUnitMovementFlag(MOVEMENTFLAG_LEVITATING);
            me->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
            WorldPacket data;                       //send update position to client
            me->BuildHeartBeatMsg(&data);
            me->SendMessageToSet(&data, true);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!Active)
            {
                if (CanIteract <= diff)
                {
                    Active = true;
                    CanIteract = 3500;
                    me->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
                }
                else
                    CanIteract -= diff;
            }
        }

        void EnterCombat(Unit* /*who*/){}

        void ReceiveEmote(Player* player, uint32 emote)
        {
            if (me->IsWithinLOS(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ()) && me->IsWithinDistInMap(player, 30.0f))
            {
                me->SetInFront(player);
                Active = false;

                WorldPacket data;
                me->BuildHeartBeatMsg(&data);
                me->SendMessageToSet(&data, true);
                switch (emote)
                {
                    case TEXT_EMOTE_KISS:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_SHY);
                        break;
                    case TEXT_EMOTE_WAVE:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
                        break;
                    case TEXT_EMOTE_BOW:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_BOW);
                        break;
                    case TEXT_EMOTE_JOKE:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                        break;
                    case TEXT_EMOTE_DANCE:
                        if (!player->HasAura(SPELL_SEDUCTION))
                            DoCast(player, SPELL_SEDUCTION, true);
                        break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_dancing_flamesAI(creature);
    }
};

/*######
## Triage quest
######*/

//signed for 9623
#define SAY_DOC1    -1000201
#define SAY_DOC2    -1000202
#define SAY_DOC3    -1000203

#define DOCTOR_ALLIANCE     12939
#define DOCTOR_HORDE        12920
#define ALLIANCE_COORDS     7
#define HORDE_COORDS        6

struct Location
{
    float x, y, z, o;
};

static Location AllianceCoords[]=
{
    {-3757.38f, -4533.05f, 14.16f, 3.62f},                      // Top-far-right bunk as seen from entrance
    {-3754.36f, -4539.13f, 14.16f, 5.13f},                      // Top-far-left bunk
    {-3749.54f, -4540.25f, 14.28f, 3.34f},                      // Far-right bunk
    {-3742.10f, -4536.85f, 14.28f, 3.64f},                      // Right bunk near entrance
    {-3755.89f, -4529.07f, 14.05f, 0.57f},                      // Far-left bunk
    {-3749.51f, -4527.08f, 14.07f, 5.26f},                      // Mid-left bunk
    {-3746.37f, -4525.35f, 14.16f, 5.22f},                      // Left bunk near entrance
};

//alliance run to where
#define A_RUNTOX -3742.96f
#define A_RUNTOY -4531.52f
#define A_RUNTOZ 11.91f

static Location HordeCoords[]=
{
    {-1013.75f, -3492.59f, 62.62f, 4.34f},                      // Left, Behind
    {-1017.72f, -3490.92f, 62.62f, 4.34f},                      // Right, Behind
    {-1015.77f, -3497.15f, 62.82f, 4.34f},                      // Left, Mid
    {-1019.51f, -3495.49f, 62.82f, 4.34f},                      // Right, Mid
    {-1017.25f, -3500.85f, 62.98f, 4.34f},                      // Left, front
    {-1020.95f, -3499.21f, 62.98f, 4.34f}                       // Right, Front
};

//horde run to where
#define H_RUNTOX -1016.44f
#define H_RUNTOY -3508.48f
#define H_RUNTOZ 62.96f

uint32 const AllianceSoldierId[3] =
{
    12938,                                                  // 12938 Injured Alliance Soldier
    12936,                                                  // 12936 Badly injured Alliance Soldier
    12937                                                   // 12937 Critically injured Alliance Soldier
};

uint32 const HordeSoldierId[3] =
{
    12923,                                                  //12923 Injured Soldier
    12924,                                                  //12924 Badly injured Soldier
    12925                                                   //12925 Critically injured Soldier
};

/*######
## npc_doctor (handles both Gustaf Vanhowzen and Gregory Victor)
######*/
class npc_doctor : public CreatureScript
{
public:
    npc_doctor() : CreatureScript("npc_doctor") {}

    struct npc_doctorAI : public ScriptedAI
    {
        npc_doctorAI(Creature* c) : ScriptedAI(c) {}

        uint64 PlayerGUID;

        uint32 SummonPatientTimer;
        uint32 SummonPatientCount;
        uint32 PatientDiedCount;
        uint32 PatientSavedCount;

        bool Event;

        std::list<uint64> Patients;
        std::vector<Location*> Coordinates;

        void Reset()
        {
            PlayerGUID = 0;

            SummonPatientTimer = 10000;
            SummonPatientCount = 0;
            PatientDiedCount = 0;
            PatientSavedCount = 0;

            Patients.clear();
            Coordinates.clear();

            Event = false;

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }

        void BeginEvent(Player* player)
        {
            PlayerGUID = player->GetGUID();

            SummonPatientTimer = 10000;
            SummonPatientCount = 0;
            PatientDiedCount = 0;
            PatientSavedCount = 0;

            switch (me->GetEntry())
            {
                case DOCTOR_ALLIANCE:
                    for (uint8 i = 0; i < ALLIANCE_COORDS; ++i)
                        Coordinates.push_back(&AllianceCoords[i]);
                    break;
                case DOCTOR_HORDE:
                    for (uint8 i = 0; i < HORDE_COORDS; ++i)
                        Coordinates.push_back(&HordeCoords[i]);
                    break;
            }

            Event = true;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }

        void PatientDied(Location* point)
        {
            Player* player = Unit::GetPlayer(*me, PlayerGUID);
            if (player && ((player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)))
            {
                ++PatientDiedCount;

                if (PatientDiedCount > 5 && Event)
                {
                    if (player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE)
                        player->FailQuest(6624);
                    else if (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)
                        player->FailQuest(6622);

                    Reset();
                    return;
                }

                Coordinates.push_back(point);
            }
            else
                // If no player or player abandon quest in progress
                Reset();
        }

        void PatientSaved(Creature* /*soldier*/, Player* player, Location* point)
        {
            if (player && PlayerGUID == player->GetGUID())
            {
                if ((player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE))
                {
                    ++PatientSavedCount;

                    if (PatientSavedCount == 15)
                    {
                        if (!Patients.empty())
                        {
                            std::list<uint64>::const_iterator itr;
                            for (itr = Patients.begin(); itr != Patients.end(); ++itr)
                            {
                                if (Creature* patient = Unit::GetCreature((*me), *itr))
                                    patient->setDeathState(JUST_DIED);
                            }
                        }

                        if (player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE)
                            player->AreaExploredOrEventHappens(6624);
                        else if (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)
                            player->AreaExploredOrEventHappens(6622);

                        Reset();
                        return;
                    }

                    Coordinates.push_back(point);
                }
            }
        }

        void UpdateAI(uint32 const diff);

        void EnterCombat(Unit* /*who*/){}
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if ((quest->GetQuestId() == 6624) || (quest->GetQuestId() == 6622))
            CAST_AI(npc_doctor::npc_doctorAI, creature->AI())->BeginEvent(player);

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_doctorAI(creature);
    }
};

/*#####
## npc_injured_patient (handles all the patients, no matter Horde or Alliance)
#####*/

class npc_injured_patient : public CreatureScript
{
public:
    npc_injured_patient() : CreatureScript("npc_injured_patient") { }

    struct npc_injured_patientAI : public ScriptedAI
    {
        npc_injured_patientAI(Creature* c) : ScriptedAI(c) {}

        uint64 DoctorGUID;
        Location* Coord;

        void Reset()
        {
            DoctorGUID = 0;
            Coord = NULL;

            //no select
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

            //no regen health
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);

            //to make them lay with face down
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, UNIT_STAND_STATE_DEAD);

            uint32 mobId = me->GetEntry();

            switch (mobId)
            {                                                   //lower max health
                case 12923:
                case 12938:                                     //Injured Soldier
                    me->SetHealth(me->CountPctFromMaxHealth(75));
                    break;
                case 12924:
                case 12936:                                     //Badly injured Soldier
                    me->SetHealth(me->CountPctFromMaxHealth(50));
                    break;
                case 12925:
                case 12937:                                     //Critically injured Soldier
                    me->SetHealth(me->CountPctFromMaxHealth(25));
                    break;
            }
        }

        void EnterCombat(Unit* /*who*/){}

        void SpellHit(Unit* caster, SpellInfo const* spell)
        {
            if (caster->GetTypeId() == TYPEID_PLAYER && me->isAlive() && spell->Id == 20804)
            {
                if ((CAST_PLR(caster)->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE) || (CAST_PLR(caster)->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE))
                    if (DoctorGUID)
                        if (Creature* doctor = Unit::GetCreature(*me, DoctorGUID))
                            CAST_AI(npc_doctor::npc_doctorAI, doctor->AI())->PatientSaved(me, CAST_PLR(caster), Coord);

                //make not selectable
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

                //regen health
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);

                //stand up
                me->SetUInt32Value(UNIT_FIELD_BYTES_1, UNIT_STAND_STATE_STAND);

                DoScriptText(RAND(SAY_DOC1, SAY_DOC2, SAY_DOC3), me);

                uint32 mobId = me->GetEntry();
                me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);

                switch (mobId)
                {
                    case 12923:
                    case 12924:
                    case 12925:
                        me->GetMotionMaster()->MovePoint(0, H_RUNTOX, H_RUNTOY, H_RUNTOZ);
                        break;
                    case 12936:
                    case 12937:
                    case 12938:
                        me->GetMotionMaster()->MovePoint(0, A_RUNTOX, A_RUNTOY, A_RUNTOZ);
                        break;
                }
            }
        }

        void UpdateAI(uint32 const /*diff*/)
        {
            //lower HP on every world tick makes it a useful counter, not officlone though
            if (me->isAlive() && me->GetHealth() > 6)
                me->ModifyHealth(-5);

            if (me->isAlive() && me->GetHealth() <= 6)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->setDeathState(JUST_DIED);
                me->SetFlag(UNIT_DYNAMIC_FLAGS, 32);

                if (DoctorGUID)
                    if (Creature* doctor = Unit::GetCreature((*me), DoctorGUID))
                        CAST_AI(npc_doctor::npc_doctorAI, doctor->AI())->PatientDied(Coord);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_injured_patientAI(creature);
    }
};

void npc_doctor::npc_doctorAI::UpdateAI(uint32 const diff)
{
    if (Event && SummonPatientCount >= 20)
    {
        Reset();
        return;
    }

    if (Event)
    {
        if (SummonPatientTimer <= diff)
        {
            if (Coordinates.empty())
                return;

            std::vector<Location*>::iterator itr = Coordinates.begin() + rand() % Coordinates.size();
            uint32 patientEntry = 0;

            switch (me->GetEntry())
            {
                case DOCTOR_ALLIANCE:
                    patientEntry = AllianceSoldierId[rand() % 3];
                    break;
                case DOCTOR_HORDE:
                    patientEntry = HordeSoldierId[rand() % 3];
                    break;
                default:
                    sLog->outError("TSCR: Invalid entry for Triage doctor. Please check your database");
                    return;
            }

            if (Location* point = *itr)
            {
                if (Creature* Patient = me->SummonCreature(patientEntry, point->x, point->y, point->z, point->o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000))
                {
                    //303, this flag appear to be required for client side item->spell to work (TARGET_SINGLE_FRIEND)
                    Patient->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);

                    Patients.push_back(Patient->GetGUID());
                    CAST_AI(npc_injured_patient::npc_injured_patientAI, Patient->AI())->DoctorGUID = me->GetGUID();
                    CAST_AI(npc_injured_patient::npc_injured_patientAI, Patient->AI())->Coord = point;

                    Coordinates.erase(itr);
                }
            }
            SummonPatientTimer = 10000;
            ++SummonPatientCount;
        }
        else
            SummonPatientTimer -= diff;
    }
}

/*######
## npc_garments_of_quests
######*/

//TODO: get text for each NPC

enum eGarments
{
    SPELL_LESSER_HEAL_R2    = 2052,
    SPELL_FORTITUDE_R1      = 1243,

    QUEST_MOON              = 5621,
    QUEST_LIGHT_1           = 5624,
    QUEST_LIGHT_2           = 5625,
    QUEST_SPIRIT            = 5648,
    QUEST_DARKNESS          = 5650,

    ENTRY_SHAYA             = 12429,
    ENTRY_ROBERTS           = 12423,
    ENTRY_DOLF              = 12427,
    ENTRY_KORJA             = 12430,
    ENTRY_DG_KEL            = 12428,

    //used by 12429, 12423, 12427, 12430, 12428, but signed for 12429
    SAY_COMMON_HEALED       = -1000164,
    SAY_DG_KEL_THANKS       = -1000165,
    SAY_DG_KEL_GOODBYE      = -1000166,
    SAY_ROBERTS_THANKS      = -1000167,
    SAY_ROBERTS_GOODBYE     = -1000168,
    SAY_KORJA_THANKS        = -1000169,
    SAY_KORJA_GOODBYE       = -1000170,
    SAY_DOLF_THANKS         = -1000171,
    SAY_DOLF_GOODBYE        = -1000172,
    SAY_SHAYA_THANKS        = -1000173,
    SAY_SHAYA_GOODBYE       = -1000174, //signed for 21469
};

class npc_garments_of_quests : public CreatureScript
{
public:
    npc_garments_of_quests() : CreatureScript("npc_garments_of_quests") { }

    struct npc_garments_of_questsAI : public npc_escortAI
    {
        npc_garments_of_questsAI(Creature* c) : npc_escortAI(c) {Reset();}

        uint64 CasterGUID;

        bool IsHealed;
        bool CanRun;

        uint32 RunAwayTimer;

        void Reset()
        {
            CasterGUID = 0;

            IsHealed = false;
            CanRun = false;

            RunAwayTimer = 5000;

            me->SetStandState(UNIT_STAND_STATE_KNEEL);
            //expect database to have RegenHealth=0
            me->SetHealth(me->CountPctFromMaxHealth(70));
        }

        void EnterCombat(Unit* /*who*/) {}

        void SpellHit(Unit* caster, SpellInfo const* Spell)
        {
            if (Spell->Id == SPELL_LESSER_HEAL_R2 || Spell->Id == SPELL_FORTITUDE_R1)
            {
                //not while in combat
                if (me->isInCombat())
                    return;

                //nothing to be done now
                if (IsHealed && CanRun)
                    return;

                if (Player* player = caster->ToPlayer())
                {
                    switch (me->GetEntry())
                    {
                        case ENTRY_SHAYA:
                            if (player->GetQuestStatus(QUEST_MOON) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    DoScriptText(SAY_SHAYA_THANKS, me, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    DoScriptText(SAY_COMMON_HEALED, me, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                        case ENTRY_ROBERTS:
                            if (player->GetQuestStatus(QUEST_LIGHT_1) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    DoScriptText(SAY_ROBERTS_THANKS, me, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    DoScriptText(SAY_COMMON_HEALED, me, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                        case ENTRY_DOLF:
                            if (player->GetQuestStatus(QUEST_LIGHT_2) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    DoScriptText(SAY_DOLF_THANKS, me, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    DoScriptText(SAY_COMMON_HEALED, me, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                        case ENTRY_KORJA:
                            if (player->GetQuestStatus(QUEST_SPIRIT) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    DoScriptText(SAY_KORJA_THANKS, me, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    DoScriptText(SAY_COMMON_HEALED, me, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                        case ENTRY_DG_KEL:
                            if (player->GetQuestStatus(QUEST_DARKNESS) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && Spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    DoScriptText(SAY_DG_KEL_THANKS, me, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && Spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    DoScriptText(SAY_COMMON_HEALED, me, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                    }

                    //give quest credit, not expect any special quest objectives
                    if (CanRun)
                        player->TalkedToCreature(me->GetEntry(), me->GetGUID());
                }
            }
        }

        void WaypointReached(uint32 /*point*/)
        {
        }

        void UpdateAI(uint32 const diff)
        {
            if (CanRun && !me->isInCombat())
            {
                if (RunAwayTimer <= diff)
                {
                    if (Unit* unit = Unit::GetUnit(*me, CasterGUID))
                    {
                        switch (me->GetEntry())
                        {
                            case ENTRY_SHAYA:
                                DoScriptText(SAY_SHAYA_GOODBYE, me, unit);
                                break;
                            case ENTRY_ROBERTS:
                                DoScriptText(SAY_ROBERTS_GOODBYE, me, unit);
                                break;
                            case ENTRY_DOLF:
                                DoScriptText(SAY_DOLF_GOODBYE, me, unit);
                                break;
                            case ENTRY_KORJA:
                                DoScriptText(SAY_KORJA_GOODBYE, me, unit);
                                break;
                            case ENTRY_DG_KEL:
                                DoScriptText(SAY_DG_KEL_GOODBYE, me, unit);
                                break;
                        }

                        Start(false, true, true);
                    }
                    else
                        EnterEvadeMode();                       //something went wrong

                    RunAwayTimer = 30000;
                }
                else
                    RunAwayTimer -= diff;
            }

            npc_escortAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_garments_of_questsAI(creature);
    }
};

/*######
## npc_guardian
######*/

#define SPELL_DEATHTOUCH                5

class npc_guardian : public CreatureScript
{
public:
    npc_guardian() : CreatureScript("npc_guardian") { }

    struct npc_guardianAI : public ScriptedAI
    {
        npc_guardianAI(Creature* c) : ScriptedAI(c) {}

        void Reset()
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void EnterCombat(Unit* /*who*/)
        {
        }

        void UpdateAI(uint32 const /*diff*/)
        {
            if (!UpdateVictim())
                return;

            if (me->isAttackReady())
            {
                DoCast(me->getVictim(), SPELL_DEATHTOUCH, true);
                me->resetAttackTimer();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_guardianAI(creature);
    }
};

/*######
## npc_mount_vendor
######*/

class npc_mount_vendor : public CreatureScript
{
public:
    npc_mount_vendor() : CreatureScript("npc_mount_vendor") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        bool canBuy = false;
        uint32 vendor = creature->GetEntry();
        uint8 race = player->getRace();

        switch (vendor)
        {
            case 384:                                           //Katie Hunter
            case 1460:                                          //Unger Statforth
            case 2357:                                          //Merideth Carlson
            case 4885:                                          //Gregor MacVince
                if (player->GetReputationRank(72) != REP_EXALTED && race != RACE_HUMAN)
                    player->SEND_GOSSIP_MENU(5855, creature->GetGUID());
                else canBuy = true;
                break;
            case 1261:                                          //Veron Amberstill
                if (player->GetReputationRank(47) != REP_EXALTED && race != RACE_DWARF)
                    player->SEND_GOSSIP_MENU(5856, creature->GetGUID());
                else canBuy = true;
                break;
            case 3362:                                          //Ogunaro Wolfrunner
                if (player->GetReputationRank(76) != REP_EXALTED && race != RACE_ORC)
                    player->SEND_GOSSIP_MENU(5841, creature->GetGUID());
                else canBuy = true;
                break;
            case 3685:                                          //Harb Clawhoof
                if (player->GetReputationRank(81) != REP_EXALTED && race != RACE_TAUREN)
                    player->SEND_GOSSIP_MENU(5843, creature->GetGUID());
                else canBuy = true;
                break;
            case 4730:                                          //Lelanai
                if (player->GetReputationRank(69) != REP_EXALTED && race != RACE_NIGHTELF)
                    player->SEND_GOSSIP_MENU(5844, creature->GetGUID());
                else canBuy = true;
                break;
            case 4731:                                          //Zachariah Post
                if (player->GetReputationRank(68) != REP_EXALTED && race != RACE_UNDEAD_PLAYER)
                    player->SEND_GOSSIP_MENU(5840, creature->GetGUID());
                else canBuy = true;
                break;
            case 7952:                                          //Zjolnir
                if (player->GetReputationRank(530) != REP_EXALTED && race != RACE_TROLL)
                    player->SEND_GOSSIP_MENU(5842, creature->GetGUID());
                else canBuy = true;
                break;
            case 7955:                                          //Milli Featherwhistle
                if (player->GetReputationRank(54) != REP_EXALTED && race != RACE_GNOME)
                    player->SEND_GOSSIP_MENU(5857, creature->GetGUID());
                else canBuy = true;
                break;
            case 16264:                                         //Winaestra
                if (player->GetReputationRank(911) != REP_EXALTED && race != RACE_BLOODELF)
                    player->SEND_GOSSIP_MENU(10305, creature->GetGUID());
                else canBuy = true;
                break;
            case 17584:                                         //Torallius the Pack Handler
                if (player->GetReputationRank(930) != REP_EXALTED && race != RACE_DRAENEI)
                    player->SEND_GOSSIP_MENU(10239, creature->GetGUID());
                else canBuy = true;
                break;
        }

        if (canBuy)
        {
            if (creature->isVendor())
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        }
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());

        return true;
    }
};

/*######
## npc_rogue_trainer
######*/

#define GOSSIP_HELLO_ROGUE1 "I wish to unlearn my talents"
#define GOSSIP_HELLO_ROGUE2 "<Take the letter>"
#define GOSSIP_HELLO_ROGUE3 "Purchase a Dual Talent Specialization."

class npc_rogue_trainer : public CreatureScript
{
public:
    npc_rogue_trainer() : CreatureScript("npc_rogue_trainer") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->isTrainer())
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);

        if (creature->isCanTrainingAndResetTalentsOf(player))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, GOSSIP_HELLO_ROGUE1, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_UNLEARNTALENTS);

        if (player->GetSpecsCount() == 1 && creature->isCanTrainingAndResetTalentsOf(player) && player->getLevel() >= sWorld->getIntConfig(CONFIG_MIN_DUALSPEC_LEVEL))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, GOSSIP_HELLO_ROGUE3, GOSSIP_SENDER_MAIN, GOSSIP_OPTION_LEARNDUALSPEC);

        if (player->getClass() == CLASS_ROGUE && player->getLevel() >= 24 && !player->HasItemCount(17126, 1) && !player->GetQuestRewardStatus(6681))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_ROGUE2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(5996, creature->GetGUID());
        } else
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, 21100, false);
                break;
            case GOSSIP_ACTION_TRAIN:
                player->GetSession()->SendTrainerList(creature->GetGUID());
                break;
            case GOSSIP_OPTION_UNLEARNTALENTS:
                player->CLOSE_GOSSIP_MENU();
                player->SendTalentWipeConfirm(creature->GetGUID());
                break;
            case GOSSIP_OPTION_LEARNDUALSPEC:
                if (player->GetSpecsCount() == 1 && !(player->getLevel() < sWorld->getIntConfig(CONFIG_MIN_DUALSPEC_LEVEL)))
                {
                    if (!player->HasEnoughMoney(10000000))
                    {
                        player->SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, 0, 0, 0);
                        player->PlayerTalkClass->SendCloseGossip();
                        break;
                    }
                    else
                    {
                        player->ModifyMoney(-10000000);

                        // Cast spells that teach dual spec
                        // Both are also ImplicitTarget self and must be cast by player
                        player->CastSpell(player, 63680, true, NULL, NULL, player->GetGUID());
                        player->CastSpell(player, 63624, true, NULL, NULL, player->GetGUID());

                        // Should show another Gossip text with "Congratulations..."
                        player->PlayerTalkClass->SendCloseGossip();
                    }
                }
                break;
        }
        return true;
    }
};

/*######
## npc_sayge
######*/

#define SPELL_DMG       23768                               //dmg
#define SPELL_RES       23769                               //res
#define SPELL_ARM       23767                               //arm
#define SPELL_SPI       23738                               //spi
#define SPELL_INT       23766                               //int
#define SPELL_STM       23737                               //stm
#define SPELL_STR       23735                               //str
#define SPELL_AGI       23736                               //agi
#define SPELL_FORTUNE   23765                               //faire fortune

#define GOSSIP_HELLO_SAYGE  "Yes"
#define GOSSIP_SENDACTION_SAYGE1    "Slay the Man"
#define GOSSIP_SENDACTION_SAYGE2    "Turn him over to liege"
#define GOSSIP_SENDACTION_SAYGE3    "Confiscate the corn"
#define GOSSIP_SENDACTION_SAYGE4    "Let him go and have the corn"
#define GOSSIP_SENDACTION_SAYGE5    "Execute your friend painfully"
#define GOSSIP_SENDACTION_SAYGE6    "Execute your friend painlessly"
#define GOSSIP_SENDACTION_SAYGE7    "Let your friend go"
#define GOSSIP_SENDACTION_SAYGE8    "Confront the diplomat"
#define GOSSIP_SENDACTION_SAYGE9    "Show not so quiet defiance"
#define GOSSIP_SENDACTION_SAYGE10   "Remain quiet"
#define GOSSIP_SENDACTION_SAYGE11   "Speak against your brother openly"
#define GOSSIP_SENDACTION_SAYGE12   "Help your brother in"
#define GOSSIP_SENDACTION_SAYGE13   "Keep your brother out without letting him know"
#define GOSSIP_SENDACTION_SAYGE14   "Take credit, keep gold"
#define GOSSIP_SENDACTION_SAYGE15   "Take credit, share the gold"
#define GOSSIP_SENDACTION_SAYGE16   "Let the knight take credit"
#define GOSSIP_SENDACTION_SAYGE17   "Thanks"

class npc_sayge : public CreatureScript
{
public:
    npc_sayge() : CreatureScript("npc_sayge") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->HasSpellCooldown(SPELL_INT) ||
            player->HasSpellCooldown(SPELL_ARM) ||
            player->HasSpellCooldown(SPELL_DMG) ||
            player->HasSpellCooldown(SPELL_RES) ||
            player->HasSpellCooldown(SPELL_STR) ||
            player->HasSpellCooldown(SPELL_AGI) ||
            player->HasSpellCooldown(SPELL_STM) ||
            player->HasSpellCooldown(SPELL_SPI))
            player->SEND_GOSSIP_MENU(7393, creature->GetGUID());
        else
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_SAYGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(7339, creature->GetGUID());
        }

        return true;
    }

    void SendAction(Player* player, Creature* creature, uint32 action)
    {
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE1,            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE2,            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE3,            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE4,            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                player->SEND_GOSSIP_MENU(7340, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE5,            GOSSIP_SENDER_MAIN + 1, GOSSIP_ACTION_INFO_DEF);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE6,            GOSSIP_SENDER_MAIN + 2, GOSSIP_ACTION_INFO_DEF);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE7,            GOSSIP_SENDER_MAIN + 3, GOSSIP_ACTION_INFO_DEF);
                player->SEND_GOSSIP_MENU(7341, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE8,            GOSSIP_SENDER_MAIN + 4, GOSSIP_ACTION_INFO_DEF);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE9,            GOSSIP_SENDER_MAIN + 5, GOSSIP_ACTION_INFO_DEF);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE10,           GOSSIP_SENDER_MAIN + 2, GOSSIP_ACTION_INFO_DEF);
                player->SEND_GOSSIP_MENU(7361, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE11,           GOSSIP_SENDER_MAIN + 6, GOSSIP_ACTION_INFO_DEF);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE12,           GOSSIP_SENDER_MAIN + 7, GOSSIP_ACTION_INFO_DEF);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE13,           GOSSIP_SENDER_MAIN + 8, GOSSIP_ACTION_INFO_DEF);
                player->SEND_GOSSIP_MENU(7362, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE14,           GOSSIP_SENDER_MAIN + 5, GOSSIP_ACTION_INFO_DEF);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE15,           GOSSIP_SENDER_MAIN + 4, GOSSIP_ACTION_INFO_DEF);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE16,           GOSSIP_SENDER_MAIN + 3, GOSSIP_ACTION_INFO_DEF);
                player->SEND_GOSSIP_MENU(7363, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SENDACTION_SAYGE17,           GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                player->SEND_GOSSIP_MENU(7364, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                creature->CastSpell(player, SPELL_FORTUNE, false);
                player->SEND_GOSSIP_MENU(7365, creature->GetGUID());
                break;
        }
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (sender)
        {
            case GOSSIP_SENDER_MAIN:
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 1:
                creature->CastSpell(player, SPELL_DMG, false);
                player->AddSpellCooldown(SPELL_DMG, 0, time(NULL) + 7200);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 2:
                creature->CastSpell(player, SPELL_RES, false);
                player->AddSpellCooldown(SPELL_RES, 0, time(NULL) + 7200);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 3:
                creature->CastSpell(player, SPELL_ARM, false);
                player->AddSpellCooldown(SPELL_ARM, 0, time(NULL) + 7200);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 4:
                creature->CastSpell(player, SPELL_SPI, false);
                player->AddSpellCooldown(SPELL_SPI, 0, time(NULL) + 7200);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 5:
                creature->CastSpell(player, SPELL_INT, false);
                player->AddSpellCooldown(SPELL_INT, 0, time(NULL) + 7200);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 6:
                creature->CastSpell(player, SPELL_STM, false);
                player->AddSpellCooldown(SPELL_STM, 0, time(NULL) + 7200);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 7:
                creature->CastSpell(player, SPELL_STR, false);
                player->AddSpellCooldown(SPELL_STR, 0, time(NULL) + 7200);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 8:
                creature->CastSpell(player, SPELL_AGI, false);
                player->AddSpellCooldown(SPELL_AGI, 0, time(NULL) + 7200);
                SendAction(player, creature, action);
                break;
        }
        return true;
    }
};

class npc_steam_tonk : public CreatureScript
{
public:
    npc_steam_tonk() : CreatureScript("npc_steam_tonk") { }

    struct npc_steam_tonkAI : public ScriptedAI
    {
        npc_steam_tonkAI(Creature* c) : ScriptedAI(c) {}

        void Reset() {}
        void EnterCombat(Unit* /*who*/) {}

        void OnPossess(bool apply)
        {
            if (apply)
            {
                // Initialize the action bar without the melee attack command
                me->InitCharmInfo();
                me->GetCharmInfo()->InitEmptyActionBar(false);

                me->SetReactState(REACT_PASSIVE);
            }
            else
                me->SetReactState(REACT_AGGRESSIVE);
        }

    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_steam_tonkAI(creature);
    }
};

#define SPELL_TONK_MINE_DETONATE 25099

class npc_tonk_mine : public CreatureScript
{
public:
    npc_tonk_mine() : CreatureScript("npc_tonk_mine") { }

    struct npc_tonk_mineAI : public ScriptedAI
    {
        npc_tonk_mineAI(Creature* c) : ScriptedAI(c)
        {
            me->SetReactState(REACT_PASSIVE);
        }

        uint32 ExplosionTimer;

        void Reset()
        {
            ExplosionTimer = 3000;
        }

        void EnterCombat(Unit* /*who*/) {}
        void AttackStart(Unit* /*who*/) {}
        void MoveInLineOfSight(Unit* /*who*/) {}

        void UpdateAI(uint32 const diff)
        {
            if (ExplosionTimer <= diff)
            {
                DoCast(me, SPELL_TONK_MINE_DETONATE, true);
                me->setDeathState(DEAD); // unsummon it
            }
            else
                ExplosionTimer -= diff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_tonk_mineAI(creature);
    }
};

/*####
## npc_brewfest_reveler
####*/

class npc_brewfest_reveler : public CreatureScript
{
public:
    npc_brewfest_reveler() : CreatureScript("npc_brewfest_reveler") { }

    struct npc_brewfest_revelerAI : public ScriptedAI
    {
        npc_brewfest_revelerAI(Creature* c) : ScriptedAI(c) {}
        void ReceiveEmote(Player* player, uint32 emote)
        {
            if (!IsHolidayActive(HOLIDAY_BREWFEST))
                return;

            if (emote == TEXT_EMOTE_DANCE)
                me->CastSpell(player, 41586, false);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_brewfest_revelerAI(creature);
    }
};

/* Fete des brasseurs */
/*####
## npc_brewfest_trigger
####*/
enum eBrewfestBarkQuests
{
    BARK_FOR_THE_THUNDERBREWS       = 11294,
    BARK_FOR_TCHALIS_VOODOO_BREWERY = 11408,
    BARK_FOR_THE_BARLEYBREWS        = 11293,
    BARK_FOR_DROHNS_DISTILLERY      = 11407
};

class npc_brewfest_trigger : public CreatureScript
{
public:
    npc_brewfest_trigger() : CreatureScript("npc_brewfest_trigger") { }

    struct npc_brewfest_triggerAI : public ScriptedAI
    {
        npc_brewfest_triggerAI(Creature* c) : ScriptedAI(c) {}
        void MoveInLineOfSight(Unit *who)
        {
            Player *pPlayer = who->ToPlayer();
            if (!pPlayer)
                return;
            if (pPlayer->GetQuestStatus(BARK_FOR_THE_THUNDERBREWS) == QUEST_STATUS_INCOMPLETE
                || pPlayer->GetQuestStatus(BARK_FOR_TCHALIS_VOODOO_BREWERY) == QUEST_STATUS_INCOMPLETE
                || pPlayer->GetQuestStatus(BARK_FOR_THE_BARLEYBREWS) == QUEST_STATUS_INCOMPLETE
                || pPlayer->GetQuestStatus(BARK_FOR_DROHNS_DISTILLERY) == QUEST_STATUS_INCOMPLETE)
                pPlayer->KilledMonsterCredit(me->GetEntry(),0);
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_brewfest_triggerAI(creature);
    }
};

/*####
## npc_brewfest_apple_trigger
####*/

#define SPELL_RAM_FATIGUE    43052

class npc_brewfest_apple_trigger : public CreatureScript
{
public:
    npc_brewfest_apple_trigger() : CreatureScript("npc_brewfest_apple_trigger") { }

    struct npc_brewfest_apple_triggerAI : public ScriptedAI
    {
        npc_brewfest_apple_triggerAI(Creature* c) : ScriptedAI(c) {}
        void MoveInLineOfSight(Unit *who)
        {
            Player *pPlayer = who->ToPlayer();
            if (!pPlayer)
                return;
            if (pPlayer->HasAura(SPELL_RAM_FATIGUE) && me->GetDistance(pPlayer->GetPositionX(),pPlayer->GetPositionY(),pPlayer->GetPositionZ()) <= 7.5f)
                pPlayer->RemoveAura(SPELL_RAM_FATIGUE);
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_brewfest_apple_triggerAI(creature);
    }
};

/*####
## npc_brewfest_keg_thrower
####*/

enum eBrewfestKegThrower
{
    SPELL_BREWFEST_RAM   = 43880,
    SPELL_THROW_KEG      = 43660,
    ITEM_BREWFEST_KEG    = 33797
};

class npc_brewfest_keg_thrower : public CreatureScript
{
public:
    npc_brewfest_keg_thrower() : CreatureScript("npc_brewfest_keg_thrower") { }

    struct npc_brewfest_keg_throwerAI : public ScriptedAI
    {
        npc_brewfest_keg_throwerAI(Creature* c) : ScriptedAI(c) {}
        void MoveInLineOfSight(Unit *who)
        {
            Player *pPlayer = who->ToPlayer();
            if (!pPlayer)
                return;
            if (pPlayer->HasAura(SPELL_BREWFEST_RAM)
                && me->GetDistance(pPlayer->GetPositionX(),pPlayer->GetPositionY(),pPlayer->GetPositionZ()) <= 25.0f
                && !pPlayer->HasItemCount(ITEM_BREWFEST_KEG,1))
            {
                me->CastSpell(pPlayer,SPELL_THROW_KEG,false);
                me->CastSpell(pPlayer,42414,false);
            }
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_brewfest_keg_throwerAI(creature);
    }
};

/*####
## npc_brewfest_keg_receiver
####*/

enum eBrewfestKegReceiver
{
    SPELL_CREATE_TICKETS            = 44501,
    QUEST_THERE_AND_BACK_AGAIN_A    = 11122,
    QUEST_THERE_AND_BACK_AGAIN_H    = 11412,
    NPC_BREWFEST_DELIVERY_BUNNY     = 24337
};

class npc_brewfest_keg_receiver : public CreatureScript
{
public:
    npc_brewfest_keg_receiver() : CreatureScript("npc_brewfest_keg_receiver") { }

    struct npc_brewfest_keg_receiverAI : public ScriptedAI
    {
        npc_brewfest_keg_receiverAI(Creature* c) : ScriptedAI(c) {}
        void MoveInLineOfSight(Unit *who)
        {
            Player *pPlayer = who->ToPlayer();
            if (!pPlayer)
                return;
            if (pPlayer->HasAura(SPELL_BREWFEST_RAM)
                && me->GetDistance(pPlayer->GetPositionX(),pPlayer->GetPositionY(),pPlayer->GetPositionZ()) <= 5.0f
                && pPlayer->HasItemCount(ITEM_BREWFEST_KEG,1))
            {
                pPlayer->CastSpell(me,SPELL_THROW_KEG,true);
                pPlayer->DestroyItemCount(ITEM_BREWFEST_KEG,1,true);
                pPlayer->GetAura(SPELL_BREWFEST_RAM)->SetDuration(pPlayer->GetAura(SPELL_BREWFEST_RAM)->GetDuration() + 30000);
                if (pPlayer->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_A)
                    || pPlayer->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_H))
                {
                    pPlayer->CastSpell(pPlayer,SPELL_CREATE_TICKETS,true);
                }
                else
                {
                    pPlayer->KilledMonsterCredit(NPC_BREWFEST_DELIVERY_BUNNY,0);
                    if (pPlayer->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_A) == QUEST_STATUS_INCOMPLETE)
                        pPlayer->AreaExploredOrEventHappens(QUEST_THERE_AND_BACK_AGAIN_A);
                    if (pPlayer->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_H) == QUEST_STATUS_INCOMPLETE)
                        pPlayer->AreaExploredOrEventHappens(QUEST_THERE_AND_BACK_AGAIN_H);
                    if (pPlayer->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_A) == QUEST_STATUS_COMPLETE
                        || pPlayer->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_H) == QUEST_STATUS_COMPLETE)
                        pPlayer->RemoveAura(SPELL_BREWFEST_RAM);
                }
           }
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_brewfest_keg_receiverAI(creature);
    }
};

/*####
## npc_brewfest_ram_master
####*/
#define GOSSIP_ITEM_RAM             "Do you have additional work?"
#define GOSSIP_ITEM_RAM_REINS       "Give me another Ram Racing Reins"
#define SPELL_BREWFEST_SUMMON_RAM   43720

class npc_brewfest_ram_master : public CreatureScript
{
public:
    npc_brewfest_ram_master() : CreatureScript("npc_brewfest_ram_master") { }

    bool OnGossipHello(Player *pPlayer, Creature *pCreature)
    {
        if (pCreature->isQuestGiver())
            pPlayer->PrepareQuestMenu(pCreature->GetGUID());

            if (pPlayer->HasSpellCooldown(SPELL_BREWFEST_SUMMON_RAM)
                && !pPlayer->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_A)
                && !pPlayer->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_H)
                && (pPlayer->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_A) == QUEST_STATUS_INCOMPLETE
                || pPlayer->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_H) == QUEST_STATUS_INCOMPLETE))
                pPlayer->RemoveSpellCooldown(SPELL_BREWFEST_SUMMON_RAM);
            if (!pPlayer->HasAura(SPELL_BREWFEST_RAM) && ((pPlayer->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_A) == QUEST_STATUS_INCOMPLETE
            || pPlayer->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_H) == QUEST_STATUS_INCOMPLETE
            || (!pPlayer->HasSpellCooldown(SPELL_BREWFEST_SUMMON_RAM) &&
                (pPlayer->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_A)
                || pPlayer->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_H))))))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_RAM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

            if ((pPlayer->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_A)
                || pPlayer->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_H))
                && !pPlayer->HasItemCount(33306,1,true))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_RAM_REINS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);



        pPlayer->SEND_GOSSIP_MENU(384, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->SendCloseGossip();
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            if (pPlayer->HasItemCount(ITEM_BREWFEST_KEG,1))
                pPlayer->DestroyItemCount(ITEM_BREWFEST_KEG,1,true);
            pPlayer->CastSpell(pPlayer,SPELL_BREWFEST_SUMMON_RAM,true);
            pPlayer->AddSpellCooldown(SPELL_BREWFEST_SUMMON_RAM,0,time(NULL) + 18*60*60);
        }
        if (uiAction == GOSSIP_ACTION_INFO_DEF+2)
        {
            pPlayer->CastSpell(pPlayer,44371,false);
        }
        return true;
    }
};
/* Fin fete des brasseurs */

/* jour des pirates */
#define    SPELL_AURA_PIRATE 50517
#define GOSSIP_DRINK   "A la santee des pirates !"
#define GOSSIP_PUNISH   "Je hai les pirates !"

class npc_demeza : public CreatureScript
{
public:
    npc_demeza() : CreatureScript("npc_demeza") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
      printf("hello boy !\n");
      player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_DRINK, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
      player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_PUNISH, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
      player->SEND_GOSSIP_MENU(9647, creature->GetGUID());
      return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
	  creature->CastSpell(player, SPELL_AURA_PIRATE, true);
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF+2)
        {
	  player->TeleportTo(0, -14422.505859f, 528.839844f, 386.005806f, 0.627286f);
        }

        return true;
    }
};

/* fin jour des pirates */

/*####
## npc_winter_reveler
####*/

enum WinterReveler
{
    SPELL_MISTLETOE_DEBUFF       = 26218,
    SPELL_CREATE_MISTLETOE       = 26206,
    SPELL_CREATE_HOLLY           = 26207,
    SPELL_CREATE_SNOWFLAKES      = 45036,
};

class npc_winter_reveler : public CreatureScript
{
    public:
        npc_winter_reveler() : CreatureScript("npc_winter_reveler") { }

        struct npc_winter_revelerAI : public ScriptedAI
        {
            npc_winter_revelerAI(Creature* c) : ScriptedAI(c) {}

            void ReceiveEmote(Player* player, uint32 emote)
            {
                if (player->HasAura(SPELL_MISTLETOE_DEBUFF))
                    return;

                if (!IsHolidayActive(HOLIDAY_FEAST_OF_WINTER_VEIL))
                    return;

                if (emote == TEXT_EMOTE_KISS)
                {
                    uint32 spellId = RAND<uint32>(SPELL_CREATE_MISTLETOE, SPELL_CREATE_HOLLY, SPELL_CREATE_SNOWFLAKES);
                    me->CastSpell(player, spellId, false);
                    me->CastSpell(player, SPELL_MISTLETOE_DEBUFF, false);
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_winter_revelerAI(creature);
        }
};

/*####
## npc_snake_trap_serpents
####*/

#define SPELL_MIND_NUMBING_POISON    25810   //Viper
#define SPELL_DEADLY_POISON          34655   //Venomous Snake
#define SPELL_CRIPPLING_POISON       30981   //Viper

#define VENOMOUS_SNAKE_TIMER 1500
#define VIPER_TIMER 3000

#define C_VIPER 19921

class npc_snake_trap : public CreatureScript
{
public:
    npc_snake_trap() : CreatureScript("npc_snake_trap_serpents") { }

    struct npc_snake_trap_serpentsAI : public ScriptedAI
    {
        npc_snake_trap_serpentsAI(Creature* c) : ScriptedAI(c) {}

        uint32 SpellTimer;
        bool IsViper;

        void EnterCombat(Unit* /*who*/) {}

        void Reset()
        {
            SpellTimer = 0;

            CreatureTemplate const* Info = me->GetCreatureInfo();

            IsViper = Info->Entry == C_VIPER ? true : false;

            me->SetMaxHealth(uint32(107 * (me->getLevel() - 40) * 0.025f));
            //Add delta to make them not all hit the same time
            uint32 delta = (rand() % 7) * 100;
            me->SetStatFloatValue(UNIT_FIELD_BASEATTACKTIME, float(Info->baseattacktime + delta));
            me->SetStatFloatValue(UNIT_FIELD_RANGED_ATTACK_POWER, float(Info->attackpower));

            // Start attacking attacker of owner on first ai update after spawn - move in line of sight may choose better target
            if (!me->getVictim() && me->isSummon())
                if (Unit* Owner = me->ToTempSummon()->GetSummoner())
                    if (Owner->getAttackerForHelper())
                        AttackStart(Owner->getAttackerForHelper());
        }

        //Redefined for random target selection:
        void MoveInLineOfSight(Unit* who)
        {
            if (!me->getVictim() && me->canCreatureAttack(who))
            {
                if (me->GetDistanceZ(who) > CREATURE_Z_ATTACK_RANGE)
                    return;

                float attackRadius = me->GetAttackDistance(who);
                if (me->IsWithinDistInMap(who, attackRadius) && me->IsWithinLOSInMap(who))
                {
                    if (!(rand() % 5))
                    {
                        me->setAttackTimer(BASE_ATTACK, (rand() % 10) * 100);
                        SpellTimer = (rand() % 10) * 100;
                        AttackStart(who);
                    }
                }
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (me->getVictim()->HasBreakableByDamageCrowdControlAura(me))
            {
                me->InterruptNonMeleeSpells(false);
                return;
            }

            if (SpellTimer <= diff)
            {
                if (IsViper) //Viper
                {
                    if (urand(0, 2) == 0) //33% chance to cast
                    {
                        uint32 spell;
                        if (urand(0, 1) == 0)
                            spell = SPELL_MIND_NUMBING_POISON;
                        else
                            spell = SPELL_CRIPPLING_POISON;

                        DoCast(me->getVictim(), spell);
                    }

                    SpellTimer = VIPER_TIMER;
                }
                else //Venomous Snake
                {
                    if (urand(0, 2) == 0) //33% chance to cast
                        DoCast(me->getVictim(), SPELL_DEADLY_POISON);
                    SpellTimer = VENOMOUS_SNAKE_TIMER + (rand() % 5) * 100;
                }
            }
            else
                SpellTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_snake_trap_serpentsAI(creature);
    }
};

#define SAY_RANDOM_MOJO0    "Now that's what I call froggy-style!"
#define SAY_RANDOM_MOJO1    "Your lily pad or mine?"
#define SAY_RANDOM_MOJO2    "This won't take long, did it?"
#define SAY_RANDOM_MOJO3    "I thought you'd never ask!"
#define SAY_RANDOM_MOJO4    "I promise not to give you warts..."
#define SAY_RANDOM_MOJO5    "Feelin' a little froggy, are ya?"
#define SAY_RANDOM_MOJO6a   "Listen, "
#define SAY_RANDOM_MOJO6b   ", I know of a little swamp not too far from here...."
#define SAY_RANDOM_MOJO7    "There's just never enough Mojo to go around..."

class mob_mojo : public CreatureScript
{
public:
    mob_mojo() : CreatureScript("mob_mojo") { }

    struct mob_mojoAI : public ScriptedAI
    {
        mob_mojoAI(Creature* c) : ScriptedAI(c) {Reset();}

        uint32 Hearts;
        uint64 VictimGUID;

        void Reset()
        {
            VictimGUID = 0;
            Hearts = 15000;
            if (Unit* own = me->GetOwner())
                me->GetMotionMaster()->MoveFollow(own, 0, 0);
        }

        void EnterCombat(Unit* /*who*/){}

        void UpdateAI(uint32 const diff)
        {
            if (me->HasAura(20372))
            {
                if (Hearts <= diff)
                {
                    me->RemoveAurasDueToSpell(20372);
                    Hearts = 15000;
                }
                Hearts -= diff;
            }
        }

        void ReceiveEmote(Player* player, uint32 emote)
        {
            me->HandleEmoteCommand(emote);
            Unit* own = me->GetOwner();
            if (!own || own->GetTypeId() != TYPEID_PLAYER || CAST_PLR(own)->GetTeam() != player->GetTeam())
                return;
            if (emote == TEXT_EMOTE_KISS)
            {
                std::string whisp = "";
                switch (rand() % 8)
                {
                    case 0:
                        whisp.append(SAY_RANDOM_MOJO0);
                        break;
                    case 1:
                        whisp.append(SAY_RANDOM_MOJO1);
                        break;
                    case 2:
                        whisp.append(SAY_RANDOM_MOJO2);
                        break;
                    case 3:
                        whisp.append(SAY_RANDOM_MOJO3);
                        break;
                    case 4:
                        whisp.append(SAY_RANDOM_MOJO4);
                        break;
                    case 5:
                        whisp.append(SAY_RANDOM_MOJO5);
                        break;
                    case 6:
                        whisp.append(SAY_RANDOM_MOJO6a);
                        whisp.append(player->GetName());
                        whisp.append(SAY_RANDOM_MOJO6b);
                        break;
                    case 7:
                        whisp.append(SAY_RANDOM_MOJO7);
                        break;
                }

                me->MonsterWhisper(whisp.c_str(), player->GetGUID());
                if (VictimGUID)
                    if (Player* victim = Unit::GetPlayer(*me, VictimGUID))
                        victim->RemoveAura(43906);//remove polymorph frog thing
                me->AddAura(43906, player);//add polymorph frog thing
                VictimGUID = player->GetGUID();
                DoCast(me, 20372, true);//tag.hearts
                me->GetMotionMaster()->MoveFollow(player, 0, 0);
                Hearts = 15000;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_mojoAI(creature);
    }
};

class npc_mirror_image : public CreatureScript
{
public:
    npc_mirror_image() : CreatureScript("npc_mirror_image") { }

    struct npc_mirror_imageAI : CasterAI
    {
        npc_mirror_imageAI(Creature* c) : CasterAI(c) {}

        void InitializeAI()
        {
            CasterAI::InitializeAI();
            Unit* owner = me->GetOwner();
            if (!owner)
                return;
            me->SetMaxHealth(4400);
            me->SetHealth(4400);
            // Inherit Master's Threat List (not yet implemented)
            owner->CastSpell((Unit*)NULL, 58838, true);
            // here mirror image casts on summoner spell (not present in client dbc) 49866
            // here should be auras (not present in client dbc): 35657, 35658, 35659, 35660 selfcasted by mirror images (stats related?)
            // Clone Me!
            owner->CastSpell(me, 45204, false);
            me->SetReactState(REACT_AGGRESSIVE);
            //            if (owner->ToPlayer() && owner->ToPlayer()->GetSelectedUnit())
            //    me->AI()->AttackStart(owner->ToPlayer()->GetSelectedUnit());
        }

        /*        void EnterCombat(Unit *who)
        {
            if (spells.empty())
                return;

            for (SpellVct::iterator itr = spells.begin(); itr != spells.end(); ++itr)
            {
                if (AISpellInfo[*itr].condition == AICOND_AGGRO)
                    me->CastSpell(who, *itr, false);
                else if (AISpellInfo[*itr].condition == AICOND_COMBAT)
                {
                    uint32 cooldown = GetAISpellInfo(*itr)->realCooldown;
                    events.ScheduleEvent(*itr, cooldown);
                }
            }
            }*/


        /*        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            bool hasCC = false;
            if (me->getVictim())
                if (Unit *owner =  me->GetOwner())
                    if (me->getVictim()->HasBreakableByDamageCrowdControlAura(me) || me->getVictim()->HasAuraType(SPELL_AURA_MOD_CONFUSE) || me->getVictim() != owner->getVictim())
                        hasCC = true;

            if (hasCC)
            {
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    me->CastStop();
                me->AI()->EnterEvadeMode();
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uint32 spellId = events.ExecuteEvent())
            {
                if (hasCC)
                {
                    events.ScheduleEvent(spellId, 500);
                    return;
                }
                DoCast(spellId);
                uint32 casttime = me->GetCurrentSpellCastTime(spellId);
                events.ScheduleEvent(spellId, (casttime ? casttime : 500) + GetAISpellInfo(spellId)->realCooldown);
            }

            }*/

        // Do not reload Creature templates on evade mode enter - prevent visual lost
        void EnterEvadeMode()
        {
            if (me->IsInEvadeMode() || !me->isAlive())
                return;

            Unit* owner = me->GetCharmerOrOwner();

            me->CombatStop(true);
            if (owner && !me->HasUnitState(UNIT_STATE_FOLLOW))
            {
                me->GetMotionMaster()->Clear(false);
                me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle(), MOTION_SLOT_ACTIVE);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_mirror_imageAI(creature);
    }
};

class npc_ebon_gargoyle : public CreatureScript
{
public:
    npc_ebon_gargoyle() : CreatureScript("npc_ebon_gargoyle") { }

    struct npc_ebon_gargoyleAI : CasterAI
    {
        npc_ebon_gargoyleAI(Creature* c) : CasterAI(c) {}

        uint32 DespawnTimer;

        void InitializeAI()
        {
            CasterAI::InitializeAI();
            uint64 ownerGuid = me->GetOwnerGUID();
            if (!ownerGuid)
                return;
            // Not needed to be despawned now
            DespawnTimer = 0;
            // Find victim of Summon Gargoyle spell
	    /*            std::list<Unit*> targets;
            Trinity::AnyUnfriendlyUnitInObjectRangeCheck u_check(me, me, 30);
            Trinity::UnitListSearcher<Trinity::AnyUnfriendlyUnitInObjectRangeCheck> searcher(me, targets, u_check);
            me->VisitNearbyObject(30, searcher);
            for (std::list<Unit*>::const_iterator iter = targets.begin(); iter != targets.end(); ++iter)
                if ((*iter)->GetAura(49206, ownerGuid))
                {
                    me->Attack((*iter), false);
                    break;
		    }*/
	    if (Unit* owner = me->GetOwner())
	      if (owner->GetTypeId() == TYPEID_PLAYER && owner->getVictim())
	      {
		me->AttackStop();
		me->ToCreature()->AI()->AttackStart(owner->getVictim());
	      }

        }

        void EnterEvadeMode()
        {
        }

        void JustDed(Unit* /*killer*/)
        {
            // Stop Feeding Gargoyle when it dies
            if (Unit* owner = me->GetOwner())
                owner->RemoveAurasDueToSpell(50514);
        }

        // Fly away when dismissed
        void SpellHit(Unit* source, SpellInfo const* spell)
        {
            if (spell->Id != 50515 || !me->isAlive())
                return;

            Unit* owner = me->GetOwner();

            if (!owner || owner != source)
                return;

            // Stop Fighting
            me->ApplyModFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE, true);
            // Sanctuary
            me->CastSpell(me, 54661, true);
            me->SetReactState(REACT_PASSIVE);

            // Fly Away
            me->AddUnitMovementFlag(MOVEMENTFLAG_CAN_FLY|MOVEMENTFLAG_ASCENDING|MOVEMENTFLAG_FLYING);
            me->SetSpeed(MOVE_FLIGHT, 0.75f, true);
            me->SetSpeed(MOVE_RUN, 0.75f, true);
            float x = me->GetPositionX() + 20 * cos(me->GetOrientation());
            float y = me->GetPositionY() + 20 * sin(me->GetOrientation());
            float z = me->GetPositionZ() + 40;
            me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MovePoint(0, x, y, z);

            // Despawn as soon as possible
            DespawnTimer = 4 * IN_MILLISECONDS;
        }

        void UpdateAI(const uint32 diff)
        {
            if (DespawnTimer > 0)
            {
                if (DespawnTimer > diff)
                    DespawnTimer -= diff;
                else
                    me->DespawnOrUnsummon();
                return;
            }
            CasterAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ebon_gargoyleAI(creature);
    }
};

class npc_lightwell : public CreatureScript
{
public:
    npc_lightwell() : CreatureScript("npc_lightwell") { }

    struct npc_lightwellAI : public PassiveAI
    {
        npc_lightwellAI(Creature* c) : PassiveAI(c) {}

        void Reset()
        {
            DoCast(me, 59907, false); // Spell for Lightwell Charges
        }

        void EnterEvadeMode()
        {
            if (!me->isAlive())
                return;

            me->DeleteThreatList();
            me->CombatStop(true);
            me->ResetPlayerDamageReq();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_lightwellAI(creature);
    }
};

enum eTrainingDummy
{
    NPC_ADVANCED_TARGET_DUMMY                  = 2674,
    NPC_TARGET_DUMMY                           = 2673
};

class npc_training_dummy : public CreatureScript
{
public:
    npc_training_dummy() : CreatureScript("npc_training_dummy") { }

    struct npc_training_dummyAI : Scripted_NoMovementAI
    {
        npc_training_dummyAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            Entry = creature->GetEntry();
        }

        uint32 Entry;
        uint32 ResetTimer;
        uint32 DespawnTimer;

        void Reset()
        {
            me->setTrainingDummy(true);
            me->SetControlled(true, UNIT_STATE_STUNNED);//disable rotate
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);//imune to knock aways like blast wave

            ResetTimer = 5000;
            DespawnTimer = 15000;
        }

        void EnterEvadeMode()
        {
            if (!_EnterEvadeMode())
                return;

            Reset();
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage)
        {
            ResetTimer = 5000;
            damage = 0;
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (Entry != NPC_ADVANCED_TARGET_DUMMY && Entry != NPC_TARGET_DUMMY)
                return;
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            if (!me->HasUnitState(UNIT_STATE_STUNNED))
                me->SetControlled(true, UNIT_STATE_STUNNED);//disable rotate

            if (Entry != NPC_ADVANCED_TARGET_DUMMY && Entry != NPC_TARGET_DUMMY)
            {
                if (ResetTimer <= diff)
                {
                    EnterEvadeMode();
                    ResetTimer = 5000;
                }
                else
                    ResetTimer -= diff;
                return;
            }
            else
            {
                if (DespawnTimer <= diff)
                    me->DespawnOrUnsummon();
                else
                    DespawnTimer -= diff;
            }
        }
        void MoveInLineOfSight(Unit* /*who*/){return;}
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_training_dummyAI(creature);
    }
};

/*######
# npc_shadowfiend
######*/
#define GLYPH_OF_SHADOWFIEND_MANA         58227
#define GLYPH_OF_SHADOWFIEND              58228

class npc_shadowfiend : public CreatureScript
{
public:
    npc_shadowfiend() : CreatureScript("npc_shadowfiend") { }

    struct npc_shadowfiendAI : public ScriptedAI
    {
        npc_shadowfiendAI(Creature* creature) : ScriptedAI(creature) {}

        void JustDied(Unit* killer)
        {
            if (me->isSummon())
                if (Unit* owner = me->ToTempSummon()->GetSummoner())
                    if (owner->HasAura(GLYPH_OF_SHADOWFIEND))
                        owner->CastSpell(owner, GLYPH_OF_SHADOWFIEND_MANA, true);
        }

        void Reset()
        {
            me->SetSpeed(MOVE_WALK, 1.5f);
            me->SetSpeed(MOVE_RUN, 1.5f);
            if (me->isSummon())
                if (Unit* owner = me->ToTempSummon()->GetSummoner())
                    AttackStart(owner->getAttackerForHelper());
        }

    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_shadowfiendAI(creature);
    }
};

/*######
# npc_fire_elemental
######*/
#define SPELL_FIRENOVA        12470
#define SPELL_FIRESHIELD      13376
#define SPELL_FIREBLAST       57984

class npc_fire_elemental : public CreatureScript
{
public:
    npc_fire_elemental() : CreatureScript("npc_fire_elemental") { }

    struct npc_fire_elementalAI : public ScriptedAI
    {
        npc_fire_elementalAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 FireNova_Timer;
        uint32 FireShield_Timer;
        uint32 FireBlast_Timer;

        void Reset()
        {
            FireNova_Timer = 5000 + rand() % 15000; // 5-20 sec cd
            FireBlast_Timer = 5000 + rand() % 15000; // 5-20 sec cd
            FireShield_Timer = 0;
            me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (FireShield_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_FIRESHIELD);
                FireShield_Timer = 2 * IN_MILLISECONDS;
            }
            else
                FireShield_Timer -= diff;

            if (FireBlast_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_FIREBLAST);
                FireBlast_Timer = 5000 + rand() % 15000; // 5-20 sec cd
            }
            else
                FireBlast_Timer -= diff;

            if (FireNova_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_FIRENOVA);
                FireNova_Timer = 5000 + rand() % 15000; // 5-20 sec cd
            }
            else
                FireNova_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_fire_elementalAI(creature);
    }
};

/*######
# npc_earth_elemental
######*/
#define SPELL_ANGEREDEARTH        36213

class npc_earth_elemental : public CreatureScript
{
public:
    npc_earth_elemental() : CreatureScript("npc_earth_elemental") { }

    struct npc_earth_elementalAI : public ScriptedAI
    {
        npc_earth_elementalAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 AngeredEarth_Timer;

        void Reset()
        {
            AngeredEarth_Timer = 0;
            me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (AngeredEarth_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_ANGEREDEARTH);
                AngeredEarth_Timer = 5000 + rand() % 15000; // 5-20 sec cd
            }
            else
                AngeredEarth_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_earth_elementalAI(creature);
    }
};

/*######
# npc_wormhole
######*/

#define GOSSIP_ENGINEERING1   "Toundra Boreenne."
#define GOSSIP_ENGINEERING2   "Fjord Hurlant."
#define GOSSIP_ENGINEERING3   "Bassin de Sholazar."
#define GOSSIP_ENGINEERING4   "La Couronne de glace."
#define GOSSIP_ENGINEERING5   "Les pics Foudroyés."
#define GOSSIP_ENGINEERING6   "Souterrain."

enum eWormhole
{
    SPELL_HOWLING_FJORD         = 67838,
    SPELL_SHOLAZAR_BASIN        = 67835,
    SPELL_ICECROWN              = 67836,
    SPELL_STORM_PEAKS           = 67837,

    TEXT_WORMHOLE               = 907
};

class npc_wormhole : public CreatureScript
{
public:
    npc_wormhole() : CreatureScript("npc_wormhole") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isSummon())
        {
            if (player == creature->ToTempSummon()->GetSummoner())
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ENGINEERING1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ENGINEERING2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ENGINEERING3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ENGINEERING4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ENGINEERING5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);

				if (urand(0,90) == 90)
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ENGINEERING6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);

                player->PlayerTalkClass->SendGossipMenu(TEXT_WORMHOLE, creature->GetGUID());
            }
        }
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        bool roll = urand(0, 1);

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1: //Borean Tundra
                player->CLOSE_GOSSIP_MENU();
                if (roll) //At the moment we don't have chance on spell_target_position table so we hack this
                    player->TeleportTo(571, 4305.505859f, 5450.839844f, 63.005806f, 0.627286f);
                else
                    player->TeleportTo(571, 3201.936279f, 5630.123535f, 133.658798f, 3.855272f);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2: //Howling Fjord
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_HOWLING_FJORD, true);
                break;
            case GOSSIP_ACTION_INFO_DEF + 3: //Sholazar Basin
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_SHOLAZAR_BASIN, true);
                break;
            case GOSSIP_ACTION_INFO_DEF + 4: //Icecrown
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_ICECROWN, true);
                break;
            case GOSSIP_ACTION_INFO_DEF + 5: //Storm peaks
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_STORM_PEAKS, true);
                break;
			case GOSSIP_ACTION_INFO_DEF + 6: // Souterrain
                player->CLOSE_GOSSIP_MENU();
                player->TeleportTo(571, 5860.715820f, 513.231628f, 599.817993f, 2.514055f);
                break;
        }
        return true;
    }
};

/*######
## npc_pet_trainer
######*/

enum ePetTrainer
{
    TEXT_ISHUNTER               = 5838,
    TEXT_NOTHUNTER              = 5839,
    TEXT_PETINFO                = 13474,
    TEXT_CONFIRM                = 7722
};

#define GOSSIP_PET1             "How do I train my pet?"
#define GOSSIP_PET2             "I wish to untrain my pet."
#define GOSSIP_PET_CONFIRM      "Yes, please do."

class npc_pet_trainer : public CreatureScript
{
public:
    npc_pet_trainer() : CreatureScript("npc_pet_trainer") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->getClass() == CLASS_HUNTER)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_PET1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            if (player->GetPet() && player->GetPet()->getPetType() == HUNTER_PET)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_PET2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

            player->PlayerTalkClass->SendGossipMenu(TEXT_ISHUNTER, creature->GetGUID());
            return true;
        }
        player->PlayerTalkClass->SendGossipMenu(TEXT_NOTHUNTER, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->PlayerTalkClass->SendGossipMenu(TEXT_PETINFO, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_PET_CONFIRM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    player->PlayerTalkClass->SendGossipMenu(TEXT_CONFIRM, creature->GetGUID());
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                {
                    player->ResetPetTalents();
                    player->CLOSE_GOSSIP_MENU();
                }
                break;
        }
        return true;
    }
};

/*######
## npc_locksmith
######*/

enum eLockSmith
{
    QUEST_HOW_TO_BRAKE_IN_TO_THE_ARCATRAZ = 10704,
    QUEST_DARK_IRON_LEGACY                = 3802,
    QUEST_THE_KEY_TO_SCHOLOMANCE_A        = 5505,
    QUEST_THE_KEY_TO_SCHOLOMANCE_H        = 5511,
    QUEST_HOTTER_THAN_HELL_A              = 10758,
    QUEST_HOTTER_THAN_HELL_H              = 10764,
    QUEST_RETURN_TO_KHAGDAR               = 9837,
    QUEST_CONTAINMENT                     = 13159,

    ITEM_ARCATRAZ_KEY                     = 31084,
    ITEM_SHADOWFORGE_KEY                  = 11000,
    ITEM_SKELETON_KEY                     = 13704,
    ITEM_SHATTERED_HALLS_KEY              = 28395,
    ITEM_THE_MASTERS_KEY                  = 24490,
    ITEM_VIOLET_HOLD_KEY                  = 42482,

    SPELL_ARCATRAZ_KEY                    = 54881,
    SPELL_SHADOWFORGE_KEY                 = 54882,
    SPELL_SKELETON_KEY                    = 54883,
    SPELL_SHATTERED_HALLS_KEY             = 54884,
    SPELL_THE_MASTERS_KEY                 = 54885,
    SPELL_VIOLET_HOLD_KEY                 = 67253
};

#define GOSSIP_LOST_ARCATRAZ_KEY         "I've lost my key to the Arcatraz."
#define GOSSIP_LOST_SHADOWFORGE_KEY      "I've lost my key to the Blackrock Depths."
#define GOSSIP_LOST_SKELETON_KEY         "I've lost my key to the Scholomance."
#define GOSSIP_LOST_SHATTERED_HALLS_KEY  "I've lost my key to the Shattered Halls."
#define GOSSIP_LOST_THE_MASTERS_KEY      "I've lost my key to the Karazhan."
#define GOSSIP_LOST_VIOLET_HOLD_KEY      "I've lost my key to the Violet Hold."

class npc_locksmith : public CreatureScript
{
public:
    npc_locksmith() : CreatureScript("npc_locksmith") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        // Arcatraz Key
        if (player->GetQuestRewardStatus(QUEST_HOW_TO_BRAKE_IN_TO_THE_ARCATRAZ) && !player->HasItemCount(ITEM_ARCATRAZ_KEY, 1, true))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_ARCATRAZ_KEY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        // Shadowforge Key
        if (player->GetQuestRewardStatus(QUEST_DARK_IRON_LEGACY) && !player->HasItemCount(ITEM_SHADOWFORGE_KEY, 1, true))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_SHADOWFORGE_KEY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        // Skeleton Key
        if ((player->GetQuestRewardStatus(QUEST_THE_KEY_TO_SCHOLOMANCE_A) || player->GetQuestRewardStatus(QUEST_THE_KEY_TO_SCHOLOMANCE_H)) &&
            !player->HasItemCount(ITEM_SKELETON_KEY, 1, true))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_SKELETON_KEY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

        // Shatered Halls Key
        if ((player->GetQuestRewardStatus(QUEST_HOTTER_THAN_HELL_A) || player->GetQuestRewardStatus(QUEST_HOTTER_THAN_HELL_H)) &&
            !player->HasItemCount(ITEM_SHATTERED_HALLS_KEY, 1, true))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_SHATTERED_HALLS_KEY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

        // Master's Key
        if (player->GetQuestRewardStatus(QUEST_RETURN_TO_KHAGDAR) && !player->HasItemCount(ITEM_THE_MASTERS_KEY, 1, true))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_THE_MASTERS_KEY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);

        // Violet Hold Key
        if (player->GetQuestRewardStatus(QUEST_CONTAINMENT) && !player->HasItemCount(ITEM_VIOLET_HOLD_KEY, 1, true))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_VIOLET_HOLD_KEY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_ARCATRAZ_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_SHADOWFORGE_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_SKELETON_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_SHATTERED_HALLS_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_THE_MASTERS_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_VIOLET_HOLD_KEY, false);
                break;
        }
        return true;
    }
};

/*######
## npc_tabard_vendor
######*/

enum
{
    QUEST_TRUE_MASTERS_OF_LIGHT = 9737,
    QUEST_THE_UNWRITTEN_PROPHECY = 9762,
    QUEST_INTO_THE_BREACH = 10259,
    QUEST_BATTLE_OF_THE_CRIMSON_WATCH = 10781,
    QUEST_SHARDS_OF_AHUNE = 11972,

    ACHIEVEMENT_EXPLORE_NORTHREND = 45,
    ACHIEVEMENT_TWENTYFIVE_TABARDS = 1021,
    ACHIEVEMENT_THE_LOREMASTER_A = 1681,
    ACHIEVEMENT_THE_LOREMASTER_H = 1682,

    ITEM_TABARD_OF_THE_HAND = 24344,
    ITEM_TABARD_OF_THE_BLOOD_KNIGHT = 25549,
    ITEM_TABARD_OF_THE_PROTECTOR = 28788,
    ITEM_OFFERING_OF_THE_SHATAR = 31408,
    ITEM_GREEN_TROPHY_TABARD_OF_THE_ILLIDARI = 31404,
    ITEM_PURPLE_TROPHY_TABARD_OF_THE_ILLIDARI = 31405,
    ITEM_TABARD_OF_THE_SUMMER_SKIES = 35279,
    ITEM_TABARD_OF_THE_SUMMER_FLAMES = 35280,
    ITEM_TABARD_OF_THE_ACHIEVER = 40643,
    ITEM_LOREMASTERS_COLORS = 43300,
    ITEM_TABARD_OF_THE_EXPLORER = 43348,

    SPELL_TABARD_OF_THE_BLOOD_KNIGHT = 54974,
    SPELL_TABARD_OF_THE_HAND = 54976,
    SPELL_GREEN_TROPHY_TABARD_OF_THE_ILLIDARI = 54977,
    SPELL_PURPLE_TROPHY_TABARD_OF_THE_ILLIDARI = 54982,
    SPELL_TABARD_OF_THE_ACHIEVER = 55006,
    SPELL_TABARD_OF_THE_PROTECTOR = 55008,
    SPELL_LOREMASTERS_COLORS = 58194,
    SPELL_TABARD_OF_THE_EXPLORER = 58224,
    SPELL_TABARD_OF_SUMMER_SKIES = 62768,
    SPELL_TABARD_OF_SUMMER_FLAMES = 62769
};

#define GOSSIP_LOST_TABARD_OF_BLOOD_KNIGHT "I've lost my Tabard of Blood Knight."
#define GOSSIP_LOST_TABARD_OF_THE_HAND "I've lost my Tabard of the Hand."
#define GOSSIP_LOST_TABARD_OF_THE_PROTECTOR "I've lost my Tabard of the Protector."
#define GOSSIP_LOST_GREEN_TROPHY_TABARD_OF_THE_ILLIDARI "I've lost my Green Trophy Tabard of the Illidari."
#define GOSSIP_LOST_PURPLE_TROPHY_TABARD_OF_THE_ILLIDARI "I've lost my Purple Trophy Tabard of the Illidari."
#define GOSSIP_LOST_TABARD_OF_SUMMER_SKIES "I've lost my Tabard of Summer Skies."
#define GOSSIP_LOST_TABARD_OF_SUMMER_FLAMES "I've lost my Tabard of Summer Flames."
#define GOSSIP_LOST_LOREMASTERS_COLORS "I've lost my Loremaster's Colors."
#define GOSSIP_LOST_TABARD_OF_THE_EXPLORER "I've lost my Tabard of the Explorer."
#define GOSSIP_LOST_TABARD_OF_THE_ACHIEVER "I've lost my Tabard of the Achiever."

class npc_tabard_vendor : public CreatureScript
{
public:
    npc_tabard_vendor() : CreatureScript("npc_tabard_vendor") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        bool lostBloodKnight = false;
        bool lostHand = false;
        bool lostProtector = false;
        bool lostIllidari = false;
        bool lostSummer = false;

        //Tabard of the Blood Knight
        if (player->GetQuestRewardStatus(QUEST_TRUE_MASTERS_OF_LIGHT) && !player->HasItemCount(ITEM_TABARD_OF_THE_BLOOD_KNIGHT, 1, true))
            lostBloodKnight = true;

        //Tabard of the Hand
        if (player->GetQuestRewardStatus(QUEST_THE_UNWRITTEN_PROPHECY) && !player->HasItemCount(ITEM_TABARD_OF_THE_HAND, 1, true))
            lostHand = true;

        //Tabard of the Protector
        if (player->GetQuestRewardStatus(QUEST_INTO_THE_BREACH) && !player->HasItemCount(ITEM_TABARD_OF_THE_PROTECTOR, 1, true))
            lostProtector = true;

        //Green Trophy Tabard of the Illidari
        //Purple Trophy Tabard of the Illidari
        if (player->GetQuestRewardStatus(QUEST_BATTLE_OF_THE_CRIMSON_WATCH) &&
            (!player->HasItemCount(ITEM_GREEN_TROPHY_TABARD_OF_THE_ILLIDARI, 1, true) &&
            !player->HasItemCount(ITEM_PURPLE_TROPHY_TABARD_OF_THE_ILLIDARI, 1, true) &&
            !player->HasItemCount(ITEM_OFFERING_OF_THE_SHATAR, 1, true)))
            lostIllidari = true;

        //Tabard of Summer Skies
        //Tabard of Summer Flames
        if (player->GetQuestRewardStatus(QUEST_SHARDS_OF_AHUNE) &&
            !player->HasItemCount(ITEM_TABARD_OF_THE_SUMMER_SKIES, 1, true) &&
            !player->HasItemCount(ITEM_TABARD_OF_THE_SUMMER_FLAMES, 1, true))
            lostSummer = true;

        if (lostBloodKnight || lostHand || lostProtector || lostIllidari || lostSummer)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

            if (lostBloodKnight)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_TABARD_OF_BLOOD_KNIGHT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            if (lostHand)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_TABARD_OF_THE_HAND, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

            if (lostProtector)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_TABARD_OF_THE_PROTECTOR, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

            if (lostIllidari)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_GREEN_TROPHY_TABARD_OF_THE_ILLIDARI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_PURPLE_TROPHY_TABARD_OF_THE_ILLIDARI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
            }

            if (lostSummer)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_TABARD_OF_SUMMER_SKIES, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_LOST_TABARD_OF_SUMMER_FLAMES, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            }

            player->SEND_GOSSIP_MENU(13583, creature->GetGUID());
        }
        else
            player->GetSession()->SendListInventory(creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 1:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_TABARD_OF_THE_BLOOD_KNIGHT, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_TABARD_OF_THE_HAND, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_TABARD_OF_THE_PROTECTOR, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_GREEN_TROPHY_TABARD_OF_THE_ILLIDARI, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_PURPLE_TROPHY_TABARD_OF_THE_ILLIDARI, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_TABARD_OF_SUMMER_SKIES, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 7:
                player->CLOSE_GOSSIP_MENU();
                player->CastSpell(player, SPELL_TABARD_OF_SUMMER_FLAMES, false);
                break;
        }
        return true;
    }
};

/*######
## npc_experience
######*/

#define EXP_COST                100000 //10 00 00 copper (10golds)
#define GOSSIP_TEXT_EXP         14736
#define GOSSIP_XP_OFF           "I no longer wish to gain experience."
#define GOSSIP_XP_ON            "I wish to start gaining experience again."

class npc_experience : public CreatureScript
{
public:
    npc_experience() : CreatureScript("npc_experience") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_XP_OFF, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_XP_ON, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXT_EXP, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        bool noXPGain = player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
        bool doSwitch = false;

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1://xp off
                {
                    if (!noXPGain)//does gain xp
                        doSwitch = true;//switch to don't gain xp
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 2://xp on
                {
                    if (noXPGain)//doesn't gain xp
                        doSwitch = true;//switch to gain xp
                }
                break;
        }
        if (doSwitch)
        {
            if (!player->HasEnoughMoney(EXP_COST))
                player->SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, 0, 0, 0);
            else if (noXPGain)
            {
                player->ModifyMoney(-EXP_COST);
                player->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
            }
            else if (!noXPGain)
            {
                player->ModifyMoney(-EXP_COST);
                player->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_NO_XP_GAIN);
            }
        }
        player->PlayerTalkClass->SendCloseGossip();
        return true;
    }
};

enum Fireworks
{
    NPC_OMEN                = 15467,
    NPC_MINION_OF_OMEN      = 15466,
    NPC_FIREWORK_BLUE       = 15879,
    NPC_FIREWORK_GREEN      = 15880,
    NPC_FIREWORK_PURPLE     = 15881,
    NPC_FIREWORK_RED        = 15882,
    NPC_FIREWORK_YELLOW     = 15883,
    NPC_FIREWORK_WHITE      = 15884,
    NPC_FIREWORK_BIG_BLUE   = 15885,
    NPC_FIREWORK_BIG_GREEN  = 15886,
    NPC_FIREWORK_BIG_PURPLE = 15887,
    NPC_FIREWORK_BIG_RED    = 15888,
    NPC_FIREWORK_BIG_YELLOW = 15889,
    NPC_FIREWORK_BIG_WHITE  = 15890,

    NPC_CLUSTER_BLUE        = 15872,
    NPC_CLUSTER_RED         = 15873,
    NPC_CLUSTER_GREEN       = 15874,
    NPC_CLUSTER_PURPLE      = 15875,
    NPC_CLUSTER_WHITE       = 15876,
    NPC_CLUSTER_YELLOW      = 15877,
    NPC_CLUSTER_BIG_BLUE    = 15911,
    NPC_CLUSTER_BIG_GREEN   = 15912,
    NPC_CLUSTER_BIG_PURPLE  = 15913,
    NPC_CLUSTER_BIG_RED     = 15914,
    NPC_CLUSTER_BIG_WHITE   = 15915,
    NPC_CLUSTER_BIG_YELLOW  = 15916,
    NPC_CLUSTER_ELUNE       = 15918,

    GO_FIREWORK_LAUNCHER_1  = 180771,
    GO_FIREWORK_LAUNCHER_2  = 180868,
    GO_FIREWORK_LAUNCHER_3  = 180850,
    GO_CLUSTER_LAUNCHER_1   = 180772,
    GO_CLUSTER_LAUNCHER_2   = 180859,
    GO_CLUSTER_LAUNCHER_3   = 180869,
    GO_CLUSTER_LAUNCHER_4   = 180874,

    SPELL_ROCKET_BLUE       = 26344,
    SPELL_ROCKET_GREEN      = 26345,
    SPELL_ROCKET_PURPLE     = 26346,
    SPELL_ROCKET_RED        = 26347,
    SPELL_ROCKET_WHITE      = 26348,
    SPELL_ROCKET_YELLOW     = 26349,
    SPELL_ROCKET_BIG_BLUE   = 26351,
    SPELL_ROCKET_BIG_GREEN  = 26352,
    SPELL_ROCKET_BIG_PURPLE = 26353,
    SPELL_ROCKET_BIG_RED    = 26354,
    SPELL_ROCKET_BIG_WHITE  = 26355,
    SPELL_ROCKET_BIG_YELLOW = 26356,
    SPELL_LUNAR_FORTUNE     = 26522,

    ANIM_GO_LAUNCH_FIREWORK = 3,
    ZONE_MOONGLADE          = 493,
};

Position omenSummonPos = {7558.993f, -2839.999f, 450.0214f, 4.46f};

class npc_firework : public CreatureScript
{
public:
    npc_firework() : CreatureScript("npc_firework") { }

    struct npc_fireworkAI : public ScriptedAI
    {
        npc_fireworkAI(Creature* creature) : ScriptedAI(creature) {}

        bool isCluster()
        {
            switch (me->GetEntry())
            {
                case NPC_FIREWORK_BLUE:
                case NPC_FIREWORK_GREEN:
                case NPC_FIREWORK_PURPLE:
                case NPC_FIREWORK_RED:
                case NPC_FIREWORK_YELLOW:
                case NPC_FIREWORK_WHITE:
                case NPC_FIREWORK_BIG_BLUE:
                case NPC_FIREWORK_BIG_GREEN:
                case NPC_FIREWORK_BIG_PURPLE:
                case NPC_FIREWORK_BIG_RED:
                case NPC_FIREWORK_BIG_YELLOW:
                case NPC_FIREWORK_BIG_WHITE:
                    return false;
                case NPC_CLUSTER_BLUE:
                case NPC_CLUSTER_GREEN:
                case NPC_CLUSTER_PURPLE:
                case NPC_CLUSTER_RED:
                case NPC_CLUSTER_YELLOW:
                case NPC_CLUSTER_WHITE:
                case NPC_CLUSTER_BIG_BLUE:
                case NPC_CLUSTER_BIG_GREEN:
                case NPC_CLUSTER_BIG_PURPLE:
                case NPC_CLUSTER_BIG_RED:
                case NPC_CLUSTER_BIG_YELLOW:
                case NPC_CLUSTER_BIG_WHITE:
                case NPC_CLUSTER_ELUNE:
                default:
                    return true;
            }
        }

        GameObject* FindNearestLauncher()
        {
            GameObject* launcher = NULL;

            if (isCluster())
            {
                GameObject* launcher1 = GetClosestGameObjectWithEntry(me, GO_CLUSTER_LAUNCHER_1, 0.5f);
                GameObject* launcher2 = GetClosestGameObjectWithEntry(me, GO_CLUSTER_LAUNCHER_2, 0.5f);
                GameObject* launcher3 = GetClosestGameObjectWithEntry(me, GO_CLUSTER_LAUNCHER_3, 0.5f);
                GameObject* launcher4 = GetClosestGameObjectWithEntry(me, GO_CLUSTER_LAUNCHER_4, 0.5f);

                if (launcher1)
                    launcher = launcher1;
                else if (launcher2)
                    launcher = launcher2;
                else if (launcher3)
                    launcher = launcher3;
                else if (launcher4)
                    launcher = launcher4;
            }
            else
            {
                GameObject* launcher1 = GetClosestGameObjectWithEntry(me, GO_FIREWORK_LAUNCHER_1, 0.5f);
                GameObject* launcher2 = GetClosestGameObjectWithEntry(me, GO_FIREWORK_LAUNCHER_2, 0.5f);
                GameObject* launcher3 = GetClosestGameObjectWithEntry(me, GO_FIREWORK_LAUNCHER_3, 0.5f);

                if (launcher1)
                    launcher = launcher1;
                else if (launcher2)
                    launcher = launcher2;
                else if (launcher3)
                    launcher = launcher3;
            }

            return launcher;
        }

        uint32 GetFireworkSpell(uint32 entry)
        {
            switch (entry)
            {
                case NPC_FIREWORK_BLUE:
                    return SPELL_ROCKET_BLUE;
                case NPC_FIREWORK_GREEN:
                    return SPELL_ROCKET_GREEN;
                case NPC_FIREWORK_PURPLE:
                    return SPELL_ROCKET_PURPLE;
                case NPC_FIREWORK_RED:
                    return SPELL_ROCKET_RED;
                case NPC_FIREWORK_YELLOW:
                    return SPELL_ROCKET_YELLOW;
                case NPC_FIREWORK_WHITE:
                    return SPELL_ROCKET_WHITE;
                case NPC_FIREWORK_BIG_BLUE:
                    return SPELL_ROCKET_BIG_BLUE;
                case NPC_FIREWORK_BIG_GREEN:
                    return SPELL_ROCKET_BIG_GREEN;
                case NPC_FIREWORK_BIG_PURPLE:
                    return SPELL_ROCKET_BIG_PURPLE;
                case NPC_FIREWORK_BIG_RED:
                    return SPELL_ROCKET_BIG_RED;
                case NPC_FIREWORK_BIG_YELLOW:
                    return SPELL_ROCKET_BIG_YELLOW;
                case NPC_FIREWORK_BIG_WHITE:
                    return SPELL_ROCKET_BIG_WHITE;
                default:
                    return 0;
            }
        }

        uint32 GetFireworkGameObjectId()
        {
            uint32 spellId = 0;

            switch (me->GetEntry())
            {
                case NPC_CLUSTER_BLUE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BLUE);
                    break;
                case NPC_CLUSTER_GREEN:
                    spellId = GetFireworkSpell(NPC_FIREWORK_GREEN);
                    break;
                case NPC_CLUSTER_PURPLE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_PURPLE);
                    break;
                case NPC_CLUSTER_RED:
                    spellId = GetFireworkSpell(NPC_FIREWORK_RED);
                    break;
                case NPC_CLUSTER_YELLOW:
                    spellId = GetFireworkSpell(NPC_FIREWORK_YELLOW);
                    break;
                case NPC_CLUSTER_WHITE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_WHITE);
                    break;
                case NPC_CLUSTER_BIG_BLUE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_BLUE);
                    break;
                case NPC_CLUSTER_BIG_GREEN:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_GREEN);
                    break;
                case NPC_CLUSTER_BIG_PURPLE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_PURPLE);
                    break;
                case NPC_CLUSTER_BIG_RED:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_RED);
                    break;
                case NPC_CLUSTER_BIG_YELLOW:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_YELLOW);
                    break;
                case NPC_CLUSTER_BIG_WHITE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_WHITE);
                    break;
                case NPC_CLUSTER_ELUNE:
                    spellId = GetFireworkSpell(urand(NPC_FIREWORK_BLUE, NPC_FIREWORK_WHITE));
                    break;
            }

            const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(spellId);

            if (spellInfo && spellInfo->Effects[0].Effect == SPELL_EFFECT_SUMMON_OBJECT_WILD)
                return spellInfo->Effects[0].MiscValue;

            return 0;
        }

        void Reset()
        {
            if (GameObject* launcher = FindNearestLauncher())
            {
                launcher->SendCustomAnim(ANIM_GO_LAUNCH_FIREWORK);
                me->SetOrientation(launcher->GetOrientation() + M_PI/2);
            }
            else
                return;

            if (isCluster())
            {
                // Check if we are near Elune'ara lake south, if so try to summon Omen or a minion
                if (me->GetZoneId() == ZONE_MOONGLADE)
                {
                    if (!me->FindNearestCreature(NPC_OMEN, 100.0f, false) && me->GetDistance2d(omenSummonPos.GetPositionX(), omenSummonPos.GetPositionY()) <= 100.0f)
                    {
                        switch (urand(0,9))
                        {
                            case 0:
                            case 1:
                            case 2:
                            case 3:
                                if (Creature* minion = me->SummonCreature(NPC_MINION_OF_OMEN, me->GetPositionX()+frand(-5.0f, 5.0f), me->GetPositionY()+frand(-5.0f, 5.0f), me->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                                    minion->AI()->AttackStart(me->SelectNearestPlayer(20.0f));
                                break;
                            case 9:
                                me->SummonCreature(NPC_OMEN, omenSummonPos);
                                break;
                        }
                    }
                }
                if (me->GetEntry() == NPC_CLUSTER_ELUNE)
                    DoCast(SPELL_LUNAR_FORTUNE);

                float displacement = 0.7f;
                for (uint8 i = 0; i < 4; i++)
                    me->SummonGameObject(GetFireworkGameObjectId(), me->GetPositionX() + (i%2 == 0 ? displacement : -displacement), me->GetPositionY() + (i > 1 ? displacement : -displacement), me->GetPositionZ() + 4.0f, me->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 1);
            }
            else
                //me->CastSpell(me, GetFireworkSpell(me->GetEntry()), true);
                me->CastSpell(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), GetFireworkSpell(me->GetEntry()), true);
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_fireworkAI(creature);
    }
};

/*#####
# npc_spring_rabbit
#####*/

enum rabbitSpells
{
    SPELL_SPRING_FLING          = 61875,
    SPELL_SPRING_RABBIT_JUMP    = 61724,
    SPELL_SPRING_RABBIT_WANDER  = 61726,
    SPELL_SUMMON_BABY_BUNNY     = 61727,
    SPELL_SPRING_RABBIT_IN_LOVE = 61728,
    NPC_SPRING_RABBIT           = 32791
};

class npc_spring_rabbit : public CreatureScript
{
public:
    npc_spring_rabbit() : CreatureScript("npc_spring_rabbit") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_spring_rabbitAI(creature);
    }

    struct npc_spring_rabbitAI : public ScriptedAI
    {
        npc_spring_rabbitAI(Creature* c) : ScriptedAI(c) { }

        bool inLove;
        uint32 jumpTimer;
        uint32 bunnyTimer;
        uint32 searchTimer;
        uint64 rabbitGUID;

        void Reset()
        {
            inLove = false;
            rabbitGUID = 0;
            jumpTimer = urand(5000, 10000);
            bunnyTimer = urand(10000, 20000);
            searchTimer = urand(5000, 10000);
            if (Unit* owner = me->GetOwner())
                me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
        }

        void EnterCombat(Unit * /*who*/) { }

        void DoAction(const int32 /*param*/)
        {
            inLove = true;
            if (Unit* owner = me->GetOwner())
                owner->CastSpell(owner, SPELL_SPRING_FLING, true);
        }

        void UpdateAI(const uint32 diff)
        {
            if (inLove)
            {
                if (jumpTimer <= diff)
                {
                    if (Unit* rabbit = Unit::GetUnit(*me, rabbitGUID))
                        DoCast(rabbit, SPELL_SPRING_RABBIT_JUMP);
                    jumpTimer = urand(5000, 10000);
                } else jumpTimer -= diff;

                if (bunnyTimer <= diff)
                {
                    DoCast(SPELL_SUMMON_BABY_BUNNY);
                    bunnyTimer = urand(20000, 40000);
                } else bunnyTimer -= diff;
            }
            else
            {
                if (searchTimer <= diff)
                {
                    if (Creature* rabbit = me->FindNearestCreature(NPC_SPRING_RABBIT, 10.0f))
                    {
                        if (rabbit == me || rabbit->HasAura(SPELL_SPRING_RABBIT_IN_LOVE))
                            return;

                        me->AddAura(SPELL_SPRING_RABBIT_IN_LOVE, me);
                        DoAction(1);
                        rabbit->AddAura(SPELL_SPRING_RABBIT_IN_LOVE, rabbit);
                        rabbit->AI()->DoAction(1);
                        rabbit->CastSpell(rabbit, SPELL_SPRING_RABBIT_JUMP, true);
                        rabbitGUID = rabbit->GetGUID();
                    }
                    searchTimer = urand(5000, 10000);
                } else searchTimer -= diff;
            }
        }
    };
};

/*######
## npc_argent_squire/gruntling
######*/

enum Misc
{
    STATE_BANK      = 0x1,
    STATE_SHOP      = 0x2,
    STATE_MAIL      = 0x4,

    GOSSIP_ACTION_MAIL = 3,
    ACHI_PONY_UP                = 3736,

    SPELL_CHECK_MOUNT           = 67039,
    SPELL_CHECK_TIRED           = 67334,
    SPELL_SQUIRE_BANK_ERRAND    = 67368,
    SPELL_SQUIRE_POSTMAN        = 67376,
    SPELL_SQUIRE_SHOP           = 67377,
    SPELL_SQUIRE_TIRED          = 67401
};
enum Quests
{
    QUEST_CHAMP_ORGRIMMAR       = 13726,
    QUEST_CHAMP_UNDERCITY       = 13729,
    QUEST_CHAMP_SENJIN          = 13727,
    QUEST_CHAMP_SILVERMOON      = 13731,
    QUEST_CHAMP_THUNDERBLUFF    = 13728,
    QUEST_CHAMP_STORMWIND       = 13699,
    QUEST_CHAMP_IRONFORGE       = 13713,
    QUEST_CHAMP_GNOMEREGAN      = 13723,
    QUEST_CHAMP_DARNASSUS       = 13725,
    QUEST_CHAMP_EXODAR          = 13724
};
enum Pennants
{
    SPELL_DARNASSUS_PENNANT     = 63443,
    SPELL_EXODAR_PENNANT        = 63439,
    SPELL_GNOMEREGAN_PENNANT    = 63442,
    SPELL_IRONFORGE_PENNANT     = 63440,
    SPELL_ORGRIMMAR_PENNANT     = 63444,
    SPELL_SENJIN_PENNANT        = 63446,
    SPELL_SILVERMOON_PENNANT    = 63438,
    SPELL_STORMWIND_PENNANT     = 62727,
    SPELL_THUNDERBLUFF_PENNANT  = 63445,
    SPELL_UNDERCITY_PENNANT     = 63441
};

class npc_argent_squire : public CreatureScript
{
public:
    npc_argent_squire() : CreatureScript("npc_argent_squire") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        // Argent Pony Bridle options
        if (pPlayer->GetAchievementMgr().HasAchieved(ACHI_PONY_UP))
            if (!pCreature->HasAura(SPELL_SQUIRE_TIRED))
            {
                uint8 uiBuff = (STATE_BANK | STATE_SHOP | STATE_MAIL);
                if (pCreature->HasAura(SPELL_SQUIRE_BANK_ERRAND))
                    uiBuff = STATE_BANK;
                if (pCreature->HasAura(SPELL_SQUIRE_SHOP))
                    uiBuff = STATE_SHOP;
                if (pCreature->HasAura(SPELL_SQUIRE_POSTMAN))
                    uiBuff = STATE_MAIL;

                if (uiBuff & STATE_BANK)
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "Voir une banque.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_BANK);
                if (uiBuff & STATE_SHOP)
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Voir un marchand.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
                if (uiBuff & STATE_MAIL)
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Voir une boite aux lettres.", GOSSIP_SENDER_MAIN, 3);
            }

        // Horde
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_SENJIN))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion des Sombrelances", GOSSIP_SENDER_MAIN, SPELL_SENJIN_PENNANT);
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_UNDERCITY))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion des Reprouves", GOSSIP_SENDER_MAIN, SPELL_UNDERCITY_PENNANT);
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_ORGRIMMAR))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion d'Orgrimmar", GOSSIP_SENDER_MAIN, SPELL_ORGRIMMAR_PENNANT);
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_SILVERMOON))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion de Lune-d'Argent", GOSSIP_SENDER_MAIN, SPELL_SILVERMOON_PENNANT);
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_THUNDERBLUFF))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion des Pitons-de-Tonnerre", GOSSIP_SENDER_MAIN, SPELL_THUNDERBLUFF_PENNANT);

        //Alliance
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_DARNASSUS))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion de Darnassus", GOSSIP_SENDER_MAIN, SPELL_DARNASSUS_PENNANT);
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_EXODAR))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion de l'Exodar", GOSSIP_SENDER_MAIN, SPELL_EXODAR_PENNANT);
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_GNOMEREGAN))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion de Gnomeregan", GOSSIP_SENDER_MAIN, SPELL_GNOMEREGAN_PENNANT);
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_IRONFORGE))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion de Forgefer", GOSSIP_SENDER_MAIN, SPELL_IRONFORGE_PENNANT);
        if (pPlayer->GetQuestRewardStatus(QUEST_CHAMP_STORMWIND))
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Pennon de champion de Hurlevent", GOSSIP_SENDER_MAIN, SPELL_STORMWIND_PENNANT);

        pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction >= 1000) // remove old pennant aura
            pCreature->AI()->SetData(0, 0);
        switch (uiAction)
        {
            case GOSSIP_ACTION_BANK:
                pCreature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_BANKER);
                pPlayer->GetSession()->SendShowBank(pCreature->GetGUID());
                if (!pCreature->HasAura(SPELL_SQUIRE_BANK_ERRAND))
                    pCreature->AddAura(SPELL_SQUIRE_BANK_ERRAND, pCreature);
                if (!pPlayer->HasAura(SPELL_CHECK_TIRED))
                    pPlayer->AddAura(SPELL_CHECK_TIRED, pPlayer);
                break;
            case GOSSIP_ACTION_TRADE:
                pCreature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_VENDOR);
                pPlayer->GetSession()->SendListInventory(pCreature->GetGUID());
                if (!pCreature->HasAura(SPELL_SQUIRE_SHOP))
                    pCreature->AddAura(SPELL_SQUIRE_SHOP, pCreature);
                if (!pPlayer->HasAura(SPELL_CHECK_TIRED))
                    pPlayer->AddAura(SPELL_CHECK_TIRED, pPlayer);
                break;
            case GOSSIP_ACTION_MAIL:
                pCreature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_MAILBOX);
                pPlayer->GetSession()->SendShowMailBox(pCreature->GetGUID());
                //pCreature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                if (!pCreature->HasAura(SPELL_SQUIRE_POSTMAN))
                    pCreature->AddAura(SPELL_SQUIRE_POSTMAN, pCreature);
                if (!pPlayer->HasAura(SPELL_CHECK_TIRED))
                    pPlayer->AddAura(SPELL_CHECK_TIRED, pPlayer);
                break;
            case SPELL_SENJIN_PENNANT:
            case SPELL_UNDERCITY_PENNANT:
            case SPELL_ORGRIMMAR_PENNANT:
            case SPELL_SILVERMOON_PENNANT:
            case SPELL_THUNDERBLUFF_PENNANT:
            case SPELL_DARNASSUS_PENNANT:
            case SPELL_EXODAR_PENNANT:
            case SPELL_GNOMEREGAN_PENNANT:
            case SPELL_IRONFORGE_PENNANT:
            case SPELL_STORMWIND_PENNANT:
                pCreature->AI()->SetData(1, uiAction);
				pPlayer->CLOSE_GOSSIP_MENU();
                break;
        }
        //pPlayer->PlayerTalkClass->CloseGossip();
        return true;
    }

    struct npc_argent_squireAI : public ScriptedAI
    {
        npc_argent_squireAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_current_pennant = 0;
            check_timer = 1000;
        }

        uint32 m_current_pennant;
        uint32 check_timer;

        void UpdateAI(const uint32 uiDiff)
        {
            // have to delay the check otherwise it wont work
            if (check_timer && (check_timer <= uiDiff))
            {
                me->AddAura(SPELL_CHECK_MOUNT, me);
                if (Aura* tired = me->GetOwner()->GetAura(SPELL_CHECK_TIRED))
                {
                    int32 duration = tired->GetDuration();
                    tired = me->AddAura(SPELL_SQUIRE_TIRED, me);
                    tired->SetDuration(duration);
                }
                check_timer = 0;
            }
            else check_timer -= uiDiff;

            if (me->HasAura(SPELL_SQUIRE_TIRED) && me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_BANKER | UNIT_NPC_FLAG_VENDOR))
            {
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_BANKER | UNIT_NPC_FLAG_VENDOR);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }
        }

        void SetData(uint32 add, uint32 spell)
        {
            if (add)
            {
                me->AddAura(spell, me);
                m_current_pennant = spell;
            }
            else if (m_current_pennant)
            {
                me->RemoveAura(m_current_pennant);
                m_current_pennant = 0;
            }
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_argent_squireAI(creature);
    }
};

const Position movePosition[] =
{
    { 8539.276367f, 624.307678f, 563.883545f, 0.0f },
    { 8607.274414f, 796.302795f, 597.421082f, 0.0f },
    { 8689.521484f, 1071.988525f, 607.254333f, 0.0f },
    { 8759.689453f, 1333.898315f, 514.711304f, 0.0f },
    { 8854.704102f, 1684.304443f, 267.374268f, 0.0f },
    { 8868.194336f, 1900.236206f, 136.044876f, 0.0f },
    { 8893.030273f, 1998.716431f, 88.405754f, 0.0f },
    { 8958.488281f, 2062.763428f, 22.060783f, 0.0f },
    { 8980.103516f, 2068.657227f, 12.500456f, 0.0f },
    { 0.0f, 0.0f, 0.0f, 0.0f }
};
class vehicle_knight_gryphon : public CreatureScript
{
public:
    vehicle_knight_gryphon() : CreatureScript("vehicle_knight_gryphon") { }

    struct vehicle_knight_gryphonAI : VehicleAI
    {
        vehicle_knight_gryphonAI(Creature *c) : VehicleAI(c)
        {
            MovingStarted = false;
            curPoint = 8;
        }

        uint8 curPoint;
        bool MovingStarted;

        void UpdateAI(const uint32 diff)
        {
            if (!MovingStarted) {
                me->GetMotionMaster()->MovePoint(curPoint,movePosition[8]);
                MovingStarted = true;
            } else
                if (me->GetDistance(movePosition[curPoint]) <= 5.0f)
                {
                    curPoint++;
                    if (movePosition[curPoint].GetPositionX() > 8000)
                        me->GetMotionMaster()->MovePoint(curPoint,movePosition[curPoint]);
                    else  {
                        if (me->GetCharmer())
                            if (me->GetCharmer()->ToPlayer())
                            {
                                me->GetCharmer()->ToPlayer()->KilledMonsterCredit(me->GetEntry(),0);
                                me->GetCharmer()->ToPlayer()->ExitVehicle();
                            }
                        me->DespawnOrUnsummon();
                    }
                }
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new vehicle_knight_gryphonAI(creature);
    }
};

#define GIVRE_BOLT			9672
#define GIVRE_JAVELOT		49906
#define LIEN_SOUMISSION		52185
#define NOVA_GIVRE			11831
#define VEINE_GLACIALE		54792

class npc_artuis : public CreatureScript
{
public:
  npc_artuis() : CreatureScript("npc_artuis") { }

  struct npc_artuisAI : public ScriptedAI
  {
  private:
    uint32 m_uibolt, m_uijav, m_uinova, m_uiveine, mui_calivemob;
    bool endphase, firstbucle, bjaloot, bzepiv, npcpop;
    Creature *jaloot, *zepiv;
    SummonList Summons;

  public:
    npc_artuisAI(Creature* pCreature) : ScriptedAI(pCreature), Summons(me)
    {
    }

    void Reset()
    {
      Summons.DespawnAll();
      mui_calivemob = 500;
      m_uibolt = 2000;
      m_uijav = 3000;
      m_uinova = 4000;
      m_uiveine = 20000;
      firstbucle = false;
	  npcpop = false;
      bjaloot = false;
      bzepiv = false;
      SetEndPhase(false);
      //      me->SetReactState(REACT_AGGRESSIVE);
      me->AttackStop();
    }

	void JustReachedHome()
	{
		Summons.DespawnAll();
	}

	void JustSummoned(Creature* summon)
	{
		Summons.Summon(summon);
	}

    void JustDied(Unit* killer)
    {
		if (!killer->ToPlayer())
		return ;


		if (killer->ToPlayer()->GetQuestStatus(12581) == QUEST_STATUS_NONE)
			return ;

		if (bjaloot)
		{
			//std::cout << killer->ToPlayer()->GetReputation(1104) << std::endl;
			//if (killer->ToPlayer()->GetReputation(1104) < 14000)
				killer->ToPlayer()->SetReputation(1104, 14000);
		}
		else if (bzepiv)
		{
			//std::cout << killer->ToPlayer()->GetReputation(1105) << std::endl;
			//if (killer->ToPlayer()->GetReputation(1105) < 14000)
				killer->ToPlayer()->SetReputation(1105, 14000);
		}
/*	Gob Pop manuellement en attendant(fonctionne) car il est inutilisable par les joueurs. SOUCIS SQL	*/
/*
        std::list<GameObject*> ArtuisGob;
        me->GetGameObjectListWithEntryInGrid(ArtuisGob, 190777, 100.0f);
        if (ArtuisGob.empty())
			me->SummonGameObject(190777, 5619.55f, 3776.31f, -94.513f, 2.39f, 0.0f, 0.0f, 0.0f, 0.0f, 180000))//despawn apres 3 minutes apres pop.
*/

		Summons.DespawnAll();
    }


    void DamageTaken(Unit* /*doneBy*/, uint32& damage)
    {
		if (!HealthAbovePct(30))
			SetEndPhase(true);
    }


    void UpdateAI(const uint32 diff)
    {
		if (!UpdateVictim())
			return;

		if (me->HasUnitState(UNIT_STATE_CASTING) && !isEndPhase())
			return;

		if(!npcpop)
		{
            std::list<Creature*> jalootpop;
            GetCreatureListWithEntryInGrid(jalootpop, me, 28667, 100.0f);
			if(jalootpop.empty())
			{
				jaloot = me->SummonCreature(28667, 5616.91f, 3772.67f, -94.5f, 1.78f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 180000);
				jaloot->AddAura(52182, jaloot);
			}
			else
			{
			  if (jaloot)
				if(!jaloot->GetAura(52182))
					jaloot->AddAura(52182, jaloot);
			}

            std::list<Creature*> zepivpop;
            GetCreatureListWithEntryInGrid(zepivpop, me, 28668, 100.0f);
			if(zepivpop.empty())
			{
				zepiv = me->SummonCreature(28668, 5631.62f, 3794.36f, -92.5f, 3.4f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 180000);
				zepiv->AddAura(52182, zepiv);
			}
			else
			{
				if(!zepiv->GetAura(52182))
					zepiv->AddAura(52182, zepiv);
			}
			npcpop = true;
		}

		if (!isEndPhase())
		{
			if (m_uibolt <= diff)
			{
				DoCast(me->getVictim(), GIVRE_BOLT, true);
				m_uibolt = 2000;
			}
			else m_uibolt -= diff;

			if (m_uijav <= diff)
			{
				DoCast(me->getVictim(), GIVRE_JAVELOT, true);
				m_uijav = 3000;
			}
			else m_uijav -= diff;

			if (m_uinova <= diff)
			{
				DoCast(me->getVictim(), NOVA_GIVRE, true);
				m_uinova = 4000;
			}
			else m_uinova -= diff;

			if (m_uiveine <= diff)
			{
				DoCast(me->getVictim(), VEINE_GLACIALE, true);
				m_uiveine = 20000;
			}
			else m_uiveine -= diff;
		}
		else if (!firstbucle)
		{
			firstbucle = true;
			jaloot->RemoveAura(52182);
			zepiv->RemoveAura(52182);
		  //	  me->CastCustomSpell(LIEN_SOUMISSION, SPELLVALUE_MAX_TARGETS, 1, jaloot, true);
		  //  me->CastCustomSpell(LIEN_SOUMISSION, SPELLVALUE_MAX_TARGETS, 1, zepiv, true);
		  //	  DoCast(jaloot, LIEN_SOUMISSION);
			DoCastAOE(LIEN_SOUMISSION);
		}
		else if (firstbucle)
		{
			if (mui_calivemob <= diff)
			{
				if (!jaloot->isAlive())
					bjaloot = true;
				else if (!zepiv->isAlive())
					bzepiv = true;

				mui_calivemob = 500;

				if (bjaloot || bzepiv)
				{
					SetEndPhase(false);
					me->RemoveAurasDueToSpell(LIEN_SOUMISSION);
				}
			}
			else mui_calivemob -= diff;
		}
	}

	void SetEndPhase(bool st)
	{
		endphase = st;
	}

	bool isEndPhase()
	{
		return endphase;
	}
  };

  CreatureAI *GetAI(Creature *creature) const
  {
    return new npc_artuisAI(creature);
  }

};

class npc_risen_ally : public CreatureScript
{
    public:
        npc_risen_ally() : CreatureScript("npc_risen_ally") { }

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_risen_allyAI(pCreature);
        }

        struct npc_risen_allyAI : public ScriptedAI
        {
            npc_risen_allyAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                me->setPowerType(POWER_ENERGY);

	            me->SetUInt32Value(UNIT_FIELD_LEVEL, pCreature->getLevel());
	            me->SetUInt32Value(UNIT_FIELD_RESISTANCES, pCreature->GetUInt32Value(UNIT_FIELD_RESISTANCES));

				//me->SetSheath(SHEATH_STATE_MELEE);
				me->SetByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_ABANDONED);
				me->SetUInt32Value(UNIT_FIELD_BYTES_0, 2048);
				me->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
				me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
				me->SetFloatValue(UNIT_FIELD_COMBATREACH, 1.5f);

				uint32 petlevel = pCreature->getLevel();

				pCreature->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(petlevel - (petlevel / 4)));
			    pCreature->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(petlevel + (petlevel / 4)));

				if (Player* creator = ((Player *)me->GetOwner()))
				{
					creator->RemoveAllAuras();

					me->SetPower(POWER_ENERGY,creator->GetMaxHealth());
					me->SetMaxPower(POWER_ENERGY,creator->GetMaxHealth());

					pCreature->SetMaxHealth(creator->GetMaxHealth());
					pCreature->SetHealth(creator->GetMaxHealth());
					pCreature->setFaction(creator->getFaction());

					me->SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, float(creator->GetArmor()) * 0.15f);
				}
            }

            void EnterCombat(Unit *who)
            {
            }

			void AttackStart(Unit* who)
			{
				if (!who) return;

				if (me->Attack(who, true))
				{
					me->SetInCombatWith(who);
					who->SetInCombatWith(me);
					DoStartMovement(who, 10.0f);
					SetCombatMovement(true);
				}
			}

            void JustDied(Unit* Killer)
            {
				if (Player* creator = ((Player *)me->GetOwner()))
				{
					creator->RemoveAurasDueToSpell(46619);
					creator->RemoveAurasDueToSpell(62218);
				}
            }

            void Reset()
            {
				me->SetSheath(SHEATH_STATE_MELEE);
				me->SetByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_ABANDONED);
				me->SetUInt32Value(UNIT_FIELD_BYTES_0, 2048);
				me->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
				me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
				me->SetFloatValue(UNIT_FIELD_COMBATREACH, 1.5f);

				if (Player* creator = ((Player *)me->GetOwner()))
				{
				   me->SetLevel(creator->getLevel());
				   me->setFaction(creator->getFaction());
				}
            }

            void UpdateAI(const uint32 diff)
            {
				if(!me->isCharmed())
				  me->DespawnOrUnsummon(800);

				if (me->isInCombat())
					DoMeleeAttackIfReady();
            }
        };
};

class npc_brew : public CreatureScript
{
public:
  npc_brew() : CreatureScript("npc_brew") { }

  struct npc_brewAI : public ScriptedAI
  {
    npc_brewAI(Creature* creature) : ScriptedAI(creature)
    {
      me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
      me->SetVisible(false);
    }

    uint32 waves;

    void Reset()
    {
      waves = 0;
    }

    void UpdateAI(const uint32 uiDiff)
    {
      if (waves <= uiDiff)
        {
	  if (me->GetEntry() == 8000002)
            me->SummonCreature(8000001,  me->GetPositionX(),  me->GetPositionY(),  me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 3000000);
          else
            me->SummonCreature(9000001,  me->GetPositionX(),  me->GetPositionY(),  me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 3000000);

          waves = 1800000;
          //      waves = 400000;
        }
      else waves -= uiDiff;
    }
  };

  CreatureAI* GetAI(Creature* creature) const
  {
    return new npc_brewAI(creature);
  }
};

class npc_sum_brew : public CreatureScript
{
public:
  npc_sum_brew() : CreatureScript("npc_sum_brew") { }

  struct npc_sum_brewAI : public ScriptedAI
  {
    npc_sum_brewAI(Creature* creature) : ScriptedAI(creature)
    {
    }

    uint32 move, move2;
    float x[3],y[3],z[3];

    void Reset()
    {
      if (me->GetEntry() == 8000003)
        {
          x[0] = -5159.65;
          y[0] = -630.11;
          z[0] = 397.50;
          x[1] = -5147.03;
          y[1] = -577.77;
          z[1] = 397.27;
          x[2] = -5185.09;
          y[2] = -599.90;
          z[2] = 397.27;
        }
      else
        {
          x[0] = 1184.29;
          y[0] = -4275.24;
          z[0] = 21.19;
          x[1] = 1221.62;
          y[1] = -4297.02;
          z[1] = 21.19;
          x[2] = 1185.37;
          y[2] = -4313.25;
	  z[2] = 21.29;
        }
      int a = rand() % 3;
      me->GetMotionMaster()->MovePoint(42, x[a], y[a], z[a]);
      move = 10000000;
      move2 = 10000000;
    }

    void MovementInform(uint32 type, uint32 id)
    {
      switch(id)
        {
        case 42:
          {
            move = 3000 + rand() % 10000;
            break;
          }
        case 43:
          {
            move2 = 3000 + rand() % 10000;
            break;
          }
        }
    }

    void SpellHit(Unit* caster, SpellInfo const* spell)
    {
      if (caster)
	caster->Kill(me);
    }

    void UpdateAI(const uint32 uiDiff)
    {
      if (move <= uiDiff)
        {
	  float _x, _y, _z;
	  if (me->GetEntry() == 8000003)
	    {
	      _x = -5159.35;
	      _y = -596.81;
	      _z = 398.17;
	    }
	  else
	    {
	      _x = 1199.87;
	      _y = -4298.49;
	      _z =  21.36;
	    }
	  me->GetMotionMaster()->MovePoint(43, _x, _y, _z);
          move = 10000000;
        }
      else move -= uiDiff;
      if (move2 <= uiDiff)
        {
          int a = rand() % 3;
          me->GetMotionMaster()->MovePoint(42, x[a], y[a], z[a]);
          move2 = 10000000;
        }
      else move2 -= uiDiff;
    }
  };

  CreatureAI* GetAI(Creature* creature) const
  {
    return new npc_sum_brewAI(creature);
  }
};

enum Mobs
  {
    NPC_D          = 8000003,
    NPC_H          = 9000003,
    GOB_MOLE_MACHINE                = 194316,
    GOB_MOLE_MACHINE_SUCCESS                = 8000000
  };


class npc_brew_attak_trigger : public CreatureScript
{
public:
  npc_brew_attak_trigger() : CreatureScript("npc_brew_attak_trigger") { }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_brew_attak_triggerAI (pCreature);
  }

  struct npc_brew_attak_triggerAI : public Scripted_NoMovementAI
  {
    npc_brew_attak_triggerAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature), summons(pCreature)
    {
      me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
      me->SetVisible(false);
    }

    GameObject* MoleMachine;
    uint32 SummonTimer, sumCount;
    uint32 SummonEndTimer;
    uint32 SEndTimer, sum;
    std::list<Creature *> summoned;
    uint32 checkSuccess;
    bool succ, end;
    SummonList summons;

    void Reset()
    {
      sumCount = 4;
      succ = false;
      end = false;
      checkSuccess = 10000;
      SEndTimer = 240000;
      MoleMachine = me->SummonGameObject(GOB_MOLE_MACHINE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(),
                                         float(urand(0, 6)), 0, 0, 0, 0, 300000);
      if (MoleMachine)
        MoleMachine->SetGoState(GO_STATE_ACTIVE);
      SummonTimer = 0;
      SummonEndTimer = 900000;
    }

    void JustSummoned(Creature* summon)
    {
      summons.Summon(summon);
      if (sumCount == 1 && (summon->GetEntry() == NPC_D || summon->GetEntry() == NPC_H))
        summoned.push_back(summon);
    }

    bool checkEndEvent()
    {
      if (!summoned.empty())
        {
          for (std::list<Creature *>::iterator it = summoned.begin(); it != summoned.end(); it++)
            {
              if ((*it)->isAlive())
                {
                  return false;
                }
            }
        }
      return true;
    }

    void UpdateAI(const uint32 uiDiff)
    {
      //      if (!UpdateVictim())
      //        return;

      if (SummonEndTimer <= uiDiff)
        {
          SummonEndTimer = 0;
          me->DespawnOrUnsummon();
        }
      else
        SummonEndTimer -= uiDiff;

      if (!end && !succ)
	if (SEndTimer <= uiDiff)
	  {
	    if (checkEndEvent())
	      {
		succ = true;
		printf("omg ces cons de joueurs ont reussis ><\n");
		me->SummonGameObject(GOB_MOLE_MACHINE_SUCCESS, me->GetPositionX() + 10, me->GetPositionY() + 10, me->GetPositionZ(),
				     float(urand(0, 6)), 0, 0, 0, 0, 600000);
	      }
	    else
              printf("fail de l'event!!!!!!!! ><\n");
	    summons.DespawnAll();
	    SEndTimer = 100000;
	    end = true;
	  }
	else
	  SEndTimer -= uiDiff;

      if (!succ && !end)
	if (SummonTimer <= uiDiff)
	  {
	    float x = me->GetPositionX();
	    float y = me->GetPositionY();
	    float z = me->GetPositionZ() + 1;
	    if (sumCount > 0)
	      {
		printf("summon !\n");
		if (me->GetEntry() == 8000001)
		  {
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		  }
		else
		  {
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		  }
	      }
	    sumCount--;
	    SummonTimer = 60000;
	  }
	else SummonTimer -= uiDiff;
    }
  };

};
class npc_brew_attak_trigger2 : public CreatureScript
{
public:
  npc_brew_attak_trigger2() : CreatureScript("npc_brew_attak_trigger2") { }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_brew_attak_trigger2AI (pCreature);
  }

  struct npc_brew_attak_trigger2AI : public Scripted_NoMovementAI
  {
    npc_brew_attak_trigger2AI(Creature* pCreature) : Scripted_NoMovementAI(pCreature), summons(pCreature)
    {
      me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
      me->SetVisible(false);
    }

    GameObject* MoleMachine;
    uint32 SummonTimer, sumCount;
    uint32 SummonEndTimer;
    uint32 SEndTimer, sum;
    std::list<Creature *> summoned;
    uint32 checkSuccess;
    bool succ, end;
    SummonList summons;

    void Reset()
    {
      sumCount = 4;
      succ = false;
      end = false;
      checkSuccess = 10000;
      SEndTimer = 240000;
      MoleMachine = me->SummonGameObject(GOB_MOLE_MACHINE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(),
                                         float(urand(0, 6)), 0, 0, 0, 0, 300000);
      if (MoleMachine)
        MoleMachine->SetGoState(GO_STATE_ACTIVE);
      SummonTimer = 0;
      SummonEndTimer = 900000;
    }
    void JustSummoned(Creature* summon)
    {
      summons.Summon(summon);
      if (sumCount == 1 && (summon->GetEntry() == NPC_D || summon->GetEntry() == NPC_H))
        summoned.push_back(summon);
    }

    bool checkEndEvent()
    {
      if (!summoned.empty())
        {
          for (std::list<Creature *>::iterator it = summoned.begin(); it != summoned.end(); it++)
            {
              if ((*it)->isAlive())
                {
                  return false;
                }
              else
		printf("its dead");
            }
        }
      return true;
    }

    void UpdateAI(const uint32 uiDiff)
    {
      //      if (!UpdateVictim())
      //        return;

      if (SummonEndTimer <= uiDiff)
        {
          SummonEndTimer = 0;
          me->DespawnOrUnsummon();
        }
      else
        SummonEndTimer -= uiDiff;

      if (!end && !succ)
	if (SEndTimer <= uiDiff)
	  {
	    if (checkEndEvent())
	      {
		succ = true;
		printf("omg ces cons de joueurs ont reussis ><\n");
		me->SummonGameObject(GOB_MOLE_MACHINE_SUCCESS, me->GetPositionX() + 10, me->GetPositionY() + 10, me->GetPositionZ(),
				     float(urand(0, 6)), 0, 0, 0, 0, 600000);
	      }
	    else
              printf("fail de l'event!!!!!!!! ><\n");
	    summons.DespawnAll();
	    SEndTimer = 100000;
	    end = true;
	  }
	else
	  SEndTimer -= uiDiff;

      if (!succ && !end)
	if (SummonTimer <= uiDiff)
	  {
	    float x = me->GetPositionX();
	    float y = me->GetPositionY();
	    float z = me->GetPositionZ() + 1;
	    if (sumCount > 0)
	      {
		printf("summon !\n");
		if (me->GetEntry() == 8000001)
		  {
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_D, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		  }
		else
		  {
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		    me->SummonCreature(NPC_H, x, y, z, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000000);
		  }
	      }
	    sumCount--;
	    SummonTimer = 60000;
	  }
	else SummonTimer -= uiDiff;
    }
  };

};

class npc_cervoise : public CreatureScript
{
public:
  npc_cervoise(): CreatureScript("npc_cervoise"){}

  struct npc_cervoiseAI : public ScriptedAI
  {
    npc_cervoiseAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
      pCreature->setFaction(35); //wrong faction in db?
    }

    void Reset()
    {
    }

    void JustDied(Unit* /*killer*/)
    {
      me->Respawn();
    }

    void SpellHit(Unit* caster, SpellInfo const* spell)
    {
      if (caster)
        {
          caster->Kill(me);
          caster->ToPlayer()->KilledMonsterCredit(24108, 1);
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
    }

  };

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_cervoiseAI (pCreature);
  }
};

enum HalloweenData
{
  NPC_STINKY_BOMB_CREDIT = 15415,

  GO_STINKY_BOMB_FLASK   = 180449,
  GO_STINKY_BOMB_CLOUD   = 180450,

  QUEST_CRASHING_WICKERMAN_FESTIVAL = 1658,

  SPELL_PIRATE_COSTUME_MALE           = 24708,
  SPELL_PIRATE_COSTUME_FEMALE         = 24709,
  SPELL_NINJA_COSTUME_MALE            = 24711,
  SPELL_NINJA_COSTUME_FEMALE          = 24710,
  SPELL_LEPER_GNOME_COSTUME_MALE      = 24712,
  SPELL_LEPER_GNOME_COSTUME_FEMALE    = 24713,
  SPELL_GHOST_COSTUME_MALE            = 24735,
  SPELL_GHOST_COSTUME_FEMALE          = 24736,


  SPELL_HALLOWEEN_WAND_PIRATE         = 24717,
  SPELL_HALLOWEEN_WAND_NINJA          = 24718,
  SPELL_HALLOWEEN_WAND_LEPER_GNOME    = 24719,
  SPELL_HALLOWEEN_WAND_RANDOM         = 24720,
  SPELL_HALLOWEEN_WAND_SKELETON       = 24724,
  SPELL_HALLOWEEN_WAND_WISP           = 24733,
  SPELL_HALLOWEEN_WAND_GHOST          = 24737,
  SPELL_HALLOWEEN_WAND_BAT            = 24741,

  SPELL_GRIM_VISAGE                   = 24705,

  // Headless Horseman fire event
  NPC_HEADLESS_FIRE                   = 23537,
  NPC_FIRE_DUMMY                      = 23686,
  NPC_SHADE_HORSEMAN                  = 23543,
  GO_FIRE_EFFIGY                      = 186720,
  GO_LARGE_JACK_O_LANTERN             = 186887,


  SPELL_FIRE_CREATE_NODE              = 42118,
  SPELL_WATER_SPOUT_VISUAL            = 42348,
  SPELL_FIRE_VISUAL_BUFF              = 42074,
  SPELL_FIRE_SIZE_STACK               = 42091,
  SPELL_FIRE_STARTING_SIZE            = 42096,
  SPELL_QUESTS_CREDITS                = 42242,
  SPELL_CREATE_WATER_BUCKET           = 42349,

  SPELL_HORSEMAN_CONFLAGRATION_1      = 42380,
  SPELL_HORSEMAN_CONFLAGRATION_2      = 42869,
  SPELL_HORSEMAN_JACK_O_LANTERN       = 44185,
  SPELL_HORSEMAN_CLEAVE               = 15496,

  SAY_HORSEMAN_SPAWN                  = 1,
  SAY_HORSEMAN_FIRES_OUT              = 2,
  SAY_HORSEMAN_FIRES_FAIL             = 3,
  SAY_HORSEMAN_LAUGHS                 = 4,

  QUEST_LET_THE_FIRES_COME_A          = 12135,
  QUEST_LET_THE_FIRES_COME_H          = 12139,
  QUEST_STOP_FIRES_A                  = 11131,
  QUEST_STOP_FIRES_H                  = 11219,
};

#define FIRE_NODES_PER_AREA  13

const Position FireNodesGoldShire[FIRE_NODES_PER_AREA + 1] =
{
  {-9459.41f, 43.90f, 64.23f, 0.00f},
  {-9472.57f, 41.11f, 64.17f, 0.00f},
  {-9467.22f, 85.86f, 66.20f, 0.00f},
  {-9472.94f, 93.84f, 69.20f, 0.00f},
  {-9462.50f, 103.90f, 68.51f, 0.00f},
  {-9467.84f, 100.69f, 66.12f, 0.00f},
  {-9456.91f, 112.81f, 66.12f, 0.00f},
  {-9478.22f, 41.65f, 69.85f, 0.00f},
  {-9481.30f, 24.87f, 69.08f, 0.00f},
  {-9482.69f, 14.39f, 62.94f, 0.00f},
  {-9471.16f, -6.65f, 70.76f, 0.00f},
  {-9451.26f, 38.83f, 68.02f, 0.00f},
  {-9450.13f, 89.46f, 66.22f, 0.00f},
  {-9464.28f,68.1982f,56.2331f,0.0f}, // Center of Town
};

const Position FireNodesRazorHill[FIRE_NODES_PER_AREA+1] =
{
  {372.70f, -4714.64f, 23.11f, 0.00f},
  {343.11f, -4708.87f, 29.19f, 0.00f},
  {332.06f, -4703.21f, 24.52f, 0.00f},
  {317.20f, -4694.22f, 16.78f, 0.00f},
  {326.30f, -4693.24f, 34.59f, 0.00f},
  {281.18f, -4705.37f, 22.38f, 0.00f},
  {293.32f, -4773.45f, 25.03f, 0.00f},
  {280.17f, -4831.90f, 22.25f, 0.00f},
  {319.04f, -4770.23f, 31.47f, 0.00f},
  {362.50f, -4676.11f, 28.63f, 0.00f},
  {348.71f, -4805.08f, 32.23f, 0.00f},
  {342.88f, -4837.07f, 26.29f, 0.00f},
  {361.80f, -4769.27f, 18.49f, 0.00f},
  {317.837f,-4734.06f,9.76272f,0.0f}, // Center of Town
};

enum HalloweenFireEvents
{
  EVENT_FIRE_NONE,
  EVENT_FIRE_HIT_BY_BUCKET,
  EVENT_FIRE_VISUAL_WATER,
  EVENT_FIRE_GROW_FIRE,
  EVENT_HORSEMAN_CONFLAGRATION,
  EVENT_HORSEMAN_CLEAVE,
  EVENT_HORSEMAN_LAUGHS,
  EVENT_FIRE_FINISH,
  EVENT_FIRE_FAIL,
};

class spell_halloween_wand : public SpellScriptLoader
{
public:
  spell_halloween_wand() : SpellScriptLoader("spell_halloween_wand") {}

  class spell_halloween_wand_SpellScript : public SpellScript
  {
    PrepareSpellScript(spell_halloween_wand_SpellScript)

    bool Validate(SpellInfo const* /*spellEntry*/)
    {
      if (!sSpellMgr->GetSpellInfo(SPELL_PIRATE_COSTUME_MALE))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_PIRATE_COSTUME_FEMALE))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_NINJA_COSTUME_MALE))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_NINJA_COSTUME_FEMALE))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_LEPER_GNOME_COSTUME_MALE))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_LEPER_GNOME_COSTUME_FEMALE))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_GHOST_COSTUME_MALE))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_GHOST_COSTUME_FEMALE))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_PIRATE))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_NINJA))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_LEPER_GNOME))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_RANDOM))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_SKELETON))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_WISP))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_GHOST))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_BAT))
	return false;
      return true;
    }

    void HandleScriptEffect()
    {
      Unit* caster = GetCaster();
      Unit* target = GetHitPlayer();

      if (!caster || !target)
	return;

      uint32 spellId = 0;
      uint8 gender = target->getGender();

      switch (GetSpellInfo()->Id)
      {
      case SPELL_HALLOWEEN_WAND_LEPER_GNOME:
	spellId = gender ? SPELL_LEPER_GNOME_COSTUME_FEMALE : SPELL_LEPER_GNOME_COSTUME_MALE;
	break;
      case SPELL_HALLOWEEN_WAND_PIRATE:
	spellId = gender ? SPELL_PIRATE_COSTUME_FEMALE : SPELL_PIRATE_COSTUME_MALE;
	break;
      case SPELL_HALLOWEEN_WAND_GHOST:
	spellId = gender ? SPELL_GHOST_COSTUME_FEMALE : SPELL_GHOST_COSTUME_MALE;
	break;
      case SPELL_HALLOWEEN_WAND_NINJA:
	spellId = gender ? SPELL_NINJA_COSTUME_FEMALE : SPELL_NINJA_COSTUME_MALE;
	break;
      case SPELL_HALLOWEEN_WAND_RANDOM:
	spellId = RAND(SPELL_HALLOWEEN_WAND_PIRATE, SPELL_HALLOWEEN_WAND_NINJA, SPELL_HALLOWEEN_WAND_LEPER_GNOME, SPELL_HALLOWEEN_WAND_SKELETON, SPELL_HALLOWEEN_WAND_WISP, SPELL_HALLOWEEN_WAND_GHOST, SPELL_HALLOWEEN_WAND_BAT);
	break;
      }
      caster->CastSpell(target, spellId, true);
    }

    void Register()
    {
      AfterHit += SpellHitFn(spell_halloween_wand_SpellScript::HandleScriptEffect);
    }
  };

  SpellScript* GetSpellScript() const
  {
    return new spell_halloween_wand_SpellScript();
  }
};

class spell_toss_stinky_bomb : public SpellScriptLoader
{
public:
  spell_toss_stinky_bomb() : SpellScriptLoader("spell_toss_stinky_bomb") {}

  class spell_toss_stinky_bomb_SpellScript : public SpellScript
  {
    PrepareSpellScript(spell_toss_stinky_bomb_SpellScript)

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
      Unit* caster = GetCaster();

      if (caster && caster->GetTypeId() == TYPEID_PLAYER)
	caster->ToPlayer()->KilledMonsterCredit(NPC_STINKY_BOMB_CREDIT, 0);
    }

    void Register()
    {
      OnEffectHit += SpellEffectFn(spell_toss_stinky_bomb_SpellScript::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SEND_EVENT);
    }
  };

  SpellScript* GetSpellScript() const
  {
    return new spell_toss_stinky_bomb_SpellScript();
  }
};

class spell_clean_stinky_bomb : public SpellScriptLoader
{
public:
  spell_clean_stinky_bomb() : SpellScriptLoader("spell_clean_stinky_bomb") {}

  class spell_clean_stinky_bomb_SpellScript : public SpellScript
  {
    PrepareSpellScript(spell_clean_stinky_bomb_SpellScript)

    SpellCastResult CheckIfNearBomb()
    {
      Unit* caster = GetCaster();

      if(GameObject* stinky = GetClosestGameObjectWithEntry(caster, GO_STINKY_BOMB_CLOUD, 15.0f))
	return SPELL_CAST_OK;
      else
	return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
    }

    void HandleCleanBombEffect(SpellEffIndex effIndex)
    {
      Unit* caster = GetCaster();

      if (GameObject* stinky = GetClosestGameObjectWithEntry(caster, GO_STINKY_BOMB_CLOUD, 15.0f))
	stinky->RemoveFromWorld();
    }

    void Register()
    {
      OnCheckCast += SpellCheckCastFn(spell_clean_stinky_bomb_SpellScript::CheckIfNearBomb);
      OnEffectHit += SpellEffectFn(spell_clean_stinky_bomb_SpellScript::HandleCleanBombEffect, EFFECT_1, SPELL_EFFECT_ACTIVATE_OBJECT);
    }
  };

  SpellScript* GetSpellScript() const
  {
    return new spell_clean_stinky_bomb_SpellScript();
  }
};

class at_wickerman_festival : public AreaTriggerScript
{
public:
  at_wickerman_festival() : AreaTriggerScript("at_wickerman_festival") {}

  bool OnTrigger(Player* player, AreaTriggerEntry const* /*trigger*/)
  {
    player->GroupEventHappens(QUEST_CRASHING_WICKERMAN_FESTIVAL, player);
    return true;
  }
};

#define GOSSIP_WICKERMAN_EMBER "Usar las cenizas como pintura de guerra para la cara" //"Smear the ash on my face like war paint!"

class go_wickerman_ember : public GameObjectScript
{
public:
  go_wickerman_ember() : GameObjectScript("go_wickerman_ember") { }

  bool OnGossipHello(Player* player, GameObject* go)
  {
    if (!player->HasAura(SPELL_GRIM_VISAGE))
      player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_WICKERMAN_EMBER, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
    player->SEND_GOSSIP_MENU(player->GetGossipTextId(go), go->GetGUID());
    return true;
  }

  bool OnGossipSelect(Player* player, GameObject* go, uint32 /*sender*/, uint32 action)
  {
    if (action == GOSSIP_ACTION_INFO_DEF)
      go->CastSpell(player, SPELL_GRIM_VISAGE);

    player->PlayerTalkClass->ClearMenus();
    player->CLOSE_GOSSIP_MENU();
    return true;
  }
};

class item_water_bucket : public ItemScript
{
public:

  item_water_bucket() : ItemScript("item_water_bucket") { }

  bool OnUse(Player* player, Item* item, SpellCastTargets const& targets)
  {
    if (Creature* dummy = player->SummonCreature(NPC_FIRE_DUMMY, targets.GetDst()->GetPositionX(), targets.GetDst()->GetPositionY(), targets.GetDst()->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 500))
    {
      std::list<Creature*> firesList;
      Trinity::AllCreaturesOfEntryInRange checker(dummy, NPC_HEADLESS_FIRE, 3.0f);
      Trinity::CreatureListSearcher<Trinity::AllCreaturesOfEntryInRange> searcher(dummy, firesList, checker);
      player->VisitNearbyObject(3.0f, searcher);

      if (firesList.empty())
      {
	// Just some extra checks...
	Creature* fire = dummy->FindNearestCreature(NPC_HEADLESS_FIRE, 3.0f, true);
	if (fire && fire->isAlive())
	  fire->AI()->SetGUID(player->GetGUID(), EVENT_FIRE_HIT_BY_BUCKET);
	else if (Player* friendPlr = dummy->SelectNearestPlayer(3.0f))
	{
	  if (friendPlr->IsFriendlyTo(player) && friendPlr->isAlive())
	    player->CastSpell(friendPlr, SPELL_CREATE_WATER_BUCKET, true);
	}
	else
	  return false;
      }

      for (std::list<Creature*>::const_iterator i = firesList.begin(); i != firesList.end(); ++i)
	if ((*i) && (*i)->isAlive())
	  (*i)->AI()->SetGUID(player->GetGUID(), EVENT_FIRE_HIT_BY_BUCKET);
    }
    return false;
  }
};

class npc_halloween_fire : public CreatureScript
{
public:
  npc_halloween_fire() : CreatureScript("npc_halloween_fire") { }


  struct npc_halloween_fireAI : public ScriptedAI
  {
    npc_halloween_fireAI(Creature* c) : ScriptedAI(c) {}

    bool fireEffigy;
    bool off;
    EventMap events;
    uint64 _playerGUID;

    void Reset()
    {
      off = false;
      fireEffigy = false;
      _playerGUID = 0;
      events.Reset();
      // Mark the npc if is for handling effigy instead of horseman fires
      if(GameObject* effigy = me->FindNearestGameObject(GO_FIRE_EFFIGY, 0.5f))
	fireEffigy = true;
      me->CastSpell(me, SPELL_FIRE_STARTING_SIZE, true);
      events.ScheduleEvent(EVENT_FIRE_GROW_FIRE, 1000);
    }

    void UpdateAI(const uint32 diff)
    {
      events.Update(diff);

      switch(events.ExecuteEvent())
      {
      case EVENT_FIRE_VISUAL_WATER:
	me->CastSpell(me, SPELL_WATER_SPOUT_VISUAL, true);
	if (fireEffigy)
	{
	  if (GameObject* effigy = me->FindNearestGameObject(GO_FIRE_EFFIGY, 0.5f))
	  {
	    effigy->SetGoState(GO_STATE_READY);
	    if (Player* player = me->GetPlayer(*me, _playerGUID))
	      player->KilledMonsterCredit(me->GetEntry(),0);
	    events.ScheduleEvent(EVENT_FIRE_GROW_FIRE, 22000);
	  }
	} else {
	  if (Aura* fireSize = me->GetAura(SPELL_FIRE_SIZE_STACK))
	  {
	    if (fireSize->GetStackAmount() < 10)
	    {
	      me->RemoveAura(fireSize);
	      me->RemoveAurasDueToSpell(SPELL_FIRE_VISUAL_BUFF);
	      me->DespawnOrUnsummon(1000);
	    } else
	      fireSize->ModStackAmount(-10);
	  }
	}
	break;
      case EVENT_FIRE_GROW_FIRE:
	if (fireEffigy)
	{
	  if (GameObject* effigy = me->FindNearestGameObject(GO_FIRE_EFFIGY, 0.5f))
	    effigy->SetGoState(GO_STATE_ACTIVE);
	} else {
	  if (off) break; // This fire have been extinguished

	  if (Aura* fireSize = me->GetAura(SPELL_FIRE_SIZE_STACK)) // This fire have maxium size
	    if(fireSize->GetStackAmount() == 255) break;

	  if (!me->HasAura(SPELL_FIRE_STARTING_SIZE))
	    me->CastSpell(me, SPELL_FIRE_STARTING_SIZE, true);
	  if (!me->HasAura(SPELL_FIRE_VISUAL_BUFF))
	    me->CastSpell(me, SPELL_FIRE_VISUAL_BUFF, true);
	  me->CastSpell(me, SPELL_FIRE_SIZE_STACK, true);
	  events.ScheduleEvent(EVENT_FIRE_GROW_FIRE, urand(1000,2500));
	}
	break;
      }
    }

    void SetGUID(uint64 guid, int32 id)
    {
      if (off) return;

      if (id == EVENT_FIRE_HIT_BY_BUCKET)
      {
	_playerGUID = guid;
	if (fireEffigy)
	{
	  if (GameObject* effigy = me->FindNearestGameObject(GO_FIRE_EFFIGY, 0.5f))
	    if (effigy->GetGoState() == GO_STATE_ACTIVE)
	      events.ScheduleEvent(EVENT_FIRE_VISUAL_WATER, 1000);
	} else
	{
	  if (Creature* horseman = me->GetCreature(*me, me->GetCreatorGUID()))
	    horseman->AI()->SetGUID(_playerGUID, EVENT_FIRE_HIT_BY_BUCKET);
	  events.ScheduleEvent(EVENT_FIRE_VISUAL_WATER, 1000);
	}
      }
    }
  };

  CreatureAI* GetAI(Creature* creature) const
  {
    return new npc_halloween_fireAI(creature);
  }
};

/* This should be fixed ASAP, as far as I know, HHman should appear flying on villages and
start casting SPELL_FIRE_CREATE_NODE on their buildings, maybe also son zone warning, also need
to fix the quests, there are 2 aviable now, when only one should be depending if the village is
alreade setted on fire or nor.
*/
class npc_shade_horseman : public CreatureScript
{
public:
  npc_shade_horseman() : CreatureScript("npc_shade_horseman") { }


  struct npc_shade_horsemanAI : public ScriptedAI
  {
    npc_shade_horsemanAI(Creature* c) : ScriptedAI(c), fires(c) {}

    SummonList fires;
    EventMap events;
    bool moving;
    bool pointReached;
    bool allFiresSet;
    bool firesOut;
    uint32 wpCount;
    std::list<uint64> _playerList;

    void Reset()
    {
      moving = true;
      pointReached = true;
      allFiresSet = false;
      firesOut = false;
      wpCount = 0;
      _playerList.clear();
      events.Reset();

      me->Mount(25159);
      me->SetReactState(REACT_PASSIVE);
      me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
      me->AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT | MOVEMENTFLAG_LEVITATING);

      events.ScheduleEvent(EVENT_HORSEMAN_LAUGHS, urand(5000, 10000));
      events.ScheduleEvent(EVENT_HORSEMAN_CONFLAGRATION, urand(7000, 14000));
      events.ScheduleEvent(EVENT_FIRE_FAIL, 600000);
    }

    void JustSummoned(Creature* summon)
    {
      if (!summon)
	return;

      summon->SetCreatorGUID(me->GetGUID());
      fires.Summon(summon);
    }

    void SummonedCreatureDespawn(Creature* summon)
    {
      if (!summon)
	return;

      fires.Despawn(summon);
    }

    void JustDied(Unit* killer)
    {
      if (killer && killer->GetAreaId() == me->GetAreaId())
	killer->SummonGameObject(GO_LARGE_JACK_O_LANTERN, me->GetPositionX(), me->GetPositionY(), killer->GetPositionZ()+1.0f, me->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 180000);
    }
    void MovementInform(uint32 type, uint32 id)
    {
      if (type != POINT_MOTION_TYPE)
	return;

      if (moving && id < FIRE_NODES_PER_AREA)
      {
	if (id == 0 && !allFiresSet)
	{
	  sLog->outBasic("HEADLESS HORSEMAN BUG TRACKING Area %u.", me->GetAreaId());
	  Talk(SAY_HORSEMAN_SPAWN);
	}

	if (!allFiresSet)
	{
	  const Position pos = GetPositionsForArea()[wpCount];
	  if (pos.IsPositionValid())
	    me->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_FIRE_CREATE_NODE, true);
	}

	if (id+1 == FIRE_NODES_PER_AREA)
	{
	  allFiresSet = true;
	  wpCount = 0;
	}
	else
	  ++wpCount;

	pointReached = true;
      }
      else if (id == FIRE_NODES_PER_AREA && firesOut)
      {
	me->ExitVehicle();
	me->SetReactState(REACT_AGGRESSIVE);
	me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
	me->RemoveUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT | MOVEMENTFLAG_LEVITATING);
	events.ScheduleEvent(EVENT_HORSEMAN_CLEAVE, urand(5000, 10000));
      }
    }

    void UpdateAI(const uint32 diff)
    {
      events.Update(diff);


      if (!firesOut)
      {
	const Position pos = GetPositionsForArea()[wpCount];

	if (!pos.IsPositionValid())
	  return;

	if (pointReached)
	{
	  pointReached = false;
	  me->GetMotionMaster()->MovePoint(wpCount, pos.GetPositionX(), pos.GetPositionY(), GetZForArea());
	}

	if (allFiresSet && fires.size() <= (uint32)(FIRE_NODES_PER_AREA*0.3f) && wpCount != FIRE_NODES_PER_AREA+1)
	{
	  Talk(SAY_HORSEMAN_FIRES_OUT);
	  wpCount = FIRE_NODES_PER_AREA;
	  me->GetMotionMaster()->MoveIdle();
	  me->GetMotionMaster()->MovePoint(FIRE_NODES_PER_AREA, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ());
	  fires.DespawnAll();
	  firesOut = true;
	  // Credit quest to players
	  if (!_playerList.empty())
	    for (std::list<uint64>::const_iterator i = _playerList.begin();i != _playerList.end(); ++i)
	      if (Player* player = me->GetPlayer(*me, *i))
		player->CastSpell(player, SPELL_QUESTS_CREDITS, true);
	  me->DespawnOrUnsummon(10000);
	  return;
	}

	switch(events.ExecuteEvent())
	{
	case EVENT_FIRE_FAIL:
	  fires.DespawnAll();
	  Talk(SAY_HORSEMAN_FIRES_FAIL);
	  wpCount = FIRE_NODES_PER_AREA+1;
	  me->GetMotionMaster()->MovePoint(wpCount, pos.GetPositionX(), pos.GetPositionY(), GetZForArea());
	  if (!_playerList.empty())
	  {
	    for (std::list<uint64>::const_iterator i = _playerList.begin();i != _playerList.end(); ++i)
	    {
	      Player* player = me->GetPlayer(*me, *i);
	      if (player)
	      {
		uint32 questId = player->GetTeam() == ALLIANCE ? QUEST_LET_THE_FIRES_COME_A : QUEST_LET_THE_FIRES_COME_H;
		if (player->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE)
		  player->FailQuest(questId);
	      }
	    }
	  }
	  me->DespawnOrUnsummon(10000);
	  break;
	case EVENT_HORSEMAN_CONFLAGRATION:
	  if (!_playerList.empty())
	  {
	    for (std::list<uint64>::const_iterator i = _playerList.begin();i != _playerList.end(); ++i)
	    {
	      Player* player = me->GetPlayer(*me, *i);
	      if (player && player->GetDistance(me) <= 30.0f)
	      {
		me->CastSpell(player, RAND(SPELL_HORSEMAN_CONFLAGRATION_1, SPELL_HORSEMAN_CONFLAGRATION_2, SPELL_HORSEMAN_JACK_O_LANTERN), true);
		break;
	      }
	    }
	  }
	  events.ScheduleEvent(EVENT_HORSEMAN_CONFLAGRATION, urand(5000, 10000));
	  break;
	case EVENT_HORSEMAN_LAUGHS:
	  Talk(SAY_HORSEMAN_LAUGHS);
	  events.ScheduleEvent(EVENT_HORSEMAN_LAUGHS, urand(10000, 25000));
	  break;
	}
      } else {
	switch(events.ExecuteEvent())
	{
	case EVENT_HORSEMAN_CLEAVE:
	  if (Unit* victim = me->getVictim())
	    me->CastSpell(victim, SPELL_HORSEMAN_CLEAVE, true);
	  events.ScheduleEvent(EVENT_HORSEMAN_CLEAVE, urand(5000, 10000));
	  return;
	case EVENT_HORSEMAN_CONFLAGRATION:
	  if (!_playerList.empty())
	  {
	    for (std::list<uint64>::const_iterator i = _playerList.begin();i != _playerList.end(); ++i)
	    {
	      Player* player = me->GetPlayer(*me, *i);
	      if (player && player->GetAreaId() == me->GetAreaId() && player->GetDistance(me) <= 30.0f)
	      {
		me->CastSpell(player, RAND(SPELL_HORSEMAN_CONFLAGRATION_1, SPELL_HORSEMAN_CONFLAGRATION_2, SPELL_HORSEMAN_JACK_O_LANTERN), true);
		break;
	      }
	    }
	  }
	  events.ScheduleEvent(EVENT_HORSEMAN_CONFLAGRATION, urand(5000, 10000));
	  break;
	}
	DoMeleeAttackIfReady();
      }
    }

    const Position* GetPositionsForArea()
    {
      switch (me->GetAreaId())
      {
      case 87: //GoldShire
	return FireNodesGoldShire;
      case 362: // Razor Hill
      case 2337:
      case 14:
	return FireNodesRazorHill;
      }
      return NULL;
    }

    float GetZForArea()
    {
      switch (me->GetAreaId())
      {
      case 87: //GoldShire
	return 77.6f;
      case 362: // Razor Hill
      case 2337:
      case 14:
	return 40.0f;
      }
      return 0.0f;
    }

    void SetGUID(uint64 guid, int32 id)
    {
      if (id == EVENT_FIRE_HIT_BY_BUCKET)
      {
	_playerList.push_back(guid);
	_playerList.unique();
      }

    }
  };

  CreatureAI* GetAI(Creature* creature) const
  {
    return new npc_shade_horsemanAI(creature);
  }
};

class npc_halloween_orphan_matron : public CreatureScript
{
public:
  npc_halloween_orphan_matron() : CreatureScript("npc_halloween_orphan_matron") { }

  uint64 _headlessHoresemanGUID;

  bool OnGossipHello(Player* player, Creature* me)
  {
      player->PrepareQuestMenu(me->GetGUID());
      if (Creature* horseman = me->GetCreature(*me, _headlessHoresemanGUID))
      {
          QuestMenu &qm = player->PlayerTalkClass->GetQuestMenu();
          QuestMenu qm2;

          uint32 quest1 = player->GetTeam() == ALLIANCE ? QUEST_LET_THE_FIRES_COME_A : QUEST_LET_THE_FIRES_COME_H;
          uint32 quest2 = player->GetTeam() == ALLIANCE ? QUEST_STOP_FIRES_A : QUEST_STOP_FIRES_H;

          // Copy current quest menu ignoring some quests
          for (uint32 i = 0; i<qm.GetMenuItemCount(); ++i)
          {
              if (qm.GetItem(i).QuestId == quest1 || qm.GetItem(i).QuestId == quest2)
                  continue;

              qm2.AddMenuItem(qm.GetItem(i).QuestId, qm.GetItem(i).QuestIcon);
          }

          if (player->GetQuestStatus(quest1) == QUEST_STATUS_NONE)
          {
              if (player->GetQuestStatus(quest2) == QUEST_STATUS_NONE)
                  qm2.AddMenuItem(quest2, 2);
              else if (player->GetQuestStatus(quest2) != QUEST_STATUS_REWARDED)
                  qm2.AddMenuItem(quest2, 4);
          }
          else
              if (player->GetQuestStatus(quest1) != QUEST_STATUS_REWARDED)
                  qm2.AddMenuItem(quest1, 4);

          qm.ClearMenu();

          for (uint32 i = 0; i<qm2.GetMenuItemCount(); ++i)
              qm.AddMenuItem(qm2.GetItem(i).QuestId, qm2.GetItem(i).QuestIcon);
      }

      player->SEND_GOSSIP_MENU(player->GetGossipTextId(me), me->GetGUID());
      return true;
  }

    bool OnQuestAccept(Player* player, Creature* me, Quest const* quest)
    {
        if (!(me->GetAreaId() == 87 || me->GetAreaId() == 362))
        {
            return true;
        }

        if (quest->GetQuestId() == QUEST_LET_THE_FIRES_COME_A || quest->GetQuestId() == QUEST_LET_THE_FIRES_COME_H)
        {
            Creature* horseman = me->FindNearestCreature(NPC_SHADE_HORSEMAN, 100);
            //me->GetCreature(*me, _headlessHoresemanGUID);

            if (!horseman)
            {
                sLog->outBasic("HEADLESS HORSEMAN BUG TRACKING. SUMMON: GUID Player: %u. Area %u.", player->GetGUID(), player->GetAreaId());
                if (Creature* newHorseman = player->SummonCreature(NPC_SHADE_HORSEMAN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 20.0f, 0, TEMPSUMMON_DEAD_DESPAWN, 180000))
                    _headlessHoresemanGUID = newHorseman->GetGUID();
            }
        }
        return true;
    }
};


class npc_raise_ally : public CreatureScript
{
public:
    npc_raise_ally() : CreatureScript("npc_raise_ally") { }

    struct npc_raise_ally_AI : public ScriptedAI
    {
      npc_raise_ally_AI(Creature* c) : ScriptedAI(c) { Reset(); }

        void Reset()
        {
            if (me->ToTempSummon())
                if (me->ToTempSummon()->GetSummoner())
                {
                    int health = me->ToTempSummon()->GetSummoner()->GetMaxHealth() * 60 / 100;
                    int mana = me->ToTempSummon()->GetSummoner()->GetMaxPower(POWER_MANA) * 20 / 100;
                    if (mana <= 0)
                        mana = 10000;
                    me->SetMaxHealth(me->ToTempSummon()->GetSummoner()->GetMaxHealth());
                    me->SetHealth(me->ToTempSummon()->GetSummoner()->GetMaxHealth());
                    me->SetMaxPower(POWER_ENERGY, mana);
                    me->SetPower(POWER_ENERGY, mana);
                    //	      me->SetEnergy(100);
                }
        }

        void JustDied(Unit* /*who*/)
        {
            if (me->ToTempSummon())
                if (me->ToTempSummon()->GetSummoner())
                    me->ToTempSummon()->GetSummoner()->Kill(me->ToTempSummon()->GetSummoner());
        }

        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(uint32 const diff)
        {
        }

        void ReceiveEmote(Player* player, uint32 emote)
        {
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_raise_ally_AI(creature);
    }
};

/*###########################################
     ### QUEST The Exorcism of Colonel Jules ###
     ###########################################*/
#define GOSSIP_ITEM_1 "Je suis pret, Anchorite. Commencons l'exorcism"

#define SAY_BARADA1            -1900100
#define SAY_BARADA2            -1900101
#define SAY_BARADA3            -1900104
#define SAY_BARADA4            -1900105
#define SAY_BARADA5            -1900106
#define SAY_BARADA6            -1900107
#define SAY_BARADA7            -1900108
#define SAY_BARADA8            -1900109
#define SAY_COLONEL1           -1900110
#define SAY_COLONEL2           -1900111
#define SAY_COLONEL3           -1900112
#define SAY_COLONEL4           -1900113
#define SAY_COLONEL5           -1900114
#define SAY_COLONEL6           -1900115
#define SAY_COLONEL7           -1900116
#define SAY_COLONEL8           -1900117

enum
{
  QUEST_THE_EXORCIM          = 10935,
  NPC_COLONEL_JULES          = 22432,
  NPC_DARKNESS_RELEASED      = 22507,

  SPELL_EXORCIM              = 39277,
  SPELL_EXORCIM2             = 39278,
  SPELL_COLONEL1             = 39283,
  SPELL_COLONEL2             = 39294,
  SPELL_COLONEL3             = 39284,
  SPELL_COLONEL4             = 39294,
  SPELL_COLONEL5             = 39295,
  SPELL_COLONEL7             = 39381,
    SPELL_COLONEL8             = 39380
};


class npc_anchorite_barada : public CreatureScript
{
public:
  npc_anchorite_barada() : CreatureScript("npc_anchorite_barada") { }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_anchorite_baradaAI (pCreature);
  }

  struct npc_anchorite_baradaAI : public ScriptedAI
  {
    npc_anchorite_baradaAI(Creature* pCreature) : ScriptedAI(pCreature) {}

    bool Exorcim;

    uint64 uiPlayerGUID;
    uint32 uiStepsTimer;
    uint32 uiSteps;

    float colonel;

    void Reset()
    {
      Exorcim = false;
      uiStepsTimer = 0;
      uiSteps = 0;
      uiPlayerGUID = 0;
    }

    void AttackedBy(Unit* pWho) {}
    void AttackStart(Unit* pWho) {}

    void DoSpawnDarkness()
    {
      me->SummonCreature(NPC_DARKNESS_RELEASED, -710.924, 2754.683, 105.0, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 20000);
    }

    void MoveInLineOfSight(Unit *pWho)
    {
      if (pWho->GetTypeId() == TYPEID_PLAYER)
      {
	if (CAST_PLR(pWho)->GetQuestStatus(QUEST_THE_EXORCIM) == QUEST_STATUS_INCOMPLETE)
	{
	  if (me->IsWithinDistInMap(((Player *)pWho), 5))
	  {
	    uiPlayerGUID = pWho->GetGUID();
	  }
	}
      }
    }

    uint32 NextStep(uint32 uiSteps)
    {
      Creature* pColonel = me->FindNearestCreature(NPC_COLONEL_JULES, 15);
      colonel = me->GetAngle(pColonel->GetPositionX(), pColonel->GetPositionY());

      switch(uiSteps)
      {
      case 1:me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
	pColonel->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
	me->SetStandState(UNIT_STAND_STATE_STAND);return 2000;
      case 2:DoScriptText(SAY_BARADA1, me,0);return 5000;
      case 3:DoScriptText(SAY_BARADA2, me,0);return 3000;
      case 4:DoScriptText(SAY_COLONEL1, pColonel, 0);return 3000;
      case 5:me->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);return 3000;
      case 6:me->GetMotionMaster()->MovePoint(0, -707.702f, 2749.038f, 101.590f);return 2000;
      case 7:me->GetMotionMaster()->MovePoint(0, -710.810f, 2748.376f, 101.590f);return 2100;
      case 8:me->SetOrientation(colonel);
	me->SendMovementFlagUpdate();return 2000;
      case 9:me->CastSpell(me, SPELL_EXORCIM , false);return 10000;
      case 10:DoScriptText(SAY_BARADA3, me,0); return 10000;
      case 11:DoScriptText(SAY_COLONEL2, pColonel, 0);return 8000;
      case 12:me->RemoveAllAuras();
      case 13:me->CastSpell(me, SPELL_EXORCIM2 , false);
      case 14:pColonel->CastSpell(pColonel, SPELL_COLONEL1, false);
      case 15:pColonel->SetUnitMovementFlags(MOVEMENTFLAG_LEVITATING);
	pColonel->SetSpeed(MOVE_RUN, 0.17f);
	pColonel->GetMotionMaster()->MovePoint(0, -710.611f, 2753.435f, 103.774f);
	pColonel->CastSpell(pColonel, SPELL_COLONEL3, false);return 14000;
      case 16:DoScriptText(SAY_COLONEL3, pColonel, 0);
	DoSpawnDarkness();
	DoSpawnDarkness();return 14000;
      case 17:DoScriptText(SAY_BARADA4, me, 0);
	DoSpawnDarkness();
	DoSpawnDarkness();return 14000;
      case 18:DoScriptText(SAY_COLONEL4, pColonel, 0);
	DoSpawnDarkness();return 14000;
      case 19:DoScriptText(SAY_BARADA5, me, 0); return 14000;
      case 20:pColonel->CastSpell(pColonel, SPELL_COLONEL4, false);
	pColonel->CastSpell(pColonel, SPELL_COLONEL2, false);
	DoSpawnDarkness();return 1500;
      case 21:pColonel->GetMotionMaster()->MovePoint(0, -713.406f, 2744.240f, 103.774f);return 5000;
      case 22:DoScriptText(SAY_COLONEL5, pColonel, 0);return 1000;
      case 23:pColonel->GetMotionMaster()->MovePoint(0, -707.784f, 2749.562f, 103.774f);
	DoSpawnDarkness();return 4000;
      case 24:pColonel->GetMotionMaster()->MovePoint(0, -708.558f, 2744.923f, 103.774f);
	pColonel->CastSpell(me,SPELL_COLONEL5, false);return 2500;
      case 25:DoScriptText(SAY_BARADA6, me, 0);
      case 26:pColonel->GetMotionMaster()->MovePoint(0, -713.406f, 2744.240f, 103.774f);
	DoSpawnDarkness();return 3500;
      case 27:pColonel->GetMotionMaster()->MovePoint(0, -714.212f, 2750.606f, 103.774f);return 4000;
      case 28:pColonel->GetMotionMaster()->MovePoint(0, -707.784f, 2749.562f, 103.774f);
	DoScriptText(SAY_COLONEL6, pColonel, 0);
	DoSpawnDarkness();return 4000;
      case 29:pColonel->GetMotionMaster()->MovePoint(0, -714.212f, 2750.606f, 103.774f);return 4000;
      case 30:pColonel->GetMotionMaster()->MovePoint(0, -707.784f, 2749.562f, 103.774f);return 4000;
      case 31: DoScriptText(SAY_BARADA7, me, 0); return 0;
      case 32:pColonel->GetMotionMaster()->MovePoint(0, -708.558f, 2744.923f, 103.774f);
	DoSpawnDarkness();return 4000;
      case 33:pColonel->GetMotionMaster()->MovePoint(0, -713.406f, 2744.240f, 103.774f);return 4000;
      case 34:pColonel->GetMotionMaster()->MovePoint(0, -714.212f, 2750.606f, 103.774f);
	DoScriptText(SAY_COLONEL7, pColonel, 0);
	DoSpawnDarkness();return 4000;
      case 35:pColonel->GetMotionMaster()->MovePoint(0, -713.406f, 2744.240f, 103.774f);return 4000;
      case 36:pColonel->GetMotionMaster()->MovePoint(0, -714.212f, 2750.606f, 103.774f);
	DoSpawnDarkness();return 4000;
      case 37:DoScriptText(SAY_BARADA6, me, 0);
      case 38:pColonel->GetMotionMaster()->MovePoint(0, -707.784f, 2749.562f, 103.774f);return 4000;
      case 39:pColonel->GetMotionMaster()->MovePoint(0, -708.558f, 2744.923f, 103.774f);return 4000;
      case 40:pColonel->GetMotionMaster()->MovePoint(0, -713.406f, 2744.240f, 103.774f);
	DoScriptText(SAY_COLONEL8, pColonel, 0);return 4000;
      case 41:pColonel->GetMotionMaster()->MovePoint(0, -714.212f, 2750.606f, 103.774f);return 4000;
      case 42:pColonel->GetMotionMaster()->MovePoint(0, -707.784f, 2749.562f, 103.774f);return 4000;
      case 43:DoScriptText(SAY_BARADA6, me, 0); return 1000;
      case 44:pColonel->GetMotionMaster()->MovePoint(0, -708.558f, 2744.923f, 103.774f);return 4000;
      case 45:pColonel->GetMotionMaster()->MovePoint(0, -713.406f, 2744.240f, 103.774f);
	pColonel->CastSpell(pColonel, SPELL_COLONEL8, false);return 4000;
      case 46:pColonel->GetMotionMaster()->MovePoint(0, -714.212f, 2750.606f, 103.774f);
	pColonel->CastSpell(pColonel, SPELL_COLONEL7, false);return 4000;
      case 47:pColonel->GetMotionMaster()->MovePoint(0, -710.792f, 2750.693f, 103.774f);return 5000;
      case 48:DoScriptText(SAY_BARADA8, me, 0); return 1000;
      case 49:pColonel->GetMotionMaster()->MovePoint(0, -710.111f, 2754.346f, 102.367f);return 3000;
      case 50:pColonel->RemoveAllAuras();
      case 51:me->RemoveAllAuras();return 2000;
      case 52:me->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);return 2000;
      case 53:me->GetMotionMaster()->MovePoint(0, -706.726f, 2751.632f, 101.591f);return 2200;
      case 54:me->GetMotionMaster()->MovePoint(0, -707.382f, 2753.994f, 101.591f);return 7000;
      case 55:me->SetStandState(UNIT_STAND_STATE_KNEEL);
	me->CombatStop();return 3000;
      case 56:pColonel->SetFlag(UNIT_NPC_FLAGS, 1);return 6000;
      case 57:me->SetFlag(UNIT_NPC_FLAGS, 1);
	if (Player* pPlayer = Unit::GetPlayer(*me, uiPlayerGUID))
	  pPlayer->AreaExploredOrEventHappens(QUEST_THE_EXORCIM);return 1000;
      case 58:Reset();
      default: return 0;
      }
    }

    void JustDied(Unit* pWho)
    {
      if (Creature* pColonel = me->FindNearestCreature(NPC_COLONEL_JULES, 15.0f, true))
      {
	pColonel->GetMotionMaster()->MovePoint(0, -710.111f, 2754.346f, 102.367f);
	pColonel->RemoveAllAuras();
      }
    }

    void UpdateAI(const uint32 uiDiff)
    {
      if (uiStepsTimer <= uiDiff)
      {
	if (Exorcim)
	  uiStepsTimer = NextStep(++uiSteps);
      }
      else uiStepsTimer -= uiDiff;
    }
  };

  bool OnGossipHello(Player* pPlayer, Creature* pCreature)
  {
    if (pPlayer->GetQuestStatus(QUEST_THE_EXORCIM) == QUEST_STATUS_INCOMPLETE)
      pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
    pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
    return true;
  }

  bool OnGossipSelect(Player* pPlayer, Creature* pCreature,  uint32 /*uiSender*/, uint32 uiAction)
  {
    if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
    {
      ((npc_anchorite_baradaAI*)pCreature->AI())->Exorcim = true;
      pPlayer->CLOSE_GOSSIP_MENU();
    }
    return true;
  }
};


/*######
## npc_darkness_released
######*/

enum
{
  SPELL_AURA_ME     = 39303,
  SPELL_DARKNESS    = 39307,
    NPC_BARADA        = 22431
};

class npc_darkness_released : public CreatureScript
{
public:
  npc_darkness_released() : CreatureScript("npc_darkness_released") { }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_darkness_releasedAI (pCreature);
  }

  struct npc_darkness_releasedAI : public ScriptedAI
  {
    npc_darkness_releasedAI(Creature* pCreature) : ScriptedAI(pCreature) {}

    uint32 uiAtTimer;
    uint32 uiChTimer;

    void Reset()
    {
      uiChTimer = 5000;
      uiAtTimer = 10000;
      DoCast(SPELL_AURA_ME);
      me->SetUnitMovementFlags(MOVEMENTFLAG_LEVITATING);
      me->SetSpeed(MOVE_RUN, 0.10f);
      switch(urand(0,3))
      {
      case 0: me->GetMotionMaster()->MovePoint(0, -714.212f, 2750.606f, 105.0f); break;
      case 1: me->GetMotionMaster()->MovePoint(0, -713.406f, 2744.240f, 105.0f); break;
      case 2: me->GetMotionMaster()->MovePoint(0, -707.784f, 2749.562f, 105.0f); break;
      case 3: me->GetMotionMaster()->MovePoint(0, -708.558f, 2744.923f, 105.0f); break;
      }
    }

    void AttackedBy(Unit* pWho) {}
    void AttackStart(Unit* pWho) {}

    void JustDied(Unit* pWho)
    {
      me->RemoveCorpse();
    }

    void UpdateAI(const uint32 uiDiff)
    {
      if (uiAtTimer <= uiDiff)
      {
	DoCast(SPELL_DARKNESS);
	switch (urand(0,3))
	{
	case 0: me->GetMotionMaster()->MovePoint(0, -714.212f, 2750.606f, 105.0f); break;
	case 1: me->GetMotionMaster()->MovePoint(0, -713.406f, 2744.240f, 105.0f); break;
	case 2: me->GetMotionMaster()->MovePoint(0, -707.784f, 2749.562f, 105.0f); break;
	case 3: me->GetMotionMaster()->MovePoint(0, -708.558f, 2744.923f, 105.0f); break;
	}

	uiAtTimer = 10000;
      }
      else uiAtTimer -= uiDiff;

      if (uiChTimer <= uiDiff)
      {
	if (Creature* pBar = me->FindNearestCreature(NPC_BARADA, 15.0f, false))
	  me->setDeathState(CORPSE);

	if (Creature* pBara = me->FindNearestCreature(NPC_BARADA, 15.0f, true))
	{
	  if (!pBara->HasAura(SPELL_EXORCIM2, 0))
	    me->setDeathState(CORPSE);
	}

	uiChTimer = 5000;
      }
      else uiChTimer -= uiDiff;
    }
  };
};


class npc_foul_purge : public CreatureScript
{
public:
  npc_foul_purge() : CreatureScript("npc_foul_purge") { }

  CreatureAI* GetAI_npc_foul_purge(Creature* pCreature)
  {
    return new npc_foul_purgeAI(pCreature);
  }

  struct npc_foul_purgeAI : public ScriptedAI
  {
    npc_foul_purgeAI(Creature* pCreature) : ScriptedAI(pCreature) {}

    uint32 uiChTimer;

    void Reset()
    {
      if (Creature* pBara = me->FindNearestCreature(NPC_BARADA, 15.0f, true))
      {
	AttackStart(pBara);
      }
      uiChTimer = 4000;
    }

    void JustDied(Unit* pWho)
    {
      me->RemoveCorpse();
    }

    void UpdateAI(const uint32 uiDiff)
    {
      if (uiChTimer <= uiDiff)
      {
	if (Creature* pBar = me->FindNearestCreature(NPC_BARADA, 15.0f, false))
	  me->setDeathState(CORPSE);

	if (Creature* pBara = me->FindNearestCreature(NPC_BARADA, 15.0f, true))
	{
	  if (!pBara->HasAura(SPELL_EXORCIM2, 0))
	    me->setDeathState(CORPSE);
	}

	uiChTimer = 4000;
      }
      else uiChTimer -= uiDiff;

      DoMeleeAttackIfReady();
    }
  };
};


/*######
## npc_mana_bomb
## http://www.wowhead.com/quest=10446 The Final Code (Alliance)
## http://www.wowhead.com/quest=10447 The Final Code (Horde)
######*/

enum eManaBomb
{
  SAY_COUNT_1                 = -1000472,
  SAY_COUNT_2                 = -1000473,
  SAY_COUNT_3                 = -1000474,
  SAY_COUNT_4                 = -1000475,
  SAY_COUNT_5                 = -1000476,
  SPELL_MANA_BOMB_LIGHTNING   = 37843,
  SPELL_MANA_BOMB_EXPL        = 35513,
  NPC_MANA_BOMB_EXPL_TRIGGER  = 20767,
    NPC_MANA_BOMB_KILL_TRIGGER  = 21039
};

class npc_mana_bomb : public CreatureScript
{
public:
  npc_mana_bomb() : CreatureScript("npc_mana_bomb") { }

  bool OnGossipHello(Player* pPlayer, GameObject* pGo)
  {
    if (Creature* pCreature = GetClosestCreatureWithEntry(pGo, NPC_MANA_BOMB_EXPL_TRIGGER, INTERACTION_DISTANCE))
    {
      if (npc_mana_bombAI* pBombAI = dynamic_cast<npc_mana_bombAI*>(pCreature->AI()))
	pBombAI->DoTrigger(pPlayer, pGo);
    }

    return true;
  }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_mana_bombAI (pCreature);
  }

  struct npc_mana_bombAI : public ScriptedAI
  {
    npc_mana_bombAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
      Reset();
    }

    GameObject* pManaBomb;

    bool m_bIsActivated;
    uint32 m_uiEventTimer;
    uint32 m_uiEventCounter;

    void Reset()
    {
      pManaBomb = NULL;
      m_bIsActivated = false;
      m_uiEventTimer = 1000;
      m_uiEventCounter = 0;
    }

    void DoTrigger(Player* pPlayer, GameObject* pGo)
    {
      if (m_bIsActivated)
	return;
      m_bIsActivated = true;
      pPlayer->KilledMonsterCredit(NPC_MANA_BOMB_KILL_TRIGGER,me->GetGUID());
      pManaBomb = pGo;
    }

    void UpdateAI(const uint32 uiDiff)
    {
      if (!m_bIsActivated)
	return;

      if (m_uiEventTimer < uiDiff)
      {
	m_uiEventTimer = 1000;

	if (m_uiEventCounter < 10)
	  me->CastSpell(me, SPELL_MANA_BOMB_LIGHTNING, false);

	switch(m_uiEventCounter)
	{
	case 5:
	  if (pManaBomb)
	    pManaBomb->SetGoState(GO_STATE_ACTIVE);
	  DoScriptText(SAY_COUNT_1, me);
	  break;
	case 6:
	  DoScriptText(SAY_COUNT_2, me);
	  break;
	case 7:
	  DoScriptText(SAY_COUNT_3, me);
	  break;
	case 8:
	  DoScriptText(SAY_COUNT_4, me);
	  break;
	case 9:
	  DoScriptText(SAY_COUNT_5, me);
	  break;
	case 10:
	  me->CastSpell(me, SPELL_MANA_BOMB_EXPL, false);
	  break;
	case 30:
	  if (pManaBomb)
	    pManaBomb->SetGoState(GO_STATE_READY);
	  Reset();
	  break;
	}

	++m_uiEventCounter;
      }
      else
	m_uiEventTimer -= uiDiff;
    }
  };
};

/*################################
# Pilgrim's Bounty - Wild Turkey
#################################*/

enum TheTurkinator
{
  SPELL_KILL_COUNTER_VISUAL       = 62015,
  SPELL_KILL_COUNTER_VISUAL_MAX   = 62021,
};



enum WildTurkey
{
  SPELL_TURKEY_TRACKER = 62014,
};

class npc_wild_turkey : public CreatureScript
{
public:
  npc_wild_turkey() : CreatureScript("npc_wild_turkey") { }

  struct npc_wild_turkeyAI : public ScriptedAI
  {
    npc_wild_turkeyAI(Creature* creature) : ScriptedAI(creature) {}

    void JustDied(Unit* killer)
    {
      if (!killer)
	return;

      if (Player* player = killer->ToPlayer())
	player->CastSpell(player, SPELL_TURKEY_TRACKER, false);
    }
  };

  CreatureAI* GetAI(Creature* creature) const
  {
    return new npc_wild_turkeyAI(creature);
  }
};

/*######################################
# Pilgrim's Bounty - spell_gen_feast_on
######################################*/

class spell_gen_feast_on : public SpellScriptLoader
{
public:
  spell_gen_feast_on() : SpellScriptLoader("spell_gen_feast_on") { }

  class spell_gen_feast_on_SpellScript : public SpellScript
  {
    PrepareSpellScript(spell_gen_feast_on_SpellScript);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
      int32 basePoints0 = GetSpellInfo()->Effects[EFFECT_0].CalcValue();

      if (Unit* caster = GetCaster())
	if (caster->IsVehicle())
	  if (Unit* passenger = caster->GetVehicleKit()->GetPassenger(0))
	    if (Player* player = passenger->ToPlayer())
	      player->CastSpell(player, basePoints0, true);
    }

    void Register()
    {
      OnEffectHitTarget += SpellEffectFn(spell_gen_feast_on_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
  };

  SpellScript* GetSpellScript() const
  {
    return new spell_gen_feast_on_SpellScript();
  }
};


/*##################################
# Pilgrim's bounty - The Turkinator
###################################*/

class spell_gen_turkey_tracker : public SpellScriptLoader
{
public:
  spell_gen_turkey_tracker() : SpellScriptLoader("spell_gen_turkey_tracker") {}

  class spell_gen_turkey_tracker_SpellScript : public SpellScript
  {
    PrepareSpellScript(spell_gen_turkey_tracker_SpellScript);

    bool Validate(SpellInfo const* /*spellEntry*/)
    {
      if (!sSpellMgr->GetSpellInfo(SPELL_KILL_COUNTER_VISUAL))
	return false;
      if (!sSpellMgr->GetSpellInfo(SPELL_KILL_COUNTER_VISUAL_MAX))
	return false;
      return true;
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
      Player* target = GetHitPlayer();
      if (!target)
	return;

      if (Aura* aura = GetCaster()->ToPlayer()->GetAura(GetSpellInfo()->Id))
      {
	switch (aura->GetStackAmount())
	{
	case 10:
	  target->MonsterTextEmote("Turkey Hunter!", 0, true);
	  GetCaster()->CastSpell(target, SPELL_KILL_COUNTER_VISUAL, true, NULL);
	  break;
	case 20:
	  target->MonsterTextEmote("Turkey Domination!", 0, true);
	  GetCaster()->CastSpell(target, SPELL_KILL_COUNTER_VISUAL, true, NULL);
	  break;
	case 30:
	  target->MonsterTextEmote("Turkey Slaughter!", 0, true);
	  GetCaster()->CastSpell(target, SPELL_KILL_COUNTER_VISUAL, true, NULL);
	  break;
	case 40:
	  target->MonsterTextEmote("TURKEY TRIUMPH!", 0, true);
	  GetCaster()->CastSpell(target, SPELL_KILL_COUNTER_VISUAL, true, NULL);
	  GetCaster()->CastSpell(target, SPELL_KILL_COUNTER_VISUAL_MAX, true, NULL); // Achievement Credit
	  break;
	default:
	  break;
	}
      }
    }

    void Register()
    {
      OnEffectHitTarget += SpellEffectFn(spell_gen_turkey_tracker_SpellScript::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
  };

  SpellScript* GetSpellScript() const
  {
    return new spell_gen_turkey_tracker_SpellScript();
  }
};


#define GOSSIP_ITEM_MARIAGE   "Direction le mariage !"

class npc_jump_mariage : public CreatureScript
{
public:
  npc_jump_mariage() : CreatureScript("npc_jump_mariage") { }

  bool OnGossipHello(Player* player, Creature* creature)
  {
    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_MARIAGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

    player->SEND_GOSSIP_MENU(TEXT_ID_DEFAULT, creature->GetGUID());
    return true;
  }

  bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
  {
    player->PlayerTalkClass->ClearMenus();
    if (action == GOSSIP_ACTION_INFO_DEF + 1)
      player->GetMotionMaster()->MoveJump(3836.35f, -2867.5f, 131.5f, 50, 50);
    return true;
  }
};


class npc_maggoc : public CreatureScript
{
public:
  npc_maggoc() : CreatureScript("npc_maggoc") { }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_maggocAI (pCreature);
  }

  struct npc_maggocAI : public ScriptedAI
  {
    npc_maggocAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
      Reset();
    }

    bool frenzie, loot;

    void Reset()
    {
      frenzie = false;
      loot = false;
    }

    void DamageTaken(Unit* doneBy, uint32& damage)
    {
      if (((me->GetHealth() - damage) * 100) / me->GetMaxHealth() <= 30 && !frenzie)
      {
	me->CastSpell(me, 36406, true);
	frenzie = true;
      }
    }

    void JustDied(Unit* doneBy)
    {
      if (doneBy->GetTypeId() == TYPEID_PLAYER)
      {
	if (doneBy->ToPlayer()->GetQuestStatus(10996) == QUEST_STATUS_INCOMPLETE)
	{
	  DoCast(39891);
	  doneBy->ToPlayer()->AddItem(32380, 1);
	}
      }
    }

    void UpdateAI(const uint32 uiDiff)
    {
      if (!UpdateVictim())
	return;

      DoMeleeAttackIfReady();
    }
  };
};

class npc_grolloc : public CreatureScript
{
public:
  npc_grolloc() : CreatureScript("npc_grolloc") { }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_grollocAI (pCreature);
  }

  struct npc_grollocAI : public ScriptedAI
  {
    npc_grollocAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
      Reset();
    }

    bool frenzie, loot;

    void Reset()
    {
      frenzie = false;
      loot = false;
      mui_cast1 = 1000;
      mui_cast2 = 2000;
    }
    //20216
    void DamageTaken(Unit* doneBy, uint32& damage)
    {
      if (((me->GetHealth() - damage) * 100) / me->GetMaxHealth() <= 30 && !frenzie)
      {
	if (me->HasUnitState(UNIT_STATE_CASTING))
	  return;
	me->CastSpell(me, 38771, true);
	frenzie = true;
      }
    }

    void JustDied(Unit* doneBy)
    {
      if (doneBy->GetTypeId() == TYPEID_PLAYER)
      {
	if (doneBy->ToPlayer()->GetQuestStatus(10995) == QUEST_STATUS_INCOMPLETE)
	{
	  doneBy->ToPlayer()->AddItem(32379, 1);
	}
      }
    }

    void UpdateAI(const uint32 uiDiff)
    {
      if (!UpdateVictim())
	return;


      if (me->HasUnitState(UNIT_STATE_CASTING))
	return;

      if (mui_cast1 <= uiDiff)
      {
	DoCast(21055);
	mui_cast1 = 10000;
      }
      else mui_cast1 -= uiDiff;

      if (mui_cast2 <= uiDiff)
      {
	if (Unit *un = me->getVictim())
	  me->CastSpell(un, 38772, true);
	mui_cast2 = 5000;
      }
      else mui_cast2 -= uiDiff;

      DoMeleeAttackIfReady();
    }

    uint32 mui_cast2, mui_cast1;
  };
};

class npc_skori : public CreatureScript
{
public:
  npc_skori() : CreatureScript("npc_skori") { }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_skoriAI (pCreature);
  }

  struct npc_skoriAI : public ScriptedAI
  {
    npc_skoriAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
      Reset();
    }

    bool frenzie, loot;

    void Reset()
    {
      frenzie = false;
      loot = false;
    }

    //20216
    void DamageTaken(Unit* doneBy, uint32& damage)
    {
      if (((me->GetHealth() - damage) * 100) / me->GetMaxHealth() <= 30 && !frenzie)
      {
	me->CastSpell(me, 33958, true);
	frenzie = true;
      }
    }

    void JustDied(Unit* doneBy)
    {
      if (doneBy->GetTypeId() == TYPEID_PLAYER)
      {
	if (doneBy->ToPlayer()->GetQuestStatus(10997) == QUEST_STATUS_INCOMPLETE)
	{
	  doneBy->ToPlayer()->AddItem(32382, 1);
	}
      }
    }

    void UpdateAI(const uint32 uiDiff)
    {
      if (!UpdateVictim())
	return;

      DoMeleeAttackIfReady();
    }

  };
};

class npc_paragon_5_years_01 : public CreatureScript
{
public:
  npc_paragon_5_years_01() : CreatureScript("npc_paragon_5_years_01") { }

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_paragon_5_years_01AI (pCreature);
  }

  bool OnGossipHello(Player* player, Creature* creature)
  {
    if (CAST_AI(npc_paragon_5_years_01::npc_paragon_5_years_01AI, creature->AI())->GetData(42) < 5)
      {
	player->ADD_GOSSIP_ITEM(0, "Bienvenue chers aventuriers, etes vous prets a entrer dans la salle des tortures ? un defis de taille vous y attendra", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
	player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
      }
    else
      creature->MonsterSay("la salle de torture est deja en activite veuillez repasser plus tard.", LANG_UNIVERSAL, 0);
    return true;
  }

  bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
  {
    player->PlayerTalkClass->ClearMenus();
    if (action == GOSSIP_ACTION_INFO_DEF + 1)
      {
	CAST_AI(npc_paragon_5_years_01::npc_paragon_5_years_01AI, creature->AI())->SetGUID(player->GetGUID(), 0);
	creature->MonsterWhisper("vous avez ete retenu pour la prochaine seance de tortures.", player->GetGUID(), true);
      }
    player->PlayerTalkClass->SendCloseGossip();
    return true;
  }

  struct npc_paragon_5_years_01AI : public ScriptedAI
  {
    npc_paragon_5_years_01AI(Creature* pCreature) : ScriptedAI(pCreature), Summons(me)
    {
      Reset();
    }

    void Reset()
    {
      mui_timer_event = 2000;
      event_active = false;
      phase = 0;
      mui_timer_phase_event = 15000;
    }

    void SetGUID(uint64 guid, int32 /*type*/)
    {
      std::list<uint64>::iterator findIter = std::find(playersGUID.begin(), playersGUID.end(), guid);
      if (findIter == playersGUID.end())
          playersGUID.push_back(guid);
      char nbr = '0';
      nbr += (5 - playersGUID.size());
      std::string txt = "il reste ";
      txt += nbr;
      txt += " places pour une session de tortures.";
      if (findIter == playersGUID.end())
      {
          if (playersGUID.size() < 5)
              me->MonsterYell(txt.c_str(), LANG_UNIVERSAL, 0);
          else
              me->MonsterYell("la salle des tortures est pleine, la session va bientot debutter, prochaine session dans 30 minutes.", LANG_UNIVERSAL, 0);
      }
    }

    void DamageTaken(Unit* doneBy, uint32& damage)
    {
    }

    void JustDied(Unit* doneBy)
    {
    }

    uint32 GetData(uint32 data)
    {
      if (!playersGUID.empty())
          return playersGUID.size();
      return 0;
    }

    void JustSummoned(Creature* summon)
    {
      Summons.Summon(summon);
    }

    void UpdateAI(uint32 const uiDiff)
    {
      if (mui_timer_event <= uiDiff)
      {
          if (playersGUID.size() >= 5)
          {
              for (std::list<uint64 >::iterator itr = playersGUID.begin(); itr != playersGUID.end(); itr++)
                  if (Player *player = Unit::GetPlayer(*me, *itr))
                      player->TeleportTo(1, 7445.27f, -1691.75f, 195.0f, 5.6f);
              event_active = true;
              phase = 0;
              mui_timer_phase_event = 15000;
              mui_timer_event = 1800000;
          }
          else
              mui_timer_event = 2000;
      }
      else
          mui_timer_event -= uiDiff;

      if (event_active)
      {
          if (mui_timer_phase_event <= uiDiff)
          {
              switch (phase)
              {
              case 0 :
                  for (int cnt = 0; cnt < 6; cnt++)
                      me->SummonCreature(11262, 7445.27f, -1691.75f, 195.0f, 5.6f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000);
                  for (int cnt = 0; cnt < 2; cnt++)
                      me->SummonCreature(12129, 7445.27f, -1691.75f, 195.0f, 5.6f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000);
                  break;
              case 1 :
                  for (int cnt = 0; cnt < 8; cnt++)
                      me->SummonCreature(33550, 7445.27f, -1691.75f, 195.0f, 5.6f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000);
                  for (int cnt = 0; cnt < 3; cnt++)
                      me->SummonCreature(34127, 7445.27f, -1691.75f, 195.0f, 5.6f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000);
                  break;
              case 2 :
                  for (int cnt = 0; cnt < 2; cnt++)
                      me->SummonCreature(12129, 7445.27f, -1691.75f, 195.0f, 5.6f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000);
                  for (int cnt = 0; cnt < 10; cnt++)
                      me->SummonCreature(11262, 7445.27f, -1691.75f, 195.0f, 5.6f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000);
                  break;
              case 3 :
                  for (int cnt = 0; cnt < 1; cnt++)
                      me->SummonCreature(37023, 7445.27f, -1691.75f, 195.0f, 5.6f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000);
                  for (int cnt = 0; cnt < 4; cnt++)
                      me->SummonCreature(33550, 7445.27f, -1691.75f, 195.0f, 5.6f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000);
                  break;
              case 4 :
                  me->SummonCreature(6109, 7445.27f, -1691.75f, 195.0f, 5.6f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 600000);
                  break;
              default :
                  for (std::list<uint64 >::iterator itr = playersGUID.begin(); itr != playersGUID.end(); itr++)
                      if (Player *player = Unit::GetPlayer(*me, *itr))
                          player->TeleportTo(1, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 5.6f);
                  playersGUID.clear();
                  event_active = false;
                  Summons.DespawnAll();
                  break;
              }
              phase++;
              mui_timer_phase_event = 300000;
          }
          else
              mui_timer_phase_event -= uiDiff;
      }
    }

  private:
    uint32 mui_timer_event;
    std::list<uint64 > playersGUID;
    bool event_active;
    uint32 phase;
    uint32 mui_timer_phase_event;
    SummonList Summons;
  };
};

enum eArmyDeadGhoul
{
    SPELL_TAUNT             = 43263,
    SPELL_CLAW              = 47468,
    SPELL_LEAP              = 47482,
    SPELL_AOE_AVOIDANCE     = 62137
};

class npc_army_dead_ghoul : public CreatureScript
{
public:
    npc_army_dead_ghoul() : CreatureScript("npc_army_dead_ghoul") { }

    struct npc_army_dead_ghoulAI : public ScriptedAI
    {
        npc_army_dead_ghoulAI(Creature* creature) : ScriptedAI(creature)
        {
            DoCast(me, SPELL_AOE_AVOIDANCE, true);
        }

        void Reset()
        {
            me->SetReactState(REACT_AGGRESSIVE);
            me->setPowerType(POWER_ENERGY);
            me->SetMaxPower(POWER_ENERGY, 100);
            ClawTimer = 2000;
            TauntTimer = 2500;
        }

        void EnterCombat(Unit* who)
        {
            if (me->GetDistance2d(who) > 5.0f)
                DoCast(who, SPELL_LEAP, true);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (me->GetPower(POWER_ENERGY) >= 40)
            {
                if (ClawTimer < diff)
                {
                    DoCastVictim(SPELL_CLAW, true);
                    me->SetPower(POWER_ENERGY, me->GetPower(POWER_ENERGY) - 40);
                    ClawTimer = urand(3000, 5000);
                } else ClawTimer -= diff;
            }

            if (TauntTimer < diff)
            {
                if (Unit* target = me->getVictim())
                {
                    if (target->GetTypeId() == TYPEID_UNIT)
                    {
                        if (!target->ToCreature()->isWorldBoss())
                            DoCastVictim(SPELL_TAUNT, true);
                    } else DoCastVictim(SPELL_TAUNT, true);
                }
                TauntTimer = urand(1000, 2000);
            } else TauntTimer -= diff;

            DoMeleeAttackIfReady();
        }

    private:
        uint32 ClawTimer;
        uint32 TauntTimer;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_army_dead_ghoulAI(creature);
    }
};


void AddSC_npcs_special()
{
    //lost+found/  new npc_jump_mariage;
    new npc_air_force_bots;
    //    new npc_lunaclaw_spirit;
    new npc_chicken_cluck;
    new npc_dancing_flames;
    new npc_doctor;
    new npc_injured_patient;
    new npc_garments_of_quests;
    new npc_guardian;
    new npc_mount_vendor;
    new npc_rogue_trainer;
    new npc_sayge;
    new npc_steam_tonk;
    new npc_tonk_mine;
    new npc_winter_reveler;
    new npc_brewfest_reveler;
	new npc_brewfest_trigger();
	new npc_brewfest_apple_trigger();
	new npc_brewfest_keg_thrower();
	new npc_brewfest_keg_receiver();
	new npc_brewfest_ram_master();
    //	new npc_demeza();
	new npc_brew();
	new npc_sum_brew();
	new npc_brew_attak_trigger();
    //	new npc_brew_attak_trigger2();
	new npc_cervoise();
    new npc_snake_trap;
    new npc_mirror_image;
    new npc_ebon_gargoyle;
    new npc_lightwell;
    new mob_mojo;
    new npc_training_dummy;
    new npc_shadowfiend;
    new npc_wormhole;
    new npc_pet_trainer;
    new npc_locksmith;
    new npc_tabard_vendor();
    new npc_experience();
    new npc_fire_elemental();
    new npc_earth_elemental();
    new npc_firework();
    new npc_spring_rabbit();
    new npc_argent_squire();
    // new npc_artuis();
    //    new vehicle_knight_gryphon();
    //	new npc_risen_ally();
    new spell_toss_stinky_bomb();
    new spell_clean_stinky_bomb();
    new at_wickerman_festival();
    new spell_halloween_wand();
    new go_wickerman_ember();
    new item_water_bucket();
    new npc_halloween_fire();
    new npc_shade_horseman();
    new npc_halloween_orphan_matron();

    new npc_anchorite_barada();
    new npc_darkness_released();
    new npc_foul_purge();
    new npc_mana_bomb();

    //    new npc_raise_ally();


    new npc_wild_turkey();
    new spell_gen_feast_on();
    new spell_gen_turkey_tracker();

    new npc_maggoc();
    new npc_grolloc();
    new npc_skori();

    //    new npc_paragon_5_years_01();

    new npc_army_dead_ghoul();
}
