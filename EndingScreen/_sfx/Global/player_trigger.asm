	include "player_symbols.asm"

kp_triggerC SUBROUTINE
	; x = instrument
	; y = volume

	lda #$04
	sta kp_pat_wait_2

	lda kp_insmap_lo,x
	sta kp_osc_adr_0_2
	sta kp_osc_adr_1_2
	lda kp_insmap_hi,x
	sta kp_osc_adr_0_2+1
	sta kp_osc_adr_1_2+1

	lda kp_volmap_lo,x
	sta kp_vol_adr_0_2
	lda kp_volmap_hi,x
	sta kp_vol_adr_0_2+1

	lda #$00
	sta kp_osc_wait_2
	sta kp_osc_pos_2
	sta kp_vol_wait_2
	sta kp_vol_pos_2
	
	sty kp_vol_mod0_2

	
	rts
; ----------------------------------------------	
;kp_triggerB SUBROUTINE
	; x = instrument
	; y = volume

;	lda #$04
;	sta kp_pat_wait_1

;	lda kp_insmap_lo,x
;	sta kp_osc_adr_0_1
;	sta kp_osc_adr_1_1
;	lda kp_insmap_hi,x
;	sta kp_osc_adr_0_1+1
;	sta kp_osc_adr_1_1+1

;	lda kp_volmap_lo,x
;	sta kp_vol_adr_0_1
;	lda kp_volmap_hi,x
;	sta kp_vol_adr_0_1+1

;	lda #$00
;	sta kp_osc_wait_1
;	sta kp_osc_pos_1
;	sta kp_vol_wait_1
;	sta kp_vol_pos_1
	
;	sty kp_vol_mod0_1

	
;	rts

