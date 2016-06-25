;-----------------------------------------------------
; x tells if it should be activated or deactivated
;-----------------------------------------------------
LAYER0FUNC SUBROUTINE
	beq .deactivated
	lda #$00
	sta parallaxRasterSpeed + 1
	rts
.deactivated
	lda #$02
	sta parallaxRasterSpeed + 1
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
	beq .notActivated
	lda #<PLAYERSHIELD_DURATION_NORMAL
	sta playerShieldOn + 0
	lda #>PLAYERSHIELD_DURATION_NORMAL
	sta playerShieldOn + 1
.notActivated
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

parallaxRasterPos dc.w $0000

RASTERFUNC SUBROUTINE
	lda parallaxRasterPos + 0
	clc
parallaxRasterSpeed = .
	adc #$00
	sta parallaxRasterPos + 0

	lda parallaxRasterPos + 1
	adc #$00 ; never above 255
	sta parallaxRasterPos + 1

	lda startGradientPosIntern + 0
	sbc parallaxRasterPos + 0
	sta startGradientPosIntern2 + 0

	lda startGradientPosIntern + 1
	sbc parallaxRasterPos + 1
	and #$01
	sta startGradientPosIntern2 + 1

	rts

CLEARFUNC SUBROUTINE
	rts

PAINTFUNC SUBROUTINE
	rts

EXPLOGRAVITY = $68
EXPLOIMPULS	= $03
EXPLOLIVETIME = $20
