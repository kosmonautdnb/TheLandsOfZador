


imcdfli_setup
    LDA #imcdfli_sirq & 255
    STA $FFFE
    LDA #imcdfli_sirq >> 8
    STA $FFFF
    LDA #$02
    STA $FF0A
    LDA #$01
    STA $FF0B
    
    LDA #$3b
    STA $FF06

    ; wir schreiben den voice krams einfach in beide speedcodes
    LDA $ff12
    and #%00000011
    sta .ora1 + 1
    lda $b001
    and #%11111100
.ora1
    ora #$44
    sta $b001


    LDA $ff12
    and #%00000011
    sta .ora2 + 1
    lda $a001
    and #%11111100
.ora2
    ora #$44
    sta $a001

    PLUGIN_CANCELDEFAULT
    RTS
    


imcdfli_sirq
    STA imcdfli_sirq_exit+1
    LDA $FF09
    STA $FF09
    
    LDA $FF1E
    AND #$04
    BNE imcdfli_sirq_1
    
imcdfli_sirq_1    
    LDA #(imcdfli_mirq & 255)
    STA $FFFE
    LDA #(imcdfli_mirq >> 8)
    STA $FFFF
    LDA #$02
    STA $FF0B
    
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
    
imcdfli_sirq_exit
    LDA #$00
    RTI



    MAC IMCDFLI_CORE ; vmem,yscroll,bgcol1,fgcol1,xscroll,bgcol2,fgcol2

    LDA #{1}
    STA $FF14
    LDA #{2}
    STA $FF06
    LDA #{5}
    STA $FF07
    LDA #{3}
    STA $FF15
    LDA #{4}
    STA $FF16
    NOP
    LDA #{6}
    STA $FF15
    LDA #{7}
    STA $FF16

    ENDM
    
    
imcdfli_mirq
    STA imcdfli_mirq_exit+1
    STX imcdfli_mirq_exit+3
    STY imcdfli_mirq_exit+5    

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

;    NOP
;   NOP
;   NOP
    
imcdfli_mirq_call    
    JSR $A000
;    NOP
;   NOP
;   NOP


;    IMCDFLI_CORE $40,$3b, $01,$72, $10, $11,$62
;    IMCDFLI_CORE $48,$3d, $21,$52, $11, $31,$42
;    IMCDFLI_CORE $50,$3f, $41,$32, $12, $51,$22
;    IMCDFLI_CORE $58,$39, $61,$12, $13, $71,$02
;
;    IMCDFLI_CORE $40,$3b, $00,$00, $00, $00,$00

    
        
    LDA $FF09
    STA $FF09
    JSR fw_lowirq_install
    
    
    LDA imcdfli_mirq_call+2
    CMP #$A0
    BNE imcdfli_mirq_flipodd
    
    LDA #$B0
    STA imcdfli_mirq_call+2
    JMP imcdfli_mirq_exit
    
imcdfli_mirq_flipodd    
    LDA #$A0
    STA imcdfli_mirq_call+2
    JMP imcdfli_mirq_exit
    
    
imcdfli_mirq_exit
    LDA #$00
    LDX #$00
    LDY #$00
    RTI
    
    


imcdfli_test
    LDY #$07
imcdfli_test1
    LDA #$5A
    STA $2008,Y
    LDA #$F0
    STA $2010,Y
    DEY
    BPL imcdfli_test1
    
    LDA #$07
    STA $4001
    LDA #$25
    STA $4801
    LDA #$43
    STA $5001
    LDA #$61
    STA $5801
    
    LDA #$12
    STA $4401
    LDA #$34
    STA $4C01
    LDA #$56
    STA $5401
    LDA #$78
    STA $5C01

    RTS




imcdfli_fadein_saveandclear SUBROUTINE

	ldy #$00
	lda #$00
.0x	sta $f000,y
	sta $f100,y
	sta $f200,y
	sta $f300,y
	sta $f400,y
	sta $f500,y
	sta $f600,y
	sta $f700,y
	iny
	bne .0x	

	lda #$05
	sta $e0
	lda #$b0
	sta $e1

	lda #$05
	sta $e2
	lda #$a0
	sta $e3

	ldx #$00

.0
	ldy #$01
	lda ($e0),y
	sta fil_e_ff14,x
	lda ($e2),y
	sta fil_o_ff14,x
	lda #$f0
	sta ($e0),y	
	sta ($e2),y	

	ldy #16
	lda ($e0),y
	sta fil_e_ff15,x
	lda ($e2),y
	sta fil_o_ff15,x
	lda #$00
	sta ($e0),y	
	sta ($e2),y	

	ldy #21
	lda ($e0),y
	sta fil_e_ff16,x
	lda ($e2),y
	sta fil_o_ff16,x
	lda #$00
	sta ($e0),y	
	sta ($e2),y	

	ldy #27
	lda ($e0),y
	sta fil_e_ff15b,x
	lda ($e2),y
	sta fil_o_ff15b,x
	lda #$00
	sta ($e0),y	
	sta ($e2),y	

	ldy #32
	lda ($e0),y
	sta fil_e_ff16b,x
	lda ($e2),y
	sta fil_o_ff16b,x
	lda #$00
	sta ($e0),y	
	sta ($e2),y	

	clc
	lda $e0
	adc #[$2a-$06]
	sta $e0
	lda $e1
	adc #$00
	sta $e1

	clc
	lda $e2
	adc #[$2a-$06]
	sta $e2
	lda $e3
	adc #$00
	sta $e3

	inx
	cpx #$64
	bne .0
	rts
	
imcdfli_restoreline SUBROUTINE
	pha
	txa
	pha
	tya
	pha

	clc
	lda fol_codelo,y
	adc #$05
	sta $e0
	lda fol_codehi,y
	adc #$b0
	sta $e1

	clc
	lda fol_codelo,y
	adc #$05
	sta $e2
	lda fol_codehi,y
	adc #$a0
	sta $e3

	tya
	tax
	
	ldy #$01
	lda fil_e_ff14,x
	sta ($e0),y	
	lda fil_o_ff14,x
	sta ($e2),y	

	ldy #16
	lda fil_e_ff15,x
	sta ($e0),y	
	lda fil_o_ff15,x
	sta ($e2),y	

	ldy #21
	lda fil_e_ff16,x
	sta ($e0),y	
	lda fil_o_ff16,x
	sta ($e2),y	

	ldy #27
	lda fil_e_ff15b,x
	sta ($e0),y	
	lda fil_o_ff15b,x
	sta ($e2),y	

	ldy #32
	lda fil_e_ff16b,x
	sta ($e0),y	
	lda fil_o_ff16b,x
	sta ($e2),y	

	
	
	pla
	tay
	pla
	tax
	pla
	rts

    
    MAC fol ; zp
    LDA ({1}),Y
    AND #$7F
	SEC
	SBC #$10
	BPL .0
    LDA #$00
.0
    STA ({1}),Y
    ENDM    

imcdfli_fol_oe
    dc.b $00
    
imcdfli_fol
    PHA
    TXA
    PHA
    TYA
    PHA

    ; code-ptr erzeugen
    LDA fol_codelo,Y
    STA $D0
    STA $D2
    LDA fol_codehi,Y
    STA $D1
    STA $D3
    
    ; 5 bytes überspringen
    CLC 
    LDA $D0
    ADC #$05
    STA $D0
    LDA $D1
    ADC #$A0
    STA $D1
    
    CLC 
    LDA $D2
    ADC #$05
    STA $D2
    LDA $D3
    ADC #$B0
    STA $D3

    ; vmem-ptr erzeugen
    TYA
    AND #$03
    ASL 
    ASL 
    ASL 
    
    PHA
    CLC
    ADC #$60
    STA $E1
    PLA
    ADC #$80
    STA $E3
    LDA #$00
    STA $E0
    STA $E2
    
    TYA
    LSR 
    LSR 
    TAY
    
    CLC
    LDA linetab_lo,Y
    ADC $E0
    STA $E0
    LDA linetab_hi,Y
    ADC $E1
    STA $E1

    CLC
    LDA linetab_lo,Y
    ADC $E2
    STA $E2
    LDA linetab_hi,Y
    ADC $E3
    STA $E3
    
    
    LDA $E0
    STA $E4
    LDA $E1
    CLC
    ADC #$04
    STA $E5

    LDA $E2
    STA $E6
    LDA $E3
    CLC
    ADC #$04
    STA $E7

    ; ausfaden
    LDY #$27
imcdfli_fol_even1
    LDA ($E0),Y
    TAX
    LDA fol_lum,X
    STA ($E0),Y
    LDA ($E4),Y
    AND fol_colmask,X
    STA ($E4),Y

    LDA ($E2),Y
    TAX
    LDA fol_lum,X
    STA ($E2),Y
    LDA ($E6),Y
    AND fol_colmask,X
    STA ($E6),Y

    DEY
    BPL imcdfli_fol_even1

    ; bgfg ausfaden
    LDY #16
    fol $D0
    fol $D2
    LDY #21
    fol $D0
    fol $D2
    
    LDY #34
    LDA ($D0),Y
    CMP #$15
    BNE skipbg_odd

    LDY #32
    fol $D0
skipbg_odd

    LDY #34
    LDA ($D2),Y
    CMP #$15
    BNE skipbg_even

    LDY #32
    fol $D2
skipbg_even

    LDY #27
    fol $D0
    fol $D2


imcdfli_fol_exit
    PLA
    TAY
    PLA
    TAX
    PLA
    RTS


    echo "bitmaps: " ,.

    include "odd_bmp.asm"    
    include "even_bmp.asm"    
    include "odd_vmem.asm"    
    include "even_vmem.asm"
    include "odd_code.asm"
bitconverttable
	incbin "bitconverttable.bin"
    include "even_code.asm"    

linetab_lo
    dc.b  $00,$28,$50,$78,$A0
    dc.b  $C8,$F0,$18,$40,$68
    dc.b  $90,$B8,$E0,$08,$30
    dc.b  $58,$80,$A8,$D0,$F8
    dc.b  $20,$48,$70,$98,$c0

linetab_hi
    dc.b  $00,$00,$00,$00,$00
    dc.b  $00,$00,$01,$01,$01
    dc.b  $01,$01,$01,$02,$02
    dc.b  $02,$02,$02,$02,$02
    dc.b  $03,$03,$03,$03,$03
    
    
    
fol_lum
	dc.b $00,$00,$01,$02,$03,$04,$05,$06,$00,$00,$01,$02,$03,$04,$05,$06
	dc.b $00,$00,$01,$02,$03,$04,$05,$06,$00,$00,$01,$02,$03,$04,$05,$06
	dc.b $10,$10,$11,$12,$13,$14,$15,$16,$10,$10,$11,$12,$13,$14,$15,$16
	dc.b $20,$20,$21,$22,$23,$24,$25,$26,$20,$20,$21,$22,$23,$24,$25,$26
	dc.b $30,$30,$31,$32,$33,$34,$35,$36,$30,$30,$31,$32,$33,$34,$35,$36
	dc.b $40,$40,$41,$42,$43,$44,$45,$46,$40,$40,$41,$42,$43,$44,$45,$46
	dc.b $50,$50,$51,$52,$53,$54,$55,$56,$50,$50,$51,$52,$53,$54,$55,$56
	dc.b $60,$60,$61,$62,$63,$64,$65,$66,$60,$60,$61,$62,$63,$64,$65,$66
	dc.b $00,$00,$01,$02,$03,$04,$05,$06,$00,$00,$01,$02,$03,$04,$05,$06
	dc.b $00,$00,$01,$02,$03,$04,$05,$06,$00,$00,$01,$02,$03,$04,$05,$06
	dc.b $10,$10,$11,$12,$13,$14,$15,$16,$10,$10,$11,$12,$13,$14,$15,$16
	dc.b $20,$20,$21,$22,$23,$24,$25,$26,$20,$20,$21,$22,$23,$24,$25,$26
	dc.b $30,$30,$31,$32,$33,$34,$35,$36,$30,$30,$31,$32,$33,$34,$35,$36
	dc.b $40,$40,$41,$42,$43,$44,$45,$46,$40,$40,$41,$42,$43,$44,$45,$46
	dc.b $50,$50,$51,$52,$53,$54,$55,$56,$50,$50,$51,$52,$53,$54,$55,$56
	dc.b $60,$60,$61,$62,$63,$64,$65,$66,$60,$60,$61,$62,$63,$64,$65,$66

fol_colmask

	dc.b $00,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$00,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $00,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$00,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b $0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF

fol_codelo
	dc.b $00,$24,$48,$6C,$90,$B4,$D8,$FC,$20,$44,$68,$8C,$B0,$D4,$F8,$1C
	dc.b $40,$64,$88,$AC,$D0,$F4,$18,$3C,$60,$84,$A8,$CC,$F0,$14,$38,$5C
	dc.b $80,$A4,$C8,$EC,$10,$34,$58,$7C,$A0,$C4,$E8,$0C,$30,$54,$78,$9C
	dc.b $C0,$E4,$08,$2C,$50,$74,$98,$BC,$E0,$04,$28,$4C,$70,$94,$B8,$DC
	dc.b $00,$24,$48,$6C,$90,$B4,$D8,$FC,$20,$44,$68,$8C,$B0,$D4,$F8,$1C
	dc.b $40,$64,$88,$AC,$D0,$F4,$18,$3C,$60,$84,$A8,$CC,$F0,$14,$38,$5C
	dc.b $80,$A4,$C8,$EC
	
fol_codehi
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$02
	dc.b $02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$04,$04,$04
	dc.b $04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06
	dc.b $06,$06,$07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$08,$08
	dc.b $09,$09,$09,$09,$09,$09,$09,$09,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0B
	dc.b $0B,$0B,$0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D,$0D
	dc.b $0D,$0D,$0D,$0D    
	
	
	
fil_e_ff14
	ds.b 100,0		
fil_e_ff15
	ds.b 100,0		
fil_e_ff16
	ds.b 100,0		
fil_e_ff15b
	ds.b 100,0		
fil_e_ff16b
	ds.b 100,0		

fil_o_ff14
	ds.b 100,0		
fil_o_ff15
	ds.b 100,0		
fil_o_ff16
	ds.b 100,0		
fil_o_ff15b
	ds.b 100,0		
fil_o_ff16b
	ds.b 100,0		
    
    echo "flipic-ende: ",.
    
    
    