QUEUE: {





	NextPieceID:		.byte 0, 0
	QueuePieceID:		.byte 0, 0
	NextPieceColour:	.byte 0, 0
	QueuePieceColour:	.byte 0, 0


	Queue:				.fill 32, 0

	QueuePosition:		.byte 255


	ColumnLookup:		.byte 2, 10
	PlayerOffset:		.byte 0, 24

	Colours:		.byte RED, GREEN, BLUE, YELLOW

	.label SOLID_BLOCK = 61

	NewGame: {


		lda #255
		sta QueuePosition
		sta NextPieceID
		sta NextPieceID + 1
		sta QueuePieceID + 1
		sta QueuePieceID

		jsr FillInitialQueue
		jsr DrawQueue

		rts

	}



	FillInitialQueue: {


		GetRandomPieces:

			jsr RANDOM.Get
			and #%00011111
			sta NextPieceID
		
			jsr RANDOM.Get
			and #%00011111
			sta QueuePieceID
		
			jsr RANDOM.Get
			and #%00000011
			sta NextPieceColour
		
			jsr RANDOM.Get
			and #%00000011
			sta QueuePieceColour
		
			lda PLAYER.TwoPlayer
			beq SinglePlayer	

		TwoPlayer:

			lda NextPieceID 
			sta NextPieceID + 1

			lda QueuePieceID
			sta QueuePieceID + 1

			lda NextPieceColour
			sta NextPieceColour + 1

			lda QueuePieceColour
			sta QueuePieceColour + 1 

		SinglePlayer:



		rts
	}




	DrawPiece: {


			jsr PIECE_DATA.GetData

			lda ZP.StartX
			sta ZP.Column

			lda ZP.StartY
			sta ZP.Row

			ldy #0
			sty ZP.Y
			sty ZP.ColumnID
			sty ZP.RowID

		SquareLoop:

			ldy ZP.Y

			lda (ZP.PieceAddress), y
			beq NextColumn


			DrawSquare:

				ldx ZP.Column
				ldy ZP.Row

				lda #SOLID_BLOCK

				jsr PLOT.PlotCharacter

				lda ZP.Colour

				jsr PLOT.ColorCharacter

			NextColumn:

				inc ZP.Y
				inc ZP.Column

				lda ZP.ColumnID
				clc
				adc #1
				sta ZP.ColumnID

				cmp ZP.Size
				bcc ContinueColumn

			NextRow:

				lda #0
				sta ZP.ColumnID

				lda ZP.StartX
				sta ZP.Column

				inc ZP.Row

				lda ZP.RowID
				clc
				adc #1
				sta ZP.RowID
				cmp ZP.Size
				bcs Exit

			ContinueColumn:

				jmp SquareLoop




			Exit:




		rts
	}



	DrawQueue: {

		ldx #0

		Loop:

			stx ZP.PlayerID

			lda NextPieceColour, x
			tay
			lda Colours, y
			sta ZP.Colour

			lda NextPieceID, x
			sta ZP.PieceID

			lda ColumnLookup
			clc
			adc PlayerOffset, x
			sta ZP.StartX

			lda #0
			sta ZP.StartY

			jsr DrawPiece


			ldx ZP.PlayerID

			lda QueuePieceColour, x
			tay
			lda Colours, y
			sta ZP.Colour

			lda QueuePieceID, x
			sta ZP.PieceID

			lda ColumnLookup + 1
			clc
			adc PlayerOffset, x
			sta ZP.StartX

			lda #0
			sta ZP.StartY

			jsr DrawPiece


			ldx ZP.PlayerID
			cpx PLAYER.TwoPlayer
			beq Done

			inx
			jmp Loop

		Done:

			



		rts
	}



}