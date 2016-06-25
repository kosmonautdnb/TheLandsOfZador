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

kp_patternmap_hi
	dc.b #>patnil
	dc.b #>pat1

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$00
	kp_setinstrument $01,$01
	kp_rewind [pat1loop-pat1]

kp_insmap_lo
	dc.b #<insnil
	dc.b #<ins1

kp_insmap_hi
	dc.b #>insnil
	dc.b #>ins1

kp_volmap_lo
	dc.b #<volnil
	dc.b #<vol1

kp_volmap_hi
	dc.b #>volnil
	dc.b #>vol1

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
ins1loop
	KP_OSCV $00,1,0,0,$00
	KP_OSCV $00,0,0,0,$00
	KP_OSCJ [ins1loop-ins1]

vol1
vol1loop
	KP_VOLV $0F,$00
	KP_VOLJ [vol1loop-vol1]

kp_sequence
	dc.b $00,$01,$01,$01
	dc.b $ff
	dc.w $0004

