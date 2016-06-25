#ifndef _SETUP_H_
#define _SETUP_H_

#include <string>

extern std::string commandLine;
extern std::string globalWorkingDirPrefix;
extern std::string spritesWorkingDirPrefix;
extern std::string tilesWorkingDirPrefix;
extern std::string levelWorkingDirPrefix;
extern std::string globalOutputDirPrefix;
extern std::string spritesOutputDirPrefix;
extern std::string tilesOutputDirPrefix;
extern std::string levelOutputDirPrefix;
extern std::string checkingDirPrefix;
extern std::string dataDirPrefix;

extern std::string levelSuffix;

extern unsigned char backgroundColor; // also used for the sprites
extern unsigned char foregroundColor; // also used for the sprites
extern unsigned char spriteColor1; // also used for the sprites
extern int exitBackgroundColor;
extern int exit_starCol1;
extern int gWorld;
extern int gLevel;

extern unsigned char backgroundColor; // also used for the sprites
extern unsigned char foregroundColor; // also used for the sprites

void setupWithCommandLine();

#endif