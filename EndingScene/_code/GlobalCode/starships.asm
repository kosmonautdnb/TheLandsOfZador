	processor 6502
	include "fw_interface.asm"
	include "scenesetup.inc"
	include "standard.asm"
	include "macros.asm"
	include "persistent.asm"

SCREEN8 = $6000

	ORG ENDSHIPSADR
	jmp displayEndscene

ZP_STARS = $10 ; 2 * 6

frameCounter  dc.w $00
frameCounter2 dc.w $00

shipsCharset 
	incbin "shipsCharset.bin"
clearChar = (. - shipsCharset) / 8
	ds.b $08,$ff
firstStarChar = (. - shipsCharset) / 8
	incbin "starCharset.bin"
finFirstChar = (. - shipsCharset) / 8
	incbin "finCharset.bin"

finScreen
	incbin "finScreen0000.bin"


bigship0	incbin "bigship0.scr"
bigship1	incbin "bigship1.scr"
bigship2	incbin "bigship2.scr"
bigship3	incbin "bigship3.scr"
bigship4	incbin "bigship4.scr"
bigship5	incbin "bigship5.scr"

smallship0	incbin "smallship0.scr"
smallship1	incbin "smallship1.scr"
smallship2	incbin "smallship2.scr"
smallship3	incbin "smallship3.scr"
smallship4	incbin "smallship4.scr"
smallship5	incbin "smallship5.scr"

bigships
	dc.w bigship0
	dc.w bigship1
	dc.w bigship2
	dc.w bigship3
	dc.w bigship4
	dc.w bigship5

smallships
	dc.w smallship0
	dc.w smallship1
	dc.w smallship2
	dc.w smallship3
	dc.w smallship4
	dc.w smallship5

WAIT = $178

fadeinstars   dc.b 40
fadeinship   dc.w $68
fadeoutship   dc.w $00
shipspos	  dc.w $00
stayInCounter dc.w $400+WAIT
fldFadeOutCounter dc.w $440+WAIT
fadeOutCounter dc.w $480+WAIT
quitFlag dc.b $08 ; 8 luminance steps
speedIncrease dc.b $00

	MAC FF13ENTER
	lda $ff13
	pha
	and #%11111101
	sta $ff13
	ENDM

	MAC FF13LEAVE
	pla
	sta $ff13
	ENDM


fileName
	dc.b "LS",0

displayEndscene SUBROUTINE
	lda #$71
	sta $ff15
	lda #$25
	sta $ff16
	lda #$65
	sta $ff17

	ldy #$04
	ldx #$00
.next
	lda #$00 + $08
.write1
	sta SCREEN8,x
	lda #clearChar
.write2
	sta SCREEN8 + $400,x
	inx
	bne .next
	inc .write1 + 2 
	inc .write2 + 2 
	dey
	bne .next

	ldy #$08
	ldx #$00
.next2
	lda shipsCharset,x
	sta $2000,x
	inx
	bne .next2
	inc .next2 + 2
	inc .next2 + 2 + 3
	dey
	bne .next2

	ldx #$00
.nextx
	lda finScreen,x
	clc
	adc #finFirstChar
	sta SCREEN8 + $400 + 22 * 40,x
	lda #$00
	sta SCREEN8 + 22 * 40,x
	inx
	cpx #3 * 40
	bne .nextx

	lda $ff07
	and #%11110111
	sta $ff07

	jsr animate ; initial

	lda #$00
	sta frameCounter

	sei
	lda #<raster_plugin
	sta fw_topirq_plugin + 0
	lda #>raster_plugin
	sta fw_topirq_plugin + 1
	cli

	jsr waitFrame

.wait
	lda quitFlag
	bne .wait

	sei
	lda #$00
	sta fw_topirq_plugin + 0
	sta fw_topirq_plugin + 1
	cli
	jsr waitFrame
	jsr waitFrame

	ldx #<fileName
	ldy #>fileName
	LOAD_NORMAL
	ldx fw_load_end + 0
	ldy fw_load_end + 1
	jsr fw_decrunch

	lda #LEVELSTATUS_GAMEOVER
	sta ZP_LEVELSTATUS

	jsr songoff

	jmp ENTRYPOINT_LOADINGSCREEN

	include "player_clear2.asm"

waitFrame SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
.waita
	bit $ff1c
	bne .waita
	rts

raster_plugin SUBROUTINE 
	lda #<rasterIrqTop 
	sta $fffe 
	lda #>rasterIrqTop
	sta $ffff 
	lda #2  ;raster irq 
	sta $ff0a 
	lda #$00 ; rasterline 
	sta $ff0b
	PLUGIN_CANCELDEFAULT 
	rts 


rasterIrqTop SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	FF13ENTER
	lda $ff07
	and #%11111000
	ora bigshipxAnd7
	sta $ff07

	ldx bigshipx
	lda bigshipframe
	jsr blitbigship

	ldx bigshipx
	lda bigshipframe
	jsr blitbigshipstrahl

	ldx smallshipx
	lda smallshipframe
	jsr blitsmallship

	ldx smallshipx
	lda smallshipframe
	jsr blitsmallshipstrahl

	lda #<rasterIrqMiddle1
	sta $fffe 
	lda #>rasterIrqMiddle1
	sta $ffff 
	lda #SMALLSHIPYPOS*8-2 ; rasterline 
	sta $ff0b

	FF13LEAVE
	inc $ff09
	pla
	tay
	pla
	tay
	pla
	rti

rasterIrqMiddle1 SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	FF13ENTER
	
	lda $ff07
	and #%11111000
	ora smallshipxAnd7
.wait
	ldx $ff1e
	bpl .wait	
	sta $ff07

	lda #<rasterIrqBelow
	sta $fffe 
	lda #>rasterIrqBelow
	sta $ffff 
	lda #SMALLSHIPYPOS*8; rasterline 
	sta $ff0b

	FF13LEAVE
	inc $ff09
	pla
	tay
	pla
	tay
	pla
	rti

screenYAnd7FLD dc.b $00
fldDistance dc.b $15

rasterIrqBelow SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	FF13ENTER

	jsr animate

	lda frameCounter
	asl
	tax
	lda sin1,x
	lsr
	lsr
	lsr
	lsr
	lsr
	and #$07
	sta screenYAnd7

	jsr reblitstars

	lda #<rasterIrqScrolly
	sta $fffe 
	lda #>rasterIrqScrolly
	sta $ffff 
	lda screenYAnd7
	eor #$07
	clc
	adc #20*8+1; rasterline 
	sta $ff0b
	lda screenYAnd7FLD
	eor #$07
	clc
	adc #$01
	clc
	adc fldDistance
	sta waitRasterlines

	FF13LEAVE
	inc $ff09
	pla
	tay
	pla
	tay
	pla
	rti
waitRasterlines dc.b $00
rasterIrqScrolly SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	FF13ENTER

	ldx waitRasterlines
	lda $ff1d
.wait3
	cmp $ff1d
	beq .wait3
.3
	lda $ff06
	clc
	adc #$01
	and #%11110111
	sta $ff06
	dec $ff1f
	lda $ff1d
.wait2
	cmp $ff1d
	beq .wait2
	dex
	bne .3


	lda $ff07
	and #%11111000
	sta $ff07

	lda #<rasterIrqBorder
	sta $fffe 
	lda #>rasterIrqBorder
	sta $ffff 
	lda #200; rasterline 
	sta $ff0b

	FF13LEAVE
	inc $ff09
	pla
	tay
	pla
	tay
	pla
	rti

screenYAnd7 dc.b $00
rasterIrqBorder SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	FF13ENTER
	
	; enable screen and scroll
	lda #%00010000
	ora screenYAnd7
	sta $ff06
	lda screenYAnd7
	sta screenYAnd7FLD

	jsr fw_lowirq_install
	lda frameCounter 
	and #$01
	bne .oha
	inc frameCounter2
.oha

	inc frameCounter + 0
	bne .nothi
	inc frameCounter + 1
.nothi
	FF13LEAVE
	inc $ff09
	pla
	tay
	pla
	tay
	pla
	rti

bigshipx dc.b $12
bigshipxAnd7 dc.b $00
bigshipframe dc.b 0
BIGSHIPYPOS = 4
BIGSHIPXSIZE = 9
BIGSHIPYSIZE = 4
blitbigship SUBROUTINE
	asl
	tay
	lda bigships + 0,y
	sta ZP_STARS + 0
	lda bigships + 1,y
	sta ZP_STARS + 1

	ldy #$00
.nextprep
	lda ZP_STARS + 0,y
	clc
	adc #<BIGSHIPXSIZE
	sta ZP_STARS + 2,y
	lda ZP_STARS + 0+1,y
	adc #>BIGSHIPXSIZE
	sta ZP_STARS + 2+1,y
	iny
	iny
	cpy #BIGSHIPYSIZE * 2
	bne .nextprep


	ldy #$00
.next
	cpx #$00
	bmi .dontdraw1
	cpx #40
	bpl .dontdraw1
Y SET 0
	REPEAT BIGSHIPYSIZE
	lda (ZP_STARS + Y * 2),y
	sta SCREEN8 + $400 + [BIGSHIPYPOS + Y] * 40,x
Y SET Y + 1
	REPEND
.dontdraw1
	iny
	inx
	cpy #BIGSHIPXSIZE
	bne .next
	cpx #$00
	bmi .dontdraw2
	lda #clearChar
Y SET 0
	REPEAT BIGSHIPYSIZE
	sta SCREEN8 + $400 + [BIGSHIPYPOS + Y] * 40,x
Y SET Y + 1
	REPEND
.dontdraw2
	rts

blitbigshipstrahl SUBROUTINE
	dex
	bpl .notrts
	rts
.notrts
	cpx #39
	bmi .ok
	ldx #39
.ok
	asl
	tay
	lda bigships + 0,y
	sta .read1 + 1
	sta .read2 + 1
	lda bigships + 1,y
	sta .read1 + 2
	sta .read2 + 2

	ldy #BIGSHIPXSIZE * 1
.read1	
	lda $4444,y
	sta .lda1 + 1
	ldy #BIGSHIPXSIZE * 2
.read2	
	lda $4444,y
	sta .lda2 + 1

.yo
.lda1
	lda #$44
	sta SCREEN8 + $400 + 40 * [BIGSHIPYPOS+1],x
.lda2
	lda #$44
	sta SCREEN8 + $400 + 40 * [BIGSHIPYPOS+2],x
	dex
	bpl .yo

	rts

smallshipx dc.b $8
smallshipxAnd7 dc.b $8
smallshipframe dc.b 0
SMALLSHIPYPOS = 12
SMALLSHIPXSIZE = 6
SMALLSHIPYSIZE = 2
blitsmallship SUBROUTINE
	asl
	tay
	lda smallships + 0,y
	sta ZP_STARS + 0
	lda smallships + 1,y
	sta ZP_STARS + 1

	ldy #$00
.nextprep
	lda ZP_STARS + 0,y
	clc
	adc #<SMALLSHIPXSIZE
	sta ZP_STARS + 2,y
	lda ZP_STARS + 0+1,y
	adc #>SMALLSHIPXSIZE
	sta ZP_STARS + 2+1,y
	iny
	iny
	cpy #SMALLSHIPYSIZE * 2
	bne .nextprep


	ldy #$00
.next
	cpx #$00
	bmi .dontdraw1
	cpx #40
	bpl .dontdraw1
Y SET 0
	REPEAT SMALLSHIPYSIZE
	lda (ZP_STARS + Y * 2),y
	sta SCREEN8 + $400 + [SMALLSHIPYPOS + Y] * 40,x
Y SET Y + 1
	REPEND
.dontdraw1
	iny
	inx
	cpy #SMALLSHIPXSIZE
	bne .next
	cpx #$00
	bmi .dontdraw2
	lda #clearChar
Y SET 0
	REPEAT SMALLSHIPYSIZE
	sta SCREEN8 + $400 + [SMALLSHIPYPOS + Y] * 40,x
Y SET Y + 1
	REPEND
.dontdraw2
	rts

blitsmallshipstrahl SUBROUTINE
	dex
	bpl .notrts
	rts
.notrts
	cpx #39
	bmi .ok
	ldx #39
.ok
	asl
	tay
	lda smallships + 0,y
	sta .read1 + 1
	sta .read2 + 1
	lda smallships + 1,y
	sta .read1 + 2
	sta .read2 + 2

	ldy #SMALLSHIPXSIZE * 0
.read1	
	lda $4444,y
	sta .lda1 + 1
	ldy #SMALLSHIPXSIZE * 1
.read2	
	lda $4444,y
	sta .lda2 + 1

.yo
.lda1
	lda #$44
	sta SCREEN8 + $400 + 40 * [SMALLSHIPYPOS+0],x
.lda2
	lda #$44
	sta SCREEN8 + $400 + 40 * [SMALLSHIPYPOS+1],x
	dex
	bpl .yo

	rts

	MAC DEC16
	lda {1} + 0
	sec
	sbc #<$01
	sta {1} + 0
	lda {1} + 1
	sbc #>$01
	sta {1} + 1
	ENDM

	MAC ADD16I
	lda {1} + 0
	clc
	adc #<{2}
	sta {1} + 0
	lda {1} + 1
	adc #>{2}
	sta {1} + 1
	ENDM

	MAC ADD16B1
	lda {1} + 0
	clc
	adc {2}
	sta {1} + 0
	lda {1} + 1
	adc #$00
	sta {1} + 1
	ENDM

tempa dc.b $00

animate SUBROUTINE

	lda stayInCounter + 1
	ora stayInCounter + 1
	beq .fadeoutships
	DEC16 stayInCounter
	jmp .dontfadeoutships
.fadeoutships
	lda speedIncrease
	lsr
	lsr
	lsr
	clc
	adc #$02
	cmp #$07
	bcc .a
	lda #$07
.a
	sta tempa
	ADD16B1 fadeoutship,tempa
	inc speedIncrease
.dontfadeoutships

	lda fadeOutCounter + 1
	ora fadeOutCounter + 1
	beq .fadeoutcolors
	DEC16 fadeOutCounter
	jmp .dontfadeoutcolors
.fadeoutcolors
	lda frameCounter
	and #$03
	bne .dontfadeoutcolors
	lda $ff15
	and #$7f
	sec
	sbc #$10
	bpl .notblack1
	lda #$00
.notblack1
	sta $ff15
	lda $ff16
	and #$7f
	sec
	sbc #$10
	bpl .notblack2
	lda #$00
.notblack2
	sta $ff16
	lda $ff17
	and #$7f
	sec
	sbc #$10
	bpl .notblack3
	lda #$00
.notblack3
	sta $ff17
	lda quitFlag
	beq .dontfadeoutcolors
	dec quitFlag
.dontfadeoutcolors


	lda fldFadeOutCounter + 1
	ora fldFadeOutCounter + 1
	beq .fadeoutfld
	DEC16 fldFadeOutCounter
	lda frameCounter
	and #$03
	bne .notflddecrease
	lda fadeinship
	bne .notflddecrease
	lda fldDistance
	beq .notflddecrease
	dec fldDistance
.notflddecrease
	jmp .dontfadeoutfldcolors
.fadeoutfld
	lda frameCounter
	and #$03
	bne .dontfadeoutfldcolors
	lda fldDistance
	clc
	adc #$01
	cmp #$10
	bmi .yo
	lda #$10
.yo 
	sta fldDistance
.dontfadeoutfldcolors


	lda fadeinship + 0
	ora fadeinship + 1
	beq .notdecfadeinships
	DEC16 fadeinship
.notdecfadeinships



	lda frameCounter
	and #$03
	bne .notincbigframe
	lda bigshipframe
	clc 
	adc #$01
	cmp #$06
	bne .notoverbig
	lda #$00
.notoverbig
	sta bigshipframe
.notincbigframe

	lda frameCounter
	and #$03
	bne .notincsmallframe
	lda smallshipframe
	clc 
	adc #$01
	cmp #$06
	bne .notoversmall
	lda #$00
.notoversmall
	sta smallshipframe
.notincsmallframe

	;--------------------------------------------------------------
	; bigship movement
	;--------------------------------------------------------------
	lda fadeoutship + 0
	sec
	sbc fadeinship + 0
	sta shipspos + 0
	lda fadeoutship + 1
	sbc fadeinship + 1
	sta shipspos + 1

	lda frameCounter2
	tax
	ldy #$00
	lda sin1,x
	bpl .notneg
	ldy #$ff
.notneg
	clc
	adc shipspos + 0
	sta shipspos + 0
	tya
	adc shipspos + 1
	sta shipspos + 1

	lda shipspos + 0
	and #$07
	sta bigshipxAnd7
	lda shipspos + 0
	lsr
	lsr
	lsr
	sta bigshipx
	lda shipspos + 1
	asl
	asl
	asl
	asl
	asl
	ora bigshipx
	sta bigshipx

	;--------------------------------------------------------------
	; smallship movement
	;--------------------------------------------------------------
	lda fadeoutship + 0
	sec
	sbc fadeinship + 0
	sta shipspos + 0
	lda fadeoutship + 1
	sbc fadeinship + 1
	sta shipspos + 1

	lda frameCounter2
	clc 
	adc #$30
	tax
	ldy #$00
	lda sin2,x
	bpl .notnegsmall
	ldy #$ff
.notnegsmall
	clc
	adc shipspos + 0
	sta shipspos + 0
	tya
	adc shipspos + 1
	sta shipspos + 1

	lda shipspos + 0
	and #$07
	sta smallshipxAnd7
	lda shipspos + 0
	lsr
	lsr
	lsr
	sta smallshipx
	lda shipspos + 1
	asl
	asl
	asl
	asl
	asl
	ora smallshipx
	sta smallshipx
	
	lda frameCounter
	and #$03
	bne .notfadeinstars
	lda fadeinstars
	beq .notfadeinstars
	dec fadeinstars
.notfadeinstars
	rts

sin1
	incbin "sin1.bin"
sin2
	incbin "sin2.bin"

	include "starstuff.inc"

firstStarCharWithY dc.b $00
xvalstars1 dc.b $00
xvalstars2 dc.b $00

reblitstars SUBROUTINE

	lda screenYAnd7
	eor #$07
	asl
	asl
	asl
	clc
	adc #firstStarChar
	sta	firstStarCharWithY
	
	lda bigshipxAnd7
	eor #$07
	asl
	asl
	asl
	asl
	asl
	sta xvalstars1
	lda smallshipxAnd7
	eor #$07
	asl
	asl
	asl
	asl
	asl
	sta xvalstars2

	lda #<[SCREEN8 + $400]
	sta ZP_STARS + 0
	lda #>[SCREEN8 + $400]
	sta ZP_STARS + 1

	ldx #$00
.nextstar
	ldy STARXDISP,x
	lda (ZP_STARS),y
	cmp #clearChar
	bcc .thereissomethingotherthanstars
	lda #clearChar
	sta (ZP_STARS),y
.thereissomethingotherthanstars
	lda STARXLO,x
	sec
	sbc STARXLOSUB,x
	sta STARXLO,x
	lda STARXHI,x
	sbc STARXHISUB,x
	bpl .ok
	lda #39
.ok
	sta STARXHI,x
	lda STARXLO,x
	clc
	adc xvalstars1
	sta .starxp + 1
	lda STARXHI,x
	adc #$00
	sta STARXDISP,x
	tay
	lda (ZP_STARS),y
	cmp #clearChar
	bcc .thereissomethingotherthanstars2
	cpy fadeinstars
	bcc .thereissomethingotherthanstars2
.starxp
	lda #$44
	lsr
	lsr
	lsr
	lsr
	lsr
	clc
	adc firstStarCharWithY
	sta (ZP_STARS),y
.thereissomethingotherthanstars2
	lda ZP_STARS + 0
	clc
	adc #<40
	sta ZP_STARS + 0
	lda ZP_STARS + 1
	adc #>40
	sta ZP_STARS + 1
	cmp #>[SCREEN8 + $800]-1
	bcs .ready
	lda ZP_STARS + 0
	cmp #<[SMALLSHIPYPOS * 40]
	bne .yo
	lda xvalstars2
	sta xvalstars1
.yo
	inx
	jmp .nextstar
.ready

	rts
