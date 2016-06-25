call _collect.bat
cd ..\_compile\_collectedForCompile

dasm.exe demopart.asm -v3 -I..\..\..\Framework\trackmo\framework\ -oloadingscreen.prg
exomizer2 mem -oloadingscreen.exo loadingscreen.prg

rem --------- PREPARE FOR DISC ---------------
xcopy %collectDir%\loadingscreen.exo %intermediateDir%\ /Y /d

cd ..\_helpers
call disc.bat

cd ..\..\LoadingScreen

