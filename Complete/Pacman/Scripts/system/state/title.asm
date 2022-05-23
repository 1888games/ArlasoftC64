TITLE: {

	* = * "TITLE"
	.label STATE_GHOST = 0
	.label STATE_POINTS = 1
	.label STATE_REST_TEXT = 2
	.label STATE_ANIMATION = 3
	.label STATE_WAIT = 4
	.label STATE_PUSH_START = 5
	.label STATE_BUSY = 6



	.label COLUMNS = 23
	.label ROWS = 23
	.label GHOST_Y_OFFSET = 47
	.label GHOST_X_OFFSET = 24

	.label START_COLUMNS = 27
	.label START_ROWS = 13

	.label PAUSE_FACTOR = 1

	.label LONG_PAUSE = 55
	.label SHORT_PAUSE = 25

	GhostProgress:		.byte 0
	GhostRow:			.byte 0
	OverallProgress:	.byte 255
	Timer:				.byte 0
	Credits:			.byte 0

	FlashState:			.byte 0
	FlashTimer:			.byte 0
	FirstEaten:			.byte 0


	GhostRows:		.byte 4, 7, 10, 13
	GhostColours:	.byte RED, LIGHT_RED, CYAN, ORANGE

	StartColours:	.byte ORANGE
					.fill 3, 0
					.byte CYAN
					.fill 3, 0
					.byte LIGHT_RED
					.fill 3,0 
					.byte PURPLE
 

	.label StartRow = 11
	.label StartColumn = 7
	.label StartChars = 27

	.label FlashInterval = 8

	StartRows:		.fill 4, StartRow + (i*3)

	GhostPixelY:	.byte GHOST_Y_OFFSET + (4 * 8)
					.byte GHOST_Y_OFFSET + (7 * 8)
					.byte GHOST_Y_OFFSET + (10 * 8)
					.byte GHOST_Y_OFFSET + (13 * 8)

	.label GhostPixelX = GHOST_X_OFFSET + (9*8)

	GhostTimes:		.byte LONG_PAUSE * PAUSE_FACTOR, SHORT_PAUSE * PAUSE_FACTOR, SHORT_PAUSE * PAUSE_FACTOR

	GhostX:			.byte 0, 12, 23
	GhostChars:		.byte 0, 11, 8

	Debounce:		.byte 0

	TitleSpriteX:	.fill 4, 0
	TitleSpriteY:	.fill 4, 0
	TitleSpriteColor:	.fill 4,0 
	TitleSpritePointer:	.fill 4, 0

	SpritePriority:	.byte 0

	DebugKill:		.byte 0

	LivesText:		.text @"lives,"
	Lives:			.byte 51

	Initialise: {	

		lda #0
		sta GAME.KillScreen
		sta GAME.Invincible

		jsr SCORE.DrawP1_Digits
		jsr SCORE.DrawHighDigits

		jsr SCROLLER.SetToScreen0

		jsr UTILITY.ClearScreen

		jsr LoadScreen


		lda #9
		ldx #29
		jsr UTILITY.BlockBorders



		lda #40 * PAUSE_FACTOR
		sta Timer
		sta Debounce

		lda #0
		sta Credits
		sta BOTTOM_HUD.ShowLives
		sta ENERGIZER.IsActive
		sta FlashState
		sta FirstEaten
		sta SpritePriority
		

		lda #FlashInterval
		sta FlashTimer

		lda #255
		sta OverallProgress
		sta GhostProgress
		sta GhostRow


		ldx #0

		Loop:

			sta TitleSpriteX, x
			sta TitleSpriteY, x
			sta SpriteY, x
			sta SpriteX, x
			inx
			cpx #4
			bcc Loop

		lda MAIN.DebugMode
		beq NoLevel

			lda GAME.StartLevel
			clc
			adc #48
			sta SCREEN_RAM

		NoLevel:


		rts
	}


	ShowPts: {

		lda #LIGHT_RED
		sta VIC.COLOR_RAM + (19*40) + 15
		sta VIC.COLOR_RAM + (21*40) + 15

		lda #WHITE
		
		ldx #0

		Loop:

			sta VIC.COLOR_RAM + (19*40) + 17, x
			sta VIC.COLOR_RAM + (21*40) + 17, x

			inx
			cpx #6
			bcc Loop

		lda #LONG_PAUSE * PAUSE_FACTOR
		sta Timer

		inc OverallProgress



		rts
	}

	ShowFinal: {

		lda #LIGHT_RED

		ldx #0

		Loop:

			sta VIC.COLOR_RAM + (24*40) + 9, x
			inx
			cpx #22
			bcc Loop

		inc OverallProgress

		sta VIC.COLOR_RAM + (16*40) + 9

		lda #LONG_PAUSE * PAUSE_FACTOR
		sta Timer

		

		rts
	}


	CopyData: {

		ldx #0
		ldy #0

		Loop:

			lda TitleSpriteX, x
			bmi Finish

			sta VIC.SPRITE_0_X, y

			lda TitleSpriteY, x
			sta VIC.SPRITE_0_Y, y

			lda TitleSpriteColor, x
			sta VIC.SPRITE_COLOR_0, x

			lda TitleSpritePointer, x
			sta SPRITE_POINTERS, x
			sta SPRITE_POINTERS_2, x


			inx
			iny
			iny
			cpx #4
			bcc Loop

		Finish:


		lda #255
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y
		
		lda #%00001111
		sta VIC.SPRITE_MULTICOLOR

		lda #WHITE
		sta VIC.SPRITE_MULTICOLOR_1

		lda #BLUE
		sta VIC.SPRITE_MULTICOLOR_2

		rts
	}



	ShowText: {

		lda GhostX, x
		sta ZP.Column

		lda GhostChars, x
		sta ZP.Amount

		ldy GhostRow
		lda GhostRows, y
		sta ZP.Row

		lda GhostColours, y
		sta ZP.Colour

		ldy ZP.Row
		ldx ZP.Column

		jsr PLOT.GetCharacter

		ldy #0

		Loop:

			lda ZP.Colour
			sta (ZP.ColourAddress), y
			iny
			cpy ZP.Amount
			bcc Loop




		rts
	}


	ShowPushStart: {


		
		sfx(SFX_COIN)

		inc Credits

		lda #STATE_PUSH_START
		sta OverallProgress

		lda #255
		ldx #0

		Loop2:

			sta TitleSpriteX, x
			sta TitleSpriteY, x
			inx
			cpx #4
			bcc Loop2


		jsr UTILITY.ClearScreen

		ldx #StartColumn
		ldy #StartRow

		jsr PLOT.GetCharacter

		ldy #0
		sty ZP.Row


		lda #<START_MAP
		sta ZP.SourceAddress

		lda #>START_MAP
		sta ZP.SourceAddress + 1

		Loop:


			lda (ZP.SourceAddress), y
			sta (ZP.ScreenAddress), y

			ldx ZP.Row
			lda StartColours, x
			sta (ZP.ColourAddress), y

			iny
			cpy #START_COLUMNS
			bcc Loop

			inc ZP.Row
			lda ZP.Row
			cmp #START_ROWS
			bcs Finish

			MovePointer(ZP.SourceAddress, START_COLUMNS)
			MovePointer(ZP.ScreenAddress, 40)
			MovePointer(ZP.ColourAddress, 40)

			ldy #0
			jmp Loop

		Finish:


		jsr DrawLives

		rts



	}


	DrawLives: {

		ldx #0

		.label Row = 5

		Loop:

			lda LivesText, x
			sta SCREEN_RAM + (Row * 40) + 17, x

			lda #YELLOW
			sta VIC.COLOR_RAM + (Row * 40) + 17, x

			inx
			cpx #7
			bcc Loop



		rts
	}


	Flash: {

		lda MAIN.GameMode
		cmp #GAME_MODE_READY
		bne Okay

		rts

		Okay:

		lda OverallProgress
		bmi DontFlash
		cmp #STATE_ANIMATION
		bcc DontFlash

		jmp FlashThem

		DontFlash:
		rts

		FlashThem:

			lda FlashTimer
			beq Ready

			dec FlashTimer
			rts

		Ready:

			lda #FlashInterval
			sta FlashTimer

			lda FlashState
			beq HidePills

		ShowPills:

			dec FlashState
		
			ldy FirstEaten
			beq ShowFirst

		HideFirst:

			lda #BLACK
			sta VIC.COLOR_RAM + 649
			sta SCREEN_RAM + 649

			lda #LIGHT_RED
			sta VIC.COLOR_RAM + 855
			rts
		
		ShowFirst:

			lda #LIGHT_RED
			sta VIC.COLOR_RAM + 649
			sta VIC.COLOR_RAM + 855

			rts

		
		HidePills:

			inc FlashState

			lda #BLACK
			sta VIC.COLOR_RAM + 649
			sta VIC.COLOR_RAM + 855

			rts
		
	}


	TitleIRQ: {

		:StoreState()

		lda SpritePriority
		sta VIC.SPRITE_PRIORITY

		jsr CopyData

		jsr Flash


	

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERMISSION
		beq IsAnimation

		cmp #GAME_MODE_EATEN
		bne IsJustTitle

		IsAnimation:

			lda #1
			sta GAME_SPRITES.Mode

			lda #<GAME_SPRITES.SpriteIRQ
			ldx #>GAME_SPRITES.SpriteIRQ
			ldy #164
			jsr IRQ.SetNextInterrupt

			jmp Finish

		IsJustTitle:
			
			lda IRQ.SidTimer
			cmp #IRQ.SidTime
			beq SkipSound
			
			jsr sid.play
			jsr SFX_KIT_IRQ

			SkipSound:

			lda #<IRQ.MainIRQ
			ldx #>IRQ.MainIRQ
			ldy #IRQ.MainIRQLine
			jsr IRQ.SetNextInterrupt

		Finish:

		asl VIC.INTERRUPT_STATUS

		:RestoreState()

		rti

	}

	HandleGhosts: {

		inc GhostProgress
		ldx GhostProgress
		cpx #3
		bcs NextGhostRow

		lda GhostTimes, x
		sta Timer

		jmp ShowText

		NextGhostRow:

		jsr NewGhostRow


		rts
	}


	NewGhostRow: {

		inc GhostRow

		lda #0
		sta GhostProgress
		
		ldy GhostRow
		cpy #4
		bcs FinishGhosts

		ContinueGhosts:

			lda GhostPixelY, y
			sta TitleSpriteY, y

			lda #GhostPixelX
			sta TitleSpriteX, y

			lda GhostColours, y
			sta TitleSpriteColor, y

			lda #88
			sta TitleSpritePointer, y

			lda GhostTimes
			sta Timer

			rts

		FinishGhosts:

			inc OverallProgress

			lda #LONG_PAUSE * PAUSE_FACTOR
			sta Timer



		rts
	}




	Control: {

		lda Debounce
		beq Ready

		dec Debounce
		rts

	Ready:

		ldy #1

		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		lda OverallProgress
		cmp #STATE_PUSH_START
		bcc GotoPushStart

		//lda #MAIN.SONG_ALARM_1
		//jsr sid.init

		lda #0
		sta GAME.AttractMode
			
		jmp MAIN.ResetGame
			

		GotoPushStart:
			
			jsr INTERMISSION.Cancel
			jsr ShowPushStart

		Finish:

			//jmp DoIt

			lda MAIN.DebugMode
			bne DoIt

			lda OverallProgress
			cmp #STATE_PUSH_START
			beq DoIt

			ldy #1
			//lda INPUT.JOY_UP_NOW, y
			lda #0
			beq NotKill

			lda GAME.KillScreen
			eor #%00000001
			sta GAME.KillScreen
			sta $d020

			lda #16
			sta Debounce

		NotKill:

			//lda INPUT.JOY_DOWN_NOW, y
			lda #0
			beq DoIt

			lda GAME.Invincible
			eor #%00000010
			sta GAME.Invincible
			sta $d020


			lda #16
			sta Debounce


		DoIt:

			lda OverallProgress
			cmp #STATE_PUSH_START
			bne NotLives

			ldy #1
			lda INPUT.JOY_UP_NOW, y
			clc
			adc INPUT.JOY_DOWN_NOW, y
			beq NotLives

		DoLives:

			lda #15
			sta Debounce

			lda Lives
			cmp #51
			beq MakeFive

		MakeThree:

			lda #51
			sta Lives
			jmp UpdateLives

		MakeFive:

			lda #53
			sta Lives


		UpdateLives:

			jsr DrawLives


		 NotLives:

		// 	ldy #1
		// 	lda INPUT.JOY_RIGHT_NOW, y
		// 	beq NotRight

		// 	lda GAME.StartLevel
		// 	cmp #9
		// 	beq Nope

		// 	lda #10
		// 	sta Debounce

		// 	inc GAME.StartLevel
		// 	lda GAME.StartLevel
		// 	clc
		// 	adc #48
		// 	sta SCREEN_RAM
		// 	rts

		// NotRight:

		// 	lda INPUT.JOY_LEFT_NOW, y
		// 	beq Nope

		// 	lda GAME.StartLevel
		// 	cmp #2
		// 	bcc Nope

		// 	lda #10
		// 	sta Debounce

		// 	dec GAME.StartLevel
		// 	lda GAME.StartLevel
		// 	clc
		// 	adc #48
		// 	sta SCREEN_RAM
		// 	rts

		Nope:

		rts
	}

	HandleAnimation: {

		lda #STATE_BUSY
		sta OverallProgress

		ldx #INTERMISSION_TITLE
		jsr INTERMISSION.Initialise



		rts
	}

	FrameUpdate: {

		jsr Control

		lda Timer
		beq Ready

		dec Timer
		rts



		Ready:

			lda OverallProgress
			bpl AlreadyStarted

			inc OverallProgress
			jmp NewGhostRow

		AlreadyStarted:

			bne NotGhosts

			jmp HandleGhosts

		NotGhosts:

			cmp #STATE_POINTS
			bne NotPts

			jmp ShowPts

		NotPts:

			cmp #STATE_REST_TEXT
			bne NotFinal

			jmp ShowFinal

		NotFinal:

			cmp #STATE_ANIMATION
			bne NotAnimation

			jmp HandleAnimation

		NotAnimation:

		rts
	}

	LoadScreen: {	


		ldx #9
		ldy #2

		jsr PLOT.GetCharacter

		ldy #0
		sty ZP.Row


		lda #<TITLE_MAP
		sta ZP.SourceAddress

		lda #>TITLE_MAP
		sta ZP.SourceAddress + 1

		Loop:


			lda (ZP.SourceAddress), y
			sta (ZP.ScreenAddress), y

			lda ZP.Row
			bne NoColour

				lda CHAR_COLORS, x
				jmp StoreColour

			NoColour:

				lda #0

			StoreColour:

				sta (ZP.ColourAddress), y

				iny
				cpy #COLUMNS
				bcc Loop

				inc ZP.Row
				lda ZP.Row
				cmp #ROWS
				bcs Finish

				MovePointer(ZP.SourceAddress, COLUMNS)
				MovePointer(ZP.ScreenAddress, 40)
				MovePointer(ZP.ColourAddress, 40)

				ldy #0
				jmp Loop

		Finish:



		rts
	}



}