

launchpart SUBROUTINE
;	
;	; quelle
;	clc
;	lda load_start
;	sta .reloc_addr1+1
;	sta .reloc_addr2+1
;	adc #$02
;	sta .copysrc+1
;	lda load_start+1
;	sta .reloc_addr1+2
;	sta .reloc_addr2+2
;	adc #$00
;	sta .copysrc+2
;	
;	; ziel mit "safety-offset", exomizer will das so
;	ldx #$00
;	sec
;.reloc_addr1
;	lda $1234,x
;	sta .runpart+1
;	sbc #SAFETY_OFFSET
;	sta .copydst+1
;	inx
;.reloc_addr2
;	lda $1234,x
;	sta .runpart+2
;	sbc #$00
;	sta .copydst+2
;	
;	; endmarke, exomizer nimmt das zum decrunchen
;	sec
;	lda load_end
;	sbc load_start
;	sta .decrunch_lo+1
;	lda load_end+1
;	sbc load_start+1
;	sta .decrunch_hi+1
;	
;	clc
;	lda .decrunch_lo+1
;	adc .copydst+1
;	sta .decrunch_lo+1
;	lda .decrunch_hi+1
;	adc .copydst+2
;	sta .decrunch_hi+1
;
;	sec
;	lda .decrunch_lo+1
;	sbc #$02
;	sta .decrunch_lo+1
;	lda .decrunch_hi+1
;	sbc #$00
;	sta .decrunch_hi+1
;	
;	lda .decrunch_hi
;	clc
;	adc #$01
;	sta .copylen+1
;	
;	
;	ldy #$00
;.0
;.copysrc	
;	lda $2000,y
;.copydst
;	sta $1000,y
;	iny
;	bne .0	
;	inc .copysrc+2
;	inc .copydst+2
;	lda .copydst+2
;.copylen	
;	cmp #$00
;	bne .0
;	
;	
;.decrunch_lo
;	ldx #$00
;.decrunch_hi
;	ldy #$00
;	jsr decrunch
;
;.runpart	
;	jmp $1ffd

