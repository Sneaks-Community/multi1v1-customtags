#include <sourcemod>
#include <cstrike>
#include <multi1v1>

#pragma newdecls required

public Plugin myinfo =
{
	name = "1v1 Arenas - Custom Tags",
	version = "1.0",
	author = "sneaK",
	description = "Appends VIP, Admin, and Owner tags to standard arena labeling system",
	url = "www.snksrv.com"
}

public void OnPluginStart()
{
	LoadTranslations("multi1v1.phrases");
}

public void Multi1v1_AfterPlayerSetup(int client)
{
	int iArena = Multi1v1_GetArenaNumber(client);
	char szClanTag[32];
	
	if (CheckCommandAccess(client, "owner", ADMFLAG_ROOT))
	{
		Format(szClanTag, sizeof(szClanTag), "%T|Owner", "ArenaClanTag", LANG_SERVER, iArena);
	}

	else if (CheckCommandAccess(client, "admin", ADMFLAG_GENERIC))
	{
		Format(szClanTag, sizeof(szClanTag), "%T|Admin", "ArenaClanTag", LANG_SERVER, iArena);
	}

	else if (CheckCommandAccess(client, "vip", ADMFLAG_CUSTOM2))
	{
		Format(szClanTag, sizeof(szClanTag), "%T | VIP", "ArenaClanTag", LANG_SERVER, iArena);
	}

	else
	{
		Format(szClanTag, sizeof(szClanTag), "%T", "ArenaClanTag", LANG_SERVER, iArena);
	}

	CS_SetClientClanTag(client, szClanTag);
}