PLAYER_BEGIN SET .

	include "player_const.asm"

	SUBROUTINE	

	include "player_code.asm"
	include "player_frqtab.asm"
	echo "PLAYER: ",[. - PLAYER_BEGIN]

SNGBEGIN = .
.song
	include "song.asm"
	ECHO "SONG: ",[.-.song]
	echo "TOTAL: ",[. - PLAYER_BEGIN]
	