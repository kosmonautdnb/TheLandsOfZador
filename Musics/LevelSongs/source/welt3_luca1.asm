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
	kp_settrackregister $00,$13
	kp_settrackregister $01,$00
	kp_settrackregister $03,$09
	kp_setinstrument $0C,$01
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$01
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $00,$0B
	kp_settrackregister $01,$00
	kp_settrackregister $03,$09
	kp_setinstrument $0A,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $0B,$01
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$01
	kp_setinstrument $02,$02
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$02
	kp_setinstrument $02,$03
	kp_settrackregister $01,$08
	kp_settrackregister $03,$03
	kp_setinstrument $02,$02
	kp_settrackregister $01,$00
	kp_settrackregister $03,$04
	kp_setinstrument $02,$03
	kp_settrackregister $01,$10
	kp_settrackregister $03,$05
	kp_setinstrument $02,$02
	kp_settrackregister $01,$08
	kp_settrackregister $03,$06
	kp_setinstrument $02,$03
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$07
	kp_setinstrument $02,$02
	kp_settrackregister $01,$10
	kp_settrackregister $03,$08
	kp_setinstrument $02,$03
	kp_settrackregister $01,$30
	kp_settrackregister $03,$09
	kp_setinstrument $02,$02
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$03
	kp_settrackregister $01,$38
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$02
	kp_settrackregister $01,$30
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$02
	kp_settrackregister $01,$38
	kp_settrackregister $03,$0E
	kp_setinstrument $02,$03
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $01,$40
	kp_setinstrument $02,$03
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $01,$60
	kp_setinstrument $02,$02
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$68
	kp_setinstrument $02,$02
	kp_settrackregister $01,$60
	kp_setinstrument $02,$03
	kp_settrackregister $01,$40
	kp_setinstrument $02,$04
	kp_settrackregister $01,$68
	kp_setinstrument $02,$03
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$70
	kp_setinstrument $02,$03
	kp_settrackregister $01,$60
	kp_setinstrument $02,$04
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$68
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $02,$03
	kp_settrackregister $01,$70
	kp_setinstrument $02,$04
	kp_settrackregister $01,$98
	kp_setinstrument $02,$03
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$A0
	kp_setinstrument $02,$03
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$01
	kp_setinstrument $01,$01
	kp_settrackregister $03,$02
	kp_settrackregister $00,$01
	kp_settrackregister $03,$03
	kp_settrackregister $00,$01
	kp_settrackregister $03,$04
	kp_settrackregister $00,$01
	kp_settrackregister $03,$05
	kp_settrackregister $00,$01
	kp_settrackregister $03,$06
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$08
	kp_settrackregister $00,$01
	kp_setinstrument $01,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$01
	kp_setinstrument $01,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0E
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$03
	kp_setinstrument $08,$01
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $01,$08
	kp_setinstrument $02,$02
	kp_settrackregister $01,$54
	kp_setinstrument $02,$03
	kp_settrackregister $01,$10
	kp_setinstrument $02,$02
	kp_settrackregister $01,$08
	kp_setinstrument $02,$03
	kp_settrackregister $01,$14
	kp_setinstrument $02,$02
	kp_settrackregister $01,$10
	kp_setinstrument $02,$03
	kp_settrackregister $01,$24
	kp_setinstrument $02,$02
	kp_settrackregister $01,$14
	kp_setinstrument $02,$03
	kp_settrackregister $01,$38
	kp_setinstrument $02,$02
	kp_settrackregister $01,$24
	kp_setinstrument $02,$03
	kp_settrackregister $01,$40
	kp_setinstrument $02,$02
	kp_settrackregister $01,$38
	kp_setinstrument $02,$03
	kp_settrackregister $01,$44
	kp_setinstrument $02,$02
	kp_settrackregister $01,$40
	kp_setinstrument $02,$03
	kp_settrackregister $01,$54
	kp_setinstrument $02,$02
	kp_settrackregister $01,$44
	kp_setinstrument $02,$03
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $01,$00
	kp_setinstrument $04,$01
	kp_settrackregister $03,$0E
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$02
	kp_settrackregister $03,$06
	kp_settrackregister $00,$02
	kp_settrackregister $03,$05
	kp_settrackregister $00,$02
	kp_settrackregister $03,$04
	kp_setinstrument $02,$01
	kp_settrackregister $03,$03
	kp_settrackregister $00,$02
	kp_settrackregister $03,$02
	kp_settrackregister $00,$02
	kp_settrackregister $03,$01
	kp_settrackregister $00,$02
	kp_rewind [pat7loop-pat7]
pat8
pat8loop
	kp_settrackregister $01,$68
	kp_setinstrument $02,$02
	kp_settrackregister $01,$54
	kp_setinstrument $02,$03
	kp_settrackregister $01,$70
	kp_setinstrument $02,$02
	kp_settrackregister $01,$68
	kp_setinstrument $02,$03
	kp_settrackregister $01,$44
	kp_setinstrument $02,$04
	kp_settrackregister $01,$70
	kp_setinstrument $02,$03
	kp_settrackregister $01,$54
	kp_setinstrument $02,$04
	kp_settrackregister $01,$74
	kp_setinstrument $02,$03
	kp_settrackregister $01,$68
	kp_setinstrument $02,$04
	kp_settrackregister $01,$84
	kp_setinstrument $02,$03
	kp_settrackregister $01,$70
	kp_setinstrument $02,$04
	kp_settrackregister $01,$98
	kp_setinstrument $02,$03
	kp_settrackregister $01,$74
	kp_setinstrument $02,$04
	kp_settrackregister $01,$A0
	kp_setinstrument $02,$03
	kp_settrackregister $01,$84
	kp_setinstrument $02,$04
	kp_settrackregister $01,$A4
	kp_setinstrument $02,$03
	kp_rewind [pat8loop-pat8]
pat9
pat9loop
	kp_settrackregister $01,$00
	kp_setinstrument $02,$02
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$08
	kp_setinstrument $02,$02
	kp_settrackregister $01,$00
	kp_setinstrument $02,$03
	kp_settrackregister $01,$10
	kp_setinstrument $02,$02
	kp_settrackregister $01,$08
	kp_setinstrument $02,$03
	kp_settrackregister $01,$1C
	kp_setinstrument $02,$02
	kp_settrackregister $01,$10
	kp_setinstrument $02,$03
	kp_settrackregister $01,$30
	kp_setinstrument $02,$02
	kp_settrackregister $01,$1C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$38
	kp_setinstrument $02,$02
	kp_settrackregister $01,$30
	kp_setinstrument $02,$03
	kp_settrackregister $01,$40
	kp_setinstrument $02,$02
	kp_settrackregister $01,$38
	kp_setinstrument $02,$03
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$02
	kp_settrackregister $01,$40
	kp_setinstrument $02,$03
	kp_rewind [pat9loop-pat9]
pat10
pat10loop
	kp_settrackregister $00,$0F
	kp_settrackregister $01,$10
	kp_setinstrument $11,$01
	kp_rewind [pat10loop-pat10]
pat11
pat11loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$01
	kp_setinstrument $04,$05
	kp_settrackregister $03,$03
	kp_setinstrument $04,$05
	kp_settrackregister $03,$05
	kp_settrackregister $00,$02
	kp_settrackregister $03,$06
	kp_settrackregister $00,$02
	kp_settrackregister $01,$30
	kp_settrackregister $03,$07
	kp_setinstrument $02,$05
	kp_settrackregister $03,$08
	kp_settrackregister $00,$02
	kp_settrackregister $01,$00
	kp_settrackregister $03,$09
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0E
	kp_settrackregister $00,$02
	kp_settrackregister $01,$30
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$06
	kp_rewind [pat11loop-pat11]
pat12
pat12loop
	kp_settrackregister $01,$00
	kp_setinstrument $04,$05
	kp_setinstrument $08,$05
	kp_settrackregister $01,$30
	kp_setinstrument $04,$05
	kp_settrackregister $01,$00
	kp_setinstrument $04,$05
	kp_setinstrument $08,$05
	kp_settrackregister $01,$30
	kp_setinstrument $04,$06
	kp_rewind [pat12loop-pat12]
pat13
pat13loop
	kp_settrackregister $01,$81
	kp_setinstrument $01,$07
	kp_settrackregister $01,$84
	kp_settrackregister $00,$03
	kp_setinstrument $04,$08
	kp_settrackregister $01,$7C
	kp_settrackregister $00,$04
	kp_setinstrument $06,$08
	kp_settrackregister $01,$84
	kp_settrackregister $00,$01
	kp_settrackregister $01,$8C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$90
	kp_settrackregister $00,$04
	kp_settrackregister $01,$70
	kp_setinstrument $04,$07
	kp_settrackregister $01,$74
	kp_setinstrument $02,$08
	kp_settrackregister $01,$75
	kp_settrackregister $00,$01
	kp_settrackregister $01,$77
	kp_settrackregister $00,$01
	kp_rewind [pat13loop-pat13]
pat14
pat14loop
	kp_settrackregister $01,$08
	kp_setinstrument $04,$05
	kp_setinstrument $04,$05
	kp_setinstrument $04,$09
	kp_setinstrument $04,$05
	kp_settrackregister $01,$14
	kp_setinstrument $04,$05
	kp_setinstrument $04,$05
	kp_settrackregister $01,$08
	kp_setinstrument $04,$09
	kp_settrackregister $01,$14
	kp_setinstrument $04,$05
	kp_rewind [pat14loop-pat14]
pat15
pat15loop
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$07
	kp_settrackregister $01,$74
	kp_setinstrument $04,$07
	kp_settrackregister $01,$70
	kp_setinstrument $04,$07
	kp_settrackregister $01,$74
	kp_setinstrument $03,$07
	kp_settrackregister $01,$7A
	kp_settrackregister $00,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $08,$08
	kp_settrackregister $01,$74
	kp_setinstrument $08,$08
	kp_rewind [pat15loop-pat15]
pat16
pat16loop
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$06
	kp_settrackregister $01,$68
	kp_setinstrument $02,$0A
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$14
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$06
	kp_settrackregister $01,$60
	kp_setinstrument $02,$0A
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$06
	kp_settrackregister $01,$60
	kp_setinstrument $02,$0B
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$08
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$06
	kp_settrackregister $01,$54
	kp_setinstrument $04,$0C
	kp_rewind [pat16loop-pat16]
pat17
pat17loop
	kp_settrackregister $01,$70
	kp_setinstrument $04,$08
	kp_settrackregister $01,$66
	kp_settrackregister $00,$01
	kp_settrackregister $01,$63
	kp_settrackregister $00,$01
	kp_settrackregister $01,$60
	kp_settrackregister $00,$02
	kp_settrackregister $01,$10
	kp_setinstrument $02,$02
	kp_settrackregister $01,$08
	kp_setinstrument $02,$03
	kp_settrackregister $01,$1C
	kp_setinstrument $02,$02
	kp_settrackregister $01,$10
	kp_setinstrument $02,$03
	kp_settrackregister $01,$30
	kp_setinstrument $02,$02
	kp_settrackregister $01,$1C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$38
	kp_setinstrument $02,$02
	kp_settrackregister $01,$30
	kp_setinstrument $02,$03
	kp_settrackregister $01,$40
	kp_setinstrument $02,$02
	kp_settrackregister $01,$38
	kp_setinstrument $02,$03
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$02
	kp_settrackregister $01,$40
	kp_setinstrument $02,$03
	kp_rewind [pat17loop-pat17]
pat18
pat18loop
	kp_settrackregister $01,$00
	kp_setinstrument $04,$05
	kp_setinstrument $04,$05
	kp_settrackregister $01,$08
	kp_setinstrument $04,$09
	kp_settrackregister $01,$30
	kp_setinstrument $04,$05
	kp_settrackregister $01,$00
	kp_setinstrument $04,$05
	kp_setinstrument $04,$05
	kp_settrackregister $01,$08
	kp_setinstrument $04,$09
	kp_settrackregister $01,$30
	kp_setinstrument $04,$06
	kp_rewind [pat18loop-pat18]
pat19
pat19loop
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$07
	kp_settrackregister $01,$70
	kp_setinstrument $04,$07
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$08
	kp_settrackregister $01,$7F
	kp_settrackregister $00,$01
	kp_settrackregister $01,$83
	kp_settrackregister $00,$01
	kp_settrackregister $01,$84
	kp_settrackregister $00,$04
	kp_settrackregister $01,$7C
	kp_setinstrument $08,$08
	kp_settrackregister $01,$74
	kp_setinstrument $08,$08
	kp_rewind [pat19loop-pat19]
pat20
pat20loop
	kp_settrackregister $01,$90
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_rewind [pat20loop-pat20]
pat21
pat21loop
	kp_settrackregister $01,$8C
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_settrackregister $01,$84
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_settrackregister $01,$74
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_rewind [pat21loop-pat21]
pat22
pat22loop
	kp_settrackregister $01,$54
	kp_setinstrument $02,$04
	kp_settrackregister $01,$70
	kp_setinstrument $02,$03
	kp_settrackregister $01,$44
	kp_setinstrument $02,$02
	kp_settrackregister $01,$54
	kp_setinstrument $02,$03
	kp_settrackregister $01,$24
	kp_setinstrument $02,$04
	kp_settrackregister $01,$44
	kp_setinstrument $02,$03
	kp_settrackregister $01,$2C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$54
	kp_setinstrument $02,$03
	kp_settrackregister $01,$60
	kp_setinstrument $02,$04
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$44
	kp_setinstrument $02,$02
	kp_settrackregister $01,$60
	kp_setinstrument $02,$03
	kp_settrackregister $01,$14
	kp_setinstrument $02,$04
	kp_settrackregister $01,$44
	kp_setinstrument $02,$03
	kp_settrackregister $01,$30
	kp_setinstrument $02,$04
	kp_settrackregister $01,$54
	kp_setinstrument $02,$03
	kp_rewind [pat22loop-pat22]
pat23
pat23loop
	kp_settrackregister $01,$14
	kp_setinstrument $08,$05
	kp_setinstrument $08,$05
	kp_setinstrument $08,$05
	kp_setinstrument $08,$05
	kp_rewind [pat23loop-pat23]
pat24
pat24loop
	kp_settrackregister $01,$70
	kp_setinstrument $02,$04
	kp_settrackregister $01,$60
	kp_setinstrument $02,$03
	kp_settrackregister $01,$24
	kp_setinstrument $02,$04
	kp_settrackregister $01,$70
	kp_setinstrument $02,$03
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$54
	kp_setinstrument $02,$03
	kp_setinstrument $02,$02
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$70
	kp_setinstrument $02,$04
	kp_settrackregister $01,$54
	kp_setinstrument $02,$03
	kp_settrackregister $01,$30
	kp_setinstrument $02,$04
	kp_settrackregister $01,$70
	kp_setinstrument $02,$03
	kp_settrackregister $01,$68
	kp_setinstrument $02,$04
	kp_settrackregister $01,$60
	kp_setinstrument $02,$03
	kp_settrackregister $01,$70
	kp_setinstrument $02,$02
	kp_settrackregister $01,$68
	kp_setinstrument $02,$03
	kp_rewind [pat24loop-pat24]
pat25
pat25loop
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$70
	kp_setinstrument $02,$03
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$02
	kp_setinstrument $02,$03
	kp_settrackregister $01,$24
	kp_setinstrument $02,$04
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$2C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$54
	kp_setinstrument $02,$03
	kp_settrackregister $01,$60
	kp_setinstrument $02,$04
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$02
	kp_settrackregister $01,$60
	kp_setinstrument $02,$03
	kp_settrackregister $01,$10
	kp_setinstrument $02,$04
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$1C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$40
	kp_setinstrument $02,$03
	kp_rewind [pat25loop-pat25]
pat26
pat26loop
	kp_settrackregister $01,$00
	kp_setinstrument $08,$05
	kp_setinstrument $08,$05
	kp_setinstrument $08,$05
	kp_setinstrument $08,$05
	kp_rewind [pat26loop-pat26]
pat27
pat27loop
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$70
	kp_setinstrument $02,$03
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$02
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$2C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$30
	kp_setinstrument $02,$04
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$68
	kp_setinstrument $02,$04
	kp_settrackregister $01,$30
	kp_setinstrument $02,$03
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$68
	kp_setinstrument $02,$03
	kp_settrackregister $01,$84
	kp_setinstrument $02,$04
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$03
	kp_settrackregister $01,$90
	kp_setinstrument $04,$0D
	kp_rewind [pat27loop-pat27]
pat28
pat28loop
	kp_settrackregister $01,$1C
	kp_setinstrument $08,$06
	kp_settrackregister $01,$4C
	kp_setinstrument $08,$05
	kp_settrackregister $01,$1C
	kp_setinstrument $08,$06
	kp_settrackregister $01,$4C
	kp_setinstrument $08,$05
	kp_rewind [pat28loop-pat28]
pat29
pat29loop
	kp_settrackregister $01,$8C
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_settrackregister $01,$84
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0D
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$0D
	kp_setinstrument $04,$0E
	kp_settrackregister $01,$F1
	kp_setinstrument $08,$0F
	kp_rewind [pat29loop-pat29]
pat30
pat30loop
	kp_settrackregister $01,$14
	kp_setinstrument $02,$06
	kp_settrackregister $01,$54
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$44
	kp_setinstrument $04,$05
	kp_settrackregister $01,$10
	kp_setinstrument $02,$06
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$0A
	kp_settrackregister $01,$40
	kp_setinstrument $04,$06
	kp_settrackregister $01,$08
	kp_setinstrument $02,$06
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$0B
	kp_setinstrument $04,$0E
	kp_settrackregister $01,$D8
	kp_setinstrument $08,$0F
	kp_rewind [pat30loop-pat30]
pat31
pat31loop
	kp_settrackregister $01,$81
	kp_setinstrument $01,$08
	kp_settrackregister $01,$84
	kp_settrackregister $00,$0B
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$84
	kp_settrackregister $00,$04
	kp_settrackregister $01,$90
	kp_settrackregister $00,$0B
	kp_settrackregister $01,$9A
	kp_setinstrument $01,$08
	kp_rewind [pat31loop-pat31]
pat32
pat32loop
	kp_settrackregister $01,$9D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A0
	kp_settrackregister $00,$0B
	kp_settrackregister $01,$7C
	kp_setinstrument $14,$08
	kp_rewind [pat32loop-pat32]
pat33
pat33loop
	kp_settrackregister $01,$70
	kp_setinstrument $0C,$0C
	kp_settrackregister $01,$68
	kp_setinstrument $0C,$0A
	kp_settrackregister $01,$60
	kp_setinstrument $08,$0A
	kp_rewind [pat33loop-pat33]
pat34
pat34loop
	kp_settrackregister $01,$24
	kp_setinstrument $04,$05
	kp_settrackregister $01,$10
	kp_setinstrument $04,$05
	kp_settrackregister $01,$08
	kp_setinstrument $04,$09
	kp_settrackregister $01,$60
	kp_setinstrument $02,$10
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$24
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$05
	kp_settrackregister $01,$10
	kp_setinstrument $03,$05
	kp_setinstrument $01,$09
	kp_settrackregister $01,$08
	kp_setinstrument $04,$09
	kp_setinstrument $04,$11
	kp_rewind [pat34loop-pat34]
pat35
pat35loop
	kp_settrackregister $01,$5C
	kp_setinstrument $0C,$0C
	kp_settrackregister $01,$4C
	kp_setinstrument $14,$10
	kp_rewind [pat35loop-pat35]
pat36
pat36loop
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$05
	kp_settrackregister $01,$10
	kp_setinstrument $04,$05
	kp_settrackregister $01,$08
	kp_setinstrument $04,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$10
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$05
	kp_settrackregister $01,$10
	kp_setinstrument $03,$05
	kp_setinstrument $01,$09
	kp_settrackregister $01,$08
	kp_setinstrument $02,$09
	kp_setinstrument $02,$09
	kp_setinstrument $04,$11
	kp_rewind [pat36loop-pat36]
pat37
pat37loop
	kp_settrackregister $01,$81
	kp_setinstrument $01,$08
	kp_settrackregister $01,$84
	kp_settrackregister $00,$07
	kp_settrackregister $01,$54
	kp_setinstrument $04,$04
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$08
	kp_settrackregister $01,$84
	kp_settrackregister $00,$04
	kp_settrackregister $01,$90
	kp_settrackregister $00,$04
	kp_settrackregister $01,$60
	kp_setinstrument $07,$04
	kp_settrackregister $01,$9A
	kp_setinstrument $01,$08
	kp_rewind [pat37loop-pat37]
pat38
pat38loop
	kp_settrackregister $01,$9D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$A0
	kp_settrackregister $00,$07
	kp_settrackregister $01,$70
	kp_setinstrument $04,$04
	kp_settrackregister $01,$7C
	kp_setinstrument $0C,$08
	kp_settrackregister $01,$4C
	kp_setinstrument $08,$04
	kp_rewind [pat38loop-pat38]
pat39
pat39loop
	kp_settrackregister $01,$5C
	kp_setinstrument $0C,$0C
	kp_settrackregister $01,$54
	kp_setinstrument $0C,$0C
	kp_settrackregister $01,$4C
	kp_setinstrument $08,$0A
	kp_rewind [pat39loop-pat39]
pat40
pat40loop
	kp_settrackregister $01,$4C
	kp_setinstrument $0C,$0B
	kp_settrackregister $01,$5C
	kp_setinstrument $14,$12
	kp_rewind [pat40loop-pat40]
pat41
pat41loop
	kp_settrackregister $01,$08
	kp_setinstrument $04,$05
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$05
	kp_settrackregister $01,$08
	kp_setinstrument $04,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$0B
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$08
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$05
	kp_settrackregister $01,$1C
	kp_setinstrument $03,$05
	kp_setinstrument $01,$09
	kp_settrackregister $01,$08
	kp_setinstrument $02,$09
	kp_setinstrument $02,$09
	kp_setinstrument $04,$11
	kp_rewind [pat41loop-pat41]
pat42
pat42loop
	kp_settrackregister $01,$24
	kp_setinstrument $04,$04
	kp_settrackregister $01,$30
	kp_setinstrument $04,$04
	kp_settrackregister $01,$40
	kp_setinstrument $04,$04
	kp_settrackregister $01,$30
	kp_setinstrument $04,$04
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$04
	kp_settrackregister $01,$30
	kp_setinstrument $04,$04
	kp_settrackregister $01,$40
	kp_setinstrument $04,$04
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$04
	kp_rewind [pat42loop-pat42]
pat43
pat43loop
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$04
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$04
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$04
	kp_settrackregister $01,$60
	kp_setinstrument $04,$04
	kp_settrackregister $01,$68
	kp_setinstrument $04,$04
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$04
	kp_settrackregister $01,$84
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $04,$04
	kp_rewind [pat43loop-pat43]
pat44
pat44loop
	kp_settrackregister $01,$08
	kp_setinstrument $04,$05
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$05
	kp_settrackregister $01,$08
	kp_setinstrument $04,$09
	kp_settrackregister $01,$5C
	kp_setinstrument $02,$12
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$08
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$05
	kp_settrackregister $01,$1C
	kp_setinstrument $03,$05
	kp_settrackregister $01,$08
	kp_setinstrument $01,$09
	kp_setinstrument $01,$09
	kp_setinstrument $03,$09
	kp_setinstrument $02,$09
	kp_setinstrument $02,$09
	kp_rewind [pat44loop-pat44]
pat45
pat45loop
	kp_settrackregister $01,$90
	kp_setinstrument $08,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$08
	kp_settrackregister $03,$0F
	kp_setinstrument $10,$0E
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
	KP_OSCV $D8,0,1,0,$01
	KP_OSCV $DA,0,1,0,$01
	KP_OSCV $DB,0,1,0,$01
	KP_OSCV $DC,0,1,0,$0F
	KP_OSCV $DC,0,1,0,$0A
	KP_OSCV $DB,0,1,0,$04
	KP_OSCV $DA,0,1,0,$03
	KP_OSCV $D9,0,1,0,$03
	KP_OSCV $D8,0,1,0,$03
	KP_OSCV $D7,0,1,0,$03
ins1loop
	KP_OSCV $D6,0,1,0,$00
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $01,$02
	KP_VOLV $02,$02
	KP_VOLV $03,$02
	KP_VOLV $04,$02
	KP_VOLV $05,$02
	KP_VOLV $06,$02
	KP_VOLV $07,$02
	KP_VOLV $08,$02
	KP_VOLV $09,$02
	KP_VOLV $0A,$02
	KP_VOLV $0B,$02
	KP_VOLV $0C,$06
	KP_VOLV $0B,$01
	KP_VOLV $0A,$01
	KP_VOLV $09,$01
	KP_VOLV $08,$01
	KP_VOLV $07,$01
	KP_VOLV $06,$01
	KP_VOLV $05,$01
	KP_VOLV $04,$01
	KP_VOLV $03,$01
	KP_VOLV $02,$01
	KP_VOLV $01,$01
vol1loop
	KP_VOLV $00,$00
	KP_VOLJ [vol1loop-vol1]
ins2
ins2loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $0C,$02
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
vol2loop
	KP_VOLV $06,$00
	KP_VOLJ [vol2loop-vol2]
ins3
ins3loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $06,$03
	KP_VOLV $05,$03
vol3loop
	KP_VOLV $04,$00
	KP_VOLJ [vol3loop-vol3]
ins4
	KP_OSCV $24,0,1,1,$00
	KP_OSCV $2C,0,1,1,$00
ins4loop
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $2F,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$01
	KP_VOLV $0B,$00
	KP_VOLV $0A,$01
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$01
	KP_VOLV $07,$01
vol4loop
	KP_VOLV $06,$00
	KP_VOLJ [vol4loop-vol4]
ins5
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $34,0,1,0,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
ins5loop
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
	KP_OSCJ [ins5loop-ins5]

vol5
	KP_VOLV $0C,$00
	KP_VOLV $08,$00
	KP_VOLV $0C,$07
	KP_VOLV $0C,$02
	KP_VOLV $0B,$01
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
vol5loop
	KP_VOLV $07,$00
	KP_VOLJ [vol5loop-vol5]
ins6
	KP_OSCV $A2,1,0,0,$00
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
ins6loop
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
	KP_OSCJ [ins6loop-ins6]

vol6
	KP_VOLV $0C,$00
	KP_VOLV $08,$00
	KP_VOLV $0C,$07
	KP_VOLV $0C,$02
	KP_VOLV $0B,$01
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
vol6loop
	KP_VOLV $07,$00
	KP_VOLJ [vol6loop-vol6]
ins7
ins7loop
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins7loop-ins7]

vol7
	KP_VOLV $0C,$07
	KP_VOLV $0C,$05
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
vol7loop
	KP_VOLV $05,$00
	KP_VOLJ [vol7loop-vol7]
ins8
ins8loop
	KP_OSCV $FE,0,1,1,$01
	KP_OSCV $FF,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $01,0,1,1,$01
	KP_OSCV $02,0,1,1,$01
	KP_OSCV $01,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$01
	KP_OSCJ [ins8loop-ins8]

vol8
	KP_VOLV $0C,$07
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
vol8loop
	KP_VOLV $09,$00
	KP_VOLJ [vol8loop-vol8]
ins9
	KP_OSCV $EF,1,0,1,$00
	KP_OSCV $40,0,1,0,$00
	KP_OSCV $30,0,1,0,$00
ins9loop
	KP_OSCV $EE,1,0,1,$00
	KP_OSCV $ED,1,0,1,$00
	KP_OSCJ [ins9loop-ins9]

vol9
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
vol9loop
	KP_VOLV $02,$00
	KP_VOLJ [vol9loop-vol9]
ins10
ins10loop
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $14,0,1,1,$01
	KP_OSCV $44,0,1,1,$00
	KP_OSCV $54,0,1,1,$00
	KP_OSCJ [ins10loop-ins10]

vol10
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$07
	KP_VOLV $0C,$03
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
vol10loop
	KP_VOLV $09,$00
	KP_VOLJ [vol10loop-vol10]
ins11
ins11loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$01
	KP_OSCV $40,0,1,1,$00
	KP_OSCV $4C,0,1,1,$00
	KP_OSCJ [ins11loop-ins11]

vol11
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$07
	KP_VOLV $0C,$03
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
vol11loop
	KP_VOLV $09,$00
	KP_VOLJ [vol11loop-vol11]
ins12
ins12loop
	KP_OSCV $20,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $14,0,1,1,$01
	KP_OSCV $44,0,1,1,$00
	KP_OSCV $50,0,1,1,$00
	KP_OSCJ [ins12loop-ins12]

vol12
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$07
	KP_VOLV $0C,$03
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
vol12loop
	KP_VOLV $09,$00
	KP_VOLJ [vol12loop-vol12]
ins13
ins13loop
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $B4,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $A4,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $A4,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $B4,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCJ [ins13loop-ins13]

vol13
	KP_VOLV $0B,$00
	KP_VOLV $0C,$04
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
vol13loop
	KP_VOLV $06,$00
	KP_VOLJ [vol13loop-vol13]
ins14
ins14loop
	KP_OSCV $00,0,0,0,$00
	KP_OSCJ [ins14loop-ins14]

vol14
vol14loop
	KP_VOLV $00,$00
	KP_VOLJ [vol14loop-vol14]
ins15
ins15loop
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
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins15loop-ins15]

vol15
	KP_VOLV $07,$00
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$02
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
	KP_VOLV $09,$02
	KP_VOLV $08,$02
	KP_VOLV $07,$02
	KP_VOLV $06,$02
	KP_VOLV $05,$02
	KP_VOLV $04,$02
	KP_VOLV $03,$02
	KP_VOLV $02,$02
	KP_VOLV $01,$02
vol15loop
	KP_VOLV $00,$00
	KP_VOLJ [vol15loop-vol15]
ins16
ins16loop
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$01
	KP_OSCV $40,0,1,1,$00
	KP_OSCV $54,0,1,1,$00
	KP_OSCJ [ins16loop-ins16]

vol16
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$07
	KP_VOLV $0C,$03
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
vol16loop
	KP_VOLV $09,$00
	KP_VOLJ [vol16loop-vol16]
ins17
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $10,1,0,0,$00
ins17loop
	KP_OSCV $52,0,1,0,$00
	KP_OSCV $4E,0,1,0,$00
	KP_OSCJ [ins17loop-ins17]

vol17
	KP_VOLV $08,$00
	KP_VOLV $0A,$00
	KP_VOLV $0E,$00
	KP_VOLV $09,$00
	KP_VOLV $06,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$01
	KP_VOLV $02,$01
	KP_VOLV $01,$01
vol17loop
	KP_VOLV $00,$00
	KP_VOLJ [vol17loop-vol17]
ins18
ins18loop
	KP_OSCV $20,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$01
	KP_OSCV $3C,0,1,1,$00
	KP_OSCV $50,0,1,1,$00
	KP_OSCJ [ins18loop-ins18]

vol18
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$07
	KP_VOLV $0C,$03
	KP_VOLV $0B,$02
	KP_VOLV $0A,$02
vol18loop
	KP_VOLV $09,$00
	KP_VOLJ [vol18loop-vol18]

kp_sequence
	dc.b $00,$00,$01,$00
	dc.b $00,$00,$02,$00
	dc.b $00,$03,$00,$00
	dc.b $00,$04,$05,$00
	dc.b $00,$06,$07,$00
	dc.b $00,$08,$01,$00
	dc.b $00,$09,$0A,$00
	dc.b $00,$04,$01,$00
	dc.b $00,$09,$0B,$00
	dc.b $00,$04,$0C,$00
	dc.b $00,$0D,$0E,$00
	dc.b $00,$0F,$10,$00
	dc.b $00,$11,$12,$00
	dc.b $00,$04,$12,$00
	dc.b $00,$0D,$0E,$00
	dc.b $00,$13,$10,$00
	dc.b $00,$11,$12,$00
	dc.b $00,$04,$12,$00
	dc.b $00,$14,$0E,$00
	dc.b $00,$15,$10,$00
	dc.b $00,$11,$12,$00
	dc.b $00,$04,$12,$00
	dc.b $00,$14,$0E,$00
	dc.b $00,$15,$10,$00
	dc.b $00,$11,$12,$00
	dc.b $00,$04,$12,$00
	dc.b $00,$16,$17,$00
	dc.b $00,$18,$17,$00
	dc.b $00,$19,$1A,$00
	dc.b $00,$18,$1A,$00
	dc.b $00,$16,$17,$00
	dc.b $00,$18,$17,$00
	dc.b $00,$1B,$1C,$00
	dc.b $00,$1D,$1E,$00
	dc.b $00,$1F,$0E,$00
	dc.b $00,$20,$12,$00
	dc.b $00,$21,$22,$00
	dc.b $00,$23,$24,$00
	dc.b $00,$25,$0E,$00
	dc.b $00,$26,$12,$00
	dc.b $00,$27,$24,$00
	dc.b $00,$28,$29,$00
	dc.b $00,$1F,$0E,$00
	dc.b $00,$20,$12,$00
	dc.b $00,$21,$22,$00
	dc.b $00,$23,$24,$00
	dc.b $00,$25,$0E,$00
	dc.b $00,$26,$12,$00
	dc.b $00,$2A,$22,$00
	dc.b $00,$2B,$2C,$00
	dc.b $00,$09,$2D,$00
	dc.b $00,$04,$00,$00
	dc.b $ff
	dc.w $00B0

