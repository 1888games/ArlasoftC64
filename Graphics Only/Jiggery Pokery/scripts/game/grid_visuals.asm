GRID_VISUALS: {

		* = $3700 "Grid Visuals" 



	RowLookup:	.fill GRID.TotalSquaresOnGrid, 0 + (floor(i / GRID.Columns) * 3)
				.fill GRID.TotalSquaresOnGrid, 0 + (floor(i / GRID.Columns) * 3)

	ColumnLookup:	.fill GRID.TotalSquaresOnGrid, GRID.PlayerOneStartColumn + (i * 3 - ((floor(i / GRID.Columns) * GRID.Columns) * 3))
					.fill GRID.TotalSquaresOnGrid, GRID.PlayerTwoStartColumn + (i * 3 - ((floor(i / GRID.Columns) * GRID.Columns) * 3))

	.label BackgroundCharID1= 155
	.label BackgroundCharID2 = 0
	.label LastAnimationFrame = 16

	BackgroundCharIDs:	.byte 153, 154
	StartIndex:			.byte 0




	ClearChars: {


		TopLeft:

			lda StartIndex
			eor #%00000001
			sta StartIndex
			tax
			lda BackgroundCharIDs, x

			ldx ZP.Column
			ldy ZP.Row

			jsr DRAW.PlotCharacter

			
			lda #BLACK
			jsr DRAW.ColorCharacter


		CentreRight:

			lda StartIndex
			eor #%00000001
			sta StartIndex
			tax
			lda BackgroundCharIDs, x
			ldy #1

			sta (ZP.ScreenAddress), y

			lda #BLACK
			sta (ZP.ColourAddress), y


		TopRight:

			ldy #2

			lda StartIndex
			eor #%00000001
			sta StartIndex
			tax
			lda BackgroundCharIDs, x
			

			sta (ZP.ScreenAddress), y

			lda #BLACK
			sta (ZP.ColourAddress), y

		MiddleLeft:

			ldy #40

			lda StartIndex
			eor #%00000001
			sta StartIndex
			tax
			lda BackgroundCharIDs, x
			

			sta (ZP.ScreenAddress), y

			lda #BLACK
			sta (ZP.ColourAddress), y

		MiddleCentre:

			ldy #41

			lda StartIndex
			eor #%00000001
			sta StartIndex
			tax
			lda BackgroundCharIDs, x

			sta (ZP.ScreenAddress), y

			lda #BLACK
			sta (ZP.ColourAddress), y


		MiddleRight:


			ldy #42

			
			
			lda StartIndex
			eor #%00000001
			sta StartIndex
			tax
			lda BackgroundCharIDs, x
			

			sta (ZP.ScreenAddress), y

			lda #BLACK
			sta (ZP.ColourAddress), y

		BottomLeft:

			ldy #80

			
			lda StartIndex
			eor #%00000001
			sta StartIndex
			tax
			lda BackgroundCharIDs, x
			
			sta (ZP.ScreenAddress), y

			lda #BLACK
			sta (ZP.ColourAddress), y

		BottomCentre:

			ldy #81

			
			lda StartIndex
			eor #%00000001
			sta StartIndex
			tax
			lda BackgroundCharIDs, x
			

			sta (ZP.ScreenAddress), y

			lda #BLACK
			sta (ZP.ColourAddress), y


		BottomRight:

			ldy #82
			
			lda StartIndex
			eor #%00000001
			sta StartIndex
			tax
			lda BackgroundCharIDs, x
			
			sta (ZP.ScreenAddress), y

			lda #BLACK
			sta (ZP.ColourAddress), y





		rts
	}



	ClearBehindFallingCard: {


		lda ZP.Row
		clc
		adc ZP.Column
		and #%00000001
		sta StartIndex

		jsr ClearChars


		rts
	}


	ClearSquare: {



		lda ColumnLookup, x
		sta ZP.Column
		
		lda RowLookup, x
		sta ZP.Row
		clc
		adc ZP.Column
		and #%00000001
		sta StartIndex

		jsr ClearChars

		

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

			txa
			tay

			sty ZP.Y

			lda DRAW.TopLeft, y
			clc
			adc #DRAW.AmountToAdd
		
			ldx ZP.Column
			ldy ZP.Row
			jsr PLAYER.DrawCharacter
				
		TopCentre:

			ldy ZP.Y
			lda DRAW.TopCentre, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr PLAYER.DrawCharacter

		TopRight:

			ldy ZP.Y
			lda DRAW.TopRight, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr PLAYER.DrawCharacter

			iny
			sty ZP.Row
			ldx ZP.TempX

		MiddleLeft:

			ldy ZP.Y
			lda DRAW.MiddleLeft, y
			clc
			adc #DRAW.AmountToAdd
		
			ldy ZP.Row
			jsr PLAYER.DrawCharacter
				
		Middle:

			ldy ZP.Y
			lda DRAW.Middle, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr PLAYER.DrawCharacter

		MiddleRight:

			ldy ZP.Y
			lda DRAW.MiddleRight, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr PLAYER.DrawCharacter

			iny
			sty ZP.Row
			ldx ZP.TempX
			
		BottomLeft:

			ldy ZP.Y
			lda DRAW.BottomLeft, y
			clc
			adc #DRAW.AmountToAdd
		
			ldy ZP.Row
			jsr PLAYER.DrawCharacter
				
		BottomCentre:

			ldy ZP.Y
			lda DRAW.BottomCentre, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr PLAYER.DrawCharacter

		Bottomight:

			ldy ZP.Y
			lda DRAW.BottomRight, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr PLAYER.DrawCharacter



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