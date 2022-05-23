.label NUM_ROWS = 8
.label NUM_COLS = 7


GRID: {

	
	.label StartColumn = 1
	.label CellSize = 3

	
	Cells:	.fill NUM_COLS * NUM_ROWS, 0


	Score:		.byte 4
	High:		.byte 4
	Minutes:		.byte 0
	Tens:		.byte 0
	Digits:		.byte 0


	Offset:	.fill NUM_COLS * NUM_ROWS, 0
			.fill 5, 0
	GravityTimer:	.byte 0

	Falling:	.byte 0
					// 1  2   3   4   5   6   7   8  9    10  11  12  13  14  15  16  17  18  19  20

	.label GravityTime = 1
	.label StartScore = 4

	SecondsTimer:	.byte 50
	Seconds:		.byte 0
	SecondsPerRow:	.byte 15
	RowQueued:		.byte 0
	AllowFixed:		.byte 0

	FixedThisRow:	.byte 0


	ScoreAnds:	.byte %00000001, %00000001, %00000011, %00000011, %00000111, %00000111, %00000111, %00000111
				.byte %00001111, %00001111, %00001111, %00001111, %00001111, %00001111, %00001111, %00001111
				.byte %00011111, %00011111, %00011111, %00011111, %00011111, %00011111, %00011111, %00011111

	CharX:	

		.for(var j=0; j<NUM_ROWS; j++) {
			.fill NUM_COLS, StartColumn + (i * CellSize)
		}

		.byte 27, 33, 25, 31, 35

	CharY:
		
		.for(var j=0; j<NUM_ROWS; j++) {
			.fill NUM_COLS, j * 3
		}	

		.byte 3, 3, 10, 10, 10

	Row:	.for(var j=0; j<NUM_ROWS; j++) {
			.fill NUM_COLS, j
	}

	Column:	.for(var j=0; j<NUM_ROWS; j++) {
			.fill NUM_COLS, i
	}



	TimePieces:	.fill 50, i / 50 * 8


	Reset: {


		ldx #0

		Loop:

			lda #0
			sta Cells, x
			sta Offset, x

			inx
			cpx #NUM_ROWS * NUM_COLS
			bcc Loop


		lda #StartScore
		sta Score

		lda SecondsPerRow
		sta Seconds

		lda MAIN.FramesPerSecond
		sta SecondsTimer

		lda #0
		sta RowQueued
		sta Minutes
		sta Tens
		sta Digits

		lda #1
		sta AllowFixed

		lda #4
		sta Score


		//ldx #0
		//stx ZP.CurrentID

		//jsr BOX.Draw

		jsr NewRow

		jsr NewRow

		rts
	}



	ShiftUp: {

		jsr JOIN.MoveUp

		CheckTopRow:

			ldx #0

		Loop:

			lda Cells, x
			beq EndLoop


			GameOver:

				lda #GAME_MODE_OVER
				sta MAIN.GameMode

				lda #100
				sta MAIN.GameOverTimer

				jmp HUD.DrawGameOver

			EndLoop:

				inx 
				cpx #NUM_COLS
				bcc Loop


		MoveCellsUp:

			ldx #0

		Loop2:

			stx ZP.CurrentID

			lda Cells + NUM_COLS, x
			sta Cells, x
			
			txa
			clc
			adc #NUM_COLS
			tax

			jsr BOX.Clear

			ldx ZP.CurrentID

			jsr BOX.Draw

			ldx ZP.CurrentID
			inx
			cpx #(NUM_COLS * (NUM_ROWS - 1))
			bcc Loop2


		rts
	}

	Consecutive:	.byte 0
	LastValue:		.byte 0

	NewRow: {

		lda #0
		sta Consecutive
		sta LastValue
		sta FixedThisRow

		jsr ShiftUp

		ldx #NUM_COLS * 7
		ldy Score

		Loop:

			jsr RANDOM.Get
			and #%00011111

		AddOne:

			clc
			adc #1
			cmp Score
			bcc Okay
			beq Okay

			jmp Loop

		Okay:	

			stx ZP.CurrentID

			sta Cells, x


			cmp Cells - NUM_COLS, x
			beq AddOne

			cmp LastValue
			beq IsConsecutive

		NotConsective:

			ldy #0
			sty Consecutive
			jmp StoreIt

		IsConsecutive:

			inc Consecutive
			ldy Consecutive
			cpy #2
			bcs AddOne

		StoreIt:

			sta LastValue

			lda AllowFixed
			beq NoFixed


		NoFixed:

			lda FixedThisRow
			bne Skip

			jsr JOIN.CheckAdd

			Skip:

			lda FixedThisRow
			beq NoDec
			dec FixedThisRow

			NoDec:

			ldx ZP.CurrentID
			jsr BOX.Draw

			ldx ZP.CurrentID

			inx
			cpx #NUM_COLS * NUM_ROWS
			bcc Loop



		rts
	}


	CheckJoinFall: {

		ldy ZP.Joined
		lda Column, y
		cmp Column, x
		beq CanFall

		lda Cells + NUM_COLS, y
		bne CantFall

		CanFall:

			inc Falling
			jsr ProcessFall

		CantFall:






		rts
	}

	CheckFall: {


		lda #0
		sta Falling

		ldx #((NUM_ROWS - 1) * NUM_COLS) - 1
		Loop:

			stx ZP.X

			lda Offset, x
			bne CanFall

			lda Cells, x
			beq EndLoop

			lda Cells + NUM_COLS, x
			beq IsSpace

			cmp Cells, x
			bne EndLoop

		Combine:

			lda GravityTimer
			bne EndLoop

			jsr JOIN.CheckCellFixed
			bcs EndLoop

			stx ZP.ClearID
			txa
			clc
			adc #NUM_COLS
			sta ZP.CombineID

			jsr BOX.Combine

			jmp EndLoop

		IsSpace:

			jsr JOIN.CheckCellFixed
			bcc CanFall

			jsr CheckJoinFall

			jmp EndLoop

		CanFall:

			inc Falling

			jsr ProcessFall

			
		EndLoop:

			ldx ZP.X
			dex
			bpl Loop
		


		Finish:



		rts
	}


	UpdateGravity: {

		lda GravityTimer
		beq Ready

		dec GravityTimer
		rts

		Ready:

		lda #GravityTime
		sta GravityTimer

		rts
	}

	FrameUpdate: {

		jsr UpdateTimer

		lda PLAYER.Selected
		bmi Okay

		rts

		Okay:
		
		jsr CheckFall
		jsr UpdateGravity

		jsr CheckTimer


		rts
	}


	TimerBar: {

		ldx SecondsPerRow

		Loop:

			cpx Seconds
			bne NotThisOne

			ldy SecondsTimer
			lda TimePieces, y
			sta ZP.Amount

			lda #65
			sec
			sbc ZP.Amount
			sta ZP.CharID

			jmp Draw

			NotThisOne:

				bcc Full

				lda #0
				sta ZP.CharID
				jmp Draw


			Full:

				lda #57
				sta ZP.CharID
				jmp Draw

			Draw:

				lda ZP.CharID
				sta SCREEN_RAM + (17 * 40) + 23, x


				dex
				bne Loop


		rts
	}

	UpdateTimer: {

		lda SecondsTimer
		beq Ready

		dec SecondsTimer
		jmp TimerBar


		Ready:

		lda MAIN.FramesPerSecond
		sta SecondsTimer	

		dec Seconds
		lda Seconds
		beq SecondsReady

		rts

		SecondsReady:


		inc RowQueued

		lda SecondsPerRow
		sta Seconds

		jsr TimerBar



		rts
	}

	CheckTimer: {

		
		lda RowQueued
		beq Finish

	Again:

		jsr NewRow
		dec RowQueued

		jmp CheckTimer


		Finish:

		rts
	}
	
	ProcessFall: {

		lda GravityTimer
		bne Finish

		stx ZP.CurrentID

		jsr BOX.Clear

		ldx ZP.CurrentID

		inc Offset, x
		lda Offset, x
		cmp #3
		bcc Okay

		lda Cells, x
		sta Cells + NUM_COLS, x

		jsr JOIN.CheckCellFixed
		bcc NoJoin

		lda ZP.CurrentID

		jsr JOIN.FindToFall

	NoJoin:

		lda #0
		sta Cells, x
		sta Offset, x
		sta Offset + NUM_COLS, x

		txa
		clc
		adc #NUM_COLS
		sta ZP.CurrentID
		tax

		Okay:

			jsr BOX.Draw
			
		Finish:	

			rts


	}






}