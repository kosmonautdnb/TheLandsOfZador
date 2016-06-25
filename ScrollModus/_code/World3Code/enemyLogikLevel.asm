	; all the enemies
	include "enemyData.inc"

ENEMY_CONFIGURATIONFLAG_RANDOM_JUMPING				= $80
ENEMY_CONFIGURATIONFLAG_GRAVITY						= $40
ENEMY_CONFIGURATIONFLAG_FLOOR_HANDLING				= $20
ENEMY_CONFIGURATIONFLAG_XMOVEMENT					= $10
ENEMY_CONFIGURATIONFLAG_XMOVEMENT_HALVE_SPEED		= $08
ENEMY_CONFIGURATIONFLAG_COLLISION_JUMPING			= $04
ENEMY_CONFIGURATIONFLAG_PERIODICAL_SHOT				= $02
ENEMY_CONFIGURATIONFLAG_EXPLODE_ON_COLLISION		= $01

ENEMY_ANIMTYPE_SLOWER1			= %10000000
ENEMY_ANIMTYPE_SLOWER2			= %01000000
ENEMY_ANIMTYPE_YSINPLUS			= %00100000
ENEMY_ANIMTYPE_LOOPMASK			= %00001111
ENEMY_ANIMTYPE_LOOP_FREEZE		= $00
ENEMY_ANIMTYPE_LOOP_FRAME4		= $01
ENEMY_ANIMTYPE_LOOP_FRAME2		= $02
ENEMY_ANIMTYPE_LOOP_THREEFRAME4 = $03
ENEMY_ANIMTYPE_LOOP_FOURFRAME8  = $04
ENEMY_ANIMTYPE_LOOP_XFLIP		= $05
ENEMY_ANIMTYPE_LOOP_JUMP		= $06

ENEMY_GRAVITY					= $0050
ENEMY_JUMP_VELOCITY				= $0320
ENEMY_COLLISIONJUMP_VELOCITY	= $0400

;----------------------------------------------------------------------------------
	; is used for the axe to determine which direction it should be thrown
enemyTemp  dc.b $00
enemyTemp2 dc.b $00

InitFrog SUBROUTINE
	lda #SPRITEFRAMES_ENEMY1
	sta GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda #ENEMY_ANIMTYPE_LOOP_THREEFRAME4|ENEMY_ANIMTYPE_SLOWER1
	sta GameObjectAnimType,x
	lda #ENEMY_CONFIGURATIONFLAG_XMOVEMENT|ENEMY_CONFIGURATIONFLAG_GRAVITY|ENEMY_CONFIGURATIONFLAG_FLOOR_HANDLING|ENEMY_CONFIGURATIONFLAG_RANDOM_JUMPING
	sta GameObjectConfiguration,x
	jmp enemyFlippedX

InitBird SUBROUTINE
	lda #SPRITEFRAMES_ENEMY2
	sta GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda #ENEMY_ANIMTYPE_LOOP_THREEFRAME4|ENEMY_ANIMTYPE_SLOWER1|ENEMY_ANIMTYPE_YSINPLUS
	sta GameObjectAnimType,x
	lda #ENEMY_CONFIGURATIONFLAG_XMOVEMENT_HALVE_SPEED
	sta GameObjectConfiguration,x
	jmp enemyFlippedX

InitBomby SUBROUTINE
	lda #SPRITEFRAMES_ENEMY3
	sta GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda #ENEMY_ANIMTYPE_LOOP_FRAME2|ENEMY_ANIMTYPE_SLOWER1
	sta GameObjectAnimType,x
	lda #ENEMY_CONFIGURATIONFLAG_XMOVEMENT_HALVE_SPEED|ENEMY_CONFIGURATIONFLAG_FLOOR_HANDLING|ENEMY_CONFIGURATIONFLAG_PERIODICAL_SHOT
	sta GameObjectConfiguration,x
	jmp enemyFlippedX

InitDog SUBROUTINE
	lda #SPRITEFRAMES_ENEMY6
	sta GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda #ENEMY_ANIMTYPE_LOOP_FRAME2|ENEMY_ANIMTYPE_SLOWER1
	sta GameObjectAnimType,x
	lda #ENEMY_CONFIGURATIONFLAG_XMOVEMENT_HALVE_SPEED|ENEMY_CONFIGURATIONFLAG_FLOOR_HANDLING|ENEMY_CONFIGURATIONFLAG_PERIODICAL_SHOT
	sta GameObjectConfiguration,x
	jmp enemyFlippedX

InitFat SUBROUTINE
	lda #SPRITEFRAMES_ENEMY4
	sta GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda #ENEMY_ANIMTYPE_LOOP_FRAME2|ENEMY_ANIMTYPE_SLOWER1
	sta GameObjectAnimType,x
	lda #ENEMY_CONFIGURATIONFLAG_XMOVEMENT_HALVE_SPEED|ENEMY_CONFIGURATIONFLAG_FLOOR_HANDLING|ENEMY_CONFIGURATIONFLAG_PERIODICAL_SHOT
	sta GameObjectConfiguration,x
	jmp enemyFlippedX

InitThrower SUBROUTINE
	lda #SPRITEFRAMES_ENEMY5
	sta GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda #ENEMY_ANIMTYPE_LOOP_FRAME2|ENEMY_ANIMTYPE_SLOWER1
	sta GameObjectAnimType,x
	lda #ENEMY_CONFIGURATIONFLAG_XMOVEMENT_HALVE_SPEED|ENEMY_CONFIGURATIONFLAG_FLOOR_HANDLING ;|ENEMY_CONFIGURATIONFLAG_PERIODICAL_SHOT
	sta GameObjectConfiguration,x
	jmp enemyFlippedX

InitEnemyShot1 SUBROUTINE
axeSoundTrigger	
	lda #SOUND_LAZER
	jsr triggerSoundScreen
	lda #SPRITEFRAMES_ENEMYSHOT1
	sta GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda #ENEMY_ANIMTYPE_LOOP_XFLIP|ENEMY_ANIMTYPE_SLOWER1
	sta GameObjectAnimType,x
	; floor handling must be off it is only for floor walking objects
	lda #ENEMY_CONFIGURATIONFLAG_XMOVEMENT|ENEMY_CONFIGURATIONFLAG_EXPLODE_ON_COLLISION
	sta GameObjectConfiguration,x
	lda #$00
	sta GameObjectVar1,x
	sta GameObjectVar2,x
	sta GameObjectHitPoints,x
	lda #$ff
	sta GameObjectVar3,x
	lda enemyTemp
	sta GameObjectFlags1,x
	lda #$02
	sta GameObjectFlags2,x
	rts
	;jmp enemyFlippedX

InitEnemyShot2 SUBROUTINE
	;lda #SOUND_SHOT
	;sta axeSoundTrigger + 1
	jsr InitEnemyShot1
	;lda #SOUND_ENEMY_LAZER
	;sta axeSoundTrigger + 1
	lda #SPRITEFRAMES_ENEMYSHOT2
	sta GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	lda #ENEMY_CONFIGURATIONFLAG_GRAVITY|ENEMY_CONFIGURATIONFLAG_XMOVEMENT|ENEMY_CONFIGURATIONFLAG_EXPLODE_ON_COLLISION|ENEMY_CONFIGURATIONFLAG_COLLISION_JUMPING
	sta GameObjectConfiguration,x
	lda #<[-$0200]
	sta GameObjectVar1,x
	lda #>[-$0200]
	sta GameObjectVar2,x
	rts

enemyFlippedX SUBROUTINE
	lda GameObjectXPosLo,x
	sec
	sbc GameObjectXPosLo + PLAYERGAMEOBJECT
	lda GameObjectXPosHi,x
	sbc GameObjectXPosHi + PLAYERGAMEOBJECT
	bmi .neg
	lda #$00
	sta GameObjectFlags1,x
	rts
.neg
	lda #$01
	sta GameObjectFlags1,x
	rts

;---------------------------------------------------------
;--- the configurable standard enemy				   ---
;---------------------------------------------------------
HandleStandardEnemy SUBROUTINE

	; explode if behind stone
	lda GameObjectFlags1,x
	lsr
	lda GameObjectVar10,x
	rol 
	sta GameObjectVar10,x
	cmp #%00110011 ; the flipping enemy is somehow a little wrong (2 times instead of one time)
	bne .nothanginginlevel
	ldy enemyNr
	jmp .explodeit
.nothanginginlevel

	lda #$00
	sta enemyTemp

	; JUMPING ENEMY ?
	lda GameObjectConfiguration,x
	and #ENEMY_CONFIGURATIONFLAG_RANDOM_JUMPING
	beq .notjumping
	; check if jump
	txa
	asl
	clc
	adc GameObjectActiveCounter,x
	and #$3f
	sta enemyTemp
	bne .nojump
	jsr collisionEnemyDown
	cmp #$00
	beq .notjumping
	lda #SOUND_LITTLEJUMP
	;lda #SOUND_JUMP
	jsr triggerSoundScreen
	lda #<[-ENEMY_JUMP_VELOCITY]
	sta GameObjectVar1,x
	lda #>[-ENEMY_JUMP_VELOCITY]
	sta GameObjectVar2,x
	lda #$ff
	sta GameObjectVar3,x
.nojump
	; only check top y if jumping is enabled
	jsr collisionEnemyUp
	cmp #$00
	beq .notcollided2
	lda #$00
	sta GameObjectVar1,x
	sta GameObjectVar2,x
	sta GameObjectVar3,x
.notcollided2
.herenocollision
.notjumping

	lda GameObjectEnemyType,x
	cmp #ENEMY_TYPE_SPECIALENEMY
	bne .noshotit
	lda enemyTemp
	cmp #$04
	beq .shotit
	cmp #$06
	bne .noshotit
.shotit
	lda GameObjectFlags1,x
	eor #$01
	sta GameObjectFlags1,x
	txa
	tay
	jmp .shot
.noshotit

	lda GameObjectConfiguration,x
	and #ENEMY_CONFIGURATIONFLAG_GRAVITY | ENEMY_CONFIGURATIONFLAG_RANDOM_JUMPING
	beq .noymovement
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
.noymovement

	; GRAVITY ?
	lda GameObjectConfiguration,x
	and #ENEMY_CONFIGURATIONFLAG_GRAVITY
	beq .nogravity
	; handle y movement
	lda GameObjectVar1,x
	clc
	adc #<ENEMY_GRAVITY
	sta GameObjectVar1,x
	lda GameObjectVar2,x
	adc #>ENEMY_GRAVITY
	sta GameObjectVar2,x
	lda GameObjectVar3,x
	adc #$00
	sta GameObjectVar3,x
	jsr collisionEnemyDown
	cmp #$00
	beq .notcollided1
	lda GameObjectConfiguration,x
	and #ENEMY_CONFIGURATIONFLAG_COLLISION_JUMPING
	beq .notCollisionJumping
	lda #SOUND_LITTLEJUMP
	;lda #SOUND_JUMP
	jsr triggerSoundScreen
	lda #<[-ENEMY_COLLISIONJUMP_VELOCITY]
	sta GameObjectVar1,x
	lda #>[-ENEMY_COLLISIONJUMP_VELOCITY]
	sta GameObjectVar2,x
	lda #$ff
	sta GameObjectVar3,x
	rts
.notCollisionJumping
	; floor handling
	lda GameObjectConfiguration,x
	and #ENEMY_CONFIGURATIONFLAG_FLOOR_HANDLING
	beq .nofloorcollisionhandling	
	lda #COLLISIONMODEFLAG_WITHFLOOR
	sta collisionMode
.nofloorcollisionhandling
	lda #$00
	sta GameObjectVar1,x
	sta GameObjectVar2,x
	sta GameObjectVar3,x
.notcollided1
.nogravity

	; handle FLIPPING (always enabled)
	lda GameObjectFlags1,x
	bne .notflipped
	lda #$01
	jmp .storeflag
.notflipped
	lda #$00
.storeflag
	sta GameObjectSpriteFlippedX,x

	; set animation
	txa
	tay
	asl
	clc
	adc GameObjectActiveCounter,x
	lsr ; fixed 2nd frame here
	tax
	
	lda GameObjectAnimType,y
	and #ENEMY_ANIMTYPE_SLOWER1
	beq .notslower1
	txa
	lsr
	tax
.notslower1
	lda GameObjectAnimType,y
	and #ENEMY_ANIMTYPE_SLOWER2
	beq .notslower2
	txa
	lsr
	tax
.notslower2

	lda GameObjectAnimType,y
	and #ENEMY_ANIMTYPE_LOOPMASK
	cmp #ENEMY_ANIMTYPE_LOOP_FREEZE
	bne .notfreeze
	ldx #$00
	jmp .animselected
.notfreeze
	cmp #ENEMY_ANIMTYPE_LOOP_THREEFRAME4
	bne .notthreeframe4
	txa
	and #$03
	tax
	lda threeFrameAnimation4,x
	tax
	jmp .animselected
.notthreeframe4
	cmp #ENEMY_ANIMTYPE_LOOP_FRAME4
	bne .notframe4
	txa
	and #$03
	tax
	jmp .animselected
.notframe4
	cmp #ENEMY_ANIMTYPE_LOOP_FRAME2
	bne .notframe2
	txa
	and #$01
	tax
	jmp .animselected
.notframe2
	cmp #ENEMY_ANIMTYPE_LOOP_FOURFRAME8
	bne .notfourframe8
	txa
	and #$07
	tax
	lda fourFrameAnimation8,x
	tax
	jmp .animselected
.notfourframe8
	cmp #ENEMY_ANIMTYPE_LOOP_XFLIP
	bne .notxflipanimation
	txa
	and #$01
	sta GameObjectSpriteFlippedX,y
	ldx #$00
	jmp .animselected
.notxflipanimation
	cmp #ENEMY_ANIMTYPE_LOOP_JUMP
	bne .notjumpinganimation
	ldx #$00
	lda GameObjectVar3,y
	ora GameObjectVar2,y
	ora GameObjectVar1,y
	beq .justsitting
	lda GameObjectVar3,y
	bmi .fpinc1
	inx
.fpinc1
	inx
.justsitting
	jmp .animselected
.notjumpinganimation
.animselected
	txa
	clc
	adc GameObjectSpriteValue,y
	sta GameObjectSpriteImage,y

	lda GameObjectSpriteValue,y
	cmp #SPRITEFRAMES_ENEMYSHOT1
	bne .notlazer
	jsr eAddLazerParticlesY
.notlazer

	ldx enemyNr
	ldy enemyNr
	
	lda #$00
	sta GameObjectSpritePaintWhite,x
	lda GameObjectHit,x
	beq .notdecwhite
	lda #$01
	sta GameObjectSpritePaintWhite,x
.notdecwhite

	lda GameObjectConfiguration,y
	and #ENEMY_CONFIGURATIONFLAG_RANDOM_JUMPING
	bne .floorcollisionisforjumpingalreadyhandled
	lda GameObjectConfiguration,y
	and #ENEMY_CONFIGURATIONFLAG_FLOOR_HANDLING
	beq .floorcollisionisforjumpingalreadyhandled
	lda #COLLISIONMODEFLAG_WITHFLOOR
	sta collisionMode
.floorcollisionisforjumpingalreadyhandled

	lda #$02
	sta enemyTemp2
.reloop
	lda GameObjectConfiguration,y
	and #ENEMY_CONFIGURATIONFLAG_XMOVEMENT|ENEMY_CONFIGURATIONFLAG_XMOVEMENT_HALVE_SPEED
	beq .noxmovement
	and #ENEMY_CONFIGURATIONFLAG_XMOVEMENT_HALVE_SPEED
	beq .nothalvexspeed
	lda GameObjectActiveCounter,y
	and #$01
	beq .noxmovement
.nothalvexspeed
	lda GameObjectFlags1,y
	and #$01
	asl
	sec
	sbc #$01
	ldx GameObjectFlags2,y
	cpx #$02
	bne .notfaster
	asl	
.notfaster
	jsr enemyMoveX
	cmp #$00
	beq .notFlipped

	; should it explode
	lda GameObjectConfiguration,y
	and #ENEMY_CONFIGURATIONFLAG_EXPLODE_ON_COLLISION
	beq .notexplode
.explodeit
	tya
	jsr explodeEnemy
	ldy enemyNr
	lda #GAMEOBJECT_COLLISIONTYPE_ENEMY_SHOT
	sta GameObjectCollisionType,y
	rts
.notexplode


	lda GameObjectFlags1,y
	eor #$01
	sta GameObjectFlags1,y
	jmp .noxmovement
.notFlipped
.noxmovement

	lda GameObjectEnemyType,y
	cmp #ENEMY_TYPE_ENEMYSHOT1
	bne .notReloop
	lda gameLogikCounter
	and #$02
	beq .notReloop
	dec enemyTemp2
	bne .reloop
.notReloop

	lda GameObjectAnimType,y
	and #ENEMY_ANIMTYPE_YSINPLUS
	beq .notsinplus
	lda GameObjectActiveCounter,y
	and #31
	tax
	lda sinPlus,x
	jsr enemyMoveYNoCollision
.notsinplus

	; shooting (axe)
	lda GameObjectConfiguration,y
	and #ENEMY_CONFIGURATIONFLAG_PERIODICAL_SHOT
	beq .noshot
	lda GameObjectActiveCounter,y
	and #%1011111
	bne .noshot
.shot
	lda #ENEMY_TYPE_ENEMYSHOT1
	sta enemyAddEnemyType
	lda GameObjectXPosLo,y
	sta enemyAddPosX + 0
	lda GameObjectXPosHi,y
	sta enemyAddPosX + 1
	lda #GAMEOBJECT_COLLISIONTYPE_ENEMY_SHOT
	sta enemyAddCollisionType

	lda #10
	sta .adc + 1
	lda GameObjectEnemyType,y
	cmp #ENEMY_TYPE_ENEMY4
	beq .yeahgirl
	cmp #ENEMY_TYPE_ENEMY6
	bne .notdog
.yeahgirl
	lda #ENEMY_TYPE_ENEMYSHOT2
	sta enemyAddEnemyType
	lda #0
	sta .adc + 1
.notdog


	lda GameObjectYPosLo,y
	clc
.adc
	adc #$44
	sta enemyAddPosY + 0
	lda GameObjectYPosHi,y
	adc #$00
	sta enemyAddPosY + 1


	lda GameObjectFlags1,y
	sta enemyTemp
	lda enemyNr
	pha
	lda enemyAddGameObjectIndexStart
	pha
	lda enemyAddGameObjectIndexEnd
	pha
	lda #ENEMYSHOTSFROM
	sta enemyAddGameObjectIndexStart
	lda #ENEMYSHOTSTO
	sta enemyAddGameObjectIndexEnd
	lda #NOLEVELENEMY
	sta enemyAddLevelEnemyIndex
	jsr addEnemyIntern
	pla
	sta enemyAddGameObjectIndexEnd
	pla
	sta enemyAddGameObjectIndexStart
	pla 
	sta enemyNr
.noshot
	rts





;---------------------------------------------------------
;--- the background Animations   					   ---
;---------------------------------------------------------
InitBackground SUBROUTINE
	lda enemyAddPropertyIntern
	sta GameObjectSpriteImage,x
	sta GameObjectSpriteValue,x
	lda enemyAddSpecialValue
	sta GameObjectVar1,x
	rts

HandleBackground SUBROUTINE
	lda GameObjectXPosLo,x
	lsr
	lsr
	clc
	adc GameObjectActiveCounter,x
	lsr
	lsr
	lsr
	and #$03
	tay
	lda threeFrameAnimation4,y
	clc
	adc GameObjectSpriteValue,x
	sta GameObjectSpriteImage,x
	rts

InitSpecialEnemy SUBROUTINE
	rts

HandleSpecialEnemy SUBROUTINE
	rts

	