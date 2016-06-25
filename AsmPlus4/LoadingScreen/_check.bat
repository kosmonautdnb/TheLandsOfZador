call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\LoadingScreen\assembly.lst -s..\..\LoadingScreen\symbols.txt -o..\..\LoadingScreen\check.prg
cd ..\..\LoadingScreen

