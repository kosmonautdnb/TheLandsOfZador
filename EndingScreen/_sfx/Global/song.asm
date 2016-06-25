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
	dc.b $04
	dc.b $06
	dc.b $09
	dc.b $05
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

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$01
	kp_setinstrument $04,$02
	kp_setinstrument $02,$03
	kp_settrackregister $03,$08
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_setinstrument $02,$02
	kp_setinstrument $04,$01
	kp_setinstrument $02,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$03
	kp_settrackregister $03,$08
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_setinstrument $02,$02
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $06,$04
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $01,$20
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$00
	kp_settrackregister $00,$04
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$04
	kp_settrackregister $01,$08
	kp_setinstrument $02,$04
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $01,$20
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$00
	kp_settrackregister $00,$04
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$01
	kp_setinstrument $04,$02
	kp_setinstrument $02,$03
	kp_settrackregister $03,$08
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_setinstrument $02,$02
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0E
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$03
	kp_setinstrument $04,$06
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $06,$04
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $01,$20
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$00
	kp_settrackregister $00,$04
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$04
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0A
	kp_setinstrument $01,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$05
	kp_settrackregister $01,$08
	kp_setinstrument $01,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$02
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$01
	kp_setinstrument $04,$02
	kp_setinstrument $04,$03
	kp_setinstrument $02,$02
	kp_setinstrument $02,$02
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0E
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$03
	kp_setinstrument $04,$06
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $06,$04
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $01,$20
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$00
	kp_settrackregister $00,$04
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$04
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0A
	kp_setinstrument $01,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$05
	kp_settrackregister $01,$08
	kp_setinstrument $04,$04
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$04
	kp_settrackregister $01,$40
	kp_setinstrument $04,$07
	kp_settrackregister $01,$70
	kp_setinstrument $04,$07
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$68
	kp_setinstrument $04,$07
	kp_settrackregister $01,$54
	kp_setinstrument $02,$07
	kp_settrackregister $01,$60
	kp_setinstrument $04,$07
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$07
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$08
	kp_rewind [pat7loop-pat7]
pat8
pat8loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$40
	kp_setinstrument $04,$07
	kp_settrackregister $01,$68
	kp_setinstrument $04,$07
	kp_settrackregister $01,$60
	kp_setinstrument $04,$08
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$07
	kp_settrackregister $01,$54
	kp_setinstrument $02,$07
	kp_settrackregister $01,$60
	kp_setinstrument $04,$07
	kp_settrackregister $01,$54
	kp_setinstrument $02,$07
	kp_settrackregister $01,$44
	kp_setinstrument $04,$08
	kp_rewind [pat8loop-pat8]
pat9
pat9loop
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$04
	kp_settrackregister $01,$40
	kp_setinstrument $04,$07
	kp_settrackregister $01,$70
	kp_setinstrument $04,$07
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$68
	kp_setinstrument $04,$07
	kp_settrackregister $01,$54
	kp_setinstrument $02,$07
	kp_settrackregister $01,$60
	kp_setinstrument $04,$07
	kp_settrackregister $01,$68
	kp_setinstrument $02,$07
	kp_settrackregister $01,$70
	kp_setinstrument $04,$09
	kp_rewind [pat9loop-pat9]
pat10
pat10loop
	kp_settrackregister $00,$02
	kp_settrackregister $01,$68
	kp_settrackregister $03,$08
	kp_setinstrument $01,$0A
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$0A
	kp_settrackregister $01,$70
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$08
	kp_settrackregister $01,$68
	kp_setinstrument $04,$07
	kp_settrackregister $01,$60
	kp_setinstrument $04,$08
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$07
	kp_settrackregister $01,$60
	kp_setinstrument $02,$07
	kp_settrackregister $01,$54
	kp_setinstrument $04,$07
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$07
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$09
	kp_rewind [pat10loop-pat10]
pat11
pat11loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$07
	kp_settrackregister $01,$74
	kp_setinstrument $04,$08
	kp_settrackregister $01,$70
	kp_setinstrument $0C,$09
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0C
	kp_setinstrument $04,$09
	kp_rewind [pat11loop-pat11]
pat12
pat12loop
	kp_settrackregister $01,$24
	kp_settrackregister $03,$0F
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $01,$34
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$00
	kp_settrackregister $00,$04
	kp_settrackregister $01,$24
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$04
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $01,$20
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$00
	kp_settrackregister $00,$04
	kp_rewind [pat12loop-pat12]
pat13
pat13loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_settrackregister $01,$74
	kp_setinstrument $04,$07
	kp_settrackregister $01,$6C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$68
	kp_setinstrument $0C,$09
	kp_settrackregister $01,$38
	kp_setinstrument $04,$09
	kp_rewind [pat13loop-pat13]
pat14
pat14loop
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $01,$2C
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$00
	kp_settrackregister $00,$04
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$04
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0A
	kp_setinstrument $01,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$05
	kp_settrackregister $01,$20
	kp_setinstrument $01,$04
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$02
	kp_rewind [pat14loop-pat14]
pat15
pat15loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$40
	kp_setinstrument $04,$07
	kp_settrackregister $01,$68
	kp_setinstrument $04,$07
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$50
	kp_setinstrument $04,$07
	kp_settrackregister $01,$54
	kp_setinstrument $02,$07
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$07
	kp_settrackregister $01,$70
	kp_setinstrument $02,$07
	kp_settrackregister $01,$74
	kp_setinstrument $04,$09
	kp_rewind [pat15loop-pat15]
pat16
pat16loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$40
	kp_setinstrument $04,$07
	kp_settrackregister $01,$68
	kp_setinstrument $04,$07
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$50
	kp_setinstrument $04,$07
	kp_settrackregister $01,$54
	kp_setinstrument $02,$07
	kp_settrackregister $01,$44
	kp_setinstrument $04,$07
	kp_settrackregister $01,$50
	kp_setinstrument $02,$07
	kp_settrackregister $01,$40
	kp_setinstrument $04,$09
	kp_rewind [pat16loop-pat16]
pat17
pat17loop
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$01
	kp_setinstrument $04,$02
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_setinstrument $10,$03
	kp_rewind [pat17loop-pat17]
pat18
pat18loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $06,$04
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $01,$20
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$00
	kp_settrackregister $00,$04
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $08,$04
	kp_settrackregister $01,$00
	kp_setinstrument $05,$0B
	kp_settrackregister $01,$04
	kp_settrackregister $00,$01
	kp_settrackregister $01,$08
	kp_settrackregister $00,$01
	kp_settrackregister $01,$0C
	kp_settrackregister $00,$01
	kp_rewind [pat18loop-pat18]

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

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
	KP_OSCV $1A,0,1,0,$00
	KP_OSCV $10,0,1,0,$00
	KP_OSCV $06,0,1,0,$00
	KP_OSCV $01,0,1,0,$00
ins1loop
	KP_OSCV $00,0,1,0,$00
	KP_OSCV $00,0,0,0,$00
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $0E,$00
	KP_VOLV $0F,$00
	KP_VOLV $0A,$00
	KP_VOLV $06,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$01
vol1loop
	KP_VOLV $00,$00
	KP_VOLJ [vol1loop-vol1]
ins2
	KP_OSCV $FC,1,0,0,$00
ins2loop
	KP_OSCV $FA,1,0,0,$00
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $0A,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$01
vol2loop
	KP_VOLV $00,$00
	KP_VOLJ [vol2loop-vol2]
ins3
	KP_OSCV $40,0,1,0,$00
	KP_OSCV $F2,1,0,0,$00
ins3loop
	KP_OSCV $F7,1,0,0,$00
	KP_OSCV $FA,1,0,0,$00
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $0E,$00
	KP_VOLV $0B,$00
	KP_VOLV $08,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$02
vol3loop
	KP_VOLV $00,$00
	KP_VOLJ [vol3loop-vol3]
ins4
ins4loop
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $01,0,1,1,$01
	KP_OSCV $02,0,1,1,$01
	KP_OSCV $01,0,1,1,$01
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $08,$01
	KP_VOLV $0A,$03
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$02
vol4loop
	KP_VOLV $00,$00
	KP_VOLJ [vol4loop-vol4]
ins5
ins5loop
	KP_OSCV $30,0,1,1,$02
	KP_OSCV $40,0,1,1,$02
	KP_OSCV $4C,0,1,1,$02
	KP_OSCV $60,0,1,1,$02
	KP_OSCJ [ins5loop-ins5]

vol5
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$02
	KP_VOLV $01,$02
vol5loop
	KP_VOLV $00,$00
	KP_VOLJ [vol5loop-vol5]
ins6
	KP_OSCV $48,0,1,0,$00
	KP_OSCV $F2,1,0,0,$00
ins6loop
	KP_OSCV $F9,1,0,0,$00
	KP_OSCV $F2,1,0,0,$00
	KP_OSCJ [ins6loop-ins6]

vol6
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $07,$00
	KP_VOLV $05,$00
vol6loop
	KP_VOLV $04,$01
	KP_VOLJ [vol6loop-vol6]
ins7
	KP_OSCV $00,0,1,1,$01
ins7loop
	KP_OSCV $30,0,1,1,$00
	KP_OSCJ [ins7loop-ins7]

vol7
	KP_VOLV $0B,$03
	KP_VOLV $08,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$03
vol7loop
	KP_VOLV $00,$00
	KP_VOLJ [vol7loop-vol7]
ins8
	KP_OSCV $00,0,1,1,$00
ins8loop
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $31,0,1,1,$01
	KP_OSCJ [ins8loop-ins8]

vol8
	KP_VOLV $0B,$00
	KP_VOLV $09,$02
	KP_VOLV $08,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$07
	KP_VOLV $03,$00
vol8loop
	KP_VOLV $00,$00
	KP_VOLJ [vol8loop-vol8]
ins9
	KP_OSCV $00,0,1,1,$00
ins9loop
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $31,0,1,1,$01
	KP_OSCJ [ins9loop-ins9]

vol9
	KP_VOLV $0B,$00
	KP_VOLV $09,$02
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $05,$01
	KP_VOLV $06,$00
	KP_VOLV $07,$04
	KP_VOLV $06,$01
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$04
vol9loop
	KP_VOLV $00,$00
	KP_VOLJ [vol9loop-vol9]
ins10
ins10loop
	KP_OSCV $30,0,1,1,$00
	KP_OSCJ [ins10loop-ins10]

vol10
	KP_VOLV $0B,$00
	KP_VOLV $09,$02
	KP_VOLV $08,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$07
	KP_VOLV $03,$00
vol10loop
	KP_VOLV $00,$00
	KP_VOLJ [vol10loop-vol10]
ins11
ins11loop
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $01,0,1,1,$01
	KP_OSCV $02,0,1,1,$01
	KP_OSCV $01,0,1,1,$01
	KP_OSCJ [ins11loop-ins11]

vol11
	KP_VOLV $08,$01
	KP_VOLV $0A,$03
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
vol11loop
	KP_VOLV $04,$00
	KP_VOLJ [vol11loop-vol11]

kp_sequence
	dc.b $00,$00,$01,$02
	dc.b $00,$00,$03,$04
	dc.b $00,$00,$01,$02
	dc.b $00,$00,$03,$04
	dc.b $00,$00,$01,$02
	dc.b $00,$00,$03,$04
	dc.b $00,$00,$01,$02
	dc.b $00,$00,$05,$06
	dc.b $00,$07,$01,$02
	dc.b $00,$00,$03,$04
	dc.b $00,$08,$01,$02
	dc.b $00,$00,$03,$04
	dc.b $00,$09,$01,$02
	dc.b $00,$00,$03,$04
	dc.b $00,$0A,$01,$02
	dc.b $00,$00,$05,$06
	dc.b $00,$0B,$01,$0C
	dc.b $00,$0D,$03,$0E
	dc.b $00,$0F,$01,$02
	dc.b $00,$00,$03,$06
	dc.b $00,$0B,$01,$0C
	dc.b $00,$0D,$03,$0E
	dc.b $00,$10,$01,$02
	dc.b $00,$00,$11,$12
	dc.b $00,$00,$01,$02
	dc.b $00,$00,$03,$04
	dc.b $00,$00,$01,$02
	dc.b $00,$00,$03,$04
	dc.b $ff
	dc.w $0050

