GAME: {


	.label SetStart = 200
	.label BlankStartID = SetStart + 5

	.label GridStartRow = 0
	.label GridStartColumn = 3

	.label ChanceOfATree = 60
	.label RightEdge = SetStart + 13

	.label NumberStart = SetStart + 16
	.label BottomCorner = SetStart + 15
	.label BottomEdge = SetStart + 14

	.label SpritePointer = 56

	* = * "GAME"


	CharIDLookup:	.byte 5 + SetStart, 9 + SetStart, 1 + SetStart
	ColourLookup:	.byte GREEN + 8, GREEN + 8, RED + 8

	CreateGrid: {

		lda #SpritePointer
		sta SPRITE_POINTERS
		
		jsr DrawScore
		jsr DrawLevel


		lda #$99
		sta ZP.ScoreThisRound

		ldy #171
		sty VIC.SPRITE_ENABLE
		sty ZP.ScoreCounter


		lda #BLACK
		sta VIC.BORDER_COLOR
		sta ZP.SelectedCell
		sta ZP.SelectedRow
		sta ZP.SelectedColumn
		sta ZP.CurrentRow
		sta ZP.CurrentColumn


		Loop:		

			sta ZP.Grid - 1, y
			dey
			bne Loop


		CreateLoop:

			sty ZP.Y
		
			lda ZP.Grid, y
			beq IsBlank

			jmp NextCell


			IsBlank:

				jsr RANDOM.Get
				cmp #ChanceOfATree
				bcc PlaceTree

				jmp NextCell

			PlaceTree:

				lda #0
				sta ZP.Amount

			FindTentPos:

				lda ZP.Amount
				cmp #12
				bcc OkayError

				jmp NextCell


				OkayError:	

					inc ZP.Amount
			
					jsr RANDOM.Get
					and #%00000011
					bne NotLeft

					jmp TryLeft

				NotLeft:

					cmp #1
					beq TryRight

					cmp #2
					beq TryUp

				TryDown:

					ldx ZP.CurrentRow
					inx
					cpx ZP.GridSize
					beq FindTentPos

					tya
					clc
					adc ZP.GridSize
					sta ZP.CurrentID
					tay

					lda ZP.Grid, y
					pha

					ldy ZP.Y

					pla
					cmp #0
					bne FindTentPos

					ldy ZP.CurrentID

					lda #WILL_BE_TENT
					sta ZP.Grid, y

					ldy ZP.Y

					ldx ZP.CurrentRow
					inx
					inc ZP.RowCounts, x

					ldx ZP.CurrentColumn
					inc ZP.ColumnCounts, x
					jmp Confirm

				TryUp:

					ldx ZP.CurrentRow
					beq FindTentPos
				
					tya
					sec
					sbc ZP.GridSize
					sta ZP.CurrentID
					tay

					lda ZP.Grid, y
					pha

					ldy ZP.Y

					pla
					cmp #0
					bne FindTentPos

					ldy ZP.CurrentID

					lda #WILL_BE_TENT
					sta ZP.Grid, y

					ldy ZP.Y

					ldx ZP.CurrentRow
					dex
					inc ZP.RowCounts, x

					ldx ZP.CurrentColumn
					inc ZP.ColumnCounts, x
					jmp Confirm



				TryRight:

					ldx ZP.CurrentColumn
					inx
					cpx ZP.GridSize
					bne OkayRight

					jmp FindTentPos


					OkayRight:

					iny
					lda ZP.Grid, y
					dey
					cmp #0
					beq TentOK

					jmp FindTentPos


					TentOK:

					iny
					lda #WILL_BE_TENT
					sta ZP.Grid, y
					dey

					ldx ZP.CurrentColumn
					inx
					inc ZP.ColumnCounts, x

					ldx ZP.CurrentRow
					inc ZP.RowCounts, x

					jmp Confirm

				TryLeft:

					lda ZP.CurrentColumn
					bne TentOK3

					jmp FindTentPos


					TentOK3:

					dey
					lda ZP.Grid, y
					iny
					cmp #0
					beq TentOK2
					
					jmp FindTentPos

					TentOK2:

					dey
					lda #WILL_BE_TENT
					sta ZP.Grid, y
					iny

					ldx ZP.CurrentColumn
					dex
					inc ZP.ColumnCounts, x

					ldx ZP.CurrentRow
					inc ZP.RowCounts,  x


			Confirm:	

				ldy ZP.Y
				lda #TREE
				sta ZP.Grid, y


			NextCell:

				ldy ZP.Y
				iny
				inc ZP.CurrentColumn
				lda ZP.CurrentColumn
				cmp ZP.GridSize
				bcc Okay

				lda #0
				sta ZP.CurrentColumn
				inc ZP.CurrentRow

				lda ZP.CurrentRow
				cmp ZP.GridSize
				bcs Done

				Okay:

				jmp CreateLoop


			Done:


			jsr DrawGrid
			jsr DrawEdges


		CalculateSpritePos:


		lda ZP.StartRow
		asl
		asl
		asl
		clc
		adc #51
		sta ZP.PointerPositionY
		sta VIC.SPRITE_0_Y

		lda #((GridStartColumn * 8 ) + 25)
		sta ZP.PointerPositionX
		sta VIC.SPRITE_0_X	


		rts
	}



	GetStartScreenPosition: {


		lda #11
		sec
		sbc ZP.GridSize
		sta ZP.StartRow
		tax

		lda #<SCREEN_RAM + (40 * GridStartRow) + GridStartColumn
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + (40 * GridStartRow) + GridStartColumn
		sta ZP.ScreenAddress + 1

		lda #<VIC.COLOR_RAM + (40 * GridStartRow) + GridStartColumn
		sta ZP.ColourAddress

		lda #>VIC.COLOR_RAM  + (40 * GridStartRow) + GridStartColumn
		sta ZP.ColourAddress + 1


		MoveDown:

			cpx #0
			beq NoMore
			jsr MoveDownRow
			dex
			bne MoveDown


		NoMore:

		rts
	}

	DrawGrid: {

		jsr GetStartScreenPosition

		ldx #22
		lda #0

		ClearLoop:

			sta ZP.YourRowCounts - 1, x
			dex
			bne ClearLoop

		ldx #0
		stx ZP.CurrentColumn
		stx ZP.CurrentRow

		ldy #0
		sty ZP.LevelNotComplete

		Loop:	

			stx ZP.X

			lda ZP.Grid, x
			cmp #3
			bne NotTempTent

			lda #0
			sta ZP.Grid, x

			NotTempTent:

			cmp #2
			bcc NotTent

			ldx ZP.CurrentRow
			inc ZP.YourRowCounts, x

			ldx ZP.CurrentColumn
			inc ZP.YourColumnCounts, x

			NotTent:

			tax
			lda ColourLookup, x
			sta ZP.Colour

			lda CharIDLookup, x
			sta ZP.CurrentID

			
			TopLeft:

				sta (ZP.ScreenAddress), y

				lda ZP.Colour
				sta (ZP.ColourAddress), y
				

			TopRight:

				inc ZP.CurrentID
				lda ZP.CurrentID
				iny
				sta (ZP.ScreenAddress), y

				lda ZP.Colour
				sta (ZP.ColourAddress), y


			BottomLeft:

				tya
				pha
				clc
				adc #39
				tay

				inc ZP.CurrentID
				lda ZP.CurrentID
				
				sta (ZP.ScreenAddress), y

				lda ZP.Colour
				sta (ZP.ColourAddress), y

			BottomRight:

				inc ZP.CurrentID
				lda ZP.CurrentID
				iny
				sta (ZP.ScreenAddress), y

				lda ZP.Colour
				sta (ZP.ColourAddress), y

				pla
				tay
				iny

			EndLoop:

				ldx ZP.X
				inx

				inc ZP.CurrentColumn
				lda ZP.CurrentColumn
				cmp ZP.GridSize
				bcc NextColumn

			NextRow:

				lda #0
				sta ZP.CurrentColumn
				ldy #0

				inc ZP.CurrentRow
				lda ZP.CurrentRow
				cmp ZP.GridSize
				beq Done

				jsr MoveDownRow
				jsr MoveDownRow

			NextColumn:

				jmp Loop


		Done:
		

		rts
	}



	DrawEdges: {

		jsr GetStartScreenPosition

		lda ZP.GridSize
		asl
		clc
		adc ZP.ScreenAddress
		sta ZP.ScreenAddress

		bcc NoWrap

		inc ZP.ScreenAddress + 1

		NoWrap:

		lda ZP.GridSize
		asl
		clc
		adc ZP.ColourAddress
		sta ZP.ColourAddress

		bcc NoWrap2

		inc ZP.ColourAddress + 1

		NoWrap2:


		ldx #0
		stx ZP.LevelNotComplete

		Loop:

			lda #RightEdge
			ldy #0
			sta (ZP.ScreenAddress), y

			ldy #40
			sta (ZP.ScreenAddress), y

			lda #BLACK + 8
			sta (ZP.ColourAddress), y

			ldy #0
			sta (ZP.ColourAddress), y

			lda ZP.RowCounts, x
			cmp ZP.YourRowCounts, x
			beq Ready

			lda #RED
			sta ZP.Colour
			sta ZP.LevelNotComplete
			jmp GetNumCharID
			
			Ready:

			lda #GREEN 
			sta ZP.Colour

			GetNumCharID:

				lda ZP.RowCounts, x
				asl
				asl
				clc
				adc #NumberStart
				sta ZP.Amount

			TopLeft:

				iny
				sta (ZP.ScreenAddress), y

				lda ZP.Colour
				sta (ZP.ColourAddress), y

			TopRight:

				iny
				inc ZP.Amount
				lda ZP.Amount
				sta (ZP.ScreenAddress), y
					
				lda ZP.Colour
				sta (ZP.ColourAddress), y

			BottomLeft:

				ldy #41
				inc ZP.Amount
				lda ZP.Amount
				sta (ZP.ScreenAddress), y

				lda ZP.Colour
				sta (ZP.ColourAddress), y

			BottomRight:
	
				iny
				inc ZP.Amount
				lda ZP.Amount
				sta (ZP.ScreenAddress), y

				lda ZP.Colour
				sta (ZP.ColourAddress), y


			jsr MoveDownRow
			jsr MoveDownRow

			inx
			cpx ZP.GridSize
			bcc Loop



		jsr DrawBottomEdge




		rts
	}



	Controls: {

		beq Left

		cmp #RIGHT
		beq Right

		cmp #DOWN
		beq Down

		cmp #FIRE
		beq Fire

		Up:

			lda ZP.SelectedRow
			bne Okay

			jmp Draw

			Okay:

			dec ZP.SelectedRow

			lda ZP.SelectedCell
			sec
			sbc ZP.GridSize
			sta ZP.SelectedCell
			
			lda ZP.PointerPositionY
			sec
			sbc #16
			sta ZP.PointerPositionY
			jmp Draw


		Down:

			ldx ZP.SelectedRow
			inx
			cpx ZP.GridSize
			bcs Draw
		
			inc ZP.SelectedRow

			lda ZP.SelectedCell
			clc
			adc ZP.GridSize
			sta ZP.SelectedCell

			lda ZP.PointerPositionY
			clc
			adc #16
			sta ZP.PointerPositionY
			jmp Draw


		Left:

			lda ZP.SelectedColumn
			beq Draw

			dec ZP.SelectedColumn
			dec ZP.SelectedCell

			lda ZP.PointerPositionX
			sec
			sbc #16
			sta ZP.PointerPositionX
			jmp Draw


		Right:

			ldx ZP.SelectedColumn
			inx
			cpx ZP.GridSize
			bcs Draw

			inc ZP.SelectedColumn
			inc ZP.SelectedCell

			lda ZP.PointerPositionX
			clc
			adc #16
			sta ZP.PointerPositionX
			jmp Draw

		Draw:

		

		lda ZP.PointerPositionX
		sta VIC.SPRITE_0_X

		lda ZP.PointerPositionY
		sta VIC.SPRITE_0_Y

		lda #15
		sta ZP.Cooldown
		

		rts


		Fire:

		
			lda #15
			sta $d418


			ldx ZP.SelectedCell
			lda ZP.Grid, x
			beq AddTent

			cmp #TREE
			beq Draw


			RemoveTent:

			lda #EMPTY
			sta ZP.Grid, x
			jmp Update


			AddTent:

			LeftCheck:

				ldy ZP.SelectedColumn
				beq RightCheck

				dex
				lda ZP.Grid, x
				inx
				cmp #TREE
				beq CanPlace

			RightCheck:

				iny
				cpy ZP.GridSize
				beq UpCheck

				inx
				lda ZP.Grid, x
				dex
				cmp #TREE
				beq CanPlace

			UpCheck:

				ldy ZP.SelectedRow
				beq DownCheck

				txa
				stx ZP.EndID
				sec
				sbc ZP.GridSize
				tax

				lda ZP.Grid, x
				ldx ZP.EndID
				cmp #TREE
				beq CanPlace

			DownCheck:

				iny
				cpy ZP.GridSize
				beq Update

				txa
				stx ZP.EndID
				clc
				adc ZP.GridSize
				tax

				lda ZP.Grid, x
				ldx ZP.EndID
				cmp #TREE
				bne Update

				
			CanPlace:

			lda #TENT
			sta ZP.Grid, x


			Update:

				jsr DrawGrid
				jsr DrawEdges

		jmp Draw


	
	}


	DrawBottomEdge: {	

		ldy #0
		lda #BottomCorner
		sta (ZP.ScreenAddress), y

 		lda #BLACK + 8
 		sta (ZP.ColourAddress), y

 		lda ZP.GridSize
 		asl
 		sta ZP.Amount

 		lda ZP.ScreenAddress
 		sec
 		sbc ZP.Amount
 		sta ZP.ScreenAddress

 		bcs NoWrap

 		dec ZP.ScreenAddress - 1

 		NoWrap:


 		lda ZP.GridSize
 		asl
 		sta ZP.Amount

 		lda ZP.ColourAddress
 		sec
 		sbc ZP.Amount
 		sta ZP.ColourAddress

 		bcs NoWrap2

 		dec ZP.ColourAddress - 1
 		
 		NoWrap2:

 		ldx #0
 		ldy #0

 		Loop:

			lda #BottomEdge
			sta (ZP.ScreenAddress), y

			iny
			sta (ZP.ScreenAddress), y

			lda #BLACK + 8
			sta (ZP.ColourAddress), y

			dey
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #40
			tay

			lda ZP.ColumnCounts, x
			cmp ZP.YourColumnCounts, x
			beq Ready

			lda #RED
			sta ZP.Colour
			sta ZP.LevelNotComplete
			jmp GetNumCharID
			
			Ready:

			lda #GREEN 
			sta ZP.Colour

			GetNumCharID:

				lda ZP.ColumnCounts, x
				asl
				asl
				clc
				adc #NumberStart
				sta ZP.Amount

			TopLeft:

				sta (ZP.ScreenAddress), y
				lda ZP.Colour
				sta (ZP.ColourAddress), y

			TopRight:

				iny
				inc ZP.Amount
				lda ZP.Amount
				sta (ZP.ScreenAddress), y
					
				lda ZP.Colour
				sta (ZP.ColourAddress), y

			BottomLeft:

				tya
				clc
				adc #39
				tay

				inc ZP.Amount
				lda ZP.Amount
				sta (ZP.ScreenAddress), y

				lda ZP.Colour
				sta (ZP.ColourAddress), y

			BottomRight:
	
				iny
				inc ZP.Amount
				lda ZP.Amount
				sta (ZP.ScreenAddress), y

				lda ZP.Colour
				sta (ZP.ColourAddress), y

		

			NextColumn:

			tya
			sec
			sbc #79
			tay	
	
			inx
			cpx ZP.GridSize
			bcc Loop


		lda ZP.LevelNotComplete
		bne NotYet

		lda #GAME_MODE_COMPLETE
		sta ZP.GameMode

		lda #150
		sta ZP.GameOverCount

		UpdateScore:

			sed

			lda ZP.Score
			clc
			adc ZP.ScoreThisRound
			sta ZP.Score
			
			lda ZP.Score + 1
			adc #0
			sta ZP.Score + 1

			cld

			jsr DrawScore
		

		NotYet:

		rts
	}

	MoveDownRow: {

		lda ZP.ScreenAddress
		clc
		adc #40
		sta ZP.ScreenAddress

		bcc NoWrap

		inc ZP.ScreenAddress + 1

		NoWrap:

		lda ZP.ColourAddress
		clc
		adc #40
		sta ZP.ColourAddress
		bcc NoWrap2

		inc ZP.ColourAddress + 1

		NoWrap2:


		rts
	}


	DrawLevel: {

		ldy #1	// screen offset, right most digit
		ldx #ZERO	// score byte index
	
		ScoreLoop:

			lda ZP.Level,x
			sta ZP.Amount
			and #$0f	// keep lower nibble
			jsr PlotDigit
			lda ZP.Amount
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #1
			bne ScoreLoop

			rts

		PlotDigit: {

			jsr Setup
			sta SCREEN_RAM + (40 * 6) + 30, y

			clc
			adc #1
			sta SCREEN_RAM + (40 * 6) + 31, y

			clc
			adc #1
			sta SCREEN_RAM + (40 * 7) + 30, y

			clc
			adc #1
			sta SCREEN_RAM + (40 * 7) + 31, y


			ldy ZP.Y

			dey
			rts

		}





		rts
	}

	
	DrawScore: {

	

		ldy #3	// screen offset, right most digit
		ldx #ZERO	// score byte index
	
		ScoreLoop:

			lda ZP.Score,x
			sta ZP.Amount
			and #$0f	// keep lower nibble
			jsr PlotDigit
			lda ZP.Amount
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #2
			bne ScoreLoop

			rts

		PlotDigit: {

			
			jsr Setup
			sta SCREEN_RAM + (40 * 12) + 30, y
			clc
			adc #1
			sta SCREEN_RAM + (40 * 12) + 31, y

			clc
			adc #1
			sta SCREEN_RAM + (40 * 13) + 30, y

			clc
			adc #1
			sta SCREEN_RAM + (40 * 13) + 31, y


			ldy ZP.Y

			dey
			rts

		}


		rts
	}





	Setup: {

		sty ZP.Y
		pha

		tya
		asl
		tay

		pla

		asl
		asl
		clc
		adc #NumberStart

		rts


	}






}