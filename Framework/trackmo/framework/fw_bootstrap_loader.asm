	include "loadersymbols.inc"


	org $2c00 - 2 ; incbin funktioniert nicht richtig :(
	incbin "install.prg"
	
fw_initloader = install
