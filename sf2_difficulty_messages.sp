#include <sf2>
#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <tf2>
#include <tf2_stocks>
#include <cbasenpc>
#include <morecolors>

bool g_slenderDiffMessage[MAX_BOSSES];

public Plugin myinfo =
{
	name = "[SF2] Difficulty Messages",
	description = "Make a boss say something on difficulty change.",
	author = "The Gaben",
	version = "1.0.0",
	url = "http://steamcommunity.com/profiles/76561198075611624/"
};

public void SF2_OnBossAdded(int bossIndex)
{
	char profile[SF2_MAX_PROFILE_NAME_LENGTH];
	SF2_GetBossName(bossIndex, profile, sizeof(profile));

	g_slenderDiffMessage[bossIndex] = SF2_GetBossProfileNum(profile, "difficulty_messages", 0)  != 0;
}

public void SF2_OnDifficultyChanged(int difficulty, int oldDifficulty)
{
	for (int bossIndex = 0; bossIndex < MAX_BOSSES; bossIndex++)
	{
		if (SF2_BossIndexToBossID(bossIndex) == -1)
		{
			continue;
		}

		if (g_slenderDiffMessage[bossIndex])
		{
			char profile[SF2_MAX_PROFILE_NAME_LENGTH];
			char bossname[PLATFORM_MAX_PATH];
			char sentence1[PLATFORM_MAX_PATH];
			char sentence2[PLATFORM_MAX_PATH];
			char sentence3[PLATFORM_MAX_PATH];
			char sentence4[PLATFORM_MAX_PATH];
			char sentence5[PLATFORM_MAX_PATH];
			char namecolor[PLATFORM_MAX_PATH];
			SF2_GetBossName(bossIndex, profile, sizeof(profile));
			SF2_GetBossProfileString(profile, "name", bossname, sizeof(bossname));
			SF2_GetBossProfileString(profile, "difficulty_message_namecolor", namecolor, sizeof(namecolor), "red");
			SF2_GetRandomStringFromBossProfile(profile, "difficulty_message_normal", sentence1, sizeof(sentence1));
			SF2_GetRandomStringFromBossProfile(profile, "difficulty_message_hard", sentence2, sizeof(sentence2));
			SF2_GetRandomStringFromBossProfile(profile, "difficulty_message_insane", sentence3, sizeof(sentence3));
			SF2_GetRandomStringFromBossProfile(profile, "difficulty_message_nightmare", sentence4, sizeof(sentence4));
			SF2_GetRandomStringFromBossProfile(profile, "difficulty_message_apollyon", sentence5, sizeof(sentence5));

			switch (difficulty)
			{
				case Difficulty_Normal:
				{
					if (sentence1[0] != '\0')
					{
						CPrintToChatAll("{%s}%s{default}: %s", namecolor, bossname, sentence1);
					}
				}

				case Difficulty_Hard:
				{
					if (sentence2[0] != '\0')
					{
						CPrintToChatAll("{%s}%s{default}: %s", namecolor, bossname, sentence2);
					}
				}

				case Difficulty_Insane:
				{
					if (sentence3[0] != '\0')
					{
						CPrintToChatAll("{%s}%s{default}: %s", namecolor, bossname, sentence3);
					}
				}

				case Difficulty_Nightmare:
				{
					if (sentence4[0] != '\0')
					{
						CPrintToChatAll("{%s}%s{default}: %s", namecolor, bossname, sentence4);
					}
				}

				case Difficulty_Apollyon:
				{
					if (sentence5[0] != '\0')
					{
						CPrintToChatAll("{%s}%s{default}: %s", namecolor, bossname, sentence5);
					}
				}
			}
		}
	}
}