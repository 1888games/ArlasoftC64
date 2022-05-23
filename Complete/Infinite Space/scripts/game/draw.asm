DRAW: {



	.label BlankCharacterID = 0

	ClearScreen: {

		lda #BlankCharacterID
		ldx #0

		Loop:

			sta SCREEN_RAM + 0, x
			sta SCREEN_RAM + 250, x
			sta SCREEN_RAM + 500, x
			sta SCREEN_RAM + 750, x

			inx
			cpx #250
			beq Finish
			jmp Loop


		Finish:

		rts
	}




	

}