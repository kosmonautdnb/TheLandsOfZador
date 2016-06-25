call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\ScrollWorld2\assembly.lst -s..\..\ScrollWorld2\symbols.txt -o..\..\ScrollWorld2\check.prg
cd ..\..\ScrollWorld2