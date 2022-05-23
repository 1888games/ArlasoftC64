

 	* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/skyjinks - sprites.bin"



* = $f000 "Charset"



CHAR_SET:
.fill 2048, 0  
		
* = $7000 "Game Map" 
MAP: 		//.import binary "../assets/jawbreaker - Map (20x13).bin"
.byte 0

* = * "Game Tiles" 
MAP_TILES: //.import binary "../assets/jawbreaker - Tiles.bin"
.byte 0

* = * "Game Colours" 
CHAR_COLORS: 
.byte 0
//.import binary "../assets/jawbreaker - CharAttribs_L1.bin"




	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)