MENU: {


	* = $eb00 "Menu" 

	.label LogoStartPointer = 39
	.label MaxYOffset = 13
	.label ControlCooldown = 3
	.label HiScoreSecondsShow = 10


	Diff_Colours:	.byte 3, 4, 5, 6
	Diff_Speed:		.byte 1, 2, 3, 4
	Diff_Layers:	.byte 0, 0, 0, 2
	Diff_Continues:	.byte 3, 2, 1, 0
	Difficulty:		.byte 1

	Colours:		.byte LIGHT_BLUE, LIGHT_RED, LIGHT_GREEN, YELLOW, PURPLE
	Pointers:		.byte 39, 40, 41, 42, 43
	XPos:			.byte 124, 149, 174, 199, 224
	YPos:			.byte 65, 65, 65, 65, 65
	XPos_MSB:		.byte 0, 0, 0, 0, 0
	FrameTimer:		.fill 5, 0
	FrameTime:		.byte 1, 1, 2, 1, 1
	Mode:			.byte 0

	YOffset:		.byte 3, 12, 5, 7, 0
	Direction:		.byte -1, 1, 1, -1, 1

	PreviousOption:	.byte 0
	SelectedOption:	.byte 0
	OptionColours:	.byte RED + 8, PURPLE + 8, GREEN +8, YELLOW + 8, CYAN + 8, RED + 8
	ControlTimer: .byte 0

	SelectionRows:	.byte 7, 10, 13, 16, 19, 22

	SelectionColumns:	.byte 13, 25
	OptionCharType:	.byte 0, 0
	Active:			.byte 0
	Unlocked:		.byte 0

	HiScoreSeconds:	.byte 0
	HiScoreTimer:	.byte 50
	MaxRows:		.byte 5, 4



	Show: {

		lda #0
		sta Mode
		sta SelectedOption
		sta PreviousOption
		sta ControlTimer
		sta VIC.SPRITE_ENABLE
		sta IRQ.Mode
		sta SCORING.PlayerOne
		sta SCORING.PlayerOne + 1
		sta SCORING.PlayerOne + 2
		sta VIC.SPRITE_DOUBLE_X
		sta VIC.SPRITE_DOUBLE_Y

		lda HI_SCORE.Unlocked
		sta Unlocked

		jsr MAIN.SetupVIC
		jsr DRAW.HideSprites

		lda #BLACK
		sta VIC.BACKGROUND_COLOUR

		lda #CYAN
		sta VIC.BORDER_COLOUR

		lda #WHITE
		sta VIC.EXTENDED_BG_COLOR_1
		lda #GRAY
		sta VIC.EXTENDED_BG_COLOR_2

		jsr DRAW.MenuScreen
		jsr MenuColours
		jsr SetupSprites

		jsr DrawSelection

		lda #1
		sta Active
		sta Difficulty

		
		jmp MenuLoop

	}



	ShowDifficulty: {



		ldx #0
		ldy #0
		sty Unlocked

		lda #1
		sta Mode

		lda #<DIFF_MAP
		sta ZP.LookupAddress

		lda #>DIFF_MAP
		sta ZP.LookupAddress + 1

		lda #<SCREEN_RAM + 292
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 292
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 292
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 292
		sta ZP.ColourAddress + 1

		Loop:

			lda (ZP.LookupAddress), y
			sta (ZP.ScreenAddress), y
			
			cpx #12
			bcc NoColour

			lda #WHITE
			sta (ZP.ColourAddress), y



			NoColour:

			iny
			cpy #16
			bcc Loop

			inx
			cpx #17
			bcs Done

			lda ZP.LookupAddress
			clc
			adc #16
			sta ZP.LookupAddress

			lda ZP.LookupAddress + 1
			adc #0
			sta ZP.LookupAddress + 1

			lda ZP.ScreenAddress
			clc
			adc #40
			sta ZP.ScreenAddress

			lda ZP.ScreenAddress + 1
			adc #0
			sta ZP.ScreenAddress + 1

			lda ZP.ColourAddress
			clc
			adc #40
			sta ZP.ColourAddress

			lda ZP.ColourAddress + 1
			adc #0
			sta ZP.ColourAddress + 1

			ldy #0
			jmp Loop


		Done:

		lda #1
		sta SelectedOption

		jsr DrawSelection
		jsr UpdateDifficultyLevels

		


		rts
	}


	UpdateDifficultyLevels: {

		ldx SelectedOption

		lda Diff_Colours, x
		clc
		adc #48
		sta SCREEN_RAM + 787

		lda Diff_Speed, x
		clc
		adc #48
		sta SCREEN_RAM + 827

		lda Diff_Layers, x
		clc
		adc #48
		sta SCREEN_RAM + 867


		lda Diff_Continues, x
		clc
		adc #48
		sta SCREEN_RAM + 907


		rts
	}


	MenuLoop: {


		WaitForRasterLine:

			lda VIC.RASTER_LINE
			cmp #160
			bne WaitForRasterLine

		lda #0
		sta cooldown


		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		sfx(SFX_CHICK)
		jmp DecidePath

		Finish:

		jsr SpriteUpdate
		jsr ControlUpdate
		jsr UpdateHiScore

		jmp MenuLoop

	}


	UpdateHiScore: {

		lda Mode
		beq Okay

		rts

		Okay:

		lda HiScoreTimer
		beq Ready

		dec HiScoreTimer
		jmp NotYet

		Ready:

		lda ROCKS.FramesPerSecond
		sta HiScoreTimer

		inc HiScoreSeconds
		lda HiScoreSeconds
		cmp #HiScoreSecondsShow
		bcc NotYet

		lda #0
		sta HiScoreSeconds

		jmp HI_SCORE.Show

		NotYet:

		rts


	}



	DifficultyScreen: {

		ldx SelectedOption
		lda Diff_Colours, x
		sta PANEL.MaxColours
		sta PANEL.MaxColours + 1

		lda Diff_Speed, x
		tay
		dey
		sty CAMPAIGN.DropSpeed
		lda SETTINGS.DropSpeeds, y
		sta PLAYER.CurrentAutoDropTime
		sta PLAYER.CurrentAutoDropTime + 1

		lda Diff_Layers, x
		sta GRID.StartLayers

		lda Diff_Continues, x
		sta CAMPAIGN.Continues

		lda #0
		sta GRID.StartLayers + 1
		sta SelectedOption

		jsr CAMPAIGN.NewGame
		jmp CAMPAIGN.Show

		jmp MenuLoop

	}



	DecidePath: {

		lda Mode
		beq MenuScreen

		jmp DifficultyScreen

		MenuScreen:


		lda SelectedOption
		bne NoScenario

		jmp Scenario

		NoScenario:

			cmp #3
			bne NotOptions

			jmp Options

		NotOptions:

			cmp #PLAY_MODE_2P
			beq TwoPlayer

			cmp #5
			beq Gypsy

			cmp #4
			beq Instructions

		Practice:

			lda #0
			sta GRID.Active + 1

			ldx SETTINGS.DropSpeed
			lda SETTINGS.DropSpeeds, x
			sta PLAYER.CurrentAutoDropTime

			lda SETTINGS.BeanColours
			sta PANEL.MaxColours

			ldx SETTINGS.Character
			lda OPPONENTS.Colours, x
			sta CAMPAIGN.PlayerColours

			lda OPPONENTS.Pointers, x
			sta CAMPAIGN.PlayerPointers


			jmp MAIN.StartGame


		TwoPlayer:

			lda SETTINGS.BeanColours
			sta PANEL.MaxColours
			lda SETTINGS.BeanColours + 1
			sta PANEL.MaxColours + 1

			lda #0
			sta PLAYER.CPU + 1
			sta SCORING.Rounds 
			sta SCORING.Rounds + 1

			ldx SETTINGS.Character
			lda OPPONENTS.Colours, x
			sta CAMPAIGN.PlayerColours

			lda OPPONENTS.Pointers, x
			sta CAMPAIGN.PlayerPointers

			lda SETTINGS.Character + 1
			sta CAMPAIGN.OpponentID

			tax
			lda OPPONENTS.Colours, x
			sta CAMPAIGN.PlayerColours + 1

			lda OPPONENTS.Pointers, x
			sta CAMPAIGN.PlayerPointers + 1

			ldx SETTINGS.DropSpeed
			dex
			lda SETTINGS.DropSpeeds, x
			sta PLAYER.CurrentAutoDropTime

			ldx SETTINGS.DropSpeed + 1
			dex
			lda SETTINGS.DropSpeeds, x
			sta PLAYER.CurrentAutoDropTime + 1

			jmp MAIN.StartGame


		Gypsy:

			jmp GYPSY.Show


		Instructions:	
			jmp INSTRUCT.Show

		Scenario:

			jsr ShowDifficulty
		//	jsr CAMPAIGN.NewGame
			//jmp CAMPAIGN.Show
			jmp MenuLoop


		Options:

			jmp SETTINGS.Show




	}


	ControlUpdate: {

		lda ControlTimer
		beq Ready

		dec ControlTimer
		jmp Finish

		Ready:

		ldy #1
		lda SelectedOption
		sta PreviousOption

		CheckDown:

			lda SelectedOption

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			lda INPUT.JOY_DOWN_LAST, y
			bne Finish

			PressingDown:

			lda #ControlCooldown
			sta ControlTimer

			lda #0
			sta HiScoreSeconds

			jsr DeleteSelection
			inc SelectedOption

			ldx Mode
			lda MaxRows, x
			clc
			adc Unlocked
			sta ZP.Amount

			lda SelectedOption
			cmp ZP.Amount
			bcc Okay

			lda #0
			sta SelectedOption

			Okay:

			jsr DrawSelection

			sfx(SFX_MOVE)

			jmp Finish



		CheckUp:

			ldy #1
			lda INPUT.JOY_UP_NOW, y
			beq Finish

			lda INPUT.JOY_UP_LAST, y
			bne Finish

			PressingUp:

			lda #ControlCooldown
			sta ControlTimer

			lda #0
			sta HiScoreSeconds

			jsr DeleteSelection
			dec SelectedOption

			lda SelectedOption
			cmp #255
			bne Okay2

			lda #3
			sta SelectedOption

			Okay2:

			jsr DrawSelection

			sfx(SFX_BLOOP)




		Finish:



		rts
	}


	DeleteSelection: {

		ldx PreviousOption
		lda SelectionRows, x
		sta ZP.Row

		LeftBean:

			lda SelectionColumns
			tax

			lda #0
			ldy ZP.Row

			jsr DRAW.PlotCharacter

			inx

			jsr DRAW.PlotCharacter

			iny

			jsr DRAW.PlotCharacter

			dex

			jsr DRAW.PlotCharacter

		RightBean:	

			dec ZP.Row


			lda SelectionColumns + 1
			tax

			lda #0
			ldy ZP.Row

			jsr DRAW.PlotCharacter

			inx

			jsr DRAW.PlotCharacter

			iny

			jsr DRAW.PlotCharacter

			dex

			jsr DRAW.PlotCharacter




		rts
	}



	DrawSelection: {

		ldx SelectedOption
		lda SelectionRows, x
		sta ZP.Row

		lda OptionColours, x
		sta ZP.BeanColour


		LeftBean:

			ldy OptionCharType
			lda BEAN.Chars, y
			clc
			adc #3
			sta ZP.CharID

			ldx SelectionColumns

			lda ZP.CharID
			ldy ZP.Row

			jsr DRAW.PlotCharacter
			lda ZP.BeanColour
			jsr DRAW.ColorCharacter

			inx

			dec ZP.CharID
			lda ZP.CharID

			jsr DRAW.PlotCharacter
			lda ZP.BeanColour
			jsr DRAW.ColorCharacter


			dec ZP.CharID
			lda ZP.CharID

			iny

			jsr DRAW.PlotCharacter
			lda ZP.BeanColour
			jsr DRAW.ColorCharacter


			dec ZP.CharID
			lda ZP.CharID

			dex

			jsr DRAW.PlotCharacter

			lda ZP.BeanColour
			jsr DRAW.ColorCharacter

		RightBean:	

			dec ZP.Row
		

			ldy OptionCharType + 1
			lda BEAN.Chars, y
			clc
			adc #3
			sta ZP.CharID

			ldx SelectionColumns + 1

			lda ZP.CharID
			ldy ZP.Row

			jsr DRAW.PlotCharacter
			lda ZP.BeanColour
			jsr DRAW.ColorCharacter

			inx

			dec ZP.CharID
			lda ZP.CharID

			jsr DRAW.PlotCharacter
			lda ZP.BeanColour
			jsr DRAW.ColorCharacter


			dec ZP.CharID
			lda ZP.CharID

			iny

			jsr DRAW.PlotCharacter
			lda ZP.BeanColour
			jsr DRAW.ColorCharacter


			dec ZP.CharID
			lda ZP.CharID

			dex

			jsr DRAW.PlotCharacter

			lda ZP.BeanColour
			jsr DRAW.ColorCharacter


		lda Mode
		beq Finish

		jsr UpdateDifficultyLevels


		Finish:


		rts
	}

	MenuColours: {


		ldx #40

		Loop:	

			lda OptionColours + 0
			sta COLOR_RAM + 256, x
			sta COLOR_RAM + 296, x

			lda OptionColours + 1
			sta COLOR_RAM + 376, x
			sta COLOR_RAM + 416, x

			lda OptionColours + 2
			sta COLOR_RAM + 496, x
			sta COLOR_RAM + 535, x

			lda OptionColours + 3
			sta COLOR_RAM + 616, x
			sta COLOR_RAM + 656, x

			lda OptionColours +4
			sta COLOR_RAM + 736, x
			sta COLOR_RAM + 776, x


			lda Unlocked
			beq Hide

			lda #RED + 8
			sta COLOR_RAM + 856, x
			sta COLOR_RAM + 896, x
			jmp Skip


			Hide:

			lda #BLACK
			sta COLOR_RAM + 856, x
			sta COLOR_RAM + 896, x

			Skip:


			inx
			cpx #48
			bcc Loop


		rts
	}



	SetupSprites: {	

		lda #%11111111
		sta VIC.SPRITE_ENABLE
		sta VIC.SPRITE_MULTICOLOR


		lda #DARK_GRAY
		sta VIC.SPRITE_MULTICOLOR_1

		lda #WHITE
		sta VIC.SPRITE_MULTICOLOR_2


		lda #0
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y



		ldx #0

		Loop:	

			txa
			asl
			tay

			lda Pointers, x
			sta SPRITE_POINTERS, x
			
			lda Colours, x
			sta VIC.SPRITE_COLOR_0, x

			lda XPos, x
			sta VIC.SPRITE_0_X, y

			lda YPos, x
			sta VIC.SPRITE_0_Y, y

			lda FrameTime, x
			sta FrameTimer, x

			lda XPos_MSB, x
			bne MSB


			NoMSB:

				lda VIC.SPRITE_MSB
				and DRAW.MSB_Off, x
				sta VIC.SPRITE_MSB
				jmp EndLoop

			MSB:

				lda VIC.SPRITE_MSB
				ora DRAW.MSB_On, x
				sta VIC.SPRITE_MSB

			EndLoop:

				inx
				cpx #5
				bcc Loop



		rts
	}


	SpriteUpdate: {

		ldx #0

		Loop:	


			lda FrameTimer, x
			beq Ready

			dec FrameTimer, x
			jmp EndLoop

			Ready:

			

				lda FrameTime, x
				sta FrameTimer, x

				txa
				asl
				tay

				lda YPos, x
				clc
				adc YOffset, x
				sta VIC.SPRITE_0_Y, y

				lda YOffset, x
				clc
				adc Direction, x
				sta YOffset, x

				cmp #0
				beq MakeOne

				cmp #MaxYOffset
				beq Make255

				jmp EndLoop

			Make255:

				lda #255
				sta Direction, x
				jmp EndLoop


			MakeOne:

				lda #1
				sta Direction, x

			EndLoop:

				inx
				cpx #5
				bcc Loop




		rts
	}


	GameTitle: {








		rts
	}









}