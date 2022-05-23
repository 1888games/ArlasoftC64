BLOCK: {


	.label ChanceOfAirBlock = 230
	.label BrownBlockID = 29


	Values:	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 0-8
			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 9-17
			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 18-26
			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 27-35
			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 36-44
			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 45-53
			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 54-62
			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 63-71
			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 72-80
			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0  // 81-89




	RowStart:	.byte 0, 9, 18, 27, 36, 45, 54, 63, 72, 81
	ColumnStart:	.byte 0, 3, 6, 9, 12, 15, 18, 21, 24


	ScreenRows:	.fill 9, 22
				.fill 9, 19
				.fill 9, 16
				.fill 9, 13
				.fill 9, 10
				.fill 9, 7
				.fill 9, 4
				.fill 9, 1
				.fill 9, 1
				.fill 9, 1
		

	ScreenColumns:	.byte 0, 3, 6, 9, 12, 15, 18, 21, 24
					.byte 0, 3, 6, 9, 12, 15, 18, 21, 24
					.byte 0, 3, 6, 9, 12, 15, 18, 21, 24
					.byte 0, 3, 6, 9, 12, 15, 18, 21, 24
					.byte 0, 3, 6, 9, 12, 15, 18, 21, 24
					.byte 0, 3, 6, 9, 12, 15, 18, 21, 24
					.byte 0, 3, 6, 9, 12, 15, 18, 21, 24
					.byte 0, 3, 6, 9, 12, 15, 18, 21, 24
					.byte 0, 3, 6, 9, 12, 15, 18, 21, 24
					.byte 0, 3, 6, 9, 12, 15, 18, 21, 24



			


	ScrolledLastFrame: .byte 0

    // 0 = Empty
	// 1 = Air
	// 2 = Red
	// 3 = Green
	// 4 = Blue
	// 5 = Yellow
	// 6 = Brown

 
	Likelyhood:	.fill 7, 2
				.fill 7, 3
				.fill 7, 4
				.fill 7, 5
				.fill 4, 6

	AirBlockTimer:	.byte 0, 5
	AllowAirBlock: .byte 0

	Colours:	.byte 0, 13, 2, 5, 3, 7, 9

	StartCharacterID:	.byte 38
	CurrentScreenRow:	.byte 0

	CharacterAdd:	.byte 0, 3, 6

	BlockCharacterLookup:	.byte 0, 128, 0, 0, 0, 0, 29


	Reset: {

		lda #0
		sta CurrentScreenRow

		lda AirBlockTimer +1
		sta AirBlockTimer

		jsr GenerateRow


		rts

	}


	DrillBlock: {

		lda #0
		sta Values, x

		//.break

		lda ScreenRows, x
		clc
		adc CurrentScreenRow
		tay


		lda ScreenColumns, x
		tax

		lda #1
		jsr PLOT.PlotCharacter

		lda #11
		jsr PLOT.ColorCharacter

		inx
		lda #1
		jsr PLOT.PlotCharacter

		lda #11
		jsr PLOT.ColorCharacter

		inx 
		lda #1
		jsr PLOT.PlotCharacter

		lda #11
		jsr PLOT.ColorCharacter

		iny
		lda #1
		jsr PLOT.PlotCharacter

		lda #11
		jsr PLOT.ColorCharacter

		dex
		lda #1
		jsr PLOT.PlotCharacter

		lda #11
		jsr PLOT.ColorCharacter

		dex
		lda #1
		jsr PLOT.PlotCharacter

		lda #11
		jsr PLOT.ColorCharacter

		iny
		lda #1
		jsr PLOT.PlotCharacter

		lda #11
		jsr PLOT.ColorCharacter

		inx 
		lda #1
		jsr PLOT.PlotCharacter

		lda #11
		jsr PLOT.ColorCharacter

		inx 
		lda #1
		jsr PLOT.PlotCharacter

		lda #3
		jsr PLOT.ColorCharacter



		rts
	}


	GenerateRow: {

		ldx #0
		stx AllowAirBlock

		lda AirBlockTimer
		beq AirBlockAllowed

		dec AirBlockTimer
		jmp Loop

		AirBlockAllowed:

			lda AirBlockTimer + 1
			sta AirBlockTimer

			lda #1
			sta AllowAirBlock

		Loop:

			stx CurrentBlock

			jsr RANDOM.Get

			pha

			lda AllowAirBlock
			beq NormalBlock

			pla

			cmp #ChanceOfAirBlock
			bcs AirBlock
			jmp NoPull

			NormalBlock:

				pla

				NoPull:

				and #%00011111
				tay
				lda Likelyhood, y
				jmp AddBlock

			AirBlock:

				lda #1

				lda #0
				sta AllowAirBlock


			AddBlock:

				ldx CurrentBlock

				sta Values, x

				inx
				cpx #9
				beq Finish
				jmp Loop



		Finish:

		rts



	}


	ShiftBlockValues: {



		.for(var y=9; y>0; y--) {
			
			.for(var x=0; x<9; x++) {
				
				lda Values + ((y - 1) * 9) + x
				sta Values + ((y - 0) * 9) + x
			}
			
		}
	
		rts

	}

	Update:{

		lda ScrolledLastFrame
		beq DontShiftValues

		jsr NextRow


		DontShiftValues:



		rts
	}

	NextRow: {	

		lda #0
		sta ScrolledLastFrame

		lda CurrentScreenRow
		bne NoNewData
////
	//	.break

		jsr ShiftBlockValues
		jsr GenerateRow

		NoNewData:


		ldx CurrentScreenRow

		lda CharacterAdd, x
		sta CharacterAddNow
		clc
		adc StartCharacterID
		sta CharID

		ldx #0

		Loop:

			stx Column

			lda Values, x
			tay

			lda ColumnStart, x
			tax

			lda Colours, y
			sta VIC.COLOR_RAM +960, x
			sta VIC.COLOR_RAM +961, x
			sta VIC.COLOR_RAM +962, x

			
			cpy #6
			bne NormalBlock

			lda BlockCharacterLookup, y
			clc
			adc CharacterAddNow

			jmp SetCharacter

			NormalBlock:

			lda CharID

			SetCharacter:

				sta SCREEN_RAM + 960, x
				sta SCREEN_RAM + 961, x
				inc SCREEN_RAM + 961, x
				sta SCREEN_RAM + 962, x
				inc SCREEN_RAM + 962, x
				inc SCREEN_RAM + 962, x


			ldx Column
			inx
			cpx #9
			beq Finish
			jmp Loop


		Finish:


			inc CurrentScreenRow
			lda CurrentScreenRow

			//		.break


			cmp #3
			bcc SameRow

			lda #0
			sta CurrentScreenRow

			
			lda #0
			sta SPRITE.IsFalling



			//jsr GenerateRow

		SameRow:

			rts



	}



}