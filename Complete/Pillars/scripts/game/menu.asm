MENU: {


	* = $eaC1 "Menu" 

	.label LogoStartPointer = 39
	.label MaxYOffset = 7
	.label ControlCooldown = 3
	.label HiScoreSecondsShow = 10


	Diff_Colours:	.byte 3, 4, 5, 6
	Diff_Speed:		.byte 1, 2, 3, 4
	Diff_Layers:	.byte 0, 0, 0, 2
	Diff_Continues:	.byte 3, 2, 1, 0
	Difficulty:		.byte 1

	Colours:		.byte LIGHT_BLUE, LIGHT_RED, LIGHT_GREEN, YELLOW, PURPLE, ORANGE, CYAN
	Pointers:		.byte 39, 40, 41, 41, 42, 43, 74
	XPos:			.byte 99, 124, 149, 174, 199, 224,249
	YPos:			.byte 65, 65, 65, 65, 65, 65, 65
	XPos_MSB:		.byte 0, 0, 0, 0, 0, 0, 0
	FrameTimer:		.fill 5, 0
	FrameTime:		.byte 1, 1, 2, 2, 2, 1, 1
	Mode:			.byte 0

	YOffset:		.byte 5, 3, 6, 1, 4, 5, 2
	Direction:		.byte -1, 1, 1, -1, 1, -1, 1

	PreviousOption:	.byte 0
	SelectedOption:	.byte 0
	OptionColours:	.byte RED, PURPLE, GREEN, YELLOW, CYAN, RED
	ControlTimer: .byte 0

	SelectionRows:	.byte 7, 10, 13, 16, 19, 22

	SelectionColumns:	.byte 13, 25
	OptionCharType:	.byte 0, 0
	Active:			.byte 0
	Unlocked:		.byte 0

	HiScoreSeconds:	.byte 0
	HiScoreTimer:	.byte 50
	MaxRows:		.byte 5, 4

	.label BorderColour = DARK_GRAY



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

		lda #BLACK
		sta VIC.BORDER_COLOUR
		sta COLOR_RAM
		sta COLOR_RAM + 39
		sta COLOR_RAM + 960
		sta COLOR_RAM + 999

		lda #WHITE
		sta VIC.EXTENDED_BG_COLOR_1
		lda #LIGHT_BLUE
		sta VIC.EXTENDED_BG_COLOR_2

		jsr DRAW.MenuScreen
		jsr MenuColours
		jsr SetupSprites


		lda #255
		sta VIC.SPRITE_ENABLE


		jsr DrawSelection

		lda #1
		sta Active
		sta Difficulty

		
		
		
		jmp MenuLoop

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




	ArcadeMode: {

		lda #0
		sta GRID.Active + 1

		lda SETTINGS.DropSpeed
		sta PLAYER.Level

		lda SETTINGS.BeanColours
		sta PANEL.MaxColours

		lda #PLAYER.AutoDropTime
		sec
		sbc PLAYER.Level
		sbc PLAYER.Level
		sbc PLAYER.Level
		sta PLAYER.CurrentAutoDropTime
		
		jmp MAIN.StartGame


		rts
	}


	TimeTrial: {

		lda #0
		sta GRID.Active + 1

		lda SETTINGS.DropSpeed
		sta PLAYER.Level

		lda SETTINGS.BeanColours
		sta PANEL.MaxColours

		lda #PLAYER.AutoDropTime
		sec
		sbc PLAYER.Level
		sbc PLAYER.Level
		sbc PLAYER.Level
		sta PLAYER.CurrentAutoDropTime
		
		jmp MAIN.StartGame


		rts
	}


	TwoPlayerGame: {

		lda #1
		sta GRID.Active + 1

		lda SETTINGS.DropSpeed
		sta PLAYER.Level

		lda SETTINGS.DropSpeed + 1
		sta PLAYER.Level + 1

		lda SETTINGS.BeanColours
		sta PANEL.MaxColours

		lda SETTINGS.BeanColours + 1
		sta PANEL.MaxColours + 1

		lda #PLAYER.AutoDropTime
		sec
		sbc PLAYER.Level
		sbc PLAYER.Level
		sbc PLAYER.Level
		sta PLAYER.CurrentAutoDropTime

		lda #PLAYER.AutoDropTime
		sec
		sbc PLAYER.Level + 1
		sbc PLAYER.Level + 1
		sbc PLAYER.Level + 1
		sta PLAYER.CurrentAutoDropTime + 1
		
		lda #0
		sta PLAYER.CPU + 1
		sta SCORING.Rounds 
		sta SCORING.Rounds + 1

		jmp MAIN.StartGame

		rts
	}

	DecidePath: {

		
		MenuScreen:

			lda SelectedOption
			bne NotArcade

			jmp ArcadeMode

		NotArcade:	

			cmp #PLAY_MODE_TIME
			bne NotTimed

			jmp TimeTrial

		NotTimed:

			cmp #PLAY_MODE_2P
			beq TwoPlayer

			cmp #3
			beq Options

			cmp #5
			beq Gypsy

			cmp #4
			beq Instructions


		TwoPlayer:

			jmp TwoPlayerGame


		Gypsy:

			//jmp GYPSY.Show


		Instructions:	
			jmp INSTRUCT.Show

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
		sta ZP.Colour
		clc
		adc #8
		sta ZP.BeanColour


		LeftBean:

			ldy OptionCharType
			lda BEAN.Chars, y
			clc
			adc #3
			sta ZP.CharID

			ldx ZP.Colour
   			lda PANEL.ColourToChar, x
    		clc
    		adc ZP.CharID
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

			ldx ZP.Colour
   			lda PANEL.ColourToChar, x
    		clc
    		adc ZP.CharID
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


			// lda Unlocked
			// beq Hide

			// lda #RED
			// sta COLOR_RAM + 856, x
			// sta COLOR_RAM + 896, x
			// jmp Skip


			// Hide:

			// lda #BLACK
			// sta COLOR_RAM + 856, x
			// sta COLOR_RAM + 896, x

			// Skip:


			inx
			cpx #49
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
				cpx #7
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
				cpx #7
				bcc Loop




		rts
	}


	








}