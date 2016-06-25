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
	dc.b #<pat2

kp_patternmap_hi
	dc.b #>patnil
	dc.b #>pat1
	dc.b #>pat2

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $03,$0F
	kp_setinstrument $01,$01
	kp_setinstrument $01,$02
	kp_setinstrument $01,$03
	kp_setinstrument $01,$04
	kp_setinstrument $01,$05
	kp_setinstrument $01,$06
	kp_setinstrument $01,$07
	kp_setinstrument $01,$08
	kp_setinstrument $01,$09
	kp_setinstrument $03,$0A
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$44
	kp_settrackregister $03,$0F
	kp_setinstrument $0D,$0A
	kp_rewind [pat2loop-pat2]

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

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
	KP_OSCV $90,0,1,0,$00
	KP_OSCV $C8,0,1,0,$00
	KP_OSCV $B4,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $7C,0,1,0,$00
	KP_OSCV $A4,0,1,0,$00
ins1loop
	KP_OSCV $74,0,0,0,$00
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $0F,$05
vol1loop
	KP_VOLV $00,$00
	KP_VOLJ [vol1loop-vol1]
ins2
	KP_OSCV $5C,0,1,0,$00
	KP_OSCV $44,0,1,0,$00
	KP_OSCV $B4,1,0,0,$02
	KP_OSCV $8C,1,0,0,$01
	KP_OSCV $44,0,1,0,$01
	KP_OSCV $1C,1,0,0,$00
	KP_OSCV $14,1,0,0,$00
	KP_OSCV $68,1,0,0,$02
	KP_OSCV $08,0,1,0,$03
ins2loop
	KP_OSCV $08,1,0,0,$00
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
vol2loop
	KP_VOLV $00,$00
	KP_VOLJ [vol2loop-vol2]
ins3
	KP_OSCV $30,0,1,0,$00
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $40,0,1,0,$00
	KP_OSCV $44,0,1,0,$00
	KP_OSCV $4C,1,0,0,$00
	KP_OSCV $54,1,0,0,$00
	KP_OSCV $5C,1,0,0,$00
	KP_OSCV $60,0,1,0,$00
	KP_OSCV $68,0,1,0,$00
	KP_OSCV $70,0,1,0,$00
	KP_OSCV $74,0,1,0,$00
	KP_OSCV $7C,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $8C,0,1,0,$00
	KP_OSCV $60,0,1,0,$01
	KP_OSCV $70,0,1,0,$00
	KP_OSCV $7C,0,1,0,$00
ins3loop
	KP_OSCV $AC,0,1,0,$00
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $03,$00
	KP_VOLV $04,$00
	KP_VOLV $05,$00
	KP_VOLV $06,$00
	KP_VOLV $07,$00
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$01
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
vol3loop
	KP_VOLV $00,$00
	KP_VOLJ [vol3loop-vol3]
ins4
	KP_OSCV $14,0,1,0,$00
	KP_OSCV $1C,0,1,0,$00
	KP_OSCV $24,0,1,0,$00
	KP_OSCV $2C,0,1,0,$00
	KP_OSCV $30,0,1,0,$00
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $40,0,1,0,$00
	KP_OSCV $44,0,1,0,$00
	KP_OSCV $4C,0,1,0,$00
	KP_OSCV $54,0,1,0,$00
ins4loop
	KP_OSCV $5C,0,0,0,$00
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $0E,$01
	KP_VOLV $0F,$07
vol4loop
	KP_VOLV $00,$00
	KP_VOLJ [vol4loop-vol4]
ins5
	KP_OSCV $BC,0,1,0,$00
	KP_OSCV $AC,0,1,0,$00
	KP_OSCV $A4,0,1,0,$00
	KP_OSCV $A0,0,1,0,$00
	KP_OSCV $68,0,1,0,$00
	KP_OSCV $54,0,1,0,$00
	KP_OSCV $4C,0,1,0,$00
	KP_OSCV $44,0,1,0,$00
	KP_OSCV $40,0,1,0,$00
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $2C,0,1,0,$00
	KP_OSCV $24,0,1,0,$00
	KP_OSCV $1C,0,1,0,$00
	KP_OSCV $14,0,1,0,$00
	KP_OSCV $10,0,1,0,$00
	KP_OSCV $08,0,1,0,$00
ins5loop
	KP_OSCV $00,0,1,0,$00
	KP_OSCJ [ins5loop-ins5]

vol5
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
vol5loop
	KP_VOLV $00,$00
	KP_VOLJ [vol5loop-vol5]
ins6
	KP_OSCV $60,0,1,0,$00
	KP_OSCV $68,0,1,0,$00
	KP_OSCV $70,0,1,0,$00
	KP_OSCV $68,0,1,0,$00
	KP_OSCV $70,0,1,0,$00
	KP_OSCV $74,0,1,0,$00
	KP_OSCV $70,0,1,0,$00
	KP_OSCV $74,0,1,0,$00
	KP_OSCV $7C,0,1,0,$00
	KP_OSCV $74,0,1,0,$00
	KP_OSCV $7C,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $74,0,1,0,$00
	KP_OSCV $7C,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $7C,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $8C,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $8C,0,1,0,$00
	KP_OSCV $90,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $8C,0,1,0,$00
	KP_OSCV $90,0,1,0,$00
ins6loop
	KP_OSCV $90,0,1,0,$00
	KP_OSCJ [ins6loop-ins6]

vol6
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $0B,$00
	KP_VOLV $0C,$00
	KP_VOLV $0D,$00
	KP_VOLV $0E,$00
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
vol6loop
	KP_VOLV $00,$00
	KP_VOLJ [vol6loop-vol6]
ins7
	KP_OSCV $60,0,1,0,$00
	KP_OSCV $54,0,1,0,$00
	KP_OSCV $4C,0,1,0,$00
	KP_OSCV $40,0,1,0,$00
	KP_OSCV $38,0,1,0,$00
	KP_OSCV $40,0,1,0,$00
	KP_OSCV $44,0,1,0,$00
	KP_OSCV $40,0,1,0,$00
ins7loop
	KP_OSCV $38,0,1,0,$00
	KP_OSCJ [ins7loop-ins7]

vol7
	KP_VOLV $03,$00
	KP_VOLV $04,$00
	KP_VOLV $05,$00
	KP_VOLV $06,$00
	KP_VOLV $0A,$00
	KP_VOLV $08,$00
	KP_VOLV $09,$00
	KP_VOLV $0A,$00
vol7loop
	KP_VOLV $00,$00
	KP_VOLJ [vol7loop-vol7]
ins8
	KP_OSCV $D0,0,1,0,$00
	KP_OSCV $C8,0,1,0,$00
	KP_OSCV $98,0,1,0,$00
	KP_OSCV $7C,0,1,0,$00
	KP_OSCV $74,0,1,0,$00
	KP_OSCV $68,0,0,0,$00
ins8loop
	KP_OSCV $60,0,0,0,$00
	KP_OSCJ [ins8loop-ins8]

vol8
	KP_VOLV $03,$00
	KP_VOLV $04,$00
	KP_VOLV $05,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
vol8loop
	KP_VOLV $03,$00
	KP_VOLJ [vol8loop-vol8]
ins9
	KP_OSCV $60,0,1,0,$00
	KP_OSCV $30,0,1,0,$00
	KP_OSCV $70,0,1,0,$00
	KP_OSCV $40,0,1,0,$00
	KP_OSCV $7C,0,1,0,$00
	KP_OSCV $84,0,1,0,$00
	KP_OSCV $A0,0,1,0,$00
	KP_OSCV $90,0,1,0,$00
	KP_OSCV $98,0,1,0,$00
ins9loop
	KP_OSCV $90,0,1,0,$00
	KP_OSCJ [ins9loop-ins9]

vol9
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
vol9loop
	KP_VOLV $00,$00
	KP_VOLJ [vol9loop-vol9]
ins10
	KP_OSCV $74,1,0,0,$00
	KP_OSCV $70,1,0,0,$00
	KP_OSCV $68,1,0,0,$00
	KP_OSCV $60,1,0,0,$00
	KP_OSCV $4C,1,0,0,$00
	KP_OSCV $44,1,0,0,$00
ins10loop
	KP_OSCV $40,1,0,0,$00
	KP_OSCJ [ins10loop-ins10]

vol10
	KP_VOLV $0F,$00
	KP_VOLV $0E,$00
	KP_VOLV $0D,$00
	KP_VOLV $0C,$00
	KP_VOLV $0B,$00
	KP_VOLV $0A,$00
vol10loop
	KP_VOLV $00,$00
	KP_VOLJ [vol10loop-vol10]

kp_sequence
	dc.b $00,$00,$00,$01
	dc.b $00,$00,$00,$02
	dc.b $ff
	dc.w $0008

