.namespace MAP_GENERATOR {

	* = * "-Map"

	* = * "--Generate"

	X:					.byte 0
	Y:					.byte 0


	Work_LSB:			.byte 0
	Work_MSB:			.byte 0

	Add_LSB:			.byte 0
	Add_MSB:			.byte 0


	Walls:				.fill 8, 0

	.label Magic_MSB = $31
	.label Magic_LSB = $53

	DirectionScreenAdd:	.byte 40, 40, 1, 1
	DirectionScreenInc:	.byte 0, 1, 1, 0

	DebugTimer:			.byte 0

	DirectionToScroll:	.byte 0

	Scrolling:			.byte 0
	ScrollProgress:		.byte 0
	ScrollTimer:		.byte 10

	.label ScrollTime = 2



	ScrollFunc_LSB:		.byte <ScrollLeft, <ScrollRight, <ScrollDown, <ScrollUp
	ScrollFunc_MSB:		.byte >ScrollLeft, >ScrollRight, >ScrollDown, >ScrollUp		

						.byte <SpritesLeft, <SpritesRight, <SpritesDown, <SpritesUp
						.byte >SpritesLeft, >SpritesRight, >SpritesDown, >SpritesUp	



.label WALL_NORTH = 0
.label WALL_SOUTH = 1
.label WALL_EAST = 2
.label WALL_WEST = 3
						//NR  NL  SR  SL  ED  EU  WD  WU
	Wall_1_Block:	.byte 30, 46, 35, 51, 16, 06, 15, 05
	Wall_2_Block:	.byte 31, 47, 36, 52, 17, 07, 16, 06
	Wall_3_Block:	.byte 32, 48, 37, 53, 18, 08, 17, 07
	Wall_4_Block:	.byte 33, 49, 38, 54, 19, 09, 18, 08

	Wall_5_Block:	.byte 35, 51, 40, 56, 21, 11, 20, 10
	Wall_6_Block:	.byte 36, 52, 41, 57, 22, 12, 21, 11
	Wall_7_Block:	.byte 37, 53, 42, 58, 23, 13, 22, 12
	Wall_8_Block:	.byte 38, 54, 43, 59, 24, 14, 23, 13


	Wall_X_Start:	.fill 8, 0
	Wall_X_End:		.fill 8, 0
	Wall_Y_Start:	.fill 8, 0
	Wall_Y_End:		.fill 8, 0

	

	WallUp_D:		.byte 0, 0, 0, 0, 0 // 0-4
					.byte 0, 0, 0, 0, 0 // 5-9
					.byte 0, 0, 0, 0, 0 // 10-14
				

	WallDown_D:		.byte 0, 0, 0, 0, 0 // 15-19
					.byte 0, 0, 0, 0, 0 // 20-24
					.byte 0, 0, 0, 0, 0 // 25-29

	WallRight_D:	.byte 0, 0, 0, 0, 0 // 30-34
					.byte 0, 0, 0, 0, 0 // 35-39
					.byte 0, 0, 0, 0, 0 // 40-44

	WallLeft_D:		.byte 0, 0, 0, 0, 0 // 45-49
					.byte 0, 0, 0, 0, 0 // 50-54
					.byte 0, 0, 0, 0, 0 // 55-59



	
	WallUp:			.byte 1, 1, 1, 1, 1 // 0-4
					.byte 0, 0, 0, 0, 0 // 5-9
					.byte 0, 0, 0, 0, 0 // 10-14
				

	WallDown:		.byte 0, 0, 0, 0, 0 // 15-19
					.byte 0, 0, 0, 0, 0 // 20-24
					.byte 1, 1, 1, 1, 1 // 25-29

	WallRight:		.byte 0, 0, 0, 0, 1 // 30-34
					.byte 0, 0, 0, 0, 1 // 35-39
					.byte 0, 0, 0, 0, 1 // 40-44

	WallLeft:		.byte 1, 0, 0, 0, 0 // 45-49
					.byte 1, 0, 0, 0, 0 // 50-54
					.byte 1, 0, 0, 0, 0 // 55-59



	HumanIgnoreWall:	.byte 0, 0, 1, 0, 0
						.byte 1, 0, 0, 0, 1
						.byte 0, 0, 1, 0, 1


	WallX:			.fill 8, 0
					.fill 8, 31
					.byte 13, 14, 15, 16, 17, 18, 0, 0
					.byte 13, 14, 15, 16, 17, 18

	WallY:			.byte 8, 9, 10, 11, 12, 13, 14, 15
					.byte 8, 9, 10, 11, 12, 13, 14, 15
					.fill 8, 24
					.fill 6, 0

	WallSize:		.byte 8, 8, 6, 6
	CharID:			.byte 16, 17, 18, 19
	SpawnSide:		.byte 0
					
	EntranceColour:	.byte 0

	InitialSetup: {

		//jsr RANDOM.Get
		//sta X

		///jsr RANDOM.Get
		//sta Y

		lda X
		sta Work_LSB

		lda Y
		sta Work_MSB

		jsr MultiplyBy7
		jsr AddMagicNumber

		lda #50
		sta DebugTimer

		rts
	}


	CalculateWallsOn: {

		ldx #0



		Loop:

			lda WallUp_D, x
			sta WallUp, x

			inx
			cpx #60
			bcc Loop


		ldy #0


		Loop2:

			sty ZP.Y

			tya
			asl
			asl
			asl
			sta ZP.Amount

			lda Walls, y
			asl
			clc
			adc ZP.Amount
			sta ZP.Amount
			tay
			lda Wall_1_Block, y
			tax

			inc WallUp, x

			iny
			lda Wall_1_Block, y
			tax

			inc WallUp, x

			ldy ZP.Y
			iny
			cpy #8
			bcc Loop2




		rts
	}

	BlockEntrance: {


		lda SpawnSide
		bmi NoBlock



		GetWallSize:

			tax
			lda WallSize, x
			sta ZP.Amount

			lda CharID, x
			sta ZP.CharID

			lda SpawnSide
			asl
			asl
			asl
			sta ZP.Y


		ldx #0

		Loop:

			stx ZP.X

			ldx ZP.Y

			lda WallY, x
			tay

			lda WallX, x
			tax

			lda ZP.CharID
			jsr PLOT.PlotCharacter

			ldy #0
			lda EntranceColour
			sta (ZP.ColourAddress), y

			ldx ZP.X
			inx
			inc ZP.Y
			cpx ZP.Amount
			bcc Loop



		NoBlock:




		rts
	}






	RandomMap: {

		jsr RANDOM.Get
		sta X

		jsr RANDOM.Get
		sta Y

		rts
	}

	

	FrameUpdate: {

		lda Scrolling
		beq NotScrolling

		jmp HandleScroll



		NotScrolling:

		rts
	}



	Generate: {

		jsr PROGRESSION.CheckLevel
		jsr PLAYER.Hide
		jsr BULLET.ClearAll
		

		lda #0
		

		jsr DrawOutline
		jsr InitialSetup
	
		ldx #0

		PillarLoop:

			stx ZP.X

			jsr MultiplyBy7
			jsr AddMagicNumber

			jsr MultiplyBy7
			jsr AddMagicNumber

			ldx ZP.X
			cpx #0
			bne DontStore

			lda Work_LSB
			jsr ROBOT.CalculateCount	

		DontStore:

		
			ldx Work_LSB
			lda Work_MSB

			and #%00000011

			ldx ZP.X
			sta Walls, x

			inx
			cpx #8
			bcc PillarLoop

		lda PLAYER.SpawnSide
		sta SpawnSide

		

		jsr PROGRESSION.GetLevelData

		lda ROBOT.CurrentColour
		sta EntranceColour

		jsr BlockEntrance
		
		jsr DrawAllWalls
		jsr TidyIntersections

		
		
		jsr PLAYER.Initialise
		jsr BONUS.Clear
		

		
		//jsr ROBOT.NewLevel
		
		jsr LIVES.Draw


	Again:

		lda $d012
		cmp #240
		bne Again

		jsr CalculateWallsOn
		//jsr SetupScroll


		rts
	}




	TidyIntersections: {

		ldx #0


		Loop:

			stx ZP.WallID

			jsr GetWallData

			CheckGapRight:

				ldy #0
				lda (ZP.ScreenAddress), y

				cmp #7
				bne DontNeed7_5

				ldy #1
				lda (ZP.ScreenAddress), y
				cmp #5
				bne DontNeed7_5

				lda #5
				ldy #0
				sta (ZP.ScreenAddress), y

			DontNeed7_5:

				ldy #0
				lda (ZP.ScreenAddress), y

				cmp #3
				bne DontNeed3_5

				ldy #1
				lda (ZP.ScreenAddress), y
				cmp #5
				bne DontNeed3_5

				lda #6
				ldy #0
				sta (ZP.ScreenAddress), y

			DontNeed3_5:

				lda ZP.ScreenAddress
				sec
				sbc #40
				sta ZP.ScreenAddress

				lda ZP.ScreenAddress + 1
				sbc #0
				sta ZP.ScreenAddress + 1

			CheckAbove1:

			 	ldy #0
			 	lda (ZP.ScreenAddress), y
			 	cmp #3
				bne NotGapAbove

				ldy #40
				lda (ZP.ScreenAddress), y
				cmp #7
				bne NotGapAbove1

				lda #3
				sta (ZP.ScreenAddress), y

			 NotGapAbove1:

			 	ldy #40
			 	lda (ZP.ScreenAddress), y
				cmp #5
			 	bne NotGapAbove

				lda #6
			 	sta (ZP.ScreenAddress), y

			 NotGapAbove:

				ldy #40
			 	lda (ZP.ScreenAddress), y
			 	cmp #2
			 	bne NotGapBelow

			 	ldy #80
			 	lda (ZP.ScreenAddress), y
			 	cmp #3
			 	bne NotGapBelow

			 	lda #8
			 	ldy #40
				sta (ZP.ScreenAddress), y


			 NotGapBelow:

			EndLoop:

				ldx ZP.WallID
				inx
				cpx #8
				bcc Loop




		rts
	}


	DrawAllWalls: {

		ldx #0
		
		WallLoop:

			stx ZP.WallID

			jsr GetWallData
			jsr DrawWall

			ldx ZP.WallID
			inx
			cpx #8
			bcc WallLoop

		rts
	}


	GetWallData: {

		GetWallDirection: // 0-3

			ldx ZP.WallID
			lda Walls, x
			sta ZP.WallDirection

		GetMoveDirection:

			tay
			lda DirectionScreenAdd, y
			sta ZP.ScreenMove

			lda DirectionScreenInc, y
			sta ZP.CharDirection

		GetWallData:

			lda ZP.WallID
			asl
			asl
			sta ZP.Temp3
			asl
			sta ZP.Temp4

			lda ZP.WallDirection
			asl
			clc
			adc ZP.Temp4
			tay

			lda WALL_DATA.Segment_1_Chars, y
			sta ZP.DataAddress

			iny
			lda WALL_DATA.Segment_1_Chars, y
			sta ZP.DataAddress + 1

		GetScreenAddress:

			lda WALL_DATA.Segment_Start_Y, x
			sta ZP.Row
			tay

			lda WALL_DATA.Segment_Start_X, x
			sta ZP.Column
			tax

			jsr PLOT.GetCharacter

			lda ZP.Temp3
			clc
			adc ZP.WallDirection
			tax

			ldy ZP.WallID

			lda WALL_DATA.Wall_1_X_Start, x
			sta Wall_X_Start, y

			lda WALL_DATA.Wall_1_X_End, x
			sta Wall_X_End, y

			lda WALL_DATA.Wall_1_Y_Start, x
			clc
			adc #50
			sta Wall_Y_Start, y

			lda WALL_DATA.Wall_1_Y_End, x
			clc
			adc #50
			sta Wall_Y_End, y

		rts
	}

	DrawWall: {

		ldy #0

		CharLoop:	

			sty ZP.Y

			lda (ZP.DataAddress), y
			beq Finish

			ldy #0
			sta (ZP.ScreenAddress), y

			lda #BLUE
			sta (ZP.ColourAddress), y

			lda ZP.CharDirection
			bne Increase	

			Decrease:


				lda ZP.ScreenAddress
				sec
				sbc ZP.ScreenMove
				sta ZP.ScreenAddress

				lda ZP.ScreenAddress + 1
				sbc #0
				sta ZP.ScreenAddress + 1

				lda ZP.ColourAddress
				sec
				sbc ZP.ScreenMove
				sta ZP.ColourAddress

				lda ZP.ColourAddress + 1
				sbc #0
				sta ZP.ColourAddress + 1

				jmp EndLoop


			Increase:

				lda ZP.ScreenAddress
				clc
				adc ZP.ScreenMove
				sta ZP.ScreenAddress

				lda ZP.ScreenAddress + 1
				adc #0
				sta ZP.ScreenAddress + 1

				lda ZP.ColourAddress
				clc
				adc ZP.ScreenMove
				sta ZP.ColourAddress

				lda ZP.ColourAddress + 1
				adc #0
				sta ZP.ColourAddress + 1


			EndLoop:

				ldy ZP.Y
				iny
				jmp CharLoop



		Finish:



		rts
	}




	DrawOutline: {

		lda #0
		sta MAPLOADER.CurrentMapID

		jsr MAPLOADER.DrawMap


		rts
	}

	AddMagicNumber: {

		lda Work_LSB
		clc
		adc #Magic_LSB
		sta Work_LSB

		lda Work_MSB
		adc #Magic_MSB
		sta Work_MSB

	
		lda Work_MSB
		ldx Work_LSB


		rts
	}

	MultiplyBy7: {

		ldy #0
		
		lda Work_LSB
		sta Add_LSB

		lda Work_MSB
		sta Add_MSB

		Loop:	

			lda Work_LSB
			clc
			adc Add_LSB
			sta Work_LSB

			lda Work_MSB
			adc Add_MSB
			sta Work_MSB
			
			iny
			cpy #6
			bcc Loop

		
		lda Work_MSB
		ldx Work_LSB

		

		rts
	}




}