
.label SCREEN_RAM = $c000
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/spaceShip - sprites.bin"

 * = $8200 "Game Colours"
 CHAR_COLORS: .import binary "../assets/space - CharAttribs.bin"

 * = $8000 "Game Map"
 MAP: .import binary "../assets/space - Map (20x13).bin"

 * = $8105 "Game Tiles"
 MAP_TILES: .import binary "../assets/space - Tiles.bin"


		
* = $f000 "Charset"
	CHAR_SET:
		.import binary "../assets/space - Chars.bin"   //roll 12!

	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)

