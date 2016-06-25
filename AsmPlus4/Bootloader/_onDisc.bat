rem ---------------- intro musics
xcopy ..\..\Musics\OtherSongs\source\starting.asm .\ /Y
del song.asm
ren starting.asm song.asm
xcopy song.asm ..\..\Musics\FrameworkSong\asm\ /Y 
pushd ..\..\Framework\trackmo\framework
call test.bat
popd
rem -----------------------------

cd ..\..\Framework\trackmo\framework
call test.bat
cd ..\..\..\AsmPlus4\Bootloader
call _collect

cd ..\_compile\_collectedForCompile

dasm.exe demopart.asm -v3 -I..\..\..\Framework\trackmo\framework\ -obootloader.prg
exomizer2 sfx 4109 -obootloader.exo bootloader.prg -t4

rem --------- PREPARE FOR DISC ---------------
xcopy %collectDir%\bootloader.exo %intermediateDir%\ /Y /d

cd ..\_helpers
call disc.bat

cd ..\..\Bootloader

