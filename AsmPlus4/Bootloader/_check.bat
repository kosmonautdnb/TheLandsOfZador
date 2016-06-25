call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\BootLoader\assembly.lst -s..\..\BootLoader\symbols.txt -o..\..\BootLoader\check.prg
cd ..\..\BootLoader

