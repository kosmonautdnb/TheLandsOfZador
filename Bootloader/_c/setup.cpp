#include "setup.h"

std::string commandLine;

std::string globalWorkingDirPrefix;
std::string globalOutputDirPrefix;
std::string dataDirPrefix;

void setupWithCommandLine()
{
	globalWorkingDirPrefix		= "../../../BootLoader/_gfx/Global/";
	globalOutputDirPrefix		= "../../../BootLoader/_codegfx/Global/";
	dataDirPrefix				= "data/";
}