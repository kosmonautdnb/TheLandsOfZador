ZP_USEBIOSLOADING				  = $8f ; 1 ; also defined in player.asm and fw_bootstrap.asm

fw_init SUBROUTINE

	bne .skip_loader_init

	LDA #$08
	STA $AE

	jsr fw_initloader
	bcc .loader_ok

	lda #$01
    sta ZP_USEBIOSLOADING
	jmp .loader_ok	; 7

	;ldy #$10
	;ldx #$ff	
.y
	inc $ff19
	dex
	bne .y 
	;dey 
	;bne .y ; 7

.loader_ok
	;--------------------------
	; warteschleife
	;--------------------------
	sei
	ldx #$28
	
.wait2	
	lda #$cd
.wait0	
	cmp $ff1d
	bne .wait0
	
	lda #$cf
.wait1
	cmp $ff1d
	bne .wait1
	
	dex
	bne .wait2
	cli
	;--------------------------

	
.skip_loader_init



	sei
	sta $FF3F
	
	lda #$4c
	sta $fff6

	ldx #$00
	ldy #$00
.0	lda fw_image_begin,y
.1	sta $0200,y
	iny
	bne .nowrap
	inc .0+2
	inc .1+2
	inx
.nowrap
	cpy #<fw_image_size
	bne .0
	cpx #>fw_image_size
	bne .0
	
	jsr fw_z4init
	lda #$00
	jmp fw_initplayer
	rts
	
fw_run SUBROUTINE
	jsr fw_lowirq_install
	rts


fw_z4init SUBROUTINE
	sei
	lda #<fw_z4timing
	sta $fffe
	lda #>fw_z4timing
	sta $ffff
	lda #2		;raster irq
	sta $ff0a
	lda #5
	sta $ff0b
	lda $ff09
	sta $ff09
	cli

.w	lda .counter	; wait
	beq .w
	rts
		
fw_z4timing
	sta tempa
	lda $ff1e	;stabilizaljuk a rasztert
	lsr
	lsr
	sta reljump
reljump = .+1
	bpl .+2		;vigyazni kell, hogy a kov. nop ugyanebben
	cmp #$c9	;a 256 byteos blokkban legyen, kulonben
	cmp #$c9	;elromlik az idozites!
	cmp #$c9
	cmp #$c9
	cmp #$c9
	cmp #$c5
	nop
	; stabil!

	bit $ffff	;53 cycle
	bit $ffff
	bit $ffff
	bit $ffff
	bit $ffff
	bit $ffff
	bit $ffff
	bit $ffff
	bit $ffff
	bit $ffff
	bit $ffff
	bit $ffff
	bit $ff
	nop

	lda #<(8*57)
	sta $ff00
	lda #>(8*57)
	sta $ff01

	sta .counter

	inc $ff09
tempa = .+1
	lda #0
	rti
	
.counter
	dc.b $00	
	
		
	include "fw_bootstrap_loader.asm"		
	
fw_image_addr
fw_image_begin = .+2
	incbin "framework.prg"
fw_image_size = .-fw_image_begin

	align 256,0
fw_bamtemp
	ds.b 256,0
	
	echo "fw_bamtemp ", fw_bamtemp
	;echo "fw_files", fw_files
