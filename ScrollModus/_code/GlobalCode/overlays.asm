;-------------------------------------------------------------
;-- Updates the Energy GameObject							--
;-------------------------------------------------------------
updateEnergy SUBROUTINE
	lda ZP_ENERGY
	clc
	adc #SPRITEFRAMES_STATUS-1
	sta GameObjectSpriteImage + STATUSBARENERGYGAMEOBJECT
	rts

updateStatusDisplay SUBROUTINE
	rts

displayOverlays SUBROUTINE
	rts