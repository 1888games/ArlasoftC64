

 	* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/fast - sprites.bin"



* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/fast - Chars.bin"   //roll 12!

* = $3000 "SFX"
		.import binary "../assets/fff.prg"

* = $7000 "Game Map" 
MAP: .import binary "../assets/fast - Map (20x13).bin"

* = $7104 "Game Tiles" 
MAP_TILES: .import binary "../assets/fast - Tiles.bin"

* = $7300 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/fast - CharAttribs.bin"



	



	//.pc = sid.location "sid"
	//.fill sid.size, sid.getData(i)