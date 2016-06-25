#include "setup.h"

std::string commandLine;

std::string globalWorkingDirPrefix;
std::string globalOutputDirPrefix;
std::string dataDirPrefix;

void setupWithCommandLine()
{
	globalWorkingDirPrefix		= "../../../EndingScene/_gfx/Global/";
	globalOutputDirPrefix		= "../../../EndingScene/_codegfx/Global/";
	dataDirPrefix				= "data/";
}