    processor   6502
	
	include "fw_interface.asm"
	include "macros.asm"
	include "standard.asm"
	include "persistent.asm"

BARPOSY   = 11
BARLENGTH = 8
BARPOSX   = 20 - BARLENGTH / 2
BARCOLOR1 = $33
BARCOLOR2 = $53
BARCOLOR3 = $73

GEMX = 20 - 3
GEMY = BARPOSY - 9
TEXTX = 5
TEXTY = BARPOSY + 3

TEXTCOLOR = $04
TEXTLUMA = $04
INLINELENGTH = 32
LINELENGTH = 30
FIRSTSTATUSCHR = INLINELENGTH*3

	include "gemSetup.inc"

	ORG $2000 ; text font (perhaps with animation)
	incbin "gamefont.bin"
	incbin "font.bin"
	incbin "screenchars.bin"
	incbin "gemcharset.bin"

	ORG $2800-$08
	incbin "kreis.bin" ; loading ready char
	ORG $2800
ENTRYPOINT
;--------------------------------------------------------------------
; Hauptprogramm (Init)
;--------------------------------------------------------------------
MAINPRG SUBROUTINE

	lda #$ff
	sta $fd30

	; --------------------------------------
	; GAME OVER
	; --------------------------------------
	lda ZP_LEVELSTATUS
	cmp #LEVELSTATUS_OK
	beq .notGameOver
	lda #$00
	sta ZP_LEVELTOLOAD
.notGameOver

	;-------------------------------------------------------------------
	; disable screen
	;-------------------------------------------------------------------
	lda #%00101011
	sta $ff06

	jsr waitFrame

	lda #$00
	sta $ff15

	lda #BARCOLOR1
	sta $ff16
	lda #BARCOLOR2
	sta $ff17

	; clear screen
	ldx #$00
.yo
Y SET 0
	REPEAT $04	
	lda #$00
	sta $1800+Y*$100,x
	lda SCREENMASK+Y*$100,x
	sta $1c00+Y*$100,x
Y SET Y + 1
	REPEND
	dex
	bne .yo

	jsr LOADSONG
	
	; draw bar colors
	ldx #BARLENGTH-1
	lda #$08 + BARCOLOR3
.nextc
	sta $1800 + BARPOSY * 40 + BARPOSX,x
	dex
	bpl .nextc

	; draw gem
	ldx #GEM_YSIZE-1
.nexty2	
	ldy #GEM_XSIZE-1
.nextx2
	lda GEMCOLS,y
	sta $1800 + GEMX + GEMY * 40,y
	lda GEMCHARS,y
	sta $1c00 + GEMX + GEMY * 40,y
	dey
	bpl .nextx2

	lda .nextx2  + 1 + 6 * 0
	clc
	adc #GEM_XSIZE
	sta .nextx2  + 1 + 6 * 0
	lda .nextx2  + 2 + 6 * 0
	adc #$00
	sta .nextx2  + 2 + 6 * 0

	lda .nextx2  + 1 + 6 * 1
	adc #GEM_XSIZE
	sta .nextx2  + 1 + 6 * 1
	lda .nextx2  + 2 + 6 * 1
	adc #$00
	sta .nextx2  + 2 + 6 * 1

	lda .nextx2  + 1 + 6 * 0 + 3
	clc
	adc #40
	sta .nextx2  + 1 + 6 * 0 + 3
	lda .nextx2  + 2 + 6 * 0 + 3
	adc #$00
	sta .nextx2  + 2 + 6 * 0 + 3

	lda .nextx2  + 1 + 6 * 1 + 3
	adc #40
	sta .nextx2  + 1 + 6 * 1 + 3
	lda .nextx2  + 2 + 6 * 1 + 3
	adc #$00
	sta .nextx2  + 2 + 6 * 1 + 3

	dex
	bpl .nexty2



	lda ZP_LEVELTOLOAD
	asl
	tax
	lda TEXTSCREENPOINTERS + 0,x
	sta .readIt + 1
	clc
	adc #<$01
	sta currentTextScreenRead + 0
	lda TEXTSCREENPOINTERS + 1,x
	sta .readIt + 2
	adc #>$01
	sta currentTextScreenRead + 1

.readIt
	lda $4444
	sta currentTextLineCount

	lda #<[$1c00 + 40 * TEXTY + TEXTX]
	sta currentTextScreenWrite + 0
	lda #>[$1c00 + 40 * TEXTY + TEXTX]
	sta currentTextScreenWrite + 1

	;-------------------------------------------------------------------
	; bitmap adress 2000 | bitmap ram 
	;-------------------------------------------------------------------
	lda $ff12
	and #%11000011 
	ora #%00001000 
	sta $ff12

	lda $ff14
	and #%00000111
	ora #%00011000
	sta $ff14

	lda #%10011000 ; we want multicolor
	sta $ff07

	lda $ff13
	and #%00000101 ; speedmode
	ora #%00100000 ; font $2000
	sta $ff13

	jsr prepareReplace

	sei
	lda #<raster_plugin
	sta fw_topirq_plugin + 0
	lda #>raster_plugin
	sta fw_topirq_plugin + 1
	cli

	;-------------------------------------------------------------------
	; enable screen
	;-------------------------------------------------------------------
	lda #%00011011
	sta $ff06

	; --------------------------------------
	; SCROLLLEVEL
	; --------------------------------------
	ldx ZP_LEVELTOLOAD
	lda LEVELTYPE,x
	cmp #LT_SCROLLLEVEL
	bne .noScrollLevel
.scrollLevel
	
	lda ZP_LOADSTATE
	and #LOADSTATE_ENGINE     
	bne .noEngineLoad
	ldx #<ENGINEFILENAME
	ldy #>ENGINEFILENAME
	jsr LOAD_NORMAL_DECRUNCH
.noEngineLoad

	lda ZP_LOADSTATE
	and #LOADSTATE_SFX
	bne .noSFXLoad
	ldx #<SOUNDEFFECTSFILENAME
	ldy #>SOUNDEFFECTSFILENAME
	jsr LOAD_NORMAL_DECRUNCH
.noSFXLoad

	lda ZP_LEVELTOLOAD
	asl
	tay
	ldx LEVELS,y
	lda LEVELS+1,y
	tay
	jsr LOAD_NORMAL_DECRUNCH

	jsr LOADLEVELSONG
	
	lda #LOADSTATE_ENGINE|LOADSTATE_SFX|LOADSTATE_SCROLLLEVEL
	ora ZP_LOADSTATE
	sta ZP_LOADSTATE

	lda #<ActivateWithMusic
	sta .entryPoint + 1
	lda #>ActivateWithMusic
	sta .entryPoint + 2

	lda #<ENTRYPOINT_LEVELSTART_SCROLL 
	sta entryPointWithMusic + 1
	lda #>ENTRYPOINT_LEVELSTART_SCROLL 
	sta entryPointWithMusic + 2

	jmp .doneLoading
.noScrollLevel

	cmp #LT_STARTSCREEN
	bne .noStartScreen
	; --------------------------------------
	; STARTSCREEN
	; --------------------------------------
	ldx #<STARTSCREENFILENAME
	ldy #>STARTSCREENFILENAME
	jsr LOAD_NORMAL_DECRUNCH

	lda #$00
	sta ZP_LOADSTATE

	lda #$01
	sta ZP_DONTFADEOUT

	lda #<ENTRYPOINT_STARTSCREEN 
	sta .entryPoint + 1
	lda #>ENTRYPOINT_STARTSCREEN 
	sta .entryPoint + 2

	jmp .doneLoading
.noStartScreen

	cmp #LT_ENDSCREEN
	bne .noEndScreen
	; --------------------------------------
	; ENDSCREEN
	; --------------------------------------
	ldx #<ENDSCREENFILENAME
	ldy #>ENDSCREENFILENAME
	jsr LOAD_NORMAL_DECRUNCH

	jsr LOADLEVELSONG

	lda #$00
	sta ZP_LOADSTATE

	lda #<ActivateWithMusic
	sta .entryPoint + 1
	lda #>ActivateWithMusic
	sta .entryPoint + 2

	lda #<ENTRYPOINT_ENDSCREEN 
	sta entryPointWithMusic + 1
	lda #>ENTRYPOINT_ENDSCREEN 
	sta entryPointWithMusic + 2

	jmp .doneLoading
.noEndScreen


.doneLoading
	lda ZP_LEVELTOLOAD
	sta ZP_LEVELCURRENT

	lda #$01
	sta loadingReady

	jsr blop

	ldx #50*4

.waitforjoy
	dex
	;beq .waitover ; wait till joystick
	jsr waitFrame
	jsr gatherJoystick 
	lda joyPressed
	beq .waitforjoy

.waitover
	jsr blip
	ldx #$10
.e
	jsr waitFrame
	dex
	bne .e

.waitfornotjoy
	jsr gatherJoystick 
	lda joyPressed
	bne .waitfornotjoy

.donejoy

	;-------------------------------------------------------------------
	; disable screen
	;-------------------------------------------------------------------
	jsr waitFrame
	jsr waitBorder
	lda #$00
	sta fw_topirq_plugin + 0
	sta fw_topirq_plugin + 1
	cli
	lda #%00101011
	sta $ff06
	jsr waitFrame
	sei
	jsr songoff
	jsr kp_clear
	cli
	lda #%00101011
	sta $ff06
	jsr waitFrame
	jsr waitFrame

	lda #$ff
	sta $fd30

.entryPoint
	jmp $4444

ActivateWithMusic
	jsr ACTIVATELEVELSONG
entryPointWithMusic
	jmp $4444

loadingReady			dc.b $00

STARTSCREENFILENAME		dc.b "SS",0
ENDSCREENFILENAME		dc.b "ES",0
SOUNDEFFECTSFILENAME	dc.b "SF",0
ENGINEFILENAME			dc.b "CORE",0

WORLD1FILENAME dc.b "W1",0
WORLD2FILENAME dc.b "W2",0
WORLD3FILENAME dc.b "W3",0
WORLD4FILENAME dc.b "W4",0
WORLD5FILENAME dc.b "W5",0
WORLD6FILENAME dc.b "W6",0
WORLD7FILENAME dc.b "W7",0
WORLD8FILENAME dc.b "W8",0

WORLD1MUSICFILENAME dc.b "S1",0
WORLD2MUSICFILENAME dc.b "S2",0
WORLD3MUSICFILENAME dc.b "S3",0
WORLD4MUSICFILENAME dc.b "S4",0
WORLD5MUSICFILENAME dc.b "S5",0
WORLD6MUSICFILENAME dc.b "S6",0
WORLD7MUSICFILENAME dc.b "S7",0
WORLD8MUSICFILENAME dc.b "S8",0
ENDSCREENMUSICFILENAME dc.b "S7",0

LEVELS
	dc.w $00 ; STARTSCREEN
	dc.w WORLD1FILENAME
	dc.w WORLD2FILENAME
	dc.w WORLD3FILENAME
	dc.w WORLD4FILENAME
	dc.w WORLD5FILENAME
	dc.w WORLD6FILENAME
	dc.w WORLD7FILENAME
	dc.w WORLD8FILENAME
	dc.w ENDSCREENFILENAME

MUSICS
	dc.w $00
	dc.w WORLD1MUSICFILENAME
	dc.w WORLD2MUSICFILENAME
	dc.w WORLD3MUSICFILENAME
	dc.w WORLD4MUSICFILENAME
	dc.w WORLD5MUSICFILENAME
	dc.w WORLD6MUSICFILENAME
	dc.w WORLD7MUSICFILENAME
	dc.w WORLD8MUSICFILENAME
	dc.w ENDSCREENMUSICFILENAME

LT_STARTSCREEN	= $01
LT_SCROLLLEVEL	= $02
LT_ENDSCREEN	= $03

LEVELTYPE
	dc.b LT_STARTSCREEN
	dc.b LT_SCROLLLEVEL
	dc.b LT_SCROLLLEVEL
	dc.b LT_SCROLLLEVEL
	dc.b LT_SCROLLLEVEL
	dc.b LT_SCROLLLEVEL
	dc.b LT_SCROLLLEVEL
	dc.b LT_SCROLLLEVEL
	dc.b LT_SCROLLLEVEL
	dc.b LT_ENDSCREEN

;---------------------------------------------------------------------------------
; JOYSTICK STUFF
;---------------------------------------------------------------------------------

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


;---------------------------------------------------------------------------------
; WAITFRAME STUFF 
;---------------------------------------------------------------------------------
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

;---------------------------------------------------------------------------------
; THE RASTER IRQ 
;---------------------------------------------------------------------------------
raster_plugin SUBROUTINE 
	lda #<rasterIrq 
	sta $fffe 
	lda #>rasterIrq
	sta $ffff 
	lda #2  ;raster irq 
	sta $ff0a 
	lda #$00 ; rasterline 
	sta $ff0b
	PLUGIN_CANCELDEFAULT 
	rts 

frameCounter dc.w $00

barCounter dc.b $00
rasterIrq SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	lda $ff13
	pha
	and #%11111101 
	sta $ff13

	lda #GEM_COLOR1
	sta $ff16
	lda #GEM_COLOR2
	sta $ff17

	inc $ff09

	inc barCounter

	lda loadingReady
	beq .normalbar
	lda #$ff
	ldx #BARLENGTH-1
.nextd
	sta $1c00 + BARPOSY * 40 + BARPOSX,x
	dex
	bpl .nextd

	lda barCounter
	lsr
	lsr
	lsr
	and #$07
	tax
	lda BARCOLMAP,x
	ldx #BARLENGTH-1
.nexte
	sta $1800 + BARPOSY * 40 + BARPOSX,x
	dex
	bpl .nexte

	jmp .donebar
.normalbar
	lda barCounter
	lsr
	lsr
	tay
	ldx #BARLENGTH-1
.nextc
	tya
	and #$0f
	tay
	lda BARMAP,y
	sta $1c00 + BARPOSY * 40 + BARPOSX,x
	dey
	dex
	bpl .nextc
.donebar

	lda #BARPOSY*8 ; rasterline 
	sta $ff0b

	lda #<rasterIrqBar
	sta $fffe 
	lda #>rasterIrqBar
	sta $ffff 

	lda barCounter
	and #$03
	bne .nofadein
	jsr fadeInTextScreen
.nofadein

	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

rasterIrqBar SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	lda $ff13
	pha
	and #%11111101 
	sta $ff13

	lda #BARCOLOR1
	sta $ff16
	lda #BARCOLOR2
	sta $ff17

	inc $ff09

	jsr fw_lowirq_install
	lda barCounter
	and #$07
	bne .a
	jsr sidesFadeIn
.a

	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

;---------------------------------------------------------------------------------
; loads the loader song
;---------------------------------------------------------------------------------
LOADSONG SUBROUTINE

	lda #$01
	sta fw_song_off
	lda #$00
	sta $ff11

	ldx #<[SONGMEM_END]
	ldy #>[SONGMEM_END]
	jsr fw_decrunch

	jsr waitFrame

	sei
	ldx #<MEMPOS_LOADER_SONG
	ldy #>MEMPOS_LOADER_SONG
	lda #$01
	jsr fw_initplayer
	lda #$00
	sta kp_pattern_counter
	jsr kp_clear
	cli

	jsr waitFrame
	lda #$00
	sta fw_song_off
	rts

;---------------------------------------------------------------------------------
; LEVEL SONG LOADING AND PLAYING
;---------------------------------------------------------------------------------
LOADLEVELSONG SUBROUTINE

	jsr waitFrame
	jsr waitFrame

	lda ZP_LEVELTOLOAD
	asl
	tax
	ldy MUSICS + 1,x
	lda MUSICS + 0,x
	tax
	jsr LOAD_NORMAL_DECRUNCH
	rts

	include "player_clear_real.asm"

ACTIVATELEVELSONG SUBROUTINE
	
	sei
	jsr songoff	
	ldx #<[EMPTY_END]
	ldy #>[EMPTY_END]
	jsr fw_decrunch

	jsr waitFrame

	ldx #<MEMPOS_LOADER_SONG
	ldy #>MEMPOS_LOADER_SONG
	lda #$01
	jsr fw_initplayer
	lda #$00
	sta kp_pattern_counter
	jsr kp_clear

	lda #$00
	sta fw_song_off
	cli

	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame

	jsr waitFrame
	jsr songoff
	jsr waitFrame
	jsr waitFrame

	sei

	ldx #<MEMPOS_STANDARD_SONG
	ldy #>MEMPOS_STANDARD_SONG

	lda #$01
	jsr fw_initplayer

	lda #$00
	sta kp_pattern_counter

	jsr waitFrame
	jsr kp_clear
	lda #$00
	sta fw_song_off
	cli

	rts

LOAD_NORMAL_DECRUNCH SUBROUTINE
	LOAD_NORMAL
	ldx fw_load_end + 0
	ldy fw_load_end + 1
	jmp fw_decrunch

;---------------------------------------------------------------------------------
; Fades the text screen in
;---------------------------------------------------------------------------------
fadeInTextScreen SUBROUTINE
.again
	lda textFadeInOff
	beq .do
	rts
.do
	lda currentTextScreenFade
	beq .drawNewTextLine
	cmp #TEXTLUMA+$01
	bne .fadein
	lda currentTextScreenWrite + 0
	clc
	adc #<40
	sta currentTextScreenWrite + 0
	lda currentTextScreenWrite + 1
	adc #>40
	sta currentTextScreenWrite + 1
	lda currentTextScreenRead + 0
	clc
	adc #<INLINELENGTH
	sta currentTextScreenRead + 0
	lda currentTextScreenRead + 1
	adc #>INLINELENGTH
	sta currentTextScreenRead + 1
	lda #$00
	sta currentTextScreenFade
	dec currentTextLineCount
	bne .again
	lda #$01
	sta textFadeInOff
	jmp .again
.fadein
	; position
	lda currentTextScreenWrite + 0
	sta .write + 1
	lda currentTextScreenWrite + 1
	sec
	sbc #$04
	sta .write + 2

	; color
	lda currentTextScreenFade
	sec
	sbc #$01
	asl
	asl
	asl
	asl
	ora #TEXTCOLOR

	ldx #LINELENGTH-1
.nextx
.write 
	sta $4444,x
	dex
	bpl .nextx
	jmp .done
.drawNewTextLine
	; position
	lda currentTextScreenWrite + 0
	sta .write2 + 1
	lda currentTextScreenWrite + 1
	sta .write2 + 2

	lda currentTextScreenRead+ 0
	sta .read2 + 1
	lda currentTextScreenRead + 1
	sta .read2 + 2
	ldy #$05
	ldx #LINELENGTH-1
.nextx2
.read2 
	lda $4444,x
	cmp #$5f ; AE
	bne .normal
	lda replace,y
	dey
.normal
.write2 
	sta $4444,x
	dex
	bpl .nextx2
	inc currentTextScreenFade
	jmp .again
.done
	inc currentTextScreenFade
	rts

;---------------------------------------------------------------------------------
; prepares the replacement string with the current password
;---------------------------------------------------------------------------------
prepareReplace SUBROUTINE
	ldy #$00
.reloop
	lda levelPasswords + 6,y
	cmp ZP_LEVELTOLOAD
	bne .next
	lda levelPasswords + 7,y
	cmp ZP_SKILLLEVEL
	bne .next
	ldx #$00
.copy
	lda levelPasswords,y
	sec
	sbc #"A"
	clc
	adc #33
	sta replace,x
	inx
	iny
	cpx #$06
	bne .copy
	rts
.next
	tya
	clc
	adc #$08
	tay
	cpy #PASSWORDCOUNT * 8
	bne .reloop

	rts

sidesCounter dc.b $03
color dc.b $05
sidesFadeIn SUBROUTINE
	lda sidesCounter
	bne .do
	rts
.do
	dec sidesCounter

	ldy #0
.1
	tya
	tax
	jsr blitSideLineWithColor
	tya
	clc
	adc #40-4
	tax
	jsr blitSideLineWithColor
	iny
	cpy #$04
	bne .1


	lda color
	clc
	adc #$10
	sta color
	
	rts


blitSideLineWithColor
	lda #<$1800
	sta .mod + 1
	lda #>$1800
	sta .mod + 2

.reloop
	lda color
.mod
	sta $1800,x
	txa
	clc
	adc #40
	tax
	bcc .nohi
	inc .mod + 2
	lda .mod + 2
	cmp #>$1c00
	beq .rts
.nohi
	jmp .reloop
.rts
	rts


;---------------------------------------------------------------------------------
; The two songs for the loading (one is empty for silencing the voices)
;---------------------------------------------------------------------------------
SONGMEM_START
	incbin "loading.exo"
SONGMEM_END

EMPTY_START
	incbin "empty.exo"
EMPTY_END

	include "player_const.asm"
	include "player_symbols.asm"
	include "player_trigger.asm"
	include "soundeffects.asm"

;---------------------------------------------------------------------------------
; triggers a sound
;---------------------------------------------------------------------------------
triggerSound SUBROUTINE
	tax
	ldy #$0f
	jsr kp_triggerC
	rts

blop SUBROUTINE
	lda #$02
	jmp triggerSound

blip SUBROUTINE
	lda #$04
	jmp triggerSound

BARMAP
	dc.b $00+FIRSTSTATUSCHR,$01+FIRSTSTATUSCHR,$02+FIRSTSTATUSCHR,$03+FIRSTSTATUSCHR,$04+FIRSTSTATUSCHR,$05+FIRSTSTATUSCHR
	dc.b $06+FIRSTSTATUSCHR,$07+FIRSTSTATUSCHR,$07+FIRSTSTATUSCHR,$06+FIRSTSTATUSCHR,$05+FIRSTSTATUSCHR,$04+FIRSTSTATUSCHR
	dc.b $03+FIRSTSTATUSCHR,$02+FIRSTSTATUSCHR,$01+FIRSTSTATUSCHR,$00+FIRSTSTATUSCHR

BARCOL = $05
	
BARCOLMAP
	dc.b BARCOL + $10,BARCOL + $30,BARCOL + $50,BARCOL + $70,BARCOL + $50,BARCOL + $30,BARCOL + $10,BARCOL + $00
GEMCHARS
	incbin "gemchars.bin"
GEMCOLS
	incbin "gemcols.bin"
	include "passwords.asm"
replace
	ds.b $06,$00

currentTextScreenRead dc.w $0000
currentTextScreenWrite dc.w $0000
currentTextScreenFade dc.b $00
currentTextLineCount dc.b $00
textFadeInOff dc.b $00

	include "textscreens.inc"
	include "textscreensheader.inc"
	ORG MEMPOS_LOADER_SONG	; the songs get depacked here
SCREENMASK
	incbin "screenmask.bin"

	echo "eof: ",.
