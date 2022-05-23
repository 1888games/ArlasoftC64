GLOB: {



	Frame:		.byte 0
	State:		.byte 0


	PosX_Frac:	.byte 0
	PosX_LSB:	.byte 0
	PosY:		.byte 0

	Column:		.byte 0
	Row:		.byte 0 

	FrameTimer:	.byte 0
	StartFrame:	.byte 0
	EndFrame:	.byte 0

	.label StartPointer = 17


	RowToY:		.fill 6, 61 + (i * 32)
	ColumnToX:	.fill 13, 29 + (i * 16)

	StateTimes:		.byte 6, JumpFrameTime, JumpFrameTime
	StartFrames:	.byte 0, 2, 10

	.label JumpFrameTime = 2

	.label JumpDistance = 256 * 16

	AnimProgress:		.byte 0
	DistanceTravelled:	.byte 0
	DistanceToTravel:	.byte 0

	Speeds_X_Frac:	.byte 0, <(JumpDistance / (JumpFrameTime * 5)), <(JumpDistance / (JumpFrameTime * 5))
	Speeds_X_Pixel:	.byte 0, >(JumpDistance / (JumpFrameTime * 5)), >(JumpDistance / (JumpFrameTime * 5))
	Speeds_Y_Frac:	.byte 0, 0, 0
	Speeds_Y_Pixel:	.byte 0, 0, 0
	X_Directions:	.byte 0, 1, -1
	Y_Directions:	.byte 0, 0, 0
	Distances:		.byte 0, 16, 16

	SpeedX_Frac:		.byte 0
	SpeedX_Pixel:		.byte 0
	SpeedY_Frac:		.byte 0
	SpeedY_Pixel:		.byte 0
	DirectionX:			.byte 0
	DirectionY:			.byte 0




	Initialise: {

		
		jsr StartPosition
		
		ldx #GLOB_IDLE
		jsr ChangeState

		jsr UpdateSprite

		rts
	}

	StartPosition: {

		lda #5
		sta Row

		ldx Row
		lda RowToY, x
		sta PosY

		ldx Column
		lda ColumnToX, x
		sta PosX_LSB

		lda #127
		sta PosX_Frac

		rts
	}


	ChangeState: {

		stx State

		lda StateTimes, x
		sta FrameTimer

		lda StartFrames, x
		sta Frame

		lda Speeds_X_Frac, x
		sta SpeedX_Frac

		lda Speeds_X_Pixel, x
		sta SpeedX_Pixel

		lda Speeds_Y_Frac, x
		sta SpeedY_Frac

		lda Speeds_Y_Pixel, x
		sta SpeedY_Pixel

		lda X_Directions, x
		sta DirectionX

		lda Y_Directions, x
		sta DirectionY

		lda Distances, x
		sta DistanceToTravel

		lda #0
		sta AnimProgress
		sta DistanceTravelled

		rts
	}




	UpdateFrame: {

		lda FrameTimer
		beq Ready

		dec FrameTimer
		rts

		Ready:

			lda State
			bne NotIdle

		Idle:

			lda Frame
			eor #%00000001
			sta Frame

			lda StateTimes
			sta FrameTimer


		NotIdle:

			cmp #GLOB_JUMP
			bcs NotSideways

			jmp JumpSideways


		NotSideways:



		rts
	}

	Move: {

		lda DistanceTravelled
		cmp DistanceToTravel
		bne DoX

		rts

		DoX:

			lda DirectionX
			beq DoY
			bpl GoRight


		GoLeft:

			lda PosX_Frac
			sec
			sbc SpeedX_Frac
			sta PosX_Frac

			lda PosX_LSB
			sta ZP.Amount
			sbc SpeedX_Pixel
			sta PosX_LSB

			lda ZP.Amount
			sec
			sbc PosX_LSB
			clc
			adc DistanceTravelled
			sta DistanceTravelled

			jmp DoY


		GoRight:

			lda PosX_Frac
			clc
			adc SpeedX_Frac
			sta PosX_Frac

			lda PosX_LSB
			sta ZP.Amount
			adc SpeedX_Pixel
			sta PosX_LSB

			sec
			sbc ZP.Amount
			clc
			adc DistanceTravelled
			sta DistanceTravelled

		DoY:





		rts
	}

	JumpSideways: {

		inc AnimProgress
		inc Frame

		CheckProgress:

			lda AnimProgress
			cmp #5
			bcc StillGoing

		Finished:

			ldx #GLOB_IDLE
			jmp ChangeState

		StillGoing:

			ldx State
			lda StateTimes, x
			sta FrameTimer


		rts
	}

	Control: {

		lda State
		beq CanControl

		rts

		cmp #GLOB_RIGHT
		bne NotRight




		NotRight:

		


		CanControl:

			ldy #1

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckLeft

			ldx #GLOB_RIGHT
			jmp ChangeState


		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckDown

			ldx #GLOB_LEFT
			jmp ChangeState


		CheckDown:

		rts
	}

	FrameUpdate: {

		jsr UpdateFrame
		jsr Control
		jsr Move
		jsr UpdateSprite
		






		rts
	}



	UpdateSprite: {

		lda PosX_LSB
		sta VIC.SPRITE_0_X

		lda PosY 
		sta VIC.SPRITE_0_Y 

		lda #CYAN
		sta VIC.SPRITE_COLOR_0

		lda Frame
		clc
		adc #StartPointer
		sta SPRITE_POINTERS



		rts
	}


}