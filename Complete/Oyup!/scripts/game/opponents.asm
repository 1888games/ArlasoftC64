OPPONENTS: {


	* = * "Opponent Data"

	Colours:	.byte LIGHT_GREEN, BLUE, BROWN, ORANGE, RED, YELLOW, CYAN, PURPLE, BLUE, BROWN, BROWN, DARK_GRAY
				.byte BLACK, RED, WHITE, BLACK, LIGHT_RED, WHITE, DARK_GRAY, BLACK, RED, LIGHT_RED, PURPLE, GREEN
				.byte WHITE, GREEN, BLACK, LIGHT_RED, YELLOW, BLACK, WHITE, YELLOW, BLACK, GRAY, BLUE, WHITE
				.byte PURPLE, GRAY, LIGHT_RED, WHITE, LIGHT_GREEN, LIGHT_RED, YELLOW, RED, WHITE, BLACK, BLACK, BLACK


	Skill:		.fill 6, random() * 30 + 20			// 20 - 50
				.fill 6, random() * 30 + 60		//    60 - 90
				.fill 6, random() * 30 + 100								// 100 -130	  
				.fill 6, random() * 30 + 140								 // 140-170
				.fill 6, random() * 30 + 180										  		// 180 - 210
				.fill 6, random() * 30 + 220										// 220 - 250

	// Speed:		.byte 100, 150, 175, 125, 150, 100, 125, 150
	// 			.byte 150, 200, 125, 150, 125, 175, 100, 150
	// 			.byte 225, 125, 175, 200, 150, 150, 200, 175
	// 			.byte 125, 150, 225, 175, 200, 200, 150, 175
	// 			.byte 225, 200, 175, 150, 175, 250, 200, 150
	// 			.byte 175, 150, 250, 150, 200, 225, 250, 200

	.label SkillAdd = 0

	Speed:		.fill 48, 20 + random() * 235


												  			// 180 - 205


	Pointers:	.fill 12, 54 + i
				.fill 12, 54 + i
				.fill 12, 54 + i
				.fill 12, 54 + i

	
	* = * "AI"

	.label TotalIterations = 22



	TempBeanIDS:		.byte 0, 0
	NewBeans:			.byte 0, 0
	TempBeanValues:		.byte 0, 0
	PlaceSlotIDs:		.byte 0, 0


	Bean1_Slots:		.byte 072, 073, 074, 075, 076, 077, 078, 079, 080, 081, 082, 083, 072, 073, 074, 075, 076, 073, 074, 075, 076, 077
	Bean2_Slots:		.byte 078, 079, 080, 081, 082, 083, 072, 073, 074, 075, 076, 077, 073, 074, 075, 076, 077, 072, 073, 074, 075, 076
	BaseScore:			.byte 002, 002, 000, 002, 002, 002, 002, 002, 000, 002, 002, 002, 005, 003, 003, 005, 005, 005, 003, 003, 005, 005
	Warning:			.byte 000, 000, 001, 000, 000, 000, 000, 000, 001, 000, 000, 000, 000, 003, 002, 000, 000, 000, 002, 003, 000, 000


	* = * "Scores"
	Scores:				.fill 32, 0


	* = * "Lookup"

	Lookup:				.fill 32, 0

	RowsFreeColumn3:	.byte 0

	XMove:				.byte 001, 002, 003, 004, 005, 006, 001, 002, 003, 004, 005, 006, 002, 003, 004, 005, 006, 001, 002, 003, 004, 005
	//XMove:				.byte 254, 255, 000, 001, 002, 003, 254, 255, 000, 001, 002, 003, 255, 000, 001, 002, 003, 254, 255, 000, 001, 002

	* = * "Rotations"
	Rotation:			.byte 002, 002, 002, 002, 002, 002, 000, 000, 000, 000, 000, 000, 003, 003, 003, 003, 003, 001, 001, 001, 001, 001

 	* = * "Lookups"

	CurrentIteration:	.byte 0
	Active:				.byte 0
							//    0   1   2   3   4   5   6   7   
	ColoursInSameColumn:	.byte 10, 08, 04, 03, 02, 01, 00, 00
	RowsFreeInColumn:		.byte 253, 01, 02, 03, 04, 05, 06, 07
	ExtraMatched:			.byte 00, 20, 40, 60, 80, 80, 80, 80
	SetsPopped:				.byte 00, 16, 32, 64, 100, 100, 100, 100

	.label MatchLeftOrRight = 14
 		
 	TopScores:				.byte 0, 0, 0, 0, 0
 	WorstScore:				.byte 0


	SetActive: {

		lda #0
		sta CurrentIteration
		sta WorstScore
		sta RowsFreeColumn3

		lda #1
		sta Active

		lda PANEL.PlayerTwo
		sta NewBeans

		lda PANEL.PlayerTwo + 1
		sta NewBeans + 1


		rts
	}






	



	RunIteration: {

	
		ldx CurrentIteration
		txa
		sta Lookup, x

		lda #0
		sta Scores, x
		sta GRID.RealCheck + 1

		lda Bean1_Slots, x
		tay
		sty TempBeanIDS

		lda GRID.PlayerOne, y
		sta TempBeanValues

		lda Bean2_Slots, x
		tay
		sty TempBeanIDS + 1

		lda GRID.PlayerOne, y
		sta TempBeanValues + 1

		Bean1:

			ldx TempBeanIDS
			ldy #0

			CheckEmpty:

				lda GRID.PlayerOne, x
				beq NextRow1

				cpy #0
				bne PlaceAbove

				jmp EndIteration

				NextRow1:	

				   	txa
					clc
					adc #6
					tax
					stx ZP.TempX

					iny
					cpy #12
					bcc CheckEmpty

				PlaceAbove:

					txa
					sec
					sbc #6
					sta PlaceSlotIDs

				SaveFreeRows:

					tya
					ldx CurrentIteration

					clc
					adc Scores, x
					sta Scores, x

					lda Warning, x
					beq CheckRight
					cmp #3
					bcs CheckRight

					tya
					sta RowsFreeColumn3

				CheckRight:

					ldx PlaceSlotIDs
					lda GRID.RelativeColumn, x
					cmp #5
					beq CheckLeft

					inx 
					lda GRID.PlayerOne, x
					cmp NewBeans
					bne CheckLeft

					ldx CurrentIteration
					lda Scores, x
					adc #MatchLeftOrRight
					sta Scores, x
				
				CheckLeft:

					ldx PlaceSlotIDs
					lda GRID.RelativeColumn, x
					beq NoLeft

					dex
					lda GRID.PlayerOne, x
					cmp NewBeans
					bne NoLeft

					ldx CurrentIteration
					lda Scores, x
					adc #MatchLeftOrRight
					sta Scores, x

				NoLeft:
			

				lda #0
				sta ZP.Amount

			
				ldx ZP.TempX

				CheckColours:

					sty ZP.Y
		
					cpy #12
					beq ReachedBottom

				
					lda GRID.PlayerOne, x
					cmp NewBeans
					bne NoMatch

					ldy ZP.Amount
					cpy #6
					bcs ReachedBottom			

					ldx CurrentIteration
					lda ColoursInSameColumn, y
					clc
					adc Scores, x
					sta Scores, x

					NoMatch:

					inc ZP.Amount

					lda ZP.TempX
					clc
					adc #6
					tax 
					stx ZP.TempX

					ldy ZP.Y
					iny
					jmp CheckColours

				ReachedBottom:

					

		Bean2:

			ldx TempBeanIDS + 1
			ldy #0

			CheckEmpty2:

				lda GRID.PlayerOne, x
				beq NextRow2

				cpy #0
				bne PlaceAbove2

				jmp EndIteration

				NextRow2:	

				   	txa
					clc
					adc #6
					tax
				
					iny
					cpy #12
					bcc CheckEmpty2

				PlaceAbove2:

					stx ZP.TempX
					txa
					sec
					sbc #6
					sta PlaceSlotIDs + 1

				SaveFreeRows2:

					tya
					ldx CurrentIteration

					clc
					adc Scores, x
					sta Scores, x

					lda Warning, x
					beq CheckRight2
					cmp #2
					beq CheckRight2

					tya
					sta RowsFreeColumn3

				CheckRight2:

					ldx PlaceSlotIDs + 1
					lda GRID.RelativeColumn, x
					cmp #5
					beq CheckLeft2

					inx 
					lda GRID.PlayerOne, x
					cmp NewBeans + 1
					bne CheckLeft2

					ldx CurrentIteration
					lda Scores, x
					adc #MatchLeftOrRight
					sta Scores, x
				
				CheckLeft2:

					ldx PlaceSlotIDs + 1
					lda GRID.RelativeColumn, x
					beq NoLeft2

					dex
					lda GRID.PlayerOne, x
					cmp NewBeans + 1
					bne NoLeft2

					ldx CurrentIteration
					lda Scores, x
					adc #MatchLeftOrRight
					sta Scores, x

				NoLeft2:

				lda #0
				sta ZP.Amount

				ldx ZP.TempX

				CheckColours2:

					sty ZP.Y
				
					cpy #12
					beq ReachedBottom2


					lda GRID.PlayerOne, x
					cmp NewBeans + 1
					bne NoMatch2

					ldy ZP.Amount
					cpy #6
					bcs ReachedBottom2

					ldx CurrentIteration	
					lda ColoursInSameColumn, y
					clc
					adc Scores, x
					sta Scores, x

					NoMatch2:

					inc ZP.Amount

					lda ZP.TempX
					clc
					adc #6
					tax 
					stx ZP.TempX

					ldy ZP.Y
					iny
					jmp CheckColours2

				ReachedBottom2:

		ldx CurrentIteration
		lda Scores, x
		clc 
		adc BaseScore, x
		sta Scores, x

		EndIteration:

			lda TempBeanValues
			ldx TempBeanIDS
			sta GRID.PlayerTwo, x
			lda TempBeanValues + 1
			ldx TempBeanIDS + 1
			sta GRID.PlayerTwo, x

		CheckIfLastIteration:

			lda #1
			sta GRID.RealCheck + 1
			
			inc CurrentIteration
			ldx CurrentIteration
			cpx #22
			bcc Finish

		LastIteration:

			lda #0
			sta Active

			lda #0
			sta CurrentIteration

			// lda RowsFreeColumn3
			// cmp #4
			// bcs Okay

			// .break
			// nop

			Okay:

			jsr CalculateMove

		Finish:


		rts
	}



	CalculateMove: {

		jsr SortMoves



		ldx #21
		ldy CAMPAIGN.OpponentID
		lda Skill, y
		clc
		adc #SkillAdd
		sta ZP.Amount

		Loop:

			jsr RANDOM.Get
			cmp ZP.Amount
			bcc GotMove

			dex
			bne Loop

		GotMove:

		lda Lookup, x
		tax

		lda Scores, x
		bne Valid

		jmp ChooseBest

		Valid:

		lda #0
		sta PLAYER.CPUDanger

		lda RowsFreeColumn3
		cmp #4
		bcs NoDanger

		lda Warning, x
		beq NoDanger

		ChooseBest:

			ldx #0
			lda Lookup, x
			tax

			lda #1
			sta PLAYER.CPUDanger

		NoDanger:

			lda XMove, x
			sta PLAYER.TargetMove

			lda Rotation, x
			sta PLAYER.TargetRotation

			cmp #4
			bcc Okay

		//	.break
			nop

		Okay:

		lda #3
		sta PLAYER.CurrentMove + 1

		lda #0
		sta PLAYER.CurrentRotation + 1


		rts
	}

	SortMoves: {

		lda #<Lookup
		sta ZP.LookupAddress

		lda #>Lookup
		sta ZP.LookupAddress + 1

		lda #<Scores
		sta ZP.ScoresAddress

		lda #>Scores
		sta ZP.ScoresAddress + 1

		Sort8:

			ldy #0
			sty ZP.Amount

			ldx #21
		
		NextElement:

			lda (ZP.ScoresAddress), y
			iny
			cmp (ZP.ScoresAddress), y
			bcc CheckEnd
			beq CheckEnd

			pha
			lda (ZP.ScoresAddress), y
			dey
			sta (ZP.ScoresAddress), y

			pla
			iny
			sta (ZP.ScoresAddress), y

			lda (ZP.LookupAddress), y
			pha
			dey
			lda (ZP.LookupAddress), y
			iny
			sta (ZP.LookupAddress), y
			dey
			pla
			sta (ZP.LookupAddress), y
			iny

			lda #255
			sta ZP.Amount

		CheckEnd:

			dex
			bne NextElement
			bit ZP.Amount
			bmi Sort8

			rts
	}


	FrameUpdate: {

		lda Active
		beq Finish

		jsr RunIteration




		Finish:

		rts
	}



}