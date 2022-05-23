

 	* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/mike - sprites.bin"

* = $2000 "SFX"

SFX:	.import binary "../assets/sfx2.prg"   
		

* = $f000 "Charset"

CHAR_SET:	.import binary "../assets/c64 - Chars.bin"   
		
* = $7000 "Game Map" 
MAP: 		.import binary "../assets/c64 - Map (20x13).bin"

* = * "Game Tiles" 
MAP_TILES: .import binary "../assets/c64 - Tiles.bin"

* = * "Game Colours" 
CHAR_COLORS: .import binary "../assets/c64 - CharAttribs_L1.bin"




	//.pc = sid.location "sid"
	//.fill sid.size, sid.getData(i)