; CONSTANTS
;-------------------------------------------
NEGBYTEFF = $ff ; if it's negative the low part gets this ; $FF is the right value but $00 looks also good
; VARS
;--------------------------------------------
smallestXFrame		ds.b $02, $00
smallestYFrame		ds.b $02, $00
largestXFrame		ds.b $02, $00
largestYFrame		ds.b $02, $00

topy				ds.b MAXSPANX,0
downy				ds.b MAXSPANX,0
dxtable				ds.b MAXSPANX,0

p_subtractdx		dc.b $00

;--------------------------------------------------------
;-- polygon drawing helpers 
;--------------------------------------------------------
	; search for smallest x
	MAC SmallestX
	ldx #$01
.next
	lda p_xr,x
	cmp p_xt
	bcs . + 2 + 3 + 3
	sta p_xt
	stx p_t
	inx
	cpx p_cnt
	bne .next
	REPEND
	ENDM

	; search for largest x
	MAC LargestX
	ldx #$01
.next
	lda p_xr,x
	cmp p_xt2
	bcc . + 2 + 3
	sta p_xt2
	inx
	cpx p_cnt
	bne .next
	ENDM

	; search for smallest y
	MAC SmallestY
	ldx #$01
.next
	lda p_yr,x
	cmp p_ytv
	bcs . + 2 + 3
	sta p_ytv
	inx
	cpx p_cnt
	bne .next
	ENDM

	; search for largest y
	MAC LargestY
	ldx #$01
.next
	lda p_yr,x
	cmp p_ytv2
	bcc . + 2 + 3
	sta p_ytv2
	inx
	cpx p_cnt
	bne .next
	ENDM

	MAC GetEdgePoint
	stx p_xp
.side1ZeroXDelta
	lda p_np1 + {1}*1
	sta p_lp1 + {1}*1
	lda p_np1 + {1}*1
	clc
	adc #[$01-{1}*2] & 255
	cmp p_cnt
	bne .notover
	lda #$00
.notover
	cmp #$ff
	bne .notunder
	lda p_cnt
	sec
	sbc #$01
.notunder
	sta p_np1 + {1}*1
	ldx p_lp1 + {1}*1
	ldy p_np1 + {1}*1
	lda p_xr,y
	sec
	sbc p_xr,x
	sta p_dx1 + {1}*1
	beq .side1ZeroXDelta
	ENDM

	MAC CalcSlope
	ldx p_lp1 + {1}*1
	ldy p_np1 + {1}*1
	lda p_yr,x
	sta p_yp1 + 1 + {1}*2
	lda #$00
	sta p_yp1  + 0 + {1}*2
	sta p_dya1 + 0 + {1}*2

	; check if we must div2 because of spans too big
	lda p_ydiv2
	beq .notdiv2
	jsr ydiv2_{1}
	jmp .end
.notdiv2

	; the delta adds
	lda p_yr,y
	sec
	sbc p_yr,x
	sta p_dya1 + 1 + {1}*2
	bpl .pos1
	lda #NEGBYTEFF
	sta p_dya1 + 0 + {1}*2
.pos1

	; now we need the divisions by p_dx1
	lda p_dx1 + {1}*1
	sta ZP_16BIT8DIVISIONBY

	lda #<[p_dya1 + {1}*2]
	sta ZP_16BIT8DIVISION + 0
	lda #>[p_dya1 + {1}*2]
	sta ZP_16BIT8DIVISION + 1

	jsr divide16_8
.end
	clc
	ENDM

	; update one side of the polyloop
	MAC SideCheck
	GetEdgePoint {1}
	; check for negative xmovement so we reached polygon end
	bpl .notAtPolygonEndSide1
.done
	jmp drawPolyBlit
.notAtPolygonEndSide1
	;lda #$01
	;sta p_newEdgePoint ; for backface culling
	; set positions * 256
	CalcSlope {1}
	ENDM


	MAC Side1Check
	; side1 update check
	ldy p_np1
	txa 
	cmp p_xr,y
	bne .notSide1Update
	SideCheck 0
	ldx p_xp
	lda p_yp1 + 1
	sta topy,x
.notSide1Update
	ENDM

	MAC Side2Check
	; side1 update check
	ldy p_np2
	txa 
	cmp p_xr,y
	lda p_dx2
	bne .notSide2Update
	SideCheck 1
	ldx p_xp
	lda p_yp2 + 1
	sta downy,x
.notSide2Update
	ENDM

	MAC BACKFACE
	;------ backface culling
	; check for backface culling
	lda p_newEdgePoint
	beq .nobackfacetest
	lda #$00
	sta p_newEdgePoint
	lda p_yp2 + 1
	sec
	sbc p_yp1 + 1
	bcs .nobackfacetest
	beq .nobackfacetest
	cmp #BACKFACETOLERANCE
	bcs .nobackfacetest
	inc drawnButCulledPolys
	rts ; ok, it's backfacing
.nobackfacetest
	ENDM

;--------------------------------------------------------
;-- polygon drawing function 
;--------------------------------------------------------
; the coordinates of the polygons outside
; ------------------------------------- input section
p_xr                      ; the input x coordinates lo part (only lo part is used for drawing)
	ds.b MAXPOLYPOINTS
p_yr					  ; the input y coordinates lo part (only lo part is used for drawing)
	ds.b MAXPOLYPOINTS
p_cr					  ; the color of the polygon (0-7)
	dc.b $03
;p_cnt					  ; the number of points surrounding the polygon
;	dc.b $04 ; ZEROPAGE
; ------------------------------------- intern
; for largest smallest x search
p_t  dc.b $00
p_xt dc.b $00
p_xt2 dc.b $00
; lastpoint and nextpoint in poly
p_lp1 dc.b $00
p_lp2 dc.b $00
p_np1 dc.b $00
p_np2 dc.b $00
; the x rasterposition
p_xstart dc.b $00
p_xend dc.b $00
p_first dc.b $00
p_ytv dc.b $00
p_ytv2 dc.b $00
p_fbdx1 dc.b $00
p_fbdx2 dc.b $00
p_ydiv2	dc.b $00		  ; if the absolute of a span is in y bigger the 127 we must set this flag for not so precise but working outlines
;--------------------------------------------------------
	SUBROUTINE
;--------------------------------------------------------
drawPolyCore SUBROUTINE

	; check for smallest x
	; ----------------------
	lda #$00
	sta p_t
	lda p_xr + 0
	sta p_xt

	SmallestX

	; check for largest x
	; ----------------------
	lda p_xr + 0
	sta p_xt2

	LargestX
	
	; polygon large size for the div2 flag
	lda p_yr + 0
	sta p_ytv
	sta p_ytv2

	SmallestY

	LargestY

	lda #$00
	sta p_ydiv2
	lda p_ytv2
	sec
	sbc p_ytv
	cmp #125
	bcc .div2normal
	lda #$01
	sta p_ydiv2
.div2normal

	; is smallestx lesser than largest x?
	lda p_xt2
	sec 
	sbc p_xt
	beq .rts
	bcs .do
.rts
	rts
.do
	inc drawnPolys

	; set color
	lda p_cr
	asl
	asl
	asl
	sta ZP_READCOLOR1 + 0
	sta ZP_READCOLOR2 + 0

	lda ZP_READCOLOR1 + 0
	clc
	adc #<COLORBITMASK
	sta ZP_READCOLOR1 + 0
	lda #>COLORBITMASK
	adc #$00
	sta ZP_READCOLOR1 + 1

	lda ZP_READCOLOR2 + 0
	clc
	adc #<[COLORBITMASK+4]
	sta ZP_READCOLOR2 + 0
	lda #>[COLORBITMASK+4]
	adc #$00
	sta ZP_READCOLOR2 + 1

	ldy p_cr
	lda COLORBITMASKFULL1,y
	sta ZP_COLORFULL1
	lda COLORBITMASKFULL2,y
	sta ZP_COLORFULL2

	; initialize points
	lda p_t
	sta p_lp1
	sta p_lp2
	sta p_np1
	sta p_np2

	; initialize x position
	ldy p_t
	lda p_xr,y
	sta p_xp
	sta p_xstart

	; for outline performance
	lda #$00
	sta p_dx1
	sta p_dx2
	sta p_dx
	sta p_subtractdx

	; initial condition

	ldx p_xp

	; the mainloop
	;-----------------------------------------
.mainLoop

	lda p_dx
	sta dxtable,x ; this is used for the fastblit
	beq SideChecks
SideChecksDone

	inx
	
	ADD16POLY p_yp1,p_dya1,p_yp1
	sta topy,x
	
	ADD16POLY p_yp2,p_dya2,p_yp2
	sta downy,x

	dec p_dx	
							;sta dxtable,x ; (seems that it suffices to store it only as above)
	jmp .mainLoop

SideChecks
	lda p_dx1
	sec
	sbc p_subtractdx
	sta p_dx1
	lda p_dx2
	sec
	sbc p_subtractdx
	sta p_dx2
	Side1Check
	Side2Check
	lda p_dx2
	cmp p_dx1
	bcc .wetakethis
	lda p_dx1
.wetakethis
	sta p_dx
	sta p_subtractdx
	sta dxtable,x ; this is used for the fastblit
	jmp SideChecksDone

	; for y div2 polygone outlines (elsway we would have just 127 + or - steps, due to the division)
ydiv2_0 SUBROUTINE

	lda p_yr,x
	lsr
	sta .sub + 1
	lda p_yr,y
	lsr
	sec
.sub
	sbc #$44
	sta p_dya1 + 1
	bpl .pos1
	lda #NEGBYTEFF
	sta p_dya1 + 0
.pos1

	; now we need the divisions by p_dx1
	lda p_dx1
	sta ZP_16BIT8DIVISIONBY

	lda #<[p_dya1]
	sta ZP_16BIT8DIVISION + 0
	lda #>[p_dya1]
	sta ZP_16BIT8DIVISION + 1

	jsr divide16_8

	; mul2
	asl p_dya1 + 0
	rol p_dya1 + 1

	rts

ydiv2_1 SUBROUTINE
	lda p_yr,x
	lsr
	sta .sub + 1
	lda p_yr,y
	lsr
	sec
.sub
	sbc #$44
	sta p_dya2 + 1
	bpl .pos1
	lda #NEGBYTEFF
	sta p_dya2 + 0
.pos1

	; now we need the divisions by p_dx1
	lda p_dx2
	sta ZP_16BIT8DIVISIONBY

	lda #<[p_dya2]
	sta ZP_16BIT8DIVISION + 0
	lda #>[p_dya2]
	sta ZP_16BIT8DIVISION + 1

	jsr divide16_8

	; mul2
	asl p_dya2 + 0
	rol p_dya2 + 1

	rts

;--------------------------------------------------------
; here starts the actual blitting of the polygon
;--------------------------------------------------------
drawPolyBlit SUBROUTINE
	lda p_xp
	sta p_xend


	; firstly check the polygon size for the clearing area later

	ldy doubleBuffer
	cmp largestXFrame,y
	bcc .notincreasexl
	sta largestXFrame,y
.notincreasexl

	lda p_ytv
	cmp smallestYFrame,y
	bcs .notdecreaseys
	sta smallestYFrame,y
.notdecreaseys

	; ensure ; the accumulator isn't used here
	lda p_xend
	sec
	sbc #$04
	sta p_xendm4

	lda p_ytv2
	cmp largestYFrame,y
	bcc .notincreaseyl
	sta largestYFrame,y
.notincreaseyl

	; and again polygonsize for the clearing area
	lda p_xstart
	cmp smallestXFrame,y
	bcs .notdecreasexs
	sta smallestXFrame,y
.notdecreasexs
	sta p_xp


.nextblit

	tax

	; check for fast blit
	and #$03
	bne .slowblit
	lda dxtable,x
	cmp #$04
	bcc .perhapsSlowblit
	jmp fastBlit
.perhapsSlowblit
	jmp PERHAPSSLOWBLIT
.slowblit
SLOWBLIT

	lda topy,x
	cmp downy,x
	bcs .noblitslow

	; generate colors and and out
	jsr prepareFineDitherColors

	; generate bitmap write
	ldy topy,x
	lda (ZP_MUL10BLITSLOWLO),y
	sta .jumpin + 1
	lda (ZP_MUL10BLITSLOWHI),y
	sta .jumpin + 2
	ldy downy,x
	lda (ZP_MUL10BLITSLOWLO),y
	sta ZP_RTS_PLACER + 0
	lda (ZP_MUL10BLITSLOWHI),y
	sta ZP_RTS_PLACER + 1
	ldy #$00
	lda #OPC_RTS
	sta (ZP_RTS_PLACER),y
	txa
	and #%1111100
	asl ; * 8
	tax
.jumpin
	jsr $4444
	ldy #$00
	lda #OPC_LDA_ABS_X
	sta (ZP_RTS_PLACER),y
.doneblit

.noblitslow
	inc p_xp
FastBlitDone
	lda p_xp
	cmp p_xend
	bne .nextblit
	rts

PERHAPSSLOWBLIT
	; look if afterwards comes directly another one
Y SET 1 
	REPEAT $03
	lda dxtable+Y,x
	cmp #$04
	bcc SLOWBLIT
Y SET Y + 1
	REPEND
	jmp fastBlit

;--------------------------------------------------
; sets the two colors one hand of the x position
;--------------------------------------------------
prepareFineDitherColors SUBROUTINE
	txa
	and #$03
	tay
	lda ANDOUT,y
	sta ZP_COLUMN
	txa
	and #$01
	beq .flippeddither
	lda (ZP_READCOLOR1),y
	sta ZP_COLOR1
	lda (ZP_READCOLOR2),y
	sta ZP_COLOR2
	rts
.flippeddither
	lda (ZP_READCOLOR1),y
	sta ZP_COLOR2
	lda (ZP_READCOLOR2),y
	sta ZP_COLOR1
	rts

;--------------------------------------------------------
; here starts the fast blitting function
;--------------------------------------------------------
; p_yue dc.b $00 ; end of fine portion up ; ZEROPAGE
; p_yde dc.b $00 ; end of fine portion down ; ZEROPAGE
; p_finePortion dc.b $00 ; 0 to 4 ; ZEROPAGE
; p_ystop dc.b $00 ; for the down cap ; ZEROPAGE
fastBlit SUBROUTINE

	lda p_xp
	clc
	adc #$04
	tay

	lda topy,y
	sta p_yue
	cmp topy,x
	bcs .not14
	lda topy,x
	sta p_yue
.not14

	lda downy,y
	sta p_yde
	cmp downy,x
	bcc .not24
	lda downy,x
	sta p_yde
.not24

	lda p_yue
	and #$01
	beq .zwo2
	inc p_yue
.zwo2

	lda p_yde
	and #$01
	beq .zwo1
	dec p_yde
.zwo1

	lda p_yde
	cmp p_yue
	bcs .do
.do2
	jmp SLOWBLIT
.do

	lda #$04
	sta p_finePortion

.blitnextfine

	; prepare fine dither colors 
	lax p_xp
	and #$03
	tay
	lda ANDOUT,y
	sta ZP_COLUMN
	txa
	and #$01
	beq .flippeddither
	lda (ZP_READCOLOR1),y
	sta ZP_COLOR1
	lda (ZP_READCOLOR2),y
	sta ZP_COLOR2
	jmp .doNormal
.flippeddither
	lda (ZP_READCOLOR1),y
	sta ZP_COLOR2
	lda (ZP_READCOLOR2),y
	sta ZP_COLOR1
.doNormal

	; generate bitmap write
	ldy topy,x
	lda (ZP_MUL10BLITSLOWLO),y
	sta .jumpin1 + 1
	lda (ZP_MUL10BLITSLOWHI),y
	sta .jumpin1 + 2
	ldy p_yue
	lda (ZP_MUL10BLITSLOWLO),y
	sta ZP_RTS_PLACER + 0
	lda (ZP_MUL10BLITSLOWHI),y
	sta ZP_RTS_PLACER + 1
	ldy #$00
	lda #OPC_RTS
	sta (ZP_RTS_PLACER),y
	txa
	and #%1111100
	asl
	tax ; * 8
	stx .x2 + 1
.jumpin1
	jsr $4444
	ldy #$00
	lda #OPC_LDA_ABS_X
	sta (ZP_RTS_PLACER),y

	ldx p_xp

	; generate bitmap write
	ldy p_yde
	lda (ZP_MUL10BLITSLOWLO),y
	sta .jumpin2 + 1
	lda (ZP_MUL10BLITSLOWHI),y
	sta .jumpin2 + 2
	ldy downy,x
	lda (ZP_MUL10BLITSLOWLO),y
	sta ZP_RTS_PLACER + 0
	lda (ZP_MUL10BLITSLOWHI),y
	sta ZP_RTS_PLACER + 1
	ldy #$00
	lda #OPC_RTS
	sta (ZP_RTS_PLACER),y
.x2
	ldx #$44
.jumpin2
	jsr $4444
	ldy #$00
	lda #OPC_LDA_ABS_X
	sta (ZP_RTS_PLACER),y

	dec p_finePortion
	beq .donefineblit

	inc p_xp
	ldx p_xp
	jmp .blitnextfine
.donefineblit

	inc p_xp

	; generate bitmap write
	lda p_yue
	lsr
	tay
	lda (ZP_MUL3BLITFASTLO),y
	sta .jumpin3 + 1
	sta .jumpin4 + 1
	lda (ZP_MUL3BLITFASTHI),y
	sta .jumpin3 + 2
	sta .jumpin4 + 2
	lda p_yde
	lsr
	tay
	lda (ZP_MUL3BLITFASTLO),y
	sta ZP_RTS_PLACER + 0
	lda (ZP_MUL3BLITFASTHI),y
	sta ZP_RTS_PLACER + 1
	ldy #$00
	lda #OPC_RTS
	sta (ZP_RTS_PLACER),y
	lda p_xp
	sec
	sbc #$04 ; we need the byte before
	tax
	asl ; * 8
	tax
	lda ZP_COLORFULL1
.jumpin3
	jsr $4444
	inx
	lda ZP_COLORFULL2
.jumpin4
	jsr $4444
	ldy #$00
	lda #OPC_STA_ABS_X
	sta (ZP_RTS_PLACER),y

	jmp FastBlitDone

; ------------------------------------------------ VARS

COLORBITMASK
	; 0
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000

	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000

	; 1
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000

	dc.b %01000000
	dc.b %00000000
	dc.b %00000100
	dc.b %00000000

	; 2
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000
	dc.b %00000000

	dc.b %01000000
	dc.b %00010000
	dc.b %00000100
	dc.b %00000001

	; 3	
	dc.b %01000000
	dc.b %00010000
	dc.b %00000100
	dc.b %00000001

	dc.b %01000000
	dc.b %00010000
	dc.b %00000100
	dc.b %00000001

	; 4
	dc.b %01000000
	dc.b %00010000
	dc.b %00000100
	dc.b %00000001

	dc.b %10000000
	dc.b %00100000
	dc.b %00001000
	dc.b %00000010

	; 5
	dc.b %10000000
	dc.b %00100000
	dc.b %00001000
	dc.b %00000010

	dc.b %10000000
	dc.b %00100000
	dc.b %00001000
	dc.b %00000010

	; 6
	dc.b %10000000
	dc.b %00100000
	dc.b %00001000
	dc.b %00000010

	dc.b %11000000
	dc.b %00110000
	dc.b %00001100
	dc.b %00000011

	; 7
	dc.b %11000000
	dc.b %00110000
	dc.b %00001100
	dc.b %00000011

	dc.b %11000000
	dc.b %00110000
	dc.b %00001100
	dc.b %00000011


; for whole fillers
COLORBITMASKFULL1
	dc.b %00000000
	dc.b %01000100
	dc.b %01000100
	dc.b %01010101
	dc.b %10011001
	dc.b %10101010
	dc.b %11101110
	dc.b %11111111

COLORBITMASKFULL2
	dc.b %00000000
	dc.b %00000000
	dc.b %00010001
	dc.b %01010101
	dc.b %01100110
	dc.b %10101010
	dc.b %10111011
	dc.b %11111111
ANDOUT	
	dc.b %00111111
	dc.b %11001111
	dc.b %11110011
	dc.b %11111100

MUL10BLITSLOWLO 
Y SET 0
	REPEAT SCREENYSIZE
	dc.b <[BLITSLOW+Y*10]
Y SET Y + 1
	REPEND

MUL10BLITSLOWHI 
Y SET 0
	REPEAT SCREENYSIZE
	dc.b >[BLITSLOW+Y*10]
Y SET Y + 1
	REPEND

MUL3BLITFASTLO 
Y SET 0
	REPEAT SCREENYSIZE
	dc.b <[BLITFAST+Y*3]
Y SET Y + 1
	REPEND

MUL3BLITFASTHI 
Y SET 0
	REPEAT SCREENYSIZE
	dc.b >[BLITFAST+Y*3]
Y SET Y + 1
	REPEND

MUL10BLITSLOWLO2 
Y SET 0
	REPEAT SCREENYSIZE
	dc.b <[BLITSLOW2+Y*10]
Y SET Y + 1
	REPEND

MUL10BLITSLOWHI2 
Y SET 0
	REPEAT SCREENYSIZE
	dc.b >[BLITSLOW2+Y*10]
Y SET Y + 1
	REPEND

MUL3BLITFASTLO2 
Y SET 0
	REPEAT SCREENYSIZE
	dc.b <[BLITFAST2+Y*3]
Y SET Y + 1
	REPEND

MUL3BLITFASTHI2 
Y SET 0
	REPEAT SCREENYSIZE
	dc.b >[BLITFAST2+Y*3]
Y SET Y + 1
	REPEND

BLITSLOW
Y SET YMOVE
	REPEAT SCREENYSIZE/2
	lda BITMAP1+[Y & 7]+[Y/8*320]+SCREENXP4*8,x
	and ZP_COLUMN
	ora ZP_COLOR1
	sta BITMAP1+[Y & 7]+[Y/8*320]+SCREENXP4*8,x
Y SET Y + 1
	lda BITMAP1+[Y & 7]+[Y/8*320]+SCREENXP4*8,x
	and ZP_COLUMN
	ora ZP_COLOR2
	sta BITMAP1+[Y & 7]+[Y/8*320]+SCREENXP4*8,x
Y SET Y + 1
	REPEND
	rts

BLITSLOW2
Y SET YMOVE
	REPEAT SCREENYSIZE/2
	lda BITMAP2+[Y & 7]+[Y/8*320]+SCREENXP4*8,x
	and ZP_COLUMN
	ora ZP_COLOR1
	sta BITMAP2+[Y & 7]+[Y/8*320]+SCREENXP4*8,x
Y SET Y + 1
	lda BITMAP2+[Y & 7]+[Y/8*320]+SCREENXP4*8,x
	and ZP_COLUMN
	ora ZP_COLOR2
	sta BITMAP2+[Y & 7]+[Y/8*320]+SCREENXP4*8,x
Y SET Y + 1
	REPEND
	rts

BLITFAST
Y SET YMOVE
	REPEAT SCREENYSIZE/2
	sta BITMAP1+[[Y] & 7]+[[Y]/8*320]+SCREENXP4*8,x
Y SET Y + 2
	REPEND
	rts

BLITFAST2
Y SET  YMOVE
	REPEAT SCREENYSIZE/2
	sta BITMAP2+[[Y] & 7]+[[Y]/8*320]+SCREENXP4*8,x
Y SET Y + 2	
	REPEND
	rts

	echo "eof: ",.
	