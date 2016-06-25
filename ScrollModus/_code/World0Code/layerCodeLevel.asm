;-----------------------------------------------------
; x tells if it should be activated or deactivated
;-----------------------------------------------------
LAYER0FUNC SUBROUTINE
	rts

LAYER1FUNC SUBROUTINE
	rts

LAYER2FUNC SUBROUTINE
	rts

LAYER3FUNC SUBROUTINE
	rts

LAYER4FUNC SUBROUTINE
	rts

LAYER5FUNC SUBROUTINE
	rts

LAYER6FUNC SUBROUTINE
	rts

LAYER7FUNC SUBROUTINE
	rts

LAYER8FUNC SUBROUTINE
	rts

LAYER9FUNC SUBROUTINE
	rts

LAYER10FUNC SUBROUTINE
	rts

LAYER11FUNC SUBROUTINE
	rts

LAYER12FUNC SUBROUTINE
	rts

LAYER13FUNC SUBROUTINE
	beq .notActivated
	lda #QUITFLAG_LOADNEXTLEVEL
	sta quitFlag
.notActivated
	rts

LAYER14FUNC SUBROUTINE
	beq .notActivated
	lda #$03
	sta ZP_BALLS
.notActivated
	rts

LAYER15FUNC SUBROUTINE
	beq .notActivated
	lda #FULLENERGY
	sta ZP_ENERGY
.notActivated
	rts


EXPLOGRAVITY = $68
EXPLOIMPULS	= $03
EXPLOLIVETIME = $20
