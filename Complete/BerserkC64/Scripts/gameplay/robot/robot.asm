.namespace ROBOT {

	.label MAX_ROBOTS = 11
	.label MIN_ROBOTS = 4


	* = * "Robot Data"

	PosX_LSB:	.fill MAX_ROBOTS, 0
	PosX_MSB:	.fill MAX_ROBOTS, 0

	* = * "Robot Data"

	PosY:		.fill MAX_ROBOTS, 0
	PosX_Frac:	.fill MAX_ROBOTS, 0
	PosY_Frac:	.fill MAX_ROBOTS, 0


	* = * "OffsetX"

	OffsetX:	.fill MAX_ROBOTS, 0
	OffsetY:	.fill MAX_ROBOTS, 0

	* = * "CharX"

	CharX:		.fill MAX_ROBOTS, 0
	CharY:		.fill MAX_ROBOTS, 0
	Sector:		.fill MAX_ROBOTS, 0


	* = * "State"
	State:		.fill MAX_ROBOTS, ROBOT_DEAD
	WaitTimer:	.fill MAX_ROBOTS, 0
	Frame:		.fill MAX_ROBOTS, 0
	StartPointer:	.fill MAX_ROBOTS, 0
	FrameTimer:	.fill MAX_ROBOTS, 0
	FrameSpeed:	.fill MAX_ROBOTS, 0

	* = * "SpriteID"

	SpriteID:	.fill MAX_ROBOTS, 0


	PlayerDiffX:	.fill MAX_ROBOTS, 0
	PlayerDiffY:	.fill MAX_ROBOTS, 0
	
	DirectionX:		.fill MAX_ROBOTS, 0
	DirectionY:		.fill MAX_ROBOTS, 0

	FireCooldown:	.fill MAX_ROBOTS, 0


	* = * "BlockUp"
	BlockUp:		.fill MAX_ROBOTS, 0
	BlockDown:		.fill MAX_ROBOTS, 0
	BlockLeft:		.fill MAX_ROBOTS, 0
	BlockRight:		.fill MAX_ROBOTS, 0
	BlockRight_MSB: .fill MAX_ROBOTS, 0

	SectorUp:		.fill MAX_ROBOTS, 0
	SectorDown:		.fill MAX_ROBOTS, 0
	SectorLeft:		.fill MAX_ROBOTS, 0
	SectorRight:	.fill MAX_ROBOTS, 0
	SectorRight_MSB: .fill MAX_ROBOTS, 0

	MoveDirection:	.fill MAX_ROBOTS, 0
	SameSegment:	.fill MAX_ROBOTS, 0

	Delay:			.byte 0

	SectorOccupied:	.fill 15, 0
	CurrentMoveRobot:	.byte 0
	LastRobot:		.byte 0


	.label SectorXStart = 34
	.label SectorXGap = 48


	SectorCentreX:	.fill 5, SectorXStart + (i * SectorXGap) - XOff
					.fill 5, SectorXStart + (i * SectorXGap) - XOff
					.fill 5, SectorXStart + (i * SectorXGap) - XOff

	.label YOff = 6
	.label XOff = 4

	SectorCentreY:	.fill 5, 82 - YOff
					.fill 5, 146 - YOff
					.fill 5, 214 - YOff




	SectorsLeft:	.byte 0
					.fill 4, SectorXStart + (i * SectorXGap) - XOff - SectorXGap/2
					.byte 0
					.fill 4, SectorXStart + (i * SectorXGap) - XOff - SectorXGap/2
					.fill 4, SectorXStart + (i * SectorXGap) - XOff - SectorXGap/2
					.byte 0

	SectorsRight:	.fill 4, <SectorXStart + (i * SectorXGap) - XOff + SectorXGap/2
					.byte 255
					.fill 4, <SectorXStart + (i * SectorXGap) - XOff + SectorXGap/2
					.byte 255
					.fill 4, <SectorXStart + (i * SectorXGap) - XOff + SectorXGap/2
					.byte 255

	SectorsRight_MSB:	.fill 4, 0
						.byte 1


	SectorsUp:		.fill 5, 0
					.fill 5, 82 - YOff - 28
					.fill 5, 146 - YOff - 28

	SectorsDown:	.fill 5, 82 - YOff + 28
					.fill 5, 146 - YOff + 28
					.fill 5, 255



	PixelSpeed:		.byte 0
	FracSpeed:		.byte 30

	PixelSpeed_One:	.byte 0
	FracSpeed_One:	.byte 20


	StartCount:		.byte 0
	Count:			.byte 0

	SpawnSectors:	.byte 5, 9, 12, 2
	SpawnSector:	.byte 0

	* = * "Robot Colour"
	CurrentColour:	.byte YELLOW

	StartPointers:	//.byte 25, 25, 31, 33, 35, 38, 41, 16
					.byte 49, 49, 55, 57, 59, 62, 65, 40


						// 0. 1.  2.  3.  4.  5.  6.  7.  8.  9. 10.  11. 12. 13. 14. 15. 16 17. 18. 19.  20. 21
	FramePointers:	.byte 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 60, 62, 63, 64, 63, 65, 66, 67, 40
	StartFrameIDs:	.byte 0, 0, 6, 8, 10, 14, 18, 21

	Frames:			.byte 1, 6, 2, 2, 4, 4, 3, 1

	FrameSpeeds:	.byte 8, 12, 12, 12, 12, 12, 4, 0

	Active:			.byte 0

	

	SegmentColumns:	.fill 7, 0
					.fill 6, 1
					.fill 6, 2
					.fill 6, 3
					.fill 7, 4

	ColumnOverwrite: .fill 6, 1
					 .fill 1, 0
					 .fill 5, 1
					 .fill 1, 0
					 .fill 5, 1
					 .fill 1, 0
					 .fill 6, 1




	SegmentRows:	.fill 7, 0
					.fill 9, 5
					.fill 9, 10

	RowOverwrite:	.fill 7, 1
					.fill 1, 0
					.fill 8, 1
					.fill 1, 0
					.fill 8, 1





	Segment_1_Walls:	.byte 0, 1, 255, 255
	Segment_2_Walls:	.byte 0, 1, 255, 255
	Segment_3_Walls:	.byte 1, 2, 255, 255
	Segment_4_Walls:	.byte 2, 3, 255, 255
	Segment_5_Walls:	.byte 2, 3, 255, 255

	Segment_6_Walls:	.byte 0, 4, 255, 255
	Segment_7_Walls:	.byte 0, 1, 4, 5
	Segment_8_Walls:	.byte 1, 2, 5, 6
	Segment_9_Walls:	.byte 2, 3, 6, 7
	Segment_10_Walls:	.byte 2, 3, 6, 7

	Segment_11_Walls:	.byte 4, 5, 255, 255
	Segment_12_Walls:	.byte 4, 5, 255, 255
	Segment_13_Walls:	.byte 5, 6, 255, 255
	Segment_14_Walls:	.byte 6, 7, 255, 255
	Segment_15_Walls:	.byte 6, 7, 255, 255




	ChangeState: {


		sta State, x
		tay
		bmi NoPointer

		lda StartFrameIDs, Y
		sta StartPointer, x

		lda FrameSpeeds, y
		sta FrameSpeed, x


		NoPointer:

		lda #0
		sta Frame, x



		rts
	}


	

	Kill: {


		ldx ZP.RobotID

		lda State, x
		cmp #ROBOT_DYING
		bne Reduce

		jmp NoReduce


		Reduce:
		
		lda #ROBOT_DYING
		jsr ChangeState

		jsr UpdatePointer

		lda PosX_LSB, x
		sec
		sbc #4
		sta PosX_LSB, x

		lda PosX_MSB, x
		sbc #0
		sta PosX_MSB, x

		lda PosY, x
		sec
		sbc #4
		sta PosY, x

		ldy #0
		jsr SCORE.AddScore

		dec Count
		lda Count
		bne NotAllDead

		lda StartCount
		jsr BONUS.Show

		ldx ZP.RobotID

		NotAllDead:

			lda FracSpeed
			clc
			adc #PROGRESSION.RobotSpeedPerRobot
			sta FracSpeed

			lda PixelSpeed
			adc #0
			sta PixelSpeed

			lda Count
			cmp #1
			bne NotLast

			ldy #0

		DoubleIncrease:

			lda FracSpeed
			clc
			adc #PROGRESSION.RobotSpeedPerRobot
			sta FracSpeed

			lda PixelSpeed
			adc #0
			sta PixelSpeed

			iny
			cpy #6
			bcc DoubleIncrease


		NotLast:

		jsr OTTO.IncreaseFrames

		Loop:

			lda FrameSpeeds + 1
			cmp #7
			bcc NoReduce	

			dec FrameSpeeds + 1
			dec FrameSpeeds + 2
			dec FrameSpeeds + 3
			dec FrameSpeeds + 4
			dec FrameSpeeds + 5


		NoReduce:


		rts
	}

	RemoveRobot: {


		//jsr SOUND.RobotDie

		ldy #S_EXPLODE
		jsr SPEECH.StartSequence

		ldx ZP.RobotID

		lda #ROBOT_DEAD
		jsr ChangeState

	
		ldy SpriteID, x

		lda #0
		sta PosY, x
		sta SpriteY, y
		sta PosX_LSB, x
		sta SpriteColor, y
		sta Frame, x

		jsr UpdateSprite

		// lda Count
		// cmp #1
		// bne NotLastRobot

		// ldx #0

		// Loop:

		// 	lda State, x
		// 	bpl FoundIt

		// 	inx
		// 	cpx StartCount
		// 	bcc Loop

		// FoundIt:

		// 	stx LastRobot

		// 	lda PLAYER.PixelSpeed
		// 	lsr
		// 	sta ROBOT.PixelSpeed

		// 	lda PLAYER.FracSpeed
		// 	lsr
		// 	sta ROBOT.FracSpeed

		// 	ldx ZP.RobotID

		// NotLastRobot:




		rts
	}

	UpdateFrame: {

	
		lda FrameTimer, x
		beq Ready

		dec FrameTimer, x
		rts

		Ready:



			lda FrameSpeed, x
			sta FrameTimer, x

			inc Frame, x

			lda State, x
			tay
			bmi NoLoop

			lda FrameSpeeds, y
			sta FrameTimer, x

			lda Frame, x
			cmp Frames, y
			bcc NoLoop

			lda #0
			sta Frame, x

			lda State, x
			cmp #ROBOT_DYING
			bne NoLoop


			jsr RemoveRobot

		NoLoop:	

			jsr UpdatePointer

		rts
	}

	UpdatePointer: {

		ldy SpriteID, x

		stx ZP.RobotID

		lda Frame, x
		clc
		adc StartPointer, x
		tax
		lda FramePointers, x
		sta SpritePointer, y

		ldx ZP.RobotID

		rts
	}

	UpdateSprite: {


		ldy SpriteID, x

		lda #0
		sta PosX_MSB, x

		lda PosX_LSB, x
		clc
		adc #24
		sta SpriteX, y

		lda PosX_MSB, x
		adc #0
		sta PosX_MSB, x

		lda PosY, x
		sta SpriteY, y

		lda PosX_MSB, x
		sta SpriteMSB, y
		jsr UTILITY.StoreMSBColourY


		Finish:
	
		// lda Frame, x
		// clc
		// adc StartPointer, x
		// //sta SpritePointer, y

		rts
	}


	Move: {


			lda State, x
			cmp #ROBOT_DYING
			bne NotDead

			rts

		NotDead:

		
			lda WaitTimer, x
			beq CanMove

			rts

		CanMove:

			lda #0
			sta ZP.E


		DoY:

			lda Sector, x
			cmp PLAYER.Sector
			bne Different

			lda #0
			sta BlockUp, x
			sta BlockDown, x
			sta BlockLeft, x
			sta BlockRight, x


		Different:


			lda PlayerDiffY, x
			beq DoX
			//bcc DoX

			lda DirectionY, x
			bne MoveDown

		MoveUp:


			lda PosY, x
			cmp SectorDown, x
			bcs CantBlockUp


			lda BlockUp, x
			bne DoX

		CantBlockUp:

			lda PosY_Frac, x
			sec
			sbc FracSpeed
			sta PosY_Frac, x

			lda PosY, x
			sta ZP.L
			sbc PixelSpeed
			sta PosY, x

			cmp PLAYER.PosY
			bcs NoWallUp

			lda PLAYER.PosY
			sta PosY, x

		NoWallUp:

			lda #ROBOT_UP
			sta ZP.State

			inc ZP.E

			jmp DoX

		MoveDown:

			lda PosY, x
			cmp SectorDown, x
			bcc CantBlockDown

			lda BlockDown, x
			bne DoX

		CantBlockDown:

			lda PosY_Frac, x
			clc
			adc FracSpeed
			sta PosY_Frac, x

			lda PosY, x
			sta ZP.L
			adc PixelSpeed
			sta PosY, x

			cmp PLAYER.PosY
			bcc NoWallDown

			lda PLAYER.PosY
			sta PosY, x

		NoWallDown:

			lda #ROBOT_DOWN
			sta ZP.State

			inc ZP.E

		DoX:	

			lda PlayerDiffX, x
			bne IsDifference

			jmp CalcSegment

		IsDifference:
			
			lda DirectionX, x
			bpl MoveRight

		MoveLeft:

			lda PosX_LSB, x
			cmp SectorRight, x
			bcs CantBlockLeft

			lda BlockLeft, x
			bne StoppedLeft
	
		CantBlockLeft:

			lda PosX_Frac, x
			sec
			sbc FracSpeed
			sta PosX_Frac, x

			lda PosX_LSB, x
			sta ZP.L
			sbc PixelSpeed
			sta PosX_LSB, x


			cmp PLAYER.PosX_LSB
			bcs NoWallLeft

			lda PLAYER.PosX_LSB
			sta PosX_LSB, x


			jmp NoWallLeft


		StoppedLeft:


			jmp CalcSegment

		NoWallLeft:

			lda #ROBOT_LEFT
			sta ZP.State

			inc ZP.E

			jmp CalcSegment

		MoveRight:

			lda PosX_LSB, x
			cmp SectorRight, x
			bcc CantBlockRight

			lda BlockRight, x
			bne StoppedRight

		CantBlockRight:

			lda PosX_Frac, x
			clc
			adc FracSpeed
			sta PosX_Frac, x

			lda PosX_LSB, x
			sta ZP.L
			adc PixelSpeed
			sta PosX_LSB, x


			cmp PLAYER.PosX_LSB
			bcc NoWallRight

			lda PLAYER.PosX_LSB
			sta PosX_LSB, x

			jmp NoWallRight

		
		StoppedRight:

			jmp CalcSegment

		NoWallRight:

			lda #ROBOT_RIGHT
			sta ZP.State

			inc ZP.E
	
		CalcSegment:

			lda ZP.E
			bne Moving

			lda #ROBOT_THINKING
			sta ZP.State

			Moving:

			lda ZP.State
			cmp State, x
			beq NoStateChange

			jsr ChangeState

		NoStateChange:

			jsr CalculateSegment
			jsr CheckWallDistances

			
		
		rts
	}


	
	
	MoveOne: {	

		//lda Count
		//cmp #1
		//bne NotLastRobot


		//ldx LastRobot
		//stx CurrentMoveRobot

		NotLastRobot:

		ldx CurrentMoveRobot
		lda State, x
		bmi EndLoop

		cmp #ROBOT_DYING
		beq NoMove

		jsr GetDistanceToPlayer
		jsr Move

		NoMove:

		jsr CheckSpriteCollision

		EndLoop:

		ldx CurrentMoveRobot
		inx
		cpx StartCount
		bcc NoWrap

		ldx #0
	

		NoWrap:

		stx CurrentMoveRobot

	
		rts

		lda State, x
		bmi EndLoop2

		cmp #ROBOT_DYING
		beq NoMove2

		jsr GetDistanceToPlayer
		jsr Move

		NoMove2:

		jsr CheckSpriteCollision

		EndLoop2:

		ldx CurrentMoveRobot
		inx
		cpx StartCount
		bcc NoWrap2

		ldx #0

		NoWrap2:

		stx CurrentMoveRobot

		rts
	}


	KillAll: {

		ldx #0

		Loop:

			stx ZP.X

			lda #255
			sta State, x

			lda #0
			sta PosY, x
			sta PosX_LSB, x
			sta PosX_MSB, x

			jsr UpdateSprite


			lda SpriteY, y
			sta SpriteCopyY, y

			ldx ZP.X

			inx
			cpx StartCount
			bcc Loop



		rts
	}

	FrameUpdate: {


		SetDebugBorder(YELLOW)

		lda Active
		bne DoWork

		jmp Exit

		DoWork:

			jsr MoveOne
			
			ldx #0

		Loop:	

			stx ZP.RobotID

			lda State, x
			bmi EndLoop

			lda WaitTimer, x
			beq NotWaiting

			dec WaitTimer, x

			NotWaiting:

			jsr UpdateFrame
			jsr UpdateSprite
			
			lda FireCooldown, x
			beq EndLoop

			dec FireCooldown, x


		EndLoop:

			ldx ZP.RobotID
			inx
			cpx StartCount
			bcc Loop


		Exit:

		jsr AI
		
		

		SetDebugBorder(BLACK)

		rts
	}
}


