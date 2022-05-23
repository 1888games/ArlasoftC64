.namespace TRAFFIC {


	* = * "Traffic"
	
	VehicleType:		.fill TRAFFIC_ROWS * MAX_VEHICLES, OFF
	VehicleX_LSB:		.fill TRAFFIC_ROWS * MAX_VEHICLES, 0
	VehicleX_MSB:		.fill TRAFFIC_ROWS * MAX_VEHICLES, 0

	VehicleSpeed_MSB:	.fill TRAFFIC_ROWS, 0
	VehicleSpeed_LSB:	.fill TRAFFIC_ROWS, 0

	VehicleX_Frac:		.fill TRAFFIC_ROWS * MAX_VEHICLES, 0

	Level:				.byte 0


	.label FirstRow = 73

	RowLookup:		.byte FirstRow, FirstRow + 16, FirstRow + 32, FirstRow + 48, FirstRow + 64
					.byte FirstRow + 81, FirstRow + 97, FirstRow + 113, FirstRow + 129, FirstRow + 145

	YPositions:		.fill 3, FirstRow
					.fill 3, FirstRow + 16
					.fill 3, FirstRow + 32
					.fill 3, FirstRow + 48
					.fill 3, FirstRow + 64
					.fill 3, FirstRow + 81
					.fill 3, FirstRow + 97
					.fill 3, FirstRow + 113
					.fill 3, FirstRow + 129
					.fill 3, FirstRow + 145

	CurrentRow:		.byte 0

	Colours:		.byte RED, LIGHT_GREEN, BROWN, LIGHT_RED, BLUE, ORANGE, LIGHT_BLUE, PURPLE, GREEN, YELLOW


	DataLookup:		.fill TRAFFIC_ROWS, i * 3
	POT:			.byte 0, 2, 4, 6, 8, 10, 12, 14

	Row:			.byte 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9

	.label L6L = 34
	.label L6R = 81
	.label L6C = 67
	.label L6O = 128
	.label TL = 17
	.label TR = 75

	.label LEFT_BOUNDARY = 8
	.label RIGHT_BOUNDARY = 88


	Level_1: {

		Type:
				.byte CRL, OFF, OFF
				.byte CRL, OFF, OFF
				.byte CRL, OFF, OFF
				.byte CRL, OFF, OFF
				.byte CRL, OFF, OFF

				.byte CRR, OFF, OFF
				.byte CRR, OFF, OFF
				.byte CRR, OFF, OFF
				.byte CRR, OFF, OFF
				.byte CRR, OFF, OFF

		X_LSB:	

				.byte L6R, 000, 000
				.byte L6R, 000, 000
				.byte L6R, 000, 000
				.byte L6R, 000, 000
				.byte L6R, 000, 000

				.byte L6R, 000, 000
				.byte L6R, 000, 000
				.byte L6R, 000, 000
				.byte L6R, 000, 000
				.byte L6R, 000, 000


		X_MSB:	.byte ONE, 000, 000
				.byte ONE, 000, 000
				.byte ONE, 000, 000
				.byte ONE, 000, 000
				.byte ONE, 000, 000

				.byte ONE, 000, 000
				.byte ONE, 000, 000
				.byte ONE, 000, 000
				.byte ONE, 000, 000
				.byte ONE, 000, 000

		Speed:	.byte 0, 1, 2, 3, 3, 4, 3, 2, 1, 0

	//	S_MSB:	.byte 000, 000, 001, 002, 002, 005, 002, 001, 000, 000
	//	S_LSB:	.byte 149, 205, 054, 095, 095, 000, 095, 054, 205, 149


	}

	Level_2: {

		Type:
				.byte CRL, CRL, OFF
				.byte CRL, CRL, OFF
				.byte CRL, CRL, CRL
				.byte CRL, CRL, OFF
				.byte TBL, TFL, OFF

				.byte CRR, CRR, OFF
				.byte CRR, CRR, CRR
				.byte CRR, CRR, OFF
				.byte CRR, CRR, OFF
				.byte CRR, OFF, OFF

		X_LSB:	

				.byte L6L, L6R, 000
				.byte L6C, L6R, 000
				.byte L6L, L6C, L6R
				.byte L6O, L6R, 000
				.byte TL, TR, 000

				.byte L6O, L6R, 000
				.byte L6L, L6C, L6R
				.byte L6C, L6R, 000
				.byte L6L, L6R, 000
				.byte L6R, 000, 000


		X_MSB:	.byte NIL, ONE, 000
				.byte NIL, ONE, 000
				.byte NIL, NIL, ONE
				.byte NIL, ONE, 000
				.byte NIL, ONE, 000

				.byte NIL, ONE, 000
				.byte NIL, NIL, ONE
				.byte NIL, ONE, 000
				.byte NIL, ONE, 000
				.byte ONE, 000, 000

		Speed:	.byte 0, 1, 2, 3, 3, 4, 3, 2, 1, 0

		//S_MSB:	.byte 000, 000, 001, 002, 002, 005, 002, 001, 000, 000
		//S_LSB:	.byte 149, 205, 054, 095, 095, 000, 095, 054, 205, 149

	}



	Level_3: {

		Type:
				.byte CRL, CRL, CRL
				.byte CRL, CRL, CRL
				.byte CRL, OFF, OFF
				.byte CRL, CRL, CRL
				.byte CRL, OFF, OFF

				.byte TFR, TBR, OFF
				.byte CRR, CRR, CRR
				.byte CRR, OFF, OFF
				.byte CRR, CRR, CRR
				.byte CRR, CRR, CRR

		X_LSB:	

				.byte L6C, L6O, L6R
				.byte L6C, L6O, L6R
				.byte L6R, 000, 000
				.byte L6C, L6O, L6R
				.byte L6R, 000, 000

				.byte TL, TR, 000
				.byte L6C, L6O, L6R
				.byte L6R, 000, 000
				.byte L6C, L6O, L6R
				.byte L6C, L6O, L6R


		X_MSB:	.byte NIL, NIL, ONE
				.byte NIL, NIL, ONE
				.byte ONE, NIL, ONE
				.byte NIL, NIL, ONE
				.byte ONE, ONE, 000

				.byte NIL, ONE, 000
				.byte NIL, NIL, ONE
				.byte ONE, 000, 000
				.byte NIL, NIL, ONE
				.byte NIL, NIL, ONE

		Speed:	.byte 0, 1, 2, 3, 4, 4, 3, 2, 1, 0

		//S_MSB:	.byte 000, 000, 001, 002, 002, 005, 002, 001, 000, 000
		//S_LSB:	.byte 149, 205, 054, 095, 095, 000, 095, 054, 205, 149

	}


	Level_4: {

		Type:
				.byte TBL, TFL, OFF
				.byte TBL, TFL, OFF
				.byte TBL, TFL, OFF
				.byte TBL, TFL, OFF
				.byte TBL, TFL, OFF


				.byte TFR, TBR, OFF
				.byte TFR, TBR, OFF
				.byte TFR, TBR, OFF
				.byte TFR, TBR, OFF
				.byte TFR, TBR, OFF

		X_LSB:	

				.byte TL, TR, 000
				.byte TL, TR, 000
				.byte TL, TR, 000
				.byte TL, TR, 000
				.byte TL, TR, 000

				.byte TL, TR, 000
				.byte TL, TR, 000
				.byte TL, TR, 000
				.byte TL, TR, 000
				.byte TL, TR, 000


		X_MSB:	.byte NIL, ONE, 000
				.byte NIL, ONE, 000
				.byte NIL, ONE, 000
				.byte NIL, ONE, 000
				.byte NIL, ONE, 000

				.byte NIL, ONE, 000
				.byte NIL, ONE, 000
				.byte NIL, ONE, 000
				.byte NIL, ONE, 000
				.byte NIL, ONE, 000

		Speed:	.byte 4, 3, 2, 3, 4, 4, 3, 2, 3, 4

		//S_MSB:	.byte 005, 002, 001, 002, 005, 005, 002, 001, 002, 005
		//S_LSB:	.byte 000, 095, 054, 095, 000, 000, 095, 054, 095, 000

	}

	Level_5: {

		.label L6L = 34
	.label L6R = 81
	.label L6C = 67
	.label L6O = 128
	.label TL = 17
	.label TR = 75


		Type:
				.byte TBL, TFL, CRL
				.byte CRL, CRL, CRL
				.byte TBL, TFL, CRL
				.byte CRL, CRL, CRL
				.byte TBL, TFL, CRL


				.byte TFR, TBR, CRR
				.byte TFR, TBR, CRR
				.byte CRR, CRR, CRR
				.byte CRR, CRR, CRR
				.byte TFR, TBR, CRR

		X_LSB:	

				.byte TL, TR, L6O
				.byte L6L, L6R, L6O
				.byte TL, TR, L6R
				.byte L6C, L6O, L6R
				.byte TL, TR, L6C

				.byte TL, TR, L6R
				.byte TL, TR, L6C
				.byte L6L, L6R, L6R
				.byte L6C, L6O, L6R
				.byte TL, TR, L6O


		X_MSB:	.byte NIL, ONE, NIL
				.byte NIL, NIL, NIL
				.byte NIL, ONE, NIL
				.byte NIL, NIL, ONE
				.byte NIL, ONE, NIL

				.byte NIL, ONE, NIL
				.byte NIL, ONE, NIL
				.byte NIL, NIL, ONE
				.byte NIL, NIL, ONE
				.byte NIL, ONE, NIL

		Speed:	.byte 4, 2, 3, 1, 4, 2, 3, 4, 3, 4

		//S_MSB:	.byte 005, 002, 001, 002, 005, 005, 002, 001, 002, 005
		//S_LSB:	.byte 000, 095, 054, 095, 000, 000, 095, 054, 095, 000

	}

	Speeds_MSB:	.byte 000, 000, 001, 002, 005
	Speeds_LSB:	.byte 149, 205, 054, 095, 000


		LevelData:	.word Level_1, Level_2, Level_3, Level_4, Level_1, Level_2, Level_3, Level_4, Level_5
		


		NewGame: {

			jsr GetLevelData




			rts

		}



		GetNewLaneSpeed: {

			lda Level
			cmp #8
			bcc NormalLevel

			lda #90
			clc
			adc ZP.Row
			tay

		ChooseAgain:

			jsr RANDOM.Get
			and #%00000011
			beq ChooseAgain
		

			sta VehicleType, y

			jsr RANDOM.Get
			sta VehicleType + 10, y
			jmp Finish

		NormalLevel:

			asl
			tax

			lda LevelData, x
			sta ZP.DataAddress

			lda LevelData + 1, x
			sta ZP.DataAddress + 1	

			lda #90
			clc
			adc ZP.Row
			tay

			lda (ZP.DataAddress), y
			tax

			jsr RANDOM.Get
			and #%00000001
			beq GetSpeed

			txa
			beq Increase

			cmp #4
			beq Decrease

			jsr RANDOM.Get
			and #%00000001
			beq Increase

			Decrease:

				dex
				jmp GetSpeed

			Increase:

				inx

			GetSpeed:

				lda Speeds_MSB, x
				sta VehicleType, y

				lda Speeds_LSB, x
				sta VehicleType + 10, y

			Finish:

			rts
		}

		GetLevelData: {


			lda Level
			asl
			tax

			lda LevelData, x
			sta ZP.DataAddress

			lda LevelData + 1, x
			sta ZP.DataAddress + 1

			ldy #0

			Loop:

				cpy #90
				bcc NormalData


				Speed:

					lda Level
					cmp #8
					bcc NormalLevel

				ChooseAgain:

					jsr RANDOM.Get
					and #%00000011
					beq ChooseAgain
					sta VehicleType, y

					jsr RANDOM.Get
					sta VehicleType + 10, y
					jmp EndLoop


				NormalLevel:

					lda (ZP.DataAddress), y
					tax
					lda Speeds_MSB, x
					sta VehicleType, y

					lda Speeds_LSB, x
					sta VehicleType + 10, y

					jmp EndLoop


				NormalData:

					lda (ZP.DataAddress), y
					sta VehicleType, y

				EndLoop:


				iny
				cpy #100
				bcc Loop


			ldy #0
			lda #0

			ClearLoop:

				sta VehicleX_Frac, y
				iny
				cpy TRAFFIC_ROWS * MAX_VEHICLES
				bcc ClearLoop



			rts

		}


		Move: {

			ldy #0


			Loop:	

				lda Row, y
				tax

				cpy #15
				bcc GoingLeft


				GoingRight:

					lda VehicleX_Frac, y
					clc
					adc VehicleSpeed_LSB, x
					sta VehicleX_Frac, y

					lda VehicleX_LSB, y
					adc #0
					sta VehicleX_LSB, y
					lda VehicleX_MSB, y
					adc #0
					sta VehicleX_MSB, y

					lda VehicleX_LSB, y
					clc
					adc VehicleSpeed_MSB, x
					sta VehicleX_LSB, y

					lda VehicleX_MSB, y
					adc #0
					sta VehicleX_MSB, y
					beq NoWrap

					lda VehicleX_LSB, y
					cmp #RIGHT_BOUNDARY
					bcc NoWrap

					lda #LEFT_BOUNDARY
					sta VehicleX_LSB, y

					lda #0
					sta VehicleX_MSB, y

					jmp NoWrap


				GoingLeft:

					lda VehicleX_Frac, y
					sec
					sbc VehicleSpeed_LSB, x
					sta VehicleX_Frac, y

					lda VehicleX_LSB, y
					sbc #0
					sta VehicleX_LSB, y

					lda VehicleX_MSB, y
					sbc #0
					sta VehicleX_MSB, y

					lda VehicleX_LSB, y
					sec
					sbc VehicleSpeed_MSB, x
					sta VehicleX_LSB, y

					lda VehicleX_MSB, y
					sbc #0
					sta VehicleX_MSB, y
					bne NoWrap

					lda VehicleX_LSB, y
					cmp #LEFT_BOUNDARY
					bcs NoWrap

					lda #RIGHT_BOUNDARY
					sta VehicleX_LSB, y

					lda #1
					sta VehicleX_MSB, y


				NoWrap:


				EndLoop:

					iny
					cpy #30
					beq Done

					jmp Loop


				Done:



			rts
		}


		UpdateSprites: {

			//inc $d020

			ldx CurrentRow
			lda DataLookup, x
			sta ZP.CurrentID
			tay

			lda CurrentRow
			and #%00000001
			beq UseFirstThree

			UseSecondThree:

				ldx CurrentRow
				lda RowLookup, x
				sta VIC.SPRITE_3_Y
				sta VIC.SPRITE_4_Y
				sta VIC.SPRITE_5_Y

				lda Colours, x
				sta VIC.SPRITE_COLOR_3
				sta VIC.SPRITE_COLOR_4
				sta VIC.SPRITE_COLOR_5

				lda VehicleType, y
				clc
				adc #16
				sta SPRITE_POINTERS + 3

				lda VehicleType + 1, y
				clc
				adc #16
				sta SPRITE_POINTERS + 4

				lda VehicleType + 2, y
				clc
				adc #16
				sta SPRITE_POINTERS + 5

				lda VehicleX_LSB, y
				sta VIC.SPRITE_3_X

				lda VehicleX_LSB + 1, y
				sta VIC.SPRITE_4_X

				lda VehicleX_LSB + 2, y
				sta VIC.SPRITE_5_X

				ldx #3
				lda #6
				sta ZP.EndID

				jmp MSB_Loop


			UseFirstThree:
			
				ldx CurrentRow
				lda RowLookup, x
				sta VIC.SPRITE_0_Y
				sta VIC.SPRITE_1_Y
				sta VIC.SPRITE_2_Y

				lda Colours, x
				sta VIC.SPRITE_COLOR_0
				sta VIC.SPRITE_COLOR_1
				sta VIC.SPRITE_COLOR_2

				lda VehicleType, y
				clc
				adc #16
				sta SPRITE_POINTERS

				lda VehicleType + 1, y
				clc
				adc #16
				sta SPRITE_POINTERS + 1

				lda VehicleType + 2, y
				clc
				adc #16
				sta SPRITE_POINTERS + 2

				lda VehicleX_LSB, y
				sta VIC.SPRITE_0_X

				lda VehicleX_LSB + 1, y
				sta VIC.SPRITE_1_X

				lda VehicleX_LSB + 2, y
				sta VIC.SPRITE_2_X

				ldx #0
				lda #3
				sta ZP.EndID


			MSB_Loop:

			Loop:	

				lda VehicleX_MSB, y
				beq NoMSB

				MSB:


					lda VIC.SPRITE_MSB
					ora VIC.MSB_On, x
					sta VIC.SPRITE_MSB
					jmp Done


				NoMSB:

					lda VIC.SPRITE_MSB
					and VIC.MSB_Off, x
					sta VIC.SPRITE_MSB
					
				Done:


					inx
					iny
					cpx ZP.EndID
					bcc Loop


		//	dec $d020

			rts
		}



}