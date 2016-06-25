#include "setup.h"

std::string commandLine;

std::string globalWorkingDirPrefix;
std::string globalOutputDirPrefix;
std::string dataDirPrefix;

void setupWithCommandLine()
{
	globalWorkingDirPrefix		= "../../../Stories/_gfx/Global/";
	globalOutputDirPrefix		= "../../../Stories/_codegfx/Global/";
	dataDirPrefix				= "data/";
}