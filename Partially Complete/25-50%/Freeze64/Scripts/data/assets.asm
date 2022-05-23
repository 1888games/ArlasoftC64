

 	* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/freeze - sprites.bin"



* = $f000 "Charset"

	CHAR_SET:
		.import binary "../assets/freeze - Chars.bin"   //roll 12!

//* = $3000 "SFX"
	//	.import binary "../assets/fff.prg"

* = $7000 "Game Map" 
MAP: .import binary "../assets/freeze - map (20x13).bin"

* = $7104 "Game Tiles" 
MAP_TILES: .import binary "../assets/freeze - Tiles.bin"

* = $7300 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/freeze - CharAttribs.bin"


* = $7500 "Full Map" 
FULL: .import binary "../assets/full - map.bin"

* = $7700 "Title Map" 
TMAP: .import binary "../assets/title - map.bin"

	



	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)