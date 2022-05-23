/*  
	$c000 - $c3ff Screen
	$c400 - $cfff 48 sprites
	$d000 - $efff 128 Sprites
	$f000 - $f7ff 1 charset
	$f800 - $fffd 15 sprites
*/
					
.label SCREEN_RAM = $c000
.label SPRITE_POINTERS = SCREEN_RAM + $3f8

* = musicList.get(0).location "Title Music"
  .fill musicList.get(0).size, musicList.get(0).getData(i)

  * = musicList.get(1).location "StartGame"
  .fill musicList.get(1).size, musicList.get(1).getData(i)

  * = musicList.get(2).location "GameOver"
  .fill musicList.get(2).size, musicList.get(2).getData(i)

    * = musicList.get(3).location "LoseLife"
  .fill musicList.get(3).size, musicList.get(3).getData(i)


 * = $d000 "Sprites" //Start at frame #64

 	SPRITES:
 		.import binary "../assets/sprites.bin"


 * = $8000 "Title data"

	TITLE_TILES:
		.import binary "../assets/Title/caveTitleBitmap - Tiles.bin"
	TITLE_COLORS:
		.import binary "../assets/Title/caveTitleBitmap - CharAttribs.bin"

	TITLE_MAP:
		.import binary "../assets/Title/caveTitleBitmap - Map (20x12).bin"

 * = $7500 "Instructions data"

	INS_TILES:
		.import binary "../assets/Title/caveIns - Tiles.bin"

	INS_MAP:
		.import binary "../assets/Title/caveIns - Map (20x12).bin"

* = $8500 "Screen data"

	MAP_TILES:
		.import binary "../assets/tiles.bin"

	CHAR_COLORS:
		.import binary "../assets/colours.bin"

	MAP:
		.import binary "../assets/map.bin"

	// HUD_DATA:
	// 	.import binary "../../assets/maps/hud.bin"
		
* = $f000 "Charset"
	CHAR_SET:
		.import binary "../assets/char.bin"   //roll 12!


* = $f800 "~TitleChars"
	TITLE_SET:
		.import binary "../assets/Title/caveTitleBitmap - Chars.bin"   //roll 12!




