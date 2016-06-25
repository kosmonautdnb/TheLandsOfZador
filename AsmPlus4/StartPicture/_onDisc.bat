call _collect.bat
cd ..\_compile\_collectedForCompile

dasm.exe demopart.asm -v3 -I..\..\..\Framework\trackmo\framework\ -ostartpicture.prg
exomizer2 mem -ostartpicture.exo startpicture.prg

rem --------- PREPARE FOR DISC ---------------
xcopy %collectDir%\startpicture.exo %intermediateDir%\ /Y /d

cd ..\_helpers
call disc.bat

cd ..\..\StartPicture

