    processor   6502

	include "fw_interface.asm"
	include "macros.asm"
	include "standard.asm"
	include "loadingPictureConstants.inc"
	include "persistent.asm"


	ORG $4000
;--------------------------------------------------------------------
; Hauptprogramm (Init)
;--------------------------------------------------------------------
MAINPRG SUBROUTINE

	jsr fadeOver

;	jsr LOADSONG

	lda #$0b
	sta $ff06
	jsr waitFrame

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

	lda #$00
	sta $ff19
	lda #loadingBackColor
	sta $ff15
	lda #loadingFrontColor
	sta $ff16

	jsr FADEINAMIGA

	ldx #$00
.b
	lda .stub,x
	sta $1800,x
	inx
	cpx #.stubEnd - .stub
	bne .b

	lda #$00
	sta ZP_DONTFADEOUT

	jmp $1800
fname dc.b "SS",$00

.stub
	ldx #<fname
  	ldy #>fname 
	LOAD_NORMAL

	ldx fw_load_end + 0
	ldy fw_load_end + 1
	jsr fw_decrunch

	lda kp_pattern_counter
.waita
	cmp kp_pattern_counter
	beq .waita

	jmp ENTRYPOINT_STARTSCREEN ; STARTSCREEN
.stubEnd

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

	ldx #<MEMPOS_STANDARD_SONG 
	ldy #>MEMPOS_STANDARD_SONG 
	lda #$01
	jsr fw_initplayer
	jsr kp_clear
	lda #$00
	sta kp_pattern_counter

	jsr waitFrame
	lda #$00
	sta fw_song_off
	rts

	include "player_clear.asm"
SONGMEM_START
	incbin "memsong.exo"
SONGMEM_END

waitFrame SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
.waita
	bit $ff1c
	bne .waita
	rts

fortyline
	incbin "fortyline.bin"
dectable
	incbin "dectable.bin"
bitconverttable
	incbin "bitconverttable.bin"


	include "fadein.asm"
	include "fadercode.asm"

LUMRAM
	incbin "loadingPictureLumi.bin"
	ds.b 24,0
COLRAM
	incbin "loadingPictureColi.bin"
	ds.b 24,0
BITMAP
	incbin "loadingPicture.bin"

	