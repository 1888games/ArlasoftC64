
* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/spritepad/glob - sprites.bin"







* = $5d50 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/charpad/glob - CharAttribs_L1.bin"


* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/charpad/glob - Chars.bin"   //roll 12!


* = $5a04 "Game Map" 
MAP: .import binary "../assets/charpad/glob - Map (20x13).bin"

* = $5b08 "Game Tiles" 
MAP_TILES: .import binary "../assets/charpad/glob - Tiles.bin"


	//.pc = sid.location "sid"
	//.fill sid.size, sid.getData(i)