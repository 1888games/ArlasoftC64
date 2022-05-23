HUD: {


	.label ScoreID = NUM_COLS * NUM_ROWS + 0
	.label HighID = ScoreID + 1
	.label MinsID = ScoreID + 2
	.label TensID = ScoreID + 3
	.label DigitsID = ScoreID + 4


	SecondsTimer:	.byte 50


	GameOver:	.byte 0, 52, 67, 54, 49, 00, 47, 68, 49, 48, 0
	Twenty:		.byte 0, 53, 71, 49, 72, 53, 73, 74, 74, 74, 0





	Reset: {

		jsr DisplayScore
		jsr DisplayBest

		lda MAIN.FramesPerSecond
		sta SecondsTimer

		jsr Time.NoWrap

		rts
	}




	DrawGameOver: {

		ldx #0

		Loop:

			lda GameOver, x
			sta SCREEN_RAM + (40 * 8) + 6, x

			lda #0
			sta SCREEN_RAM + (40 * 7) + 6, x
			sta SCREEN_RAM + (40 * 9) + 6, x

			lda #YELLOW
			sta VIC.COLOR_RAM + (40 * 8) + 6, x

			inx
			cpx #11
			bcc Loop


		jsr DisplayBest
		jsr DisplayScore
		jsr Time.NoWrap

		
		lda #0
		sta VIC.SPRITE_ENABLE



		rts
	}


	DrawTwenty: {

		ldx #0

		Loop:

			lda Twenty, x
			sta SCREEN_RAM + (40 * 8) + 6, x
			sta SCREEN_RAM + (40 * 9) + 6, x
			sta SCREEN_RAM + (40 * 10) + 6, x
			sta SCREEN_RAM + (40 * 11) + 6, x

			lda #0
			sta SCREEN_RAM + (40 * 7) + 6, x
			sta SCREEN_RAM + (40 * 12) + 6, x

		Again:

			
			lda #WHITE
			sta VIC.COLOR_RAM + (40 * 8) + 6, x

			
			lda #LIGHT_GRAY
			sta VIC.COLOR_RAM + (40 * 9) + 6, x

			lda #GRAY
			sta VIC.COLOR_RAM + (40 * 10) + 6, x

			lda #DARK_GRAY
			sta VIC.COLOR_RAM + (40 * 11) + 6, x

			inx
			cpx #11
			bcc Loop

		lda #0
		sta VIC.SPRITE_ENABLE


		rts
	}



	DisplayScore: {


		ldx #ScoreID

		stx ZP.CurrentID

		jmp BOX.Draw

	}


	Time: {

		lda SecondsTimer
		beq Ready

		dec SecondsTimer
		rts

		Ready:

		lda MAIN.FramesPerSecond
		sta SecondsTimer

		inc GRID.Digits

		lda GRID.Digits
		cmp #10
		bcc NoWrap

		lda #0
		sta GRID.Digits

		inc GRID.Tens

		lda GRID.Tens
		cmp #6
		bcc NoWrap

		lda #0
		sta GRID.Tens

		inc GRID.Minutes

		lda GRID.Minutes
		cmp #10
		bcc NoWrap

		lda #9
		sta GRID.Minutes
		sta GRID.Digits

		lda #5
		sta GRID.Tens

		NoWrap:

		ldx #MinsID
		stx ZP.CurrentID
		jsr BOX.Draw

		ldx #TensID
		stx ZP.CurrentID
		jsr BOX.Draw

		ldx #DigitsID
		stx ZP.CurrentID
		jsr BOX.Draw






		rts
	}

	FrameUpdate: {


		jsr DisplayScore

		lda GRID.Score
		cmp GRID.High
		bcc Okay
		beq Okay

		sta GRID.High

		jsr DisplayBest


		Okay:

		jsr Time

		rts
	}
	DisplayBest: {

		ldx #HighID

		stx ZP.CurrentID

		jmp BOX.Draw

	}





}