
; Zeropage vectors
zp55 = $55 ;(6)
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
zp53 = $53 ;(2)
zp54 = $54 ;(2)
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


	org $2c00
V_2C00:
	dc.b $06,$07,$A5,$18,$85,$13,$A9,$01,$8D,$0B,$1C,$A9,$EE,$8D,$0C,$1C
	dc.b $A9,$00,$A2,$82,$95,$81,$CA,$30,$FB,$8E,$0E,$18,$8E,$0E,$1C,$A9
	dc.b $C0,$8D,$0E,$1C,$A9,$D0,$85,$00,$A9,$15,$85,$05,$86,$0F,$86,$12
	dc.b $A9,$8D,$CD,$00,$18,$D0,$FB,$AD,$00,$1C,$29,$08,$F0,$02,$A9,$FF
	dc.b $AA,$20,$C3,$02,$AD,$00,$18,$C9,$8D,$F0,$F6,$C9,$0D,$F0,$03,$4C
	dc.b $02,$03,$A9,$10,$2D,$00,$1C,$85,$11,$A0,$0F,$B9,$DE,$05,$BE,$7F
	dc.b $F7,$95,$11,$88,$10,$F5,$A5,$06,$D0,$08,$A2,$02,$86,$13,$CA,$20
	dc.b $26,$03,$A9,$FF,$A0,$FF,$20,$48,$01,$B0,$18,$A5,$0C,$4A,$06,$0B
	dc.b $2A,$06,$0B,$2A,$06,$0B,$2A,$29,$1F,$A8,$A5,$0B,$20,$F5,$02,$C5
	dc.b $13,$F0,$0B,$18,$A9,$20,$6D,$00,$1C,$8D,$00,$1C,$D0,$D4,$A9,$45
	dc.b $8D,$88,$02,$A9,$D0,$8D,$8A,$02,$A9,$8D,$8D,$80,$03,$A9,$86,$8D
	dc.b $83,$03,$4C,$7B,$03,$A9,$80,$8D,$05,$1C,$8D,$00,$18,$A0,$03,$CC
	dc.b $00,$18,$B0,$FB,$AC,$00,$18,$C0,$05,$6A,$CC,$00,$18,$F0,$FB,$AC
	dc.b $00,$18,$C0,$01,$6A,$90,$E8,$60,$8C,$00,$18,$78,$60,$AD,$00,$1C
	dc.b $29,$10,$C5,$11,$85,$11,$60,$48,$29,$0F,$AA,$BD,$7F,$F7,$99,$00
	dc.b $06,$68,$4A,$4A,$4A,$4A,$AA,$BD,$7F,$F7,$99,$00,$07,$60,$A2,$00
V_2D00:
	dc.b $AD,$05,$1C,$F0,$0F,$2C,$00,$1C,$30,$F6,$2C,$01,$1C,$B8,$50,$FE
	dc.b $4E,$01,$1C,$B8,$60,$20,$F7,$00,$F0,$04,$38,$66,$12,$38,$60,$00
	dc.b $00,$00,$00,$1B,$00,$B9,$03,$A4,$1D,$A5,$13,$A2,$C5,$2C,$A2,$85
	dc.b $84,$14,$20,$1E,$03,$A9,$D0,$8D,$F9,$01,$8D,$4B,$02,$A9,$FF,$8D
	dc.b $05,$1C,$20,$18,$01,$F0,$CE,$B0,$F9,$A2,$06,$50,$FE,$AD,$01,$1C
	dc.b $B8,$95,$08,$CA,$10,$F5,$06,$0C,$A5,$0D,$2A,$29,$1F,$A8,$A5,$0C
	dc.b $20,$F5,$02,$C5,$05,$B0,$D6,$85,$04,$AA,$B5,$30,$E4,$14,$F0,$0A
	dc.b $A4,$14,$30,$06,$C8,$10,$C6,$AA,$30,$C3,$85,$10,$A9,$FF,$8D,$05
	dc.b $1C,$20,$18,$01,$90,$B7,$50,$FE,$AD,$01,$1C,$4B,$3F,$B8,$50,$FE
	dc.b $AC,$01,$1C,$9D,$00,$07,$98,$6A,$4A,$4A,$4A,$9D,$00,$06,$8A,$CB
	dc.b $FD,$98,$AC,$01,$1C,$B8,$C0,$80,$2A,$29,$1F,$50,$FE,$9D,$FE,$06
	dc.b $98,$4B,$7F,$9D,$FE,$05,$AD,$01,$1C,$A8,$6A,$5E,$FE,$05,$6A,$4A
	dc.b $4A,$4A,$9D,$FF,$06,$AD,$01,$1C,$4A,$9D,$00,$07,$98,$29,$1F,$9D
	dc.b $FF,$05,$AD,$01,$1C,$B8,$6A,$9D,$00,$06,$50,$FE,$29,$1F,$E8,$D0
	dc.b $AF,$A8,$AD,$01,$1C,$20,$F4,$02,$A8,$A2,$00,$BD,$03,$06,$5E,$03
	dc.b $07,$6A,$5E,$03,$07,$6A,$4A,$4A,$4A,$9D,$03,$06,$98,$BC,$00,$07
V_2E00:
	dc.b $59,$A0,$F8,$BC,$00,$06,$59,$C0,$F8,$BC,$01,$07,$59,$A0,$F8,$BC
	dc.b $01,$06,$59,$C0,$F8,$BC,$02,$07,$59,$A0,$F8,$BC,$02,$06,$59,$C0
	dc.b $F8,$BC,$03,$07,$59,$A0,$F8,$BC,$03,$06,$59,$C0,$F8,$A8,$8A,$CB
	dc.b $FC,$D0,$B8,$98,$F0,$06,$8A,$D0,$03,$4C,$DB,$02,$A5,$0E,$4B,$3F
	dc.b $A8,$A5,$0D,$20,$F4,$02,$85,$0E,$A7,$0A,$4A,$4A,$4A,$A8,$8A,$06
	dc.b $09,$2A,$06,$09,$2A,$29,$1F,$20,$F8,$02,$85,$0D,$A5,$09,$4A,$4A
	dc.b $4A,$A8,$A5,$08,$20,$F4,$02,$A8,$45,$0D,$45,$04,$45,$0E,$85,$13
	dc.b $24,$4F,$A5,$0D,$A2,$00,$C4,$16,$D0,$02,$C5,$17,$18,$D0,$42,$A0
	dc.b $00,$20,$E4,$02,$85,$06,$20,$E4,$02,$A8,$A6,$14,$E8,$F0,$14,$84
	dc.b $07,$A4,$06,$F0,$0C,$C0,$2A,$B0,$28,$20,$85,$03,$CA,$E4,$07,$90
	dc.b $20,$A4,$07,$A6,$04,$A5,$06,$18,$60,$8A,$A8,$F0,$15,$C8,$D0,$FD
	dc.b $A8,$20,$DD,$02,$88,$D0,$FD,$CA,$D0,$02,$29,$FB,$29,$F7,$8D,$00
	dc.b $1C,$38,$60,$A9,$08,$0D,$00,$1C,$D0,$F4,$BE,$00,$07,$BD,$A0,$F8
	dc.b $BE,$00,$06,$1D,$C0,$F8,$A6,$15,$C8,$60,$6A,$4A,$4A,$4A,$AA,$B9
	dc.b $A0,$F8,$1D,$C0,$F8,$60,$A2,$FF,$8A,$48,$F0,$05,$A9,$0C,$20,$DF
	dc.b $02,$A9,$12,$20,$25,$03,$68,$F0,$08,$A2,$FF,$20,$C3,$02,$8A,$D0
V_2F00:
	dc.b $FA,$6C,$FC,$FF,$8E,$94,$02,$CA,$8E,$90,$02,$AA,$A9,$04,$20,$DF
	dc.b $02,$8A,$F0,$4D,$C9,$2A,$B0,$49,$38,$E5,$13,$F0,$44,$86,$13,$A0
	dc.b $00,$84,$08,$B0,$05,$49,$FF,$69,$01,$C8,$84,$09,$0A,$A8,$A9,$99
	dc.b $8D,$05,$1C,$AA,$A5,$09,$4D,$00,$1C,$38,$2A,$29,$03,$4D,$00,$1C
	dc.b $8D,$00,$1C,$88,$F0,$1B,$8A,$C9,$90,$F0,$0A,$48,$A5,$08,$E9,$1C
	dc.b $85,$08,$68,$E9,$00,$EC,$05,$1C,$F0,$FB,$CA,$30,$EA,$10,$D1,$D0
	dc.b $87,$A4,$13,$20,$85,$03,$2C,$00,$1C,$24,$05,$AD,$00,$1C,$09,$E0
	dc.b $A2,$15,$C0,$12,$90,$12,$CA,$CA,$E9,$20,$C0,$19,$90,$0A,$CA,$E9
	dc.b $20,$C0,$1F,$90,$03,$CA,$E9,$20,$60,$20,$C3,$02,$20,$2F,$01,$AD
	dc.b $00,$18,$C9,$8D,$F0,$F3,$C9,$0D,$D0,$C5,$8A,$F0,$03,$20,$DD,$02
	dc.b $38,$6E,$05,$1C,$58,$A2,$FF,$86,$46,$20,$CF,$00,$F0,$07,$E8,$95
	dc.b $35,$E0,$0F,$D0,$F4,$20,$D8,$05,$20,$7B,$04,$85,$19,$86,$18,$A9
	dc.b $60,$8D,$97,$02,$A0,$FF,$20,$43,$01,$B0,$F9,$F0,$01,$38,$A9,$D0
	dc.b $66,$12,$8D,$97,$02,$F0,$5D,$A9,$12,$A0,$00,$20,$48,$01,$B0,$F7
	dc.b $84,$2D,$A2,$FF,$86,$46,$A9,$00,$85,$15,$20,$F7,$00,$D0,$E8,$A9
	dc.b $12,$20,$45,$01,$B0,$E1,$86,$29,$D0,$02,$A0,$01,$84,$45,$A0,$03
V_3000:
	dc.b $20,$E4,$02,$95,$47,$AA,$F0,$19,$20,$E4,$02,$95,$69,$20,$67,$04
	dc.b $48,$8A,$A6,$15,$95,$8B,$68,$95,$AD,$E6,$15,$E0,$21,$A5,$29,$B0
	dc.b $11,$98,$29,$E0,$69,$23,$A8,$90,$D7,$A4,$45,$C4,$2D,$D0,$BB,$E6
	dc.b $46,$2C,$85,$45,$A9,$00,$85,$12,$A6,$15,$CA,$10,$4C,$A5,$15,$C9
	dc.b $22,$90,$06,$A4,$45,$24,$46,$30,$9D,$38,$4C,$4D,$05,$A2,$FF,$86
	dc.b $08,$20,$E4,$02,$A6,$08,$C9,$A0,$F0,$07,$E8,$95,$35,$E0,$0F,$D0
	dc.b $EE,$18,$86,$31,$86,$32,$86,$33,$86,$34,$B5,$35,$65,$31,$85,$31
	dc.b $90,$02,$E6,$32,$65,$33,$85,$33,$A5,$32,$65,$34,$85,$34,$CA,$10
	dc.b $E9,$65,$33,$AA,$A5,$31,$65,$32,$60,$A5,$18,$55,$8B,$D0,$AB,$A5
	dc.b $19,$55,$AD,$D0,$A5,$86,$18,$A5,$29,$85,$2D,$85,$45,$20,$DD,$02
	dc.b $B5,$47,$B4,$69,$A2,$00,$86,$21,$08,$84,$1D,$48,$8A,$18,$65,$21
	dc.b $85,$21,$68,$20,$25,$03,$95,$2F,$9D,$7F,$07,$CA,$D0,$F8,$A9,$24
	dc.b $A0,$80,$84,$14,$20,$51,$01,$B0,$F5,$9D,$80,$07,$98,$9D,$C0,$07
	dc.b $A0,$00,$A6,$1D,$86,$07,$BD,$80,$07,$30,$E3,$94,$30,$C8,$48,$BD
	dc.b $C0,$07,$AA,$68,$C5,$13,$F0,$EE,$28,$48,$98,$48,$86,$22,$84,$25
	dc.b $A0,$7F,$90,$02,$A4,$07,$84,$1D,$20,$41,$01,$B0,$FB,$A0,$FF,$94
V_3100:
	dc.b $30,$AA,$D0,$02,$A4,$07,$8C,$C1,$05,$88,$88,$98,$A0,$01,$20,$01
	dc.b $01,$18,$A5,$10,$65,$21,$20,$6E,$05,$A5,$25,$D0,$D3,$A4,$22,$68
	dc.b $AA,$68,$D0,$84,$A6,$18,$E8,$E4,$15,$B5,$47,$90,$02,$A9,$12,$20
	dc.b $25,$03,$18,$20,$65,$05,$A2,$01,$A9,$08,$2D,$00,$1C,$F0,$02,$A2
	dc.b $FF,$58,$2C,$00,$18,$10,$FB,$78,$4C,$A3,$03,$A9,$00,$85,$25,$8D
	dc.b $C1,$05,$E9,$01,$A0,$00,$20,$01,$01,$A2,$FF,$A0,$10,$8E,$05,$1C
	dc.b $A9,$02,$8D,$00,$18,$AD,$05,$1C,$D0,$06,$88,$F0,$0B,$8E,$05,$1C
	dc.b $2C,$00,$18,$10,$F0,$8E,$05,$1C,$78,$A0,$00,$BE,$00,$06,$B5,$11
	dc.b $2C,$00,$18,$30,$FB,$8D,$00,$18,$0A,$09,$10,$BE,$00,$07,$2C,$00
	dc.b $18,$10,$FB,$8D,$00,$18,$B5,$11,$8D,$05,$1C,$2C,$00,$18,$30,$FB
	dc.b $8D,$00,$18,$0A,$09,$10,$C0,$00,$C8,$2C,$00,$18,$10,$FB,$8D,$00
	dc.b $18,$90,$C8,$2C,$00,$18,$30,$FB,$A0,$08,$C6,$25,$D0,$02,$A0,$0A
	dc.b $38,$4C,$F2,$00,$EF,$E7,$ED,$E5,$EB,$E3,$E9,$E1,$EE,$E6,$EC,$E4
	dc.b $EA,$E2,$E8,$E0,$78,$A5,$42,$85,$06,$A9,$08,$8D,$00,$18,$A9,$7A
	dc.b $8D,$02,$18,$AD,$00,$18,$4A,$90,$FA,$A2,$19,$E8,$D0,$03,$EE,$2C
	dc.b $06,$A9,$80,$8D,$00,$18,$A0,$03,$CC,$00,$18,$B0,$FB,$AC,$00,$18
V_3200:
	dc.b $C0,$05,$6A,$CC,$00,$18,$F0,$FB,$AC,$00,$18,$C0,$01,$6A,$90,$E8
	dc.b $9D,$00,$00,$E0,$ED,$D0,$D4,$C6,$1A,$D0,$D0,$A9,$08,$8D,$00,$18
	dc.b $A2,$3C,$9A,$60,$06,$A9,$FB,$2D,$00,$1C,$8D,$00,$1C,$A9,$01,$8D
	dc.b $0B,$1C,$A9,$E0,$8D,$0C,$1C,$A5,$18,$85,$13,$A9,$7F,$8D,$0E,$18
	dc.b $8D,$0E,$1C,$85,$01,$A9,$C0,$8D,$0E,$1C,$20,$41,$06,$A9,$8D,$CD
	dc.b $00,$18,$D0,$FB,$AD,$00,$1C,$29,$08,$F0,$02,$A9,$FF,$AA,$20,$AB
	dc.b $02,$AD,$00,$18,$C9,$8D,$F0,$F6,$C9,$0D,$F0,$03,$4C,$BC,$03,$20
	dc.b $83,$03,$A9,$10,$2D,$00,$1C,$85,$00,$A2,$15,$86,$0E,$AD,$00,$07
	dc.b $D0,$08,$A2,$02,$86,$13,$CA,$20,$FB,$02,$A9,$FF,$A0,$FF,$20,$19
	dc.b $01,$B0,$18,$A5,$06,$4A,$06,$05,$2A,$06,$05,$2A,$06,$05,$2A,$29
	dc.b $1F,$A8,$A5,$05,$20,$EF,$02,$C5,$13,$F0,$0B,$18,$A9,$20,$6D,$00
	dc.b $1C,$8D,$00,$1C,$D0,$D4,$A9,$45,$8D,$77,$02,$A9,$D0,$8D,$79,$02
	dc.b $A9,$8D,$8D,$7E,$03,$A9,$86,$8D,$81,$03,$20,$79,$03,$4C,$F5,$03
	dc.b $0F,$07,$0D,$05,$0B,$03,$09,$01,$0E,$06,$0C,$04,$0A,$02,$08,$00
	dc.b $00,$00,$00,$00,$00,$00,$44,$00,$20,$E4,$02,$F0,$04,$38,$66,$01
	dc.b $38,$60,$A4,$11,$A5,$13,$A2,$C5,$2C,$A2,$85,$8E,$83,$02,$CA,$8E
V_3300:
	dc.b $7F,$02,$84,$14,$20,$FA,$02,$A9,$4C,$8D,$23,$02,$A9,$FF,$8D,$05
	dc.b $1C,$20,$CF,$02,$F0,$D2,$C9,$52,$D0,$F7,$A2,$06,$2C,$01,$18,$30
	dc.b $FB,$AD,$01,$1C,$95,$02,$CA,$10,$F3,$06,$06,$A5,$07,$2A,$29,$1F
	dc.b $A8,$A5,$06,$20,$EF,$02,$C5,$0E,$B0,$D2,$85,$0C,$AA,$B5,$1A,$E4
	dc.b $14,$F0,$09,$24,$14,$30,$05,$50,$C3,$AA,$30,$C0,$85,$0D,$A9,$FF
	dc.b $20,$CC,$02,$C9,$55,$D0,$B5,$A0,$00,$84,$15,$2C,$01,$18,$30,$FB
	dc.b $AE,$01,$1C,$E0,$C0,$90,$A5,$BD,$0D,$A1,$2C,$01,$18,$30,$FB,$85
	dc.b $09,$8A,$4A,$AD,$01,$1C,$85,$0A,$29,$F0,$69,$00,$AA,$A5,$09,$1D
	dc.b $0F,$9F,$99,$00,$07,$45,$15,$06,$0A,$2C,$01,$18,$30,$FB,$85,$15
	dc.b $AD,$01,$1C,$85,$09,$0A,$A9,$1E,$25,$0A,$6A,$AA,$BD,$1D,$9F,$A6
	dc.b $09,$1D,$0D,$A2,$99,$01,$07,$2C,$01,$18,$30,$FB,$45,$15,$85,$15
	dc.b $8A,$29,$03,$85,$09,$AD,$01,$1C,$85,$0A,$29,$E0,$05,$09,$AA,$BD
	dc.b $2A,$9F,$A6,$0A,$1D,$0D,$A3,$2C,$01,$18,$30,$FB,$99,$02,$07,$45
	dc.b $15,$85,$15,$AE,$01,$1C,$BD,$0D,$A0,$85,$0A,$8A,$29,$07,$85,$0B
	dc.b $C8,$C8,$C8,$2C,$01,$18,$30,$FB,$AD,$01,$1C,$85,$09,$29,$C0,$05
	dc.b $0B,$AA,$BD,$0D,$9F,$05,$0A,$99,$00,$07,$45,$15,$85,$15,$A6,$09
V_3400:
	dc.b $C8,$F0,$03,$4C,$87,$01,$D0,$1D,$BD,$0D,$A1,$85,$09,$8A,$4A,$2C
	dc.b $01,$18,$30,$FB,$AD,$01,$1C,$29,$F0,$69,$00,$AA,$A5,$09,$1D,$0F
	dc.b $9F,$45,$15,$D0,$7E,$A5,$08,$4B,$3F,$A8,$A5,$07,$20,$EE,$02,$85
	dc.b $08,$A7,$04,$4A,$4A,$4A,$A8,$8A,$06,$03,$2A,$06,$03,$2A,$29,$1F
	dc.b $20,$F2,$02,$85,$07,$A5,$03,$4A,$4A,$4A,$A8,$A5,$02,$20,$EE,$02
	dc.b $A8,$45,$07,$45,$0C,$45,$08,$85,$13,$24,$48,$A5,$07,$A2,$00,$C4
	dc.b $16,$D0,$02,$C5,$17,$18,$D0,$3B,$A6,$14,$E8,$F0,$12,$AC,$00,$07
	dc.b $F0,$0D,$C0
V_3473:
	dc.b $4D,$B0,$2D,$20,$93,$03,$CA,$EC,$01,$07,$90,$24,$AC,$01,$07,$A6
	dc.b $0C,$AD,$00,$07,$18,$60,$BA,$03,$8A,$A8,$F0,$15,$C8,$D0,$FD,$A8
	dc.b $20,$C5,$02,$88,$D0,$FD,$CA,$D0,$02,$29,$FB,$29,$F7,$8D,$00,$1C
	dc.b $38,$60,$A9,$08,$0D,$00,$1C,$D0,$F4,$8D,$05,$1C,$AD,$05,$1C,$F0
	dc.b $0F,$2C,$00,$1C,$30,$F6,$2C,$01,$18,$30,$FB,$A2,$00,$AD,$01,$1C
	dc.b $60,$AD,$00,$1C,$29,$10,$C5,$00,$85,$00,$60,$6A,$4A,$4A,$4A,$AA
	dc.b $B9,$A0,$F8,$1D,$C0,$F8,$60,$AA,$A9,$04,$20,$C7,$02,$8A,$F0,$76
V_34E3:		dc.b $C9
V_34E4:
	dc.b $4D,$B0,$72,$38,$A5,$13,$E9,$23,$F0,$04,$90,$02,$85,$13,$38,$8A
	dc.b $E9,$23,$F0,$02,$B0,$02,$18,$8A,$48,$AD,$01,$18
V_3500:
	dc.b $09,$04
V_3502:
	dc.b $8D,$01,$18,$29,$FB,$90,$02,$09,$04
V_350B:
	dc.b $8D,$01,$18,$68,$38,$E5,$13,$86,$13,$F0,$43,$A0,$00,$84,$03,$B0
	dc.b $05,$49,$FF,$69,$01,$C8,$84,$04,$0A,$A8,$20,$8A,$03,$A9,$99,$8D
	dc.b $05,$1C,$AA,$A5,$04,$4D,$00,$1C,$38,$2A,$29,$03,$4D,$00,$1C,$8D
	dc.b $00,$1C,$88,$F0,$19,$8A,$C9,$90,$F0,$0A,$48,$A5,$03,$E9,$1C,$85
	dc.b $03,$68,$E9,$00,$EC,$05,$1C,$F0,$FB,$CA,$30,$EA,$10,$D1,$A4,$13
	dc.b $20,$93,$03,$2C,$00,$1C,$24,$0E,$A9,$A0,$0D,$01,$18,$D0,$05,$A9
	dc.b $DF,$2D,$01,$18,$8D,$01,$18,$60,$98,$A8,$38,$E9,$23,$F0,$02,$B0
	dc.b $F8,$AD,$00,$1C,$09,$E0,$A2,$15,$C0,$12,$90,$12,$CA,$CA,$E9,$20
	dc.b $C0,$19,$90,$0A,$CA,$E9,$20,$C0,$1F,$90,$03,$CA,$E9,$20,$60,$A2
	dc.b $FF,$8A,$48,$F0,$05,$A9,$0C,$20,$C7,$02,$A9,$12,$20,$FA,$02,$68
	dc.b $F0,$08,$A2,$FF,$20,$AB,$02,$8A,$D0,$FA,$6C,$FC,$FF,$20,$8A,$03
	dc.b $20,$AB,$02,$20,$08,$01,$AD,$00,$18,$C9,$8D,$F0,$F3,$C9,$0D,$D0
	dc.b $D0,$20,$83,$03,$8A,$F0,$03,$20,$C5,$02,$38,$6E,$05,$1C,$58,$A2
	dc.b $FF,$86,$30,$20,$49,$06,$F0,$07,$E8,$95,$1E,$E0,$0F,$D0,$F4,$20
	dc.b $3B,$06,$20,$9B,$05,$85,$19,$86,$18,$A9,$60,$8D,$86,$02,$A0,$FF
	dc.b $20,$14,$01,$B0,$F9
V_3600:
	dc.b $F0,$01,$38,$A9,$D0,$66,$01,$8D,$86,$02,$F0,$60,$A9,$12,$A0,$00
	dc.b $20,$19,$01,$B0,$F7,$84,$31,$A2,$FF,$86,$30,$A9,$00,$85,$34,$20
	dc.b $E4,$02,$D0,$E8,$A9,$12,$20,$16,$01,$B0,$E1,$86,$32,$D0,$02,$A0
	dc.b $01,$84,$33,$A0,$03,$A6,$34,$B9,$00,$07,$F0,$1D,$95,$35,$B9,$01
	dc.b $07,$95,$7F,$20,$8A,$05,$48,$8A,$A6,$34,$9D,$6C,$06,$68,$9D,$B6
	dc.b $06,$E6,$34,$E0,$49,$A5,$32,$B0,$11,$98,$29,$E0,$69,$23,$A8,$90
	dc.b $D4,$A4,$33,$C4,$31,$D0,$B8,$E6,$30,$2C,$85,$33,$A9,$00,$85,$01
	dc.b $A6,$34,$CA,$10,$10,$A5,$34,$C9,$4A,$90,$06,$A4,$33,$24,$30,$30
	dc.b $9A,$38,$4C,$69,$05,$A5,$18,$5D,$6C,$06,$D0,$E6,$A5,$19,$5D,$B6
	dc.b $06,$D0,$DF,$86,$18,$A5,$32,$85,$31,$85,$33,$20,$C5,$02,$B4,$35
	dc.b $F0,$13,$C0
V_36A3:
	dc.b $4D,$B0,$10,$20,$93,$03,$86,$02,$A6,$18,$B5,$35,$B4,$7F,$C4,$02
	dc.b $90,$04,$38,$4C,$69,$05,$38,$A2,$00,$86,$0F,$08,$84,$11,$48,$8A
	dc.b $18,$65,$0F,$85,$0F,$68,$20,$FA,$02,$95,$19,$9D,$7F,$07,$CA,$D0
	dc.b $F8,$A9,$AD,$A0,$80,$84,$14,$20,$29,$01,$B0,$F5,$9D,$80,$07,$98
	dc.b $9D,$C0,$07,$A0,$00,$A6,$11,$8E,$01,$07,$BD,$80,$07,$30,$E2,$94
	dc.b $1A,$C8,$48,$BD,$C0,$07,$AA,$68,$C5,$13,$F0,$EE,$28
V_3700:
	dc.b $48,$98,$48,$86,$10,$84,$12,$A0,$7F,$90,$03,$AC,$01,$07,$84,$11
	dc.b $20,$12,$01,$B0,$FB,$A0,$FF,$94,$1A,$AA,$D0,$03,$AC,$01,$07,$8C
	dc.b $26,$06,$88,$88,$AD,$01,$07,$48,$20,$C3,$05,$68,$8D,$01,$07,$A5
	dc.b $12,$D0,$D4,$A4,$10,$68,$AA,$68,$D0,$84,$A6,$18,$E8,$E4,$34,$B5
	dc.b $35,$90,$02,$A9,$12,$20,$FA,$02,$18,$A9,$00,$85,$12,$8D,$26,$06
	dc.b $E9,$01,$20,$CB,$05,$A2,$01,$A9,$08,$2D,$00,$1C,$F0,$02,$A2,$FF
	dc.b $58,$2C,$00,$18,$10,$FB,$78,$4C,$D8,$03,$A2,$FF,$B9,$02,$07,$C8
	dc.b $C9,$A0,$F0,$07,$E8,$95,$1E,$E0,$0F,$D0,$F1,$18,$86,$1A,$86,$1B
	dc.b $86,$1C,$86,$1D,$B5,$1E,$65,$1A,$85,$1A,$90,$02,$E6,$1B,$65,$1C
	dc.b $85,$1C,$A5,$1B,$65,$1D,$85,$1D,$CA,$10,$E9,$65,$1C,$AA,$A5,$1A
	dc.b $65,$1B,$60,$8C,$01,$07,$18,$A5,$0D,$65,$0F,$8D,$00,$07,$A2,$FF
	dc.b $A0,$20,$8E,$05,$1C,$A9,$02,$8D,$00,$18,$AD,$05,$1C,$D0,$06,$88
	dc.b $F0,$0B,$8E,$05,$1C,$2C,$00,$18,$10,$F0,$8E,$05,$1C,$58,$A0,$00
	dc.b $A9,$FF,$8D,$05,$1C,$B9,$00,$07,$29,$0F,$AA,$B5,$F0,$2C,$00,$18
	dc.b $30,$FB,$8D,$00,$18,$0A,$09,$10,$2C,$00,$18,$10,$FB,$8D,$00,$18
	dc.b $B9,$00,$07,$4A,$4A,$4A,$4A,$AA,$B5,$F0,$2C,$00,$18,$30,$FB,$8D
V_3800:
	dc.b $00,$18,$0A,$09,$10,$C0,$00,$C8,$2C,$00,$18,$10,$FB,$8D,$00,$18
	dc.b $90,$BE,$2C,$00,$18,$30,$FB,$C6,$12,$D0,$06,$A0,$0A,$8C,$00,$18
	dc.b $2C,$A0,$08,$8C,$00,$18,$18,$78,$60,$A9,$80,$8D,$05,$1C,$8D,$00
	dc.b $18,$A0,$03,$CC,$00,$18,$B0,$FB,$AC,$00,$18,$C0,$05,$6A,$CC,$00
	dc.b $18,$F0,$FB,$AC,$00,$18,$C0,$01,$6A,$90,$E8,$60,$A5,$42,$8D,$00
	dc.b $07,$20,$41,$06,$A9,$7A,$8D,$02,$18,$AD,$00,$18,$4A,$90,$FA,$A2
	dc.b $05,$9A,$A2,$43,$E8,$D0,$03,$EE,$8F,$06,$20,$49,$06,$9D,$00,$00
	dc.b $E0,$40,$D0,$F0,$C6,$44,$D0,$EC,$60,$04,$0F,$07,$0D,$05,$0B,$03
	dc.b $09,$01,$0E,$06,$0C,$04,$0A,$02,$08,$00,$BA,$86,$01,$AD,$00,$40
	dc.b $20,$21,$05,$A2,$00,$8A,$29,$0F,$A8,$B9,$01,$03,$9D,$00,$0A,$8A
	dc.b $4A,$4A,$4A,$4A,$A8,$B9,$01,$03,$9D,$00,$0B,$E8,$D0,$E7,$AD,$92
	dc.b $01,$85,$1D,$AD,$93,$01,$85,$1E,$A9,$FF,$8D,$04,$40,$8D,$05,$40
	dc.b $A9,$11,$8D,$0E,$40,$20,$EB,$04,$A9,$7F,$8D,$0D,$40,$A9,$82,$8D
	dc.b $0D,$40,$A2,$00,$86,$11,$20,$0B,$06,$AD,$01,$40,$29,$9F,$C9,$8D
	dc.b $D0,$F7,$20,$0A,$05,$AD,$01,$40,$29,$9F,$C9,$8D,$F0,$F4,$C9,$0D
	dc.b $F0,$03,$4C,$50,$05,$8A,$F0,$03,$20,$29,$05,$20,$00,$05,$A2,$FF
V_3900:
	dc.b $86,$16,$20,$12,$06,$F0,$08,$E8,$9D,$11,$03,$E0,$0F,$D0,$F3,$20
	dc.b $08,$06,$20,$7B,$05,$85,$0C,$86,$0B,$A5,$11,$F0,$05,$AD,$00,$40
	dc.b $30,$77,$AD,$2B,$02,$A0,$00,$20,$30,$05,$B0,$F6,$85,$14,$84,$15
	dc.b $84,$1B,$A2,$FF,$86,$16,$A2,$00,$86,$11,$2C,$00,$40,$10,$E3,$85
	dc.b $12,$20,$30,$05,$B0,$DC,$86,$13,$D0,$05,$AD,$2B,$02,$A4,$1B,$85
	dc.b $19,$84,$1A,$A0,$03,$A6,$11,$B9,$00,$09,$F0,$1D,$9D,$38,$06,$B9
	dc.b $01,$09,$9D,$EA,$06,$20,$69,$05,$48,$8A,$A6,$11,$9D,$9C,$07,$68
	dc.b $9D,$4E,$08,$E6,$11,$E0,$B1,$B0,$18,$98,$29,$E0,$69,$23,$A8,$90
	dc.b $D4,$A5,$19,$A4,$1A,$C5,$14,$D0,$B1,$C4,$15,$D0,$AD,$E6,$16,$B0
	dc.b $08,$A5,$12,$85,$19,$A5,$13,$85,$1A,$A6,$11,$CA,$10,$12,$A5,$11
	dc.b $C9,$B2,$90,$08,$A5,$19,$A4,$1A,$24,$16,$30,$8A,$38,$4C,$AA,$04
	dc.b $A5,$0B,$5D,$9C,$07,$D0,$E4,$A5,$0C,$5D,$4E,$08,$D0,$DD,$86,$0B
	dc.b $A5,$12,$85,$14,$85,$19,$A5,$13,$85,$15,$85,$1A,$20,$29,$05,$BD
	dc.b $38,$06,$BC,$EA,$06,$AA,$F0,$08,$E0,$51,$B0,$05,$C0,$28,$90,$04
	dc.b $38,$4C,$AA,$04,$20,$29,$05,$8A,$A2,$00,$86,$1C,$85,$17,$84,$18
	dc.b $20,$34,$05,$B0,$FB,$48,$F0,$02,$A0,$FF,$AD,$01,$09,$48,$8C,$F0
V_3A00:
	dc.b $05,$88,$88,$8C,$01,$09,$A5,$1C,$20,$AE,$05,$E6,$1C,$68,$A8,$68
	dc.b $D0,$DA,$A6,$0B,$E8,$E4,$11,$BD,$38,$06,$90,$03,$AD,$2B,$02,$20
	dc.b $DC,$04,$18,$20,$A5,$05,$A2,$01,$A9,$40,$2D,$00,$40,$F0,$02,$A2
	dc.b $FF,$20,$00,$05,$2C,$01,$40,$10,$FB,$78,$4C,$69,$03,$AD,$00,$40
	dc.b $29,$40,$F0,$02,$A9,$FF,$85,$79,$A5,$1D,$8D,$92,$01,$A5,$1E,$8D
	dc.b $93,$01,$4C,$9F,$CB,$AA,$CA,$8E,$C8,$01,$20,$C4,$04,$A9,$8C,$A2
	dc.b $06,$20,$54,$FF,$A9,$4E,$8D,$92,$01,$A9,$05,$8D,$93,$01,$A9,$20
	dc.b $8D,$06,$40,$A9,$00,$8D,$07,$40,$60,$A9,$59,$8D,$0F,$40,$2C,$0D
	dc.b $40,$58,$60,$8A,$A8,$F0,$1A,$EA,$24,$24,$C8,$D0,$FA,$A8,$20,$29
	dc.b $05,$EA,$24,$24,$88,$D0,$FA,$CA,$D0,$02,$09,$04,$29,$BF,$8D,$00
	dc.b $40,$60,$A9,$40,$0D,$00,$40,$D0,$F5,$85,$17,$84,$18,$20,$C4,$04
	dc.b $A9,$80,$A2,$06,$20,$54,$FF,$20,$EB,$04,$A5,$08,$C9,$01,$AC,$01
	dc.b $09,$A6,$18,$AD,$00,$09,$60,$A2,$FF,$8A,$48,$AD,$2B,$02,$20,$DC
	dc.b $04,$68,$F0,$08,$A2,$FF,$20,$0A,$05,$8A,$D0,$FA,$A6,$01,$9A,$4C
	dc.b $C4,$04,$A2,$FF,$B9,$02,$09,$C8,$C9,$A0,$F0,$08,$E8,$9D,$11,$03
	dc.b $E0,$0F,$D0,$F0,$18,$86,$0D,$86,$0F,$86,$0E,$86,$10,$BD,$11,$03
V_3B00:
	dc.b $65,$0D,$85,$0D,$90,$03,$E6,$0E,$18,$65,$0F,$85,$0F,$A5,$0E,$65
	dc.b $10,$85,$10,$CA,$10,$E7,$65,$0F,$AA,$A5,$0D,$65,$0E,$60,$A9,$00
	dc.b $8D,$F0,$05,$E9,$01,$85,$17,$8D,$00,$09,$20,$00,$05,$A9,$02,$8D
	dc.b $01,$40,$2C,$01,$40,$10,$FB,$A0,$00,$A9,$59,$8D,$0F,$40,$BE,$00
	dc.b $09,$BD,$00,$0A,$2C,$01,$40,$30,$FB,$8D,$01,$40,$0A,$29,$EF,$2C
	dc.b $01,$40,$10,$FB,$8D,$01,$40,$BE,$00,$09,$BD,$00,$0B,$2C,$01,$40
	dc.b $30,$FB,$8D,$01,$40,$0A,$29,$EF,$C0,$00,$C8,$2C,$01,$40,$10,$FB
	dc.b $8D,$01,$40,$90,$C4,$2C,$01,$40,$30,$FB,$AD,$00,$09,$C5,$17,$F0
	dc.b $03,$A0,$0A,$2C,$A0,$08,$8C,$01,$40,$78,$60,$A9,$80,$85,$00,$8D
	dc.b $01,$40,$A9,$04,$2C,$01,$40,$F0,$FB,$AD,$01,$40,$4A,$66,$00,$A9
	dc.b $04,$2C,$01,$40,$D0,$FB,$AD,$01,$40,$4A,$66,$00,$90,$E4,$A5,$00
	dc.b $60,$20,$0B,$06,$AD,$01,$40,$4A,$90,$FA,$A2,$FF,$E8,$D0,$03,$EE
	dc.b $4E,$06,$20,$12,$06,$9D,$00,$02,$E0,$0A,$D0,$F0,$CE,$00,$03,$D0
	dc.b $EB,$4C,$11,$03
	
fw_initloader:
S_3BD4:	
	LDA #$20
	STA zp55
	LDA #$3E
	STA zp55+1
	LDA #$07
	CMP zp00
	BNE B_3BE5
	JMP L_3D93
	;
B_3BE5:	
	PHP
	LDA #$00
	STA zpF9
	LDA zpAE
	CMP #$08
	BCC B_3BF4
	CMP #$0F
	BCC B_3BF6
B_3BF4:	
	LDA #$08
B_3BF6:	
	PHA
	LDX #$08
B_3BF9:	
	STX zpAE
	LDA #$00
	STA zp90
	JSR S_3D9E
	JSR S_FFB7	; KERNAL: READSS (Return I/O STATUS byte)
	BMI B_3C1B
	PLA
	EOR #$80
	BMI B_3C1A
	STA zpAE
	JSR S_FFAE	; KERNAL: UNLSN (Send UNLISTEN out serial bus or DMA disk)
	PLP
	LDA #$FD
	LDX #$FD
	LDY #$55	; "U"
	SEC
	RTS
;$3C1A  --------
B_3C1A:	
	PHA
B_3C1B:	
	JSR S_FFAE	; KERNAL: UNLSN (Send UNLISTEN out serial bus or DMA disk)
	LDX zpAE
	INX
	CPX #$0F
	BNE B_3BF9
	LDA #$00
	STA zp90
	PLA
	AND #$7F
	STA zpAE
B_3C2E:	
	PHA
	JSR S_3D9E
	JSR S_FFB7	; KERNAL: READSS (Return I/O STATUS byte)
	PHA
	JSR S_FFAE	; KERNAL: UNLSN (Send UNLISTEN out serial bus or DMA disk)
	PLA
	BPL B_3C55
	LDX zpAE
	INX
	CPX #$0F
	BNE B_3C45
	LDX #$08
B_3C45:	
	STX zpAE
	PLA
	CMP zpAE
	BNE B_3C2E
	PLP
	LDA #$FB
	LDX #$FF
	LDY #$55	; "U"
	SEC
	RTS
;$3C55  --------
B_3C55:	
	PLA
	LDA #$C6
	LDX #$E5
	JSR S_3DA8
	CMP #$34
	BEQ B_3C7B
	CMP #$37
	BEQ B_3C98
	LDA #$E9
	LDX #$A6
	JSR S_3DA8
	LDY #$25
	CMP #$38
	BEQ B_3CB6
	PLP
	LDA #$FC
	LDX #$FD
	LDY #$55	; "U"
	SEC
	RTS
;$3C7B  --------
B_3C7B:	
	LDA #$02
	LDX #$C0
	JSR S_3DA8
	LDY #$20
	CMP #$43	; "C"
	BNE B_3CB6
	LDA #$A3
	LDX #$EA
	JSR S_3DA8
	LDY #$21
	CMP #$FF
	BNE B_3CB6
	INY
	BNE B_3CB6
B_3C98:	
	CPX #$B1
	LDA #$2A
	LDX #$2C
	LDY #$23
	BCC B_3CA7
	LDA #$4D	; "M"
	LDX #$8D
	INY
B_3CA7:	
	STA V_3473
	STA V_34E4
	STX V_3502
	STX V_350B
	STA V_36A3
B_3CB6:	
	STY V_3D95 + 1
	LDX V_3DDE + 1,Y
	LDA V_3E05,X
	STA V_3D04 + 1
	LDA V_3E08,X
	STA V_3D04 + 2
	LDA V_3E0B,X
	STA V_3D0B + 1
	LDA V_3E0E,X
	STA V_3D46 + 1
	LDA V_3E11,X
	STA V_3D48 + 2
	LDA V_3E14,X
	STA V_3DF0
	LDA V_3E17,X
	STA V_3DF1
	LDA V_3E1A,X
	STA V_3DF5
	LDA V_3E1D,X
	STA V_3DF6
	JSR S_3D9E
	LDX #$00
B_3CF7:	
	LDY #$05
B_3CF9:	
	LDA V_3DEF,Y
	JSR S_FFA8	; KERNAL: CIOUT (Handshake serial bus or DMA disk byte out)
	DEY
	BPL B_3CF9
	LDY #$23
V_3D04:
B_3D04:	
	dc.b $bd,$00,$00 ;LDA.w $00,X
	JSR S_FFA8	; KERNAL: CIOUT (Handshake serial bus or DMA disk byte out)
	INX
V_3D0B:	
	CPX #$00
	BEQ B_3D25
	DEY
	BNE B_3D04
	JSR S_3D9B
	CLC
	LDA #$23
	ADC V_3DF1
	STA V_3DF1
	BCC B_3CF7
	INC V_3DF0
	BNE B_3CF7
B_3D25:	
	JSR S_3D9B
	LDX #$05
B_3D2A:	
	LDA V_3DF4,X
	JSR S_FFA8	; KERNAL: CIOUT (Handshake serial bus or DMA disk byte out)
	DEX
	BNE B_3D2A
	JSR S_FFAE	; KERNAL: UNLSN (Send UNLISTEN out serial bus or DMA disk)
	LDA #$08
	STA zp01
B_3D3A:	
	BIT zp01
	BVS B_3D3A
	LDA #$09
	STA zp01
B_3D42:	
	BIT zp01
	BVC B_3D42
V_3D46:	
	LDY #$00
V_3D48:
B_3D48:	
	dc.b $b9,$00,$00 ;LDA.w $00,Y
	PHA
	LDA #$02
	ORA $FF13	; Char. Gen
	STA $FF13	; Char. Gen
	PLA
	LDX #$08
B_3D57:	
	LSR
	PHA
	LDA zp01
	AND #$FE
	BCC B_3D61
	ORA #$01
B_3D61:	
	EOR #$02
	STA zp01
	PLA
	DEX
	BNE B_3D57
	PHA
	PLA
	LDA #$FD
	AND $FF13	; Char. Gen
	STA $FF13	; Char. Gen
	INY
	BNE B_3D79
	INC V_3D48 + 2
B_3D79:	
	CPY V_3D04 + 1
	BNE B_3D48
	LDX V_3D48 + 2
	CPX V_3D04 + 2
	BNE B_3D48
B_3D86:	
	BIT zp01
	BVS B_3D86
	LDA #$0F
	STA zp01
	LDA #$07
	STA zp00
	PLP
L_3D93:	
	LDA #$00
V_3D95:	
	LDX #$00
	LDY #$55	; "U"
	CLC
	RTS
;$3D9B  --------
S_3D9B:	
	JSR S_FFAE	; KERNAL: UNLSN (Send UNLISTEN out serial bus or DMA disk)
S_3D9E:	
	LDA zpAE
	JSR S_FFB1	; KERNAL: LISTN (Send LISTEN out serial bus or DMA disk)
	LDA #$6F
	JMP V_FF93	; KERNAL: SECND (Send SA after LISTEN)
	;
S_3DA8:	
	STA V_3DEC
	STX V_3DED
	LDA #$06
	LDX #$E9
	LDY #$3D
	JSR S_FFBD	; KERNAL: SETNAM (Set length and filename address)
	LDA #$0F
	LDX zpAE
	TAY
	JSR S_FFBA	; KERNAL: SETLFS (Set LA, FA, SA)
	JSR S_FFC0	; KERNAL: OPEN (Open logical file)
	BCC B_3DCF
	PLA
	PLA
	PLP
	LDA #$FE
	LDX #$FE
	LDY #$55	; "U"
	SEC
	RTS
;$3DCF  --------
B_3DCF:	
	LDX #$0F
	JSR S_FFC6	; KERNAL: CHKIN (Open channel in)
	JSR S_FFCF	; KERNAL: BASIN (Input from channel)
	PHA
	JSR S_FFCF	; KERNAL: BASIN (Input from channel)
	PHA
	LDA #$0F
V_3DDE:	
	JSR S_FFC3	; KERNAL: CLOSE (Close logical file) - *** Self mod. indirect jump!
	JSR S_FFCC
	PLA
	TAX
	PLA
	CLC
	RTS
;$3DE9  --------
	dc.b $4D,$2D,$52
V_3DEC:
	dc.b $00
V_3DED:
	dc.b $00,$02
V_3DEF:
	dc.b $23
V_3DF0:
	dc.b $00
V_3DF1:
	dc.b $00,$57,$2D
V_3DF4:
	dc.b $4D
V_3DF5:
	dc.b $00
V_3DF6:
	dc.b $00,$45,$2D,$4D,$31,$4D,$3E,$30,$55,$00
V_3E00:
	dc.b $00,$00,$01,$01,$02
V_3E05:
	dc.b $D4,$21,$84
V_3E08:
	dc.b $31,$38,$3B
V_3E0B:
	dc.b $50,$58,$50
V_3E0E:
	dc.b $00,$24,$79
V_3E11:
	dc.b $2C,$32,$38
V_3E14:
	dc.b $05,$06,$06
V_3E17:
	dc.b $EE,$41,$0B
V_3E1A:
	dc.b $05,$06,$06
V_3E1D:
	dc.b $EE,$6C,$38,$CB,$52,$49,$4C,$4C,$27,$53,$20,$CC,$4F,$41,$44,$45
	dc.b $52,$2C,$20,$56,$45,$52,$53,$49,$4F,$4E,$20,$39,$39,$CD,$2C,$20
	dc.b $43,$4F,$4E,$46,$49,$47,$55,$52,$41,$54,$49,$4F,$4E,$20,$38,$45
	dc.b $2E,$31,$30,$2E,$30,$2E,$30,$2E,$31,$32,$30,$30,$31,$30,$2E,$31
	dc.b $38,$31,$30,$31,$43,$2E,$30,$30,$30,$30,$30,$30,$30,$30,$31,$30
	dc.b $30,$30,$30,$31,$30,$30,$30,$30,$31,$30,$2E,$36,$2E,$30,$41,$32
	dc.b $37,$31,$32,$31,$32,$30,$32,$30,$31,$2E,$34,$2E,$30,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b $00,$00,$00



