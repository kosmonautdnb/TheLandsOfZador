call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\EndingScene\assembly.lst -s..\..\EndingScene\symbols.txt -o..\..\EndingScene\check.prg
cd ..\..\EndingScene

