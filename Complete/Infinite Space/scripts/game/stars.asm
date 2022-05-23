STARS: {


	.label MAX_STARS = 16

	Columns:	.fill MAX_STARS, 255
	Rows:		.fill MAX_STARS, 255
	StartID:	.byte 0, MAX_STARS/2


	FrameTimer:		.byte 0

	.label FrameTime = 1





	FrameUpdate: {

		
		inc FrameTimer

		lda FrameTimer
		and #%00000001
		tax
		lda StartID, x
		tax

		clc
		adc #MAX_STARS/2
		sta EndID

		Loop:

			stx StoredXReg

			CheckIfOffScreen:

				lda Columns, x
				bmi NewStar

			DeleteStar:

				lda Rows, x
				tay

				lda Columns, x
				tax

				lda #0
				jsr PLOT.PlotStar
				jmp MoveStar
		
			NewStar:

				jsr RANDOM.Get
				beq EndLoop
				cmp #24
				bcs EndLoop
				
				sta Rows, x

				lda #39
				sta Columns, x
				jmp DrawStar

			MoveStar:

				ldx StoredXReg
				dec Columns, x

			DrawStar:

				lda Columns, x
				bmi EndLoop

				lda Rows, x
				tay

				lda Columns, x
				tax

				lda #1
				jsr PLOT.PlotStar


			EndLoop:	

				ldx StoredXReg
				inx
				cpx EndID
				bcc Loop

		Finish:


		rts


	}


}