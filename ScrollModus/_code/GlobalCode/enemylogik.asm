
HEARTENEMYTYPE				= 32
DIAMONDENEMYTYPE			= 33
BACKGROUNDENEMYTYPE			= 34
ITEMENEMYTYPE				= 35
STONEENEMYTYPESTART			= 40
STONEENEMYTYPEEND			= 50
SCHALTERENEMYTYPESTART		= 50
SCHALTERENEMYTYPEEND		= 64 ; 63 because of and 63 in the logic


ENEMY_FLAGS_DESTROYED		= 128
ENEMY_FLAGS_ONSCREEN		= 64
NOLEVELENEMY				= $ff
ENEMY_HIT_STAY_FRAMES		= $02 ; 1 doesn't suffice because of collision check order in the gamelogikloop

UPDOWNENEMYGUARD			= $03
LEFTRIGHTENEMYGUARD			= $03
UPENEMYGUARDCLEAR			= $04
DOWNENEMYGUARDCLEAR			= $04
LEFTENEMYGUARDCLEAR			= $04
RIGHTENEMYGUARDCLEAR		= $04
GUARDCLEAREXPANDX			= 5
GUARDCLEAREXPANDY			= 5

enemyAddGameObjectIndexStart dc.b $00
enemyAddGameObjectIndexEnd	 dc.b $00

COLLISIONMODE_NORMAL		= $00
COLLISIONMODEFLAG_WITHFLOOR = $01

collisionMode				dc.b $00
enemyNr						dc.b $00

threeFrameAnimation4 ; 4 bytes!
	dc.b $00
	dc.b $01
	dc.b $02
	dc.b $01
fourFrameAnimation8 ; 8 bytes!
	dc.b $00
	dc.b $01
	dc.b $02
	dc.b $03
	dc.b $03
	dc.b $02
	dc.b $01
	dc.b $00
eightFrameAnimation16 ; 16 bytes!
	dc.b $00
	dc.b $01
	dc.b $02
	dc.b $03
	dc.b $04
	dc.b $05
	dc.b $06
	dc.b $07
	dc.b $07
	dc.b $06
	dc.b $05
	dc.b $04
	dc.b $03
	dc.b $02
	dc.b $01
	dc.b $00


;---------------------------------------------------------
;---gets a free game object							   ---
;---returns accu $ff if not possible				   ---
;---------------------------------------------------------
getFreeGameObject SUBROUTINE
	ldx enemyAddGameObjectIndexStart
.next
	lda GameObjectCollisionType,x
	bne .notfree
	txa
	rts
.notfree
	inx
	cpx enemyAddGameObjectIndexEnd
	bne .next
	lda #$ff
	rts

;---------------------------------------------------------
;---gets a free game object or removes one in the level---
;---returns accu $ff if not possible				   ---
;---------------------------------------------------------
getNewGameObject SUBROUTINE
	jsr getFreeGameObject
	cmp #$ff
	bne .found
	jsr clearMostOutsideEnemy
	; returns ff or index
.found
	rts

enemyAddCollisionType	dc.b $00
enemyAddEnemyType		dc.b $00
enemyAddPosX			dc.w $0000
enemyAddPosY			dc.w $0000
enemyAddLevelEnemyIndex dc.b $00
enemyAddPropertyIntern	dc.b $00
enemyAddSpecialValue	dc.b $00
;---------------------------------------------------------
;--- adds a enemy / addEnemyLevel should be used	   ---
;---------------------------------------------------------
addEnemyIntern SUBROUTINE
	jsr getNewGameObject
	cmp #$ff
	bne .freeslotfound
	rts
.freeslotfound
	tax

	lda #$00
	sta GameObjectXPosLoLo,x
	sta GameObjectYPosLoLo,x
	sta GameObjectSpriteImage,x
	sta GameObjectSpriteFlippedX,x
	sta GameObjectSpritePaintWhite,x
	sta GameObjectSpriteValue,x	
	sta GameObjectFlags1,x	
	sta GameObjectFlags2,x	
	sta GameObjectVar1,x	
	sta GameObjectVar2,x	
	sta GameObjectVar3,x	
	sta GameObjectVar4,x	
	sta GameObjectVar5,x	
	sta GameObjectVar6,x	
	sta GameObjectVar7,x	
	sta GameObjectVar8,x	
	sta GameObjectVar9,x	
	sta GameObjectVar10,x
	sta GameObjectConfiguration,x
	sta GameObjectAnimType,x
	sta GameObjectActiveCounter,x
	sta GameObjectHit,x

	lda #$01
	sta GameObjectVisible,x
	
	lda enemyAddPosX + 0
	sta GameObjectXPosLo,x
	lda enemyAddPosX + 1
	sta GameObjectXPosHi,x
	lda enemyAddPosY + 0
	sta GameObjectYPosLo,x
	lda enemyAddPosY + 1
	sta GameObjectYPosHi,x
	lda enemyAddCollisionType
	sta GameObjectCollisionType,x
	lda enemyAddEnemyType
	sta GameObjectEnemyType,x
	lda enemyAddLevelEnemyIndex
	sta GameObjectLevelEnemyIndex,x

	ldy enemyAddEnemyType
	lda enemyXStart,y
	sta GameObjectXStart,x
	lda enemyYStart,y
	sta GameObjectYStart,x
	lda enemyXEnd,y
	sta GameObjectXEnd,x
	lda enemyYEnd,y
	sta GameObjectYEnd,x
	lda enemyHitPoints,y
	sta GameObjectHitPoints,x

	lda enemyAddEnemyType
	jsr initEnemy
	lda enemyNr
	rts

addEnemyLevelXPos dc.b $00
addEnemyLevelYPos dc.b $00

;---------------------------------------------------------
;--- adds a enemy at the given x if within a y frame   ---
;---------------------------------------------------------
	SUBROUTINE
.count								dc.b $00
.addEnemyLevelYPosBottom			dc.b $00
.addEnemyLevelYPosTop				dc.b $00
addEnemyLevel

	lda ENEMYXSPANCOUNT
	bne .wehavesome
.noenemy
	rts
.wehavesome

	ldy addEnemyLevelXPos

	lda (ZP_ENEMYX_XARRAYINDEX),y
	beq .noenemy

	tay
	dey

	lda (ZP_ENEMYX_COUNT),y
	sta .count

	lda (ZP_ENEMYX_EARRAYINDEX),y
	tay

.nexty
	lda (ZP_ENEMYY_YPOSITION),y
	
	cmp .addEnemyLevelYPosTop
	bcc .donexty

	cmp .addEnemyLevelYPosBottom
	bcs .donexty

	lda (ZP_ENEMYY_ENEMYTYPE),y
	and #ENEMY_FLAGS_DESTROYED | ENEMY_FLAGS_ONSCREEN
	bne .donexty

	lda (ZP_ENEMYY_YPOSITION),y
	asl
	asl
	asl
	sta enemyAddPosY + 0
	lda (ZP_ENEMYY_YPOSITION),y
	lsr
	lsr
	lsr
	lsr
	lsr
	sta enemyAddPosY + 1

	lda addEnemyLevelXPos
	asl
	asl
	sta enemyAddPosX + 0
	lda addEnemyLevelXPos
	lsr
	lsr
	lsr
	lsr
	lsr
	lsr
	sta enemyAddPosX + 1
	
	lda #GAMEOBJECT_COLLISIONTYPE_ENEMY
	sta enemyAddCollisionType

	jsr checkForCollectables

	; move enemy up
	ldx	enemyAddEnemyType

	lda enemyAddPosY + 0
	clc
	adc #<$08
	sta enemyAddPosY + 0
	lda enemyAddPosY + 1
	adc #>$08
	sta enemyAddPosY + 1

	lda enemyAddPosY + 0
	sec
	sbc enemyYEnd,x
	sta enemyAddPosY + 0
	lda enemyAddPosY + 1
	sbc #$00
	sta enemyAddPosY + 1

	sty enemyAddLevelEnemyIndex

	jsr addEnemyIntern

	ldy enemyAddLevelEnemyIndex
	cmp #$ff
	beq .notonscreen
	lda (ZP_ENEMYY_ENEMYTYPE),y
	ora #ENEMY_FLAGS_ONSCREEN
	sta (ZP_ENEMYY_ENEMYTYPE),y
.notonscreen
.donexty
	iny
	dec .count
	beq .nextyfin
	jmp .nexty
.nextyfin
	rts ; not in y screen
.foundy


	rts

checkForCollectables 
	lda (ZP_ENEMYY_ENEMYTYPE),y
	and #63 ; because of the two flags for on screen and destroyed
	sta enemyAddEnemyType
	
	ldx #NORMALENEMIESSTARTINDEX
	stx enemyAddGameObjectIndexStart
	ldx #NORMALENEMIESENDINDEX
	stx enemyAddGameObjectIndexEnd
	
	cmp #HEARTENEMYTYPE
	bne .notheart
	lda #ENEMY_TYPE_HEART
	sta enemyAddEnemyType
	lda #COLLECTABLE_TYPE_HEART
	sta enemyAddPropertyIntern
	jmp .collectable 
.notheart
	cmp #DIAMONDENEMYTYPE
	bne .notdiamond
	lda #ENEMY_TYPE_DIAMOND
	sta enemyAddEnemyType
	lda #COLLECTABLE_TYPE_DIAMOND
	sta enemyAddPropertyIntern
	jmp .collectable 
.notdiamond
	cmp #STONEENEMYTYPESTART
	bcc .notstone
	cmp #STONEENEMYTYPEEND
	bcs .notstone
	sta enemyAddSpecialValue
AddMagicPre
	lda #ENEMY_TYPE_BACKGROUND
	sta enemyAddEnemyType
	lda #SPRITEFRAMES_SPARKLES
	sta enemyAddPropertyIntern
	lda #GAMEOBJECT_COLLISIONTYPE_MAGIC
	sta enemyAddCollisionType
	jmp .background 
.notstone
	cmp #SCHALTERENEMYTYPESTART
	bcc .notschalter
	cmp #SCHALTERENEMYTYPEEND
	bcs .notschalter
	sec
	sbc #$01
	sta enemyAddSpecialValue
	lda #ENEMY_TYPE_SCHALTER
	sta enemyAddEnemyType
	lda #SPRITEFRAMES_SCHALTER
	sta enemyAddPropertyIntern
	lda #GAMEOBJECT_COLLISIONTYPE_SCHALTER
	sta enemyAddCollisionType
	jmp .background 
.notschalter
	cmp #BACKGROUNDENEMYTYPE
	bne .notbackgroundanim
	lda #ENEMY_TYPE_BACKGROUND
	sta enemyAddEnemyType
	lda #SPRITEFRAMES_BACKGROUND
	sta enemyAddPropertyIntern
	lda #GAMEOBJECT_COLLISIONTYPE_NO_COLLISION
	sta enemyAddCollisionType
	jmp .background 
.notbackgroundanim
	rts
.collectable
	lda #GAMEOBJECT_COLLISIONTYPE_COLLECTABLE
	sta enemyAddCollisionType
.background
	lda #COLLECTABLESFROM
	sta enemyAddGameObjectIndexStart
	lda #COLLECTABLESTO
	sta enemyAddGameObjectIndexEnd
	rts

;---------------------------------------------------------
;--- adds all enemies for the given column      	   ---
;---------------------------------------------------------
addEnemyLevelX	
	; search on y axis
	lda addEnemyLevelYPos
	sec
	sbc #UPDOWNENEMYGUARD
	bcs .normalnoclip1
	lda #$00
.normalnoclip1
	sta .addEnemyLevelYPosTop

	lda addEnemyLevelYPos
	clc
	adc #DISPLAYAREAROWS+UPDOWNENEMYGUARD
	bcc .normalnoclip2
	lda #255
.normalnoclip2
	sta .addEnemyLevelYPosBottom

	jsr addEnemyLevel
	rts

;---------------------------------------------------------
;--- adds all enemies for the given row				   ---
;---------------------------------------------------------
.counter dc.b $00
addEnemyLevelY	

	; search on y axis
	lda addEnemyLevelYPos
	sta .addEnemyLevelYPosTop

	lda addEnemyLevelYPos
	clc
	adc #$01
	sta .addEnemyLevelYPosBottom

	lda addEnemyLevelXPos
 	sec
 	sbc #LEFTRIGHTENEMYGUARD
 	bcs .normalnoclip3
 	lda #$00
.normalnoclip3
	sta addEnemyLevelXPos

	lda #40 + LEFTRIGHTENEMYGUARD*2
	sta .counter
.temp
	jsr addEnemyLevel
	inc addEnemyLevelXPos
	dec .counter
	bne .temp

	rts


;---------------------------------------------------------
;--- adds all enemies for the current screen     	   ---
;---------------------------------------------------------
	SUBROUTINE
.counter dc.b $00
.addEnemyLevelXPos dc.b $00
addEnemyAllOnScreen
	lda scrollPosXDiv4
	sta .addEnemyLevelXPos

	lda scrollPosYDiv8
	sta addEnemyLevelYPos

	lda #40+LEFTRIGHTENEMYGUARD
	sta .counter
.temp
	lda .addEnemyLevelXPos
	sta addEnemyLevelXPos
	jsr addEnemyLevelX
	inc .addEnemyLevelXPos
	dec .counter
	bne .temp

	rts	

;---------------------------------------------------------
;--- calls the in the accu given enemies init handler  ---
;--- accu = enemytype, x = gameobjectnr				   ---
;---------------------------------------------------------
initEnemy SUBROUTINE
	stx .saveX + 1
	tax
	asl
	tay
	lda enemyInitFuncs + 0,y
	sta .jmp + 1
	lda enemyInitFuncs + 1,y
	sta .jmp + 2
.saveX 
	ldx #$44
.jmp
	jmp $4444

;---------------------------------------------------------
;--- calls the in the accu given enemies frame handler ---
;---------------------------------------------------------

handleEnemy SUBROUTINE
	stx .xrestore + 1
	sty .yrestore + 1
	sta enemyNr
	tax
	lda #COLLISIONMODE_NORMAL
	sta collisionMode
	lda GameObjectEnemyType,x
	asl
	tax
	lda enemyHandleFuncs + 0,x
	sta .jmp + 1
	lda enemyHandleFuncs + 1,x
	sta .jmp + 2
	ldx enemyNr
.jmp
	jsr $4444
.xrestore
	ldx #$44
.yrestore
	ldy #$44
	rts

;---------------------------------------------------------
;--- function to clear a enemy if it is outside		   ---
;--- the extended screen area						   ---
;---------------------------------------------------------


clearLeftGuard dc.b $00
clearRightGuard dc.b $00
clearUpGuard dc.b $00
clearDownGuard dc.b $00

	SUBROUTINE
.testPosX				dc.w $00
.testPosY				dc.w $00
.enemiesEnemyDistance	ds.b GAMEOBJECTCOUNT,$00
.enemiesEnemyNr			ds.b GAMEOBJECTCOUNT,$00
.enemiesEnemyCount		dc.b $00
.enemiesFarestValue		dc.b $00
.enemiesFarestNr		dc.b $00
.enemyNrIntern			dc.b $00
.outa					dc.b $00
.distance				dc.b $00
clearMostOutsideEnemyExpanded
	lda #LEFTENEMYGUARDCLEAR + GUARDCLEAREXPANDX
	sta clearLeftGuard
	lda #UPENEMYGUARDCLEAR + GUARDCLEAREXPANDY
	sta clearUpGuard
	lda #40+RIGHTENEMYGUARDCLEAR + GUARDCLEAREXPANDX
	sta clearRightGuard
	lda #DISPLAYAREAROWS+DOWNENEMYGUARDCLEAR + GUARDCLEAREXPANDY
	sta clearDownGuard
	jmp clearMostOutsideEnemyIntern
clearMostOutsideEnemy
	lda #LEFTENEMYGUARDCLEAR
	sta clearLeftGuard
	lda #UPENEMYGUARDCLEAR
	sta clearUpGuard
	lda #40+RIGHTENEMYGUARDCLEAR
	sta clearRightGuard
	lda #DISPLAYAREAROWS+DOWNENEMYGUARDCLEAR
	sta clearDownGuard
clearMostOutsideEnemyIntern 

	lda #$00
	sta .enemiesEnemyCount
	lda enemyAddGameObjectIndexStart
	sta .enemyNrIntern

.collectLoop
	ldy .enemyNrIntern
	lda GameObjectCollisionType,y
	bne .doCheck
	jmp .next
.doCheck

	jsr getGameObjectScreenPosChars

	ldx .enemiesEnemyCount
	lda #$00
	sta .distance
	sta .outa

	lda gameObjectScreenPosXChars + 0
	clc
	adc clearLeftGuard ; 32 pixel
	sta .testPosX + 0
	lda gameObjectScreenPosXChars + 1
	adc #$00 ; 32 pixel
	sta .testPosX + 1
	bpl .itsDisplayed1
	lda #$01
	sta .outa
	lda .testPosX + 0
	eor #$ff
	clc
	adc #$01
	clc
	adc .distance
	sta .distance
.itsDisplayed1

	lda gameObjectScreenPosYChars + 0
	clc
	adc clearUpGuard ; 32 pixel
	sta .testPosY + 0
	lda gameObjectScreenPosYChars + 1
	adc #$00 ; 32 pixel
	sta .testPosY + 1
	bpl .itsDisplayed1b
	lda #$01
	sta .outa
	lda .testPosY + 0
	eor #$ff
	clc
	adc #$01
	clc
	adc .distance
	sta .distance
.itsDisplayed1b

	lda gameObjectScreenPosXChars + 0
	sec
	sbc clearRightGuard
	sta .testPosX + 0
	lda gameObjectScreenPosXChars + 1
	sbc #$00
	sta .testPosX + 1
	bmi .itsDisplayed2
	lda #$01
	sta .outa
	lda .testPosX + 0
	clc
	adc .distance
	sta .distance
	jmp .checka
.itsDisplayed2

	lda gameObjectScreenPosYChars + 0
	sec
	sbc clearDownGuard
	sta .testPosY + 0
	lda gameObjectScreenPosYChars + 1
	sbc #$00
	sta .testPosY + 1
	bmi .itsDisplayed2b
	lda #$01
	sta .outa
	lda .testPosY + 0
	clc
	adc .distance
	sta .distance
	jmp .checka
.itsDisplayed2b

.checka
	lda .outa
	beq .noouta
	ldx .enemiesEnemyCount
	lda .enemyNrIntern
	sta .enemiesEnemyNr,x
	lda .distance
	sta .enemiesEnemyDistance,x
	inc .enemiesEnemyCount
.noouta

.next
	inc .enemyNrIntern
	lda .enemyNrIntern
	cmp enemyAddGameObjectIndexEnd
	beq .collectLoopfin
	jmp .collectLoop
.collectLoopfin
	ldx .enemiesEnemyCount
	bne .someEnemiesCollected
	lda #$ff
	rts
.someEnemiesCollected
	; now search the one with the farest distance
	dex
	lda .enemiesEnemyDistance,x
	sta .enemiesFarestValue
	stx .enemiesFarestNr
.farloop
	lda .enemiesEnemyDistance,x
	cmp .enemiesFarestValue
	bmi .notfarer
	stx .enemiesFarestNr 
	sta .enemiesFarestValue
.notfarer
	dex
	bpl .farloop
	ldx .enemiesFarestNr
	lda .enemiesEnemyNr,x
	jsr removeEnemyFromScreen
	ldx .enemiesFarestNr
	lda .enemiesEnemyNr,x
	rts

;---------------------------------------------------------
;--- gets the screenposition of a gameobject in pixels ---
;---------------------------------------------------------
gameObjectScreenPosX	dc.w $0000
gameObjectScreenPosY	dc.w $0000
	SUBROUTINE
.scrollSubX				dc.w $0000
.scrollSubY				dc.w $0000
getGameObjectScreenPos 

	lda GameObjectXPosLo,y
	sec 
	sbc scrollPosXCurrent + 0
	sta gameObjectScreenPosX + 0
	lda GameObjectXPosHi,y
	sbc scrollPosXCurrent + 1
	sta gameObjectScreenPosX + 1

	lda GameObjectYPosLo,y
	sec 
	sbc scrollPosYCurrent + 0
	sta gameObjectScreenPosY + 0
	lda GameObjectYPosHi,y
	sbc scrollPosYCurrent + 1
	sta gameObjectScreenPosY + 1

	rts

;---------------------------------------------------------
;--- gets the screenposition of a gameobject in chars  ---
;---------------------------------------------------------
gameObjectScreenPosXChars	dc.w $0000
gameObjectScreenPosYChars	dc.w $0000
getGameObjectScreenPosChars SUBROUTINE
	jsr getGameObjectScreenPos
	
	lda gameObjectScreenPosX + 0
	lsr
	lsr
	sta gameObjectScreenPosXChars + 0
	lda gameObjectScreenPosX + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora gameObjectScreenPosXChars + 0
	sta gameObjectScreenPosXChars + 0
	lda gameObjectScreenPosX + 1
	lsr
	lsr
	sta gameObjectScreenPosXChars + 1
	lda gameObjectScreenPosX + 1
	bpl .notnegx
	lda #%11000000
	ora gameObjectScreenPosXChars + 1
	sta gameObjectScreenPosXChars + 1
.notnegx

	lda gameObjectScreenPosY + 0
	lsr
	lsr
	lsr
	sta gameObjectScreenPosYChars + 0
	lda gameObjectScreenPosY + 1
	asl
	asl
	asl
	asl
	asl
	ora gameObjectScreenPosYChars + 0
	sta gameObjectScreenPosYChars + 0
	lda gameObjectScreenPosY + 1
	lsr
	lsr
	lsr
	sta gameObjectScreenPosYChars + 1
	lda gameObjectScreenPosY + 1
	bpl .notnegy
	lda #%11100000
	ora gameObjectScreenPosYChars + 1
	sta gameObjectScreenPosYChars + 1
.notnegy

	rts

;---------------------------------------------------------
;--- removes the enemy in accu from the screen		   ---
;---------------------------------------------------------
removeEnemyFromScreen SUBROUTINE
	stx .restoreX + 1
	sty .restoreY + 1
	tax
	lda #$00
	sta GameObjectCollisionType,x
	sta GameObjectVisible,x
	ldy GameObjectLevelEnemyIndex,x
	cpy #NOLEVELENEMY
	beq .nolevelEnemy
	lda (ZP_ENEMYY_ENEMYTYPE),y
	and #255-ENEMY_FLAGS_ONSCREEN
	sta (ZP_ENEMYY_ENEMYTYPE),y
.nolevelEnemy
.restoreX
	ldx #$44
.restoreY
	ldy #$44
	rts

;---------------------------------------------------------
;--- marks the enemy in accu as destroyed in the level ---
;---------------------------------------------------------
removeEnemyFromLevel SUBROUTINE
	stx .restoreX + 1
	sty .restoreY + 1
	; tax at removeEnemyFromScreen
	jsr removeEnemyFromScreen
	ldy GameObjectLevelEnemyIndex,x
	cpy #NOLEVELENEMY
	beq .nolevelEnemy
	lda (ZP_ENEMYY_ENEMYTYPE),y
	ora #ENEMY_FLAGS_DESTROYED
	sta (ZP_ENEMYY_ENEMYTYPE),y
.nolevelEnemy
.restoreX
	ldx #$44
.restoreY
	ldy #$44
	rts


;---------------------------------------------------------
;--- moves the enemy sprite down by accu pixels		   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
moveEnemyDownByAccu SUBROUTINE
	stx .restoreX + 1
	ldx enemyNr
	clc
	adc GameObjectYPosLo,x
	sta GameObjectYPosLo,x
	lda GameObjectYPosHi,x
	adc #$00
	sta GameObjectYPosHi,x
.restoreX
	ldx #$44
	jmp collisionEnemyDown

;---------------------------------------------------------
;--- moves the enemy sprite up by accu pixels		   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
moveEnemyUpByAccu SUBROUTINE
	sta .collideSub + 1
	stx .restoreX + 1
	ldx enemyNr
	lda GameObjectYPosLo,x
	sec
.collideSub
	sbc #$44
	sta GameObjectYPosLo,x
	lda GameObjectYPosHi,x
	sbc #$00
	sta GameObjectYPosHi,x
.restoreX
	ldx #$44
	jmp collisionEnemyUp

;---------------------------------------------------------
;--- moves the enemy sprite right by accu pixels	   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
moveEnemyRightByAccu SUBROUTINE
	stx .restoreX + 1
	ldx enemyNr
	clc
	adc GameObjectXPosLo,x
	sta GameObjectXPosLo,x
	lda GameObjectXPosHi,x
	adc #$00
	sta GameObjectXPosHi,x
.restoreX
	ldx #$44
	jmp collisionEnemyRight

;---------------------------------------------------------
;--- moves the enemy sprite left by accu pixels		   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
moveEnemyLeftByAccu SUBROUTINE
	stx .restoreX + 1
	ldx enemyNr
	
	sta .collideSub + 1

	lda GameObjectXPosLo,x
	sec
.collideSub
	sbc #$44
	sta GameObjectXPosLo,x
	lda GameObjectXPosHi,x
	sbc #$00
	sta GameObjectXPosHi,x
.restoreX
	ldx #$44
	jmp collisionEnemyLeft


;---------------------------------------------------------
;--- collides down and moves enemy to right position   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
collisionEnemyDown SUBROUTINE
	stx .restoreX + 1
	sty .restoreY + 1

	lda #$00
	sta .collided + 1

	lda enemyNr
	jsr getCollisionFlagsDownForGameObject
	and #CHARFLAG_COLLISION
	beq .nocollision
	lda #$01
	sta .collided + 1
	lda enemyNr
	jsr replaceGameObjectToCollisionDown
.nocollision

.restoreX
	ldx #$44
.restoreY
	ldy #$44
.collided
	lda #$44
	rts

;---------------------------------------------------------
;--- collides up and moves enemy to right position	   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
collisionEnemyUp SUBROUTINE
	stx .restoreX + 1
	sty .restoreY + 1

	lda #$00
	sta .collided + 1

	lda enemyNr
	jsr getCollisionFlagsUpForGameObject
	and #CHARFLAG_COLLISION
	beq .nocollision
	lda #$01
	sta .collided + 1
	lda enemyNr
	jsr replaceGameObjectToCollisionUp
.nocollision

.restoreX
	ldx #$44
.restoreY
	ldy #$44
.collided
	lda #$44
	rts

;---------------------------------------------------------
;--- test collision to the right					   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
collisionEnemyRight SUBROUTINE
	stx .restoreX + 1
	sty .restoreY + 1

	lda #$00
	sta .collided + 1
	sta .retflags + 1

	lda enemyNr
	jsr getCollisionFlagsRightForGameObject
	sta .retflags + 1
	lda collisionMode
	and #COLLISIONMODEFLAG_WITHFLOOR
	beq .ready
	ldy enemyNr
	ldx #$00
	jsr getGameObjectRectangle
	lda collisionFlagRectYE + 0
	sta collisionFlagRectYS + 0
	lda collisionFlagRectYE + 1
	sta collisionFlagRectYS + 1
	lda collisionFlagRectXE + 0
	sta collisionFlagRectXS + 0
	lda collisionFlagRectXE + 1
	sta collisionFlagRectXS + 1
	jsr getCollisionFlags
	and #CHARFLAG_COLLISION
	bne .ready
	lda #CHARFLAG_COLLISION
	ora .retflags + 1
	sta .retflags + 1
.ready
.retflags
	lda #$44
	and #CHARFLAG_COLLISION
	beq .nocollision
	lda #$01
	sta .collided + 1
	lda enemyNr
	jsr replaceGameObjectToCollisionRight
.nocollision


.restoreX
	ldx #$44
.restoreY
	ldy #$44
.collided
	lda #$44
	rts

;---------------------------------------------------------
;--- test collision to the left						   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
collisionEnemyLeft SUBROUTINE
	stx .restoreX + 1
	sty .restoreY + 1

	lda #$00
	sta .collided + 1
	sta .retflags + 1

	lda enemyNr
	jsr getCollisionFlagsLeftForGameObject
	sta .retflags + 1
	lda collisionMode
	and #COLLISIONMODEFLAG_WITHFLOOR
	beq .ready
	ldy enemyNr
	ldx #$00
	jsr getGameObjectRectangle
	lda collisionFlagRectYE + 0
	sta collisionFlagRectYS + 0
	lda collisionFlagRectYE + 1
	sta collisionFlagRectYS + 1
	lda collisionFlagRectXS + 0
	sta collisionFlagRectXE + 0
	lda collisionFlagRectXS + 1
	sta collisionFlagRectXE + 1
	jsr getCollisionFlags
	and #CHARFLAG_COLLISION
	bne .ready
	lda #CHARFLAG_COLLISION
	ora .retflags + 1
	sta .retflags + 1
.ready
.retflags
	lda #$44
	and #CHARFLAG_COLLISION
	beq .nocollision
	lda #$01
	sta .collided + 1
	lda enemyNr
	jsr replaceGameObjectToCollisionLeft
.nocollision


.restoreX
	ldx #$44
.restoreY
	ldy #$44
.collided
	lda #$44
	rts

;---------------------------------------------------------
;--- moves the enemy left or right					   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
enemyMoveX SUBROUTINE
	cmp #$00
	beq .done
	bmi .neg
	jmp moveEnemyRightByAccu
.neg
	eor #$ff
	clc
	adc #$01
	jmp moveEnemyLeftByAccu
.done
	rts

enemyMoveXNoCollision SUBROUTINE
	stx .restoreX + 1
	sta .bmitest + 1
	ldx enemyNr
	clc
	adc GameObjectXPosLo,x
	sta GameObjectXPosLo,x
	lda #$00
.bmitest
	ldx #$44
	bpl .notbmi
	lda #$ff
.notbmi
	ldx enemyNr
	adc GameObjectXPosHi,x
	sta GameObjectXPosHi,x
.restoreX
	ldx #$44
	rts

;---------------------------------------------------------
;--- moves the enemy up or down						   ---
;--- returns Accu 0 if not collided and 1 if collided  ---
;---------------------------------------------------------
enemyMoveY SUBROUTINE
	cmp #$00
	beq .done
	bmi .neg
	jmp moveEnemyDownByAccu
.neg
	eor #$ff
	clc
	adc #$01
	jmp moveEnemyUpByAccu
.done
	rts

enemyMoveYNoCollision SUBROUTINE
	stx .restoreX + 1
	sta .bmitest + 1
	ldx enemyNr
	clc
	adc GameObjectYPosLo,x
	sta GameObjectYPosLo,x
	lda #$00
.bmitest
	ldx #$44
	bpl .notbmi
	lda #$ff
.notbmi
	ldx enemyNr
	adc GameObjectYPosHi,x
	sta GameObjectYPosHi,x
.restoreX
	ldx #$44
	rts

;---------------------------------------------------------
;--- explodes the enemy and removes an enemy from level---
;--- enemy nr in accu						           ---
;---------------------------------------------------------
explodeEnemy SUBROUTINE
	tay
	lda GameObjectCollisionType,y
	cmp #GAMEOBJECT_COLLISIONTYPE_ENEMY
	bne .noenemy
	jsr addSparkles
.noenemy
	jsr addExplosionForGameObject
	lda #ENEMY_TYPE_EXPLOSION
	sta GameObjectEnemyType,y
	lda enemyYEnd + ENEMY_TYPE_EXPLOSION ; for movedown
	sta GameObjectYEnd,y
	lda #$00
	sta GameObjectVar1,y
	sta GameObjectSpritePaintWhite,y
	sta GameObjectHitPoints,y
	lda #GAMEOBJECT_COLLISIONTYPE_NO_COLLISION
	sta GameObjectCollisionType,y
	lda #SOUND_EXPLOSION
	jsr triggerSound
	rts

;-------------------------------------------------------------
;-- removes all enemies from the screen					    --
;-------------------------------------------------------------
removeAllEnemiesFromScreen SUBROUTINE
	ldx #GAMEOBJECTCOUNT - 1
.next
	lda GameObjectLevelEnemyIndex,x
	cmp #NOLEVELENEMY
	beq .notclear
	txa
	jsr removeEnemyFromScreen
.notclear
	dex 
	bpl .next
	rts


;-------------------------------------------------------------
;--  adds some sparkles if enemy exploded                   --
;-------------------------------------------------------------
addSparkles SUBROUTINE
	jsr addExplosionForGameObject
	lda #$00
	sta enemyAddPropertyIntern
addSparklesIntern
	stx .xrestore + 1
	sty .yrestore + 1
 	lda #ENEMYSHOTSFROM
	sta enemyAddGameObjectIndexStart
	lda #ENEMYSHOTSTO
	sta enemyAddGameObjectIndexEnd
	lda GameObjectXPosLo,y
	sta enemyAddPosX + 0
	lda GameObjectXPosHi,y
	sta enemyAddPosX + 1
	lda GameObjectYPosLo,y
	sta enemyAddPosY + 0
	lda GameObjectYPosHi,y
	sta enemyAddPosY + 1
	lda #GAMEOBJECT_COLLISIONTYPE_NO_COLLISION
	sta enemyAddCollisionType
	lda #NOLEVELENEMY
	sta enemyAddLevelEnemyIndex
	lda #ENEMY_TYPE_SPARKLES
	sta enemyAddEnemyType
	jsr addEnemyIntern
.xrestore
	ldx #$44
.yrestore
	ldy #$44
	rts

add50 SUBROUTINE
	lda #SPRITEFRAMES_HIT50
	sta enemyAddPropertyIntern
	jmp addSparklesIntern
