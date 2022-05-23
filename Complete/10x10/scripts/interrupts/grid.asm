GRID: {



	Rows: .byte 3, 5, 7, 9, 11, 13, 15, 17, 19, 21
	Cols: .byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18

	//Rows: .byte 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23
	//Cols: .byte 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22

	.label GridSize = 10



	ClearingRow:	 		.fill GridSize, 0
	ClearingRowProgress:	.fill GridSize, 0

	ClearingColumn:	 		.fill GridSize, 0
	ClearingColumnProgress:	.fill GridSize, 0

	
	ClearCooldown: .byte 0, 1
	CurrentPieceIsValid:	.byte 0
	InvalidColour:	.byte 1
	CurrentInvalid:	.byte 0

	NeedToCheckComplete:	.byte 0
	NeedToPlacePiece:		.byte 0
	BlankColour:	.byte 11

	ClearedByLastMove:	.byte 0

	ClearingBonuses:	.byte 0, 10, 30, 60, 100, 150, 210, 245, 245, 245, 245, 245, 245, 245, 245, 245, 245

	CheckingRow:	.byte 99
	CheckingCol:	.byte 99
	FoundPlaceForFinalPiece:	.byte 0

	CheckingPiece:	.byte 99



	Reset: {


		lda #99
		sta CheckingCol
		sta CheckingRow
		sta CheckingPiece

		lda #0
		sta NeedToPlacePiece
		sta NeedToCheckComplete
		sta CurrentPieceIsValid

		ldx #0

		Loop:

			sta ClearingColumn, x
			sta ClearingRow, x
			sta ClearingColumnProgress, x
			sta ClearingRowProgress, x

			inx
			cpx #GridSize
			beq Finish
			jmp Loop

		Finish:


		jsr ClearAllRows

		//jsr Debug


		rts
	}


	Update: {

		lda MAIN.GameActive
		beq Finish

		lda CheckingPiece

		cmp #99
		beq NotCheckingPieces

	
		jsr CheckPieceAgainstAllPositions

		lda MAIN.GameIsOver
		bne Finish

		NotCheckingPieces:

			jsr CheckClearing
			jsr CheckPieceIsValid

			lda NeedToPlacePiece
			beq NotPlacing

			jsr PlacePiece
			lda #0
			sta NeedToPlacePiece
			jmp Finish

		NotPlacing:


			lda NeedToCheckComplete
			beq Finish


			lda #0
			sta NeedToCheckComplete
			sta ClearedByLastMove

			jsr CheckRowsCompleted
			jsr CheckColumnsCompleted

			ldx ClearedByLastMove
			beq Finish

			lda ClearingBonuses, x
			jsr SCORE.ScorePoints


		Finish:

		
		rts


	}


	ActivateGameOverCheck: {

		lda #2
		sta CheckingPiece

		lda #0
		sta CheckingCol
		sta CheckingRow



		rts
	}


	CheckPieceAgainstAllPositions: {



		tax
		lda SELECTION.Pieces, x
		cmp #99

		beq CheckIfLastPiece

		tax
		jsr PIECE.SelectNewPiece


		jsr CheckFinalPiece

		ldx SELECTION.SelectedPiece
		cpx #99
		beq NothingSelected

		lda SELECTION.Pieces, x
		tax

		jsr PIECE.SelectNewPiece
		jmp FinishPiece

		NothingSelected:

			lda #99
			sta PIECE.SelectedPieceID

			jmp FinishPiece

		CheckIfLastPiece:

			lda CheckingPiece
			bne NextPiece

			jsr MAIN.GameOver
			jmp FinishPiece


		NextPiece:

			dec CheckingPiece

		FinishPiece:


		rts
	}


	CheckRowsCompleted: {

		ldy #0	

		RowLoop:



			ldx #0

			sty CurrentRow

			ColumnLoop:

				ldy CurrentRow
				stx CurrentCol

				lda Rows, y
				tay

				lda Cols, x
				tax

				jsr PLOT.GetColor

				cmp BlankColour
				beq EndRowLoop


				ldx CurrentCol
				inx 
				cpx #GridSize
				beq RowFull
				jmp ColumnLoop

				
				RowFull:

					ldy CurrentRow
					lda #1
					sta ClearingRow, y
					lda #0
					sta ClearingRowProgress, y

					inc ClearedByLastMove

			EndRowLoop:

				ldy CurrentRow
				iny
				cpy #GridSize
				beq Finish
				jmp RowLoop


		Finish:

	//	dec $d020

		rts
	}


	CheckColumnsCompleted: {

		ldx #0	

		ColumnLoop:

			ldy #0

			stx CurrentCol

			RowLoop:

				ldx CurrentCol
				sty CurrentRow

				lda Rows, y
				tay

				lda Cols, x
				tax

				jsr PLOT.GetColor

				cmp BlankColour
				beq EndColLoop


				ldy CurrentRow
				iny
				cpy #GridSize
				beq ColumnFull
				jmp RowLoop

				
				ColumnFull:

					ldx CurrentCol
					lda #1
					sta ClearingColumn, x
					lda #0
					sta ClearingColumnProgress, x

					inc ClearedByLastMove


			EndColLoop:

				ldx CurrentCol
				inx
				cpx #GridSize
				beq Finish
				jmp ColumnLoop


		Finish:

	//	dec $d020

		rts
	}


	PlacePiece: {

		lda PIECE.SelectedPieceID
		cmp #99
		beq NoPlace

		lda CurrentPieceIsValid
		beq NoPlace

		ldy #0

		Loop:

			sty CharByteID


			lda VIC.SPRITE_0_X + 2
			sec
			sbc #24
			lsr
			lsr
			lsr

			clc
			adc (PIECE_DATA_ADDRESS), y
			adc (PIECE_DATA_ADDRESS), y
			tax

			iny
			sty CharByteID

			lda MOUSE.MouseFireY
			clc
			adc (PIECE_DATA_ADDRESS), y
			adc (PIECE_DATA_ADDRESS), y

			tay

			lda PIECE.SpriteColour

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

			lda PIECE.NumberOfChars
			lsr
			jsr SCORE.ScorePoints

			lda #1
			sta NeedToCheckComplete
			
			dec SELECTION.PiecesLeft

			lda #0	
			sta VIC.SPRITE_0_X + 2
			sta VIC.SPRITE_0_X + 4
			sta VIC.SPRITE_0_X + 6
			sta VIC.SPRITE_0_X + 8
			sta VIC.SPRITE_0_X + 10
			sta VIC.SPRITE_0_X + 12


			lda #99

			ldx SELECTION.SelectedPiece
			sta SELECTION.Pieces, x
			sta SELECTION.SelectedPiece
			sta PIECE.SelectedPieceID

			jsr SELECTION.CheckNewPieces

			sfx(2)

			

			//jmpsr PIECE.SelectRandomPiece


		NoPlace:



		rts

	}




	CheckFinalPiece: {

		ldy #0

		Loop:

			sty CharByteID

			ldx CheckingCol
			lda Cols, x
			adc (PIECE_DATA_ADDRESS), y
			adc (PIECE_DATA_ADDRESS), y
			tax

			cpx #20
			bcs InvalidCell

			iny
			sty CharByteID

			ldy CheckingRow
			lda Rows, y
			ldy CharByteID
			clc
			adc (PIECE_DATA_ADDRESS), y
			adc (PIECE_DATA_ADDRESS), y

			tay

			cpy #23
			bcs InvalidCell


			jsr PLOT.GetColor

			cmp BlankColour
			beq CellIsEmpty

			InvalidCell:

				inc CheckingCol
				lda CheckingCol
				cmp #GridSize
				bne Finish

				//.break

				inc CheckingRow
				lda CheckingRow
				cmp #GridSize
				beq CheckIfFinalPiece

				jmp NextRow

				CheckIfFinalPiece:

				//	.break

					lda CheckingPiece
					bne GameNotOver

					jsr MAIN.GameOver
					jmp Finish

					GameNotOver:

					dec CheckingPiece

					lda #0
					sta CheckingRow

				NextRow:

					lda #0
					sta CheckingCol

					jmp Finish


			CellIsEmpty:

				ldy CharByteID

				iny
				cpy PIECE.NumberOfChars
				beq FoundValidPlace
				jmp Loop


		FoundValidPlace:

			//lda CheckingCol
			//jsr SCORE.Hardcode

			//lda CheckingRow
			//jsr SCORE.SetBest

			//lda CheckingPiece

			lda #99
			sta CheckingPiece


		Finish:

			rts
	}


	
	CheckPieceIsValid: {

	

		lda PIECE.SelectedPieceID
		cmp #99
		beq NoColour

		lda PIECE.SpriteColour
		sta CurrentInvalid



		lda MOUSE.MouseFireX
		cmp #20
		bcs NotInGrid

		lda MOUSE.MouseFireY
		cmp #3
		bcc NotInGrid

		lda InvalidColour
		sta CurrentInvalid

		ldy #0


		lda #1
		sta CurrentPieceIsValid

		Loop:

			sty CharByteID

			lda VIC.SPRITE_0_X + 2
			sec
			sbc #24
			lsr
			lsr
			lsr
			clc
			adc (PIECE_DATA_ADDRESS), y
			adc (PIECE_DATA_ADDRESS), y
			tax

			cpx #20
			bcs InvalidCell


			iny
			sty CharByteID

			lda MOUSE.MouseFireY
			clc
			adc (PIECE_DATA_ADDRESS), y
			adc (PIECE_DATA_ADDRESS), y

			tay

			cpy #3
			bcc InvalidCell

			cpy #23
			bcs InvalidCell



			jsr PLOT.GetColor

			cmp BlankColour
			beq CellIsEmpty

			InvalidCell:

				lda #0
				sta CurrentPieceIsValid
				jmp Finish

			CellIsEmpty:

				ldy CharByteID

				iny
				cpy PIECE.NumberOfChars
				beq Finish
				jmp Loop


		NotInGrid:

			nop


		Finish:


		NoColour:

		rts
	}




	CheckClearing: {

		lda ClearCooldown
		beq OkayToClear

		dec ClearCooldown
		jmp Finish

		OkayToClear:

			lda ClearCooldown + 1
			sta ClearCooldown

			ldx #0

		
		Loop:

			stx RowColID
			
			CheckRows:

				lda ClearingRow, x
				beq CheckColumns

				jsr ClearRow

				ldx RowColID

			CheckColumns:

				lda ClearingColumn, x
				beq EndLoop

				jsr ClearColumn

				ldx RowColID

			EndLoop:

				inx
				cpx #GridSize
				beq Finish
				jmp Loop

		Finish:


			rts
	}

	ClearAllRows:{

		ldx #0
		lda #1

		Loop:

			sta ClearingRow, x

			inx
			//cpx #2
			cpx #GridSize
			beq Finish
			jmp Loop

		Finish:

			lda ClearCooldown + 1
			sta ClearCooldown


			rts
	}



	SetClearRow: {


		lda #1
		sta ClearingRow, x

		rts
	}



	ClearColumn: {

		stx ColID

		lda ClearingColumnProgress, x
		sta RowID

		ldy RowID
		lda Rows, y
		tay

		ldx ColID
		lda Cols, x
		tax

		jsr ClearBlock
	

		ldx ColID

		inc ClearingColumnProgress, x
		lda ClearingColumnProgress, x
		cmp #GridSize

		bne Finish

		lda #0
		sta ClearingColumn, x


		sfx(3)

		Finish:



		rts
	}


	

	ClearRow: {


		stx RowID

		lda ClearingRowProgress, x
		sta ColID

		ldy RowID
		lda Rows, y
		tay

		ldx ColID
		lda Cols, x
		tax

		jsr ClearBlock
	

		ldx RowID

		inc ClearingRowProgress, x
		//inc ClearingRowProgress, x
		lda ClearingRowProgress, x
		//cmp #8
		cmp #GridSize

		bne Finish

		lda #0
		sta ClearingRow, x

		sfx(5)



		Finish:



		rts

	}

	ClearBlock: {

		lda BlankColour


		jsr PLOT.ColorCharacterOnly
		
		inx


		jsr PLOT.ColorCharacterOnly
		
		dex
		iny

		jsr PLOT.ColorCharacterOnly

		inx

		jsr PLOT.ColorCharacterOnly

		rts

	}




	Debug: {


		lda BlankColour
		ldx #0
		sta VIC.COLOR_RAM + 120, x
		sta VIC.COLOR_RAM + 121, x
		sta VIC.COLOR_RAM + 122, x
		sta VIC.COLOR_RAM + 123, x
		sta VIC.COLOR_RAM + 124, x
		sta VIC.COLOR_RAM + 125, x
		sta VIC.COLOR_RAM + 126, x
		sta VIC.COLOR_RAM + 127, x
		sta VIC.COLOR_RAM + 128, x
		sta VIC.COLOR_RAM + 129, x
		sta VIC.COLOR_RAM + 130, x
		sta VIC.COLOR_RAM + 131, x
		sta VIC.COLOR_RAM + 132, x
		sta VIC.COLOR_RAM + 133, x
		sta VIC.COLOR_RAM + 134, x
		sta VIC.COLOR_RAM + 135, x
		sta VIC.COLOR_RAM + 136, x
		sta VIC.COLOR_RAM + 137, x
		sta VIC.COLOR_RAM + 138, x
		sta VIC.COLOR_RAM + 139, x

		ldx #0

		sta VIC.COLOR_RAM + 160, x
		sta VIC.COLOR_RAM + 200, x
		sta VIC.COLOR_RAM + 240, x
		sta VIC.COLOR_RAM + 280, x
		sta VIC.COLOR_RAM + 320, x
		sta VIC.COLOR_RAM + 360, x
		sta VIC.COLOR_RAM + 400, x
		sta VIC.COLOR_RAM + 440, x
		sta VIC.COLOR_RAM + 480, x
		sta VIC.COLOR_RAM + 520, x
		sta VIC.COLOR_RAM + 560, x
		sta VIC.COLOR_RAM + 600, x
		sta VIC.COLOR_RAM + 640, x
		sta VIC.COLOR_RAM + 680, x
		sta VIC.COLOR_RAM + 720, x
		sta VIC.COLOR_RAM + 760, x
		sta VIC.COLOR_RAM + 800, x


		ldx #18

		sta VIC.COLOR_RAM + 160, x
		sta VIC.COLOR_RAM + 200, x
		sta VIC.COLOR_RAM + 240, x
		sta VIC.COLOR_RAM + 280, x
		sta VIC.COLOR_RAM + 320, x
		sta VIC.COLOR_RAM + 360, x
		sta VIC.COLOR_RAM + 400, x
		sta VIC.COLOR_RAM + 440, x
		sta VIC.COLOR_RAM + 480, x
		sta VIC.COLOR_RAM + 520, x
		sta VIC.COLOR_RAM + 560, x
		sta VIC.COLOR_RAM + 600, x
		sta VIC.COLOR_RAM + 640, x
		sta VIC.COLOR_RAM + 680, x
		sta VIC.COLOR_RAM + 720, x
		sta VIC.COLOR_RAM + 760, x
		sta VIC.COLOR_RAM + 800, x

		
		
		ldx #0
		sta VIC.COLOR_RAM + 840, x
		sta VIC.COLOR_RAM + 841, x
		sta VIC.COLOR_RAM + 842, x
		sta VIC.COLOR_RAM + 843, x
		sta VIC.COLOR_RAM + 844, x
		sta VIC.COLOR_RAM + 845, x
		sta VIC.COLOR_RAM + 846, x
		sta VIC.COLOR_RAM + 847, x
		sta VIC.COLOR_RAM + 848, x
		sta VIC.COLOR_RAM + 849, x
		sta VIC.COLOR_RAM + 850, x
		sta VIC.COLOR_RAM + 851, x
		sta VIC.COLOR_RAM + 852, x
		sta VIC.COLOR_RAM + 853, x
		sta VIC.COLOR_RAM + 854, x
		sta VIC.COLOR_RAM + 855, x
		sta VIC.COLOR_RAM + 856, x
		sta VIC.COLOR_RAM + 857, x
		sta VIC.COLOR_RAM + 858, x
		sta VIC.COLOR_RAM + 859, x

		
		// sta VIC.COLOR_RAM + 840, x
		// sta VIC.COLOR_RAM + 841, x
		// sta VIC.COLOR_RAM + 842, x
		// sta VIC.COLOR_RAM + 843, x
		// sta VIC.COLOR_RAM + 844, x
		// sta VIC.COLOR_RAM + 845, x
		// sta VIC.COLOR_RAM + 846, x
		// sta VIC.COLOR_RAM + 847, x
		// sta VIC.COLOR_RAM + 848, x
		// sta VIC.COLOR_RAM + 849, x
		// sta VIC.COLOR_RAM + 850, x
		// sta VIC.COLOR_RAM + 851, x
		// sta VIC.COLOR_RAM + 852, x
		// sta VIC.COLOR_RAM + 853, x
		// sta VIC.COLOR_RAM + 854, x
		// sta VIC.COLOR_RAM + 855, x
		// sta VIC.COLOR_RAM + 856, x
		// sta VIC.COLOR_RAM + 857, x
		// sta VIC.COLOR_RAM + 858, x
		// sta VIC.COLOR_RAM + 859, x

		


		rts
	}


}