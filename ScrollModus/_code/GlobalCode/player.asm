QUITFLAG_LOADGAMEOVER  = $01
QUITFLAG_LOADNEXTLEVEL = $02
quitFlag dc.b $00

NOSTONE				= $ff
NOSCHALTER			= $ff
playerIsBeforeStone		dc.b NOSTONE
playerIsBeforeSchalter	dc.b NOSCHALTER
schalterPressed			dc.b $00

GRAVITY							= $0020
JUMP_VELOCITY					= $0440
JUMP_VELOCITY_DECREASE			= $0030
MOVESPEED						= 1
DASH_VELOCITY					= $0300
HIT_VELOCITY					= $0200
SHOT_JUMP_VELOCITY				= $0280
SHOT_KICK_ADD					= $0400

PLAYERFLICKER_DURATION			= $1c
PLAYERSHIELD_DURATION_START		= $40
PLAYERSHIELD_DURATION_NORMAL	= $200

DASH_POINTS_SUBTRACT			= $05


PLAYERHIT_FRAMES				= $10

CHARFLAG_COLLISION				= $01
CHARFLAG_DEATH					= $40

FULLENERGY						= $05

onGround						dc.b $00
isPlayerVelocityMovingUp		dc.b $00
isPlayerVelocityMovingDown		dc.b $00
jumpUpAdd						dc.w $0000
fallDownAdd						dc.w $0000
continuosjump					dc.b $00


jumpAnimEnabled					dc.b $00
playerDirection					dc.b $00
playerHit						dc.b $00 ; if the player is hit currently (a duration for the animation)
playerFlickerOn					dc.b $00
playerShieldOn					dc.w $0000 ; word counter
framesSteps						dc.w $0000

KATE_SPRITES_START				= 0
pANIMMODE_STAND					= $00
pANIMMODE_WALK					= $01
pANIMMODE_JUMP					= $02
pANIMMODE_SHOT					= $03
pANIMMODE_HIT					= $04
pANIMMODE_WAIT					= $05

pAnimMode						dc.b $00

SWITCHANIMMODECOUNT				= $07
STONESWITCHANIMMODECOUNT		= $10
STONESWITCHANIMMODECOUNTACTIVATE = $02
pSwitchAnimModeCounter			dc.b $00
SWITCHMODETYPESTONE				= 1
SWITCHMODETYPESWITCH			= 2
pSwitchAnimModeType				dc.b $00
pSwitchAnimModeTemp				dc.b $00

song_double_speed				dc.b $00

joyMoveLeft  dc.b $00
joyMoveRight dc.b $00
joyMoveUp	 dc.b $00
joyMoveDown	 dc.b $00
joyPressed   dc.b $00

addSparkleRequested  dc.b $00

;-------------------------------------------------------------
;-- initializes the player							        --
;-------------------------------------------------------------
initPlayer SUBROUTINE
	lda #$00
	sta jumpUpAdd	+ 0
	sta jumpUpAdd	+ 1
	sta fallDownAdd + 0
	sta fallDownAdd + 1
	sta jumpAnimEnabled
	sta disableGameLogik
	sta disablePlayerInteraction
	sta playerHit
	sta playerFlickerOn
	sta addSparkleRequested
	sta schalterPressed
	sta pSwitchAnimModeCounter
	sta pSwitchAnimModeType
	lda #$01
	sta playerDirection
	lda #<PLAYERSHIELD_DURATION_START
	sta playerShieldOn + 0
	lda #>PLAYERSHIELD_DURATION_START
	sta playerShieldOn + 1
	rts

;-------------------------------------------------------------
;-- set the player spriteimage animation properties		    --
;-------------------------------------------------------------
animatePlayer SUBROUTINE

	lda #$00
	ldx playerDirection
	bne .notflippedX
	lda #$01
.notflippedX
	sta GameObjectSpriteFlippedX + PLAYERGAMEOBJECT

	; if we fallDown we are jumping so set the anim mode
	lda jumpAnimEnabled
	beq .notjumping1
	lda #pANIMMODE_JUMP
	sta pAnimMode
.notjumping1

	lda playerCanShotAgain
	bne .notshot
	lda #pANIMMODE_SHOT
	sta pAnimMode
.notshot

	; now handle the player animation
	lda #KATE_SPRITES_START + 0
	sta GameObjectSpriteImage + PLAYERGAMEOBJECT
	lda #$00
	sta GameObjectSpritePaintWhite + PLAYERGAMEOBJECT

	; if the player got hit override animation
	lda playerHit
	beq .playerNotHit
	lda #pANIMMODE_HIT
	sta pAnimMode
	dec playerHit
.playerNotHit

	; handle kick
	lda playerKickAdd + 0
	ora playerKickAdd + 1
	beq .nokick
	lda #pANIMMODE_JUMP
	sta pAnimMode
	lda playerKickAdd + 1
	cmp #PLAYER_KICK_HIT_TEST
	bcs .nokick
	lda #pANIMMODE_SHOT
	sta pAnimMode
	;ldy #PLAYERGAMEOBJECT
	;jsr addSparkles
.nokick

	; display the right player sprite onhand of anim mode
	lda pAnimMode
	cmp #pANIMMODE_STAND
	bne .notstanding
	lda #KATE_SPRITES_START + 0
	sta GameObjectSpriteImage + PLAYERGAMEOBJECT
.notstanding

	lda pAnimMode
	cmp #pANIMMODE_WAIT
	bne .notwaiting
	lda #KATE_SPRITES_START + 0
	sta GameObjectSpriteImage + PLAYERGAMEOBJECT
	incWord playerWaitCounter
	lda playerWaitCounter + 0
	bne .nodust
	jsr DISPLAYDUST3
.nodust
	lda playerWaitCounter + 1
	clc
	adc #$01
	and #$03
	bne .normalwait
	lda playerWaitCounter
	cmp #$20
	bcs .notwaiting
	ldx #KATE_SPRITES_START + 11
	lda playerWaitCounter + 1
	and #$04
	beq .zwo
	ldx #KATE_SPRITES_START + 8
.zwo
	stx GameObjectSpriteImage + PLAYERGAMEOBJECT
	jmp .notwaiting
.normalwait
	lda playerWaitCounter
	and #$50
	bne .notwaiting
	lda #KATE_SPRITES_START + 1
	sta GameObjectSpriteImage + PLAYERGAMEOBJECT
.notwaiting

	lda pAnimMode
	cmp #pANIMMODE_WALK
	bne .notwalking
	lda framesSteps
	lsr
	and #$07
	clc
	adc #KATE_SPRITES_START
	sta GameObjectSpriteImage + PLAYERGAMEOBJECT
.notwalking
	lda pAnimMode
	cmp #pANIMMODE_SHOT
	bne .notshooting
	lda #KATE_SPRITES_START + 8
	sta GameObjectSpriteImage + PLAYERGAMEOBJECT
.notshooting
	lda pAnimMode
	cmp #pANIMMODE_JUMP
	bne .notjumping
	lda #KATE_SPRITES_START + 9
	sta GameObjectSpriteImage + PLAYERGAMEOBJECT
.notjumping
	lda pAnimMode
	cmp #pANIMMODE_HIT
	bne .nothit
	lda #KATE_SPRITES_START + 10
	sta GameObjectSpriteImage + PLAYERGAMEOBJECT
.nothit

	lda pSwitchAnimModeCounter
	beq .notSwitch

	dec pSwitchAnimModeCounter
	lda #KATE_SPRITES_START + 11
	sta GameObjectSpriteImage + PLAYERGAMEOBJECT
	lda pSwitchAnimModeCounter
	cmp #STONESWITCHANIMMODECOUNTACTIVATE
	bne .notactivateSwitchMode
	
	lda pSwitchAnimModeType
	cmp #SWITCHMODETYPESTONE
	bne .notStone
	lda #SOUND_COLLECTED
	jsr triggerSound
	jsr displayTextScreen
	jmp .notactivateSwitchMode
.notStone
	cmp #SWITCHMODETYPESWITCH
	bne .notSwitchButton
	lda #SOUND_SCHALTER
	jsr triggerSound
	lda pSwitchAnimModeTemp
	jsr updateLayer
	jmp .notactivateSwitchMode
.notSwitchButton

.notactivateSwitchMode

.notSwitch

	; animate shot mode getting
	lda playerFlickerOn
	beq .noflicker1
	dec playerFlickerOn
	and #$04
	beq .noflicker1
	lda #$01
	sta GameObjectSpritePaintWhite + PLAYERGAMEOBJECT
.noflicker1

	; animate shield mode
	lda #$00
	sta song_double_speed
	lda playerShieldOn + 0
	ora playerShieldOn + 1
	beq .noflicker2
	
	lda  playerShieldOn + 0
	and #$0f
	bne .notaddsparkles
	lda #$01
	sta addSparkleRequested
.notaddsparkles

	lda addSparkleRequested
	beq .nosparkles
	ldy #PLAYERGAMEOBJECT
	jsr addSparkles
	cmp #$ff
	beq .nosparkles
	lda #$00
	sta addSparkleRequested
.nosparkles

	
	dec playerShieldOn + 0
	lda playerShieldOn + 0
	cmp #$ff
	bne .nothi
	dec playerShieldOn + 1
.nothi
	and #$0c
	beq .noflicker2a
	lda #$01
	sta GameObjectSpritePaintWhite + PLAYERGAMEOBJECT
.noflicker2a
	lda #$01
	sta song_double_speed
.noflicker2
	
	; increment the current gamelogic frame
	inc framesSteps + 0
	bne .frsnohi
	inc framesSteps + 1
.frsnohi

	lda #pANIMMODE_STAND
	sta pAnimMode
	rts

PLAYER_KICK_HIT_TEST = $02
PLAYER_KICK_ADD_SUB = $20
PLAYER_KICK_ADD = $0300
playerKickAdd	dc.w $0000
playerKickDirection dc.b $00
playerIsKicking dc.b $00

WAIT_FORSPECIALANIM = $60
playerStanding dc.b $00
playerWaitCounter dc.w $0000
;-------------------------------------------------------------
;-- called every tick										--
;-------------------------------------------------------------
playerAlways SUBROUTINE

	lda pAnimMode
	cmp #pANIMMODE_STAND
	beq .notwait
	lda #WAIT_FORSPECIALANIM
	sta playerStanding
.notwait

	lda playerStanding
	beq .waitAnim
	dec playerStanding
	lda #$00
	sta playerWaitCounter + 0
	sta playerWaitCounter + 1
	jmp .notWaitAnim
.waitAnim
	lda #pANIMMODE_WAIT
	sta pAnimMode
.notWaitAnim


	lda playerKickAdd + 0
	ora playerKickAdd + 1
	bne .doKick
	rts
.doKick

	lda playerKickDirection
	beq .neg
	lda GameObjectXPosLo + PLAYERGAMEOBJECT
	clc
	adc playerKickAdd + 1
	sta GameObjectXPosLo + PLAYERGAMEOBJECT
	lda GameObjectXPosHi + PLAYERGAMEOBJECT
	adc #$00
	sta GameObjectXPosHi + PLAYERGAMEOBJECT
	lda #PLAYERGAMEOBJECT
	jsr getCollisionFlagsRightForGameObject
	and #CHARFLAG_COLLISION
	beq .notcollidedright
	lda #PLAYERGAMEOBJECT
	jsr replaceGameObjectToCollisionRight
.notcollidedright
	jmp .flattenvalue
.neg
	lda GameObjectXPosLo + PLAYERGAMEOBJECT
	sec
	sbc playerKickAdd + 1
	sta GameObjectXPosLo + PLAYERGAMEOBJECT
	lda GameObjectXPosHi + PLAYERGAMEOBJECT
	sbc #$00
	sta GameObjectXPosHi + PLAYERGAMEOBJECT
	lda #PLAYERGAMEOBJECT
	jsr getCollisionFlagsLeftForGameObject
	and #CHARFLAG_COLLISION
	beq .notcollidedleft
	lda #PLAYERGAMEOBJECT
	jsr replaceGameObjectToCollisionLeft
.notcollidedleft

.flattenvalue
	lda playerKickAdd + 0
	sec
	sbc #<PLAYER_KICK_ADD_SUB
	sta playerKickAdd + 0
	lda playerKickAdd + 1
	sbc #>PLAYER_KICK_ADD_SUB
	sta playerKickAdd + 1
	bpl .ok
	lda #$00
	sta playerKickAdd + 0
	sta playerKickAdd + 1
.ok

	rts

;-------------------------------------------------------------
;-- gathers the joystick									--
;-------------------------------------------------------------
; 7    Joystick 2 Fire    (0=Pressed, 1=Released)
; 6    Joystick 1 Fire    (0=Pressed, 1=Released)
; 3    Joystick 1/2 Right (0=Moved, 1=Released)
; 2    Joystick 1/2 Left  (0=Moved, 1=Released)
; 1    Joystick 1/2 Down  (0=Moved, 1=Released)
; 0    Joystick 1/2 Up    (0=Moved, 1=Released) 
JOYSTICKSELECT = %00000010 ; select joy 1 (bit 2 = 0) (deselect joy 2 bit 3 = 1)
	SUBROUTINE
.temp dc.b $00
; lda #$ff
; sta $fd30 ; for the keyboard latch is done at the loading screen
gatherJoystick 
	lda #JOYSTICKSELECT
	sta $ff08
	lda $ff08
	eor #$ff
	sta .temp
	and #$01
	sta joyMoveUp
	lda .temp
	and #$02
	sta joyMoveDown
	lda .temp
	and #$04
	sta joyMoveLeft
	lda .temp
	and #$08
	sta joyMoveRight
	lda .temp
	and #$40
	sta joyPressed 
	rts

;-------------------------------------------------------------
;-- handles the joystick left								--
;-------------------------------------------------------------
playerMoveLeft SUBROUTINE

	lda playerDirection
	cmp #$01
	bne .notstaub
	lda onGround
	beq .notstaub
	jsr DISPLAYDUST2
.notstaub

	lda #$00
	sta playerDirection
	lda #pANIMMODE_WALK
	sta pAnimMode


	ldy #PLAYERGAMEOBJECT
	lda #<[-MOVESPEED]
	jsr moveGameObjectByAccuX

	lda #PLAYERGAMEOBJECT
	jsr getCollisionFlagsLeftForGameObject
	and #CHARFLAG_COLLISION
	beq .notcollided
	lda #PLAYERGAMEOBJECT
	jsr replaceGameObjectToCollisionLeft
.notcollided

	rts

;-------------------------------------------------------------
;-- handles the joystick right								--
;-------------------------------------------------------------
playerMoveRight SUBROUTINE

	lda playerDirection
	cmp #$00
	bne .notstaub
	lda onGround
	beq .notstaub
	jsr DISPLAYDUST2
.notstaub

	lda #$01
	sta playerDirection
	lda #pANIMMODE_WALK
	sta pAnimMode

	ldy #PLAYERGAMEOBJECT
	lda #<[MOVESPEED]
	jsr moveGameObjectByAccuX

	lda #PLAYERGAMEOBJECT
	jsr getCollisionFlagsRightForGameObject
	and #CHARFLAG_COLLISION
	beq .notcollided
	lda #PLAYERGAMEOBJECT
	jsr replaceGameObjectToCollisionRight
.notcollided
	rts

;-------------------------------------------------------------
;-- handles the joystick up									--
;-------------------------------------------------------------
playerMoveUp SUBROUTINE

	lda onGround
	beq .notonground
	lda #SOUND_JUMP
	jsr triggerSound
	lda #$01
	sta continuosjump
	lda #$01
	sta jumpAnimEnabled
.notonground
	
	lda continuosjump
	beq .notcontinuos
	lda #<JUMP_VELOCITY
	sta jumpUpAdd + 0 
	lda #>JUMP_VELOCITY
	sta jumpUpAdd + 1 
.notcontinuos
	rts

;-------------------------------------------------------------
;-- handles the joystick NOT up								--
;-------------------------------------------------------------
playerNotMoveUp SUBROUTINE
	lda #$00
	sta continuosjump
	rts

;-------------------------------------------------------------
;-- handles the joystick down								--
;-------------------------------------------------------------
playerMoveDown SUBROUTINE

	lda playerIsBeforeStone
	cmp #NOSTONE
	beq .notbeforeastone
	lda #SWITCHMODETYPESTONE
	sta pSwitchAnimModeType
	lda playerIsBeforeStone
	sta textScreenNumber
	lda #STONESWITCHANIMMODECOUNT
	sta pSwitchAnimModeCounter
	jmp .nokick
.notbeforeastone

	lda schalterPressed
	beq .notschalting
	lda #SWITCHANIMMODECOUNT
	sta pSwitchAnimModeCounter
	jmp .nokick
.notschalting

	lda playerIsBeforeSchalter
	cmp #NOSCHALTER
	beq .notbeforeaschalter
	lda #SWITCHANIMMODECOUNT
	sta pSwitchAnimModeCounter
	lda #SWITCHMODETYPESWITCH
	sta pSwitchAnimModeType
	lda #$01
	sta schalterPressed
	lda playerIsBeforeSchalter
	sta pSwitchAnimModeTemp
	asl
	tax
	lda layers + 0,x
	sta ZP_BYTE + 0
	lda layers + 1,x
	sta ZP_BYTE + 1
	ldy #$00
	lda (ZP_BYTE),y
	eor #$01
	sta (ZP_BYTE),y
	jmp .nokick
.notbeforeaschalter

	lda onGround
	beq .nokick
	lda playerIsKicking
	bne .nokick
	lda #$01
	sta playerIsKicking
	lda #SOUND_KICK
	jsr triggerSound
	lda #<PLAYER_KICK_ADD
	sta playerKickAdd + 0
	lda #>PLAYER_KICK_ADD
	sta playerKickAdd + 1
	lda playerDirection
	sta playerKickDirection
.nokick	
	rts

;-------------------------------------------------------------
;-- handles the joystick NOT down							--
;-------------------------------------------------------------
playerNotMoveDown SUBROUTINE
	lda #$00
	sta playerIsKicking
	lda #$00
	sta playerKickAdd + 0
	sta playerKickAdd + 1
	lda #$00
	sta schalterPressed
	rts

playerCanShotAgain dc.b $01
;-------------------------------------------------------------
;-- handles the joystick button								--
;-------------------------------------------------------------
playerButton SUBROUTINE
	lda ZP_BALLS
	bne .haveballs
	rts
.haveballs
	lda playerCanShotAgain
	cmp #$01
	bne .notshot
	lda #$00
	sta playerCanShotAgain
	lda #PLAYERSHOTSFROM
	sta enemyAddGameObjectIndexStart
	lda #PLAYERSHOTSTO
	sta enemyAddGameObjectIndexEnd
	lda GameObjectXPosLo + PLAYERGAMEOBJECT
	sta enemyAddPosX + 0
	lda GameObjectXPosHi + PLAYERGAMEOBJECT
	sta enemyAddPosX + 1
	lda GameObjectYPosLo + PLAYERGAMEOBJECT
	clc
	adc #<[PLAYER_YEND-6]
	sta enemyAddPosY + 0
	lda GameObjectYPosHi + PLAYERGAMEOBJECT
	adc #>[PLAYER_YEND-6]
	sta enemyAddPosY + 1
	lda #GAMEOBJECT_COLLISIONTYPE_PLAYER_SHOT
	sta enemyAddCollisionType
	lda #NOLEVELENEMY
	sta enemyAddLevelEnemyIndex
	lda #ENEMY_TYPE_PLAYERSHOT
	sta enemyAddEnemyType
	jsr addEnemyIntern
	cmp #$ff
	beq .notpossible
	lda #<SHOT_JUMP_VELOCITY
	sta jumpUpAdd + 0 
	lda #>SHOT_JUMP_VELOCITY
	sta jumpUpAdd + 1 
	lda #<SHOT_KICK_ADD
	sta playerKickAdd + 0
	lda #>SHOT_KICK_ADD
	sta playerKickAdd + 1
	lda playerDirection
	eor #$01
	sta playerKickDirection
	lda #SOUND_LAZER
	jsr triggerSound
	dec ZP_BALLS
.notpossible

.notshot

	rts

;-------------------------------------------------------------
;-- handles the joystick button	NOT PRESSED					--
;-------------------------------------------------------------
playerNotButton SUBROUTINE
	lda #$01
	sta playerCanShotAgain
	rts

;-------------------------------------------------------------
;-- handles the gravity and jumping							--
;-------------------------------------------------------------
	SUBROUTINE
.playerYVelocityClamped dc.w $00
playerGravity 
	
	; decrease jump velocity
	lda jumpUpAdd + 0
	sec
	sbc #<JUMP_VELOCITY_DECREASE
	sta jumpUpAdd + 0
	lda jumpUpAdd + 1
	sbc #>JUMP_VELOCITY_DECREASE
	sta jumpUpAdd + 1
	bpl .notneg
	lda #$00
	sta jumpUpAdd + 0
	sta jumpUpAdd + 1
.notneg
	
	; increase gravity
	lda fallDownAdd + 0
	clc
	adc #<GRAVITY
	sta fallDownAdd + 0
	lda fallDownAdd + 1
	adc #>GRAVITY
	sta fallDownAdd + 1

	; calculate velocity
	ldx #$00
	lda fallDownAdd + 0
	sec
	sbc jumpUpAdd + 0
	sta .playerYVelocityClamped + 0
	lda fallDownAdd + 1
	sbc jumpUpAdd + 1
	sta .playerYVelocityClamped + 1
	bpl .notjumping
	ldx #$01
.notjumping
	stx isPlayerVelocityMovingUp

	lda #$00
	sta isPlayerVelocityMovingDown
	lda .playerYVelocityClamped + 1
	bmi .notmovingdown
	lda #$01
	sta isPlayerVelocityMovingDown
.notmovingdown

	lda .playerYVelocityClamped + 1
	bmi .positivevalueok
	cmp #$07
	bmi .positivevalueok
	lda #$00
	sta .playerYVelocityClamped + 0
	lda #$07
	sta .playerYVelocityClamped + 1
.positivevalueok

	lda .playerYVelocityClamped + 1
	bpl .negativevalueok
	cmp #<[-$07]
	bpl .negativevalueok
	lda #$ff
	sta .playerYVelocityClamped + 0
	lda #<[-$07]
	sta .playerYVelocityClamped + 1
.negativevalueok

	; add velocity to player
	lda GameObjectYPosLoLo + PLAYERGAMEOBJECT
	clc
	adc .playerYVelocityClamped + 0
	sta GameObjectYPosLoLo + PLAYERGAMEOBJECT
	lda GameObjectYPosLo + PLAYERGAMEOBJECT
	adc .playerYVelocityClamped + 1
	sta GameObjectYPosLo + PLAYERGAMEOBJECT
	lda #$00
	ldx .playerYVelocityClamped + 1
	bpl .notnegvelocity
	lda #$ff
.notnegvelocity
	adc GameObjectYPosHi + PLAYERGAMEOBJECT
	sta GameObjectYPosHi + PLAYERGAMEOBJECT

	; check collisions
	lda .playerYVelocityClamped + 0
	ora .playerYVelocityClamped + 1
	beq .nocollision
	lda #$00
	sta onGround
	lda .playerYVelocityClamped + 1
	bmi .collisionTestUp
	lda #PLAYERGAMEOBJECT
	jsr getCollisionFlagsDownForGameObject
	and #CHARFLAG_COLLISION|CHARFLAG_DEATH
	beq .nocollision
	and #CHARFLAG_DEATH
	beq .notdeath
	jmp initiateLiveLost
.notdeath
	lda #PLAYERGAMEOBJECT
	jsr replaceGameObjectToCollisionDown
	lda #$00
	sta fallDownAdd + 0
	sta fallDownAdd + 1
	lda #$01
	sta onGround
	lda #$00
	sta isPlayerVelocityMovingDown
	lda #$00
	sta jumpAnimEnabled
	jsr groundSavePointCheck
	jmp .nocollision
.collisionTestUp
	lda #PLAYERGAMEOBJECT
	jsr getCollisionFlagsUpForGameObject
	and #CHARFLAG_COLLISION
	beq .nocollision
	lda #PLAYERGAMEOBJECT
	jsr replaceGameObjectToCollisionUp
	lda jumpUpAdd + 0
	sta fallDownAdd + 0
	lda jumpUpAdd + 1
	sta fallDownAdd + 1
	lda #$00
	sta jumpUpAdd + 0
	sta jumpUpAdd + 1
	jmp .nocollision
.nocollision
	rts

;-------------------------------------------------------------
;-- checks if on ground and puts a save point if			--
;-------------------------------------------------------------
groundSavePointCheck SUBROUTINE
	lda gameLogikCounter
	and #$07
	bne .nosavepoint
	lda #PLAYERGAMEOBJECT
	tay
	ldx #$00
	jsr getGameObjectRectangle
	lda collisionFlagRectYE + 0
	sta collisionFlagRectYS + 0
	lda collisionFlagRectYE + 1
	sta collisionFlagRectYS + 1

	lda collisionFlagRectXS + 0
	clc
	adc #<$04
	sta collisionFlagRectXS + 0
	sta collisionFlagRectXE + 0
	lda collisionFlagRectXS + 1
	adc #>$04
	sta collisionFlagRectXS + 1
	sta collisionFlagRectXE + 1

	jsr getCollisionFlags
	and #CHARFLAG_COLLISION
	beq .nosavepoint
	jsr setOnGroundSavePoint
.nosavepoint
	rts

;-------------------------------------------------------------
;-- builds a scroll pos from the player position			--
;-------------------------------------------------------------
SCREENMIDX = 80-8
SCREENMIDY = 100-16
XINSCREEN dc.w $0000
SCROLLNOTINXMID dc.b $00
playerGenNewScrollPos SUBROUTINE

	lda GameObjectXPosLo + PLAYERGAMEOBJECT
	sec
	sbc #<SCREENMIDX
	sta XINSCREEN + 0
	lda GameObjectXPosHi + PLAYERGAMEOBJECT
	sbc #>SCREENMIDX
	sta XINSCREEN + 1
	
	lda XINSCREEN + 0
	sec
	sbc scrollPosXCurrent + 0
	sta XINSCREEN + 0
	lda XINSCREEN + 1
	sbc scrollPosXCurrent+ 1
	sta XINSCREEN + 1

	lda XINSCREEN + 0
	lsr
	lsr
	sta XINSCREEN + 0
	lda XINSCREEN + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora XINSCREEN + 0
	sta XINSCREEN + 0

	lda XINSCREEN + 0
	bpl .yo
	eor #$ff
	sec
	sbc #$01
	bpl .yo2
	lda #$00
.yo2
	sta XINSCREEN + 0
.yo

	bne .notrestored
	sta SCROLLNOTINXMID
.notrestored

	ldx SCROLLNOTINXMID
	bne .scrollx

	cmp #10 ; area around x
	bmi .notx
.scrollx
	lda #$01
	sta SCROLLNOTINXMID
	lda GameObjectXPosLo + PLAYERGAMEOBJECT
	sec
	sbc #<SCREENMIDX
	sta scrollPosXDesired + 0
	lda GameObjectXPosHi + PLAYERGAMEOBJECT
	sbc #>SCREENMIDX
	sta scrollPosXDesired + 1
.notx


	lda GameObjectYPosLo + PLAYERGAMEOBJECT
	sec
	sbc #<SCREENMIDY
	sta scrollPosYDesired + 0
	lda GameObjectYPosHi + PLAYERGAMEOBJECT
	sbc #>SCREENMIDY
	sta scrollPosYDesired + 1

	jsr clampScrollPosDesired
	rts

;-------------------------------------------------------------
;-- clamps the player to the levelsize						--
;-------------------------------------------------------------
	SUBROUTINE
.xtemp1 dc.w $0000
clampPlayerPos 
	lda GameObjectXPosHi + PLAYERGAMEOBJECT
	bpl .notleft
	lda #$00
	sta GameObjectXPosLo + PLAYERGAMEOBJECT
	sta GameObjectXPosHi + PLAYERGAMEOBJECT
.notleft

	lda GameObjectYPosHi + PLAYERGAMEOBJECT
	bpl .notup
	lda #$00
	sta GameObjectYPosLo + PLAYERGAMEOBJECT
	sta GameObjectYPosHi + PLAYERGAMEOBJECT
.notup

	lda GameObjectXPosHi + PLAYERGAMEOBJECT
	cmp #>[[40*4-4]*4]
	bne .notright
	lda GameObjectXPosLo + PLAYERGAMEOBJECT
	and #%11111100
	cmp #<[[40*4-4]*4]
	bcc .notright
	lda #<[[40*4-4]*4]
	sta GameObjectXPosLo + PLAYERGAMEOBJECT
	lda #>[[40*4-4]*4]
	sta GameObjectXPosHi + PLAYERGAMEOBJECT
.notright

	lda GameObjectYPosHi + PLAYERGAMEOBJECT
	cmp #>[[64*4-5]*8]
	bne .notdown
	lda GameObjectYPosLo + PLAYERGAMEOBJECT
	and #%11111000
	cmp #<[[64*4-5]*8]
	bcc .notdown
	lda #<[[64*4-5]*8]
	sta GameObjectYPosLo + PLAYERGAMEOBJECT
	lda #>[[64*4-5]*8]
	sta GameObjectYPosHi + PLAYERGAMEOBJECT
	jsr initiateLiveLost
.notdown

	lda GameObjectXPosLo + PLAYERGAMEOBJECT
	sec
	sbc scrollPosXCurrent + 0
	sta .xtemp1 + 0
	lda GameObjectXPosHi + PLAYERGAMEOBJECT
	sbc scrollPosXCurrent + 1
	sta .xtemp1 + 1

	lda .xtemp1 + 0
	lsr
	lsr
	sta .xtemp1 + 0
	lda .xtemp1 + 1
	asl
	asl
	asl
	asl
	asl
	asl
	ora .xtemp1 + 0
	sta .xtemp1 + 0

PLAYERMAXCHARX = 36
PLAYERMINCHARX = 1

	lda .xtemp1
	bmi .negx
	cmp #PLAYERMAXCHARX
	bcc .donex
	lda scrollPosXCurrent + 0
	clc
	adc #<[4 * PLAYERMAXCHARX]
	sta GameObjectXPosLo + PLAYERGAMEOBJECT
	lda scrollPosXCurrent + 1
	adc #>[4 * PLAYERMAXCHARX]
	sta GameObjectXPosHi + PLAYERGAMEOBJECT
	jmp .donex
.negx
	eor #$ff
	cmp #PLAYERMINCHARX - 1
	bcc .donex
	lda scrollPosXCurrent + 0
	sec
	sbc #<[4 * PLAYERMINCHARX]
	sta GameObjectXPosLo + PLAYERGAMEOBJECT
	lda scrollPosXCurrent + 1
	sbc #>[4 * PLAYERMINCHARX]
	sta GameObjectXPosHi + PLAYERGAMEOBJECT
.donex

	rts

;-------------------------------------------------------------
;-- a enemy collided with the player						--
;-------------------------------------------------------------
enemyCollidedWithPlayer SUBROUTINE
	tay
	; check for kick
	lda playerKickAdd + 0
	ora playerKickAdd + 1
	beq .nokick
	lda playerKickAdd + 1
	cmp #PLAYER_KICK_HIT_TEST
	bcs .nokick
	jmp shieldHit
.nokick

	lda isPlayerVelocityMovingDown
	bne .dash
	jmp playerHitten
.dash
	ldx #PLAYERGAMEOBJECT
	jsr placeGameObjectAbove
	jsr playerDash

	; if upcollision replace
	lda #$05
	sta .maxcount + 1
.nexttest
	lda #PLAYERGAMEOBJECT
	jsr getCollisionFlagsUpForGameObject
	and #CHARFLAG_COLLISION
	beq .nocollision
	lda #PLAYERGAMEOBJECT
	jsr replaceGameObjectToCollisionUp
	dec .maxcount + 1
.maxcount
	lda #$44
	bne .nexttest
.nocollision

	rts

;-------------------------------------------------------------
;-- a enemy shot collided with the player				    --
;-------------------------------------------------------------
enemyShotCollidedWithPlayer SUBROUTINE
	jsr explodeEnemy
	jmp playerHitten

collectableCollidedWithPlayer SUBROUTINE
	tax

	lda GameObjectVar2,x
	beq .notalreadyoffanimating
	rts
.notalreadyoffanimating
	lda #$01
	sta GameObjectVar2,x
	
	lda GameObjectVar1,x
	cmp #COLLECTABLE_TYPE_HEART
	bne .notheart
	txa
	tay
	jsr addSparkles
	jsr anotherHeart
	jmp updateStatusDisplay
.notheart
	cmp #COLLECTABLE_TYPE_DIAMOND
	bne .notdiamond
	jsr anotherDiamond
	jmp updateStatusDisplay
.notdiamond
	cmp #COLLECTABLE_TYPE_ITEM
	bne .notitem
	; disable off animation
	lsr GameObjectVar5,x ; smaller off animation
	jsr anotherItem
	jmp updateStatusDisplay
.notitem
	rts

;-------------------------------------------------------------
;-- a magicitem collided with the player					--
;-------------------------------------------------------------
magicCollidedWithPlayer SUBROUTINE
	tax
	lda GameObjectVar1,x
	sec
	sbc #STONEENEMYTYPESTART
	tax
	lda TEXTSCREENSFORSTONES,x
	sta playerIsBeforeStone
	rts

;-------------------------------------------------------------
;-- a magicitem collided with the player					--
;-------------------------------------------------------------
schalterCollidedWithPlayer SUBROUTINE
	tax
	lda GameObjectVar1,x
	sec
	sbc #SCHALTERENEMYTYPESTART
	sta playerIsBeforeSchalter
	rts

;-------------------------------------------------------------
;-- a enemy collided with a playershot						--
;-------------------------------------------------------------
enemyCollidedWithPlayerShot SUBROUTINE
	sta .ycheck + 1
	jsr explodeEnemy
;	lda #$50
;	jsr addAccuToBCDToScore
.ycheck
	ldy #$44 
	jsr add50
	rts

;-------------------------------------------------------------
;-- the player dashes										--
;-------------------------------------------------------------
playerDash SUBROUTINE
	lda #SOUND_DASH
	jsr triggerSound
	lda #ENEMY_HIT_STAY_FRAMES
	sta GameObjectHit,y
	lda #$00
	sta fallDownAdd + 0
	sta fallDownAdd + 1
	lda #<DASH_VELOCITY
	sta jumpUpAdd + 0
	lda #>DASH_VELOCITY
	sta jumpUpAdd + 1
	tya
	tax
	lda playerShieldOn + 0
	ora playerShieldOn + 1
	bne .shielddash
	stx .xrestore + 1
;	lda #$a0+DASH_POINTS_SUBTRACT
;	jsr addAccuToBCDToScore
.xrestore
	ldx #$44
	lda	GameObjectHitPoints,x
	beq .nothitable
	dec	GameObjectHitPoints,x
	bne .nothitable
.explodeit
	txa
	jsr explodeEnemy
.nothitable
	rts
.shielddash
;	lda #$50
;	jsr addAccuToBCDToScore
	jmp .explodeit

;-------------------------------------------------------------
;-- the player was hitten									--
;-------------------------------------------------------------
playerHitten SUBROUTINE
	lda playerHit
	bne .notHitThisWeAreSafe
	lda playerShieldOn + 0
	ora playerShieldOn + 1
	bne shieldHit
	lda #PLAYERHIT_FRAMES
	sta playerHit + 0
	lda #<HIT_VELOCITY
	sta jumpUpAdd + 0 
	lda #>HIT_VELOCITY
	sta jumpUpAdd + 1 
	lda #$00
	sta fallDownAdd + 0
	sta fallDownAdd + 1
	lda #PLAYERHIT_FRAMES
	sta playerHit
 dec ZP_ENERGY ; god mode
	lda ZP_ENERGY
	beq pHitPlayerDeadly
	jsr updateEnergy
	lda #SOUND_HIT
	jsr triggerSound
.notHitThisWeAreSafe
	rts

shieldHit SUBROUTINE
	cpy #NOLEVELENEMY
	beq .noenemycollision
	tya
	jsr explodeEnemy
	lda #$50
;	jsr addAccuToBCDToScore
	jsr add50
.noenemycollision
	rts

;-------------------------------------------------------------
;-- the player was hitten deadly							--
;-------------------------------------------------------------
pHitPlayerDeadly SUBROUTINE
	lda #SOUND_HIT
	jsr triggerSound
	jsr initiateLiveLost
	rts

;-------------------------------------------------------------
;-- the player lost a live									--
;-------------------------------------------------------------
initiateLiveLost SUBROUTINE
	dec ZP_LIVES
	lda ZP_LIVES
	bne .nextLive
	; game over
	lda #TEXTSCREEN_GAMEOVER
	sta textScreenNumber
	jsr displayTextScreen
	jmp gameOver
.nextLive	
	lda #TEXTSCREEN_LIVELOST
	sta textScreenNumber
	jsr displayTextScreen

	jmp newLiveInit

;-------------------------------------------------------------
;-- the player collected a heart							--
;-------------------------------------------------------------
anotherHeart SUBROUTINE
	lda #SOUND_COLLECTED
	jsr triggerSoundScreen
;	lda #$50
;	jsr addAccuToBCDToScore

	lda ZP_ENERGY
	cmp #FULLENERGY
	beq .fullenergy
	lda #FULLENERGY
	sta ZP_ENERGY
	jsr updateEnergy
	lda ZP_SKILLLEVEL
	beq .fullenergy
	rts ; EASY
.fullenergy
	lda ZP_LIVES
	cmp #$09
	beq .clip
	inc ZP_LIVES
.clip
	rts

;-------------------------------------------------------------
;-- the player collected a diamond							--
;-------------------------------------------------------------
diamondscollected dc.b $00
anotherDiamond SUBROUTINE
	lda #SOUND_DIAMOND
	jsr triggerSoundScreen
	lda ZP_SKILLLEVEL
	cmp #$02
	beq .noadd
	cmp #$00
	beq .immediateadd
	inc diamondscollected
	lda diamondscollected
	and #$03
	bne .noadd
.immediateadd
	lda ZP_ENERGY
	cmp #FULLENERGY
	beq .fullenergy
	inc ZP_ENERGY
	jsr updateEnergy
.fullenergy
.noadd
	rts

	SUBROUTINE
;-------------------------------------------------------------
;-- the player collected a heart							--
;-------------------------------------------------------------
.yposTest dc.w $0000
anotherItem 

	lda GameObjectXPosLo,x
	lsr
	lsr
	lsr
	lsr
	sta stoneXPos
	lda GameObjectXPosHi,x
	asl
	asl
	asl
	asl
	ora stoneXPos
	sta stoneXPos

	; move down a little so we get the stone behind
	lda GameObjectYPosLo,x
	clc
	adc #<$04
	sta .yposTest + 0
	lda GameObjectYPosHi,x
	adc #>$04
	sta .yposTest + 1

	lda .yposTest + 0
	lsr
	lsr
	lsr
	lsr
	lsr
	sta stoneYPos
	lda .yposTest + 1
	asl
	asl
	asl
	ora stoneYPos
	sta stoneYPos

	lda #$00
	sta stoneNr

	jsr drawStoneOnXY

	ldx goalTextScreenNr
	lda goalNextTextScreen
	sta CURRENTSCREENS,x

	lda #SOUND_COLLECTED
	jsr triggerSoundScreen

	rts


;-------------------------------------------------------------
;-- the player collected 3 balls							--
;-------------------------------------------------------------
addShots SUBROUTINE
	lda #SOUND_COLLECTED
	jsr triggerSoundScreen

	lda ZP_BALLS
	clc
	adc #$03
	cmp #$09
	bmi .ok
	lda #$09
.ok
	sta ZP_BALLS

	rts

;-------------------------------------------------------------
;-- mark this point as position savepoint for respawn		--
;-------------------------------------------------------------
onGroundSavePointPlayerPosX dc.w $00
onGroundSavePointPlayerPosY dc.w $00
setOnGroundSavePoint SUBROUTINE
	lda GameObjectXPosLo + PLAYERGAMEOBJECT 
	sta onGroundSavePointPlayerPosX + 0
	lda GameObjectXPosHi + PLAYERGAMEOBJECT 
	sta onGroundSavePointPlayerPosX + 1
	lda GameObjectYPosLo + PLAYERGAMEOBJECT 
	sta onGroundSavePointPlayerPosY + 0
	lda GameObjectYPosHi + PLAYERGAMEOBJECT 
	sta onGroundSavePointPlayerPosY + 1
	rts

;-------------------------------------------------------------
;-- initialize a new live									--
;-------------------------------------------------------------
newLiveInit SUBROUTINE
	lda #FULLENERGY
	sta ZP_ENERGY
	jsr initPlayer
	jmp newPlayerScrollPosition

;-------------------------------------------------------------
;-- we have a new position for the player                   --
;-------------------------------------------------------------
newPlayerScrollPosition SUBROUTINE
	lda #$00
	sta GameObjectXPosLoLo + PLAYERGAMEOBJECT
	sta GameObjectYPosLoLo + PLAYERGAMEOBJECT
	jsr setPlayerToNewScrollPos
	jsr removeAllEnemiesFromScreen
	jsr initializeGameObjects
	ldy #PLAYERGAMEOBJECT
	jsr addSparkles
	jmp addEnemyAllOnScreen

DISPLAYDUST2
	lda onGround
	sta lastOnGround
	lda GameObjectYPosLo + PLAYERGAMEOBJECT
	clc
	adc #<[PLAYER_YEND-1]
	jmp DISPLAYDUST

;-------------------------------------------------------------
;-- displays the dust if player jumps or collides			--
;-------------------------------------------------------------
dustCounter dc.b $00
lastOnGround dc.b $00
lastSoundTrigger dc.b $00
	SUBROUTINE
playerDisplayDustFrame 

	lda playerKickAdd + 0
	ora playerKickAdd + 1
	beq .nokickdust
	lda gameLogikCounter
	and #$07
	bne .nokickdust
DISPLAYDUST3
	lda onGround
	sta lastOnGround
	lda GameObjectYPosLo + PLAYERGAMEOBJECT
	clc
	adc #<PLAYER_YEND - 3
	jmp .displayDust
.nokickdust

	lda lastOnGround
	cmp onGround
	beq .nochange
	lda onGround
	beq .notlanded
	lda lastSoundTrigger
	cmp #24
	bcc .nofloorsound
	lda #SOUND_FLOOR
	jsr triggerSound
.nofloorsound
.notlanded
	
	lda onGround
	sta lastOnGround
	lda GameObjectYPosLo + PLAYERGAMEOBJECT
	clc
	adc #<PLAYER_YEND
DISPLAYDUST
.displayDust
	sta GameObjectYPosLo + DUSTGAMEOBJECT
	lda GameObjectYPosHi + PLAYERGAMEOBJECT
	adc #$00
	sta GameObjectYPosHi + DUSTGAMEOBJECT
	lda GameObjectXPosLo + PLAYERGAMEOBJECT
	sta GameObjectVar1 + DUSTGAMEOBJECT
	lda GameObjectXPosHi + PLAYERGAMEOBJECT
	sta GameObjectVar2 + DUSTGAMEOBJECT
	lda #$10
	sta dustCounter
.nochange
	
	lda #$00
	ldx dustCounter
	beq .notdisplay
	dec dustCounter
	lda dustCounter
	lsr
	lsr
	and #$01
	clc
	adc #SPRITEFRAMES_DUST
	sta GameObjectSpriteImage + DUSTGAMEOBJECT

	ldx dustCounter
	lda playerDisplayDustFrame,x ; random
	and #$03
	adc #[PLAYER_XEND-PLAYER_XSTART]/2-2
	adc GameObjectVar1 + DUSTGAMEOBJECT
	sta GameObjectXPosLo + DUSTGAMEOBJECT
	lda GameObjectVar2 + DUSTGAMEOBJECT
	adc #$00
	sta GameObjectXPosHi + DUSTGAMEOBJECT

	lda #GAMEOBJECT_COLLISIONTYPE_NO_COLLISION
	sta GameObjectCollisionType + DUSTGAMEOBJECT
	lda #$01
.notdisplay
	sta GameObjectVisible + DUSTGAMEOBJECT
	rts

gameOver
	lda #QUITFLAG_LOADGAMEOVER
	sta quitFlag
	rts

levelComplete
	lda #QUITFLAG_LOADNEXTLEVEL
	sta quitFlag
	rts

cleanStop SUBROUTINE
	sei
	lda #$00
	sta fw_topirq_plugin + 0
	sta fw_topirq_plugin + 1
	cli
	jsr waitFrame
	jsr waitFrame
	rts

LOADNEXTLEVEL SUBROUTINE

	lda #LEVELSTATUS_OK
	sta ZP_LEVELSTATUS

LoadLoadingScreen
	jsr cleanStop
	
	ldx #<loadingScreenFileName
	ldy #>loadingScreenFileName
	jsr fw_load

	ldx fw_load_end + 0
	ldy fw_load_end + 1
	jsr fw_decrunch

	lda ZP_LEVELCURRENT
	sta ZP_LEVELTOLOAD
	inc ZP_LEVELTOLOAD 

	jmp ENTRYPOINT_LOADINGSCREEN

LOADGAMEOVER SUBROUTINE

	lda #LEVELSTATUS_GAMEOVER
	sta ZP_LEVELSTATUS

	jmp LoadLoadingScreen

loadingScreenFileName
	dc.b "LS",0
