EDOTCOUNT			= $08 
EDOTPOSX			ds.b EDOTCOUNT,0
EDOTPOSY			ds.b EDOTCOUNT,0
EDOTPOSXLO			ds.b EDOTCOUNT,0
EDOTPOSYLO			ds.b EDOTCOUNT,0

EDOTADDX			ds.b EDOTCOUNT,0
EDOTADDY			ds.b EDOTCOUNT,0
EDOTADDXLO			ds.b EDOTCOUNT,0
EDOTADDYLO			ds.b EDOTCOUNT,0

EDOTLIVECOUNT		ds.b EDOTCOUNT,0

EDOTPOSLOOLD		ds.b EDOTCOUNT*2,0
EDOTPOSHIOLD		ds.b EDOTCOUNT*2,0
EDOTOLD				ds.b EDOTCOUNT*2,0

EDOTBUFFEREND		dc.b $00
EDOTBUFFERSTART		dc.b $00
EDOTXADD			dc.b $00
EDOTYADD			dc.b $00
EDOTLASTSCROLLY		dc.b $00
EDOTLASTSCROLLX		dc.b $00
EDOTSACTIVE			dc.b $00
EDOTLASTFRAMECOUNT	dc.b $00
EDOTTEMP			dc.b $00

EDOTCOLTAB
Y SET 0
	REPEAT 4
	dc.b [2+[Y & 1]]<<[6-Y*2]
Y SET Y + 1
	REPEND

EDOTSLIVETIMERANDOMAND = $0f*$00

EDOTGUARDBANDX = $08
EDOTGUARDBANDY = $10

ECLEARFUNC SUBROUTINE
	lda EDOTSACTIVE
	beq .rts

	lda #$00
	sta EDOTBUFFERSTART
	lda #EDOTCOUNT
	sta EDOTBUFFEREND
	
	lda doubleBuffer
	beq .noyinc
	lda #EDOTCOUNT
	sta EDOTBUFFERSTART
	lda #EDOTCOUNT*2
	sta EDOTBUFFEREND
.noyinc

	; clear dots
	ldx EDOTBUFFEREND
	dex
.nextdotclear
	ldy EDOTPOSLOOLD,x
	lda EDOTPOSHIOLD,x
	beq .notclear
	sta .clear + 2	
	lda #$00 ; clear only once
	sta EDOTPOSHIOLD,x
	lda EDOTOLD,x
.clear
	sta $4400,y
.notclear
	dex
	cpx EDOTBUFFERSTART
	bpl .nextdotclear
.rts
	rts

EPAINTFUNC SUBROUTINE

	lda scrollPosXCurrent
	sec
	sbc EDOTLASTSCROLLX
	sta EDOTXADD

	lda scrollPosXCurrent
	sta EDOTLASTSCROLLX

	lda scrollPosYCurrent
	sec
	sbc EDOTLASTSCROLLY
	sta EDOTYADD

	lda scrollPosYCurrent
	sta EDOTLASTSCROLLY

	lda EDOTSACTIVE
	cmp #$02 ; die particel können schön eher fertig sein, da es frameraten schwankungen gibt.
	bcs .do
	rts
.do
	dec EDOTSACTIVE

	lda frameCounter
	sec
	sbc EDOTLASTFRAMECOUNT
	lsr
	cmp #$06
	bcc .notbigger
	lda #$05
.notbigger
	sta EDOTTEMP

	lda frameCounter
	sta EDOTLASTFRAMECOUNT

	lda EDOTTEMP
	beq .noanim

.animreloop
	; animate
	ldx #$00
.nextdotanim
	lda EDOTLIVECOUNT,x
	beq .notanimate

	lda EDOTPOSYLO,x
	clc
	adc EDOTADDYLO,x
	sta EDOTPOSYLO,x
	lda EDOTPOSY,x
	adc EDOTADDY,x
	sec
	sbc EDOTYADD
	cmp #EDOTGUARDBANDY
	bcs .notyclip1
.dotoutsidescreen
	lda #$00
	sta EDOTLIVECOUNT,x
	jmp .notanimate
.notyclip1
	cmp #200-EDOTGUARDBANDY
	bcc .notyclip2
	jmp .dotoutsidescreen
.notyclip2
	sta EDOTPOSY,x

	lda EDOTPOSXLO,x
	clc
	adc EDOTADDXLO,x
	sta EDOTPOSXLO,x
	lda EDOTPOSX,x
	adc EDOTADDX,x
	sec
	sbc EDOTXADD
	cmp #EDOTGUARDBANDX
	bcs .notxclip1
	jmp .dotoutsidescreen
.notxclip1
	cmp #160-EDOTGUARDBANDX
	bcc .notxclip2
	jmp .dotoutsidescreen
.notxclip2
	sta EDOTPOSX,x

	lda EDOTADDYLO,x
	clc 
	adc explogravity + 0
	sta EDOTADDYLO,x
	lda EDOTADDY,x
	adc #$00
	sta EDOTADDY,x

	dec EDOTLIVECOUNT,x
.notanimate
	inx
	cpx #EDOTCOUNT
	bne .nextdotanim

	lda #$00
	sta EDOTXADD
	sta EDOTYADD
	
	dec EDOTTEMP
	bne .animreloop

.noanim

	; paint

	lda scrollFineX
	lsr
	sta .xadd + 1

	lda scrollFineY
	sta .yadd + 1

	ldx #$00
.nextdot
	lda EDOTLIVECOUNT,x
	beq .notpaint
	lda EDOTPOSX,x
	sec
.xadd
	sbc #$44
	pha
	and #$03
	tay
	lda EDOTCOLTAB,y
	sta .xcol4 + 1
	pla
	lsr
	lsr
	clc
	adc scrollPosXDiv4
	sta .8 + 1
	sta .82 + 1
	lda EDOTPOSY,x
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

	ldx EDOTBUFFERSTART
	
	sta EDOTPOSLOOLD,x
	sta ZP_BYTE + 0

	lda #$00
	adc MUL320HI,y
.82
	ldy #$44
	adc MUL8HI,y
	and #$1f
	ora lastBitmapHigh
	
	sta EDOTPOSHIOLD,x
	sta ZP_BYTE + 1

	ldy #$00
	lda (ZP_BYTE),y
	sta EDOTOLD,x 
.xcol4
	ora #$44
	sta (ZP_BYTE),y
	inc EDOTBUFFERSTART
.x
	ldx #$44
.notpaint
	inx
	cpx #EDOTCOUNT
	bne .nextdot
	
	; dotbufferstart is off now

	rts

addExplosionForGameObject SUBROUTINE
	sta .arestore + 1
	stx .xrestore + 1
	sty .yrestore + 1

	; spritePX,PY is used here for convenience
	jsr spritePXPYExplosion
	
	lda spritePX + 1
	ora spritePY + 1
	bne .notInScreen

	lda GameObjectXStart,y
	clc
	adc GameObjectXEnd,y
	lsr
	clc
	adc spritePX + 0
	sta spritePX + 0

	lda GameObjectYStart,y
	clc
	adc GameObjectYEnd,y
	lsr
	clc
	adc spritePY + 0
	sta spritePY + 0

	lda spritePX + 0
	adc spritePY + 0
	tay

	ldx #EDOTCOUNT - 1
.nextx
	jsr eAddRandom

	iny

	dex
	bpl .nextx

	lda explolivetime
	clc
	adc #EDOTSLIVETIMERANDOMAND
	sta EDOTSACTIVE
		
.notInScreen
.yrestore
	ldy #$44
.xrestore
	ldx #$44
.arestore
	lda #$44
	rts

counter8 dc.b $00
eAddLazerParticlesY SUBROUTINE
	lda GameObjectActiveCounter,y
	and #$01
	bne .rts

	lda counter8
	clc
	adc #$01
	and #$07
	sta counter8
	tax 

	jsr spritePXPYExplosion
	lda spritePX + 1
	ora spritePY + 1
	beq .inScreen
.rts
	rts
.inScreen

	lda spritePY + 0
	clc
	adc #$10
	sta spritePY + 0
	adc spritePX + 0
	tay

	lda explolivetime
	sta EDOTSACTIVE ; guard time

	jmp someBytesLeft1


eAddRandom SUBROUTINE
	lda spritePX + 0
	sta EDOTPOSX,x
	lda spritePY + 0
	sta EDOTPOSY,x

	lda MAINPRG+10,y
	and #EDOTSLIVETIMERANDOMAND
	clc
	adc explolivetime
	sta EDOTLIVECOUNT,x

	lda MAINPRG,y
	sta EDOTADDYLO,x
	sta EDOTADDXLO,x

	lda MAINPRG+10,y
	and #$03
	clc 
	adc exploimpuls
	eor #$ff
	sta EDOTADDY,x

	lda MAINPRG+20,y
	and #$01
	sec
	sbc #$01
	sta EDOTADDX,x
	rts

spritePXPYExplosion SUBROUTINE
	lda GameObjectXPosLo,y
	sec
	sbc scrollPosXCurrent + 0
	sta spritePX + 0
	lda GameObjectXPosHi,y
	sbc scrollPosXCurrent + 1
	sta spritePX + 1

	lda GameObjectYPosLo,y
	sec
	sbc scrollPosYCurrent + 0
	sta spritePY + 0
	lda GameObjectYPosHi,y
	sbc scrollPosYCurrent + 1
	sta spritePY + 1
	rts
