song_registers 		ds.b [SONG_STRUCTSIZE],00
song_trackstates 	ds.b [TRACK_STRUCTSIZE*3],00
song_ff0e			ds.b SONG_MAXSPEED,$00
song_ff0f			ds.b SONG_MAXSPEED,$00
song_ff10			ds.b SONG_MAXSPEED,$00
song_ff11			ds.b SONG_MAXSPEED,$00
song_ff12			EQU $17e0 ;ds.b SONG_MAXSPEED,$00





