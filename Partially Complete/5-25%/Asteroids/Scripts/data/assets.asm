
* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/spritepad/asteroids - sprites.bin"







* = $7800 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/charpad/asteroids - CharAttribs_L1.bin"


* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/charpad/asteroids - Chars.bin"   //roll 12!

* = $5900 "Demo Map" 
MAP_DEMO: .import binary "../assets/charpad/galaga_D - Demo (8bpc, 20x13).bin"

* = $7400 "Game Map" 
MAP: .import binary "../assets/charpad/asteroids - screen.bin"

* = $7504 "Game Tiles" 
MAP_TILES: .import binary "../assets/charpad/asteroids - Tiles.bin"
	
* = $7900 "Logo"
LOGO:	.import binary "../assets/charpad/galax_logo.bin"


	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)