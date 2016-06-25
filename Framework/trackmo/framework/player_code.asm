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

KP_ZP0	EQU $07
KP_ZP1	EQU $08
KP_ZP2	EQU $09

kp_tedwrite				dc.b $00
kp_tedread				dc.b $00
	
kp_tickstonextbeat		dc.b $00	
kp_beatstonextpattern	dc.b $00	
kp_sequence_addr		dc.w $0000
	

kp_ff0e			ds.b 2,$00
kp_ff0f			ds.b 2,$00
kp_ff10			ds.b 2,$00
kp_ff11			ds.b 2,$00
kp_ff12			ds.b 2,$00






kp_reset SUBROUTINE
	stx KP_ZP0
	sty KP_ZP0+1

	lda #<kp_dynamics
	sta kp_volumetable_address+0
	lda #>kp_dynamics
	sta kp_volumetable_address+1
	
	;dc.b $f2

;	ldy #$00
;	lda (KP_ZP0),y
;	sta kp_song_registers_occ0
;	sta kp_song_registers_occ1
;	sta kp_song_registers_occ2
;	iny
;	lda (KP_ZP0),y
;	sta kp_song_registers_occ0+1
;	sta kp_song_registers_occ1+1
;	sta kp_song_registers_occ2+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_speed_occ0
;	sta kp_speed_occ1
;	iny
;	lda (KP_ZP0),y
;	sta kp_speed_occ0+1
;	sta kp_speed_occ1+1
		
;	iny
;	lda (KP_ZP0),y
;	sta kp_grooveboxpos_occ0
;	sta kp_grooveboxpos_occ1
;	iny
;	lda (KP_ZP0),y
;	sta kp_grooveboxpos_occ0+1
;	sta kp_grooveboxpos_occ1+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_grooveboxlen_occ0
;	iny
;	lda (KP_ZP0),y
;	sta kp_grooveboxlen_occ0+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_groovebox_occ0
;	iny
;	lda (KP_ZP0),y
;	sta kp_groovebox_occ0+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_patternlen_occ0
;	iny
;	lda (KP_ZP0),y
;	sta kp_patternlen_occ0+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_patternmap_lo_occ0
;	sta kp_patternmap_lo_occ1
;	sta kp_patternmap_lo_occ2
;	iny
;	lda (KP_ZP0),y
;	sta kp_patternmap_lo_occ0+1
;	sta kp_patternmap_lo_occ1+1
;	sta kp_patternmap_lo_occ2+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_patternmap_hi_occ0
;	sta kp_patternmap_hi_occ1
;	sta kp_patternmap_hi_occ2
;	iny
;	lda (KP_ZP0),y
;	sta kp_patternmap_hi_occ0+1
;	sta kp_patternmap_hi_occ1+1
;	sta kp_patternmap_hi_occ2+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_insmap_lo_occ0
;	sta kp_insmap_lo_occ1
;	sta kp_insmap_lo_occ2
;	iny
;	lda (KP_ZP0),y
;	sta kp_insmap_lo_occ0+1
;	sta kp_insmap_lo_occ1+1
;	sta kp_insmap_lo_occ2+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_insmap_hi_occ0
;	sta kp_insmap_hi_occ1
;	sta kp_insmap_hi_occ2
;	iny
;	lda (KP_ZP0),y
;	sta kp_insmap_hi_occ0+1
;	sta kp_insmap_hi_occ1+1
;	sta kp_insmap_hi_occ2+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_volmap_lo_occ0
;	sta kp_volmap_lo_occ1
;	sta kp_volmap_lo_occ2
;	iny
;	lda (KP_ZP0),y
;	sta kp_volmap_lo_occ0+1
;	sta kp_volmap_lo_occ1+1
;	sta kp_volmap_lo_occ2+1

;	iny
;	lda (KP_ZP0),y
;	sta kp_volmap_hi_occ0
;	sta kp_volmap_hi_occ1
;	sta kp_volmap_hi_occ2
;	iny
;	lda (KP_ZP0),y
;	sta kp_volmap_hi_occ0+1
;	sta kp_volmap_hi_occ1+1
;	sta kp_volmap_hi_occ2+1
;
;	iny
;	lda (KP_ZP0),y
;	sta kp_sequence_addr
;	iny
;	lda (KP_ZP0),y
;	sta kp_sequence_addr+1
;	lda #$00
;	sta kp_tickstonextbeat
;	sta kp_beatstonextpattern
;	rts

	ldy #$02
	jsr .getnext
	stx kp_song_registers_occ0
	stx kp_song_registers_occ1
	stx kp_song_registers_occ2
	sta kp_song_registers_occ0+1
	sta kp_song_registers_occ1+1
	sta kp_song_registers_occ2+1

;	jsr .getnext
	stx kp_speed_occ0
	stx kp_speed_occ1
	sta kp_speed_occ0+1
	sta kp_speed_occ1+1

	jsr .getnext			
	stx kp_grooveboxpos_occ0
	stx kp_grooveboxpos_occ1
	sta kp_grooveboxpos_occ0+1
	sta kp_grooveboxpos_occ1+1

	jsr .getnext			
	stx kp_grooveboxlen_occ0
	sta kp_grooveboxlen_occ0+1

	jsr .getnext			
	stx kp_groovebox_occ0
	sta kp_groovebox_occ0+1

	jsr .getnext			
	stx kp_patternlen_occ0
	sta kp_patternlen_occ0+1

	jsr .getnext			
	stx kp_patternmap_lo_occ0
	stx kp_patternmap_lo_occ1
	stx kp_patternmap_lo_occ2
	sta kp_patternmap_lo_occ0+1
	sta kp_patternmap_lo_occ1+1
	sta kp_patternmap_lo_occ2+1

	jsr .getnext			
	stx kp_patternmap_hi_occ0
	stx kp_patternmap_hi_occ1
	stx kp_patternmap_hi_occ2
	sta kp_patternmap_hi_occ0+1
	sta kp_patternmap_hi_occ1+1
	sta kp_patternmap_hi_occ2+1

	jsr .getnext			
	stx kp_insmap_lo_occ0
	stx kp_insmap_lo_occ1
	stx kp_insmap_lo_occ2
	sta kp_insmap_lo_occ0+1
	sta kp_insmap_lo_occ1+1
	sta kp_insmap_lo_occ2+1

	jsr .getnext			
	stx kp_insmap_hi_occ0
	stx kp_insmap_hi_occ1
	stx kp_insmap_hi_occ2
	sta kp_insmap_hi_occ0+1
	sta kp_insmap_hi_occ1+1
	sta kp_insmap_hi_occ2+1

	jsr .getnext			
	stx kp_volmap_lo_occ0
	stx kp_volmap_lo_occ1
	stx kp_volmap_lo_occ2
	sta kp_volmap_lo_occ0+1
	sta kp_volmap_lo_occ1+1
	sta kp_volmap_lo_occ2+1

	jsr .getnext			
	stx kp_volmap_hi_occ0
	stx kp_volmap_hi_occ1
	stx kp_volmap_hi_occ2
	sta kp_volmap_hi_occ0+1
	sta kp_volmap_hi_occ1+1
	sta kp_volmap_hi_occ2+1

	jsr .getnext			
	stx kp_sequence_addr
	sta kp_sequence_addr+1
	
	lda #$00
	sta kp_tickstonextbeat
	sta kp_beatstonextpattern

	rts

.getnext
	lda (KP_ZP0),y
	tax
	iny
	lda (KP_ZP0),Y
	iny
	rts
;#############################################################################################
;
; song abspielen
; ausgabe berechnen
;
;#############################################################################################
kp_tick SUBROUTINE
	echo "kp_tick =",.

	lda song_off
	beq .notoff
	rts
.notoff

;	lda kp_pulse_var
;	beq .nopulse
;
;	lda kp_pulse_callback+1
;	beq .nopulse
;
;	sta .sr+1
;	lda kp_pulse_callback
;	sta .sr
;.sr = .+1
;	jsr $1234	
;
;.nopulse
	
	lda KP_ZP0
	sta kp_zp0restore
	lda KP_ZP1
	sta kp_zp1restore
	lda KP_ZP2
	sta kp_zp2restore

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
	inc kp_beat_counter
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
	inc kp_pattern_counter
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

kp_zp0restore = . + 1
	lda #$44
	sta KP_ZP0
kp_zp1restore = . + 1
	lda #$44
	sta KP_ZP1
kp_zp2restore = . + 1
	lda #$44
	sta KP_ZP2
	rts


kp_dynamics
	dc.b $00,$01,$01,$02,$02,$03,$03,$04
	dc.b $05,$05,$06,$06,$07,$07,$08,$08

kp_output	SUBROUTINE
	lda song_off
	bne .exit2

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

.exit2
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
;	clc
;	adc .frq_mod1
	tax	
.notranspose
	stx .out_freq
	
	lda .osc_vol
	beq .noamp		; lautstärke
	
	clc
	adc .vol_mod0
;	clc
;	adc .vol_mod1
	sec
;	sbc #$1e
	sbc #$0f
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