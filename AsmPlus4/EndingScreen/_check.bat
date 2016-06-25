call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\EndingScreen\assembly.lst -s..\..\EndingScreen\symbols.txt -o..\..\EndingScreen\check.prg
cd ..\..\EndingScreen

