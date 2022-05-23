STARS: {


	.label MAX_STARS = 48

	Columns:	.fill MAX_STARS, random() * 25
	Rows:		.fill MAX_STARS, random() * 25
	//StartIDs:	.byte 0, 16, 32, 48, 64
	StartIDs:	.byte 0, 24
	//StartIDs:	.byte 0, 8, 16, 24, 32, 40, 48, 56
	CharIDs:	.fill 64, 33 + floor(i/8)
	FlashTimer:	.fill MAX_STARS, random() * 6
	On:			.fill MAX_STARS, random() * 1
	Colours:	.fill MAX_STARS, 1 + random() * 6

	CharPositions:	.fill 8, i
	CharMemory:		.fillword 8, (CHAR_SET + 264) + (i * 8)


	FrameTimer:		.byte 0
	StartID:		.byte 0

	.label FlashTime = 6

	.label BlankCharacterID = 32




	FrameUpdate: {

		SetDebugBorder(4)

		inc FrameTimer

		lda FrameTimer
		and #%00000001
		tax
		lda StartIDs, x
		sta StartID
		tax

		clc
		adc #MAX_STARS/2
		sta EndID	

		Loop:

			stx StoredXReg

			CheckIfOffScreen:

				lda Rows, x
				cmp #25
				bcs NewStar

			DeleteStar:

				lda On, x
				beq MoveStar

				lda Rows, x
				sta Row

				lda Columns, x
				tax

				lda #BlankCharacterID
				sta CharID

				jsr PLOT.PlotStar
				ldx StoredXReg
				jmp MoveStar
		
			NewStar:


				jsr RANDOM.Get
				beq EndLoop
				cmp #26
				bcs EndLoop
				
				sta Columns, x

				lda #0
				sta Rows, x

			MoveStar:

				lda FlashTimer, x
				beq ReadyToFlash

				dec FlashTimer, x
				jmp NoFlash

				ReadyToFlash:

					lda #FlashTime
					sta FlashTimer, x

					lda On, x
					eor #255
					sta On, x

				NoFlash:

					inc CharIDs, x
					//inc CharIDs, x
					lda CharIDs, x
					cmp #41
					bcc DrawStar

					lda #33
					sta CharIDs, x
					inc Rows, x
					
			DrawStar:

				lda On, x
				beq EndLoop

				lda Columns, x
				bmi EndLoop

				lda Rows, x
				sta Row

				lda CharIDs, x
				sta CharID

				lda Colours, x
				sta Colour

				lda Columns, x
				tax

				jsr PLOT.PlotStar

			EndLoop:	

				ldx StoredXReg
				inx
				cpx EndID
				bcs Finish
				jmp Loop

		Finish:

		rts


	}




}