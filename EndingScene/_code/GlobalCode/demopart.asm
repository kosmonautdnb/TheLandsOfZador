    processor   6502

	include "macros.asm"
	include "persistent.asm"

SCREEN8 = $6000

; Das meiste $4000 fressen hier die vorberechneten Frames, später besser mit MatrixRotation!
; das klipping kann ganz einfach gemacht werden einfach in die loops einbauen, kein pre clipping
COLOR1 = $13
COLOR2 = $43
COLOR3 = $73

mul8_xtmp			= $16  ;temporary for X reg
mul8_rl				= $17  ;result lo
mul8_rh             = $18  ;result hi

; background stuff
bgtexxlo			= $19 ; 1
bgtexxhi			= $1a ; 1
bgypos				= $1b ; 1
bgendydiv2			= $1c ; 1	
ZP_16BIT8DIVISIONBY = $1d ; 1
ZP_16BIT8DIVISION   = $1e ; 2

ZP_FRAME_READ		= $20 ; 2
mul_factor1			= $22 ; 2
mul_factor2			= $24 ; 2
mul_result			= $26 ; 4

	include "polyconstants.asm" ; $30 - $60

	include "backgroundsetup.inc"
	; $80 - $a0 is persistent game data
ZP_BACKGROUND_OFFSETS = $b0 ; BACKGROUNDYSIZE (64) / 2 * 2

OPC_LDA_ABS_X = $BD
OPC_LDA_I_ZY  = $B1
OPC_STA_ABS_X = $9D
OPC_RTS = $60

SCREENXSIZE = 128
SCREENYSIZE = 192
SCREENXP4 = 4 ; the xposition/4 of the 32 window
YMOVE = 8

TEXTCOLOR			= $04
TEXTLUMASTEPS		= $08

	include "fw_interface.asm"

BACKGROUNDBYTE = %01101100

	ORG $6800
MAINPRG

	jsr mul8_genabstab
	jsr mul8_gensqrtab

	;-------------------------------------------------------------------
	; disable screen
	;-------------------------------------------------------------------
	lda #$0b
	sta $ff06

	jsr waitFrame

	lda #$00
	sta $ff15
	lda #COLOR3
	sta $ff16

	;-------------------------------------------------------------------
	; bitmap adress 2000 - bitmap from ram - prevail voice frequencies
	;-------------------------------------------------------------------
	lda $ff12
	and #%11000011 
	ora #%00001000  
	sta $ff12

	jsr displayStartText

	lda #TEXTCOLOR
	jsr fadeIn

	ldx #<SCENE1END
	ldy #>SCENE1END
	jsr fw_decrunch


	lda #TEXTCOLOR
	jsr fadeOut

	jsr waitFrame

	lda #$0b
	sta $ff06
	lda #$00
	sta $ff15

	ldx #$00
.do
Y SET 0
	lda #[[COLOR1>>4] & 15]|[[[COLOR2>>4] & 15]<<4]
	REPEAT $04
	sta SCREEN8 + Y * $100,x
Y SET Y + 1
	REPEND
	lda #[COLOR2 & 15]|[[COLOR1 & 15]<<4]
Y SET 0
	REPEAT $04
	sta SCREEN8 + $400 + Y * $100,x
Y SET Y + 1
	REPEND
	inx
	bne .do

	;-------------------------------------------------------------------
	; char reversing of | multicolor
	;-------------------------------------------------------------------
	lda #%10011000
	sta $ff07

	;-------------------------------------------------------------------
	; font adress 3800
	;-------------------------------------------------------------------
	lda $ff13
	and #%00000101
	ora #%00111000 ; bit 2=1 auf slow 
	sta $ff13

	ldx #>SCREEN8 ; adress 6000 ff14
	stx $ff14

	lda #<$2000
	sta ZP_BITMAPWRITE + 0
	lda #>$2000
	sta ZP_BITMAPWRITE + 1
.clear2
	ldy #$00
	lda #BGCOLORBYTE
.clear1
	sta (ZP_BITMAPWRITE),y
	iny 
	bne .clear1
	inc ZP_BITMAPWRITE + 1
	lda ZP_BITMAPWRITE + 1
	cmp #>SCREEN8
	bne .clear2
	
	lda #<SCENEADR
	sta currentRead + 0
	lda #>SCENEADR
	sta currentRead + 1
	
	jsr waitFrame
	;-------------------------------------------------------------------
	; enable screen
	;-------------------------------------------------------------------
	lda #%00110000 ; 24 rows
	ora #$01 ; we must move the screen 1 down because of a "lastlinebug"
	sta $ff06

MAINLOOP
	jsr waitBorder
	jsr switchBuffers
	lda waitBefore
	cmp #18
	bcc .donormal
	jsr clear
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jmp .rettich
.donormal
	jsr clear
	jsr nextFrame
	inc frameCounter
.rettich
	
	lda waitBefore
	beq .notdo
	dec waitBefore
	clc
	adc #SCREENYSIZE-BACKGROUNDYSIZE
	sta backgroundYPos
	jsr setBackgroundYPos
.notdo

	lda quitFlag
	beq MAINLOOP

	jsr waitFrame
	lda #$0b
	sta $ff06
	jsr waitFrame

	ldx #<STARSHIPSFILENAME
	ldy #>STARSHIPSFILENAME
	LOAD_NORMAL

	ldx fw_load_end + 0
	ldy fw_load_end + 1
	jsr fw_decrunch

	jsr CharScreen

	jmp ENDSHIPSADR

STARSHIPSFILENAME dc.b "SH",0

waitBefore dc.b BACKGROUNDYSIZE
quitFlag dc.b $00

int16_temp1	dc.w $0000
int16_temp2 dc.w $0000
	include "int16.asm"
	include "int32.asm"

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

; ---------------------------------- POLYGONSTUFF FROM HERE
	; 16 bit add without carry
	MAC ADD16c
	lda {1}+0
	adc {2}+0
	sta {3}+0
	lda {1}+1
	adc {2}+1
	sta {3}+1
	ENDM

	; 16 bit sub without carry
	MAC SUB16c
	lda {1}+0
	sbc {2}+0
	sta {3}+0
	lda {1}+1
	sbc {2}+1
	sta {3}+1
	ENDM

	MAC ADD16POLY
	; lustigerweise produziert add16c sogar weniger visuelle bugs
	ADD16c {1},{2},{3}
	ENDM

;--------------------------------------------
; divides a 16 bit value by a 8 bit value
;--------------------------------------------
divide16_8 SUBROUTINE
	ldy #$00
	lda (ZP_16BIT8DIVISION),y
	sta mul_factor1 + 0
	iny
	lda (ZP_16BIT8DIVISION),y
	sta mul_factor1 + 1

	; negate 1
	ldx #$00
	lda (ZP_16BIT8DIVISION),y
	bpl .notnegate
	nega_w mul_factor1
	ldx #$01
.notnegate
	stx .sign + 1
	
	ldy ZP_16BIT8DIVISIONBY
	lda Reziproke16Lo,y
	sta mul_factor2 + 0
	lda Reziproke16Hi,y
	sta mul_factor2 + 1

	umua_w mul_result,mul_factor1,mul_factor2

	; negate 2
.sign
	lda #$44
	beq .nosign
	nega_w mul_result + 2
.nosign

	ldy #$00
	lda mul_result + 2
	sta (ZP_16BIT8DIVISION),y
	iny
	lda mul_result + 3
	sta (ZP_16BIT8DIVISION),y

	rts

drawnPolys dc.b $00
MAXPOLYPOINTS = $10
	include "poly.asm"
; ---------------------------------- POLYGONSTUFF TO HERE

sceneDone SUBROUTINE
	lda #<SCENEADR
	sta currentRead + 0
	lda #>SCENEADR
	sta currentRead + 1
	lda #SCREENYSIZE - BACKGROUNDYSIZE
	sta backgroundYPos
	lda #$01
	sta quitFlag
	rts

currentRead dc.w $0000
nextFrame SUBROUTINE
.again
	lda currentRead + 0 
	sta ZP_FRAME_READ + 0
	lda currentRead + 1
	sta ZP_FRAME_READ + 1

	ldy #$00
	lda (ZP_FRAME_READ),y
	bne .yo
	lda currentRead + 0 
	clc
	adc #<[$01]
	sta currentRead + 0
	lda currentRead + 1 
	adc #>[$01]
	sta currentRead + 1
	jmp .frameDone
.yo
	cmp #$ff
	bne .yo2
	jsr sceneDone
	jmp nextFrame
.yo2

	tax
	and #15
	sta p_cnt
	txa
	lsr
	lsr
	lsr
	lsr
	bne .zw
	lda #$01
.zw
	and #$07
	sta p_cr
	iny

	lda #$00
	sta p_ydiv2
	txa
	bpl .notdiv2
	lda #$01
	sta p_ydiv2
.notdiv2

	ldx #$00
.nextcoord
	lda (ZP_FRAME_READ),y
	sta p_xr + 0,x
	iny
	lda (ZP_FRAME_READ),y
	sta p_yr + 0,x
	iny
	inx
	cpx p_cnt
	bne .nextcoord

	tya
	clc
	adc currentRead + 0 
	sta currentRead + 0
	lda currentRead + 1 
	adc #$00
	sta currentRead + 1
	
	jsr drawPolyCore

	jmp .again

.frameDone

	rts

switchBuffers SUBROUTINE
	lda doubleBuffer
	eor #$01
	sta doubleBuffer
	bne .zwo
	;-------------------------------------------------------------------
	; bitmap adress 2000 - bitmap from ram - prevail voice frequencies
	;-------------------------------------------------------------------
	lda $ff12
	and #%11000011 
	ora #%00001000  
	sta $ff12
	lda #<MUL10BLITSLOWLO2
	sta ZP_MUL10BLITSLOWLO + 0
	lda #>MUL10BLITSLOWLO2
	sta ZP_MUL10BLITSLOWLO + 1
	lda #<MUL10BLITSLOWHI2
	sta ZP_MUL10BLITSLOWHI + 0
	lda #>MUL10BLITSLOWHI2
	sta ZP_MUL10BLITSLOWHI + 1

	lda #<MUL3BLITFASTLO2
	sta ZP_MUL3BLITFASTLO + 0
	lda #>MUL3BLITFASTLO2
	sta ZP_MUL3BLITFASTLO + 1
	lda #<MUL3BLITFASTHI2
	sta ZP_MUL3BLITFASTHI + 0
	lda #>MUL3BLITFASTHI2
	sta ZP_MUL3BLITFASTHI + 1
	rts
.zwo
	;-------------------------------------------------------------------
	; bitmap adress 4000 - bitmap from ram - prevail voice frequencies
	;-------------------------------------------------------------------
	lda $ff12
	and #%11000011 
	ora #%00010000  
	sta $ff12

	lda #<MUL10BLITSLOWLO
	sta ZP_MUL10BLITSLOWLO + 0
	lda #>MUL10BLITSLOWLO
	sta ZP_MUL10BLITSLOWLO + 1
	lda #<MUL10BLITSLOWHI
	sta ZP_MUL10BLITSLOWHI + 0
	lda #>MUL10BLITSLOWHI
	sta ZP_MUL10BLITSLOWHI + 1

	lda #<MUL3BLITFASTLO
	sta ZP_MUL3BLITFASTLO + 0
	lda #>MUL3BLITFASTLO
	sta ZP_MUL3BLITFASTLO + 1
	lda #<MUL3BLITFASTHI
	sta ZP_MUL3BLITFASTHI + 0
	lda #>MUL3BLITFASTHI
	sta ZP_MUL3BLITFASTHI + 1
	rts


backgroundYPos dc.b SCREENYSIZE - BACKGROUNDYSIZE
backgroundstartyintern dc.b $00
backgroundendyintern dc.b $00

clear SUBROUTINE

	lda frameCounter
	cmp #15
	bcc .notbackmove
	lda backgroundYPos
	cmp #SCREENYSIZE
	bcs .notbackmove
	inc backgroundYPos
	jsr setBackgroundYPos
.notbackmove

	ldx doubleBuffer

	lda largestYFrame,x
	cmp smallestYFrame,x
	bcs .weiter1
	jmp .done
.weiter1
	lda largestXFrame,x
	cmp smallestXFrame,x
	bcs .weiter2
	jmp .done
.weiter2
	lda largestXFrame,x
	cmp #SCREENXSIZE
	bcc .weiter3
	jmp .done
.weiter3
	lda largestYFrame,x
	cmp #SCREENYSIZE
	bcc .weiter4
	jmp .done
.weiter4
	
	lda largestYFrame,x
	sta backgroundendyintern
	cmp backgroundYPos
	bcc .onlyclear

	lda backgroundYPos
	sta backgroundstartyintern

	lda smallestYFrame,x
	cmp backgroundYPos
	bcc .notonlybackground
	sta backgroundstartyintern
	jsr drawBackground
	jmp .done
.notonlybackground
	jsr drawBackground
	ldx doubleBuffer
	lda backgroundYPos
	sta largestYFrame,x ; largest frame y modified
.onlyclear

	lda smallestYFrame,x
	lsr
	tay
	lda (ZP_MUL3BLITFASTLO),y
	sta .jumpin1 + 1
	sta .jumpin2 + 1
	lda (ZP_MUL3BLITFASTHI),y
	sta .jumpin1 + 2
	sta .jumpin2 + 2
	
	lda largestYFrame,x
	lsr
	tay
	iny
	cpy #SCREENYSIZE
	bcc .noproblem2
	ldy #SCREENYSIZE
.noproblem2
	lda (ZP_MUL3BLITFASTLO),y
	sta ZP_RTS_PLACER + 0
	lda (ZP_MUL3BLITFASTHI),y
	sta ZP_RTS_PLACER + 1
	ldy #$00
	lda #OPC_RTS
	sta (ZP_RTS_PLACER),y

	lda largestXFrame,x
	clc
	adc #$03
	lsr
	lsr
	asl
	asl
	asl
	sta .loopEnd + 1

	lda smallestXFrame,x
	lsr
	lsr
	asl
	asl
	asl
	tax
.loop
	lda #BGCOLORBYTE
.jumpin1
	jsr $4444
	inx
.jumpin2
	jsr $4444
	txa
	clc
	adc #$07
	tax
.loopEnd
	cpx #$44
	bne .loop

	ldy #$00
	lda #OPC_STA_ABS_X
	sta (ZP_RTS_PLACER),y

.done
	ldx doubleBuffer
	lda #$ff
	sta smallestXFrame,x
	sta smallestYFrame,x
	lda #$00
	sta largestXFrame,x
	sta largestYFrame,x

	rts

setBackgroundYPos SUBROUTINE

	lda #SCREENYSIZE-1
	sta largestYFrame + 0
	sta largestYFrame + 1
	lda #$00
	sta smallestXFrame + 0
	sta smallestXFrame + 1
	lda #SCREENXSIZE-1
	sta largestXFrame + 0
	sta largestXFrame + 1

	lda backgroundYPos
	cmp smallestYFrame + 0
	bcs .noty1
	sta smallestYFrame + 0
.noty1

	lda backgroundYPos
	cmp smallestYFrame + 1
	bcs .noty2
	sta smallestYFrame + 1
.noty2

	rts


backgroundstartyintern2 dc.b $00
backgroundendyintern2 dc.b $00
bgyjumpin dc.b $00
bgyend dc.b $00
bgstartydiv2 dc.b $00

drawBackground SUBROUTINE
	; possibility check
	lda backgroundstartyintern
	cmp backgroundendyintern
	bcc .do
.notdo
	rts
.do
	cmp #SCREENYSIZE - BACKGROUNDYSIZE
	bcc .notdo
	lda backgroundendyintern
	cmp #SCREENYSIZE
	bcs .notdo

	;increase by 1 because of div2
	inc backgroundendyintern
	lda backgroundendyintern
	cmp #SCREENYSIZE
	bcc .ready
	lda #SCREENYSIZE
	sta backgroundendyintern
.ready


	lda backgroundstartyintern
	sec
	sbc #SCREENYSIZE -BACKGROUNDYSIZE
	sta backgroundstartyintern2
	lda backgroundendyintern
	sec
	sbc #SCREENYSIZE -BACKGROUNDYSIZE
	sta backgroundendyintern2

	lda backgroundstartyintern2
	lsr
	sta bgstartydiv2
	asl
	asl
	clc
	adc bgstartydiv2 ; * 5
	sta bgyjumpin

	lda backgroundendyintern2
	lsr
	sta bgendydiv2
	asl
	asl
	clc
.mul52
	adc bgendydiv2 ; * 5
	sta bgyend



	lda doubleBuffer
	bne .zwo
	ldy bgyend
	lda #OPC_RTS
	sta BLITBACKGROUND2,y

	lda bgyjumpin
	clc
	adc #<BLITBACKGROUND2
	sta bgjumpin1 + 1
	sta bgjumpin2 + 1
	lda #>BLITBACKGROUND2
	adc #$00
	sta bgjumpin1 + 2
	sta bgjumpin2 + 2
	
	jsr blitbackgroundx

	ldy bgyend
	lda #OPC_LDA_I_ZY
	sta BLITBACKGROUND2,y
	rts
.zwo
	ldy bgyend
	lda #OPC_RTS
	sta BLITBACKGROUND1,y

	lda bgyjumpin
	clc
	adc #<BLITBACKGROUND1
	sta bgjumpin1 + 1
	sta bgjumpin2 + 1
	lda #>BLITBACKGROUND1
	adc #$00
	sta bgjumpin1 + 2
	sta bgjumpin2 + 2

	jsr blitbackgroundx

	ldy bgyend
	lda #OPC_LDA_I_ZY
	sta BLITBACKGROUND1,y
	rts

bgxstart dc.b $00
bgxend dc.b $00

blitbackgroundx SUBROUTINE
	lda smallestXFrame,x
	sta bgxstart
	lda largestXFrame,x
	sta bgxend

	lda bgxend
	cmp bgxstart
	bcs .do
	rts
.do

	ldx doubleBuffer
	lda bgxend
	clc
	adc #$03
	lsr
	lsr
	sta bgxend

	lda bgxstart
	lsr
	lsr
	sta bgxstart

	jsr newtexxpos

	lda bgxend
	asl
	asl
	asl
	sta .loopEnd + 1

	lda bgxstart
	asl
	asl
	asl
	tax

	lda backgroundstartyintern2
	eor #$01
	and #$01
	tay
.nextbackgroundcolumn
bgjumpin1
	jsr $4444
	iny
	inx
bgjumpin2
	jsr $4444

	tya
	clc
	adc #BACKGROUNDYSIZE-1
	tay

	bcc .nooverflow
	stx .xrestore + 1
	sty .yrestore + 1
	cpx bgendydiv2


	lda bgendydiv2
	sec
	sbc bgstartydiv2
	tay
	lda bgstartydiv2
	asl
	tax
.redo
	inc ZP_BACKGROUND_OFFSETS+1,x
	inx
	inx
	dey
	bne .redo
.yrestore
	ldy #$44
.xrestore
	ldx #$44
.nooverflow

	inc bgxstart
	txa
	clc
	adc #$07
	tax
.loopEnd
	cmp #$44
	bne .nextbackgroundcolumn

	rts

newtexxpos SUBROUTINE
	lda bgxstart
	lsr
	lsr
	sta .add + 1
	lda bgxstart
	asl
	asl
	asl
	asl
	asl
	asl ; BACKGROUNDYSIZE = 64
	clc
	adc #<BACKGROUND
	sta bgtexxlo
	lda #>BACKGROUND
.add
	adc #$44
	sta bgtexxhi

;	lda bgstartydiv2
;	asl
;	clc
;	adc bgtexxlo
;	sta bgtexxlo
;	lda bgtexxhi
;	adc #$00
;	sta bgtexxhi



	; prepare x pos in texture
	lda bgstartydiv2
	sta bgypos
.redo
	lda bgypos
	asl
	tay
	lda bgtexxlo
	sta ZP_BACKGROUND_OFFSETS+0,y
	clc
	adc #<$02
	sta bgtexxlo
	lda bgtexxhi
	sta ZP_BACKGROUND_OFFSETS+1,y
	adc #>$02
	sta bgtexxhi
	inc bgypos
	lda bgypos
	cmp bgendydiv2
	bcc .redo
	rts

; --------------------------------------------------
displayStartText SUBROUTINE
	ldx #<FONTEXO
	ldy #>FONTEXO
	jsr fw_decrunch

	ldx #<TEXTEXO
	ldy #>TEXTEXO
	jsr fw_decrunch

	jsr CharScreen
	; enable screen
	lda #%00010111
	sta $ff06
	rts

CharScreen SUBROUTINE
	lda #$00
	ldy #$00
.nexty
Y SET 0
	REPEAT $04
	sta SCREEN8 + Y * $100,y
Y SET Y + 1
	REPEND
	iny
	bne .nexty

	lda #$00
	sta $ff15

	; FONT ADR $2000
	lda $ff13
	and #%00000101
	ora #%00100000 ; bit 2=1 auf slow 
	sta $ff13

	lda #>SCREEN8
	sta $ff14 ; SCREEN $1800

	lda #%10011000 ; we want multicolor
	sta $ff07

	jsr waitFrame
	;-------------------------------------------------------------------
	; enable screen
	;-------------------------------------------------------------------
	rts

fadeIn SUBROUTINE
	tax
	ldy #TEXTLUMASTEPS
	jsr waitFrame
.fadein
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	txa
	sta $ff15
	clc
	adc #$10
	tax
	dey
	bne .fadein
	rts

fadeOut SUBROUTINE
	ora #((TEXTLUMASTEPS-1)<<4)
	tax
	ldy #TEXTLUMASTEPS
	jsr waitFrame
.fadeout
	txa
	sta $ff15
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	jsr waitFrame
	txa
	sec
	sbc #$10
	tax
	dey
	bne .fadeout
	rts

tempb dc.b $00


frameCounter dc.w $0000
doubleBuffer dc.b $00
	; mul8 stuff
	include "mul8.asm"


testVal0_16 dc.w $0000
testVal1_16 dc.w $0000
testVal2_16 dc.w $0000

Reziproke16Lo
	include "reziproke16.inc"
Reziproke16Hi = Reziproke16Lo + 256 

	align 256
mul8_sqrl ds.b $200,0 ;low bytes of: x=(x*x)/4; 512 entry on 16 bits
mul8_sqrh ds.b $200,0 ;high bytes
mul8_abs  ds.b $100,0 ;x=abs(x)

BACKGROUND
	incbin "background.bin"

BLITBACKGROUND1
Y SET 0
Y2 SET SCREENYSIZE - BACKGROUNDYSIZE + YMOVE
	REPEAT BACKGROUNDYSIZE/2
	lda (ZP_BACKGROUND_OFFSETS + Y * 2),y
	sta $2000+[[Y2] & 7]+[[Y2]/8*320]+SCREENXP4*8,x
Y SET Y + 1
Y2 SET Y2 + 2
	REPEND
	rts

BLITBACKGROUND2
Y SET 0
Y2 SET SCREENYSIZE - BACKGROUNDYSIZE + YMOVE
	REPEAT BACKGROUNDYSIZE/2
	lda (ZP_BACKGROUND_OFFSETS + Y * 2),y
	sta $4000+[[Y2] & 7]+[[Y2]/8*320]+SCREENXP4*8,x
Y SET Y + 1	
Y2 SET Y2 + 2
	REPEND
	rts

	include "scenesetup.inc"
	ORG SCENEADR - $02 - $02 ; the filepointer is also in the exo
	incbin "scene1.exo"
SCENE1END


	incbin "endfont.exo"
FONTEXO
	incbin "endtext.exo"
TEXTEXO

	echo "eof: ",.
	