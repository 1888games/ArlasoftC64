LIVES: {


	
	* = * "Lives"

	.label Lives = 3
	.label FlashTime = 16
	

	FlashTimer:	.byte FlashTime
	FlashState:	.byte 1

	LabelRows:	.byte 6, 10

	Left:		.byte 3
	Active:		.byte 0
	GameOver:	.byte 0



	NewGame: {

		lda #Lives
		sta Left
		
		lda #1
		sta FlashState

		lda #0
		sta GameOver
		sta SPEECH.IsChicken

		jsr Draw


		rts

	}



	Decrease: {


		
		lda #0
		sta SPEECH.IsChicken

		LoseLife:

		//ldx STAGE.CurrentPlayer
			dec Left
			lda Left

			beq GameOver2

			jsr Draw
			rts

		GameOver2:

			lda #0
			sta Left

			inc GameOver

		Finish:
	
		rts
	}

	Add: {

		ldx #0
		lda Left, x
		cmp #12
		bcs CantAdd

		clc
		adc #1
		sta Left, x

		jsr Draw

		CantAdd:

		rts

	}



	Draw: {

		ldx #35
		ldy #14
		jsr PLOT.GetCharacter

		lda Left
		sta ZP.Amount
		dec ZP.Amount
	
		ldy #0

		Loop:

			lda #9
			cpy ZP.Amount

			bcc DrawMan

			lda #0

		DrawMan:

			sta (ZP.ScreenAddress), y

			lda #GREEN
			sta (ZP.ColourAddress), y

			iny
			cpy #4
			bcc Loop




		rts
	}


	

	

	FrameUpdate: {

		
		

		rts
	}



}