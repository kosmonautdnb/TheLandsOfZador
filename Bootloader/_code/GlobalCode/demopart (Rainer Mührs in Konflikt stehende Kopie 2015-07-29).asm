    processor   6502

	include "macros.asm"
	include "standard.asm"
	include "loadingPictureConstants.inc"

	ORG $1001
	DC.W $100B,0
	DC.B $9E,"4109",0,0,0	; SYS4107
	JMP MAINPRG
	
	ORG $1800,$00
	include "fw_interface.asm"
	include "fw_bootstrap.asm"	

TEXTCOLOR = $71

	ORG $5800
	ds.b $800,$00
;--------------------------------------------------------------------
; Hauptprogramm (Init)
;--------------------------------------------------------------------
MAINPRG SUBROUTINE

	jsr waitFrame
	lda #$00
	sta $ff15
	sta $ff19
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
	jsr fw_init
;	lda #$01
;	sta fw_song_off

	sei
    sta $ff3f
    
    lda #$00
    sta $ff0a
    
    lda $ff09
    sta $ff09
    
	ldy #$04
	lda #$00
.0	sta $0000,y
	iny
	bne .0
	
	jsr fw_run
	cli
	

	lda #<LUMRAM
	sta .read + 1
	lda #>LUMRAM
	sta .read + 2
	lda #<$b800
	sta .write + 1
	lda #>$b800
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
	
	jsr displayInfoScreen

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

	ldx #%10111000 ; adress b800 ff14
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

	include "fadein.asm"
INFOSCREEN
	incbin "infoscreen.bin"
INFOCHARSET
	incbin "infocharset.bin"

displayInfoScreen SUBROUTINE

	lda #$0b
	sta $ff06

	;-------------------------------------------------------------------
	; char reversing of | no multicolor
	;-------------------------------------------------------------------
	lda #%10001000
	sta $ff07

	lda #%00011000 ; 1800
	sta $ff14

	;-------------------------------------------------------------------
	; bitmap adress 2000 - bitmap from ram - prevail voice frequencies
	;-------------------------------------------------------------------
	lda $ff12
	and #%11000011 
	ora #%00110000 ; c000 
	sta $ff12

	;-------------------------------------------------------------------
	; font adress 2000
	;-------------------------------------------------------------------
	lda $ff13
	and #%00000101
	ora #%00100000 ; bit 2=1 auf slow 
	sta $ff13

	ldx #$00
.b
Y SET 0
	REPEAT $08
	lda INFOCHARSET + Y * $100,x
	sta $2000 + Y * $100,x
Y SET Y + 1
	REPEND
	inx
	bne .b

	ldx #$00
.next
	lda INFOSCREEN + $100*0,x
	sta $1c00 + $100*0,x
	lda INFOSCREEN + $100*1,x
	sta $1c00 + $100*1,x
	lda INFOSCREEN + $100*2,x
	sta $1c00 + $100*2,x
	lda INFOSCREEN + $100*3,x
	sta $1c00 + $100*3,x
	lda #$00
	sta $1800 + $100*0,x
	sta $1800 + $100*1,x
	sta $1800 + $100*2,x
	sta $1800 + $100*3,x
	inx
	bne .next

	;-------------------------------------------------------------------
	; bitmap mode
	;-------------------------------------------------------------------
	lda #%00011011
	sta $ff06

Y SET 0
	REPEAT $07
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	lda #[Y * $10] + [TEXTCOLOR & $0f]
	sta $ff15
Y SET Y + 1
	REPEND

	ldx #250
.a
	jsr waitFrame
	dex
	bne .a

Y SET 0
	REPEAT $07
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	lda #[[6-Y] * $10] + [TEXTCOLOR & $0f]
	sta $ff15
Y SET Y + 1
	REPEND

	rts


	ORG $f500 - $2800
LUMRAM
	incbin "loadingPictureLumi.bin"
	ds.b 24,0
COLRAM
	incbin "loadingPictureColi.bin"
	ds.b 24,0
BITMAP
	incbin "loadingPicture.bin"

	ORG $f500
fname dc.b "STARTPIC",$00
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

	jmp ENTRYPOINT_STARTPICTURE ; STARTPICTURE

	echo "eof: ",.
	