call _collect.bat
rem ---------------- level musics
xcopy ..\..\Musics\LevelSongs\source\welt2_star1.asm .\ /Y
del song.asm
ren welt2_star1.asm song.asm
xcopy song.asm ..\..\Musics\FrameworkSong\asm\ /Y 
pushd ..\..\Framework\trackmo\framework
call test.bat
popd
rem -----------------------------
cd ..\_compile\_collectedForCompile
dasm.exe demopartstart.asm -v3 -I..\..\..\Framework\trackmo\framework\ -odemopart.prg
exomizer2 mem -l $17f0 -o demopart.exo demopart.prg
dasm.exe ..\..\..\Framework\trackmo\framework\driver_packed.asm -v1 -I..\..\..\Framework\trackmo\framework\ -o..\..\ScrollWorld2\leveltest.prg
cd ..\..\ScrollWorld2
yape leveltest.prg
