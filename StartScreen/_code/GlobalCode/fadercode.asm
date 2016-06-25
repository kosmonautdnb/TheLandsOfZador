	processor   6502

	include "fw_interface.asm"

LUMARAM		EQU $b800
COLORRAM	EQU $bc00
BITMAP_		EQU $c000

fadeOverFrameCount	dc.b $00
;--------------------------------------------------------------------------
;fadeOver SUBROUTINE
;--------------------------------------------------------------------------
fadeinoutdistance	= 8

fadeOver2 SUBROUTINE
	jsr fadeOutOld
	rts

;-------------------------------------------------------------------------
; fades out the old picture 
;-------------------------------------------------------------------------
RANDOMTABLE
	incbin "randomtable.bin"
currentRandomTablePos dc.b $00
coolness dc.b $00

fadeOutOld SUBROUTINE
	
TILES = 8

DELTATILES = $02
	lda #256-TILES-TILES-DELTATILES
	sta coolness

.onecoolness

	lda #$01
.waitb
	bit $ff1c
	beq .waitb

	lda #<[BITMAP_+320*5*0]
	sta .modi1 + 1
	lda #>[BITMAP_+320*5*0]
	sta .modi1 + 2

	lda #<[BITMAP_+320*5*1]
	sta .modi2 + 1
	lda #>[BITMAP_+320*5*1]
	sta .modi2 + 2

	lda #<[BITMAP_+320*5*2]
	sta .modi3 + 1
	lda #>[BITMAP_+320*5*2]
	sta .modi3 + 2

	lda #<[BITMAP_+320*5*3]
	sta .modi4 + 1
	lda #>[BITMAP_+320*5*3]
	sta .modi4 + 2

	lda #<[BITMAP_+320*5*4]
	sta .modi5 + 1
	lda #>[BITMAP_+320*5*4]
	sta .modi5 + 2

	lda #$00
	sta currentRandomTablePos

.onetable
	ldx currentRandomTablePos
	lda RANDOMTABLE,x
	sec
	sbc coolness
	bmi .overjump
	cmp #TILES ; 5 tiles fonts
	bmi .dotwo
	cmp #TILES+DELTATILES
	bmi .overjump
	cmp #TILES+DELTATILES+TILES
	bpl .overjump
	jmp .doone
.doone
	sec
	sbc #TILES+DELTATILES
	tay
	lda #%01010101
	jmp .copyer
.dotwo
	eor #$ff
	clc
	adc #$07+1
	tay
Y SET 0	
	REPEAT $05
	lda COLORRAM+40*5*Y,x
	and #$f0
	sta COLORRAM+40*5*Y,x
	lda LUMARAM+40*5*Y,x
	and #$0f
	sta LUMARAM+40*5*Y,x
Y SET Y + 1
	REPEND

	lda #%10101010
.copyer
.modi1
	sta $4444,y
.modi2
	sta $4444,y
.modi3
	sta $4444,y
.modi4
	sta $4444,y
.modi5
	sta $4444,y

.overjump

	lda .modi1 + 1
	clc
	adc #<8
	sta .modi1 + 1
	lda .modi1 + 2
	adc #>8
	sta .modi1 + 2

	lda .modi2 + 1
	clc
	adc #<8
	sta .modi2 + 1
	lda .modi2 + 2
	adc #>8
	sta .modi2 + 2

	lda .modi3 + 1
	clc
	adc #<8
	sta .modi3 + 1
	lda .modi3 + 2
	adc #>8
	sta .modi3 + 2

	lda .modi4 + 1
	clc
	adc #<8
	sta .modi4 + 1
	lda .modi4 + 2
	adc #>8
	sta .modi4 + 2

	lda .modi5 + 1
	clc
	adc #<8
	sta .modi5 + 1
	lda .modi5 + 2
	adc #>8
	sta .modi5 + 2


	inc currentRandomTablePos
	lda currentRandomTablePos
	cmp #5*40
	beq .outay
	jmp .onetable
.outay

	inc coolness
	lda coolness
	cmp #40 + TILES*2+DELTATILES
	beq .outaz
	jmp .onecoolness
.outaz

	rts
