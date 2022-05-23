SELECTION:{
	


	TopLeftX:	.byte 21, 25, 29
	TopLeftY:	.byte 0, 7, 14


	Pieces:		.byte 99, 99, 99


	SelectedPiece:	.byte 99

	PiecesLeft:		.byte 0


	Reset: {

		lda #99
		sta SelectedPiece
		sta Pieces
		sta Pieces + 1
		sta Pieces + 2

		lda #0
		sta PiecesLeft

		jsr GenerateNewPieces


		rts
	}


	CheckNewPieces: {

	 	jsr GRID.ActivateGameOverCheck

		lda PiecesLeft
		bne CheckOneLeft

		jsr GenerateNewPieces
		jmp Finish

		CheckOneLeft:


	

		lda PiecesLeft

		cmp #1
		bne Finish

		ldx #0
		lda Pieces, x
		cmp #99
		beq TryTwo

		tay
		jmp GrabLastPiece

		TryTwo:

		inx
		lda Pieces, x
		cmp #99
		beq DoThree

		tay
		jmp GrabLastPiece

		DoThree:

		ldx #2
		lda Pieces, x
		tay


		GrabLastPiece:

			lda #0
			sta GRID.CheckingCol
			sta GRID.CheckingRow

			jsr SelectPiece

		Finish:


			rts
	}

	GenerateNewPieces: {


		ldy #0

		Loop:

			sty SelectedPiece

			jsr RANDOM.Get
			and #%00111111

			tax

			lda PIECE_DATA.Frequency, x
			tax

			sta Pieces, y

			jsr PIECE.SelectNewPiece

			lda #99
			sta PIECE.SelectedPieceID

			ldy SelectedPiece
			ldx PIECE.SpriteColour

			jsr DrawPiece

			ldy SelectedPiece

			iny
			cpy #3
			beq Finish
			jmp Loop

		Finish:
			
			lda #99
			sta SelectedPiece

			lda #3
			sta PiecesLeft

			jsr GRID.ActivateGameOverCheck


		sfx(0)

		rts


	}


	SelectPiece:{

		stx SelectedPiece

		tya
		tax

		jsr PIECE.SelectNewPiece

		ldx MAIN.ScreenColour
		ldy SelectedPiece

		jsr DrawPiece


		rts
	}


  	DeselectPiece: {

  		 ldx SelectedPiece
  		 cpx #99

  		 beq Finish

  		 lda Pieces, x
  		 tax
  		 jsr PIECE.SelectNewPiece

  		 ldx PIECE.SpriteColour
  		 ldy SelectedPiece

  		 jsr DrawPiece


  		Finish:

  			rts


  	}



	DrawPiece: {


		stx CurrentColour

		lda Pieces, y
		
		lda TopLeftY, y
		sta RowID

		lda TopLeftX, y
		sta ColID

		ldy #0

		Loop:

			sty CharByteID

			lda ColID

			clc
			adc (PIECE_DATA_ADDRESS), y
			adc (PIECE_DATA_ADDRESS), y
			tax

			iny
			sty CharByteID

			lda RowID
			clc
			adc (PIECE_DATA_ADDRESS), y
			adc (PIECE_DATA_ADDRESS), y

			tay

			lda CurrentColour

			jsr PLOT.ColorCharacterOnly

			inx

			jsr PLOT.ColorCharacterOnly

			dex
			iny

			jsr PLOT.ColorCharacterOnly

			inx

			jsr PLOT.ColorCharacterOnly

			ldy CharByteID

			iny
			cpy PIECE.NumberOfChars
			bcs Finish
			jmp Loop

		Finish:


		rts

	}


}