cd ..

call _collectDirInclude
call _clearCollectDir
call collectStandardAsms

xcopy ..\..\..\Musics\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Musics\LevelSongs\source\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Musics\LevelSongs\make\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Musics\OtherSongs\source\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Musics\OtherSongs\make\*.* %collectDir%\ /Y /d

cd musics