

 	* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/taz - sprites.bin"



* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/taz - Chars.bin"   //roll 12!

* = $3000 "SFX"
		.import binary "../assets/tas.prg"

* = $7000 "Game Map" 
MAP: .import binary "../assets/taz - Map (20x13).bin"

* = $7104 "Game Tiles" 
MAP_TILES: .import binary "../assets/taz - Tiles.bin"

* = $7300 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/taz - CharAttribs.bin"

* = $7500 "Title Map" 
TITLE_MAP: .import binary "../assets/taz_title - Map (20x13).bin"

* = $7604 "Title Tiles" 
TITLE_MAP_TILES: .import binary "../assets/taz_title - Tiles.bin"

 * = $7800 "Title Colours" 
	TITLE_CHAR_COLORS: .import binary "../assets/taz_title - CharAttribs.bin"




	



	//.pc = sid.location "sid"
	//.fill sid.size, sid.getData(i)