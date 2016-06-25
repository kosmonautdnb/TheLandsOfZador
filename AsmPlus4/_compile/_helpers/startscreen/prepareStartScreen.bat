cd ..

call _collectDirInclude
call _clearCollectDir
call collectStandardAsms

xcopy ..\..\..\StartScreen\_codegfx\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\StartScreen\_code\GlobalCode\*.* %collectDir%\ /Y /d
xcopy ..\..\..\StartScreen\_sfx\Global\*.* %collectDir%\ /Y /d

xcopy ..\..\..\Musics\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Musics\Othersongs\make\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Musics\Othersongs\source\*.* %collectDir%\ /Y /d

rem --------------- MAKE MUSICS -----------------
cd %collectDir%\

dasm.exe makeMOS2_Title.asm -v3 -I..\..\..\Framework\trackmo\framework\ -omos2_title.prg
exomizer2 mem -omos2_title.exo mos2_title.prg

cd ..\_helpers\startscreen
