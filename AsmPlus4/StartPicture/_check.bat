call _collect.bat
cd ..\_compile\_collectedForCompile
cmd /K dasm.exe demopart.asm -v3  -I..\..\..\Framework\trackmo\framework\ -l..\..\StartPicture\assembly.lst -s..\..\StartPicture\symbols.txt -o..\..\StartPicture\check.prg
cd ..\..\StartPicture

