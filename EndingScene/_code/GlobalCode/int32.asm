	;--------------------------------------------------------
	; load zero absolute long *dest
	;--------------------------------------------------------
	MAC ldza_l

		lda #$00
		sta {1}
		sta {1}+1
		sta {1}+2
		sta {1}+3
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; load zeri indirect long *dest
	;--------------------------------------------------------
	MAC ldzi_l

		ldy #$00
		tya
		sta {1},y
		iny
		sta {1},y
		iny
		sta {1},y
		iny
		sta {1},y
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; load constant absolute long *dest,value
	;--------------------------------------------------------
	MAC ldca_l

		lda #[[{2} >> 0] & $FF]
		sta {1}
		lda #[[{2} >> 8] & $FF]
		sta {1}+1
		lda #[[{2} >> 16] & $FF]
		sta {1}+2
		lda #[[{2} >> 24] & $FF]
		sta {1}+3
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; load constant indirect long *dest,value
	;--------------------------------------------------------
	MAC ldci_l

		ldy #$00
		lda #[[{2} >> 0] & $FF]
		sta {1},y
		iny
		lda #[[{2} >> 8] & $FF]
		sta {1},y
		iny
		lda #[[{2} >> 16] & $FF]
		sta {1},y
		iny
		lda #[[{2} >> 24] & $FF]
		sta {1},y
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; shift right absolute long *dest
	;--------------------------------------------------------
	MAC shra_l
		
		lda {1}+3
		asl
		ror {1}+3
		ror {1}+2
		ror {1}+1
		ror {1}
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; shift left absolute long *dest
	;--------------------------------------------------------
	MAC shla_l
		
		asl {1}
		rol {1}+1
		rol {1}+2
		rol {1}+3
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; move absolute long *dest,*source
	;--------------------------------------------------------
	MAC mova_l
		
		lda {2}
		sta {1}
		lda {2}+1
		sta {1}+1
		lda {2}+2
		sta {1}+2
		lda {2}+3
		sta {1}+3
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; move indirect long *dest,*source
	;--------------------------------------------------------
	MAC movi_l

		ldy #$00
		lda {2},y
		sta {1},y
		iny
		lda {2},y
		sta {1},y
		iny
		lda {2},y
		sta {1},y
		iny
		lda {2},y
		sta {1},y
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; add absolute long *dest,*augend,*addend
	;--------------------------------------------------------
	MAC adda_l
		
		clc
		lda {3}
		adc {2}
		sta {1}
		lda {3}+1
		adc {2}+1
		sta {1}+1
		lda {3}+2
		adc {2}+2
		sta {1}+2
		lda {3}+3
		adc {2}+3
		sta {1}+3
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; add indirect long *dest,*augend,*addend
	;--------------------------------------------------------
	MAC addi_l
		
		ldy #$00
		clc
		lda {3},y
		adc {2},y
		sta {1},y
		iny
		lda {3},y
		adc {2},y
		sta {1},y
		iny
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
	; subtract absolute long *dest,*minuend,*subtrahend
	;--------------------------------------------------------
	MAC suba_l
		
		sec
		lda {2}
		sbc {3}
		sta {1}
		lda {2}+1
		sbc {3}+1
		sta {1}+1
		lda {2}+2
		sbc {3}+2
		sta {1}+2
		lda {2}+3
		sbc {3}+3
		sta {1}+3
	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; subtract indirect long *dest,*minuend,*subtrahend
	;--------------------------------------------------------
	MAC subi_l
		
		ldy #$00
		sec
		lda {2},y
		sbc {3},y
		sta {1},y
		iny
		lda {2},y
		sbc {3},y
		sta {1},y
		iny
		lda {2},y
		sbc {3},y
		sta {1},y
		iny
		lda {2},y
		sbc {3},y
		sta {1},y
		iny
			
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; negate absolute long <*dest>
	;--------------------------------------------------------
	MAC nega_l
		
		lda {1}
		eor #$ff
		sta {1}
		lda {1}+1
		eor #$ff
		sta {1}+1
		lda {1}+2
		eor #$ff
		sta {1}+2
		lda {1}+3
		eor #$ff
		sta {1}+3
		
		clc
		lda {1}
		adc #$01
		sta {1}
		lda {1}+1
		adc #$00
		sta {1}+1
		lda {1}+2
		adc #$00
		sta {1}+2
		lda {1}+3
		adc #$00
		sta {1}+3

	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; negate indirect long <*dest>
	;--------------------------------------------------------
	MAC negi_l
		
		ldy #$00
		
		clc
		lda {1},y
		eor #$ff
		adc #$01
		sta {1},y
		iny
		lda {1},y
		eor #$ff
		adc #$00
		sta {1},y
		iny
		lda {1},y
		eor #$ff
		adc #$00
		sta {1},y
		iny
		lda {1},y
		eor #$ff
		adc #$00
		sta {1},y
		
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; absolute absolute long <*dest>
	;--------------------------------------------------------
	MAC absa_l
		
		lda {1}+3
		bpl .0
		nega_l {1}
.0	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; absolute indirect long <*dest>
	;--------------------------------------------------------
	MAC absi_l
		
		ldy #$03
		lda {1},y
		bpl .0
		negi_l {1}
.0	
	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; compare absolute long <*minuend>,<*subtrahend>
	;--------------------------------------------------------
	MAC cmpa_w
		
		sec
		lda {2}
		sbc {1}
		lda {2}+1
		sbc {1}+1
		lda {2}+2
		sbc {1}+2
		lda {2}+3
		sbc {1}+3

	ENDM
	;--------------------------------------------------------



	;--------------------------------------------------------
	; compare indirect long <*minuend>,<*subtrahend>
	;--------------------------------------------------------
	MAC cmpi_w
		
		ldy #$00
		sec
		lda {2},y
		sbc {1},y
		iny
		lda {2},y
		sbc {1},y
		iny
		lda {2},y
		sbc {1},y
		iny
		lda {2},y
		sbc {1},y

	ENDM
	;--------------------------------------------------------










