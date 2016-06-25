cd ..

call _collectDirInclude
call _clearCollectDir
call collectStandardAsms

xcopy ..\..\..\LoadingScreen\_codegfx\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\LoadingScreen\_code\GlobalCode\*.* %collectDir%\ /Y /d
xcopy ..\..\..\LoadingScreen\_sfx\Global\*.* %collectDir%\ /Y /d

xcopy ..\..\..\Musics\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Musics\Othersongs\make\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Musics\Othersongs\source\*.* %collectDir%\ /Y /d

rem --------------- MAKE MUSICS -----------------
cd %collectDir%\

dasm.exe makeLoading.asm -v3 -I..\..\..\Framework\trackmo\framework\ -oloading.prg
exomizer2 mem -oloading.exo loading.prg
dasm.exe makeEmpty.asm -v3 -I..\..\..\Framework\trackmo\framework\ -oempty.prg
exomizer2 mem -oempty.exo empty.prg

cd ..\_helpers\loadingscreen