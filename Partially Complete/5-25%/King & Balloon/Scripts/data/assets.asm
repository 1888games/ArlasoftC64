
* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/spritepad/king - sprites.bin"







* = $5d50 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/charpad/king - CharAttribs.bin"


* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/charpad/king - Chars.bin"   //roll 12!

* = $5900 "Demo Map" 
MAP_DEMO: .import binary "../assets/charpad/galaga_D - Demo (8bpc, 20x13).bin"

* = $5a04 "Game Map" 
MAP: .import binary "../assets/charpad/galaga_D - Game (8bpc, 20x13).bin"

* = $5b08 "Game Tiles" 
MAP_TILES: .import binary "../assets/charpad/king - Tiles.bin"
	
* = $5f00 "Logo"
LOGO:	.import binary "../assets/charpad/galax_logo.bin"


	//.pc = sid.location "sid"
	//.fill sid.size, sid.getData(i)