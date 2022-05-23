/*  
	$c000 - $c3ff Screen
	$c400 - $cfff 48 sprites
	$d000 - $efff 128 Sprites
	$f000 - $f7ff 1 charset
	$f800 - $fffd 15 sprites
*/
					
.label SCREEN_RAM = $c000
.label SPRITE_POINTERS = SCREEN_RAM + $3f8



* = $c400 "Sprites" //start at frame #16
 .import binary "../../assets/8bit - sprites.bin"



 * = $7300 "Char Colours"
 CHAR_COLORS: .import binary "../assets/main - CharAttribs.bin"

 * = $7000 "Hud Map"
 HUD_MAP: .import binary "../assets/main - Map (20x12).bin"

 * = $7100 "Hud Tiles"
 MAP_TILES: .import binary "../assets/main - Tiles.bin"


// * = $8700 "Title Colours" 
// .import binary "../assets/merge_title - CharAttribs.bin"

// * = $8400 "Title Map" 
// .import binary "../assets/merge_title - Map (20x12).bin"

// * = $8500 "Title Tiles" 
// .import binary "../assets/merge_title - Tiles.bin"




		
* = $f000 "Charset"
	CHAR_SET:
		.import binary "../assets/main - Chars.bin"   

// * = $f800 "Title Charset"
// 	TITLE_CHAR_SET:
// 		.import binary "../assets/merge_title - Chars.bin"   //roll 12!


 * = $7400 "Map Data"

 Screen_00:		.import binary "../assets/map - SubMap (8bpc, 30x19) [0,0].bin"
 Screen_01:		.import binary "../assets/map - SubMap (8bpc, 30x19) [0,1].bin" 
 Screen_02:		.import binary "../assets/map - SubMap (8bpc, 30x19) [0,2].bin" 
 Screen_03:		.import binary "../assets/map - SubMap (8bpc, 30x19) [0,3].bin" 
 Screen_04:		.import binary "../assets/map - SubMap (8bpc, 30x19) [0,4].bin"

 Screen_05:		.import binary "../assets/map - SubMap (8bpc, 30x19) [1,0].bin"
 Screen_06:		.import binary "../assets/map - SubMap (8bpc, 30x19) [1,1].bin" 
 Screen_07:		.import binary "../assets/map - SubMap (8bpc, 30x19) [1,2].bin" 
 Screen_08:		.import binary "../assets/map - SubMap (8bpc, 30x19) [1,3].bin" 
 Screen_09:		.import binary "../assets/map - SubMap (8bpc, 30x19) [1,4].bin" 

 Screen_10:		.import binary "../assets/map - SubMap (8bpc, 30x19) [2,0].bin"
 Screen_11:		.import binary "../assets/map - SubMap (8bpc, 30x19) [2,1].bin" 
 Screen_12:		.import binary "../assets/map - SubMap (8bpc, 30x19) [2,2].bin" 
 Screen_13:		.import binary "../assets/map - SubMap (8bpc, 30x19) [2,3].bin" 
 Screen_14:		.import binary "../assets/map - SubMap (8bpc, 30x19) [2,4].bin" 

 Screen_15:		.import binary "../assets/map - SubMap (8bpc, 30x19) [3,0].bin"
 Screen_16:		.import binary "../assets/map - SubMap (8bpc, 30x19) [3,1].bin" 
 Screen_17:		.import binary "../assets/map - SubMap (8bpc, 30x19) [3,2].bin" 
 Screen_18:		.import binary "../assets/map - SubMap (8bpc, 30x19) [3,3].bin" 
 Screen_19:		.import binary "../assets/map - SubMap (8bpc, 30x19) [3,4].bin"

 Screen_20:		.import binary "../assets/map - SubMap (8bpc, 30x19) [4,0].bin"
 Screen_21:		.import binary "../assets/map - SubMap (8bpc, 30x19) [4,1].bin" 
 Screen_22:		.import binary "../assets/map - SubMap (8bpc, 30x19) [4,2].bin" 
 Screen_23:		.import binary "../assets/map - SubMap (8bpc, 30x19) [4,3].bin" 
 Screen_24:		.import binary "../assets/map - SubMap (8bpc, 30x19) [4,4].bin" 

 Screen_25:		.import binary "../assets/map - SubMap (8bpc, 30x19) [5,0].bin"
 Screen_26:		.import binary "../assets/map - SubMap (8bpc, 30x19) [5,1].bin" 
 Screen_27:		.import binary "../assets/map - SubMap (8bpc, 30x19) [5,2].bin" 
 Screen_28:		.import binary "../assets/map - SubMap (8bpc, 30x19) [5,3].bin" 
 Screen_29:		.import binary "../assets/map - SubMap (8bpc, 30x19) [5,4].bin" 



	//.pc = sid.location "sid"
	//.fill sid.size, sid.getData(i)

