/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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
#include "ArenaTeamMgr.h"
#include "math.h"

bool ChatHandler::HandleHelpCommand(const char* args)
{
    char* cmd = strtok((char*)args, " ");
    if (!cmd)
    {
        ShowHelpForCommand(getCommandTable(), "help");
        ShowHelpForCommand(getCommandTable(), "");
    }
    else
    {
        if (!ShowHelpForCommand(getCommandTable(), cmd))
            SendSysMessage(LANG_NO_HELP_CMD);
    }

    return true;
}

bool ChatHandler::HandleCommandsCommand(const char* /*args*/)
{
    ShowHelpForCommand(getCommandTable(), "");
    return true;
}

bool ChatHandler::HandleStartCommand(const char* /*args*/)
{
    // Jail mod start:
    if (m_session->GetPlayer()->m_jail_isjailed)
    {
        SendSysMessage(LANG_JAIL_DENIED);
        return true;
    }
    // Jail mod end.
    Player* chr = m_session->GetPlayer();

    if (chr->isInFlight())
    {
        SendSysMessage(LANG_YOU_IN_FLIGHT);
        SetSentErrorMessage(true);
        return false;
    }

    if (chr->isInCombat())
    {
        SendSysMessage(LANG_YOU_IN_COMBAT);
        SetSentErrorMessage(true);
        return false;
    }

    if ((chr->isDead()) || (chr->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST)))
    {
    // if player is dead and stuck, send ghost to graveyard
    chr->RepopAtGraveyard();
    return true;
    }

    // cast spell Stuck
    chr->CastSpell(chr, 8690, false);
    return true;
}

bool ChatHandler::HandleServerInfoCommand(const char* /*args*/)
{
    uint32 playersNum = sWorld->GetPlayerCount();
    uint32 maxPlayersNum = sWorld->GetMaxPlayerCount();
    uint32 activeClientsNum = sWorld->GetActiveSessionCount();
    uint32 queuedClientsNum = sWorld->GetQueuedSessionCount();
    uint32 maxActiveClientsNum = sWorld->GetMaxActiveSessionCount();
    uint32 maxQueuedClientsNum = sWorld->GetMaxQueuedSessionCount();
    std::string uptime = secsToTimeString(sWorld->GetUptime());
    uint32 updateTime = sWorld->GetUpdateTime();

    SendSysMessage(_FULLVERSION);
    PSendSysMessage(LANG_CONNECTED_PLAYERS, playersNum, maxPlayersNum);
    PSendSysMessage(LANG_CONNECTED_USERS, activeClientsNum, maxActiveClientsNum, queuedClientsNum, maxQueuedClientsNum);
    PSendSysMessage(LANG_UPTIME, uptime.c_str());
    PSendSysMessage(LANG_UPDATE_DIFF, updateTime);
    //! Can't use sWorld->ShutdownMsg here in case of console command
    if (sWorld->IsShuttingDown())
        PSendSysMessage(LANG_SHUTDOWN_TIMELEFT, secsToTimeString(sWorld->GetShutDownTimeLeft()).c_str());

    return true;
}

bool ChatHandler::HandleDismountCommand(const char* /*args*/)
{
    //If player is not mounted, so go out :)
    if (!m_session->GetPlayer()->IsMounted())
    {
        SendSysMessage(LANG_CHAR_NON_MOUNTED);
        SetSentErrorMessage(true);
        return false;
    }

    if (m_session->GetPlayer()->isInFlight())
    {
        SendSysMessage(LANG_YOU_IN_FLIGHT);
        SetSentErrorMessage(true);
        return false;
    }

    m_session->GetPlayer()->Dismount();
    m_session->GetPlayer()->RemoveAurasByType(SPELL_AURA_MOUNTED);
    return true;
}

bool ChatHandler::HandleSaveCommand(const char* /*args*/)
{
    Player* player = m_session->GetPlayer();

    // Jail by WarHead edited by LordPsyan
    if (player->m_jail_isjailed)
    {
        SendSysMessage(LANG_JAIL_DENIED);
        return true;
    }

    // save GM account without delay and output message
    if (!AccountMgr::IsPlayerAccount(m_session->GetSecurity()))
    {
        if (Player* target = getSelectedPlayer())
            target->SaveToDB();
        else
            player->SaveToDB();
        SendSysMessage(LANG_PLAYER_SAVED);
        return true;
    }

    // save if the player has last been saved over 20 seconds ago
    uint32 save_interval = sWorld->getIntConfig(CONFIG_INTERVAL_SAVE);
    if (save_interval == 0 || (save_interval > 20*IN_MILLISECONDS && player->GetSaveTimer() <= save_interval - 20*IN_MILLISECONDS))
        player->SaveToDB();

    return true;
}

/// Display the 'Message of the day' for the realm
bool ChatHandler::HandleServerMotdCommand(const char* /*args*/)
{
    PSendSysMessage(LANG_MOTD_CURRENT, sWorld->GetMotd());
    return true;
}

//Trinity Jail Edited by spgm ajustado por Eilo
bool ChatHandler::HandleJailInfoCommand(const char* args)
{
    time_t localtime;
    localtime = time(NULL);
    Player *chr = m_session->GetPlayer();

    if (chr->m_jail_release > 0)
    {
        uint32 min_left = (uint32)floor(float(chr->m_jail_release - localtime) / 60);

        if (min_left <= 0)
        {
            chr->m_jail_release = 0;
            chr->_SaveJail();
            SendSysMessage(LANG_JAIL_NOTJAILED_INFO);
            return true;
        }
        else
        {
            if (min_left >= 60) PSendSysMessage(LANG_JAIL_JAILED_H_INFO, (uint32)floor(float(chr->m_jail_release - localtime) / 60 / 60));
            else PSendSysMessage(LANG_JAIL_JAILED_M_INFO, min_left);
            PSendSysMessage(LANG_JAIL_REASON, chr->m_jail_gmchar.c_str(), chr->m_jail_reason.c_str());

            return true;
        }
    }
    else
    {
        SendSysMessage(LANG_JAIL_NOTJAILED_INFO);
        return true;
    }
    return false;
}

bool ChatHandler::HandleDiamondInfoCommand(const char* /*args*/)
{
  QueryResult result = StoreDatabase.PQuery( "SELECT diamond FROM diamond WHERE acctid = '%u'", m_session->GetAccountId());
  if (!result){
    StoreDatabase.PExecute("INSERT INTO diamond(acctid, diamond) VALUES('%d', '0')", m_session->GetAccountId());
    PSendSysMessage(LANG_DIAM_INFO, 0);
    return true;
  }

  Field *fields = result->Fetch();
  PSendSysMessage(LANG_DIAM_INFO, fields[0].GetInt32());

  return true;
}

bool ChatHandler::HandleDiamondLevelCommand(const char* /*args*/)
{
  Player *chr = m_session->GetPlayer();
  uint32 chrLvl = chr->getLevel();
  int32 diam = 0;

  QueryResult result = StoreDatabase.PQuery("SELECT diamond FROM diamond WHERE acctid='%d'", m_session->GetAccountId());
  if (!result)
    {
      StoreDatabase.PExecute("INSERT INTO diamond(acctid, diamond) VALUES('%d', '0')", m_session->GetAccountId());
      PSendSysMessage(LANG_DIAM_ZERO);
      return true;
    }
  Field *fields = result->Fetch();
  diam = fields[0].GetInt32();

  //Is the character has diamond ?
  if (diam == 0)
    {
      PSendSysMessage(LANG_DIAM_ZERO);
      return true;
    }

  result = StoreDatabase.Query("SELECT level FROM level ORDER BY level DESC");
  fields = result->Fetch();
  uint32 dataLvl = fields[0].GetUInt32();

  if (chrLvl >= dataLvl || chrLvl >= 80)
  {
      PSendSysMessage(LANG_DIAM_LVL_ERR);
      return true;
  }

  result = StoreDatabase.PQuery("SELECT price, nblevel FROM level WHERE level = '%u'", chrLvl);
  fields = result->Fetch();
  int32 dataPrice = fields[0].GetInt32();
  uint32 dataNblvl = fields[1].GetUInt32();

  //Is character has enough diamond ?
  if (diam < dataPrice)
    {
      PSendSysMessage(LANG_DIAM_NOT_ENOUGH, dataPrice);
      return true;
    }

  diam -= dataPrice;
  int32 newlevel = chrLvl + dataNblvl;

  int chrguid = chr->GetGUID();
  int acctid = m_session->GetAccountId();

  //Character level up
  chr->GiveLevel(newlevel);
  chr->InitTalentForLevel();
  chr->SetUInt32Value(PLAYER_XP, 0);

  StoreDatabase.PExecute("UPDATE diamond SET diamond='%d' WHERE acctid='%u'", diam, m_session->GetAccountId());
  StoreDatabase.PExecute("INSERT INTO lvl_bought(acctid, charid, clvl, elvl, nlvl, price) VALUES('%u', '%u', '%u', '%u', '%u', '%u')", acctid, chrguid, chrLvl, newlevel, dataNblvl, dataPrice);
  chr->SaveToDB();
  PSendSysMessage(LANG_DIAM_LVL_BUY, dataNblvl, dataPrice);

  return true;
}

bool ChatHandler::HandleRecupCommand(const char* /*args*/)
{
  Player *perso = m_session->GetPlayer();
  int charguid = perso->GetGUID();
  int acctid = m_session->GetAccountId();

  QueryResult result = WebDatabase.PQuery("SELECT * FROM recups WHERE account=%u AND perso=%u", acctid, charguid);
  if(result)
  {
      Field *fields = result->Fetch();
      int32 r_guid = fields[0].GetInt32();
      int32 r_status = fields[10].GetInt32();

      if (r_status == (int32)0 || r_status == (int32)1 || r_status == (int32)2)
      {
          PSendSysMessage(LANG_RECUP_WAITING);
          return true;
      }
      if (r_status == (int32)4)
      {
          PSendSysMessage(LANG_RECUP_ALREADY_DONE);
          return true;
      }
      if (r_status < (int32)0)
      {
          PSendSysMessage(LANG_RECUP_REFUSED);
          return true;
      }

      const char *r_skills = fields[6].GetString().c_str();

      if (r_skills){

          char **t_skills = my_explode((char*)r_skills, ';');
          char **my_skill;
          for (int i = 0; t_skills[i]; i++)
          {
              my_skill = my_explode(t_skills[i], ' ');
              if (my_skill[0] && my_skill[1]){
                  uint16 skill_id = static_cast<uint16>(atoi(my_skill[0]));
                  uint16 skill_level = static_cast<uint16>(atoi(my_skill[1]));
                  uint16 skill_max = perso->GetMaxSkillValueForLevel();
                  uint16 skill_step = perso->GetSkillStep(skill_id);
                  uint16 currValue = perso->GetPureSkillValue(skill_id);
                  bool can_learn_primary_prof = perso->GetFreePrimaryProfessionPoints() > 0;
                  if (!currValue && !can_learn_primary_prof && (skill_id == 171 || skill_id == 164 || skill_id == 333 || skill_id == 202 || skill_id == 182 || skill_id == 773 || skill_id == 755 || skill_id == 165 || skill_id == 186 || skill_id == 393 || skill_id == 197))
                      continue;

                  QueryResult r_prof = WebDatabase.PQuery("SELECT spell FROM profession_spell WHERE skill = %u", skill_id);
                  if (r_prof)
                  {
                      Field *prof_fields = r_prof->Fetch();
                      if (uint32 spell_id = prof_fields[0].GetUInt32())
                          perso->learnSpell(spell_id, false);
                  }
                  perso->SetSkill(skill_id, skill_step, skill_level, skill_max);
              }
          }
      }
      const char *r_reputs = fields[7].GetString().c_str();
      if(r_reputs){
          char **t_reputs = my_explode((char*)r_reputs, ';');
          char **my_reput;
          const FactionEntry *factionEntry;
          for (int i = 0; t_reputs[i]; i++)
          {
              my_reput = my_explode(t_reputs[i], ' ');
              if(my_reput[0] && my_reput[1]){
                  factionEntry = sFactionStore.LookupEntry((uint32)atoi(my_reput[0]));
                  if(!factionEntry){
                      PSendSysMessage("Reputation inexistante. Passee.");
                  }
                  else{
                      perso->GetReputationMgr().SetReputation(factionEntry, (int32)atoi(my_reput[1]));
                  }
              }
          }
      }

      WebDatabase.PExecute("UPDATE recups SET status=4 WHERE id=%u", r_guid);
      perso->SaveToDB();
      PSendSysMessage(LANG_RECUP_DONE);
  }
  else
      PSendSysMessage(LANG_RECUP_NOT_EXISTS);

  return true;
}
