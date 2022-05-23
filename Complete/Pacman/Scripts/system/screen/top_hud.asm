TOP_HUD: {


	.label HighScoreStart = 145
	.label OneUp = 89
	.label ScoreY = 39
	.label LabelY = 14

	Pointers:		.byte 80 + 48, 76 + 48, 77 + 48, 78 + 48, 79 + 48
	ScorePointers:	.byte 83 + 48, 84 + 48, 85 + 48, 86 + 48

	X:				.byte OneUp
					.fill 4, HighScoreStart + (i*24)

	Y:				.byte LabelY, LabelY + 25


	ScoreX:			.byte OneUp - 16, OneUp + 8
					.byte HighScoreStart + 16, HighScoreStart + 40


	FlashCounter:	.byte 0



	IRQ_Entry: {

		:StoreState()

		SetDebugBorder(LIGHT_RED)

		lda #255
		sta VIC.SPRITE_ENABLE


		lda #0
		sta VIC.SPRITE_PRIORITY

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERMISSION
		bne TopYes

		lda INTERMISSION.ID
		beq TopYes

		DoNothing:

			lda #255
			sta VIC.SPRITE_0_Y
			sta VIC.SPRITE_1_Y
			sta VIC.SPRITE_2_Y
			sta VIC.SPRITE_3_Y
			sta VIC.SPRITE_4_Y
			sta VIC.SPRITE_5_Y
			sta VIC.SPRITE_6_Y
			sta VIC.SPRITE_7_Y

			jmp DoNothing2

		TopYes:
	
			jsr DoLabels

			lda #%00000000
			sta VIC.SPRITE_MULTICOLOR

			lda #%11000000
			sta VIC.SPRITE_MSB	

		DoNothing2:
	
			ldy #ScoreY - 5
			lda #<IRQ_Entry_2
			ldx #>IRQ_Entry_2
			jsr IRQ.SetNextInterrupt

			jsr BOTTOM_HUD.Draw
		
			asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti



	}

	IRQ_Entry_2: {

		:StoreState()

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERMISSION
		bne DrawIt

		lda INTERMISSION.ID
		beq DrawIt

		ldy #53
		jmp NotTitle

		DrawIt:

		jsr DoScores
		ldy #53

		CheckWhichIRQ:

			lda MAIN.GameMode
			cmp #GAME_MODE_TITLE
			beq Title

			cmp #GAME_MODE_EATEN
			bne NotEaten

			lda MAIN.PreviousMode
			cmp #GAME_MODE_INTERMISSION
			beq Title

			jmp NotTitle

		NotEaten:

			cmp #GAME_MODE_INTERMISSION
			bne NotTitle

			lda INTERMISSION.ID
			bne NotTitle

		Title:
		
			lda #<TITLE.TitleIRQ
			ldx #>TITLE.TitleIRQ
			jsr IRQ.SetNextInterrupt

			jmp Exit

		NotTitle:

			lda #0
			sta GAME_SPRITES.Mode

			lda #<GAME_SPRITES.SpriteIRQ
			ldx #>GAME_SPRITES.SpriteIRQ
			jsr IRQ.SetNextInterrupt

		Exit:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		//dec $d020

		rti



	}


	DoScores: {

		ldx #0
		ldy #0
		
		Loop:

			lda Y + 1
			sta VIC.SPRITE_0_Y, y

			lda ScorePointers, x
			sta SPRITE_POINTERS, x
			sta SPRITE_POINTERS_2, x

			lda ScoreX, x
			sta VIC.SPRITE_0_X, y

			lda #WHITE
			sta VIC.SPRITE_COLOR_0, x

			iny
			iny
			inx 
			cpx #4
			bcc Loop

		jsr BOTTOM_HUD.Level
		


		rts
	}

	DoLabels: {

		lda GAME.AttractMode
		beq NotAttractMode

		sta FlashCounter

		NotAttractMode:

		ldx #0
		ldy #0
	
		Loop:

			cpx #0
			bne Not1Up

			lda FlashCounter
			and #%00010000
			bne EndLoop


			Not1Up:

			lda Y
			sta VIC.SPRITE_0_Y, y

			lda Pointers, x
			sta SPRITE_POINTERS, x
			sta SPRITE_POINTERS_2, x

			lda X, x
			sta VIC.SPRITE_0_X, y

			lda #WHITE
			sta VIC.SPRITE_COLOR_0, x

			EndLoop:

			iny
			iny
			inx 
			cpx #5
			bcc Loop

		lda GAME.Started
		beq NoWrap

		lda FlashCounter
		cmp #32
		bcc NoWrap

		lda #0
		sta FlashCounter

		NoWrap:





		rts
	}


}