; POLY CONSTANTS
;--------------------------------------------

; ZEROPAGE
;--------------------------------------------
ZP_BITMAPWRITE	    = $30 ; 2
ZP_MUL10BLITSLOWLO	= $32 ; 2
ZP_MUL10BLITSLOWHI	= $34 ; 2
ZP_MUL3BLITFASTLO	= $36 ; 2
ZP_MUL3BLITFASTHI	= $38 ; 2
ZP_RTS_PLACER		= $3a ; 2

p_xp				= $3e ; 1
p_yue				= $3f ; 1
p_yde				= $40 ; 1
p_xendm4			= $41 ; 1
p_finePortion		= $42 ; 1

ZP_COLUMN			= $43 ; 1
ZP_COLORFULL1		= $44 ; 1
ZP_COLORFULL2		= $45 ; 1
ZP_COLOR1			= $46 ; 1
ZP_COLOR2			= $47 ; 1
ZP_READCOLOR1		= $48 ; 2
ZP_READCOLOR2		= $4a ; 2

p_yp1				= $4c ; 2
p_yp2				= $4e ; 2
p_dya1				= $50 ; 2
p_dya2				= $52 ; 2
p_dx1				= $54 ; 1
p_dx2				= $55 ; 1
p_dx				= $56 ; 1

s_cnt1				= $57 ; 1
s_somepointsout		= $58 ; 1 ; is atleast one point out
s_allpointsin		= $59 ; 1 ; checks if all points are inside
s_allpointsout		= $5a ; 1 ; checks if all points are outside
p_somepointsout		= s_somepointsout ; is atleast one point out
p_allpointsin		= s_allpointsin ; checks if all points are inside
p_allpointsout		= s_allpointsout ; checks if all points are outside
p_cE				= $5b ; 1
p_cS				= $5c ; 1
p_ccnt 				= $5d ; 1
p_cnt			    = $5e ; 1
s_ppos				= $5f ; 1


; CONSTANTS
;--------------------------------------------
BITMAP1 = $2000
BITMAP2 = $4000
MAXSPANX = 128

