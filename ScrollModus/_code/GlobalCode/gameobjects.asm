GAMEOBJECTCOUNT				= SPRITECOUNT
PERSISTENTITEMCOUNT			= 1

COLLECTABLESFROM			= 0
COLLECTABLESTO				= 5
NORMALENEMIESSTARTINDEX		= 5
NORMALENEMIESENDINDEX		= 9
PLAYERGAMEOBJECT			= 9
ENEMYSHOTSFROM				= 10
ENEMYSHOTSTO				= 12
PLAYERSHOTSFROM				= 12
PLAYERSHOTSTO				= 13
STATUSBARENERGYGAMEOBJECT	= 13
DUSTGAMEOBJECT				= 14
ITEMGAMEOBJECT				= 15

GameObjectXPosLoLo			ds.b GAMEOBJECTCOUNT,$00
GameObjectXPosLo			ds.b GAMEOBJECTCOUNT,$00
GameObjectXPosHi			ds.b GAMEOBJECTCOUNT,$00
GameObjectYPosLoLo			ds.b GAMEOBJECTCOUNT,$00
GameObjectYPosLo			ds.b GAMEOBJECTCOUNT,$00
GameObjectYPosHi			ds.b GAMEOBJECTCOUNT,$00
GameObjectVisible			ds.b GAMEOBJECTCOUNT,$00
GameObjectSpriteImage		ds.b GAMEOBJECTCOUNT,$00
GameObjectSpriteFlippedX	ds.b GAMEOBJECTCOUNT,$00
GameObjectSpritePaintWhite	ds.b GAMEOBJECTCOUNT,$00
GameObjectXStart			ds.b GAMEOBJECTCOUNT,$00
GameObjectYStart			ds.b GAMEOBJECTCOUNT,$00
GameObjectXEnd				ds.b GAMEOBJECTCOUNT,$00
GameObjectYEnd				ds.b GAMEOBJECTCOUNT,$00
GameObjectSpriteValue		ds.b GAMEOBJECTCOUNT,$00
GameObjectFlags1			ds.b GAMEOBJECTCOUNT,$00
GameObjectFlags2			ds.b GAMEOBJECTCOUNT,$00
GameObjectVar1				ds.b GAMEOBJECTCOUNT,$00
GameObjectVar2				ds.b GAMEOBJECTCOUNT,$00
GameObjectVar3				ds.b GAMEOBJECTCOUNT,$00
GameObjectVar4				ds.b GAMEOBJECTCOUNT,$00
GameObjectVar5				ds.b GAMEOBJECTCOUNT,$00
GameObjectVar6				ds.b GAMEOBJECTCOUNT,$00
GameObjectVar7				ds.b GAMEOBJECTCOUNT,$00
GameObjectVar8				ds.b GAMEOBJECTCOUNT,$00
GameObjectVar9				ds.b GAMEOBJECTCOUNT,$00
GameObjectVar10				ds.b GAMEOBJECTCOUNT,$00
GameObjectHitPoints			ds.b GAMEOBJECTCOUNT,$00 ; how many hitpoints the enemy has left
GameObjectCollisionType		ds.b GAMEOBJECTCOUNT,$00 ; also used for determining a free slot (must be set to paint it)
GameObjectEnemyType			ds.b GAMEOBJECTCOUNT,$00 
GameObjectLevelEnemyIndex	ds.b GAMEOBJECTCOUNT,$00 ; used to lookup level enemies
GameObjectConfiguration		ds.b GAMEOBJECTCOUNT,$00 
GameObjectAnimType			ds.b GAMEOBJECTCOUNT,$00 
GameObjectActiveCounter		ds.b GAMEOBJECTCOUNT,$00 
GameObjectHit				ds.b GAMEOBJECTCOUNT,$00 ; it was hit

GAMEOBJECT_COLLISIONTYPE_FREE_ENEMY_SLOT = $00
GAMEOBJECT_COLLISIONTYPE_NO_COLLISION   = $01
GAMEOBJECT_COLLISIONTYPE_ENEMY			= $02
GAMEOBJECT_COLLISIONTYPE_PLAYER			= $03
GAMEOBJECT_COLLISIONTYPE_PLAYER_SHOT	= $04
GAMEOBJECT_COLLISIONTYPE_ENEMY_SHOT		= $05
GAMEOBJECT_COLLISIONTYPE_COLLECTABLE	= $06
GAMEOBJECT_COLLISIONTYPE_OVERLAY		= $07
GAMEOBJECT_COLLISIONTYPE_MAGIC			= $08
GAMEOBJECT_COLLISIONTYPE_SCHALTER		= $09

checkIsCollidesForPlayer
	dc.b $00
	dc.b $00
	dc.b $01
	dc.b $00
	dc.b $00
	dc.b $01
	dc.b $01
	dc.b $00
	dc.b $01
	dc.b $01

PLAYER_YSTART	= 4
PLAYER_YEND		= 32
PLAYER_XSTART	= 2
PLAYER_XEND		= 12

;---------------------------------------------------------
;--- starting initialization						   ---
;--- setting player popterties						   ---
;---------------------------------------------------------
initializeGameObjectsFull SUBROUTINE
	lda #$00
	ldx #GAMEOBJECTCOUNT - 1
	jmp .initstart
initializeGameObjects 
	lda #$00
	ldx #GAMEOBJECTCOUNT - 1 - PERSISTENTITEMCOUNT
.initstart
.reloop
	sta GameObjectVisible,x
	sta GameObjectCollisionType,x
	dex
	bpl .reloop
	lda #$01
	sta GameObjectVisible + PLAYERGAMEOBJECT
	sta GameObjectVisible + STATUSBARENERGYGAMEOBJECT
	lda #PLAYER_XSTART
	sta GameObjectXStart + PLAYERGAMEOBJECT
	lda #PLAYER_YSTART
	sta GameObjectYStart + PLAYERGAMEOBJECT
	lda #PLAYER_XEND
	sta GameObjectXEnd + PLAYERGAMEOBJECT
	lda #PLAYER_YEND
	sta GameObjectYEnd + PLAYERGAMEOBJECT
	lda #GAMEOBJECT_COLLISIONTYPE_PLAYER
	sta GameObjectCollisionType + PLAYERGAMEOBJECT
	lda #GAMEOBJECT_COLLISIONTYPE_OVERLAY
	sta GameObjectCollisionType + STATUSBARENERGYGAMEOBJECT
	lda #SPRITEFRAMES_STATUS-1
	clc
	adc ZP_ENERGY
	sta GameObjectSpriteImage + STATUSBARENERGYGAMEOBJECT
	lda #200-20
	sta GameObjectYPosLo + STATUSBARENERGYGAMEOBJECT
	lda #7
	sta GameObjectXPosLo + STATUSBARENERGYGAMEOBJECT
	rts

;---------------------------------------------------------
;--- main gameobject paint function					   ---
;---------------------------------------------------------
paintAllVisibleGameObjects SUBROUTINE
	ldy #$00
	ldx #$00
.reloop
	lda GameObjectCollisionType,x
	beq .dontpaint
	lda GameObjectVisible,x
	beq .dontpaint
	sty spritePort
	lda GameObjectSpriteImage,x
	sta spriteImage
	lda GameObjectSpriteFlippedX,x
	sta spriteFlipped
	lda GameObjectSpritePaintWhite,x
	sta spriteWhite
	lda GameObjectCollisionType,x
	cmp #GAMEOBJECT_COLLISIONTYPE_OVERLAY
	bne .normal
	lda GameObjectXPosLo,x
	sta spritePX + 0
	lda GameObjectXPosHi,x
	sta spritePX + 1
	lda GameObjectYPosLo,x
	sta spritePY + 0
	lda GameObjectYPosHi,x
	sta spritePY + 1
	jmp .blitit
.normal
	lda GameObjectXPosLo,x
	sec
	sbc scrollPosXCurrent + 0
	sta spritePX + 0
	lda GameObjectXPosHi,x
	sbc scrollPosXCurrent + 1
	sta spritePX + 1
	lda GameObjectYPosLo,x
	sec
	sbc scrollPosYCurrent + 0
	sta spritePY + 0
	lda GameObjectYPosHi,x
	sbc scrollPosYCurrent + 1
	sta spritePY + 1
.blitit
	jsr blitVSprite
	iny
	cpy #SPRITECOUNT
	beq .nomore
.dontpaint
	inx
	cpx #GAMEOBJECTCOUNT
	bne .reloop
.nomore
	rts

;-------------------------------------------------------------
;--- gets a pixelwise collision rectangle for a gameobject ---
;-------------------------------------------------------------

getGameObjectRectangle SUBROUTINE
	; x can be 0 or 2
	lda GameObjectXPosLo,y
	clc
	adc GameObjectXStart,y
	sta collisionFlagRectXS + 0,x
	lda GameObjectXPosHi,y
	adc #$00
	sta collisionFlagRectXS + 1,x

	lda GameObjectXPosLo,y
	adc GameObjectXEnd,y
	sta collisionFlagRectXE + 0,x
	lda GameObjectXPosHi,y
	adc #$00
	sta collisionFlagRectXE + 1,x

	lda GameObjectYPosLo,y
	adc GameObjectYStart,y
	sta collisionFlagRectYS + 0,x
	lda GameObjectYPosHi,y
	adc #$00
	sta collisionFlagRectYS + 1,x

	lda GameObjectYPosLo,y
	adc GameObjectYEnd,y
	sta collisionFlagRectYE + 0,x
	lda GameObjectYPosHi,y
	adc #$00
	sta collisionFlagRectYE + 1,x
	rts

;------------------------------------------------------------------------------
;--- gets a pixelwise collision rectangle for a gameobject up collisiontest ---
;------------------------------------------------------------------------------
getCollisionFlagsUpForGameObject SUBROUTINE
	tay
	ldx #$00
	jsr getGameObjectRectangle
	lda collisionFlagRectYS + 0
	sta collisionFlagRectYE + 0
	lda collisionFlagRectYS + 1
	sta collisionFlagRectYE + 1
	jmp getCollisionFlags

;--------------------------------------------------------------------------------
;--- gets a pixelwise collision rectangle for a gameobject down collisiontest ---
;--------------------------------------------------------------------------------
getCollisionFlagsDownForGameObject SUBROUTINE
	tay
	ldx #$00
	jsr getGameObjectRectangle
	lda collisionFlagRectYE + 0
	sta collisionFlagRectYS + 0
	lda collisionFlagRectYE + 1
	sta collisionFlagRectYS + 1
	jmp getCollisionFlags

;--------------------------------------------------------------------------------
;--- gets a pixelwise collision rectangle for a gameobject left collisiontest ---
;--------------------------------------------------------------------------------
getCollisionFlagsLeftForGameObject SUBROUTINE
	tay
	ldx #$00
	jsr getGameObjectRectangle
	lda collisionFlagRectXS + 0
	sta collisionFlagRectXE + 0
	lda collisionFlagRectXS + 1
	sta collisionFlagRectXE + 1
	jmp getCollisionFlags

;---------------------------------------------------------------------------------
;--- gets a pixelwise collision rectangle for a gameobject right collisiontest ---
;---------------------------------------------------------------------------------
getCollisionFlagsRightForGameObject SUBROUTINE
	tay
	ldx #$00
	jsr getGameObjectRectangle
	lda collisionFlagRectXE + 0
	sta collisionFlagRectXS + 0
	lda collisionFlagRectXE + 1
	sta collisionFlagRectXS + 1
	jmp getCollisionFlags

;--------------------------------------------------
;--- gets the flags of the collision rectangle	---
;--------------------------------------------------
getCollisionFlags SUBROUTINE

	lda collisionFlagRectYE + 0
	clc
	adc #$07
	sta collisionFlagRectYE + 0
	bcc .nohi1
	clc
	inc collisionFlagRectYE + 1
.nohi1

	lda collisionFlagRectXE + 0
	adc #$03
	sta collisionFlagRectXE + 0
	bcc .nohi2
	clc
	inc collisionFlagRectXE + 1
.nohi2

	lda collisionFlagRectXS + 0
	lsr
	lsr
	sta rectLevelXS
	ldy collisionFlagRectXS + 1
	ldx MUL8LO,y
	lda MUL8LO,x
	ora rectLevelXS
	sta rectLevelXS

	lda collisionFlagRectYS + 0
	lsr
	lsr
	lsr
	sta rectLevelYS
	ldx collisionFlagRectYS + 1
	lda MUL8LO,x
	asl
	asl
	ora rectLevelYS
	sta rectLevelYS

	lda collisionFlagRectXE + 0
	lsr
	lsr
	sta rectLevelXE
	ldy collisionFlagRectXE + 1
	ldx MUL8LO,y
	lda MUL8LO,x
	ora rectLevelXE
	sta rectLevelXE

	lda collisionFlagRectYE + 0
	lsr
	lsr
	lsr
	sta rectLevelYE
	ldx collisionFlagRectYE + 1
	lda MUL8LO,x
	asl
	asl
	ora rectLevelYE
	sta rectLevelYE

	jsr flagsInRect
	lda rectFlags
	rts

;--------------------------------------------------
;--- clips the position with the up collision	---
;--------------------------------------------------
replaceGameObjectToCollisionUp SUBROUTINE
	tay

	lda GameObjectYPosLo,y
	clc
	adc #<$08
	sta GameObjectYPosLo,y
	lda GameObjectYPosHi,y
	adc #>$08
	sta GameObjectYPosHi,y

	lda GameObjectYPosLo,y
	clc
	adc GameObjectYStart,y 
	and #%11111000
	sta GameObjectYPosLo,y
	lda GameObjectYPosHi,y
	adc #$00 
	sta GameObjectYPosHi,y

	lda GameObjectYPosLo,y
	sec
	sbc GameObjectYStart,y 
	sta GameObjectYPosLo,y
	lda GameObjectYPosHi,y
	sbc #$00 
	sta GameObjectYPosHi,y
	rts

;--------------------------------------------------
;--- clips the position with the down collision	---
;--------------------------------------------------
replaceGameObjectToCollisionDown SUBROUTINE
	tay

	lda GameObjectYPosLo,y
	clc
	adc GameObjectYEnd,y 
	and #%11111000
	sta GameObjectYPosLo,y
	lda GameObjectYPosHi,y
	adc #$00 
	sta GameObjectYPosHi,y

	lda GameObjectYPosLo,y
	sec
	sbc GameObjectYEnd,y 
	sta GameObjectYPosLo,y
	lda GameObjectYPosHi,y
	sbc #$00 
	sta GameObjectYPosHi,y
	rts

;--------------------------------------------------
;--- clips the position with the left collision	---
;--------------------------------------------------
replaceGameObjectToCollisionLeft SUBROUTINE
	tay

	lda GameObjectXPosLo,y
	clc
	adc #<$04
	sta GameObjectXPosLo,y
	lda GameObjectXPosHi,y
	adc #>$04
	sta GameObjectXPosHi,y

	lda GameObjectXPosLo,y
	clc
	adc GameObjectXStart,y 
	and #%11111100
	sta GameObjectXPosLo,y
	lda GameObjectXPosHi,y
	adc #$00 
	sta GameObjectXPosHi,y

	lda GameObjectXPosLo,y
	sec
	sbc GameObjectXStart,y 
	sta GameObjectXPosLo,y
	lda GameObjectXPosHi,y
	sbc #$00 
	sta GameObjectXPosHi,y

	rts

;---------------------------------------------------
;--- clips the position with the right collision ---
;---------------------------------------------------
replaceGameObjectToCollisionRight SUBROUTINE
	tay

	lda GameObjectXPosLo,y
	clc
	adc GameObjectXEnd,y 
	and #%11111100
	sta GameObjectXPosLo,y
	lda GameObjectXPosHi,y
	adc #$00 
	sta GameObjectXPosHi,y

	lda GameObjectXPosLo,y
	sec
	sbc GameObjectXEnd,y 
	sta GameObjectXPosLo,y
	lda GameObjectXPosHi,y
	sbc #$00 
	sta GameObjectXPosHi,y
	rts

;---------------------------------------------------
;--- moves a gamobject in x (no collision here)  ---
;---------------------------------------------------
moveGameObjectByAccuX SUBROUTINE
	cmp #$80
	bpl .neg
	clc
	adc GameObjectXPosLo,y
	sta GameObjectXPosLo,y
	lda GameObjectXPosHi,y
	adc #$00
	sta GameObjectXPosHi,y
	rts
.neg
	clc
	adc GameObjectXPosLo,y
	sta GameObjectXPosLo,y
	lda GameObjectXPosHi,y
	adc #$ff
	sta GameObjectXPosHi,y
	rts

;---------------------------------------------------
;--- moves a gamobject in y (no collision here)  ---
;---------------------------------------------------
moveGameObjectByAccuY SUBROUTINE
	cmp #$80
	bpl .neg
	clc
	adc GameObjectYPosLo,y
	sta GameObjectYPosLo,y
	lda GameObjectYPosHi,y
	adc #$00
	sta GameObjectYPosHi,y
	rts
.neg
	clc
	adc GameObjectYPosLo,y
	sta GameObjectYPosLo,y
	lda GameObjectYPosHi,y
	adc #$ff
	sta GameObjectYPosHi,y
	rts

;---------------------------------------------------------
;--- tests if 2 sprite exactly collided				   ---
;--- a = 0 collided, a = 1 not collided->!!ATTENTION!! ---
;---------------------------------------------------------
;eCollisionSprite1 dc.b $00
;eCollisionSprite2 dc.b $00
	SUBROUTINE
gameObjectsCollided 

	lda #$00
	sta .avalue + 1 ; collision on

	lda collisionFlagRectYE + 0 + 2
	sta gameObjectT2 + 0
	lda collisionFlagRectYE + 1 + 2
	sta gameObjectT2 + 1

	lda collisionFlagRectYS + 0 + 0
	sta gameObjectT1 + 0
	lda collisionFlagRectYS + 1 + 0
	sta gameObjectT1 + 1

	jsr checkT1toT2 ; sprite2 yend - sprite1 ystart
	bne .nocollision

	lda collisionFlagRectXE + 0 + 2
	sta gameObjectT2 + 0
	lda collisionFlagRectXE + 1 + 2
	sta gameObjectT2 + 1

	lda collisionFlagRectXS + 0 + 0
	sta gameObjectT1 + 0
	lda collisionFlagRectXS + 1 + 0
	sta gameObjectT1 + 1

	jsr checkT1toT2 ; sprite2 xend - sprite1 xstart
	bne .nocollision

	lda collisionFlagRectYE + 0 + 0
	sta gameObjectT2 + 0
	lda collisionFlagRectYE + 1 + 0
	sta gameObjectT2 + 1

	lda collisionFlagRectYS + 0 + 2
	sta gameObjectT1 + 0
	lda collisionFlagRectYS + 1 + 2
	sta gameObjectT1 + 1

	jsr checkT1toT2 ; sprite1 yend - sprite2 ystart
	bne .nocollision

	lda collisionFlagRectXE + 0 + 0
	sta gameObjectT2 + 0
	lda collisionFlagRectXE + 1 + 0
	sta gameObjectT2 + 1

	lda collisionFlagRectXS + 0 + 2
	sta gameObjectT1 + 0
	lda collisionFlagRectXS + 1 + 2
	sta gameObjectT1 + 1

	jsr checkT1toT2 ; sprite1 xend - sprite2 xstart

.nocollision
.avalue
	lda #$44
	rts

checkT1toT2
	lda gameObjectT2 + 0
	sec
	sbc gameObjectT1 + 0
	lda gameObjectT2 + 1
	sbc gameObjectT1 + 1
	bpl .notoverlappinghere
	lda #$01
	sta .avalue + 1 ; collision off
.notoverlappinghere
	lda .avalue + 1
	rts

;---------------------------------------------------
;--- set a gameobject above a other				 ---
;--- x the gameobject below                      ---
;--- y the gameobject to place over the other    ---
;---------------------------------------------------
placeGameObjectAbove SUBROUTINE
	stx .gameObjectToModify + 1
	ldx #$00
	jsr getGameObjectRectangle
.gameObjectToModify
	ldx #$44
	lda collisionFlagRectYS + 0
	sec
	sbc GameObjectYEnd,x
	sta GameObjectYPosLo,x
	lda collisionFlagRectYS + 1
	sbc #$00
	sta GameObjectYPosHi,x
	lda #$00
	sta GameObjectYPosLoLo,x
	rts