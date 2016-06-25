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

	inc $ff19
	sei
    sta $ff3f
	
	ldy #$10
	lda #$00
.0	sta $0000,y
	iny
	bne .0
	
	jsr fw_run
	sta $ff3f
	cli
	
	jmp startdemo

demopart
	incbin "demopart.prg"
demopart_end

startdemo SUBROUTINE

	lda demopart
	sta .dst+1
	sta .jmp+1
	lda demopart+1
	sta .dst+2
	sta .jmp+2
	
	lda #<[demopart+2]
	sta .src+1
	lda #>[demopart+2]
	sta .src+2


.src
	lda demopart
	
.dst	
	sta $0fff
	
	inc .src+1
	bne .1
	inc .src+2
	
.1	    
    inc .dst+1
    bne .2
    inc .dst+2
    
.2  
    lda .src+1
    cmp #<demopart_end
    bne .src
    lda .src+2
    cmp #>demopart_end
    bne .src

	cli

	ldy #$00
	lda #$80
.wait70
	cmp $ff1d
	bne .wait70
	lda $ff1d
.wait71
	cmp $ff1d
	beq .wait71
	iny
	bne .wait70


	ldx kp_pattern_counter
.wait_pattern
	lda #$80
.wait80
	cmp $ff1d
	bne .wait80
	lda $ff1d
.wait81
	cmp $ff1d
	beq .wait81
	
	cpx kp_pattern_counter
	beq .wait_pattern
	
	ldx #$50
	ldy #$13
	lda #$01
	jsr fw_initplayer
	
.jmp	
	jmp $1ffd

	echo "demopart end: ",.
