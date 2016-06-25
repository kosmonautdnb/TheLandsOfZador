	include "player_symbols.asm"

	include "player_const.asm"

INSNIL2
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
VOLNIL2
	KP_VOLV 0,15
	KP_VOLJ 0

songoff
	lda #$01
	sta fw_song_off

	; disable both voices by setting the highest frequency
	lda #$fe
	sta $ff0e
	sta $ff0f
	lda #$03
	sta $ff10
	lda $ff12
	and #%11111100
	ora #$03
	sta $ff12

	lda #$00
	sta $ff11

	jsr waitFrame
	rts

kp_clear SUBROUTINE
	lda #$ff
	sta kp_osc_wait_0
	sta kp_osc_wait_1
	sta kp_osc_wait_2
	sta kp_vol_wait_0
	sta kp_vol_wait_1
	sta kp_vol_wait_2
	lda #$ff
	sta kp_pat_wait_0
	sta kp_pat_wait_1
	sta kp_pat_wait_2
	lda #$00
	sta kp_vol_mod0_0
;	sta kp_vol_mod0_1
	sta kp_vol_mod0_2
	rts

kp_triggerA2 SUBROUTINE
	; x = instrument
	; y = volume

	lda #$04
	sta kp_pat_wait_0

	lda kp_insmap_lo,x
	sta kp_osc_adr_0_0
	sta kp_osc_adr_1_0
	lda kp_insmap_hi,x
	sta kp_osc_adr_0_0+1
	sta kp_osc_adr_1_0+1

	lda kp_volmap_lo,x
	sta kp_vol_adr_0_0
	lda kp_volmap_hi,x
	sta kp_vol_adr_0_0+1

	lda #$00
	sta kp_osc_wait_0
	sta kp_osc_pos_0
	sta kp_vol_wait_0
	sta kp_vol_pos_0
	
	sty kp_vol_mod0_0
	rts

kp_triggerB2 SUBROUTINE
	; x = instrument
	; y = volume

	lda #$04
	sta kp_pat_wait_1

	lda kp_insmap_lo,x
	sta kp_osc_adr_0_1
	sta kp_osc_adr_1_1
	lda kp_insmap_hi,x
	sta kp_osc_adr_0_1+1
	sta kp_osc_adr_1_1+1

	lda kp_volmap_lo,x
	sta kp_vol_adr_0_1
	lda kp_volmap_hi,x
	sta kp_vol_adr_0_1+1

	lda #$00
	sta kp_osc_wait_1
	sta kp_osc_pos_1
	sta kp_vol_wait_1
	sta kp_vol_pos_1
	
	sty kp_vol_mod0_1
	rts
