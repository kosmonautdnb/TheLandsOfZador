call _collect.bat
cd ..\_compile\_collectedForCompile

dasm.exe demopart.asm -v3 -I..\..\..\Framework\trackmo\framework\ -ostartscreen.prg
exomizer2 mem -ostartscreen.exo startscreen.prg

rem --------- PREPARE FOR DISC ---------------
xcopy %collectDir%\startscreen.exo %intermediateDir%\ /Y /d

cd ..\_helpers
call disc.bat

cd ..\..\StartScreen

