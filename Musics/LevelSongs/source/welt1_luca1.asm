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
	dc.b $05
	dc.b $07
	dc.b $0A
	dc.b $0A
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

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $00,$18
	kp_settrackregister $01,$70
	kp_settrackregister $03,$0B
	kp_setinstrument $04,$01
	kp_settrackregister $01,$68
	kp_setinstrument $04,$02
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$06
	kp_setinstrument $02,$03
	kp_settrackregister $03,$07
	kp_settrackregister $00,$02
	kp_settrackregister $01,$01
	kp_settrackregister $00,$01
	kp_settrackregister $01,$02
	kp_settrackregister $00,$01
	kp_settrackregister $01,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $01,$04
	kp_settrackregister $00,$01
	kp_settrackregister $01,$05
	kp_settrackregister $00,$01
	kp_settrackregister $01,$07
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$01
	kp_settrackregister $01,$09
	kp_settrackregister $00,$01
	kp_settrackregister $01,$0B
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$0E
	kp_settrackregister $00,$01
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$04
	kp_settrackregister $01,$0E
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $01,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $01,$0C
	kp_settrackregister $03,$0B
	kp_settrackregister $00,$02
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $01,$07
	kp_settrackregister $00,$03
	kp_settrackregister $01,$06
	kp_settrackregister $03,$07
	kp_settrackregister $00,$02
	kp_settrackregister $03,$06
	kp_settrackregister $00,$02
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $01,$60
	kp_setinstrument $06,$04
	kp_settrackregister $01,$70
	kp_setinstrument $04,$01
	kp_settrackregister $01,$68
	kp_setinstrument $04,$02
	kp_settrackregister $01,$60
	kp_setinstrument $0A,$04
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$74
	kp_setinstrument $04,$04
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $00,$20
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $01,$70
	kp_setinstrument $06,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$02
	kp_settrackregister $01,$74
	kp_setinstrument $04,$04
	kp_settrackregister $01,$70
	kp_setinstrument $0A,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$01
	kp_settrackregister $01,$68
	kp_setinstrument $04,$02
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $01,$70
	kp_setinstrument $06,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $04,$02
	kp_settrackregister $01,$74
	kp_setinstrument $04,$04
	kp_settrackregister $01,$70
	kp_setinstrument $06,$01
	kp_settrackregister $01,$30
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$05
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$05
	kp_settrackregister $01,$10
	kp_setinstrument $04,$05
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $03,$0F
	kp_setinstrument $06,$06
	kp_setinstrument $02,$06
	kp_setinstrument $04,$07
	kp_setinstrument $02,$07
	kp_setinstrument $04,$06
	kp_setinstrument $02,$07
	kp_setinstrument $04,$06
	kp_setinstrument $04,$07
	kp_setinstrument $04,$07
	kp_rewind [pat7loop-pat7]
pat8
pat8loop
	kp_settrackregister $01,$43
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$49
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$01
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$44
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$09
	kp_settrackregister $01,$44
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$09
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$70
	kp_settrackregister $00,$01
	kp_settrackregister $01,$60
	kp_settrackregister $00,$01
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_settrackregister $00,$01
	kp_settrackregister $01,$40
	kp_settrackregister $00,$01
	kp_rewind [pat8loop-pat8]
pat9
pat9loop
	kp_settrackregister $01,$00
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0A
	kp_settrackregister $01,$40
	kp_setinstrument $04,$01
	kp_settrackregister $01,$00
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0B
	kp_setinstrument $04,$0C
	kp_settrackregister $01,$70
	kp_setinstrument $04,$01
	kp_settrackregister $01,$00
	kp_setinstrument $04,$0A
	kp_rewind [pat9loop-pat9]
pat10
pat10loop
	kp_settrackregister $01,$49
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$02
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$74
	kp_setinstrument $01,$09
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$74
	kp_setinstrument $01,$09
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$74
	kp_setinstrument $01,$09
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$74
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$6A
	kp_setinstrument $01,$08
	kp_settrackregister $01,$6D
	kp_settrackregister $00,$01
	kp_rewind [pat10loop-pat10]
pat11
pat11loop
	kp_settrackregister $01,$00
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0C
	kp_settrackregister $01,$08
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0C
	kp_settrackregister $01,$10
	kp_setinstrument $02,$0A
	kp_setinstrument $02,$07
	kp_setinstrument $02,$0C
	kp_setinstrument $02,$07
	kp_settrackregister $01,$1C
	kp_setinstrument $02,$0A
	kp_setinstrument $02,$07
	kp_setinstrument $02,$0C
	kp_setinstrument $02,$07
	kp_rewind [pat11loop-pat11]
pat12
	kp_settrackregister $01,$70
	kp_settrackregister $00,$01
pat12loop
	kp_settrackregister $01,$90
	kp_setinstrument $01,$09
	kp_settrackregister $01,$70
	kp_setinstrument $01,$08
	kp_settrackregister $01,$90
	kp_setinstrument $01,$09
	kp_settrackregister $01,$70
	kp_setinstrument $01,$08
	kp_settrackregister $01,$90
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$84
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$84
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$84
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$84
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$44
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$09
	kp_rewind [pat12loop-pat12]
pat13
pat13loop
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0A
	kp_settrackregister $01,$54
	kp_setinstrument $04,$0D
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0B
	kp_setinstrument $04,$0C
	kp_settrackregister $01,$84
	kp_setinstrument $04,$0D
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0A
	kp_rewind [pat13loop-pat13]
pat14
pat14loop
	kp_settrackregister $01,$40
	kp_setinstrument $02,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_settrackregister $00,$01
	kp_settrackregister $01,$40
	kp_setinstrument $02,$08
	kp_settrackregister $01,$70
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_settrackregister $01,$08
	kp_setinstrument $02,$05
	kp_setinstrument $02,$05
	kp_settrackregister $01,$70
	kp_setinstrument $04,$01
	kp_setinstrument $04,$02
	kp_settrackregister $01,$14
	kp_setinstrument $02,$05
	kp_settrackregister $01,$08
	kp_setinstrument $02,$05
	kp_setinstrument $02,$05
	kp_rewind [pat14loop-pat14]
pat15
pat15loop
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0A
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$0C
	kp_setinstrument $04,$0C
	kp_settrackregister $01,$10
	kp_setinstrument $02,$0A
	kp_setinstrument $02,$07
	kp_setinstrument $02,$0A
	kp_setinstrument $02,$07
	kp_settrackregister $01,$08
	kp_setinstrument $02,$0C
	kp_setinstrument $02,$07
	kp_setinstrument $02,$0C
	kp_setinstrument $02,$07
	kp_rewind [pat15loop-pat15]
pat16
pat16loop
	kp_settrackregister $01,$46
	kp_settrackregister $03,$0B
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$49
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$01
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$44
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$68
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$44
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$68
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$40
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$40
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$70
	kp_settrackregister $00,$01
	kp_settrackregister $01,$60
	kp_settrackregister $00,$01
	kp_settrackregister $01,$40
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$60
	kp_settrackregister $00,$01
	kp_settrackregister $01,$40
	kp_settrackregister $00,$01
	kp_rewind [pat16loop-pat16]
pat17
pat17loop
	kp_settrackregister $01,$49
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$02
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$54
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$54
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$54
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$54
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$74
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$74
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$74
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$74
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$6A
	kp_settrackregister $03,$0C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$6D
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$01
	kp_rewind [pat17loop-pat17]
pat18
	kp_settrackregister $01,$70
	kp_settrackregister $00,$01
pat18loop
	kp_settrackregister $01,$90
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$90
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$90
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$90
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$84
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$84
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$84
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$54
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$84
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$54
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$54
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$40
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$40
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$54
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$40
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$60
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$0E
	kp_settrackregister $01,$74
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$38
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$0F
	kp_rewind [pat18loop-pat18]
pat19
pat19loop
	kp_settrackregister $01,$54
	kp_setinstrument $02,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$60
	kp_settrackregister $00,$01
	kp_settrackregister $01,$54
	kp_setinstrument $02,$0E
	kp_settrackregister $01,$70
	kp_setinstrument $04,$01
	kp_setinstrument $04,$01
	kp_settrackregister $01,$08
	kp_setinstrument $02,$05
	kp_setinstrument $02,$05
	kp_settrackregister $01,$70
	kp_setinstrument $04,$01
	kp_settrackregister $01,$60
	kp_setinstrument $04,$08
	kp_setinstrument $04,$08
	kp_setinstrument $01,$08
	kp_settrackregister $01,$6A
	kp_settrackregister $00,$01
	kp_rewind [pat19loop-pat19]
pat20
pat20loop
	kp_settrackregister $01,$6D
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_settrackregister $00,$02
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$70
	kp_setinstrument $01,$08
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$70
	kp_setinstrument $01,$08
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$30
	kp_setinstrument $01,$08
	kp_settrackregister $01,$40
	kp_setinstrument $01,$09
	kp_setinstrument $01,$08
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$09
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_setinstrument $01,$08
	kp_settrackregister $01,$70
	kp_setinstrument $01,$09
	kp_rewind [pat20loop-pat20]
pat21
pat21loop
	kp_settrackregister $01,$66
	kp_setinstrument $01,$08
	kp_settrackregister $01,$69
	kp_settrackregister $00,$01
	kp_settrackregister $01,$68
	kp_settrackregister $00,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$68
	kp_setinstrument $01,$08
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$68
	kp_setinstrument $01,$08
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$09
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$09
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$09
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$38
	kp_setinstrument $01,$08
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$2C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$44
	kp_setinstrument $01,$09
	kp_settrackregister $01,$38
	kp_setinstrument $01,$08
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$09
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$09
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$09
	kp_rewind [pat21loop-pat21]
pat22
pat22loop
	kp_settrackregister $01,$10
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0A
	kp_settrackregister $01,$2C
	kp_setinstrument $04,$01
	kp_settrackregister $01,$10
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0B
	kp_setinstrument $04,$0C
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$01
	kp_settrackregister $01,$10
	kp_setinstrument $04,$0A
	kp_rewind [pat22loop-pat22]
pat23
pat23loop
	kp_settrackregister $01,$5A
	kp_setinstrument $01,$08
	kp_settrackregister $01,$5D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$60
	kp_settrackregister $00,$01
	kp_settrackregister $01,$74
	kp_setinstrument $01,$09
	kp_settrackregister $01,$60
	kp_setinstrument $01,$08
	kp_settrackregister $01,$74
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$08
	kp_settrackregister $01,$60
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$09
	kp_settrackregister $01,$44
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$09
	kp_settrackregister $01,$44
	kp_setinstrument $01,$09
	kp_settrackregister $01,$30
	kp_setinstrument $01,$09
	kp_settrackregister $01,$54
	kp_setinstrument $01,$09
	kp_settrackregister $01,$44
	kp_setinstrument $01,$09
	kp_settrackregister $01,$30
	kp_setinstrument $01,$09
	kp_settrackregister $01,$44
	kp_setinstrument $01,$09
	kp_settrackregister $01,$30
	kp_setinstrument $01,$09
	kp_settrackregister $01,$24
	kp_setinstrument $01,$09
	kp_settrackregister $01,$44
	kp_setinstrument $01,$09
	kp_settrackregister $01,$30
	kp_setinstrument $01,$09
	kp_settrackregister $01,$24
	kp_setinstrument $01,$09
	kp_settrackregister $01,$30
	kp_setinstrument $01,$09
	kp_settrackregister $01,$24
	kp_setinstrument $01,$09
	kp_settrackregister $01,$14
	kp_setinstrument $01,$09
	kp_settrackregister $01,$24
	kp_setinstrument $01,$09
	kp_rewind [pat23loop-pat23]
pat24
pat24loop
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0A
	kp_settrackregister $01,$54
	kp_setinstrument $04,$01
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0B
	kp_setinstrument $04,$0C
	kp_settrackregister $01,$84
	kp_setinstrument $04,$01
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0A
	kp_rewind [pat24loop-pat24]
pat25
pat25loop
	kp_settrackregister $01,$42
	kp_setinstrument $01,$08
	kp_settrackregister $01,$47
	kp_settrackregister $00,$01
	kp_settrackregister $01,$4C
	kp_settrackregister $00,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$7C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$40
	kp_setinstrument $01,$08
	kp_settrackregister $01,$68
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$38
	kp_setinstrument $01,$08
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$5C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$38
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$4C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$38
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$2C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$38
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$2C
	kp_setinstrument $01,$0F
	kp_settrackregister $01,$70
	kp_setinstrument $04,$01
	kp_settrackregister $01,$68
	kp_setinstrument $04,$02
	kp_rewind [pat25loop-pat25]
pat26
pat26loop
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$0A
	kp_setinstrument $04,$0A
	kp_settrackregister $01,$5C
	kp_setinstrument $04,$01
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$0A
	kp_settrackregister $01,$8C
	kp_setinstrument $04,$01
	kp_settrackregister $03,$0C
	kp_setinstrument $04,$01
	kp_setinstrument $02,$01
	kp_setinstrument $02,$0B
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$0B
	kp_setinstrument $02,$0B
	kp_rewind [pat26loop-pat26]
pat27
pat27loop
	kp_settrackregister $01,$00
	kp_setinstrument $04,$0A
	kp_setinstrument $02,$07
	kp_settrackregister $01,$1C
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$40
	kp_setinstrument $02,$01
	kp_settrackregister $01,$10
	kp_setinstrument $04,$0A
	kp_setinstrument $02,$07
	kp_settrackregister $01,$00
	kp_setinstrument $04,$0A
	kp_setinstrument $02,$0B
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$60
	kp_setinstrument $04,$04
	kp_settrackregister $01,$10
	kp_setinstrument $02,$0C
	kp_setinstrument $02,$06
	kp_rewind [pat27loop-pat27]
pat28
pat28loop
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0A
	kp_setinstrument $02,$07
	kp_settrackregister $01,$40
	kp_setinstrument $02,$0C
	kp_settrackregister $01,$24
	kp_setinstrument $02,$0D
	kp_settrackregister $01,$30
	kp_setinstrument $04,$0A
	kp_setinstrument $02,$07
	kp_settrackregister $01,$24
	kp_setinstrument $04,$0A
	kp_setinstrument $02,$0B
	kp_setinstrument $02,$0B
	kp_settrackregister $01,$84
	kp_setinstrument $04,$0D
	kp_settrackregister $01,$30
	kp_setinstrument $02,$0C
	kp_setinstrument $02,$06
	kp_rewind [pat28loop-pat28]
pat29
pat29loop
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0C
	kp_setinstrument $08,$04
	kp_settrackregister $03,$0F
	kp_setinstrument $08,$08
	kp_settrackregister $01,$5C
	kp_setinstrument $08,$08
	kp_settrackregister $01,$54
	kp_setinstrument $04,$08
	kp_settrackregister $01,$40
	kp_setinstrument $04,$08
	kp_rewind [pat29loop-pat29]
pat30
pat30loop
	kp_settrackregister $00,$08
	kp_settrackregister $01,$90
	kp_setinstrument $08,$0F
	kp_settrackregister $01,$8C
	kp_settrackregister $00,$08
	kp_settrackregister $01,$84
	kp_settrackregister $00,$04
	kp_settrackregister $01,$70
	kp_settrackregister $00,$04
	kp_rewind [pat30loop-pat30]
pat31
pat31loop
	kp_settrackregister $01,$84
	kp_settrackregister $03,$0C
	kp_setinstrument $08,$0D
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0F
	kp_setinstrument $08,$08
	kp_settrackregister $01,$5C
	kp_setinstrument $08,$08
	kp_settrackregister $01,$54
	kp_setinstrument $04,$08
	kp_settrackregister $01,$70
	kp_setinstrument $04,$08
	kp_rewind [pat31loop-pat31]
pat32
pat32loop
	kp_settrackregister $00,$08
	kp_settrackregister $01,$90
	kp_setinstrument $08,$0F
	kp_settrackregister $01,$8C
	kp_settrackregister $00,$08
	kp_settrackregister $01,$84
	kp_settrackregister $00,$04
	kp_settrackregister $01,$A0
	kp_settrackregister $00,$04
	kp_rewind [pat32loop-pat32]

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

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
ins1loop
	KP_OSCV $20,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$01
	KP_OSCV $3C,0,1,1,$00
	KP_OSCV $50,0,1,1,$00
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $08,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$01
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $07,$00
vol1loop
	KP_VOLV $04,$00
	KP_VOLJ [vol1loop-vol1]
ins2
ins2loop
	KP_OSCV $28,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $14,0,1,1,$01
	KP_OSCV $44,0,1,1,$00
	KP_OSCV $58,0,1,1,$00
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $08,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$01
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $07,$00
vol2loop
	KP_VOLV $04,$00
	KP_VOLJ [vol2loop-vol2]
ins3
ins3loop
	KP_OSCV $7C,1,0,0,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $60,1,0,0,$00
	KP_OSCV $10,0,1,0,$00
	KP_OSCJ [ins3loop-ins3]

vol3
vol3loop
	KP_VOLV $0A,$00
	KP_VOLJ [vol3loop-vol3]
ins4
ins4loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $10,0,1,1,$01
	KP_OSCV $40,0,1,1,$00
	KP_OSCV $4C,0,1,1,$00
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $08,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$01
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $07,$00
vol4loop
	KP_VOLV $04,$00
	KP_VOLJ [vol4loop-vol4]
ins5
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
ins5loop
	KP_OSCV $00,0,0,0,$00
	KP_OSCJ [ins5loop-ins5]

vol5
	KP_VOLV $0C,$05
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $05,$00
	KP_VOLV $03,$00
vol5loop
	KP_VOLV $01,$00
	KP_VOLJ [vol5loop-vol5]
ins6
ins6loop
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $10,1,0,0,$00
	KP_OSCV $62,0,1,0,$00
	KP_OSCV $5E,0,1,0,$00
	KP_OSCJ [ins6loop-ins6]

vol6
	KP_VOLV $09,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$01
	KP_VOLV $01,$01
vol6loop
	KP_VOLV $00,$00
	KP_VOLJ [vol6loop-vol6]
ins7
ins7loop
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $10,1,0,0,$00
	KP_OSCV $52,0,1,0,$00
	KP_OSCV $4E,0,1,0,$00
	KP_OSCJ [ins7loop-ins7]

vol7
	KP_VOLV $09,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$01
	KP_VOLV $01,$01
vol7loop
	KP_VOLV $00,$00
	KP_VOLJ [vol7loop-vol7]
ins8
ins8loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins8loop-ins8]

vol8
	KP_VOLV $0A,$00
	KP_VOLV $0C,$03
	KP_VOLV $0B,$00
	KP_VOLV $09,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
vol8loop
	KP_VOLV $05,$00
	KP_VOLJ [vol8loop-vol8]
ins9
ins9loop
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins9loop-ins9]

vol9
	KP_VOLV $05,$00
	KP_VOLV $04,$00
vol9loop
	KP_VOLV $03,$00
	KP_VOLJ [vol9loop-vol9]
ins10
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $34,0,1,0,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
ins10loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins10loop-ins10]

vol10
	KP_VOLV $0C,$00
	KP_VOLV $08,$00
	KP_VOLV $0C,$02
	KP_VOLV $0B,$00
	KP_VOLV $09,$00
	KP_VOLV $07,$00
	KP_VOLV $04,$00
vol10loop
	KP_VOLV $03,$00
	KP_VOLJ [vol10loop-vol10]
ins11
	KP_OSCV $08,0,1,0,$00
	KP_OSCV $78,1,0,0,$00
ins11loop
	KP_OSCV $F2,1,0,0,$00
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $FA,1,0,0,$00
	KP_OSCV $E8,1,0,0,$00
	KP_OSCJ [ins11loop-ins11]

vol11
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$01
	KP_VOLV $02,$02
vol11loop
	KP_VOLV $01,$00
	KP_VOLJ [vol11loop-vol11]
ins12
	KP_OSCV $EE,1,0,0,$00
	KP_OSCV $A2,1,0,0,$00
	KP_OSCV $03,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FD,0,1,1,$00
ins12loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins12loop-ins12]

vol12
	KP_VOLV $0C,$00
	KP_VOLV $08,$00
	KP_VOLV $0C,$02
	KP_VOLV $0B,$00
	KP_VOLV $09,$00
	KP_VOLV $07,$00
	KP_VOLV $04,$00
vol12loop
	KP_VOLV $03,$00
	KP_VOLJ [vol12loop-vol12]
ins13
ins13loop
	KP_OSCV $1C,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $30,0,1,1,$01
	KP_OSCV $0C,0,1,1,$01
	KP_OSCV $3C,0,1,1,$00
	KP_OSCV $4C,0,1,1,$00
	KP_OSCJ [ins13loop-ins13]

vol13
	KP_VOLV $08,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$01
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $07,$00
vol13loop
	KP_VOLV $04,$00
	KP_VOLJ [vol13loop-vol13]
ins14
ins14loop
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $2F,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FF,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins14loop-ins14]

vol14
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
vol14loop
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLJ [vol14loop-vol14]
ins15
ins15loop
	KP_OSCV $32,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $2E,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $FE,0,1,1,$00
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins15loop-ins15]

vol15
	KP_VOLV $05,$00
	KP_VOLV $04,$00
vol15loop
	KP_VOLV $03,$00
	KP_VOLJ [vol15loop-vol15]

kp_sequence
	dc.b $00,$01,$02,$00
	dc.b $00,$03,$04,$00
	dc.b $00,$05,$02,$00
	dc.b $00,$03,$04,$00
	dc.b $00,$06,$07,$00
	dc.b $00,$08,$09,$00
	dc.b $00,$0A,$0B,$00
	dc.b $00,$0C,$0D,$00
	dc.b $00,$0E,$0F,$00
	dc.b $00,$10,$09,$00
	dc.b $00,$11,$0B,$00
	dc.b $00,$12,$0D,$00
	dc.b $00,$13,$0F,$00
	dc.b $00,$14,$09,$00
	dc.b $00,$15,$16,$00
	dc.b $00,$17,$18,$00
	dc.b $00,$17,$18,$00
	dc.b $00,$14,$09,$00
	dc.b $00,$15,$16,$00
	dc.b $00,$17,$18,$00
	dc.b $00,$19,$1A,$00
	dc.b $00,$03,$1B,$00
	dc.b $00,$05,$1B,$00
	dc.b $00,$03,$1C,$00
	dc.b $00,$05,$1C,$00
	dc.b $00,$03,$1B,$00
	dc.b $00,$05,$1B,$00
	dc.b $00,$03,$1C,$00
	dc.b $00,$06,$1C,$00
	dc.b $00,$1D,$09,$00
	dc.b $00,$1E,$0B,$00
	dc.b $00,$1F,$0D,$00
	dc.b $00,$20,$0F,$00
	dc.b $00,$1D,$09,$00
	dc.b $00,$1E,$0B,$00
	dc.b $00,$1F,$0D,$00
	dc.b $00,$20,$0F,$00
	dc.b $ff
	dc.w $0080

