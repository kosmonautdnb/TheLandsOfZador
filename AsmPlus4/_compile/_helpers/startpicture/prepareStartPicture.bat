cd ..

call _collectDirInclude
call _clearCollectDir
call collectStandardAsms

xcopy ..\..\..\StartPicture\_codegfx\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\StartPicture\_code\GlobalCode\*.* %collectDir%\ /Y /d

cd startpicture