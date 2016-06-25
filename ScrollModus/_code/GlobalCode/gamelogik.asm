disableGameLogik dc.b $00 ; no gamelogik at all just interstitials and so on
disablePlayerInteraction dc.b $00 ; the player isn't controllable and doesn't collide

playerShotActive dc.b $00

;-------------------------------------------------------------
;-- The main gamelogik loopfunction							--
;-------------------------------------------------------------
gameLogik SUBROUTINE
	lda disableGameLogik
	beq .enabled
	jmp .disabled
.enabled

	lda disablePlayerInteraction
	beq .playerInteraction
	jsr playerNotMoveUp
	jsr playerNotMoveDown
	jmp .noPlayerInteraction
.playerInteraction
	; player inputs

	lda joyMoveLeft
	beq .notleft
	jsr playerMoveLeft
.notleft

	lda joyMoveRight
	beq .notright
	jsr playerMoveRight
.notright

	lda joyMoveUp
	beq .notup
	jsr playerMoveUp
	jmp .updone
.notup
	jsr playerNotMoveUp
.updone


	lda joyMoveDown
	beq .notdown
	jsr playerMoveDown
	jmp .downdone
.notdown
	jsr playerNotMoveDown
.downdone

	lda joyPressed
	beq .notpressed
	jsr playerButton
	jmp .donepressed
.notpressed
	jsr playerNotButton
.donepressed

	; gravity
	jsr playerGravity
	jsr playerAlways

	; display some dust if required
	jsr playerDisplayDustFrame

	; clamp the player
	jsr clampPlayerPos
.noPlayerInteraction

	; handle the enemies
	jsr handleEnemies

	; perhaps we can clear some enemies
	jsr clearSomeEnemies

	; did our shot hit something
	; shots are evaluated every frame (not every second like the enemies)
	lda playerShotActive
	beq .noshotactive
	jsr checkCollsionWithPlayerShot 
	lda #$00
	sta playerShotActive
.noshotactive

	lda disablePlayerInteraction
	bne .noplayerStuff

	; check collisions
	lda gameLogikCounter
	and #$03
	bne .defercollision
	lda #NOSTONE
	sta playerIsBeforeStone
	lda #NOSCHALTER
	sta playerIsBeforeSchalter
	jsr checkCollisionWithPlayer
.defercollision

	; place the right animation frame
	jsr animatePlayer

	; generate a new scroll position
	jsr playerGenNewScrollPos
.noplayerStuff

	incWord gameLogikCounter

.disabled

	inc lastSoundTrigger

	rts

;-------------------------------------------------------------
;-- The gamelogik once a frame loopfunction					--
;-------------------------------------------------------------
gameLogikPerBlit SUBROUTINE
	jsr clearEnemyHitFlags
	rts

;-------------------------------------------------------------
;-- Clears some enemies on a constant framerate				--
;-------------------------------------------------------------
clearSomeEnemies SUBROUTINE

	lda gameLogikCounter
	and #31
	bne .dontClearEnemies

	lda #NORMALENEMIESSTARTINDEX
	sta enemyAddGameObjectIndexStart
	lda #NORMALENEMIESENDINDEX
	sta enemyAddGameObjectIndexEnd

	jsr clearMostOutsideEnemyExpanded 

	lda #COLLECTABLESFROM
	sta enemyAddGameObjectIndexStart
	lda #COLLECTABLESTO
	sta enemyAddGameObjectIndexEnd

	jsr clearMostOutsideEnemyExpanded 

	lda #ENEMYSHOTSFROM
	sta enemyAddGameObjectIndexStart
	lda #ENEMYSHOTSTO
	sta enemyAddGameObjectIndexEnd

	jsr clearMostOutsideEnemyExpanded 

.dontClearEnemies
	rts

-------------------------------------------------------------
;-- handles the enemies (main loopfunction)					--
;-------------------------------------------------------------
handleEnemies SUBROUTINE

	; oneframed gamelogik

	lda #PLAYERSHOTSFROM
	sta gameObjectsStart
	lda #PLAYERSHOTSTO
	sta gameObjectsEnd
	jsr handleGameEnemyObjects

	lda gameLogikCounter 
	and #$01
	bne .do
	rts
.do

	; twoframed gamelogik

	lda #COLLECTABLESFROM
	sta gameObjectsStart
	lda #COLLECTABLESTO
	sta gameObjectsEnd
	jsr handleGameEnemyObjects

	lda #NORMALENEMIESSTARTINDEX
	sta gameObjectsStart
	lda #NORMALENEMIESENDINDEX
	sta gameObjectsEnd
	jsr handleGameEnemyObjects
	
	lda #ENEMYSHOTSFROM
	sta gameObjectsStart
	lda #ENEMYSHOTSTO
	sta gameObjectsEnd
	jsr handleGameEnemyObjects

	lda #ITEMGAMEOBJECT
	sta gameObjectsStart
	lda #ITEMGAMEOBJECT + 1
	sta gameObjectsEnd
	jsr handleGameEnemyObjects

	rts

gameObjectsStart	dc.b $00 ; enemies to handle start
gameObjectsEnd		dc.b $00 ; enemies to handle end

;-------------------------------------------------------------
;-- handles a subpart of the GameObjectEnemies				--
;-------------------------------------------------------------
	SUBROUTINE
.current dc.b $00
handleGameEnemyObjects
	lda gameObjectsStart
	sta .current
.reloop
	ldx .current
	lda GameObjectCollisionType,x
	beq .nothandle
	txa
	jsr handleEnemy
	ldx .current
	inc GameObjectActiveCounter,x
.nothandle
	inc .current
	lda .current
	cmp gameObjectsEnd
	bne .reloop
	rts

	SUBROUTINE
.count dc.b $00
checkCollisionWithPlayer 
	ldx #$02
	ldy #PLAYERGAMEOBJECT
	jsr getGameObjectRectangle
	
	lda #$00
	sta .count
.next
	ldx .count
	lda GameObjectCollisionType,x
	tay
	lda checkIsCollidesForPlayer,y ; be aware here the enemies will be filtered
	beq .notcollidewithplayer
	lda GameObjectVisible,x
	beq .notcollidewithplayer

	ldx #$00
	ldy .count
	jsr getGameObjectRectangle

	jsr gameObjectsCollided 
	cmp #$01
	beq .notcollidewithplayer
	lda .count
	jsr gameObjectCollidedWithPlayer

.notcollidewithplayer
	inc .count
	lda .count
	cmp #GAMEOBJECTCOUNT
	bne .next

	rts

	SUBROUTINE
.count1 dc.b $00
.count2 dc.b $00
checkCollsionWithPlayerShot 
	lda #$00
	sta .count1
.nextshot
	ldx .count1
	lda GameObjectCollisionType,x
	cmp #GAMEOBJECT_COLLISIONTYPE_PLAYER_SHOT
	bne .donextshot
	txa
	tay
	ldx #$02
	jsr getGameObjectRectangle ; the shot in slot2
	lda #$00
	sta .count2
.nextenemy
	ldx .count2
	lda GameObjectCollisionType,x
	cmp #GAMEOBJECT_COLLISIONTYPE_ENEMY
	beq .collidewithshot
	jmp .notcollidewithshot
.collidewithshot
	lda GameObjectVisible,x
	beq .notcollidewithshot
	ldx #$00
	ldy .count2
	jsr getGameObjectRectangle
	jsr gameObjectsCollided 
	cmp #$01
	beq .notcollidewithshot
	lda .count1
	;jsr explodeEnemy
	jsr removeEnemyFromScreen
	lda .count2
	jsr gameObjectCollidedWithShot
.notcollidewithshot
	inc .count2
	lda .count2
	cmp #GAMEOBJECTCOUNT
	bne .nextenemy
.donextshot
	inc .count1
	lda .count1
	cmp #GAMEOBJECTCOUNT
	bne .nextshot
	rts


;-------------------------------------------------------------
;-- a enemy collided with the player so handle it			--
;-------------------------------------------------------------
gameObjectCollidedWithPlayer SUBROUTINE
	tax
	lda GameObjectCollisionType,x
	cmp #GAMEOBJECT_COLLISIONTYPE_ENEMY
	bne .notEnemy
	txa
	jmp enemyCollidedWithPlayer
.notEnemy
	cmp #GAMEOBJECT_COLLISIONTYPE_ENEMY_SHOT
	bne .notEnemyShot
	txa
	jmp enemyShotCollidedWithPlayer
.notEnemyShot
	cmp #GAMEOBJECT_COLLISIONTYPE_COLLECTABLE
	bne .notCollectable
	txa
	jmp collectableCollidedWithPlayer
.notCollectable
	cmp #GAMEOBJECT_COLLISIONTYPE_MAGIC
	bne .notMagic
	txa
	jmp magicCollidedWithPlayer
.notMagic
	cmp #GAMEOBJECT_COLLISIONTYPE_SCHALTER
	bne .notSchalter
	txa
	jmp schalterCollidedWithPlayer
.notSchalter
	rts

;-------------------------------------------------------------
;-- a gameObject collided with a player shot so handle it	--
;-------------------------------------------------------------
gameObjectCollidedWithShot SUBROUTINE
	jmp enemyCollidedWithPlayerShot

;-------------------------------------------------------------
;-- clears the blink flag of a enemy updated once per frame --
;-------------------------------------------------------------
clearEnemyHitFlags SUBROUTINE
	ldx #GAMEOBJECTCOUNT - 1
.next
	lda GameObjectHit,x
	beq .nothit
	dec GameObjectHit,x
.nothit
	dex 
	bpl .next
	rts

