/*  
	$c000 - $c3ff Screen
	$c400 - $cfff 48 sprites
	$d000 - $efff 128 Sprites
	$f000 - $f7ff 1 charset
	$f800 - $fffd 15 sprites
*/
					




* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/utopia - Sprites.bin"


* = $8000 "Game Map"
MAP: .import binary "../assets/utopia - MapArea (8bpc, 20x13).bin"

* = $8105 "Game Colours"
CHAR_COLORS: .import binary "../assets/utopia - CharAttribs.bin"

* = $8200 "Game Tiles"
MAP_TILES: .import binary "../assets/utopia - Tiles.bin"


* = $8400 "Menu Map"
MENU_MAP: .import binary "../assets/utopia - Menu MapArea (8bpc, 20x13).bin"
		
* = $f000 "Charset"
	CHAR_SET:
		.import binary "../assets/utopia - Chars.bin"   //roll 12!




	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)

