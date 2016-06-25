scrollPosXDesired dc.w $0000
scrollPosYDesired dc.w $0000
scrollPosXCurrent dc.w $0000
scrollPosYCurrent dc.w $0000
scrollPosXDiv4 dc.w $0000
scrollPosYDiv8 dc.w $0000

FF07SET = %10010000
FF06SET = %00110000

ff06value dc.b $00
ff07value dc.b $00
ff14value dc.b $18

currentScreenBuffer1 dc.w SCREENBUFFER1
currentScreenBuffer2 dc.w SCREENBUFFER2

currentHardScrollPosX dc.b $00
currentHardScrollPosY dc.b $00
hardscrollX dc.b $00
hardscrollY dc.b $00
wasHardScroll dc.b $00

lastBitmapHigh	dc.b >$2000
curBitmapHigh	dc.b >$4000

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
;--- updateScrollValues                                                            --
;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------
scrollLo dc.b $00
scrollHi dc.b $00
scrollFineX dc.b $00
scrollFineY dc.b $00
SUBROUTINE
.temp dc.b $00
genScrollValues

	; should not be called around the 0th rasterline
	lda scrollPosXCurrent + 0
	eor #$ff
	asl
	and #$07
	sta scrollFineX

	lda scrollPosYCurrent + 0
	eor #$ff
	and #$07
	sta scrollFineY

	; xscrolling
	lda scrollPosXCurrent + 0
	lsr
	lsr
	sta scrollLo
	lda scrollPosXCurrent + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora scrollLo
	sta scrollLo
	lda scrollPosXCurrent + 1
	lsr
	lsr
	sta scrollHi

	; yscrolling (64tiles*4chars = 256 values)
	lda scrollPosYCurrent + 0
	lsr
	lsr
	lsr
	sta .temp
	lda scrollPosYCurrent + 1
	asl
	asl
	asl
	asl
	asl
	ora .temp
	tay
	lda MUL40LO,y
	clc
	adc scrollLo
	sta scrollLo 
	lda MUL40HI,y
	adc scrollHi
	and #$03
	sta scrollHi
	
	jsr genRasterValues
	rts

genRasterValues SUBROUTINE
	lda scrollPosYCurrent + 0
	sta startGradientPos + 0
	lda scrollPosYCurrent + 1
	sta startGradientPos + 1
	rts

setScrollValues SUBROUTINE
	lda scrollFineX
	ora #FF07SET
	sta ff07value

	lda scrollFineY
	ora #FF06SET
	sta ff06value

	lda scrollLo
	sta ff1bvalue

	lda scrollHi
	sta ff1avalue

	lda startGradientPos + 0
	sta startGradientPosIntern + 0
	sta startGradientPosIntern2 + 0
	lda startGradientPos + 1
	sta startGradientPosIntern + 1
	sta startGradientPosIntern2 + 1
	rts

	SUBROUTINE
.deltaX dc.w $0000
.deltaY dc.w $0000
.absX   dc.b $00
.tempX  dc.w $00
genCurrentScrollPos 
	lda scrollPosXDesired + 0
	sec
	sbc scrollPosXCurrent + 0
	sta .deltaX + 0
	lda scrollPosXDesired + 1
	sbc scrollPosXCurrent + 1
	sta .deltaX + 1

	lda scrollPosYDesired + 0
	sec
	sbc scrollPosYCurrent + 0
	sta .deltaY + 0
	lda scrollPosYDesired + 1
	sbc scrollPosYCurrent + 1
	sta .deltaY + 1

	lda .deltaX + 0
	ldx .deltaX + 1
	bpl .notinvx
	eor #$ff
	clc
	adc #$01
.notinvx
	cpx #$00
	beq .cool1
	cpx #$ff
	beq .cool1
	lda #$ff
.cool1
	sta .absX

	lda .deltaX + 1
	bmi .negx
	lda .deltaX + 1
	bne .x4
	lda .deltaX + 0
	cmp #$04
	bcc .xdone
.x4
	lda #<[$04]
	sta .deltaX + 0
	lda #>[$04]
	sta .deltaX + 1
	jmp .xdone
.negx
	lda .deltaX + 1
	cmp #$ff
	bne .x4neg
	lda .deltaX + 0
	cmp #<[-$04]
	bcs .xdone
.x4neg
	lda #<[-$04]
	sta .deltaX + 0
	lda #>[-$04]
	sta .deltaX + 1
.xdone

	lda .deltaY + 1
	bmi .negy
	lda .deltaY + 1
	bne .y8
	lda .deltaY + 0
	cmp #$08
	bcc .ydone
.y8
	lda #<[$08]
	sta .deltaY + 0
	lda #>[$08]
	sta .deltaY + 1
	jmp .ydone
.negy
	lda .deltaY + 1
	cmp #$ff
	bne .y8neg
	lda .deltaY + 0
	cmp #<[-$08]
	bcs .ydone
.y8neg
	lda #<[-$08]
	sta .deltaY + 0
	lda #>[-$08]
	sta .deltaY + 1
.ydone

	; the soft scrolling affects only x axis
	lda scrollPosXDesired + 1
	ror
	sta .tempX + 1
	lda scrollPosXDesired + 0
	ror
	sta .tempX + 0
	ror .tempX + 1
	ror .tempX + 0 ; div 4

	; the level borders
	lda .tempX + 0
	cmp #9
	bcc .notfinescroll
	cmp #40*4-40-9
	bcs .notfinescroll
	lda .absX
	cmp #40
	bcs .nothalvex1
	lda .deltaX + 1
	asl
	ror .deltaX + 1
	ror .deltaX + 0
.nothalvex1

	lda .absX
	cmp #20
	bcs .nothalvex2
	lda .deltaX + 1
	asl
	ror .deltaX + 1
	ror .deltaX + 0
.nothalvex2

	lda .absX
	cmp #5
	bcs .nothalvex3
	lda mainLoopCounter
	and #$01
	bne .nothalvex3
	lda .deltaX + 1
	asl
	ror .deltaX + 1
	ror .deltaX + 0
.nothalvex3
	
.notfinescroll

	lda scrollPosXCurrent + 0
	clc
	adc .deltaX + 0
	sta scrollPosXCurrent + 0
	lda scrollPosXCurrent + 1
	adc .deltaX + 1
	sta scrollPosXCurrent + 1

	lda scrollPosYCurrent + 0
	clc
	adc .deltaY + 0
	sta scrollPosYCurrent + 0
	lda scrollPosYCurrent + 1
	adc .deltaY + 1
	sta scrollPosYCurrent + 1

	rts

genScrollPosXDiv4YDiv8 SUBROUTINE

	lda scrollPosXCurrent + 0
	lsr
	lsr
	sta scrollPosXDiv4 + 0
	lda scrollPosXCurrent + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora scrollPosXDiv4 + 0
	sta scrollPosXDiv4 + 0
	lda scrollPosXCurrent + 1
	lsr
	lsr
	sta scrollPosXDiv4 + 1

	lda scrollPosYCurrent + 0
	lsr
	lsr
	lsr
	sta scrollPosYDiv8 + 0
	lda scrollPosYCurrent + 1
	asl
	asl
	asl
	asl
	asl
	ora scrollPosYDiv8 + 0
	sta scrollPosYDiv8 + 0
	lda scrollPosYCurrent + 1
	lsr
	lsr
	lsr
	sta scrollPosYDiv8 + 1

	rts

	SUBROUTINE
.temp1		 dc.b $00
.temp2		 dc.b $00
.readadd	 dc.w $0000
.nextHardScrollPosX dc.b $00
.nextHardScrollPosY dc.b $00
scroll
	; the scrollposx and scrollposy should be updated somewhere before calling this function

.wait
	lda updateDoubleBuffer
	bne .wait

	lda #$00
	sta wasHardScroll
	
	jsr genCurrentScrollPos

	jsr genScrollPosXDiv4YDiv8

	jsr genScrollValues

	lda scrollPosXDiv4 + 0
	sta .nextHardScrollPosX

	lda scrollPosYDiv8 + 0
	sta .nextHardScrollPosY

	lda .nextHardScrollPosX
	sec
	sbc currentHardScrollPosX
	sta hardscrollX

	lda .nextHardScrollPosY
	sec
	sbc currentHardScrollPosY
	sta hardscrollY

	lda hardscrollX
	ora hardscrollY
	bne .yeahHardScroll
	lda #$01
	jsr updateFrameAndSetScrollValues
	rts
.yeahHardScroll
	
	lda #$01
	sta wasHardScroll

	lda .nextHardScrollPosX
	sta currentHardScrollPosX
	lda .nextHardScrollPosY
	sta currentHardScrollPosY

	;-----------------------------------------------------------------
	;-- update hardscroll property variables
	;-----------------------------------------------------------------
	lda hardscrollY
	bpl .notnegY1
	eor #$ff
	clc
	adc #$01
.notnegY1
	tay
	lda MUL40LO,y
	sta .readadd + 0 
	lda MUL40HI,y
	sta .readadd + 1 
	lda hardscrollY
	bpl .notnegY2
	lda .readadd + 0 
	eor #$ff
	clc
	adc #$01
	sta .readadd + 0
	lda .readadd + 1
	eor #$ff
	adc #$00
	sta .readadd + 1
.notnegY2

	lda hardscrollX
	bpl .notnegX
	clc
	adc .readadd + 0
	sta .readadd + 0
	lda #$ff
	adc .readadd + 1
	sta .readadd + 1
	jmp .done1
.notnegX
	clc
	adc .readadd + 0
	sta .readadd + 0
	lda #$00
	adc .readadd + 1
	sta .readadd + 1
.done1

	;-----------------------------------------------------------------
	;-- update hardscroll speedcode
	;-----------------------------------------------------------------
	lda currentScreenBuffer1 + 0
	clc
	adc .readadd + 0
	sta hardscrollmodi1 + 1
	lda currentScreenBuffer1 + 1
	adc .readadd + 1
	sta hardscrollmodi1 + 2
	lda currentScreenBuffer2 + 0
	sta hardscrollmodi1 + 1 + 3
	lda currentScreenBuffer2 + 1
	sta hardscrollmodi1 + 2 + 3
	lda currentScreenBuffer1 + 0
	clc
	adc .readadd + 0
	sta hardscrollmodi2 + 1
	lda currentScreenBuffer1 + 1
	adc .readadd + 1
	clc
	adc #$04
	sta hardscrollmodi2 + 2
	lda currentScreenBuffer2 + 0
	sta hardscrollmodi2 + 1 + 3
	lda currentScreenBuffer2 + 1
	clc
	adc #$04
	sta hardscrollmodi2 + 2 + 3
	lda #>hardscrollmodi1
	sta .modi1_1 + 2 
	sta .modi1_2 + 2 
	sta .modi2_1 + 2 
	sta .modi2_2 + 2 
	lda #>hardscrollmodi2
	sta .modi3_1 + 2 
	sta .modi3_2 + 2 
	sta .modi4_1 + 2 
	sta .modi4_2 + 2 
	ldy #$06
	ldx #DISPLAYAREAROWS-1
	clc
.loop1

	lda hardscrollmodi1 + 1 - 6,y
	adc #<40
.modi1_1
	sta hardscrollmodi1 + 1,y

	lda hardscrollmodi1 + 2 - 6,y
	adc #>40
.modi1_2
	sta hardscrollmodi1 + 2,y

	lda hardscrollmodi1 + 1 - 6 + 3,y
	adc #<40
.modi2_1
	sta hardscrollmodi1 + 1 + 3,y

	lda hardscrollmodi1 + 2 - 6 + 3,y
	adc #>40
.modi2_2
	sta hardscrollmodi1 + 2 + 3,y

	lda hardscrollmodi2 + 1 - 6,y
	adc #<40
.modi3_1
	sta hardscrollmodi2 + 1,y

	lda hardscrollmodi2 + 2 - 6,y
	adc #>40
.modi3_2
	sta hardscrollmodi2 + 2,y

	lda hardscrollmodi2 + 1 - 6 + 3,y
	adc #<40
.modi4_1
	sta hardscrollmodi2 + 1 + 3,y

	lda hardscrollmodi2 + 2 - 6 + 3,y
	adc #>40
.modi4_2
	sta hardscrollmodi2 + 2 + 3,y

	tya
	adc #$06
	tay
	bcc .loop1do
	inc .modi1_1 + 2
	inc .modi1_2 + 2	
	inc .modi2_1 + 2
	inc .modi2_2 + 2	
	inc .modi3_1 + 2
	inc .modi3_2 + 2	
	inc .modi4_1 + 2
	inc .modi4_2 + 2	
	clc
.loop1do
	dex
	bne .loop1


	jsr hardScrollWholeColorRamAligned

	jsr hardScrollColorRamLeftRight
	jsr hardScrollColorRamUpDown
	;-----------------------------------------------------------------
	;-- flip screenbuffers hardscroll speedcode
	;-----------------------------------------------------------------
	jsr switchColorRamFrame

	;-----------------------------------------------------------------
	;-- set new frame ff14 value
	;-----------------------------------------------------------------
	lda #$02
	jsr updateFrameAndSetScrollValues

	rts

	SUBROUTINE
.scrollPosXIntern dc.w $0000
.scrollPosYIntern dc.w $0000
.xline			  dc.b $00
.xlinee			  dc.b $00
hardScrollColorRamLeftRight 


	lda #<[-LEFTRIGHTENEMYGUARD]
	sta .xlinee
	lda #$00
	ldx hardscrollX
	bne .docolleftright
	rts
.docolleftright
	cpx #$01
	bne .notleft
	lda #<[39+LEFTRIGHTENEMYGUARD]
	sta .xlinee
	lda #39
.notleft
	sta .xline

	lda scrollPosXDiv4 + 0
	clc
	adc .xline
	sta .scrollPosXIntern + 0
	lda scrollPosXDiv4 + 1
	adc #$00
	sta .scrollPosXIntern + 1
	lda scrollPosYDiv8 + 0
	sta .scrollPosYIntern + 0
	lda scrollPosYDiv8 + 1
	sta .scrollPosYIntern + 1

	lda scrollPosXDiv4 + 0
	clc
	adc .xlinee
	sta addEnemyLevelXPos
	lda scrollPosYDiv8 + 0
	sta addEnemyLevelYPos
	jsr addEnemyLevelX

	lda .scrollPosXIntern + 0
	and #$03
	asl
	asl
	sta .tilexand3shl2 + 1

	lda .scrollPosYIntern + 0
	and #$03
	sta .scrollposyaddand3 + 1

	lda .scrollPosYIntern + 0
	lsr ; / 4
	lsr
	sta .scrollposyadddiv4 + 1
	lda .scrollPosYIntern + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora .scrollposyadddiv4 + 1
	sta .scrollposyadddiv4 + 1

	ldy .scrollPosXIntern + 0

	lda DIV4MUL64TAB64MAPLO,y
	sta .tileread + 1
	lda DIV4MUL64TAB64MAPHI,y
	sta .tileread + 2

	lda currentScreenBuffer2 + 0
	clc
	adc .xline
	sta ZP_WRITE_LUMA  + 0
	sta ZP_WRITE_COLOR + 0
	lda currentScreenBuffer2 + 1
	adc #$00
	sta ZP_WRITE_LUMA  + 1
	clc
	adc #$04
	sta ZP_WRITE_COLOR + 1

	lda #>FONTLUMA
	sta ZP_READ_LUMA + 1
	lda #>FONTCOLOR
	sta ZP_READ_COLOR + 1

	clc
	ldx #$00
	jmp .entry
.reloop

	lda .readchar + 1
	adc #$01
	sta .readchar + 1
	and #%00000011
	bne .readchar
.entry
	txa
	clc
.scrollposyaddand3
	adc #$44
	tay
	and #$03
.tilexand3shl2
	adc #$44
	sta .subtiley + 1
	tya
	lsr
	lsr
	clc
	;lda DIV4TABLE,y ; y tile
.scrollposyadddiv4
	adc #$44
	tay ; y tileindex
.tileread
	lda $4444,y ; now we have the tile
	tay
	lda TILEADRLO,y
.subtiley
	adc #$44
	sta .readchar + 1
	lda TILEADRHI,y
	sta .readchar + 2
.readchar
	ldy $4444

	clc
		
	sty ZP_READ_LUMA + 0
	sty ZP_READ_COLOR + 0
	; main blit
	ldy #$00 
	lda (ZP_READ_LUMA),y
	sta (ZP_WRITE_LUMA),y
	lda (ZP_READ_COLOR),y
	sta (ZP_WRITE_COLOR),y
	
	; for color/luma we don't need wrapping
	lda ZP_WRITE_LUMA + 0
	adc #<40
	sta ZP_WRITE_LUMA + 0
	sta ZP_WRITE_COLOR + 0
	bcc .overjumpy
	lda ZP_WRITE_LUMA + 1
	adc #>40
	sta ZP_WRITE_LUMA + 1
	clc
	adc #$04
	sta ZP_WRITE_COLOR + 1
.overjumpy

	inx
	cpx #DISPLAYAREAROWS
	bne .reloop

	rts

	SUBROUTINE
.scrollPosXIntern dc.w $0000
.scrollPosYIntern dc.w $0000
.yline			  dc.w $00
.ylinee			  dc.b $00
.yline40		  dc.w $0000
.temp			  dc.b $00
hardScrollColorRamUpDown 

	lda #$00
	sta .yline
	sta .yline40 + 0
	sta .yline40 + 1
	lda #<[-UPDOWNENEMYGUARD]
	sta .ylinee

	lda hardscrollY
	bne .docolupdown
	rts
.docolupdown
	cmp #$01
	bne .notup
	lda #<[DISPLAYAREAROWS-1+UPDOWNENEMYGUARD]
	sta .ylinee
	lda #[DISPLAYAREAROWS-1]
	sta .yline
	lda #<[[DISPLAYAREAROWS-1]*40]
	sta .yline40 + 0
	lda #>[[DISPLAYAREAROWS-1]*40]
	sta .yline40 + 1
.notup

	lda scrollPosXDiv4 + 0
	sta .scrollPosXIntern + 0
	lda scrollPosXDiv4 + 1
	sta .scrollPosXIntern + 1
	lda scrollPosYDiv8 + 0
	clc
	adc .yline + 0
	sta .scrollPosYIntern + 0
	lda scrollPosYDiv8 + 1
	adc .yline + 1
	sta .scrollPosYIntern + 1

	lda scrollPosXDiv4 + 0
	sta addEnemyLevelXPos
	lda scrollPosYDiv8 + 0
	clc
	adc .ylinee
	sta addEnemyLevelYPos
	jsr addEnemyLevelY

	lda .scrollPosYIntern + 0
	and #$03
	sta .tileyand3 + 1

	lda .scrollPosXIntern + 0
	and #$03
	sta .scrollposxaddand3 + 1

	lda .scrollPosYIntern + 0
	lsr
	lsr
	sta .temp
	lda .scrollPosYIntern + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora .temp
	clc
	;adc #<MAP
	sta .tileydiv4mul64andtileadrlo + 1
	;lda #$00
	;adc #>MAP
	lda #$00
	adc #$00
	sta .tileydiv4mul64andtileadrhi + 1

	ldy .scrollPosXIntern + 0
	
	lda .tileydiv4mul64andtileadrlo + 1
	clc
	adc DIV4MUL64TAB64MAPLO,y
	sta .tileydiv4mul64andtileadrlo + 1
	lda .tileydiv4mul64andtileadrhi + 1
	adc DIV4MUL64TAB64MAPHI,y
	sec
	sbc #>MAP
	sta .tileydiv4mul64andtileadrhi + 1

	lda currentScreenBuffer2 + 0
	clc
	adc .yline40 + 0
	sta ZP_WRITE_LUMA  + 0
	sta ZP_WRITE_COLOR + 0
	lda currentScreenBuffer2 + 1
	adc .yline40 + 1
	sta ZP_WRITE_LUMA  + 1
	clc
	adc #$04
	sta ZP_WRITE_COLOR + 1

	lda #>FONTLUMA
	sta .READ_LUMA + 2
	lda #>FONTCOLOR
	sta .READ_COLOR + 2

	clc
	ldx #$00
	jmp .entry
.reloop

	lda .readchar + 1
	adc #$04
	sta .readchar + 1
	and #%00001100
	bne .readchar
.entry
	txa
	clc
.scrollposxaddand3
	adc #$44
	tay
	and #$03
	asl
	asl
.tileyand3
	adc #$44
	sta .subtilex + 1
	;lda DIV4TABLE,y ; x tile
	;tya
	;lsr
	;lsr
	;tay ; x tileindex
	; * 64
	lda DIV4MUL64TAB64MAPLO,y
	clc
.tileydiv4mul64andtileadrlo
	adc #$44
	sta .tileread + 1
	lda DIV4MUL64TAB64MAPHI,y
.tileydiv4mul64andtileadrhi
	adc #$44
	sta .tileread + 2
.tileread
	lda $4444 ; now we have the tile

	tay
	lda TILEADRLO,y
.subtilex
	adc #$44
	sta .readchar + 1
	lda TILEADRHI,y
	sta .readchar + 2

.readchar
	ldy $4444

	sty .READ_LUMA + 1
	sty .READ_COLOR + 1
	; main blit
	txa
	tay
.READ_LUMA
	lda $4444
	sta (ZP_WRITE_LUMA),y
.READ_COLOR
	lda $4444
	sta (ZP_WRITE_COLOR),y
	
	inx
	cpx #40
	bne .reloop

	rts

	SUBROUTINE
.scrollPosXIntern dc.w $0000
.scrollPosYIntern dc.w $0000
.xline			  dc.b $00
hardScrollBitmapLeftRight

	lda #$00
	ldx hardscrollX
	bne .dobitmapleftright
	rts
.dobitmapleftright
	cpx #$01
	bne .notleft
	lda #39
.notleft
	sta .xline

	lda scrollPosXDiv4 + 0
	clc
	adc .xline
	sta .scrollPosXIntern + 0
	lda scrollPosXDiv4 + 1
	adc #$00
	sta .scrollPosXIntern + 1
	lda scrollPosYDiv8 + 0
	sta .scrollPosYIntern + 0
	lda scrollPosYDiv8 + 1
	sta .scrollPosYIntern + 1

	lda .scrollPosXIntern + 0
	and #$03
	asl
	asl
	sec
	sbc #$01 ; missing clc
	sta .tilexand3shl2 + 1

	lda .scrollPosYIntern + 0
	and #$03
	clc
	adc #DISPLAYAREAROWS ; optimized
	sta .scrollposyaddand3 + 1

	lda .scrollPosYIntern + 0
	lsr ; / 4
	lsr
	sta .scrollposyadddiv4 + 1
	lda .scrollPosYIntern + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora .scrollposyadddiv4 + 1
	sta .scrollposyadddiv4 + 1

	ldy .scrollPosXIntern + 0
	lda DIV4MUL64TAB64MAPLO,y
	sta .tileread + 1
	lda DIV4MUL64TAB64MAPHI,y
	sta .tileread + 2

	ldx scrollLo
	ldy scrollHi
	lda MUL8LO,x
	sta ZP_WRITE_BITMAP + 0
	sta ZP_WRITE_BITMAP2 + 0
	lda MUL8LO,y
	clc
	adc MUL8HI,x
	ora #>$2000
	sta ZP_WRITE_BITMAP + 1
	sta ZP_WRITE_BITMAP + 1
	clc
	adc #>$2000
	sta ZP_WRITE_BITMAP2 + 1

	lda .xline
	cmp #39
	bne .notendline
	lda ZP_WRITE_BITMAP + 0
	clc
	adc #<[39*8]
	sta ZP_WRITE_BITMAP + 0
	sta ZP_WRITE_BITMAP2 + 0
	lda ZP_WRITE_BITMAP + 1
	adc #>[39*8]
	and #$1f
	ora #>$2000
	sta ZP_WRITE_BITMAP + 1
	clc
	adc #>$2000
	sta ZP_WRITE_BITMAP2 + 1
.notendline

	clc
	ldx #[-DISPLAYAREAROWS] & 255
	jmp .entry
.reloop

	lda .readchar + 1
	adc #$01
	sta .readchar + 1
	and #%00000011
	bne .readchar
.entry
	txa
	clc
.scrollposyaddand3
	adc #$44
	tay
	and #$03
.tilexand3shl2
	adc #$44
	sta .subtiley + 1
	tya
	lsr
	lsr
	clc
.scrollposyadddiv4
	adc #$44
	tay ; y tileindex
.tileread
	lda $4444,y ; now we have the tile
	tay
	lda TILEADRLO,y
.subtiley
	adc #$44
	sta .readchar + 1
	lda TILEADRHI,y
	sta .readchar + 2
	clc
.readchar
	ldy $4444
		
	lda MUL8LO,y
	sta ZP_READ_BITMAP + 0
	lda MUL8HI,y
	adc #>FONT
	sta ZP_READ_BITMAP + 1

	; main blit
	ldy #$00
	REPEAT $07
	lda (ZP_READ_BITMAP),y	
	sta (ZP_WRITE_BITMAP),y	
	sta (ZP_WRITE_BITMAP2),y	
	iny
	REPEND
	lda (ZP_READ_BITMAP),y	
	sta (ZP_WRITE_BITMAP),y	
	sta (ZP_WRITE_BITMAP2),y	

	inx
	beq .noreloop

	; increment write pointers
	lda ZP_WRITE_BITMAP + 0
	adc #<320
	sta ZP_WRITE_BITMAP + 0
	sta ZP_WRITE_BITMAP2 + 0
	lda ZP_WRITE_BITMAP + 1
	adc #>320
	and #$1f
	ora #>$2000
	sta ZP_WRITE_BITMAP + 1
	;clc
	adc #>$2000
	sta ZP_WRITE_BITMAP2 + 1

	jmp .reloop
.noreloop

	rts

	SUBROUTINE
.scrollPosXIntern dc.w $0000
.scrollPosYIntern dc.w $0000
.yline			  dc.b $00
.yline320		  dc.w $0000
.temp			  dc.b $00
hardScrollBitmapUpDown

	lda #$00
	sta .yline
	sta .yline320 + 0
	sta .yline320 + 1

	lda hardscrollY
	bne .docolupdown
	rts
.docolupdown
	cmp #$01
	bne .notup
	lda #[DISPLAYAREAROWS-1]
	sta .yline
	lda #<[[DISPLAYAREAROWS-1]*320]
	sta .yline320 + 0
	lda #>[[DISPLAYAREAROWS-1]*320]
	sta .yline320 + 1
.notup

	; one char less if we are scrolling to the left or right
	ldy #$00
	lda #40
	ldx hardscrollX
	cpx #$00
	beq .notleftright
	lda #39
	cpx #$ff
	bne .notleftright
	ldy #$01
.notleftright
	sta .modibefore + 1
	eor #$ff
	clc
	adc #$01
	sta .modireal + 1

	tya
	clc
	adc scrollPosXDiv4 + 0
	sta .scrollPosXIntern + 0
	lda scrollPosXDiv4 + 1
	adc #$00
	sta .scrollPosXIntern + 1
	lda scrollPosYDiv8 + 0
	clc
	adc .yline + 0
	sta .scrollPosYIntern + 0
	lda scrollPosYDiv8 + 1
	adc .yline + 1
	sta .scrollPosYIntern + 1

	lda .scrollPosYIntern + 0
	and #$03
	sec
	sbc #$01 ; missing clc
	sta .tileyand3 + 1

	lda .scrollPosXIntern + 0
	and #$03
	clc
.modibefore
	adc #$44
	sta .scrollposxaddand3 + 1

	lda .scrollPosYIntern + 0
	lsr
	lsr
	sta .temp
	lda .scrollPosYIntern + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora .temp
	clc
	adc #<MAP
	sta .tileydiv4mul64andtileadrlo + 1
;	lda #>MAP
	lda #$00
	adc #$00
	sta .tileydiv4mul64andtileadrhi + 1

	ldy .scrollPosXIntern + 0
	lda .tileydiv4mul64andtileadrlo + 1
	clc
	adc DIV4MUL64TAB64MAPLO,y
	sta .tileydiv4mul64andtileadrlo + 1
	lda .tileydiv4mul64andtileadrhi + 1
	adc DIV4MUL64TAB64MAPHI,y
	sec
	sbc #>MAP
	sta .tileydiv4mul64andtileadrhi + 1

	ldx scrollLo
	ldy scrollHi
	lda MUL8LO,x
	sta ZP_WRITE_BITMAP + 0
	lda MUL8LO,y
	clc
	adc MUL8HI,x
	ora #>$2000
	sta ZP_WRITE_BITMAP + 1


	lda hardscrollX
	cmp #$ff
	bne .notx
	lda ZP_WRITE_BITMAP + 0
	clc
	adc #<$08
	sta ZP_WRITE_BITMAP + 0
	lda ZP_WRITE_BITMAP + 1
	adc #>$08
	sta ZP_WRITE_BITMAP + 1
.notx

	lda ZP_WRITE_BITMAP + 0
	clc
	adc .yline320 + 0
	sta ZP_WRITE_BITMAP + 0
	sta ZP_WRITE_BITMAP2 + 0
	lda ZP_WRITE_BITMAP + 1
	adc .yline320 + 1
	and #$1f
	ora #>$2000
	sta ZP_WRITE_BITMAP + 1
	clc
	adc #>$2000
	sta ZP_WRITE_BITMAP2 + 1

	clc
.modireal
	ldx #$00
	jmp .entry
.reloop

	lda .readchar + 1
	adc #$04
	sta .readchar + 1
	and #%00001100
	bne .readchar
.entry
	txa
	clc
.scrollposxaddand3
	adc #$44
	tay
	lda AND3ASLASL,y
.tileyand3
	adc #$44
	sta .subtilex + 1
	; * 64
	lda DIV4MUL64TAB64MAPLO,y
	clc
.tileydiv4mul64andtileadrlo
	adc #$44
	sta .tileread + 1
	lda DIV4MUL64TAB64MAPHI,y
.tileydiv4mul64andtileadrhi
	adc #$44
	sta .tileread + 2
.tileread
	lda $4444 ; now we have the tile

	tay
	lda TILEADRLO,y
.subtilex
	adc #$44
	sta .readchar + 1
	lda TILEADRHI,y
	sta .readchar + 2

	clc
.readchar
	ldy $4444

	lda MUL8LO,y
	sta ZP_READ_BITMAP + 0
	lda MUL8HI,y
	adc #>FONT
	sta ZP_READ_BITMAP + 1

	; main blit
	ldy #$00
	REPEAT $07
	lda (ZP_READ_BITMAP),y	
	sta (ZP_WRITE_BITMAP),y	
	sta (ZP_WRITE_BITMAP2),y	
	iny
	REPEND
	lda (ZP_READ_BITMAP),y	
	sta (ZP_WRITE_BITMAP),y	
	sta (ZP_WRITE_BITMAP2),y	

	inx
	beq .noreloop

	; increment write pointers
	lda ZP_WRITE_BITMAP + 0
	adc #<$08
	sta ZP_WRITE_BITMAP + 0
	sta ZP_WRITE_BITMAP2 + 0
	bcc .nohiinc
	lda ZP_WRITE_BITMAP + 1
	adc #>$08
	and #$1f
	ora #>$2000
	sta ZP_WRITE_BITMAP + 1
	;clc
	adc #>$2000
	sta ZP_WRITE_BITMAP2 + 1
.nohiinc
	
	jmp .reloop
.noreloop

	rts

LEVELPAINTFUCENABLED dc.b $00

jumpToXYFunction SUBROUTINE

	stx .funcjmp + 1
	sty .funcjmp + 2
	txa
	ora .funcjmp + 2
	beq .nofunc
.funcjmp
	jsr $4444
.nofunc
	rts

callLevelPaintFunc SUBROUTINE
	lda LEVELPAINTFUCENABLED
	beq .yeah
	ldx levelPaintFrameFunc + 0
	ldy levelPaintFrameFunc + 1
	jsr jumpToXYFunction
.yeah
	jmp EPAINTFUNC ; also explosions

callLevelClearFunc SUBROUTINE
	jsr ECLEARFUNC ; also explosions
	lda LEVELPAINTFUCENABLED
	beq .yeah
	ldx levelClearFrameFunc + 0
	ldy levelClearFrameFunc + 1
	jsr jumpToXYFunction
.yeah
	rts

updateFrameAndSetScrollValues SUBROUTINE
	sta .writeDoubleBuffer + 1
	jsr clearFrame
	jsr switchFrame

	jsr callLevelClearFunc
	jsr callLevelPaintFunc

	jsr paintFrame

.writeDoubleBuffer	
	lda #$44
	sta updateDoubleBuffer
.immediateWait
	lda updateDoubleBuffer
;	bne .immediateWait
	rts

updateScrollIrq SUBROUTINE
	lda screenFixed
	beq .normalscrollbehaviour
	rts
.normalscrollbehaviour
	jsr setScrollValues
	lda ff06value
	sta $ff06
	lda ff07value
	sta $ff07
	lda currentScreenBuffer1 + 1
	sta $ff14
	lda doubleBuffer
	bne .nullbuffer
	lda $ff12
	and #%11000011 
	ora #%00001000 
	sta $ff12
	lda #>$4000
	sta lastBitmapHigh
	lda #>$2000
	sta curBitmapHigh
	rts
.nullbuffer
	lda $ff12
	and #%11000011 
	ora #%00010000 
	sta $ff12
	lda #>$2000
	sta lastBitmapHigh
	lda #>$4000
	sta curBitmapHigh
	rts

	SUBROUTINE
;------------------------------------------------------------
;-- Sets the player to a new scrollpos                     --
;------------------------------------------------------------
setPlayerToNewScrollPos
	jsr playerGenNewScrollPos
	lda scrollPosXDesired + 0
	sta scrollPosXCurrent + 0
	lda scrollPosXDesired + 1
	sta scrollPosXCurrent + 1
	lda scrollPosYDesired + 0
	sta scrollPosYCurrent + 0
	lda scrollPosYDesired + 1
	sta scrollPosYCurrent + 1
	jsr genCurrentScrollPos
	jsr genScrollPosXDiv4YDiv8
	jsr genScrollValues
	jsr setScrollValues
	lda scrollPosXDiv4 + 0
	sta currentHardScrollPosX
	lda scrollPosYDiv8 + 0
	sta currentHardScrollPosY
	jsr setOnGroundSavePoint
	; screenFullOfLevel must be called explicitely afterwards
	rts