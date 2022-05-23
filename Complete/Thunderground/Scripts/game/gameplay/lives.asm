LIVES: {


	* = * "Lives"

	Left:		.byte 0


	.label MaxLives = 6
	.label Pointer = 25


	XPos:	.byte 89, 89, 57, 25
	Pointers:	.byte 32, 25, 25, 25

	.label YPos = LEVEL.TickY

	Initialise: {

		lda #6
		sta Left


		rts
	}

	Add: {

		lda Left
		cmp #MaxLives
		bcs Finish

		inc Left

		lda Left
		cmp #5
		bcs Finish

		Finish:

			rts
	}


	Lose: {

		dec Left
		lda Left
		bne Okay

		lda #1
		sta PLAYER.GameOver


		Okay:


		rts
	}

	UpdateSprites: {

		ldx #0
		ldy #0

		Loop:

			cpx Left
			bcc DrawIt


			HideIt:

				lda #0
				sta VIC.SPRITE_1_Y, y

				jmp EndLoop

			DrawIt:

				lda #0
				sta ZP.Amount

				lda XPos, x
				clc
				adc LEVEL.CompletePixelAdd
				sta VIC.SPRITE_1_X, y

				lda ZP.Amount
				adc #0
				sta ZP.Amount
				beq NoMSB

				MSB:

					lda VIC.SPRITE_MSB
					ora VIC.MSB_On + 1, x
					sta VIC.SPRITE_MSB
					jmp DoneMSB

				NoMSB:

					lda VIC.SPRITE_MSB
					and VIC.MSB_Off + 1, x
					sta VIC.SPRITE_MSB

				DoneMSB:


				lda #YPos
				sta VIC.SPRITE_1_Y, y

				lda Pointers, x
				sta SPRITE_POINTERS + 1, x

				lda PLAYER.Colour
				sta VIC.SPRITE_COLOR_1, x

			EndLoop:

				inx
				iny
				iny
				cpx #4
				bcc Loop



		rts
	}






}