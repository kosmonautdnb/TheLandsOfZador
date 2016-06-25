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
	dc.b $07
	dc.b $05
	dc.b $07
	dc.b $05
	dc.b $05
	dc.b $04
	dc.b $06
	dc.b $04
kp_patternlen
	dc.b $2F

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

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $0C,$01
	kp_settrackregister $01,$14
	kp_setinstrument $04,$01
	kp_setinstrument $02,$01
	kp_setinstrument $02,$01
	kp_setinstrument $04,$01
	kp_settrackregister $01,$1C
	kp_setinstrument $18,$01
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $0C,$02
	kp_settrackregister $01,$14
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$03
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$03
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $01,$1C
	kp_setinstrument $0C,$02
	kp_settrackregister $01,$08
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_settrackregister $01,$14
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$02
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $0C,$01
	kp_settrackregister $01,$28
	kp_setinstrument $04,$01
	kp_setinstrument $02,$01
	kp_setinstrument $02,$01
	kp_settrackregister $01,$14
	kp_setinstrument $04,$01
	kp_settrackregister $01,$1C
	kp_setinstrument $18,$01
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $0C,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$01
	kp_setinstrument $02,$01
	kp_setinstrument $02,$01
	kp_settrackregister $01,$28
	kp_setinstrument $04,$01
	kp_settrackregister $01,$1C
	kp_setinstrument $14,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$84
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_settrackregister $01,$74
	kp_setinstrument $04,$04
	kp_settrackregister $01,$84
	kp_setinstrument $04,$04
	kp_settrackregister $01,$7C
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$A0
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$A4
	kp_setinstrument $04,$04
	kp_settrackregister $01,$A0
	kp_setinstrument $02,$04
	kp_settrackregister $01,$98
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_rewind [pat7loop-pat7]
pat8
pat8loop
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_settrackregister $01,$74
	kp_setinstrument $04,$04
	kp_settrackregister $01,$84
	kp_setinstrument $04,$04
	kp_settrackregister $01,$7C
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$06
	kp_rewind [pat8loop-pat8]
pat9
pat9loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$90
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$98
	kp_settrackregister $00,$02
	kp_settrackregister $01,$A0
	kp_settrackregister $00,$02
	kp_settrackregister $01,$A4
	kp_settrackregister $00,$02
	kp_settrackregister $01,$A0
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_settrackregister $01,$90
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$AC
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_settrackregister $01,$98
	kp_setinstrument $04,$04
	kp_settrackregister $01,$A4
	kp_setinstrument $06,$04
	kp_settrackregister $01,$A0
	kp_setinstrument $02,$04
	kp_settrackregister $01,$98
	kp_setinstrument $04,$04
	kp_rewind [pat9loop-pat9]
pat10
pat10loop
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$04
	kp_settrackregister $01,$90
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$8C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$90
	kp_settrackregister $00,$02
	kp_settrackregister $01,$98
	kp_settrackregister $00,$02
	kp_settrackregister $01,$8C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$84
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$98
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$06
	kp_rewind [pat10loop-pat10]
pat11
pat11loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$A4
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$A0
	kp_settrackregister $00,$02
	kp_settrackregister $01,$A4
	kp_settrackregister $00,$02
	kp_settrackregister $01,$AC
	kp_settrackregister $00,$02
	kp_settrackregister $01,$98
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$90
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_settrackregister $01,$8C
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_settrackregister $01,$90
	kp_setinstrument $04,$04
	kp_settrackregister $01,$A0
	kp_setinstrument $06,$04
	kp_settrackregister $01,$90
	kp_setinstrument $02,$04
	kp_settrackregister $01,$98
	kp_setinstrument $04,$04
	kp_rewind [pat11loop-pat11]
pat12
pat12loop
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$04
	kp_settrackregister $01,$90
	kp_settrackregister $03,$0D
	kp_setinstrument $02,$04
	kp_settrackregister $01,$8C
	kp_settrackregister $00,$02
	kp_settrackregister $01,$90
	kp_settrackregister $00,$02
	kp_settrackregister $01,$98
	kp_settrackregister $00,$02
	kp_settrackregister $01,$8C
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$02
	kp_settrackregister $01,$84
	kp_settrackregister $03,$0D
	kp_setinstrument $04,$04
	kp_settrackregister $01,$74
	kp_setinstrument $04,$04
	kp_settrackregister $01,$7C
	kp_setinstrument $06,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$06
	kp_rewind [pat12loop-pat12]
pat13
pat13loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$07
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$5C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$5C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$07
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_rewind [pat13loop-pat13]
pat14
pat14loop
	kp_settrackregister $01,$58
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$07
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$5C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$0B
	kp_settrackregister $03,$08
	kp_settrackregister $00,$0C
	kp_rewind [pat14loop-pat14]
pat15
pat15loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$07
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$5C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$07
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_rewind [pat15loop-pat15]
pat16
pat16loop
	kp_settrackregister $01,$58
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$07
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$03
	kp_settrackregister $01,$4C
	kp_settrackregister $03,$0D
	kp_setinstrument $01,$04
	kp_settrackregister $03,$0A
	kp_settrackregister $00,$0B
	kp_settrackregister $03,$08
	kp_settrackregister $00,$0C
	kp_rewind [pat16loop-pat16]
pat17
pat17loop
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $0C,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$01
	kp_setinstrument $02,$01
	kp_setinstrument $02,$01
	kp_settrackregister $01,$28
	kp_setinstrument $04,$01
	kp_settrackregister $01,$1C
	kp_setinstrument $18,$01
	kp_rewind [pat17loop-pat17]

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
ins1loop
	KP_OSCV $30,0,1,1,$02
	KP_OSCV $40,0,1,1,$02
	KP_OSCV $4C,0,1,1,$02
	KP_OSCV $60,0,1,1,$02
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$01
	KP_VOLV $02,$02
vol1loop
	KP_VOLV $01,$00
	KP_VOLJ [vol1loop-vol1]
ins2
	KP_OSCV $28,0,1,0,$00
	KP_OSCV $0C,0,1,0,$00
	KP_OSCV $00,0,1,0,$00
	KP_OSCV $00,0,1,1,$05
ins2loop
	KP_OSCV $00,0,1,1,$03
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0C,$00
	KP_VOLV $07,$02
	KP_VOLV $06,$01
	KP_VOLV $05,$00
vol2loop
	KP_VOLV $02,$00
	KP_VOLJ [vol2loop-vol2]
ins3
	KP_OSCV $00,0,1,1,$05
ins3loop
	KP_OSCV $00,0,1,1,$03
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $07,$02
	KP_VOLV $06,$01
	KP_VOLV $05,$00
vol3loop
	KP_VOLV $02,$00
	KP_VOLJ [vol3loop-vol3]
ins4
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$00
ins4loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $08,$00
vol4loop
	KP_VOLV $07,$00
	KP_VOLJ [vol4loop-vol4]

kp_sequence
	dc.b $00,$01,$02,$00
	dc.b $00,$03,$02,$00
	dc.b $00,$01,$02,$00
	dc.b $00,$04,$02,$00
	dc.b $00,$05,$02,$00
	dc.b $00,$06,$02,$00
	dc.b $00,$07,$02,$00
	dc.b $00,$08,$02,$00
	dc.b $00,$09,$02,$00
	dc.b $00,$0A,$02,$00
	dc.b $00,$0B,$02,$00
	dc.b $00,$0C,$02,$00
	dc.b $00,$0D,$02,$00
	dc.b $00,$0E,$02,$00
	dc.b $00,$0F,$02,$00
	dc.b $00,$10,$02,$00
	dc.b $00,$09,$02,$00
	dc.b $00,$0A,$02,$00
	dc.b $00,$0B,$02,$00
	dc.b $00,$0C,$02,$00
	dc.b $00,$01,$02,$00
	dc.b $00,$03,$02,$00
	dc.b $00,$01,$02,$00
	dc.b $00,$11,$02,$00
	dc.b $ff
	dc.w $0060

