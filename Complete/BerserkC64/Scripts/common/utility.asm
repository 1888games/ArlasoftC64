UTILITY: {

	* = * "Utility"

	BankOutKernalAndBasic:{

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta PROCESSOR_PORT
		rts
	}

	BankInKernal: {

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000110
		sta PROCESSOR_PORT
		rts

	}
	

	ClearScreen: {

		ldx #250
		lda #0

		Loop:

			sta SCREEN_RAM - 1, x
			sta SCREEN_RAM + 249, x
			sta SCREEN_RAM + 499, x
			sta SCREEN_RAM + 749, x

			dex
			bne Loop


		rts	


	}
	
	StoreMSBColourX: {

		beq NoMSB

		MSB:

			lda SpriteColor, x
			ora #%10000000
			sta SpriteColor, x
			rts

		NoMSB:

			lda SpriteColor, x
			and #%01111111
			sta SpriteColor, x
			rts
	}

	StoreMSBColourY: {

		beq NoMSB

		MSB:

			lda SpriteColor, y
			ora #%10000000
			sta SpriteColor, y
			rts

		NoMSB:

			lda SpriteColor, y
			and #%01111111
			sta SpriteColor, y
			rts
	}


}