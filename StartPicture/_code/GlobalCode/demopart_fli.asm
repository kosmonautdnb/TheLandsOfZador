    processor 6502

	include "fw_interface.asm"
	include "macros.asm"
	include "standard.asm"
	include "persistent.asm"


	ORG $1800
;--------------------------------------------------------------------
; Hauptprogramm (Init)
;--------------------------------------------------------------------
MAINPRG	
	jsr fadeOver
	
	jsr waitFrame
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
	sei
	lda #<imcdfli_setup
	sta fw_topirq_plugin
	lda #>imcdfli_setup
	sta fw_topirq_plugin+1
	; --- bitmap und zoom4 ---
	LDA #$3b
	STA $FF06	
	LDA #$18  	
	STA $FF07	
	LDA #$08
	STA $FF12
	cli ; we have zoom4

	ldx #250
.waithere
	jsr waitFrame
	dex
	bne .waithere
	
	LDA #$04
	sta .yo + 1
.mainloop5
    LDA #$00
    STA $DF
    
mainloop4
    LDX $DF
    LDY SPECIALTABLE,x
	LDX #$02
mainloop2
    TYA
    BMI skip1
    CMP #$64
    BCS skip1
    
    JSR imcdfli_fol
    
skip1    
    INY
    INY
    INY
    DEX
    BNE mainloop2
    
    INC $DF
    lda $DF
    cmp #$64
    beq .ready
    JMP mainloop4
.ready	
	dec .yo + 1
.yo
	lda #$44
	bne .mainloop5	

    ; COPIES THE LOADERSTUB UP
    ldx #<(LOADNEXTPARTEND -  LOADNEXTPARTSTART)
.copy
    lda LOADNEXTPARTSTART - 1,x
    sta LOADNEXTPARTLOCATION - 1,x
    dex
    bne .copy
	ldx #$01
    sei
    lda #$00
    sta fw_topirq_plugin  
    sta fw_topirq_plugin + 1
    sta fw_lowirq_plugin  
    sta fw_lowirq_plugin + 1
    cli
	jsr waitFrame
	jsr waitFrame
    lda #$0b
    sta $ff06
	jsr waitFrame
    jmp LOADNEXTPARTLOCATION

mainloop3
    JMP mainloop3
    
	SEI
	STA $FF3E	; enable ROM
	JMP $FFF6	; reset
	
mltemp
    dc.b $00

waitFrame SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
.waita
	bit $ff1c
	bne .waita
	rts

	include "fadercode.asm"

fortyline
	incbin "fortyline.bin"

; this snipped gots copied up
LOADNEXTPARTLOCATION equ $fa80
LOADNEXTPARTSTART SUBROUTINE
LOADDELTA equ LOADNEXTPARTLOCATION - LOADNEXTPARTSTART

    ldx #<(fname + LOADDELTA)
    ldy #>(fname + LOADDELTA)
    jsr fw_load

	ldx fw_load_end + 0
	ldy fw_load_end + 1
    jsr fw_decrunch

    jmp ENTRYPOINT_STARTSCREEN

fname dc.b "SS",$00
LOADNEXTPARTEND    

    include "imcdfli.asm"

dectable
	incbin "dectable.bin"

SPECIALTABLE
	incbin "specialtable.bin"

	rts
