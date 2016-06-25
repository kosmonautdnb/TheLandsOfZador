

load SUBROUTINE	
	jsr openfile
	bcc .pollblock
	rts
	
.pollblock
	jsr loadblock
	bcc .pollblock
	
	lda #$00
	sta load_end
	sta load_end+1
	
    ldx storebyte + $01
    cpx load_end
    ldy storebyte + $02
    iny
    tya
    sbc load_end+1
    bcc .bla
    stx load_end
    sty load_end+1
.bla
	rts
	

zp53	= $0c
zp54	= $0d
zp55	= $0e

; Zeropage vectors
;zp55 = $55 ;(6)
zp64 = $64 ;(7)
zpFA = $FA ;(9)
zpFC = $FC ;(16)
zpFE = $FE ;(2)
;---------
; Zeropage variables
zp00 = $00 ;(9)
zp01 = $01 ;(27)
zp02 = $02 ;(4)
zp03 = $03 ;(7)
zp18 = $18 ;(1)
zp22 = $22 ;(1)
zp23 = $23 ;(1)
zp24 = $24 ;(2)
zp33 = $33 ;(1)
zp34 = $34 ;(1)
;zp53 = $53 ;(2)
;zp54 = $54 ;(2)
zp61 = $61 ;(3)
zp62 = $62 ;(1)
zp63 = $63 ;(1)
zp66 = $66 ;(8)
zp90 = $90 ;(2)
zp99 = $99 ;(1)
zp9E = $9E ;(2)
zp9F = $9F ;(2)
zpA0 = $A0 ;(2)
zpA1 = $A1 ;(2)
zpAE = $AE ;(13)
zpEA = $EA ;(3)
zpF9 = $F9 ;(1)
;---------


V_FF93 = $FF93
S_FFA8 = $FFA8
S_FFAE = $FFAE
S_FFB1 = $FFB1
S_FFB7 = $FFB7
S_FFBA = $FFBA
S_FFBD = $FFBD
S_FFC0 = $FFC0
S_FFC3 = $FFC3
S_FFC6 = $FFC6
S_FFCC = $FFCC
S_FFCF = $FFCF
S_FFD2 = $FFD2



openfile
S_6600:	
	STY zp55+1
	LDA #$09
	STA zp01
	LDA #$17
	STA zp00
B_660A:	
	BIT zp01
	BVC B_660A
	STX zp55
	LDY #$00
B_6612:	
	LDA (zp55),Y
	PHA
	PHA
	LDA #$02
	ORA $FF13	; Char. Gen
	STA $FF13	; Char. Gen
	PLA
	LDX #$08
B_6621:	
	LSR
	PHA
	LDA zp01
	AND #$FE
	BCC B_662B
	ORA #$01
B_662B:	
	EOR #$02
	STA zp01
	PLA
	DEX
	BNE B_6621
	PHA
	PLA
	LDA #$FD
	AND $FF13	; Char. Gen
	STA $FF13	; Char. Gen
	PLA
	BEQ B_6645
	INY
	CPY #$10
	BNE B_6612
B_6645:	
	LDA #$08
	STA zp01
	CLC
B_664A:	
	LDA #$00
	TAX
B_664D:	
	RTS
;$664E  --------
loadblock
S_664E:	
	LDA #$F8
	LDX #$07
	CPX zp00
	BEQ B_664D
	JSR S_6674
	BCS B_6663
	LDA #$07
	BIT zp01
	BPL B_664D
	BCC B_664A
B_6663:	
	LDX #$0F
	STX zp01
	LDX #$07
	STX zp00
	CMP #$FE
	BEQ B_664A
	CLC
	ADC #$FB
S_6672:	
	SEC
	RTS
;$6674  --------
S_6674:	
	LDA #$00
	LDX #$04
B_6678:	
	BIT zp01
	BVC B_6678
	BMI S_6672
	STX zp01
	JSR S_6672
	LDA zp01
	AND #$38
	STA V_669E + 1
	ORA #$00
	LSR
	LSR
	EOR #$04
	EOR V_669E + 1
	LSR
	LSR
	EOR #$00
	EOR V_669E + 1
	LSR
	LSR
	EOR #$04
V_669E:	
	EOR #$00
	STA V_6722 + 1
	LDA #$00
	STA zp01
	LDA #$02
	ORA $FF13	; Char. Gen
	STA $FF13	; Char. Gen
	JSR S_66ED
	STA zp55+1
	BNE B_66CF
	JSR S_66ED
	PHA
	JSR S_66ED
	STA zp53
	STA zp55
	JSR S_66ED
	STA zp54
	STA V_672B + 2
	PLA
	SEC
	SBC #$02
	BCS B_66EA
B_66CF:	
	CMP #$FE
	BCS B_6732
	LDA zp53
	SBC zp55+1
	PHP
	CLC
	SBC zp55+1
	STA zp55
	LDA zp54
	ADC zp55+1
	PLP
	SBC #$01
	STA V_672B + 2
	JSR S_66ED
B_66EA:	
	LDY #$99
	dc.b $2C
S_66ED:	
	LDY #$60
	STY V_672B
	TAX
	EOR #$FF
	CPY #$99
	BNE B_6705
	TAY
	TXA
	ADC zp55
	STA V_672B + 1
	BCS B_6705
	DEC V_672B + 2
B_6705:	
	LDX #$04
	LDA zp01
	STX zp01
	LSR
	LSR
	NOP
	NOP
	LDX #$00
	EOR zp01
	STX zp01
	LSR
	LSR
	NOP
	NOP
	LDX #$04
	EOR zp01
	STX zp01
	LSR
	LSR
	NOP
V_6722:	
	EOR #$00
	LDX #$00
	EOR.w $0001
	STX zp01
storebyte 
V_672B:	
	dc.b $99,$00,$00 ;STA.w $00,Y
	INY
	BNE B_6705
	CLC
B_6732:	
	PHA
	LDA #$FD
	AND $FF13	; Char. Gen
	STA $FF13	; Char. Gen
	PLA
	RTS
;$673D  --------
; EOF
