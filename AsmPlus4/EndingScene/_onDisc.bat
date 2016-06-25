call _collect.bat
cd ..\_compile\_collectedForCompile

dasm.exe demopart.asm -v3 -I..\..\..\Framework\trackmo\framework\ -oendingscene.prg
exomizer2 mem -oendingscene.exo endingscene.prg

rem --------- PREPARE FOR DISC ---------------
xcopy %collectDir%\endingscene.exo %intermediateDir%\ /Y /d
xcopy %collectDir%\starships.exo %intermediateDir%\ /Y /d

cd ..\_helpers
call disc.bat

cd ..\..\EndingScene

