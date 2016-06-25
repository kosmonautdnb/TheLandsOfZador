cd ..

call _collectDirInclude
call _clearCollectDir
call collectStandardAsms

xcopy ..\..\..\ScrollModus\_codegfx\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\ScrollModus\_codegfx\Global\nongfx\*.* %collectDir%\ /Y /d
xcopy ..\..\..\ScrollModus\_code\GlobalCode\*.* %collectDir%\ /Y /d

xcopy ..\..\..\ScrollModus\_code\_globalincludes\*.* %collectDir%\ /Y /d
xcopy ..\..\..\ScrollModus\_code\LevelsCode\*.* %collectDir%\ /Y /d

xcopy ..\..\..\ScrollModus\_sfx\Global\*.* %collectDir%\ /Y /d

rem --------------------------------------------------------------
rem --------------------TextBorder and TextFont ------------------
rem --------------------------------------------------------------

cd ..\_collectedForCompile
dasm.exe gamefont.asm -v3 -I..\..\..\Framework\trackmo\framework\ -ogamefont.prg
exomizer2 mem -ogamefont.exo gamefont.prg
dasm.exe screenmask.asm -v3 -I..\..\..\Framework\trackmo\framework\ -oscreenmask.prg
exomizer2 mem -oscreenmask.exo screenmask.prg
cd ..\_helpers

cd worlds
