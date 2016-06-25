kp_song_registers
kp_speed
	dc.b $02
kp_grooveboxpos
	dc.b $00
kp_grooveboxlen
	dc.b $04
kp_groovebox
	dc.b $04
	dc.b $05
	dc.b $06
	dc.b $05
	dc.b $05
	dc.b $04
	dc.b $06
	dc.b $05
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

kp_patternmap_hi
	dc.b #>patnil
	dc.b #>pat1
	dc.b #>pat2
	dc.b #>pat3
	dc.b #>pat4
	dc.b #>pat5
	dc.b #>pat6
	dc.b #>pat7

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $01,$9C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_setinstrument $02,$01
	kp_settrackregister $01,$AC
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$AC
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$90
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$AC
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$AC
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$AC
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$98
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$0C
	kp_settrackregister $01,$00
	kp_setinstrument $0C,$02
	kp_setinstrument $08,$02
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $00,$0C
	kp_settrackregister $01,$0C
	kp_settrackregister $03,$0F
	kp_setinstrument $0C,$02
	kp_setinstrument $08,$02
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $00,$0C
	kp_settrackregister $01,$1C
	kp_setinstrument $0C,$02
	kp_settrackregister $01,$28
	kp_setinstrument $08,$02
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$03
	kp_setinstrument $04,$04
	kp_setinstrument $04,$05
	kp_setinstrument $02,$04
	kp_setinstrument $04,$03
	kp_setinstrument $04,$04
	kp_setinstrument $02,$04
	kp_setinstrument $04,$05
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$03
	kp_setinstrument $02,$04
	kp_setinstrument $04,$03
	kp_setinstrument $04,$05
	kp_setinstrument $02,$04
	kp_setinstrument $04,$03
	kp_setinstrument $02,$03
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$05
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_rewind [pat7loop-pat7]

kp_insmap_lo
	dc.b #<insnil
	dc.b #<ins1
	dc.b #<ins2
	dc.b #<ins3
	dc.b #<ins4
	dc.b #<ins5

kp_insmap_hi
	dc.b #>insnil
	dc.b #>ins1
	dc.b #>ins2
	dc.b #>ins3
	dc.b #>ins4
	dc.b #>ins5

kp_volmap_lo
	dc.b #<volnil
	dc.b #<vol1
	dc.b #<vol2
	dc.b #<vol3
	dc.b #<vol4
	dc.b #<vol5

kp_volmap_hi
	dc.b #>volnil
	dc.b #>vol1
	dc.b #>vol2
	dc.b #>vol3
	dc.b #>vol4
	dc.b #>vol5

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
	KP_OSCV $60,0,1,1,$00
ins1loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $0A,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$01
vol1loop
	KP_VOLV $00,$00
	KP_VOLJ [vol1loop-vol1]
ins2
ins2loop
	KP_OSCV $00,0,1,1,$03
	KP_OSCV $01,0,1,1,$03
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $07,$04
	KP_VOLV $08,$00
	KP_VOLV $09,$02
	KP_VOLV $08,$01
	KP_VOLV $07,$01
	KP_VOLV $06,$09
	KP_VOLV $05,$0F
	KP_VOLV $05,$02
	KP_VOLV $04,$09
	KP_VOLV $03,$08
	KP_VOLV $02,$08
	KP_VOLV $01,$04
vol2loop
	KP_VOLV $00,$00
	KP_VOLJ [vol2loop-vol2]
ins3
	KP_OSCV $18,0,1,0,$00
	KP_OSCV $0E,0,1,0,$00
	KP_OSCV $0A,0,1,0,$00
	KP_OSCV $05,0,1,0,$00
ins3loop
	KP_OSCV $00,0,1,0,$00
	KP_OSCV $00,1,0,0,$00
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
vol3loop
	KP_VOLV $00,$00
	KP_VOLJ [vol3loop-vol3]
ins4
	KP_OSCV $F9,1,0,0,$00
ins4loop
	KP_OSCV $F2,1,0,0,$00
	KP_OSCV $99,1,0,0,$00
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $07,$00
	KP_VOLV $0D,$00
vol4loop
	KP_VOLV $00,$00
	KP_VOLJ [vol4loop-vol4]
ins5
	KP_OSCV $EF,1,0,0,$00
	KP_OSCV $40,0,1,0,$00
	KP_OSCV $38,0,1,0,$00
ins5loop
	KP_OSCV $F2,1,0,0,$00
	KP_OSCV $F7,1,0,0,$00
	KP_OSCV $F4,1,0,0,$00
	KP_OSCV $F1,1,0,0,$00
	KP_OSCJ [ins5loop-ins5]

vol5
	KP_VOLV $0F,$00
	KP_VOLV $0D,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
vol5loop
	KP_VOLV $00,$00
	KP_VOLJ [vol5loop-vol5]

kp_sequence
	dc.b $00,$01,$00,$00
	dc.b $00,$01,$00,$00
	dc.b $00,$01,$00,$00
	dc.b $00,$02,$00,$00
	dc.b $00,$01,$03,$00
	dc.b $00,$01,$03,$00
	dc.b $00,$01,$04,$00
	dc.b $00,$02,$05,$00
	dc.b $00,$01,$03,$06
	dc.b $00,$01,$03,$07
	dc.b $00,$01,$04,$06
	dc.b $00,$02,$05,$07
	dc.b $00,$01,$03,$06
	dc.b $00,$01,$03,$07
	dc.b $00,$01,$04,$06
	dc.b $00,$02,$05,$07
	dc.b $00,$01,$00,$06
	dc.b $00,$02,$00,$06
	dc.b $00,$01,$00,$06
	dc.b $00,$02,$00,$07
	dc.b $00,$01,$00,$06
	dc.b $00,$02,$00,$06
	dc.b $00,$01,$00,$06
	dc.b $00,$02,$00,$07
	dc.b $ff
	dc.w $0040

