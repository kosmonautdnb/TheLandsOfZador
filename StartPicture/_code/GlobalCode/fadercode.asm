	processor   6502

	include "fw_interface.asm"

LUMARAM		EQU $e000
COLORRAM	EQU $e400
BITMAP_		EQU $c000

ZP_READ2	= $10	; 2 byte / overwrites other registers
ZP_WRITE2	= $12	; 2 byte / overwrites other registers

fadeOverFrameCount	dc.b $00
;--------------------------------------------------------------------------
;fadeOver SUBROUTINE
;--------------------------------------------------------------------------
fadeinoutdistance	= 8

fadeOver SUBROUTINE
.a
	jsr waitFrame
	jsr fadeOverMain
;	lda #%00111011 leider muss hier überall nen stück fehlen da der verticalscroller das alles vordefiniert
;	sta $ff06
;	jsr fadeOverMain2
	inc fadeOverFrameCount
	lda fadeOverFrameCount
	cmp #25+25+25-fadeinoutdistance
	bne .a
	rts

curbitmaplinelo dc.b $00
curbitmaplinehi dc.b $00
curbitmaplineloread dc.b $00
curbitmaplinehiread dc.b $00
loadd dc.b $00
hiadd dc.b $00
fadeoversegment dc.b $00
fadeOverMain SUBROUTINE
	lda #<[BITMAP_ - 1 * 8]
	sta curbitmaplinelo
	lda #>[BITMAP_ - 1 * 8]
	sta curbitmaplinehi
	lda #<[LUMARAM - 1]
	sta .ready1 + 1
	sta .ready2 + 1
	lda #>[LUMARAM - 1]
	sta .ready1 + 2
	sta .ready2 + 2
	lda #<[COLORRAM - 1]
	sta .ready3 + 1
	lda #>[COLORRAM - 1]
	sta .ready3 + 2
	lda #25+25
	sec 
	sbc fadeOverFrameCount
	sta .mover + 1
	lda #$05
	sta fadeoversegment

.fadeoverouter
	ldx #40*5
.fadeover
	lda fortyline,x
	sec
.mover
	sbc #$44
	bmi .nofade ; fortyline < ypos ; nofade
	cmp #$08
	bpl .nofade
	cmp #$00
	bne .notfirst
	txa
	asl
	asl
	asl
	clc
	adc curbitmaplinelo
	sta .modi1 + 1
	sta .modi2 + 1
	lda #$00
	bcc .b
	lda #$01
.b
	sta .adderio + 1
	txa
	lsr
	lsr
	lsr
	lsr
	lsr
	clc
.adderio
	adc #$44
	adc curbitmaplinehi
	sta .modi1 + 2
	sta .modi2 + 2
	txa
	pha
	ldy #$07
.reloopa
.modi1
	ldx $4444,y
	lda bitconverttable,x
.modi2
	sta $4444,y
	dey
	bpl .reloopa
	pla
	tax
.notfirst
.ready1
	ldy $4444,x
	lda dectable,y
.ready2
	sta $4444,x
	bpl .notclearcol
	lda #$00
.ready3
	sta $4444,x
.notclearcol
.nofade
	dex
	bne .fadeover
	lda .ready1 + 1
	clc
	adc #40*5
	sta .ready1 + 1
	sta .ready2 + 1
	sta .ready3 + 1
	bcc .noc
	inc .ready1 + 2
	inc .ready2 + 2
	inc .ready3 + 2
.noc

	lda curbitmaplinelo
	clc
	adc #<[40*5*8]
	sta curbitmaplinelo
	lda curbitmaplinehi
	adc #>[40*5*8]
	sta curbitmaplinehi
	
	lda .mover + 1
	sec
	sbc #$05
	sta .mover + 1

	dec fadeoversegment
	beq .rettich
	jmp .fadeoverouter
.rettich
	rts


