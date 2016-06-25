    processor   6502

	ORG $1001
	DC.W $100B,0
	DC.B $9E,"4109",0,0,0	; SYS4107
	JMP main
	
	org $1800,$00
	
	include "fw_interface.asm"
	include "fw_bootstrap.asm"	

main SUBROUTINE

	lda #$00
	jsr fw_init

	sei
    sta $ff3f
    
    lda #$00
    sta $ff0a
	
	ldy #$10
	lda #$00
.0	sta $0000,y
	iny
	bne .0

	jsr fw_run
	cli
	
	ldy #$00
.loop
	iny
	sty $ff19
	bne .loop
	jmp launch
	

demopart_begin = .
	incbin "demopart.exo"
demopart_end = .
demopart_len = [demopart_end - demopart_begin]

	org $fcb6

launch SUBROUTINE

	lda #<demopart_begin
	sta .src
	lda #>demopart_begin
	sta .src+1
	
	lda #$f0
	sta .dst
	lda #$17
	sta .dst+1

.loop
.src = .+1
	lda $1234
.dst = .+1
	sta $5678
	
	inc .src
	bne .srcok
	inc .src+1
.srcok
	inc .dst
	bne .dstok
	inc .dst+1
.dstok
	
	lda .src
	cmp #<demopart_end
	bne .loop
	lda .src+1
	cmp #>demopart_end
	bne .loop
	
	sei	
	ldx .dst
	ldy .dst+1
	jsr fw_decrunch
	cli

	jmp $17fd

	ECHO demopart_begin, " " , demopart_end, " ", demopart_len
	
