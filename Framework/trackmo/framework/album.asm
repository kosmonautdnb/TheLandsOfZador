;---------------------------------------------------

album_songs
	dc.w song_metamerism

album_numsongs dc.b $01

album_patternmap
	dc.w pat_nil
	dc.w pat_pl
	dc.w pat_pr0
	dc.w pat_prz
	dc.w pat_pr
	dc.w pat_pr2
	dc.w pat_px
	dc.w pat_claptest_beng_fi
	dc.w pat_claptest
	dc.w pat_claptest_hh
	dc.w pat_claptest_beng
	dc.w pat_claptest_hh_fi1
	dc.w pat_claptest_hhchr
	dc.w pat_bl1
	dc.w pat_bl2
	dc.w pat_bl2_fi
	dc.w pat_bip1
	dc.w pat_hhmixin
	dc.w pat_melo1
	dc.w pat_melo1ch
	dc.w pat_melo2
	dc.w pat_melo2ch
	dc.w pat_melo3
	dc.w pat_melo4
	dc.w pat_downgroove
	dc.w pat_upgroove
	dc.w pat_off
	dc.w pat_bln1
	dc.w pat_bln2
	dc.w pat_bl2_fi2
	dc.w pat_melo1_od
	dc.w pat_melo2_od
	dc.w pat_melo3_od
	dc.w pat_melo4_od
	dc.w pat_bl1_t
	dc.w pat_bl2_t
	dc.w pat_bip1_t
	dc.w pat_pl_fi1
	dc.w pat_pr2_fi1
	dc.w pat_px_fi1
	dc.w pat_pl_fi4
	dc.w pat_pr2_fi4
	dc.w pat_prz_fi4
	dc.w pat_pl_fi5

album_frqtab_lo
	dc.b <ins_nil_frq
	dc.b <ins_bd_frq
	dc.b <ins_sn_frq
	dc.b <ins_sn2_frq
	dc.b <ins_hh_frq
	dc.b <ins_hh2_frq
	dc.b <ins_hh4_frq
	dc.b <ins_hh3_frq
	dc.b <ins_cl_frq
	dc.b <ins_beng_frq
	dc.b <ins_pling_frq
	dc.b <ins_sq_frq
	dc.b <ins_bl_frq
	dc.b <ins_bl2_frq
	dc.b <ins_bip_frq
	dc.b <ins_chr1_frq
	dc.b <ins_mchr1_frq
	dc.b <ins_mchr2_frq
	dc.b <ins_melo_frq


album_frqtab_hi
	dc.b >ins_nil_frq
	dc.b >ins_bd_frq
	dc.b >ins_sn_frq
	dc.b >ins_sn2_frq
	dc.b >ins_hh_frq
	dc.b >ins_hh2_frq
	dc.b >ins_hh4_frq
	dc.b >ins_hh3_frq
	dc.b >ins_cl_frq
	dc.b >ins_beng_frq
	dc.b >ins_pling_frq
	dc.b >ins_sq_frq
	dc.b >ins_bl_frq
	dc.b >ins_bl2_frq
	dc.b >ins_bip_frq
	dc.b >ins_chr1_frq
	dc.b >ins_mchr1_frq
	dc.b >ins_mchr2_frq
	dc.b >ins_melo_frq


album_frqtab_stop
	dc.b 2
	dc.b 20
	dc.b 12
	dc.b 16
	dc.b 4
	dc.b 6
	dc.b 6
	dc.b 12
	dc.b 6
	dc.b 8
	dc.b 2
	dc.b 12
	dc.b 14
	dc.b 14
	dc.b 18
	dc.b 8
	dc.b 14
	dc.b 8
	dc.b 20


album_frqtab_loop
	dc.b 0
	dc.b 18
	dc.b 8
	dc.b 12
	dc.b 0
	dc.b 4
	dc.b 4
	dc.b 8
	dc.b 4
	dc.b 0
	dc.b 0
	dc.b 10
	dc.b 0
	dc.b 0
	dc.b 2
	dc.b 2
	dc.b 0
	dc.b 0
	dc.b 4


album_voltab_lo
	dc.b <ins_nil_vol
	dc.b <ins_bd_vol
	dc.b <ins_sn_vol
	dc.b <ins_sn2_vol
	dc.b <ins_hh_vol
	dc.b <ins_hh2_vol
	dc.b <ins_hh4_vol
	dc.b <ins_hh3_vol
	dc.b <ins_cl_vol
	dc.b <ins_beng_vol
	dc.b <ins_pling_vol
	dc.b <ins_sq_vol
	dc.b <ins_bl_vol
	dc.b <ins_bl2_vol
	dc.b <ins_bip_vol
	dc.b <ins_chr1_vol
	dc.b <ins_mchr1_vol
	dc.b <ins_mchr2_vol
	dc.b <ins_melo_vol


album_voltab_hi
	dc.b >ins_nil_vol
	dc.b >ins_bd_vol
	dc.b >ins_sn_vol
	dc.b >ins_sn2_vol
	dc.b >ins_hh_vol
	dc.b >ins_hh2_vol
	dc.b >ins_hh4_vol
	dc.b >ins_hh3_vol
	dc.b >ins_cl_vol
	dc.b >ins_beng_vol
	dc.b >ins_pling_vol
	dc.b >ins_sq_vol
	dc.b >ins_bl_vol
	dc.b >ins_bl2_vol
	dc.b >ins_bip_vol
	dc.b >ins_chr1_vol
	dc.b >ins_mchr1_vol
	dc.b >ins_mchr2_vol
	dc.b >ins_melo_vol


album_voltab_stop
	dc.b 2
	dc.b 18
	dc.b 8
	dc.b 8
	dc.b 14
	dc.b 4
	dc.b 4
	dc.b 6
	dc.b 18
	dc.b 16
	dc.b 6
	dc.b 8
	dc.b 10
	dc.b 12
	dc.b 8
	dc.b 10
	dc.b 4
	dc.b 8
	dc.b 8


album_voltab_loop
	dc.b 0
	dc.b 16
	dc.b 6
	dc.b 6
	dc.b 12
	dc.b 2
	dc.b 2
	dc.b 4
	dc.b 16
	dc.b 14
	dc.b 4
	dc.b 0
	dc.b 8
	dc.b 10
	dc.b 6
	dc.b 8
	dc.b 2
	dc.b 0
	dc.b 6


PATID_nil	EQU	$00
PATID_pl	EQU	$01
PATID_pr0	EQU	$02
PATID_prz	EQU	$03
PATID_pr	EQU	$04
PATID_pr2	EQU	$05
PATID_px	EQU	$06
PATID_claptest_beng_fi	EQU	$07
PATID_claptest	EQU	$08
PATID_claptest_hh	EQU	$09
PATID_claptest_beng	EQU	$0A
PATID_claptest_hh_fi1	EQU	$0B
PATID_claptest_hhchr	EQU	$0C
PATID_bl1	EQU	$0D
PATID_bl2	EQU	$0E
PATID_bl2_fi	EQU	$0F
PATID_bip1	EQU	$10
PATID_hhmixin	EQU	$11
PATID_melo1	EQU	$12
PATID_melo1ch	EQU	$13
PATID_melo2	EQU	$14
PATID_melo2ch	EQU	$15
PATID_melo3	EQU	$16
PATID_melo4	EQU	$17
PATID_downgroove	EQU	$18
PATID_upgroove	EQU	$19
PATID_off	EQU	$1A
PATID_bln1	EQU	$1B
PATID_bln2	EQU	$1C
PATID_bl2_fi2	EQU	$1D
PATID_melo1_od	EQU	$1E
PATID_melo2_od	EQU	$1F
PATID_melo3_od	EQU	$20
PATID_melo4_od	EQU	$21
PATID_bl1_t	EQU	$22
PATID_bl2_t	EQU	$23
PATID_bip1_t	EQU	$24
PATID_pl_fi1	EQU	$25
PATID_pr2_fi1	EQU	$26
PATID_px_fi1	EQU	$27
PATID_pl_fi4	EQU	$28
PATID_pr2_fi4	EQU	$29
PATID_prz_fi4	EQU	$2A
PATID_pl_fi5	EQU	$2B

INSID_nil	EQU	$00
INSID_bd	EQU	$01
INSID_sn	EQU	$02
INSID_sn2	EQU	$03
INSID_hh	EQU	$04
INSID_hh2	EQU	$05
INSID_hh4	EQU	$06
INSID_hh3	EQU	$07
INSID_cl	EQU	$08
INSID_beng	EQU	$09
INSID_pling	EQU	$0A
INSID_sq	EQU	$0B
INSID_bl	EQU	$0C
INSID_bl2	EQU	$0D
INSID_bip	EQU	$0E
INSID_chr1	EQU	$0F
INSID_mchr1	EQU	$10
INSID_mchr2	EQU	$11
INSID_melo	EQU	$12

;---------------------------------------------------

song_metamerism
	dc.b $3F,$04,$02,$00,$00,$00,$00,$00,$04,$00,$00,$00,$00,$00
	dc.w song_metamerism_sequence
	dc.b $06,$05,$04,$03,$00,$00,$00,$00
	dc.b $00,$00,$01,$01,$02,$02,$02,$03
	dc.b $03,$03,$04,$04,$05,$06,$07,$08

song_metamerism_sequence
	dc.b $00,PATID_pl,PATID_prz,PATID_nil
	dc.b $00,PATID_pl,PATID_prz,PATID_nil
	dc.b $00,PATID_pl,PATID_prz,PATID_nil
	dc.b $00,PATID_pl,PATID_prz,PATID_nil
	dc.b $00,PATID_pl,PATID_pr0,PATID_nil
	dc.b $00,PATID_pl,PATID_pr0,PATID_nil
	dc.b $00,PATID_pl,PATID_pr0,PATID_nil
	dc.b $00,PATID_pl,PATID_pr0,PATID_nil
	dc.b $00,PATID_pl,PATID_pr,PATID_nil
	dc.b $00,PATID_pl,PATID_pr,PATID_nil
	dc.b $00,PATID_pl,PATID_pr,PATID_nil
	dc.b $00,PATID_pl_fi1,PATID_pr,PATID_nil
	dc.b $00,PATID_pl,PATID_pr2,PATID_nil
	dc.b $00,PATID_pl,PATID_pr2,PATID_nil
	dc.b $00,PATID_pl,PATID_pr2,PATID_nil
	dc.b $00,PATID_pl_fi1,PATID_pr2,PATID_nil
	dc.b $00,PATID_pl,PATID_pr2,PATID_px
	dc.b $00,PATID_pl,PATID_pr2,PATID_px
	dc.b $00,PATID_pl,PATID_pr2,PATID_px
	dc.b $00,PATID_pl_fi1,PATID_pr2_fi1,PATID_px
	dc.b $00,PATID_pl,PATID_pr2,PATID_px
	dc.b $00,PATID_pl,PATID_pr2,PATID_px
	dc.b $00,PATID_pl,PATID_pr2,PATID_px
	dc.b $00,PATID_pl_fi1,PATID_pr2_fi1,PATID_px_fi1
	dc.b $00,PATID_pl,PATID_melo1ch,PATID_nil
	dc.b $00,PATID_pl,PATID_melo2ch,PATID_nil
	dc.b $00,PATID_pl,PATID_melo1ch,PATID_nil
	dc.b $00,PATID_pl_fi1,PATID_melo2ch,PATID_nil
	dc.b $00,PATID_melo1ch,PATID_melo1,PATID_off
	dc.b $00,PATID_melo2ch,PATID_melo2,PATID_downgroove
	dc.b $00,PATID_melo1ch,PATID_melo3,PATID_nil
	dc.b $00,PATID_melo2ch,PATID_melo4,PATID_nil
song_metamerism_loop
	dc.b $00,PATID_melo1_od,PATID_bl1,PATID_melo1ch
	dc.b $00,PATID_melo2_od,PATID_bl2,PATID_melo2ch
	dc.b $00,PATID_melo3_od,PATID_bl1,PATID_melo1ch
	dc.b $00,PATID_melo4_od,PATID_bl2_fi,PATID_melo2ch
	dc.b $00,PATID_melo1,PATID_bl1,PATID_melo1ch
	dc.b $00,PATID_melo2,PATID_bl2,PATID_melo2ch
	dc.b $00,PATID_melo3,PATID_bl1,PATID_melo1ch
	dc.b $00,PATID_melo4,PATID_bl2_fi2,PATID_melo2ch
	dc.b $00,PATID_melo1ch,PATID_bip1,PATID_bl1
	dc.b $00,PATID_melo2ch,PATID_bip1,PATID_bl2_fi
	dc.b $00,PATID_melo1ch,PATID_bip1,PATID_bl1
	dc.b $00,PATID_melo2ch,PATID_bip1,PATID_bl2_fi2
	dc.b $00,PATID_bip1,PATID_bln1,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bln2,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bln1,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bln2,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bl1,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bl2_fi,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bl1,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bl2_fi,PATID_hhmixin
	dc.b $00,PATID_bip1_t,PATID_bl1_t,PATID_hhmixin
	dc.b $00,PATID_bip1_t,PATID_bl2_t,PATID_hhmixin
	dc.b $00,PATID_bip1_t,PATID_bl1_t,PATID_hhmixin
	dc.b $00,PATID_bip1_t,PATID_bl2_t,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bl1,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bl2_fi,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bl1,PATID_hhmixin
	dc.b $00,PATID_bip1,PATID_bl2_fi2,PATID_hhmixin
	dc.b $00,PATID_upgroove,PATID_prz,PATID_bip1
	dc.b $00,PATID_pl_fi5,PATID_prz_fi4,PATID_bip1
	dc.b $00,PATID_pl,PATID_pr2,PATID_bip1
	dc.b $00,PATID_pl,PATID_pr2,PATID_bip1
	dc.b $00,PATID_pl,PATID_pr2,PATID_bip1
	dc.b $00,PATID_pl_fi1,PATID_pr2_fi1,PATID_bip1
	dc.b $00,PATID_pl,PATID_pr2,PATID_px
	dc.b $00,PATID_pl,PATID_pr2,PATID_px
	dc.b $00,PATID_pl,PATID_pr2,PATID_px
	dc.b $00,PATID_pl_fi4,PATID_pr2_fi4,PATID_px_fi1
	dc.b $00,PATID_pl,PATID_pr2,PATID_claptest
	dc.b $00,PATID_pl,PATID_pr2,PATID_claptest
	dc.b $00,PATID_pl,PATID_pr2,PATID_claptest
	dc.b $00,PATID_pl_fi4,PATID_pr2_fi4,PATID_claptest
	dc.b $00,PATID_claptest_beng,PATID_claptest,PATID_claptest_hh
	dc.b $00,PATID_claptest_beng,PATID_claptest,PATID_claptest_hh
	dc.b $00,PATID_claptest_beng,PATID_claptest,PATID_claptest_hh
	dc.b $00,PATID_claptest_beng_fi,PATID_claptest,PATID_claptest_hh_fi1
	dc.b $00,PATID_claptest_beng,PATID_bip1,PATID_claptest_hhchr
	dc.b $00,PATID_claptest_beng,PATID_bip1,PATID_claptest_hhchr
	dc.b $00,PATID_claptest_beng,PATID_bip1,PATID_claptest_hhchr
	dc.b $00,PATID_claptest_beng_fi,PATID_bip1,PATID_claptest_hhchr
	dc.b $00,PATID_melo1ch,PATID_bip1,PATID_claptest_hhchr
	dc.b $00,PATID_melo2ch,PATID_bip1,PATID_claptest_hhchr
	dc.b $00,PATID_melo1ch,PATID_bip1,PATID_nil
	dc.b $00,PATID_melo2ch,PATID_bip1,PATID_nil
	dc.b $00,PATID_melo1ch,PATID_bl1,PATID_downgroove
	dc.b $00,PATID_melo2ch,PATID_bl2_fi,PATID_nil
	dc.b $00,PATID_melo1ch,PATID_bl1,PATID_nil
	dc.b $00,PATID_melo2ch,PATID_bl2_fi,PATID_nil
	dc.b $ff
	dc.w [.-song_metamerism_loop-1]


;---------------------------------------------------

pat_nil
	player_settrackregister PATTERN_WAIT,$00
pat_nil_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_nil_loop+2]

pat_pl
pat_pl_loop
	player_settrackregister $09,$0A
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$72
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_rewind [.-pat_pl_loop+2]

pat_pr0
pat_pr0_loop
	player_setinstrument $06,INSID_bd
	player_setinstrument $02,INSID_hh
	player_setinstrument $04,INSID_bd
	player_setinstrument $04,INSID_hh
	player_setinstrument $06,INSID_bd
	player_setinstrument $02,INSID_hh
	player_setinstrument $04,INSID_bd
	player_setinstrument $04,INSID_hh
	player_setinstrument $06,INSID_bd
	player_setinstrument $02,INSID_hh
	player_setinstrument $04,INSID_bd
	player_setinstrument $04,INSID_hh
	player_setinstrument $06,INSID_bd
	player_setinstrument $02,INSID_hh
	player_setinstrument $04,INSID_bd
	player_setinstrument $04,INSID_hh
	player_rewind [.-pat_pr0_loop+2]

pat_prz
pat_prz_loop
	player_settrackregister $08,$00
	player_setinstrument $08,INSID_bd
	player_rewind [.-pat_prz_loop+2]

pat_pr
pat_pr_loop
	player_settrackregister $08,$00
	player_setinstrument $06,INSID_bd
	player_setinstrument $02,INSID_hh
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $06,INSID_bd
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $06,INSID_bd
	player_setinstrument $02,INSID_hh
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $06,INSID_bd
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $04,INSID_hh3
	player_setinstrument $02,INSID_hh
	player_rewind [.-pat_pr_loop+2]

pat_pr2
pat_pr2_loop
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh3
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $04,INSID_hh3
	player_setinstrument $02,INSID_hh
	player_rewind [.-pat_pr2_loop+2]

pat_px
pat_px_loop
	player_settrackregister $09,$6A
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_pling
	player_rewind [.-pat_px_loop+2]

pat_claptest_beng_fi
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_setinstrument $02,INSID_bd
	player_settrackregister $09,$FF
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_sq
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_setinstrument $02,INSID_bd
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_setinstrument $02,INSID_bd
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_beng
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$92
	player_setinstrument $04,INSID_beng
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $04,INSID_beng
	player_setinstrument $02,INSID_bd
	player_settrackregister $09,$13
	player_setinstrument $02,INSID_sq
	player_settrackregister $09,$06
	player_setinstrument $02,INSID_beng
	player_setinstrument $02,INSID_bd
pat_claptest_beng_fi_loop
	player_setinstrument $08,INSID_bd
	player_rewind [.-pat_claptest_beng_fi_loop+2]

pat_claptest
pat_claptest_loop
	player_settrackregister $09,$31
	player_settrackregister $08,$F8
	player_setinstrument $02,INSID_sq
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_cl
	player_settrackregister $08,$F8
	player_setinstrument $02,INSID_cl
	player_settrackregister $09,$93
	player_setinstrument $04,INSID_sq
	player_settrackregister $08,$FC
	player_setinstrument $04,INSID_cl
	player_settrackregister $09,$31
	player_settrackregister $08,$F8
	player_setinstrument $02,INSID_sq
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_cl
	player_settrackregister $08,$F8
	player_setinstrument $04,INSID_cl
	player_settrackregister $09,$93
	player_settrackregister $08,$FC
	player_setinstrument $02,INSID_sq
	player_settrackregister $08,$FC
	player_setinstrument $04,INSID_cl
	player_rewind [.-pat_claptest_loop+2]

pat_claptest_hh
pat_claptest_hh_loop
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_rewind [.-pat_claptest_hh_loop+2]

pat_claptest_beng
pat_claptest_beng_loop
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_setinstrument $02,INSID_bd
	player_settrackregister $09,$FF
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_sq
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_setinstrument $02,INSID_bd
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_setinstrument $02,INSID_bd
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_beng
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$92
	player_setinstrument $04,INSID_beng
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $04,INSID_beng
	player_setinstrument $02,INSID_bd
	player_settrackregister $09,$13
	player_setinstrument $02,INSID_sq
	player_settrackregister $09,$06
	player_setinstrument $02,INSID_beng
	player_setinstrument $02,INSID_bd
	player_rewind [.-pat_claptest_beng_loop+2]

pat_claptest_hh_fi1
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh4
pat_claptest_hh_fi1_loop
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_rewind [.-pat_claptest_hh_fi1_loop+2]

pat_claptest_hhchr
pat_claptest_hhchr_loop
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$FF
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$FF
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$FF
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_mchr1
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_settrackregister $09,$2E
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_mchr1
	player_settrackregister $08,$FE
	player_setinstrument $02,INSID_hh4
	player_rewind [.-pat_claptest_hhchr_loop+2]

pat_bl1
pat_bl1_loop
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$12
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_sn2
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$0A
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_rewind [.-pat_bl1_loop+2]

pat_bl2
pat_bl2_loop
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_sn2
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$1E
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$26
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$26
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_sn2
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$2E
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_rewind [.-pat_bl2_loop+2]

pat_bl2_fi
pat_bl2_fi_loop
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_sn2
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$1E
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$26
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$02
	player_setinstrument $01,INSID_bd
	player_settrackregister $09,$26
	player_settrackregister $08,$00
	player_setinstrument $03,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_sn2
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$2E
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_rewind [.-pat_bl2_fi_loop+2]

pat_bip1
pat_bip1_loop
	player_settrackregister $09,$12
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$1E
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_bip
	player_rewind [.-pat_bip1_loop+2]

pat_hhmixin
pat_hhmixin_loop
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_hh
	player_settrackregister $08,$FD
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_hh4
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_hh4
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_hh2
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_hh4
	player_rewind [.-pat_hhmixin_loop+2]

pat_melo1
	player_settrackregister $09,$72
	player_settrackregister $08,$00
	player_setinstrument $1B,INSID_melo
	player_setinstrument $01,INSID_nil
	player_settrackregister $09,$6A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$72
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$7A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$7E
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$7A
	player_setinstrument $0A,INSID_melo
	player_setinstrument $02,INSID_nil
	player_settrackregister $09,$6A
	player_setinstrument $04,INSID_melo
pat_melo1_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo1_loop+2]

pat_melo1ch
	player_settrackregister $09,$12
	player_setinstrument $04,INSID_mchr2
pat_melo1ch_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo1ch_loop+2]

pat_melo2
	player_settrackregister $09,$62
	player_settrackregister $08,$00
	player_setinstrument $18,INSID_melo
	player_settrackregister $09,$6A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$56
	player_setinstrument $04,INSID_melo
pat_melo2_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo2_loop+2]

pat_melo2ch
	player_settrackregister $09,$02
	player_setinstrument $24,INSID_mchr2
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_mchr2
pat_melo2ch_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo2ch_loop+2]

pat_melo3
	player_settrackregister $09,$72
	player_settrackregister $08,$00
	player_setinstrument $1B,INSID_melo
	player_setinstrument $01,INSID_nil
	player_settrackregister $09,$6A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$72
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$7A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$7E
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$7A
	player_setinstrument $08,INSID_melo
	player_settrackregister $09,$7E
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$8E
	player_setinstrument $04,INSID_melo
pat_melo3_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo3_loop+2]

pat_melo4
	player_settrackregister $09,$9A
	player_settrackregister PATTERN_WAIT,$10
	player_settrackregister $09,$8E
	player_settrackregister PATTERN_WAIT,$10
	player_settrackregister $09,$92
	player_settrackregister PATTERN_WAIT,$10
	player_settrackregister $09,$8E
	player_settrackregister PATTERN_WAIT,$10
pat_melo4_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo4_loop+2]

pat_downgroove
	player_settrackregister $09,$02
	player_settrackregister $08,$FF
	player_setsongregister $10,$05
	player_setinstrument $01,INSID_nil
	player_setsongregister $11,$04
	player_settrackregister PATTERN_WAIT,$01
	player_setsongregister $12,$05
	player_settrackregister PATTERN_WAIT,$01
	player_setsongregister $13,$04
	player_settrackregister PATTERN_WAIT,$01
pat_downgroove_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_downgroove_loop+2]

pat_upgroove
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $01,INSID_nil
	player_setsongregister $10,$06
	player_settrackregister PATTERN_WAIT,$01
	player_setsongregister $11,$05
	player_settrackregister PATTERN_WAIT,$01
	player_setsongregister $12,$04
	player_settrackregister PATTERN_WAIT,$01
	player_setsongregister $13,$03
	player_settrackregister PATTERN_WAIT,$01
pat_upgroove_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_upgroove_loop+2]

pat_off
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $00,INSID_nil
pat_off_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_off_loop+2]

pat_bln1
pat_bln1_loop
	player_settrackregister $09,$12
	player_settrackregister $08,$00
	player_setinstrument $38,INSID_bl2
	player_settrackregister $09,$0A
	player_setinstrument $10,INSID_bl2
	player_rewind [.-pat_bln1_loop+2]

pat_bln2
pat_bln2_loop
	player_settrackregister $09,$02
	player_setinstrument $38,INSID_bl2
	player_settrackregister $09,$26
	player_setinstrument $10,INSID_bl2
	player_rewind [.-pat_bln2_loop+2]

pat_bl2_fi2
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_sn2
	player_settrackregister $09,$12
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$1E
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $04,INSID_chr1
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$12
	player_setinstrument $04,INSID_chr1
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$12
	player_setinstrument $04,INSID_chr1
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$12
	player_setinstrument $04,INSID_chr1
pat_bl2_fi2_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_bl2_fi2_loop+2]

pat_melo1_od
	player_settrackregister $09,$42
	player_settrackregister $08,$00
	player_setinstrument $1B,INSID_melo
	player_setinstrument $01,INSID_nil
	player_settrackregister $09,$3A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$42
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$4A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$4E
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$4A
	player_setinstrument $0A,INSID_melo
	player_setinstrument $02,INSID_nil
	player_settrackregister $09,$3A
	player_setinstrument $04,INSID_melo
pat_melo1_od_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo1_od_loop+2]

pat_melo2_od
	player_settrackregister $09,$32
	player_settrackregister $08,$00
	player_setinstrument $18,INSID_melo
	player_settrackregister $09,$3A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$26
	player_setinstrument $04,INSID_melo
pat_melo2_od_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo2_od_loop+2]

pat_melo3_od
	player_settrackregister $09,$42
	player_settrackregister $08,$00
	player_setinstrument $1B,INSID_melo
	player_setinstrument $01,INSID_nil
	player_settrackregister $09,$3A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$42
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$4A
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$4E
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$4A
	player_setinstrument $08,INSID_melo
	player_settrackregister $09,$4E
	player_setinstrument $04,INSID_melo
	player_settrackregister $09,$5E
	player_setinstrument $04,INSID_melo
pat_melo3_od_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo3_od_loop+2]

pat_melo4_od
	player_settrackregister $09,$6A
	player_settrackregister PATTERN_WAIT,$10
	player_settrackregister $09,$5E
	player_settrackregister PATTERN_WAIT,$10
	player_settrackregister $09,$62
	player_settrackregister PATTERN_WAIT,$10
	player_settrackregister $09,$5E
	player_settrackregister PATTERN_WAIT,$10
pat_melo4_od_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_melo4_od_loop+2]

pat_bl1_t
pat_bl1_t_loop
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$26
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$26
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_sn2
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$1E
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_rewind [.-pat_bl1_t_loop+2]

pat_bl2_t
pat_bl2_t_loop
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$02
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_sn2
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$1E
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$0A
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_sn2
	player_settrackregister $09,$0A
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_chr1
	player_settrackregister $09,$02
	player_setinstrument $04,INSID_bd
	player_settrackregister $09,$0A
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bl
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_sn2
	player_settrackregister $09,$02
	player_setinstrument $02,INSID_bd
	player_settrackregister $09,$32
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bl
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_chr1
	player_rewind [.-pat_bl2_t_loop+2]

pat_bip1_t
pat_bip1_t_loop
	player_settrackregister $09,$42
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$32
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$26
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$42
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$32
	player_setinstrument $02,INSID_bip
	player_settrackregister $09,$0A
	player_setinstrument $02,INSID_bip
	player_rewind [.-pat_bip1_t_loop+2]

pat_pl_fi1
pat_pl_fi1_loop
	player_settrackregister $09,$0A
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$16
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$16
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$72
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$72
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_rewind [.-pat_pl_fi1_loop+2]

pat_pr2_fi1
pat_pr2_fi1_loop
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_hh
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_hh
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_hh2
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh2
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh2
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh
	player_rewind [.-pat_pr2_fi1_loop+2]

pat_px_fi1
pat_px_fi1_loop
	player_settrackregister $09,$6A
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $04,INSID_pling
	player_setinstrument $04,INSID_pling
	player_setinstrument $04,INSID_pling
	player_setinstrument $04,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_setinstrument $02,INSID_pling
	player_rewind [.-pat_px_fi1_loop+2]

pat_pl_fi4
pat_pl_fi4_loop
	player_settrackregister $09,$0A
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$06
	player_setinstrument $08,INSID_beng
	player_settrackregister $09,$16
	player_setinstrument $08,INSID_beng
	player_settrackregister $09,$72
	player_setinstrument $08,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $08,INSID_beng
	player_rewind [.-pat_pl_fi4_loop+2]

pat_pr2_fi4
pat_pr2_fi4_loop
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_hh
	player_settrackregister $08,$00
	player_setinstrument $02,INSID_bd
	player_setinstrument $02,INSID_sn
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_sn
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_hh
	player_setinstrument $02,INSID_hh2
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $04,INSID_hh
	player_settrackregister $08,$00
	player_setinstrument $04,INSID_bd
	player_setinstrument $04,INSID_hh2
	player_setinstrument $04,INSID_sn
	player_setinstrument $04,INSID_hh2
	player_setinstrument $04,INSID_sn
	player_setinstrument $02,INSID_hh4
	player_setinstrument $02,INSID_sn
	player_rewind [.-pat_pr2_fi4_loop+2]

pat_prz_fi4
	player_settrackregister $08,$00
	player_setinstrument $08,INSID_bd
	player_setinstrument $08,INSID_bd
	player_setinstrument $08,INSID_bd
	player_setinstrument $08,INSID_bd
	player_setinstrument $08,INSID_bd
	player_setinstrument $08,INSID_bd
	player_setinstrument $08,INSID_bd
	player_setinstrument $02,INSID_sn
	player_setinstrument $04,INSID_bd
	player_setinstrument $02,INSID_sn
pat_prz_fi4_loop
	player_settrackregister PATTERN_WAIT,$10
	player_rewind [.-pat_prz_fi4_loop+2]

pat_pl_fi5
pat_pl_fi5_loop
	player_settrackregister $09,$0A
	player_settrackregister $08,$00
	player_setinstrument $08,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $08,INSID_beng
	player_settrackregister $09,$0A
	player_setinstrument $08,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $08,INSID_beng
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$06
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$16
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$16
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$72
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$72
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_settrackregister $09,$0E
	player_setinstrument $04,INSID_beng
	player_rewind [.-pat_pl_fi5_loop+2]


;---------------------------------------------------

ins_nil
ins_nil_frq
ins_nil_vol
	player_moddata 0,0,0

ins_bd
ins_bd_frq
	player_moddata $00,$09,$28
	player_moddata $00,$09,$18
	player_moddata $00,$09,$04
	player_moddata $00,$09,$00
	player_moddata $00,$0D,$FC
	player_moddata $00,$08,$00
	player_moddata $00,$0D,$FC
	player_moddata $00,$08,$00
	player_moddata $00,$0D,$FC
	player_moddata $00,$08,$00

ins_bd_vol
	player_moddata $00,$00,$0F
	player_moddata $01,$00,$0D
	player_moddata $04,$00,$0C
	player_moddata $04,$00,$0A
	player_moddata $02,$00,$06
	player_moddata $01,$00,$04
	player_moddata $01,$00,$02
	player_moddata $01,$00,$01
	player_moddata $02,$00,$00


ins_sn
ins_sn_frq
	player_moddata $00,$0E,$F4
	player_moddata $00,$09,$48
	player_moddata $00,$09,$28
	player_moddata $00,$0E,$C1
	player_moddata $00,$0E,$FA
	player_moddata $00,$0E,$F7

ins_sn_vol
	player_moddata $02,$00,$0F
	player_moddata $02,$00,$0C
	player_moddata $02,$00,$08
	player_moddata $03,$00,$00


ins_sn2
ins_sn2_frq
	player_moddata $00,$0E,$FA
	player_moddata $01,$09,$30
	player_moddata $00,$0E,$F1
	player_moddata $00,$09,$2C
	player_moddata $00,$0E,$E8
	player_moddata $00,$0E,$E3
	player_moddata $00,$0E,$E7
	player_moddata $00,$0E,$FA

ins_sn2_vol
	player_moddata $02,$00,$0F
	player_moddata $02,$00,$0D
	player_moddata $02,$00,$08
	player_moddata $03,$00,$00


ins_hh
ins_hh_frq
	player_moddata $00,$0E,$EC
	player_moddata $00,$0E,$ED

ins_hh_vol
	player_moddata $00,$00,$0F
	player_moddata $00,$00,$0C
	player_moddata $00,$00,$08
	player_moddata $00,$00,$06
	player_moddata $00,$00,$04
	player_moddata $00,$00,$02
	player_moddata $00,$00,$00


ins_hh2
ins_hh2_frq
	player_moddata $00,$0E,$E1
	player_moddata $00,$0E,$E5
	player_moddata $00,$0E,$EB

ins_hh2_vol
	player_moddata $00,$00,$0F
	player_moddata $00,$00,$00


ins_hh4
ins_hh4_frq
	player_moddata $01,$0E,$FA
	player_moddata $00,$0E,$EB

ins_hh4_vol
	player_moddata $00,$00,$0F
	player_moddata $00,$00,$00


ins_hh3
ins_hh3_frq
	player_moddata $00,$0D,$F8
	player_moddata $00,$0D,$60
	player_moddata $00,$0E,$F4
	player_moddata $00,$0E,$F3
	player_moddata $00,$0E,$F4
	player_moddata $00,$0E,$F3

ins_hh3_vol
	player_moddata $01,$00,$0F
	player_moddata $00,$00,$0B
	player_moddata $00,$00,$03


ins_cl
ins_cl_frq
	player_moddata $05,$0E,$FB
	player_moddata $00,$0E,$FA
	player_moddata $00,$0E,$F7

ins_cl_vol
	player_moddata $04,$00,$0E
	player_moddata $00,$00,$0D
	player_moddata $00,$00,$0C
	player_moddata $00,$00,$0B
	player_moddata $00,$00,$0A
	player_moddata $00,$00,$09
	player_moddata $00,$00,$08
	player_moddata $03,$00,$04
	player_moddata $00,$00,$00


ins_beng
ins_beng_frq
	player_moddata $00,$05,$F3
	player_moddata $00,$00,$00
	player_moddata $00,$05,$F3
	player_moddata $00,$00,$00

ins_beng_vol
	player_moddata $00,$00,$0F
	player_moddata $04,$00,$0C
	player_moddata $04,$00,$08
	player_moddata $02,$00,$06
	player_moddata $04,$00,$04
	player_moddata $04,$00,$02
	player_moddata $04,$00,$01
	player_moddata $02,$00,$00


ins_pling
ins_pling_frq
	player_moddata $00,$01,$32

ins_pling_vol
	player_moddata $01,$00,$0C
	player_moddata $02,$00,$03
	player_moddata $02,$00,$00


ins_sq
ins_sq_frq
	player_moddata $00,$0D,$F1
	player_moddata $01,$05,$F4
	player_moddata $01,$05,$F3
	player_moddata $01,$05,$F2
	player_moddata $01,$05,$F1
	player_moddata $00,$05,$F0

ins_sq_vol
	player_moddata $06,$00,$0C
	player_moddata $05,$00,$02
	player_moddata $04,$00,$0A
	player_moddata $03,$00,$02


ins_bl
ins_bl_frq
	player_moddata $02,$01,$03
	player_moddata $02,$01,$02
	player_moddata $02,$01,$01
	player_moddata $02,$01,$02
	player_moddata $02,$01,$03
	player_moddata $02,$01,$02
	player_moddata $02,$01,$01

ins_bl_vol
	player_moddata $05,$00,$0C
	player_moddata $04,$00,$0B
	player_moddata $05,$00,$0A
	player_moddata $04,$00,$08
	player_moddata $08,$00,$00


ins_bl2
ins_bl2_frq
	player_moddata $02,$01,$03
	player_moddata $02,$01,$02
	player_moddata $02,$01,$01
	player_moddata $02,$01,$02
	player_moddata $02,$01,$03
	player_moddata $02,$01,$02
	player_moddata $02,$01,$01

ins_bl2_vol
	player_moddata $08,$00,$0A
	player_moddata $08,$00,$09
	player_moddata $08,$00,$08
	player_moddata $08,$00,$07
	player_moddata $08,$00,$06
	player_moddata $08,$00,$04


ins_bip
ins_bip_frq
	player_moddata $00,$01,$92
	player_moddata $02,$01,$32
	player_moddata $02,$01,$31
	player_moddata $02,$01,$30
	player_moddata $02,$01,$31
	player_moddata $02,$01,$32
	player_moddata $02,$01,$33
	player_moddata $02,$01,$34
	player_moddata $02,$01,$33

ins_bip_vol
	player_moddata $05,$00,$0B
	player_moddata $08,$00,$02
	player_moddata $08,$00,$01
	player_moddata $08,$00,$00


ins_chr1
ins_chr1_frq
	player_moddata $00,$0D,$E4
	player_moddata $01,$01,$3A
	player_moddata $01,$01,$4E
	player_moddata $01,$01,$32

ins_chr1_vol
	player_moddata $02,$00,$0C
	player_moddata $02,$00,$0A
	player_moddata $01,$00,$08
	player_moddata $01,$00,$06
	player_moddata $04,$00,$03


ins_mchr1
ins_mchr1_frq
	player_moddata $05,$01,$6A
	player_moddata $04,$01,$7E
	player_moddata $05,$01,$62
	player_moddata $05,$01,$8E
	player_moddata $04,$01,$6A
	player_moddata $05,$01,$7E
	player_moddata $04,$01,$62

ins_mchr1_vol
	player_moddata $04,$00,$0C
	player_moddata $04,$00,$03


ins_mchr2
ins_mchr2_frq
	player_moddata $02,$01,$62
	player_moddata $02,$01,$72
	player_moddata $02,$01,$7E
	player_moddata $03,$01,$92

ins_mchr2_vol
	player_moddata $04,$00,$0B
	player_moddata $05,$00,$02
	player_moddata $04,$00,$0A
	player_moddata $05,$00,$01


ins_melo
ins_melo_frq
	player_moddata $00,$01,$4E
	player_moddata $00,$01,$32
	player_moddata $01,$01,$01
	player_moddata $02,$01,$00
	player_moddata $01,$01,$01
	player_moddata $01,$01,$02
	player_moddata $01,$01,$03
	player_moddata $02,$01,$04
	player_moddata $01,$01,$03
	player_moddata $01,$01,$02

ins_melo_vol
	player_moddata $02,$00,$0C
	player_moddata $02,$00,$0A
	player_moddata $02,$00,$08
	player_moddata $05,$00,$07


