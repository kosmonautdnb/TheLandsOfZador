
cd ..
xcopy splitScrollWorld\splitter.exe %collectDir%\ /Y /d
cd ..\_collectedForCompile
call splitter.exe
exomizer2 mem -oengine.exo scrollworldpart0.prg
exomizer2 mem -oscrollworld.exo scrollworldpart1.prg
exomizer2 mem -osoundeffects.exo scrollworldpart2.prg
cd ..\_helpers\splitScrollWorld