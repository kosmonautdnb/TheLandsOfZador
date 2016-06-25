rem --------------------------------------------------------------
rem ---------------------- compile texts -------------------------
rem --------------------------------------------------------------

cd ..

cd ..\_collectedForCompile
dasm.exe textscreens.asm -v3 -I..\..\..\Framework\trackmo\framework\ -otextscreens.prg
exomizer2 mem -otextscreens.exo textscreens.prg
cd ..\_helpers

cd worlds
