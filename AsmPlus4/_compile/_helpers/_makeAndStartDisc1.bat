cd ..\..\..\Disc\Disc1\make
call _build.bat
if NOT "%dontStart%"=="on" (
call _startDisc.bat
)
cd ..\..\..\AsmPlus4\_compile\_helpers