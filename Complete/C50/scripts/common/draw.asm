DRAW: {

	* = * "-Draw"

	.label BlankCharacterID = 32



	ClearScreen: {

		lda #BlankCharacterID
		ldx #250

		Loop:

			sta SCREEN_RAM - 1, x
			sta SCREEN_RAM + 249, x
			sta SCREEN_RAM + 499, x
			sta SCREEN_RAM + 749, x

			dex
			bne Loop

		lda #1

		Loop2:

			sta VIC.COLOR_RAM - 1, x
			sta VIC.COLOR_RAM + 249, x
			sta VIC.COLOR_RAM + 499, x
			sta VIC.COLOR_RAM + 749, x

			dex
			bne Loop2

		Finish:

		rts
	}

	



	

}