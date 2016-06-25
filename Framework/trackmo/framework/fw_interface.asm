fw_jumptable			EQU $0200


fw_load					EQU fw_jumptable + 0
fw_decrunch				EQU fw_jumptable + 3
fw_topirq_install		EQU fw_jumptable + 6
fw_topirq_handler		EQU fw_jumptable + 9

fw_lowirq_install		EQU fw_jumptable + 12
fw_lowirq_handler		EQU fw_jumptable + 15

fw_initplayer			EQU fw_jumptable + 18


fw_settings				EQU fw_jumptable + 21


fw_framecounter			EQU fw_settings + 0
fw_bgcolor				EQU fw_settings + 2
	
fw_isloading			EQU fw_settings + 3
fw_isdecrunching		EQU fw_settings + 4

fw_singleclock			EQU fw_settings + 5
	
fw_topirq_rasterline	EQU fw_settings + 6
fw_topirq_plugin		EQU fw_settings + 8

fw_lowirq_rasterline	EQU fw_settings + 10
fw_lowirq_plugin		EQU fw_settings + 12
	
fw_load_start			EQU fw_settings + 14
fw_load_end				EQU fw_settings + 16

fw_song_off				EQU fw_settings + 18

kp_pattern_counter		EQU fw_settings + 19
kp_beat_counter			EQU fw_settings + 20
kp_pulse_var			EQU fw_settings + 21
kp_pulse_callback 		EQU fw_settings + 22
kp_volumetable_address		EQU fw_settings + 24

	MAC WAIT_FRAMENUMBER

	lda #<{1}
	cmp fw_framecounter
	bne .0
	lda #>{1}
	cmp fw_framecounter+1
.0	
	ENDM



	MAC WAIT_FRAMENUMBER_OR_HIGHER

.0	
	lda fw_framecounter+1
	cmp #>{1}
	bcs .1
	jmp .0
.1	
	lda fw_framecounter
	cmp #<{1}
	bcs .2
	jmp .0
.2	
	
	ENDM



	MAC WAIT_VBLANK

	lda fw_framecounter
.0	cmp fw_framecounter
	beq .0

	ENDM
	
	
	MAC TOPIRQ_INSTALL_PLUGIN
	
	lda #<{1}
	sta fw_topirq_plugin
	lda #>{1}
	sta fw_topirq_plugin+1
	
	ENDM



	MAC TOPIRQ_REMOVE_PLUGIN
	
	lda #$00
	sta fw_topirq_plugin
	sta fw_topirq_plugin+1
	
	ENDM


	MAC LOWIRQ_INSTALL_PLUGIN
	
	lda #<{1}
	sta fw_lowirq_plugin
	lda #>{1}
	sta fw_lowirq_plugin+1
	
	ENDM



	MAC LOWIRQ_REMOVE_PLUGIN
	
	lda #$00
	sta fw_lowirq_plugin
	sta fw_lowirq_plugin+1
	
	ENDM
	
	
	
	MAC PLUGIN_CANCELDEFAULT
	
	pla
	pla
	
	ENDM
