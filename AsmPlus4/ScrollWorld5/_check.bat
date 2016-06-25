call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\ScrollWorld5\assembly.lst -s..\..\ScrollWorld5\symbols.txt -o..\..\ScrollWorld5\check.prg
cd ..\..\ScrollWorld5