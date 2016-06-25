    processor 6502

	include "fw_interface.asm"
	include "macros.asm"
	include "standard.asm"
	include "persistent.asm"

ZP_IRQTEMP = $10
textPointer = $12 ; 2


	; charset
	ORG $4000 
FONT
	incbin "gamefont.bin"
SIDEBARINTERN
	incbin "sidebar.bin"
SIDEBARSTARTCHAR = [SIDEBARINTERN - FONT] / 8
SIDEBARINTERN2
	ORG SIDEBARINTERN2 + SIDEBARSTARTCHAR * 8
	ORG $4800
;--------------------------------------------------------------------
; Hauptprogramm (Init)
;--------------------------------------------------------------------
MAINPRG	
	LDA #$0b
	STA $FF06	
	jsr waitFrame

	lda #$00
	sta $ff15
	lda #$61
	sta $ff16
	lda #$31
	sta $ff17

	; bitmap Adress $2000
	lda $ff12
	and #%11000011 
	ora #%00001000 
	sta $ff12

	lda #>$1800
	sta $ff14

	lda #%10011000 ; we want multicolor
	sta $ff07

	; font Adress $4000
	lda $ff13
	and #%00000101 ; speedmode
	ora #%01000000 ; font $4000
	sta $ff13

	jsr initScreen
	jsr buildSideBar
	ldx #$00
.yeah
Y SET 0
	REPEAT $08
	lda $1800 + Y * $100,x
	sta $2000 + Y * $100,x
Y SET Y + 1
	REPEND
	inx
	bne .yeah

	lda #<TEXT
	sta textPointer + 0
	lda #>TEXT
	sta textPointer + 1

	jsr waitFrame
	jsr waitBorder

	;-------------------------------------------------------------------
	; enable screen
	;-------------------------------------------------------------------
	;lda #%00011011
	;sta $ff06

	;jsr waitFrame


	sei
	lda #<raster_plugin
	sta fw_topirq_plugin + 0
	lda #>raster_plugin
	sta fw_topirq_plugin + 1
	cli

.waitforjoy
	jsr findFirstKeyPress
	bne .somekeypressed
	jsr gatherJoystick 
	lda joyPressed
	beq .waitforjoy

.waitfornotjoy
	jsr gatherJoystick 
	lda joyPressed
	bne .waitfornotjoy
.somekeypressed

	sei
	lda #$00
	sta fw_topirq_plugin + 0
	sta fw_topirq_plugin + 1
	cli
	lda #$0b
	sta $ff06
	jsr waitFrame
	lda #$0b
	sta $ff06
	jsr waitFrame
	lda #$0b
	sta $ff06
	jsr waitFrame
	
	ldx #$00
.nexti
	lda LOADPROCEDURESOURCE,x
	sta LOADPROCEDUREDEST,x
	inx
	bne .nexti
	jmp LOADPROCEDUREDEST

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
	lda #$ff
	sta $fd30
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

DEL = $01
RIG = $02
RET = $03
LFT = $04
ESC = $05
UP	= $06
DOWN = $07

keybordMatrixX  dc.b $fe,$fd,$fb,$f7,$ef,$df,$bf,$7f
keybordMatrixY1 dc.b $fe,$fd,$fb,$f7,$ef,$df,$bf,$7f
keybordMatrixY2 dc.b $01,$02,$04,$08,$10,$20,$40,$80

; D und 6 funktionieren nicht, da die vom Yape verwendet werden um mit Cursorkeys den Joystick zu emulieren
keyboardMatrix
	dc.b DEL,"3","5","7","9",DOWN,LFT,"1"
	dc.b RET,"W","R","Y","I","P","*",$00
	dc.b $00,"A","D"*1+LFT*0,"G","J","L",$00,$00
	dc.b $00,"4","6"*1+RIG*0,"8","0",UP,RIG,"2"
	dc.b $00,"Z","C","B","M",$00,ESC," "
	dc.b $00,"S","F","H","K",$00,"=",$00
	dc.b $00,"E","T","U","O","-","+","q"
	dc.b $00,$00,"X","V","N","<","/",ESC

findFirstKeyPress
	ldy #$00
.nexty
	ldx #$00
.nextx
	lda keybordMatrixX,x
	sta $fd30 ; Write to Keyboard Matrix
	sta $ff08 ; Write to Keyboard Latch
	lda $ff08 ; Read from Keyboard Latch
	and keybordMatrixY2,y
	beq .pressed
	inx 
	cpx #$08
	bne .nextx
	iny
	cpy #$08
	bne .nexty
	lda #$00
	rts
.pressed
	tya
	asl
	asl
	asl
	sta .readoutAdd + 1
	txa
	clc
.readoutAdd
	adc #$44
	tax
	lda keyboardMatrix,x
	rts


	include "player_symbols.asm"
	include "player_clear_real.asm"

FNAME dc.b "ED",0
MNAME dc.b "ESS",0

LOADPROCEDUREDEST = $2000
LOADPROCEDURESOURCE

	ldx #<FNAME
	ldy #>FNAME
	LOAD_NORMAL
	ldx fw_load_end + 0
	ldy fw_load_end + 1
	jsr fw_decrunch

	lda #$01
.waitb
	bit $ff1c
	beq .waitb
.waita
	bit $ff1c
	bne .waita

	sei
	jsr songoff
	ldx #<MNAME
	ldy #>MNAME
	LOAD_NORMAL
	ldx fw_load_end + 0
	ldy fw_load_end + 1
	jsr fw_decrunch
	
	ldx #<MEMPOS_STANDARD_SONG
	ldy #>MEMPOS_STANDARD_SONG

	lda #$01
	jsr fw_initplayer
	jsr kp_clear

	cli

	lda #$00
	sta kp_pattern_counter

	lda #$00
	sta fw_song_off

	jmp ENTRYPOINT_ENDSCENE


; -----------------------------------------------------------------------
initScreen SUBROUTINE
; -----------------------------------------------------------------------
	ldx #$00
.nextx
	lda #$71
	sta $1800,x
	sta $1900,x
	sta $1a00,x
	sta $1b00,x
	lda #$00
	sta $1c00,x
	sta $1d00,x
	sta $1e00,x
	sta $1f00,x
	inx
	bne .nextx

	rts


sidebarColors dc.b $01+$08,$01+$08,$01+$08,$21+$08,$21+$08,$01+$08
; -----------------------------------------------------------------------
buildSideBar SUBROUTINE
; -----------------------------------------------------------------------
	
	lda #SIDEBARSTARTCHAR
	sta .xadd + 1

	ldx #$00
.nextx
	txa
	clc
	adc #<[$1c00 + 0]
	sta .leftwrite + 1
	sta .leftwriteCol + 1
	lda #$00
	adc #>[$1c00 + 0]
	sta .leftwrite + 2
	sec
	sbc #$04
	sta .leftwriteCol + 2

	txa
	sta .sub + 1
	lda #<[$1c00 + 39]
	sec
.sub
	sbc #$44
	sta .rightwrite + 1
	sta .rightwriteCol + 1
	lda #>[$1c00 + 39]
	sbc #$00
	sta .rightwrite + 2
	sec
	sbc #$04
	sta .rightwriteCol + 2

	ldy #$00
.nexty
	tya
	and #$03
	clc
.xadd
	adc #$44
.leftwrite
	sta $4444
	clc
	adc #24
.rightwrite
	sta $4444
.inc
	lda sidebarColors	
.leftwriteCol
	sta $4444
.rightwriteCol
	sta $4444

	lda .leftwrite + 1
	clc
	adc #<40
	sta .leftwrite + 1
	sta .leftwriteCol + 1
	lda .leftwrite + 2
	adc #>40
	sta .leftwrite + 2
	sec
	sbc #$04
	sta .leftwriteCol + 2

	lda .rightwrite + 1
	clc
	adc #<40
	sta .rightwrite + 1
	sta .rightwriteCol + 1
	lda .rightwrite + 2
	adc #>40
	sta .rightwrite + 2
	sec
	sbc #$04
	sta .rightwriteCol + 2

	iny
	cpy #25
	beq .nonexty
	jmp .nexty
.nonexty

	lda .xadd + 1
	clc
	adc #4
	sta .xadd + 1

	lda .inc + 1
	clc
	adc #<$01
	sta .inc + 1
	lda .inc + 2
	adc #>$01
	sta .inc + 2


	inx
	cpx #$06
	beq .nonextx
	jmp .nextx
.nonextx

	rts

; -----------------------------------------------------------------------
waitFrame SUBROUTINE
; -----------------------------------------------------------------------
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
.waita
	bit $ff1c
	bne .waita
	rts

; -----------------------------------------------------------------------
waitBorder SUBROUTINE
; -----------------------------------------------------------------------
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
	rts

; -----------------------------------------------------------------------
raster_plugin SUBROUTINE 
; -----------------------------------------------------------------------
	lda #<rasterIrqTop
	sta $fffe 
	lda #>rasterIrqTop
	sta $ffff 
	lda #2  ;raster irq 
	sta $ff0a 
	lda #$00; rasterline 
	sta $ff0b
	PLUGIN_CANCELDEFAULT 
	rts 

; -----------------------------------------------------------------------
rasterIrqTop SUBROUTINE
; -----------------------------------------------------------------------
	pha
	txa
	pha
	tya
	pha

	jsr switchFrame

	lda #<rasterIrqBottom
	sta $fffe 
	lda #>rasterIrqBottom
	sta $ffff 
	lda #$d0; rasterline 
	sta $ff0b

	inc $ff09
	cli

	jsr scroll

	pla
	tay
	pla
	tax
	pla
	rti

; -----------------------------------------------------------------------
switchFrame SUBROUTINE
; -----------------------------------------------------------------------
	lda doubleBuffer
	eor #$01
	sta doubleBuffer
	beq .number1
	lda #$18
	sta $ff14
	lda #<$2400
	sta screenWrite + 0
	lda #>$2400
	sta screenWrite + 1
	rts
.number1
	lda #$20
	sta $ff14
	lda #<$1c00
	sta screenWrite + 0
	lda #>$1c00
	sta screenWrite + 1
	rts

ff06val dc.b $00
doubleBuffer dc.b $00
screenWrite dc.w $1c00

; -----------------------------------------------------------------------
rasterIrqBottom SUBROUTINE
; -----------------------------------------------------------------------
	pha
	txa
	pha
	tya
	pha

	inc $ff09
	jsr fw_lowirq_handler
	cli

	jsr animateSideBar
	jsr drawSideBar2
	jsr drawSideBar1

	lda ff06val
	sta $ff06

	pla
	tay
	pla
	tax
	pla
	rti


sideBarPositionsLo ds.b $06,$00
sideBarPositionsHi ds.b $06,$00

sideBarHiLoAdder 
	dc.w $80
	dc.w $60
	dc.w $20
; -----------------------------------------------------------------------
animateSideBar SUBROUTINE
; -----------------------------------------------------------------------

	lda sideBarPositionsLo + 0
	sec
	sbc sideBarHiLoAdder + 0 * 2 + 0
	sta sideBarPositionsLo + 0
	lda sideBarPositionsHi + 0
	sbc sideBarHiLoAdder + 0 * 2 + 1
	sta sideBarPositionsHi + 0
	sta sideBarPositionsHi + 1
	sta sideBarPositionsHi + 2

	lda sideBarPositionsLo + 3
	sec
	sbc sideBarHiLoAdder + 1 * 2 + 0
	sta sideBarPositionsLo + 3
	lda sideBarPositionsHi + 3
	sbc sideBarHiLoAdder + 1 * 2 + 1
	sta sideBarPositionsHi + 3
	sta sideBarPositionsHi + 4

	lda sideBarPositionsLo + 5
	sec
	sbc sideBarHiLoAdder + 2 * 2 + 0
	sta sideBarPositionsLo + 5
	lda sideBarPositionsHi + 5
	sbc sideBarHiLoAdder + 2 * 2 + 1
	sta sideBarPositionsHi + 5
	rts

; -----------------------------------------------------------------------
	SUBROUTINE
.currentColumn dc.b $00
drawSideBar1
; -----------------------------------------------------------------------
	lda #$00
	sta .currentColumn
.nextx	
	jsr drawSideBarIntern

	inc .currentColumn
	lda .currentColumn
	cmp #$05
	bne .nextx
	rts

drawSideBar2
; -----------------------------------------------------------------------
	lda #$05
	sta .currentColumn

	jsr drawSideBarIntern
	rts

drawSideBarIntern
	lda .currentColumn
	asl
	asl
	asl
	asl
	asl ; * 32
	sta .element + 1
	tax
	ldy .currentColumn
	lda sideBarPositionsHi,y
	clc
	adc softScrollY
	and #31
	ora .element + 1
	tay

	lda #32
	sta ZP_IRQTEMP

.nexty
	lda SIDEBAR,y
	sta SIDEBARINTERN,x
	lda SIDEBAR2,y
	sta SIDEBARINTERN2,x
	iny
	tya
	and #31
.element
	ora #$44
	tay
	inx
	dec ZP_IRQTEMP
	bne .nexty
	rts


softScrollY dc.b $00
softScrollDelay dc.b $00
hardScrollInit dc.b $00
scroll SUBROUTINE

	inc softScrollDelay
	lda softScrollDelay
	and #$03
	beq .doSoftScroll
	jmp .done
.doSoftScroll

	dec softScrollY

	lda softScrollY
	and #$07
	sta softScrollY
	ora #%00010000
	sta ff06val

	lda softScrollY
	cmp #$07
	bne .noHardScroll
	lda #$02
	sta hardScrollInit
.noHardScroll

.done
	lda hardScrollInit
	beq .noRealHardScroll
	jsr hardScroll
	dec hardScrollInit
	bne .notinc
	lda textPointer + 0
	clc
	adc #<28
	sta textPointer + 0
	lda textPointer + 1
	adc #>28
	sta textPointer + 1
	ldy #$00
	lda (textPointer),y
	cmp #$ff
	bne .notinc
	lda #<TEXT
	sta textPointer + 0
	lda #>TEXT
	sta textPointer + 1
.notinc
.noRealHardScroll

	rts

hardScroll SUBROUTINE
	lda doubleBuffer
	bne .number2
	jsr hardScroll1
	jmp blitLowLine1
.number2
	jsr hardScroll2
	jmp blitLowLine2

hardScroll1 SUBROUTINE
X SET 0
	REPEAT $04
	ldx #39-6*2
RELOOP SET .
Y SET 0
	REPEAT $06
Z SET [X*6+Y]
	lda $1c00 + 40 * [Z+1]+6,x
	sta $1c00 + 40 * Z+6,x
Y SET Y + 1
	REPEND
	dex
	bpl RELOOP
X SET X + 1
	REPEND
	rts

hardScroll2 SUBROUTINE
X SET 0
	REPEAT $04
	ldx #39-6*2
RELOOP SET .
Y SET 0
	REPEAT $06
Z SET [X*6+Y]
	lda $2400 + 40 * [Z+1]+6,x
	sta $2400 + 40 * Z+6,x
Y SET Y + 1
	REPEND
	dex
	bpl RELOOP
X SET X + 1
	REPEND
	rts

blitLowLine1 SUBROUTINE

	lda textPointer + 0
	sta .read + 1
	lda textPointer + 1
	sta .read + 2
	
	ldx #27
.yo
.read
	lda $4444,x
	sta $1c00 + 40 * 24 + 6,x
	dex
	bpl .yo
	
	rts

blitLowLine2 SUBROUTINE

	lda textPointer + 0
	sta .read + 1
	lda textPointer + 1
	sta .read + 2
	
	ldx #27
.yo
.read
	lda $4444,x
	sta $2400 + 40 * 24 + 6,x
	dex
	bpl .yo
	
	rts

SIDEBAR
	incbin "sidebar.bin"
SIDEBAR2
	incbin "sidebar2.bin"
TEXT
	include "text.inc"