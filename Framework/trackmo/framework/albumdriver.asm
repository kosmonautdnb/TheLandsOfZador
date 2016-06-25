

	MAC playatline
.loop0
		lda $ff1c
		and #$01
		cmp #>{1}
		bne .loop0

		lda #<{1}
.loop1
		cmp $ff1d
		bne .loop1
	
		lda $ff1d
.loop2
		cmp $ff1d
		beq .loop2

		inc $ff19
		jsr kp_output
		dec $ff19
	ENDM	
	
	MAC execplayer

		lda $ff1d
		sta .saverasterline
		
		inc $ff19
		jsr kp_tick
		dec $ff19
	
		sec
		lda $ff1d
.saverasterline = .+1
		sbc #$00
		sta $0ffe
		cmp $0fff
		bcc .notmax
		sta $0fff
.notmax	
	
	ENDM
	
	




    processor   6502

	ORG $1001
	DC.W $100B,0
	DC.B $9E,"4109",0,0,0	; SYS4107
	JMP main

main SUBROUTINE
	sei
    sta $ff3f

	lda #$00
	sta $ff0a
	sta $ff0b

	lda #$00
	sta $ff19
	lda #$00
	sta $ff15

	lda #$0b
	sta $ff06
	
	lda #$00
	sta $0fff
	
	lda #$00
	jsr kp_reset
	
	
	lda kp_speed
	asl
	tax
	lda playtab,x
	sta .loop+1
	inx
	lda playtab,x
	sta .loop+2

	cli
	
.loop	
	jsr play_3x

	jmp .loop
	
	
	
play_1x SUBROUTINE

	playatline $00cd
	execplayer

	rts	
	
play_2x SUBROUTINE

	playatline $0130
	playatline $00cd
	execplayer

	rts	

play_3x SUBROUTINE

	playatline $0130
	playatline $0060
	playatline $00cd
	execplayer
	rts	

play_4x SUBROUTINE

	playatline $0120
	playatline $0030
	playatline $0090
	playatline $00cd
	execplayer

	rts	

playtab
	dc.w $0000
	dc.w play_1x	
	dc.w play_2x	
	dc.w play_3x	
	dc.w play_4x	

TUNE_START = .
	include "player.asm"
TUNE_END = .
  echo "endmark: ",[$054d + [TUNE_END-TUNE_START]]
	
	
	

	
