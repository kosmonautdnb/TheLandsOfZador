PLAYER_BEGIN SET .

	include "player_const.asm"

	SUBROUTINE	

	include "player_code.asm"
	include "player_frqtab.asm"
	echo "PLAYER: ",[. - PLAYER_BEGIN]

ZP_USEBIOSLOADING = $8f ; 1 ; also defined in persistent.asm
ZP_FOURBYTES	  = $40 ; 4 ; also defined in persistent.asm

KERNAL_SETLFS	= $ffba
KERNAL_SETNAM	= $ffbd
KERNAL_SETMSG   = $ff90
KERNAL_OPEN	= $ffc0
KERNAL_CLOSE	= $ffc3
KERNAL_LOAD	= $ffd5
KERNAL_SAVE	= $ffd8
DELTA = $00

load2 SUBROUTINE
	lda ZP_USEBIOSLOADING
	bne loadKernal
	jsr openfile
	jmp loadNormal

loadKernal SUBROUTINE
	lda #$01
.waitb
	bit $ff1c
	beq .waitb
	
	; irgendwie werden die daten bei 07f6 und 0544 ueberschrieben.
	sei
	lda $ff06
	pha
	lda #$0b
	sta $ff06

	lda $05e8
	pha 
	lda $07c2
	pha 
	lda $07ce
	pha

	lda #$00
	sta $ff11

	stx ZP_FOURBYTES + 0
	sty ZP_FOURBYTES + 1
	tay ; 00
.readfn
	lda (ZP_FOURBYTES + 0),y
	beq .found
	iny
	bne .readfn ; memsparen
.found
	tya
	pha

	ldx #$7f
.save380
	lda $380,x
	sta $100+DELTA,x
	cpx #restore07d9end - restore07d9start
	bpl .zwo1
	lda $07d9,x
	sta $0180+DELTA,x
	lda restore07d9start,x
	sta $07d9,x
.zwo1
	dex
	bpl .save380

	sta $ff3e

	jsr $F2CE ; !! wichtig !! 0300

	lda #<irqh
	sta $0314
	lda #>irqh
	sta $0315

	; SETLFS
    ldx #8	   ; Device Number
    lda #1     ; Logical File Number
	tay     ; SA 1 = take prg header adress
    jsr KERNAL_SETLFS

    ; SETNAM
    pla
    ldx ZP_FOURBYTES + 0
	ldy ZP_FOURBYTES + 1
    jsr KERNAL_SETNAM

	lda #$00   ; load not verify
	jsr KERNAL_LOAD

	ldx #$7f
.load380
	lda $100+DELTA,x
	sta $380,x
	cpx #restore07d9end - restore07d9start
	bpl .zwo2
	lda $0180+DELTA,x
	sta $07d9,x
.zwo2
	dex
	bpl .load380
	
	inx
	stx $ff19

	lda $9d
	sta load_end + 0
	lda $9e
	sta load_end + 1

	pla
	sta $07ce
	pla
	sta $07c2
	pla
	sta $05e8
	pla
	sta $ff06

	jsr topirq_install
	sta $ff3f

	cli
	rts

restore07d9start
	php
	sei
	sta $ff3f
	lda ($9b),y
	sta $ff3e
	plp
	rts
restore07d9end

irqh
	lda $ff19
	adc #$01
	and #$01
	sta $ff19
	inc $ff09
	jmp $fcbe

	ORG $0d80 - 3 ; safety bytes
	ORG $0d80

SNGBEGIN = .
	ECHO "SNGBEGIN: ",[.]
.song
	include "../../../Musics/FrameworkSong/asm/song.asm"
	ECHO "SONG: ",[.-.song]
	echo "TOTAL: ",[. - PLAYER_BEGIN]
	