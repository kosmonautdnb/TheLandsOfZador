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
	dc.b $03
	dc.b $04
	dc.b $04
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

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0F
	kp_setinstrument $20,$01
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $10,$02
	kp_setinstrument $10,$02
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $01,$4C
	kp_setinstrument $20,$03
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $01,$16
	kp_setinstrument $01,$02
	kp_settrackregister $01,$19
	kp_settrackregister $00,$01
	kp_settrackregister $01,$1C
	kp_settrackregister $00,$0E
	kp_setinstrument $10,$02
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $01,$68
	kp_setinstrument $20,$01
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $01,$0E
	kp_setinstrument $01,$02
	kp_settrackregister $01,$0B
	kp_settrackregister $00,$01
	kp_settrackregister $01,$08
	kp_settrackregister $00,$0E
	kp_setinstrument $10,$02
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $01,$5C
	kp_setinstrument $20,$03
	kp_rewind [pat7loop-pat7]
pat8
pat8loop
	kp_settrackregister $01,$28
	kp_setinstrument $01,$04
	kp_settrackregister $01,$2A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$2C
	kp_settrackregister $00,$0E
	kp_setinstrument $10,$04
	kp_rewind [pat8loop-pat8]
pat9
pat9loop
	kp_settrackregister $01,$48
	kp_setinstrument $20,$05
	kp_rewind [pat9loop-pat9]
pat10
pat10loop
	kp_settrackregister $01,$12
	kp_setinstrument $01,$02
	kp_settrackregister $01,$15
	kp_settrackregister $00,$01
	kp_settrackregister $01,$18
	kp_settrackregister $00,$0E
	kp_setinstrument $10,$04
	kp_rewind [pat10loop-pat10]
pat11
pat11loop
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0F
	kp_setinstrument $20,$03
	kp_rewind [pat11loop-pat11]
pat12
pat12loop
	kp_settrackregister $01,$20
	kp_setinstrument $01,$04
	kp_settrackregister $01,$22
	kp_settrackregister $00,$01
	kp_settrackregister $01,$24
	kp_settrackregister $00,$0E
	kp_setinstrument $10,$04
	kp_rewind [pat12loop-pat12]
pat13
pat13loop
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$06
	kp_settrackregister $01,$40
	kp_settrackregister $00,$04
	kp_settrackregister $01,$30
	kp_settrackregister $00,$04
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$40
	kp_settrackregister $00,$04
	kp_settrackregister $01,$30
	kp_settrackregister $00,$04
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$40
	kp_settrackregister $00,$04
	kp_rewind [pat13loop-pat13]
pat14
pat14loop
	kp_settrackregister $01,$3C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$58
	kp_settrackregister $00,$04
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$3C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$58
	kp_settrackregister $00,$04
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$3C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$58
	kp_settrackregister $00,$04
	kp_rewind [pat14loop-pat14]
pat15
pat15loop
	kp_settrackregister $01,$54
	kp_setinstrument $04,$06
	kp_settrackregister $01,$48
	kp_settrackregister $00,$04
	kp_settrackregister $01,$38
	kp_settrackregister $00,$04
	kp_settrackregister $01,$54
	kp_settrackregister $00,$04
	kp_settrackregister $01,$48
	kp_settrackregister $00,$04
	kp_settrackregister $01,$38
	kp_settrackregister $00,$04
	kp_settrackregister $01,$54
	kp_settrackregister $00,$04
	kp_settrackregister $01,$48
	kp_settrackregister $00,$04
	kp_rewind [pat15loop-pat15]
pat16
pat16loop
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$68
	kp_settrackregister $00,$04
	kp_settrackregister $01,$5C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$68
	kp_settrackregister $00,$04
	kp_settrackregister $01,$5C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$04
	kp_settrackregister $01,$68
	kp_settrackregister $00,$04
	kp_rewind [pat16loop-pat16]
pat17
pat17loop
	kp_settrackregister $01,$64
	kp_setinstrument $04,$06
	kp_settrackregister $01,$54
	kp_settrackregister $00,$04
	kp_settrackregister $01,$48
	kp_settrackregister $00,$04
	kp_settrackregister $01,$64
	kp_settrackregister $00,$04
	kp_settrackregister $01,$54
	kp_settrackregister $00,$04
	kp_settrackregister $01,$48
	kp_settrackregister $00,$04
	kp_settrackregister $01,$64
	kp_settrackregister $00,$04
	kp_settrackregister $01,$54
	kp_settrackregister $00,$04
	kp_rewind [pat17loop-pat17]
pat18
pat18loop
	kp_settrackregister $01,$44
	kp_settrackregister $00,$04
	kp_settrackregister $01,$60
	kp_settrackregister $00,$04
	kp_settrackregister $01,$54
	kp_settrackregister $00,$04
	kp_settrackregister $01,$44
	kp_settrackregister $00,$04
	kp_settrackregister $01,$60
	kp_settrackregister $00,$04
	kp_settrackregister $01,$54
	kp_settrackregister $00,$04
	kp_settrackregister $01,$44
	kp_settrackregister $00,$04
	kp_settrackregister $01,$60
	kp_settrackregister $00,$04
	kp_rewind [pat18loop-pat18]
pat19
pat19loop
	kp_settrackregister $01,$30
	kp_setinstrument $08,$07
	kp_settrackregister $01,$18
	kp_setinstrument $01,$04
	kp_settrackregister $01,$1A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$1C
	kp_settrackregister $00,$04
	kp_setinstrument $02,$08
	kp_settrackregister $01,$18
	kp_setinstrument $01,$02
	kp_settrackregister $01,$1A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$1C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$14
	kp_setinstrument $04,$02
	kp_settrackregister $01,$10
	kp_setinstrument $04,$04
	kp_settrackregister $01,$08
	kp_setinstrument $04,$02
	kp_rewind [pat19loop-pat19]
pat20
pat20loop
	kp_settrackregister $01,$08
	kp_setinstrument $01,$02
	kp_settrackregister $01,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$0C
	kp_settrackregister $00,$04
	kp_setinstrument $02,$02
	kp_setinstrument $02,$08
	kp_setinstrument $02,$08
	kp_setinstrument $04,$02
	kp_settrackregister $01,$28
	kp_setinstrument $08,$04
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$04
	kp_setinstrument $04,$09
	kp_rewind [pat20loop-pat20]
pat21
pat21loop
	kp_settrackregister $01,$38
	kp_setinstrument $08,$07
	kp_settrackregister $01,$22
	kp_setinstrument $02,$04
	kp_settrackregister $01,$24
	kp_settrackregister $00,$04
	kp_setinstrument $02,$08
	kp_settrackregister $01,$20
	kp_setinstrument $01,$02
	kp_settrackregister $01,$22
	kp_settrackregister $00,$01
	kp_settrackregister $01,$24
	kp_settrackregister $00,$02
	kp_settrackregister $01,$18
	kp_setinstrument $04,$02
	kp_settrackregister $01,$10
	kp_setinstrument $04,$04
	kp_settrackregister $01,$08
	kp_setinstrument $04,$02
	kp_rewind [pat21loop-pat21]
pat22
pat22loop
	kp_settrackregister $01,$18
	kp_setinstrument $01,$02
	kp_settrackregister $01,$1A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$1C
	kp_settrackregister $00,$04
	kp_setinstrument $02,$02
	kp_setinstrument $02,$08
	kp_setinstrument $02,$08
	kp_setinstrument $04,$02
	kp_settrackregister $01,$38
	kp_setinstrument $08,$04
	kp_settrackregister $01,$2C
	kp_setinstrument $04,$04
	kp_setinstrument $04,$09
	kp_rewind [pat22loop-pat22]
pat23
pat23loop
	kp_settrackregister $01,$48
	kp_setinstrument $08,$0A
	kp_settrackregister $01,$30
	kp_setinstrument $01,$04
	kp_settrackregister $01,$32
	kp_settrackregister $00,$01
	kp_settrackregister $01,$34
	kp_settrackregister $00,$04
	kp_setinstrument $02,$08
	kp_settrackregister $01,$30
	kp_setinstrument $01,$02
	kp_settrackregister $01,$32
	kp_settrackregister $00,$01
	kp_settrackregister $01,$34
	kp_settrackregister $00,$02
	kp_settrackregister $01,$24
	kp_setinstrument $04,$02
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$04
	kp_settrackregister $01,$18
	kp_setinstrument $04,$02
	kp_rewind [pat23loop-pat23]
pat24
pat24loop
	kp_settrackregister $01,$10
	kp_setinstrument $01,$02
	kp_settrackregister $01,$12
	kp_settrackregister $00,$01
	kp_settrackregister $01,$14
	kp_settrackregister $00,$04
	kp_setinstrument $02,$02
	kp_setinstrument $02,$08
	kp_setinstrument $02,$08
	kp_setinstrument $04,$09
	kp_settrackregister $01,$30
	kp_setinstrument $08,$04
	kp_settrackregister $01,$24
	kp_setinstrument $04,$04
	kp_setinstrument $02,$09
	kp_setinstrument $02,$09
	kp_rewind [pat24loop-pat24]
pat25
pat25loop
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$06
	kp_settrackregister $01,$60
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$40
	kp_setinstrument $02,$06
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$30
	kp_setinstrument $02,$06
	kp_settrackregister $01,$70
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$60
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$70
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$06
	kp_settrackregister $01,$60
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$40
	kp_setinstrument $02,$06
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$60
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$70
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0B
	kp_rewind [pat25loop-pat25]
pat26
pat26loop
	kp_settrackregister $01,$3C
	kp_setinstrument $02,$06
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$88
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$06
	kp_settrackregister $01,$88
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$58
	kp_setinstrument $02,$06
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$88
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$3C
	kp_setinstrument $02,$06
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$88
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$0B
	kp_rewind [pat26loop-pat26]
pat27
pat27loop
	kp_settrackregister $01,$54
	kp_setinstrument $02,$06
	kp_settrackregister $01,$68
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$48
	kp_setinstrument $02,$06
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$38
	kp_setinstrument $02,$06
	kp_settrackregister $01,$78
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$68
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$78
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$54
	kp_setinstrument $02,$06
	kp_settrackregister $01,$68
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$48
	kp_setinstrument $02,$06
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$68
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$78
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0B
	kp_rewind [pat27loop-pat27]
pat28
pat28loop
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$06
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$98
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$06
	kp_settrackregister $01,$98
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$68
	kp_setinstrument $02,$06
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$98
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$06
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$98
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$0B
	kp_rewind [pat28loop-pat28]
pat29
pat29loop
	kp_settrackregister $01,$64
	kp_setinstrument $02,$06
	kp_settrackregister $01,$78
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$54
	kp_setinstrument $02,$06
	kp_settrackregister $01,$94
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$48
	kp_setinstrument $02,$06
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$94
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$78
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$64
	kp_setinstrument $02,$06
	kp_settrackregister $01,$78
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$54
	kp_setinstrument $02,$06
	kp_settrackregister $01,$94
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$78
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$94
	kp_setinstrument $02,$0B
	kp_rewind [pat29loop-pat29]
pat30
pat30loop
	kp_settrackregister $01,$44
	kp_setinstrument $02,$06
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$90
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$74
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$54
	kp_setinstrument $02,$06
	kp_settrackregister $01,$90
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$74
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$60
	kp_setinstrument $02,$06
	kp_settrackregister $01,$74
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$90
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$44
	kp_setinstrument $02,$06
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$90
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$74
	kp_setinstrument $02,$0B
	kp_rewind [pat30loop-pat30]
pat31
pat31loop
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$06
	kp_settrackregister $01,$74
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$90
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$44
	kp_setinstrument $02,$06
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$90
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$74
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$06
	kp_settrackregister $01,$74
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$90
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$44
	kp_setinstrument $02,$06
	kp_settrackregister $01,$84
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$90
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$74
	kp_setinstrument $02,$0B
	kp_rewind [pat31loop-pat31]
pat32
pat32loop
	kp_settrackregister $01,$60
	kp_setinstrument $20,$0D
	kp_rewind [pat32loop-pat32]
pat33
pat33loop
	kp_settrackregister $01,$00
	kp_setinstrument $20,$0E
	kp_rewind [pat33loop-pat33]
pat34
pat34loop
	kp_settrackregister $03,$0E
	kp_settrackregister $00,$08
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$08
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$08
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$04
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0E
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$01
	kp_rewind [pat34loop-pat34]
pat35
pat35loop
	kp_settrackregister $01,$5A
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$5D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$60
	kp_settrackregister $00,$06
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$04
	kp_setinstrument $08,$10
	kp_settrackregister $01,$44
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$54
	kp_settrackregister $00,$03
	kp_settrackregister $01,$6C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$6E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$70
	kp_settrackregister $00,$03
	kp_rewind [pat35loop-pat35]
pat36
pat36loop
	kp_settrackregister $01,$62
	kp_settrackregister $00,$01
	kp_settrackregister $01,$65
	kp_settrackregister $00,$01
	kp_settrackregister $01,$68
	kp_settrackregister $00,$06
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$04
	kp_setinstrument $08,$10
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0F
	kp_setinstrument $03,$0F
	kp_settrackregister $01,$66
	kp_settrackregister $00,$02
	kp_settrackregister $01,$68
	kp_settrackregister $00,$02
	kp_settrackregister $01,$72
	kp_settrackregister $00,$01
	kp_settrackregister $01,$73
	kp_settrackregister $00,$01
	kp_settrackregister $01,$74
	kp_settrackregister $00,$03
	kp_rewind [pat36loop-pat36]
pat37
pat37loop
	kp_settrackregister $01,$72
	kp_settrackregister $00,$01
	kp_settrackregister $01,$70
	kp_settrackregister $00,$03
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$04
	kp_setinstrument $08,$10
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$68
	kp_settrackregister $00,$04
	kp_settrackregister $01,$70
	kp_settrackregister $00,$04
	kp_settrackregister $01,$7C
	kp_settrackregister $00,$04
	kp_rewind [pat37loop-pat37]
pat38
pat38loop
	kp_settrackregister $01,$84
	kp_settrackregister $00,$04
	kp_settrackregister $03,$0C
	kp_setinstrument $04,$10
	kp_settrackregister $01,$78
	kp_settrackregister $03,$0E
	kp_setinstrument $04,$0F
	kp_settrackregister $03,$0C
	kp_setinstrument $04,$10
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$0F
	kp_settrackregister $03,$0C
	kp_setinstrument $04,$10
	kp_settrackregister $01,$54
	kp_setinstrument $04,$0F
	kp_setinstrument $02,$10
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_rewind [pat38loop-pat38]
pat39
pat39loop
	kp_settrackregister $01,$58
	kp_settrackregister $03,$0F
	kp_setinstrument $08,$0F
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$04
	kp_setinstrument $02,$10
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$54
	kp_settrackregister $00,$04
	kp_settrackregister $01,$58
	kp_settrackregister $00,$04
	kp_settrackregister $01,$68
	kp_settrackregister $00,$04
	kp_rewind [pat39loop-pat39]
pat40
pat40loop
	kp_settrackregister $01,$60
	kp_settrackregister $00,$04
	kp_settrackregister $01,$44
	kp_setinstrument $02,$07
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$07
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $01,$70
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$10
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $01,$50
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$0A
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $01,$74
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$10
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$0A
	kp_rewind [pat40loop-pat40]
pat41
pat41loop
	kp_settrackregister $01,$40
	kp_setinstrument $20,$11
	kp_rewind [pat41loop-pat41]
pat42
pat42loop
	kp_settrackregister $01,$30
	kp_setinstrument $20,$0D
	kp_rewind [pat42loop-pat42]
pat43
pat43loop
	kp_settrackregister $01,$00
	kp_setinstrument $02,$12
	kp_settrackregister $01,$02
	kp_settrackregister $00,$02
	kp_settrackregister $01,$04
	kp_settrackregister $00,$02
	kp_settrackregister $01,$06
	kp_settrackregister $00,$02
	kp_settrackregister $01,$08
	kp_settrackregister $03,$0E
	kp_settrackregister $00,$02
	kp_settrackregister $01,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$0C
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $01,$0E
	kp_settrackregister $00,$02
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$12
	kp_settrackregister $00,$02
	kp_settrackregister $01,$14
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $01,$16
	kp_settrackregister $00,$02
	kp_settrackregister $01,$18
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$1A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $01,$1E
	kp_settrackregister $00,$02
	kp_rewind [pat43loop-pat43]
pat44
pat44loop
	kp_settrackregister $01,$00
	kp_setinstrument $0C,$0E
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$05
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$03
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$08
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_rewind [pat44loop-pat44]
pat45
pat45loop
	kp_settrackregister $03,$08
	kp_settrackregister $00,$04
	kp_settrackregister $03,$07
	kp_settrackregister $00,$04
	kp_settrackregister $03,$06
	kp_settrackregister $00,$04
	kp_settrackregister $03,$05
	kp_settrackregister $00,$04
	kp_settrackregister $03,$04
	kp_settrackregister $00,$04
	kp_settrackregister $03,$03
	kp_settrackregister $00,$04
	kp_settrackregister $03,$02
	kp_settrackregister $00,$04
	kp_settrackregister $03,$01
	kp_settrackregister $00,$04
	kp_rewind [pat45loop-pat45]

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

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
ins1loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$01
	KP_OSCV $40,0,1,1,$00
	KP_OSCV $4C,0,1,1,$00
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $03,$07
	KP_VOLV $04,$07
	KP_VOLV $05,$07
	KP_VOLV $06,$07
	KP_VOLV $07,$07
	KP_VOLV $08,$07
	KP_VOLV $09,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$03
	KP_VOLV $09,$07
	KP_VOLV $08,$07
	KP_VOLV $07,$07
	KP_VOLV $06,$07
	KP_VOLV $05,$07
	KP_VOLV $04,$07
vol1loop
	KP_VOLV $03,$00
	KP_VOLJ [vol1loop-vol1]
ins2
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $34,0,1,0,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
ins2loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $0C,$00
	KP_VOLV $08,$00
	KP_VOLV $0C,$07
	KP_VOLV $0C,$02
	KP_VOLV $0B,$01
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
vol2loop
	KP_VOLV $07,$00
	KP_VOLJ [vol2loop-vol2]
ins3
ins3loop
	KP_OSCV $20,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$01
	KP_OSCV $3C,0,1,1,$00
	KP_OSCV $50,0,1,1,$00
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $03,$07
	KP_VOLV $04,$07
	KP_VOLV $05,$07
	KP_VOLV $06,$07
	KP_VOLV $07,$07
	KP_VOLV $08,$07
	KP_VOLV $09,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$03
	KP_VOLV $09,$07
	KP_VOLV $08,$07
	KP_VOLV $07,$07
	KP_VOLV $06,$07
	KP_VOLV $05,$07
	KP_VOLV $04,$07
vol3loop
	KP_VOLV $03,$00
	KP_VOLJ [vol3loop-vol3]
ins4
	KP_OSCV $A2,1,0,0,$00
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
ins4loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $0C,$00
	KP_VOLV $08,$00
	KP_VOLV $0C,$07
	KP_VOLV $0C,$02
	KP_VOLV $0B,$01
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
vol4loop
	KP_VOLV $07,$00
	KP_VOLJ [vol4loop-vol4]
ins5
ins5loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$01
	KP_OSCV $3C,0,1,1,$00
	KP_OSCV $4C,0,1,1,$00
	KP_OSCJ [ins5loop-ins5]

vol5
	KP_VOLV $03,$07
	KP_VOLV $04,$07
	KP_VOLV $05,$07
	KP_VOLV $06,$07
	KP_VOLV $07,$07
	KP_VOLV $08,$07
	KP_VOLV $09,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$03
	KP_VOLV $09,$07
	KP_VOLV $08,$07
	KP_VOLV $07,$07
	KP_VOLV $06,$07
	KP_VOLV $05,$07
	KP_VOLV $04,$07
vol5loop
	KP_VOLV $03,$00
	KP_VOLJ [vol5loop-vol5]
ins6
ins6loop
	KP_OSCV $61,0,1,1,$00
	KP_OSCV $62,0,1,1,$00
	KP_OSCV $61,0,1,1,$00
	KP_OSCV $5F,0,1,1,$00
	KP_OSCV $5E,0,1,1,$00
	KP_OSCV $5F,0,1,1,$00
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $32,0,1,1,$00
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $2F,0,1,1,$00
	KP_OSCV $2E,0,1,1,$00
	KP_OSCV $2F,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins6loop-ins6]

vol6
	KP_VOLV $0B,$02
	KP_VOLV $0A,$01
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
vol6loop
	KP_VOLV $0A,$01
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLJ [vol6loop-vol6]
ins7
ins7loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$01
	KP_OSCV $40,0,1,1,$00
	KP_OSCV $4C,0,1,1,$00
	KP_OSCJ [ins7loop-ins7]

vol7
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$07
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
vol7loop
	KP_VOLV $07,$00
	KP_VOLJ [vol7loop-vol7]
ins8
ins8loop
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $10,1,0,0,$00
	KP_OSCV $52,0,1,0,$00
	KP_OSCV $4E,0,1,0,$00
	KP_OSCJ [ins8loop-ins8]

vol8
	KP_VOLV $09,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
	KP_VOLV $04,$00
vol8loop
	KP_VOLV $03,$00
	KP_VOLJ [vol8loop-vol8]
ins9
	KP_OSCV $08,0,1,0,$00
	KP_OSCV $78,1,0,0,$00
ins9loop
	KP_OSCV $F2,1,0,0,$00
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $FA,1,0,0,$00
	KP_OSCV $E8,1,0,0,$00
	KP_OSCJ [ins9loop-ins9]

vol9
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
vol9loop
	KP_VOLV $03,$00
	KP_VOLJ [vol9loop-vol9]
ins10
ins10loop
	KP_OSCV $20,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$01
	KP_OSCV $3C,0,1,1,$00
	KP_OSCV $50,0,1,1,$00
	KP_OSCJ [ins10loop-ins10]

vol10
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$07
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
vol10loop
	KP_VOLV $07,$00
	KP_VOLJ [vol10loop-vol10]
ins11
ins11loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins11loop-ins11]

vol11
	KP_VOLV $05,$03
	KP_VOLV $04,$02
vol11loop
	KP_VOLV $03,$00
	KP_VOLJ [vol11loop-vol11]
ins12
ins12loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins12loop-ins12]

vol12
	KP_VOLV $0B,$03
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
vol12loop
	KP_VOLV $06,$00
	KP_VOLJ [vol12loop-vol12]
ins13
ins13loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$01
	KP_OSCV $40,0,1,1,$00
	KP_OSCV $4C,0,1,1,$00
	KP_OSCJ [ins13loop-ins13]

vol13
	KP_VOLV $03,$00
	KP_VOLV $04,$00
	KP_VOLV $05,$07
	KP_VOLV $06,$07
	KP_VOLV $07,$07
	KP_VOLV $08,$07
	KP_VOLV $09,$07
	KP_VOLV $0A,$07
	KP_VOLV $0B,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0B,$07
	KP_VOLV $0B,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
	KP_VOLV $0A,$07
vol13loop
	KP_VOLV $09,$00
	KP_VOLJ [vol13loop-vol13]
ins14
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $34,0,1,0,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
ins14loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins14loop-ins14]

vol14
	KP_VOLV $0C,$00
	KP_VOLV $08,$00
	KP_VOLV $0C,$05
	KP_VOLV $0B,$03
	KP_VOLV $0A,$03
vol14loop
	KP_VOLV $09,$00
	KP_VOLJ [vol14loop-vol14]
ins15
ins15loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $03,0,1,1,$01
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FD,0,1,1,$01
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCJ [ins15loop-ins15]

vol15
vol15loop
	KP_VOLV $0C,$00
	KP_VOLJ [vol15loop-vol15]
ins16
	KP_OSCV $32,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $2E,0,1,1,$00
ins16loop
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins16loop-ins16]

vol16
vol16loop
	KP_VOLV $0C,$00
	KP_VOLJ [vol16loop-vol16]
ins17
ins17loop
	KP_OSCV $20,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$01
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCJ [ins17loop-ins17]

vol17
	KP_VOLV $09,$05
	KP_VOLV $0A,$05
	KP_VOLV $0B,$05
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0C,$07
	KP_VOLV $0B,$07
	KP_VOLV $0B,$03
	KP_VOLV $0A,$07
	KP_VOLV $0A,$03
	KP_VOLV $09,$07
	KP_VOLV $09,$03
	KP_VOLV $08,$07
	KP_VOLV $08,$03
	KP_VOLV $07,$07
	KP_VOLV $07,$03
	KP_VOLV $06,$07
	KP_VOLV $06,$03
	KP_VOLV $05,$07
	KP_VOLV $05,$03
vol17loop
	KP_VOLV $04,$00
	KP_VOLJ [vol17loop-vol17]
ins18
ins18loop
	KP_OSCV $70,0,1,0,$00
	KP_OSCV $71,0,1,0,$00
	KP_OSCV $70,0,1,1,$00
	KP_OSCV $73,0,1,0,$00
	KP_OSCV $74,0,1,0,$00
	KP_OSCV $73,0,1,0,$00
	KP_OSCV $70,0,1,1,$00
	KP_OSCV $71,0,1,0,$00
	KP_OSCV $70,0,1,0,$00
	KP_OSCV $6F,0,1,0,$00
	KP_OSCV $70,0,1,1,$00
	KP_OSCV $6D,0,1,0,$00
	KP_OSCV $6C,0,1,0,$00
	KP_OSCV $6D,0,1,0,$00
	KP_OSCV $70,0,1,1,$00
	KP_OSCV $6F,0,1,0,$00
	KP_OSCJ [ins18loop-ins18]

vol18
vol18loop
	KP_VOLV $0C,$00
	KP_VOLJ [vol18loop-vol18]

kp_sequence
	dc.b $00,$01,$02,$00
	dc.b $00,$03,$04,$00
	dc.b $00,$05,$06,$00
	dc.b $00,$07,$08,$00
	dc.b $00,$09,$0A,$00
	dc.b $00,$07,$08,$00
	dc.b $00,$09,$0A,$00
	dc.b $00,$0B,$0C,$00
	dc.b $00,$0D,$02,$00
	dc.b $00,$0E,$04,$00
	dc.b $00,$0F,$06,$00
	dc.b $00,$10,$08,$00
	dc.b $00,$11,$0A,$00
	dc.b $00,$10,$08,$00
	dc.b $00,$11,$0A,$00
	dc.b $00,$12,$0C,$00
	dc.b $00,$01,$13,$00
	dc.b $00,$03,$14,$00
	dc.b $00,$05,$15,$00
	dc.b $00,$07,$16,$00
	dc.b $00,$09,$17,$00
	dc.b $00,$07,$16,$00
	dc.b $00,$09,$17,$00
	dc.b $00,$0B,$18,$00
	dc.b $00,$19,$13,$00
	dc.b $00,$1A,$14,$00
	dc.b $00,$1B,$15,$00
	dc.b $00,$1C,$16,$00
	dc.b $00,$1D,$17,$00
	dc.b $00,$1C,$16,$00
	dc.b $00,$1D,$17,$00
	dc.b $00,$1E,$18,$00
	dc.b $00,$19,$13,$00
	dc.b $00,$1A,$14,$00
	dc.b $00,$1B,$15,$00
	dc.b $00,$1C,$16,$00
	dc.b $00,$1D,$17,$00
	dc.b $00,$1C,$16,$00
	dc.b $00,$1D,$17,$00
	dc.b $00,$1E,$18,$00
	dc.b $00,$1D,$0A,$00
	dc.b $00,$1E,$0C,$00
	dc.b $00,$1E,$00,$00
	dc.b $00,$1F,$00,$00
	dc.b $00,$0B,$0C,$00
	dc.b $00,$07,$08,$00
	dc.b $00,$01,$02,$00
	dc.b $00,$05,$06,$00
	dc.b $00,$03,$04,$00
	dc.b $00,$0B,$0C,$00
	dc.b $00,$20,$21,$00
	dc.b $00,$22,$22,$00
	dc.b $00,$1E,$18,$00
	dc.b $00,$1C,$16,$00
	dc.b $00,$19,$13,$00
	dc.b $00,$1B,$15,$00
	dc.b $00,$1A,$14,$00
	dc.b $00,$1E,$18,$00
	dc.b $00,$19,$13,$00
	dc.b $00,$19,$13,$00
	dc.b $00,$1E,$18,$00
	dc.b $00,$1C,$16,$00
	dc.b $00,$19,$13,$00
	dc.b $00,$1B,$15,$00
	dc.b $00,$1A,$14,$00
	dc.b $00,$1E,$18,$00
	dc.b $00,$19,$13,$00
	dc.b $00,$19,$13,$00
	dc.b $00,$23,$18,$00
	dc.b $00,$24,$16,$00
	dc.b $00,$25,$13,$00
	dc.b $00,$26,$15,$00
	dc.b $00,$27,$14,$00
	dc.b $00,$28,$18,$00
	dc.b $00,$29,$13,$00
	dc.b $00,$2A,$13,$00
	dc.b $00,$23,$18,$00
	dc.b $00,$24,$16,$00
	dc.b $00,$25,$13,$00
	dc.b $00,$26,$15,$00
	dc.b $00,$27,$14,$00
	dc.b $00,$28,$18,$00
	dc.b $00,$2B,$2C,$00
	dc.b $00,$2D,$2D,$00
	dc.b $ff
	dc.w $0150

