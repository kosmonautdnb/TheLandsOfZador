call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\StartScreen\assembly.lst -s..\..\StartScreen\symbols.txt -o..\..\StartScreen\check.prg
cd ..\..\StartScreen

