.namespace ACTOR { 


.namespace GHOST {

	* = * "-Ghost"
						
	LevelStep: 			.byte 0
	ThisLevelStep:		.byte 0
	OpenTiles:			.fill 4, 0

	SignalReverse:		.fill MAX_ACTORS, 0
	SignalLeaveHome:	.fill MAX_ACTORS, 0

	EatenInRow:			.byte 0
	PointsFramesLeft:	.byte 0
	EatenID:			.byte 0

	* = * "Mode"
	Mode:				.fill MAX_ACTORS, 0
	Scared:				.fill MAX_ACTORS, 0
	// InTunnel:			.fill MAX_ACTORS, 0
	OppositeDirection:	.fill MAX_ACTORS, 0
	NewDirection:		.fill MAX_ACTORS, 0
	StartPixelX:		.fill MAX_ACTORS, 0
	StartPixelY:		.fill MAX_ACTORS, 0
	Targeting:			.fill MAX_ACTORS, 0

	TargetTileX:		.fill MAX_ACTORS, 0
	TargetTileY:		.fill MAX_ACTORS, 0

	NextTileX:			.fill MAX_ACTORS, 0
	NextTileY:			.fill MAX_ACTORS, 0
	IsBigPacman:		.fill MAX_ACTORS, 0

	.label DOOR_TILE_X = 13
	.label DOOR_TILE_Y = 14
	.label DOOR_PIXEL_X = ((DOOR_TILE_X + 1) * TILE_SIZE) - 1
	.label DOOR_PIXEL_Y = ((DOOR_TILE_Y + 0) * TILE_SIZE) + MID_TILE_Y
	.label HOME_TOP_PIXEL = 17 * TILE_SIZE
	.label HOME_BOTTOM_PIXEL = 18 * TILE_SIZE
	.label RIGHT_AI_TILE_X = MID_TILE_X + 1
	.label LEFT_AI_TILE_X = MID_TILE_X - 1
	.label UP_AI_TILE_Y = MID_TILE_Y - 1
	.label DOWN_AI_TILE_Y = MID_TILE_Y + 1
	.label NUM_GHOSTS = 4
	.label ScorePointer = 106

	Elroy:				.byte 0
	WaitForClyde:		.byte 0
	ElroyDots1:			.byte 0
	ElroyDots2:			.byte 0
	ElroyLevelStep:		.byte 0
	ElroyLookup:		.byte 0, 32


	Reset: {	



		lda Start_X, x
		sta PixelX, x
		sta StartPixelX, x

		lda Start_Y, x
		sta PixelY, x
		sta StartPixelY, x

		lda Start_Dir, x
		sta Direction, x

		lda StartLook, x
		sta NextDirection, x

		lda Start_Mode, x
		sta Mode, x

		jsr SetDirectionFromEnum

		lda #0
		sta SignalReverse, x
		sta SignalLeaveHome, x
		sta Scared, x
		sta InTunnel, x
		sta Targeting, x
		sta IsBigPacman, x
	

	

		ldx ZP.GhostID
		jsr CommitPosition

		rts


	}


	CheckElroy: {

		lda WaitForClyde
		beq NotWaitingClyde

		lda #0
		sta Elroy

		lda InTunnel + CLYDE
		bne Finish

		lda Mode + CLYDE
		cmp #GHOST_PACING_HOME
		beq Finish

		lda #0
		sta WaitForClyde

	NotWaitingClyde:

		lda ACTOR.PLAYER.PelletsEaten
		cmp ElroyDots2
		bcc NotElroy2

		IsElroy2:

			lda #2
			sta Elroy
			rts

		NotElroy2:

			cmp ElroyDots1
			bcc Finish

		IsElroy1:

			lda #1
			sta Elroy

		Finish:


		rts
	}


	ResetAll: {

		ldx #1

		Loop:

			stx ZP.GhostID

			jsr Reset
			jsr UpdateSprite

		EndLoop:

			ldx ZP.GhostID

			inx
			cpx #NUM_GHOSTS + 1
			bcc Loop



		jsr CalculateLevelSteps

		rts
	}


	RotateAboutFace: {

		lda Direction, x
		tay
		lda DirectionReverse, y
		sta OppositeDirection, x

		rts
	}



	CalculateLevelSteps: {


		lda #144
		sta LevelStep

		lda #96
		sta ElroyLevelStep

		ldx GAME.Level
		cpx #21
		bcs UseHighest
		dex

		lda LevelStepLookup, x
		sta LevelStep

		lda ElroyStepLookup, x
		sta ElroyLevelStep

		UseHighest:


		rts
	}


	OnEnergized: {

		sta ZP.Amount

		ldx #1
		lda #1

		Loop:

			lda #1
			sta SignalReverse, x

			lda ZP.Amount
			beq EndLoop

			lda Mode, x
			cmp #GHOST_GOING_HOME
			beq EndLoop

			cmp #GHOST_ENTERING_HOME
			beq EndLoop

			lda #1
			sta Scared, x

			lda #0
			sta Targeting, x

		EndLoop:

			inx
			cpx #5
			bcc Loop

		lda #0
		sta EatenInRow

	
		rts
	}


	ReturnToNormal: {

		ldx #1
		
		Loop:

			lda #0
			sta Scared, x

		EndLoop:

			inx
			cpx #5
			bcc Loop



		rts
	}



	DeadUpdate: {

		lda #1
		sta DrawSprites

		lda ACTOR.PLAYER.DeathProgress
		bne Hide

		ldx #1

		Loop:



			jsr UpdateFrames
			jsr UpdateSprite

			inx
			cpx #5
			bcc Loop

			rts


		Hide:

		lda #0
		sta DrawSprites




		rts
	}



	

	GetFrameSteps: {

		cpx #BLINKY
		bne NotBlinky

		lda Scared, x
		bne NotBlinky

		lda InTunnel, x
		bne NotBlinky

		CheckElroy:

			ldy Elroy
			beq NotBlinky

		IsElroy:

			dey
			lda ElroyLookup, y
			clc
			adc ElroyLevelStep
			sta ZP.Steps

			lda Frames, x
			and #%00001111
			clc
			adc ZP.Steps
			tax

			lda ElroySteps, x
			sta ZP.Steps

			rts

		NotBlinky:

		
			NotBlinky2:

			lda Frames, x
			and #%00001111
			clc
			adc ThisLevelStep
			tax

			lda GhostSteps, x
			sta ZP.Steps


		Finish:

		rts
	}


	GetNumberOfSteps: {

		lda Pause, x
		beq NotPaused

		Waiting:

			dec Pause, x
			lda #0
			sta ZP.Steps
			rts

		NotPaused:

		lda LevelStep
		sta ThisLevelStep

		CheckGoingHome:

			lda Mode, x
			cmp #GHOST_GOING_HOME
			bne NotGoingHome

		GoingHome:

			lda #2
			sta ZP.Steps
			rts

		NotGoingHome:

			cmp #GHOST_ENTERING_HOME
			bne NotEnteringHome

			lda #2
			sta ZP.Steps
			rts

		NotEnteringHome:

			cmp #GHOST_LEAVING_HOME
			bne NotLeavingHome

		LeavingHome:

			lda #32
			sta ThisLevelStep
			jmp GetFrameSteps

		NotLeavingHome:

			cmp #GHOST_PACING_HOME
			bne NotPacingHome

		PacingHome:

			lda #32
			sta ThisLevelStep
			jmp GetFrameSteps


		NotPacingHome:

			lda Scared, x
			beq NotScared

			lda #16
			clc
			adc ThisLevelStep
			sta ThisLevelStep

			jmp NotTunnel


		NotScared:

			lda InTunnel, x
			beq NotTunnel

			lda #32
			clc
			adc ThisLevelStep
			sta ThisLevelStep

		NotTunnel:

			jsr GetFrameSteps


		rts
	}



	Priority_On:		.byte %00000001, %00001000, %00000100,%00000010,%00000001
	Priority_Off:		.byte %11111110, %11110111, %11111011,%11111101,%11111110


	Process: {

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERMISSION
		bne NotIntermission

		lda PixelY, x
		cmp #200
		beq Paused

		jmp DoIntermission


		NotIntermission:

			lda READY.GameStarted
			beq Skip

			lda GAME.Active
			beq Paused

		DoIntermission:

			jsr GetNumberOfSteps

			ldx ZP.GhostID

		CheckEaten:

			lda Mode, x
			cmp #GHOST_EATEN
			bne NotEaten

			jmp Paused

		NotEaten:

			lda ZP.Steps
			beq NoSteps

			ldy #0
	
		Loop:
			
			sty ZP.Y

			jsr MoveInCurrentDirection

			lda MAIN.GameMode
			cmp #GAME_MODE_INTERMISSION
			beq SkipPriority

			cmp #GAME_MODE_PLAY
			beq DoTunnel

			//lda INTERMISSION.ID
			//bne SkipPriority

		DoTunnel:


			lda InTunnel, x
			bne EndLoop

			lda TITLE.SpritePriority
			and Priority_Off, x
			sta TITLE.SpritePriority
		
			jsr Steer

			jmp SkipPriority

		EndLoop:

			lda TITLE.SpritePriority
			ora Priority_On, x
			sta TITLE.SpritePriority
		
		SkipPriority:

			ldy ZP.Y
			iny
			cpy ZP.Steps
			bcc Loop

		NoSteps:


		jsr UpdateFrames

		Paused:

		jsr UpdateSprite

		Skip:

		rts
	}


	DuringEaten: {

		lda PointsFramesLeft
		beq Restart

		dec PointsFramesLeft
		jmp Continue

		Restart:

			lda MAIN.PreviousMode
			cmp #GAME_MODE_PLAY
			beq ReturnToGame

		ReturnToInter:

			lda #GAME_MODE_INTERMISSION
			sta MAIN.GameMode

			ldx EatenID
			lda #200
			sta PixelY, x
			rts

		ReturnToGame:

			lda #GAME_MODE_PLAY
			sta MAIN.GameMode

			jsr PlayRetreat

			ldx EatenID
			lda #GHOST_GOING_HOME
			sta Mode, x
			rts

		Continue:

			lda #1
			sta DrawSprites

			ldx #1

		Loop:

			stx ZP.GhostID

			lda Mode, x
			cmp #GHOST_GOING_HOME
			beq Okay

			cmp #GHOST_ENTERING_HOME
			beq Okay

			jsr UpdateSprite
			jmp EndLoop

		Okay:

			jsr Process


		EndLoop:

			ldx ZP.GhostID
			inx
			cpx #NUM_GHOSTS  + 1
		//	cpx #3
			bcc Loop

		rts




	}

	FrameUpdate: {

		lda #1
		sta DrawSprites

		ldx #1

		Loop:

			stx ZP.GhostID

			jsr Process


		EndLoop:

			ldx ZP.GhostID

			inx
			cpx #NUM_GHOSTS  + 1
		//	cpx #3
			bcc Loop

		

		rts
	}


	DebugColours:	.byte YELLOW, RED, LIGHT_RED, CYAN, ORANGE

	ShowDebug: {

		lda MAIN.DebugMode
		bne DoIt

		rts

		DoIt:

		lda #0
		.for(var i=0; i<25; i++) {
			
			sta SCREEN_RAM + (i * 40)
			sta SCREEN_RAM + (i * 40) + 1
			sta SCREEN_RAM + (i * 40) + 2
			sta SCREEN_RAM_2 + (i * 40)
			sta SCREEN_RAM_2 + (i * 40) + 1
			sta SCREEN_RAM_2 + (i * 40) + 2

		}
		


		ldx #1

		ldy #1	
		Loop:

		
			lda #0
			sta ZP.RandomAddress

			lda TargetTileX, x
			bpl TensLoop

			pha

			lda #45
			sta SCREEN_RAM_2 - 1, y
			sta SCREEN_RAM - 1, y

			pla
			ReverseSign()

		
		TensLoop:

			cmp #10
			bcc FinishTens

			inc ZP.RandomAddress
			sec
			sbc #10
			jmp TensLoop

		FinishTens:

			clc
			adc #48
			sta SCREEN_RAM + 1, y
			sta SCREEN_RAM_2 + 1, y

			lda DebugColours, x
			sta VIC.COLOR_RAM + 1, y
			sta VIC.COLOR_RAM + 0, y

			lda ZP.RandomAddress
			clc
			adc #48
			sta SCREEN_RAM, y
			sta SCREEN_RAM_2, y

			
			tya
			clc
			adc #40
			tay

		EndLoop:

			inx
			cpx #5
			bcc Loop


		ldx #1
		
		ldy #1
		

		Loop2:	

			
			lda #0
			sta ZP.RandomAddress

			lda TargetTileY, x
			bpl TensLoop2

			pha
			
			lda #45
			sta SCREEN_RAM_2 - 1, y
			sta SCREEN_RAM - 1, y

			pla
			ReverseSign()

		TensLoop2:

			cmp #10
			bcc FinishTens2

			inc ZP.RandomAddress
			sec
			sbc #10
			jmp TensLoop2

		FinishTens2:

			clc
			adc #48
			sta SCREEN_RAM + 241, y
			sta SCREEN_RAM_2 + 241, y

			lda DebugColours, x
			sta VIC.COLOR_RAM + 241, y
			sta VIC.COLOR_RAM + 240, y

			lda ZP.RandomAddress
			clc
			adc #48
			sta SCREEN_RAM + 240, y
			sta SCREEN_RAM_2 + 240, y

			
			tya
			clc
			adc #40
			tay

			inx
			cpx #5
			bcc Loop2


	PacX:

			ldy #1

			lda #0
			sta ZP.RandomAddress

			lda TileX
			
			
		TensLoop3:

			cmp #10
			bcc FinishTens3

			inc ZP.RandomAddress
			sec
			sbc #10
			jmp TensLoop3

		FinishTens3:

			clc
			adc #48
			sta SCREEN_RAM + 481, y
			sta SCREEN_RAM_2 + 481, y

			lda #7
			sta VIC.COLOR_RAM + 481, y
			sta VIC.COLOR_RAM + 480, y

			lda ZP.RandomAddress
			clc
			adc #48
			sta SCREEN_RAM + 480, y
			sta SCREEN_RAM_2 + 480, y
			
	PacY:

			ldy #1

			lda #0
			sta ZP.RandomAddress

			lda TileY
			
			
		TensLoop4:

			cmp #10
			bcc FinishTens4

			inc ZP.RandomAddress
			sec
			sbc #10
			jmp TensLoop4

		FinishTens4:

			clc
			adc #48
			sta SCREEN_RAM + 521, y
			sta SCREEN_RAM_2 + 521, y

			lda #8
			sta VIC.COLOR_RAM + 521, y
			sta VIC.COLOR_RAM + 520, y

			lda ZP.RandomAddress
			clc
			adc #48
			sta SCREEN_RAM + 520, y
			sta SCREEN_RAM_2 + 520, y



	BlinkX:

			ldy #1

			lda #0
			sta ZP.RandomAddress

			lda TileX + 1
			
			
		TensLoop5:

			cmp #10
			bcc FinishTens5

			inc ZP.RandomAddress
			sec
			sbc #10
			jmp TensLoop5

		FinishTens5:

			clc
			adc #48
			sta SCREEN_RAM + 601, y
			sta SCREEN_RAM_2 + 601, y

			lda #RED
			sta VIC.COLOR_RAM + 601, y
			sta VIC.COLOR_RAM + 600, y

			lda ZP.RandomAddress
			clc
			adc #48
			sta SCREEN_RAM + 600, y
			sta SCREEN_RAM_2 + 600, y
			
	BlinkY:

			ldy #1

			lda #0
			sta ZP.RandomAddress

			lda TileY + 1
			
			
		TensLoop6:

			cmp #10
			bcc FinishTens6

			inc ZP.RandomAddress
			sec
			sbc #10
			jmp TensLoop6

		FinishTens6:

			clc
			adc #48
			sta SCREEN_RAM + 641, y
			sta SCREEN_RAM_2 + 641, y

			lda #LIGHT_RED
			sta VIC.COLOR_RAM + 641, y
			sta VIC.COLOR_RAM + 640, y

			lda ZP.RandomAddress
			clc
			adc #48
			sta SCREEN_RAM + 640, y
			sta SCREEN_RAM_2 + 640, y



		rts
	}

	


	UpdateMovementDirection: {

		lda SignalReverse, x
		beq NoReverse

		lda OppositeDirection, x
		sta NextDirection, x

		dec SignalReverse, x

		NoReverse:

		lda NextDirection, x
		sta Direction, x

		jsr SetDirectionFromEnum

		ldx ZP.GhostID


		rts
	}


	IsScared: {

		GetRandomDirection:

			jsr PAC_RAND.Get
			and #%00000011

			tay

		TryAgain:

		lda OpenTiles, y
		bne DirectionOk

		iny
		cpy #4
		bcc TryAgain

		ldy #0
		jmp TryAgain


	DirectionOk:

		tya
		sta NextDirection, x

		lda #0
		sta Targeting, x

		rts
	}


	


	ConstrainGhostTurns: {

		lda #0
		sta ZP.Amount

		CheckX:

			lda NextTileX, x
			cmp #12
			bne Not12

			jmp CheckY

		Not12:

			cmp #15
			bne Finish

		CheckY:

			lda NextTileY, x
			cmp #14
			bne Not14

			jmp TurnOffUp

		Not14:

			cmp #26
			bne Finish

		TurnOffUp:

			lda #0
			sta OpenTiles


		Finish:

		rts
	}

	







}


}