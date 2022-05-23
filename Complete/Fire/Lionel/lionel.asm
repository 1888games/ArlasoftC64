

.if (target =="264") {
	*=$5100 "Lionel"
}

.if(target == "C64") {

	*=$1400 "Lionel"
}

.if(target == "VIC") {

	*=$2400 "Lionel"
}

.if(target == "PET") {

	*=$1000 "Lionel"
}
.label ZERO= 0
.label ALL_ON = 255
.label ONE=1

LIONEL:{

 #import "basicUpstart.asm"
 #import "video.asm"
 #import "sound.asm" 
 #import "random.asm"
 #import "c64.asm"
 #import "vic20.asm"
 #import "plus4.asm"
 #import "input.asm"
 #import "pet.asm"



	Initialise: {

		jsr VIDEO.Initialise
		jsr SOUND.Initialise
		jsr RANDOM.Initialise
		jsr INPUT.Initialise
		jsr SOUND.Initialise

		rts

	}

}