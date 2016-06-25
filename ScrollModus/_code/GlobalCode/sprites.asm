SPRITECOUNT = 16

; the index is the port
spriteRestoreXS ds.b SPRITECOUNT*2,$00
spriteRestoreYS ds.b SPRITECOUNT*2,$00
spriteRestoreXE ds.b SPRITECOUNT*2,$00
spriteRestoreYE ds.b SPRITECOUNT*2,$00
; it's in demopart.asm
;spriteRestored	ds.b SPRITECOUNT*2,$00

spritePortRestoreAdders
	dc.b SPRITECOUNT * 0
	dc.b SPRITECOUNT * 1
spritePortRestoreAdd
	dc.b $00

;---------------------------------------------------------------------------------------
;-------- VSPRITE LOGIK ----------------------------------------------------------------
;---------------------------------------------------------------------------------------
spritePX		dc.w $0000 ; x sprite position
spritePY		dc.w $0000 ; y sprite position
spriteImage		dc.b $00 ; sprite Image
spriteFlipped	dc.b $00 ; flipped?
spriteWhite		dc.b $00 ; is it constantly white
spritePort		dc.b $00 ; the port where the restauration information is written to

	SUBROUTINE
SPRITE_XSIZE4			dc.b $00
SPRITE_XSIZE			dc.b $00
SPRITE_YSIZE			dc.b $00
SPRITE_XADD				dc.b $00
SPRITE_YADD				dc.b $00
SPRITE_DATA				dc.b $00
SPRITE_SPECIALTABLE		dc.b $00
SPRITE_XSTART			dc.w $0000
SPRITE_YSTART			dc.w $0000
SPRITE_XEND				dc.w $0000
SPRITE_YEND				dc.w $0000
SPRITE_XSIZE_PLUS3		dc.b $00
SPRITE_YSIZE_PLUS7		dc.b $00
SPRITE_XEND_4			dc.b $00
SPRITE_YEND_8			dc.b $00
SPRITE_XSTART_4			dc.b $00
SPRITE_YSTART_8			dc.b $00
SCROLL_XPOS_4_40		dc.b $00
SCROLL_YPOS_8_25		dc.b $00
SPRITE_XBLOCKADD		dc.b $00
SPRITE_YBLOCKADD		dc.b $00
SPRITE_XSMOOTHVAL		dc.b $00
SPRITE_YSMOOTHVAL		dc.b $00
SCREEN_XSTART_4			dc.b $00
SCREEN_YSTART_8			dc.b $00
SPRITE_XEND_4_CLIPPED	dc.b $00
SPRITE_XENDCLIP			dc.b $00
ZP_SPRITE_YREG_X		dc.b $00
ZP_SPRITE_XCOUNT		dc.b $00
SPRITE_YBLOCKADD_8		dc.b $00
SPRITE_YSMOOTH_INV		dc.b $00
SPRITE_XCLIP2			dc.b $00
SPRITE_XCLIP3			dc.b $00
SCREEN_XSTART_4_8		dc.w $00
SPRITE_XLOOP_START		dc.b $00
finex					dc.b $00
SPRITE_FLIPADD			dc.b $00
isRightClean			dc.b $00
isLeftClean				dc.b $00

; save for one cycle alignment
SPRITE_BUILD_FROM_TWO_LOCATIONS SUBROUTINE

	lda ZP_LEFT_BYTE + 0 
	sta .location1 + 1
	lda ZP_LEFT_BYTE + 1 
	sta .location1 + 2
	lda ZP_RIGHT_BYTE + 0 
	sta .location2 + 1
	lda ZP_RIGHT_BYTE + 1 
	sta .location2 + 2
	
	ldy ZP_Y_LENGTH
	dey

.nextelement
.location1
	ldx $4444,y
ror1a
	lda $4400,x ; rortable1
.location2
	ldx $4444,y ; location2
ror2a
	ora $4400,x ; rortable2
	sta SPRITEBUFFER_PLUS_8,y
	dey
	bpl .nextelement
	jmp SPRITE_BUILD_FILL_NEXT8

SPRITE_BUILD_FROM_TWO_LOCATIONS_LEFT SUBROUTINE

	lda #$00
	sta isRightClean

	lda ZP_LEFT_BYTE + 0 
	sta .location1 + 1
	lda ZP_LEFT_BYTE + 1 
	sta .location1 + 2
	
	ldy ZP_Y_LENGTH
	dey

.nextelement
.location1
	ldx $4444,y
ror1al
	lda $4400,x ; rortable1
	sta SPRITEBUFFER_PLUS_8,y
	dey
	bpl .nextelement
	jmp SPRITE_BUILD_FILL_NEXT8

.dofastloop				dc.b $00

;---------------------------------------------------------------------------------------
;-- main sprite blitting function													  --
;---------------------------------------------------------------------------------------
blitVSprite
	stx .xrestore + 1
	sty .yrestore + 1

	lda spriteImage
	asl
	tay
	lda (ZP_SPRITES),y
	sta ZP_SPRITE_STRUCT_ADR + 0
	iny
	lda (ZP_SPRITES),y
	sta ZP_SPRITE_STRUCT_ADR + 1

	ldy #$00
	lda (ZP_SPRITE_STRUCT_ADR),y ; x size 4 0-7
	lsr
	lsr
	lsr
	lsr
	lsr
	sta SPRITE_XSIZE4
	asl
	asl
	sta SPRITE_XSIZE
	lda (ZP_SPRITE_STRUCT_ADR),y ; y size
	and #31
	bne .notzweiundreisig
	lda #32
.notzweiundreisig
	sta SPRITE_YSIZE
	iny
	lda (ZP_SPRITE_STRUCT_ADR),y ; x and y add (y add 0 - 31, x add 0 - 7)
	tax
	and #$07
	sta SPRITE_XADD
	txa
	lsr
	lsr
	lsr
	clc
	adc #$07 ; dunno
	sta SPRITE_YADD
	iny ; spriteflippadd
	ldx spriteFlipped
	beq .notflipperior
	lda (ZP_SPRITE_STRUCT_ADR),y 
	sta SPRITE_XADD
.notflipperior
	iny

	tya
	clc
	adc ZP_SPRITE_STRUCT_ADR + 0
	sta ZP_SPRITE_DATA + 0
	lda ZP_SPRITE_STRUCT_ADR + 1
	adc #$00
	sta ZP_SPRITE_DATA + 1

	lda #$00
	ldx spriteFlipped
	beq .notxflipped
	ora #$02
.notxflipped
	ldx spriteWhite
	beq .notwhite
	ora #$01
.notwhite
	sta SPRITE_SPECIALTABLE
	cmp #$00
	beq .nothingspecial
	clc
	adc #[>SPECIALTABLES]-1
	sta ZP_SPECIAL
.nothingspecial

	; DUNNO
	lda SPRITE_XADD
	clc
	adc #$02
	sta SPRITE_XADD

	; calculate start and end
	lda spritePX + 0
	clc
	adc SPRITE_XADD + 0
	sta SPRITE_XSTART + 0
	lda spritePX + 1
	adc #$00
	sta SPRITE_XSTART + 1

	lda scrollFineX
	lsr
	sta finex

	lda SPRITE_XSTART + 0
	sec
	sbc finex
	sta SPRITE_XSTART + 0
	lda SPRITE_XSTART + 1
	sbc #$00
	sta SPRITE_XSTART + 1

	lda spritePY + 0
	clc
	adc SPRITE_YADD + 0
	sta SPRITE_YSTART + 0
	lda spritePY + 1
	adc #$00
	sta SPRITE_YSTART + 1

	lda SPRITE_YSTART + 0
	sec
	sbc scrollFineY
	sta SPRITE_YSTART + 0
	lda SPRITE_YSTART + 1
	sbc #$00
	sta SPRITE_YSTART + 1

	lda SPRITE_XSIZE
	clc
	adc #$03
	sta SPRITE_XSIZE_PLUS3

	lda SPRITE_YSIZE
	clc
	adc #$07
	sta SPRITE_YSIZE_PLUS7

	lda SPRITE_XSTART + 0
	clc
	adc SPRITE_XSIZE_PLUS3
	sta SPRITE_XEND + 0
	lda SPRITE_XSTART + 1
	adc #$00
	sta SPRITE_XEND + 1

	lda SPRITE_YSTART + 0
	clc
	adc SPRITE_YSIZE_PLUS7
	sta SPRITE_YEND + 0
	lda SPRITE_YSTART + 1
	adc #$00
	sta SPRITE_YEND + 1

	; calculate start and end in blocks
	lda SPRITE_XSTART + 0
	lsr
	lsr
	sta SPRITE_XSTART_4
	lda SPRITE_XSTART + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora SPRITE_XSTART_4
	sta SPRITE_XSTART_4


	lda SPRITE_YSTART + 0
	lsr
	lsr
	lsr
	sta SPRITE_YSTART_8
	lda SPRITE_YSTART + 1
	asl
	asl
	asl
	asl
	asl
	ora SPRITE_YSTART_8
	sta SPRITE_YSTART_8

	lda SPRITE_XEND + 0
	lsr
	lsr
	sta SPRITE_XEND_4
	lda SPRITE_XEND + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora SPRITE_XEND_4
	sta SPRITE_XEND_4

	lda SPRITE_YEND + 0
	lsr
	lsr
	lsr
	sta SPRITE_YEND_8
	lda SPRITE_YEND + 1
	asl
	asl
	asl
	asl
	asl
	ora SPRITE_YEND_8
	sta SPRITE_YEND_8

	; now do the clipping
	;--------------------------------------
	; earlyOutTest
	;--------------------------------------

	lda SPRITE_XEND_4
	beq .xfully
	bpl .xinsideleft
.xfully
	jmp .out
.xinsideleft

	lda SPRITE_YEND_8
	beq .yfully
	bpl .yinsideup
.yfully
	jmp .out
.yinsideup

	lda SPRITE_XSTART_4
	cmp #40
	bmi .xinsideright
	jmp .out
.xinsideright

	lda SPRITE_YSTART_8
	cmp #DISPLAYAREAROWS
	bmi .yinsidedown
	jmp .out
.yinsidedown

	lda #$00
	sta SPRITE_XBLOCKADD
	sta SPRITE_YBLOCKADD
	;--------------------------------------
	; partial clipping
	;--------------------------------------
	lda SPRITE_XSTART_4
	cmp #$00
	bpl .nothalveclippedleft
	lda #$00
	sec
	sbc SPRITE_XSTART_4
	sta SPRITE_XBLOCKADD
	lda #$00
	sta SPRITE_XSTART_4
.nothalveclippedleft

	lda SPRITE_YSTART_8
	cmp #$00
	bpl .nothalveclippedup
	lda #$00
	sec
	sbc SPRITE_YSTART_8
	sta SPRITE_YBLOCKADD
	lda #$00
	sta SPRITE_YSTART_8
.nothalveclippedup

	lda #$00
	sta SPRITE_XEND_4_CLIPPED
	sta SPRITE_XENDCLIP

	; xend and yend will be clipped directly
	lda SPRITE_XEND_4
	cmp #40
	bmi .nothalveclippedright
	beq .nothalveclippedright
	lda SPRITE_XEND_4
	sec
	sbc #40
	sta SPRITE_XENDCLIP
	lda #$01
	sta SPRITE_XEND_4_CLIPPED
	lda #40
.nothalveclippedright
	sta SPRITE_XEND_4

	lda SPRITE_YEND_8
	cmp #DISPLAYAREAROWS
	bmi .nothalveclippeddown
	lda #DISPLAYAREAROWS
.nothalveclippeddown
	sta SPRITE_YEND_8

	;--------------------------------------
	; clipping done
	;--------------------------------------

	; calculate ror values
	lda SPRITE_XSTART
	and #$03
	sta	SPRITE_XSMOOTHVAL

	lda SPRITE_YSTART
	and #$07
	sta	SPRITE_YSMOOTHVAL

	;--------------------------------------
	; calculate screen block coordinates
	;--------------------------------------
	lda SPRITE_XSTART_4
	clc
	adc scrollPosXDiv4
	sta SCREEN_XSTART_4
	asl
	asl
	asl
	sta SCREEN_XSTART_4_8 + 0
	lda SCREEN_XSTART_4
	lsr
	lsr
	lsr
	lsr
	lsr
	sta SCREEN_XSTART_4_8 + 1

	lda SPRITE_YSTART_8
	clc
	adc scrollPosYDiv8
	sta SCREEN_YSTART_8

	;--------------------------------------
	; calculate blitting address
	;--------------------------------------
	;;;;; ---- everything ok!

	lda #$00
	sta ZP_SPRITE_YREG_X ; xcounter
	lda SPRITE_XEND_4
	sec
	sbc SPRITE_XSTART_4
	sta ZP_SPRITE_XCOUNT ; xsize

	lda spriteFlipped
	beq .notflipped

	lda ZP_SPRITE_XCOUNT
	sec
	sbc #$01
	asl
	asl
	asl
	clc
	adc SCREEN_XSTART_4_8 + 0
	sta SCREEN_XSTART_4_8 + 0
	lda SCREEN_XSTART_4_8 + 1
	adc #$00
	sta SCREEN_XSTART_4_8 + 1
.notflipped

	ldy SCREEN_YSTART_8
	lda MUL320LO,y
	clc
	adc SCREEN_XSTART_4_8 + 0
	sta ZP_SCREENBLITADDRESS + 0
	lda MUL320HI,y
	adc SCREEN_XSTART_4_8 + 1
	and #$1f

	; fastloop for screen position
	ldx #$00
	cmp #>[320*[25-6]]
	bcs .nofastloop
	ldy spriteFlipped
	beq .doitfast
	cmp #$00 ; for flipped sprites there is a sub so no 0 line
	beq .nofastloop
.doitfast
	ldx #$01
.nofastloop
	stx .dofastloop

	ora BITMAPSCREENHI
	sta ZP_SCREENBLITADDRESS + 1

	;--------------------------------------
	; calculate rortable pos
	;--------------------------------------
	lda SPRITE_XSTART
	ldx spriteFlipped
	bne .noflip
	eor #$ff
	jmp .flip
.noflip		
	clc
	adc #$03
.flip
	and #$03
	clc
	adc #>RORTABLES1
	sta ror1a + 2
	sta ror1b + 2
	sta ror1al + 2
	sta ror1bl + 2
	clc
	adc #[>RORTABLES2]-[>RORTABLES1]
	sta ror2a + 2
	sta ror2b + 2
	sta ror2ar + 2
	sta ror2br + 2

	lda SPRITE_YBLOCKADD
	asl
	asl
	asl
	sta SPRITE_YBLOCKADD_8

	; y calculations
	lda SPRITE_YSMOOTHVAL
	eor #$07
	clc
	adc #$01
	clc
	adc SPRITE_YBLOCKADD_8
	sta	SPRITE_YSMOOTH_INV

	lda SPRITE_YSIZE
	sta ZP_Y_LENGTH ; y clipping is imperfect the whole sprite gets generated here

	; generate adresses for the readout
	lda ZP_SPRITE_DATA + 0
	sta ZP_BYTE + 0
	lda ZP_SPRITE_DATA + 1
	sta ZP_BYTE + 1

	lda #$00
	sta SPRITE_XCLIP3
	sta SPRITE_XCLIP2
	sta isLeftClean
	sta isRightClean

	lda spriteFlipped
	beq .notxflipped2

	lda SPRITE_XBLOCKADD
	beq .yo2
	lda #$01
	sta SPRITE_XCLIP2
.yo2

	lda #$00
	sta SPRITE_XBLOCKADD
	lda SPRITE_XEND_4_CLIPPED
	beq .c
	ldx SPRITE_XENDCLIP
.xaddloop2
	lda ZP_BYTE + 0
	clc
	adc SPRITE_YSIZE
	sta ZP_BYTE + 0
	lda ZP_BYTE + 1
	adc #$00
	sta ZP_BYTE + 1
	dex
	bne .xaddloop2
	lda #$01
	sta SPRITE_XCLIP3
.c
.notxflipped2

	ldx SPRITE_XBLOCKADD
	lda SPRITE_XSMOOTHVAL
	bne .a
	inx
.a
	dex
	beq .noxaddloop
	bmi .noxaddloop
.xaddloop
	lda ZP_BYTE + 0
	clc
	adc SPRITE_YSIZE
	sta ZP_BYTE + 0
	lda ZP_BYTE + 1
	adc #$00
	sta ZP_BYTE + 1
	dex
	bne .xaddloop
.noxaddloop

	lda #$01 
	sta SPRITE_XLOOP_START

.nextxelement

	lda ZP_BYTE + 0
	sta ZP_LEFT_BYTE + 0
	clc
	adc SPRITE_YSIZE
	sta ZP_RIGHT_BYTE + 0
	lda ZP_BYTE + 1
	sta ZP_LEFT_BYTE + 1
	adc #$00
	sta ZP_RIGHT_BYTE + 1

	lda ZP_SPRITE_XCOUNT
	cmp #$01
	bne .notlastcolumn
	lda SPRITE_XCLIP3
	bne .doit
	lda SPRITE_XEND_4_CLIPPED
	ora SPRITE_XCLIP2
	bne .notlastcolumn
.doit
	lda #$01
	sta isRightClean
.notlastcolumn

	lda SPRITE_XLOOP_START
	beq .notfirstcolumn
	lda SPRITE_XSMOOTHVAL
	beq .notfirstcolumn
	lda SPRITE_XBLOCKADD
	bne .notfirstcolumn
	lda ZP_LEFT_BYTE  + 0
	sta ZP_RIGHT_BYTE + 0
	lda ZP_LEFT_BYTE  + 1
	sta ZP_RIGHT_BYTE + 1
	lda #$01
	sta isLeftClean
	lda SPRITE_XCLIP3
	beq .nolo
	lda ZP_RIGHT_BYTE + 0
	sec
	sbc SPRITE_YSIZE
	sta ZP_LEFT_BYTE  + 0
	lda ZP_RIGHT_BYTE + 1
	sbc #$00
	sta ZP_LEFT_BYTE  + 1
	lda ZP_SPRITE_XCOUNT
	cmp #$01
	bne .ya
	lda #$01
	sta isRightClean
.ya
.nolo
	jmp .firstcolumndone
.notfirstcolumn

	lda ZP_BYTE + 0
	clc
	adc SPRITE_YSIZE
	sta ZP_BYTE + 0
	lda ZP_BYTE + 1
	adc #$00
	sta ZP_BYTE + 1
.firstcolumndone

	lda #$00
	sta SPRITE_XLOOP_START

	lda ZP_SPRITE_YREG_X
	sta ZP_SPRITE_YREG   ; y counter
	lda SPRITE_YEND_8
	sec
	sbc SPRITE_YSTART_8
	sta ZP_SPRITE_YCOUNT ; ysize

	lda #<SPRITEBUFFER
	clc
	adc SPRITE_YSMOOTH_INV
	sta ZP_SPRITE_BUFFER + 0
	lda #>SPRITEBUFFER
	sta ZP_SPRITE_BUFFER + 1

	; sprite buffer preparation
	lda SPRITE_XSMOOTHVAL
	bne .wemustror
	lda SPRITE_SPECIALTABLE
	bne .special1
	jmp SPRITE_BUILD_FROM_ONE_LOCATION
.special1
	jmp SPRITE_BUILD_FROM_ONE_LOCATION_SPECIAL
.wemustror
	lda SPRITE_SPECIALTABLE
	bne .special2
	lda isLeftClean
	beq .notleftclean1
	jmp SPRITE_BUILD_FROM_TWO_LOCATIONS_RIGHT
.notleftclean1
	lda isRightClean
	beq .notrightclean1
	jmp SPRITE_BUILD_FROM_TWO_LOCATIONS_LEFT
.notrightclean1
	jmp SPRITE_BUILD_FROM_TWO_LOCATIONS

.special2
	lda isLeftClean
	beq .notleftclean2
	jmp SPRITE_BUILD_FROM_TWO_LOCATIONS_RIGHT_SPECIAL
.notleftclean2
	lda isRightClean
	beq .notrightclean2
	jmp SPRITE_BUILD_FROM_TWO_LOCATIONS_LEFT_SPECIAL
.notrightclean2
	jmp SPRITE_BUILD_FROM_TWO_LOCATIONS_SPECIAL

SPRITEBUILDREADY ;-------------- jump back point --------------

	; write early out test
	lda ZP_SCREENBLITADDRESS + 0
	sta ZP_SCREENBLITWRITE + 0
	lda ZP_SCREENBLITADDRESS + 1
	sta ZP_SCREENBLITWRITE + 1


	lda .dofastloop
	beq .normalloop
	jmp fastloop
.normalloop
	clc
	echo "1", . / $100
.nextyelement
 ;-------------------------------- MainLoop for drawing the tiles	
	ldy #$00
	REPEAT 7
	lax (ZP_SPRITE_BUFFER),y
	ora (ZP_SCREENBLITWRITE),y
	and AUTOMASKING,x
	sta (ZP_SCREENBLITWRITE),y
	iny
	REPEND
	lax (ZP_SPRITE_BUFFER),y
	ora (ZP_SCREENBLITWRITE),y
	and AUTOMASKING,x
	sta (ZP_SCREENBLITWRITE),y
	
	dec ZP_SPRITE_YCOUNT
	beq .doneyelement

	lda ZP_SPRITE_BUFFER
	adc #$08
	sta ZP_SPRITE_BUFFER
	
	lda ZP_SCREENBLITWRITE + 0
	adc #<320
	sta ZP_SCREENBLITWRITE + 0
	lda ZP_SCREENBLITWRITE + 1
	adc #>320
	and #$1f
	ora BITMAPSCREENHI
	sta ZP_SCREENBLITWRITE + 1

	bne .nextyelement
	beq .nextyelement
	echo "2", . / $100

.doneyelement
fastloopend
	dec ZP_SPRITE_XCOUNT
	beq .nonextxelement

	lda spriteFlipped
	beq .b
	lda ZP_SCREENBLITADDRESS + 0
	sec
	sbc #<[$08*2]
	sta ZP_SCREENBLITADDRESS + 0
	lda ZP_SCREENBLITADDRESS + 1
	sbc #>[$08*2]
	sta ZP_SCREENBLITADDRESS + 1
.b

	lda ZP_SCREENBLITADDRESS + 0
	clc
	adc #<$08
	sta ZP_SCREENBLITADDRESS + 0
	lda ZP_SCREENBLITADDRESS + 1
	adc #>$08
	and #$1f
	ora BITMAPSCREENHI
	sta ZP_SCREENBLITADDRESS + 1

	jmp .nextxelement
.nonextxelement

	lda spritePort
	cmp #$ff
	beq .norestore
	clc
	adc spritePortRestoreAdd
	tax

	lda SCREEN_XSTART_4
	sta spriteRestoreXS,x
	lda SCREEN_YSTART_8
	sta spriteRestoreYS,x
	lda SPRITE_XEND_4
	clc
	adc scrollPosXDiv4
	sta spriteRestoreXE,x
	lda SPRITE_YEND_8
	clc
	adc scrollPosYDiv8
	sta spriteRestoreYE,x

	lda #$00
	sta spriteRestored,x
.norestore


.out
.xrestore
	ldx #$44
.yrestore
	ldy #$44
	rts

; -------------------------------------------------------------------------------------------
; -- SPRITEBUFFER STUFF																	   --
; -------------------------------------------------------------------------------------------
; -- these routines blit the sprite from the source data rored right and with flipping     --
; -- into a special line buffer which will be used later to draw them onto the screen	   --
; -------------------------------------------------------------------------------------------
;-----
SPRITE_BUILD_FROM_TWO_LOCATIONS_RIGHT SUBROUTINE

	lda #$00
	sta isLeftClean

	lda ZP_RIGHT_BYTE + 0 
	sta .location1 + 1
	lda ZP_RIGHT_BYTE + 1 
	sta .location1 + 2
	
	ldy ZP_Y_LENGTH
	dey

.nextelement
	echo "1", . / $100
.location1
	ldx $4444,y
ror2ar
	lda $4400,x ; rortable1
	sta SPRITEBUFFER_PLUS_8,y
	dey
	bpl .nextelement
	echo "2", . / $100
	jmp SPRITE_BUILD_FILL_NEXT8

;-----
SPRITE_BUILD_FROM_ONE_LOCATION SUBROUTINE

	lda ZP_LEFT_BYTE + 0 
	sta .location1 + 1
	lda ZP_LEFT_BYTE + 1 
	sta .location1 + 2

	ldy ZP_Y_LENGTH
	dey

.nextelement
	echo "1", . / $100
.location1
	lda $4444,y ; location
	sta SPRITEBUFFER_PLUS_8,y
	dey
	bpl .nextelement
	echo "2", . / $100
	jmp SPRITE_BUILD_FILL_NEXT8

;-----
SPRITE_BUILD_FROM_TWO_LOCATIONS_SPECIAL SUBROUTINE
	lda ZP_LEFT_BYTE + 0 
	sta .location1 + 1
	lda ZP_LEFT_BYTE + 1 
	sta .location1 + 2
	lda ZP_RIGHT_BYTE + 0 
	sta .location2 + 1
	lda ZP_RIGHT_BYTE + 1 
	sta .location2 + 2
	lda ZP_SPECIAL
	sta .special + 2
	
	ldy ZP_Y_LENGTH
	dey

.nextelement
	echo "1", . / $100
.location1
	ldx $4444,y ; location1
ror1b
	lda $4400,x ; rortable1
.location2
	ldx $4444,y ; location2
ror2b
	ora $4400,x ; rortable2
	tax
.special
	lda $4400,x ; specialtable
	sta SPRITEBUFFER_PLUS_8,y
	dey
	echo "2", . / $100
	bpl .nextelement
	jmp SPRITE_BUILD_FILL_NEXT8

SPRITE_BUILD_FROM_TWO_LOCATIONS_LEFT_SPECIAL SUBROUTINE

	lda #$00
	sta isRightClean

	lda ZP_LEFT_BYTE + 0 
	sta .location1 + 1
	lda ZP_LEFT_BYTE + 1 
	sta .location1 + 2
	lda ZP_SPECIAL
	sta .special + 2
	ldy ZP_Y_LENGTH
	dey
.nextelement
	echo "1", . / $100
.location1
	ldx $4444,y ; location1
ror1bl
	lda $4400,x ; rortable1
.location2
	tax
.special
	lda $4400,x ; specialtable
	sta SPRITEBUFFER_PLUS_8,y
	dey
	bpl .nextelement
	echo "2", . / $100
	jmp SPRITE_BUILD_FILL_NEXT8

SPRITE_BUILD_FROM_TWO_LOCATIONS_RIGHT_SPECIAL SUBROUTINE

	lda #$00
	sta isLeftClean

	lda ZP_RIGHT_BYTE + 0 
	sta .location1 + 1
	lda ZP_RIGHT_BYTE + 1 
	sta .location1 + 2
	lda ZP_SPECIAL
	sta .special + 2
	ldy ZP_Y_LENGTH
	dey
.nextelement
	echo "1", . / $100
.location1
	ldx $4444,y ; location1
ror2br
	lda $4400,x ; rortable2
.location2
	tax
.special
	lda $4400,x ; specialtable
	sta SPRITEBUFFER_PLUS_8,y
	dey
	bpl .nextelement
	echo "2", . / $100
	jmp SPRITE_BUILD_FILL_NEXT8

;-----
SPRITE_BUILD_FROM_ONE_LOCATION_SPECIAL SUBROUTINE
	lda ZP_LEFT_BYTE + 0 
	sta .location + 1
	lda ZP_LEFT_BYTE + 1 
	sta .location + 2
	lda ZP_SPECIAL
	sta .special + 2
	
	ldy ZP_Y_LENGTH
	dey

.nextelement
	echo "1", . / $100
.location
	ldx $4444,y ; location
.special
	lda $4400,x ; specialtable
	sta SPRITEBUFFER_PLUS_8,y
	dey
	bpl .nextelement
	echo "2", . / $100
	jmp SPRITE_BUILD_FILL_NEXT8

;-----
SPRITE_BUILD_FILL_NEXT8 SUBROUTINE
	ldy ZP_Y_LENGTH
	lda #$00
Y SET 0
	REPEAT 8
	sta SPRITEBUFFER_PLUS_8+Y,y
Y SET Y + 1
	REPEND
	jmp SPRITEBUILDREADY





fastloop SUBROUTINE
	clc
	ldy #$00
.nextyelement
	REPEAT 8
	lax (ZP_SPRITE_BUFFER),y
	ora (ZP_SCREENBLITWRITE),y
	and AUTOMASKING,x
	sta (ZP_SCREENBLITWRITE),y
	iny
	REPEND

	lda ZP_SCREENBLITWRITE + 0
	adc #<[320-8]
	sta ZP_SCREENBLITWRITE + 0
	inc ZP_SCREENBLITWRITE + 1
	bcc .nocarry
	clc
	inc ZP_SCREENBLITWRITE + 1
.nocarry

	dec ZP_SPRITE_YCOUNT
	bne .nextyelement
	jmp fastloopend

;------------------------------------------------------------------------------------------
;-- restores the sprite rectangle (spritePortRestoreAdd should point to the last frame)  --
;------------------------------------------------------------------------------------------
restoreSpritePort SUBROUTINE
	lda spritePort
	clc
	adc spritePortRestoreAdd
	tax
	lda spriteRestored,x
	bne .alreadyRestored
	lda #$01
	sta spriteRestored,x
	lda spriteRestoreXS,x
	sta rectLevelXS
	lda spriteRestoreYS,x
	sta rectLevelYS
	lda spriteRestoreXE,x
	sta rectLevelXE
	lda spriteRestoreYE,x
	sta rectLevelYE
	jsr restoreRect
.alreadyRestored
	rts

;------------------------------------------------------------------------------------------
;-- initializes the sprites																 --
;------------------------------------------------------------------------------------------
	SUBROUTINE
initSpriteSubsystem 
	
	lda SPRITES				+ 0
	sta ZP_SPRITES			+ 0
	lda SPRITES				+ 1
	sta ZP_SPRITES			+ 1
    
	lda ENEMYX_XARRAYINDEX_ADR	+ 0
    sta ZP_ENEMYX_XARRAYINDEX	+ 0
    lda ENEMYX_XARRAYINDEX_ADR	+ 1
    sta ZP_ENEMYX_XARRAYINDEX	+ 1
	
	lda ENEMYX_EARRAYINDEX_ADR	+ 0
	sta ZP_ENEMYX_EARRAYINDEX	+ 0
	lda ENEMYX_EARRAYINDEX_ADR	+ 1
	sta ZP_ENEMYX_EARRAYINDEX	+ 1
	
	lda ENEMYX_COUNT_ADR		+ 0
	sta ZP_ENEMYX_COUNT			+ 0
	lda ENEMYX_COUNT_ADR		+ 1
	sta ZP_ENEMYX_COUNT			+ 1
	
	lda ENEMYY_ENEMYTYPE_ADR	+ 0
	sta ZP_ENEMYY_ENEMYTYPE		+ 0
	lda ENEMYY_ENEMYTYPE_ADR	+ 1
	sta ZP_ENEMYY_ENEMYTYPE		+ 1
	
	lda ENEMYY_YPOSITION_ADR	+ 0
	sta ZP_ENEMYY_YPOSITION		+ 0
	lda ENEMYY_YPOSITION_ADR	+ 1
	sta ZP_ENEMYY_YPOSITION		+ 1

	ldx #SPRITECOUNT * 2 - 1
.reloop
	lda #$01
	sta spriteRestored,x		; we don't want this sprite to be updated
	dex
	bpl .reloop
	rts

