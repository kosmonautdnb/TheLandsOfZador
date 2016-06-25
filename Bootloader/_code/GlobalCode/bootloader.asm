    processor   6502

	ORG $17fa
	jmp fw_init		
	ORG $17fd
	jmp fw_run		
	ORG $1800,$00
	include "fw_interface.asm"
	include "fw_bootstrap.asm"	
