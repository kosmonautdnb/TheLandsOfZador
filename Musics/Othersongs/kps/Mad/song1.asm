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

;kp_song_registers_occ0 = .+1	
;
;kp_speed_occ0 = .+1
;kp_speed_occ1 = .+1
;
;kp_grooveboxpos_occ0 = .+1	
;kp_grooveboxpos_occ1 = .+1	
;
;kp_grooveboxlen_occ0 = .+1	
;kp_groovebox_occ0 = .+1
;
;kp_patternlen_occ0 = .+1	
;
;kp_patternmap_lo_occ0 = .+1	
;kp_patternmap_lo_occ1 = .+1	
;kp_patternmap_lo_occ2 = .+1	
;
;kp_patternmap_hi_occ0 = .+1	
;kp_patternmap_hi_occ1 = .+1	
;kp_patternmap_hi_occ2 = .+1	
;
;
;kp_sequence_addr
;
;
;
;
;

KP_ZP0	EQU $08
KP_ZP1	EQU $09
KP_ZP2	EQU $0a

kp_tedwrite				dc.b $00
kp_tedread				dc.b $00
	
kp_tickstonextbeat		dc.b $00	
	
kp_beatstonextpattern	dc.b $00	
	
kp_sequence_addr		dc.w $0000


kp_ff0e			ds.b 4,$00
kp_ff0f			ds.b 4,$00
kp_ff10			ds.b 4,$00
kp_ff11			ds.b 4,$00
kp_ff12			ds.b 4,$00






kp_reset SUBROUTINE
	stx KP_ZP0
	sty KP_ZP0+1

	ldy #$00
	lda (KP_ZP0),y
	sta kp_song_registers_occ0
	sta kp_song_registers_occ1
	sta kp_song_registers_occ2
	iny
	lda (KP_ZP0),y
	sta kp_song_registers_occ0+1
	sta kp_song_registers_occ1+1
	sta kp_song_registers_occ2+1

	iny
	lda (KP_ZP0),y
	sta kp_speed_occ0
	sta kp_speed_occ1
	iny
	lda (KP_ZP0),y
	sta kp_speed_occ0+1
	sta kp_speed_occ1+1
		
	iny
	lda (KP_ZP0),y
	sta kp_grooveboxpos_occ0
	sta kp_grooveboxpos_occ1
	iny
	lda (KP_ZP0),y
	sta kp_grooveboxpos_occ0+1
	sta kp_grooveboxpos_occ1+1

	iny
	lda (KP_ZP0),y
	sta kp_grooveboxlen_occ0
	iny
	lda (KP_ZP0),y
	sta kp_grooveboxlen_occ0+1

	iny
	lda (KP_ZP0),y
	sta kp_groovebox_occ0
	iny
	lda (KP_ZP0),y
	sta kp_groovebox_occ0+1

	iny
	lda (KP_ZP0),y
	sta kp_patternlen_occ0
	iny
	lda (KP_ZP0),y
	sta kp_patternlen_occ0+1

	iny
	lda (KP_ZP0),y
	sta kp_patternmap_lo_occ0
	sta kp_patternmap_lo_occ1
	sta kp_patternmap_lo_occ2
	iny
	lda (KP_ZP0),y
	sta kp_patternmap_lo_occ0+1
	sta kp_patternmap_lo_occ1+1
	sta kp_patternmap_lo_occ2+1

	iny
	lda (KP_ZP0),y
	sta kp_patternmap_hi_occ0
	sta kp_patternmap_hi_occ1
	sta kp_patternmap_hi_occ2
	iny
	lda (KP_ZP0),y
	sta kp_patternmap_hi_occ0+1
	sta kp_patternmap_hi_occ1+1
	sta kp_patternmap_hi_occ2+1

	iny
	lda (KP_ZP0),y
	sta kp_insmap_lo_occ0
	sta kp_insmap_lo_occ1
	sta kp_insmap_lo_occ2
	iny
	lda (KP_ZP0),y
	sta kp_insmap_lo_occ0+1
	sta kp_insmap_lo_occ1+1
	sta kp_insmap_lo_occ2+1

	iny
	lda (KP_ZP0),y
	sta kp_insmap_hi_occ0
	sta kp_insmap_hi_occ1
	sta kp_insmap_hi_occ2
	iny
	lda (KP_ZP0),y
	sta kp_insmap_hi_occ0+1
	sta kp_insmap_hi_occ1+1
	sta kp_insmap_hi_occ2+1

	iny
	lda (KP_ZP0),y
	sta kp_volmap_lo_occ0
	sta kp_volmap_lo_occ1
	sta kp_volmap_lo_occ2
	iny
	lda (KP_ZP0),y
	sta kp_volmap_lo_occ0+1
	sta kp_volmap_lo_occ1+1
	sta kp_volmap_lo_occ2+1

	iny
	lda (KP_ZP0),y
	sta kp_volmap_hi_occ0
	sta kp_volmap_hi_occ1
	sta kp_volmap_hi_occ2
	iny
	lda (KP_ZP0),y
	sta kp_volmap_hi_occ0+1
	sta kp_volmap_hi_occ1+1
	sta kp_volmap_hi_occ2+1

	iny
	lda (KP_ZP0),y
	sta kp_sequence_addr
	iny
	lda (KP_ZP0),y
	sta kp_sequence_addr+1

	rts


;#############################################################################################
;
; song abspielen
; ausgabe berechnen
;
;#############################################################################################
kp_tick SUBROUTINE


	lda #$00
	sta [kp_tedwrite]
	sta [kp_tedread]
	
kp_tickloop	


	;--------------------------------------------
	; immer noch im selben beat:
	; nur instrumente ausfhren
	;--------------------------------------------
	lda [kp_tickstonextbeat]
	beq .nextbeat

	dec [kp_tickstonextbeat]

	jsr kp_track_ins_0
	jsr kp_track_ins_1
	jsr kp_track_ins_2
	jmp kp_mixer

	;--------------------------------------------

	
.nextbeat
	;--------------------------------------------
	; groovebox: anzahl der ticks fr den
	; n„chsten beat
	;--------------------------------------------
kp_grooveboxpos_occ0 = .+1	
	ldx $FFFF
	inx
kp_grooveboxlen_occ0 = .+1	
	cpx $FFFF
	bcc .grooveok

	ldx #$00
.grooveok	
kp_grooveboxpos_occ1 = .+1	
	stx $FFFF
kp_groovebox_occ0 = .+1	
	lda $FFFF,x
	sta kp_tickstonextbeat
	;--------------------------------------------
	


	;--------------------------------------------
	; noch im selben pattern:
	; pattern und instrumente ausfhren
	;--------------------------------------------
	lda [kp_beatstonextpattern]
	beq .nextpattern
	
	dec [kp_beatstonextpattern]

	jmp kp_tick_patterns
	;--------------------------------------------

.nextpattern

	;--------------------------------------------
	; alles: nächste seq,pat,ins
	;--------------------------------------------
kp_patternlen_occ0 = .+1	
	lda $FFFF
	sta [kp_beatstonextpattern]
	;--------------------------------------------



;#############################################################################################
; sequenzer
;#############################################################################################
kp_tick_sequence  SUBROUTINE

	lda [kp_sequence_addr]
	sta KP_ZP0
	lda [kp_sequence_addr + 1]
	sta KP_ZP0+1

	ldy #$00
	lda (KP_ZP0),y
	bpl .setpatterns
	
.rewind
	sec	
	lda KP_ZP0
	iny
	sbc (KP_ZP0),y
	sta [kp_sequence_addr]
	lda KP_ZP0+1
	iny
	sbc (KP_ZP0),y
	sta [kp_sequence_addr +1 ]
	
	jmp kp_tick_sequence
	
.setpatterns
	iny 
	lda (KP_ZP0),y
	tax
kp_patternmap_lo_occ0 = .+1	
	lda $ffff,x
	sta kp_patadr_0_0
	sta kp_patadr_1_0
kp_patternmap_hi_occ0 = .+1	
	lda $ffff,x
	sta kp_patadr_0_0+1
	sta kp_patadr_1_0+1
	
	iny 
	lda (KP_ZP0),y
	tax
kp_patternmap_lo_occ1 = .+1
	lda $ffff,x
	sta kp_patadr_0_1
	sta kp_patadr_1_1
kp_patternmap_hi_occ1 = .+1	
	lda $ffff,x
	sta kp_patadr_0_1+1
	sta kp_patadr_1_1+1


	iny 
	lda (KP_ZP0),y
	tax
kp_patternmap_lo_occ2 = .+1
	lda $ffff,x
	sta kp_patadr_0_2
	sta kp_patadr_1_2
kp_patternmap_hi_occ2 = .+1	
	lda $ffff,x
	sta kp_patadr_0_2+1
	sta kp_patadr_1_2+1
	

	lda #$00
	sta kp_pat_wait_0
	sta kp_pat_wait_1
	sta kp_pat_wait_2
	sta kp_patpos_0
	sta kp_patpos_1
	sta kp_patpos_2

	clc
	lda KP_ZP0
	adc #$04
	sta [kp_sequence_addr]
	lda KP_ZP0+1
	adc #$00
	sta [kp_sequence_addr + 1]


;#############################################################################################
; patterns
;#############################################################################################
kp_tick_patterns SUBROUTINE
	jsr kp_track_0
	jsr kp_track_1
	jsr kp_track_2
kp_tick_patterns_return





;#############################################################################################
; mixer
;#############################################################################################
	; mixer...
kp_mixer	
	; entscheiden, ob ein mixin stattfindet
	ldx kp_out_vol_2
	beq .skipmixin		; stimme 3 hat vol=0, hier gibt es nichts zu tun
	
	lda kp_out_flags_2
	and #%01000000
	bne .check1			; stimme 3 verwendet noise. den check auf stimme 0 können wir uns schenken
	
	cpx kp_out_vol_0
	bcc .check1
	
	; stimme 0 bekommt den mixin
	stx kp_out_vol_0
	lda kp_out_flags_2
	sta kp_out_flags_0
	lda kp_out_freq_2
	sta kp_out_freq_0
	jmp .skipmixin
	
.check1
	cpx kp_out_vol_1
	bcc .skipmixin	

	; stimme 1 bekommt den mixin
	stx kp_out_vol_1
	lda kp_out_flags_2
	sta kp_out_flags_1
	lda kp_out_freq_2
	sta kp_out_freq_1
.skipmixin	

	; lautstärke entscheiden (lauteste stimme gewinnt, zu leise stimmen werden abgeworfen
	
	lda kp_out_vol_0
	cmp kp_out_vol_1
	bcc .0isless
.0isgreater
	sta .finalvol
	
	lda kp_out_vol_1
	clc
	adc #$03
	sec
	sbc kp_out_vol_0
	bpl .mixingdone		; stimme 1 wird nicht abgeworfen, mixen fertig
	
	lda #$00
	sta kp_out_flags_1
	jmp .mixingdone
.0isless		
	ldx kp_out_vol_1
	stx .finalvol

	clc
	adc #$03
	sec
	sbc kp_out_vol_1
	bpl .mixingdone
	
	lda #$00
	sta kp_out_flags_0
	
.mixingdone
;	lda kp_out_vol_1
;	sta .finalvol
	ldx .finalvol
	lda kp_dynamics,x
	sta .finalvol
	
	ldx kp_tedwrite
	
	lda kp_out_flags_0
	and #%00100000
	lsr
.finalvol = .+1
	ora #$00
	sta KP_ZP0

	lda kp_out_flags_1
	and #%01100000
	
	ora KP_ZP0
	sta kp_ff11,x
	;-------------------------------------------

	

.ch0
	ldy kp_out_freq_0
	lda player_freqtab_lo,y
	sta kp_ff0e,x
	tya
	lsr
	lsr
	tay
	lda player_freqtab_hi,y
	sta kp_ff12,x
.ch0_end
		

.ch1
	ldy kp_out_freq_1
	lda player_freqtab_lo,y
	sta kp_ff0f,x
	tya
	lsr
	lsr
	tay
	lda player_freqtab_hi,y
	sta kp_ff10,x
.ch1_end


	
.endmixer	
	
	inc kp_tedwrite
	lda kp_tedwrite
kp_speed_occ0 = .+1
	cmp $ffff
	beq .exit
	
	
	jmp kp_tickloop

	
.exit	
	rts


kp_dynamics
	dc.b $00,$01,$01,$02,$02,$03,$03,$04
	dc.b $05,$05,$06,$06,$07,$07,$08,$08

kp_output	SUBROUTINE
	ldx kp_tedread
kp_speed_occ1 = .+1
	cpx $FFFF
	bcs .exit
	lda #$00
	lda kp_ff0e,x
	sta $ff0e
	lda kp_ff0f,x
	sta $ff0f
	lda kp_ff10,x
	sta $ff10
	lda kp_ff11,x
	sta $ff11
	lda $ff12
	and #%11111100
	ora kp_ff12,x
	sta $ff12


	inc kp_tedread
.exit
	rts
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	






	MAC kp_trackinstance

;###########################################################
;### process pattern data
;###########################################################

kp_track_{0}	
kp_patpos_{1} = .+1
	ldy #$00

.pat_next
	lda .pat_wait
	beq .pat_waitcomplete
	dec .pat_wait
	jmp .pat_end

.pat_waitcomplete

kp_patadr_0_{1} = .+1
	lda $1234,y
	sta KP_ZP1
	iny
kp_patadr_1_{1} = .+1
	lda $1234,y
	iny

	lsr
	bcs .bx1
.bx0
	lsr 
	bcs .b10

.b00 ; setsongregister -------------------------
	tax
	lda KP_ZP1
kp_song_registers_occ{1} = .+1
	sta $ffff,x
	jmp .pat_next
; ----------------------------------------------	

.b10 ; setinstrument ---------------------------
	sta .pat_wait
	ldx KP_ZP1	
kp_insmap_lo_occ{1} = .+1
	lda $ffff,x
	sta .osc_adr_0
	sta .osc_adr_1
kp_insmap_hi_occ{1} = .+1
	lda $ffff,x
	sta .osc_adr_0+1
	sta .osc_adr_1+1

kp_volmap_lo_occ{1} = .+1
	lda $ffff,x
	sta .vol_adr_0
kp_volmap_hi_occ{1} = .+1
	lda $ffff,x
	sta .vol_adr_0+1

	lda #$00
	sta .osc_wait
	sta .osc_pos
	sta .vol_wait
	sta .vol_pos
	jmp .pat_next	
; ----------------------------------------------	


.bx1
	lsr
	bcs .b11
.b01 ; settrackregister	------------------------
	tax	
	lda KP_ZP1
	sta .track_registers,x
	jmp .pat_next
; ----------------------------------------------

	
.b11 ; rewind ----------------------------------
	ldy KP_ZP1
	jmp .pat_next	
; ----------------------------------------------	



.pat_end
	sty kp_patpos_{1}
;###########################################################



kp_track_ins_{0}	
;###########################################################
;### process oscillator control-data
;### 
;### xxxxxxxx cnptwwww
;### 
;###########################################################
.osc_pos = .+1
	ldy #$00

.osc_wait = .+1
	lda #$00
	beq .osc_waitcomplete
	dec .osc_wait
	jmp .osc_end

.osc_waitcomplete

.osc_adr_0 = .+1
	lda $1234,y
	sta .osc_freq
	iny
.osc_adr_1 = .+1
	lda $1234,y
	bpl .osc_freqvalue

.osc_jumpvalue ; -------------------------------
	iny
	and #%01111111
	tay
	jmp .osc_waitcomplete
; ----------------------------------------------	

.osc_freqvalue ; -------------------------------
	iny
	sta .osc_flags
	and #%00001111
	sta .osc_wait
; ----------------------------------------------	

	sty .osc_pos

.osc_end
;###########################################################

	
;###########################################################
;### process volume-envelope data
;### 
;### cwwwvvvv
;### 
;###########################################################
.vol_pos = .+1
	ldy #$00

.vol_wait = .+1
	lda #$00
	beq .vol_waitcomplete
	dec .vol_wait
	jmp .vol_end

.vol_waitcomplete

.vol_adr_0 = .+1
	lda $ffff,y
	bpl .vol_volvalue

.vol_jumpvalue ; -------------------------------
	and #%01111111
	tay
	jmp .vol_waitcomplete
; ----------------------------------------------	

.vol_volvalue ; --------------------------------
	iny
	tax
	and #%00001111
	sta .osc_vol
	txa
	and #%01110000
	lsr
	lsr
	lsr
	lsr
	sta .vol_wait
; ----------------------------------------------	

	sty .vol_pos
.vol_end
;###########################################################



;###########################################################
;### ausgabewert ermitteln
;###########################################################
	ldx .osc_freq
	
	lda .osc_flags
	sta .out_flags
	and #%00010000 ; transpose!?
	beq .notranspose

	clc
	txa
	adc .frq_mod0
	clc
	adc .frq_mod1
	tax	
.notranspose
	stx .out_freq
	
	lda .osc_vol
	beq .noamp		; lautstärke
	
	clc
	adc .vol_mod0
	clc
	adc .vol_mod1
	sec
	sbc #$1e
	bpl .noamp
	lda #$00
.noamp
	sta .out_vol	
	
	bne .hasvol ; lautstärke = 0 => stimme abschalten
	lda .out_flags
	and #%10011111
	sta .out_flags
.hasvol	
	
	rts
	
;###########################################################
;### track registers
;###########################################################

.track_registers	
kp_pat_wait_{1} = .
.pat_wait	dc.b $00
.frq_mod0	dc.b $00
.frq_mod1	dc.b $00
.vol_mod0	dc.b $0f
.vol_mod1	dc.b $0f
.osc_freq	dc.b $00
.osc_vol	dc.b $00
.osc_flags	dc.b $00

kp_out_flags_{1} = .
.out_flags	dc.b $00
kp_out_freq_{1} = .
.out_freq	dc.b $00
kp_out_vol_{1} = .
.out_vol	dc.b $00
;###########################################################

	ENDM
kp_track0		
	kp_trackinstance 0
	
kp_track1
	kp_trackinstance 1

kp_track2
	kp_trackinstance 2

player_freqtab_lo
	dc.b $00,$0F,$1D,$2C,$3A,$48,$55,$63,$70,$7D,$8A,$97,$A3,$B0,$BC,$C8
	dc.b $D3,$DF,$EB,$F6,$01,$0C,$17,$22,$2C,$37,$41,$4B,$55,$5F,$68,$72
	dc.b $7B,$84,$8D,$96,$9F,$A8,$B1,$B9,$C1,$CA,$D2,$DA,$E2,$E9,$F1,$F9
	dc.b $00,$07,$0F,$16,$1D,$24,$2B,$31,$38,$3F,$45,$4B,$52,$58,$5E,$64
	dc.b $6A,$70,$75,$7B,$81,$86,$8B,$91,$96,$9B,$A0,$A5,$AA,$AF,$B4,$B9
	dc.b $BE,$C2,$C7,$CB,$D0,$D4,$D8,$DD,$E1,$E5,$E9,$ED,$F1,$F5,$F9,$FC
	dc.b $00,$04,$07,$0B,$0E,$12,$15,$19,$1C,$1F,$22,$26,$29,$2C,$2F,$32
	dc.b $35,$38,$3B,$3D,$40,$43,$46,$48,$4B,$4E,$50,$53,$55,$58,$5A,$5C
	dc.b $5F,$61,$63,$66,$68,$6A,$6C,$6E,$70,$72,$74,$76,$78,$7A,$7C,$7E
	dc.b $80,$82,$84,$85,$87,$89,$8B,$8C,$8E,$90,$91,$93,$94,$96,$97,$99
	dc.b $9A,$9C,$9D,$9F,$A0,$A2,$A3,$A4,$A6,$A7,$A8,$A9,$AB,$AC,$AD,$AE
	dc.b $AF,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF
	dc.b $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$Ca,$Cb,$Cc,$cd,$ce,$ef
	dc.b $d0,$d1,$d2,$d3,$d4,$d5,$d6,$d7,$d8,$d9,$da,$db,$dc,$dd,$de,$df
	dc.b $e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$e8,$e9,$ea,$eb,$ec,$ed,$ee,$ef
	dc.b $f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe,$ff

player_freqtab_hi
;	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;	dc.b $00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;	dc.b $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;	dc.b $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
;	dc.b $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
;	dc.b $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
;	dc.b $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03

	dc.b $00,            $00,            $00,            $00            
	dc.b $00,            $01,            $01,            $01            
	dc.b $01,            $01,            $01,            $01            
	dc.b $02,            $02,            $02,            $02            
	dc.b $02,            $02,            $02,            $02            
	dc.b $02,            $02,            $02,            $02            
	dc.b $03,            $03,            $03,            $03            
	dc.b $03,            $03,            $03,            $03            
	dc.b $03,            $03,            $03,            $03            
	dc.b $03,            $03,            $03,            $03            
	dc.b $03,            $03,            $03,            $03            
	dc.b $03,            $03,            $03,            $03            
	dc.b $03,            $03,            $03,            $03            
	dc.b $03,            $03,            $03,            $03            
	dc.b $03,            $03,            $03,            $03            
	dc.b $03,            $03,            $03,            $03            


.song
kp_song
kp_reloc
	dc.w kp_song_registers
	dc.w kp_speed
	dc.w kp_grooveboxpos
	dc.w kp_grooveboxlen
	dc.w kp_groovebox
	dc.w kp_patternlen
	dc.w kp_patternmap_lo
	dc.w kp_patternmap_hi
	dc.w kp_insmap_lo
	dc.w kp_insmap_hi
	dc.w kp_volmap_lo
	dc.w kp_volmap_hi
	dc.w kp_sequence
kp_song_registers
kp_speed
	dc.b $02
kp_grooveboxpos
	dc.b $00
kp_grooveboxlen
	dc.b $04
kp_groovebox
	dc.b $03
	dc.b $07
	dc.b $07
	dc.b $03
	dc.b $05
	dc.b $04
	dc.b $06
	dc.b $04
kp_patternlen
	dc.b $2F

kp_patternmap_lo
	dc.b #<patnil
	dc.b #<pat1
	dc.b #<pat2
	dc.b #<pat3
	dc.b #<pat4
	dc.b #<pat5
	dc.b #<pat6
	dc.b #<pat7

kp_patternmap_hi
	dc.b #>patnil
	dc.b #>pat1
	dc.b #>pat2
	dc.b #>pat3
	dc.b #>pat4
	dc.b #>pat5
	dc.b #>pat6
	dc.b #>pat7

patnil
	kp_setinstrument 8,0
	kp_settrackregister 0,16
	kp_rewind $00
pat1
pat1loop
	kp_settrackregister $01,$24
	kp_setinstrument $04,$01
	kp_settrackregister $01,$40
	kp_setinstrument $04,$01
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$01
	kp_settrackregister $01,$24
	kp_setinstrument $04,$01
	kp_settrackregister $01,$40
	kp_setinstrument $04,$01
	kp_settrackregister $01,$4C
	kp_setinstrument $04,$01
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$01
	kp_settrackregister $01,$38
	kp_setinstrument $04,$01
	kp_settrackregister $01,$44
	kp_setinstrument $04,$01
	kp_settrackregister $01,$1C
	kp_setinstrument $04,$01
	kp_settrackregister $01,$38
	kp_setinstrument $04,$01
	kp_settrackregister $01,$44
	kp_setinstrument $04,$01
	kp_rewind [pat1loop-pat1]
pat2
pat2loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$02
	kp_settrackregister $01,$24
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $04,$02
	kp_settrackregister $01,$1C
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$02
	kp_settrackregister $01,$08
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $04,$02
	kp_settrackregister $01,$14
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $04,$02
	kp_rewind [pat2loop-pat2]
pat3
pat3loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$01
	kp_settrackregister $01,$24
	kp_setinstrument $04,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$01
	kp_settrackregister $01,$10
	kp_setinstrument $04,$01
	kp_settrackregister $01,$24
	kp_setinstrument $04,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$01
	kp_settrackregister $01,$14
	kp_setinstrument $04,$01
	kp_settrackregister $01,$24
	kp_setinstrument $04,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$01
	kp_settrackregister $01,$14
	kp_setinstrument $04,$01
	kp_settrackregister $01,$24
	kp_setinstrument $04,$01
	kp_settrackregister $01,$30
	kp_setinstrument $04,$01
	kp_rewind [pat3loop-pat3]
pat4
pat4loop
	kp_settrackregister $01,$10
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$02
	kp_settrackregister $01,$24
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$02
	kp_settrackregister $01,$00
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $04,$02
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$02
	kp_settrackregister $01,$14
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $04,$02
	kp_settrackregister $01,$08
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $03,$08
	kp_setinstrument $02,$02
	kp_settrackregister $01,$14
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$02
	kp_settrackregister $01,$08
	kp_setinstrument $04,$02
	kp_rewind [pat4loop-pat4]
pat5
pat5loop
	kp_settrackregister $03,$0F
	kp_settrackregister $00,$20
	kp_settrackregister $00,$08
	kp_setinstrument $04,$03
	kp_setinstrument $04,$04
	kp_rewind [pat5loop-pat5]
pat6
pat6loop
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$05
	kp_setinstrument $04,$04
	kp_setinstrument $04,$03
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $04,$04
	kp_setinstrument $04,$03
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $04,$04
	kp_setinstrument $04,$03
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$03
	kp_rewind [pat6loop-pat6]
pat7
pat7loop
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $04,$04
	kp_setinstrument $04,$03
	kp_setinstrument $02,$06
	kp_settrackregister $03,$0E
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $04,$04
	kp_setinstrument $04,$03
	kp_setinstrument $02,$04
	kp_settrackregister $03,$0C
	kp_setinstrument $02,$03
	kp_settrackregister $03,$0F
	kp_setinstrument $04,$07
	kp_setinstrument $04,$08
	kp_setinstrument $04,$03
	kp_setinstrument $04,$09
	kp_rewind [pat7loop-pat7]

kp_insmap_lo
	dc.b #<insnil
	dc.b #<ins1
	dc.b #<ins2
	dc.b #<ins3
	dc.b #<ins4
	dc.b #<ins5
	dc.b #<ins6
	dc.b #<ins7
	dc.b #<ins8
	dc.b #<ins9

kp_insmap_hi
	dc.b #>insnil
	dc.b #>ins1
	dc.b #>ins2
	dc.b #>ins3
	dc.b #>ins4
	dc.b #>ins5
	dc.b #>ins6
	dc.b #>ins7
	dc.b #>ins8
	dc.b #>ins9

kp_volmap_lo
	dc.b #<volnil
	dc.b #<vol1
	dc.b #<vol2
	dc.b #<vol3
	dc.b #<vol4
	dc.b #<vol5
	dc.b #<vol6
	dc.b #<vol7
	dc.b #<vol8
	dc.b #<vol9

kp_volmap_hi
	dc.b #>volnil
	dc.b #>vol1
	dc.b #>vol2
	dc.b #>vol3
	dc.b #>vol4
	dc.b #>vol5
	dc.b #>vol6
	dc.b #>vol7
	dc.b #>vol8
	dc.b #>vol9

insnil
	KP_OSCV 0,0,0,0,15
	KP_OSCJ 0
volnil
	KP_VOLV 0,15
	KP_VOLJ 0
ins1
	KP_OSCV $34,0,1,1,$00
	KP_OSCV $33,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $31,0,1,1,$00
	KP_OSCV $30,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
ins1loop
	KP_OSCV $00,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCJ [ins1loop-ins1]

vol1
	KP_VOLV $0A,$02
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $06,$00
	KP_VOLV $04,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$03
	KP_VOLV $00,$02
	KP_VOLV $08,$00
	KP_VOLV $06,$00
	KP_VOLV $04,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$00
vol1loop
	KP_VOLV $00,$03
	KP_VOLJ [vol1loop-vol1]
ins2
ins2loop
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $02,0,1,1,$00
	KP_OSCV $01,0,1,1,$00
	KP_OSCV $00,0,1,1,$01
	KP_OSCV $FF,0,1,1,$00
	KP_OSCJ [ins2loop-ins2]

vol2
	KP_VOLV $0A,$04
	KP_VOLV $09,$00
	KP_VOLV $08,$00
	KP_VOLV $07,$00
	KP_VOLV $06,$00
	KP_VOLV $05,$00
	KP_VOLV $04,$00
	KP_VOLV $03,$00
	KP_VOLV $02,$00
	KP_VOLV $01,$00
vol2loop
	KP_VOLV $00,$00
	KP_VOLJ [vol2loop-vol2]
ins3
	KP_OSCV $48,0,1,0,$00
	KP_OSCV $38,0,1,0,$00
ins3loop
	KP_OSCV $FA,1,0,0,$00
	KP_OSCV $F5,1,0,0,$00
	KP_OSCJ [ins3loop-ins3]

vol3
	KP_VOLV $0E,$03
	KP_VOLV $04,$01
	KP_VOLV $01,$02
vol3loop
	KP_VOLV $00,$00
	KP_VOLJ [vol3loop-vol3]
ins4
ins4loop
	KP_OSCV $FB,1,0,0,$00
	KP_OSCJ [ins4loop-ins4]

vol4
	KP_VOLV $0F,$00
	KP_VOLV $0A,$00
	KP_VOLV $01,$02
vol4loop
	KP_VOLV $00,$00
	KP_VOLJ [vol4loop-vol4]
ins5
	KP_OSCV $14,0,1,0,$00
	KP_OSCV $08,0,1,0,$00
ins5loop
	KP_OSCV $FC,1,0,0,$01
	KP_OSCJ [ins5loop-ins5]

vol5
	KP_VOLV $0F,$01
vol5loop
	KP_VOLV $06,$03
	KP_VOLJ [vol5loop-vol5]
ins6
	KP_OSCV $FB,1,0,0,$00
ins6loop
	KP_OSCV $FC,1,0,0,$00
	KP_OSCJ [ins6loop-ins6]

vol6
	KP_VOLV $0F,$00
	KP_VOLV $0C,$00
	KP_VOLV $0A,$00
vol6loop
	KP_VOLV $00,$00
	KP_VOLJ [vol6loop-vol6]
ins7
	KP_OSCV $14,0,1,0,$00
	KP_OSCV $08,0,1,0,$00
	KP_OSCV $04,0,1,0,$00
ins7loop
	KP_OSCV $00,0,1,0,$00
	KP_OSCV $00,0,0,0,$00
	KP_OSCJ [ins7loop-ins7]

vol7
	KP_VOLV $0E,$00
	KP_VOLV $0F,$00
	KP_VOLV $0A,$00
	KP_VOLV $06,$00
	KP_VOLV $03,$00
	KP_VOLV $04,$02
vol7loop
	KP_VOLV $00,$00
	KP_VOLJ [vol7loop-vol7]
ins8
	KP_OSCV $14,0,1,0,$00
	KP_OSCV $08,0,1,0,$00
	KP_OSCV $00,1,0,0,$00
ins8loop
	KP_OSCV $F8,1,0,0,$01
	KP_OSCJ [ins8loop-ins8]

vol8
	KP_VOLV $0F,$01
	KP_VOLV $08,$00
	KP_VOLV $06,$01
vol8loop
	KP_VOLV $05,$00
	KP_VOLJ [vol8loop-vol8]
ins9
	KP_OSCV $FC,1,0,0,$00
	KP_OSCV $0C,0,1,0,$00
	KP_OSCV $04,0,1,0,$00
ins9loop
	KP_OSCV $00,0,1,0,$00
	KP_OSCV $00,0,0,0,$00
	KP_OSCJ [ins9loop-ins9]

vol9
	KP_VOLV $0C,$00
	KP_VOLV $0F,$00
	KP_VOLV $0A,$00
	KP_VOLV $06,$00
	KP_VOLV $03,$00
	KP_VOLV $04,$02
vol9loop
	KP_VOLV $00,$00
	KP_VOLJ [vol9loop-vol9]

kp_sequence
	dc.b $00,$01,$02,$00
	dc.b $00,$03,$04,$00
	dc.b $00,$01,$02,$00
	dc.b $00,$03,$04,$05
	dc.b $00,$01,$02,$06
	dc.b $00,$03,$04,$07
	dc.b $00,$01,$02,$06
	dc.b $00,$03,$04,$07
	dc.b $00,$00,$02,$06
	dc.b $00,$00,$04,$07
	dc.b $00,$00,$02,$06
	dc.b $00,$00,$04,$07
	dc.b $00,$01,$00,$06
	dc.b $00,$03,$00,$07
	dc.b $00,$01,$00,$06
	dc.b $00,$03,$00,$07
	dc.b $ff
	dc.w $0010


