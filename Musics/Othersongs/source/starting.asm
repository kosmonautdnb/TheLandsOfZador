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
	dc.b $04
kp_groovebox
	dc.b $05
	dc.b $05
	dc.b $06
	dc.b $04
	dc.b $05
	dc.b $04
	dc.b $06
	dc.b $04
kp_patternlen
	dc.b $3F

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

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $01,$8C
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $01,$80
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $01,$70
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$14
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$06
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$08
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $01,$14
	kp_settrackregister $03,$0F
	kp_setinstrument $08,$03
	kp_settrackregister $01,$C0
	kp_settrackregister $03,$0B
	kp_setinstrument $04,$04
	kp_settrackregister $01,$14
	kp_settrackregister $03,$0F
	kp_setinstrument $08,$03
	kp_settrackregister $01,$C0
	kp_settrackregister $03,$0B
	kp_setinstrument $20,$04
	kp_settrackregister $00,$04
	kp_settrackregister $01,$14
	kp_settrackregister $03,$0F
	kp_setinstrument $08,$03
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $01,$90
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$14
	kp_settrackregister $01,$84
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$06
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$08
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $01,$8C
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $01,$80
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $01,$84
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$14
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$06
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $01,$80
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $03,$08
	kp_settrackregister $00,$20
	kp_settrackregister $00,$14
	kp_rewind [pat7loop-pat7]
pat8
pat8loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_rewind [pat8loop-pat8]

kp_insmap_lo
	dc.b #<insnil
	dc.b #<ins1
	dc.b #<ins2
	dc.b #<ins3
	dc.b #<ins4

kp_insmap_hi
	dc.b #>insnil
	dc.b #>ins1
	dc.b #>ins2
	dc.b #>ins3
	dc.b #>ins4

kp_volmap_lo
	dc.b #<volnil
	dc.b #<vol1
	dc.b #<vol2
	dc.b #<vol3
	dc.b #<vol4

kp_volmap_hi
	dc.b #>volnil
	dc.b #>vol1
	dc.b #>vol2
	dc.b #>vol3
	dc.b #>vol4

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$00
ins1loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $08,$00
vol1loop
	KP_VOLV $07,$00
	KP_VOLJ [vol1loop-vol1]
ins2
	KP_OSCV $00,0,1,1,$05
ins2loop
	KP_OSCV $00,0,1,1,$03
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $08,$02
	KP_VOLV $07,$01
	KP_VOLV $06,$00
vol2loop
	KP_VOLV $03,$00
	KP_VOLJ [vol2loop-vol2]
ins3
	KP_OSCV $28,0,1,0,$00
	KP_OSCV $0C,0,1,0,$00
ins3loop
	KP_OSCV $00,0,1,0,$00
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0C,$00
	KP_VOLV $08,$00
	KP_VOLV $02,$01
	KP_VOLV $01,$01
vol3loop
	KP_VOLV $00,$00
	KP_VOLJ [vol3loop-vol3]
ins4
	KP_OSCV $FC,1,0,1,$00
ins4loop
	KP_OSCV $FB,1,0,1,$00
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $0C,$00
	KP_VOLV $05,$00
vol4loop
	KP_VOLV $00,$00
	KP_VOLJ [vol4loop-vol4]

kp_sequence
	dc.b $00,$01,$02,$03
	dc.b $00,$04,$05,$03
	dc.b $00,$06,$02,$03
	dc.b $00,$04,$05,$03
	dc.b $00,$07,$08,$03
	dc.b $00,$00,$08,$03
	dc.b $ff
	dc.w $0004

