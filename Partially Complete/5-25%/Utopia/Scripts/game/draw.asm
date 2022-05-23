DRAW: {

	GoldBarInhibit:			.byte 0
	DisplayScores:			.byte 0
	SinkingAnimationFrame:	.byte 0
	SinkingOffset:			.byte 0
	DisplaySinkingAnim:		.byte 0
	SinkingCounter:			.byte 0

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