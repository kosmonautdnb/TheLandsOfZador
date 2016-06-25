call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\ScrollWorld6\assembly.lst -s..\..\ScrollWorld6\symbols.txt -o..\..\ScrollWorld6\check.prg
cd ..\..\ScrollWorld6