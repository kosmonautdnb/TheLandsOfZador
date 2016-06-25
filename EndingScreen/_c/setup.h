#ifndef _SETUP_H_
#define _SETUP_H_

#include <string>

extern std::string commandLine;
extern std::string globalWorkingDirPrefix;
extern std::string globalOutputDirPrefix;
extern std::string dataDirPrefix;

void setupWithCommandLine();

#endif