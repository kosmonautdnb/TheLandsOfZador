#include "setup.h"


unsigned char backgroundColor; // also used for the sprites
unsigned char foregroundColor; // also used for the sprites
unsigned char spriteColor1; // also used for the sprites

int gLevel = 1;
int gWorld = 7;

std::string commandLine;

std::string globalWorkingDirPrefix;
std::string spritesWorkingDirPrefix;
std::string tilesWorkingDirPrefix;
std::string levelWorkingDirPrefix;

std::string globalOutputDirPrefix;
std::string spritesOutputDirPrefix;
std::string tilesOutputDirPrefix;
std::string levelOutputDirPrefix;

std::string checkingDirPrefix;
std::string dataDirPrefix;
std::string levelSuffix;

void setupWithCommandLine()
{
	std::string levelDir;
	std::string worldDir;
	switch(gLevel)
	{
	case 0:
		levelSuffix = "_level0";
		levelDir    = "Level0/";
		break;
	case 1:
		levelSuffix = "_level1";
		levelDir    = "Level1/";
		break;
	case 2:
		levelSuffix = "_level2";
		levelDir    = "Level2/";
		break;
	case 3:
		levelSuffix = "_level3";
		levelDir    = "Level3/";
		break;
	}
	switch(gWorld)
	{
	case 0:
		backgroundColor = 0x0c;
		foregroundColor = 0x79;
		worldDir = "World0/";
		break;
	case 1:
		backgroundColor = 0x0c;
		foregroundColor = 0x79;
		spriteColor1 = 0x02;
		worldDir = "World1/";
		break;
	case 2:

		backgroundColor = 0x09;
		foregroundColor = 0x79;
		spriteColor1 = 0x0d;
		worldDir = "World2/";
		break;
	case 3:
		backgroundColor = 0xff;
		foregroundColor = 0x79;
		spriteColor1 = 0x0d;
		worldDir = "World3/";
		break;
	case 4:
		backgroundColor = 0xff;
		foregroundColor = 0x79;
		spriteColor1 = 0x0b;
		worldDir = "World4/";
		break;
	case 5:
		backgroundColor = 0xff;
		foregroundColor = 0x79;
		spriteColor1 = 0x0b;
		worldDir = "World5/";
		break;
	case 6:
		backgroundColor = 0xff;
		foregroundColor = 0x79;
		spriteColor1 = 0x0b;
		worldDir = "World6/";
		break;
	case 7:
		backgroundColor = 0xff;
		foregroundColor = 0x79;
		spriteColor1 = 0x0d;
		worldDir = "World7/";
		break;
	case 8:
		backgroundColor = 0xff;
		foregroundColor = 0x79;
		spriteColor1 = 0x0b;
		worldDir = "World8/";
		break;
	}
		
	globalWorkingDirPrefix		= "../../ScrollModus/_gfx/Global/";

	spritesWorkingDirPrefix		= "../../ScrollModus/_gfx/"+worldDir+"Sprites/";
	levelWorkingDirPrefix		= "../../ScrollModus/_gfx/"+worldDir+"Levels/" + levelDir;
	tilesWorkingDirPrefix		= "../../ScrollModus/_gfx/"+worldDir;
	globalOutputDirPrefix		= "../../ScrollModus/_codegfx/Global/";
	spritesOutputDirPrefix		= "../../ScrollModus/_codegfx/"+worldDir;
	levelOutputDirPrefix		= "../../ScrollModus/_codegfx/"+worldDir+"Levels/" + levelDir;
	tilesOutputDirPrefix		= "../../ScrollModus/_codegfx/"+worldDir;
	checkingDirPrefix			= "../../ScrollModus/_gfx/_check/";
	dataDirPrefix				= "data/";
}