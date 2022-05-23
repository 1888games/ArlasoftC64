

 	* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/fight - sprites.bin"

* = $2000 "SFX"

SFX:	.import binary "../assets/sfx2.prg"   
		

* = $f000 "Charset"

CHAR_SET:	.import binary "../assets/fight - Chars.bin"   
		
* = $7000 "Game Map" 
MAP: 		.import binary "../assets/fight - Map (20x13).bin"

* = * "Game Tiles" 
MAP_TILES: .import binary "../assets/fight - Tiles.bin"

* = $7190

* = * "Game Colours" 
CHAR_COLORS: .import binary "../assets/fight - CharAttribs_L1.bin"




	//.pc = sid.location "sid"
	//.fill sid.size, sid.getData(i)