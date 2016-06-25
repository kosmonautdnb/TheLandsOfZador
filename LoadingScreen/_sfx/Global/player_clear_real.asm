	include "player_symbols.asm"

	include "player_const.asm"

songoff
	lda #$01
	sta fw_song_off
	jsr waitFrame

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

	rts

array1Pos = kp_vol_mod0_0 - 3
array2Pos = kp_vol_mod0_1 - 3
array3Pos = kp_vol_mod0_2 - 3

kp_clear

	lda #$00
	sta kp_pattern_counter

	lda #$ff
	sta kp_osc_wait_0
	sta kp_osc_wait_1
	sta kp_osc_wait_2
	sta kp_vol_wait_0
	sta kp_vol_wait_1
	sta kp_vol_wait_2

	ldy #11-1
.hey
	sta array1Pos,y
	sta array2Pos,y
	sta array3Pos,y
	dey
	bpl .hey

	lda #$0f
	sta kp_vol_mod0_0                  
	sta kp_vol_mod0_1                  
	sta kp_vol_mod0_2                       
	sta kp_vol_mod0_0 + 1
	sta kp_vol_mod0_1 + 1                  
	sta kp_vol_mod0_2 + 1                       
	rts
