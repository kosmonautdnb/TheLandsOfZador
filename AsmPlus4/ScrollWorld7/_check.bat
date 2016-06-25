call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\ScrollWorld7\assembly.lst -s..\..\ScrollWorld7\symbols.txt -o..\..\ScrollWorld7\check.prg
cd ..\..\ScrollWorld7