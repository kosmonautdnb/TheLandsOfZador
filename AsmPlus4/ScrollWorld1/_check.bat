call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\ScrollWorld1\assembly.lst -s..\..\ScrollWorld1\symbols.txt -o..\..\ScrollWorld1\check.prg
cd ..\..\ScrollWorld1