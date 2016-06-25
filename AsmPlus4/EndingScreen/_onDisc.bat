call _collect.bat
cd ..\_compile\_collectedForCompile

dasm.exe demopart.asm -v3 -I..\..\..\Framework\trackmo\framework\ -oendingscreen.prg
exomizer2 mem -oendingscreen.exo endingscreen.prg

rem --------- PREPARE FOR DISC ---------------
xcopy %collectDir%\endingscreen.exo %intermediateDir%\ /Y /d

cd ..\_helpers
call disc.bat

cd ..\..\EndingScreen

