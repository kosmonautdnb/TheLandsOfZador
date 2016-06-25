#include "setup.h"

std::string commandLine;

std::string globalWorkingDirPrefix;
std::string globalOutputDirPrefix;
std::string dataDirPrefix;

void setupWithCommandLine()
{
	globalWorkingDirPrefix		= "../../../LoadingScreen/_gfx/Global/";
	globalOutputDirPrefix		= "../../../LoadingScreen/_codegfx/Global/";
	dataDirPrefix				= "data/";
}