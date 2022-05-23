

 	* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/robotron_2 - sprites.bin"



* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/robotron - Chars.bin"   //roll 12!

//* = $3000 "SFX"
	//	.import binary "../assets/fff.prg"

* = $9000 "Game Map" 
MAP: .import binary "../assets/robotron - MapArea (8bpc, 20x13).bin"

* = $9104 "Game Tiles" 
MAP_TILES: .import binary "../assets/robotron - Tiles.bin"

* = $9300 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/robotron - CharAttribs.bin"


* = $9400 "Full Map" 
FULL: .import binary "../assets/robotron - flash (8bpc, 20x13).bin"

* = $9504 "Title Map" 
TITLE_MAP: .import binary "../assets/robotron - Title (8bpc, 20x13).bin"

* = $4000 "SFX"
.import binary "../assets/robof4-2.prg"

	



	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)