	MAC kp_setsongregister
		dc.b {2},[$00 | [{1} << 2]]
	ENDM
	
	MAC kp_settrackregister
		dc.b {2},[$01 | [{1} << 2]]
	ENDM

	MAC kp_setinstrument
		dc.b {2},[$02 | [{1} << 2]]
	ENDM

	MAC kp_rewind
		dc.b 0,[$03]
	ENDM




	MAC KP_OSCV
		dc.b {1},[[{2} & $01] << 6] | [[{3} & $01] << 5] | [[{4} & $01] << 4] | [{5} & %00001111]
	ENDM
	
	MAC KP_OSCJ
		dc.b $00,[{1} | %10000000]
	ENDM
	
	MAC KP_VOLV
		dc.b [ [{1} & %00001111] | [[{2} & %00000111] << 4] ]
	ENDM
	
	MAC KP_VOLJ
		dc.b [{1} | %10000000]
	ENDM