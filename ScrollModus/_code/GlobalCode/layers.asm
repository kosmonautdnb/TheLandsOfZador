layersNoSound dc.b $00 


ytemplayer dc.b $00

 	SUBROUTINE
;-------------------------------------------------------------
;-- updates the layer status (nr in accu)
;-------------------------------------------------------------
updateLayer
	pha
	sta .todo + 1
	txa
	pha
	tya
	pha

	jsr waitForScrollDone
	jsr switchFrame
	jsr callLevelClearFunc
	jsr switchFrame
	jsr callLevelClearFunc

.todo
	lda #$44
	asl
	tax
	lda layers + 0,x
	sta ZP_BYTE + 0
	lda layers + 1,x
	sta ZP_BYTE + 1

	ldy #$00 ; on off
	lda (ZP_BYTE),y
	sta .iny1 + 1
	sta .iny2 + 1
	sta .jsrX + 1
	iny
	ldx #$00
.next
	lda (ZP_BYTE),y
	cmp #$ff
	beq .done

	sta stoneXPos
	iny
	lda (ZP_BYTE),y
	sta stoneYPos
	iny

.iny1
	lda #$44
	beq .noiny1
	iny
.noiny1

	lda (ZP_BYTE),y
	sta stoneNr


.iny2
	lda #$44
	bne .noiny2
	iny
.noiny2

	jsr drawStoneOnXY

	txa
	and #$03
	ora layersNoSound
	ora stoneOutsideScreen
	bne .nosound

	lda #SOUND_LAYERREMOVE
	ldx .iny1 + 1
	beq .notbuild
	lda #SOUND_LAYERBUILD
.notbuild
	jsr triggerSound
.nosound

	inx
	iny
	jmp .next

.done
	sty ytemplayer

	lda .todo + 1
	asl
	tax
	lda layerJump + 0,x
	sta .jsr + 1
	lda layerJump + 1,x
	sta .jsr + 2
.jsrX
	ldx #$44
.jsr
	jsr $4444

	lda frameCounter + 0
	sta lastFrameCounterGameLogik + 0
	pla
	tay
	pla
	tax
	pla
	rts
	
	SUBROUTINE
;-------------------------------------------------------------
;-- activates a layer layer Number in Accu
;-------------------------------------------------------------
activateLayer
	sta .todo + 1
	txa
	pha
	tya
	pha
.todo
	lda #$44
	asl
	tax
	lda layers + 0,x
	sta .modi1 + 1
	sta .modi2 + 1
	lda layers + 1,x
	sta .modi1 + 2
	sta .modi2 + 2
.modi1
	lda $4444
	and #$01
	bne .alreadyEnabled

	lda #$01
.modi2
	sta $4444
	lda .todo + 1
	jsr updateLayer
	ldy ytemplayer
	iny
	lda (ZP_BYTE),y
	cmp #$fe
	bne .nolayeritem
	iny
	lda (ZP_BYTE),y
	sta enemyAddPosX + 0
	iny
	lda (ZP_BYTE),y
	sta enemyAddPosY + 0

	lda #ITEMGAMEOBJECT
	sta enemyAddGameObjectIndexStart
	lda #ITEMGAMEOBJECT + 1
	sta enemyAddGameObjectIndexEnd

	lda enemyAddPosX + 0
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	sta enemyAddPosX + 1
	lda enemyAddPosX + 0
	asl
	asl
	sta enemyAddPosX + 0

	lda enemyAddPosY + 0
	lsr
	lsr
	lsr
	lsr
	lsr
	sta enemyAddPosY + 1
	lda enemyAddPosY + 0
	asl
	asl
	asl
	sta enemyAddPosY + 0

	lda #GAMEOBJECT_COLLISIONTYPE_COLLECTABLE
	sta enemyAddCollisionType
	lda #NOLEVELENEMY
	sta enemyAddLevelEnemyIndex

	lda #ENEMY_TYPE_ITEM
	sta enemyAddEnemyType
	lda #COLLECTABLE_TYPE_ITEM
	sta enemyAddPropertyIntern

	jsr addEnemyIntern

.nolayeritem
.alreadyEnabled
	pla
	tay
	pla
	tax
	rts

	SUBROUTINE
;-------------------------------------------------------------
;-- activates a layer layer Number in Accu
;-------------------------------------------------------------
deactivateLayer
	sta .todo + 1
	txa
	pha
.todo
	lda #$44
	asl
	tax
	lda layers + 0,x
	sta .modi1 + 1
	sta .modi2 + 1
	lda layers + 1,x
	sta .modi1 + 2
	sta .modi2 + 2
.modi1
	lda $4444
	and #$01
	beq .alreadyDisabled
	lda #$00
.modi2
	sta $4444
	lda .todo + 1
	jsr updateLayer
.alreadyDisabled
	pla
	tax
	rts

	SUBROUTINE
;-------------------------------------------------------------
;-- switches a layer
;-------------------------------------------------------------
switchLayer
	pha
	stx .xrestore + 1
	asl
	tax
	lda layers + 0,x
	sta .modi + 1
	lda layers + 1,x
	sta .modi + 2
.xrestore
	ldx #$44
.modi
	lda $4444
	bne .deactivate
	pla
	jmp activateLayer
.deactivate
	pla
	jmp deactivateLayer

	SUBROUTINE
;-------------------------------------------------------------
;-- activates a layer layer Number in Accu
;-------------------------------------------------------------
stoneXPos dc.b $00
stoneYPos dc.b $00
stoneNr   dc.b $00
drawStoneOnXY 
	pha
	txa
	pha
	tya
	pha

	lda stoneXPos
	asl
	asl
	tax
	lda DIV4MUL64TAB64MAPLO,x
	clc
	adc stoneYPos
	sta .write + 1 
	lda DIV4MUL64TAB64MAPHI,x
	adc #$00
	sta .write + 2 

	lda stoneNr
.write
	sta $4444

	lda stoneXPos
	asl
	asl
	sta rectLevelXS

	lda stoneYPos
	asl
	asl
	sta rectLevelYS

	lda rectLevelXS
	clc
	adc #$04
	sta rectLevelXE
	lda rectLevelYS
	clc
	adc #$04
	sta rectLevelYE

	jsr redrawPortion
	pla
	tay
	pla
	tax
	pla
	rts
