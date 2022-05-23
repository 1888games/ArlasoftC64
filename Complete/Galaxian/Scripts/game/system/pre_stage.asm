PRE_STAGE: {

	* = * "Pre-Stage"
	
	Progress:	.byte 0

	Timer:		.byte 0

	//.label StartTime = 150
	//.label DelayTime = 25
	//.label StageTime = 25
	//.label ReadyTime = 50
	//.label BadgeTime = 3



	.label StartTime = 1
	.label DelayTime = 2
	.label StageTime = 2
	.label ReadyTime = 5
	.label BadgeTime = 3

	.label StartRow = 14
	.label StartColumn = 11

	.label StageRow = 18
	.label StageColumn = 9
	.label ChallengeColumn =5

	  
	.label StageNumColumn = 17

	BadgeValues:	.byte 10, 1

	BadgeChars:		.byte 44, 58, 43, 59
					.byte 42, 255,41, 255
					

	BadgeColours:	.byte WHITE_MULT, WHITE_MULT


	BadgesToShow:	.fill 13, 0
	NumBadges:		.byte 0
	BadgeProgress:	.byte 0

	BadgeRows:		.byte 19, 19, 19, 19, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21
	BadgeColumns:	
	//.byte 29, 31, 33, 35, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38
					.byte 30, 32, 34, 36, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39
	GameStarted:	.byte 0

	NewStage:		.byte 1


	Initialise: {

		lda #255
		sta VIC.SPRITE_ENABLE

		sfx(SFX_THEME)


		lda #StartTime
		sta Timer

		lda #0
		sta Progress

		lda #0
		//sta STARS.Scrolling
		sta GameStarted

		lda #28
		sta STARS.MaxColumns

		lda #TRUE
		sta MAIN.GameActive
		sta NewStage

		lda #GAME_MODE_PRE_STAGE
		sta MAIN.GameMode

		lda #StartRow
		sta TextRow

		lda #StartColumn
		sta TextColumn

		jsr STAGE.NewGame

		rts
	}



	StartStage: {

	
		lda GameStarted
		bne NoShipDecrease

		jsr LIVES.Decrease
		jsr SHIP.NewGame
		jsr SHIP.Initialise
		jsr STAGE.NewGame
		jsr ENEMY.NewGame
		jsr CHARGER.NewGame
		jsr BULLETS.NewGame
		

		NoShipDecrease:

			lda NewStage
			bne IsNewStage

			lda #1
			sta STARS.Scrolling

			lda #$6
			sta CHARGER.FlagshipMasterCounter_2

			lda #$40
			sta CHARGER.FlagshipMasterCounter_1

			jsr LIVES.Decrease
			jsr SHIP.Initialise
			jsr SHIP.SecondShip
			jmp NoNewStage	

		IsNewStage:

			jsr SHIP.NewStage
			jsr FORMATION.Initialise
			jsr CHARGER.Reset
			jsr STAGE.GetStageData
			

		NoNewStage:

			jsr SHIP.Reset

			lda #GAME_MODE_PLAY
			sta MAIN.GameMode

		Loop:

			//lda $d012
			//cmp #230
			//bne Loop

		lda #1
		sta GameStarted

		rts
	}

	FrameUpdate: {

		lda ZP.Counter
		and #%00000001
		beq NoUpdate

		CheckTimer:

			lda Timer
			beq Ready

			dec Timer
			rts

		Ready:

			lda Progress
			beq ShowStage

			cmp #1
			beq ShowStage2

			cmp #2
			beq ShowBadges2

			//cmp #3
			//beq ShowReady2

			jmp StartStage

		ShowBadges2:

			jmp ShowBadges

		ShowStage2:

			jmp ShowStage	

		ShowReady2:

			jmp ShowReady

		PreStageDelay:

			lda #PreStageDelay
			sta Timer

			inc Progress

			ldy #StartRow
			ldx #StartColumn
			lda #5
		
			jsr UTILITY.DeleteText

			lda #DelayTime
			sta Timer


		NoUpdate:	

		rts
	}	


	ShowReady: {

		lda NewStage
		beq NotNewStage

		ldy #StageRow
		ldx #ChallengeColumn
		lda #18
	
		jsr UTILITY.DeleteText

		NotNewStage:

		lda #1
		sta STARS.Scrolling

		lda #StartRow
		sta TextRow

		lda #StartColumn
		sta TextColumn

		ldx #RED
		lda #TEXT.READY

		jsr TEXT.Draw

		lda #ReadyTime
		sta Timer

		inc Progress

		lda #1
		sta LIVES.Active


		rts
	}


	ShowStage: {

		inc Progress

		jsr CalculateBadges
		jsr DeleteBadges
		jsr ShowStageTitle

		lda #1
		sta STARS.Scrolling
		sta LIVES.Active


		rts
	}	


	
	ShowStageTitle: {

		lda #StageRow
		sta TextRow

		lda #StageColumn
		sta TextColumn

		NormalStage:

			lda #TEXT.STAGE
			ldx #RED

			jsr TEXT.Draw

			lda #StageNumColumn
			sta TextColumn

			ldx STAGE.CurrentPlayer
			lda STAGE.CurrentStage, x
			clc
			adc #1

			ldy #RED

			ldx #0
			jsr TEXT.DrawByteInDigits


		rts
	}


	ShowBadge: {

		// ZP.Amount is badge type
		// ZP.StoredYReg = charID lookup

		// ZP.StoredXReg = badgeposition

		//sfx(SFX_BADGE)

		lda BadgeRows, x
		sta ZP.Row

		lda BadgeColumns, x
		sta ZP.Column

		ldx ZP.StoredYReg
		inc ZP.StoredYReg

		TopLeft:

			lda BadgeChars, x
			ldx ZP.Column
			ldy ZP.Row

			jsr PLOT.PlotCharacter

			lda ZP.Colour

			jsr PLOT.ColorCharacter


		TopRight:

			ldy #1
			ldx ZP.StoredYReg
			inc ZP.StoredYReg

			lda BadgeChars, x
			bmi BottomLeft

			
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y
			


		BottomLeft:

			ldy #40
			ldx ZP.StoredYReg
			inc ZP.StoredYReg
			lda BadgeChars, x
			sta (ZP.ScreenAddress), y


			lda ZP.Colour
			sta (ZP.ColourAddress), y


		BottomRight:

			ldy #41
			ldx ZP.StoredYReg
			inc ZP.StoredYReg
			lda BadgeChars, x
			bmi Skip

			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y


		Skip:


		rts
	}

	DeleteBadges: {

		ldx BadgeColumns
		ldy BadgeRows

		lda #10
		jsr UTILITY.DeleteText

		ldx BadgeColumns
		ldy BadgeRows
		iny

		lda #10
		jsr UTILITY.DeleteText

		ldx BadgeColumns
		ldy BadgeRows + 4

		lda #10
		jsr UTILITY.DeleteText

		ldx BadgeColumns
		ldy BadgeRows + 4
		iny

		lda #10
		jsr UTILITY.DeleteText

		ldx BadgeColumns
		ldy BadgeRows + 8

		lda #10
		jsr UTILITY.DeleteText

		ldx BadgeColumns
		ldy BadgeRows + 8
		iny

		lda #10
		jsr UTILITY.DeleteText


		rts
	}

	ShowBadges: {

		ldx BadgeProgress

		Loop:

			stx ZP.StoredXReg
			cpx #13
			beq NoMoreBadges

			lda BadgesToShow, x
			bmi SkipBadge
			sta ZP.Amount

			asl
			asl
			sta ZP.StoredYReg

			ldx ZP.Amount
			lda BadgeColours, x
			sta ZP.Colour

			ldx ZP.StoredXReg

			jsr ShowBadge

			
			lda STAGE.StageIndex
			cmp #CHALLENGING_STAGE
			bcs NoSound

			//sfx(SFX_BADGE)


			NoSound:

			SkipBadge:
	
			inc BadgeProgress

			lda #BadgeTime
			sta Timer

		Finish:

			rts

		NoMoreBadges:

			inc Progress

			lda #StageTime
			sta Timer
			rts
	}

	CalculateBadges: {

		lda #255

		ldx #0

		Loop:

			sta BadgesToShow, x
			inx
			cpx #13
			bcc Loop
			

		ldx STAGE.CurrentPlayer
		lda STAGE.CurrentStage
		clc
		adc #1
		sta ZP.Amount

		cmp #49
		bcc Okay

		lda #48
		sta ZP.Amount

		Okay:


		ldx #0
		stx NumBadges
		stx BadgeProgress

		BadgeLoop:

			lda ZP.Amount
			sec
			sbc BadgeValues, x
			bpl AddBadge

		NotEnoughLeft:

			inx
			lda #4
			sta NumBadges
			cpx #2
			bcc BadgeLoop

			jmp Finish

		AddBadge:

			sta ZP.Amount

			txa
			ldy NumBadges

			sta BadgesToShow, y

			inc NumBadges

			jmp BadgeLoop


		Finish:

		rts
	}


}