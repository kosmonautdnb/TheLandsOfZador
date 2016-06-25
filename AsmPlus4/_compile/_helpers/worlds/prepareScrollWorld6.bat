call prepareScrollWorldsPre

rem --------------------------------------------------------------
rem ----------------------- worldStuff ---------------------------
rem --------------------------------------------------------------

cd ..

xcopy ..\..\..\ScrollModus\_codegfx\World6\*.* %collectDir%\ /Y /d
xcopy ..\..\..\ScrollModus\_code\World6Code\*.* %collectDir%\ /Y /d

rem --- level ---
xcopy ..\..\..\ScrollModus\_codegfx\World6\Levels\Level1\*.* %collectDir%\ /Y /d

cd worlds

call prepareScrollWorldsPost

