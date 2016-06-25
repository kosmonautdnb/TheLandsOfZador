cd ..

call _collectDirInclude
call _clearCollectDir
call collectStandardAsms

xcopy ..\..\..\Bootloader\_codegfx\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Bootloader\_code\GlobalCode\*.* %collectDir%\ /Y /d

cd bootloader