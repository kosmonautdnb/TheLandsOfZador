
	include "loadersymbols.inc"

	;ORG openfile - 2 ; incbin funktioniert nicht richtig :(
	;incbin "loader.prg"
	ORG openfile
	incbin "loader.pr2"

diskio_status_OK EQU 00

load SUBROUTINE	
	;jsr openfile
	jmp load2
loadNormal
	bcc .pollblock
	rts
	
.pollblock
	jsr pollblock
	bcc .pollblock

	sta .restorea + 1	
	lda endaddrlo
	sta load_end
	lda endaddrhi
	sta load_end + 1
.restorea
	lda #$44
	cmp #diskio_status_OK + 1
	rts

