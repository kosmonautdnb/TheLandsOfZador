
call _collectDirInclude.bat
xcopy ..\_intermediate\*.bin %disc1Dir%\ /Y /d
xcopy ..\_intermediate\*.exo %disc1Dir%\ /Y /d

cd %disc1Dir%\..\make
call _build.bat
if NOT "%dontStart%"=="on" (
call _startDisc.bat
)
cd ..\..\..\AsmPlus4\_compile\_helpers