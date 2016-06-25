call _collect.bat
cd ..\_compile\_collectedForCompile


cd ..\_collectedForCompile

rem erstmal make (compile)
dasm.exe makesl1.asm -v3 -I..\..\..\Framework\trackmo\framework\ -o..\_intermediate\sl1.prg
dasm.exe makesl2.asm -v3 -I..\..\..\Framework\trackmo\framework\ -o..\_intermediate\sl2.prg
dasm.exe makesl3.asm -v3 -I..\..\..\Framework\trackmo\framework\ -o..\_intermediate\sl3.prg
dasm.exe makesl4.asm -v3 -I..\..\..\Framework\trackmo\framework\ -o..\_intermediate\sl4.prg
dasm.exe makesl5.asm -v3 -I..\..\..\Framework\trackmo\framework\ -o..\_intermediate\sl5.prg
dasm.exe makesl6.asm -v3 -I..\..\..\Framework\trackmo\framework\ -o..\_intermediate\sl6.prg
dasm.exe makesl7.asm -v3 -I..\..\..\Framework\trackmo\framework\ -o..\_intermediate\sl7.prg
dasm.exe makesl8.asm -v3 -I..\..\..\Framework\trackmo\framework\ -o..\_intermediate\sl8.prg
dasm.exe makeEnding.asm -v3 -I..\..\..\Framework\trackmo\framework\ -o..\_intermediate\ess.prg

rem now exomize
exomizer2 mem -o..\_intermediate\sl1.exo ..\_intermediate\sl1.prg
exomizer2 mem -o..\_intermediate\sl2.exo ..\_intermediate\sl2.prg
exomizer2 mem -o..\_intermediate\sl3.exo ..\_intermediate\sl3.prg
exomizer2 mem -o..\_intermediate\sl4.exo ..\_intermediate\sl4.prg
exomizer2 mem -o..\_intermediate\sl5.exo ..\_intermediate\sl5.prg
exomizer2 mem -o..\_intermediate\sl6.exo ..\_intermediate\sl6.prg
exomizer2 mem -o..\_intermediate\sl7.exo ..\_intermediate\sl7.prg
exomizer2 mem -o..\_intermediate\sl8.exo ..\_intermediate\sl8.prg
exomizer2 mem -o..\_intermediate\ess.exo ..\_intermediate\ess.prg

cd ..\_helpers
call disc.bat

cd ..\..\Musics

