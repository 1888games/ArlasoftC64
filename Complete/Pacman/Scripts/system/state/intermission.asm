INTERMISSION: {


	* = * "INTERMISSION"

	.label DIR_UP = 0
	.label DIR_LEFT = 1
	.label DIR_DOWN = 2
	.label DIR_RIGHT = 3


	#import "system/state/intermission_data.asm"

	StartIDs:		.byte 0, 10, 30, 80
	PacmanLevel:	.byte 1, 1, 1, 1
	GhostLevel:		.byte 2, 2, 2, 2

	EndIDs:			.byte 10, 30, 80, 95
	BlockChars:		.byte 255, 255, 255, 255

	ID:				.byte 0
	EndID:			.byte 0

	CurrentIDs:		.fill 5, 0
	TimeLeft:		.fill 5, 0
	Pointers:		.fill 5, 0
	Frames:			.fill 5, 0
	CurrentFrame:	.fill 5, 0
	Colours:		.fill 5, 0

	SpriteMulti:	.byte BLUE


	Levels:			.byte 2, 5, 9, 13, 17
	//Levels:			.byte 1, 2, 3, 4, 5
	IDs:			.byte 1, 2, 3, 3, 3
	Intermission:	.byte 0

	Initialise: {

		lda #BLUE
		sta SpriteMulti

		lda #GAME_MODE_INTERMISSION
		sta MAIN.GameMode


		jsr ResetSprites

		

		
		//ldx #3
		stx ID
		cpx #0
		beq KeepPill

		RealIntermission:

			jsr SFX_KIT_CLR

			lda #MAIN.SONG_INTERMISSION
			jsr sid.init

			jsr SCROLLER.SetToScreen0

			jsr UTILITY.ClearScreen
			

			lda #BLACK
			sta SCREEN_RAM + 649

		KeepPill:

		lda #9
		ldx #29
		jsr UTILITY.BlockBorders
		
		lda #0
		sta ACTOR.PLAYER.Stopped
		sta ACTOR.GHOST.EatenInRow
		sta ENERGIZER.IsActive
		sta ENERGIZER.Scared
		sta ACTOR.GHOST.Elroy
		sta ACTOR.GHOST.Scared
		sta ACTOR.GHOST.Scared + 1
		sta ACTOR.GHOST.Scared + 2
		sta ACTOR.GHOST.Scared + 3
		sta ACTOR.GHOST.Scared + 4

		lda #GHOST_OUTSIDE
		sta ACTOR.GHOST.Mode
		sta ACTOR.GHOST.Mode + 1
		sta ACTOR.GHOST.Mode + 2
		sta ACTOR.GHOST.Mode + 3
		sta ACTOR.GHOST.Mode + 4


		ldx ID

		lda GAME.Level
		sta GAME.BackupLevel

		lda GhostLevel, x
		sta GAME.Level
		jsr ACTOR.GHOST.CalculateLevelSteps

		ldx ID
		lda PacmanLevel, x
		sta GAME.Level

		jsr ACTOR.PLAYER.CalculateLevelStep

		lda #DIR_LEFT
		sta ACTOR.NextDirection
		sta ACTOR.Direction

		ldx #PACMAN
		jsr ACTOR.SetDirectionFromEnum

		ldx ID

		lda EndIDs, x
		sta EndID

		lda BlockChars, x
		sta TITLE.SpritePriority

		lda StartIDs, x
		sta CurrentIDs
	
		tay
		iny
		sty CurrentIDs + 1
		iny
		sty CurrentIDs + 2
		iny
		sty CurrentIDs + 3
		iny
		sty CurrentIDs + 4

		jsr GetSteps

		lda #1
		sta READY.GameStarted

		lda #0
		sta SCROLLER.PixelScroll




		rts
	}

	ResetSprites: {


		lda #255
		sta SpriteY
		sta SpriteY + 1
		sta SpriteY + 2
		sta SpriteY + 3
		sta SpriteY + 4
		sta SpriteCopyY
		sta SpriteCopyY + 1
		sta SpriteCopyY + 2
		sta SpriteCopyY + 3
		sta SpriteCopyY + 4

		lda #200
		sta ACTOR.PixelY
		sta ACTOR.PixelY + 1
		sta ACTOR.PixelY + 2
		sta ACTOR.PixelY + 3
		sta ACTOR.PixelY + 4

	

		rts
	}


	CheckIfIntermission: {

		lda GAME.Level

		ldy Intermission
		cpy #5
		beq NoIntermission

		lda Levels, y
		cmp GAME.Level
		bne NoIntermission

		inc Intermission

		lda IDs, y
		tax

		jmp Initialise


		NoIntermission:





		rts
	}

	Cancel: {

		lda #BLUE
		sta SpriteMulti

		ldx #0

		Loop:
			lda #200
			sta ACTOR.PixelY, x


			inx
			cpx #5
			bcc Loop


		lda #GAME_MODE_TITLE
		sta MAIN.GameMode



		rts
	}


	GetSteps: {

		ldx #0

		Loop:

		
			lda CurrentIDs, x
			tay


			jsr GetStep


			inx
			cpx #5
			bcc Loop


		rts
	}


	IntermissionDone: {

		lda #BLUE
		sta SpriteMulti

		lda ID
		cmp #INTERMISSION_TITLE
		bne NotTitle

		TitleIntermission:

			lda #GAME_MODE_TITLE
			sta MAIN.GameMode

			lda #200
			sta ACTOR.PixelY

			lda #1
			sta GAME.AttractMode
			
			jmp MAIN.ResetGame
		

		NotTitle:


			lda GAME.BackupLevel
			sta GAME.Level

			lda #MAIN.SONG_BLANK
			jsr sid.init

			lda #GAME_MODE_COMPLETE
			sta MAIN.GameMode

			jsr ResetSprites

			jsr MAIN.NewLevel

	


		rts
	}

	GetStep: {

		cpy EndID
		bcc Continue

		jmp IntermissionDone

		Continue:


		cpx #0
		bne NotPacman2

		sty TITLE.FirstEaten

		lda #BLACK
		sta VIC.COLOR_RAM + 649

		NotPacman2:


		lda Direction, y
		bpl IsValidDirection

		CancelSprite:

			lda #200
			sta ACTOR.PixelY, x

			jmp SamePosition

		IsValidDirection:

			sty ZP.StoredYReg

			sta ACTOR.Direction, x
			sta ACTOR.NextDirection, x

			lda Pointer, y
			sta Pointers, x

			cmp #44
			bcc NotCaught

			cmp #46
			bcs NotCaught

			lda #%11110000
			sta TITLE.SpritePriority

		NotCaught:


			lda IsBigPacman, y
			sta ACTOR.GHOST.IsBigPacman, x
			beq NotBigPacman

			lda #112
			sta ACTOR.PLAYER.LevelStep


		NotBigPacman:

			lda Frame, y
			sta Frames, x

			lda #0
			sta CurrentFrame, x

			lda Delay, y
			sta ACTOR.Pause, x
			cpx #0
			bne NotPacman

			sta ACTOR.PLAYER.Waiting

			NotPacman:

			lda IsScared, y
			sta ACTOR.GHOST.Scared, x
			beq NotEnergized

				lda #1
				sta ENERGIZER.IsActive

			NotEnergized:

				lda X, y
				cmp #255
				beq SamePosition

				sta ACTOR.PixelX, x

				lda Y, y
				sta ACTOR.PixelY, x

				jsr ACTOR.CommitPosition
				ldy ZP.StoredYReg

				lda ID
				cmp #2
				bne NotNeeded

				jsr ACTOR.GHOST.UpdateFrames.IntermissionPointer


				ldy ZP.StoredYReg

				NotNeeded:


			SamePosition:
		
			lda Time, y
			sta TimeLeft, x

			lda #0
			sta ACTOR.DistToMidY, x



		rts
	}

	AtePellet: {







		rts
	}

	FrameUpdate: {



		ldx #0

		Loop:

			lda TimeLeft, x
			beq DoNextStep

			cpx #0
			bne NotPacman

			ldy ID
			bne NotPacman

			cmp #50
			bne NotPacman

			lda TITLE.SpritePriority
			ora #%00010000
			sta TITLE.SpritePriority


		NotPacman:

			dec TimeLeft, x
			jmp EndLoop


		DoNextStep:

			lda CurrentIDs, x
			clc
			adc #5
			sta CurrentIDs, x
			tay

			cpy #66
			beq Torn

			cpy #86
			beq Torn

			jmp NotTorn

		Torn:

			lda #LIGHT_RED
			sta SpriteMulti

		NotTorn:

			jsr GetStep



			EndLoop:

			inx
			cpx #5
			bcc Loop


		lda ID
		bne NotTitle

		jsr TITLE.Control

		NotTitle:

		rts
	}



}