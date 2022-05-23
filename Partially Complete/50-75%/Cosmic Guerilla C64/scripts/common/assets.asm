
.label SCREEN_RAM = $c000
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/sprites.bin"

  * = $8000 "Game Map"
 MAP: .import binary "../assets/cosmic - Map (20x13).bin"

 * = * "Game Colours"
 CHAR_COLORS: .import binary "../assets/cosmic - CharAttribs.bin"


 * = * "Game Tiles"
MAP_TILES: .import binary "../assets/cosmic - Tiles.bin"

		
* = $f000 "Charset"
CHAR_SET:
		.import binary "../assets/cosmic - Chars.bin"   //roll 12!

.pc = sid.location "sid"
.fill sid.size, sid.getData(i)

