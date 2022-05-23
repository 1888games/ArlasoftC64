LAUNCHER: {



	Height:			.byte 0, 0
	Rising: 		.byte 0, 0
	FrameTimer:		.byte 0, 0
	StartColumn:	.byte 0, 0

	TopChars:		.byte 100, 99, 101
	MiddleChars:	.byte 0, 239, 0
	BottomChars:	.byte 0, 71, 0


	HeightLookup:	.word Height0, Height1, Height2, Height3, Height4


	Height0:		.byte 0, 0, 0
					.byte 0, 0, 0
					.byte 0, 0, 0
					.byte 0, 0, 0

	Height1:		.byte 0, 0, 0
					.byte 0, 0, 0
					.byte 0, 0, 0
					.byte 100, 99, 101

	Height2:		.byte 0, 0, 0
					.byte 0, 0, 0
					.byte 100, 99, 101
					.byte 0, 239, 0

	Height3:		.byte 0, 0, 0			
					.byte 100, 99, 101
					.byte 0, 239, 0
					.byte 0, 71, 0

	Height4:		.byte 100, 99, 101
					.byte 0, 239, 0
					.byte 0, 71, 0
					.byte 0, 71, 0




	.label FrameTime = 0

	.label StartRow = 21




	Start: {

		lda #1
		sta Height, x
		sta Rising, x

		lda PLAYER.SelectedColumn, x
		clc
		adc PLAYER.SelectedColumn, x
		clc
		adc PLAYER.SelectedColumn, x
		clc
		adc PLAYER.StartColumn, x
		sta StartColumn, x

		jsr Draw

		rts
	}

	Draw: {	

		lda Height, x
		asl
		tay

		lda HeightLookup, y
		sta GetChar + 1

		lda HeightLookup + 1, y
		sta GetChar +2

		lda StartColumn, x
		tax

		ldy #StartRow
		jsr PLOT.GetCharacter

		ldx #0
		ldy #255

		RowLoop:	

			jsr DrawChar
			jsr DrawChar
			jsr DrawChar

		EndLoop:	

				tya
				clc
				adc #37
				tay

				cpx #11
				bcc RowLoop

				

		ldx ZP.Player




		rts
	}

	DrawChar: {

		iny

		jsr GetChar
		sta (ZP.ScreenAddress), y
		cmp #0
		beq Cyan

		lda #YELLOW_MULT
		sta (ZP.ColourAddress), y
		rts

		Cyan:

		lda #CYAN
		sta (ZP.ColourAddress), y
		rts

	}


	GetChar: {

		lda $BEEF, x
		inx
		rts
	}


	FrameUpdate: {

		ldx #0

		Loop:

			stx ZP.Player

			lda Height, x
			beq Finish

			lda FrameTimer, x
			beq Ready

			dec FrameTimer, x
			rts

			Ready:

			lda #FrameTime
			sta FrameTimer, x

			lda Rising, x
			beq Falling

			GoingUp:

				inc Height, x
				lda Height, x
				cmp #5
				bcs CompleteUp

				jsr Draw
				jmp EndLoop

			CompleteUp:

				dec Rising, x
				dec Height, x
				dec Height, x

				jsr Draw

			Falling:

				dec Height, x
				lda Height, x
				beq CompleteDown

				jsr Draw
				jmp EndLoop

			CompleteDown:

				jsr Draw


	
			EndLoop:

			inx
			cpx #2
			bcc Loop




		Finish:


		rts
	}
}