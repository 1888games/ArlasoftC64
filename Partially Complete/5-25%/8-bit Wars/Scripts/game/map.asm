MAP: {



	Data: .word Screen_00, Screen_01, Screen_02, Screen_03, Screen_04
		  .word	Screen_05, Screen_06, Screen_07, Screen_08, Screen_09
		  .word Screen_10, Screen_11, Screen_12, Screen_13, Screen_14
		  .word Screen_15, Screen_16, Screen_17, Screen_18, Screen_19
		  .word Screen_20, Screen_21, Screen_22, Screen_23, Screen_24
		  .word Screen_25, Screen_26, Screen_27, Screen_28, Screen_29
		  .word Screen_00, Screen_00

	CurrentScreen:	.byte 0

	.label NumberOfScreens = 32

					// 	 	00	01	02	03	04	05	06	07	08	09	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30	31
	MoveIntoLeft:	.byte 	99, 05, 03, 20, 99, 02, 01,	27, 16, 99, 99, 99, 99, 99, 13, 14, 06, 08, 17, 21, 12, 29, 25, 99, 22, 99, 99, 99, 07, 28, 99, 99
	MoveIntoRight:	.byte 	99, 06, 05, 02, 99, 01, 16, 28, 17, 99, 99, 99, 20, 14, 15, 99, 08, 18, 99, 99, 03, 19, 24, 99, 99, 22, 99, 07, 29, 21, 99, 99
	MoveIntoDown:	.byte 	04, 99, 99, 99, 03, 99, 07, 99, 99, 08, 09, 10, 13, 99, 99, 99, 99, 99, 19, 99, 99, 22, 23, 99, 99, 99, 30, 99, 99, 99, 05, 11
	MoveIntoUp:		.byte 	99, 99, 99, 04, 00, 30, 99, 06, 09, 10, 11, 31, 99, 12, 99, 99, 99, 99, 99, 18, 99, 99, 21, 22, 99, 99, 99, 99, 99, 99, 26, 99
	MoveTeleport:	.byte	99, 99, 99, 99, 99, 99, 99, 05, 99, 99, 99, 99, 99, 99, 05, 99, 99, 99, 99, 99, 99, 99, 99, 26, 99, 99, 99, 99, 99, 99, 99, 99
	Locations:		.byte	00, 00, 00, 00, 00, 00, 03, 03, 07, 07, 07, 07, 01, 02, 02, 02, 03, 04, 04, 06, 01, 06, 06, 06, 06, 06, 05, 03, 03, 06, 00, 00

	LocationNames:	.text "hesperia planum "
					.text "chryse planitia "
					.text "hydraspis chaos "
					.text "cerberus fossae "
					.text "aonia desert    "
					.text "elysium mons    "
					.text "hellas basin    "
					.text "galactic museum "

	ScreenLeft:		.byte 0
	ScreenRight:	.byte 0
	ScreenUp:		.byte 0
	ScreenDown:		.byte 0
	ScreenTeleport:	.byte 0
	Location:		.byte 0

	CharShiftCounter:	.byte 0, 3

	.label SpinnerAddress = $F000 + (8 * 85)
	.label Lazer1Address = $F000 + (8 * 87)
	.label Lazer2Address = $F000 + (8 * 88)

	StarsMSB:	.fill 32, 99
	StarsLSB:	.fill 32, 99
	StarTimers: .fill 32, 99
	NumberOfStars:	.byte 0

	StarColours:	.byte 7, 1, 15, 15, 12, 12, 11, 00

	.label StarCounter = 15
	.label LocationRow = 23
	.label LocationColumn = 16


	Reset: {


		lda #0
		sta CurrentScreen

		lda #99
		sta Location

		jsr Display

		rts


	}


	CalculateValidMoves: {

		ldx CurrentScreen

		lda MoveIntoLeft, x
		sta ScreenLeft

		lda MoveIntoRight, x
		sta ScreenRight

		lda MoveIntoUp, x
		sta ScreenUp

		lda MoveIntoDown, x
		sta ScreenDown

		lda MoveTeleport, x
		sta ScreenTeleport

		lda Locations, x
		cmp Location
		beq NoUpdateName

		sta Location

		jsr DisplayName

		jmp Finish

		NoUpdateName:

		sta Location

		Finish:


		rts


	}


	MoveLeft: {

		lda ScreenLeft
		cmp #99
		beq Finish

		sta CurrentScreen
		jsr Display

		Finish:

			rts

	}

	MoveRight: {

		lda ScreenRight
		cmp #99
		beq Finish

		sta CurrentScreen
		jsr Display

		Finish:

			rts

	}

	MoveUp: {

		lda ScreenUp
		cmp #99
		beq Finish

		sta CurrentScreen
		jsr Display

		Finish:

			rts

	}


	MoveDown: {

		lda ScreenDown
		cmp #99
		beq Finish

		sta CurrentScreen
		jsr Display

		Finish:

			rts

	}



	Teleport: {

		lda ScreenTeleport
		cmp #99
		beq Finish

		sta CurrentScreen
		jsr Display

		Finish:

			rts

	}


	PreviousScreen: {

		dec CurrentScreen
		lda CurrentScreen
		cmp #255
		bne Draw

		inc CurrentScreen
		jmp Finish

		Draw:

			jsr Display

		Finish:

			rts


	}

	NextScreen: {

		inc CurrentScreen
		lda CurrentScreen
		cmp #NumberOfScreens
		bcc Draw

		dec CurrentScreen
		jmp Finish

		Draw:

			jsr Display

		Finish:

			rts


	}


	ScrollChars: {

		lda CharShiftCounter
		beq ReadyToScroll

		dec CharShiftCounter
		jmp Finish

		ReadyToScroll:

			lda CharShiftCounter + 1
			sta CharShiftCounter

			ldx #7

			Loop:

				lda SpinnerAddress, x
				asl
				adc #0
				sta SpinnerAddress, x

				lda Lazer2Address, x
				asl
				adc #0
				sta Lazer2Address, x

				lda Lazer1Address, x
				asl
				adc #0
				sta Lazer1Address, x

				dex
				bpl Loop
			
		Finish:

		rts
	}

	Update: {


		jsr ScrollChars
		jsr FlashStars



		rts




	}


	FlashStars: {


		ldx #0
		ldy #0

		Loop:

			 lda StarTimers, x
			 cmp #99
			 beq Finish

			 cmp #0
			 beq ReadyToCycle

			 dec StarTimers, x
			 jmp EndLoop

			 ReadyToCycle:

				lda #StarCounter
			 	sta StarTimers, x

				lda StarsMSB, x
				sta ColourAddress + 1

				lda StarsLSB, x
				sta ColourAddress + 0

				jsr RANDOM.Get
				and #%00000111
				tax

				lda StarColours, x

				//lda (ColourAddress), y
				//clc
				//adc #1
				//and #%00001111
				//tax

				sta (ColourAddress), y
				
			EndLoop:

				inx
				cpx #32
				beq Finish
				jmp Loop


		Finish:


		rts

	}

	ClearStars: {

		lda #99
		ldx #31

		Loop:

			sta StarTimers, x

			dex
			bpl Loop


		rts
	}


	DisplayName: {


		//.break

		ldx Location

		lda #LocationRow
		sta Row

		lda #LocationColumn
		sta Column

		txa
		asl
		asl
		asl
		asl
		sta CharOffset
		clc
		adc #16
		sta EndOfText
		
		Loop:

			
			ldx CharOffset
			lda LocationNames, x

			clc
			adc #195


			//.break

			cmp #227
			bne NotSpace

			lda #0

			NotSpace:	

			//.break

			inc Column

			ldx Column
			ldy Row

			jsr PLOT.PlotCharacter

			inc CharOffset
			lda CharOffset
			cmp EndOfText
			beq Finish

			jmp Loop


		Finish:


		rts

	}

	Display: {

		lda #0
		sta MAIN.GameActive

		jsr CalculateValidMoves
		jsr ClearStars
		
		lda CurrentScreen
		asl
		tax
		lda Data, x
		sta MapAddress

		lda Data + 1, x
		sta MapAddress + 1

		lda #<SCREEN_RAM
		clc
		adc #125
		sta ScreenAddress

		lda #>SCREEN_RAM
		adc #0
		sta ScreenAddress + 1

		lda #<VIC.COLOR_RAM
		clc
		adc #125
		sta ColourAddress

		lda #>VIC.COLOR_RAM
		adc #0
		sta ColourAddress + 1


		ldy #0
		ldx #0

		stx Row
		stx NumberOfStars

		Loop:

			lda (MapAddress), y
			sta (ScreenAddress), y

			cmp #1
			bne NoStar

			SaveStar:

				ldx NumberOfStars

				tya
				clc
				adc ColourAddress
				sta StarsLSB, x

				lda ColourAddress + 1
				adc #0
				sta StarsMSB, x

				inc NumberOfStars

				txa
				and #%00000111
				sta StarTimers, x


			NoStar:

				lda (MapAddress), y

				tax
				tya
				pha

				lda CHAR_COLORS, x
				sta (ColourAddress), y

				pla
				tay

				iny
				cpy #30
				bcc Loop

			NextRow:

				inc Row
				ldx Row
				cpx #19
				beq Finish

				lda MapAddress
				clc
				adc #30
				sta MapAddress

				lda MapAddress +1
				adc #0
				sta MapAddress + 1

				lda ScreenAddress
				clc
				adc #40
				sta ScreenAddress

				lda ScreenAddress + 1
				adc #0
				sta ScreenAddress + 1


				lda ColourAddress
				clc
				adc #40
				sta ColourAddress

				lda ColourAddress + 1
				adc #0
				sta ColourAddress + 1

				ldy #0
				jmp Loop



		Finish:

		lda #1
		sta MAIN.GameActive


		rts

	}

}