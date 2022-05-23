BLOCK: {


	Values:		.byte 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0



	SquareType:	.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0


	Rows:		.fill 14, 0
				.fill 14, 2
				.fill 14, 4
				.fill 14, 6
				.fill 14, 8
				.fill 14, 10
				.fill 14, 12
				.fill 14, 14
				.fill 14, 16
				.fill 14, 18
				.fill 14, 20
				.fill 14, 22

	Columns:	.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
				.byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26



	RowStart:	.byte 0, 14, 28, 42, 56, 70, 84, 98, 112, 126, 140, 154, 168

	Colours:	.byte 0, 9, 10, 13, 15, 14, 12


	// Up = 1, Left = 2, Up & Left = 4


	TopLeft:	.byte 8, 12


	BlockGroups:	.byte 2
					.fill 1023, 0

	GroupStart:	.fill 32, i * 32




	NewGame:{

		ldx #0
		stx CurrentID

		jsr DrawBlock

		jsr MoveDown

		rts
	}






	MoveDown: {

		ldx #0
		stx CurrentID

		jsr DeleteBlock

		ldx CurrentID

		lda Values, x
		pha

		lda #0
		sta Values, x

		txa
		clc
		adc #14
		sta CurrentID
		tax

		pla
		sta Values, x

		jsr DrawBlock

		rts

	}


	MoveBlocks: {







	}



	DrawBlock: {

		ldx CurrentID

		lda Rows, x
		tay

		lda Values, x
		tax
		lda Colours, x
		sta Colour

		ldx CurrentID
		lda Columns, x
		tax

		lda #8
		sta CharID

		
		jsr PLOT.PlotCharacter

		lda Colour
		jsr PLOT.ColorCharacter

		inc CharID
		lda CharID
		inx
		jsr PLOT.PlotCharacter

		lda Colour
		jsr PLOT.ColorCharacter

		inc CharID
		lda CharID
		dex
		iny
		jsr PLOT.PlotCharacter

		lda Colour
		jsr PLOT.ColorCharacter

		inc CharID
		lda CharID
		inx
		jsr PLOT.PlotCharacter

		lda Colour
		jsr PLOT.ColorCharacter



		rts



	}


	DeleteBlock: {

		ldx CurrentID

		lda Rows, x
		tay

		lda SquareType, x
		sta CharID

		lda Columns, x
		tax

		
		lda CharID
		jsr PLOT.PlotCharacter

		lda #3
		jsr PLOT.ColorCharacter

		lda CharID
		inx
		jsr PLOT.PlotCharacter

		lda #3
		jsr PLOT.ColorCharacter

		lda CharID
		dex
		iny
		jsr PLOT.PlotCharacter

		lda #3
		jsr PLOT.ColorCharacter

		lda CharID
		inx
		jsr PLOT.PlotCharacter

		lda #3
		jsr PLOT.ColorCharacter



		rts
	}



}