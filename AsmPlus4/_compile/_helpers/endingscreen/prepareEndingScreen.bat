cd ..

call _collectDirInclude
call _clearCollectDir
call collectStandardAsms

xcopy ..\..\..\EndingScreen\_codegfx\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\EndingScreen\_code\GlobalCode\*.* %collectDir%\ /Y /d
xcopy ..\..\..\EndingScreen\_sfx\Global\*.* %collectDir%\ /Y /d

cd endingscreen