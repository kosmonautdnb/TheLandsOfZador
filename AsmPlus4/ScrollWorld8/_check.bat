call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\ScrollWorld8\assembly.lst -s..\..\ScrollWorld8\symbols.txt -o..\..\ScrollWorld8\check.prg
cd ..\..\ScrollWorld8