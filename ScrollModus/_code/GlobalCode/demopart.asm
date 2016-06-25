    processor   6502

    include "memorylayout.inc"
	include "fw_interface.asm"
	include "constants.inc"
	include "persistent.asm"

DISPLAYAREAROWS = 25
SCREENBUFFER1 = $1800
SCREENBUFFER2 = $6000

OPCODE_RTS = $60
OPCODE_NOP = $1a
OPCODE_EOR_ABS_X = $5d 
OPCODE_STA_ABS_X = $9d 
OPCODE_BMI = $30
OPCODE_BPL = $10

ZP_READ_LUMA					= $10 ; 2
ZP_READ_COLOR					= $12 ; 2
ZP_READ_BITMAP					= $14 ; 2

ZP_WRITE_LUMA					= $16 ; 2
ZP_WRITE_COLOR					= $18 ; 2
ZP_WRITE_BITMAP					= $1a ; 2
ZP_WRITE_BITMAP_SAVE			= $1c ; 2
ZP_WRITE_BITMAP2				= $1e ; 2

ZP_WRITE_LUMA_SAVE				= $2c ; 2

ZP_TEMP_TILEADR					= $30 ; 1
ZP_TEMP_SUBTILEADR				= $31 ; 1

blockLevelX						= $32 ; 1
blockLevelY						= $33 ; 1
rectFlags						= $34 ; 1
BLOCKREADADR					= $35 ; 2
gameObjectT1					= $37 ; 2 ; collision testing
gameObjectT2					= $39 ; 2

collisionFlagRectXS				= $3b ; 4
collisionFlagRectYS				= $3f ; 4
collisionFlagRectXE				= $43 ; 4
collisionFlagRectYE				= $47 ; 4

ZP_ENEMYX_XARRAYINDEX			= $50 ; 2
ZP_ENEMYX_EARRAYINDEX			= $52 ; 2
ZP_ENEMYX_COUNT					= $54 ; 2
ZP_ENEMYY_ENEMYTYPE				= $56 ; 2
ZP_ENEMYY_YPOSITION				= $58 ; 2

ff1avalue						= $5a ; 1
ff1bvalue					    = $5b ; 1

ZP_SPRITES						= $60 ; 2
ZP_SPRITE_STRUCT_ADR			= $62 ; 2
ZP_SPECIAL						= $64 ; 1
ZP_SPRITE_DATA					= $65 ; 2
ZP_SCREENBLITADDRESS			= $67 ; 2

ZP_SPRITE_YCOUNT				= $69 ; 1
ZP_SPRITE_YREG					= $6a ; 1
ZP_RIGHT_BYTE					= $6b ; 2
ZP_LEFT_BYTE					= $6d ; 2
ZP_SPRITE_BUFFER				= $6f ; 2
ZP_Y_LENGTH						= $71 ; 1
ZP_BYTE							= $72 ; 2
ZP_SCREENBLITWRITE				= $74 ; 2

ZP_TEXTSCREENREAD				= $76 ; 2
ZP_NEXTGRADIENTCOLOR			= $78 ; 1
ZP_NEXTGRADIENTPOS				= $79 ; 1
ZP_GRADIENTPOSDIV4				= $7a ; 1
ZP_GRADIENTPOSAND7				= $7b ; 1
ZP_IRQXSAVE						= $7c ; 1
ZP_WRITE_BITMAP_PAUSE			= $7d ; 2

	MAC incWord
	inc {1}+0
	bne .nohi
	inc {1}+1
.nohi
	ENDM

	MAC decWord
	lda {1}+0
	sec
	sbc #$01
	sta {1}+0
	lda {1}+1
	sbc #$00
	sta {1}+1
.nohi
	ENDM

	;ORG $1800
	;ORG $2000
	;ORG $4000

	ORG EPOINT_WORLD_FIRST_CODE	; 6800				
	jmp MAINPRG
; aligned hardscroll function must be aligned sucking selfmodifiying code
	include "hardscrollaligned.asm"

MAINPRG SUBROUTINE
	;-------------------------------------------------------------------
	; font adress 3800
	;-------------------------------------------------------------------
	lda $ff13
	and #%00000101
	ora #%00111000 ; bit 2=1 auf slow 
	sta $ff13

	lda #$03
	sta ZP_LIVES

	lda #$0b
	sta $ff06
	jsr waitFrame
	lda BACKGROUNDCOLOR
	sta $ff15
	lda FOREGROUNDCOLOR
	sta $ff16

	lda #FULLENERGY
	sta ZP_ENERGY
	;lda #$09
	;sta ZP_LIVES
	;lda #$00
	;sta ZP_BALLS

	lda #$00
	sta mainLoopCounter + 0
	sta mainLoopCounter + 1
	sta frameCounter + 0
	sta frameCounter + 1
	sta quitFlag

	sta ff06value
	sta ff07value
	sta ff1avalue
	sta ff1bvalue
	lda #$18
	sta ff14value

	sei
	lda #$00
	sta fw_topirq_plugin + 0
	sta fw_topirq_plugin + 1
	cli
	
	jsr waitFrame

	lda #$0b
	sta $ff06

	;-------------------------------------------------------------------
	; bitmap adress 2000 - bitmap from ram - prevail voice frequencies
	;-------------------------------------------------------------------
	lda $ff12
	and #%11000011 
	ora #%00001000 
	sta $ff12

	lda #%00011000 ; adress 1800 ff14
	sta $ff14

	lda #$01 
	sta doubleBuffer
	jsr initSpriteSubsystem


	lda frameCounter + 0
	sta lastFrameCounterGameLogik + 0
	lda frameCounter + 1
	sta lastFrameCounterGameLogik + 1

	lda #<SCREENBUFFER1
	sta currentScreenBuffer1 + 0
	lda #>SCREENBUFFER1
	sta currentScreenBuffer1 + 1
	lda #<SCREENBUFFER2
	sta currentScreenBuffer2 + 0
	lda #>SCREENBUFFER2
	sta currentScreenBuffer2 + 1
	lda #>$2000
	sta BITMAPSCREENHI
	lda #$00
	sta scrollPosXDiv4
	sta scrollPosYDiv8
	sta scrollPosXDesired + 0
	sta scrollPosXDesired + 1
	sta scrollPosYDesired + 0
	sta scrollPosYDesired + 1
	sta scrollPosXCurrent + 0
	sta scrollPosXCurrent + 1
	sta scrollPosYCurrent + 0
	sta scrollPosYCurrent + 1
	sta currentHardScrollPosX
	sta currentHardScrollPosY
	sta hardscrollX
	sta hardscrollY
	sta wasHardScroll
	sta scrollLo
	sta scrollHi
	sta scrollFineX
	sta scrollFineY
	sta LEVELPAINTFUCENABLED
	sta goalNextTextScreen
	sta goalTextScreenNr

	lda #>$2000
	sta lastBitmapHigh
	lda #>$4000
	sta curBitmapHigh

	lda PLAYERSTARTPOSX + 0
	sta GameObjectXPosLo + PLAYERGAMEOBJECT
	lda PLAYERSTARTPOSX + 1
	sta GameObjectXPosHi + PLAYERGAMEOBJECT

	lda PLAYERSTARTPOSY + 0
	sta GameObjectYPosLo + PLAYERGAMEOBJECT
	lda PLAYERSTARTPOSY + 1
	sta GameObjectYPosHi + PLAYERGAMEOBJECT

	; setup screen and level
	jsr initializeGameObjectsFull ; because of persistent items
	jsr newLiveInit

	lda #$01
	sta layersNoSound

	ldx #$00
.nextLayer
	txa
	jsr updateLayer
	inx
	cpx #LAYERCOUNT
	bne .nextLayer

	lda #$00
	sta layersNoSound

	lda #TEXTSCREEN_LEVELSTART
	sta textScreenNumber
	jsr displayTextScreen

	jsr waitFrame

	lda rasterValuesPerLevelModifier + 0
	sta levelGradientJsr + 1
	lda rasterValuesPerLevelModifier + 1
	sta levelGradientJsr + 2

	sei
	lda #<raster_plugin
	sta fw_topirq_plugin + 0
	lda #>raster_plugin
	sta fw_topirq_plugin + 1
	cli

mainLoop

	lda frameCounter + 0
	sec
	sbc lastFrameCounterGameLogik + 0
	sta gameLogikSteps

	lda frameCounter + 0
	sta lastFrameCounterGameLogik + 0
	lda frameCounter + 1
	sta lastFrameCounterGameLogik + 1
	
	lda gameLogikSteps
	beq .nogameLogik
.anothergamelogikstep
	jsr gatherJoystick
	jsr gameLogik
	dec gameLogikSteps
	bne .anothergamelogikstep
.nogameLogik
	jsr gameLogikPerBlit

	lda quitFlag
	bne .quit

	jsr scroll

	incWord mainLoopCounter
	jmp mainLoopDeferred

.quit
	cmp #QUITFLAG_LOADGAMEOVER
	bne .notGameOver
	jmp LOADGAMEOVER
.notGameOver
	cmp #QUITFLAG_LOADNEXTLEVEL
	bne .notNextLevel
	jmp LOADNEXTLEVEL
.notNextLevel
.dunno
	inc $ff19
	jmp .dunno

	rts

waitFrame SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
.waita
	bit $ff1c
	bne .waita
	rts

waitUntilBorder SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	bne .waitb
.waita
	bit $ff1c
	beq .waita
	rts

raster_plugin SUBROUTINE 
	lda #<rasterIrqTop
	sta $fffe 
	lda #>rasterIrqTop 
	sta $ffff 
	lda #2  ;raster irq 
	sta $ff0a 
	lda #$00 
	sta $ff0b
	PLUGIN_CANCELDEFAULT 
	rts 

startGradientPos dc.w $0000
startGradientPosIntern dc.w $0000
startGradientPosIntern2 dc.w $0000
rasterTemp dc.b $00

rasterIrqTop SUBROUTINE
	pha
	lda ff1bvalue
	sta $ff1b
	lda ff1avalue
	sta $ff1a
	stx ZP_IRQXSAVE
	tya
	pha

levelGradientJsr
	jsr $4444

	lda startGradientPosIntern2 + 0
	lsr
	lsr
	eor #$ff
	and #$03
	sta ZP_GRADIENTPOSAND7
	lda startGradientPosIntern2 + 0
	lsr
	lsr

	lsr
	lsr
	sta ZP_GRADIENTPOSDIV4
	ldx startGradientPosIntern2 + 1
	lda MUL8LO,x ; * 16
	asl
	ora ZP_GRADIENTPOSDIV4
	sta ZP_GRADIENTPOSDIV4

	pla
	tay ; y doesn't get saved in applynextgradient

	lda screenFixed
	beq .normalscrollbehaviour ; don't use y here
	jmp RASTERIRQBOTTOMSET
.normalscrollbehaviour
	lda #<rasterIrqGradient
	sta $fffe 
	lda #>rasterIrqGradient
	sta $ffff 
	lda ZP_GRADIENTPOSAND7
	clc
	adc #$03 ; update the rasterbar flicker prevention in clampscrollposdesired aswell
	sta ZP_NEXTGRADIENTPOS
	ldx ZP_GRADIENTPOSDIV4
	lda gradient,x
	sta ZP_NEXTGRADIENTCOLOR
	sta $ff15
	inc $ff09
	inc ZP_NEXTGRADIENTPOS
	txa
	and #$01
	beq .no
	dec ZP_NEXTGRADIENTPOS
.no
	jmp applyNextGradient

ENDRASTERLINE = 198

rasterIrqGradient SUBROUTINE
	; here is a badline flickering bug if the character doesn't be on a div8 position
	; the flickering is not visible if we ensure that the character stays on the ground most of the times
	; and the level is clipped rightly
	; we use a flicker prevention in clamp scrollpos desired
	pha
	lda $ff1e
	bmi .a
	stx ZP_IRQXSAVE
	ldx ZP_GRADIENTPOSDIV4
	txa
	and #$01
	asl
	adc #$03
	adc ZP_NEXTGRADIENTPOS
	pha
	inc $ff09
	lda ZP_NEXTGRADIENTCOLOR
	sta $ff15
	pla
	bne .jumpin2
	beq .jumpin2
.a

	lda ZP_NEXTGRADIENTCOLOR
	sta $ff15
	
	inc $ff09

	stx ZP_IRQXSAVE

	ldx ZP_GRADIENTPOSDIV4
	bne .jumpin
	beq .jumpin

applyNextGradient 
.nextGradient
	lda gradient,x
	cmp ZP_NEXTGRADIENTCOLOR
	bne .newGradient
.jumpin
	txa
	and #$01
	asl
	adc #$03
	adc ZP_NEXTGRADIENTPOS
.jumpin2
	cmp #ENDRASTERLINE
	bcs .nextIsBottom
	sta ZP_NEXTGRADIENTPOS
	inx
	bne .nextGradient
.newGradient
	sta ZP_NEXTGRADIENTCOLOR
	stx ZP_GRADIENTPOSDIV4
	; put second one on
	lda ZP_NEXTGRADIENTPOS
	sta $ff0b
	ldx ZP_IRQXSAVE
	pla
	rti

RASTERIRQBOTTOMSET
.nextIsBottom
	; put second one on
	lda #<rasterIrqBottom
	sta $fffe 
	lda #>rasterIrqBottom
	sta $ffff 
	lda $ff1d
	cmp #ENDRASTERLINE
	bcs .yo
	lda #ENDRASTERLINE
.yo
	clc
	adc #$02
	sta $ff0b
	ldx ZP_IRQXSAVE
	pla
	rti


songdoublespeeder dc.b $00

rasterIrqBottom SUBROUTINE
	pha
	txa
	pha
	tya
	pha

	incWord frameCounter

	inc songdoublespeeder
	lda song_double_speed
	beq .notdoublespeed
	lda songdoublespeeder
	and #$03
	bne .notdoublespeed
	lda kp_tickstonextbeat
	beq .notdoublespeed
	dec kp_tickstonextbeat
.notdoublespeed

	lda updateDoubleBuffer
	beq .dontupdate
	jsr updateScrollIrq
	jsr fw_lowirq_handler
	lda updateDoubleBuffer
	cmp #$02
	bne .dont
	lda #$03
	sta updateDoubleBuffer
	inc $ff09
	cli
	jsr hardScrollBitmapUpDown
	jsr hardScrollBitmapLeftRight
.dont
	lda #$00
	sta updateDoubleBuffer
	jmp .dontupdate2
.dontupdate
	inc $ff09
	jsr fw_lowirq_handler
.dontupdate2

	pla
	tay
	pla
	tax
	pla
	rti

;blockLevelX dc.b $00 now at zeropage
;blockLevelY dc.b $00 now at zeropage
;--------------------------------------------------------------
; clipsTheRect on the screen for clearing
; input is blockLevelX,blockLevelY
; modifies x,y (can be speed up later through tables)
;--------------------------------------------------------------
getBlockAtXY SUBROUTINE
	lax blockLevelY
	lsr
	lsr
	sta .tileAdr + 1
	txa
	and #$03
	ldx blockLevelX
	ora AND3ASLASL,x
	pha
	ldy DIV4MUL64TAB64MAPLO,x
	lda DIV4MUL64TAB64MAPHI,x
	sta .tileAdr + 2
.tileAdr
	ldx $4400,y ; we have the tile now mul16
	pla
	ora TILEADRLO,x
	sta BLOCKREADADR + 0
	lda TILEADRHI,x
	sta BLOCKREADADR + 1
	rts

; the original rectangle
rectLevelXS dc.b $00
rectLevelYS dc.b $00
rectLevelXE dc.b $04
rectLevelYE dc.b $04

; the resulting clipped rectangle
rectLevelXSClipped dc.b $00
rectLevelYSClipped dc.b $00
rectLevelXEClipped dc.b $00
rectLevelYEClipped dc.b $00

; the scrollpos to clip the rectangle (screensize as dimension)
rectClipScrollPosX dc.b $00
rectClipScrollPosY dc.b $00

; the flags collected for this rectangle
;rectFlags dc.b $00 ; NOW ZEROPAGE

;--------------------------------------------------------------
; clipsTheRect on the screen for clearing
; accu != 0 if painted
;--------------------------------------------------------------
	SUBROUTINE
.rectClipScrollPosXRight	dc.b $00
.rectClipScrollPosYDown		dc.b $00
clipRect 

	;--------------------------------------
	; earlyOutTest
	;--------------------------------------
	lda rectLevelXE
	cmp rectClipScrollPosX
	beq .xfullclipped
	bcs .xinsideleft
.xfullclipped
	lda #$00
	rts
.xinsideleft

	lda rectLevelYE
	cmp rectClipScrollPosY
	beq .yfullclipped
	bcs .yinsideup
.yfullclipped
	lda #$00
	rts
.yinsideup

	lda rectClipScrollPosX
	clc
	adc #40
	sta .rectClipScrollPosXRight

	lda rectLevelXS
	cmp .rectClipScrollPosXRight
	bcc .xinsideright
	lda #$00
	rts
.xinsideright

	lda rectClipScrollPosY
	clc
	adc #DISPLAYAREAROWS
	sta .rectClipScrollPosYDown

	lda rectLevelYS
	cmp .rectClipScrollPosYDown
	bcc .yinsidedown
	lda #$00
	rts
.yinsidedown


	;--------------------------------------
	; partial clipping
	;--------------------------------------
	lda rectLevelXS
	cmp rectClipScrollPosX
	bpl .nothalveclippedleft
	lda rectClipScrollPosX
.nothalveclippedleft
	sta rectLevelXSClipped

	lda rectLevelYS
	cmp rectClipScrollPosY
	bpl .nothalveclippedup
	lda rectClipScrollPosY
.nothalveclippedup
	sta rectLevelYSClipped

	lda rectLevelXE
	cmp .rectClipScrollPosXRight
	bmi .nothalveclippedright
	lda .rectClipScrollPosXRight
.nothalveclippedright
	sta rectLevelXEClipped

	lda rectLevelYE
	cmp .rectClipScrollPosYDown
	bmi .nothalveclippeddown
	lda .rectClipScrollPosYDown
.nothalveclippeddown
	sta rectLevelYEClipped

	lda #$01
	rts
	; sizecheck is disabled now

	;--------------------------------------
	; size check
	;--------------------------------------
	lda rectLevelXEClipped
	cmp rectLevelXSClipped
	beq .fulloutx
	bpl .notfulloutx
.fulloutx
	lda #$00
	rts	
.notfulloutx

	lda rectLevelYEClipped
	cmp rectLevelYSClipped
	beq .fullouty
	bpl .notfullouty
.fullouty
	lda #$00
	rts	
.notfullouty

	lda #$01
	rts

;--------------------------------------------------------------
; restoreRect restores a rect on the screen
;--------------------------------------------------------------
	SUBROUTINE
.xcount dc.b $00
.ycount dc.b $00
.readBlockSave dc.w $0000
.blockScreenX dc.b $00
.blockScreenY dc.b $00
.xCountSave dc.b $00
restoreRect 
	lda scrollPosXDiv4
	sta rectClipScrollPosX
	lda scrollPosYDiv8
	sta rectClipScrollPosY
	
	jsr clipRect
	cmp #$00
	bne .wehavesomethingtorestore
	rts
.wehavesomethingtorestore

	lda rectLevelXSClipped
	sta blockLevelX
	sta .blockScreenX
	lda rectLevelYSClipped
	sta blockLevelY
	sta .blockScreenY
	jsr getBlockAtXY

	ldy .blockScreenY
	ldx .blockScreenX
	lda MUL320LO,y
	clc
	adc MUL8LO,x
	sta ZP_WRITE_BITMAP_SAVE + 0
	lda MUL320HI,y
	adc MUL8HI,x
	and #$1f
	ora BITMAPSCREENHI
	sta ZP_WRITE_BITMAP_SAVE + 1

	lda BLOCKREADADR + 0 ; from getBlockAtXY
	sta .readBlockSave + 0
	lda BLOCKREADADR + 1 ; from getBlockAtXY
	sta .readBlockSave + 1

	lda ZP_WRITE_BITMAP_SAVE + 0
	sta ZP_WRITE_BITMAP + 0
	lda ZP_WRITE_BITMAP_SAVE + 1
	sta ZP_WRITE_BITMAP + 1
	
	lda rectLevelYEClipped
	sec
	sbc rectLevelYSClipped
	sta .ycount

	lda rectLevelXEClipped
	sec
	sbc rectLevelXSClipped
	sta .xCountSave

.reloopy
	
	lda .xCountSave
	sta .xcount
	clc

.reloopx
	;---------------------------------
	;- block loop					--
	;---------------------------------
	ldy #$00
	lax (BLOCKREADADR),y

	lda MUL8LO,x
	sta ZP_READ_BITMAP + 0
	lda MUL8HI,x
	adc #>FONT
	sta ZP_READ_BITMAP + 1

	REPEAT $07
	lda (ZP_READ_BITMAP),y
	sta (ZP_WRITE_BITMAP),y
	iny
	REPEND
	lda (ZP_READ_BITMAP),y
	sta (ZP_WRITE_BITMAP),y

	; increment write pointers
	lda ZP_WRITE_BITMAP + 0
	adc #<$08
	sta ZP_WRITE_BITMAP + 0
	bcc .nocarry
	lda ZP_WRITE_BITMAP + 1
	adc #>$08
	and #$1f
	ora BITMAPSCREENHI
	sta ZP_WRITE_BITMAP + 1
.nocarry

	inc blockLevelX
	lda BLOCKREADADR + 0
	adc #$04
	sta BLOCKREADADR + 0
	and #%00001100
	bne .notnexttilex
	jsr getBlockAtXY
	clc
.notnexttilex

	dec .xcount
	bne .reloopx

	dec .ycount
	beq .noreloopy
	
	lda rectLevelXSClipped
	sta blockLevelX

	inc blockLevelY

	; find a way for this again (if there are problems with the level update disable this again
	lda .readBlockSave + 1
	sta BLOCKREADADR + 1
	lda .readBlockSave + 0
	clc
	adc #$01
	sta BLOCKREADADR + 0
	sta .readBlockSave + 0
	and #%00000011
	bne .notnexttiley
	jsr getBlockAtXY
	lda BLOCKREADADR + 0 ; from getBlockAtXY
	sta .readBlockSave + 0
	lda BLOCKREADADR + 1 ; from getBlockAtXY
	sta .readBlockSave + 1
.notnexttiley

	lda ZP_WRITE_BITMAP_SAVE + 0
	clc
	adc #<320
	sta ZP_WRITE_BITMAP_SAVE + 0
	sta ZP_WRITE_BITMAP + 0
	lda ZP_WRITE_BITMAP_SAVE + 1
	adc #>320
	and #$1f
	ora BITMAPSCREENHI
	sta ZP_WRITE_BITMAP_SAVE + 1
	sta ZP_WRITE_BITMAP + 1
	clc

	jmp .reloopy
.noreloopy

; here no more code should be placed, since a conditional rts(nop) above could make this code unreachable

	rts

;--------------------------------------------------------------
; restoreRectColor restores a rect on the screen in colorram
;--------------------------------------------------------------
	SUBROUTINE
.xcount dc.b $00
.ycount dc.b $00
.readBlockSave dc.w $0000
.blockScreenX dc.b $00
.blockScreenY dc.b $00
.xCountSave dc.b $00
restoreRectColor 
	lda scrollPosXDiv4
	sta rectClipScrollPosX
	lda scrollPosYDiv8
	sta rectClipScrollPosY
	
	jsr clipRect
	cmp #$00
	bne .wehavesomethingtorestore
	rts
.wehavesomethingtorestore

	lda rectLevelXSClipped
	sta blockLevelX
	sec
	sbc scrollPosXDiv4
	sta .blockScreenX
	lda rectLevelYSClipped
	sta blockLevelY
	sec
	sbc scrollPosYDiv8
	sta .blockScreenY
	jsr getBlockAtXY

	ldy .blockScreenY
	lda MUL40LO,y
	clc
	adc .blockScreenX
	sta ZP_WRITE_LUMA_SAVE + 0
	lda MUL40HI,y
	adc currentScreenBuffer1 + 1
	sta ZP_WRITE_LUMA_SAVE + 1

	lda BLOCKREADADR + 0 ; from getBlockAtXY
	sta .readBlockSave + 0
	lda BLOCKREADADR + 1 ; from getBlockAtXY
	sta .readBlockSave + 1

	lda ZP_WRITE_LUMA_SAVE + 0
	sta ZP_WRITE_LUMA + 0
	sta ZP_WRITE_COLOR + 0
	lda ZP_WRITE_LUMA_SAVE + 1
	sta ZP_WRITE_LUMA + 1
	clc
	adc # $04
	sta ZP_WRITE_COLOR + 1
	
	lda rectLevelYEClipped
	sec
	sbc rectLevelYSClipped
	sta .ycount

	lda rectLevelXEClipped
	sec
	sbc rectLevelXSClipped
	sta .xCountSave

.reloopy
	
	lda .xCountSave
	sta .xcount
	clc

.reloopx
	;---------------------------------
	;- block loop					--
	;---------------------------------
	ldy #$00
	lax (BLOCKREADADR),y
	lda FONTCOLOR,x
	sta (ZP_WRITE_COLOR),y
	lda FONTLUMA,x
	sta (ZP_WRITE_LUMA),y

	
	inc ZP_WRITE_LUMA + 0
	inc ZP_WRITE_COLOR + 0
	bne .nocarry
	inc ZP_WRITE_LUMA + 1
	inc ZP_WRITE_COLOR + 1
.nocarry
	
	inc blockLevelX
	lda BLOCKREADADR + 0
	adc #$04
	sta BLOCKREADADR + 0
	and #%00001100
	bne .notnexttilex
	jsr getBlockAtXY
	clc
.notnexttilex

	dec .xcount
	bne .reloopx

	dec .ycount
	beq .noreloopy
	
	lda rectLevelXSClipped
	sta blockLevelX

	inc blockLevelY

	; find a way for this again (if there are problems with the level update disable this again
	lda .readBlockSave + 1
	sta BLOCKREADADR + 1
	lda .readBlockSave + 0
	clc
	adc #$01
	sta BLOCKREADADR + 0
	sta .readBlockSave + 0
	and #%00000011
	bne .notnexttiley
	jsr getBlockAtXY
	lda BLOCKREADADR + 0 ; from getBlockAtXY
	sta .readBlockSave + 0
	lda BLOCKREADADR + 1 ; from getBlockAtXY
	sta .readBlockSave + 1
.notnexttiley

	lda ZP_WRITE_LUMA_SAVE + 0
	adc #<40
	sta ZP_WRITE_LUMA + 0
	sta ZP_WRITE_COLOR + 0
	sta ZP_WRITE_LUMA_SAVE + 0
	lda ZP_WRITE_LUMA_SAVE + 1
	adc #>40
	sta ZP_WRITE_LUMA + 1
	sta ZP_WRITE_LUMA_SAVE + 1
	clc
	adc # $04
	sta ZP_WRITE_COLOR + 1
	clc

	jmp .reloopy
.noreloopy

; here no more code should be placed, since a conditional rts(nop) above could make this code unreachable

	rts

;--------------------------------------------------------------
; flagsInRect gets all the flags in the rect
;--------------------------------------------------------------
	SUBROUTINE
.xcount dc.b $00
.ycount dc.b $00
.readBlockSave dc.w $0000
.xCountSave dc.b $00
flagsInRect 

	lda #$00
	sta rectFlags

	lda rectLevelXS
	sta blockLevelX
	lda rectLevelYS
	sta blockLevelY
	jsr getBlockAtXY

	lda BLOCKREADADR + 0 ; from getBlockAtXY
	sta .readBlockSave + 0
	lda BLOCKREADADR + 1 ; from getBlockAtXY
	sta .readBlockSave + 1
	
	lda rectLevelYE
	sec
	sbc rectLevelYS
	bne .notzeroy
	lda #$01
.notzeroy
	sta .ycount
	

	lda rectLevelXE
	sec
	sbc rectLevelXS
	bne .notzerox
	lda #$01
.notzerox
	sta .xCountSave

	ldy #$00

.reloopy
	
	lda .xCountSave
	sta .xcount
	
.reloopx
	;---------------------------------
	;- block loop					--
	;---------------------------------
	lax (BLOCKREADADR),y
	lda FONTFLAGS,x
	ora rectFlags
	sta rectFlags

	inc blockLevelX
	lda BLOCKREADADR + 0
	clc
	adc #$04
	sta BLOCKREADADR + 0
	and #%00001100
	bne .notnexttilex
	jsr getBlockAtXY
	ldy #$00
.notnexttilex

	dec .xcount
	bne .reloopx

	dec .ycount
	beq .noreloopy
	
	lda rectLevelXS
	sta blockLevelX

	inc blockLevelY

	; find a way for this again (if there are problems with the level update disable this again
	lda .readBlockSave + 1
	sta BLOCKREADADR + 1
	lda .readBlockSave + 0
	clc
	adc #$01
	sta BLOCKREADADR + 0
	sta .readBlockSave + 0
	and #%00000011
	bne .notnexttiley
	jsr getBlockAtXY
	ldy #$00
	lda BLOCKREADADR + 0 ; from getBlockAtXY
	sta .readBlockSave + 0
	lda BLOCKREADADR + 1 ; from getBlockAtXY
	sta .readBlockSave + 1
.notnexttiley

	jmp .reloopy
.noreloopy

; here no more code should be placed, since a conditional rts(nop) above could make this code unreachable

	rts

	SUBROUTINE
.temp dc.b $00
clampScrollPosDesired 
	lda scrollPosXDesired + 1
	bpl .notleft
	lda #$00
	sta scrollPosXDesired + 0
	sta scrollPosXDesired + 1
.notleft

	lda scrollPosYDesired + 1
	bpl .notup
	lda #$00
	sta scrollPosYDesired + 0
	sta scrollPosYDesired + 1
.notup

	lda scrollPosXDesired + 0
	lsr
	lsr
	sta .temp
	lda scrollPosXDesired + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora .temp
	cmp #[40*4-39]
	bcc .notright
	lda #<[[40*4-39]*4]
	sta scrollPosXDesired + 0
	lda #>[[40*4-39]*4]
	sta scrollPosXDesired + 1
.notright

	; -2 because of a flickering bug
	lda scrollPosYDesired + 1
	cmp #>[[64*4-DISPLAYAREAROWS]*8-1]
	bne .notdown
	lda scrollPosYDesired + 0
	and #%11111000
	cmp #<[[64*4-DISPLAYAREAROWS]*8-1]
	bcc .notdown
	lda #<[[64*4-DISPLAYAREAROWS]*8-1]
	sta scrollPosYDesired + 0
	lda #>[[64*4-DISPLAYAREAROWS]*8-1]
	sta scrollPosYDesired + 1
.notdown

	; colorrasterbar flicker prevention
	; $01 ; for 2 as rastervalue add in raster_irq_top  (at the moment it's three so -1 (= $00))
	; $07
	; $08
	; $0b
	; $0c
	; $12
	; $1d 
	; $21
	; ... , $27, $28, $2b

	lda scrollPosYDesired + 0
	and #$1f
	cmp #$00
	beq .flickerpreventplus1
	cmp #$06
	beq .flickerpreventminus1
	cmp #$07
	beq .flickerpreventplus1
	cmp #$0a
	beq .flickerpreventminus1
	cmp #$0b
	beq .flickerpreventplus1
	cmp #$11
	beq .flickerpreventplus1
	cmp #$1c
	beq .flickerpreventplus1
	jmp .flickerpreventdone
.flickerpreventplus1
	lda scrollPosYDesired + 0
	clc
	adc #<$01
	sta scrollPosYDesired + 0
	lda scrollPosYDesired + 1
	adc #>$01
	sta scrollPosYDesired + 1
	jmp .flickerpreventdone
.flickerpreventminus1
	lda scrollPosYDesired + 0
	sec
	sbc #<$01
	sta scrollPosYDesired + 0
	lda scrollPosYDesired + 1
	sbc #>$01
	sta scrollPosYDesired + 1
.flickerpreventdone

	rts

;--------------------------------------------------------------
; switchFrame
;--------------------------------------------------------------
switchFrame SUBROUTINE
	lda doubleBuffer
	eor #$01
	sta doubleBuffer
	rts

;--------------------------------------------------------------
; switchColorFrame
;--------------------------------------------------------------
	SUBROUTINE
.temp1 dc.b $00
.temp2 dc.b $00
switchColorRamFrame 
	lda currentScreenBuffer1 + 0
	sta .temp1
	lda currentScreenBuffer1 + 1
	sta .temp2
	lda currentScreenBuffer2 + 0
	sta currentScreenBuffer1 + 0
	lda currentScreenBuffer2 + 1
	sta currentScreenBuffer1 + 1
	lda .temp1
	sta currentScreenBuffer2 + 0
	lda .temp2
	sta currentScreenBuffer2 + 1
	rts

;--------------------------------------------------------------
;-- paints the frame                                         -- 
;--------------------------------------------------------------
paintFrame SUBROUTINE
	lda lastBitmapHigh
	sta BITMAPSCREENHI
	ldx doubleBuffer
	lda spritePortRestoreAdders,x
	sta spritePortRestoreAdd

	jsr displayOverlays
	jsr paintAllVisibleGameObjects
	
	lda #$01
	sta LEVELPAINTFUCENABLED

	rts

;--------------------------------------------------------------
;-- INCLUDES												 -- 
;--------------------------------------------------------------
	include "scroll.asm"
	include "player.asm"
	include "sprites.asm"
	include "gameobjects.asm"
	include "gamelogik.asm"
	include "fadeinout.asm"
	include "enemylogik.asm"
	include "interstitials.asm"
	include "overlays.asm"
	include "sound.asm"
	include "screens.asm"
	include "layers.asm"
	include "particleexplosion.asm"

; alignment fix
;--------------------------------------------------------------
;-- clears the frame                                         -- 
;--------------------------------------------------------------
clearFrame SUBROUTINE
	; this clears the sprites
	lda lastBitmapHigh
	sta BITMAPSCREENHI
	lda doubleBuffer
	eor #$01
	tax
	lda spritePortRestoreAdders,x
	sta spritePortRestoreAdd
	lda #$00
	sta .modi1 + 1
.reloop
.modi1
	lda #$44
	sta spritePort
	jsr restoreSpritePort
	
	inc .modi1 + 1
	lda .modi1 + 1
	cmp #SPRITECOUNT
	bne .reloop
	rts

	incbin "gamefont.exo"
FONTFOR2000EXOEND
	incbin "screenmask.exo"
SCREENMASKFOR1800EXOEND

sinPlus
	incbin "sinplus.bin"

SPRITEBUFFER
SPRITEBUFFER_PLUS_8 = SPRITEBUFFER + 8
Y SET 0
	REPEAT 48
	dc.b $00
Y SET Y + 1
	REPEND

	; not aligned
TILEADRLO
Y SET 0
	REPEAT 160
	dc.b <[Y*16+TILES]
Y SET Y + 1
	REPEND

TILEADRHI
Y SET 0
	REPEAT 160
	dc.b >[Y*16+TILES]
Y SET Y + 1
	REPEND

	align 256
;---------------------------------------------------
; TABLES
;---------------------------------------------------
	; i think we need these four tables
	; aligned
MUL40LO
Y SET 0
	REPEAT 256
	dc.b <[Y*40]
Y SET Y + 1
	REPEND

MUL40HI
Y SET 0
	REPEAT 256
	dc.b >[Y*40]
Y SET Y + 1
	REPEND

MUL320LO
Y SET 0
	REPEAT 256
	dc.b <[Y*320]
Y SET Y + 1
	REPEND

MUL320HI
Y SET 0
	REPEAT 256
	dc.b >[Y*320]
Y SET Y + 1
	REPEND

MUL8LO
Y SET 0
	REPEAT 256
	dc.b <[Y*8]
Y SET Y + 1
	REPEND

MUL8HI
Y SET 0
	REPEAT 256
	dc.b >[Y*8]
Y SET Y + 1
	REPEND

SPECIALTABLES
	incbin "specialwhite.bin"
	incbin "specialxflip.bin"
	incbin "specialxflipwhite.bin"
RORTABLES1
	incbin "rortable1_0.bin"
	incbin "rortable1_1.bin"
	incbin "rortable1_2.bin"
RORTABLES2
	incbin "rortable2_0.bin"
	incbin "rortable2_1.bin"
	incbin "rortable2_2.bin"
AUTOMASKING
	incbin "automasking.bin"

AND3ASLASL ; its only for x used levelsize x = 40; so it's just 40 * 4
Y SET 0
	REPEAT 160
	dc.b [Y & 3] * 4
Y SET Y  + 1
	REPEND

DIV4MUL64TAB64MAPLO
Y SET 0
	REPEAT 160 ; not 256!
	dc.b <[Y/4*64+MAP]
Y SET Y + 1
	REPEND

DIV4MUL64TAB64MAPHI
Y SET 0 ; not 256!
	REPEAT 160
	dc.b >[Y/4*64+MAP]
Y SET Y + 1
	REPEND

; here are some bytes free (remember the safety offset is 2) so before perleveldata must be 2 bytes free ($bf00)
;---------------------------------------------------
; Global Vars
;---------------------------------------------------

gameLogikSteps dc.b $00

frameCounter dc.w $0000
mainLoopCounter dc.w $0000
gameLogikCounter dc.w $0000
lastFrameCounterGameLogik dc.w $0000

BITMAPSCREENHI dc.b >$0000

doubleBuffer dc.b $00
updateDoubleBuffer dc.b $00
spriteRestored	ds.b SPRITECOUNT*2,$00

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! FREE MEMORY align memory !!!!!!!!!!!!!!!!!!!!!!!!!!!


someBytesLeft1	
	lda spritePX
	clc 
	adc #$02
	sta spritePX
	jsr eAddRandom
	lda #$ff
	sta EDOTADDY,x
	rts

accesRunStop
	LDA #$7F	 ;Check column 7
	STA $FF08	 ;Write to Keyboard Latch
	LDA $FF08	 ;Read from Keyboard Latch
	AND #$80	 ;Query keyboard for "RunStop"
	rts

waitRunStop
.wait2
	jsr accesRunStop
	BNE .wait2
.wait
	jsr accesRunStop
	BEQ .wait
	rts

PAUSEMIDX = 20
PAUSEMIDY = 12
PAUSELENGTHX = 10

mainLoopDeferred 
	LDA #$7F	 ;Check column 7
	STA $FD30	 ;Write to Keyboard Matrix
	jsr accesRunStop
	beq .pressed
.done
	LDA #$FF	 
	STA $FD30	 ;Write to Keyboard Matrix
	jmp mainLoop
.pressed
	; there is no other possibility to avoid the raster flickering
	lda scrollPosYCurrent + 0
	cmp scrollPosYDesired + 0
	beq .do
	jmp .done
.do
	jsr waitFrame
	jsr waitFrame

	lda scrollPosYDiv8
	clc
	adc #PAUSEMIDY
	tay
	lda scrollPosXDiv4
	clc
	adc #PAUSEMIDX-PAUSELENGTHX/2
	tax
	lda MUL8LO,x
	clc
	adc MUL320LO,y
	sta ZP_WRITE_BITMAP_PAUSE + 0
	lda MUL8HI,x
	adc MUL320HI,y
	and #$1f
	adc BITMAPSCREENHI
	sta ZP_WRITE_BITMAP_PAUSE + 1

	ldx #$00
.yo2	
	ldy #$00
.yo
	lda (ZP_WRITE_BITMAP_PAUSE),y
	ora PAUSE,x
	sta (ZP_WRITE_BITMAP_PAUSE),y
	inx
	iny
	cpy #$08
	bne .yo
	lda	ZP_WRITE_BITMAP_PAUSE + 0
	adc #$0f ; carry is set from cpy
	sta	ZP_WRITE_BITMAP_PAUSE + 0
	lda	ZP_WRITE_BITMAP_PAUSE + 1
	adc #$00
	and #$1f
	adc BITMAPSCREENHI
	sta	ZP_WRITE_BITMAP_PAUSE + 1
	cpx #$08*$05
	bne .yo2

	jsr waitRunStop
	jsr waitRunStop

	; clear pause
	lda scrollPosXDiv4
	clc
	adc #PAUSEMIDX - PAUSELENGTHX / 2
	sta rectLevelXS
	clc
	adc #PAUSELENGTHX
	sta rectLevelXE
	lda scrollPosYDiv8
	clc
	adc #PAUSEMIDY
	sta rectLevelYS
	clc
	adc #$01
	sta rectLevelYE
	jsr restoreRect

	jsr frameCounterAdjust
	jmp .done

PAUSE 
	incbin "pause.bin"

;---------------------------------------------------
	ORG $befc ; with safety area
	include "perleveldata.asm"
	
	ORG $fb48
	include "soundeffects.asm"

	echo "eof: ",.
	