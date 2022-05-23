.var sid = LoadSid("../assets/goattracker/cold_outside.sid")

MAIN: {

	#import "data/zeropage.asm"

	BasicUpstart2(Entry)

	*=$880 "Modules"


	Entry: {

		lda #0
		jsr sid.init

	Loop:

		lda $d012
		cmp #220
		bne Loop

		jsr sid.play

		jmp Loop



	}


}
	.pc = sid.location "sid"
	.fill sid.size, sid.getData(i)