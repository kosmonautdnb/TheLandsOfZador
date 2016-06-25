cd ..

call _collectDirInclude
call _clearCollectDir
call collectStandardAsms

xcopy ..\..\..\EndingScene\_codegfx\Global\*.* %collectDir%\ /Y /d
xcopy ..\..\..\EndingScene\_code\GlobalCode\*.* %collectDir%\ /Y /d

rem --------------- MAKE MUSICS -----------------
cd %collectDir%\

dasm.exe scene1.asm -v3 -I..\..\..\Framework\trackmo\framework\ -oscene1.prg
exomizer2 mem -oscene1.exo scene1.prg

dasm.exe endtext.asm -v3 -I..\..\..\Framework\trackmo\framework\ -oendtext.prg
exomizer2 mem -oendtext.exo endtext.prg

dasm.exe endfont.asm -v3 -I..\..\..\Framework\trackmo\framework\ -oendfont.prg
exomizer2 mem -oendfont.exo endfont.prg

dasm.exe finCharset.asm -v3 -I..\..\..\Framework\trackmo\framework\ -ofinCharset.prg
exomizer2 mem -ofinCharset.exo finCharset.prg

dasm.exe finScreen.asm -v3 -I..\..\..\Framework\trackmo\framework\ -ofinScreen.prg
exomizer2 mem -ofinScreen.exo finScreen.prg

dasm.exe starships.asm -v3 -I..\..\..\Framework\trackmo\framework\ -ostarships.prg
exomizer2 mem -ostarships.exo starships.prg

cd ..\_helpers\endingscene
