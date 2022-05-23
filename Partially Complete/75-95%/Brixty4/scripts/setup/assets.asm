/*  
	$c000 - $c3ff Screen
	$c400 - $cfff 48 sprites
	$d000 - $efff 128 Sprites
	$f000 - $f7ff 1 charset
	$f800 - $fffd 15 sprites
*/
					
.label SCREEN_RAM = $c000
.label SPRITE_POINTERS = SCREEN_RAM + $3f8




* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/sprites.bin"


* = $8000 "Screen data"

	MAP_TILES:
		.import binary "../assets/tiles.bin"

	CHAR_COLORS:
		.import binary "../assets/colours.bin"

	MAP:
		.import binary "../assets/map.bin"

	// HUD_DATA:
	//	.import binary "../../assets/maps/hud.bin"
		
* = $f000 "Charset"
	CHAR_SET:
		.import binary "../assets/char.bin"   //roll 12!

