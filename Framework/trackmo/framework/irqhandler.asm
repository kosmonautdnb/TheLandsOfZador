topirq_install SUBROUTINE

	lda topirq_rasterline+1
	ora #$02
	sta $ff0a
	lda topirq_rasterline
	sta $ff0b
	lda #<topirq_stub
	sta $fffe
	lda #>topirq_stub
	sta $ffff

	rts


topirq_stub SUBROUTINE
	sta .exit+1
	stx .exit+3
	sty .exit+5

    jsr topirq_handler	
	
	inc $ff09	

.exit
	lda #$00
	ldx #$00
	ldy #$00	
	rti
	
	
	

topirq_handler SUBROUTINE

	jsr kp_output

	lda topirq_plugin+1
	beq .skipplugin

	lda topirq_plugin
	sta .pluginaddr
	lda topirq_plugin+1
	sta .pluginaddr+1

.pluginaddr = .+1
	jsr $1234
	
.skipplugin
	jsr lowirq_install
	
	rts




lowirq_install SUBROUTINE

	lda lowirq_rasterline+1
	ora #$02
	sta $ff0a
	lda lowirq_rasterline
	sta $ff0b
	lda #<lowirq_stub
	sta $fffe
	lda #>lowirq_stub
	sta $ffff

	rts


lowirq_stub SUBROUTINE
	sta .exit+1
	stx .exit+3
	sty .exit+5

	jsr lowirq_handler	
	
	inc $ff09	
	
	
.exit
	lda #$00
	ldx #$00
	ldy #$00	
	rti
	
	

lowirq_handler SUBROUTINE

	inc framecounter
	bne .0
	inc framecounter+1
.0
	jsr kp_output
	jsr kp_tick
	
	lda lowirq_plugin+1
	beq .skipplugin

	lda lowirq_plugin
	sta .pluginaddr
	lda lowirq_plugin+1
	sta .pluginaddr+1

.pluginaddr = .+1
	jsr $1234
	
.skipplugin
	jsr topirq_install
	
	rts


