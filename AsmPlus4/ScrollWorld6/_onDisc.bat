call _collect.bat

rem --------- COMPILE THE WORLD --------------

cd ..\_compile\_collectedForCompile
dasm.exe demopartstart.asm -v3 -I..\..\..\Framework\trackmo\framework\ -odemopart.prg
cd ..\..\ScrollWorld6

rem --------- SPLIT THE WORLD ----------------
cd ..\_compile\_helpers\splitScrollWorld
call splitworld.bat

rem --------- PREPARE FOR DISC ---------------
cd ..
xcopy %collectDir%\engine.exo %intermediateDir%\ /Y /d
xcopy %collectDir%\scrollworld.exo %intermediateDir%\ /Y /d
xcopy %collectDir%\soundeffects.exo %intermediateDir%\ /Y /d

cd %intermediateDir%

rem ----------- FINAL NAMING FOR DISC --------
del scrollengine.exo
del w6part.exo
ren engine.exo scrollengine.exo
ren scrollWorld.exo w6part.exo

cd ..\_helpers
call disc.bat

cd ..\..\ScrollWorld6