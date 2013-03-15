/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */


/* ScriptData
SDName: telenpc
SD%Complete: 100
SDComment: Show a codebox in gossip option
SDCategory: Script Examples
EndScriptData */

#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include <cstring>
#include "Config.h"
#include "GameEventMgr.h"

#ifdef WIN32
#pragma warning(disable:4700) // uninitialized local variable
#pragma warning(disable:4101) // unreferenced local variable
#endif

enum eEnums
  {
    DALARAN					= -1888888,
    SHATTRAH				= -1888887,
    ORGRIMMAR				= -1888886,
    LUNEARGENT				= -1888885,
    FORGEFER				= -1888884,
    LESPITONSDUTONNERRE		= -1888883,
    HURLEVENT				= -1888882,
    DARNASSUS				= -1888881,
    EXODAR					= -1888880,
    FOSSOYEUSE				= -1888879
  };

/*
Coord defines go as follow
map id
X
Y
Z
Orientation
*/

//Horde Mall Coord Defines
#define HMMD    1
#define HMXD    -8679.3330
#define HMYD    1971.2595
#define HMZD    109.1228
#define HMOD    5.0984

//Ally Mall Coord Defines
#define AMMD    1
#define AMXD    -8667.9931
#define AMYD    1941.1539
#define AMZD    109.1230
#define AMOD    1.9490

//Horde PvP Port
#define HPMD    0
#define HPXD    -13277.4
#define HPYD    127.372
#define HPZD    26.1418
#define HPOD    1.11878

//Ally PvP Port
#define APMD    0
#define APXD    -13277.4
#define APYD    127.372
#define APZD    26.1418
#define APOD    1.11878
#define REQ_LEVEL       80


class telenpc : public GameObjectScript
{
public:
  telenpc() : GameObjectScript("telenpc") { }


bool OnGossipHello(Player* Plr, GameObject* pCrea)
{
  // Main Menu for Alliance
  if (Plr->GetTeam() == ALLIANCE)
    Plr->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Villes de l'Alliance ->", GOSSIP_SENDER_MAIN, 1000);
  else // Main Menu for Horde
    Plr->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Villes de la Horde ->", GOSSIP_SENDER_MAIN, 2000);
  Plr->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Villes neutres ->", GOSSIP_SENDER_MAIN, 3000);
  Plr->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Donjons ->", GOSSIP_SENDER_MAIN, 5000);
  if (IsEventActive(42))
    Plr->ADD_GOSSIP_ITEM( 5, "event 5 ans de paragon !", GOSSIP_SENDER_MAIN, 3501);

  Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
  return true;
}

void OnSendDefaultMenu(Player* Plr, GameObject* pCrea, uint32 action)
{
  // Not allow in combat
  if (Plr->isInCombat())
    {
      Plr->CLOSE_GOSSIP_MENU();
      pCrea->MonsterSay("Vous etes en combat !", LANG_UNIVERSAL, NULL);
      return;
    }
  switch(action)
    {
    case 1000: //Alliance Town
      Plr->PlayerTalkClass->ClearMenus();
      Plr->ADD_GOSSIP_ITEM( 5, "Darnassus", GOSSIP_SENDER_MAIN, 1001);
      Plr->ADD_GOSSIP_ITEM( 5, "Exodar", GOSSIP_SENDER_MAIN, 1005);
      Plr->ADD_GOSSIP_ITEM( 5, "Forgefer", GOSSIP_SENDER_MAIN, 1010);
      Plr->ADD_GOSSIP_ITEM( 5, "Hurlevent", GOSSIP_SENDER_MAIN, 1015);
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 2000: //Horde Town
      Plr->PlayerTalkClass->ClearMenus();
      Plr->ADD_GOSSIP_ITEM( 5, "Orgrimmar", GOSSIP_SENDER_MAIN, 2001);
      Plr->ADD_GOSSIP_ITEM( 5, "Lune d'Argent", GOSSIP_SENDER_MAIN, 2005);
      Plr->ADD_GOSSIP_ITEM( 5, "Les Pitons du Tonnerre", GOSSIP_SENDER_MAIN, 2010);
      Plr->ADD_GOSSIP_ITEM( 5, "Fossoyeuse", GOSSIP_SENDER_MAIN, 2015);
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 3000: //Neutral Town
      Plr->PlayerTalkClass->ClearMenus();
      if(Plr->getClass()==6)
	Plr->ADD_GOSSIP_ITEM( 5, "Fort d'Ebene", GOSSIP_SENDER_MAIN, 3001);
      Plr->ADD_GOSSIP_ITEM( 5, "Baie du butin", GOSSIP_SENDER_MAIN, 3005);
      if (Plr->getLevel() >= 74)
	Plr->ADD_GOSSIP_ITEM( 5, "Dalaran", GOSSIP_SENDER_MAIN, 3010);
      if (Plr->getLevel() >= 58)
	Plr->ADD_GOSSIP_ITEM( 5, "Shattrath", GOSSIP_SENDER_MAIN, 3035);
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 5000: //Dungeons
      Plr->PlayerTalkClass->ClearMenus();
      Plr->ADD_GOSSIP_ITEM( 7, "Kalimdor ->", GOSSIP_SENDER_MAIN, 5010);
      Plr->ADD_GOSSIP_ITEM( 7, "Royaume de l'Est ->", GOSSIP_SENDER_MAIN, 5015);
      if (Plr->getLevel() >= 58)
	Plr->ADD_GOSSIP_ITEM( 7, "Outreterre ->", GOSSIP_SENDER_MAIN, 5025);
      if (Plr->getLevel() >= 68)
	Plr->ADD_GOSSIP_ITEM( 7, "Northrend ->", GOSSIP_SENDER_MAIN, 5030);
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 5005: //Back To Main Menu
      Plr->PlayerTalkClass->ClearMenus();
      if (Plr->GetTeam() == ALLIANCE)
	{
	  Plr->ADD_GOSSIP_ITEM( 7, "Villes de l'Alliance ->", GOSSIP_SENDER_MAIN, 1000);
	  Plr->ADD_GOSSIP_ITEM( 7, "Villes neutres ->", GOSSIP_SENDER_MAIN, 3000);
	  Plr->ADD_GOSSIP_ITEM( 7, "Donjons ->", GOSSIP_SENDER_MAIN, 5000);
	}
      else // Main Menu for Horde
	{
	  Plr->ADD_GOSSIP_ITEM( 7, "Villes de la Horde ->", GOSSIP_SENDER_MAIN, 2000);
	  Plr->ADD_GOSSIP_ITEM( 7, "Villes neutres->", GOSSIP_SENDER_MAIN, 3000);
	  Plr->ADD_GOSSIP_ITEM( 7, "Donjons ->", GOSSIP_SENDER_MAIN, 5000);
	}
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 5010: //Kalimdor
      Plr->PlayerTalkClass->ClearMenus();
      Plr->ADD_GOSSIP_ITEM( 5, "Les Cavernes du Temps", GOSSIP_SENDER_MAIN, 6005);
      if (Plr->getLevel() >= 70)
	Plr->ADD_GOSSIP_ITEM( 5, "Le Repaire d'Onyxia", GOSSIP_SENDER_MAIN, 6020);
      Plr->ADD_GOSSIP_ITEM( 5, "Le Temple d'Ahn'Qiraj", GOSSIP_SENDER_MAIN, 6045);
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 5015: //Eastern Kingdoms 1
      Plr->PlayerTalkClass->ClearMenus();
      if (Plr->getLevel() >= 70)
	Plr->ADD_GOSSIP_ITEM( 5, "Ile de Quel'Danas", GOSSIP_SENDER_MAIN, 7025);
      Plr->ADD_GOSSIP_ITEM( 5, "Karazhan", GOSSIP_SENDER_MAIN, 7030);
      Plr->ADD_GOSSIP_ITEM( 5, "Zul'Aman", GOSSIP_SENDER_MAIN, 7075);
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 5020: //Eastern Kingdoms 2
      Plr->PlayerTalkClass->ClearMenus();
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 5025: //Outland
      Plr->PlayerTalkClass->ClearMenus();
      Plr->ADD_GOSSIP_ITEM( 5, "Temple noir", GOSSIP_SENDER_MAIN, 8005);
      Plr->ADD_GOSSIP_ITEM( 5, "Caverne du sanctuaire du Serpent", GOSSIP_SENDER_MAIN, 8010);
      Plr->ADD_GOSSIP_ITEM( 5, "Le Repaire de Gruul", GOSSIP_SENDER_MAIN, 8015);
      Plr->ADD_GOSSIP_ITEM( 5, "Donjon de la Tempete", GOSSIP_SENDER_MAIN, 8025);
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 5030: //Northrend 
      Plr->PlayerTalkClass->ClearMenus();
      if (Plr->getLevel() >= 70)
	{
	  Plr->ADD_GOSSIP_ITEM( 5, "Ulduar", GOSSIP_SENDER_MAIN, 9050);
	  Plr->ADD_GOSSIP_ITEM( 5, "Tournoi d'argent", GOSSIP_SENDER_MAIN, 9060);
	}
      if (Plr->getLevel() >= 80)
	{
	  Plr->ADD_GOSSIP_ITEM( 5, "Citadelle de la Couronne de Glace", GOSSIP_SENDER_MAIN, 9020);
	  Plr->ADD_GOSSIP_ITEM( 5, "Naxxramas", GOSSIP_SENDER_MAIN, 9025);
	  Plr->ADD_GOSSIP_ITEM( 5, "Sanctum", GOSSIP_SENDER_MAIN, 9035);
	}
      Plr->SEND_GOSSIP_MENU(Plr->GetGossipTextId(pCrea), pCrea->GetGUID());
      break;
    case 1001: // Darnassus
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, 9947.52f, 2482.73f, 1316.21f, 0.0f);
      break;
    case 1005: // Exodar
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, -3954.20f, -11656.54f, -138.69f, 0.0f);
      break;
    case 1010: // Ironforge
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -4924.07f, -951.95f, 501.55f, 5.40f);
      break;
    case 1015: // Stormwind
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -8960.14f, 516.266f, 96.3568f, 0.0f);
      break;
    case 2001: // Orgrimmar
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, 1552.5f, -4420.66f, 8.94802f, 0.0f);
      break;
    case 2005: // Silvermoon
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, 9338.74f, -7277.27f, 13.7895f, 0.0f);
      break;
    case 2010: // Thunder Bluff
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -1290.0f, 147.033997f, 129.682007f, 4.919000f);
      break;
    case 2015: // Undercity
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, 1819.71f, 238.79f, 60.5321f, 0.0f);
      break;
      //////////////////////////////////////////////////NEUTRAL///////////////////////////////////////////////////////////////
    case 3001:// Ebon Hold
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, 2353.530029f, -5665.819824f, 426.028015f, 0.596f);
      break;
    case 3005:// Booty Bay
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -14438.2f, 472.22f, 15.32f, 0.65f);
      break;
    case 3010: //Dalaran
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 5819.08f, 643.99f, 647.80f, 3.32f);
      break;
    case 3015: //Everlook
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, 6724.77f, -4610.68f, 720.78f, 4.78f);
      break;
    case 3020: //Gadgetzan
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -7173.26f, -3785.60f, 8.37f, 6.13f);
      break;
    case 3025: //Mudsprocket
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -4564.79f, -3172.38f, 33.93f, 3.21f);
      break;
    case 3030: //Ratchet
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -956.664f, -3754.71f, 5.33239f, 0.996637f);
      break;
    case 3035:// Shattrath City
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, -1850.209961f, 5435.821777f, -10.961435f, 3.403913f);
      break;
    case 3040:// Isle Of Quel'Danas
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, 12947.4f,-6893.31f,5.68398f,3.09154f);
      break;
      //////////////////////////////////////////////////KALIMDOR///////////////////////////////////////////////////////////////
    case 6001:// Blackfathom Deeps
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, 4248.72f, 744.35f, -24.67f, 1.34f);
      break;
    case 6005:// Caverns of Time
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -8173.66f, -4746.36f, 33.84f, 4.94f);
      break;
    case 6010:// Dire Maul
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -3960.95f, 1130.64f, 161.05f, 0.0f);
      break;
    case 6015:// Maraudon
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -1431.33f, 2962.34f, 98.23f, 4.74f);
      break;
    case 6020:// Onyxia's Lair
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -4707.44f, -3726.82f, 54.6723f, 3.8f);
      break;
    case 6025:// Ragefire Chasm
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, 1814.47f, -4419.46f, -18.78f, 5.28f);
      break;
    case 6030:// Razorfen Downs
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -4657.88f, -2525.59f, 81.4f, 4.16f);
      break;
    case 6035:// Razorfen Kraul
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -4463.6f, -1664.53f, 82.26f, 0.85f);
      break;
    case 6040:// Ruins of Ahn'Qiraj
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -8413.33f, 1501.27f, 29.64f, 2.61f);
      break;
    case 6045:// Temple of Ahn'Qiraj
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -8245.837891f, 1983.736206f, 129.071686f, 0.936195f);
      break;
    case 6050:// Wailing Caverns
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -722.53f,-2226.30f,16.94f,2.71f);
      break;
    case 6055:// Zul'Farrak
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -6801.9f, -2890.22f, 8.88f, 6.25f);
      break;
      //////////////////////////////////////////////////EASTERN KINGDOMS///////////////////////////////////////////////////////////////
    case 7001:// Blackrock Depths
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -7180.57f, -920.04f, 165.49f, 5.02f);
      break;
    case 7005:// Blackrock Spire
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -7526.77f, -1225.64f, 285.73f, 5.31f);
      break;
    case 7010:// Blackwing Lair
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(469, -7672.61f, -1107.21f, 396.65f, 3.75f);
      break;
    case 7015:// Deadmines
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -11208.2f, 1675.92f, 24.57f, 1.48f);
      break;
    case 7020:// Gnomeregan
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -5163.32f, 927.18f, 257.158f, 1.44f);
      break;
    case 7025:// Isle Of Quel'Danas
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, 13010.00f, -6907.64f, 9.58f, 4.58f);
      break;
    case 7030:// Karazhan
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -11119.6f, -2011.42f, 47.09f, 0.65f);
      break;
    case 7035:// Molten Core
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(230, 1114.85f, -457.76f, -102.81f, 3.83f);
      break;
    case 7040:// Scarlet Monastery
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, 2843.89f,-693.74f,139.32f,5.11f);
      break;
    case 7045:// Scholomance
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, 1273.06f, -2574.01f, 92.66f, 2.06f);
      break;
    case 7050:// Shadowfang Keep
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -239.54f, 1550.8f, 76.89f, 1.18f);
      break;
    case 7055:// Stratholme
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, 3370.76f, -3343.63f, 142.26f, 5.23f);
      break;
    case 7060:// Sunken Temple
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -10346.92f, -3851.90f, -43.41f, 6.09f);
      break;
    case 7065:// The Stockade
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -8766.89f, 844.6f, 88.43f, 0.69f);
      break;
    case 7070:// Uldaman
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -6070.72f, -2955.33f, 209.78f, 0.05f);
      break;
    case 7075:// Zul'Aman
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, 6851.09f, -7979.71f, 183.54f, 4.72f);
      break;
    case 7080:// Zul'Gurub
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -11916.4f, -1216.23f, 92.28f, 4.75f);
      break;
      //////////////////////////////////////////////////OUTLAND///////////////////////////////////////////////////////////////
    case 8001:// Auchindoun
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, -3322.92f, 4931.02f, -100.56f, 1.86f);
      break;
    case 8005:// Black Temple
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, -3649.1f, 317.33f, 35.19f, 2.97f);
      break;
    case 8010:// Coilfang Reservoir
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, 721.08f, 6846.77f, -68.75f, 0.34f);
      break;
    case 8015:// Gruul's Lair
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, 3539.01f, 5082.36f, 1.69f, 0.0f);
      break;
    case 8020:// Hellfire Citadel
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, -292.71f, 3146.77f, 31.60f, 2.05f);
      break;
    case 8025:// Tempest Keep
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(530, 3087.62f, 1376.27f, 184.8f, 4.63f);
      break;
      //////////////////////////////////////////////////NORTHREND///////////////////////////////////////////////////////////////
    case 9001:// Ahn'Kahet
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 3646.76f, 2045.17f, 1.79f, 4.37f);
      break;
    case 9005:// Azjol-Nerub
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 3675.43f, 2169.00f, 35.90f, 2.29f);
      break;
    case 9010:// Drak'Tharon Keep
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 4450.86f, -2045.25f, 162.83f, 0.00f);
      break;
    case 9015:// Gun'Drak
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 6937.54f, -4455.98f, 450.68f, 1.00f);
      break;
    case 9020:// Icecrown Citadel
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 6139.24f, 2233.72f, 510.79f, 3.56f);
      //      Plr->SendMovieStart(14);
      break;
    case 9025:// Naxxramas
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 3668.72f, -1262.46f, 243.622f, 4.785f);
      break;
    case 9030:// The Nexus
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 3789.95f, 6961.48f, 104.23f, 0.28f);
      break;
    case 9035:// The Obsidian Sanctum
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 3625.78f, 280.4f, -120.14f, 3.25f);
      break;
    case 9040:// Ulduar
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 1219.72f, -4865.28f, 41.25f, 0.31f);
      break;
    case 9045:// Utgarde Keep
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 1245.69f, -4856.59f, 216.86f, 3.45f);
      break;
    case 9050:// Utgarde Pinnacle
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 8976.24f, -1281.33f, 1059.01f, 0.58f);
      break;
    case 9055:// Violet Hold
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 5679.82f, 486.80f, 652.40f, 4.08f);
      break;
    case 9060:// Tournoi d'argent
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 8477.13f, 696.37f, 548.40f, 4.38f);
      break;
    case 9065:// Acrhavon
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(571, 5407.91f, 2842.86f, 418.67f, 6.22f);
      break;
      // PLAYER TOOLS
    case 3500: // Arena PvP Option
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      if (Plr->GetTeam() == ALLIANCE) // Gurubashi for Alliance
        Plr->TeleportTo(APMD, APXD, APYD, APZD, APOD);
      else // Gurubashi for Horde
        Plr->TeleportTo(HPMD, HPXD, HPYD, HPZD, HPOD);
      break;
    case 3501: // Arena PvP Option
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, 7331.89f, -1532.03f, 160.0f, 0.65f);
      /*      if (Plr->GetTeam() == ALLIANCE) // Gurubashi for Alliance
        Plr->TeleportTo(1, -3818.0f, 1094.0f, 133.0f, 6.22f);
      else // Gurubashi for Horde
      Plr->TeleportTo(1, -3690.0f, 1084.0f, 133.0f, 3.112f);*/
      break;
    case 5200: //Mall
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(0, -12027.61f, -1704.04f , 40.31f, 0.51f); // Alliance
      break;
    case 8500: //Mall
      Plr->PlayerTalkClass->ClearMenus();
      Plr->CLOSE_GOSSIP_MENU();
      Plr->TeleportTo(1, -727.10f, -1068.32f, 179.45f, 5.17f); // Alliance
      break;
    }
}

bool OnGossipSelect(Player* Plr, GameObject* pCrea, uint32 sender, uint32 action)
{
  // Main menu
  if (sender == GOSSIP_SENDER_MAIN)
    OnSendDefaultMenu(Plr, pCrea, action);
  return true;
}
};

void AddSC_telenpc()
{
  new telenpc();
}
