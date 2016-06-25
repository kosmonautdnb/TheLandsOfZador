#include "setup.h"

std::string commandLine;

std::string globalWorkingDirPrefix;
std::string globalOutputDirPrefix;
std::string dataDirPrefix;

void setupWithCommandLine()
{
	globalWorkingDirPrefix		= "../../../StartScreen/_gfx/Global/";
	globalOutputDirPrefix		= "../../../StartScreen/_codegfx/Global/";
	dataDirPrefix				= "data/";
}