call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\ScrollWorld4\assembly.lst -s..\..\ScrollWorld4\symbols.txt -o..\..\ScrollWorld4\check.prg
cd ..\..\ScrollWorld4