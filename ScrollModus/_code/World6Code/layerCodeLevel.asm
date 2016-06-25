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


RASTERFUNC SUBROUTINE
	rts

DOTCOUNT = $10
DOTPOSX		incbin "rand160tablelinear.bin"
DOTPOSY		incbin "rand200tablelinear.bin"
DOTPOSLOOLD	ds.b DOTCOUNT*2,0
DOTPOSHIOLD	ds.b DOTCOUNT*2,0
DOTOLD		ds.b DOTCOUNT*2,0
DOTBUFFEREND   dc.b $00
DOTBUFFERSTART dc.b $00
DOTXADD		   dc.b $00
DOTYADD		   dc.b $00
DOTLASTSCROLLY dc.b $00
DOTLASTSCROLLX dc.b $00
DOTLASTFRAMECOUNT dc.b $00
DOTCOLTAB
Y SET 0
	REPEAT 4
	dc.b 3<<[6-Y*2]
Y SET Y + 1
	REPEND
DOTGUARDBANDX = $08
DOTGUARDBANDY = $10

CLEARFUNC SUBROUTINE
	lda #$00
	sta DOTBUFFERSTART
	lda #DOTCOUNT
	sta DOTBUFFEREND
	
	lda doubleBuffer
	beq .noyinc
	lda #DOTCOUNT
	sta DOTBUFFERSTART
	lda #DOTCOUNT*2
	sta DOTBUFFEREND
.noyinc

	; clear dots
	ldx DOTBUFFEREND
	dex
.nextdotclear
	ldy DOTPOSLOOLD,x
	lda DOTPOSHIOLD,x
	beq .notclear
	sta .clear + 2	
	lda #$00 ; clear only once
	sta DOTPOSHIOLD,x
	lda DOTOLD,x
.clear
	sta $4400,y
.notclear
	dex
	cpx DOTBUFFERSTART
	bpl .nextdotclear
	rts

PAINTFUNC SUBROUTINE

	lda scrollPosYCurrent
	sec
	sbc DOTLASTSCROLLY
	sta DOTYADD
	asl
	ror DOTYADD
	lda DOTYADD
	asl
	ror DOTYADD
	lda DOTYADD
	asl
	asl
	clc
	adc DOTLASTSCROLLY
	sta DOTLASTSCROLLY
	
	lda scrollPosXCurrent
	sec
	sbc DOTLASTSCROLLX
	sta DOTXADD
	asl
	ror DOTXADD
	lda DOTXADD
	asl
	ror DOTXADD
	lda DOTXADD
	asl
	asl
	clc
	adc DOTLASTSCROLLX
	sta DOTLASTSCROLLX

	lda scrollPosXCurrent
	sta DOTLASTSCROLLX

;	lda frameCounter
;	sta DOTLASTFRAMECOUNT

	; animate
	ldx #$00
.nextdotanim

	lda DOTPOSY,x
	sec
	sbc DOTYADD
	cmp #DOTGUARDBANDY
	bcs .notyclip1
	clc
	adc #200-DOTGUARDBANDY*2
.notyclip1
	cmp #200-DOTGUARDBANDY
	bcc .notyclip2
	sec
	sbc #200-DOTGUARDBANDY * 2
.notyclip2
	sta DOTPOSY,x
	txa
	lda DOTPOSX,x
	sec
	sbc DOTXADD
	cmp #DOTGUARDBANDX
	bcs .notxclip1
	clc
	adc #160-DOTGUARDBANDX*2
.notxclip1
	cmp #160-DOTGUARDBANDX
	bcc .notxclip2
	sec
	sbc #160-DOTGUARDBANDX*2
.notxclip2
	sta DOTPOSX,x
	inx
	cpx #DOTCOUNT
	bne .nextdotanim


	lda scrollFineX
	lsr
	sta .xadd + 1

	lda scrollFineY
	sta .yadd + 1

	ldx #$00
.nextdot
	lda DOTPOSX,x
	sec
.xadd
	sbc #$44
	pha
	and #$03
	tay
	lda DOTCOLTAB,y
	sta .xcol3 + 1
	sta .xcol4 + 1
	pla
	lsr
	lsr
	clc
	adc scrollPosXDiv4
	sta .8 + 1
	sta .82 + 1
	lda DOTPOSY,x
	sec
.yadd
	sbc #$44
	pha
	lsr
	lsr
	lsr
	clc
	adc scrollPosYDiv8
	tay
	pla
	and #$07
	ora MUL320LO,y
	stx .x + 1
.8
	ldx #$44
	clc
	adc MUL8LO,x

	ldx DOTBUFFERSTART
	
	sta DOTPOSLOOLD,x
	sta ZP_BYTE + 0
	
	lda #$00
	adc MUL320HI,y
.82
	ldy #$44
	adc MUL8HI,y
	and #$1f
	ora lastBitmapHigh
	
	sta DOTPOSHIOLD,x
	sta ZP_BYTE + 1

	ldy #$00
	lda (ZP_BYTE),y
	sta DOTOLD,x 
	tax
.xcol3
	and #$44
	bne .notzero
	txa
.xcol4
	ora #$44
	sta (ZP_BYTE),y
.notzero
	inc DOTBUFFERSTART
.x
	ldx #$44
	inx
	cpx #DOTCOUNT
	bne .nextdot
	
	; dotbufferstart is off now

	rts

EXPLOGRAVITY = $68
EXPLOIMPULS	= $03
EXPLOLIVETIME = $20

