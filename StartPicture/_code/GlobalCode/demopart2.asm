    processor 6502

ZP_TEMP2 equ $10
ZP_WRITE2 equ $12

	include "fw_interface.asm"

;	ORG $1001
;	DC.W $100B,0
;	DC.B $9E,"4109",0,0,0	; SYS4107
	
	ORG $17fd
	jmp main


;--------------------------------------------------------------------
; Hauptprogramm (Init)
;--------------------------------------------------------------------
main	
	jsr waitvblank

    lda #$0b
    sta $ff06
	LDA #$00
	STA $FF19
	STA $FF15
	
	; --- irq --	
	jsr imcdfli_fadein_saveandclear 


	lda #<imcdfli_setup
	sta fw_topirq_plugin
	lda #>imcdfli_setup
	sta fw_topirq_plugin+1
	; --- bitmap und zoom4 ---


    ldy #$02
.initdelay
	jsr waitvblank
	dey
	bne .initdelay
	
	
	
.fi0
	ldy #$00
	jsr imcdfli_restoreline
.fi1
	ldy #$63
	jsr imcdfli_restoreline

	jsr waitvblank
	jsr waitvblank

	inc .fi0+1
	inc .fi0+1
	dec .fi1+1
	dec .fi1+1

	lda .fi0+1
	cmp #$63
	bcc .fi0

	ldy #$00
.wait	
	jsr waitvblank
	iny
	bne .wait


.2a
	lda #$00
	sta .0+1
	lda #$63
	sta .0x+1	


.2b	
	ldx #$08
.0
	ldy #$00
	jsr imcdfli_fol
	iny
	jsr imcdfli_fol
	iny
	jsr imcdfli_fol
	iny
	jsr imcdfli_fol
.0x
	ldy #$63
	jsr imcdfli_fol
	dey	
	jsr imcdfli_fol
	dey	
	jsr imcdfli_fol
	dey	
	jsr imcdfli_fol

	jsr waitvblank
	dex 
	bne .0
	

	inc .0+1
	inc .0+1
	inc .0+1
	inc .0+1
	dec .0x+1
	dec .0x+1
	dec .0x+1
	dec .0x+1
	
	lda .0+1
	cmp #$31
	bcs .3
.1

	jmp .2b
.3    
.exit
	jmp nextpart


;--------------------------------------------------------------------
; helper routine. wait for specific rasterline
;--------------------------------------------------------------------
waitvblank SUBROUTINE

	lda #$FC
.0	cmp $FF1D
	bne .0
	
	lda $ff1d
.1	cmp $ff1d
	beq .1

	rts
;--------------------------------------------------------------------

nextpart SUBROUTINE
.ready	
    ; COPIES THE LOADERSTUB UP
    ldx #<(LOADNEXTPARTEND -  LOADNEXTPARTSTART)
.copy
    lda LOADNEXTPARTSTART - 1,x
    sta LOADNEXTPARTLOCATION - 1,x
    dex
    bne .copy
    sei
    lda #$00
    sta fw_topirq_plugin  
    sta fw_topirq_plugin + 1
    sta fw_lowirq_plugin  
    sta fw_lowirq_plugin + 1
    cli
    ldx #$03
    jsr framedelay
    lda #$0b
    sta $ff06
    jmp LOADNEXTPARTLOCATION

mainloop3
    JMP mainloop3
    
	SEI
	STA $FF3E	; enable ROM
	JMP $FFF6	; reset
	
mltemp
    dc.b $00
    
    echo "imcdfli: ",.

    include "imcdfli.asm"

framedelay SUBROUTINE

.waitb	
	lda fw_framecounter
.waita
	cmp fw_framecounter
	beq .waita

	dex
	bne .waitb

	rts

; this snipped gots copied up
LOADNEXTPARTLOCATION equ $fa80
LOADNEXTPARTSTART SUBROUTINE
LOADDELTA equ LOADNEXTPARTLOCATION - LOADNEXTPARTSTART

    ;ldx #<(fname + LOADDELTA)
    ;ldy #>(fname + LOADDELTA)
    ;jsr fw_load


    ; copy down part
    lda #<SUBPARTSTART
    sta ZP_TEMP2 + 0
    lda #>SUBPARTSTART
    sta ZP_TEMP2 + 1
    lda #<($17f0)
    sta ZP_WRITE2 + 0
    lda #>($17f0)
    sta ZP_WRITE2 + 1

    ldy #$00
.next
    lda (ZP_TEMP2),y
    sta (ZP_WRITE2),y
    iny
    cpy #<(SUBPARTSIZE)
    bne .nexty
    lda ZP_TEMP2 + 1
    cmp #>(SUBPARTEND)
    beq .yippi
.nexty
    cpy #$00
    bne .next
    inc ZP_TEMP2 + 1
    inc ZP_WRITE2 + 1
    jmp .next + LOADDELTA

.yippi
    ldx #<($17f0+SUBPARTSIZE)
    ldy #>($17f0+SUBPARTSIZE)
    jsr fw_decrunch
    jmp $17fd

fname dc.b "01",$00
LOADNEXTPARTEND    

SUBPARTSTART
    incbin "subpart/explopacked.exo"
SUBPARTEND
SUBPARTSIZE equ (SUBPARTEND - SUBPARTSTART)

	echo "eof: ",.
