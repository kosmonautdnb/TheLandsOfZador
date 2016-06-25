SPRITEFRAMECOUNT = 62

SPRITEFRAMES_KATE = 0
SPRITEFRAMES_PLAYERSHOT = 12
SPRITEFRAMES_EXPLOSION = 14
SPRITEFRAMES_STATUS = 18
SPRITEFRAMES_DUST = 23
SPRITEFRAMES_HIT50 = 25
SPRITEFRAMES_SPARKLES = 26
SPRITEFRAMES_DIAMOND = 29
SPRITEFRAMES_HEART = 32
SPRITEFRAMES_BACKGROUND = 35
SPRITEFRAMES_SCHALTER = 38
SPRITEFRAMES_ITEM = 40
SPRITEFRAMES_ENEMY1 = 43
SPRITEFRAMES_ENEMY2 = 46
SPRITEFRAMES_ENEMY3 = 50
SPRITEFRAMES_ENEMY4 = 52
SPRITEFRAMES_ENEMY5 = 54
SPRITEFRAMES_ENEMY6 = 56
SPRITEFRAMES_ENEMYSHOT1 = 58
SPRITEFRAMES_ENEMYSHOT2 = 59
SPRITEFRAMES_SPECIAL = 60

SPRITEFRAMES_KATECOUNT = 12
SPRITEFRAMES_PLAYERSHOTCOUNT = 2
SPRITEFRAMES_EXPLOSIONCOUNT = 4
SPRITEFRAMES_STATUSCOUNT = 5
SPRITEFRAMES_DUSTCOUNT = 2
SPRITEFRAMES_HIT50COUNT = 1
SPRITEFRAMES_SPARKLESCOUNT = 3
SPRITEFRAMES_DIAMONDCOUNT = 3
SPRITEFRAMES_HEARTCOUNT = 3
SPRITEFRAMES_BACKGROUNDCOUNT = 3
SPRITEFRAMES_SCHALTERCOUNT = 2
SPRITEFRAMES_ITEMCOUNT = 3
SPRITEFRAMES_ENEMY1COUNT = 3
SPRITEFRAMES_ENEMY2COUNT = 4
SPRITEFRAMES_ENEMY3COUNT = 2
SPRITEFRAMES_ENEMY4COUNT = 2
SPRITEFRAMES_ENEMY5COUNT = 2
SPRITEFRAMES_ENEMY6COUNT = 2
SPRITEFRAMES_ENEMYSHOT1COUNT = 1
SPRITEFRAMES_ENEMYSHOT2COUNT = 1
SPRITEFRAMES_SPECIALCOUNT = 2

ENEMY_TYPE_PLAYERSHOT = 0
ENEMY_TYPE_EXPLOSION = 1
ENEMY_TYPE_SPARKLES = 2
ENEMY_TYPE_HEART = 3
ENEMY_TYPE_DIAMOND = 4
ENEMY_TYPE_BACKGROUND = 5
ENEMY_TYPE_STONE = 6
ENEMY_TYPE_SCHALTER = 7
ENEMY_TYPE_ITEM = 8
ENEMY_TYPE_ENEMY1 = 9
ENEMY_TYPE_ENEMY2 = 10
ENEMY_TYPE_ENEMY3 = 11
ENEMY_TYPE_ENEMY4 = 12
ENEMY_TYPE_ENEMY5 = 13
ENEMY_TYPE_ENEMY6 = 14
ENEMY_TYPE_ENEMYSHOT1 = 15
ENEMY_TYPE_ENEMYSHOT2 = 16
ENEMY_TYPE_SPECIALENEMY = 17

enemyInitFuncs
	dc.w InitPlayerShot ; PLAYERSHOT
	dc.w InitExplosion ; EXPLOSION
	dc.w InitSparkles ; SPARKLES
	dc.w InitCollectable ; HEART
	dc.w InitCollectable ; DIAMOND
	dc.w InitBackground ; BACKGROUND
	dc.w InitBackground ; STONE
	dc.w InitSchalter ; SCHALTER
	dc.w InitCollectable ; ITEM
	dc.w InitFrog ; ENEMY1
	dc.w InitBird ; ENEMY2
	dc.w InitBomby ; ENEMY3
	dc.w InitFat ; ENEMY4
	dc.w InitThrower ; ENEMY5
	dc.w InitDog ; ENEMY6
	dc.w InitEnemyShot1 ; ENEMYSHOT1
	dc.w InitEnemyShot2 ; ENEMYSHOT2
	dc.w InitSpecialEnemy ; SPECIALENEMY
	dc.w $0000 ; clean
	dc.w $0000 ; clean

enemyHandleFuncs
	dc.w HandlePlayerShot ; PLAYERSHOT
	dc.w HandleExplosion ; EXPLOSION
	dc.w HandleSparkles ; SPARKLES
	dc.w HandleCollectable ; HEART
	dc.w HandleCollectable ; DIAMOND
	dc.w HandleBackground ; BACKGROUND
	dc.w HandleBackground ; STONE
	dc.w HandleSchalter ; SCHALTER
	dc.w HandleCollectable ; ITEM
	dc.w HandleStandardEnemy ; ENEMY1
	dc.w HandleStandardEnemy ; ENEMY2
	dc.w HandleStandardEnemy ; ENEMY3
	dc.w HandleStandardEnemy ; ENEMY4
	dc.w HandleStandardEnemy ; ENEMY5
	dc.w HandleStandardEnemy ; ENEMY6
	dc.w HandleStandardEnemy ; ENEMYSHOT1
	dc.w HandleStandardEnemy ; ENEMYSHOT2
	dc.w HandleSpecialEnemy ; SPECIALENEMY
	dc.w $0000 ; clean
	dc.w $0000 ; clean

enemyXStart
	dc.b 0 ; PLAYERSHOT
	dc.b 0 ; EXPLOSION
	dc.b 0 ; SPARKLES
	dc.b 0 ; HEART
	dc.b 0 ; DIAMOND
	dc.b 0 ; BACKGROUND
	dc.b 0 ; STONE
	dc.b 0 ; SCHALTER
	dc.b 1 ; ITEM
	dc.b 0 ; ENEMY1
	dc.b 0 ; ENEMY2
	dc.b 0 ; ENEMY3
	dc.b 0 ; ENEMY4
	dc.b 2 ; ENEMY5
	dc.b 1 ; ENEMY6
	dc.b 0 ; ENEMYSHOT1
	dc.b 1 ; ENEMYSHOT2
	dc.b 0 ; SPECIALENEMY
	dc.b $00 ; clean
	dc.b $00 ; clean

enemyYStart
	dc.b 0 ; PLAYERSHOT
	dc.b 0 ; EXPLOSION
	dc.b 0 ; SPARKLES
	dc.b 0 ; HEART
	dc.b 0 ; DIAMOND
	dc.b 0 ; BACKGROUND
	dc.b 0 ; STONE
	dc.b 0 ; SCHALTER
	dc.b 3 ; ITEM
	dc.b 0 ; ENEMY1
	dc.b 0 ; ENEMY2
	dc.b 1 ; ENEMY3
	dc.b 1 ; ENEMY4
	dc.b 2 ; ENEMY5
	dc.b 6 ; ENEMY6
	dc.b 10 ; ENEMYSHOT1
	dc.b 1 ; ENEMYSHOT2
	dc.b 0 ; SPECIALENEMY
	dc.b $00 ; clean
	dc.b $00 ; clean

enemyXEnd
	dc.b 4 ; PLAYERSHOT
	dc.b 12 ; EXPLOSION
	dc.b 9 ; SPARKLES
	dc.b 9 ; HEART
	dc.b 5 ; DIAMOND
	dc.b 8 ; BACKGROUND
	dc.b 9 ; STONE
	dc.b 6 ; SCHALTER
	dc.b 7 ; ITEM
	dc.b 10 ; ENEMY1
	dc.b 12 ; ENEMY2
	dc.b 11 ; ENEMY3
	dc.b 11 ; ENEMY4
	dc.b 8 ; ENEMY5
	dc.b 13 ; ENEMY6
	dc.b 6 ; ENEMYSHOT1
	dc.b 5 ; ENEMYSHOT2
	dc.b 8 ; SPECIALENEMY
	dc.b $00 ; clean
	dc.b $00 ; clean

enemyYEnd
	dc.b 8 ; PLAYERSHOT
	dc.b 24 ; EXPLOSION
	dc.b 16 ; SPARKLES
	dc.b 16 ; HEART
	dc.b 10 ; DIAMOND
	dc.b 8 ; BACKGROUND
	dc.b 16 ; STONE
	dc.b 8 ; SCHALTER
	dc.b 16 ; ITEM
	dc.b 18 ; ENEMY1
	dc.b 30 ; ENEMY2
	dc.b 32 ; ENEMY3
	dc.b 32 ; ENEMY4
	dc.b 24 ; ENEMY5
	dc.b 20 ; ENEMY6
	dc.b 12 ; ENEMYSHOT1
	dc.b 12 ; ENEMYSHOT2
	dc.b 16 ; SPECIALENEMY
	dc.b $00 ; clean
	dc.b $00 ; clean

enemyHitPoints
	dc.b 0 ; PLAYERSHOT
	dc.b 0 ; EXPLOSION
	dc.b 0 ; SPARKLES
	dc.b 0 ; HEART
	dc.b 0 ; DIAMOND
	dc.b 0 ; BACKGROUND
	dc.b 0 ; STONE
	dc.b 0 ; SCHALTER
	dc.b 0 ; ITEM
	dc.b 3 ; ENEMY1
	dc.b 3 ; ENEMY2
	dc.b 3 ; ENEMY3
	dc.b 3 ; ENEMY4
	dc.b 3 ; ENEMY5
	dc.b 3 ; ENEMY6
	dc.b 0 ; ENEMYSHOT1
	dc.b 0 ; ENEMYSHOT2
	dc.b 6 ; SPECIALENEMY
	dc.b $00 ; clean
	dc.b $00 ; clean