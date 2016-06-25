ZP_LIVES					  = $80 ; 1
ZP_BALLS					  = $81 ; 1
ZP_ENERGY					  = $82 ; 1
ZP_LOADSTATE					  = $84 ; 1

ZP_SKILLLEVEL					  = $85 ; 1
ZP_LEVELCURRENT					  = $89 ; 1
ZP_LEVELTOLOAD				          = $8a ; 1
ZP_LEVELSTATUS					  = $8b ; 1
ZP_CHEAT					  = $8c ; 1
ZP_DONTPLAYINTRO				  = $8d ; 1
ZP_DONTFADEOUT					  = $8e ; 1
ZP_USEBIOSLOADING				  = $8f ; 1 ; also defined in player.asm and fw_bootstrap.asm

ZP_FOURBYTES					  = $91 ; 4 ; bytes
ZP_ONLYSECONDCHAPTER				  = $96 ; 1 ; 90 is something with kernal load from the 1551 

LEVELSTATUS_OK 	     				  = $00
LEVELSTATUS_GAMEOVER 				  = $01

LOADSTATE_ENGINE      = $01
LOADSTATE_SFX 	      = $02
LOADSTATE_SCROLLLEVEL = $04