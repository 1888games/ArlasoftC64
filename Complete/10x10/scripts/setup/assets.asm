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


* = $8200 "Game Colours"


	CHAR_COLORS:
		.import binary "../assets/colours.bin"

* = $8000 "Game Map"

	MAP:
		.import binary "../assets/map.bin"

* = $8100 "Game Tiles"

	MAP_TILES:
		.import binary "../assets/tiles.bin"

* = $8600 "Title Colours"

		.import binary "../assets/title - CharAttribs.bin"

* = $8300 "Title Map"

		.import binary "../assets/title - Map (20x12).bin"

* = $8400 "Title Tiles"


		.import binary "../assets/title - Tiles.bin"



		
* = $f000 "Charset"
	CHAR_SET:
		.import binary "../assets/char.bin"   //roll 12!

* = $f800 "Title Charset"
	TITLE_CHAR_SET:
		.import binary "../assets/title - Chars.bin"   //roll 12!


	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)

