GRID: {


	.label Rows = 16
	.label Columns = 8
	.label CellsPerSide = Rows * Columns
	.label TotalCells = Cells * 2


	PlayerOne:		.fill Rows * Columns, 255
	PlayerTwo:		.fill Rows * Columns, 255


	CurrentPlayer:	.byte 0

	PlayerStartID:	.byte 0, CellsPerSide




	NewLevel: {

		jsr Clear





		rts
	}

	Clear: {


		ldx #0
		lda #255

		Loop:

			sta PlayerOne, x

			inx
			cpx #TotalCells
			bcc Loop



		rts
	}


}