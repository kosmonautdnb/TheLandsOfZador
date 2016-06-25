    processor   6502

	include "macros.asm"
	include "standard.asm"
	include "persistent.asm"
	include "loadingPictureConstants.inc"

	;ORG $1001
	;DC.W $100B,0
	;DC.B $9E,"4109",0,0,0	; SYS4107
	ORG 4109
	JMP MAINPRG

	ORG $1800,$00
	include "fw_interface.asm"
	include "fw_bootstrap.asm"	
;fw_init = $17fa
;fw_run = $17fd


	ORG $5800
LUMRAM2
	incbin "psytronikPictureLumi.bin"
	ds.b 24,0
COLRAM2
	incbin "psytronikPictureColi.bin"
	ds.b 24,0
TEXTCOLOR = $71

KERNAL_SETLFS	= $ffba
KERNAL_SETNAM	= $ffbd
KERNAL_CLOSE	= $ffc3
KERNAL_LOAD		= $ffd5

fn dc.b "LOADER",0

;--------------------------------------------------------------------
; Hauptprogramm (Init)
;--------------------------------------------------------------------
MAINPRG SUBROUTINE

	lda $ff19
	and #$7f
	sta .biosloadingzp + 1

	lda #32
	ldx #79
.nextx
	sta $0c00,x
	dex
	bpl .nextx

	ldx #$00
.nextfl	
	lda FASTLOADTEXT,x
	beq .donefl
	clc
	adc #[-"A" + 1] & 255
	sta $0c00,x
	inx
	bne .nextfl
.donefl

.waitkey
	LDA #$f7	 ;Check column 4 "Y"
	STA $FD30	 ;Write to Keyboard Matrix
	STA $FF08	 ;Write to Keyboard Latch
	LDA $FF08	 ;Read from Keyboard Latch
	AND #$02	 ;Query keyboard for "Y"
	BNE not_pressed1
	inc $ff19
	lda #$01
	sta .biosloadingzp + 1
	jmp .donekey
not_pressed1

	LDA #$FD	 ;Check column 2 "Z"
	STA $FD30	 ;Write to Keyboard Matrix
	STA $FF08	 ;Write to Keyboard Latch
	LDA $FF08	 ;Read from Keyboard Latch
	AND #$10	 ;Query keyboard for "Z"
	BNE not_pressed2
	inc $ff19
	lda #$01
	sta .biosloadingzp + 1
	jmp .donekey
not_pressed2

	LDA #$EF	 ;Check column 5
	STA $FD30	 ;Write to Keyboard Matrix
	STA $FF08	 ;Write to Keyboard Latch
	LDA $FF08	 ;Read from Keyboard Latch
	AND #$80	 ;Query keyboard for "N"
	BNE not_pressed3
	inc $ff19
	lda #$00
	sta .biosloadingzp + 1
	jmp .donekey
not_pressed3

	jmp .waitkey
.donekey


	jsr playYScratcherSound

	jsr waitFrame
	lda #%00111011
	sta $FF06 ; bitmap mode + visible

	lda #$00
	sta $ff19
	sta $ff15
	lda #$61
	sta $ff16

	lda #%00011000 ; multicolor
	sta $ff07
	
	lda $ff12
	and #%00000011
	ora #%00101000 ; bitmap adress $a000
	sta $ff12

	lda #$58
	sta $ff14 ; colorram address $1800

	ldx #50*3
.wait
	jsr waitFrame
	dex
	bne .wait

	jsr playYScratcherSound

	jsr waitFrame
	lda #$0b
	sta $ff06
	jsr waitFrame

	lda #$00
	;sta $ff19
	;sta $ff15
	sei
	lda $ff13
	sta .yo + 1
	and #%11111101
	; bit 2=1 auf slow 
	sta $ff13
.yo
	lda #$44
	ora #%00000010
	sta $ff13

	lda #$00
	sta $ff11

	jsr waitFrame
	lda #%01011000 ; adress 5800 ff14
	sta $ff14

	lda #$01
	sta $ff3e
	cli

	lda #$00
.biosloadingzp
	ldx #$44
	bne .zwodrio
	lda #$01
.zwodrio
	sta ZP_USEBIOSLOADING ; ;will be changed by fw_init

	lda ZP_USEBIOSLOADING ; skip loader init
	jsr fw_init
;	lda #$01
;	sta fw_song_off

	sei
    sta $ff3f
    
    lda #$00
    sta $ff0a
    
    lda $ff09
    sta $ff09

	ldx ZP_USEBIOSLOADING
    
	ldy #$04
	lda #$00
.0	sta $0000,y
	iny
	bne .0

	stx ZP_USEBIOSLOADING
	
	jsr fw_run
	cli

	lda #$01
	sta fw_song_off
 ;;  no interstitial (presents a game by)
    jsr showInterstitial
	lda #$00
	sta fw_song_off

	lda #<BITMAP
	sta .read + 1
	lda #>BITMAP
	sta .read + 2
	lda #<$c000
	sta .write + 1
	lda #>$c000
	sta .write + 2
	ldx #$28
.reloop2
	ldy #$00
.reloop
.read
	lda $4444,y
.write
	sta $4444,y
	iny
	bne .reloop
	inc .read + 2
	inc .write + 2
	dex
	bne .reloop2

	jsr waitFrame
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
	lda #$fe
.a
	cmp $ff1d
	bne .a
	
;	jsr displayInfoScreen

	;-------------------------------------------------------------------
	; verticalSmoothscrollposition3 - 25Rows - BlankScreen
	;-------------------------------------------------------------------
	;lda #%00111011
	lda #$0b
	sta $ff06

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
	ora #%00110000 ; c000 
	sta $ff12

	;-------------------------------------------------------------------
	; font adress 3800
	;-------------------------------------------------------------------
	lda $ff13
	and #%00000101
	ora #%00111000 ; bit 2=1 auf slow 
	sta $ff13

	ldx #%11100000 ; adress b800 ff14
	stx $ff14

	lda #loadingFrontColor
	sta $ff16

	jsr FADEINAMIGA

	jmp loadNext

waitFrame SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
.waita
	bit $ff1c
	bne .waita
	rts

------------------
playYScratcherSound SUBROUTINE
	lda $ff07
	sta .restore7 + 1
	lda $ff06
	sta .restore6 + 1
	lda $ff12
	sta .restore12 + 1
	lda $ff11
	sta .restore11 + 1
	lda $ff10
	sta .restore10 + 1
	
	ldy #$20
	ldx #$00
.a
	lda $e000,x
	and #%01111111
	sta $ff06

	lda $e100,x
	and #%10011111
	sta $ff07

	lda $e200,x
	sta $ff10
	lda $e300,x
	ora #%01000000
	sta $ff11
.nx
	inx
	bne .a
	dey
	bne .a

.restore6
	lda #$44
	sta $ff06
.restore7
	lda #$44
	sta $ff07
.restore12
	lda #$44
	sta $ff12
.restore11
	lda #$44
	sta $ff11
.restore10
	lda #$44
	sta $ff10
	lda #$0b
	sta $ff06
	lda #%00111011
	sta $ff06
	rts

showInterstitial SUBROUTINE

	;-------------------------------------------------------------------
	; disable screen
	;-------------------------------------------------------------------
	lda #$0b
	sta $ff06

	jsr waitFrame

	lda #$00
	sta $ff15
	lda #$00
	sta $ff16
	lda #$00
	sta $ff17

	;-------------------------------------------------------------------
	; font adress 3800
	;-------------------------------------------------------------------
	lda $ff13
	and #%00000101 ; bit 2=1 auf slow
	ora #%00111000  
	sta $ff13

	;-------------------------------------------------------------------
	; bitmap adress 2000 | bitmap ram 
	;-------------------------------------------------------------------
	lda $ff12
	and #%11000011 
	ora #%00001000 
	sta $ff12

	lda $ff14 ; 1800
	and #%00000111
	ora #%00011000
	sta $ff14

	lda #%10011000 ; we want multicolor
	sta $ff07

	ldx #$00
.chcopy
Y SET 0
	REPEAT $08
	lda PCHARSET + $100*Y,x
	sta $3800 + $100*Y,x
Y SET Y + 1
	REPEND
	inx
	bne .chcopy

	ldx #$00
.yo
	lda #$00
	sta $1800,x
	sta $1900,x
	sta $1a00,x
	sta $1b00,x
	inx
	bne .yo

	ldx #39
.sccopy
YPOSITIONPRESENTS = 8
Y SET 0
	REPEAT $08
	lda PSCREEN + 40*Y,x
	sta $1c00 + 40*[Y+YPOSITIONPRESENTS],x
Y SET Y + 1
	REPEND
	dex
	bpl .sccopy

	lda #%00011011
	sta $ff06

; fadein

	ldy #$00
.nextin
	jsr waitFrame
	jsr waitFrame
	jsr fadeCharScreen
	iny
	cpy #$09
	bne .nextin


	ldx #$40
.nextwait
	jsr waitFrame
	dex
	bne .nextwait

	ldy #$08
.nextout
	jsr waitFrame
	jsr waitFrame
	jsr fadeCharScreen
	dey
	bpl .nextout

	rts

fadeCharScreen SUBROUTINE

	lda PCOLOR1iter,y
	sta $ff16
	lda PCOLOR2iter,y
	sta $ff17

	lda PCOLOR3iter,y
	ldx #39
.sccopy
Y SET 0
	REPEAT $08
	sta $1800 + 40*[Y+YPOSITIONPRESENTS],x
Y SET Y + 1
	REPEND
	dex
	bpl .sccopy

	rts

	include "interstitialcols.inc"

PSCREEN
	incbin "interstitial_screen.bin"
PCHARSET
	incbin "interstitial_charset.bin"

	include "fadein.asm"

FASTLOADTEXT
	dc.b "FASTLOADER[Y",$2f-[[-"A"+1] & 255],"N]",0

	include "exodecrunch.s"
isdecrunching dc.b $00

	ORG $a000
BITMAP2
	incbin "psytronikPicture.bin"

	ORG $f500 - $2800
BITMAP
	incbin "loadingPicture.bin"
	ds.b 24*8,0
LUMRAM
	incbin "loadingPictureLumi.bin"
	ds.b 24,0
COLRAM
	incbin "loadingPictureColi.bin"
	ds.b 24,0

	ORG $f500
fname dc.b "SP",$00
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

	lda #$01
.waitb
	bit $ff1c
	beq .waitb
.waita
	bit $ff1c
	bne .waita

	jmp ENTRYPOINT_STARTPICTURE ; STARTPICTURE

	echo "eof: ",.
	