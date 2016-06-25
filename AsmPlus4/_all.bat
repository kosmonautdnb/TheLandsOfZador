set dontStart=on

cd LoadingScreen
call _onDisc.bat
cd ..

cd StartScreen
call _onDisc.bat
cd ..

cd EndingScreen
call _onDisc.bat
cd ..

cd EndingScene
call _onDisc.bat
cd ..

cd StartPicture
call _onDisc.bat
cd ..

cd Musics
call _onDisc.bat
cd ..

cd ScrollWorld2
call _onDisc.bat
cd ..

cd ScrollWorld3
call _onDisc.bat
cd ..

cd ScrollWorld4
call _onDisc.bat
cd ..

cd ScrollWorld5
call _onDisc.bat
cd ..

cd ScrollWorld6
call _onDisc.bat
cd ..

cd ScrollWorld7
call _onDisc.bat
cd ..

cd ScrollWorld8
call _onDisc.bat
cd ..

cd StartScreen
call _onDisc.bat
cd ..

rem ---- for the engine file ----
cd ScrollWorld1
call _onDisc.bat
cd ..

set dontStart=off

rem ---- for the intro music to the framework this is called last ----
cd Bootloader
call _onDisc.bat
cd ..
