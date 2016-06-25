#include "setup.h"

std::string commandLine;

std::string globalWorkingDirPrefix;
std::string globalOutputDirPrefix;
std::string dataDirPrefix;

void setupWithCommandLine()
{
	globalWorkingDirPrefix		= "../../../StartPicture/_gfx/Global/";
	globalOutputDirPrefix		= "../../../StartPicture/_codegfx/Global/";
	dataDirPrefix				= "data/";
}