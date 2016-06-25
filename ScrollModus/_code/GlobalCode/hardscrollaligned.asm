hardScrollWholeColorRamAligned SUBROUTINE
	;-----------------------------------------------------------------
	;-- harscroll speedcode
	;-----------------------------------------------------------------
	; perhaps we can spare one if moving on x
	ldx #39
.reloop1
Y SET 0
hardscrollmodi1
	REPEAT DISPLAYAREAROWS
	lda $4444,x
	sta $4444,x
Y SET Y + 1
	REPEND
Y SET 0
hardscrollmodi2
	REPEAT DISPLAYAREAROWS
	lda $4444,x
	sta $4444,x
Y SET Y + 1
	REPEND
	dex
	bmi .noreloop1
	jmp .reloop1
.noreloop1
	rts