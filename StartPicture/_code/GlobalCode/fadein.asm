;	include "../214_amiga/loadingPictureConstants.inc"
frontColor = 27
ZP_FF12 = $40
;--------------------------------------------------------------------
;-- THE FADEIN ------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------
	org $5000
FADEINAMIGA SUBROUTINE
	lda #$00
	sta ZP_FF12

	lda #$00
	ldy #$20
.b
	ldx #$00
.a
	sta $8000,x ;CLEANSCREEN at $8000
	inx	
	bne .a
	inc .a + 2
	dey
	bne .b

    ldy #$00
.0  	tya 
    lsr
    lsr
    lsr
    sta .fi0
    tya
    and #$07
.fi0 = .+1    
    adc #$00
    sta anim_ptr,y
    iny
    bne .0
	

	jsr mcpic_fadein

	
	sei
	lda #<relMyIrq_plugin
	sta fw_topirq_plugin
	lda #>relMyIrq_plugin
	sta fw_topirq_plugin+1
	cli

	;jsr waitvblank
;	lda #backColor
;	sta $ff15
;	lda #frontColor
;	sta $ff16

;	ldx #$06
;	jsr waitFrame

	lda #%00011000 ; multicolor
	sta $ff07
	
	lda $ff12
	and #%00000011
	ora #%00100000 ; bitmap adress $8000
	sta $ff12

	;lda #$18
	;sta $ff14 ; colorram address $1800

	;jsr waitFrame
	;lda #%00111011
	;sta $FF06 ; bitmap mode + visible

.waitfadein
	lda fw_topirq_plugin+1
	bne .waitfadein

	rts

anim_mask
	dc.b $00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00
	dc.b $01,$01,$01,$01,$01,$01,$01,$01
	dc.b $01,$01,$01,$01,$01,$01,$01,$01
	dc.b $01,$01,$01,$01,$01,$01,$01,$01
	dc.b $01,$01,$01,$01,$01,$01,$01,$01

anim_glob
	dc.b $d0    
counter
	dc.b $00    
 

backColor = $00
	align 256
ff15tab 	ds.b $100,$00
ff12tab 	ds.b $100,$00
anim_ptr 	ds.b $100,$00
    
mcpic_fadein SUBROUTINE


	ldy #$ca
    
.0	lda anim_ptr,y
	clc
	adc anim_glob
	bmi .isset
.isnull
	lda #%00110000 ; c000
	sta ff12tab,y
	lda #loadingBackColor
	sta ff15tab,y
	jmp .cont
.isset     
	lda #%00100000 ; 8000
	sta ff12tab,y
	lda #$00
	sta ff15tab,y
.cont

	dey
	bne .0


    inc anim_glob 

	rts

relMyIrq_plugin SUBROUTINE 
	lda #<irq_stab
	sta $fffe 
	lda #>irq_stab
	sta $ffff 
	lda #2  ;raster irq 
	sta $ff0a 
	lda #$01 ; rasterline 0
	sta $ff0b 

	PLUGIN_CANCELDEFAULT 
	rts 
	

	align 256
;-------------------------------------------------------------------------------
;
; stabilisator
;
;-------------------------------------------------------------------------------
irq_stab SUBROUTINE
	STA .exit + 1	
	STX .exit + 3				
	
	;lda $ff09
	;sta $ff09					

	lda $ff12
	and #%00000011
	sta ZP_FF12

	REPEAT 10
	nop
	REPEND

	inc $ff09

	LDA #MYIRQ & 255		
	STA $FFFE						
	LDA #MYIRQ >> 8		
	STA $FFFF						
	LDA #$03
	STA $FF0B						
	
	NOP

	LDA $FF1e						
	AND #$04
	BEQ .fix1						
	
.fix1
	CLI								

	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	
	NOP
	NOP
	NOP
	
.exit
	LDA #$00						
	LDX #$00
	RTI								


	MAC badlines

	lda ff12tab+8,y
	ora ZP_FF12
	sta $ff12
	lda ff15tab+8,y
	sta $ff15
	dey
	;lda $e0


	lda ff12tab+8,y
	ora ZP_FF12
	sta $ff12
	lda ff15tab+8,y
	sta $ff15
	dey
	beq .exit ; nop
	jmp MYIRQ_LOOP
.exit    
	ENDM


	MAC goodline
	lda ff12tab+8,y
	ora ZP_FF12
	sta $ff12
	lda ff15tab+8,y
	sta $ff15


	nop
	nop
	nop
	nop
	nop

	nop
	nop
	nop
	nop
	nop

	nop
	nop
	nop
	nop
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	;lda $e0
	dey
	ENDM

	MAC goodline_f
	lda ff12tab+8,y
	ora ZP_FF12	
	sta $ff12
	lda ff15tab+8,y
	sta $ff15

	;nop
	;nop
	;nop
	lda $e0
	nop
	nop

	nop
	nop
	nop
	nop
	nop

	nop
	nop
	nop
	nop
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	;lda $e0
	dey
	ENDM



;	MAC badlines_x
;
;	lda ff12tab,y
;	sta $ff12
;	lda ff15tab,y
;	sta $ff3f
;	dey
;	lda $e0

;	ENDM


	MAC goodline_x
	lda ff12tab,y
	ora ZP_FF12
	sta $ff12
	lda ff15tab,y
	sta $ff15


	nop
	nop
	nop
	nop
	nop

	nop
	nop
	nop
	nop
	nop

	nop
	nop
	nop
	nop
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop
;	lda $e0
	dey
	ENDM

	align 256
MYIRQ SUBROUTINE	
	pha
	txa
	pha
	tya
	pha

	nop
	;nop
	;nop
	inc $ff09
    
	ldy #$c0
.loop
MYIRQ_LOOP
	goodline_f
	goodline
	goodline
	goodline
	goodline
	goodline
	badlines

	ldy #$07
	goodline_x
	goodline_x
	goodline_x
	goodline_x
	goodline_x
	goodline_x
	goodline_x
	    
MYIRQ_LOOPEND
	lda #$00
	sta $ff15

	lda #$3b
	sta $ff06
    
	jsr fw_lowirq_handler
	lda $ff12
	and #%00000011
	ora #%00101000
	sta $ff12
	
	inc counter
	lda counter
	cmp #$60
	bne .dofade

	lda $ff12
	and #%00000011
	ora #%00110000
	sta $ff12
	lda #loadingBackColor
	sta $ff15
	
	lda #$00
	sta fw_topirq_plugin
	sta fw_topirq_plugin+1
	jmp .exit
	
.dofade	
	and #$01
	beq .skipfade
	jsr mcpic_fadein

.skipfade
	lda $ff12
	and #%00000011
	ora ff12tab+$c7
 	sta $ff12
	lda ff15tab+$c7
	sta $ff15
    
.exit	

	pla
	tay
	pla
	tax
	pla
	rti
	
	echo "amigafaderende: ",.
	