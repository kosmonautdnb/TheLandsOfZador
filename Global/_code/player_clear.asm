	include "player_symbols.asm"

kp_clear SUBROUTINE

	;lda #$04
	;sta kp_pat_wait_0
	;sta kp_pat_wait_1
	;sta kp_pat_wait_2

	lda #$ff
	sta kp_osc_wait_0
	sta kp_osc_wait_1
	sta kp_osc_wait_2
	sta kp_vol_wait_0
	sta kp_vol_wait_1
	sta kp_vol_wait_2
	;sta kp_vol_mod0_0
	;sta kp_vol_mod0_1
	;sta kp_vol_mod0_2
	;sta kp_osc_pos_0
	;sta kp_osc_pos_1
	;sta kp_osc_pos_2
	;sta kp_vol_pos_0
	;sta kp_vol_pos_1
	;sta kp_vol_pos_2

	;ldx #$00
	;lda #<INSNIL2
	;sta kp_osc_adr_0_0,x
	;sta kp_osc_adr_1_0,x
	;sta kp_osc_adr_0_1,x
	;sta kp_osc_adr_1_1,x
	;sta kp_osc_adr_0_2,x
	;sta kp_osc_adr_1_2,x
	;lda #<VOLNIL2
	;sta kp_vol_adr_0_0,x
	;sta kp_vol_adr_0_1,x
	;sta kp_vol_adr_0_2,x

	;ldx #$01
	;lda #>INSNIL2
	;sta kp_osc_adr_0_0,x
	;sta kp_osc_adr_1_0,x
	;sta kp_osc_adr_0_1,x
	;sta kp_osc_adr_1_1,x
	;sta kp_osc_adr_0_2,x
	;sta kp_osc_adr_1_2,x
	;lda #>VOLNIL2
	;sta kp_vol_adr_0_0,x
	;sta kp_vol_adr_0_1,x
	;sta kp_vol_adr_0_2,x

	rts