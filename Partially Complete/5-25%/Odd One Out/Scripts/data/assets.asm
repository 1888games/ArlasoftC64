


 	* = $a000 "Sprites" //Start at frame #16
 	.import binary "../../assets/odd one out - sprites.bin"


 	* = $d000 "Sprites" //Start at frame #16
 	.import binary "../../assets/odd one out - sprites.bin"

* = $7300 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/singled - CharAttribs.bin"


* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/singled - Chars.bin"   //roll 12!



* = $7000 "Game Map" 
MAP: .import binary "../assets/singled - Map (20x13).bin"

* = $7104 "Game Tiles" 
MAP_TILES: .import binary "../assets/singled - Tiles.bin"
	



	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)