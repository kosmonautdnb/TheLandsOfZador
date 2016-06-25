	; screen colors and so on
	include "screensSetup.inc"

TEXTSCREEN_LEVELSTART	  = $00
TEXTSCREEN_LEVELCOMPLETE  = $01
TEXTSCREEN_LIVELOST       = $02
TEXTSCREEN_GAMEOVER       = $03

NUMBERSSTARTINFONT		  = 16

SCREENS_TEXTCOLOR		  = $04
SCREENS_TEXTLUMINANCE	  = $06

screenFixed dc.b $00
textScreenNumber dc.b $00

goalNextTextScreen	dc.b $00
goalTextScreenNr	dc.b $00

stoneOutsideScreen	dc.b $00

	SUBROUTINE
;----------------------------------------------------------------------
; Displays a text and waits for the user to press the joystick button
;----------------------------------------------------------------------
displayTextScreen

	jsr waitForScrollDone
	;;;;jsr fixedScrollPos

	jsr waitUntilBorder
	lda #$01
	sta screenFixed
	lda #$0b
	sta $ff06
	jsr waitFrame

	jsr switchFrame
	jsr clearFrame
	jsr callLevelClearFunc
	jsr switchFrame
	jsr clearFrame
	jsr callLevelClearFunc

	lda #SCREENS_BACKGROUNDCOLOR
	sta $ff15
	lda #SCREENS_COLOR1
	sta $ff16
	lda #SCREENS_COLOR2
	sta $ff17

	ldx #<FONTFOR2000EXOEND
	ldy #>FONTFOR2000EXOEND
	jsr fw_decrunch

	ldx #<SCREENMASKFOR1800EXOEND
	ldy #>SCREENMASKFOR1800EXOEND
	jsr fw_decrunch

	; depack textscreen
	ldx textscreens+0
	ldy textscreens+1
	jsr fw_decrunch

	ldx textScreenNumber
	lda CURRENTSCREENS,x
	asl
	tax
	lda $3000 + 0,x
	sta ZP_TEXTSCREENREAD + 1 ; don't now why this is flipped
	lda $3000 + 1,x
	sta ZP_TEXTSCREENREAD + 0

	ldy #$00
	lda (ZP_TEXTSCREENREAD),y
	sta .layerNumber + 1; because it's packed in screenmem
	ldy #$02
	lda (ZP_TEXTSCREENREAD),y
	sta .switchlayerNumber + 1

	jsr blitScreenText
	lda #$00
	jsr colorizeScreen

	lda #$18	   ; screenram 1800
	sta $ff14

	lda $ff13
	and #%00000111
	ora #%00100000 ; font 2000
	sta $ff13

	lda #%10011000 ; reversing off,multicolor,25 rows 
	sta $ff07

	jsr waitUntilBorder

	lda #%00011011 ; screenon, 40 columns 
	sta $ff06

	lda .switchlayerNumber + 1
	and #$40
	beq .nozordan1
	jsr drawZordan
.nozordan1

	ldy #$00
.nextfadein
	jsr waitFrame
	tya
	pha
	asl
	asl
	asl
	asl
	ora #SCREENS_TEXTCOLOR
	jsr colorizeScreen
	pla
	tay
	iny
	cpy #SCREENS_TEXTLUMINANCE
	bne .nextfadein

	jsr joyButtonClick

	lda .switchlayerNumber + 1
	and #$40
	beq .nozordan2
	lda #$00
	jsr clearZordan
.nozordan2

	ldy #SCREENS_TEXTLUMINANCE-1
.nextfadeout
	jsr waitFrame
	tya
	pha
	asl
	asl
	asl
	asl
	ora #SCREENS_TEXTCOLOR
	jsr colorizeScreen
	pla
	tay
	dey
	bpl .nextfadeout
	
	; nextscreen for this screen
	ldy #$01
	lda (ZP_TEXTSCREENREAD),y
	bpl .isnotgoal
	and #$7f
	sta goalNextTextScreen
	ldx textScreenNumber
	stx goalTextScreenNr
	jmp .nogoal
.isnotgoal
	ldx textScreenNumber
	sta CURRENTSCREENS,x
.nogoal

	jsr waitUntilBorder
	lda #$0b
	sta $ff06
	jsr waitFrame
	lda FOREGROUNDCOLOR
	sta $ff16

	lda textScreenNumber
	cmp #TEXTSCREEN_LIVELOST
	bne .notPlayerToNewScrollPos
	lda #$00
	sta GameObjectXPosLoLo + PLAYERGAMEOBJECT
	sta GameObjectYPosLoLo + PLAYERGAMEOBJECT

	lda onGroundSavePointPlayerPosX + 0
	sta GameObjectXPosLo + PLAYERGAMEOBJECT
	lda onGroundSavePointPlayerPosX + 1
	sta GameObjectXPosHi + PLAYERGAMEOBJECT

	lda onGroundSavePointPlayerPosY + 0
	sta GameObjectYPosLo + PLAYERGAMEOBJECT
	lda onGroundSavePointPlayerPosY + 1
	sta GameObjectYPosHi + PLAYERGAMEOBJECT
	jsr setPlayerToNewScrollPos
.notPlayerToNewScrollPos	
	jsr screenFullOfLevel

	lda #$00
	sta screenFixed

	; enable or disable layer
.layerNumber
	lda #$44
	cmp #$ff
	beq .nolayerenable
	and #$7f
	sec
	sbc #$01
	ldx .layerNumber + 1
	bmi .deactivate
	jsr activateLayer
	jmp .nolayerenable
.deactivate
	jsr deactivateLayer
.nolayerenable

.switchlayerNumber
	lda #$44
	and #$3f
	beq .noswitchlayer
	sec
	sbc #$01
	jsr switchLayer
.noswitchlayer
	
	; gamelogikreset
frameCounterAdjust ;(ATTENTION THIS JSRT FROM THE PAUSE SCREEN and elsewhere, TO)
	lda frameCounter + 0
	sta lastFrameCounterGameLogik + 0
	lda frameCounter + 1
	sta lastFrameCounterGameLogik + 1
	rts

	SUBROUTINE
;----------------------------------------------------------------------
; waits for a click of the joystick
;----------------------------------------------------------------------
joyButtonClick
.waitTillButtonReleased1
	jsr gatherJoystick
	lda joyPressed
	bne .waitTillButtonReleased1

.waitTillButtonPressed
	jsr gatherJoystick
	lda joyPressed
	beq .waitTillButtonPressed

.waitTillButtonReleased2
	jsr gatherJoystick
	lda joyPressed
	bne .waitTillButtonReleased2

	lda #SOUND_COLLECTED
	jsr triggerSound
	rts

	SUBROUTINE
;----------------------------------------------------------------------
; blits the text for the given screen number
;----------------------------------------------------------------------
blitScreenText
	ldy #$03
	lda (ZP_TEXTSCREENREAD),y
	sta ZP_Y_LENGTH
	lsr
	eor #$ff
	clc
	adc #13
	tay
	lda #<[$1c00+5]
	clc
	adc MUL40LO,y
	sta ZP_SCREENBLITWRITE + 0
	lda #>[$1c00+5]
	adc MUL40HI,y
	sta ZP_SCREENBLITWRITE + 1

	lda ZP_TEXTSCREENREAD + 0
	clc
	adc #$04
	sta ZP_BYTE + 0
	lda ZP_TEXTSCREENREAD + 1
	adc #$00
	sta ZP_BYTE + 1

.nexty
	ldy #29
.nextx
	lda (ZP_BYTE),y
	bpl .yodo
	jsr specialChar
.yodo
	sta (ZP_SCREENBLITWRITE),y
	dey
	bpl .nextx
	lda ZP_BYTE + 0
	clc
	adc #<30
	sta ZP_BYTE + 0
	lda ZP_BYTE + 1
	adc #>30
	sta ZP_BYTE + 1
	lda ZP_SCREENBLITWRITE + 0
	clc
	adc #<40
	sta ZP_SCREENBLITWRITE + 0
	lda ZP_SCREENBLITWRITE + 1
	adc #>40
	sta ZP_SCREENBLITWRITE + 1
	dec ZP_Y_LENGTH
	bne .nexty
	rts

	SUBROUTINE
specialChar 
	stx .xrestore + 1
	ldx textScreenNumber
	cpx #TEXTSCREEN_LIVELOST
	bne .notlivelost
	lda ZP_LIVES
	clc
	adc #NUMBERSSTARTINFONT
.notlivelost
.xrestore
	ldx #$44
	rts

	SUBROUTINE
ZORDANX = 6
;----------------------------------------------------------------------
; draws the zordan sprite
;----------------------------------------------------------------------
drawZordan 
	lda #SCREENS_COLOR3
clearZordan
	sta .col3 + 1
	ldy #$03
	lda (ZP_TEXTSCREENREAD),y
	lsr
	eor #$ff
	clc
	adc #13-5
	tay
	lda #<[$1c00+ZORDANX]
	clc
	adc MUL40LO,y
	sta ZP_SCREENBLITWRITE + 0
	sta ZP_BYTE + 0
	lda #>[$1c00+ZORDANX]
	adc MUL40HI,y
	sta ZP_SCREENBLITWRITE + 1
	sec
	sbc #$04
	sta ZP_BYTE + 1


	lda #139+95
	sta .nextx + 1
	ldy #$00
	lda #$04
	sta ZP_Y_LENGTH
.nexty
	ldx #04
.nextx
	lda #$44
	sta (ZP_SCREENBLITWRITE),y
.col3
	lda #SCREENS_COLOR3
	sta (ZP_BYTE),y
	inc .nextx + 1
	iny
	dex
	bne .nextx
	tya
	clc
	adc #40-4
	tay
	dec ZP_Y_LENGTH
	bne .nexty	


	rts

	SUBROUTINE
;----------------------------------------------------------------------
; sets the textcolor of the screen (in accu)
;----------------------------------------------------------------------
colorizeScreen
	pha
	ldy #$03
	lda (ZP_TEXTSCREENREAD),y
	sta ZP_Y_LENGTH
	lsr
	eor #$ff
	clc
	adc #13
	tay
	lda #<[$1800+5]
	clc
	adc MUL40LO,y
	sta ZP_SCREENBLITWRITE + 0
	lda #>[$1800+5]
	adc MUL40HI,y
	sta ZP_SCREENBLITWRITE + 1

.nexty
	ldy #29
	pla
	pha
.nextx
	sta (ZP_SCREENBLITWRITE),y
	dey
	bpl .nextx
	lda ZP_SCREENBLITWRITE + 0
	clc
	adc #<40
	sta ZP_SCREENBLITWRITE + 0
	lda ZP_SCREENBLITWRITE + 1
	adc #>40
	sta ZP_SCREENBLITWRITE + 1
	dec ZP_Y_LENGTH
	bne .nexty
	pla
	rts


	SUBROUTINE
;----------------------------------------------------------------------
; fills the screen with the level on this location
;----------------------------------------------------------------------
screenFullOfLevel 

	lda scrollPosXDiv4
	sta rectLevelXS
	clc
	adc #40
	sta rectLevelXE
	lda scrollPosYDiv8
	sta rectLevelYS
	clc
	adc #25
	sta rectLevelYE
	jmp redrawPortion

	SUBROUTINE
;----------------------------------------------------------------------
; redraws the given rectangle
;----------------------------------------------------------------------
.tempTest1 dc.b $00
.tempTest2 dc.b $00
redrawPortion
	txa
	pha
	tya
	pha
	lda BITMAPSCREENHI
	pha
	lda currentScreenBuffer1 + 1
	pha

	lda #$01
	sta stoneOutsideScreen

	lda scrollPosXDiv4
	lsr
	lsr
	sta .tempTest1
	clc
	adc #40/4 + 1
	sta .tempTest2

	lda stoneXPos
	cmp .tempTest1
	bcc .nowait
	cmp .tempTest2
	bcs .nowait

	lda scrollPosYDiv8
	lsr
	lsr
	sta .tempTest1
	clc
	adc #25/4 + 1
	sta .tempTest2

	lda stoneYPos
	cmp .tempTest1
	bcc .nowait
	cmp .tempTest2
	bcs .nowait

	lda #$00
	sta stoneOutsideScreen

	jsr waitUntilBorder

.nowait


	lda #>$2000
	sta BITMAPSCREENHI
	lda #>$6000
	sta currentScreenBuffer1 + 1
	jsr restoreRectColor
	jsr restoreRect
	lda #>$4000
	sta BITMAPSCREENHI
	lda #>$1800
	sta currentScreenBuffer1 + 1
	jsr restoreRectColor
	jsr restoreRect
	pla
	sta currentScreenBuffer1 + 1
	pla
	sta BITMAPSCREENHI
	pla
	tay
	pla
	tax
	rts

waitForScrollDone SUBROUTINE
.wait
	lda updateDoubleBuffer
	bne .wait
	rts