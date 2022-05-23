

 	* = $d000 "SPRITES" //Start at frame #16
 	.import binary "../../assets/spritepad/pacman - sprites.bin"



* = $f800 "CHARSET"



CHAR_SET:	.import binary "../assets/charpad/pacman - Chars.bin"   
		

* = $B000 "----------"
* = * "Title" 
TITLE_MAP:	.import binary "../assets/charpad/pacman - title.bin"   


* = * "PushStart" 
START_MAP:	.import binary "../assets/charpad/pacman - start.bin"   



* = $b600 "-----------" 
* = * "MAP DATA" 
* = * "-Game Colours" 

CHAR_COLORS: .import binary "../assets/charpad/pacman - CharAttribs_L1.bin"
	


* = $7000 "SFX"
		.import binary "../assets/sfx/ener2.prg"

	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)