.namespace ACTOR {
.namespace PLAYER {


	* = * "-Player"

	PacmanSteps:
	Level_1P:	.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1		
				.byte 1,1,1,1,2,1,1,1,1,1,1,1,2,1,1,1

	Level_2_4P:	.byte 1,1,1,1,2,1,1,1,1,1,1,1,2,1,1,1
				.byte 1,1,1,2,1,1,1,1,2,1,1,1,1,1,2,1
			
	Level_5_20P: .byte 1,1,2,1,1,1,2,1,1,1,2,1,1,1,2,1
				 .byte 1,1,2,1,1,1,2,1,1,1,2,1,1,1,2,1
				
	Level_21P:	.byte 1,1,1,1,2,1,1,1,1,1,1,1,2,1,1,1
				.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

	BigPacman:	.byte 1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1

	Alarms:			.byte 1, 2, 3, 5
	AlarmPellets:	.byte 74, 180, 212
	StatusStepLookup:	.byte 0, 16
	FrameLookup:		.byte 17, 22, 23, 22
						.byte 17, 20, 21, 20
						.byte 17, 24, 25, 24
						.byte 17, 18, 19, 18


	LevelStepLookup:	.byte 0, 32, 32, 32
						.fill 16, 64

	IsMoving:			.byte 0
	EatFramesLeft:		.byte 0
	AxisOfMotion:		.byte 0
	AxisPerpendicular:	.byte 0
	Stopped:			.byte 0
	LastMove:			.byte 0				
	LevelStep: 			.byte 0
	Invincible:			.byte 0
	PelletsEaten:		.byte 0
	AlarmStatus:		.byte 0
	Waiting:			.byte MAIN.StartWait


	.label GhostScoreStartID = 1
	.label PelletsToEat =  244


	ResetPacman: {

		lda #0
		sta ZP.RandomSeed
		sta GHOST.IsBigPacman

		lda #$80
		sta ZP.RandomSeed + 1
		

		lda Start_X
		sta PixelX

		lda Start_Y
		sta PixelY

		lda Start_Dir
		sta Direction

		lda #0
		sta IsMoving
		sta EatFramesLeft
		sta InTunnel
		sta InTunnel + 1
		sta InTunnel + 2
		sta InTunnel + 3
		sta InTunnel + 4

		jsr CalculateLevelStep

		ldx #PACMAN
		jsr SetDirectionFromEnum
		jsr CommitPosition

		jsr UpdateSprite

		rts
	}


	NewLevel: {

		lda #0
		sta AlarmStatus
		sta PelletsEaten

		sta GHOST.WaitForClyde
		sta GHOST.Elroy


		rts
	}


	FrameUpdate: {


		jsr Control
		jsr GetNumberOfSteps

		ldx #0
		stx LastMove

		Loop:
			
			stx ZP.PacSteps
			//stx SCREEN_RAM

			lda Waiting
			beq Okay

			dec Waiting
			jmp NoMove

			Okay:

			jsr Step
			jsr Steer
			jsr CheckEat

			lda MAIN.GameMode
			cmp #GAME_MODE_COMPLETE
			beq NoMove

			jsr FRUIT.Check

			EndLoop:
			
			ldx ZP.PacSteps
			inx
			cpx ZP.Steps
			bcc Loop

		NoMove:

		
		jsr UpdateFrames
		jsr UpdateSprite

		rts
	}

	
	

	CalculateLevelStep: {



		lda #96
		sta LevelStep

		lda #124
		sta ACTOR.GHOST.ElroyDots1

		lda #184
		sta ACTOR.GHOST.ElroyDots2

		ldx GAME.Level
		cpx #21
		bcs UseHighest
		dex

		lda LevelStepLookup, x
		sta LevelStep

		lda ACTOR.GHOST.ElroyDots_1, x
		sta ACTOR.GHOST.ElroyDots1

		lda ACTOR.GHOST.ElroyDots_2, x
		sta ACTOR.GHOST.ElroyDots2
		

		UseHighest:

		rts
	}



	GetNumberOfSteps: {


		ldx ENERGIZER.IsActive
		lda StatusStepLookup, x
		clc
		adc LevelStep
		sta ZP.Steps

		lda Frames
		and #%00001111
		clc
		adc ZP.Steps
		tax

		lda PacmanSteps, x
		sta ZP.Steps
		sta ZP.PixelsThisFrame


		rts
	}

	
	


	AttractAI: {


		ldx #0
		stx ZP.GhostID

		lda #GHOST_GOING_HOME
		sta GHOST.Mode, x

		jsr GHOST.CheckUpdateFaceDirection
		jsr GHOST.RotateAboutFace
		jsr ACTOR.GetOpenTiles

		lda GHOST.Scared + 1
		beq RunAway

		Target:

			lda TileX + 2
			sta GHOST.TargetTileX

			lda TileY + 2
			sta GHOST.TargetTileY

			jmp DecideTurn

		RunAway:

	
			lda TileX + 2
			sec
			sbc TileX
			bpl NoReverse

			ReverseSign()
			lsr
			jmp AddToX

			NoReverse:

			lsr
			ReverseSign()

		AddToX:

			clc
			adc TileX
			sta GHOST.TargetTileX


			lda TileY + 2
			sec
			sbc TileY
			bpl NoReverse2

			ReverseSign()
			lsr
			jmp AddToY

			NoReverse2:

			lsr
			ReverseSign()

		AddToY:

			clc
			adc TileY
			sta GHOST.TargetTileY





		DecideTurn:	

			ldx ZP.GhostID
			jsr GHOST.ChooseTurn


			jsr GHOST.RotateAboutFace






		rts
	}



	Steer: {

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERMISSION
		beq Finish

		lda NextDirection
		bmi Finish

		
		ldx #PACMAN
		jsr IsPotentialNextTileFloor
		beq Finish

		lda NextDirection
		sta Direction

		lda #0
		sta Stopped

		ldx #PACMAN
		jsr SetDirectionFromEnum


		Finish:


		rts
	}

	
}

}