SETTINGS: {

	* = * "Settings"

	DropSpeed:		.byte 0, 0
	RockLayers:		.byte 0, 0
	BeanColours:	.byte 5, 5
	RoundsToWin:	.byte 2, 2

	Music:			.byte 0
	ColourSwitch:	.byte 0
	Character:		.byte 0, 1


	SelectedOption:	.byte 0
	PreviousOption:	.byte 0
	ControlTimer:	.byte 0

	.label ControlCooldown = 10

	Min:			.byte 0, 0, 4, 1, 0, 0, 0
	Max:			.byte 9, 5, 6, 5, 1, 47, 1

	OptionColours:	.byte YELLOW ,  GREEN, CYAN, PURPLE,BLUE, RED

	SelectionRows:	.byte 7, 10, 13, 16, 19, 22

	SelectionColumns:	.byte 9, 29
	SettingColumns:		.byte 4, 35
	TextColumns:		.byte 5, 31

	ColourLookup:		.byte GREEN, RED


	.label UP = 0
	.label DOWN = 1
	.label LEFT = 2
	.label RIGHT = 3
	.label FIRE = 4

	OptionCharType:	.byte 0, 0

	DropSpeeds:		.byte 24, 21, 18, 15, 12, 10, 8, 6, 4
	DropSpeedsNTSC:	.byte 3,  3,  3,  3,  2,  2, 1, 1, 1

	CheatTracker:	.byte UP, DOWN, LEFT, RIGHT, UP, DOWN, LEFT, RIGHT
	CheatProgress: .byte 0


	Show: {

		lda #0
		sta SelectedOption
		sta PreviousOption
		sta ControlTimer

		jsr MAIN.SetupVIC
		jsr DRAW.HideSprites

		lda #BLACK
		sta VIC.BACKGROUND_COLOUR

		lda #BLACK
		sta VIC.BORDER_COLOUR

		lda #WHITE
		sta VIC.EXTENDED_BG_COLOR_1

		lda #GRAY
		sta VIC.EXTENDED_BG_COLOR_2

		jsr DRAW.SettingScreen
		jsr SettingsColours

		jsr DrawSelection

		jsr PopulateSettings

		jmp SettingsLoop



	}

	SetSpeedsNTSC: {

		ldx #0

		Loop:

			lda DropSpeeds, x
			clc
			adc DropSpeedsNTSC
			sta DropSpeeds, x

			inx
			cpx #8
			bcc Loop
		

		rts
	
	}


	

	PopulateSettings: {

		ldx #0


		Loop:

			stx ZP.X

			lda SelectionRows, x
			tay
			iny
			sty ZP.Row

			lda SelectionColumns
			sta ZP.Column

			
			txa
			asl
			tax

			lda DropSpeed, x
			clc
			adc #48

			ldx SettingColumns
			ldy ZP.Row

			jsr DRAW.PlotCharacter

			lda #WHITE

			jsr DRAW.ColorCharacter

			lda ZP.X
			asl
			tax
			inx

			lda DropSpeed, x
			clc
			adc #48

			ldx SettingColumns + 1
			ldy ZP.Row

			jsr DRAW.PlotCharacter

			lda #WHITE

			jsr DRAW.ColorCharacter


			EndLoop:

				ldx ZP.X
				inx
				cpx #4
				bcc Loop

		// PlayerOne:

		// 	lda SelectionRows + 4
		// 	tay
		// 	iny
		// 	sty ZP.TextRow

		// 	lda TextColumns
		// 	sta ZP.TextColumn

		// 	ldx #WHITE
		// 	lda Character

		// 	jsr TEXT.Draw

		// PlayerTwo:

		// 	lda TextColumns + 1
		// 	sta ZP.TextColumn

		// 	ldx #WHITE
		// 	lda Character + 1
			
		// 	jsr TEXT.Draw

		//jsr DRAW.SettingsPlayerSprites
		jsr SoundColour


		rts
	}


	SoundColour: {

		lda #19
		sta ZP.TextRow

		lda #2
		sta ZP.TextColumn

		ldx #WHITE
		lda #TEXT.MUSIC
		jsr TEXT.Draw

		lda #32
		sta ZP.TextColumn

		ldx #WHITE
		lda #TEXT.COLOUR
		jsr TEXT.Draw


		lda #20
		sta ZP.TextRow

		lda #32
		sta ZP.TextColumn

		ldy ColourSwitch
		lda ColourLookup, y
		tax

		lda #TEXT.COLOUR_OPTIONS
		clc
		adc ColourSwitch

		jsr TEXT.Draw


		lda ColourSwitch
		beq NormalColours

		Switched:


		ldx #0

		Loop:

			lda PANEL.Colours, x
			tay
			lda GRID.ColourBlind, y
			bne Okay

			lda #8

		Okay:
			sta COLOR_RAM + 832, x

			inx
			cpx #6
			bcc Loop

		jmp Sound


		NormalColours:

		ldx #0

		Loop2:

			lda PANEL.Colours, x
			tay
			lda GRID.ColourLookup, y
			sta COLOR_RAM + 832, x

			inx
			cpx #6
			bcc Loop2


		Sound:


		lda #2
		sta ZP.TextColumn

		ldy Music
		lda ColourLookup, y
		tax

		lda #TEXT.SOUND_OPTIONS
		clc
		adc Music

		jsr TEXT.Draw




		rts
	}


	CheckCheat: {

		rts

		sta ZP.Amount

		ldx CheatProgress
		lda CheatTracker, x
		cmp ZP.Amount
		bne NoCheat


		inc CheatProgress
		ldx CheatProgress
		cpx #8
		bcc Finish

		lda #1
		sta MENU.Unlocked
		inc $d020

		NoCheat:

		lda #0
		sta CheatProgress

		Finish:

			rts
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
			beq PressingDown

			jmp Finish

			PressingDown:

			lda #DOWN
			jsr CheckCheat

			lda #ControlCooldown
			sta ControlTimer

			jsr DeleteSelection
			inc SelectedOption

			lda SelectedOption
			cmp #5
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
			bne Pressing

			jmp CheckLeft

			Pressing:

			lda INPUT.JOY_UP_LAST, y
			beq PressingUp

			jmp Finish

			PressingUp:

			lda #UP
			jsr CheckCheat

			lda #ControlCooldown
			sta ControlTimer

			jsr DeleteSelection
			dec SelectedOption

			lda SelectedOption
			cmp #255
			bne Okay2

			lda #4
			sta SelectedOption

			Okay2:

			jsr DrawSelection

			sfx(SFX_BLOOP)

		CheckLeft:

			ldy #1
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda #LEFT
			jsr CheckCheat

			lda #ControlCooldown
			sta ControlTimer

			lda SelectedOption
			tay
			asl
			tax

			lda DropSpeed, x
			cmp Max, y
			beq Wrap2

			inc DropSpeed, x
			jmp Okay3

			Wrap2:

			lda Min, y
			sta DropSpeed, x

			Okay3:

			cpx #8
			bne NotMusic

			lda Music
			jsr sid.init


			NotMusic:

			jsr PopulateSettings

			sfx(SFX_BLOOP)


		CheckRight:


			ldy #1
			lda INPUT.JOY_RIGHT_NOW, y
			beq Finish

			lda #RIGHT
			jsr CheckCheat

			lda #ControlCooldown
			sta ControlTimer

			lda SelectedOption
			tay
			asl
			tax
			inx

			lda DropSpeed, x
			cmp Max, y
			beq Wrap3

			inc DropSpeed, x
			jmp Okay4

			Wrap3:

			lda Min, y
			sta DropSpeed, x

			Okay4:

			jsr PopulateSettings

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
		clc
		adc #8
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



		rts
	}

	SettingsColours: {


		ldx #0

		Loop:	

			lda OptionColours + 0
			sta COLOR_RAM + 289, x
			sta COLOR_RAM + 329, x

			lda OptionColours + 1
			sta COLOR_RAM + 409, x
			sta COLOR_RAM + 449, x

			lda OptionColours + 2
			sta COLOR_RAM + 529, x
			sta COLOR_RAM + 569, x

			lda OptionColours + 3
			sta COLOR_RAM + 649, x
			sta COLOR_RAM + 689, x

			lda OptionColours + 4
			sta COLOR_RAM + 769, x
			sta COLOR_RAM + 809, x

			///lda OptionColours + 5
		//	sta COLOR_RAM + 889, x
		//	sta COLOR_RAM + 969, x

			inx
			cpx #22
			bcc Loop


		ldx #0

		Loop2:	

			lda #RED
			sta COLOR_RAM + 124, x
			sta COLOR_RAM + 164, x

			lda #CYAN
			sta COLOR_RAM + 148, x
			sta COLOR_RAM + 188, x

			
			inx
			cpx #8
			bcc Loop2


		lda #WHITE
		ldx #1

		Loop3:

			sta COLOR_RAM + 920, x
			inx 
			cpx #39
			bcc Loop3



		rts
	}




	SettingsLoop: 
	{


		WaitForRasterLine:

			lda VIC.RASTER_LINE
			cmp #160
			bne WaitForRasterLine

		lda #0
		sta cooldown

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		jmp MENU.Show

		Finish:

		//jsr SpriteUpdate
		jsr ControlUpdate
			jsr ROCKFORD.FrameUpdate


		jmp SettingsLoop
	}










}