#include "setup.h"

std::string commandLine;

std::string globalWorkingDirPrefix;
std::string globalOutputDirPrefix;
std::string dataDirPrefix;

void setupWithCommandLine()
{
	globalWorkingDirPrefix		= "../../../EndingScreen/_gfx/Global/";
	globalOutputDirPrefix		= "../../../EndingScreen/_codegfx/Global/";
	dataDirPrefix				= "data/";
}