	MAC LOAD_NORMAL
.nochmal
	jsr fw_load
	bcs .nochmal
	ENDM
	