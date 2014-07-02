#ifndef SC_CHESS_EVENT_H
#define SC_CHESS_EVENT_H

/* ScriptData
SDName: Chess_Event
SD%Complete: xx
SDCategory: Karazhan

TODO:
 - Fix spells (Game in session, Rain of Fire, Poison Cloud (it's all ? ))
EndScriptData */

#include "karazhan.h"

#define A_FACTION  1690
#define H_FACTION  1689

//#define EVENT_START         "Preparer l'echiquier" // Maybe should be different gossip, visuals will be fixed at the end :]
#define TRIGGER_ID          22519
//#define DUST_COVERED_CHEST  185119

    #define ALLI_CREATURE_FACTION 1690
    #define HORDE_CREATURE_FACTION 1689
    #define DUST_COVERED_CHEST  185119.0f

#define DUST_COVERED_CHEST_LOCATION -11061.6f, -1900.3f, 221.1f, 2.219765f

#define ALLIANCE_DEAD_X1        -11081.2 //-11047.8
#define ALLIANCE_DEAD_X2        -11082.8 //-11046.1
#define ALLIANCE_DEAD_Y1        -1842.2
#define ALLIANCE_DEAD_Y2        -1840.1 //-1886.4
#define HORDE_DEAD_X1           -11080.4
#define HORDE_DEAD_X2           -11078.7
#define HORDE_DEAD_Y1           -1910.2
#define HORDE_DEAD_Y2           -1912.2
#define POSITION_Z              220.66f

#define GOSSIP_POSSES "Prendre la piece" //need correction 
#define EVENT_START "Placer l'echiquier"
#define NPC_ATTACK_RADIUS 7
#define SAY_AT_EVENT_START "Tres bien. Que la partie commence!"
#define SOUND_START 10338
#define SAY_LOSE_KNIGHT_P "Oui...tout se deroule comme prevu."
#define SOUND_KNIGHT_LOSE_P 10349
#define SAY_LOSE_KNIGHT_M "Oui... Naturellement."
#define SOUND_KNIGHT_LOSE_M 10350
#define SAY_LOSE_PAWN_P_1 "Un stratageme transparent."
#define SOUND_LOSE_PAWN_P_1 10339
#define SAY_LOSE_PAWN_P_2 "Reflechissons..."
#define SOUND_LOSE_PAWN_P_2 10340
#define SAY_LOSE_PAWN_P_3 "Ah, les roues ont commence a tourner."
#define SOUND_LOSE_PAWN_P_3 10341
#define SAY_LOSE_PAWN_M_1 "Hmm."
#define SOUND_LOSE_PAWN_M_1 10342
#define SAY_LOSE_PAWN_M_2 "Peu importe !"
#define SOUND_LOSE_PAWN_M_2 10344
#define SAY_LOSE_PAWN_M_3 "Interessant."
#define SOUND_LOSE_PAWN_M_3 10343
#define SAY_LOSE_QUEEN_P "Maintenant ça devient interessant."
#define SOUND_LOSE_QUEEN_P 10351
#define SAY_LOSE_QUEEN_M "Ahh, j'aurai du le savoir."
#define SOUND_LOSE_QUEEN_M 10352
#define SAY_LOSE_BISHOP_P "Tout ce qu'il faut, c'est ne pas perdre sa concentration."
#define SOUND_LOSE_BISHOP_P 10347
#define SAY_LOSE_BISHOP_M "Un sacrifice necessaire."
#define SOUND_LOSE_BISHOP_M 10348
#define SAY_LOSE_ROOK_P "Stupide ! Tres stupide !"
#define SOUND_LOSE_ROOK_P 10345
#define SAY_LOSE_ROOK_M "Une preoccupation mineure."
#define SOUND_LOSE_ROOK_M 10346

#define SAY_PLAYER_CHECK "Et donc la fin approche."
#define SOUND_PLAYER_CHECK 10353
#define SAY_MEDIVH_CHECK "Comme cela devrait etre."
#define SOUND_MEDIVH_CHECK 10354

#define SAY_PLAYER_WIN "Et donc la fin approche."
#define SOUND_PLAYER_WIN 10355
#define SAY_MEDIVH_WIN "Rien ne pourra se faire sans la perfection."
#define SOUND_MEDIVH_WIN 10356

#define SAY_MEDIVH_CHEAT_1 "Peut-etre qu'un changement est bon."
#define SOUND_MEDIVH_CHEAT_1 10357
#define SAY_MEDIVH_CHEAT_2 "Il est temps pour un scenario alternatif."
#define SOUND_MEDIVH_CHEAT_2 10358
#define SAY_MEDIVH_CHEAT_3 "Il ne faut pas devenir trop confiant."
#define SOUND_MEDIVH_CHEAT_3 10359

    #define TRIGGER_ID 22519
     
    #define SEARCH_RANGE 5

                                //x, y, z
#define SPAWN_POS               wLoc.m_positionX, wLoc.m_positionY, wLoc.m_positionZ

#define START_PRIORITY                  100
#define RAND_PRIORITY                   100
#define MELEE_PRIORITY                  25

// pawns
#define MELEE_PRIORITY_1_0              30
#define MELEE_PRIORITY_1_1              50
#define MELEE_PRIORITY_1_2              25
#define MELEE_PRIORITY_1_3              -25
#define MELEE_PRIORITY_1_4              -50
// rooks/knights
#define MELEE_PRIORITY_2_0              25
#define MELEE_PRIORITY_2_1              50
#define MELEE_PRIORITY_2_2              75
#define MELEE_PRIORITY_2_3              75
#define MELEE_PRIORITY_2_4              75
// kings
#define MELEE_PRIORITY_3_0              25
#define MELEE_PRIORITY_3_1              50
#define MELEE_PRIORITY_3_2              50
#define MELEE_PRIORITY_3_3              35
#define MELEE_PRIORITY_3_4              -25
// quens/bishops
#define MELEE_PRIORITY_4_0              25
#define MELEE_PRIORITY_4_1              30
#define MELEE_PRIORITY_4_2              0
#define MELEE_PRIORITY_4_3              -25
#define MELEE_PRIORITY_4_4              -50

#define ATTACK_KING_PRIOR               50
#define ATTACK_HEALER_PRIOR             50

#define MELEE_ENEMY_COUNT_PRIOR_MOD_1   50
#define MELEE_ENEMY_COUNT_PRIOR_MOD_2   25
#define MELEE_ENEMY_COUNT_PRIOR_MOD_3   -25
#define MELEE_ENEMY_COUNT_PRIOR_MOD_4   -50

#define MOVE_BACK_PRIOR_MOD             -75
#define MOVE_STRAFE_PRIOR_MOD           -50
#define STAY_IN_PLACE_PRIOR_MOD         0
#define MOVE_DEFAULT_PRIOR_MOD          25

#define ABILITY_CHANCE_MAX      100
#define HEALING_ABILITY_CHANCE  75
#define NORMAL_ABILITY_CHANCE   50
#define ABILITY_1_CHANCE_MIN    25
#define ABILITY_1_CHANCE_MAX    66
#define ABILITY_2_CHANCE_MIN    25
#define ABILITY_2_CHANCE_MAX    66

#define MIN_MOVE_CHANCE         33
#define MAX_MOVE_CHANCE         90

#define MIN_SELF_MOVE_CHANCE    25
#define MAX_SELF_MOVE_CHANCE    50

#define RAND_MAX_VAL            1000

#define attackCooldown          urand(2000, 4000)
#define SHARED_COOLDOWN         5000

#define ADD_PIECE_TO_MOVE_TIMER urand(2000, 5000);

#define ORI_N           0.656777f
#define ORI_E           5.391155f
#define ORI_S           3.817220f
#define ORI_W           2.239354f

#define PIECES_HP_SUM           1040000
#define FIRST_CHEAT_HP_MIN      PIECES_HP_SUM/10
#define FIRST_CHEAT_HP_MAX      PIECES_HP_SUM/6
#define SECOND_CHEAT_HP_MIN     PIECES_HP_SUM/5
#define SECOND_CHEAT_HP_MAX     PIECES_HP_SUM/2
#define THIRD_CHEAT_HP_MIN      PIECES_HP_SUM - PIECES_HP_SUM/5
#define THIRD_CHEAT_HP_MAX      PIECES_HP_SUM - PIECES_HP_SUM/9

#define FIRST_CHEAT_TIMER_MIN   60000
#define FIRST_CHEAT_TIMER_MAX   90000
#define SECOND_CHEAT_TIMER_MIN  75000
#define SECOND_CHEAT_TIMER_MAX  120000
#define THIRD_CHEAT_TIMER_MIN   120000
#define THIRD_CHEAT_TIMER_MAX   180000

//#define CHESS_DEBUG_INFO                            1
//#define CHESS_EVENT_DISSABLE_MEDIVH_PIECES_MOVEMENT 1
//#define CHESS_EVENT_DISSABLE_MEDIVH_PIECES_SPELLS   1
//#define CHESS_EVENT_DISSABLE_MELEE                  1
//#define CHESS_EVENT_DISSABLE_FACING                 1

enum NPCs
{
    NPC_MEDIVH   = 16816,
    NPC_PAWN_H   = 17469,
    NPC_PAWN_A   = 17211,
    NPC_KNIGHT_H = 21748,
    NPC_KNIGHT_A = 21664,
    NPC_QUEEN_H  = 21750,
    NPC_QUEEN_A  = 21683,
    NPC_BISHOP_H = 21747,
    NPC_BISHOP_A = 21682,
    NPC_ROOK_H   = 21726,
    NPC_ROOK_A   = 21160,
    NPC_KING_H   = 21752,
    NPC_KING_A   = 21684,
    NPC_STATUS   = 22520
};

enum ChessEventSpells
{
    SPELL_MOVE_1   = 37146,
    SPELL_MOVE_2   = 30012,
    SPELL_MOVE_3   = 37144,
    SPELL_MOVE_4   = 37148,
    SPELL_MOVE_5   = 37151,
    SPELL_MOVE_6   = 37152,
    SPELL_MOVE_7   = 37153,

    SPELL_MOVE_PREVISUAL = 32745,

    SPELL_CHANGE_FACING     = 30284,
    SPELL_MOVE_MARKER       = 32261,
    SPELL_POSSES_CHESSPIECE = 30019,
    SPELL_IN_GAME           = 30532,
    SPELL_GAME_IN_SESSION   = 39331,
    SPELL_RECENTLY_IN_GAME  = 30529,
    SPELL_FURY_OF_MEDIVH    = 39383,  // 1st cheat: AOE spell burn cell under enemy chesspieces.
    SPELL_HAND_OF_MEDIVH    = 39339,  // 2nd cheat: Berserk own chesspieces.
    // 3rd cheat: set own creatures to max health
    SPELL_GAME_OVER         = 39401
};

enum ChessPiecesSpells
{
    //ability 1
    SPELL_KING_H_1    = 37476,    //Cleave
    SPELL_KING_A_1    = 37474,    //Sweep
    SPELL_QUEEN_H_1   = 37463,    //Fireball
    SPELL_QUEEN_A_1   = 37462,    //Elemental Blast
    SPELL_BISHOP_H_1  = 37456,    //Shadow Mend
    SPELL_BISHOP_A_1  = 37455,    //Healing
    SPELL_KNIGHT_H_1  = 37454,    //Bite
    SPELL_KNIGHT_A_1  = 37453,    //Smash
    SPELL_ROOK_H_1    = 37428,    //Hellfire
    SPELL_ROOK_A_1    = 37427,    //Geyser
    SPELL_PAWN_H_1    = 37413,    //Vicious Strike
    SPELL_PAWN_A_1    = 37406,    //Heroic Blow

    //ability 2
    SPELL_KING_H_2    = 37472,    //Bloodlust
    SPELL_KING_A_2    = 37471,    //Heroism
    SPELL_QUEEN_H_2   = 37469,    //Poison Cloud
    SPELL_QUEEN_A_2   = 37465,    //Rain of Fire
    SPELL_BISHOP_H_2  = 37461,    //Shadow Spear
    SPELL_BISHOP_A_2  = 37459,    //Holy Lance
    SPELL_KNIGHT_H_2  = 37502,    //Howl
    SPELL_KNIGHT_A_2  = 37498,    //Stomp
    SPELL_ROOK_H_2    = 37434,    //Fire Shield
    SPELL_ROOK_A_2    = 37432,    //Water Shield
    SPELL_PAWN_H_2    = 37416,    //Weapon Deflection
    SPELL_PAWN_A_2    = 37414     //Shield Block
};

enum MiniEvent
{
    MINI_EVENT_NONE     = 0,
    MINI_EVENT_KING     = 1,
    MINI_EVENT_QUEEN    = 2,
    MINI_EVENT_BISHOP   = 3,
    MINI_EVENT_KNIGHT   = 4,
    MINI_EVENT_ROOK     = 5,
    MINI_EVENT_PAWN     = 6,
    MINI_EVENT_END      = 7
};

enum GameEndEvent
{
    GAMEEND_NONE            = 0,
    GAMEEND_MEDIVH_WIN      = 1,
    GAMEEND_MEDIVH_LOSE     = 2,
    GAMEEND_CLEAR_BOARD     = 3,
    GAMEEND_DESPAWN_CHEST   = 4
};

enum AbilityCooldowns
{
    //ability 1
    CD_KING_1    = 5000,
    CD_QUEEN_1   = 5000,
    CD_BISHOP_1  = 20000,
    CD_KNIGHT_1  = 5000,
    CD_ROOK_1    = 5000,
    CD_PAWN_1    = 5000,

    //ability 2
    CD_KING_2    = 15000,
    CD_QUEEN_2   = 15000,
    CD_BISHOP_2  = 5000,
    CD_KNIGHT_2  = 5000,
    CD_ROOK_2    = 5000,
    CD_PAWN_2    = 5000
};

/*enum AttackSpells
{
    ATTACK              = 6603,
    ATTACK_TIMER        = 32226,
    TAKE_ACTION         = 32225,

    //ally
    ELEMENTAL_ATTACK    = 750,//37142,
    ELEMENTAL_ATTACK2   = 0,//37143,
    FOOTMAN_ATTACK_DMG  = 0,//32247,
    FOOTMAN_ATTACK      = 500,//32227,
    CLERIC_ATTACK       = 1250,//37147,
    CONJURER_ATTACK     = 1500,//37149,
    KING_LLANE_ATTACK   = 1750,//37150,

    //horde
    GRUNT_ATTACK        = 500,//32228,
    NECROLYTE_ATTACK    = 1250,//37337,
    WARLOCK_ATTACK      = 1500,//37345,
    WOLF_ATTACK         = 1000,//37339,
    DEMON_ATTACK        = 750,//37220,
    WARCHIEF_ATTACK     = 1750//37348
};*/

enum ChessPiecesStances
{
    PIECE_NONE          = 0,
    PIECE_MOVE          = 1,
    PIECE_CHANGE_FACING = 2
    //PIECE_DIE           = 3
};

enum ChessOrientation
{
    CHESS_ORI_N      = 0,   //Horde side
    CHESS_ORI_E      = 1,   //Doors to Prince
    CHESS_ORI_S      = 2,   //Alliance side
    CHESS_ORI_W      = 3,   //Medivh side
    CHESS_ORI_CHOOSE = 4    //simple use script to choose orientation
};

struct ChessTile
{
    WorldLocation position;
    uint64 piece;           //GUID;
    uint64 trigger;         //GUID;
    ChessOrientation ori;   //Orientation for GetMeleeTarget(), updated by medivh function SetOrientation();

    ChessTile()
    {
        piece = 0;
        trigger = 0;
        ori = CHESS_ORI_CHOOSE;
		position.m_positionZ = 220.66f;
    }

    ChessTile(const ChessTile &p)
    {
        piece = p.piece;
        trigger = p.trigger;
        ori = p.ori;
        position = p.position;
    }
};

struct ChessPosition
{
    uint64 GUID;
    int i;
    int j;

    ChessPosition()
    {
        GUID = 0;
        i = -1;
        j = -1;
    }

    ChessPosition(uint64 guid, int i, int j)
    {
        this->GUID = guid;
        this->i = i;
        this->j = j;
    }
};

struct Priority
{
    uint64 GUIDfrom;
    uint64 GUIDto;
    int prior;

    Priority()
    {
        GUIDfrom = 0;
        GUIDto = 0;
        prior = 0;
    }
};

#define OFFSETMELEECOUNT    4
#define OFFSET8COUNT        8
#define OFFSET15COUNT       12
#define OFFSET20COUNT       24
#define OFFSET25COUNT       4

// 0 - caster; 1 - 8yd range; 2 - 15yd range; 3 - 20 yd range; 4 - 25 yd range
//
// 4 3 3 3 3 3 4
// 3 3 2 2 2 3 3
// 3 2 1 1 1 2 3
// 3 2 1 0 1 2 3
// 3 2 1 1 1 2 3
// 3 3 2 2 2 3 3
// 4 3 3 3 3 3 4
//

const int offsetTabMelee[4][2] = {{-1, 0}, {1, 0}, {0, 1}, {0, -1}};

const int offsetTab8[8][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

const int offsetTab15[12][2] = {{-2, -1}, {-2, 0}, {-2, 1}, {-1, -2}, {-1, 2}, {0, -2}, {0, 2}, {1, -2}, {1, 2}, {2, -1}, {2, 0}, {2, 1}};

const int offsetTab20[24][2] = {{-3, -2}, {-3, -1}, {-3, 0}, {-3, 1}, {-3, 2}, {-2, -3}, {-2, 3}, {-1, -3}, {-1, 3}, {0, -3}, {0, 3}, {1, -3}, {1, 3}, {2, -3}, {2, 3}, {3, -2}, {3, -1}, {3, 0}, {3, 1}, {3, 2}, {2, 2}, {-2, 2}, {2, -2}, {-2, -2}};

const int offsetTab25[4][2] = {{-3, -3}, {3, -3}, {3, 3}, {-3, 3}};

    //struct chess_move_triggerAI;

    struct npc_echo_of_medivhAI : public ScriptedAI
        {

            instance_karazhan_InstanceMapScript* pInstance;

            int16 hordePieces;      //count of alive horde side pieces
            int16 alliancePieces;   //count of alive alliance side pieces

            int16 chanceToMove;     //random chance for medivh to move piece when player moved
                                    //when player want to move his piece medivh tests if he can move too

            int16 chanceToSelfMove;

            ChessTile chessBoard[8][8];
            float hordeSideDeadWP[2][16];
            float allianceSideDeadWP[2][16];

            std::list<uint64> medivhSidePieces;     //alive pieces guids

            std::list<uint64> unusedMedivhPieces;   //pieces that was summoned after medivh piece death
            std::list<uint64> unusedPlayerPieces;   //pieces that was summoned after player piece death

            bool eventStarted;

            GameEndEvent endGameEventState;
            MiniEvent miniEventState;

            int endEventCount;

            int32 miniEventTimer;
            uint32 endEventTimer;
            uint32 endEventLightningTimer;

            uint32 firstCheatTimer;
            uint32 secondCheatTimer;
            uint32 thirdCheatTimer;
            double firstCheatDamageReq;
            double secondCheatDamageReq;
            double thirdCheatDamagereq;

            WorldLocation wLoc;     //location of medivh
            WorldLocation tpLoc;    //location of player teleport point

            std::list<uint64> tpList;
            std::list<ChessTile> moveList; //list of triggers to make move

            uint32 moveTimer;
            uint32 addPieceToMoveCheckTimer;

            uint64 chestGUID;

            npc_echo_of_medivhAI(Creature *c) : ScriptedAI(c) {
                pInstance = ((instance_karazhan_InstanceMapScript*)me->GetInstanceScript());
                me->GetPosition(&wLoc);
                tpLoc.m_positionX = -11108.2f;
                tpLoc.m_positionY = -1841.56f;
                tpLoc.m_positionZ = 229.625f;
                tpLoc.m_orientation = 5.39745f;

                this->chanceToMove = urand(MIN_MOVE_CHANCE, MAX_MOVE_CHANCE);

                chanceToSelfMove = urand(MIN_SELF_MOVE_CHANCE, MAX_SELF_MOVE_CHANCE);

                /*
                               j

                      0  1  2  3  4  5  6  7
                    0 H  H  H  H  H  H  H  H
                    1 H  H  H  H  H  H  H  H
                    2 E  E  E  E  E  E  E  E
                i   3 E  E  E  E  E  E  E  E
                    4 E  E  E  E  E  E  E  E
                    5 E  E  E  E  E  E  E  E
                    6 A  A  A  A  A  A  A  A
                    7 A  A  A  A  A  A  A  A
                */

                // calc positions:

                for (uint8 i = 0; i < 8; ++i)
                {
                    for (uint8 j = 0; j < 8; ++j)
                    {
                        chessBoard[i][j].position.m_positionX = -11077.66 + 3.48 * j - 4.32 * i ;
                        chessBoard[i][j].position.m_positionY = -1849.02 - 4.365 * j - 3.41 * i;
                        chessBoard[i][j].position.m_positionZ = 221.1f;
                        chessBoard[i][j].position.m_mapId = me->GetMapId();
                    }
                }
                int j = 15;
                for (int i = 0; i < 16; ++i)
                {
                    allianceSideDeadWP[0][i] = (i < 8 ? ALLIANCE_DEAD_X2 : ALLIANCE_DEAD_X1) - 2.2 * 0.75 * (j < 8 ? j : j - 8);
                    allianceSideDeadWP[1][i] = (i < 8 ? ALLIANCE_DEAD_Y2 : ALLIANCE_DEAD_Y1) - 1.7 * 0.75 * (j < 8 ? j : j - 8);
                    hordeSideDeadWP[0][i] = (i < 8 ? HORDE_DEAD_X2 : HORDE_DEAD_X1) + 2.2 * 0.75 * (j < 8 ? j : j - 8);
                    hordeSideDeadWP[1][i] = (i < 8 ? HORDE_DEAD_Y2 : HORDE_DEAD_Y1) + 1.7 * 0.75 * (j < 8 ? j : j - 8);
                    j--;
                }
            }

            int GetMoveRange(uint64 piece)
            {
                return (GetMoveRange(me->GetUnit(*me, piece)));
            }

            int GetMoveRange(Unit * piece)
            {
                if (!piece)
                    return 0;

                switch (piece->GetEntry())
                {
                    case NPC_PAWN_A:
                    case NPC_PAWN_H:
                    case NPC_KING_A:
                    case NPC_KING_H:
                    case NPC_BISHOP_A:
                    case NPC_BISHOP_H:
                    case NPC_ROOK_A:
                    case NPC_ROOK_H:
                        return 8;

                    case NPC_KNIGHT_A:
                    case NPC_KNIGHT_H:
                        return 15;

                    case NPC_QUEEN_A:
                    case NPC_QUEEN_H:
                        return 20;

                    default:
                        break;
                }

                return 0;
            }

            bool Enemy(uint64 piece1, uint64 piece2)
            {
                Creature * tmp1, * tmp2;

                if (!piece1 || !piece2)
                    return false;

                tmp1 = me->GetCreature(*me, piece1);
                tmp2 = me->GetCreature(*me, piece2);

                if (!tmp1 || !tmp2)
                {
                    me->MonsterSay("Erreur: Au moins une des 2 pieces n'a pu être trouvée", LANG_UNIVERSAL, 0);
                    return false;
                }

                return tmp1->getFaction() != tmp2->getFaction();
            }

            int GetCountOfEnemyInMelee(uint64 piece, bool strafe = false)
            {
                int tmpCount = 0, tmpI = -1, tmpJ = -1, tmpOffsetI, tmpOffsetJ;

                //search for position in tab of piece

                if (!FindPlaceInBoard(piece, tmpI, tmpJ))
                    return 0;

                if (strafe)
                {
                    for (int i = 0; i < OFFSET8COUNT; ++i)
                    {
                        tmpOffsetI = tmpI + offsetTab8[i][0];
                        tmpOffsetJ = tmpJ + offsetTab8[i][1];
                        if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                            tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                            Enemy(piece, chessBoard[tmpOffsetI][tmpOffsetJ].piece))
                            ++tmpCount;
                    }
                }
                else
                {
                    for (int i = 0; i < OFFSETMELEECOUNT; ++i)
                    {
                        tmpOffsetI = tmpI + offsetTabMelee[i][0];
                        tmpOffsetJ = tmpJ + offsetTabMelee[i][1];
                        if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                            tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                            Enemy(piece, chessBoard[tmpOffsetI][tmpOffsetJ].piece))
                            ++tmpCount;
                    }
                }

                return tmpCount;
            }

            int GetCountOfPiecesInRange(uint64 trigger, int range, bool friendly)
            {
                int count = 0;

                int tmpI, tmpJ, i, tmpOffsetI, tmpOffsetJ;
                uint64 tmpGUID;

                if (!FindPlaceInBoard(trigger, tmpI, tmpJ))
                    return 0;

                switch (range)
                {
                    case 25:
                        for (i = 0; i < OFFSET25COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab25[i][0];
                            tmpOffsetJ = tmpJ + offsetTab25[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                            {
                                tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                if (friendly)
                                {
                                    if (tmpGUID && IsMedivhsPiece(tmpGUID))
                                        ++count;
                                }
                                else
                                {
                                    if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                                        ++count;
                                }
                            }
                        }
                    case 20:
                        for (i = 0; i < OFFSET20COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab20[i][0];
                            tmpOffsetJ = tmpJ + offsetTab20[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                            {
                                tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                if (friendly)
                                {
                                    if (tmpGUID && IsMedivhsPiece(tmpGUID))
                                        ++count;
                                }
                                else
                                {
                                    if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                                        ++count;
                                }
                            }
                        }
                    case 15:
                        for (i = 0; i < OFFSET15COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab15[i][0];
                            tmpOffsetJ = tmpJ + offsetTab15[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                            {
                                tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                if (friendly)
                                {
                                    if (tmpGUID && IsMedivhsPiece(tmpGUID))
                                        ++count;
                                }
                                else
                                {
                                    if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                                        ++count;
                                }
                            }
                        }
                    case 8:
                    default:
                        for (i = 0; i < OFFSET8COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab8[i][0];
                            tmpOffsetJ = tmpJ + offsetTab8[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                            {
                                tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                if (friendly)
                                {
                                    if (tmpGUID && IsMedivhsPiece(tmpGUID))
                                        ++count;
                                }
                                else
                                {
                                    if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                                        ++count;
                                }
                            }
                        break;
                        }
                }

                return count;
            }


            int GetLifePriority(uint64 piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a GetLifePriority(uint64 piece = %u)", piece);
            #endif

                Unit * uPiece = me->GetUnit(*me, piece);

                if (!uPiece)
                    return 0;

                int tmpPriority = 0;

                switch (uPiece->GetEntry())
                {
                    case NPC_PAWN_A:
                    case NPC_PAWN_H:
                        tmpPriority += 10;
                        break;
                    case NPC_KING_A:
                    case NPC_KING_H:
                        tmpPriority += 50;
                        break;
                    case NPC_BISHOP_A:
                    case NPC_BISHOP_H:
                        tmpPriority += 50;
                        break;
                    case NPC_ROOK_A:
                    case NPC_ROOK_H:
                        tmpPriority += 20;
                        break;
                    case NPC_KNIGHT_A:
                    case NPC_KNIGHT_H:
                        tmpPriority += 30;
                        break;
                    case NPC_QUEEN_A:
                    case NPC_QUEEN_H:
                        tmpPriority += 40;
                        break;
                    default:
                        break;
                }

                tmpPriority += tmpPriority * (1- (uPiece->GetHealth()/uPiece->GetMaxHealth()));

                return tmpPriority;
            }

            int GetAttackPriority(uint64 piece)
            {
                Unit * uPiece = me->GetUnit(*me, piece);

                if (!uPiece)
                    return 0;

                int tmpPriority = START_PRIORITY;

                switch (uPiece->GetEntry())
                {
                    case NPC_PAWN_A:
                    case NPC_PAWN_H:
                        tmpPriority += 5;
                        break;
                    case NPC_KING_A:
                    case NPC_KING_H:
                        tmpPriority += 15;
                        break;
                    case NPC_BISHOP_A:
                    case NPC_BISHOP_H:
                        tmpPriority += 15;
                        break;
                    case NPC_ROOK_A:
                    case NPC_ROOK_H:
                        tmpPriority += 5;
                        break;
                    case NPC_KNIGHT_A:
                    case NPC_KNIGHT_H:
                        tmpPriority += 5;
                        break;
                    case NPC_QUEEN_A:
                    case NPC_QUEEN_H:
                        tmpPriority += 10;
                        break;
                    default:
                        break;
                }

                tmpPriority += tmpPriority * (1 - (uPiece->GetHealth()/(double)uPiece->GetMaxHealth()));

                return tmpPriority;
            }

            bool IsEmptySquareInRange(uint64 piece, int range)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsEmptySquareInRange(uint64 piece = %u, int range = %i)", piece, range);
            #endif

                if (!piece || !range)
                    return false;

                int tmpI = -1, tmpJ = -1, tmpOffsetI, tmpOffsetJ;
                int i;

                //search for position in tab of piece

                if (!FindPlaceInBoard(piece, tmpI, tmpJ))
                {
                    Creature * uPiece = me->GetCreature(*me, piece);

                    if (uPiece)
                        uPiece->MonsterSay("IsEmptySquareInRange(..) : Pas me trouver sur la carte !!", LANG_UNIVERSAL, 0);
                    else
                        me->MonsterSay("IsEmptySquareInRange(..) : Pion non trouvé !!", LANG_UNIVERSAL, 0);
                    return false;
                }

                switch (range)
                {
                    case 25:
                        for (i = 0; i < OFFSET25COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab25[i][0];
                            tmpOffsetJ = tmpJ + offsetTab25[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                if (!chessBoard[tmpOffsetI][tmpOffsetJ].piece)
                                    return true;
                        }
                    case 20:
                        for (i = 0; i < OFFSET20COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab20[i][0];
                            tmpOffsetJ = tmpJ + offsetTab20[i][1];
                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                if (!chessBoard[tmpOffsetI][tmpOffsetJ].piece)
                                    return true;
                        }
                    case 15:
                        for (i = 0; i < OFFSET15COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab15[i][0];
                            tmpOffsetJ = tmpJ + offsetTab15[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                if (!chessBoard[tmpOffsetI][tmpOffsetJ].piece)
                                    return true;
                        }
                    case 8:
                        for (i = 0; i < OFFSET8COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab8[i][0];
                            tmpOffsetJ = tmpJ + offsetTab8[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                if (!chessBoard[tmpOffsetI][tmpOffsetJ].piece)
                                    return true;
                        }
                        break;
                    default:
                        break;
                }

                return false;
            }

            bool IsPositive(uint32 spell)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsPositive(uint32 spell = %u)", spell);
            #endif

                switch (spell)
                {
                    case SPELL_PAWN_A_2:
                    case SPELL_PAWN_H_2:
                    case SPELL_ROOK_A_2:
                    case SPELL_ROOK_H_2:
                    case SPELL_KING_A_2:
                    case SPELL_KING_H_2:
                    case SPELL_BISHOP_A_1:
                    case SPELL_BISHOP_H_1:
                        return true;

                    default:
                        return false;
                }

                return false;
            }

            int GetAbilityRange(uint32 spell)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a GetAbilityRange(uint32 spell = %u)", spell);
            #endif

                /*returns:
                0   - spell needs check if there are any target in melee range, if yes then casts spell on self
                5   - spell needs target in front of caster
                6   - spell needs target in 1 -> 3 targets in front (clave/swipe)
                20  - long range (7x7 - 5 squares) - normal check
                25  - long range (7x7 - 1 squares) - normal check

                0                   - caster;
                1 + 2 + 3           - return 0
                2                   - return 5
                3 + 2               - return 6
                4 + 1 + 2 + 3       - return 20
                5 + 4 + 1 + 2 + 3   - return 25

                 5 4 4 4 4 4 5
                 4 4 4 4 4 4 4
                 4 4 3 2 3 4 4
                 4 4 1 0 1 4 4
                 4 4 1 1 1 4 4
                 4 4 4 4 4 4 4
                 5 4 4 4 4 4 5

                ranges for spells can be wrong !
                */

                switch (spell)
                {
                    case SPELL_KING_H_1:
                    case SPELL_KING_A_1:
                        return 6;

                    case SPELL_QUEEN_H_1:
                    case SPELL_QUEEN_A_1:
                    case SPELL_QUEEN_A_2:
                    case SPELL_QUEEN_H_2:
                        return 25;

                    case SPELL_BISHOP_A_1:
                    case SPELL_BISHOP_H_1:
                        return 20;

                    case SPELL_PAWN_H_1:
                    case SPELL_PAWN_A_1:
                    case SPELL_KNIGHT_H_1:
                    case SPELL_KNIGHT_A_1:
                        return 5;

                    default:
                        return 0;
                }

                return 0;
            }

            bool IsHealingSpell(uint32 spell)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsHealingSpell(uint32 spell = %u)", spell);
            #endif

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

            bool Heal(uint32 spell, uint64 guid)
            {
                if (!IsHealingSpell(spell))
                    return true;

                Creature * tmpC = me->GetCreature(*me, guid);

                if (!tmpC)
                    return false;

                return tmpC->GetHealth() != tmpC->GetMaxHealth();
            }

            uint64 GetSpellTarget(uint64 caster, uint32 spell)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a GetSpellTarget(uint64 caster = %u, uint32 spell = %u)", caster, spell);
            #endif

                int tmpI = -1, tmpJ = -1, i, tmpOffsetI, tmpOffsetJ;

                if (!FindPlaceInBoard(caster, tmpI, tmpJ))
                {
                    Creature * uCaster = me->GetCreature(*me, caster);
                    if (uCaster)
                        uCaster->MonsterSay("GetSpellTarget(..) : Nie znaleziono mnie na planszy !!", LANG_UNIVERSAL, 0);
                    return 0;
                }

                int priority = START_PRIORITY, prevPriority = 0;

                std::list<Priority> tmpList;
                std::list<uint64> tmpPossibleTargetsList;
                uint64 tmpGUID;

                if (IsPositive(spell))
                {
                    //create possible target list

                    switch (GetAbilityRange(spell))
                    {
                        case 25:
                            for (i = 0; i < OFFSET25COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab25[i][0];
                                tmpOffsetJ = tmpJ + offsetTab25[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && IsMedivhsPiece(tmpGUID) && Heal(spell, tmpGUID))
                                        tmpPossibleTargetsList.push_back(tmpGUID);
                                }
                            }
                        case 20:
                            for (i = 0; i < OFFSET20COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab20[i][0];
                                tmpOffsetJ = tmpJ + offsetTab20[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && IsMedivhsPiece(tmpGUID) && Heal(spell, tmpGUID))
                                        tmpPossibleTargetsList.push_back(tmpGUID);
                                }
                            }
                        case 15:
                            for (i = 0; i < OFFSET15COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab15[i][0];
                                tmpOffsetJ = tmpJ + offsetTab15[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && IsMedivhsPiece(tmpGUID) && Heal(spell, tmpGUID))
                                        tmpPossibleTargetsList.push_back(tmpGUID);
                                }
                            }
                        case 8:
                            for (i = 0; i < OFFSET8COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab8[i][0];
                                tmpOffsetJ = tmpJ + offsetTab8[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && IsMedivhsPiece(tmpGUID) && Heal(spell, tmpGUID))
                                        tmpPossibleTargetsList.push_back(tmpGUID);
                                }
                            }
                            break;
                        case 6: // 3 targets in front
                            switch (chessBoard[tmpI][tmpJ].ori)
                            {
                                case CHESS_ORI_E:
                                    if (tmpJ + 1 >= 0)
                                    {
                                        if (!Enemy(caster, chessBoard[tmpI][tmpJ + 1].piece))
                                            return caster;

                                        if (tmpI - 1 >= 0 && !Enemy(caster, chessBoard[tmpI - 1][tmpJ + 1].piece))
                                            return caster;

                                        if (tmpI + 1 < 8 && !Enemy(caster, chessBoard[tmpI + 1][tmpJ + 1].piece))
                                            return caster;
                                    }
                                    break;
                                case CHESS_ORI_N:
                                    if (tmpI - 1 >= 0)
                                    {
                                        if (!Enemy(caster, chessBoard[tmpI - 1][tmpJ].piece))
                                            return caster;

                                        if (tmpJ - 1 >= 0 && !Enemy(caster, chessBoard[tmpI - 1][tmpJ - 1].piece))
                                            return caster;

                                        if (tmpJ + 1 < 8 && !Enemy(caster, chessBoard[tmpI - 1][tmpJ + 1].piece))
                                            return caster;
                                    }
                                    break;
                                case CHESS_ORI_S:
                                    if (tmpI + 1 >= 0)
                                    {
                                        if (!Enemy(caster, chessBoard[tmpI + 1][tmpJ].piece))
                                            return caster;

                                        if (tmpJ - 1 >= 0 && !Enemy(caster, chessBoard[tmpI + 1][tmpJ - 1].piece))
                                            return caster;

                                        if (tmpJ + 1 < 8 && !Enemy(caster, chessBoard[tmpI + 1][tmpJ + 1].piece))
                                            return caster;
                                    }
                                    break;
                                case CHESS_ORI_W:
                                    if (tmpJ - 1 >= 0)
                                    {
                                        if (!Enemy(caster, chessBoard[tmpI][tmpJ - 1].piece))
                                            return caster;

                                        if (tmpI - 1 >= 0 && !Enemy(caster, chessBoard[tmpI - 1][tmpJ - 1].piece))
                                            return caster;

                                        if (tmpI + 1 < 8 && !Enemy(caster, chessBoard[tmpI + 1][tmpJ - 1].piece))
                                            return caster;
                                    }
                                    break;
                                default:
                                    break;
                            }
                            break;
                        case 5: // 1 target in front
                            switch (chessBoard[tmpI][tmpJ].ori)
                            {
                                case CHESS_ORI_E:
                                    if (tmpJ + 1 >= 0)
                                        if (!Enemy(caster, chessBoard[tmpI][tmpJ + 1].piece))
                                            return chessBoard[tmpI][tmpJ + 1].piece;
                                    break;
                                case CHESS_ORI_N:
                                    if (tmpI - 1 >= 0)
                                        if (!Enemy(caster, chessBoard[tmpI - 1][tmpJ].piece))
                                            return chessBoard[tmpI - 1][tmpJ].piece;
                                    break;
                                case CHESS_ORI_S:
                                    if (tmpI + 1 >= 0)
                                        if (!Enemy(caster, chessBoard[tmpI + 1][tmpJ].piece))
                                            return chessBoard[tmpI + 1][tmpJ].piece;
                                    break;
                                case CHESS_ORI_W:
                                    if (tmpJ - 1 >= 0)
                                        if (!Enemy(caster, chessBoard[tmpI][tmpJ - 1].piece))
                                            return chessBoard[tmpI][tmpJ - 1].piece;
                                    break;
                                default:
                                    break;
                            }
                            break;
                        case 0: // check if is any piece in melee
                            for (i = 0; i < OFFSET8COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab8[i][0];
                                tmpOffsetJ = tmpJ + offsetTab8[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && IsMedivhsPiece(tmpGUID))
                                        return caster;
                                }
                            }
                            break;
                        default:
                            break;
                    }

                    if (tmpPossibleTargetsList.empty())
                        return 0;

                    // calculate and add priority

                    int prioritySum = 0;

                    for (std::list<uint64>::iterator i = tmpPossibleTargetsList.begin(); i != tmpPossibleTargetsList.end(); ++i)
                    {
                        Priority tempPriority;
                        tempPriority.prior = START_PRIORITY;
                        tempPriority.GUIDfrom = *i;

                        tempPriority.prior += GetCountOfEnemyInMelee(*i) * MELEE_PRIORITY + urand(0, RAND_PRIORITY) + GetLifePriority(*i);

                        prioritySum += tempPriority.prior;
                        tmpList.push_back(tempPriority);
                    }

                    switch (rand()%2)
                    {
                        case 0:
                        {
                            int chosen = urand(0, prioritySum), prevPrior = 0;

                            for (std::list<Priority>::iterator i = tmpList.begin(); i!= tmpList.end(); ++i)
                            {
                                if (prevPrior < chosen && (*i).prior >= chosen)
                                    return (*i).GUIDfrom;
                                prevPrior = (*i).prior;
                            }
                            break;
                        }
                        case 1:
                        default:
                        {
                            Priority best;
                            std::list<Priority> bestList;
                            best = tmpList.front();

                            for (std::list<Priority>::iterator i = tmpList.begin(); i!= tmpList.end(); ++i)
                            {
                                if (best.prior < (*i).prior)
                                {
                                    best = *i;
                                    bestList.clear();
                                    bestList.push_back(*i);
                                }
                                else if (best.prior == (*i).prior)
                                    bestList.push_back(*i);
                            }

                            if (bestList.empty())
                                return 0;

                            std::list<Priority>::iterator tmpItr = bestList.begin();

                            advance(tmpItr, urand(0, bestList.size() - 1));

                            return (*tmpItr).GUIDfrom;

                            break;
                        }
                    }
                }
                else        //if !positive
                {
                    //create possible targets list

                    switch (GetAbilityRange(spell))
                    {
                        case 25:
                            for (i = 0; i < OFFSET25COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab25[i][0];
                                tmpOffsetJ = tmpJ + offsetTab25[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                                        tmpPossibleTargetsList.push_back(tmpGUID);
                                }
                            }
                        case 20:
                            for (i = 0; i < OFFSET20COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab20[i][0];
                                tmpOffsetJ = tmpJ + offsetTab20[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                                        tmpPossibleTargetsList.push_back(tmpGUID);
                                }
                            }
                        case 15:
                            for (i = 0; i < OFFSET15COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab15[i][0];
                                tmpOffsetJ = tmpJ + offsetTab15[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                                        tmpPossibleTargetsList.push_back(tmpGUID);
                                }
                            }
                        case 8:
                            for (i = 0; i < OFFSET8COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab8[i][0];
                                tmpOffsetJ = tmpJ + offsetTab8[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                                        tmpPossibleTargetsList.push_back(tmpGUID);
                                }
                            }
                            break;
                        case 6: // 3 targets in front
                            switch (chessBoard[tmpI][tmpJ].ori)
                            {
                                case CHESS_ORI_E:
                                    if (tmpJ + 1 >= 0)
                                    {
                                        if (Enemy(caster, chessBoard[tmpI][tmpJ + 1].piece))
                                            return caster;

                                        if (tmpI - 1 >= 0 && Enemy(caster, chessBoard[tmpI - 1][tmpJ + 1].piece))
                                            return caster;

                                        if (tmpI + 1 < 8 && Enemy(caster, chessBoard[tmpI + 1][tmpJ + 1].piece))
                                            return caster;
                                    }
                                    break;
                                case CHESS_ORI_N:
                                    if (tmpI - 1 >= 0)
                                    {
                                        if (Enemy(caster, chessBoard[tmpI - 1][tmpJ].piece))
                                            return caster;

                                        if (tmpJ - 1 >= 0 && Enemy(caster, chessBoard[tmpI - 1][tmpJ - 1].piece))
                                            return caster;

                                        if (tmpJ + 1 < 8 && Enemy(caster, chessBoard[tmpI - 1][tmpJ + 1].piece))
                                            return caster;
                                    }
                                    break;
                                case CHESS_ORI_S:
                                    if (tmpI + 1 >= 0)
                                    {
                                        if (Enemy(caster, chessBoard[tmpI + 1][tmpJ].piece))
                                            return caster;

                                        if (tmpJ - 1 >= 0 && Enemy(caster, chessBoard[tmpI + 1][tmpJ - 1].piece))
                                            return caster;

                                        if (tmpJ + 1 < 8 && Enemy(caster, chessBoard[tmpI + 1][tmpJ + 1].piece))
                                            return caster;
                                    }
                                    break;
                                case CHESS_ORI_W:
                                    if (tmpJ - 1 >= 0)
                                    {
                                        if (Enemy(caster, chessBoard[tmpI][tmpJ - 1].piece))
                                            return caster;

                                        if (tmpI - 1 >= 0 && Enemy(caster, chessBoard[tmpI - 1][tmpJ - 1].piece))
                                            return caster;

                                        if (tmpI + 1 < 8 && Enemy(caster, chessBoard[tmpI + 1][tmpJ - 1].piece))
                                            return caster;
                                    }
                                    break;
                                default:
                                    break;
                            }
                            break;
                        case 5: // 1 target in front
                            switch (chessBoard[tmpI][tmpJ].ori)
                            {
                                case CHESS_ORI_E:
                                    if (tmpJ + 1 >= 0)
                                        if (Enemy(caster, chessBoard[tmpI][tmpJ + 1].piece))
                                            return chessBoard[tmpI][tmpJ + 1].piece;
                                    break;
                                case CHESS_ORI_N:
                                    if (tmpI - 1 >= 0)
                                        if (Enemy(caster, chessBoard[tmpI - 1][tmpJ].piece))
                                            return chessBoard[tmpI - 1][tmpJ].piece;
                                    break;
                                case CHESS_ORI_S:
                                    if (tmpI + 1 >= 0)
                                        if (Enemy(caster, chessBoard[tmpI + 1][tmpJ].piece))
                                            return chessBoard[tmpI + 1][tmpJ].piece;
                                    break;
                                case CHESS_ORI_W:
                                    if (tmpJ - 1 >= 0)
                                        if (Enemy(caster, chessBoard[tmpI][tmpJ - 1].piece))
                                            return chessBoard[tmpI][tmpJ - 1].piece;
                                    break;
                                default:
                                    break;
                            }
                            break;
                        case 0: // check if is any piece in melee
                            for (i = 0; i < OFFSET8COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab8[i][0];
                                tmpOffsetJ = tmpJ + offsetTab8[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                {
                                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                                    if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                                        return caster;
                                }
                            }
                            break;
                        default:
                            break;
                    }

                    // calculate and add priority

                    int prioritySum = 0;

                    for (std::list<uint64>::iterator i = tmpPossibleTargetsList.begin(); i != tmpPossibleTargetsList.end(); ++i)
                    {
                        Priority tempPriority;
                        tempPriority.prior = START_PRIORITY;
                        tempPriority.GUIDfrom = *i;

                        tempPriority.prior += GetCountOfEnemyInMelee(*i) * MELEE_PRIORITY + urand(0, RAND_PRIORITY) + GetAttackPriority(*i);

                        prioritySum += tempPriority.prior;
                        tmpList.push_back(tempPriority);
                    }

                    switch (rand()%2)
                    {
                        case 0:
                        {
                            int chosen = urand(0, prioritySum), prevPrior = 0;

                            for (std::list<Priority>::iterator i = tmpList.begin(); i!= tmpList.end(); ++i)
                            {
                                if (prevPrior < chosen && (*i).prior >= chosen)
                                    return (*i).GUIDfrom;
                                prevPrior = (*i).prior;
                            }
                            break;
                        }
                        case 1:
                        default:
                        {
                            Priority best;
                            std::list<Priority> bestList;
                            best = tmpList.front();

                            for (std::list<Priority>::iterator i = tmpList.begin(); i!= tmpList.end(); ++i)
                            {
                                if (best.prior < (*i).prior)
                                {
                                    best = *i;
                                    bestList.clear();
                                    bestList.push_back(*i);
                                }
                                else if (best.prior == (*i).prior)
                                    bestList.push_back(*i);
                            }

                            if (bestList.empty())
                                return 0;

                            std::list<Priority>::iterator tmpItr = bestList.begin();

                            advance(tmpItr, urand(0, bestList.size() - 1));

                            return (*tmpItr).GUIDfrom;
                        }
                    }
                }

                return 0;
            }

            uint64 GetMeleeTarget(uint64 piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a GetMeleeTarget(uint64 piece = %u)", piece);
            #endif
                int tmpi, tmpj;    //temporary piece position

                if (!FindPlaceInBoard(piece, tmpi, tmpj))
                    return 0;

                switch (chessBoard[tmpi][tmpj].ori)
                {
                    case CHESS_ORI_N:
                        if (tmpi > 0)
                        {
                            //front
                            if (Enemy(piece, chessBoard[tmpi - 1][tmpj].piece))
                                return chessBoard[tmpi - 1][tmpj].piece;

                            //strafe
                            if (tmpj < 7 && Enemy(piece, chessBoard[tmpi - 1][tmpj + 1].piece))
                                return chessBoard[tmpi - 1][tmpj + 1].piece;

                            if (tmpj > 0 && Enemy(piece, chessBoard[tmpi - 1][tmpj - 1].piece))
                                return chessBoard[tmpi - 1][tmpj - 1].piece;
                        }
                        break;
                    case CHESS_ORI_E:
                        if (tmpj < 7)
                        {
                            //front
                            if (Enemy(piece, chessBoard[tmpi][tmpj + 1].piece))
                                return chessBoard[tmpi][tmpj + 1].piece;

                            //strafe
                            if (tmpi < 7 && Enemy(piece, chessBoard[tmpi + 1][tmpj + 1].piece))
                                return chessBoard[tmpi + 1][tmpj + 1].piece;

                            if (tmpi > 0 && Enemy(piece, chessBoard[tmpi - 1][tmpj + 1].piece))
                                return chessBoard[tmpi - 1][tmpj + 1].piece;
                        }
                        break;
                    case CHESS_ORI_S:
                        if (tmpi < 7)
                        {
                            //front
                            if (Enemy(piece, chessBoard[tmpi + 1][tmpj].piece))
                                return chessBoard[tmpi + 1][tmpj].piece;

                            //strafe
                            if (tmpj < 7 && Enemy(piece, chessBoard[tmpi + 1][tmpj + 1].piece))
                                return chessBoard[tmpi + 1][tmpj + 1].piece;

                            if (tmpj > 0 && Enemy(piece, chessBoard[tmpi + 1][tmpj - 1].piece))
                                return chessBoard[tmpi + 1][tmpj - 1].piece;
                        }
                        break;
                    case CHESS_ORI_W:
                        if (tmpj > 0)
                        {
                            //front
                            if (Enemy(piece, chessBoard[tmpi][tmpj - 1].piece))
                                return chessBoard[tmpi][tmpj - 1].piece;

                            //strafe
                            if (tmpi < 7 && Enemy(piece, chessBoard[tmpi + 1][tmpj - 1].piece))
                                return chessBoard[tmpi + 1][tmpj - 1].piece;

                            if (tmpi > 0 && Enemy(piece, chessBoard[tmpi - 1][tmpj - 1].piece))
                                return chessBoard[tmpi - 1][tmpj - 1].piece;
                        }
                        break;
                    default:
                        break;
                }

                return 0;
            }

            bool IsChessPiece(Unit * unit)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsChessPiece(Unit * unit = %i)", unit ? 1 : 0);
            #endif

                switch (unit->GetEntry())
                {
                    case NPC_BISHOP_A:
                    case NPC_BISHOP_H:
                    case NPC_KING_A:
                    case NPC_KING_H:
                    case NPC_KNIGHT_A:
                    case NPC_KNIGHT_H:
                    case NPC_PAWN_A:
                    case NPC_PAWN_H:
                    case NPC_QUEEN_A:
                    case NPC_QUEEN_H:
                    case NPC_ROOK_A:
                    case NPC_ROOK_H:
                        return true;
                    default:
                        return false;
                }

                return false;
            }

            bool IsKing(uint64 piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsKing(uint64 piece = %u)", piece);
            #endif
                return IsKing(me->GetCreature(*me, piece));
            }

            bool IsHealer(uint64 piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsHealer(uint64 piece = %u)", piece);
            #endif
                return IsHealer(me->GetCreature(*me, piece));
            }

            bool IsKing(Creature * piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsKing(Creature * piece = %i)", piece ? 1 : 0);
            #endif

                if (!piece)
                    return false;

                switch (piece->GetEntry())
                {
                    case NPC_KING_H:
                    case NPC_KING_A:
                        return true;

                    default:
                        return false;
                }

                return false;
            }

            bool IsHealer(Creature * piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsHealer(Creature * piece = %i)", piece ? 1 : 0);
            #endif

                if (!piece)
                    return false;

                switch (piece->GetEntry())
                {
                    case NPC_BISHOP_H:
                    case NPC_BISHOP_A:
                        return true;

                    default:
                        return false;
                }

                return false;
            }

            bool IsMedivhsPiece(Unit * unit)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsMedivhsPiece(Unit * unit = %i)", unit ? 1 : 0);
            #endif

                if (unit)
                {
                    switch (pInstance->GetData(CHESS_EVENT_TEAM))
                    {
                        case ALLIANCE:
                            if (unit->getFaction() == H_FACTION)
                                return true;
                            break;
                        case HORDE:
                            if (unit->getFaction() == A_FACTION)
                                return true;
                            break;
                    }
                }
                else
                    me->MonsterSay("IsMedivhsPiece: Cos unita niema", LANG_UNIVERSAL, 0);

                return false;
            }

            bool IsMedivhsPiece(uint64 unit)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsMedivhsPiece(uint64 unit = %u)", unit);
            #endif

                for (std::list<uint64>::iterator i = medivhSidePieces.begin(); i != medivhSidePieces.end(); ++i)
                    if ((*i) == unit)
                        return true;

                return false;
            }

            bool IsInMoveList(uint64 unit, bool trigger = false)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsInMoveList(uint64 unit = %u, bool trigger = %i)", unit, trigger);
            #endif

                if (!trigger)
                {
                    for (std::list<ChessTile>::iterator i = moveList.begin(); i != moveList.end(); ++i)
                        if ((*i).piece == unit)
                            return true;
                }
                else
                {
                    for (std::list<ChessTile>::iterator i = moveList.begin(); i != moveList.end(); ++i)
                        if ((*i).trigger == unit)
                            return true;
                }

                return false;
            }

            bool IsInMoveRange(uint64 from, uint64 to, int range)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a IsInMoveRange(uint64 from = %u, uint64 to = %u, int range = %i)", from, to, range);
            #endif

                if (!from || !to || !range)
                    return false;

                int tmpI = -1, tmpJ = -1, i, tmpOffsetI, tmpOffsetJ;

                if (!FindPlaceInBoard(from, tmpI, tmpJ))
                {
                    Creature * uFrom = me->GetCreature(*me, from);
                    if (uFrom)
                        uFrom->MonsterSay("GetSpellTarget(..) : Nie znaleziono mnie na planszy !!", LANG_UNIVERSAL, 0);
                    else
                        me->MonsterSay("GetSpellTarget(..) : uFrom sie zapodzial", LANG_UNIVERSAL, 0);
                    return false;
                }

                switch (range)
                {
                    case 25:
                        for (i = 0; i < OFFSET25COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab25[i][0];
                            tmpOffsetJ = tmpJ + offsetTab25[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                if (chessBoard[tmpOffsetI][tmpOffsetJ].piece == to ||
                                    chessBoard[tmpOffsetI][tmpOffsetJ].trigger == to)
                                    return true;
                        }
                    case 20:
                        for (i = 0; i < OFFSET20COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab20[i][0];
                            tmpOffsetJ = tmpJ + offsetTab20[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                if (chessBoard[tmpOffsetI][tmpOffsetJ].piece == to ||
                                    chessBoard[tmpOffsetI][tmpOffsetJ].trigger == to)
                                    return true;
                        }
                    case 15:
                        for (i = 0; i < OFFSET15COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab15[i][0];
                            tmpOffsetJ = tmpJ + offsetTab15[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                if (chessBoard[tmpOffsetI][tmpOffsetJ].piece == to ||
                                    chessBoard[tmpOffsetI][tmpOffsetJ].trigger == to)
                                    return true;
                        }
                    case 8:
                        for (i = 0; i < OFFSET8COUNT; i++)
                        {
                            tmpOffsetI = tmpI + offsetTab8[i][0];
                            tmpOffsetJ = tmpJ + offsetTab8[i][1];

                            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                                if (chessBoard[tmpOffsetI][tmpOffsetJ].piece == to ||
                                    chessBoard[tmpOffsetI][tmpOffsetJ].trigger == to)
                                    return true;
                        }
                        break;
                    default:
                        me->MonsterSay("Jakis dziwaczny range", LANG_UNIVERSAL, 0);
                        break;
                }

                return false;
            }

            void Reset()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a npc_echo_of_medivh.npc_echo_of_medivhAI::Reset()");
            #endif

                eventStarted = false;
                miniEventState = MINI_EVENT_NONE;
                miniEventTimer = 5000;
                endGameEventState = GAMEEND_NONE;
                endEventTimer = 2500;
                hordePieces = 16;
                alliancePieces = 16;
                moveTimer = 60000;
                medivhSidePieces.clear();
                tpList.clear();
                moveList.clear();

                chestGUID = 0;

                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }

            void SayChessPieceDied(Unit * piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a SayChessPieceDied(Unit * piece)");
            #endif

                if (pInstance->GetData(CHESS_EVENT_TEAM) == HORDE)
                {
                    switch(piece->GetEntry())
                    {
                        case NPC_ROOK_H:
                            me->MonsterSay(SAY_LOSE_ROOK_P,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_ROOK_A:
                            me->MonsterSay(SAY_LOSE_ROOK_M,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_QUEEN_H:
                            me->MonsterSay(SAY_LOSE_QUEEN_P,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_QUEEN_A:
                            me->MonsterSay(SAY_LOSE_QUEEN_M,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_BISHOP_H:
                            me->MonsterSay(SAY_LOSE_BISHOP_P,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_BISHOP_A:
                            me->MonsterSay(SAY_LOSE_BISHOP_M,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_KNIGHT_H:
                            me->MonsterSay(SAY_LOSE_KNIGHT_P,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_KNIGHT_A:
                            me->MonsterSay(SAY_LOSE_KNIGHT_M,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_PAWN_H:

                            switch(rand()%3)
                              {
                              case 0:me->MonsterSay(SAY_LOSE_PAWN_P_1,LANG_UNIVERSAL,NULL);break;
                              case 1:me->MonsterSay(SAY_LOSE_PAWN_P_2,LANG_UNIVERSAL,NULL);break;
                              case 2:me->MonsterSay(SAY_LOSE_PAWN_P_3,LANG_UNIVERSAL,NULL);break;
                              }
                            break;

                        case NPC_PAWN_A:

                            switch(rand()%2)
                              {
                              case 0:me->MonsterSay(SAY_LOSE_PAWN_M_1,LANG_UNIVERSAL,NULL);break;
                              case 1:me->MonsterSay(SAY_LOSE_PAWN_M_2,LANG_UNIVERSAL,NULL);break;
                              }
                            break;

                        case NPC_KING_H:

                            me->MonsterSay(SAY_MEDIVH_WIN,LANG_UNIVERSAL,NULL);
                            pInstance->SetData(DATA_CHESS_EVENT, FAIL);
                            endGameEventState = GAMEEND_MEDIVH_WIN;
                            endEventTimer = 2500;
                            endEventCount = 0;
                            break;

                        case NPC_KING_A:

                            if (pInstance->GetData(DATA_DUST_COVERED_CHEST) != DONE)
                                chestGUID = me->SummonGameObject(DUST_COVERED_CHEST, DUST_COVERED_CHEST_LOCATION, 0.0f, 0.0f, 0.0f, 0.0f, 7200000.0f)->GetGUID();
                            //    me->Say("Teraz powinna sie skrzynka pojawic", LANG_UNIVERSAL, NULL); // temporary

                            me->MonsterSay(SAY_PLAYER_WIN,LANG_UNIVERSAL,NULL);
                            pInstance->SetData(DATA_CHESS_EVENT, DONE);
                            endGameEventState = GAMEEND_MEDIVH_LOSE;
                            endEventTimer = 2500;
                            endEventCount = 0;
                            break;

                        default:
                            break;
                    }
                }
                else
                {
                    switch(piece->GetEntry())
                    {
                        case NPC_ROOK_A:
                            me->MonsterSay(SAY_LOSE_ROOK_P,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_ROOK_H:
                            me->MonsterSay(SAY_LOSE_ROOK_M,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_QUEEN_A:
                            me->MonsterSay(SAY_LOSE_QUEEN_P,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_QUEEN_H:
                            me->MonsterSay(SAY_LOSE_QUEEN_M,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_BISHOP_A:
                            me->MonsterSay(SAY_LOSE_BISHOP_P,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_BISHOP_H:
                            me->MonsterSay(SAY_LOSE_BISHOP_M,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_KNIGHT_A:
                            me->MonsterSay(SAY_LOSE_KNIGHT_P,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_KNIGHT_H:
                            me->MonsterSay(SAY_LOSE_KNIGHT_M,LANG_UNIVERSAL,NULL);
                            break;
                        case NPC_PAWN_A:

                            switch(rand()%3)
                              {
                              case 0:me->MonsterSay(SAY_LOSE_PAWN_P_1,LANG_UNIVERSAL,NULL);break;
                              case 1:me->MonsterSay(SAY_LOSE_PAWN_P_2,LANG_UNIVERSAL,NULL);break;
                              case 2:me->MonsterSay(SAY_LOSE_PAWN_P_3,LANG_UNIVERSAL,NULL);break;
                              }
                            break;

                        case NPC_PAWN_H:

                            switch(rand()%2)
                              {
                              case 0:me->MonsterSay(SAY_LOSE_PAWN_M_1,LANG_UNIVERSAL,NULL);break;
                              case 1:me->MonsterSay(SAY_LOSE_PAWN_M_2,LANG_UNIVERSAL,NULL);break;
                              }
                            break;

                        case NPC_KING_A:

                            me->MonsterSay(SAY_MEDIVH_WIN,LANG_UNIVERSAL,NULL);
                            pInstance->SetData(DATA_CHESS_EVENT, FAIL);
                            endGameEventState = GAMEEND_MEDIVH_WIN;
                            endEventTimer = 2500;
                            endEventCount = 0;
                            break;

                        case NPC_KING_H:

                            if (pInstance->GetData(DATA_DUST_COVERED_CHEST) != DONE)
                                chestGUID = me->SummonGameObject(DUST_COVERED_CHEST, DUST_COVERED_CHEST_LOCATION, 0.0f, 0.0f, 0.0f, 0.0f, 7200000.0f)->GetGUID();
                            //    me->Say("Teraz powinna sie skrzynka pojawic", LANG_UNIVERSAL, NULL); // temporary

                            me->MonsterSay(SAY_PLAYER_WIN,LANG_UNIVERSAL,NULL);
                            pInstance->SetData(DATA_CHESS_EVENT, DONE);
                            endGameEventState = GAMEEND_MEDIVH_LOSE;
                            endEventTimer = 2500;
                            endEventCount = 0;
                            break;

                        default:
                            break;
                    }
                }
            }

            void RemoveChessPieceFromBoard(uint64 piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a RemoveChessPieceFromBoard(uint64 piece = %u)", piece);
            #endif

                RemoveChessPieceFromBoard(me->GetCreature(*me, piece));
            }

            void RemoveChessPieceFromBoard(Creature * piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a RemoveChessPieceFromBoard(Unit * piece = %i)", piece ? 1 : 0);
            #endif

                if (!piece)
                {
                    me->MonsterSay("RemoveChesPieceFromBoard(..) : Pion introuvable", LANG_UNIVERSAL, 0);
                    return;
                }

                Creature * tmpC;
                uint32 tmpEntry = GetDeadEntryForPiece(piece->GetEntry());

            #ifdef CHESS_DEBUG_INFO
                printf("\ntmpEntry: %u", tmpEntry);
            #endif
                if (piece->getFaction() == A_FACTION)
                {
                    --alliancePieces;
                    tmpC = me->SummonCreature(tmpEntry, allianceSideDeadWP[0][alliancePieces], allianceSideDeadWP[1][alliancePieces], POSITION_Z + 1, ORI_E, TEMPSUMMON_CORPSE_DESPAWN, 0);
                }
                else
                {
                    --hordePieces;
                    tmpC = me->SummonCreature(tmpEntry, hordeSideDeadWP[0][hordePieces], hordeSideDeadWP[1][hordePieces], POSITION_Z + 1, ORI_W, TEMPSUMMON_CORPSE_DESPAWN, 0);
                }

                if (tmpC)
                {
                    tmpC->CombatStop();
                    tmpC->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    tmpC->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    tmpC->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                }

                int tmpI = -1, tmpJ = -1;
                uint64 tmpGUID = piece->GetGUID();

                RemoveFromMoveList(tmpGUID);

                if (FindPlaceInBoard(tmpGUID, tmpI, tmpJ))
                    chessBoard[tmpI][tmpJ].piece = 0;

                bool medivhPiece = false;

                for (std::list<uint64>::iterator itr = medivhSidePieces.begin(); itr != medivhSidePieces.end();)
                {
                    std::list<uint64>::iterator tmpItr = itr;
                    ++itr;

                    if ((*tmpItr) == tmpGUID)
                    {
                        medivhSidePieces.erase(tmpItr);
                        medivhPiece = true;
                        if (tmpC)
                            unusedMedivhPieces.push_back(tmpC->GetGUID());
                        break;
                    }
                }

                if (!medivhPiece && tmpC)
                    unusedPlayerPieces.push_back(tmpC->GetGUID());

                SayChessPieceDied(piece);
            }

            void SpawnPawns()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a SpawnPawns()");
            #endif

                Creature * tmp[2][8];

                for (int i = 0; i < 8; i++)
                {
                    tmp[0][i] = me->SummonCreature(NPC_PAWN_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
                    tmp[1][i] = me->SummonCreature(NPC_PAWN_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
                    if (tmp[0][i])
                    {
            #ifdef CHESS_DEBUG_INFO
                        printf("\nPawns [0][%i] : %u ",i, tmp[0][i]->GetGUID());
            #endif
                        chessBoard[6][i].piece = tmp[0][i]->GetGUID();
                        tmp[0][i]->SetReactState(REACT_PASSIVE);
                        tmp[0][i]->GetMotionMaster()->MovePoint(0, chessBoard[6][i].position.m_positionX, chessBoard[6][i].position.m_positionY, chessBoard[6][i].position.m_positionZ);
                    }
                    chessBoard[6][i].ori = CHESS_ORI_N;
                    if (tmp[1][i])
                    {
            #ifdef CHESS_DEBUG_INFO
                        printf("\nPawns [1][%i] : %u ",i, tmp[0][i]->GetGUID());
            #endif
                        chessBoard[1][i].piece = tmp[1][i]->GetGUID();
                        tmp[1][i]->SetReactState(REACT_PASSIVE);
                        tmp[1][i]->GetMotionMaster()->MovePoint(0, chessBoard[1][i].position.m_positionX, chessBoard[1][i].position.m_positionY, chessBoard[1][i].position.m_positionZ);
                    }
                    chessBoard[1][i].ori = CHESS_ORI_S;
                }

                if (pInstance)
                {
                    if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
                        for (int i = 0; i < 8; i++)
                            medivhSidePieces.push_back(tmp[1][i]->GetGUID());
                    else
                        for (int i = 0; i < 8; i++)
                            medivhSidePieces.push_back(tmp[0][i]->GetGUID());
                }

                miniEventTimer = 10000;
            }

            void SpawnRooks()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a SpawnRooks()");
            #endif
                Creature * tmp1, * tmp2, * tmp3, * tmp4;

                tmp1 = me->SummonCreature(NPC_ROOK_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp1)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nRooks [0] : %u ", tmp1->GetGUID());
            #endif
                    chessBoard[7][0].piece = tmp1->GetGUID();
                    chessBoard[7][0].ori = CHESS_ORI_N;
                    tmp1->SetReactState(REACT_PASSIVE);
                    tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][0].position.m_positionX, chessBoard[7][0].position.m_positionY, chessBoard[7][0].position.m_positionZ);
                }

                tmp2 = me->SummonCreature(NPC_ROOK_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp2)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nRooks [1] : %u ", tmp2->GetGUID());
            #endif
                    chessBoard[7][7].piece = tmp2->GetGUID();
                    chessBoard[7][7].ori = CHESS_ORI_N;
                    tmp2->SetReactState(REACT_PASSIVE);
                    tmp2->GetMotionMaster()->MovePoint(0, chessBoard[7][7].position.m_positionX, chessBoard[7][7].position.m_positionY, chessBoard[7][7].position.m_positionZ);
                }


                tmp3 = me->SummonCreature(NPC_ROOK_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp3)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nRooks [2] : %u ", tmp3->GetGUID());
            #endif
                    chessBoard[0][0].piece = tmp3->GetGUID();
                    chessBoard[0][0].ori = CHESS_ORI_S;
                    tmp3->SetReactState(REACT_PASSIVE);
                    tmp3->GetMotionMaster()->MovePoint(0, chessBoard[0][0].position.m_positionX, chessBoard[0][0].position.m_positionY, chessBoard[0][0].position.m_positionZ);
                }

                tmp4 = me->SummonCreature(NPC_ROOK_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp4)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nRooks [3] : %u ", tmp4->GetGUID());
            #endif
                    chessBoard[0][7].piece = tmp4->GetGUID();
                    chessBoard[0][7].ori = CHESS_ORI_S;
                    tmp4->SetReactState(REACT_PASSIVE);
                    tmp4->GetMotionMaster()->MovePoint(0, chessBoard[0][7].position.m_positionX, chessBoard[0][7].position.m_positionY, chessBoard[0][7].position.m_positionZ);
                }

                if (pInstance && tmp1 && tmp2 && tmp3 && tmp4)
                {
                    if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
                    {
                        medivhSidePieces.push_back(tmp3->GetGUID());
                        medivhSidePieces.push_back(tmp4->GetGUID());
                    }
                    else
                    {
                        medivhSidePieces.push_back(tmp1->GetGUID());
                        medivhSidePieces.push_back(tmp2->GetGUID());
                    }
                }
                miniEventTimer = 5000;
            }

            void SpawnKnights()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a SpawnKnights()");
            #endif
                Creature * tmp1, * tmp2, * tmp3, * tmp4;

                tmp1 = me->SummonCreature(NPC_KNIGHT_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp1)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nKnights [0] : %u ", tmp1->GetGUID());
            #endif
                    chessBoard[7][1].piece = tmp1->GetGUID();
                    chessBoard[7][1].ori = CHESS_ORI_N;
                    tmp1->SetReactState(REACT_PASSIVE);
                    tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][1].position.m_positionX, chessBoard[7][1].position.m_positionY, chessBoard[7][1].position.m_positionZ);
                }

                tmp2 = me->SummonCreature(NPC_KNIGHT_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp2)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nKnights [1] : %u ", tmp2->GetGUID());
            #endif
                    chessBoard[7][6].piece = tmp2->GetGUID();
                    chessBoard[7][6].ori = CHESS_ORI_N;
                    tmp2->SetReactState(REACT_PASSIVE);
                    tmp2->GetMotionMaster()->MovePoint(0, chessBoard[7][6].position.m_positionX, chessBoard[7][6].position.m_positionY, chessBoard[7][6].position.m_positionZ);
                }


                tmp3 = me->SummonCreature(NPC_KNIGHT_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp3)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nKnights [2] : %u ", tmp3->GetGUID());
            #endif
                    chessBoard[0][1].piece = tmp3->GetGUID();
                    chessBoard[0][1].ori = CHESS_ORI_S;
                    tmp3->SetReactState(REACT_PASSIVE);
                    tmp3->GetMotionMaster()->MovePoint(0, chessBoard[0][1].position.m_positionX, chessBoard[0][1].position.m_positionY, chessBoard[0][1].position.m_positionZ);
                }

                tmp4 = me->SummonCreature(NPC_KNIGHT_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp4)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nKnights [3] : %u ", tmp4->GetGUID());
            #endif
                    chessBoard[0][6].piece = tmp4->GetGUID();
                    chessBoard[0][6].ori = CHESS_ORI_S;
                    tmp4->SetReactState(REACT_PASSIVE);
                    tmp4->GetMotionMaster()->MovePoint(0, chessBoard[0][6].position.m_positionX, chessBoard[0][6].position.m_positionY, chessBoard[0][6].position.m_positionZ);
                }

                if (pInstance && tmp1 && tmp2 && tmp3 && tmp4)
                {
                    if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
                    {
                        medivhSidePieces.push_back(tmp3->GetGUID());
                        medivhSidePieces.push_back(tmp4->GetGUID());
                    }
                    else
                    {
                        medivhSidePieces.push_back(tmp1->GetGUID());
                        medivhSidePieces.push_back(tmp2->GetGUID());
                    }
                }
                miniEventTimer = 5000;
            }

            void SpawnBishops()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a SpawnBishops()");
            #endif
                Creature * tmp1, * tmp2, * tmp3, * tmp4;

                tmp1 = me->SummonCreature(NPC_BISHOP_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp1)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nBishops [0] : %u ", tmp1->GetGUID());
            #endif
                    chessBoard[7][2].piece = tmp1->GetGUID();
                    chessBoard[7][2].ori = CHESS_ORI_N;
                    tmp1->SetReactState(REACT_PASSIVE);
                    tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][2].position.m_positionX, chessBoard[7][2].position.m_positionY, chessBoard[7][2].position.m_positionZ);
                }

                tmp2 = me->SummonCreature(NPC_BISHOP_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp2)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nBishops [1] : %u ", tmp2->GetGUID());
            #endif
                    chessBoard[7][5].piece = tmp2->GetGUID();
                    chessBoard[7][5].ori = CHESS_ORI_N;
                    tmp2->SetReactState(REACT_PASSIVE);
                    tmp2->GetMotionMaster()->MovePoint(0, chessBoard[7][5].position.m_positionX, chessBoard[7][5].position.m_positionY, chessBoard[7][5].position.m_positionZ);
                }


                tmp3 = me->SummonCreature(NPC_BISHOP_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp3)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nBishops [2] : %u ", tmp3->GetGUID());
            #endif
                    chessBoard[0][2].piece = tmp3->GetGUID();
                    chessBoard[0][2].ori = CHESS_ORI_S;
                    tmp3->SetReactState(REACT_PASSIVE);
                    tmp3->GetMotionMaster()->MovePoint(0, chessBoard[0][2].position.m_positionX, chessBoard[0][2].position.m_positionY, chessBoard[0][2].position.m_positionZ);
                }

                tmp4 = me->SummonCreature(NPC_BISHOP_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp4)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nBishops [3] : %u ", tmp4->GetGUID());
            #endif
                    chessBoard[0][5].piece = tmp4->GetGUID();
                    chessBoard[0][5].ori = CHESS_ORI_S;
                    tmp4->SetReactState(REACT_PASSIVE);
                    tmp4->GetMotionMaster()->MovePoint(0, chessBoard[0][5].position.m_positionX, chessBoard[0][5].position.m_positionY, chessBoard[0][5].position.m_positionZ);
                }

                if (pInstance && tmp1 && tmp2 && tmp3 && tmp4)
                {
                    if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
                    {
                        medivhSidePieces.push_back(tmp3->GetGUID());
                        medivhSidePieces.push_back(tmp4->GetGUID());
                    }
                    else
                    {
                        medivhSidePieces.push_back(tmp1->GetGUID());
                        medivhSidePieces.push_back(tmp2->GetGUID());
                    }
                }

                miniEventTimer = 5000;
            }

            void SpawnQueens()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a SpawnQueens()");
            #endif
                Creature * tmp1, * tmp2;

                tmp1 = me->SummonCreature(NPC_QUEEN_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp1)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nQuens [0] : %u ", tmp1->GetGUID());
            #endif
                    chessBoard[7][3].piece = tmp1->GetGUID();
                    chessBoard[7][3].ori = CHESS_ORI_N;
                    tmp1->SetReactState(REACT_PASSIVE);
                    tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][3].position.m_positionX, chessBoard[7][3].position.m_positionY, chessBoard[7][3].position.m_positionZ);
                }

                tmp2 = me->SummonCreature(NPC_QUEEN_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp2)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nQuens [1] : %u ", tmp2->GetGUID());
            #endif
                    chessBoard[0][3].piece = tmp2->GetGUID();
                    chessBoard[0][3].ori = CHESS_ORI_S;
                    tmp2->SetReactState(REACT_PASSIVE);
                    tmp2->GetMotionMaster()->MovePoint(0, chessBoard[0][3].position.m_positionX, chessBoard[0][3].position.m_positionY, chessBoard[0][3].position.m_positionZ);
                }

                if (pInstance && tmp1 && tmp2)
                {
                    if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
                        medivhSidePieces.push_back(tmp2->GetGUID());
                    else
                        medivhSidePieces.push_back(tmp1->GetGUID());
                }
                miniEventTimer = 5000;
            }

            void SpawnKings()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a SpawnKings()");
            #endif
                Creature * tmp1, * tmp2;

                tmp1 = me->SummonCreature(NPC_KING_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp1)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nKings [0] : %u", tmp1->GetGUID());
            #endif
                    chessBoard[7][4].piece = tmp1->GetGUID();
                    chessBoard[7][4].ori = CHESS_ORI_N;
                    tmp1->SetReactState(REACT_PASSIVE);
                    tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][4].position.m_positionX, chessBoard[7][4].position.m_positionY, chessBoard[7][4].position.m_positionZ);
                }

                tmp2 = me->SummonCreature(NPC_KING_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

                if (tmp2)
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nKings [1] : %u ", tmp2->GetGUID());
            #endif
                    chessBoard[0][4].piece = tmp2->GetGUID();
                    chessBoard[0][4].ori = CHESS_ORI_S;
                    tmp2->SetReactState(REACT_PASSIVE);
                    tmp2->GetMotionMaster()->MovePoint(0, chessBoard[0][4].position.m_positionX, chessBoard[0][4].position.m_positionY, chessBoard[0][4].position.m_positionZ);
                }

                if (pInstance && tmp1 && tmp2)
                {
                    if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
                        medivhSidePieces.push_back(tmp2->GetGUID());
                    else
                        medivhSidePieces.push_back(tmp1->GetGUID());
                }
                miniEventTimer = 5000;
            }

            void SpawnTriggers()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a SpawnTriggers()");
            #endif
                Creature * tmp = NULL;

                for (int i = 0; i < 8; i++)
                {
                    for (int j = 0; j < 8; j++)
                    {
                        tmp = me->SummonCreature(TRIGGER_ID, chessBoard[i][j].position.m_positionX, chessBoard[i][j].position.m_positionY, chessBoard[i][j].position.m_positionZ, ORI_W, TEMPSUMMON_DEAD_DESPAWN, 0);
                        if (tmp)
                        {
            #ifdef CHESS_DEBUG_INFO
                            printf("\nTriggers [%i][%i] : %u ", i, j, tmp->GetGUID());
            #endif
                            chessBoard[i][j].trigger = tmp->GetGUID();
                            if (i > 1 && i < 6)
                            {
                                chessBoard[i][j].piece = 0;
                                chessBoard[i][j].ori = CHESS_ORI_CHOOSE;
                            }
                            tmp->SetReactState(REACT_PASSIVE);
                        }
                    }
                }
            }

            void ClearBoard()
            {
                Creature * tmpC;
                for (int i = 0; i < 8; ++i)
                {
                    for (int j = 0; j < 8; ++j)
                    {
                        if (tmpC = me->GetCreature(*me, chessBoard[i][j].piece))
                        {
                            tmpC->SetVisible(false);
                            tmpC->DestroyForNearbyPlayers();
                            tmpC->Kill(tmpC, false);
                            tmpC->RemoveCorpse();
                        }

                        if (tmpC = me->GetCreature(*me, chessBoard[i][j].trigger))
                        {
                            tmpC->SetVisible(false);
                            tmpC->DestroyForNearbyPlayers();
                            tmpC->Kill(tmpC, false);
                            tmpC->RemoveCorpse();
                        }

                        chessBoard[i][j].piece = 0;
                        chessBoard[i][j].trigger = 0;
                        chessBoard[i][j].ori = CHESS_ORI_CHOOSE;
                    }
                }

                for (std::list<uint64>::iterator itr = unusedMedivhPieces.begin(); itr != unusedMedivhPieces.end(); ++itr)
                {
                    if (tmpC = me->GetCreature(*me, *itr))
                    {
                        tmpC->SetVisible(false);
                        tmpC->DestroyForNearbyPlayers();
                        tmpC->Kill(tmpC, false);
                        tmpC->RemoveCorpse();
                    }
                }

                for (std::list<uint64>::iterator itr = unusedPlayerPieces.begin(); itr != unusedPlayerPieces.end(); ++itr)
                {
                    if (tmpC = me->GetCreature(*me, *itr))
                    {
                        tmpC->SetVisible(false);
                        tmpC->DestroyForNearbyPlayers();
                        tmpC->Kill(tmpC, false);
                        tmpC->RemoveCorpse();
                    }
                }

                unusedMedivhPieces.clear();
                unusedPlayerPieces.clear();
                medivhSidePieces.clear();

                Map::PlayerList const &plList = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = plList.begin(); itr != plList.end(); ++itr)
                    if (Player * plr = itr->getSource())
                        plr->RemoveAurasDueToSpell(SPELL_POSSES_CHESSPIECE);
            }

            void PrepareBoardForEvent()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a PrepareBoardForEvent()");
            #endif

                SpawnTriggers();
                SpawnKings();

                firstCheatTimer = urand(FIRST_CHEAT_TIMER_MIN, FIRST_CHEAT_TIMER_MAX);
                secondCheatTimer = urand(SECOND_CHEAT_TIMER_MIN, SECOND_CHEAT_TIMER_MAX);
                thirdCheatTimer = urand(THIRD_CHEAT_TIMER_MIN, THIRD_CHEAT_TIMER_MAX);
                firstCheatDamageReq = urand(FIRST_CHEAT_HP_MIN*1000, FIRST_CHEAT_HP_MAX*1000)/1000.0;
                secondCheatDamageReq = urand(SECOND_CHEAT_HP_MIN*1000, SECOND_CHEAT_HP_MAX*1000)/1000.0;
                thirdCheatDamagereq = urand(THIRD_CHEAT_HP_MIN*1000, THIRD_CHEAT_HP_MAX*1000)/1000.0;
                pInstance->SetData(DATA_CHESS_DAMAGE, 0);
            }

            void StartMiniEvent()
            {
                ClearBoard();

                if (chestGUID)
                    return;

                miniEventState = MINI_EVENT_KING;

                pInstance->SetData(DATA_DUST_COVERED_CHEST, IN_PROGRESS);
            }

            void StartEvent()
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a StartEvent()");
            #endif

                DoZoneInCombat();
                eventStarted = true;
                addPieceToMoveCheckTimer = 10000;
            }

            void DeleteChest()
            {
                if (chestGUID)
                {
                    GameObject * tmpObj = me->GetMap()->GetGameObject(chestGUID);
                    if (tmpObj)
                        tmpObj->Delete();

                    chestGUID = 0;
                }
            }

            void UpdateAI(const uint32 diff)
            {
                if (miniEventState)
                {
                    if (miniEventTimer < diff)
                    {
                        switch(miniEventState)
                        {
                            case MINI_EVENT_KING:
                                PrepareBoardForEvent();
                                miniEventState = MINI_EVENT_QUEEN;
                                break;
                            case MINI_EVENT_QUEEN:
                                SpawnQueens();
                                miniEventState = MINI_EVENT_BISHOP;
                                break;
                            case MINI_EVENT_BISHOP:
                                SpawnBishops();
                                miniEventState = MINI_EVENT_KNIGHT;
                                break;
                            case MINI_EVENT_KNIGHT:
                                SpawnKnights();
                                miniEventState = MINI_EVENT_ROOK;
                                break;
                            case MINI_EVENT_ROOK:
                                SpawnRooks();
                                miniEventState = MINI_EVENT_PAWN;
                                break;
                            case MINI_EVENT_PAWN:
                                SpawnPawns();
                                miniEventState = MINI_EVENT_END;
                                break;
                            default:
                                miniEventState = MINI_EVENT_NONE;
                    #ifdef CHESS_DEBUG_INFO
                        printf("\nTableau:");
                    #endif
                                Creature * tmpC;
                                for (int i = 0; i < 8; i++)
                                {
                                    for (int j = 0; j < 8; j++)
                                    {
                                        ChangePieceFacing(chessBoard[i][j].piece, chessBoard[4][j].trigger);
                    #ifdef CHESS_DEBUG_INFO
                        printf("\ni: %i, j: %i, piece: %u, trigger: %u", i, j, chessBoard[i][j].piece, chessBoard[i][j].trigger);
                    #endif
                                        if (tmpC = me->GetCreature(*me, chessBoard[i][j].piece))
                                        {
                                            tmpC->CastSpell(tmpC, SPELL_MOVE_MARKER, false);
                                            //tmpC->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
                                        }
                                    }
                                }
                                moveTimer = 10000;
                                break;
                        }
                    }
                    else
                        miniEventTimer -= diff;
                    return;
                }

                if (endGameEventState)
                {
                    if (endEventTimer < diff)
                    {
                        Creature * tmpC;
                        endEventTimer = 2500;
                        switch (endGameEventState)
                        {
                            case GAMEEND_MEDIVH_WIN:
                                for (std::list<uint64>::iterator itr = unusedMedivhPieces.begin(); itr != unusedMedivhPieces.end(); ++itr)
                                    if (tmpC = me->GetCreature(*me, *itr))
                                        tmpC->HandleEmoteCommand(RAND(EMOTE_ONESHOT_CHEER, EMOTE_ONESHOT_APPLAUD));

                                for (std::list<uint64>::iterator itr = unusedPlayerPieces.begin(); itr != unusedPlayerPieces.end(); ++itr)
                                    if (tmpC = me->GetCreature(*me, *itr))
                                        tmpC->HandleEmoteCommand(EMOTE_ONESHOT_CRY);

                                if (endEventCount >= 5)
                                    endGameEventState = GAMEEND_CLEAR_BOARD;
                                break;
                            case GAMEEND_MEDIVH_LOSE:
                                for (std::list<uint64>::iterator itr = unusedPlayerPieces.begin(); itr != unusedPlayerPieces.end(); ++itr)
                                    if (tmpC = me->GetCreature(*me, *itr))
                                        tmpC->HandleEmoteCommand(RAND(EMOTE_ONESHOT_CHEER, EMOTE_ONESHOT_APPLAUD));

                                for (std::list<uint64>::iterator itr = unusedMedivhPieces.begin(); itr != unusedMedivhPieces.end(); ++itr)
                                    if (tmpC = me->GetCreature(*me, *itr))
                                        tmpC->HandleEmoteCommand(EMOTE_ONESHOT_CRY);

                                if (endEventCount >= 5)
                                    endGameEventState = GAMEEND_CLEAR_BOARD;
                                break;
                            case GAMEEND_CLEAR_BOARD:
                                ClearBoard();
                                endGameEventState = GAMEEND_DESPAWN_CHEST;

                                if (chestGUID)
                                    endEventTimer = 180000;
                                break;
                            case GAMEEND_DESPAWN_CHEST:
                                DeleteChest();
                                EnterEvadeMode();
                                return;
                        }
                        endEventCount++;
                    }
                    else
                        endEventTimer -= diff;

                    /*if (endEventLightningTimer < diff)
                    {
                        Creature * tmpC;
                        int count = rand()%5;

                        for (int i = 0; i < count; ++i)
                            if (tmpC = me->GetCreature(chessBoard[rand()%8][rand()%8].trigger))
                                me->CastSpell(tmpC, SPELL_GAME_OVER, true);
                        endEventLightningTimer = urand(100, 1000);
                    }
                    else
                        endEventLightningTimer -= diff;*/

                    return;
                }

                if (!eventStarted)
                    return;

                if (addPieceToMoveCheckTimer <= diff)
                {
                    if (urand(0, 100) < chanceToSelfMove)
                        ChoosePieceToMove();

                    addPieceToMoveCheckTimer = ADD_PIECE_TO_MOVE_TIMER;
                }
                else
                    addPieceToMoveCheckTimer -= diff;

                if (firstCheatTimer <= diff)
                {
                    if (firstCheatDamageReq < pInstance->GetData(DATA_CHESS_DAMAGE))
                    {
                        std::list<ChessTile> tmpList;

                        for (int i = 0; i < 8; ++i)
                            for (int j = 0; j < 8; ++j)
                                if (chessBoard[i][j].piece && !IsMedivhsPiece(chessBoard[i][j].piece))
                                    tmpList.push_back(ChessTile(chessBoard[i][j]));

                        int tmp = 3;
                        if (tmpList.size() < 3)
                            tmp = tmpList.size();

                        for (int i = 0; i < tmp; ++i)
                        {
                            std::list<ChessTile>::iterator itr = tmpList.begin();
                            advance(itr, urand(0, tmpList.size()-1));

                            if (Creature * tmpC = me->GetCreature(*me, (*itr).trigger))
                                tmpC->CastSpell(tmpC, SPELL_FURY_OF_MEDIVH, false);

                            me->MonsterSay(SAY_MEDIVH_CHEAT_1,LANG_UNIVERSAL,NULL);

                            tmpList.erase(itr);
                        }

                        firstCheatTimer = urand(FIRST_CHEAT_TIMER_MIN, FIRST_CHEAT_TIMER_MAX)/2;
                    }
                    else
                        firstCheatTimer = 5000; // next check in 5 seconds
                }
                else
                    firstCheatTimer -= diff;

                if (secondCheatTimer <= diff)
                {
                    if (secondCheatDamageReq < pInstance->GetData(DATA_CHESS_DAMAGE))
                    {
                        std::list<ChessTile> tmpList;

                        for (int i = 0; i < 8; ++i)
                            for (int j = 0; j < 8; ++j)
                                if (chessBoard[i][j].piece && IsMedivhsPiece(chessBoard[i][j].piece))
                                    tmpList.push_back(ChessTile(chessBoard[i][j]));

                        int tmp = 3;
                        if (tmpList.size() < 3)
                            tmp = tmpList.size();

                        for (int i = 0; i < tmp; ++i)
                        {
                            std::list<ChessTile>::iterator itr = tmpList.begin();
                            advance(itr, urand(0, tmpList.size()-1));

                            if (Creature * tmpC = me->GetCreature(*me, (*itr).trigger))
                                tmpC->CastSpell(tmpC, SPELL_HAND_OF_MEDIVH, false);

                            me->MonsterSay(SAY_MEDIVH_CHEAT_2, LANG_UNIVERSAL, NULL);

                            tmpList.erase(itr);
                        }

                        secondCheatTimer = urand(SECOND_CHEAT_TIMER_MIN, SECOND_CHEAT_TIMER_MAX)/2;
                    }
                    else
                        secondCheatTimer = 5000; // next check in 5 seconds
                }
                else
                    secondCheatTimer -= diff;

                if (thirdCheatTimer <= diff)
                {
                    if (thirdCheatDamagereq < pInstance->GetData(DATA_CHESS_DAMAGE))
                    {
                        for (std::list<uint64>::iterator itr = medivhSidePieces.begin(); itr != medivhSidePieces.end(); ++itr)
                            if (Creature * tmpC = me->GetCreature(*me, *itr))
                                tmpC->SetHealth(tmpC->GetMaxHealth());

                        me->MonsterSay(SAY_MEDIVH_CHEAT_3, LANG_UNIVERSAL, NULL);

                        thirdCheatTimer = urand(THIRD_CHEAT_TIMER_MIN, THIRD_CHEAT_TIMER_MAX)/2;
                    }
                    else
                        thirdCheatTimer = 5000; // next check in 5 seconds
                }
                else
                    thirdCheatTimer -= diff;
            }

            void SetOrientation(uint64 piece, ChessOrientation ori = CHESS_ORI_CHOOSE)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a SetOrientation(uint64 piece = %u, ChessOrientation ori = %i)", piece, ori);
            #endif
                int tmpi = -1, tmpj = -1;    //temp piece location in array

                if (!FindPlaceInBoard(piece, tmpi, tmpj))
                    return;

                if (ori == CHESS_ORI_CHOOSE)
                {
                    float tmpN = 99, tmpS = 99, tmpE = 99, tmpW = 99;
                    float pieceOri;

                    Creature * tmpPiece = me->GetCreature(*me, piece);
                    if (tmpPiece)
                    {
                        pieceOri = tmpPiece->GetOrientation();
                        if (pieceOri <0)
                            pieceOri += 2* M_PI;
                        if (pieceOri > ORI_N && pieceOri <= ORI_W)
                        {
                            tmpN = pieceOri - ORI_N;
                            tmpW = ORI_W - pieceOri;

                            if (tmpN < tmpW)
                                ori = CHESS_ORI_N;
                            else
                                ori = CHESS_ORI_W;
                        }
                        else if (pieceOri > ORI_W && pieceOri <= ORI_S)
                        {
                            tmpW = pieceOri - ORI_W;
                            tmpS = ORI_S - pieceOri;

                            if (tmpW < tmpS)
                                ori = CHESS_ORI_W;
                            else
                                ori = CHESS_ORI_S;
                        }
                        else if (pieceOri > ORI_S && pieceOri <= ORI_E)
                        {
                            tmpS = pieceOri - ORI_S;
                            tmpE = ORI_E - pieceOri;

                            if (tmpS < tmpE)
                                ori = CHESS_ORI_S;
                            else
                                ori = CHESS_ORI_E;
                        }
                        else if (pieceOri > ORI_E)
                        {
                            tmpE = pieceOri - ORI_E;
                            tmpN = 6.28 + ORI_N - pieceOri;

                            if (tmpE < tmpN)
                                ori = CHESS_ORI_E;
                            else
                                ori = CHESS_ORI_N;
                        }
                        else if (pieceOri <= ORI_N)
                        {
                            tmpW = 6.28 + pieceOri - ORI_E;
                            tmpN = ORI_N - pieceOri;

                            if (tmpE < tmpN)
                                ori = CHESS_ORI_E;
                            else
                                ori = CHESS_ORI_N;
                        }
                    }
            #ifdef CHESS_DEBUG_INFO
                    printf("\npieceori: %f, tmpW: %f, tmpE: %f, tmpN: %f, tmpS: %f", pieceOri, tmpW, tmpE, tmpN, tmpS);
            #endif
                }

            #ifdef CHESS_DEBUG_INFO
                printf("\nori: %i", ori);
            #endif

                chessBoard[tmpi][tmpj].ori = ori;

                Creature * cPiece = me->GetMap()->GetCreature(piece);
                if (cPiece)
                {
                    switch (ori)
                    {
                        case CHESS_ORI_N:
                            cPiece->SetOrientation(ORI_N);
                            break;
                        case CHESS_ORI_E:
                            cPiece->SetOrientation(ORI_E);
                            break;
                        case CHESS_ORI_S:
                            cPiece->SetOrientation(ORI_S);
                            break;
                        case CHESS_ORI_W:
                            cPiece->SetOrientation(ORI_W);
                            break;
                        default:
                            break;
                    }

                    //cPiece->SendHeartBeat();
                    cPiece->SendMovementFlagUpdate();
            /*
                    me->GetMap()->CreatureRelocation(cPiece, chessBoard[tmpi][tmpj].position.coord_x, chessBoard[tmpi][tmpj].position.coord_y, chessBoard[tmpi][tmpj].position.coord_z, cPiece->GetOrientation());

                    Map::PlayerList const& players = m_creature->GetMap()->GetPlayers();

                    if (!players.isEmpty())
                        for(Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                            if (Player* plr = itr->getSource())
                                cPiece->NearTeleportTo(chessBoard[tmpi][tmpj].position.coord_x, chessBoard[tmpi][tmpj].position.coord_y, chessBoard[tmpi][tmpj].position.coord_z, 0);
            */
                }
            }

            uint64 FindTriggerGUID(uint64 piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a FindTriggerGUID(uint64 piece = %u)", piece);
            #endif
                for (int i = 0; i < 8; i++)
                {
                    for (int j = 0; j < 8; j++)
                    {
                        if (chessBoard[i][j].piece == piece)
                            return chessBoard[i][j].trigger;
                    }
                }

                return 0;
            }

            Creature * FindTrigger(uint64 piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a FindTrigger(uint64 piece = %u)", piece);
            #endif
                for (int i = 0; i < 8; i++)
                {
                    for (int j = 0; j < 8; j++)
                    {
                        if (chessBoard[i][j].piece == piece)
                            return me->GetCreature(*me, chessBoard[i][j].trigger);
                    }
                }

                return NULL;
            }

            bool ChessSquareIsEmpty(uint64 trigger)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a ChessSquareIsEmpty(uint64 trigger = %u)", trigger);
            #endif
                if (IsInMoveList(trigger, true))
                    return false;

                for (int i = 0; i < 8; i++)
                {
                    for (int j = 0; j < 8; j++)
                    {
                        if (chessBoard[i][j].trigger == trigger)
                        {
                            if (chessBoard[i][j].piece)
                                return false;
                            else
                                return true;
                        }
                    }
                }

                return false;
            }

            bool ChessSquareIsEmpty(int i, int j)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a ChessSquareIsEmpty(int i = %i, int j = %i)", i, j);
            #endif
                if (IsInMoveList(chessBoard[i][j].trigger))
                    return false;

                if (chessBoard[i][j].piece)
                    return false;

                return true;
            }

            bool CanMoveTo(uint64 trigger, uint64 piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a CanMoveTo(uint64 trigger = %u, uint64 piece = %u)", trigger, piece);
            #endif
                if (!trigger || !piece)
                    return false;

                int moveRange = GetMoveRange(piece);
                bool inRange = IsInMoveRange(piece, trigger, moveRange);
                bool isEmpty = ChessSquareIsEmpty(trigger);
            #ifdef CHESS_DEBUG_INFO
                printf("\nCanMoveTo: moveRange %i, isInRange %i, isEmpty %i", moveRange, inRange, isEmpty);
            #endif
                return inRange && isEmpty;
            }

            void AddTriggerToMove(uint64 trigger, uint64 piece, bool player)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a AddTriggerToMove(uint64 trigger = %u, uint64 piece = %u, bool player = %i)", trigger, piece, player);
            #endif
                RemoveFromMoveList(piece);
                ChessTile tmp;
                tmp.piece = piece;
                tmp.trigger = trigger;

                moveList.push_back(tmp);

                uint16 tmpChance = urand(0, 100);

                //check, if tmpChance is higher than chanceToMove then medivh also can move one of his pieces
                if (player && tmpChance < chanceToMove)
                    ChoosePieceToMove();
            }

            void RemoveFromMoveList(uint64 unit);

            void ChangePlaceInBoard(uint64 piece, uint64 destTrigger)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a ChangePlaceInBoard(uint64 piece = %u, uint64 destTrigger = %u)", piece, destTrigger);
            #endif
                for (int i = 0; i < 8; ++i)
                {
                    for (int j = 0; j < 8; ++j)
                    {
                        if (chessBoard[i][j].piece == piece && chessBoard[i][j].trigger != destTrigger)
                        {
                            chessBoard[i][j].piece = 0;
                            chessBoard[i][j].ori = CHESS_ORI_CHOOSE;
                        }

                        if (chessBoard[i][j].trigger == destTrigger)
                        {
                            chessBoard[i][j].piece = piece;
                            chessBoard[i][j].ori = CHESS_ORI_CHOOSE;
                        }
                    }
                }

            }

            void ChangePieceFacing(uint64 piece, uint64 destTrigger)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a ChangePieceFacing(uint64 piece = %u, uint64 destTrigger = %u)", piece, destTrigger);
            #endif
                ChangePieceFacing(me->GetCreature(*me, piece), me->GetCreature(*me, destTrigger));
            }

            void ChangePieceFacing(Creature * piece, Creature * destTrigger)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a ChangePieceFacing(Creature * piece = %i, Creature * destTrigger = %i)", piece ? 1 : 0, destTrigger ? 1 : 0);
            #endif

                if (!piece || !destTrigger)
                    return;

                piece->SetInFront(destTrigger);
                SetOrientation(piece->GetGUID());
            /*
                int tmpI = -1, tmpJ = -1;

                if (!FindPlaceInBoard(piece->GetGUID(), tmpI, tmpJ))
                    return;

                Creature * tmpC = NULL;
                switch (chessBoard[tmpI][tmpJ].ori)
                {
                    case CHESS_ORI_N:
                        tmpC = me->GetCreature(chessBoard[tmpI - 1][tmpJ].trigger);
                        break;
                    case CHESS_ORI_E:
                        tmpC = me->GetCreature(chessBoard[tmpI][tmpJ + 1].trigger);
                        break;
                    case CHESS_ORI_S:
                        tmpC = me->GetCreature(chessBoard[tmpI + 1][tmpJ].trigger);
                        break;
                    case CHESS_ORI_W:
                        tmpC = me->GetCreature(chessBoard[tmpI][tmpJ - 1].trigger);
                        break;
                }

                if (tmpC)
                    piece->SetFacingToObject(tmpC);
            */
            }

            uint32 GetMoveSpell(uint64 piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a GetMoveSpell(uint64 piece = %u)", piece);
            #endif
                return GetMoveSpell(me->GetCreature(*me, piece));
            }

            uint32 GetMoveSpell(Creature * piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a GetMoveSpell(Creature * piece = %i)", piece ? 1 : 0);
            #endif
                if (!piece)
                    return 0;

                switch (piece->GetEntry())
                {
                    case NPC_QUEEN_A:
                    case NPC_QUEEN_H:
                        return SPELL_MOVE_4;
                    case NPC_KING_A:
                    case NPC_KING_H:
                        return SPELL_MOVE_5;
                    case NPC_BISHOP_A:
                    case NPC_BISHOP_H:
                        return SPELL_MOVE_6;
                    case NPC_KNIGHT_A:
                    case NPC_KNIGHT_H:
                        return SPELL_MOVE_3;
                    case NPC_ROOK_A:
                    case NPC_ROOK_H:
                        return SPELL_MOVE_7;
                    case NPC_PAWN_A:
                    case NPC_PAWN_H:
                        return SPELL_MOVE_1;
                }

                return 0;
            }

            bool FindPlaceInBoard(uint64 unit, int & i, int & j)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a: FindPlaceInBoard(uint64 unit = %u, int & i = %i, int & j = %i)", unit, i, j);
            #endif
                for (int x = 0; x < 8; ++x)
                {
                    for (int y = 0; y < 8; ++y)
                    {
                        if (chessBoard[x][y].piece == unit || chessBoard[x][y].trigger == unit)
                        {
                            i = x;
                            j = y;
                            return true;
                        }
                    }
                }
                return false;
            }

            /*
            pseudocode:

                for each medivh piece:
                    calculate actual square priority
                    for each square in range:
                        if square is empty and isn't in move list then:
                            calculate priority
                            if priority is > 0
                                add square info (priority) to list
                                sum priority
                    if square info list in not empty
                        choose random priority from 0 to priority sum
                        search for square for randomed priority
                        if chosen position is better than actual position (rand(0, chosen+actual) > actual)
                            add possible move to list

                sum square move priorities
                choose random (or best ?) move from list

                make move to chosen

            Calculate Priority:
                set base priority for square
                modify priority based on count of enemies in melee
                modify priority based on way were we want to move
            */

            int CalculatePriority(uint64 piece, uint64 trigger)
            {
                // set base priority for square
                int tmpPrior = START_PRIORITY;
                int pieceId = GetEntry(piece);

                // modify priority based on count of enemies in melee

                int meleeCount = GetCountOfEnemyInMelee(piece, true);

                switch (pieceId)
                {
                    case NPC_PAWN_A:
                    case NPC_PAWN_H:
                        switch (meleeCount)
                        {
                            case 0:
                                tmpPrior += MELEE_PRIORITY_1_0;
                                break;
                            case 1:
                                tmpPrior += MELEE_PRIORITY_1_1;
                                break;
                            case 2:
                                tmpPrior += MELEE_PRIORITY_1_2;
                                break;
                            case 3:
                                tmpPrior += MELEE_PRIORITY_1_3;
                                break;
                            default:
                                tmpPrior += MELEE_PRIORITY_1_4;
                                break;
                        }
                        break;

                    case NPC_ROOK_A:
                    case NPC_ROOK_H:
                    case NPC_KNIGHT_A:
                    case NPC_KNIGHT_H:
                        switch (meleeCount)
                        {
                            case 0:
                                tmpPrior += MELEE_PRIORITY_2_0;
                                break;
                            case 1:
                                tmpPrior += MELEE_PRIORITY_2_1;
                                break;
                            case 2:
                                tmpPrior += MELEE_PRIORITY_2_2;
                                break;
                            case 3:
                                tmpPrior += MELEE_PRIORITY_2_3;
                                break;
                            default:
                                tmpPrior += MELEE_PRIORITY_2_4;
                                break;
                        }
                        break;

                    case NPC_KING_A:
                    case NPC_KING_H:
                        switch (meleeCount)
                        {
                            case 0:
                                tmpPrior += MELEE_PRIORITY_3_0;
                                break;
                            case 1:
                                tmpPrior += MELEE_PRIORITY_3_1;
                                break;
                            case 2:
                                tmpPrior += MELEE_PRIORITY_3_2;
                                break;
                            case 3:
                                tmpPrior += MELEE_PRIORITY_3_3;
                                break;
                            default:
                                tmpPrior += MELEE_PRIORITY_3_4;
                                break;
                        }
                        break;

                    case NPC_QUEEN_A:
                    case NPC_QUEEN_H:
                    case NPC_BISHOP_A:
                    case NPC_BISHOP_H:
                        switch (meleeCount)
                        {
                            case 0:
                                tmpPrior += MELEE_PRIORITY_4_0;
                                break;
                            case 1:
                                tmpPrior += MELEE_PRIORITY_4_1;
                                break;
                            case 2:
                                tmpPrior += MELEE_PRIORITY_4_2;
                                break;
                            case 3:
                                tmpPrior += MELEE_PRIORITY_4_3;
                                break;
                            default:
                                tmpPrior += MELEE_PRIORITY_4_4;
                                break;
                        }
                        break;
                }

                // modify priority based on way were we want to move

                int tmpIP, tmpJP, tmpIT, tmpJT;

                if (FindPlaceInBoard(piece, tmpIP, tmpJP) && FindPlaceInBoard(trigger, tmpIT, tmpJT))
                {
                    if (tmpIP == tmpIT && tmpJP == tmpJT)
                        tmpPrior += STAY_IN_PLACE_PRIOR_MOD;
                    else
                    {
                        if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)   // if player is alliance
                        {
                            if (tmpIP < 2)
                            {
                                if (tmpIP > tmpIT)
                                    tmpPrior += MOVE_BACK_PRIOR_MOD;
                                else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                    tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/4 : MOVE_STRAFE_PRIOR_MOD);
                                else
                                    tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                            }
                            else
                            {
                                if (tmpIP > 5)
                                {
                                    if (tmpIP < tmpIT)
                                        tmpPrior += MOVE_BACK_PRIOR_MOD;
                                    else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                        tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/4 : MOVE_STRAFE_PRIOR_MOD);
                                    else
                                        tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                                }
                                else
                                {
                                    if (tmpIP < 4)
                                    {
                                        if (tmpIP > tmpIT)
                                            tmpPrior += MOVE_BACK_PRIOR_MOD/2;
                                        else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                            tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/8 : MOVE_STRAFE_PRIOR_MOD/4);
                                        else
                                            tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                                    }
                                    else
                                    {
                                        if (tmpIP > 3)
                                        {
                                            if (tmpIP > tmpIT)
                                                tmpPrior += MOVE_BACK_PRIOR_MOD/3;
                                            else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                                tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/8 : MOVE_STRAFE_PRIOR_MOD/4);
                                            else
                                                tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (tmpIP > 5)
                            {
                                if (tmpIP < tmpIT)
                                    tmpPrior += MOVE_BACK_PRIOR_MOD;
                                else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                    tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/4 : MOVE_STRAFE_PRIOR_MOD);
                                else
                                    tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                            }
                            else
                            {
                                if (tmpIP < 2)
                                {
                                    if (tmpIP > tmpIT)
                                        tmpPrior += MOVE_BACK_PRIOR_MOD;
                                    else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                        tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/4 : MOVE_STRAFE_PRIOR_MOD);
                                    else
                                        tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                                }
                                else
                                {
                                    if (tmpIP > 3)
                                    {
                                        if (tmpIP < tmpIT)
                                            tmpPrior += MOVE_BACK_PRIOR_MOD/2;
                                        else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                            tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/8 : MOVE_STRAFE_PRIOR_MOD/4);
                                        else
                                            tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                                    }
                                    else
                                    {
                                        if (tmpIP < 4)
                                        {
                                            if (tmpIP < tmpIT)
                                                tmpPrior += MOVE_BACK_PRIOR_MOD/3;
                                            else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                                tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/8 : MOVE_STRAFE_PRIOR_MOD/4);
                                            else
                                                tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                return tmpPrior;
            }

            void ChoosePieceToMove()
            {
            #ifdef CHESS_EVENT_DISSABLE_MEDIVH_PIECES_MOVEMENT
                return;
            #endif

            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a ChoosePieceToMove()");
            #endif

                std::list<Priority> possibleMoveList;
                int possibleMovePrioritySum = 0;

                // for each medivh piece
                for (std::list<uint64>::const_iterator pieceItr = medivhSidePieces.begin(); pieceItr != medivhSidePieces.end(); ++pieceItr)
                {
                    if (IsInMoveList(*pieceItr))
                        continue;

                    std::list<Priority> tmpPriorList;
                    int priorSum = 0, i, tmpOffsetI, tmpOffsetJ, tmpI, tmpJ;
                    // calculate actual square prior
                    int actualPriority = CalculatePriority(*pieceItr, FindTriggerGUID(*pieceItr));

                    if (!FindPlaceInBoard(*pieceItr, tmpI, tmpJ))
                        continue;

                    // for each sqare in range
                    switch (GetMoveRange(*pieceItr))
                    {
                        case 25:
                            for (i = 0; i < OFFSET25COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab25[i][0];
                                tmpOffsetJ = tmpJ + offsetTab25[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                                    chessBoard[tmpOffsetI][tmpOffsetJ].piece == 0 &&                // if square is empty
                                    !IsInMoveList(chessBoard[tmpOffsetI][tmpOffsetJ].trigger, true))// and isn't in move list
                                {
                                    Priority prior;
                                    prior.GUIDfrom = *pieceItr;
                                    prior.GUIDto = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                                    // calculate priority
                                    prior.prior = CalculatePriority(prior.GUIDfrom, prior.GUIDto);

                                    // if priority is > 0
                                    if (prior.prior > 0)
                                    {
                                        tmpPriorList.push_back(prior);  // add square info (priority) to list
                                        priorSum += prior.prior;        // sum priority
                                    }
                                }
                            }
                        case 20:
                            for (i = 0; i < OFFSET20COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab20[i][0];
                                tmpOffsetJ = tmpJ + offsetTab20[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                                    chessBoard[tmpOffsetI][tmpOffsetJ].piece == 0 &&                // if square is empty
                                    !IsInMoveList(chessBoard[tmpOffsetI][tmpOffsetJ].trigger, true))// and isn't in move list
                                {
                                    Priority prior;
                                    prior.GUIDfrom = *pieceItr;
                                    prior.GUIDto = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                                    // calculate priority
                                    prior.prior = CalculatePriority(prior.GUIDfrom, prior.GUIDto);

                                    // if priority is > 0
                                    if (prior.prior > 0)
                                    {
                                        tmpPriorList.push_back(prior);  // add square info (priority) to list
                                        priorSum += prior.prior;        // sum priority
                                    }
                                }

                            }
                        case 15:
                            for (i = 0; i < OFFSET15COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab15[i][0];
                                tmpOffsetJ = tmpJ + offsetTab15[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                                    chessBoard[tmpOffsetI][tmpOffsetJ].piece == 0 &&                // if square is empty
                                    !IsInMoveList(chessBoard[tmpOffsetI][tmpOffsetJ].trigger, true))// and isn't in move list
                                {
                                    Priority prior;
                                    prior.GUIDfrom = *pieceItr;
                                    prior.GUIDto = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                                    // calculate priority
                                    prior.prior = CalculatePriority(prior.GUIDfrom, prior.GUIDto);

                                    // if priority is > 0
                                    if (prior.prior > 0)
                                    {
                                        tmpPriorList.push_back(prior);  // add square info (priority) to list
                                        priorSum += prior.prior;        // sum priority
                                    }
                                }

                            }
                        case 8:
                            for (i = 0; i < OFFSET8COUNT; i++)
                            {
                                tmpOffsetI = tmpI + offsetTab8[i][0];
                                tmpOffsetJ = tmpJ + offsetTab8[i][1];

                                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                                    tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                                    chessBoard[tmpOffsetI][tmpOffsetJ].piece == 0 &&                // if square is empty
                                    !IsInMoveList(chessBoard[tmpOffsetI][tmpOffsetJ].trigger, true))// and isn't in move list
                                {
                                    Priority prior;
                                    prior.GUIDfrom = *pieceItr;
                                    prior.GUIDto = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                                    // calculate priority
                                    prior.prior = CalculatePriority(prior.GUIDfrom, prior.GUIDto);

                                    // if priority is > 0
                                    if (prior.prior > 0)
                                    {
                                        tmpPriorList.push_back(prior);  // add square info (priority) to list
                                        priorSum += prior.prior;        // sum priority
                                    }
                                }

                            }
                            break;
                        default:
                            me->MonsterSay("Jakis dziwaczny range", LANG_UNIVERSAL, 0);
                            break;
                    }

                    // if square info list in not empty
                    if (tmpPriorList.empty() || priorSum <= 0)
                        continue;

                    switch (rand()%2)
                    {
                        case 0:
                        {
                            // choose random priority from 0 to priority sum
                            int chosenPrior = urand(0, priorSum);
                            int tmpPriorSum = 0;
                            // search for randomed square
                            for (std::list<Priority>::iterator priorItr = tmpPriorList.begin(); priorItr != tmpPriorList.end(); ++ priorItr)
                            {
                                if (chosenPrior >= tmpPriorSum && chosenPrior < tmpPriorSum + (*priorItr).prior)
                                {
                                    // rand if chosen position is better than actual position
                                    if (urand(0, actualPriority + (*priorItr).prior) > actualPriority)
                                    {
                                        possibleMoveList.push_back(*priorItr);          // add possible move to list
                                        possibleMovePrioritySum += (*priorItr).prior;   // sum square move priorities
                                    }
            #ifdef CHESS_DEBUG_INFO
                                    else
                                    {
                                        if (Creature * tmpC = me->GetCreature(*me, *pieceItr))
                                            tmpC->MonsterSay("hmm ... La piece doit resté ou elle est (?) ...", LANG_UNIVERSAL, NULL);
                                        printf("\nPiece: %u, prior: %i, actual: %i | STAY IN HOME", *pieceItr, (*priorItr).prior, actualPriority);
                                    }
            #endif

                                    break;
                                }

                                tmpPriorSum += (*priorItr).prior;
                            }
                            break;
                        }
                        case 1:
                        {
                            std::list<Priority> bestList;
                            if (tmpPriorList.empty())
                                continue;

                            Priority best = tmpPriorList.front();
                            for (std::list<Priority>::iterator itr = tmpPriorList.begin(); itr != tmpPriorList.end(); ++itr)
                            {
                                if (best.prior < (*itr).prior)
                                {
                                    best = *itr;
                                    bestList.clear();
                                    bestList.push_back(*itr);
                                }
                                else if (best.prior == (*itr).prior)
                                {
                                    bestList.push_back(*itr);
                                }
                            }

                            if (bestList.empty())
                                continue;

                            std::list<Priority>::iterator itr = bestList.begin();
                            advance(itr, urand(0, bestList.size()-1));

                            possibleMoveList.push_back(*itr);          // add possible move to list
                            possibleMovePrioritySum += (*itr).prior;   // sum square move priorities
                            break;
                        }
                    }
                }

                if (possibleMoveList.empty())
                    return;

                Priority chosen;
            #ifdef CHESS_DEBUG_INFO
                int method;
            #endif
                if (rand()%2)
                {
            #ifdef CHESS_DEBUG_INFO
                    method = 1;
            #endif
                    // choose random move from list
                    int tmpChosenPrior = urand(0, possibleMovePrioritySum);
                    int tmpPriorSum = 0;
                    for (std::list<Priority>::iterator itr = possibleMoveList.begin(); itr != possibleMoveList.end(); ++itr)
                    {
                        if (tmpChosenPrior >= tmpPriorSum && tmpChosenPrior < tmpPriorSum + (*itr).prior)
                        {
                            chosen = *itr;
                            break;
                        }

                        tmpPriorSum += (*itr).prior;
                    }
                }
                else
                {
                    #ifdef CHESS_DEBUG_INFO
                    method = 2;
                    #endif
                    // choose best move from list
                    Priority best = possibleMoveList.front();
                    for (std::list<Priority>::iterator itr = possibleMoveList.begin(); itr != possibleMoveList.end(); ++itr)
                        if (best.prior < (*itr).prior)
                            best = *itr;

                    chosen = best;
                }

                if (!chosen.GUIDfrom || !chosen.GUIDto)
                    return;

                // make move to chosen
                Creature * tmpC = me->GetCreature(*me, chosen.GUIDfrom);
                Creature * tmpT = me->GetCreature(*me, chosen.GUIDto);

                if (tmpC && tmpT)
                    tmpC->CastSpell(tmpT, GetMoveSpell(tmpC), false);
                else
                {
            #ifdef CHESS_DEBUG_INFO
                    printf("\nchosen.GUIDfrom: %u, %i | chosen.GUIDto: %u, %i | method: %i | isMedivhPiece: %i", chosen.GUIDfrom, tmpC ? 1 : 0, chosen.GUIDto, tmpT ? 1 : 0, method, IsMedivhsPiece(chosen.GUIDfrom));
            #endif
                    me->MonsterSay("Un trigger est introuvable! Une erreur de target a du se produire!", LANG_UNIVERSAL, 0);
                }
            }

            uint32 GetEntry(uint64 piece)
            {
                Creature * tmp = me->GetCreature(*me, piece);
                if (!tmp)
                    return 0;

                return tmp->GetEntry();
            }

            uint32 GetDeadEntryForPiece(Creature * piece)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a GetDeadEntryForPiece(Creature * piece = %i)", piece);
            #endif
                if (!piece)
                    return 0;

                return GetDeadEntryForPiece(piece->GetEntry());
            }

            uint32 GetDeadEntryForPiece(uint32 entry)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a GetDeadEntryForPiece(uint32 entry = %u)", entry);
            #endif

                switch (entry)
                {
                    case NPC_PAWN_H:
                        return 16556;
                    case NPC_PAWN_A:
                        return 16567;
                    case NPC_KNIGHT_H:
                        return 16561;
                    case NPC_KNIGHT_A:
                        return 16569;
                    case NPC_QUEEN_H:
                        return 16557;
                    case NPC_QUEEN_A:
                        return 16572;
                    case NPC_BISHOP_H:
                        return 16560;
                    case NPC_BISHOP_A:
                        return 16571;
                    case NPC_ROOK_H:
                        return 16562;
                    case NPC_ROOK_A:
                        return 16570;
                    case NPC_KING_H:
                        return 16563;
                    case NPC_KING_A:
                        return 16581;
                    default:
                        return 0;
                }

                return 0;
            }

            void CheckChangeFacing(uint64 piece, int i = -1, int j = -1)
            {
            #ifdef CHESS_DEBUG_INFO
                printf("\n Appel a npc_echo_of_medivh.npc_echo_of_medivhAI::CheckChangeFacing(uint64 piece = %u, int i = %i, int j = %i)", piece, i, j);
            #endif
                if (i == -1 || j == -1)
                    if (!FindPlaceInBoard(piece, i, j))
                        return;

                if (IsInMoveList(piece))
                    return;

                ChessOrientation actualOri = chessBoard[i][j].ori;
                ChessOrientation tmpOri;
                ChessOrientation targetOri = CHESS_ORI_CHOOSE;
                uint64 target = 0, tmpTarget = 0, targetTrigger = 0;
                int targetPrior = 0, tmpPrior = 0;

                for (int k = 0; k < OFFSETMELEECOUNT; ++k)
                {
                    int tmpOffsetI = offsetTabMelee[k][0];
                    int tmpOffsetJ = offsetTabMelee[k][1];

                    if (tmpOffsetI == 0)
                    {
                        if (tmpOffsetJ == 1)
                            tmpOri = CHESS_ORI_E;
                        else
                            tmpOri = CHESS_ORI_W;
                    }
                    else if (tmpOffsetJ == 0)
                    {
                        if (tmpOffsetI == 1)
                            tmpOri = CHESS_ORI_S;
                        else
                            tmpOri = CHESS_ORI_N;
                    }

                    tmpOffsetI += i;
                    tmpOffsetJ += j;

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpTarget = chessBoard[tmpOffsetI][tmpOffsetJ].piece;
                        if (Enemy(piece, tmpTarget))
                        {
                            tmpPrior = GetAttackPriority(tmpTarget);

                            if (tmpPrior > targetPrior)
                            {
                                target = tmpTarget;
                                targetOri = tmpOri;
                                targetPrior = tmpPrior;
                                targetTrigger = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                            }
                        }
                    }
                }

                if (targetOri != CHESS_ORI_CHOOSE)
                {
                    if (targetOri != actualOri)
                    {
                        Creature * tmpC = me->GetCreature(*me, piece);
                        Creature * tmpT = me->GetCreature(*me, targetTrigger);
                        if (tmpC && tmpT)
                            tmpC->CastSpell(tmpT, SPELL_CHANGE_FACING, false);
                        #ifdef CHESS_DEBUG_INFO
                        else
                            printf("\nChangeFacing: nima tmpC (%i | guid: %u) lub tmpT (%i | guid: %u), prior: %i", tmpC ? 1 : 0, piece, tmpT ? 1 : 0, targetTrigger, targetPrior);
                        #endif
                    }
                }
            }

        };

    struct chess_move_triggerAI : public ScriptedAI
      {
        chess_move_triggerAI(Creature* c) : ScriptedAI(c), _instance(c->GetInstanceScript())
        {
			pInstance = ((InstanceScript*)me->GetInstanceScript());
			me->GetPosition(&wLoc);
        }
     
        InstanceScript* _instance;
        uint32 search_time;
        Unit *unit_on_me;
		InstanceScript* pInstance;

		WorldLocation wLoc;

		uint64 MedivhGUID;

		int32 moveTimer;
		uint64 unitToMove;
		ChessPiecesStances pieceStance;
     
        void Reset()
        {
			moveTimer   = 3000;
			pieceStance = PIECE_NONE;
			unitToMove = 0;
			MedivhGUID = pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH);
        }
     
        void Aggro(Unit *){}
     
		void UpdateAI(const uint32 diff)
        {
			me->MonsterSay("actualisation",0,0);
          if (pInstance->GetData(DATA_CHESS_EVENT) != IN_PROGRESS)
				return;
      
			if (pieceStance)
			{
				if (moveTimer < diff)
					MakeMove();
				else
					moveTimer -= diff;
			}
        }
     
        void SpellHit(Unit *caster,const SpellInfo *spell)
        {
            me->MonsterSay("touché",0,0);
			if (!MedivhGUID)
				MedivhGUID = pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH);

			if (pieceStance != PIECE_NONE || !MedivhGUID)
				return;

			switch (spell->Id)
			{
				case SPELL_MOVE_1:
				case SPELL_MOVE_2:
				case SPELL_MOVE_3:
				case SPELL_MOVE_4:
				case SPELL_MOVE_5:
				case SPELL_MOVE_6:
				case SPELL_MOVE_7:
				case SPELL_CHANGE_FACING:
				{
                    me->GetCreature(*me, MedivhGUID)->MonsterSay("touché par un sort de déplacement", LANG_UNIVERSAL,NULL);
                    npc_echo_of_medivhAI* medivh = (npc_echo_of_medivhAI*)(me->GetCreature((*me), MedivhGUID)->AI());
					if (medivh)
					{
						if (spell->Id == SPELL_CHANGE_FACING || medivh->CanMoveTo(me->GetGUID(), caster->GetGUID()))
						{
							medivh->AddTriggerToMove(me->GetGUID(), caster->GetGUID(), caster->GetCharmerOrOwnerPlayerOrPlayerItself() ? true : false);

							me->CastSpell(me, SPELL_MOVE_PREVISUAL, false);

							unitToMove = caster->GetGUID();

							if (spell->Id == SPELL_CHANGE_FACING)
								pieceStance = PIECE_CHANGE_FACING;
							else
								pieceStance = PIECE_MOVE;
						}
						else
							me->MonsterSay("Vous ne pouvez pas aller ici", LANG_UNIVERSAL, caster->GetGUID());
					}
					else
						me->MonsterSay("Medivh introuvable, vous ne pouvez bouger!", LANG_UNIVERSAL, 0);

					break;
				}
				default:
					break;
			}
		}

		void MakeMove()
		{
			ChessPiecesStances tmpStance = pieceStance;

			moveTimer = 3000;
			pieceStance = PIECE_NONE;
			Creature * temp = me->GetCreature((*me), unitToMove);
			Creature * temp2 = me->GetCreature((*me), MedivhGUID);

			if (!temp || !temp->isAlive())
			{
				unitToMove = 0;
				return;
			}

			switch (tmpStance)
			{
				case PIECE_MOVE:
					me->CastSpell(me, SPELL_MOVE_MARKER, false);
					temp->GetMotionMaster()->MovePoint(0, wLoc.m_positionX, wLoc.m_positionY, wLoc.m_positionZ);

					if (temp2)
					{
						((npc_echo_of_medivhAI*)temp2->AI())->ChangePlaceInBoard(unitToMove, me->GetGUID());
						((npc_echo_of_medivhAI*)temp2->AI())->RemoveFromMoveList(me->GetGUID());
					}
					break;
				case PIECE_CHANGE_FACING:
					if (temp2)
					{
						((npc_echo_of_medivhAI*)temp2->AI())->ChangePieceFacing(temp, me);
						((npc_echo_of_medivhAI*)temp2->AI())->RemoveFromMoveList(me->GetGUID());
					}
					break;
				default:
					break;
			}

			unitToMove = 0;
		}

			void RemoveFromMove(uint64 piece)
			{
				if (unitToMove == piece)
				{
					pieceStance = PIECE_NONE;
					unitToMove = 0;
					moveTimer = 3000;
				}
			}



      };
  

#endif
