/*  
	$c000 - $c3ff Screen
	$c400 - $cfff 48 sprites
	$d000 - $efff 128 Sprites
	$f000 - $f7ff 1 charset
	$f800 - $fffd 15 sprites
*/
					
.label SCREEN_RAM = $c000
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


 * = $d000 "Sprites" //Start at frame #64

 	SPRITE_DATA:
 		.import binary "../assets/sprites.bin"

* = $8000 "Screen data"

	MAP_TILES:
		.import binary "../assets/tiles.bin"

	CHAR_COLORS:
		.import binary "../assets/snout_orig - CharAttribs.bin"

	MAP:
		.import binary "../assets/map.bin"



	// HUD_DATA:
	// 	.import binary "../../assets/maps/hud.bin"
		
* = $f000 "Charset"
	CHAR_SET:
		.import binary "../assets/snout_orig - Chars.bin"   //roll 12!

