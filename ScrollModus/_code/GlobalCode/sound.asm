SOUND_DIAMOND = 0
SOUND_EXPLOSION = 1
SOUND_COLLECTED = 2
SOUND_JUMP = 3
SOUND_LAZER = 4
SOUND_HIT = 5
SOUND_LITTLEJUMP = 6
SOUND_FADEINOUT = 7
SOUND_DASH = 8
SOUND_FLOOR = 9
SOUND_LIVELOST = 5
SOUND_KICK = 2
SOUND_SCHALTER = 4
SOUND_LAYERBUILD = 8
SOUND_LAYERREMOVE = 9
SOUND_DROP = 2

;------------------------------------------------------------------------------------------
;-- triggers a sound																	 --
;-- accu: sound number																	 --
;------------------------------------------------------------------------------------------
triggerSound SUBROUTINE
	stx .xrestore + 1
	sty .yrestore + 1
	tax
	lda disablePlayerInteraction
	bne .xrestore
	lda #$00
	sta lastSoundTrigger
	ldy #$0f
	jsr kp_triggerC
.xrestore
	ldx #$44
.yrestore
	ldy #$44
	rts

;------------------------------------------------------------------------------------------
;-- triggers a sound only if on screen													 --
;-- accu: sound number																	 --
;------------------------------------------------------------------------------------------
triggerSoundScreen SUBROUTINE
	jsr triggerSound
	rts

	include "player_symbols.asm"
	include "player_const.asm"

;------------------------------------------------------------------------------------------
;-- internal function triggers sound on mixin voice										 --
;------------------------------------------------------------------------------------------
kp_triggerC SUBROUTINE
	; x = instrument
	; y = volume
	sei
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
	cli

	rts
