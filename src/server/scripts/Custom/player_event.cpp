#include "ScriptMgr.h"


class player_event : public PlayerScript
{
    public:
        player_event() : PlayerScript("player_event") 
  { 
  }


  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("grml") != std::string::npos)
      {
	uint16 display_id = 25149;
	player->SetDisplayId(display_id);
      }
    if (msg.find("grognie") != std::string::npos)
      {
	uint16 display_id = 29348;
	player->SetDisplayId(display_id);
      }
    if (msg.find("bourbie") != std::string::npos)
      {
	uint16 display_id = 15369;
	player->SetDisplayId(display_id);
      }
    if (msg.find("gloubie") != std::string::npos)
      {
	uint16 display_id = 15984;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* receiver)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
  }

  void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel)
  {
    if (msg.find("murloc") != std::string::npos)
      {
	uint16 display_id = 21723;
	player->SetDisplayId(display_id);
      }
    if (msg.find("demorph") != std::string::npos)
      player->SetDisplayId(player->GetNativeDisplayId());
  }



};

void AddSC_player_event()
{
    new player_event();
}
