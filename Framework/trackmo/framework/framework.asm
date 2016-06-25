	processor 6502

	ORG $0200
		
framework_begin		

SAFETY_OFFSET = $08

;-------------------------------------------------------------------------------
; interface
;-------------------------------------------------------------------------------
jumptable

					jmp load
					jmp decrunch
				
					jmp topirq_install
					jmp topirq_handler
				
					jmp lowirq_install
					jmp lowirq_handler
					
					jmp initplayer
						
framecounter		dc.w $0000
bgcolor				dc.b $00
	
isloading			dc.b $00
isdecrunching		dc.b $00	

singleclock			dc.b $00
	
topirq_rasterline	dc.w $0130
topirq_plugin		dc.w $0000

lowirq_rasterline	dc.w $00d0
lowirq_plugin		dc.w $0000
	
load_start			dc.w $0000
load_end			dc.w $0000		

song_off               dc.b $00

kp_pattern_counter		dc.b $00
kp_beat_counter			dc.b $00
kp_pulse_var			dc.b $00
kp_pulse_callback 		dc.w $00
kp_volumetable_address		dc.w $00

;-------------------------------------------------------------------------------


	
	
	ECHO "!!!!!LOADERADDRESS: ",.
	include "loader.asm"

    include "exodecrunch.s"
    include "irqhandler.asm"

initplayer SUBROUTINE
	;pha
	;lda #<kp_dynamics
	;sta kp_volumetable_address + 0
	;lda #>kp_dynamics
	;sta kp_volumetable_address + 1
	;pla
	cmp #$00
	beq .defsong
	jmp kp_reset
	
.defsong	
	ldx #<kp_reloc
	ldy #>kp_reloc
	jmp kp_reset
	
    echo "player_begin: ",.
    include "player.asm"
    
    ;echo "song2: ",.
    ;	org $133e
    ;	incbin "song2.prg"




framework_end
	
	ECHO "FRAMEWORK-SIZE: ", framework_end-framework_begin
	ECHO "end of framework: ",.

    
