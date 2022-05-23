

 	* = $c400 "Sprites" //Start at frame #16
 	//.import binary "../../assets/jawbreaker - sprites.bin"



* = $f000 "Charset"

CHAR_SET:	.import binary "../assets/rectris - Chars.bin"   
		
* = $7000 "Game Map" 
MAP: 		.import binary "../assets/rectris - Map (20x13).bin"

* = * "Game Tiles" 
MAP_TILES: .import binary "../assets/rectris - Tiles.bin"

* = * "Game Colours" 
CHAR_COLORS: .import binary "../assets/rectris - CharAttribs_L1.bin"




	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)