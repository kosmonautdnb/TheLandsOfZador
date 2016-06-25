    	include "memorylayout.inc"
	
	; Graphics Data
	ORG EPOINT_WORLD_GRAPHICS_DATA
FONT
	incbin "levelFont.bin"
FONTCOLOR
	incbin "levelFontColor.bin"
FONTLUMA
	incbin "levelFontLuma.bin"
FONTFLAGS
	incbin "levelFontFlags.bin"
TILES
	incbin "tileMap.bin"
MAP
	incbin "level4Map.bin"
gradient 
	incbin "gradient.bin"

	; not aligned

	; Solid Code	
	include "worldsetup.inc"
	include "textscreenspersistent.inc"
	include "textscreensforstones.inc"
textscreens
	dc.w TEXTSEND
layers
	dc.w LAYER0
	dc.w LAYER1
	dc.w LAYER2
	dc.w LAYER3	
	dc.w LAYER4
	dc.w LAYER5
	dc.w LAYER6
	dc.w LAYER7
	dc.w LAYER8
	dc.w LAYER9
	dc.w LAYER10
	dc.w LAYER11
	dc.w LAYER12
	dc.w LAYER13
	dc.w LAYER14
	dc.w LAYER15
layerJump
	dc.w LAYER0FUNC
	dc.w LAYER1FUNC
	dc.w LAYER2FUNC
	dc.w LAYER3FUNC
	dc.w LAYER4FUNC
	dc.w LAYER5FUNC
	dc.w LAYER6FUNC
	dc.w LAYER7FUNC
	dc.w LAYER8FUNC
	dc.w LAYER9FUNC
	dc.w LAYER10FUNC
	dc.w LAYER11FUNC
	dc.w LAYER12FUNC
	dc.w LAYER13FUNC
	dc.w LAYER14FUNC
	dc.w LAYER15FUNC

explogravity
	dc.b EXPLOGRAVITY

exploimpuls
	dc.b EXPLOIMPULS

explolivetime
	dc.b EXPLOLIVETIME


rasterValuesPerLevelModifier
	dc.w RASTERFUNC
levelPaintFrameFunc
	dc.w PAINTFUNC
levelClearFrameFunc
	dc.w CLEARFUNC

	include "enemyLogikLevelGlobal.asm"
	include "enemyLogikLevel.asm"
	include "layerCodeLevel.asm"
	include "enemies.inc"
	include "sprites.inc"

	incbin "textscreens.exo"
TEXTSEND

	include "layers.inc"

