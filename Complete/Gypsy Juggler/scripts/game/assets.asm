
* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/puyo - Sprites.bin"

* = * "Gyspy Sprites"
.import binary "../../assets/gyps - Sprites.bin"


* = $f800 "Gypsy Charset"

GYPSY_CHARS:	.import binary "../../assets/gypsy - Chars.bin"

* = $b000 "Gypsy Data"
GYPSY_COLORS:	.import binary "../../assets/gypsy - CharAttribs.bin"
GYPSY_MAP:		.import binary "../../assets/gypsy - Map (40x25).bin"
GYPSY_MORE_EGGS:		.import binary "../../assets/more_eggs.bin"
GYPSY_INSERT:		.import binary "../../assets/insert_coin.bin"


* = $ffff "End Of Memory"

.pc = sid.location "sid"
.fill sid.size, sid.getData(i)

* = $6800 "---Sprites Title"
* = $C000 "Screen Ram"

.fill 1000, 0 

