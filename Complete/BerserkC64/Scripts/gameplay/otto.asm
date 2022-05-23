OTTO: {




	CountActive:	.byte 0
	DelayFrames:	.byte 0, 0
	X_Value:		.byte 0
	Active:			.byte 0
	Spawning:		.byte 255
	FrameTimer:		.byte 0
	MoveRight:		.byte 0
	MoveDown:		.byte 0
	DistanceX:		.byte 0
	DistanceY:		.byte 0


	Frame:			.byte 0

	.label SpawnFrameTime = 10
	.label JumpFrameStart = 6
	.label SpriteID = MAX_SPRITES - 2
	.label StartPointer = 68

	SpawnPointX:	.byte 36, 216, 126, 126
	SpawnPointY:	.byte 167, 167, 233, 93
	JumpFrames:		.byte 6
	FrameLookup:	.byte 2, 4, 4, 5, 5

	.label MinX = 28
	.label MaxX = 255

	JumpLookupY:		.byte 000, -8, -06, -03, -02, -01, 002, 002, 003, 005, 008
	JumpLookupX:		.byte 000, 001, 002, 002, 001, 001, 001, 002, 002, 002, 002
	DoTwice:			.byte 000, 001, 000, 000, 000, 000, 000, 000, 000, 000, 001
	JumpProgress:		.byte 0

	PosX_LSB:			.byte 0
	PosX_MSB:			.byte 0
	PosY:				.byte 0
	XMovementFrac:		.byte 0
	XMovementPixel:		.byte 0

	.label XSpeed = PLAYER.SPEED_FRAC / 2


	.label DefaultJumpY = -8
	.label DefaultLandY = 8
	.label JumpAdjust = 4



 //while in the new version the formula is (X+Y+Z)*40 frames.

// X is set to 5 at the start of the game and decreases every time the player
// enters a new room. This includes the room the player starts the game.
// Y is equal to how many robots spawn in the room.
// Z is the #Lasers variable.
// In both sets, the game adds 80 frames to the timer when a robot is destroyed.
	
	
	NewGame: {

		lda #5
		sta X_Value

		


		rts
	}


	NewLevel: {

		lda #0
		sta Active
	
		jsr DecreaseX
		jsr CalculateFrames

		lda #0
		sta SpriteY + SpriteID
		sta SpriteCopyY + SpriteID

		lda #JumpFrameStart
		sta JumpFrames

		inc CountActive


		rts
	}

	DecreaseX: {

		dec X_Value
		lda X_Value
		bpl Okay

		lda #0
		sta X_Value


		Okay:


		rts
	}


	Collision: {

		lda PLAYER.Dead
		bne Finish

		lda Active
		beq Finish


		DoX:

		MSB_Same:

			lda PosX_LSB
			clc
			adc #2
			sec
			sbc PLAYER.PosX_LSB
			adc #4
			sta DistanceX	
			cmp #8
			bcs NoCollision

		DoY:

			lda PLAYER.PosY
			clc
			adc #6
			sec
			sbc PosY
			clc
			adc #9
			cmp #18
			bcs NoCollision

			jsr PLAYER.Kill

			lda #0
			sta Active

		NoCollision:


		Finish:

		rts
	}

	IncreaseFrames: {

		lda Active
		bne Finish


			lda DelayFrames
			clc
			adc #67
			sta DelayFrames

			lda DelayFrames + 1
			adc #0
			sta DelayFrames + 1

			rts


		Finish:

			lda ROBOT.Count
			cmp #5
			bcs NoChange

			tay
			lda FrameLookup, y
			sta JumpFrames

		NoChange:


		rts
	}	


	HandleSpawning: {


		lda FrameTimer
		beq Ready

		dec FrameTimer
		rts


		Ready:

			dec Spawning
			inc Frame

			lda #SpawnFrameTime
			sta FrameTimer

			jsr UpdateSprite

			lda Spawning
			bmi StartMoving

			rts

		StartMoving:	

			lda JumpFrames
			sta FrameTimer


		rts
	}


	CalculateDirection: {

		DoX:

			
			lda PLAYER.PosX_LSB
			cmp PosX_LSB
			bcc GoLeft

		GoRight:

			lda #1
			sta MoveRight

			jmp DoY

		GoLeft:

			lda #0
			sta MoveRight


		DoY:

			lda PLAYER.PosY
			clc
			adc #6
			cmp PosY
			bcc GoUp

		GoDown:

			lda #DefaultJumpY
			clc 
			adc #JumpAdjust
			sta JumpLookupY + 1

			lda #DefaultLandY
			clc
			adc #JumpAdjust
			sta JumpLookupY + 10

			rts

		GoUp:

			lda #DefaultJumpY
			sec 
			sbc #JumpAdjust
			sta JumpLookupY + 1

			lda #DefaultLandY
			sec
			sbc #JumpAdjust
			sta JumpLookupY + 10



	}


	AddX: {

		lda XMovementFrac
		clc
		adc #XSpeed
		sta XMovementFrac

		lda XMovementPixel
		adc #0
		sta XMovementPixel

		lda ROBOT.Count
		bne NoDouble


		lda XMovementFrac
		clc
		adc #XSpeed
		sta XMovementFrac

		lda XMovementPixel
		adc #0
		sta XMovementPixel




		NoDouble:



		rts
	}

	HandleJump: {

		jsr AddX

		lda FrameTimer
		beq Ready

		dec FrameTimer

		
		jmp CheckCollision

		Ready:

			lda JumpFrames
			sta FrameTimer

			lda JumpProgress
			bne GotDirection

		GetDirection:

			jsr CalculateDirection
			inc Frame

		GotDirection:

			inc JumpProgress
			ldx JumpProgress
			cpx #11
			bne NotBounce

			lda #0
			sta JumpProgress

			dec Frame
			jmp ShowSprite


		NotBounce:

		DoX:

			lda DistanceX
			cmp #8
			bcc DoY

			lda MoveRight
			bne GoRight


		GoLeft:

			lda PosX_LSB
			sec
			sbc XMovementPixel
			sta PosX_LSB

			jmp DoY

		GoRight:

			lda PosX_LSB
			clc
			adc XMovementPixel
			sta PosX_LSB

		DoY:	

			lda #0
			sta XMovementPixel

			lda PosY
			clc
			adc JumpLookupY, x
			sta PosY

			lda DoTwice, x
			beq ShowSprite

			jsr Collision

			lda PLAYER.Dead
			bne ShowSprite

			lda PosY
			clc
			adc JumpLookupY, x
			sta PosY

		ShowSprite:

			jsr UpdateSprite

		CheckCollision:

			jsr Collision


		rts
	}

	HandleOtto: {

		lda Spawning
		bpl DoSpawn


		OpenPlay:

			jmp HandleJump

		DoSpawn:

			jmp HandleSpawning


		rts
	}


	Disable: {

		lda #0
		sta Active
		sta Spawning
		sta PosY
		sta SpriteY + OTTO.SpriteID
		sta CountActive

		lda #255
		sta DelayFrames + 1

		rts
	}

	SpawnOtto: {

		lda ROBOT.Active
		beq Skip

		inc Active

		lda #5
		sta Spawning

		lda #0
		sta JumpProgress
		sta Frame

		lda #SpawnFrameTime
		sta FrameTimer

		ldx PLAYER.SpawnSide

		lda SpawnPointX, x
		sta PosX_LSB

		lda #0
		sta PosX_MSB
		sta XMovementPixel
		sta XMovementFrac

		lda SpawnPointY, x
		sta PosY


		lda #JumpFrameStart
		sta JumpFrames

		jsr UpdateSprite



		Skip:

	
		rts
	}

	UpdateSprite: {

		lda PosX_LSB
		clc
		adc #24
		sta SpriteX + SpriteID

		lda #0
		adc #0
		sta PosX_MSB

		lda PosY
		sta SpriteY + SpriteID

		lda PosX_MSB
		sta SpriteMSB + SpriteID

		ldy #SpriteID
		jsr UTILITY.StoreMSBColourY
	
		lda Frame
		clc
		adc #StartPointer
		sta SpritePointer + SpriteID

		lda ROBOT.CurrentColour
		sta SpriteColor + SpriteID

		rts
	}




	FrameUpdate: {



		lda CountActive
		beq NotYet

		lda Active
		bne Handle

		lda ROBOT.Active
		beq NotYet

		lda DelayFrames
		sec
		sbc #1
		sta DelayFrames

		lda DelayFrames + 1
		sbc #0
		sta DelayFrames + 1
		bne NotYet

		lda DelayFrames
		bne NotYet

			jmp SpawnOtto

		NotYet:

			rts 




		Handle:

			jmp HandleOtto




		
	}

	CalculateFrames: {


		lda ROBOT.StartCount
		clc
		adc X_Value
		clc
		adc BULLET.MaxBullets
		sec
		sbc #2
		sta DelayFrames
		sta ZP.Temp3

		ldx #0
		stx DelayFrames + 1

		Loop:

			lda DelayFrames
			clc
			adc DelayFrames
			sta DelayFrames

			lda DelayFrames + 1
			adc DelayFrames + 1
			sta DelayFrames + 1

			inx
			cpx #5
			bcc Loop


		lda DelayFrames
		clc
		adc ZP.Temp3
		sta DelayFrames

		lda DelayFrames + 1
		adc #0
		sta DelayFrames + 1

		lda #50
		//sta DelayFrames

		lda #0
		//sta DelayFrames + 1

		

		rts
	}

}