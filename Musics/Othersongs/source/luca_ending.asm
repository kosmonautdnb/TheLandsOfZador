kp_song
kp_reloc
	dc.w kp_song_registers
	dc.w kp_speed
	dc.w kp_grooveboxpos
	dc.w kp_grooveboxlen
	dc.w kp_groovebox
	dc.w kp_patternlen
	dc.w kp_patternmap_lo
	dc.w kp_patternmap_hi
	dc.w kp_insmap_lo
	dc.w kp_insmap_hi
	dc.w kp_volmap_lo
	dc.w kp_volmap_hi
	dc.w kp_sequence
kp_song_registers
kp_speed
	dc.b $02
kp_grooveboxpos
	dc.b $00
kp_grooveboxlen
	dc.b $02
kp_groovebox
	dc.b $02
	dc.b $03
	dc.b $03
	dc.b $04
	dc.b $05
	dc.b $04
	dc.b $06
	dc.b $04
kp_patternlen
	dc.b $1F

kp_patternmap_lo
	dc.b #<patnil
	dc.b #<pat1
	dc.b #<pat2
	dc.b #<pat3
	dc.b #<pat4
	dc.b #<pat5
	dc.b #<pat6
	dc.b #<pat7
	dc.b #<pat8
	dc.b #<pat9
	dc.b #<pat10
	dc.b #<pat11
	dc.b #<pat12
	dc.b #<pat13
	dc.b #<pat14
	dc.b #<pat15
	dc.b #<pat16
	dc.b #<pat17
	dc.b #<pat18
	dc.b #<pat19
	dc.b #<pat20
	dc.b #<pat21
	dc.b #<pat22
	dc.b #<pat23
	dc.b #<pat24
	dc.b #<pat25
	dc.b #<pat26
	dc.b #<pat27
	dc.b #<pat28
	dc.b #<pat29
	dc.b #<pat30
	dc.b #<pat31
	dc.b #<pat32
	dc.b #<pat33
	dc.b #<pat34
	dc.b #<pat35
	dc.b #<pat36
	dc.b #<pat37
	dc.b #<pat38
	dc.b #<pat39
	dc.b #<pat40
	dc.b #<pat41
	dc.b #<pat42
	dc.b #<pat43
	dc.b #<pat44
	dc.b #<pat45
	dc.b #<pat46
	dc.b #<pat47
	dc.b #<pat48
	dc.b #<pat49
	dc.b #<pat50
	dc.b #<pat51
	dc.b #<pat52
	dc.b #<pat53
	dc.b #<pat54
	dc.b #<pat55
	dc.b #<pat56
	dc.b #<pat57
	dc.b #<pat58
	dc.b #<pat59
	dc.b #<pat60
	dc.b #<pat61
	dc.b #<pat62
	dc.b #<pat63
	dc.b #<pat64
	dc.b #<pat65
	dc.b #<pat66
	dc.b #<pat67

kp_patternmap_hi
	dc.b #>patnil
	dc.b #>pat1
	dc.b #>pat2
	dc.b #>pat3
	dc.b #>pat4
	dc.b #>pat5
	dc.b #>pat6
	dc.b #>pat7
	dc.b #>pat8
	dc.b #>pat9
	dc.b #>pat10
	dc.b #>pat11
	dc.b #>pat12
	dc.b #>pat13
	dc.b #>pat14
	dc.b #>pat15
	dc.b #>pat16
	dc.b #>pat17
	dc.b #>pat18
	dc.b #>pat19
	dc.b #>pat20
	dc.b #>pat21
	dc.b #>pat22
	dc.b #>pat23
	dc.b #>pat24
	dc.b #>pat25
	dc.b #>pat26
	dc.b #>pat27
	dc.b #>pat28
	dc.b #>pat29
	dc.b #>pat30
	dc.b #>pat31
	dc.b #>pat32
	dc.b #>pat33
	dc.b #>pat34
	dc.b #>pat35
	dc.b #>pat36
	dc.b #>pat37
	dc.b #>pat38
	dc.b #>pat39
	dc.b #>pat40
	dc.b #>pat41
	dc.b #>pat42
	dc.b #>pat43
	dc.b #>pat44
	dc.b #>pat45
	dc.b #>pat46
	dc.b #>pat47
	dc.b #>pat48
	dc.b #>pat49
	dc.b #>pat50
	dc.b #>pat51
	dc.b #>pat52
	dc.b #>pat53
	dc.b #>pat54
	dc.b #>pat55
	dc.b #>pat56
	dc.b #>pat57
	dc.b #>pat58
	dc.b #>pat59
	dc.b #>pat60
	dc.b #>pat61
	dc.b #>pat62
	dc.b #>pat63
	dc.b #>pat64
	dc.b #>pat65
	dc.b #>pat66
	dc.b #>pat67

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$06
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$07
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$08
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$09
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0A
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_settrackregister $03,$0B
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$02
	kp_settrackregister $01,$00
	kp_setinstrument $04,$01
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $01,$54
	kp_settrackregister $03,$07
	kp_setinstrument $01,$03
	kp_settrackregister $01,$55
	kp_settrackregister $00,$01
	kp_settrackregister $01,$56
	kp_settrackregister $00,$01
	kp_settrackregister $01,$57
	kp_settrackregister $00,$01
	kp_settrackregister $01,$58
	kp_settrackregister $00,$01
	kp_settrackregister $01,$59
	kp_settrackregister $00,$01
	kp_settrackregister $01,$5A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$5B
	kp_settrackregister $00,$01
	kp_settrackregister $01,$5C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$5D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$5E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$5F
	kp_settrackregister $00,$01
	kp_settrackregister $01,$60
	kp_settrackregister $00,$01
	kp_settrackregister $01,$61
	kp_settrackregister $00,$01
	kp_settrackregister $01,$62
	kp_settrackregister $00,$01
	kp_settrackregister $01,$63
	kp_settrackregister $00,$01
	kp_settrackregister $01,$64
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_settrackregister $01,$65
	kp_settrackregister $00,$01
	kp_settrackregister $01,$66
	kp_settrackregister $00,$01
	kp_settrackregister $01,$67
	kp_settrackregister $00,$01
	kp_settrackregister $01,$68
	kp_settrackregister $00,$01
	kp_settrackregister $01,$69
	kp_settrackregister $00,$01
	kp_settrackregister $01,$6A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$6B
	kp_settrackregister $00,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$6D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$6E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$6F
	kp_settrackregister $00,$01
	kp_settrackregister $01,$70
	kp_settrackregister $00,$01
	kp_settrackregister $01,$71
	kp_settrackregister $00,$01
	kp_settrackregister $01,$72
	kp_settrackregister $00,$01
	kp_settrackregister $01,$73
	kp_settrackregister $00,$01
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0C
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$02
	kp_settrackregister $01,$00
	kp_setinstrument $04,$01
	kp_rewind [pat7loop-pat7]
pat8
pat8loop
	kp_settrackregister $01,$74
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $01,$75
	kp_settrackregister $00,$01
	kp_settrackregister $01,$76
	kp_settrackregister $00,$01
	kp_settrackregister $01,$77
	kp_settrackregister $00,$01
	kp_settrackregister $01,$78
	kp_settrackregister $00,$01
	kp_settrackregister $01,$79
	kp_settrackregister $00,$01
	kp_settrackregister $01,$7A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$7B
	kp_settrackregister $00,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$7D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$7E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$7F
	kp_settrackregister $00,$01
	kp_settrackregister $01,$80
	kp_settrackregister $00,$01
	kp_settrackregister $01,$81
	kp_settrackregister $00,$01
	kp_settrackregister $01,$82
	kp_settrackregister $00,$01
	kp_settrackregister $01,$83
	kp_settrackregister $00,$01
	kp_settrackregister $01,$84
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$85
	kp_settrackregister $00,$01
	kp_settrackregister $01,$86
	kp_settrackregister $00,$01
	kp_settrackregister $01,$87
	kp_settrackregister $00,$01
	kp_settrackregister $01,$88
	kp_settrackregister $00,$01
	kp_settrackregister $01,$89
	kp_settrackregister $00,$01
	kp_settrackregister $01,$8A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$8B
	kp_settrackregister $00,$01
	kp_settrackregister $01,$8C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$8D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$8E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$8F
	kp_settrackregister $00,$01
	kp_settrackregister $01,$90
	kp_settrackregister $00,$01
	kp_settrackregister $01,$91
	kp_settrackregister $00,$01
	kp_settrackregister $01,$92
	kp_settrackregister $00,$01
	kp_settrackregister $01,$93
	kp_settrackregister $00,$01
	kp_rewind [pat8loop-pat8]
pat9
pat9loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0E
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$02
	kp_settrackregister $01,$00
	kp_setinstrument $04,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$02
	kp_settrackregister $01,$00
	kp_setinstrument $04,$01
	kp_rewind [pat9loop-pat9]
pat10
pat10loop
	kp_settrackregister $01,$94
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$01
	kp_settrackregister $01,$95
	kp_settrackregister $00,$01
	kp_settrackregister $01,$96
	kp_settrackregister $00,$01
	kp_settrackregister $01,$97
	kp_settrackregister $00,$01
	kp_settrackregister $01,$98
	kp_settrackregister $00,$01
	kp_settrackregister $01,$99
	kp_settrackregister $00,$01
	kp_settrackregister $01,$9A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$9B
	kp_settrackregister $00,$01
	kp_settrackregister $01,$9C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$9D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$9E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$9F
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A0
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A1
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A2
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A3
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A4
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A5
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A6
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A7
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A8
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A9
	kp_settrackregister $00,$01
	kp_settrackregister $01,$AA
	kp_settrackregister $00,$01
	kp_settrackregister $01,$AB
	kp_settrackregister $00,$01
	kp_settrackregister $01,$AC
	kp_settrackregister $00,$01
	kp_settrackregister $01,$AD
	kp_settrackregister $00,$01
	kp_settrackregister $01,$AE
	kp_settrackregister $00,$01
	kp_settrackregister $01,$AF
	kp_settrackregister $00,$01
	kp_settrackregister $01,$B0
	kp_settrackregister $00,$01
	kp_settrackregister $01,$B1
	kp_settrackregister $00,$01
	kp_settrackregister $01,$B2
	kp_settrackregister $00,$01
	kp_settrackregister $01,$B3
	kp_settrackregister $00,$01
	kp_rewind [pat10loop-pat10]
pat11
pat11loop
	kp_settrackregister $01,$00
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$02
	kp_settrackregister $01,$00
	kp_setinstrument $04,$01
	kp_setinstrument $02,$01
	kp_settrackregister $01,$30
	kp_setinstrument $02,$04
	kp_settrackregister $01,$00
	kp_setinstrument $02,$01
	kp_settrackregister $01,$20
	kp_setinstrument $02,$04
	kp_settrackregister $01,$30
	kp_setinstrument $02,$02
	kp_settrackregister $01,$10
	kp_setinstrument $02,$04
	kp_settrackregister $01,$00
	kp_setinstrument $02,$01
	kp_setinstrument $02,$04
	kp_rewind [pat11loop-pat11]
pat12
pat12loop
	kp_settrackregister $01,$B4
	kp_settrackregister $00,$01
	kp_settrackregister $01,$B5
	kp_settrackregister $00,$01
	kp_settrackregister $01,$B6
	kp_settrackregister $00,$01
	kp_settrackregister $01,$B7
	kp_settrackregister $00,$01
	kp_settrackregister $01,$B8
	kp_settrackregister $00,$01
	kp_settrackregister $01,$B9
	kp_settrackregister $00,$01
	kp_settrackregister $01,$BA
	kp_settrackregister $00,$01
	kp_settrackregister $01,$BB
	kp_settrackregister $00,$01
	kp_settrackregister $01,$BC
	kp_settrackregister $00,$01
	kp_settrackregister $01,$BD
	kp_settrackregister $00,$01
	kp_settrackregister $01,$BE
	kp_settrackregister $00,$01
	kp_settrackregister $01,$BF
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C0
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C1
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C2
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C3
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C4
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C5
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C6
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C7
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C8
	kp_settrackregister $00,$01
	kp_settrackregister $01,$C9
	kp_settrackregister $00,$01
	kp_settrackregister $01,$CA
	kp_settrackregister $00,$01
	kp_settrackregister $01,$CB
	kp_settrackregister $00,$01
	kp_settrackregister $01,$CC
	kp_settrackregister $00,$01
	kp_settrackregister $01,$CD
	kp_settrackregister $00,$01
	kp_settrackregister $01,$CE
	kp_settrackregister $00,$01
	kp_settrackregister $01,$CF
	kp_settrackregister $00,$01
	kp_settrackregister $01,$D0
	kp_settrackregister $00,$01
	kp_settrackregister $01,$D1
	kp_settrackregister $00,$01
	kp_settrackregister $01,$D2
	kp_settrackregister $00,$01
	kp_settrackregister $01,$D3
	kp_settrackregister $00,$01
	kp_rewind [pat12loop-pat12]
pat13
pat13loop
	kp_settrackregister $01,$1C
	kp_setinstrument $20,$05
	kp_rewind [pat13loop-pat13]
pat14
pat14loop
	kp_settrackregister $01,$00
	kp_setinstrument $04,$06
	kp_setinstrument $04,$06
	kp_setinstrument $04,$07
	kp_setinstrument $08,$06
	kp_settrackregister $01,$30
	kp_setinstrument $04,$08
	kp_setinstrument $04,$07
	kp_settrackregister $01,$00
	kp_setinstrument $04,$06
	kp_rewind [pat14loop-pat14]
pat15
pat15loop
	kp_settrackregister $00,$20
	kp_rewind [pat15loop-pat15]
pat16
pat16loop
	kp_settrackregister $01,$24
	kp_settrackregister $00,$20
	kp_rewind [pat16loop-pat16]
pat17
pat17loop
	kp_settrackregister $01,$28
	kp_settrackregister $00,$20
	kp_rewind [pat17loop-pat17]
pat18
pat18loop
	kp_settrackregister $01,$30
	kp_settrackregister $00,$20
	kp_rewind [pat18loop-pat18]
pat19
pat19loop
	kp_settrackregister $01,$A0
	kp_setinstrument $08,$09
	kp_settrackregister $01,$90
	kp_setinstrument $08,$0A
	kp_settrackregister $01,$8C
	kp_setinstrument $08,$09
	kp_settrackregister $01,$7C
	kp_setinstrument $08,$0B
	kp_rewind [pat19loop-pat19]
pat20
pat20loop
	kp_settrackregister $01,$84
	kp_setinstrument $08,$0C
	kp_settrackregister $01,$70
	kp_setinstrument $08,$09
	kp_settrackregister $01,$68
	kp_setinstrument $08,$0D
	kp_settrackregister $01,$60
	kp_setinstrument $08,$0E
	kp_rewind [pat20loop-pat20]
pat21
pat21loop
	kp_settrackregister $01,$10
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $08,$08
	kp_settrackregister $01,$30
	kp_setinstrument $04,$08
	kp_setinstrument $04,$07
	kp_settrackregister $01,$10
	kp_setinstrument $04,$0F
	kp_rewind [pat21loop-pat21]
pat22
pat22loop
	kp_settrackregister $01,$10
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $08,$08
	kp_settrackregister $01,$24
	kp_setinstrument $04,$08
	kp_setinstrument $04,$07
	kp_settrackregister $01,$10
	kp_setinstrument $04,$0F
	kp_rewind [pat22loop-pat22]
pat23
pat23loop
	kp_settrackregister $01,$74
	kp_setinstrument $02,$10
	kp_settrackregister $01,$84
	kp_setinstrument $02,$11
	kp_settrackregister $01,$60
	kp_setinstrument $02,$10
	kp_settrackregister $01,$74
	kp_setinstrument $02,$11
	kp_settrackregister $01,$54
	kp_setinstrument $02,$10
	kp_settrackregister $01,$60
	kp_setinstrument $02,$11
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$10
	kp_settrackregister $01,$54
	kp_setinstrument $02,$11
	kp_settrackregister $01,$44
	kp_setinstrument $02,$10
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$11
	kp_setinstrument $02,$10
	kp_settrackregister $01,$44
	kp_setinstrument $02,$11
	kp_settrackregister $01,$54
	kp_setinstrument $02,$10
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$11
	kp_settrackregister $01,$60
	kp_setinstrument $02,$10
	kp_settrackregister $01,$54
	kp_setinstrument $02,$11
	kp_rewind [pat23loop-pat23]
pat24
pat24loop
	kp_settrackregister $01,$14
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $08,$08
	kp_setinstrument $04,$08
	kp_setinstrument $04,$07
	kp_setinstrument $04,$0F
	kp_rewind [pat24loop-pat24]
pat25
pat25loop
	kp_settrackregister $01,$78
	kp_setinstrument $02,$10
	kp_settrackregister $01,$88
	kp_setinstrument $02,$11
	kp_settrackregister $01,$64
	kp_setinstrument $02,$10
	kp_settrackregister $01,$78
	kp_setinstrument $02,$11
	kp_settrackregister $01,$58
	kp_setinstrument $02,$10
	kp_settrackregister $01,$64
	kp_setinstrument $02,$11
	kp_settrackregister $01,$50
	kp_setinstrument $02,$10
	kp_settrackregister $01,$58
	kp_setinstrument $02,$11
	kp_settrackregister $01,$48
	kp_setinstrument $02,$10
	kp_settrackregister $01,$50
	kp_setinstrument $02,$11
	kp_setinstrument $02,$10
	kp_settrackregister $01,$48
	kp_setinstrument $02,$11
	kp_settrackregister $01,$58
	kp_setinstrument $02,$10
	kp_settrackregister $01,$50
	kp_setinstrument $02,$11
	kp_settrackregister $01,$64
	kp_setinstrument $02,$10
	kp_settrackregister $01,$58
	kp_setinstrument $02,$11
	kp_rewind [pat25loop-pat25]
pat26
pat26loop
	kp_settrackregister $01,$18
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $08,$08
	kp_setinstrument $04,$08
	kp_setinstrument $04,$07
	kp_setinstrument $04,$0F
	kp_rewind [pat26loop-pat26]
pat27
pat27loop
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$10
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$11
	kp_settrackregister $01,$68
	kp_setinstrument $02,$10
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$11
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$10
	kp_settrackregister $01,$68
	kp_setinstrument $02,$11
	kp_settrackregister $01,$54
	kp_setinstrument $02,$10
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$11
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$10
	kp_settrackregister $01,$54
	kp_setinstrument $02,$11
	kp_setinstrument $02,$10
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$11
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$10
	kp_settrackregister $01,$54
	kp_setinstrument $02,$11
	kp_settrackregister $01,$68
	kp_setinstrument $02,$10
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$11
	kp_rewind [pat27loop-pat27]
pat28
pat28loop
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $08,$08
	kp_setinstrument $04,$08
	kp_setinstrument $04,$08
	kp_setinstrument $04,$0F
	kp_rewind [pat28loop-pat28]
pat29
pat29loop
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$12
	kp_settrackregister $01,$38
	kp_setinstrument $04,$12
	kp_settrackregister $01,$2C
	kp_setinstrument $04,$12
	kp_settrackregister $01,$24
	kp_setinstrument $04,$12
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$12
	kp_settrackregister $01,$54
	kp_setinstrument $04,$12
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$12
	kp_settrackregister $01,$68
	kp_setinstrument $04,$12
	kp_rewind [pat29loop-pat29]
pat30
pat30loop
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $08,$08
	kp_setinstrument $04,$08
	kp_setinstrument $04,$13
	kp_setinstrument $04,$04
	kp_rewind [pat30loop-pat30]
pat31
pat31loop
	kp_settrackregister $01,$90
	kp_setinstrument $10,$14
	kp_settrackregister $01,$80
	kp_setinstrument $04,$15
	kp_settrackregister $01,$90
	kp_setinstrument $04,$15
	kp_settrackregister $01,$9C
	kp_setinstrument $04,$15
	kp_settrackregister $01,$98
	kp_setinstrument $04,$14
	kp_rewind [pat31loop-pat31]
pat32
pat32loop
	kp_settrackregister $01,$20
	kp_settrackregister $03,$0F
	kp_setinstrument $08,$0F
	kp_settrackregister $01,$0C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$20
	kp_setinstrument $08,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_settrackregister $01,$0C
	kp_setinstrument $04,$0F
	kp_rewind [pat32loop-pat32]
pat33
pat33loop
	kp_settrackregister $00,$10
	kp_settrackregister $01,$88
	kp_setinstrument $04,$15
	kp_settrackregister $01,$98
	kp_setinstrument $04,$15
	kp_settrackregister $01,$A4
	kp_setinstrument $08,$14
	kp_rewind [pat33loop-pat33]
pat34
pat34loop
	kp_settrackregister $01,$28
	kp_setinstrument $08,$0F
	kp_settrackregister $01,$14
	kp_setinstrument $04,$08
	kp_settrackregister $01,$28
	kp_setinstrument $08,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_settrackregister $01,$14
	kp_setinstrument $04,$08
	kp_rewind [pat34loop-pat34]
pat35
pat35loop
	kp_settrackregister $01,$A0
	kp_setinstrument $08,$14
	kp_settrackregister $01,$A4
	kp_setinstrument $04,$15
	kp_settrackregister $01,$AC
	kp_setinstrument $14,$14
	kp_rewind [pat35loop-pat35]
pat36
pat36loop
	kp_settrackregister $01,$30
	kp_setinstrument $08,$0F
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$30
	kp_setinstrument $08,$0F
	kp_settrackregister $01,$38
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $04,$0F
	kp_rewind [pat36loop-pat36]
pat37
pat37loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$12
	kp_settrackregister $01,$44
	kp_setinstrument $04,$12
	kp_settrackregister $01,$40
	kp_setinstrument $04,$12
	kp_settrackregister $01,$30
	kp_setinstrument $04,$12
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$12
	kp_settrackregister $01,$14
	kp_setinstrument $04,$12
	kp_settrackregister $01,$10
	kp_setinstrument $04,$12
	kp_rewind [pat37loop-pat37]
pat38
pat38loop
	kp_settrackregister $01,$40
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$1C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$38
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$10
	kp_settrackregister $00,$04
	kp_settrackregister $01,$30
	kp_setinstrument $04,$08
	kp_setinstrument $04,$07
	kp_settrackregister $01,$28
	kp_setinstrument $04,$08
	kp_setinstrument $04,$07
	kp_rewind [pat38loop-pat38]
pat39
pat39loop
	kp_settrackregister $01,$AC
	kp_setinstrument $10,$16
	kp_settrackregister $01,$E4
	kp_setinstrument $10,$17
	kp_rewind [pat39loop-pat39]
pat40
pat40loop
	kp_settrackregister $01,$2C
	kp_setinstrument $08,$0F
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$2C
	kp_setinstrument $08,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_settrackregister $01,$30
	kp_setinstrument $04,$08
	kp_rewind [pat40loop-pat40]
pat41
pat41loop
	kp_settrackregister $01,$EC
	kp_settrackregister $00,$18
	kp_settrackregister $01,$70
	kp_setinstrument $04,$18
	kp_settrackregister $01,$74
	kp_setinstrument $04,$19
	kp_rewind [pat41loop-pat41]
pat42
pat42loop
	kp_settrackregister $01,$38
	kp_setinstrument $04,$0F
	kp_setinstrument $02,$07
	kp_setinstrument $02,$07
	kp_settrackregister $01,$30
	kp_setinstrument $04,$08
	kp_setinstrument $02,$07
	kp_setinstrument $02,$07
	kp_settrackregister $01,$2C
	kp_setinstrument $04,$0F
	kp_setinstrument $02,$07
	kp_setinstrument $02,$07
	kp_setinstrument $04,$13
	kp_setinstrument $04,$13
	kp_rewind [pat42loop-pat42]
pat43
pat43loop
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$1A
	kp_settrackregister $01,$70
	kp_setinstrument $04,$18
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$1A
	kp_settrackregister $01,$90
	kp_setinstrument $08,$0A
	kp_settrackregister $01,$70
	kp_setinstrument $04,$18
	kp_settrackregister $01,$74
	kp_setinstrument $04,$19
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$0A
	kp_rewind [pat43loop-pat43]
pat44
pat44loop
	kp_settrackregister $01,$30
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$60
	kp_setinstrument $04,$1B
	kp_settrackregister $01,$30
	kp_setinstrument $08,$08
	kp_settrackregister $01,$00
	kp_setinstrument $04,$06
	kp_setinstrument $04,$07
	kp_settrackregister $01,$28
	kp_setinstrument $04,$0F
	kp_rewind [pat44loop-pat44]
pat45
pat45loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$60
	kp_setinstrument $04,$19
	kp_settrackregister $01,$70
	kp_setinstrument $04,$18
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$1A
	kp_settrackregister $01,$90
	kp_setinstrument $04,$19
	kp_settrackregister $01,$70
	kp_setinstrument $04,$18
	kp_settrackregister $01,$74
	kp_setinstrument $08,$0A
	kp_rewind [pat45loop-pat45]
pat46
pat46loop
	kp_settrackregister $00,$04
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$58
	kp_setinstrument $04,$1C
	kp_settrackregister $01,$28
	kp_setinstrument $04,$0F
	kp_setinstrument $08,$08
	kp_setinstrument $02,$07
	kp_setinstrument $02,$07
	kp_setinstrument $04,$0F
	kp_rewind [pat46loop-pat46]
pat47
pat47loop
	kp_settrackregister $01,$7C
	kp_setinstrument $0C,$1D
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$18
	kp_settrackregister $01,$60
	kp_setinstrument $04,$19
	kp_settrackregister $01,$70
	kp_setinstrument $04,$18
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$1A
	kp_settrackregister $01,$90
	kp_setinstrument $04,$1E
	kp_rewind [pat47loop-pat47]
pat48
pat48loop
	kp_settrackregister $01,$14
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$44
	kp_setinstrument $04,$1B
	kp_settrackregister $01,$14
	kp_setinstrument $08,$08
	kp_settrackregister $01,$00
	kp_setinstrument $04,$06
	kp_setinstrument $04,$07
	kp_settrackregister $01,$20
	kp_setinstrument $04,$0F
	kp_rewind [pat48loop-pat48]
pat49
pat49loop
	kp_settrackregister $00,$08
	kp_settrackregister $01,$88
	kp_setinstrument $08,$0A
	kp_settrackregister $01,$7C
	kp_setinstrument $08,$0A
	kp_settrackregister $01,$70
	kp_setinstrument $04,$18
	kp_settrackregister $01,$74
	kp_setinstrument $04,$19
	kp_rewind [pat49loop-pat49]
pat50
pat50loop
	kp_settrackregister $00,$04
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$1B
	kp_settrackregister $01,$20
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$1C
	kp_setinstrument $08,$08
	kp_setinstrument $08,$13
	kp_rewind [pat50loop-pat50]
pat51
pat51loop
	kp_settrackregister $01,$7C
	kp_setinstrument $0C,$1D
	kp_setinstrument $04,$1A
	kp_settrackregister $01,$90
	kp_setinstrument $04,$19
	kp_settrackregister $01,$98
	kp_setinstrument $04,$1A
	kp_settrackregister $01,$A0
	kp_setinstrument $04,$18
	kp_settrackregister $01,$A4
	kp_setinstrument $04,$0A
	kp_rewind [pat51loop-pat51]
pat52
pat52loop
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$44
	kp_setinstrument $04,$1B
	kp_settrackregister $01,$24
	kp_setinstrument $08,$08
	kp_settrackregister $01,$00
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$07
	kp_settrackregister $01,$20
	kp_setinstrument $04,$0F
	kp_rewind [pat52loop-pat52]
pat53
pat53loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$9C
	kp_setinstrument $04,$1A
	kp_settrackregister $01,$98
	kp_setinstrument $04,$18
	kp_settrackregister $01,$90
	kp_setinstrument $0C,$09
	kp_settrackregister $01,$70
	kp_setinstrument $04,$18
	kp_settrackregister $01,$74
	kp_setinstrument $04,$19
	kp_rewind [pat53loop-pat53]
pat54
pat54loop
	kp_settrackregister $00,$04
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$1B
	kp_settrackregister $01,$20
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$28
	kp_setinstrument $08,$08
	kp_setinstrument $08,$13
	kp_rewind [pat54loop-pat54]
pat55
pat55loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$9C
	kp_setinstrument $04,$1A
	kp_settrackregister $01,$98
	kp_setinstrument $04,$18
	kp_settrackregister $01,$90
	kp_setinstrument $10,$1F
	kp_settrackregister $01,$60
	kp_setinstrument $02,$15
	kp_settrackregister $01,$68
	kp_setinstrument $02,$15
	kp_rewind [pat55loop-pat55]
pat56
pat56loop
	kp_settrackregister $01,$70
	kp_setinstrument $08,$20
	kp_settrackregister $01,$68
	kp_setinstrument $04,$15
	kp_settrackregister $01,$70
	kp_setinstrument $14,$20
	kp_rewind [pat56loop-pat56]
pat57
pat57loop
	kp_settrackregister $01,$14
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$08
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$08
	kp_setinstrument $04,$0F
	kp_rewind [pat57loop-pat57]
pat58
pat58loop
	kp_settrackregister $00,$0C
	kp_settrackregister $01,$60
	kp_setinstrument $01,$15
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $01,$5C
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$15
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$15
	kp_settrackregister $01,$60
	kp_setinstrument $06,$20
	kp_settrackregister $01,$70
	kp_setinstrument $06,$20
	kp_rewind [pat58loop-pat58]
pat59
pat59loop
	kp_setinstrument $04,$0F
	kp_setinstrument $04,$0F
	kp_setinstrument $08,$08
	kp_setinstrument $08,$08
	kp_setinstrument $04,$08
	kp_setinstrument $02,$07
	kp_setinstrument $02,$07
	kp_rewind [pat59loop-pat59]
pat60
pat60loop
	kp_settrackregister $01,$7C
	kp_setinstrument $08,$20
	kp_settrackregister $01,$74
	kp_setinstrument $06,$20
	kp_settrackregister $01,$7C
	kp_setinstrument $12,$20
	kp_rewind [pat60loop-pat60]
pat61
pat61loop
	kp_settrackregister $01,$00
	kp_setinstrument $20,$21
	kp_rewind [pat61loop-pat61]
pat62
pat62loop
	kp_settrackregister $01,$02
	kp_settrackregister $00,$01
	kp_settrackregister $01,$04
	kp_settrackregister $00,$01
	kp_settrackregister $01,$06
	kp_settrackregister $00,$01
	kp_settrackregister $01,$08
	kp_settrackregister $00,$01
	kp_settrackregister $01,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$0C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$0E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$10
	kp_settrackregister $00,$01
	kp_settrackregister $01,$12
	kp_settrackregister $00,$01
	kp_settrackregister $01,$16
	kp_settrackregister $00,$01
	kp_settrackregister $01,$18
	kp_settrackregister $00,$01
	kp_settrackregister $01,$1A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$1C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$1E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$20
	kp_settrackregister $00,$01
	kp_settrackregister $01,$22
	kp_settrackregister $00,$01
	kp_settrackregister $01,$24
	kp_settrackregister $00,$01
	kp_settrackregister $01,$26
	kp_settrackregister $00,$01
	kp_settrackregister $01,$28
	kp_settrackregister $00,$01
	kp_settrackregister $01,$2A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$2C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$2E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$30
	kp_settrackregister $00,$01
	kp_settrackregister $01,$32
	kp_settrackregister $00,$01
	kp_settrackregister $01,$34
	kp_settrackregister $00,$01
	kp_settrackregister $01,$36
	kp_settrackregister $00,$01
	kp_settrackregister $01,$38
	kp_settrackregister $00,$01
	kp_settrackregister $01,$3A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$3C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$3E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$40
	kp_settrackregister $00,$01
	kp_settrackregister $01,$42
	kp_settrackregister $00,$01
	kp_rewind [pat62loop-pat62]
pat63
pat63loop
	kp_settrackregister $01,$84
	kp_setinstrument $20,$16
	kp_rewind [pat63loop-pat63]
pat64
pat64loop
	kp_settrackregister $01,$14
	kp_setinstrument $20,$05
	kp_rewind [pat64loop-pat64]
pat65
pat65loop
	kp_settrackregister $00,$02
	kp_settrackregister $01,$86
	kp_settrackregister $00,$01
	kp_settrackregister $01,$88
	kp_settrackregister $00,$01
	kp_settrackregister $01,$8A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$8C
	kp_settrackregister $00,$1B
	kp_rewind [pat65loop-pat65]
pat66
pat66loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$2C
	kp_settrackregister $00,$1C
	kp_rewind [pat66loop-pat66]
pat67
pat67loop
	kp_settrackregister $03,$0E
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$07
	kp_settrackregister $00,$02
	kp_settrackregister $03,$06
	kp_settrackregister $00,$02
	kp_settrackregister $03,$05
	kp_settrackregister $00,$02
	kp_settrackregister $03,$04
	kp_settrackregister $00,$02
	kp_settrackregister $03,$03
	kp_settrackregister $00,$02
	kp_settrackregister $03,$02
	kp_settrackregister $00,$02
	kp_settrackregister $03,$01
	kp_settrackregister $00,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$02
	kp_setinstrument $02,$22
	kp_rewind [pat67loop-pat67]

kp_insmap_lo
	dc.b #<insnil
	dc.b #<ins1
	dc.b #<ins2
	dc.b #<ins3
	dc.b #<ins4
	dc.b #<ins5
	dc.b #<ins6
	dc.b #<ins7
	dc.b #<ins8
	dc.b #<ins9
	dc.b #<ins10
	dc.b #<ins11
	dc.b #<ins12
	dc.b #<ins13
	dc.b #<ins14
	dc.b #<ins15
	dc.b #<ins16
	dc.b #<ins17
	dc.b #<ins18
	dc.b #<ins19
	dc.b #<ins20
	dc.b #<ins21
	dc.b #<ins22
	dc.b #<ins23
	dc.b #<ins24
	dc.b #<ins25
	dc.b #<ins26
	dc.b #<ins27
	dc.b #<ins28
	dc.b #<ins29
	dc.b #<ins30
	dc.b #<ins31
	dc.b #<ins32
	dc.b #<ins33
	dc.b #<ins34

kp_insmap_hi
	dc.b #>insnil
	dc.b #>ins1
	dc.b #>ins2
	dc.b #>ins3
	dc.b #>ins4
	dc.b #>ins5
	dc.b #>ins6
	dc.b #>ins7
	dc.b #>ins8
	dc.b #>ins9
	dc.b #>ins10
	dc.b #>ins11
	dc.b #>ins12
	dc.b #>ins13
	dc.b #>ins14
	dc.b #>ins15
	dc.b #>ins16
	dc.b #>ins17
	dc.b #>ins18
	dc.b #>ins19
	dc.b #>ins20
	dc.b #>ins21
	dc.b #>ins22
	dc.b #>ins23
	dc.b #>ins24
	dc.b #>ins25
	dc.b #>ins26
	dc.b #>ins27
	dc.b #>ins28
	dc.b #>ins29
	dc.b #>ins30
	dc.b #>ins31
	dc.b #>ins32
	dc.b #>ins33
	dc.b #>ins34

kp_volmap_lo
	dc.b #<volnil
	dc.b #<vol1
	dc.b #<vol2
	dc.b #<vol3
	dc.b #<vol4
	dc.b #<vol5
	dc.b #<vol6
	dc.b #<vol7
	dc.b #<vol8
	dc.b #<vol9
	dc.b #<vol10
	dc.b #<vol11
	dc.b #<vol12
	dc.b #<vol13
	dc.b #<vol14
	dc.b #<vol15
	dc.b #<vol16
	dc.b #<vol17
	dc.b #<vol18
	dc.b #<vol19
	dc.b #<vol20
	dc.b #<vol21
	dc.b #<vol22
	dc.b #<vol23
	dc.b #<vol24
	dc.b #<vol25
	dc.b #<vol26
	dc.b #<vol27
	dc.b #<vol28
	dc.b #<vol29
	dc.b #<vol30
	dc.b #<vol31
	dc.b #<vol32
	dc.b #<vol33
	dc.b #<vol34

kp_volmap_hi
	dc.b #>volnil
	dc.b #>vol1
	dc.b #>vol2
	dc.b #>vol3
	dc.b #>vol4
	dc.b #>vol5
	dc.b #>vol6
	dc.b #>vol7
	dc.b #>vol8
	dc.b #>vol9
	dc.b #>vol10
	dc.b #>vol11
	dc.b #>vol12
	dc.b #>vol13
	dc.b #>vol14
	dc.b #>vol15
	dc.b #>vol16
	dc.b #>vol17
	dc.b #>vol18
	dc.b #>vol19
	dc.b #>vol20
	dc.b #>vol21
	dc.b #>vol22
	dc.b #>vol23
	dc.b #>vol24
	dc.b #>vol25
	dc.b #>vol26
	dc.b #>vol27
	dc.b #>vol28
	dc.b #>vol29
	dc.b #>vol30
	dc.b #>vol31
	dc.b #>vol32
	dc.b #>vol33
	dc.b #>vol34

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $00,0,1,1,$02
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
ins1loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$05
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $0F,$05
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
vol1loop
	KP_VOLV $08,$00
	KP_VOLJ [vol1loop-vol1]
ins2
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
ins2loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $0F,$05
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
vol2loop
	KP_VOLV $08,$00
	KP_VOLJ [vol2loop-vol2]
ins3
ins3loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $30,1,0,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $14,0,1,1,$00
	KP_OSCV $40,1,0,1,$00
	KP_OSCV $14,0,1,1,$00
	KP_OSCJ [ins3loop-ins3]

vol3
vol3loop
	KP_VOLV $0F,$00
	KP_VOLJ [vol3loop-vol3]
ins4
	KP_OSCV $1C,0,1,1,$00
	KP_OSCV $16,0,1,1,$00
	KP_OSCV $11,0,1,1,$00
	KP_OSCV $0D,0,1,1,$00
	KP_OSCV $0B,0,1,1,$00
	KP_OSCV $09,0,1,1,$00
	KP_OSCV $07,0,1,1,$00
	KP_OSCV $05,0,1,1,$00
	KP_OSCV $04,0,1,1,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
ins4loop
	KP_OSCV $00,0,0,0,$00
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $0F,$05
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $05,$00
vol4loop
	KP_VOLV $03,$00
	KP_VOLJ [vol4loop-vol4]
ins5
ins5loop
	KP_OSCV $54,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $60,0,1,1,$00
	KP_OSCV $44,0,1,1,$00
	KP_OSCV $74,0,1,1,$00
	KP_OSCV $84,0,1,1,$00
	KP_OSCV $24,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $14,0,1,1,$00
	KP_OSCV $44,0,1,1,$00
	KP_OSCV $54,0,1,1,$00
	KP_OSCJ [ins5loop-ins5]

vol5
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
vol5loop
	KP_VOLV $0F,$00
	KP_VOLJ [vol5loop-vol5]
ins6
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $34,0,1,0,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $00,0,1,1,$02
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
ins6loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$05
	KP_OSCJ [ins6loop-ins6]

vol6
	KP_VOLV $0F,$00
	KP_VOLV $0C,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$04
	KP_VOLV $0E,$02
	KP_VOLV $0D,$02
	KP_VOLV $0C,$02
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
	KP_VOLV $09,$01
	KP_VOLV $08,$00
vol6loop
	KP_VOLV $07,$00
	KP_VOLJ [vol6loop-vol6]
ins7
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $10,1,0,0,$00
ins7loop
	KP_OSCV $52,0,1,0,$00
	KP_OSCV $4E,0,1,0,$00
	KP_OSCJ [ins7loop-ins7]

vol7
	KP_VOLV $09,$00
	KP_VOLV $0C,$00
	KP_VOLV $0F,$03
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
vol7loop
	KP_VOLV $04,$00
	KP_VOLJ [vol7loop-vol7]
ins8
	KP_OSCV $A2,1,0,0,$00
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
ins8loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins8loop-ins8]

vol8
	KP_VOLV $0F,$00
	KP_VOLV $0C,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$04
	KP_VOLV $0E,$02
	KP_VOLV $0D,$02
	KP_VOLV $0C,$02
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
	KP_VOLV $09,$01
	KP_VOLV $08,$00
vol8loop
	KP_VOLV $07,$00
	KP_VOLJ [vol8loop-vol8]
ins9
ins9loop
	KP_OSCV $20,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$02
	KP_OSCV $20,0,1,1,$00
	KP_OSCJ [ins9loop-ins9]

vol9
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
vol9loop
	KP_VOLV $08,$00
	KP_VOLJ [vol9loop-vol9]
ins10
ins10loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$02
	KP_OSCV $1C,0,1,1,$00
	KP_OSCJ [ins10loop-ins10]

vol10
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
vol10loop
	KP_VOLV $08,$00
	KP_VOLJ [vol10loop-vol10]
ins11
ins11loop
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $14,0,1,1,$02
	KP_OSCV $24,0,1,1,$00
	KP_OSCJ [ins11loop-ins11]

vol11
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$05
	KP_VOLV $0E,$07
	KP_VOLV $0E,$07
	KP_VOLV $0E,$07
	KP_VOLV $0D,$07
	KP_VOLV $0D,$07
	KP_VOLV $0D,$07
vol11loop
	KP_VOLV $0C,$00
	KP_VOLJ [vol11loop-vol11]
ins12
ins12loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$02
	KP_OSCV $1C,0,1,1,$00
	KP_OSCJ [ins12loop-ins12]

vol12
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
vol12loop
	KP_VOLV $08,$00
	KP_VOLJ [vol12loop-vol12]
ins13
ins13loop
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $14,0,1,1,$02
	KP_OSCV $24,0,1,1,$00
	KP_OSCJ [ins13loop-ins13]

vol13
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
vol13loop
	KP_VOLV $08,$00
	KP_VOLJ [vol13loop-vol13]
ins14
ins14loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$02
	KP_OSCV $1C,0,1,1,$00
	KP_OSCJ [ins14loop-ins14]

vol14
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$05
	KP_VOLV $0E,$07
	KP_VOLV $0E,$07
	KP_VOLV $0E,$07
	KP_VOLV $0D,$07
	KP_VOLV $0D,$07
	KP_VOLV $0D,$07
vol14loop
	KP_VOLV $0C,$00
	KP_VOLJ [vol14loop-vol14]
ins15
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $34,0,1,0,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
ins15loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins15loop-ins15]

vol15
	KP_VOLV $0F,$00
	KP_VOLV $0C,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$04
	KP_VOLV $0E,$02
	KP_VOLV $0D,$02
	KP_VOLV $0C,$02
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
	KP_VOLV $09,$01
	KP_VOLV $08,$00
vol15loop
	KP_VOLV $07,$00
	KP_VOLJ [vol15loop-vol15]
ins16
ins16loop
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins16loop-ins16]

vol16
	KP_VOLV $0F,$03
	KP_VOLV $0E,$00
	KP_VOLV $0C,$00
	KP_VOLV $09,$00
vol16loop
	KP_VOLV $05,$00
	KP_VOLJ [vol16loop-vol16]
ins17
ins17loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins17loop-ins17]

vol17
vol17loop
	KP_VOLV $04,$00
	KP_VOLJ [vol17loop-vol17]
ins18
	KP_OSCV $61,0,1,1,$00
	KP_OSCV $62,0,1,1,$00
	KP_OSCV $60,0,1,1,$00
	KP_OSCV $5F,0,1,1,$00
	KP_OSCV $5E,0,1,1,$00
	KP_OSCV $60,0,1,1,$00
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $32,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $2F,0,1,1,$00
	KP_OSCV $2E,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
ins18loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins18loop-ins18]

vol18
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $05,$00
vol18loop
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLJ [vol18loop-vol18]
ins19
	KP_OSCV $08,0,1,0,$00
	KP_OSCV $78,1,0,0,$00
ins19loop
	KP_OSCV $F2,1,0,0,$00
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $FA,1,0,0,$00
	KP_OSCV $E8,1,0,0,$00
	KP_OSCJ [ins19loop-ins19]

vol19
	KP_VOLV $0F,$03
	KP_VOLV $0E,$02
	KP_VOLV $0D,$01
	KP_VOLV $0C,$01
	KP_VOLV $0B,$01
	KP_VOLV $0A,$01
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
vol19loop
	KP_VOLV $04,$00
	KP_VOLJ [vol19loop-vol19]
ins20
	KP_OSCV $F8,0,1,1,$00
	KP_OSCV $FC,0,1,1,$00
ins20loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$01
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins20loop-ins20]

vol20
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$06
	KP_VOLV $0E,$07
	KP_VOLV $0E,$03
	KP_VOLV $0D,$07
	KP_VOLV $0D,$03
	KP_VOLV $0C,$07
	KP_VOLV $0C,$03
	KP_VOLV $0B,$07
	KP_VOLV $0B,$03
	KP_VOLV $0A,$07
	KP_VOLV $0A,$03
	KP_VOLV $09,$07
	KP_VOLV $09,$03
vol20loop
	KP_VOLV $08,$00
	KP_VOLJ [vol20loop-vol20]
ins21
ins21loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$01
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCJ [ins21loop-ins21]

vol21
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$06
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
vol21loop
	KP_VOLV $09,$00
	KP_VOLJ [vol21loop-vol21]
ins22
ins22loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$01
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCJ [ins22loop-ins22]

vol22
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
vol22loop
	KP_VOLV $0F,$00
	KP_VOLJ [vol22loop-vol22]
ins23
ins23loop
	KP_OSCV $AC,0,1,0,$00
	KP_OSCV $AD,0,1,0,$00
	KP_OSCV $AC,0,1,1,$00
	KP_OSCV $AF,0,1,0,$00
	KP_OSCV $B0,0,1,0,$00
	KP_OSCV $AF,0,1,0,$00
	KP_OSCV $AC,0,1,1,$00
	KP_OSCV $AD,0,1,0,$00
	KP_OSCV $AC,0,1,0,$00
	KP_OSCV $AB,0,1,0,$00
	KP_OSCV $AC,0,1,1,$00
	KP_OSCV $A9,0,1,0,$00
	KP_OSCV $A8,0,1,0,$00
	KP_OSCV $A9,0,1,0,$00
	KP_OSCV $AC,0,1,1,$00
	KP_OSCV $AB,0,1,0,$00
	KP_OSCJ [ins23loop-ins23]

vol23
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$05
	KP_VOLV $0E,$07
	KP_VOLV $0E,$07
	KP_VOLV $0E,$07
	KP_VOLV $0E,$02
	KP_VOLV $0D,$07
	KP_VOLV $0D,$07
	KP_VOLV $0D,$07
	KP_VOLV $0D,$07
	KP_VOLV $0D,$06
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$02
vol23loop
	KP_VOLV $0B,$00
	KP_VOLJ [vol23loop-vol23]
ins24
ins24loop
	KP_OSCV $20,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$02
	KP_OSCV $20,0,1,1,$00
	KP_OSCJ [ins24loop-ins24]

vol24
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0E,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
vol24loop
	KP_VOLV $08,$00
	KP_VOLJ [vol24loop-vol24]
ins25
ins25loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$02
	KP_OSCV $1C,0,1,1,$00
	KP_OSCJ [ins25loop-ins25]

vol25
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0E,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
vol25loop
	KP_VOLV $08,$00
	KP_VOLJ [vol25loop-vol25]
ins26
ins26loop
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $14,0,1,1,$02
	KP_OSCV $24,0,1,1,$00
	KP_OSCJ [ins26loop-ins26]

vol26
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0E,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
vol26loop
	KP_VOLV $08,$00
	KP_VOLJ [vol26loop-vol26]
ins27
ins27loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$01
	KP_OSCV $40,0,1,1,$00
	KP_OSCV $4C,0,1,1,$00
	KP_OSCJ [ins27loop-ins27]

vol27
	KP_VOLV $0F,$05
	KP_VOLV $0E,$01
	KP_VOLV $0D,$01
	KP_VOLV $0C,$01
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
vol27loop
	KP_VOLV $09,$00
	KP_VOLJ [vol27loop-vol27]
ins28
ins28loop
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$01
	KP_OSCV $40,0,1,1,$00
	KP_OSCV $54,0,1,1,$00
	KP_OSCJ [ins28loop-ins28]

vol28
	KP_VOLV $0F,$05
	KP_VOLV $0E,$01
	KP_VOLV $0D,$01
	KP_VOLV $0C,$01
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
vol28loop
	KP_VOLV $09,$00
	KP_VOLJ [vol28loop-vol28]
ins29
ins29loop
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $14,0,1,1,$02
	KP_OSCV $24,0,1,1,$00
	KP_OSCJ [ins29loop-ins29]

vol29
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$03
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
vol29loop
	KP_VOLV $08,$00
	KP_VOLJ [vol29loop-vol29]
ins30
ins30loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$02
	KP_OSCV $1C,0,1,1,$00
	KP_OSCJ [ins30loop-ins30]

vol30
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$03
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
vol30loop
	KP_VOLV $08,$00
	KP_VOLJ [vol30loop-vol30]
ins31
ins31loop
	KP_OSCV $20,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$02
	KP_OSCV $20,0,1,1,$00
	KP_OSCJ [ins31loop-ins31]

vol31
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$03
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
vol31loop
	KP_VOLV $0B,$00
	KP_VOLJ [vol31loop-vol31]
ins32
ins32loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$01
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCJ [ins32loop-ins32]

vol32
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$07
	KP_VOLV $0F,$05
	KP_VOLV $0E,$07
	KP_VOLV $0E,$07
	KP_VOLV $0E,$07
	KP_VOLV $0D,$07
	KP_VOLV $0D,$07
	KP_VOLV $0D,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0B,$07
	KP_VOLV $0B,$07
	KP_VOLV $0B,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $09,$07
	KP_VOLV $09,$07
	KP_VOLV $09,$07
vol32loop
	KP_VOLV $08,$00
	KP_VOLJ [vol32loop-vol32]
ins33
ins33loop
	KP_OSCV $28,0,1,0,$00
	KP_OSCV $29,0,1,0,$00
	KP_OSCV $28,0,1,1,$00
	KP_OSCV $2B,0,1,0,$00
	KP_OSCV $2C,0,1,0,$00
	KP_OSCV $2B,0,1,0,$00
	KP_OSCV $28,0,1,1,$00
	KP_OSCV $29,0,1,0,$00
	KP_OSCV $28,0,1,0,$00
	KP_OSCV $27,0,1,0,$00
	KP_OSCV $28,0,1,1,$00
	KP_OSCV $25,0,1,0,$00
	KP_OSCV $24,0,1,0,$00
	KP_OSCV $25,0,1,0,$00
	KP_OSCV $28,0,1,1,$00
	KP_OSCV $27,0,1,0,$00
	KP_OSCJ [ins33loop-ins33]

vol33
vol33loop
	KP_VOLV $0F,$00
	KP_VOLJ [vol33loop-vol33]
ins34
ins34loop
	KP_OSCV $00,0,0,0,$00
	KP_OSCJ [ins34loop-ins34]

vol34
vol34loop
	KP_VOLV $00,$00
	KP_VOLJ [vol34loop-vol34]

kp_sequence
	dc.b $00,$01,$00,$00
	dc.b $00,$02,$00,$00
	dc.b $00,$03,$00,$00
	dc.b $00,$04,$00,$00
	dc.b $00,$05,$06,$00
	dc.b $00,$07,$08,$00
	dc.b $00,$09,$0A,$00
	dc.b $00,$0B,$0C,$00
	dc.b $00,$0D,$0E,$00
	dc.b $00,$0F,$0E,$00
	dc.b $00,$10,$0E,$00
	dc.b $00,$0F,$0E,$00
	dc.b $00,$11,$0E,$00
	dc.b $00,$0F,$0E,$00
	dc.b $00,$12,$0E,$00
	dc.b $00,$0F,$0E,$00
	dc.b $00,$13,$0E,$00
	dc.b $00,$0F,$0E,$00
	dc.b $00,$14,$15,$00
	dc.b $00,$0F,$16,$00
	dc.b $00,$17,$18,$00
	dc.b $00,$19,$1A,$00
	dc.b $00,$1B,$1C,$00
	dc.b $00,$1D,$1E,$00
	dc.b $00,$1F,$20,$00
	dc.b $00,$21,$22,$00
	dc.b $00,$23,$24,$00
	dc.b $00,$25,$26,$00
	dc.b $00,$1F,$20,$00
	dc.b $00,$21,$22,$00
	dc.b $00,$27,$28,$00
	dc.b $00,$29,$2A,$00
	dc.b $00,$2B,$2C,$00
	dc.b $00,$2D,$2E,$00
	dc.b $00,$2F,$30,$00
	dc.b $00,$31,$32,$00
	dc.b $00,$2B,$2C,$00
	dc.b $00,$2D,$2E,$00
	dc.b $00,$33,$34,$00
	dc.b $00,$35,$36,$00
	dc.b $00,$2B,$2C,$00
	dc.b $00,$2D,$2E,$00
	dc.b $00,$2F,$30,$00
	dc.b $00,$31,$32,$00
	dc.b $00,$2B,$2C,$00
	dc.b $00,$2D,$2E,$00
	dc.b $00,$33,$34,$00
	dc.b $00,$37,$36,$00
	dc.b $00,$38,$39,$00
	dc.b $00,$3A,$3B,$00
	dc.b $00,$3C,$3D,$00
	dc.b $00,$0F,$3E,$00
	dc.b $00,$3F,$40,$00
	dc.b $00,$41,$42,$00
	dc.b $00,$0F,$0F,$00
	dc.b $00,$43,$43,$00
	dc.b $ff
	dc.w $0004

