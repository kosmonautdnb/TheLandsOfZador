
	;--------------------------------------------------------
	; load zero absolute word *dest
	;--------------------------------------------------------
	MAC ldza_w

		lda #$00
		sta {1}
		sta {1}+1
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; load zero indirect word *dest
	;--------------------------------------------------------
	MAC ldzi_w

		ldy #$00
		tya
		sta {1},y
		iny
		sta {1},y
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; load constant absolute word *dest,value
	;--------------------------------------------------------
	MAC ldca_w

		lda #[[{2} >> 0] & $FF]
		sta {1}
		lda #[[{2} >> 8] & $FF]
		sta {1}+1
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; load constant indirect word *dest,value
	;--------------------------------------------------------
	MAC ldci_w

		ldy #$00
		lda #[[{2} >> 0] & $FF]
		sta {1},y
		iny
		lda #[[{2} >> 8] & $FF]
		sta {1},y
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; shift right absolute word *dest
	;--------------------------------------------------------
	MAC shra_w
		
		lda {1}+1
		asl
		ror {1}+1
		ror {1}
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; shift left absolute word *dest
	;--------------------------------------------------------
	MAC shla_w
		
		asl {1}
		rol {1}+1
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; move absolute word *dest,*source
	;--------------------------------------------------------
	MAC mova_w
		
		lda {2}
		sta {1}
		lda {2}+1
		sta {1}+1
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; move indirect word *dest,*source
	;--------------------------------------------------------
	MAC movi_w

		ldy #$00
		lda {2},y
		sta {1},y
		iny
		lda {2},y
		sta {1},y
	
	ENDM
	;--------------------------------------------------------


	;--------------------------------------------------------
	; move indirect absolute word *dest(absolute),*source(indirect)
	;--------------------------------------------------------
	MAC movia_w

		ldy #{3}
		lda {2},y
		sta {1} + 0
		iny
		lda {2},y
		sta {1} + 1
	
	ENDM
	;--------------------------------------------------------


	;--------------------------------------------------------
	; add absolute word *dest,*augend,*addend
	;--------------------------------------------------------
	MAC adda_w
		
		clc
		lda {3}
		adc {2}
		sta {1}
		lda {3}+1
		adc {2}+1
		sta {1}+1
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; add indirect word *dest,*augend,*addend
	;--------------------------------------------------------
	MAC addi_w
		
		ldy #$00
		clc
		lda {3},y
		adc {2},y
		sta {1},y
		iny
		lda {3},y
		adc {2},y
		sta {1},y
			
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; subtract absolute word *dest,*minuend,*subtrahend
	;--------------------------------------------------------
	MAC suba_w
		
		sec
		lda {2}
		sbc {3}
		sta {1}
		lda {2}+1
		sbc {3}+1
		sta {1}+1
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; subtract indirect word *dest,*minuend,*subtrahend
	;--------------------------------------------------------
	MAC subi_w
		
		ldy #$00
		sec
		lda {2},y
		sbc {3},y
		sta {1},y
		iny
		lda {2},y
		sbc {3},y
		sta {1},y
			
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; negate absolute word <*dest>
	;--------------------------------------------------------
	MAC nega_w
		
		lda {1}
		eor #$ff
		sta {1}
		lda {1}+1
		eor #$ff
		sta {1}+1
		
		clc
		lda {1}
		adc #$01
		sta {1}
		lda {1}+1
		adc #$00
		sta {1}+1
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; negate indirect word <*dest>
	;--------------------------------------------------------
	MAC negi_w
		
		ldy #$00
		lda {1},y
		eor #$ff
		adc #$01
		sta {1},y
		iny
		lda {1},y
		eor #$ff
		adc #$00
		sta {1},y
		
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; absolute absolute word <*dest>
	;--------------------------------------------------------
	MAC absa_w
		
		lda {1}+1
		bpl .0
		nega_w {1}
.0	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; absolute indirect word <*dest>
	;--------------------------------------------------------
	MAC absi_w
		
		ldy #$01
		lda {1},y
		bpl .0
		negi_w {1}
.0	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; compare absolute word <*minuend>,<*subtrahend>
	;--------------------------------------------------------
	MAC cmpa_w
		
		sec
		lda {2}
		sbc {1}
		lda {2}+1
		sbc {1}+1

	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; compare indirect word <*minuend>,<*subtrahend>
	;--------------------------------------------------------
	MAC cmpi_w
		
		ldy #$00
		sec
		lda {2},y
		sbc {1},y
		iny
		lda {2},y
		sbc {1},y

	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; multiply absolute unsigned word *dest,*factor1,*factor2
	;--------------------------------------------------------
	MAC umua_w

		ldx {2}
		ldy {3}
		jsr mul8_mulu
		sty {1}
		stx {1}+1

		ldx {2}+1
		ldy {3}
		jsr mul8_mulu
		
		clc
		tya
		adc {1}+1
		sta {1}+1
		txa
		adc #$00
		sta {1}+2
		;---
		ldx {2}
		ldy {3}+1
		jsr mul8_mulu

		clc
		tya
		adc {1}+1
		sta {1}+1
		txa
		adc {1}+2
		sta {1}+2

		ldx {2}+1
		ldy {3}+1
		jsr mul8_mulu

		clc
		tya
		adc {1}+2
		sta {1}+2
		txa
		adc #$00
		sta {1}+3
	
	ENDM
	;--------------------------------------------------------


	;--------------------------------------------------------
	; multiply indirect unsigned word *dest,*factor1,*factor2
	;--------------------------------------------------------
	MAC umui_w

		; <f1 * <f2
		ldy #$00
		lda {2},y
		tax
		lda {3},y
		tay
		jsr mul8_mulu
		tya
		ldy #$00
		sta {1},y
		iny
		txa
		sta {1},y

		; >f1 * <f2
		ldy #$01
		lda {2},y
		dey
		tax
		lda {3},y
		tay
		jsr mul8_mulu
		
		clc
		tya
		ldy #$01
		adc {1},y
		sta {1},y
		txa
		iny
		adc #$00
		sta {1},y

		; <f1 * >f2
		ldy #$01
		lda {3},y
		dey
		tax
		lda {2},y
		tay
		jsr mul8_mulu
		
		clc
		tya
		ldy #$01
		adc {1},y
		sta {1},y
		txa
		iny
		adc {1},y
		sta {1},y


		; >f1 * >f2
		ldy #$01
		lda {2},y
		tax
		lda {3},y
		tay
		jsr mul8_mulu
		
		clc
		tya
		ldy #$02
		adc {1},y
		sta {1},y
		txa
		iny
		adc #$00
		sta {1},y
			
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; multiply absolute signed word *dest,*factor1,*factor2
	;--------------------------------------------------------
	MAC smua_w

		lda {3}+1
		eor {2}+1
		sta .sign
		
		mova_w int16_temp1,{2}
		absa_w int16_temp1

		mova_w int16_temp2,{3}
		absa_w int16_temp2
		
		umua_w {1},int16_temp1,int16_temp2
	
.sign = .+1
		lda #$00	
		bpl .signok
		
		nega_l {1}
.signok
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; multiply indirect signed word *dest,*factor1,*factor2
	;--------------------------------------------------------
	MAC smui_w

		ldy #$01
		lda {3},y
		eor {2},y
		sta .sign
		
		movi_w int16_temp1,{2}
		absa_w int16_temp1

		movi_w int16_temp2,{3}
		absa_w int16_temp2
		
		umui_w {1},int16_temp1,int16_temp2
	
.sign = .+1
		lda #$00	
		bpl .signok
		
		negi_l {1}
.signok
	ENDM
	;--------------------------------------------------------


	;--------------------------------------------------------
	; negate absolute long <*dest>
	;--------------------------------------------------------
	MAC nega_w
		
		lda {1}
		eor #$ff
		sta {1}
		lda {1}+1
		eor #$ff
		sta {1}+1
		
		clc
		lda {1}
		adc #$01
		sta {1}
		lda {1}+1
		adc #$00
		sta {1}+1
	
	ENDM
	;--------------------------------------------------------









