    processor   6502

ZP_WRITE  = $10 ; 2
ZP_WRITE1 = $12 ; 2
ZP_WRITE2 = $14 ; 2
ZP_READ   = $16 ; 2

ZP_DOTS	  = $18 ; 2	
ZP_CLEAR  = $1a ; 2
ZP_CREAD  = $1c ; 2
ZP_LINE	  = $1e ; 2
ZP_MASK	  = $20 ; 2
ZP_TEMP	  = $22 ; 1

ZP_LOGOFADEREAD  = $24 ; 2
ZP_LOGOFADEWRITE = $26 ; 2
ZP_LOGOFADEWRITE2 = $28 ; 2

ZP_FADEDOT = $2a ; 1

LOGOFRONTCOLOR = $09
TEXTFRONTCOLOR = $71
SKILLLETTER = "*"
SKILLLETTERXPOS = 2 * 5 + 1
SKILLLETTERYPOS = 2 * 3 + LETTERSTARTY
SKILLLEVELCOUNT = 3
GAMEMODEXPOS = 1 * 2 + 1
GAMEMODEYPOS = 3 * 2 + LETTERSTARTY
LOGOYSIZE = 11
LETTERSTARTY = 13
LETTERCOUNTY = [25 - LETTERSTARTY]/2

DOTCOUNT  = 120

	include "fw_interface.asm"
	include "macros.asm"
	include "standard.asm"
	include "persistent.asm"
	include "globals.inc"
	include "logoPictureConstants.inc"

	ORG $4000
	ds.b $2000,$00

	ORG $6000
ENTRYPOINT
;--------------------------------------------------------------------
; Hauptprogramm (Init)
;--------------------------------------------------------------------
MAINPRG SUBROUTINE

	lda ZP_DONTFADEOUT
	bne .dontfadeout

	jsr waitFrame
	jsr fadeOver2

	lda kp_pattern_counter
.wait1
	cmp kp_pattern_counter
	beq .wait1

.dontfadeout

	;-------------------------------------------------------------------
	; disable screen
	;-------------------------------------------------------------------
	lda #%00101011
	sta $ff06

	jsr waitFrame

	jsr buildStartScreen

	;-------------------------------------------------------------------
	; char reversing of | multicolor
	;-------------------------------------------------------------------
	lda #%10011000
	sta $ff07

	;-------------------------------------------------------------------
	; bitmap adress 2000 - bitmap from ram - prevail voice frequencies
	;-------------------------------------------------------------------
	lda $ff12
	and #%11000011 
	ora #%00001000  
	sta $ff12

	;-------------------------------------------------------------------
	; font adress 3800
	;-------------------------------------------------------------------
	lda $ff13
	and #%00000101
	ora #%00111000 ; bit 2=1 auf slow 
	sta $ff13

	ldx #%00011000 ; adress 1800 ff14
	stx $ff14

	lda #logoBackColor
	sta $ff15
	lda #logoFrontColor
	sta $ff16

	lda #160
	sta ZP_FADEDOT

	jsr PLAYTITLESONG ; modifies zeropage?

	sei
	lda #<raster_plugin
	sta fw_topirq_plugin + 0
	lda #>raster_plugin
	sta fw_topirq_plugin + 1
	cli

	;-------------------------------------------------------------------
	; enable screen
	;-------------------------------------------------------------------
	lda #%00111011
	sta $ff06

	jsr waitFrame
	jsr waitFrame

	lda #$01
	sta letternumber

	lda #LEVELSTATUS_OK
	sta ZP_LEVELSTATUS
	lda #$01
	sta ZP_LEVELTOLOAD

.mainloop

	jsr findFirstKeyPress
	cmp #RET
	bne .notret
.waitret
	jsr findFirstKeyPress
	cmp #RET
	beq .waitret
	jmp .donestarting
.notret

	jsr gatherJoystick
	lda joyPressed
	bne .next
	jmp .mainloop
.next	

.pressed

	jsr gatherJoystick
	lda joyPressed
	bne .pressed

.donestarting

	jsr blop

	lda #$00
	sta lettersOn

	jsr selectNewGameOrLevelCode
	lda selected
	beq .newgame
	jsr enterPassword
	jsr selectLevelToLoadByPassword
	jmp .start
.newgame
	jsr selectSkillLevel
	lda #$01
	sta ZP_LEVELTOLOAD
.start

	jsr waitFrame
	sei
	lda #$00
	sta fw_topirq_plugin + 0
	sta fw_topirq_plugin + 1
	cli
	jsr waitFrame
	lda #$0b
	sta $ff06
	jsr waitFrame

	jsr initiateOutfade

	jmp loadNext

currentLetterPos dc.b $00
letters ds.b $06,"."

;--------------------------------------------------------------------
; builds the consistent startscreen
;--------------------------------------------------------------------
buildStartScreen SUBROUTINE


	; copy logo bitmap
	ldy #$20
.nexty
	ldx #$00
.nextx
	lda $4000,x
	sta $2000,x
	inx
	bne .nextx
	inc .nextx + 2
	inc .nextx + 2 + 3
	dey
	bne .nexty

	; copy color ram
	ldy #$04
.nexty2
	ldx #$00
.nextx2
	lda LOGOLUMI,x
	sta $1800,x
	lda LOGOCOLOR,x
	sta $1c00,x
	inx
	bne .nextx2
	inc .nextx2 + 2 + 3 * 0
	inc .nextx2 + 2 + 3 * 1
	inc .nextx2 + 2 + 3 * 2
	inc .nextx2 + 2 + 3 * 3
	dey
	bne .nexty2
	rts

;--------------------------------------------------------------------
selectSkillLevel SUBROUTINE
;--------------------------------------------------------------------
	lda #$00
	sta currentletterx
	sta	currentlettery
	lda #<TEXT2
	sta currenttextpos + 0
	lda #>TEXT2
	sta currenttextpos + 1
	lda #$03
	sta lettermask

	lda #LETTERCOUNTY * 20
	sta ZP_TEMP
.nextchar2
	jsr blitNextLetter
	jsr ADVANCE
	dec ZP_TEMP
	bne .nextchar2
	lda #SKILLLEVELCOUNT-1
	sta selectedCountMinus1
	lda #SKILLLETTERXPOS
	sta selectedXPos
	lda #SKILLLETTERYPOS
	sta selectedYPos
	jsr select
	lda selected
	sta ZP_SKILLLEVEL
	rts

;--------------------------------------------------------------------
selectNewGameOrLevelCode SUBROUTINE
;--------------------------------------------------------------------
	lda #$00
	sta currentletterx
	sta	currentlettery
	lda #<TEXT3
	sta currenttextpos + 0
	lda #>TEXT3
	sta currenttextpos + 1
	lda #$03
	sta lettermask

	lda #LETTERCOUNTY * 20
	sta ZP_TEMP
.nextchar2
	jsr blitNextLetter
	jsr ADVANCE
	dec ZP_TEMP
	bne .nextchar2
	lda #2-1
	sta selectedCountMinus1
	lda #GAMEMODEXPOS
	sta selectedXPos
	lda #GAMEMODEYPOS
	sta selectedYPos
	jsr select
	rts

;--------------------------------------------------------------------
enterPassword SUBROUTINE
;--------------------------------------------------------------------
	lda #$00
	sta currentletterx
	sta	currentlettery
	lda #<TEXT1
	sta currenttextpos + 0
	lda #>TEXT1
	sta currenttextpos + 1
	lda #$03
	sta lettermask

	lda #LETTERCOUNTY * 20
	sta ZP_TEMP
.nextchar
	jsr blitNextLetter
	jsr ADVANCE
	dec ZP_TEMP
	bne .nextchar



.letterloop	
	lda frameCounter
.waitfram
	cmp frameCounter
	beq .waitfram

	lda currentLetterPos
	asl
	clc
	adc #20-3*2
	sta letterxpos
	lda #2*2 + LETTERSTARTY
	sta letterypos

	lda #"-"
	sta letterlookup
	lda frameCounter
	lsr
	lsr
	lsr
	lsr
	and #$01
	beq .cursor
	ldx currentLetterPos
	lda letters,x
	sta letterlookup
.cursor
	jsr blitLetterAtXAndYLookup

	jsr gatherJoystick
	jsr gatherJoystick
	lda joyPressed
	bne .jumpy

	jsr findFirstKeyPress

	cmp #RET
	bne .notload
.jumpy
	jmp .nowload
.notload

	cmp #LFT
	bne .notleft
.toleftproceed
	jsr blop
.waitleft
	jsr findFirstKeyPress
	bne .waitleft
.toleft
	ldx currentLetterPos
	lda letters,x
	sta letterlookup
	jsr blitLetterAtXAndYLookup
	lda currentLetterPos
	sec
	sbc #$01
	cmp #$ff
	bne .notmin
	lda #$00
.notmin
	sta currentLetterPos
	jmp .doneletter
.notleft

	cmp #RIG
	bne .notright
.torightproceed
	jsr blip
.waitright
	jsr findFirstKeyPress
	bne .waitright
.toright	
	ldx currentLetterPos
	lda letters,x
	sta letterlookup
	jsr blitLetterAtXAndYLookup
	lda currentLetterPos
	clc
	adc #$01
	cmp #$06
	bne .notmax
	lda #$05
.notmax
	sta currentLetterPos
	jmp .doneletter
.notright

	cmp #DEL
	bne .notdel
	ldx currentLetterPos
	lda #"."
	sta letters,x
	jmp .toleftproceed
.notdel

	cmp #" "
	bne .notspace
	lda #"."
	jmp .letter
.notspace
	cmp #"0"
	bcc .checkchar
	cmp #"9"+1
	bcc .letter
.checkchar
	cmp #"A"
	bcc .doneletter
	cmp #"Z"+1
	bcs .doneletter
.letter
	ldx currentLetterPos
	sta letters,x
	jmp .torightproceed
.doneletter
	jmp .letterloop
.nowload

	jsr blop
	rts

selectedCountMinus1 dc.b $00
selected dc.b $00
selectedXPos dc.b $00
selectedYPos dc.b $00

;--------------------------------------------------------------------
select SUBROUTINE
;--------------------------------------------------------------------
	lda #$00
	sta selected

.notskillselected
	jsr gatherJoystick


	jsr findFirstKeyPress
	cmp #UP
	bne .notkup
	jsr blip
.waitkup
	jsr findFirstKeyPress
	cmp #UP
	beq .waitkup
	jmp .doup
.notkup

	jsr findFirstKeyPress
	cmp #DOWN
	bne .notkdown
	jsr blip
.waitkdown
	jsr findFirstKeyPress
	cmp #DOWN
	beq .waitkdown
	jmp .dodown
.notkdown

	lda joyMoveUp
	beq .notup
	jsr blip
.waitup
	jsr gatherJoystick
	lda joyMoveUp
	bne .waitup
.doup
	lda selected
	beq .notup
	dec selected
.notup

	lda joyMoveDown
	beq .notdown
	jsr blip
.waitdown
	jsr gatherJoystick
	lda joyMoveDown
	bne .waitdown
.dodown
	lda selected
	cmp selectedCountMinus1
	beq .notdown
	inc selected
.notdown

	lda selectedCountMinus1
	sta ZP_TEMP ; two skills
.nextskill
	lda ZP_TEMP
	asl
	clc
	adc selectedYPos
	sta letterypos

	lda selectedXPos
	sta letterxpos

	lda #" "
	sta letterlookup

	lda ZP_TEMP
	cmp selected
	bne .no
	lda #SKILLLETTER
	sta letterlookup
.no

	jsr blitLetterAtXAndYLookup

	dec ZP_TEMP
	bpl .nextskill

	jsr findFirstKeyPress
	cmp #RET
	beq .skillselected


	lda joyPressed
	bne .skillselected
	jmp .notskillselected
.skillselected

.waitskillselected
	jsr findFirstKeyPress
	cmp #RET
	beq .waitskillselected

	jsr blop

.pressed2
	jsr gatherJoystick
	lda joyPressed
	bne .pressed2

	rts


;--------------------------------------------------------------------
; blits a letter on x and y 
;--------------------------------------------------------------------
lettermask	 dc.b $00
letternumber dc.b $00
letterxpos   dc.b $00
letterypos   dc.b $00
lettercolor1  dc.b $14
lettercolor2  dc.b $54
; intern
lettercolor2Shift  dc.b $00
lettercolor1Shift  dc.b $00
lettercolors dc.b $00
letterlumas dc.b $00
letterwrite  dc.w $0000
letternumberi dc.b $00
blitLetterAtXAndY SUBROUTINE

	ldy letterypos
	lda MUL40LO,y
	clc
	adc letterxpos
	sta ZP_WRITE + 0
	lda MUL40HI,y
	adc #$00
	eor #$18 ; $1800
	sta ZP_WRITE + 1

	lda lettercolor1
	asl
	asl
	asl
	asl
	sta lettercolor2Shift
	lda lettercolor1
	lsr
	lsr
	lsr
	lsr
	sta lettercolor1Shift

	lda lettercolor2
	and #$0f
	ora lettercolor2Shift
	sta lettercolors

	lda lettercolor2
	and #$f0
	ora lettercolor1Shift
	sta letterlumas

	;-----
	lda letterlumas
	ldy #0
	sta (ZP_WRITE),y
	ldy #1
	sta (ZP_WRITE),y
	ldy #40
	sta (ZP_WRITE),y
	ldy #41
	sta (ZP_WRITE),y

	;-----
	lda ZP_WRITE + 1
	eor #$18
	eor #$1c
	sta ZP_WRITE + 1

	lda lettercolors
	ldy #0
	sta (ZP_WRITE),y
	ldy #1
	sta (ZP_WRITE),y
	ldy #40
	sta (ZP_WRITE),y
	ldy #41
	sta (ZP_WRITE),y

	;-----
	lda ZP_WRITE + 1
	eor #$1c
	sta ZP_WRITE + 1

	lda ZP_WRITE + 1
	asl
	asl
	asl
	sta ZP_WRITE + 1

	lda ZP_WRITE + 0
	lsr
	lsr
	lsr
	lsr
	lsr
	ora ZP_WRITE + 1
	sta ZP_WRITE + 1

	lda ZP_WRITE + 0
	asl
	asl
	asl
	sta ZP_WRITE + 0
	
	;-----
	lda ZP_WRITE + 0
	sta ZP_WRITE1 + 0
	sta ZP_WRITE2 + 0
	lda ZP_WRITE + 1
	eor #$20
	sta ZP_WRITE1 + 1
	lda ZP_WRITE + 1
	eor #$40
	sta ZP_WRITE2 + 1

	lda letternumber
	asl
	asl
	sta letternumberi


	lda letternumberi
	asl
	asl
	asl
	sta ZP_READ + 0
	lda letternumberi
	lsr
	lsr
	lsr
	lsr
	lsr
	sta ZP_READ + 1

	lda ZP_READ + 0
	clc
	adc #<BIGFONT
	sta ZP_READ + 0
	lda ZP_READ + 1
	adc #>BIGFONT
	sta ZP_READ + 1

	lda lettermask
	asl
	asl
	asl
	asl
	asl
	sta ZP_MASK + 0
	lda lettermask
	lsr
	lsr
	lsr
	sta ZP_MASK + 1

	lda ZP_MASK + 0
	clc
	adc #<MASK
	sta ZP_MASK + 0
	lda ZP_MASK + 1
	adc #>MASK
	sta ZP_MASK + 1

	ldy #$0f
.nextb1
	lda (ZP_READ),y
	and (ZP_MASK),y
	sta (ZP_WRITE1),y
	sta (ZP_WRITE2),y
	dey
	bpl .nextb1

	lda ZP_MASK + 0
	clc
	adc #<$10
	sta ZP_MASK + 0
	lda ZP_MASK + 1
	adc #>$10
	sta ZP_MASK + 1

	lda ZP_READ + 0
	clc
	adc #<$10
	sta ZP_READ + 0
	lda ZP_READ + 1
	adc #>$10
	sta ZP_READ + 1

	lda ZP_WRITE1 + 0
	clc
	adc #<320
	sta ZP_WRITE1 + 0
	lda ZP_WRITE1 + 1
	adc #>320
	sta ZP_WRITE1 + 1

	lda ZP_WRITE2 + 0
	clc
	adc #<320
	sta ZP_WRITE2 + 0
	lda ZP_WRITE2 + 1
	adc #>320
	sta ZP_WRITE2 + 1

	ldy #$0f
.nextb2
	lda (ZP_READ),y
	and (ZP_MASK),y
	sta (ZP_WRITE1),y
	sta (ZP_WRITE2),y
	dey
	bpl .nextb2

	rts

letterlookup dc.b $00
blitLetterAtXAndYLookup SUBROUTINE
	ldx letterlookup
	lda LETTERMAP,x
	sta letternumber
	tax
	lda COLS1,x
	sta lettercolor1
	lda COLS2,x
	sta lettercolor2
	jmp blitLetterAtXAndY

;--------------------------------------------------------------------
; blits the next letter
;--------------------------------------------------------------------
currentletterx dc.b $00
currentlettery dc.b $00
currenttextpos dc.w TEXT0
blitNextLetter SUBROUTINE

	lda currentletterx
	asl
	sta letterxpos
	lda currentlettery
	asl
	clc
	adc #LETTERSTARTY
	sta letterypos
	lda currenttextpos + 0
	sta .read + 1
	lda currenttextpos + 1
	sta .read + 2
.read
	lda $4444
	cmp #255
	bne .do
	lda #<TEXT0
	sta currenttextpos + 0
	lda #>TEXT0
	sta currenttextpos + 1
	lda #$00
	sta currentletterx
	sta currentlettery
	jmp blitNextLetter
.do	
	sta letternumber
	tax
	lda COLS1,x
	sta lettercolor1
	lda COLS2,x
	sta lettercolor2
	lda letterypos
	and #$02
	beq .zwo
	lda COLS12,x
	sta lettercolor1
	lda COLS22,x
	sta lettercolor2
.zwo

	jmp blitLetterAtXAndY

ADVANCE
	inc currenttextpos + 0
	bne .notinchi
	inc currenttextpos + 1
.notinchi

	inc currentletterx
	lda currentletterx
	cmp #20
	beq .notreturn
	rts
.notreturn
	lda #$00
	sta currentletterx
	inc currentlettery
	lda currentlettery
	cmp #LETTERCOUNTY
	beq .noreturn2
	rts
.noreturn2
	lda #$00
	sta currentlettery
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

waitBorder SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
	rts

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

frameCounter dc.b $00
frameCounterLetters dc.b $00
lettersOn dc.b $01
waitstarinit dc.b $80

lettersFunc SUBROUTINE
	lda frameCounterLetters
	and #$03
	bne .notnextletter
	lda #$00
	sta lettermask
	jsr ADVANCE
	jsr blitNextLetter
	jmp .doneletter
.notnextletter
	inc lettermask
	jsr blitLetterAtXAndY
.doneletter
	inc frameCounterLetters
	rts

isAlreadyProcessingInterrupt dc.b $00
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

	inc $ff09

	lda #LOGOFRONTCOLOR
	sta $ff16

	lda #<rasterIrqMiddle
	sta $fffe 
	lda #>rasterIrqMiddle
	sta $ffff 

	lda #91 ; rasterline 
	sta $ff0b

	cli
	lda isAlreadyProcessingInterrupt
	bne .notIsAlreadyProcessingInterrupt
	lda #$01
	sta isAlreadyProcessingInterrupt
	jsr paintDots
	lda waitstarinit
	beq .dohere
	dec waitstarinit
	jmp .donelet
.dohere
	lda lettersOn
	beq .noletters
	jsr lettersFunc
.noletters
	jsr LOGOFADEIN
.donelet
	lda #$00
	sta isAlreadyProcessingInterrupt
.notIsAlreadyProcessingInterrupt

	inc frameCounter

	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

rasterIrqMiddle SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	lda $ff13
	pha
	and #%11111101 
	sta $ff13

	inc $ff09

	lda #TEXTFRONTCOLOR
	sta $ff16

	jsr fw_lowirq_install

	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti


paintDots 
	lda ZP_FADEDOT
	beq .nodec
	dec ZP_FADEDOT
	dec ZP_FADEDOT
.nodec
	ldx #DOTCOUNT-1
.nextd
	stx .xrestore + 1
	lda DOTXPOS,x
	cmp ZP_FADEDOT
	bcc .nextdot
	lda DOTLOXPOS,x
	sbc DOTLOXADD,x
	sta DOTLOXPOS,x
	lda DOTXPOS,x
	sbc DOTXADD,x
	cmp DOTXPOS,x
	beq .nextdot
	cmp #$f0
	bcc .newdone
	lda #159
	clc
.newdone
	ldy DOTXPOS,x
	sta DOTXPOS,x
	lda DIV4MUL8LO,y
	adc DOTYPOSLO,x
	sta .clear + 1
	sta .read + 1
	lda DIV4MUL8HI,y
	adc DOTYPOSHI,x
	sta .clear + 2
	adc #$20
	sta .read + 2

.read
	lda $4444
.clear
	sta $4444

	ldy DOTXPOS,x

	lda DIV4MUL8LO,y
	adc DOTYPOSLO,x
	sta .writeread + 1
	sta .writewrite + 1
	lda DIV4MUL8HI,y
	adc DOTYPOSHI,x
	sta .writewrite + 2
	adc #$20
	sta .writeread + 2

	tya
	and #$03
	adc DOTCOLOR,x
	tay

.writeread
	lax $4444
.orat
	ora ORATABLE,y
	and ANDTABLE,x
.writewrite
	sta $4444

.nextdot
.xrestore
	ldx #$44
	dex
	bne .nextd

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
	LDA #$FF
	STA $FD30
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

passwordNumber dc.b $00

selectLevelToLoadByPassword SUBROUTINE
	lda #$00
	sta ZP_TEMP
	sta passwordNumber
.nextpassword
	ldy ZP_TEMP
	ldx #$00
.nextcheck
	lda levelPasswords,y
	cmp letters,x
	bne .nextPassword
	iny
	inx
	cpx #$06
	bne .nextcheck
    ; found level
	lda levelPasswords,y
	sta ZP_LEVELTOLOAD
	iny
	lda levelPasswords,y
	sta ZP_SKILLLEVEL
	rts
.nextPassword
	inc passwordNumber
	lda ZP_TEMP
	clc
	adc #$08
	sta ZP_TEMP
	lda passwordNumber
	cmp #PASSWORDCOUNT
	bne .nextpassword
	lda #$00
	sta ZP_SKILLLEVEL
	lda #$01
	sta ZP_LEVELTOLOAD
	rts
BIGFONT 
	incbin "bigfont.bin"
LOGOLUMI
	incbin "logoPictureLumi.bin"
LOGOCOLOR
	incbin "logoPictureColi.bin"
TEXT0
	incbin "text0.bin"
TEXT1
	incbin "text1.bin"
TEXT2
	incbin "text2.bin"
TEXT3
	incbin "text3.bin"
MASK
	incbin "mask.bin"
LETTERMAP
	incbin "letterMap.bin"

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

	include "dotspecs.inc"
COLS1
	incbin "colortable1.bin"
COLS2
	incbin "colortable2.bin"
COLS12
	incbin "colortable12.bin"
COLS22
	incbin "colortable22.bin"

	align 256
ORATABLE
	incbin "oratable.bin"
ANDTABLE
	incbin "andtable.bin"
DIV4MUL8LO
Y SET 0
	REPEAT 256
	dc.b <[Y/4*8]
Y SET Y + 1
	REPEND

DIV4MUL8HI
Y SET 0
	REPEAT 256
	dc.b >[Y/4*8]
Y SET Y + 1
	REPEND

	include "player_const.asm"
	include "player_symbols.asm"
	include "player_trigger.asm"
	include "soundeffects.asm"

triggerSound SUBROUTINE
	tax
	ldy #$0f
	jsr kp_triggerC
	rts

blip SUBROUTINE
	lda #$04
	jmp triggerSound

blop SUBROUTINE
	lda #$02
	jmp triggerSound

	include "player_clear.asm"

PLAYTITLESONG SUBROUTINE

	lda #$01
	sta fw_song_off
	lda #$00
	sta $ff11

	ldx #<[TitleSongEnd]
	ldy #>[TitleSongEnd]
	jsr fw_decrunch

	jsr waitFrame
	sei
	ldx #<MEMPOS_STANDARD_SONG
	ldy #>MEMPOS_STANDARD_SONG
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

waitbeforelogofadein dc.b $60
currentLogoYLine dc.b $00
currentLogoPos320 dc.w $0000
logoyadder dc.b $00

LOGOFADEIN SUBROUTINE
	
	lda waitbeforelogofadein
	beq .yeah
	dec waitbeforelogofadein
	rts
.yeah

	lda currentLogoYLine
	bmi .rts
	cmp #LOGOYSIZE*8
	bcc .donext
	lda logoyadder
	cmp #$02
	bne .do
.rts
	rts
.do
	inc logoyadder
	lda #LOGOYSIZE*8-1
	sta currentLogoYLine
	lda #<[320*[LOGOYSIZE-1]]
	sta currentLogoPos320 + 0
	lda #>[320*[LOGOYSIZE-1]]
	sta currentLogoPos320 + 1
.donext

	lda currentLogoPos320 + 0
	clc
	adc #<LOGOPICTURE
	sta ZP_LOGOFADEREAD + 0
	lda currentLogoPos320 + 1
	adc #>LOGOPICTURE
	sta ZP_LOGOFADEREAD + 1

	lda currentLogoPos320 + 0
	sta ZP_LOGOFADEWRITE + 0
	sta ZP_LOGOFADEWRITE2 + 0
	lda currentLogoPos320 + 1
	adc #>$2000
	sta ZP_LOGOFADEWRITE2 + 1
	lda currentLogoPos320 + 1
	adc #>$4000
	sta ZP_LOGOFADEWRITE + 1

	lda currentLogoYLine
	clc
	and #$07
	tay
	ldx #40
.nextx
	lda (ZP_LOGOFADEREAD),y
	sta (ZP_LOGOFADEWRITE),y
	sta (ZP_LOGOFADEWRITE2),y
	tya
	clc
	adc #$08
	tay
	bcc .yo
	inc ZP_LOGOFADEREAD + 1
	inc ZP_LOGOFADEWRITE + 1
	inc ZP_LOGOFADEWRITE2 + 1
.yo
	dex
	bne .nextx


	lda logoyadder
	beq .normaldown
	dec currentLogoYLine
	dec currentLogoYLine
	lda currentLogoYLine
	and #$07
	cmp #$07
	bne .oknohidec
	lda currentLogoPos320 + 0
	sec
	sbc #<320
	sta currentLogoPos320 + 0
	lda currentLogoPos320 + 1
	sbc #>320
	sta currentLogoPos320 + 1
.oknohidec
	jmp .done
.normaldown
	inc currentLogoYLine
	inc currentLogoYLine
	lda currentLogoYLine
	and #$07
	bne .oknohiinc
	lda currentLogoPos320 + 0
	clc
	adc #<320
	sta currentLogoPos320 + 0
	lda currentLogoPos320 + 1
	adc #>320
	sta currentLogoPos320 + 1
.oknohiinc
.done
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

	include "passwords.asm"

LOGOPICTURE
	incbin "logopicture.bin"
RAND
	incbin "randtablogo.bin"
currentPointerRand dc.w RAND

	include "fadercode.asm"


TitleSong
	incbin "mos2_title.exo"
TitleSongEnd

fname dc.b "LS",$00
;--------------------------------------------------------------------------------------------------
; loadNext SUBROUTINE
;--------------------------------------------------------------------------------------------------
loadNext SUBROUTINE

	ldx #<fname
  	ldy #>fname 
	LOAD_NORMAL

	ldx fw_load_end + 0
	ldy fw_load_end + 1
	jsr fw_decrunch

	jmp ENTRYPOINT_LOADINGSCREEN ; STARTPICTURE

initiateOutfade SUBROUTINE
	lda $ff12
	and #%11000011 
	ora #%00010000  ; $4000
	sta $ff12

	ldx #$00
	ldy #$20
	lda #$00
.x
	sta $4000,x
	inx
	bne .x
	inc .x + 2
	dey
	bne .x

	ldy #40
.yo
	lda #$ff
.mo
	sta $4000 + 320*12,x
	txa
	clc
	adc #$08
	tax
	bcc .do
	inc .mo + 2
.do
	dey
	bne .yo

	jsr waitFrame
	lda #$71
	sta $ff16

	lda #%00111011
	sta $ff06
	jsr waitFrame

	sei
	lda #<blinky_plugin
	sta fw_topirq_plugin + 0
	lda #>blinky_plugin
	sta fw_topirq_plugin + 1
	cli

	rts

pos1 dc.w $4000 + 320*12
pos2 dc.w $4000 + 320*12 + 39 * 8
byte1 dc.b $ff
byte2 dc.b $ff
counter dc.b 40
pointcolorcounter dc.b $00
pointcolors 
Y SET 0
	REPEAT $08
	dc.b Y * $10 + $01
Y SET Y + 1
	REPEND
Y SET 0
	REPEAT $08
	dc.b [7-Y] * $10 + $01
Y SET Y + 1
	REPEND

blinky SUBROUTINE
	
	lda counter
	bne .donormal

	lda pos1 + 0
	sta .write3 + 1
	lda pos1 + 1
	sta .write3 + 2
	lda #%00001100
.write3
	sta $4444

	lda pointcolorcounter 
	cmp #$20
	bne .do
	lda #$00
	sta $ff16
	rts
.do
	and #$0f
	tax
	lda pointcolors,x
	sta $ff16

	inc pointcolorcounter 
	rts
.donormal
	dec counter

	lda byte1
	lsr
	lsr
	lsr
	lsr
	sta byte1

	lda pos1 + 0
	sta .write1 + 1
	lda pos1 + 1
	sta .write1 + 2

	lda byte1
.write1
	sta $4444

	lda byte2
	asl
	asl
	asl
	asl
	sta byte2

	lda pos2 + 0
	sta .write2 + 1
	lda pos2 + 1
	sta .write2 + 2

	lda byte2
.write2
	sta $4444


	lda byte1
	bne .byte1ok
	lda pos1 + 0
	clc
	adc #<$08
	sta pos1 + 0
	lda pos1 + 1
	adc #>$08
	sta pos1 + 1
	lda #$ff
	sta byte1
.byte1ok

	lda byte2
	bne .byte2ok
	lda pos2 + 0
	sec
	sbc #<$08
	sta pos2 + 0
	lda pos2 + 1
	sbc #>$08
	sta pos2 + 1
	lda #$ff
	sta byte2
.byte2ok

	rts

blinky_plugin SUBROUTINE 
	lda #<blinkyIrq 
	sta $fffe 
	lda #>blinkyIrq
	sta $ffff 
	lda #2		; raster irq 
	sta $ff0a 
	lda #$00	; rasterline 
	sta $ff0b
	PLUGIN_CANCELDEFAULT 
	rts 

blinkyIrq SUBROUTINE
	pha
	txa
	pha
	tya
	pha
	lda $ff13
	pha
	and #%11111101 
	sta $ff13

	jsr blinky

	jsr fw_lowirq_install
	inc $ff09

	pla
	sta $ff13
	pla
	tay
	pla
	tax
	pla
	rti

	echo "eof: " ,.