

 	* = $d000 "SPRITES" //Start at frame #16
 	.import binary "../../Assets/spritepad/pacman - Sprites.bin"



* = $f800 "CHARSET"



CHAR_SET:	.import binary "../Assets/charpad/pacman - Chars.bin"   
		

* = $B000 "----------"
* = * "Title" 
TITLE_MAP:	.import binary "../Assets/charpad/pacman - title.bin"   


* = * "PushStart" 
START_MAP:	.import binary "../Assets/charpad/pacman - start.bin"   



* = $b600 "-----------" 
* = * "MAP DATA" 
* = * "-Game Colours" 

CHAR_COLORS: .import binary "../Assets/charpad/pacman - CharAttribs_L1.bin"
	


* = $7000 "SFX"
		.import binary "../Assets/sfx/ener2.prg"

	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)
