call _collectDirInclude.bat
xcopy ..\_standardAsms\*.* %collectDir%\ /Y /d
xcopy ..\..\..\Global\_code\*.* %collectDir%\ /Y /d