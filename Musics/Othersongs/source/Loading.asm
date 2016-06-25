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
	dc.b $06
	dc.b $05
	dc.b $07
	dc.b $05
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

kp_patternmap_hi
	dc.b #>patnil
	dc.b #>pat1
	dc.b #>pat2
	dc.b #>pat3

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $01,$2C
	kp_settrackregister $03,$0E
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $01,$24
	kp_settrackregister $03,$0E
	kp_setinstrument $02,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$04
	kp_settrackregister $01,$5C
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $01,$50
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$04
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$04
	kp_settrackregister $01,$54
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $01,$50
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $01,$40
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $01,$48
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$04
	kp_settrackregister $01,$50
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $01,$2C
	kp_settrackregister $03,$0B
	kp_setinstrument $02,$03
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$05
	kp_settrackregister $03,$07
	kp_settrackregister $00,$01
	kp_settrackregister $03,$09
	kp_settrackregister $00,$01
	kp_settrackregister $03,$07
	kp_settrackregister $00,$05
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $01,$04
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$01
	kp_settrackregister $03,$0F
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0D
	kp_settrackregister $00,$1C
	kp_rewind [pat3loop-pat3]

kp_insmap_lo
	dc.b #<insnil
	dc.b #<ins1
	dc.b #<ins2
	dc.b #<ins3

kp_insmap_hi
	dc.b #>insnil
	dc.b #>ins1
	dc.b #>ins2
	dc.b #>ins3

kp_volmap_lo
	dc.b #<volnil
	dc.b #<vol1
	dc.b #<vol2
	dc.b #<vol3

kp_volmap_hi
	dc.b #>volnil
	dc.b #>vol1
	dc.b #>vol2
	dc.b #>vol3

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
ins1loop
	KP_OSCV $1C,0,1,1,$02
	KP_OSCV $24,0,1,1,$02
	KP_OSCV $30,0,1,1,$02
	KP_OSCV $40,0,1,1,$02
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $0A,$01
	KP_VOLV $08,$01
	KP_VOLV $07,$01
	KP_VOLV $06,$01
	KP_VOLV $05,$01
vol1loop
	KP_VOLV $04,$00
	KP_VOLJ [vol1loop-vol1]
ins2
	KP_OSCV $00,0,1,1,$05
ins2loop
	KP_OSCV $00,0,1,1,$03
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $07,$02
	KP_VOLV $06,$01
	KP_VOLV $05,$00
vol2loop
	KP_VOLV $02,$00
	KP_VOLJ [vol2loop-vol2]
ins3
	KP_OSCV $24,0,1,1,$01
	KP_OSCV $00,0,1,1,$00
ins3loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $08,$00
vol3loop
	KP_VOLV $07,$00
	KP_VOLJ [vol3loop-vol3]

kp_sequence
	dc.b $00,$01,$02,$00
	dc.b $00,$01,$03,$00
	dc.b $ff
	dc.w $0008

