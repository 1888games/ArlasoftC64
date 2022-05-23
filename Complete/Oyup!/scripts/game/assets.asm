
* = $c400 "Sprites" //Start at frame #16
 	.import binary "../../assets/puyo - Sprites.bin"

* = * "Gyspy Sprites"
.import binary "../../assets/gyps - Sprites.bin"

 // * = $8000 "Game Map"
 //MAP: .import binary "../assets/blank - Map (20x13).bin"

 * = $7700 "Assets"

 * = * "Game Colours"
CHAR_COLORS: .import binary "../../assets/puyo - CharAttribs.bin"


 * = * "Game Map"
GAME_MAP: .import binary "../../assets/puyo - SubMap (8bpc, 40x25) [0,0].bin"



 * = * "Tower Map"
TOWER_MAP: .import binary "../../assets/puyo - SubMap (8bpc, 40x25) [1,0].bin"


 * = * "Menu Map"
MENU_MAP: .import binary "../../assets/puyo - SubMap (8bpc, 40x25) [2,0].bin"

 * = * "Settings Map"
SETTINGS_MAP: .import binary "../../assets/puyo - SubMap (8bpc, 40x25) [3,0].bin"

 * = * "Instructions Map"
INSTRUCTIONS_MAP: .import binary "../../assets/puyo - SubMap (8bpc, 40x25) [5,0].bin"

 * = * "Score Map"
SCORE_MAP: .import binary "../../assets/puyo - SubMap (8bpc, 40x25) [6,0].bin"


	
*= $b800
 * = * "Win"
WIN_LEFT: .import binary "../../assets/puyo - MapArea (8bpc, 12x24).bin"

WIN_RIGHT: .import binary "../../assets/puyo - MapArea (8bpc, 12x24)R.bin"


WIN_BOTTOM: .import binary "../../assets/puyo - MapArea (8bpc, 12x12)B.bin"



LOSE: .import binary "../../assets/puyo - MapArea (8bpc, 12x24)_GO.bin"

TWO_PLAYER: .import binary "../../assets/puyo - MapArea (8bpc, 12x12)_2P.bin"


TITLE_1P:	.import binary "../../assets/puyo - MapArea (8bpc, 10x2)_1P.bin"
TITLE_2P:	.import binary "../../assets/puyo - MapArea (8bpc, 10x2)_2P.bin"
TITLE_PR:	.import binary "../../assets/puyo - MapArea (8bpc, 10x2_PR).bin"


* = $f800 "Gypsy Charset"

GYPSY_CHARS:	.import binary "../../assets/gypsy - Chars.bin"

* = $b000 "Gypsy Data"
GYPSY_COLORS:	.import binary "../../assets/gypsy - CharAttribs.bin"
GYPSY_MAP:		.import binary "../../assets/gypsy - Map (40x25).bin"
GYPSY_MORE_EGGS:		.import binary "../../assets/more_eggs.bin"
GYPSY_INSERT:		.import binary "../../assets/insert_coin.bin"

* = $3c58 "Difficulty Map"
DIFF_MAP:		.import binary "../../assets/puyo - MapArea (8bpc, 16x18).bin"
		
* = $f000 "Charset"
CHAR_SET:
		.import binary "../../assets/puyo - Chars.bin"   //roll 12!

* = $ffff "End Of Memory"


.pc = sid.location "sid"
.fill sid.size, sid.getData(i)

* = $6800 "---Sprites Title"
	.import binary "../../assets/puyo - title Sprites.bin"

.const KOALA_TEMPLATE = "C64FILE, Bitmap=$0000, ScreenRam=$1f40, ColorRam=$2328, BackgroundColor = $2710"
.var picture = LoadBinary("../../assets/title.kla", KOALA_TEMPLATE)

*=$6000 "Bitmap Screen RAM" ;            			.fill picture.getScreenRamSize(), picture.getScreenRam(i)
*=$6400 "Bitmap Color RAM";	  						.fill picture.getColorRamSize(), picture.getColorRam(i)
*=$4000 "Bitmap Data"  ;         		 			.fill picture.getBitmapSize(), picture.getBitmap(i)
* = $6400 "Bitmap Color Data"




BitmapColor:

* = $C000 "Screen Ram"

.fill 1000, 0 

