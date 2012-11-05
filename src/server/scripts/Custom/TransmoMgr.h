#ifndef _TRANSMOMGR_H
#define _TRANSMOMGR_H

#include "Config.h"

class TransmoMgr
{
	friend class ACE_Singleton<TransmoMgr, ACE_Null_Mutex>;
public:
	TransmoMgr() { };
	~TransmoMgr() { };

	bool IsEnable() { return m_isEnable; }
	bool NeedToken() { return m_needToken; }
	uint32 GetTokenId() { return m_tokenId; }
	uint32 GetTokenCount() { return m_tokenCount; }

	bool IsAllowedQuality(uint32 quality)
	{
		switch(quality)
        {
        case ITEM_QUALITY_POOR: return m_AllowPoor;
        case ITEM_QUALITY_NORMAL: return m_AllowCommon;
        case ITEM_QUALITY_UNCOMMON: return m_AllowUncommon;
        case ITEM_QUALITY_RARE: return m_AllowRare;
        case ITEM_QUALITY_EPIC: return m_AllowEpic;
        case ITEM_QUALITY_LEGENDARY: return m_AllowLegendary;
        case ITEM_QUALITY_ARTIFACT: return m_AllowArtefact;
        case ITEM_QUALITY_HEIRLOOM: return m_AllowHeirloom;
        default: return false;
        }
	}

	void LoadConfig()
	{
		m_isEnable = ConfigMgr::GetBoolDefault("Transmo.Enable", true);

		m_needToken = ConfigMgr::GetBoolDefault("Transmo.NeedToken", true);
		m_tokenId = (uint32)ConfigMgr::GetIntDefault("Transmo.TokenId",  20559);
		if (!sObjectMgr->GetItemTemplate(m_tokenId))
			m_tokenId = 20559;

		m_tokenCount = (uint32)ConfigMgr::GetIntDefault("Transmo.TokenCount",  3);

		m_AllowPoor = ConfigMgr::GetBoolDefault("Transmo.AllowPoor", false);
		m_AllowCommon = ConfigMgr::GetBoolDefault("Transmo.AllowCommon", false);
		m_AllowUncommon = ConfigMgr::GetBoolDefault("Transmo.AllowUncommon", true);
		m_AllowRare = ConfigMgr::GetBoolDefault("Transmo.AllowRare", true);
		m_AllowEpic = ConfigMgr::GetBoolDefault("Transmo.AllowEpic", true);
		m_AllowLegendary = ConfigMgr::GetBoolDefault("Transmo.AllowLegendary", false);
		m_AllowArtefact = ConfigMgr::GetBoolDefault("Transmo.AllowArtefact", false);
		m_AllowHeirloom = ConfigMgr::GetBoolDefault("Transmo.AllowHeirloom", false);
	}
private:

	bool m_isEnable;

	bool m_needToken;
	uint32 m_tokenId;
	uint32 m_tokenCount;

	bool m_AllowPoor;
	bool m_AllowCommon;
	bool m_AllowUncommon;
	bool m_AllowRare;
	bool m_AllowEpic;
	bool m_AllowLegendary;
	bool m_AllowArtefact;
	bool m_AllowHeirloom;
};

#define sTransmoMgr ACE_Singleton<TransmoMgr, ACE_Null_Mutex>::instance()

#endif
