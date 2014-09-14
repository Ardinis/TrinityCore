    #include "ScriptPCH.h"
    #include "karazhan.h"
#include "chess_event.h"
#include "Group.h"
     
     
    class chess_move_trigger : public CreatureScript
    {
    public:
      chess_move_trigger() : CreatureScript("chess_move_trigger") { }
     
      CreatureAI* GetAI(Creature* creature) const
      {
        return new chess_move_triggerAI(creature);
      }
     
    };

    void npc_echo_of_medivhAI::RemoveFromMoveList(uint64 unit)
    {
        for (std::list<ChessTile>::iterator itr = moveList.begin(); itr != moveList.end();)
        {
            std::list<ChessTile>::iterator tmpItr = itr;
            ++itr;
            if ((*tmpItr).piece == unit || (*tmpItr).trigger == unit)
            {
                if (Creature * tmpC = me->GetCreature(*me, (*tmpItr).trigger))
                    ((chess_move_triggerAI*)tmpC->AI())->RemoveFromMove((*tmpItr).piece);

                moveList.erase(tmpItr);
                return;
            }
        }
    }
     
     
     class chess_npc : public CreatureScript
      {
      public:
        chess_npc() : CreatureScript("chess_npc") { }
     
        CreatureAI* GetAI(Creature* creature) const
        {
          return new chess_npcAI(creature);
        }
     
        struct chess_npcAI : public PassiveAI
        {
          chess_npcAI(Creature* c) : PassiveAI(c) {
            pInstance = ((InstanceScript*)me->GetInstanceScript());

            //No_movement
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);

            const SpellInfo *TempSpell = sSpellMgr->GetSpellInfo(SPELL_POSSES_CHESSPIECE);

            me->setActive(true);
          }

		  InstanceScript* pInstance;

		  Creature * npc_medivh;

		  bool ReturnToHome;
		  bool CanMove;

		  uint64 MedivhGUID;
		  uint64 CharmerGUID;

		  int ability1Chance;     //chance to cast spell
		  int ability2Chance;
		  int attackDamage;

		  int32 ability1Timer;
		  int32 ability1Cooldown;
		  int32 ability2Timer;
		  int32 ability2Cooldown;
		  int32 attackTimer;
          
		  int32 nextTryTimer;     //try to cast spell after some time
          
		  uint32 changeFacingTimer;

		  uint32 ability1ID;
		  uint32 ability2ID;
		  uint32 moveID;

          bool InGame;

        void SetSpellsAndCooldowns()
        {
            switch(me->GetEntry())
            {
                case NPC_KING_A:
                    ability1ID = SPELL_KING_A_1;
                    ability1Timer = CD_KING_1;
                    ability1Cooldown = CD_KING_1;

                    ability2ID = SPELL_KING_A_2;
                    ability2Timer = CD_KING_2;
                    ability2Cooldown = CD_KING_2;

                    moveID = SPELL_MOVE_5;
                    break;

                case NPC_KING_H:
                    ability1ID = SPELL_KING_H_1 ;
                    ability1Timer = CD_KING_1;
                    ability1Cooldown = CD_KING_1;

                    ability2ID = SPELL_KING_H_2;
                    ability2Timer = CD_KING_2;
                    ability2Cooldown = CD_KING_2;

                    moveID = SPELL_MOVE_5;
                    break;

                case NPC_QUEEN_A:
                    ability1ID = SPELL_QUEEN_A_1 ;
                    ability1Timer = CD_QUEEN_1;
                    ability1Cooldown = CD_QUEEN_1;

                    ability2ID = SPELL_QUEEN_A_2;
                    ability2Timer = CD_QUEEN_2;
                    ability2Cooldown = CD_QUEEN_2;

                    moveID = SPELL_MOVE_4;
                    break;

                case NPC_QUEEN_H:
                    ability1ID = SPELL_QUEEN_H_1 ;
                    ability1Timer = CD_QUEEN_1;
                    ability1Cooldown = CD_QUEEN_1;

                    ability2ID = SPELL_QUEEN_H_2;
                    ability2Timer = CD_QUEEN_2;
                    ability2Cooldown = CD_QUEEN_2;

                    moveID = SPELL_MOVE_4;
                    break;

                case NPC_BISHOP_A:
                    ability1ID = SPELL_BISHOP_A_1 ;
                    ability1Timer = CD_BISHOP_1;
                    ability1Cooldown = CD_BISHOP_1;

                    ability2ID = SPELL_BISHOP_A_2;
                    ability2Timer = CD_BISHOP_2;
                    ability2Cooldown = CD_BISHOP_2;

                    moveID = SPELL_MOVE_6;
                    break;

                case NPC_BISHOP_H:
                    ability1ID = SPELL_BISHOP_H_1 ;
                    ability1Timer = CD_BISHOP_1;
                    ability1Cooldown = CD_BISHOP_1;

                    ability2ID = SPELL_BISHOP_H_2;
                    ability2Timer = CD_BISHOP_2;
                    ability2Cooldown = CD_BISHOP_2;

                    moveID = SPELL_MOVE_6;
                    break;

                case NPC_KNIGHT_A:
                    ability1ID = SPELL_KNIGHT_A_1 ;
                    ability1Timer = CD_KNIGHT_1;
                    ability1Cooldown = CD_KNIGHT_1;

                    ability2ID = SPELL_KNIGHT_A_2;
                    ability2Timer = CD_KNIGHT_2;
                    ability2Cooldown = CD_KNIGHT_2;

                    moveID = SPELL_MOVE_3;
                    break;

                case NPC_KNIGHT_H:
                    ability1ID = SPELL_KNIGHT_H_1 ;
                    ability1Timer = CD_KNIGHT_1;
                    ability1Cooldown = CD_KNIGHT_1;

                    ability2ID = SPELL_KNIGHT_H_2;
                    ability2Timer = CD_KNIGHT_2;
                    ability2Cooldown = CD_KNIGHT_2;

                    moveID = SPELL_MOVE_3;
                    break;

                case NPC_ROOK_A:
                    ability1ID = SPELL_ROOK_A_1 ;
                    ability1Timer = CD_ROOK_1;
                    ability1Cooldown = CD_ROOK_1;

                    ability2ID = SPELL_ROOK_A_2;
                    ability2Timer = CD_ROOK_2;
                    ability2Cooldown = CD_ROOK_2;

                    moveID = SPELL_MOVE_7;
                    break;

                case NPC_ROOK_H:
                    ability1ID = SPELL_ROOK_H_1 ;
                    ability1Timer = CD_ROOK_1;
                    ability1Cooldown = CD_ROOK_1;

                    ability2ID = SPELL_ROOK_H_2;
                    ability2Timer = CD_ROOK_2;
                    ability2Cooldown = CD_ROOK_2;

                    moveID = SPELL_MOVE_7;
                    break;

                case NPC_PAWN_A:
                    ability1ID = SPELL_PAWN_A_1 ;
                    ability1Timer = CD_PAWN_1;
                    ability1Cooldown = CD_PAWN_1;

                    ability2ID = SPELL_PAWN_H_2;
                    ability2Timer = CD_PAWN_2;
                    ability2Cooldown = CD_PAWN_2;

                    moveID = SPELL_MOVE_1;
                    break;

                case NPC_PAWN_H:
                    ability1ID = SPELL_PAWN_H_1 ;
                    ability1Timer = CD_PAWN_1;
                    ability1Cooldown = CD_PAWN_1;

                    ability2ID = SPELL_PAWN_H_2;
                    ability2Timer = CD_PAWN_2;
                    ability2Cooldown = CD_PAWN_2;

                    moveID = SPELL_MOVE_1;
                    break;
                default:
                    break;
            }

            attackTimer = attackCooldown;
        }

        bool IsOnSelfSpell(uint32 spell)
        {
            switch (spell)
            {
                case SPELL_KING_H_2:
                case SPELL_KING_A_2:
                case SPELL_ROOK_H_2:
                case SPELL_ROOK_A_2:
                case SPELL_PAWN_H_2:
                case SPELL_PAWN_A_2:
                    return true;

                default:
                    return false;
            }

            return false;
        }
      
        bool IsHealingSpell(uint32 spell)
        {
            switch (spell)
            {
                case SPELL_BISHOP_A_1:
                case SPELL_BISHOP_H_1:
                    return true;

                default:
                    return false;
            }

            return false;
        }

        bool IsNullTargetSpell(uint32 spell)
        {
            switch (spell)
            {
                case SPELL_KING_H_1:
                case SPELL_KING_A_1:
                case SPELL_KNIGHT_H_1:
                case SPELL_KNIGHT_A_1:
                case SPELL_ROOK_H_1:
                case SPELL_ROOK_A_1:
                case SPELL_PAWN_H_1:
                case SPELL_PAWN_A_1:
                case SPELL_KING_H_2:
                case SPELL_KING_A_2:
                case SPELL_BISHOP_H_2:
                case SPELL_BISHOP_A_2:
                case SPELL_KNIGHT_H_2:
                case SPELL_KNIGHT_A_2:
                case SPELL_ROOK_H_2:
                case SPELL_ROOK_A_2:
                    return true;

                default:
                    return false;
            }

            return false;
        }
     
         void Reset()
         {
            ReturnToHome = true;
            InGame = true;
            CanMove = false;
            me->setActive(true);
            SetSpellsAndCooldowns();

            MedivhGUID = pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH);

            ability1Chance = urand(ABILITY_1_CHANCE_MIN, ABILITY_1_CHANCE_MAX);
            ability2Chance = urand(ABILITY_2_CHANCE_MIN, ABILITY_2_CHANCE_MAX);

            //me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            nextTryTimer = urand(500, 5000);

            changeFacingTimer = urand (3000, 7500);
         }

        void MovementInform(uint32 type, uint32 data)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            npc_medivh = me->GetCreature((*me), MedivhGUID);
            if (npc_medivh)
                ((npc_echo_of_medivhAI*)npc_medivh->AI())->SetOrientation(me->GetGUID());
        }

        void JustRespawned()
          {
             me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
             me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
          }

        void OnCharmed(bool apply)
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
            // set proper faction after charm
            if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
                me->setFaction(A_FACTION);
            else
                me->setFaction(H_FACTION);

			if (apply)
				CharmerGUID = me->GetCharmer()->GetGUID();
			else if (CharmerGUID != 0) {
				me->GetUnit(*me, CharmerGUID)->CastSpell(me->GetUnit(*me, CharmerGUID), SPELL_RECENTLY_IN_GAME, false);
			}

            if (!apply)
                if (Creature * medivh = me->GetCreature((*me), MedivhGUID))
                    ((npc_echo_of_medivhAI*)medivh->AI())->SetOrientation(me->GetGUID());
        }

        void SpellHitTarget(Unit * caster, const SpellEntry * spell)
        {
            if (spell->Id == moveID)
                ((Creature*)me)->HandleEmoteCommand(EMOTE_ONESHOT_BOW);
        }

        void DamageTaken(Unit * done_by, uint32& damage)
        {
			// deux suivantes lignes remplacées pas la troisième. Dans le premier cas, seules les pièces controllées peuvent comptabilisés les damages.
            //Player * tmpPl = done_by->GetCharmerOrOwnerPlayerOrPlayerItself();
            //if (done_by->GetTypeId() == TYPEID_UNIT && tmpPl && tmpPl->GetTeam() == pInstance->GetData(CHESS_EVENT_TEAM))
			if (me->getFaction() != pInstance->GetData(CHESS_EVENT_TEAM))
                pInstance->SetData(DATA_CHESS_DAMAGE, pInstance->GetData(DATA_CHESS_DAMAGE) + damage);

			npc_medivh = me->GetCreature((*me), MedivhGUID);

			if (npc_medivh) {
				if (me->GetEntry() == NPC_KING_A || me->GetEntry() == NPC_KING_H) {
					if (me->GetHealth() == me->GetMaxHealth()) {
						if (pInstance->GetData(CHESS_EVENT_TEAM) == HORDE && me->GetEntry() == NPC_KING_H) {
							me->PlayDirectSound(SOUND_MEDIVH_CHECK);
							npc_medivh->MonsterSay(SAY_MEDIVH_CHECK, LANG_UNIVERSAL, NULL);
						} else {
							me->PlayDirectSound(SOUND_PLAYER_CHECK);
							npc_medivh->MonsterSay(SAY_PLAYER_CHECK, LANG_UNIVERSAL, NULL);
						}
					}
				}
			}

			if (damage >= me->GetHealth()) {
				Player * tmpP = me->GetCharmerOrOwnerPlayerOrPlayerItself();
				if (tmpP) {
					tmpP->RemoveAurasDueToSpell(SPELL_POSSES_CHESSPIECE,0);
					if (tmpP->HasAura(SPELL_POSSES_CHESSPIECE))
						tmpP->RemoveAura(SPELL_POSSES_CHESSPIECE);
					me->RemoveCharmedBy(tmpP);
					me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
				}
			}
		}
     
        void JustDied(Unit * killer)
        {
            #ifdef CHESS_DEBUG_INFO
				printf("\n Appel à JustDied(Unit * killer = %i)", killer ? 1 : 0);
			#endif

            me->RemoveAurasDueToSpell(SPELL_POSSES_CHESSPIECE);

            if (pInstance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
            {
                npc_medivh = me->GetCreature((*me), MedivhGUID);
                if (npc_medivh)
                    ((npc_echo_of_medivhAI*)npc_medivh->AI())->RemoveChessPieceFromBoard(me);
                else
                    me->MonsterSay("I'm dying ... but Medivh not found ...", LANG_UNIVERSAL, 0);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (pInstance->GetData(DATA_CHESS_EVENT) == DONE || pInstance->GetData(DATA_CHESS_EVENT) == FAIL)
            {
                if (me->isInCombat())
                    me->CombatStop();

                if (me->isPossessed())
                    me->RemoveCharmedBy(me->GetCharmer());

                if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            }

            if (pInstance->GetData(DATA_CHESS_EVENT) != IN_PROGRESS)
                return;

            if (!InGame)
                return;

            uint64 ab1 = 0;
            bool ab1Self = false;
            uint64 ab2 = 0;
            bool ab2Self = false;

			if (ability1Timer <= diff && !me->isCharmed())
            {
                Creature * medivh = me->GetCreature((*me), MedivhGUID);
                if (medivh && urand(0, ABILITY_CHANCE_MAX) < ability1Chance)
                {
                    if (IsOnSelfSpell(ability1ID))
                    {
                        ab1 = me->GetGUID();
                        ab1Self = true;
                    }
                    else
                        ab1 = ((npc_echo_of_medivhAI*)medivh->AI())->GetSpellTarget(me->GetGUID(), ability1ID);
                }
                else
                    ability1Timer = urand(500, 5000);
            }
            else
                ability1Timer -= diff;

            if (ability2Timer <= diff && !me->isCharmed())
            {
                Creature * medivh = me->GetCreature((*me), MedivhGUID);
                if (medivh && urand(0, ABILITY_CHANCE_MAX) < ability2Chance)
                {
                    if (IsOnSelfSpell(ability2ID))
                    {
                        ab2 = me->GetGUID();
                        ab2Self = true;
                    }
                    else
                        ab2 = ((npc_echo_of_medivhAI*)medivh->AI())->GetSpellTarget(me->GetGUID(), ability2ID);
                }
                else
                    ability2Timer = urand(500, 5000);
            }
            else
                ability2Timer -= diff;


            if (ab1 && ab2 && !me->isCharmed())
            {
                if (urand(0, ABILITY_CHANCE_MAX) < (IsHealingSpell(ab1) ? HEALING_ABILITY_CHANCE : NORMAL_ABILITY_CHANCE))
                    ab2 = 0;
                else
                    ab1 = 0;
            }
             
            if (ab1 && !me->isCharmed())
            {
                if (IsNullTargetSpell(ability1ID))
                    me->CastSpell(NULL, sSpellMgr->GetSpellInfo(ability1ID));
                else
                {
                    Unit * victim = me->GetUnit((*me), ab1);
                    if (victim)
                        me->CastSpell(victim, sSpellMgr->GetSpellInfo(ability1ID));
                }

                ability1Timer = ability1Cooldown;
                ability2Timer = SHARED_COOLDOWN;
            }
            else if (ab2 && !me->isCharmed())
            {
                if (IsNullTargetSpell(ability2ID))
                    me->CastSpell(NULL, sSpellMgr->GetSpellInfo(ability2ID));
                else
                {
                    Unit * victim = me->GetUnit((*me), ab2);
                    if (victim)
                        me->CastSpell(victim, sSpellMgr->GetSpellInfo(ability2ID));
                }

                ability2Timer = ability1Cooldown;
                ability1Timer = SHARED_COOLDOWN;
            }

			if ((me->getFaction() == A_FACTION && pInstance->GetData(CHESS_EVENT_TEAM) == HORDE) ||
               (me->getFaction() == H_FACTION && pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE))	
			{
				if (changeFacingTimer <= diff)
				{
					changeFacingTimer = urand(3000, 7500);

					Creature * medivh = me->GetCreature((*me), MedivhGUID);

					if (!medivh)
						return;

					((npc_echo_of_medivhAI*)medivh->AI())->CheckChangeFacing(me->GetGUID());
				}
				else
					changeFacingTimer -= diff;
			}

            if (attackTimer <= diff)
            {
                attackTimer = attackCooldown;
                Creature * medivh = me->GetCreature((*me), MedivhGUID);

                if (!medivh)
                    return;

                Unit * uVictim = me->GetUnit((*me), ((npc_echo_of_medivhAI*)medivh->AI())->GetMeleeTarget(me->GetGUID()));
                if (uVictim)
                {
                    me->AttackerStateUpdate(uVictim);
                }
            }
            else
                attackTimer -= diff;
        }
	};
     
      bool OnGossipHello(Player* player, Creature* _Creature)
      {
          InstanceScript* pInstance = ((InstanceScript*)_Creature->GetInstanceScript());

        if (!pInstance)
            return false;

		if (pInstance->GetData(DATA_CHESS_EVENT) != IN_PROGRESS)
			if (_Creature->GetEntry() != NPC_KING_H && _Creature->GetEntry() != NPC_KING_A)
			return false;

        if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE && _Creature->getFaction() != A_FACTION)
            return false;
        
        if (pInstance->GetData(CHESS_EVENT_TEAM) == HORDE && _Creature->getFaction() != H_FACTION)
            return false;

        if (player->HasAura(SPELL_RECENTLY_IN_GAME, 0) || _Creature->HasAura(SPELL_RECENTLY_IN_GAME, 0))
        {
            player->SEND_GOSSIP_MENU(10505, _Creature->GetGUID());
            return true;
        }

        if (!(_Creature->isPossessedByPlayer()))
        {
            switch (_Creature->GetEntry())
            {
                case NPC_PAWN_H:
                    player->ADD_GOSSIP_ITEM(0, "Control Orc Grunt", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10425, _Creature->GetGUID());
                    break;
                case NPC_PAWN_A:
                    player->ADD_GOSSIP_ITEM(0, "Control Human Footman", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(8952, _Creature->GetGUID());
                    break;
                case NPC_KNIGHT_H:
                    player->ADD_GOSSIP_ITEM(0, "Control Orc Wolf", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10439, _Creature->GetGUID());
                    break;
                case NPC_KNIGHT_A:
                    player->ADD_GOSSIP_ITEM(0, "Control Human Charger", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10414, _Creature->GetGUID());
                    break;
                case NPC_QUEEN_H:
                    player->ADD_GOSSIP_ITEM(0, "Control Orc Warlock", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10440, _Creature->GetGUID());
                    break;
                case NPC_QUEEN_A:
                    player->ADD_GOSSIP_ITEM(0, "Control Human Conjurer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10417, _Creature->GetGUID());
                    break;
                case NPC_BISHOP_H:
                    player->ADD_GOSSIP_ITEM(0, "Control Orc Necrolyte", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10434, _Creature->GetGUID());
                    break;
                case NPC_BISHOP_A:
                    player->ADD_GOSSIP_ITEM(0, "Control Human Cleric", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10416, _Creature->GetGUID());
                    break;
                case NPC_ROOK_H:
                    player->ADD_GOSSIP_ITEM(0, "Control Summoned Daemon", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10426, _Creature->GetGUID());
                    break;
                case NPC_ROOK_A:
                    player->ADD_GOSSIP_ITEM(0, "Control Conjured Water Elemental", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10413, _Creature->GetGUID());
                    break;
                case NPC_KING_H:
                    player->ADD_GOSSIP_ITEM(0, "Control Warchief Blackhand", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10442, _Creature->GetGUID());
                    break;
                case NPC_KING_A:
                    player->ADD_GOSSIP_ITEM(0, "Control King Llane", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->SEND_GOSSIP_MENU(10418, _Creature->GetGUID());
                    break;
            }
        }

        return true;
      }
     
      bool OnGossipSelect(Player* player, Creature* _Creature, uint32 sender, uint32 action)
      {
          InstanceScript* pInstance = ((InstanceScript*)_Creature->GetInstanceScript());

        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            if (_Creature->GetEntry() == NPC_KING_A || _Creature->GetEntry() == NPC_KING_H)
            {
				if (pInstance->GetData(DATA_CHESS_EVENT) != IN_PROGRESS) {
					_Creature->GetCreature((*_Creature), pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH))->MonsterSay(SAY_AT_EVENT_START, LANG_UNIVERSAL, NULL);
					_Creature->GetCreature((*_Creature), pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH))->PlayDirectSound(SOUND_START);
					pInstance->SetData(DATA_CHESS_EVENT, IN_PROGRESS);
				}
                ((npc_echo_of_medivhAI*)(_Creature->GetCreature((*_Creature), pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH))->AI()))->StartEvent();
            }

            player->TeleportTo(_Creature->GetMapId(), -11108.2f, -1841.56f, 229.625f, 5.39745f);
            player->CastSpell(_Creature, SPELL_POSSES_CHESSPIECE, true);
        }

        player->CLOSE_GOSSIP_MENU();

        return true;
      }
 };
     
    class npc_echo_of_medivh : public CreatureScript
      {
      public:
        npc_echo_of_medivh() : CreatureScript("npc_echo_of_medivh") { }
     
        CreatureAI* GetAI(Creature* creature) const
        {
          return new npc_echo_of_medivhAI(creature);
        }
     

        bool OnGossipHello(Player* player, Creature* _Creature)
        {
            InstanceScript* pInstance = ((InstanceScript*)_Creature->GetInstanceScript());

            if (pInstance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
				return false;

			if ((!player->GetGroup() || !player->GetGroup()->IsLeader(player->GetGUID())) && !player->isGameMaster())
			{
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Je ne suis pas le Chef du Raid...", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                    player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _Creature->GetGUID());
                    return true;
            }

			if (pInstance->GetData(DATA_CHESS_EVENT) == NOT_STARTED || pInstance->GetData(DATA_CHESS_EVENT) == FAIL) {
				player->ADD_GOSSIP_ITEM(0, EVENT_START, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
				player->SEND_GOSSIP_MENU(10506, _Creature->GetGUID());
			}

			if (pInstance->GetData(DATA_CHESS_EVENT) == DONE) {
				player->ADD_GOSSIP_ITEM(0, EVENT_REDO_CHESS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF +1);
				player->SEND_GOSSIP_MENU(10506, _Creature->GetGUID());
			}

			pInstance->SetData(DATA_CHESS_EVENT, NOT_STARTED);

            return true;
        }
     
        bool OnGossipSelect(Player* player, Creature* _Creature, uint32 sender, uint32 action)
        {
            InstanceScript* pInstance = ((InstanceScript*)_Creature->GetInstanceScript());

            if (action == GOSSIP_ACTION_INFO_DEF || action == GOSSIP_ACTION_INFO_DEF + 1)
            {
                ((npc_echo_of_medivhAI*)_Creature->AI())->StartMiniEvent();

                pInstance->SetData(CHESS_EVENT_TEAM, player->GetTeam());
            }

			player->CLOSE_GOSSIP_MENU();

            return true;
        }
      };

    class npc_chess_status : public CreatureScript
    {
    public:
      npc_chess_status() : CreatureScript("npc_chess_status") { }
     
      CreatureAI* GetAI(Creature* creature) const
      {
        return new npc_chess_statusAI(creature);
      }
     
      struct npc_chess_statusAI : public ScriptedAI
      {
        npc_chess_statusAI(Creature* c) : ScriptedAI(c)
        {
        }
     
        void Reset()
        {
            me->SetLevitate(true);
            me->NearTeleportTo(-11080.599609f, -1876.380005f, 231.000092f, 0.0f);
            me->CastSpell(me, SPELL_GAME_IN_SESSION, false);
        }

      };
    };


class spell_dummy_change_facing : public SpellScriptLoader
{
    public:
        spell_dummy_change_facing() : SpellScriptLoader("spell_dummy_change_facing") { }

        class spell_dummy_change_facing_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dummy_change_facing_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
				Creature *target = GetHitCreature();
				float posX, posY;
				if (target) {
					target->GetPosition(posX,posY);

					if (target->GetEntry() == TRIGGER_ID) {
						if (WorldLocation *offset = GetHitDest()) {
							if (offset->GetExactDist2d(posX,posY) <= 4.0f) {
								target->GetAI()->SetGUID(GetCaster()->GetGUID());
								target->GetAI()->DoAction(ACTION_CHANGE_FACING);
							}
						}
					}
				}
			}

			void FilterTargets(std::list<Unit*>& targetList)
            {
				std::list<Creature*> triggers;

				GetCreatureListWithEntryInGrid(triggers, GetCaster(), TRIGGER_ID, 40.0f);

				if (triggers.empty())
					return;

				for(std::list<Creature*>::iterator iter = triggers.begin(); iter != triggers.end(); ++iter)
				{
					targetList.push_back((*iter));
				}
            }

			void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dummy_change_facing_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
				OnUnitTargetSelect += SpellUnitTargetFn(spell_dummy_change_facing_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dummy_change_facing_SpellScript();
        }
};

class spell_dummy_movement : public SpellScriptLoader
{
    public:
        spell_dummy_movement() : SpellScriptLoader("spell_dummy_movement") { }

        class spell_dummy_movement_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dummy_movement_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
				Creature *target = GetHitCreature();
				float posX, posY;
				if (target) {
						target->GetPosition(posX,posY);

					if (target->GetEntry() == TRIGGER_ID) {
						if (WorldLocation *offset = GetHitDest()) {
							if (offset->GetExactDist2d(posX,posY) <= 3.0f) {
								GetCaster()->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
								target->GetAI()->SetGUID(GetCaster()->GetGUID());
								target->GetAI()->DoAction(ACTION_MOVEMENT);
							}
						}
					}
				}
			}

			void FilterTargets(std::list<Unit*>& targetList)
            {
				std::list<Creature*> triggers;

				GetCreatureListWithEntryInGrid(triggers, GetCaster(), TRIGGER_ID, 40.0f);

				if (triggers.empty())
					return;

				for(std::list<Creature*>::iterator iter = triggers.begin(); iter != triggers.end(); ++iter)
				{
					targetList.push_back((*iter));
				}
            }

			void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dummy_movement_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
				OnUnitTargetSelect += SpellUnitTargetFn(spell_dummy_movement_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dummy_movement_SpellScript();
        }
};

class spell_vicious_strike : public SpellScriptLoader
{
    public:
        spell_vicious_strike() : SpellScriptLoader("spell_vicious_strike") { }

        class spell_vicious_strike_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_vicious_strike_SpellScript);

			void FilterTargets(std::list<Unit*>& targetList)
            {
				targetList.clear();
				Unit *caster = GetCaster();
				if (!caster)
					return;
				Map *map = caster->GetMap();
				if (!map)
					return;

				std::list<Creature*> targetsInRange;
				InstanceScript* pInstance = ((InstanceScript*)GetCaster()->GetInstanceScript());
				if (!pInstance)
					return;

				Creature *npc_medivh = GetCaster()->GetCreature(*(GetCaster()), pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH));
				if (!npc_medivh)
					return;

				Creature * tmpC;
				for (int i = 0; i < 8; ++i)
				{
					for (int j = 0; j < 8; ++j)
					{
						if (tmpC = GetCaster()->GetCreature(*(GetCaster()), ((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[i][j].piece))
						{
							targetsInRange.push_back(tmpC);
						}
					}
				}

				if (targetsInRange.empty())
					return;
				for (std::list<Creature*>::iterator i = targetsInRange.begin(); i != targetsInRange.end(); ++i)
					if (targetList.empty()) // une cible max!
						if (caster->isInFrontInMap((*i)->ToUnit(), 4.0f, static_cast<float>(M_PI / 12)))
							if (caster->getFaction() != (*i)->getFaction())
								targetList.push_back((*i));
            }

			void Register()
            {
				OnUnitTargetSelect += SpellUnitTargetFn(spell_vicious_strike_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_CONE_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_vicious_strike_SpellScript();
        }
};

class spell_howl_stomp : public SpellScriptLoader
{
    public:
        spell_howl_stomp() : SpellScriptLoader("spell_howl_stomp") { }

        class spell_howl_stomp_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_howl_stomp_SpellScript);

			void FilterTargets(std::list<Unit*>& targetList)
            {
				targetList.clear();
				Unit *caster = GetCaster();
				if (!caster)
					return;

				std::list<Creature*> targetsInRange;

				InstanceScript* pInstance = ((InstanceScript*)GetCaster()->GetInstanceScript());
				if (!pInstance)
					return;

				Creature *npc_medivh = caster->GetCreature(*caster, pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH));
				if (!npc_medivh)
					return;

				int tmpI = -1, tmpJ = -1;
				if (!((npc_echo_of_medivhAI*)npc_medivh->AI())->FindPlaceInBoard(caster->GetGUID(), tmpI, tmpJ))
                {
                    caster->MonsterSay("Cible introuvable sur la carte !!", LANG_UNIVERSAL, 0);
                    return;
                }

				switch (((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ].ori)
				{
					case CHESS_ORI_E:
						if (tmpJ + 1 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ + 1].piece));
						if (tmpJ + 1 <= 7 && tmpI - 1 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI-1][tmpJ + 1].piece));
						if (tmpJ + 1 <= 7 && tmpI + 1 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI+1][tmpJ + 1].piece));
						break;
					case CHESS_ORI_N:
						if (tmpI - 1 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI - 1][tmpJ].piece));
						if (tmpI - 1 >= 0 && tmpJ - 1 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI - 1][tmpJ - 1].piece));
						if (tmpI - 1 >= 0 && tmpJ + 1 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI - 1][tmpJ + 1].piece));
						break;
					case CHESS_ORI_S:
						if (tmpI + 1 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI + 1][tmpJ].piece));
						if (tmpI + 1 <= 7 && tmpJ - 1 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI + 1][tmpJ - 1].piece));
						if (tmpI + 1 <= 7 && tmpJ + 1 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI + 1][tmpJ + 1].piece));
						break;
					case CHESS_ORI_W:
						if (tmpJ - 1 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ - 1].piece));
						if (tmpJ - 1 >= 0 && tmpI - 1 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI - 1][tmpJ - 1].piece));
						if (tmpJ - 1 >= 0 && tmpI + 1 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI + 1][tmpJ - 1].piece));
						break;
					default:
						break;
				}

				if (targetsInRange.empty())
					return;
				for (std::list<Creature*>::iterator i = targetsInRange.begin(); i != targetsInRange.end(); ++i){
					if ((*i) != NULL)
						if (caster->getFaction() != (*i)->getFaction())
							targetList.push_back((*i));
				}

            }

			void Register()
            {
				OnUnitTargetSelect += SpellUnitTargetFn(spell_howl_stomp_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_CONE_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_howl_stomp_SpellScript();
        }
};

class spell_hellfire_geyser : public SpellScriptLoader
{
    public:
        spell_hellfire_geyser() : SpellScriptLoader("spell_hellfire_geyser") { }

        class spell_hellfire_geyser_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hellfire_geyser_SpellScript);

			void FilterTargets(std::list<Unit*>& targetList)
            {
				InstanceScript* pInstance = ((InstanceScript*)GetCaster()->GetInstanceScript());
				if (!pInstance)
					return;

				Creature *npc_medivh = GetCaster()->GetCreature(*(GetCaster()), pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH));
				if (!npc_medivh)
					return;

				Creature * tmpC;
				for (int i = 0; i < 8; ++i)
				{
					for (int j = 0; j < 8; ++j)
					{
						if (tmpC = GetCaster()->GetCreature(*(GetCaster()), ((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[i][j].piece))
						{
							targetList.push_back(tmpC);
						}
					}
				}

				float posX, posY;
				GetCaster()->GetPosition(posX,posY);
				for(std::list<Unit*>::iterator iter = targetList.begin(); iter != targetList.end(); ++iter)
				{
					if ((*iter)->getFaction() == GetCaster()->getFaction() || ((*iter)->getFaction() != A_FACTION && (*iter)->getFaction() != H_FACTION) || (*iter)->GetExactDist2d(posX,posY) > 9.0f )
						targetList.remove(*iter);
				}
            }

			void Register()
            {
				OnUnitTargetSelect += SpellUnitTargetFn(spell_hellfire_geyser_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hellfire_geyser_SpellScript();
        }
};

class spell_spear_lance : public SpellScriptLoader
{
    public:
        spell_spear_lance() : SpellScriptLoader("spell_spear_lance") { }

        class spell_spear_lance_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_spear_lance_SpellScript);

			void FilterTargets(std::list<Unit*>& targetList)
            {
				targetList.clear();
				Unit *caster = GetCaster();
				if (!caster)
					return;

				std::list<Creature*> targetsInRange;

				InstanceScript* pInstance = ((InstanceScript*)GetCaster()->GetInstanceScript());
				if (!pInstance)
					return;

				Creature *npc_medivh = caster->GetCreature(*caster, pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH));
				if (!npc_medivh)
					return;

				int tmpI = -1, tmpJ = -1;
				if (!((npc_echo_of_medivhAI*)npc_medivh->AI())->FindPlaceInBoard(caster->GetGUID(), tmpI, tmpJ))
                {
                    caster->MonsterSay("Cible introuvable sur la carte !!", LANG_UNIVERSAL, 0);
                    return;
                }

				switch (((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ].ori)
				{
					case CHESS_ORI_E:
						if (tmpJ + 1 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ + 1].piece));
						if (tmpJ + 2 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ + 2].piece));
						if (tmpJ + 3 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ + 3].piece));
						break;
					case CHESS_ORI_N:
						if (tmpI - 1 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI - 1][tmpJ].piece));
						if (tmpI - 2 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI - 2][tmpJ].piece));
						if (tmpI - 3 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI - 3][tmpJ].piece));
						break;
					case CHESS_ORI_S:
						if (tmpI + 1 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI + 1][tmpJ].piece));
						if (tmpI + 2 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI + 2][tmpJ].piece));
						if (tmpI + 3 <= 7)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI + 3][tmpJ].piece));
						break;
					case CHESS_ORI_W:
						if (tmpJ - 1 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ - 1].piece));
						if (tmpJ - 2 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ - 2].piece));
						if (tmpJ - 3 >= 0)
							targetsInRange.push_back(caster->GetCreature(*caster,((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[tmpI][tmpJ - 3].piece));
						break;
					default:
						break;
				}

				if (targetsInRange.empty())
					return;
				for (std::list<Creature*>::iterator i = targetsInRange.begin(); i != targetsInRange.end(); ++i){
					if ((*i) != NULL)
						if (caster->getFaction() != (*i)->getFaction())
							targetList.push_back((*i));
				}
            }

			void Register()
            {
				OnUnitTargetSelect += SpellUnitTargetFn(spell_spear_lance_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_CONE_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_spear_lance_SpellScript();
        }
};

class spell_bloodlust_heroism : public SpellScriptLoader
{
    public:
        spell_bloodlust_heroism() : SpellScriptLoader("spell_bloodlust_heroism") { }

        class spell_bloodlust_heroism_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_bloodlust_heroism_SpellScript);

			void FilterTargets(std::list<Unit*>& targetList)
            {
				InstanceScript* pInstance = ((InstanceScript*)GetCaster()->GetInstanceScript());
				if (!pInstance)
					return;

				Creature *npc_medivh = GetCaster()->GetCreature(*(GetCaster()), pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH));
				if (!npc_medivh)
					return;

				Creature * tmpC;
				for (int i = 0; i < 8; ++i)
				{
					for (int j = 0; j < 8; ++j)
					{
						if (tmpC = GetCaster()->GetCreature(*(GetCaster()), ((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[i][j].piece))
						{
							targetList.push_back(tmpC);
						}
					}
				}
				bool needRemove = false;
				for(std::list<Unit*>::iterator iter = targetList.begin(); iter != targetList.end(); ++iter)
				{
					needRemove = false;
					float posX, posY;
					GetCaster()->GetPosition(posX,posY);
					if ((*iter)->GetExactDist2d(posX,posY) > 8.0f)
						needRemove = true;
					if (GetCaster()->GetGUID() == (*iter)->GetGUID())
						needRemove = true;
					if (((npc_echo_of_medivhAI*)npc_medivh->AI())->isHorde((GetCaster())->GetEntry()) && ((npc_echo_of_medivhAI*)npc_medivh->AI())->isAlliance((*iter)->GetEntry()))
						needRemove = true;
					if (((npc_echo_of_medivhAI*)npc_medivh->AI())->isAlliance((GetCaster())->GetEntry()) && ((npc_echo_of_medivhAI*)npc_medivh->AI())->isHorde((*iter)->GetEntry()))
						needRemove = true;
					if (needRemove)
						targetList.remove(*iter);
				}
            }

			void Register()
            {
				OnUnitTargetSelect += SpellUnitTargetFn(spell_bloodlust_heroism_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_bloodlust_heroism_SpellScript();
        }
};

class spell_cleave_sweep : public SpellScriptLoader
{
    public:
        spell_cleave_sweep() : SpellScriptLoader("spell_cleave_sweep") { }

        class spell_cleave_sweep_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_cleave_sweep_SpellScript);

			void FilterTargets(std::list<Unit*>& targetList)
            {
				InstanceScript* pInstance = ((InstanceScript*)GetCaster()->GetInstanceScript());
				if (!pInstance)
					return;

				Creature *npc_medivh = GetCaster()->GetCreature(*(GetCaster()), pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH));
				if (!npc_medivh)
					return;

				Creature * tmpC;
				for (int i = 0; i < 8; ++i)
				{
					for (int j = 0; j < 8; ++j)
					{
						if (tmpC = GetCaster()->GetCreature(*(GetCaster()), ((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[i][j].piece))
						{
							targetList.push_back(tmpC);
						}
					}
				}

				float posX, posY;
				GetCaster()->GetPosition(posX,posY);
				for(std::list<Unit*>::iterator iter = targetList.begin(); iter != targetList.end(); ++iter)
				{
					if ((*iter)->getFaction() == GetCaster()->getFaction() || ((*iter)->getFaction() != A_FACTION && (*iter)->getFaction() != H_FACTION) || (*iter)->GetExactDist2d(posX,posY) > 9.0f )
						targetList.remove(*iter);
				}
            }

			void Register()
            {
				OnUnitTargetSelect += SpellUnitTargetFn(spell_cleave_sweep_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_cleave_sweep_SpellScript();
        }
};

class spell_fury_of_medivh : public SpellScriptLoader
{
    public:
        spell_fury_of_medivh() : SpellScriptLoader("spell_fury_of_medivh") { }

        class spell_fury_of_medivh_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_fury_of_medivh_SpellScript);

			void FilterTargetsA(std::list<Unit*>& targetList)
            {
				targetList.clear();

				InstanceScript* pInstance = ((InstanceScript*)GetCaster()->GetInstanceScript());

				if (!pInstance)
					return;

				Creature *npc_medivh = GetCaster()->GetCreature(*(GetCaster()), pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH));
				if (!npc_medivh)
					return;

				Creature * tmpC;
				for (int i = 0; i < 8; ++i)
				{
					for (int j = 0; j < 8; ++j)
					{
						if (tmpC = GetCaster()->GetCreature(*(GetCaster()), ((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[i][j].piece))
						{
							targetList.push_back(tmpC);
						}
					}
				}

				bool needRemove;
				
				for(std::list<Unit*>::iterator iter = targetList.begin(); iter != targetList.end(); ++iter)
				{
					needRemove = false;
					float posX, posY;
					GetCaster()->GetPosition(posX, posY);

					if ((*iter)->GetExactDist2d(posX, posY) > 1.0f)
						needRemove = true;

					if (((npc_echo_of_medivhAI*)npc_medivh->AI())->isHorde((*iter)->GetEntry()))
						needRemove = true;

					if (pInstance->GetData(CHESS_EVENT_TEAM) == HORDE)
						needRemove = true;
					if (needRemove)
						targetList.remove(*iter);
				}
            }

			void FilterTargetsH(std::list<Unit*>& targetList)
            {
				targetList.clear();

				InstanceScript* pInstance = ((InstanceScript*)GetCaster()->GetInstanceScript());
				if (!pInstance)
					return;

				Creature *npc_medivh = GetCaster()->GetCreature(*(GetCaster()), pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH));
				if (!npc_medivh)
					return;

				Creature * tmpC;
				for (int i = 0; i < 8; ++i)
				{
					for (int j = 0; j < 8; ++j)
					{
						if (tmpC = GetCaster()->GetCreature(*(GetCaster()), ((npc_echo_of_medivhAI*)npc_medivh->AI())->chessBoard[i][j].piece))
						{
							targetList.push_back(tmpC);
						}
					}
				}

				bool needRemove;
				
				for(std::list<Unit*>::iterator iter = targetList.begin(); iter != targetList.end(); ++iter)
				{
					needRemove = false;
					float posX, posY;
					GetCaster()->GetPosition(posX, posY);

					if ((*iter)->GetExactDist2d(posX, posY) > 1.0f)
						needRemove = true;

					if (((npc_echo_of_medivhAI*)npc_medivh->AI())->isAlliance((*iter)->GetEntry()))
						needRemove = true;

					if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
						needRemove = true;
					if (needRemove)
						targetList.remove(*iter);
				}
            }

			void Register()
            {
				OnUnitTargetSelect += SpellUnitTargetFn(spell_fury_of_medivh_SpellScript::FilterTargetsA, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
				OnUnitTargetSelect += SpellUnitTargetFn(spell_fury_of_medivh_SpellScript::FilterTargetsH, EFFECT_1, TARGET_UNIT_SRC_AREA_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_fury_of_medivh_SpellScript();
        }
};
     
    void AddSC_chess_event()
      {
        new chess_npc();
        new npc_echo_of_medivh();
        new chess_move_trigger();
        new npc_chess_status();
		new spell_dummy_change_facing();
		new spell_dummy_movement();
		new spell_vicious_strike();
		new spell_hellfire_geyser();
		new spell_spear_lance();
		new spell_bloodlust_heroism();
		new spell_howl_stomp();
		new spell_cleave_sweep();
		new spell_fury_of_medivh();
      }

