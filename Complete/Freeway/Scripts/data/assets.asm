

 	* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/freeway - sprites.bin"

* = $7300 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/freeway - CharAttribs.bin"


* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/freeway - Chars.bin"   //roll 12!

* = $3000 "SFX"
		.import binary "../assets/plyr2.prg"

* = $7000 "Game Map" 
MAP: .import binary "../assets/freeway - Map (20x13).bin"

* = $7104 "Game Tiles" 
MAP_TILES: .import binary "../assets/freeway - Tiles.bin"
	



	//.pc = sid.location "sid"
	//.fill sid.size, sid.getData(i)