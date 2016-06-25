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
	dc.b $05
	dc.b $07
	dc.b $04
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
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$98
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
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
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$98
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_setinstrument $02,$01
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $01,$98
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$98
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
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$0C
	kp_settrackregister $01,$00
	kp_setinstrument $0C,$02
	kp_setinstrument $08,$02
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $00,$0C
	kp_settrackregister $01,$0C
	kp_settrackregister $03,$0F
	kp_setinstrument $0C,$02
	kp_setinstrument $08,$02
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $00,$0C
	kp_settrackregister $01,$1C
	kp_setinstrument $0C,$02
	kp_settrackregister $01,$28
	kp_setinstrument $08,$02
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $03,$08
	kp_setinstrument $04,$03
	kp_setinstrument $04,$03
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$03
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_setinstrument $02,$03
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$06
	kp_setinstrument $02,$06
	kp_setinstrument $02,$06
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$06
	kp_rewind [pat7loop-pat7]
pat8
pat8loop
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $04,$06
	kp_setinstrument $04,$03
	kp_setinstrument $06,$05
	kp_setinstrument $02,$05
	kp_setinstrument $04,$07
	kp_setinstrument $06,$05
	kp_setinstrument $02,$05
	kp_rewind [pat8loop-pat8]
pat9
pat9loop
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$07
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$07
	kp_setinstrument $04,$03
	kp_setinstrument $02,$03
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0A
	kp_setinstrument $04,$03
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $02,$05
	kp_setinstrument $02,$07
	kp_setinstrument $04,$04
	kp_rewind [pat9loop-pat9]
pat10
pat10loop
	kp_setinstrument $04,$07
	kp_setinstrument $02,$07
	kp_setinstrument $02,$03
	kp_setinstrument $04,$05
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$07
	kp_setinstrument $02,$03
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$07
	kp_setinstrument $02,$06
	kp_setinstrument $02,$05
	kp_setinstrument $02,$07
	kp_setinstrument $02,$06
	kp_rewind [pat10loop-pat10]
pat11
pat11loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$07
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$06
	kp_setinstrument $02,$07
	kp_settrackregister $03,$0A
	kp_setinstrument $04,$06
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0A
	kp_setinstrument $02,$06
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$07
	kp_rewind [pat11loop-pat11]
pat12
pat12loop
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$07
	kp_setinstrument $02,$06
	kp_setinstrument $04,$07
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$06
	kp_setinstrument $04,$07
	kp_setinstrument $02,$07
	kp_setinstrument $02,$06
	kp_setinstrument $02,$07
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$06
	kp_setinstrument $02,$05
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$07
	kp_rewind [pat12loop-pat12]
pat13
pat13loop
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$60
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$60
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$58
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$58
	kp_setinstrument $02,$01
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$60
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$01
	kp_rewind [pat13loop-pat13]
pat14
pat14loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$03
	kp_settrackregister $01,$30
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$06
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $0C,$02
	kp_setinstrument $02,$02
	kp_settrackregister $01,$30
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$01
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_rewind [pat14loop-pat14]
pat15
pat15loop
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$58
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$58
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$58
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$58
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$60
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$60
	kp_setinstrument $02,$01
	kp_rewind [pat15loop-pat15]
pat16
pat16loop
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$01
	kp_settrackregister $01,$30
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$05
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $0C,$02
	kp_setinstrument $02,$02
	kp_settrackregister $01,$30
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$01
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_rewind [pat16loop-pat16]
pat17
pat17loop
	kp_settrackregister $00,$02
	kp_settrackregister $01,$3C
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$03
	kp_settrackregister $01,$0C
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $06,$02
	kp_setinstrument $02,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$04
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $01,$3C
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$01
	kp_settrackregister $01,$0C
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_rewind [pat17loop-pat17]
pat18
pat18loop
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$4C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$58
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$58
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_setinstrument $02,$01
	kp_rewind [pat18loop-pat18]
pat19
pat19loop
	kp_settrackregister $00,$04
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $08,$02
	kp_settrackregister $01,$3C
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$01
	kp_settrackregister $01,$20
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$01
	kp_settrackregister $01,$28
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$01
	kp_settrackregister $01,$58
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$00
	kp_settrackregister $00,$01
	kp_settrackregister $01,$28
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_rewind [pat19loop-pat19]
pat20
pat20loop
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$60
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$60
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_rewind [pat20loop-pat20]
pat21
pat21loop
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$88
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$90
	kp_setinstrument $02,$01
	kp_rewind [pat21loop-pat21]
pat22
pat22loop
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$AC
	kp_setinstrument $02,$01
	kp_settrackregister $01,$6C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$AC
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$B8
	kp_setinstrument $02,$01
	kp_settrackregister $01,$7C
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$B8
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_settrackregister $01,$68
	kp_settrackregister $03,$09
	kp_setinstrument $02,$01
	kp_settrackregister $01,$9C
	kp_setinstrument $02,$01
	kp_rewind [pat22loop-pat22]

kp_insmap_lo
	dc.b #<insnil
	dc.b #<ins1
	dc.b #<ins2
	dc.b #<ins3
	dc.b #<ins4
	dc.b #<ins5
	dc.b #<ins6
	dc.b #<ins7

kp_insmap_hi
	dc.b #>insnil
	dc.b #>ins1
	dc.b #>ins2
	dc.b #>ins3
	dc.b #>ins4
	dc.b #>ins5
	dc.b #>ins6
	dc.b #>ins7

kp_volmap_lo
	dc.b #<volnil
	dc.b #<vol1
	dc.b #<vol2
	dc.b #<vol3
	dc.b #<vol4
	dc.b #<vol5
	dc.b #<vol6
	dc.b #<vol7

kp_volmap_hi
	dc.b #>volnil
	dc.b #>vol1
	dc.b #>vol2
	dc.b #>vol3
	dc.b #>vol4
	dc.b #>vol5
	dc.b #>vol6
	dc.b #>vol7

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
	KP_OSCV $90,0,1,0,$00
ins1loop
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$02
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $0A,$00
	KP_VOLV $0E,$00
	KP_VOLV $0A,$00
	KP_VOLV $07,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
vol1loop
	KP_VOLV $02,$00
	KP_VOLJ [vol1loop-vol1]
ins2
ins2loop
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $01,0,1,1,$01
	KP_OSCV $02,0,1,1,$01
	KP_OSCV $01,0,1,1,$01
	KP_OSCV $00,0,1,1,$01
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $07,$05
	KP_VOLV $08,$04
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
	KP_OSCV $FC,1,0,0,$00
	KP_OSCV $3C,0,1,0,$00
	KP_OSCV $FA,1,0,0,$00
	KP_OSCV $FC,1,0,0,$00
	KP_OSCV $FD,1,0,0,$00
	KP_OSCV $F8,1,0,0,$00
ins3loop
	KP_OSCV $FA,1,0,0,$00
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $0E,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $06,$00
	KP_VOLV $04,$00
vol3loop
	KP_VOLV $01,$03
	KP_VOLJ [vol3loop-vol3]
ins4
	KP_OSCV $F2,1,0,0,$00
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $F1,1,0,0,$00
	KP_OSCV $F2,1,0,0,$00
	KP_OSCV $F4,1,0,0,$00
ins4loop
	KP_OSCV $FC,1,0,0,$01
	KP_OSCJ [ins4loop-ins4]

vol4
vol4loop
	KP_VOLV $0E,$01
	KP_VOLV $04,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$01
	KP_VOLV $00,$02
	KP_VOLV $0E,$00
	KP_VOLV $04,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$01
	KP_VOLV $00,$01
	KP_VOLJ [vol4loop-vol4]
ins5
	KP_OSCV $F4,1,0,0,$00
	KP_OSCV $60,0,1,0,$00
	KP_OSCV $EF,1,0,0,$00
	KP_OSCV $F2,1,0,0,$00
	KP_OSCV $FC,1,0,0,$00
	KP_OSCV $FA,1,0,0,$00
	KP_OSCV $F8,1,0,0,$00
ins5loop
	KP_OSCV $FA,1,0,0,$00
	KP_OSCJ [ins5loop-ins5]

vol5
	KP_VOLV $0F,$00
	KP_VOLV $0E,$02
	KP_VOLV $08,$00
	KP_VOLV $06,$00
	KP_VOLV $04,$00
	KP_VOLV $02,$00
vol5loop
	KP_VOLV $01,$00
	KP_VOLJ [vol5loop-vol5]
ins6
	KP_OSCV $F9,1,0,0,$00
ins6loop
	KP_OSCV $E2,1,0,0,$00
	KP_OSCJ [ins6loop-ins6]

vol6
	KP_VOLV $0C,$00
	KP_VOLV $04,$00
vol6loop
	KP_VOLV $00,$00
	KP_VOLJ [vol6loop-vol6]
ins7
	KP_OSCV $18,0,1,0,$00
	KP_OSCV $0E,0,1,0,$00
	KP_OSCV $0A,0,1,0,$00
	KP_OSCV $05,0,1,0,$00
ins7loop
	KP_OSCV $00,0,1,0,$00
	KP_OSCV $00,1,0,0,$00
	KP_OSCJ [ins7loop-ins7]

vol7
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
vol7loop
	KP_VOLV $00,$00
	KP_VOLJ [vol7loop-vol7]

kp_sequence
	dc.b $00,$01,$00,$00
	dc.b $00,$02,$00,$00
	dc.b $00,$01,$00,$00
	dc.b $00,$03,$00,$00
	dc.b $00,$01,$04,$00
	dc.b $00,$02,$04,$00
	dc.b $00,$01,$05,$00
	dc.b $00,$03,$06,$00
	dc.b $00,$01,$04,$00
	dc.b $00,$02,$04,$00
	dc.b $00,$01,$05,$00
	dc.b $00,$03,$06,$00
	dc.b $00,$01,$04,$00
	dc.b $00,$02,$04,$00
	dc.b $00,$01,$05,$00
	dc.b $00,$03,$06,$00
	dc.b $00,$01,$04,$00
	dc.b $00,$02,$04,$00
	dc.b $00,$01,$05,$00
	dc.b $00,$03,$06,$00
	dc.b $00,$01,$04,$00
	dc.b $00,$02,$04,$00
	dc.b $00,$01,$05,$00
	dc.b $00,$03,$06,$00
	dc.b $00,$0D,$0E,$00
	dc.b $00,$0F,$10,$00
	dc.b $00,$0D,$11,$00
	dc.b $00,$12,$13,$00
	dc.b $00,$14,$0E,$00
	dc.b $00,$15,$10,$00
	dc.b $00,$14,$11,$00
	dc.b $00,$16,$13,$00
	dc.b $00,$14,$0E,$00
	dc.b $00,$15,$10,$00
	dc.b $00,$14,$11,$00
	dc.b $00,$16,$13,$00
	dc.b $00,$14,$0E,$00
	dc.b $00,$15,$10,$00
	dc.b $00,$14,$11,$00
	dc.b $00,$16,$13,$00
	dc.b $00,$0D,$00,$00
	dc.b $00,$0F,$00,$00
	dc.b $00,$0D,$00,$00
	dc.b $00,$12,$00,$00
	dc.b $ff
	dc.w $0010

