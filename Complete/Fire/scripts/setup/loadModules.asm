//*=$7000 "Import"

.if (target == 264) {
	*=$4000 "Code"
}

.if (target == "VIC") {

	*=$3600"Code"
}

#import "setup/macros.asm"
#import "setup/maploader.asm"
#import "setup/titleloader.asm"
#import "lookups/charData.asm"
#import "lookups/soundData.asm"
#import "lookups/levelData.asm"
#import "interrupts/charDrawing.asm"
#import "lookups/petData.asm"


// #import "setup/sound.asm"

 #import "interrupts/score.asm"
 #import "interrupts/lives.asm"

 .if (target == 264) {
	//*=$055F "Code"
}


  .if (target == 264) {
// "Code"
}



#import "interrupts/men.asm"
#import "interrupts/fire.asm"
#import "interrupts/jumpers.asm"