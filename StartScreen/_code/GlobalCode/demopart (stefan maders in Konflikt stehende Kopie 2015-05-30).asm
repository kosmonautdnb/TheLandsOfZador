    processor   6502
	
	include "fw_interface.asm"
	include "macros.asm"
	include "standard.asm"
	include "persistent.asm"

ZP_READ1  = $10 ; 2
ZP_READ2  = $12 ; 2
ZP_WRITE1 = $14 ; 2
ZP_WRITE2 = $16 ; 2
ZP_NAMES  = $18 ; 2
ZP_SCORES = $1a ; 2
ZP_LOVE   = $1c ; 2

	include "fw_interface.asm"
	include "persistent.asm"
	include "parallaxProps.inc"

SCROLLYLINE = 19

	ORG $4000
	ds.b  $400,$00
	ORG $4400
	ds.b  $400,$00
	ORG $4800
	incbin "scroll_charset.bin"

	ORG $5000 ; text font (perhaps with animation)
	ds.b $08,$00
	ds.b $7f8,$00

	ORG $5800 ; LOGOFONT
	ds.b $08,$00
WOLKE1
	ds.b 8*2*8,0
WOLKE2
	ds.b 8*2*8,0
	incbin "logo_charset.bin"

	ORG $6000
ENTRYPOINT
;--------------------------------------------------------------------
; Hauptprogramm (Init)
;--------------------------------------------------------------------
MAINPRG SUBROUTINE

	jsr waitFrame 

	jsr loadScores
	lda ZP_STARTSCREENMUSIC
	bne .wecomefromthegame
	jsr fadeOver2
.wecomefromthegame
	lda #$00
	sta $ff15

	lda #$00
	sta ZP_CHEAT

	;-------------------------------------------------------------------
	; disable screen
	;-------------------------------------------------------------------
	lda #$0b
	sta $ff06


	lda ZP_STARTSCREENMUSIC
	beq .nomusicload
	jsr LOADSONG
.nomusicload
	lda #$01
	sta ZP_STARTSCREENMUSIC

	;-------------------------------------------------------------------
	; font adress 5800
	;-------------------------------------------------------------------
	lda $ff13
	and #%00000101 ; bit 2=1 auf slow
	ora #%01011000  
	sta $ff13

	;-------------------------------------------------------------------
	; bitmap adress 2000 | bitmap ram 
	;-------------------------------------------------------------------
	lda $ff12
	and #%11000011 
	ora #%00001000 
	sta $ff12

	lda $ff14
	and #%00000111
	ora #%01000000
	sta $ff14

	lda #%10011000 ; we want multicolor
	sta $ff07

	jsr waitBorder

	lda #LOGOCOLOR1
	sta $ff16
	lda #LOGOCOLOR2
	sta $ff17

	sei
	lda #<raster_plugin
	sta fw_topirq_plugin + 0
	lda #>raster_plugin
	sta fw_topirq_plugin + 1
	cli

	jsr fillInScores
	jsr initTextScreen
	jsr hardScroll
	lda #40
	sta fadeInActive

	jsr scroll
	jsr textColors
	jsr animateTextScreen
	;-------------------------------------------------------------------
	; enable screen
	;-------------------------------------------------------------------
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	lda #%00011011
	sta $ff06

.mainLoop
	;jsr waitFrame
	jsr waitBeforeBorder
	jsr scroll
	jsr godKeys

	jsr textColors
	jsr animateTextScreen

	lda mainCounter
	and #$ff
	cmp #$ff - 80
	bne .b
	jsr initiateFadeOver
.b

	jsr fadeOver

	inc mainCounter + 0
	bne .frcnohi
	inc mainCounter + 1
.frcnohi
	
	jsr gatherJoystick
	lda joyPressed
	bne .loadLevel

	jmp .mainLoop
.loadLevel

	sei
	lda #$00
	sta fw_topirq_plugin + 0
	sta fw_topirq_plugin + 1
	cli

	jsr waitBorder
	lda #$0b
	sta $ff06
	jsr waitFrame

	lda #$00
	sta ZP_LEVELCURRENT
	lda #$01
	sta ZP_LEVELTOLOAD
	lda #$03
	sta ZP_LIVES
	lda #$00
	sta ZP_BALLS
	lda #$00
	sta ZP_BCDSCORE + 0
	sta ZP_BCDSCORE + 1
	sta ZP_BCDSCORE + 2
	sta ZP_BCDSCORE + 3

	;ldx #<loadingScreenFileName
	;ldy #>loadingScreenFileName
	;jsr fw_load

	;ldx fw_load_end + 0
	;ldy fw_load_end + 1
	;jsr fw_decrunch

	;jmp ENTRYPOINT_LOADINGSCREEN

	ldx #$00
.copystub
	lda .stubstart,x
	sta $1800,x
	inx
	cpx #.stubend - .stubstart
	bne .copystub
	jmp $1800

.stubstart
	ldx #<fileNameStory
	ldy #>fileNameStory
	LOAD_NORMAL

	ldx fw_load_end + 0
	ldy fw_load_end + 1
	jsr fw_decrunch

	jmp ENTRYPOINT_STORY
.stubend

fileNameStory
	dc.b "STORY",0

fadeOutActive dc.b $00
fadeInActive dc.b $00
initiateFadeOver SUBROUTINE
	lda #40
	sta fadeOutActive
	rts

textLineX ds.b $03,40

fadeOver SUBROUTINE
	lda fadeOutActive
	ora fadeInActive
	bne .somefade
	rts
.somefade

	lda fadeOutActive
	beq .notdofadeout
	lda fadeOutActive
	eor #$ff
	clc
	adc #42
	eor #$ff
	clc
	adc #41+2
	sta textLineX + 0
	sta textLineX + 2
	lda fadeOutActive
	eor #$ff
	clc
	adc #42
	clc
	adc #38+2
	sta textLineX + 1
	dec fadeOutActive
	lda fadeOutActive
	bne .notinitiatefadein
	lda #40
	sta fadeInActive
	lda textScreenPos
	clc
	adc #3*11
	sta textScreenPos
	lda textScreenPos
	cmp #LASTPAGE * 3 * 11
	beq .notlastpage
	bcc .notlastpage
	lda #$00
	sta textScreenPos
.notlastpage

.notinitiatefadein
.notdofadeout

	lda fadeInActive
	beq .notdofadein
	lda fadeInActive
	eor #$ff
	clc
	adc #41+2
	sta textLineX + 1
	lda fadeInActive
	clc
	adc #38+2
	sta textLineX + 0
	sta textLineX + 2
	dec fadeInActive
.notdofadein
	
	lda #$00
	sta textLineNumber
	lda textLineX + 0
	sta textLineXPosition
	jsr blitScreenTextChars
	lda #$01
	sta textLineNumber
	lda textLineX + 1
	sta textLineXPosition
	jsr blitScreenTextChars
	lda #$02
	sta textLineNumber
	lda textLineX + 2
	sta textLineXPosition
	jsr blitScreenTextChars
	rts

fileNameHighScore dc.b "SC",$00

waitFrame SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
.waita
	bit $ff1c
	bne .waita
	rts

waitBorder SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
	rts

waitBeforeBorder SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	bne .waitb
	lda #192
.next
	cmp $ff1d
	bcs .next
	rts

raster_plugin SUBROUTINE 
	lda #<rasterIrq1 
	sta $fffe 
	lda #>rasterIrq1 
	sta $ffff 
	lda #2  ;raster irq 
	sta $ff0a 
	lda #2 
	sta $ff0b
	PLUGIN_CANCELDEFAULT 
	rts 

rasterIrq1 SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	lda $ff13
	and #%00000111
	ora #%01011000 ; font $5800
	pha
	and #%11111101 ; speedmode
	sta $ff13

	lda #CLOUDCOLOR1
	sta $ff15
	lda #LOGOCOLOR1
	sta $ff16
	lda #LOGOCOLOR2
	sta $ff17

	lda logoxpositionlo
	eor #$ff
	and #$07
	ora #%10010000 ; we want multicolor
	sta $ff07

	; put second one on
	lda #CLOUDLINE1 + 3
	sta $ff0b
	lda #<rasterIrq2
	sta $fffe 
	lda #>rasterIrq2
	sta $ffff 

	inc $ff09

	inc frameCounter + 0
	bne .frcnohi
	inc frameCounter + 1
.frcnohi

	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

rasterIrq2 SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	lda $ff13
	pha
	and #%11111101 ; speedmode
	sta $ff13 

	lda #CLOUDCOLOR2
	sta $ff15

	; put second one on
	lda #CLOUDLINE2 + 3
	sta $ff0b
	lda #<rasterIrq3
	sta $fffe 
	lda #>rasterIrq3
	sta $ffff 

	inc $ff09

	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

rasterIrq3 SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	lda $ff13
	pha
	and #%11111101 ; speedmode
	sta $ff13 
	inc $ff09

	lda #CLOUDCOLOR3
	sta $ff15
	
	; put second one on
	lda #LOGOLINES*8+2
	sta $ff0b
	lda #<rasterIrq4
	sta $fffe 
	lda #>rasterIrq4
	sta $ffff 
	
	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

XSINSTEP = $20

rasterIrq4 SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	nop
	nop
	nop
	nop
	lda $ff13
	and #%00000111
	ora #%01010000 ; font $5000
	pha
	and #%11111101 ; speedmode
	sta $ff13

	lda #CLOUDCOLOR3
	sta $ff15

	inc $ff09

	lda frameCounter
	clc
	adc #XSINSTEP*0
	tax
	lda FONTXSIN,x
	ora #%10000000 ; we want no multicolor
	sta $ff07
	
	; put second one on
	lda #TEXTPOSSTART*8+2 + 24*1
	sta $ff0b
	lda #<rasterIrq5
	sta $fffe 
	lda #>rasterIrq5
	sta $ffff 

	cli
	jsr logo
	jsr wolkeParallax1
	jsr wolkeParallax2

	lda $ff13
	and #%11111000
	sta .ff13or + 1
	pla
	and #%00000111
.ff13or	
	ora #$44
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

rasterIrq5 SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	nop
	nop
	nop
	lda $ff13
	and #%00000111
	ora #%01010000 ; font $5000
	pha
	and #%11111101 ; speedmode
	sta $ff13

	lda #CLOUDCOLOR3
	sta $ff15

	inc $ff09

	lda frameCounter
	clc
	adc #XSINSTEP*1
	tax
	lda FONTXSIN,x
	ora #%10000000 ; we want no multicolor
	sta $ff07
	
	; put second one on
	lda #TEXTPOSSTART*8+2 + 24*2
	sta $ff0b
	lda #<rasterIrq6
	sta $fffe 
	lda #>rasterIrq6
	sta $ffff 
	
	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

rasterIrq6 SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	nop
	nop
	nop
	lda $ff13
	and #%00000111
	ora #%01010000 ; font $5000
	pha
	and #%11111101 ; speedmode
	sta $ff13

	lda #CLOUDCOLOR3
	sta $ff15

	inc $ff09

	lda frameCounter
	clc
	adc #XSINSTEP*2
	tax
	lda FONTXSIN,x
	ora #%10000000 ; we want no multicolor
	sta $ff07
	
	; put second one on
	lda #TEXTPOSSTART*8+3 + 24*3-1
	sta $ff0b
	lda #<rasterIrq7
	sta $fffe 
	lda #>rasterIrq7
	sta $ffff 
	
	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti


rasterIrq7 SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	REPEAT 4
	nop
	REPEND


	lda $ff13
	and #%00000111
	ora #%01001000 ; font $4800
	pha
	and #%11111101 ; speedmode
	tax
	lda scrollPos
	eor #$07
	and #$07
	ora #%10010000 ; we want multicolor
	tay

	lda #CLOUDCOLOR3
	sta $ff15
	lda #SCROLLCOLOR1
	sta $ff16
	lda #SCROLLCOLOR2
	sta $ff17
	stx $ff13
	sty $ff07

	inc $ff09

	
	jsr fw_lowirq_install

	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

;-----------------------------------------------------------
wolkeParallaxPos dc.b $00
wolkeParallax SUBROUTINE

	lda wolkeParallaxPos
	sec
	sbc logoxpositionlo
	and #$07
	tax

	lda #<wolkeParallaxData
	clc
	adc parallaxX7AdderLo,x
	sta .vals1lo + 1
	lda #>wolkeParallaxData
	adc parallaxX7AdderHi,x
	sta .vals1hi + 1


	lda wolkeParallaxPos
	sec
	sbc logoxpositionlo
	and #8*8-1
	lsr
	lsr
	lsr
	tax
	clc
	adc #$08
	sta .endpoint + 1

.copyloop
.vals1lo
	lda #$44
	clc
	adc parallaxAdders,x
	sta .val1 + 1
.vals1hi
	lda #$44
	adc #$00
	sta .val1 + 2

	ldy #15
.next
.val1
	lda $4444,y
.val2
	sta $4444,y
	dey
	bpl .next

	lda .val2 + 1
	clc
	adc #<16
	sta .val2 + 1
	lda .val2 + 2
	adc #>16
	sta .val2 + 2

	inx
.endpoint
	cpx #$08
	bne .copyloop

	rts

wolkeParallax1Pos dc.b $00
wolkeParallax2Pos dc.b $00

wolkeParallax1
	lda frameCounter + 0
	and #$01
	beq .do1
	inc wolkeParallax1Pos
.do1
	lda wolkeParallax1Pos
	and #8*8-1
	sta wolkeParallax1Pos
	sta wolkeParallaxPos
	lda #<WOLKE1
	sta .val2 + 1
	lda #>WOLKE1
	sta .val2 + 2
	jmp wolkeParallax

wolkeParallax2
	inc wolkeParallax2Pos
	lda wolkeParallax2Pos
	and #8*8-1
	sta wolkeParallax2Pos
	sta wolkeParallaxPos
	lda #<WOLKE2
	sta .val2 + 1
	lda #>WOLKE2
	sta .val2 + 2
	jmp wolkeParallax
;-----------------------------------------------------------
logoxpositionlo dc.b $00
logoxpositionhi dc.b $00
logoxpos dc.b $00
logoxposlast dc.b $00
blitLogo
	lda logoxpositionhi
	asl
	asl
	asl
	asl
	asl
	sta logoxpos
	lda logoxpositionlo
	lsr
	lsr
	lsr
	clc
	adc logoxpos
	sta logoxpos
	cmp logoxposlast
	bne .yeahchange
	rts
.yeahchange
	sta logoxposlast
	clc
	adc #39+13
	tax

	ldy #39
.reloop
Y SET 0 
	REPEAT LOGOLINES
	lda logo_screen + Y * LOGOLINEWIDTH,x
	sta $4400 + Y * 40,y
	lda logo_color + Y * LOGOLINEWIDTH,x
	sta $4000 + Y * 40,y
Y SET Y + 1
	REPEND
	dex
	dey
	bpl .reloop
	rts

logo SUBROUTINE

	inc logox_table_pos + 0
	bne .lxnohi
	inc logox_table_pos + 1
	lda logox_table_pos + 1
	cmp #>1024
	bne .lxnohi
	lda #$00
	sta logox_table_pos + 0
	sta logox_table_pos + 1
.lxnohi

	lda #<logox_table_lo
	clc
	adc logox_table_pos + 0
	sta .read1 + 1
	lda #>logox_table_lo
	adc logox_table_pos + 1
	sta .read1 + 2

	lda #<logox_table_hi
	clc
	adc logox_table_pos + 0
	sta .read2 + 1
	lda #>logox_table_hi
	adc logox_table_pos + 1
	sta .read2 + 2

.read1
	lda $4444
	sta logoxpositionlo
	
.read2
	lda $4444
	sta logoxpositionhi

	jsr blitLogo
	rts

TEXTPOSSTART = LOGOLINES + 0

textColors SUBROUTINE
	ldy mainCounter
	ldx #39
.nextx
Y SET 0
	REPEAT 3
	lda colorband + 0 + Y * 8,y
	sta $4000 + [Y * 3 + 0 + TEXTPOSSTART] * 40,x
	lda colorband + 1 + Y * 8,y
	sta $4000 + [Y * 3 + 1 + TEXTPOSSTART] * 40,x
	lda colorband + 0 + Y * 8,y
	sta $4000 + [Y * 3 + 2 + TEXTPOSSTART] * 40,x
Y SET Y + 1
	REPEND
	dey
	dex
	bpl .nextx
	rts

TEXTXSIZE	= 2 * 11
TEXTXSTART	= [40-TEXTXSIZE]/2
TEXTXEND	= TEXTXSTART+TEXTXSIZE

initTextScreen SUBROUTINE
	rts


charNumber dc.b $00
textPosition dc.b $00
textYMove1 dc.b $00
textYMove2 dc.b $00
blitChar SUBROUTINE	

	lda charNumber
	asl
	asl
	asl
	asl
	asl
	sta ZP_READ1 + 0

	lda charNumber
	lsr
	lsr
	lsr
	sta ZP_READ1 + 1

	lda ZP_READ1 + 0
	clc
	adc #<TEXTCHARSET
	sta ZP_READ1 + 0
	lda ZP_READ1 + 1
	adc #>TEXTCHARSET
	sta ZP_READ1 + 1


	lda ZP_READ1 + 0
	clc
	adc #<16
	sta ZP_READ2 + 0
	lda ZP_READ1 + 1
	adc #>16
	sta ZP_READ2 + 1

	ldx textPosition
	lda CHARSCREENMULLO,x
	clc
	adc #<[$5000+8]
	sta ZP_WRITE1 + 0
	sta ZP_WRITE2 + 0
	lda CHARSCREENMULHI,x
	adc #>[$5000+8]
	sta ZP_WRITE1 + 1
	sta ZP_WRITE2 + 1

	lda ZP_WRITE2 + 0
	clc
	adc #<24
	sta ZP_WRITE2 + 0
	lda ZP_WRITE2 + 1
	adc #>24
	sta ZP_WRITE2 + 1

	lda ZP_WRITE1 + 0
	clc
	adc textYMove1
	sta ZP_WRITE1 + 0
	lda ZP_WRITE1 + 1
	adc #$00
	sta ZP_WRITE1 + 1

	lda ZP_WRITE2 + 0
	clc
	adc textYMove2
	sta ZP_WRITE2 + 0
	lda ZP_WRITE2 + 1
	adc #$00
	sta ZP_WRITE2 + 1
	
	; clear the pixels around
	lda #$00
	ldy #$00
	sta (ZP_WRITE1),y
	iny
	sta (ZP_WRITE1),y
	lda ZP_WRITE1 + 0
	clc
	adc #<$02
	sta ZP_WRITE1 + 0
	lda ZP_WRITE1 + 1
	adc #>$02
	sta ZP_WRITE1 + 1
	lda #$00
	ldy #16
	sta (ZP_WRITE1),y
	iny
	sta (ZP_WRITE1),y

	lda #$00
	ldy #$00
	sta (ZP_WRITE2),y
	iny
	sta (ZP_WRITE2),y
	lda ZP_WRITE2 + 0
	clc
	adc #<$02
	sta ZP_WRITE2 + 0
	lda ZP_WRITE2 + 1
	adc #>$02
	sta ZP_WRITE2 + 1
	lda #$00
	ldy #16
	sta (ZP_WRITE2),y
	iny
	sta (ZP_WRITE2),y

	ldy #$00
	REPEAT 16
	lda (ZP_READ1),y
	sta (ZP_WRITE1),y
	lda (ZP_READ2),y
	sta (ZP_WRITE2),y
	iny
	REPEND

	rts

currentChar dc.b $00
textScreenPos dc.b $00
frameCounterHere dc.b $00
frameCounterLast dc.b $00
animateTextScreen SUBROUTINE	
	lda frameCounter
	sec
	sbc frameCounterLast
	cmp #$04
	bmi .jo
	lda #$03
.jo
	clc
	adc frameCounterHere
	sta frameCounterHere
	lda frameCounter
	sta frameCounterLast

	lda #$00
	sta currentChar
.nextChar	
	lda currentChar
	asl
	clc
	adc frameCounterHere + 0
	tax
	lda FONTYSIN,x
	sta textYMove1
	sta textYMove2
	inx
	lda FONTYSIN,x
	;sta textYMove2
	lda currentChar
	clc
	adc textScreenPos
	tax
	lda TEXTSCREENS,x
	sta charNumber
	lda currentChar
	sta textPosition
	jsr blitChar
	inc currentChar
	lda currentChar
	cmp #TEXTXSIZE/2 * 3
	bne .nextChar
	rts

scrollPos dc.b $00
scrollPos8 dc.b $10
scroll SUBROUTINE
	inc scrollPos
	lda scrollPos
	and #$07
	beq hardScroll
	rts
hardScroll
	inc scrollPos8
	lda scrollPos8
	and #63
	clc
	adc #39
	tay

	ldx #39
.aloha
Y SET 0
	REPEAT 25-SCROLLYLINE
	lda SCROLLAREACHARS + Y * 128,y
	sta $4400 + [Y + SCROLLYLINE] * 40,x
	lda SCROLLAREACOLOR + Y * 128,y
	sta $4000 + [Y + SCROLLYLINE] * 40,x
Y SET Y + 1
	REPEND
	dey
	dex
	bpl .aloha

	rts


textLineNumber dc.b $00
textLineXPosition dc.b 40
blitScreenTextChars SUBROUTINE

	lda textLineNumber
	asl
	clc
	adc textLineNumber ; * 3
	tax
	lda MUL40LO,x
	clc
	adc #<[TEXTPOSSTART*40+$4400]
	sta .modw1 + 1
	lda MUL40HI,x
	adc #>[TEXTPOSSTART*40+$4400]
	sta .modw1 + 2

	lda .modw1 + 1
	clc
	adc #<40
	sta .modw2 + 1
	lda .modw1 + 2
	adc #>40
	sta .modw2 + 2

	lda .modw2 + 1
	clc
	adc #<40
	sta .modw3 + 1
	lda .modw2 + 2
	adc #>40
	sta .modw3 + 2

	lda MUL128LO,x
	clc
	adc #<[SCREENTEXTCHARS]
	sta .modr1 + 1
	lda MUL128HI,x
	adc #>[SCREENTEXTCHARS]
	sta .modr1 + 2

	lda .modr1 + 1
	clc
	adc textLineXPosition
	sta .modr1 + 1
	lda .modr1 + 2
	adc #$00
	sta .modr1 + 2

	lda .modr1 + 1
	clc
	adc #<128
	sta .modr2 + 1
	lda .modr1 + 2
	adc #>128
	sta .modr2 + 2

	lda .modr2 + 1
	clc
	adc #<128
	sta .modr3 + 1
	lda .modr2 + 2
	adc #>128
	sta .modr3 + 2

	ldx #39
.nextx
.modr1
	lda $4444,x
.modw1
	sta $4444,x
.modr2
	lda $4444,x
.modw2
	sta $4444,x
.modr3
	lda $4444,x
.modw3
	sta $4444,x
	dex
	bpl .nextx
	rts

joyMoveLeft  dc.b $00
joyMoveRight dc.b $00
joyMoveUp	 dc.b $00
joyMoveDown	 dc.b $00
joyPressed   dc.b $00

; 7    Joystick 2 Fire    (0=Pressed, 1=Released)
; 6    Joystick 1 Fire    (0=Pressed, 1=Released)
; 3    Joystick 1/2 Right (0=Moved, 1=Released)
; 2    Joystick 1/2 Left  (0=Moved, 1=Released)
; 1    Joystick 1/2 Down  (0=Moved, 1=Released)
; 0    Joystick 1/2 Up    (0=Moved, 1=Released) 
JOYSTICKSELECT = %00000010 ; select joy 1 (bit 2 = 0) (deselect joy 2 bit 3 = 1)
	SUBROUTINE
.temp dc.b $00
gatherJoystick 
	lda #JOYSTICKSELECT
	sta $ff08
	lda $ff08
	eor #$ff
	sta .temp
	and #$01
	sta joyMoveUp
	lda .temp
	and #$02
	sta joyMoveDown
	lda .temp
	and #$04
	sta joyMoveLeft
	lda .temp
	and #$08
	sta joyMoveRight
	lda .temp
	and #$40
	sta joyPressed 
	rts

godKeys SUBROUTINE
	LDA #$ef
	STA $FD30
	STA $FF08
	LDA $FF08
	AND #[$fe ^ $ff]
  	beq .6 
	rts	
.6
	lda #$01
	sta ZP_CHEAT
	rts

loadScores SUBROUTINE
	ldx #<fileNameHighScore
	ldy #>fileNameHighScore
	LOAD_NORMAL

	ldy #$01
	ldx #$00
.aloha
	tya
	eor HIGHSCORESTUFF,x
	sta HIGHSCORESTUFF,x
	iny
	inx
	cpx #HIGHSCORESTUFFEND - HIGHSCORESTUFF
	bne .aloha
	rts

HIGHSCOREPAGE = 5
LASTPAGE = 5
XPOSNAME = $01
XPOSSCORE = $01 + $04
NUMBEROFFSET = 30
fillInScores SUBROUTINE
	lda #<HIGHSCORESTUFFNAMES
	sta ZP_NAMES + 0
	lda #>HIGHSCORESTUFFNAMES
	sta ZP_NAMES + 1

	lda #<HIGHSCORESTUFFSCORES
	sta ZP_SCORES + 0
	lda #>HIGHSCORESTUFFSCORES
	sta ZP_SCORES + 1

	lda #<[11 * 3 * HIGHSCOREPAGE + TEXTSCREENS + XPOSNAME]
	sta ZP_LOVE + 0
	lda #>[11 * 3 * HIGHSCOREPAGE + TEXTSCREENS + XPOSNAME]
	sta ZP_LOVE + 1

	ldx #$00
.nextx1
	ldy #$00
.nexty1
	lda (ZP_NAMES),y
	sta (ZP_LOVE),y
	iny 
	cpy #$03
	bne .nexty1

	lda ZP_NAMES + 0
	clc
	adc #<3
	sta ZP_NAMES + 0
	lda ZP_NAMES + 1
	adc #>3
	sta ZP_NAMES + 1

	lda ZP_LOVE + 0
	clc
	adc #<11
	sta ZP_LOVE + 0
	lda ZP_LOVE + 1
	adc #>11
	sta ZP_LOVE + 1

	inx 
	cpx #$03
	bne .nextx1

	lda #<[11 * 3 * HIGHSCOREPAGE + TEXTSCREENS + XPOSSCORE]
	sta ZP_LOVE + 0
	lda #>[11 * 3 * HIGHSCOREPAGE + TEXTSCREENS + XPOSSCORE]
	sta ZP_LOVE + 1

	ldx #$00
.nextx2
	ldy #$00
.nexty2
	lda (ZP_SCORES),y
	lsr
	lsr
	lsr
	lsr
	and #$0f
	clc
	adc #NUMBEROFFSET
	sta (ZP_LOVE),y
	iny
	lda ZP_SCORES + 0
	sec
	sbc #<$01
	sta ZP_SCORES + 0
	lda ZP_SCORES + 1
	sbc #>$01
	sta ZP_SCORES + 1

	lda (ZP_SCORES),y
	and #$0f
	clc
	adc #NUMBEROFFSET
	sta (ZP_LOVE),y
	iny 
	cpy #$06
	bne .nexty2

	lda ZP_SCORES + 0
	clc
	adc #<[3+3]
	sta ZP_SCORES + 0
	lda ZP_SCORES + 1
	adc #>[3+3]
	sta ZP_SCORES + 1

	lda ZP_LOVE + 0
	clc
	adc #<11
	sta ZP_LOVE + 0
	lda ZP_LOVE + 1
	adc #>11
	sta ZP_LOVE + 1

	inx 
	cpx #$03
	bne .nextx2

	rts

LOADSONG SUBROUTINE
	lda kp_pattern_counter
.zwo
	cmp kp_pattern_counter
	beq .zwo

	lda #$01
	sta fw_song_off
	lda #$00
	sta $ff11

	ldx #<[SONGMEM_END]
	ldy #>[SONGMEM_END]
	jsr fw_decrunch

	jsr waitFrame

	ldx #<$0cb0
	ldy #>$0cb0
	lda #$01
	jsr fw_initplayer
	lda #$00
	sta kp_pattern_counter

	jsr waitFrame
	lda #$00
	sta fw_song_off
	rts

SONGMEM_START
	incbin "memsong.exo"
SONGMEM_END



	include "fadercode.asm"

; LOGO STUFF
logo_color
	incbin "logolines_color.bin"
logo_screen
	incbin "logolines_screen.bin"
logox_table_lo
	incbin "logoxtablelo.bin"
logox_table_hi
	incbin "logoxtablehi.bin"
logox_table_pos
	dc.w $00

; PARALLAX STUFF
wolkeParallaxData
	incbin "wolke_parallax.bin"
parallaxAdders
	REPEAT 2
Y SET 0
	REPEAT 8
	dc.b 16 * Y
Y SET Y + 1
	REPEND
	REPEND
parallaxX7AdderLo
Y SET 0
	REPEAT 8
	dc.b <[Y * 8*2*8]
Y SET Y + 1
	REPEND
parallaxX7AdderHi
Y SET 0
	REPEAT 8
	dc.b >[Y * 8*2*8]
Y SET Y + 1
	REPEND

frameCounter	dc.w $00
mainCounter		dc.w $00

colorband
	incbin "colshade.bin"

TEXTCHARSET
	incbin "textcharset.bin"

CHARSCREENMULLO
Y SET 0
	REPEAT 256
	dc.b <[Y * 3 * 2 * 8]
Y SET Y + 1
	REPEND

CHARSCREENMULHI
Y SET 0
	REPEAT 256
	dc.b >[Y * 3 * 2 * 8]
Y SET Y + 1
	REPEND

FONTYSIN
	incbin "fontysin.bin"
FONTXSIN
	incbin "fontxsin.bin"

TEXTSCREENS
	incbin "textscreens.bin"

	
SCREENTEXTCHARS
	incbin "screenTextChars.bin"

MUL128LO
Y SET 0
	REPEAT 32
	dc.b <[Y*128]
Y SET Y + 1
	REPEND

MUL128HI
Y SET 0
	REPEAT 32
	dc.b >[Y*128]
Y SET Y + 1
	REPEND

MUL40LO
Y SET 0
	REPEAT 25
	dc.b <[Y*40]
Y SET Y + 1
	REPEND

MUL40HI
Y SET 0
	REPEAT 25
	dc.b >[Y*40]
Y SET Y + 1
	REPEND

	align 256
SCROLLAREACOLOR
	incbin "scroll_data_col.bin"
SCROLLAREACHARS
	incbin "scroll_data_chr.bin"

	ORG MEMPOS_HIGHSCORE - 2
HIGHSCORESTUFF = MEMPOS_HIGHSCORE
	incbin "cleanhighscore.bin"	
HIGHSCORESTUFFNAMES  = HIGHSCORESTUFF
HIGHSCORESTUFFSCORES = HIGHSCORESTUFF + 3 * 10
HIGHSCORESTUFFEND = HIGHSCORESTUFF + 3 * 10 + 3 * 10



	echo "eof: ",.
