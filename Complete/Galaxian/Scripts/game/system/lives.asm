LIVES: {


	
	* = * "Lives"

	.label Lives = 3
	.label FlashTime = 16
	.label LabelColumn = 32
	.label LivesColumn = 29
	.label TimeRow = 12
	.label TimeColumn = 32

	Chars:	.byte 36, 38, 34, 35

	Columns:	.byte 31, 33, 35, 37, 28, 38, 26
				.byte 30, 32, 34, 36, 28, 38, 26

	Rows:		.byte 15, 15, 15, 15, 15, 15, 15
				.byte 17, 17, 17, 17, 17, 17, 17

	FlashTimer:	.byte FlashTime
	FlashState:	.byte 1

	LabelRows:	.byte 6, 10

	Left:		.byte 3, 3
	Active:		.byte 0
	GameOver:	.byte 0

	SpeedMinutes:	.byte 0
	SpeedTensSeconds:	.byte 0
	SpeedSeconds:	.byte 0
	SpeedHundreds:	.byte 0
	DoSpeed:		.byte 0

	NewGame: {

		lda #Lives
		sta Left
		sta Left +1

		lda #1
		sta FlashState

		lda #0
		sta GameOver
		sta DoSpeed

		lda SHIP.Speedrun
		beq NoSpeed

		lda #0
		sta SpeedSeconds
		sta SpeedHundreds
		sta SpeedMinutes
		sta SpeedTensSeconds

		jsr DrawTimeStart


		NoSpeed:

		jsr FrameUpdate.TurnOn


		lda SHIP.TwoPlayer
		bne TwoPlayer

		OnePlayer:


			lda LabelRows + 1
			tay

			ldx #LabelColumn

			lda #4
			jsr UTILITY.DeleteText	
			
			lda LabelRows + 1
			tay
			iny

			ldx #LivesColumn

			lda #8
			jsr UTILITY.DeleteText	

			rts

		TwoPlayer:

			//ßlda Left
			//asl
		//	sta Left



		rts

	}


	DeleteLives: {


		ldx Columns + 6
		ldy Rows

		lda #14
		jsr UTILITY.DeleteText

		ldx Columns + 6
		ldy Rows
		iny

		lda #14
		jsr UTILITY.DeleteText

		ldx Columns + 6
		ldy Rows +7

		lda #14
		jsr UTILITY.DeleteText

		ldx Columns + 6
		ldy Rows + 7
		iny

		lda #14
		jsr UTILITY.DeleteText


		rts

	}



	Check2Player: {

			lda #0
			sta ZP.Amount

			lda SHIP.TwoPlayer
			beq Finish

		CheckNotWinning:


			lda SHIP.PlayerDied
			beq PlayerOne

		PlayerTwo:


			lda SCORE.Value + 3
			cmp SCORE.Value + 7
			bcc RestoreLife
			bne Finish

			lda SCORE.Value + 2
			cmp SCORE.Value + 6
			bcc RestoreLife
			bne Finish

			lda SCORE.Value + 1
			cmp SCORE.Value + 5
			bcc RestoreLife
			bne Finish

			lda SCORE.Value + 0
			cmp SCORE.Value + 4
			bcc RestoreLife
			bne Finish

			jmp Finish

		PlayerOne:

			lda SCORE.Value + 7
			cmp SCORE.Value + 3
			bcc RestoreLife
			bne Finish

			lda SCORE.Value + 6
			cmp SCORE.Value + 2
			bcc RestoreLife
			bne Finish

			lda SCORE.Value + 5
			cmp SCORE.Value + 1
			bcc RestoreLife
			bne Finish

			lda SCORE.Value + 4
			cmp SCORE.Value + 0
			bcc RestoreLife

			jmp Finish

		RestoreLife:

			inc ZP.Amount

		Finish:



		rts
	}

	Decrease: {

		lda TITLE.Infinite
		bne Finish

		LoseLife:

		//ldx STAGE.CurrentPlayer
			dec Left
			lda Left

			bmi GameOver2

			jsr Draw
			rts

		GameOver2:

			lda #0
			sta Left

			inc GameOver

		Finish:
	
		rts
	}

	Add: {

		ldx STAGE.CurrentPlayer
		lda Left, x
		cmp #12
		bcs CantAdd

		clc
		adc #1
		sta Left, x

		jsr Draw

		sfx(SFX_EXTRA)

		CantAdd:

		rts

	}


	DrawShip: {

		TopLeft:

			lda Columns, x
			sta ZP.Column


			lda Rows, x
			sta ZP.Row
			tay

			lda Chars
			ldx ZP.Column

			jsr PLOT.PlotCharacter

			lda #CYAN_MULT

			jsr PLOT.ColorCharacter

		TopRight:

			ldy #1

			lda Chars + 1
			sta (ZP.ScreenAddress), y

			lda #CYAN_MULT
			sta (ZP.ColourAddress), y

		BottomLeft:

			ldy #40

			lda Chars + 2
			sta (ZP.ScreenAddress), y

			lda #CYAN_MULT
			sta (ZP.ColourAddress), y

		BottomRight:

			iny

			lda Chars + 3
			sta (ZP.ScreenAddress), y

			lda #CYAN_MULT
			sta (ZP.ColourAddress), y
			


		rts
	}

	Draw: {

		jsr DeleteLives

		//ldx STAGE.CurrentPlayer
		lda Left
		sta ZP.Amount
		beq Finish

		ldx #0

		Loop:

			stx ZP.X

			jsr DrawShip


			ldx ZP.X
			inx
			cpx ZP.Amount
			bcs Finish

			jmp Loop

		Finish:



		rts
	}


	DrawTimeStart: {

		ldy #TimeRow
		ldx #TimeColumn

		jsr PLOT.GetCharacter

		ldy #0
		lda SpeedMinutes
		clc
		adc #48
		sta (ZP.ScreenAddress), y

		lda #YELLOW
		sta (ZP.ColourAddress), y 

		lda #47
		iny
		sta (ZP.ScreenAddress), y

		lda #YELLOW
		sta (ZP.ColourAddress), y 

		iny
		lda SpeedTensSeconds
		clc
		adc #48
		sta (ZP.ScreenAddress), y

		lda #YELLOW
		sta (ZP.ColourAddress), y 

		iny
		lda SpeedSeconds
		clc
		adc #48
		sta (ZP.ScreenAddress), y

		lda #YELLOW
		sta (ZP.ColourAddress), y 


		
		rts
	}


	

	CheckTimer: {

		lda SHIP.Speedrun
		bne DoTime

		rts

	DoTime:


		ldy #TimeRow
		ldx #TimeColumn

		jsr PLOT.GetCharacter

		lda DoSpeed
		bne Hundreds

		rts
		
	Hundreds:

		lda SpeedHundreds
		clc
		adc #2
		sta SpeedHundreds

		cmp #100
		bcs RollSeconds

		rts 

	RollSeconds:

		lda #0
		sta SpeedHundreds

		lda SpeedSeconds
		clc
		adc #1
		sta SpeedSeconds

		cmp #10
		bcc NoWrapSeconds

		lda #0
		sta SpeedSeconds

	NoWrapSeconds:

		ldy #3
		clc
		adc #48
		sta (ZP.ScreenAddress), y

		cmp #48
		bne Okay


	RollTens:

		lda #0
		sta SpeedSeconds

		lda SpeedTensSeconds
		clc
		adc #1
		sta SpeedTensSeconds

		cmp #6
		bcc NoWrapTens

		lda #0
		sta SpeedTensSeconds

	NoWrapTens:

		ldy #2
		clc
		adc #48
		sta (ZP.ScreenAddress), y

		cmp #48
		bne Okay

	RollMinutes:

		inc SpeedMinutes
		lda SpeedMinutes
		cmp #10
		bcc MinutesOkay

		lda #9
		sta SpeedMinutes

		lda #5
		sta SpeedTensSeconds

		lda #9
		sta SpeedSeconds

		lda #98
		sta SpeedHundreds

		jsr DrawTimeStart

		lda #0
		sta DoSpeed

		jmp Finish


	MinutesOkay:

		ldy #0
		clc
		adc #48
		sta (ZP.ScreenAddress), y

		Okay:

		Finish:



		rts
	}


	FrameUpdate: {

		jsr CheckTimer

		lda Active
		beq Finish

		lda FlashTimer
		beq Ready

		dec FlashTimer
		rts

		Ready:

			rts

			lda #FlashTime
			sta FlashTimer

			lda FlashState
			beq TurnOn

		TurnOff:

			dec FlashState

			ldx STAGE.CurrentPlayer
			lda LabelRows, x
			tay

			ldx #LabelColumn

			lda #4
			jsr UTILITY.DeleteText

			lda SHIP.TwoPlayer
			beq OnePlayerOff

			ldx #1
			lda LabelRows, x
			tay

			ldx #LabelColumn

			lda #4
			jsr UTILITY.DeleteText


		OnePlayerOff:

			rts

		TurnOn:

			inc FlashState

			ldx STAGE.CurrentPlayer
			lda LabelRows, x
			sta TextRow

			lda #LabelColumn
			sta TextColumn

			ldx #WHITE
			lda #TEXT.ONE_UP

			jsr TEXT.Draw

			lda SHIP.TwoPlayer
			beq OnePlayerOn

		
			ldx #1
			lda LabelRows, x
			sta TextRow

			lda #LabelColumn
			sta TextColumn

			ldx #WHITE
			lda #TEXT.TWO_UP

			jsr TEXT.Draw

		OnePlayerOn:


		Finish:

		rts
	}



}