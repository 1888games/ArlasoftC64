GRID_VISUALS: {

		* = * "Grid Visuals" 



	RowLookup:	.fill GRID.TotalSquaresOnGrid, 1 + (floor(i / GRID.Columns) * 2)
				.fill GRID.TotalSquaresOnGrid, 1 + (floor(i / GRID.Columns) * 2)

	ColumnLookup:	.fill GRID.TotalSquaresOnGrid, GRID.PlayerOneStartColumn + (i * 2 - ((floor(i / GRID.Columns) * GRID.Columns) * 2))
					.fill GRID.TotalSquaresOnGrid, GRID.PlayerTwoStartColumn + (i * 2 - ((floor(i / GRID.Columns) * GRID.Columns) * 2))

	.label BackgroundCharID = 202
	.label LastAnimationFrame = 16

	ClearSquare: {

		lda RowLookup, x
		sta ZP.Row

		lda ColumnLookup, x
		sta ZP.Column

		TopLeft:

			lda #BackgroundCharID
			sta ZP.CharID

			ldx ZP.Column
			ldy ZP.Row

			jsr DRAW.PlotCharacter

			lda #GREEN

			jsr DRAW.ColorCharacter


		TopRight:

			ldy #1

			inc ZP.CharID
			lda ZP.CharID

			sta (ZP.ScreenAddress), y

			lda #PURPLE
			sta (ZP.ColourAddress), y

		BottomLeft:

			ldy #40

			inc ZP.CharID
			lda ZP.CharID

			sta (ZP.ScreenAddress), y

			lda #YELLOW
			sta (ZP.ColourAddress), y


		BottomRight:


			ldy #41

			inc ZP.CharID
			lda ZP.CharID

			sta (ZP.ScreenAddress), y

			lda #CYAN
			sta (ZP.ColourAddress), y


		

		rts
	}


	DrawBean: {

		stx ZP.TempX

		lda ZP.BeanColour
		cmp #WHITE
		bne NotRock

		lda #16
		sta GRID.CurrentType, x

		NotRock:

		lda GRID.CurrentType, x
		cmp GRID.PreviousType, x
		bne NeedsUpdate

		jmp Finish
		
		NeedsUpdate:

			lda RowLookup, x
			sta ZP.Row

			lda ColumnLookup, x
			sta ZP.Column

		TopLeft:

				lda GRID.CurrentType, x
				sta GRID.PreviousType, x
				tay

				lda BEAN.Chars, y
				clc
				adc #3
				sta ZP.CharID

			TimeToDraw:

				ldx ZP.Column
				ldy ZP.Row

				jsr DRAW.PlotCharacter

				lda ZP.BeanColour
				jsr PLAYER.ConvertColour
				clc
				adc #8

				jsr DRAW.ColorCharacter

		TopRight:

			ldy #1

			dec ZP.CharID
			lda ZP.CharID

			sta (ZP.ScreenAddress), y

			lda ZP.BeanColour
			jsr PLAYER.ConvertColour
			clc
			adc #8
			sta (ZP.ColourAddress), y


		BottomRight:

			ldy #41

			dec ZP.CharID
			lda ZP.CharID

			sta (ZP.ScreenAddress), y

			lda ZP.BeanColour
			jsr PLAYER.ConvertColour
			clc
			adc #8
			sta (ZP.ColourAddress), y


		BottomLeft:

			ldy #40

			dec ZP.CharID
			lda ZP.CharID

			sta (ZP.ScreenAddress), y

			lda ZP.BeanColour
			jsr PLAYER.ConvertColour
			clc
			adc #8
			sta (ZP.ColourAddress), y



		ldx ZP.TempX
		lda GRID.CurrentType, x
		cmp #16
		bne Finish

		lda ZP.SolidBelow
		bne Finish

		lda #32
		sta GRID.PreviousType, x


		Finish:



		rts
	}

	UpdateAnimation: {

		ldx GRID.CurrentSide
		inc GRID.NumberMoving, x

		dey
		sty ZP.BeanType

		cpy #LastAnimationFrame
		beq Reset

		cpy #GRID.BeanFallingType
		beq Exploded

		rts

		Exploded:

			ldx ZP.CurrentSlot

			lda #0
			sta GRID.PlayerOne, x

			lda #255
			sta GRID.PreviousType, x

			jsr ClearSquare

			rts

		Reset:	

			ldx ZP.CurrentSlot
			lda #0
			sta ZP.BeanType

			ldy GRID.CurrentSide
			lda PLAYER.Status, y
			cmp #PLAYER.PLAYER_STATUS_PLACED
			bne Okay

			lda #PLAYER.PLAYER_STATUS_WAIT
			sta PLAYER.Status, y


		Okay:



		rts
	}


}