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
SDName: Icecrown
SD%Complete: 100
SDComment: Quest support: 12807
SDCategory: Icecrown
EndScriptData */

/* ContentData
npc_arete
EndContentData */

#include "ScriptPCH.h"

enum SpellGral
{
    RIDE_VEHICLE                            = 63151,
    PLAYER_ON_TOURNAMENT_MOUNT              = 63034,
    LANCE_EQUIPPED                          = 62853,
};

/*######
## npc_arete
######*/

#define GOSSIP_ARETE_ITEM1 "Lord-Commander, I would hear your tale."
#define GOSSIP_ARETE_ITEM2 "<You nod slightly but do not complete the motion as the Lord-Commander narrows his eyes before he continues.>"
#define GOSSIP_ARETE_ITEM3 "I thought that they now called themselves the Scarlet Onslaught?"
#define GOSSIP_ARETE_ITEM4 "Where did the grand admiral go?"
#define GOSSIP_ARETE_ITEM5 "That's fine. When do I start?"
#define GOSSIP_ARETE_ITEM6 "Let's finish this!"
#define GOSSIP_ARETE_ITEM7 "That's quite a tale, Lord-Commander."

enum eArete
{
    GOSSIP_TEXTID_ARETE1        = 13525,
    GOSSIP_TEXTID_ARETE2        = 13526,
    GOSSIP_TEXTID_ARETE3        = 13527,
    GOSSIP_TEXTID_ARETE4        = 13528,
    GOSSIP_TEXTID_ARETE5        = 13529,
    GOSSIP_TEXTID_ARETE6        = 13530,
    GOSSIP_TEXTID_ARETE7        = 13531,

    QUEST_THE_STORY_THUS_FAR    = 12807
};

class npc_arete : public CreatureScript
{
public:
    npc_arete() : CreatureScript("npc_arete") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_THE_STORY_THUS_FAR) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE1, creature->GetGUID());
            return true;
        }

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE3, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE4, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE5, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE6, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+6:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ARETE_ITEM7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ARETE7, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+7:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(QUEST_THE_STORY_THUS_FAR);
                break;
        }

        return true;
    }
};

/*######
## npc_squire_david
######*/

enum eSquireDavid
{
    QUEST_THE_ASPIRANT_S_CHALLENGE_H                    = 13680,
    QUEST_THE_ASPIRANT_S_CHALLENGE_A                    = 13679,

    NPC_ARGENT_VALIANT                                  = 33448,

    GOSSIP_TEXTID_SQUIRE_DAVID                          = 14407
};

#define GOSSIP_SQUIRE_ITEM_1 "I am ready to fight!"
#define GOSSIP_SQUIRE_ITEM_2 "How do the Argent Crusader raiders fight?"

class npc_squire_david : public CreatureScript
{
public:
    npc_squire_david() : CreatureScript("npc_squire_david") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_THE_ASPIRANT_S_CHALLENGE_H) == QUEST_STATUS_INCOMPLETE ||
            player->GetQuestStatus(QUEST_THE_ASPIRANT_S_CHALLENGE_A) == QUEST_STATUS_INCOMPLETE)//We need more info about it.
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_SQUIRE_DAVID, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->SummonCreature(NPC_ARGENT_VALIANT, 8575.451f, 952.472f, 547.554f, 0.38f);
        }
        return true;
    }
};

/*######
## npc_argent_valiant
######*/

enum eArgentValiant
{
    SPELL_CHARGE                = 63010,
    SPELL_SHIELD_BREAKER        = 65147,
    SPELL_DEFEND                = 62719,
    SPELL_THRUST                = 62544,

    NPC_ARGENT_VALIANT_CREDIT   = 24108
};

enum eValiantText
{
       NPC_FACTION_VAILIANT_TEXT_SAY_START_1   = -1850004,//   Tenez-vous prêt !
       NPC_FACTION_VAILIANT_TEXT_SAY_START_2   = -1850005,//   Que le combat commence !
       NPC_FACTION_VAILIANT_TEXT_SAY_START_3   = -1850006,//   Préparez-vous !
       NPC_ARGENT_VAILIANT_TEXT_SAY_START      = -1850007,//   Vous pensez avoir la vaillance en vous ? Nous verrons.
       NPC_ARGENT_VAILIANT_TEXT_SAY_WIN        = -1850008,//   Impressionnante démonstration. Je pense que vous êtes tout à fait en mesure de rejoindre les rangs des vaillants.
       NPC_ARGENT_VAILIANT_TEXT_SAY_LOOSE      = -1850009,//   J'ai gagné. Vous aurez sans doute plus de chance la prochaine fois.
       NPC_FACTION_VAILIANT_TEXT_SAY_WIN_1     = -1850010,//   Je suis vaincue. Joli combat !
       NPC_FACTION_VAILIANT_TEXT_SAY_WIN_2     = -1850011,//   On dirait que j'ai sous-estimé vos compétences. Bien joué.
       NPC_FACTION_VAILIANT_TEXT_SAY_LOOSE     = -1850012,//   J'ai gagné. Vous aurez sans doute plus de chance la prochaine fois.
};

class npc_argent_valiant : public CreatureScript
{
public:
    npc_argent_valiant() : CreatureScript("npc_argent_valiant") { }

    struct npc_argent_valiantAI : public ScriptedAI
    {
        npc_argent_valiantAI(Creature* creature) : ScriptedAI(creature)
        {

            me->CastSpell(me, SPELL_DEFEND, true);
            me->CastSpell(me, SPELL_DEFEND, true);
            creature->GetMotionMaster()->MovePoint(0, 8599.258f, 963.951f, 547.553f);
            creature->setFaction(35); //wrong faction in db?
        }

        uint32 uiChargeTimer;
        uint32 uiShieldBreakerTimer;
		uint32 uiDefendTimer;

        void Reset()
        {
            uiChargeTimer = 7000;
            uiShieldBreakerTimer = 10000;
			uiDefendTimer = 10000;
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/)
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            me->setFaction(14);
        }

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
        {
               if(pDoneBy)
               {
                       if (uiDamage > me->GetHealth() && (pDoneBy->GetTypeId() == TYPEID_PLAYER || pDoneBy->GetOwner()))
                       {
                               DoScriptText(NPC_ARGENT_VAILIANT_TEXT_SAY_WIN, me);
                               uiDamage = 0;

                               if(pDoneBy->GetOwner())
                                       (pDoneBy->GetOwner())->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_VALIANT_CREDIT,0);
                               if(pDoneBy->GetTypeId() == TYPEID_PLAYER)
                                       pDoneBy->ToPlayer()->KilledMonsterCredit(NPC_ARGENT_VALIANT_CREDIT,0);

                               me->setFaction(35);
                               me->DespawnOrUnsummon(5000);
                               me->SetHomePosition(me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),me->GetOrientation());
                               EnterEvadeMode();
                       }
               }
        }

        void KilledUnit(Unit* /*victim*/)
        {
                       me->setFaction(35);
                       me->DespawnOrUnsummon(5000);
                       DoScriptText(NPC_ARGENT_VAILIANT_TEXT_SAY_LOOSE, me);
                       me->CombatStop(true);
        }

        void DoMeleeAttackIfReady()
        {
               if (me->HasUnitState(UNIT_STATE_CASTING))
                   return;

               //Make sure our attack is ready and we aren't currently casting before checking distance
               if (me->isAttackReady())
               {
                   //If we are within range melee the target
                   if (me->IsWithinMeleeRange(me->getVictim()))
                   {
                       DoCastVictim(SPELL_THRUST);
                       me->resetAttackTimer();
                   }
               }
        }

        void EnterCombat(Unit* /*who*/)
        {
               DoScriptText(NPC_ARGENT_VAILIANT_TEXT_SAY_START, me);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (uiChargeTimer <= uiDiff)
            {
                DoCastVictim(SPELL_CHARGE);
                uiChargeTimer = 7000;
            } else uiChargeTimer -= uiDiff;

            if (uiShieldBreakerTimer <= uiDiff)
            {
                DoCastVictim(SPELL_SHIELD_BREAKER);
                uiShieldBreakerTimer = 10000;
            } else uiShieldBreakerTimer -= uiDiff;

            if (uiDefendTimer <= uiDiff)
            {
               me->CastSpell(me, SPELL_DEFEND, true);
               uiDefendTimer = 10000;
            } else uiDefendTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_argent_valiantAI(creature);
    }
};

/*######
## npc_guardian_pavilion
######*/

enum eGuardianPavilion
{
    SPELL_TRESPASSER_H                            = 63987,
    AREA_SUNREAVER_PAVILION                       = 4676,

    AREA_SILVER_COVENANT_PAVILION                 = 4677,
    SPELL_TRESPASSER_A                            = 63986,
};

class npc_guardian_pavilion : public CreatureScript
{
public:
    npc_guardian_pavilion() : CreatureScript("npc_guardian_pavilion") { }

    struct npc_guardian_pavilionAI : public Scripted_NoMovementAI
    {
        npc_guardian_pavilionAI(Creature* creature) : Scripted_NoMovementAI(creature) {}

        void MoveInLineOfSight(Unit* who)
        {
            if (me->GetAreaId() != AREA_SUNREAVER_PAVILION && me->GetAreaId() != AREA_SILVER_COVENANT_PAVILION)
                return;

            if (!who || who->GetTypeId() != TYPEID_PLAYER || !me->IsHostileTo(who) || !me->isInBackInMap(who, 5.0f))
                return;

            if (who->HasAura(SPELL_TRESPASSER_H) || who->HasAura(SPELL_TRESPASSER_A))
                return;

            if (who->ToPlayer()->GetTeamId() == TEAM_ALLIANCE)
                who->CastSpell(who, SPELL_TRESPASSER_H, true);
            else
                who->CastSpell(who, SPELL_TRESPASSER_A, true);

        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_guardian_pavilionAI(creature);
    }
};

/*######
## npc_vereth_the_cunning
######*/

enum eVerethTheCunning
{
    NPC_GEIST_RETURN_BUNNY_KC   = 31049,
    NPC_LITHE_STALKER           = 30894,
    SPELL_SUBDUED_LITHE_STALKER = 58151,
};

class npc_vereth_the_cunning : public CreatureScript
{
public:
    npc_vereth_the_cunning() : CreatureScript("npc_vereth_the_cunning") { }

    struct npc_vereth_the_cunningAI : public ScriptedAI
    {
        npc_vereth_the_cunningAI(Creature* creature) : ScriptedAI(creature) {}

        void MoveInLineOfSight(Unit* who)
        {
            ScriptedAI::MoveInLineOfSight(who);

            if (who->GetEntry() == NPC_LITHE_STALKER && me->IsWithinDistInMap(who, 10.0f))
            {
                if (Unit* owner = who->GetCharmer())
                {
                    if (who->HasAura(SPELL_SUBDUED_LITHE_STALKER))
                        {
                            owner->ToPlayer()->KilledMonsterCredit(NPC_GEIST_RETURN_BUNNY_KC, 0);
                            who->ToCreature()->DisappearAndDie();

                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_vereth_the_cunningAI(creature);
    }
};

/*######
* npc_tournament_training_dummy
######*/
enum TournamentDummy
{
    NPC_CHARGE_TARGET         = 33272,
    NPC_MELEE_TARGET          = 33229,
    NPC_RANGED_TARGET         = 33243,

    SPELL_CHARGE_CREDIT       = 62658,
    SPELL_MELEE_CREDIT        = 62672,
    SPELL_RANGED_CREDIT       = 62673,

    SPELL_PLAYER_THRUST       = 62544,
    SPELL_PLAYER_BREAK_SHIELD = 62626,
    SPELL_PLAYER_CHARGE       = 62874,

    SPELL_RANGED_DEFEND       = 62719,
    SPELL_CHARGE_DEFEND       = 64100,
    SPELL_VULNERABLE          = 62665,

    SPELL_COUNTERATTACK       = 62709,

    EVENT_DUMMY_RECAST_DEFEND = 1,
    EVENT_DUMMY_RESET         = 2,
};

class npc_tournament_training_dummy : public CreatureScript
{
    public:
        npc_tournament_training_dummy(): CreatureScript("npc_tournament_training_dummy"){}

        struct npc_tournament_training_dummyAI : Scripted_NoMovementAI
        {
            npc_tournament_training_dummyAI(Creature* creature) : Scripted_NoMovementAI(creature) {}

            EventMap events;
            bool isVulnerable;

            void Reset()
            {
                me->SetControlled(true, UNIT_STATE_STUNNED);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
                isVulnerable = false;

                // Cast Defend spells to max stack size
                switch (me->GetEntry())
                {
                    case NPC_CHARGE_TARGET:
                        DoCast(SPELL_CHARGE_DEFEND);
                        break;
                    case NPC_RANGED_TARGET:
                        me->CastCustomSpell(SPELL_RANGED_DEFEND, SPELLVALUE_AURA_STACK, 3, me);
                        break;
                }

                events.Reset();
                events.ScheduleEvent(EVENT_DUMMY_RECAST_DEFEND, 5000);
            }

            void EnterEvadeMode()
            {
                if (!_EnterEvadeMode())
                    return;

                Reset();
            }

            void DamageTaken(Unit* /*attacker*/, uint32& damage)
            {
                damage = 0;
                events.RescheduleEvent(EVENT_DUMMY_RESET, 10000);
            }

            void SpellHit(Unit* caster, SpellInfo const* spell)
            {
                switch (me->GetEntry())
                {
                    case NPC_CHARGE_TARGET:
                        if (spell->Id == SPELL_PLAYER_CHARGE)
                            if (isVulnerable)
                                DoCast(caster, SPELL_CHARGE_CREDIT, true);
                        break;
                    case NPC_MELEE_TARGET:
                        if (spell->Id == SPELL_PLAYER_THRUST)
                        {
                            DoCast(caster, SPELL_MELEE_CREDIT, true);

                            if (Unit* target = caster->GetVehicleBase())
                                DoCast(target, SPELL_COUNTERATTACK, true);
                        }
                        break;
                    case NPC_RANGED_TARGET:
                        if (spell->Id == SPELL_PLAYER_BREAK_SHIELD)
                            if (isVulnerable)
                                DoCast(caster, SPELL_RANGED_CREDIT, true);
                        break;
                }

                if (spell->Id == SPELL_PLAYER_BREAK_SHIELD)
                    if (!me->HasAura(SPELL_CHARGE_DEFEND) && !me->HasAura(SPELL_RANGED_DEFEND))
                        isVulnerable = true;
            }

            void UpdateAI(uint32 const diff)
            {
                events.Update(diff);

                switch (events.ExecuteEvent())
                {
                    case EVENT_DUMMY_RECAST_DEFEND:
                        switch (me->GetEntry())
                        {
                            case NPC_CHARGE_TARGET:
                            {
                                if (!me->HasAura(SPELL_CHARGE_DEFEND))
                                    DoCast(SPELL_CHARGE_DEFEND);
                                break;
                            }
                            case NPC_RANGED_TARGET:
                            {
                                Aura* defend = me->GetAura(SPELL_RANGED_DEFEND);
                                if (!defend || defend->GetStackAmount() < 3 || defend->GetDuration() <= 8000)
                                    DoCast(SPELL_RANGED_DEFEND);
                                break;
                            }
                        }
                        isVulnerable = false;
                        events.ScheduleEvent(EVENT_DUMMY_RECAST_DEFEND, 5000);
                        break;
                    case EVENT_DUMMY_RESET:
                        if (UpdateVictim())
                        {
                            EnterEvadeMode();
                            events.ScheduleEvent(EVENT_DUMMY_RESET, 10000);
                        }
                        break;
                }

                if (!UpdateVictim())
                    return;

                if (!me->HasUnitState(UNIT_STATE_STUNNED))
                    me->SetControlled(true, UNIT_STATE_STUNNED);
            }

            void MoveInLineOfSight(Unit* /*who*/){}
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_tournament_training_dummyAI(creature);
        }

};

/*######
## Squire Danny
## Quest The Valiant's Challenge 13699-13713-13723-13724-13725-13726-13727-13728-13729-13731.
SELECT * FROM quest_template WHERE title LIKE 'The Valiant%s Challenge'
######*/

enum eSquireDanny
{
    NPC_ARGENT_CHAMPION_CREDIT                          = 33708,
    NPC_ARGENT_CHAMPION                                 = 33707,
    SAY_START_VALIANT                                   = -1850013,//"You believe you are ready to be a champion? Defend yourself!"
    SAY_END_VALIANT                                     = -1850014//"Most impressive. You are worthy to gain the rank of champion"
};

struct QUEST_THE_VALIANT_CHALLENGE
{
  uint32 quest_id;
};

QUEST_THE_VALIANT_CHALLENGE m_quest[] = {13699, 13713, 13723, 13724, 13725, 13726, 13727, 13728, 13729, 13731};

#define GOSSIP_SQUIRE_DANNY_1   "Je suis pret pour le combat !"

class npc_squire_danny : public CreatureScript
{
public:
    npc_squire_danny() : CreatureScript("npc_squire_danny") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        for (int i = 0; i < 10; i++)
        {
            if (((pPlayer->GetQuestStatus(m_quest[i].quest_id) == QUEST_STATUS_INCOMPLETE))&&
                (pPlayer->HasAura(RIDE_VEHICLE)) &&
                (pPlayer->HasAura(PLAYER_ON_TOURNAMENT_MOUNT)) &&
                (pPlayer->HasAura(LANCE_EQUIPPED)) &&
                (!pPlayer->isInCombat()))
            {
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SQUIRE_DANNY_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

            }
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_SQUIRE_DAVID, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
           if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
           {
               pPlayer->CLOSE_GOSSIP_MENU();
               pCreature->SummonCreature(NPC_ARGENT_VALIANT,8575.451f,952.472f,547.554f,0.38f);
           }
           //else
               //pPlayer->SEND_GOSSIP_MENU(???, pCreature->GetGUID()); Missing text
           return true;
    }
};

/*######
* npc_training_dummy_argent
######*/
/*
UPDATE `creature_template` SET `ScriptName`='npc_training_dummy_argent' WHERE `entry`=33229;
UPDATE `creature_template` SET `ScriptName`='npc_training_dummy_argent' WHERE `entry`=33272;
UPDATE `creature_template` SET `ScriptName`='npc_training_dummy_argent' WHERE `entry`=33243;
*/
enum eTrainingdummy
{
       CREDIT_RANGE               = 33339,
       CREDIT_CHARGE              = 33340,
       CREDIT_MELEE               = 33341,
       NPC_MELEE                  = 33229,
       NPC_CHARGE                 = 33272,
       NPC_RANGE                  = 33243,
       SPELL_ARGENT_MELEE         = 62544,
       SPELL_ARGENT_CHARGE        = 68321,
       SPELL_ARGENT_BREAK_SHIELD  = 62626,  // spell goes't work
       SPELL_DEFEND_AURA          = 62719,  // it's spell spam in console
       SPELL_DEFEND_AURA_1        = 64100,  // it's spell spam in console
       NPC_ADVANCED_TARGET_DUMMY  = 2674,
       NPC_TARGET_DUMMY           = 2673
};

class npc_training_dummy_argent : public CreatureScript
{
public:
       npc_training_dummy_argent(): CreatureScript("npc_training_dummy_argent"){}

       struct npc_training_dummy_argentAI : Scripted_NoMovementAI
       {
           npc_training_dummy_argentAI(Creature *pCreature) : Scripted_NoMovementAI(pCreature)
           {
                       Npc_Entry = pCreature->GetEntry();
           }

                       uint64 Npc_Entry;
                       uint32 ResetTimer;
                       uint32 DespawnTimer;
                       uint32 ShielTimer;
           void Reset()
           {
                       me->SetControlled(true,UNIT_STATE_STUNNED);//disable rotate
                       me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);//imune to knock aways like blast wave
                       me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_STUN, true);
                       ResetTimer = 5000;
                       DespawnTimer = 15000;
                       ShielTimer=0;
           }

           void EnterEvadeMode()
           {
                       if (!_EnterEvadeMode())
                               return;
                       Reset();
           }

           void DamageTaken(Unit * /*done_by*/, uint32 &damage)
           {
                       ResetTimer = 5000;
                       damage = 0;
           }

           void EnterCombat(Unit * /*who*/)
           {
               if (Npc_Entry != NPC_ADVANCED_TARGET_DUMMY && Npc_Entry != NPC_TARGET_DUMMY)
                   return;
           }

               void SpellHit(Unit* caster,const SpellInfo* spell)
               {
                       if(caster->GetCharmerOrOwner())
                       {
                       Player * pPlayer = caster->GetCharmerOrOwner()->ToPlayer();
                       switch (Npc_Entry)
                               {
                                       case NPC_MELEE: // dummy melee
                                               if (pPlayer && spell->Id == SPELL_ARGENT_MELEE && (pPlayer->GetQuestStatus(13828) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(13829) == QUEST_STATUS_INCOMPLETE))
                                                       caster->GetCharmerOrOwner()->ToPlayer()->KilledMonsterCredit(CREDIT_MELEE, 0);
                                                              return;
                                       case NPC_CHARGE: // dummy charge
                                               if (pPlayer && spell->Id == SPELL_ARGENT_CHARGE && (pPlayer->GetQuestStatus(13837) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(13839) == QUEST_STATUS_INCOMPLETE))
                                                       caster->GetCharmerOrOwner()->ToPlayer()->KilledMonsterCredit(CREDIT_CHARGE, 0);
                                                               return;
                                       case NPC_RANGE: // dummy range
                                               if (pPlayer && spell->Id == SPELL_ARGENT_BREAK_SHIELD && (pPlayer->GetQuestStatus(13835) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(13838) == QUEST_STATUS_INCOMPLETE))
                                                       caster->GetCharmerOrOwner()->ToPlayer()->KilledMonsterCredit(CREDIT_RANGE, 0);
                                                               return;
                              }
                       }
               }

           void UpdateAI(const uint32 diff)
           {
                       if (ShielTimer <= diff)
                       {
                               if(Npc_Entry == NPC_RANGE)
                                       me->CastSpell(me,SPELL_DEFEND_AURA,true);

                       if(Npc_Entry == NPC_CHARGE && !me->GetAura(SPELL_DEFEND_AURA_1))
                                               me->CastSpell(me,SPELL_DEFEND_AURA_1,true);
                               ShielTimer = 8000;
                       }
                       else
                               ShielTimer -= diff;

               if (!UpdateVictim())
                   return;
               if (!me->HasUnitState(UNIT_STATE_STUNNED))
                   me->SetControlled(true,UNIT_STATE_STUNNED);//disable rotate

               if (Npc_Entry != NPC_ADVANCED_TARGET_DUMMY && Npc_Entry != NPC_TARGET_DUMMY)
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
           void MoveInLineOfSight(Unit * /*who*/){return;}
       };

       CreatureAI* GetAI(Creature* pCreature) const
       {
           return new npc_training_dummy_argentAI(pCreature);
       }

};

/*#####################
## npc_valiant
######################*/

#define SAY_START_1      "En garde!"
#define SAY_START_2      "Preparez vous !"
#define SAY_END      "j'ai perdu. Joli combat !"
#define GOSSIP_VALIANT_1   "Je suis pret pour le combat."
#define ACTION_START_FIGHT 42
#define SAY_AGG 4

enum baliant_quest
  {
    QUEST_AMONG_THECHAMPIONS_A                                                      = 13790,
    QUEST_AMONG_THECHAMPIONS_H                                                      = 13811,
    QUEST_AMONG_THECHAMPIONS_A2                                             = 13793,
    QUEST_AMONG_THECHAMPIONS_H2                                                     = 13814,
  QUEST_THE_GRAND_MELEE_1= 13665,
    QUEST_THE_GRAND_MELEE_2= 13745,
    QUEST_THE_GRAND_MELEE_3 = 13750,
    QUEST_THE_GRAND_MELEE_4 = 13756,
    QUEST_THE_GRAND_MELEE_5 = 13761,
    QUEST_THE_GRAND_MELEE_6 = 13767,
    QUEST_THE_GRAND_MELEE_7 = 13772,
    QUEST_THE_GRAND_MELEE_8 = 13777,
    QUEST_THE_GRAND_MELEE_9 = 13782,
    QUEST_THE_GRAND_MELEE_10 = 13787,
  };

class npc_valiant : public CreatureScript
{
public:
  npc_valiant(): CreatureScript("npc_valiant"){}

  CreatureAI* GetAI(Creature* pCreature) const
  {
    return new npc_valiantAI (pCreature);
  }

  bool OnGossipHello(Player* pPlayer, Creature* pCreature)
  {
    if ((pPlayer->GetQuestStatus(QUEST_AMONG_THECHAMPIONS_H) == QUEST_STATUS_INCOMPLETE)||(pPlayer->GetQuestStatus(QUEST_AMONG_THECHAMPIONS_H2) == QUEST_STATUS_INCOMPLETE)||(pPlayer->GetQuestStatus(QUEST_AMONG_THECHAMPIONS_A) == QUEST_STATUS_INCOMPLETE)||(pPlayer->GetQuestStatus(QUEST_AMONG_THECHAMPIONS_A2) == QUEST_STATUS_INCOMPLETE))
      {
	pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_VALIANT_1,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF);
	pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
      }
    else if((pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_1) == QUEST_STATUS_INCOMPLETE)||
	    (pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_2) == QUEST_STATUS_INCOMPLETE) ||
	    (pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_3) == QUEST_STATUS_INCOMPLETE) ||
	    (pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_4) == QUEST_STATUS_INCOMPLETE) ||
	    (pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_5) == QUEST_STATUS_INCOMPLETE) ||
	    (pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_6) == QUEST_STATUS_INCOMPLETE) ||
	    (pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_7) == QUEST_STATUS_INCOMPLETE) ||
	    (pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_8) == QUEST_STATUS_INCOMPLETE) ||
	    (pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_9) == QUEST_STATUS_INCOMPLETE) ||
	    (pPlayer->GetQuestStatus(QUEST_THE_GRAND_MELEE_10) == QUEST_STATUS_INCOMPLETE))
      {
	pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,GOSSIP_VALIANT_1,GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1);
	pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
      }
    else
      pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
    return true;
  }

  bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
  {
    if (!pPlayer)
      return false;
    Creature* veh = pPlayer->GetVehicleCreatureBase();
    if (!veh)
      return false;
    switch(uiAction)
      {
      case GOSSIP_ACTION_INFO_DEF:
	{
	  pCreature->setFaction(14);
	  pCreature->SetReactState(REACT_AGGRESSIVE);
	  pCreature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
	  pCreature->AddThreat(veh, 100000.0f);
	  pCreature->AI()->SetGUID(veh->GetGUID(), 0);
	  pCreature->AI()->SetGUID(pPlayer->GetGUID(), 1);
	  pCreature->AI()->AttackStart(veh);
	  pCreature->AI()->DoAction(1);
	  pCreature->AI()->DoAction(SAY_AGG);

	  break;
	}
      case GOSSIP_ACTION_INFO_DEF+1:
	{
	  pCreature->setFaction(14);
	  pCreature->SetReactState(REACT_AGGRESSIVE);
	  pCreature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
	  pCreature->AddThreat(veh, 100000.0f);
	  pCreature->AI()->SetGUID(veh->GetGUID(), 0);
	  pCreature->AI()->SetGUID(pPlayer->GetGUID(), 1);
	  pCreature->AI()->AttackStart(veh);
	  pCreature->AI()->DoAction(2);
	  pCreature->AI()->DoAction(SAY_AGG);
	  break;
	}
      }
    pPlayer->CLOSE_GOSSIP_MENU();
    return true;
  }


struct npc_valiantAI : public ScriptedAI
{
  uint32 SpellTimer;
  uint32 MoviTimer;
  uint32 act;
  uint64 plGUID;
  uint64 playerGUID;

public:
  npc_valiantAI(Creature* creature) : ScriptedAI(creature)
  {
    me->setFaction(35);
    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
    plGUID = 0;
  }

  enum Spells
    {
      SHIELD_BREAKER                  =65147,
      CHARGE                                  =63010,
      THRUST                                  =68505,
      DEFEND                                  =66482,
      MUNTED_MELEE_VICTORY    =63596,
      MUNTED_MELEE2_VICTORY    =62996
    };
  enum Timers
    {
      TIMER_SPELL_MIN         =1000,
      TIMER_SPELL_MAX         =2000,
      TIMER_MoviTimer_MIN     =1000,
      TIMER_MoviTimer_MAX     =2000
    };

  void Reset()
  {
    me->setFaction(35);
    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
    if (act != 1 && act != 2)
      act = 0;
    plGUID = 0;
    playerGUID = 0;
  }

  void EnterCombat(Unit* who)
  {
    SpellTimer= urand(TIMER_SPELL_MIN,TIMER_SPELL_MAX );
    MoviTimer = urand(TIMER_MoviTimer_MIN,TIMER_MoviTimer_MAX);
  }

  void JustDied(Unit* Killer)
  {
    me->MonsterSay(SAY_END, LANG_UNIVERSAL, 0);
    me->setFaction(35);
    Player* victims = ObjectAccessor::FindPlayer(playerGUID);
    if (!victims || !victims->IsInWorld())
      return;
    if (act == 1)
      victims->CastSpell(victims, MUNTED_MELEE_VICTORY, true);
    else if (act == 2)
      victims->CastSpell(victims, MUNTED_MELEE2_VICTORY, true);
    me->Respawn(true);
    EnterEvadeMode();
  }


  void DoAction(int32 const action)
  {
    switch (action)
      {
      case 0:
	act = action;
	break;
      case 1:
	act = action;
	break;
      case 2:
	act = action;
	break;
      case SAY_AGG:
	{
	  switch (urand(0,1))
	    {
	    case 0:
	      me->MonsterSay(SAY_START_1, LANG_UNIVERSAL, 0);
	      break;
	    case 1:
	      me->MonsterSay(SAY_START_2, LANG_UNIVERSAL, 0);
	      break;
	    }
	  break;
	}
      default :
	break;
      }
  }

  void KilledUnit(Unit *victim)
  {
    Reset();
    EnterEvadeMode();
  }

  void SpellHit(Unit *caster, const SpellInfo *spell)
  {
    if (spell->Id == SHIELD_BREAKER)
      {
	me->RemoveAura(DEFEND);
      }
  }

  void SpellHitTarget(Unit *pTarget, const SpellInfo *spell)
  {
    if (spell->Id == SHIELD_BREAKER && pTarget)
      pTarget->RemoveAura(DEFEND);
  }

  void DoMeleeAttackIfReady()
  {
    if (me->HasUnitState(UNIT_STATE_CASTING))
      return;

    if (me->isAttackReady())
      {
	Creature* victims = Unit::GetCreature(*me, plGUID);
	if (!victims)
	  return;
	  if (me->IsWithinMeleeRange(victims))
	    {
	      me->CastSpell(victims, SPELL_THRUST, true);
	      me->resetAttackTimer();
	    }
      }
  }

  void SetGUID(uint64 guid, int32 id)
  {
    if (id == 0)
      plGUID = guid;
    else
      playerGUID = guid;
  }

  void UpdateAI(const uint32 uiDiff)
  {

	if (SpellTimer <= uiDiff)
	  {
	    Creature* victims = Unit::GetCreature(*me, plGUID);
	    if (!victims)
	    {
	    SpellTimer = urand(TIMER_SPELL_MIN, TIMER_SPELL_MAX);
	      return;
	    }
	      {
		if (((victims->GetPositionX() - me->GetPositionX()) <= 2) && ((victims->GetPositionY() - me->GetPositionY()) <= 2))
		  {
		    switch (urand(0,4))
		      {
		      case 0:
			me->CastSpell(me, DEFEND, true);
		      break;
		      case 1:
			DoCastAOE(THRUST, true);
			break;
		      case 2:
			DoCastAOE(THRUST, true);
			break;
		      case 3:
			DoCastAOE(THRUST, true);
		      break;
		      case 4:
			DoCastAOE(THRUST, true);
			break;
		      }
		  }
		if (((victims->GetPositionX() - me->GetPositionX()) > 2) && ((victims->GetPositionY() - me->GetPositionY()) > 2))
		  {
		    switch (urand(0,7))
		      {
		      case 0:
			DoCastAOE(SHIELD_BREAKER, true);
			victims->RemoveAura(DEFEND);
			break;
		      case 1:
			DoCastAOE(SHIELD_BREAKER, true);
			victims->RemoveAura(DEFEND);
		    break;
		      case 2:
			DoCastAOE(SHIELD_BREAKER, true);
			victims->RemoveAura(DEFEND);
			break;
		      case 3:
			DoCastAOE(CHARGE, true);
			break;
		      case 4:
			DoCastAOE(CHARGE, true);
			break;
 		      case 5:
			DoCastAOE(CHARGE, true);
			break;
		      case 6:
			DoCastAOE(CHARGE, true);
			break;
		      case 7:
			me->CastSpell(me, DEFEND, true);
			break;
		      }
		  }
	      }
	    SpellTimer = urand(TIMER_SPELL_MIN, TIMER_SPELL_MAX);
	    return ;
	  } else SpellTimer -= uiDiff;

	if (MoviTimer <= uiDiff)
	  {
	    Creature* victims = Unit::GetCreature(*me, plGUID);
            if (!victims)
	    {
	      MoviTimer = urand(TIMER_MoviTimer_MIN,TIMER_MoviTimer_MAX);
              return;
	    }
	      switch (urand(0,8))
		{
		case 0:
		  me->GetMotionMaster()->MovePoint(0, (victims->GetPositionX() + 4), victims->GetPositionY(), victims->GetPositionZ());
		  break;
		case 1:
		  me->GetMotionMaster()->MovePoint(0, (victims->GetPositionX()), (victims->GetPositionY() - 5), victims->GetPositionZ());
		  break;
		case 2:
		  me->GetMotionMaster()->MovePoint(0, (victims->GetPositionX() - 2), (victims->GetPositionY() + 1), victims->GetPositionZ());
		break;
		case 3:
		  me->GetMotionMaster()->MovePoint(0, (victims->GetPositionX() - 3), (victims->GetPositionY() - 4), victims->GetPositionZ());
		  break;
		case 4:
		  me->GetMotionMaster()->MovePoint(0, (victims->GetPositionX() - 1), (victims->GetPositionY() + 5), victims->GetPositionZ());
		  break;
		case 5:
		me->GetMotionMaster()->MovePoint(0, (victims->GetPositionX() - 4), (victims->GetPositionY() + 5), victims->GetPositionZ());
		break;
		case 6:
		  me->GetMotionMaster()->MovePoint(0, (victims->GetPositionX()), (victims->GetPositionY()), victims->GetPositionZ());
		  break;
		case 7:
		  me->GetMotionMaster()->MovePoint(0, (victims->GetPositionX() - 5), (victims->GetPositionY() + 2), victims->GetPositionZ());
		  break;
		case 8:
		  me->GetMotionMaster()->MovePoint(0, (victims->GetPositionX() - 5), (victims->GetPositionY() - 1), victims->GetPositionZ());
		  break;
		}
	    MoviTimer = urand(TIMER_MoviTimer_MIN,TIMER_MoviTimer_MAX);
	    return ;
	  } else MoviTimer -= uiDiff;
	DoMeleeAttackIfReady();
  }
};
};

enum eAchievementsTournamentFactionChampion {
  ACHIEVEMENT_CHAMPION_OF_DARNASSUS = 2777,
  ACHIEVEMENT_CHAMPION_OF_EXODAR = 2778,
  ACHIEVEMENT_CHAMPION_OF_GNOMEREGAN = 2779,
  ACHIEVEMENT_CHAMPION_OF_IRONFORGE = 2780,
  ACHIEVEMENT_CHAMPION_OF_STORMWIND = 2781,
  ACHIEVEMENT_CHAMPION_OF_ORGRIMMAR = 2783,
  ACHIEVEMENT_CHAMPION_OF_DARKSPEARS = 2784,
  ACHIEVEMENT_CHAMPION_OF_SILVERMOON = 2785,
  ACHIEVEMENT_CHAMPION_OF_THUNDERBLUFF = 2786,
  ACHIEVEMENT_CHAMPION_OF_UNDERCITY = 2787,
};

enum eNPCVendorEntrys {
  ENTRY_EXODAR_VENDOR = 33657,
  ENTRY_GNOMEREGAN_VENDOR = 33650,
  ENTRY_DARNASSUS_VENDOR = 33653,
  ENTRY_STORMWIND_VENDOR = 33307,
  ENTRY_IRONFORGE_VENDOR = 33310,

  ENTRY_ORGRIMMAR_VENDOR = 33553,
  ENTRY_DARKSPEARS_VENDOR = 33554,
  ENTRY_SILVERMOON_VENDOR = 33557,
  ENTRY_THUNDERBLUFF_VENDOR = 33556,
  ENTRY_UNDERCITY_VENDOR = 33555,
};

class npc_vendor_tournament_fraction_champion: public CreatureScript
{
public:
  npc_vendor_tournament_fraction_champion() :
    CreatureScript("npc_vendor_tournament_fraction_champion") {}

  bool OnGossipHello(Player* player, Creature* creature)
  {
    bool showVendor = false;

    switch (creature->GetEntry())
    {
    case ENTRY_EXODAR_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_EXODAR);
      break;
    case ENTRY_GNOMEREGAN_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_GNOMEREGAN);
      break;
    case ENTRY_DARNASSUS_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_DARNASSUS);
      break;
    case ENTRY_STORMWIND_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_STORMWIND);
      break;
    case ENTRY_IRONFORGE_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_IRONFORGE);
      break;
    case ENTRY_ORGRIMMAR_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_ORGRIMMAR);
      break;
    case ENTRY_DARKSPEARS_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_DARKSPEARS);
      break;
    case ENTRY_SILVERMOON_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_SILVERMOON);
      break;
    case ENTRY_THUNDERBLUFF_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_THUNDERBLUFF);
      break;
    case ENTRY_UNDERCITY_VENDOR:
      showVendor = player->HasAchieved(ACHIEVEMENT_CHAMPION_OF_UNDERCITY);
      break;
    }

    if (showVendor)
    {
      player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
      player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
    }
    return true;
  }

  bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
  {
    player->PlayerTalkClass->ClearMenus();
    if (uiAction == GOSSIP_ACTION_TRADE)
      player->GetSession()->SendListInventory(creature->GetGUID());
    return true;
  }
};

void AddSC_icecrown()
{
  new npc_arete();
  //  new npc_squire_david();
  // new npc_squire_danny();
  // new npc_argent_valiant();
  new npc_guardian_pavilion();
  new npc_vereth_the_cunning();
  new npc_tournament_training_dummy();
  // new npc_training_dummy_argent();
  new npc_valiant();
  new npc_vendor_tournament_fraction_champion();
}
