
* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/spritepad/PLANES - sprites.bin"







* = $5d50 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/charpad/paper - CharAttribs.bin"


* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/charpad/paper - Chars.bin"   //roll 12!


* = $5a04 "Game Map" 
MAP: .import binary "../assets/charpad/paper - Map (20x13).bin"

* = $5b08 "Game Tiles" 
MAP_TILES: .import binary "../assets/charpad/paper - Tiles.bin"


	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)