
* = $ca00 "Sprites" //Start at frame #16
 	.import binary "../../assets/spritepad/berserk - sprites.bin"







* = $5308 "Game Colours" 
	CHAR_COLORS: .import binary "../assets/charpad/berserk - CharAttribs_L1.bin"


* = $D800 "Charset"

	CHAR_SET:
		.import binary "../assets/charpad/berserk - Chars.bin"   //roll 12!

	//* = $b000 "SFX"
		//.import binary "../assets/goattracker/berserk.prg"


* = $5000 "Title Map" 
TITLE_DEMO: .import binary "../assets/charpad/berserk - Title (8bpc, 20x13).bin"

* = $5104 "Game Map" 
MAP: .import binary "../assets/charpad/berserk - Map16.bin"

* = $5208 "Game Tiles" 
MAP_TILES: .import binary "../assets/charpad/berserk - Tiles.bin"

	//.pc = sid.location "sid"
	//.fill sid.size, sid.getData(i)