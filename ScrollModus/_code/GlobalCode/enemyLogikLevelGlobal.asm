COLLECTABLE_DISAPPEAR_VELOCITY = $24
COLLECTABLE_TYPE_HEART		   = $00
COLLECTABLE_TYPE_DIAMOND	   = $01
COLLECTABLE_TYPE_STONE		   = $02
COLLECTABLE_TYPE_ITEM		   = $03
spritePointersForCollectables 
	dc.b SPRITEFRAMES_HEART
	dc.b SPRITEFRAMES_DIAMOND
	dc.b SPRITEFRAMES_SPARKLES
	dc.b SPRITEFRAMES_ITEM

PLAYERSHOOT1_JUMP_VELOCITY		= $0260
PLAYERSHOOT1_GRAVITY			= $0020
PLAYERSHOOT1_FRAMES_DONE		= $c0

;---------------------------------------------------------
;--- objects that can be collected					   ---
;---------------------------------------------------------
InitCollectable SUBROUTINE
	ldy enemyAddPropertyIntern
	lda spritePointersForCollectables,y
	sta GameObjectSpriteImage,x
	sta GameObjectSpriteValue,x
	jsr enemyFlippedX
	lda GameObjectFlags1,x
	eor #$01
	sta GameObjectSpriteFlippedX,x
	tya
	sta GameObjectVar1,x
	lda #$00
	sta GameObjectVar2,x ; off animation on/off
	lda #$ff
	sta GameObjectVar3,x ; off animation y move
	sta GameObjectVar4,x ; off animation y move
	lda #$1c
	sta GameObjectVar5,x ; off animation duration
	rts

HandleCollectable SUBROUTINE
	lda GameObjectActiveCounter,x
	clc
	adc GameObjectXPosLo,x
	lsr
	lsr
	lsr
	and #$03
	tay
	lda threeFrameAnimation4,y
	clc
	adc GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x

	lda GameObjectVar2,x
	beq .notoffanimation
	lda GameObjectYPosLoLo,x
	clc
	adc GameObjectVar3,x
	sta GameObjectYPosLoLo,x
	lda GameObjectYPosLo,x
	adc GameObjectVar4,x
	sta GameObjectYPosLo,x
	lda GameObjectYPosHi,x
	adc #$ff
	sta GameObjectYPosHi,x

	lda GameObjectVar3,x
	sec
	sbc #<COLLECTABLE_DISAPPEAR_VELOCITY
	sta GameObjectVar3,x
	lda GameObjectVar4,x
	sbc #>COLLECTABLE_DISAPPEAR_VELOCITY
	sta GameObjectVar4,x
	lda GameObjectActiveCounter,x
	lsr
	lsr
	lsr
	lsr
	and #$01
	asl
	sec
	sbc #$01
	jsr enemyMoveXNoCollision
	dec GameObjectVar5,x
	bne .notdone
	txa
	jsr removeEnemyFromLevel
.notdone
	rts
.notoffanimation
	lda GameObjectActiveCounter,x
	and #31
	clc
	adc GameObjectXPosLo,x
	clc
	adc GameObjectXPosLo,x
	and #31
	lsr
	lsr
	lsr
	lsr
	and #$01
	asl
	sec
	sbc #$01
	jmp enemyMoveYNoCollision

;---------------------------------------------------------
;--- the shoot of the player						   ---
;---------------------------------------------------------
InitPlayerShot SUBROUTINE
	lda #SPRITEFRAMES_PLAYERSHOT
	sta GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda GameObjectSpriteFlippedX + PLAYERGAMEOBJECT
	and #$01
	sta GameObjectFlags1,x
	lda #GAMEOBJECT_COLLISIONTYPE_PLAYER_SHOT
	sta GameObjectCollisionType,x
	lda #<[-PLAYERSHOOT1_JUMP_VELOCITY]
	sta GameObjectVar1,x
	lda #>[-PLAYERSHOOT1_JUMP_VELOCITY]
	sta GameObjectVar2,x
	lda #$ff
	sta GameObjectVar3,x
	rts

;---------------------------------------------------------
;--- the player shot							       ---
;---------------------------------------------------------
HandlePlayerShot SUBROUTINE

	lda #$01
	sta playerShotActive

	lda GameObjectActiveCounter,x
	lsr
	lsr
	lsr
	and #$01
	clc
	adc #SPRITEFRAMES_PLAYERSHOT
	sta GameObjectSpriteImage,x

	lda GameObjectActiveCounter,x
	cmp #PLAYERSHOOT1_FRAMES_DONE
	bne .dontdelete
	lda enemyNr
	jmp removeEnemyFromScreen
.dontdelete

	; handle y movement
	lda GameObjectYPosLoLo,x
	clc
	adc GameObjectVar1,x
	sta GameObjectYPosLoLo,x
	lda GameObjectYPosLo,x
	adc GameObjectVar2,x
	sta GameObjectYPosLo,x
	lda GameObjectYPosHi,x
	adc GameObjectVar3,x
	sta GameObjectYPosHi,x

	lda GameObjectVar1,x
	clc
	adc #<PLAYERSHOOT1_GRAVITY
	sta GameObjectVar1,x
	lda GameObjectVar2,x
	adc #>PLAYERSHOOT1_GRAVITY
	sta GameObjectVar2,x
	lda GameObjectVar3,x
	adc #$00
	sta GameObjectVar3,x

	jsr collisionEnemyDown
	cmp #$00
	beq .notcollidedDown
	lda #SOUND_LITTLEJUMP
	jsr triggerSound
	lda #<[-PLAYERSHOOT1_JUMP_VELOCITY]
	sta GameObjectVar1,x
	lda #>[-PLAYERSHOOT1_JUMP_VELOCITY]
	sta GameObjectVar2,x
	lda #$ff
	sta GameObjectVar3,x
.notcollidedDown

	jsr collisionEnemyUp
	cmp #$00
	beq .notcollidedUp
	lda #$00
	sta GameObjectVar1,x
	sta GameObjectVar2,x
	sta GameObjectVar3,x
.notcollidedUp

	lda GameObjectFlags1,x
	bne .flipped
	lda #$00
	sta GameObjectSpriteFlippedX,x
	lda #$01
	jsr moveEnemyRightByAccu
	jmp .checkFlip
.flipped
	lda #$01
	sta GameObjectSpriteFlippedX,x
	lda #$01
	jsr moveEnemyLeftByAccu
.checkFlip
	cmp #$00
	beq .notFlipped
	lda #SOUND_LITTLEJUMP
	jsr triggerSound
	ldx enemyNr
	lda GameObjectFlags1,x
	eor #$01
	sta GameObjectFlags1,x
.notFlipped
	txa
	tay
	jmp eAddLazerParticlesY


;---------------------------------------------------------
;--- the explosion									   ---
;---------------------------------------------------------
HandleExplosion SUBROUTINE
	lda #$03
	jsr moveEnemyUpByAccu
	ldx enemyNr
	lda GameObjectVar1,x
	;lsr
	lsr
	cmp #$04
	bne .display
	lda enemyNr
	jmp removeEnemyFromLevel
.display
	clc
	adc #SPRITEFRAMES_EXPLOSION
	sta GameObjectSpriteImage,x
	inc GameObjectVar1,x
InitExplosion ; never called
	rts

;---------------------------------------------------------
;--- the sparkles (for explosions)					   ---
;---------------------------------------------------------
InitSparkles SUBROUTINE
	lda #SPRITEFRAMES_SPARKLES
	sta GameObjectSpriteImage,x
	sta GameObjectSpriteValue,x
	lda enemyAddPropertyIntern
	sta GameObjectVar1,x
	rts

HandleSparkles SUBROUTINE
	lda GameObjectActiveCounter,x
	cmp #12
	bne .notdeleted
	lda #GAMEOBJECT_COLLISIONTYPE_FREE_ENEMY_SLOT
	sta GameObjectCollisionType,x ; free enemy
	rts
.notdeleted
	lsr
	lsr
	and #$03
	tay
	lda threeFrameAnimation4,y
	clc
	adc GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda GameObjectVar1,x
	beq .normalfree
	sta GameObjectSpriteImage,x
	lda #$fe
	jsr enemyMoveYNoCollision
.normalfree
	lda #$fd
	jmp enemyMoveYNoCollision

;---------------------------------------------------------
;--- initializes a schalter   						   ---
;---------------------------------------------------------
InitSchalter SUBROUTINE
	lda enemyAddPropertyIntern
	sta GameObjectSpriteImage,x
	sta GameObjectSpriteValue,x
	lda enemyAddSpecialValue
	sta GameObjectVar1,x
	rts

HandleSchalter SUBROUTINE
	lda GameObjectVar1,x
	sec
	sbc #SCHALTERENEMYTYPESTART
	asl
	tay
	lda layers + 0,y
	sta .read + 1
	lda layers + 1,y
	sta .read + 2
.read
	lda $4444
	and #$01
	clc
	adc GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	rts
