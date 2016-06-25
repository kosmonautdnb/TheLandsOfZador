call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\ScrollWorld3\assembly.lst -s..\..\ScrollWorld3\symbols.txt -o..\..\ScrollWorld3\check.prg
cd ..\..\ScrollWorld3