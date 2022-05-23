.namespace GRID {

	.label ROWS = 8
	.label COLUMNS = 5
	.label FISH_PER_GRID = ROWS * COLUMNS
	.label TOTAL_FISH = FISH_PER_GRID * 2
	.label MoveTime = 0
	.label GridSettleTime = 9

	Fish: 		.fill FISH_PER_GRID * 2, NO_FISH
	FrameTimer:	.fill FISH_PER_GRID * 2, 0
	FrameID:	.fill FISH_PER_GRID * 2, 0
	Frame:		.fill FISH_PER_GRID * 2, 0
	YOffset:	.fill FISH_PER_GRID * 2, 0
	MoveTimer:	.fill FISH_PER_GRID * 2, 0

	Row:		.fill COLUMNS, 0
				.fill COLUMNS, 1
				.fill COLUMNS, 2
				.fill COLUMNS, 3
				.fill COLUMNS, 4
				.fill COLUMNS, 5
				.fill COLUMNS, 6
				.fill COLUMNS, 7

				.fill COLUMNS, 0
				.fill COLUMNS, 1
				.fill COLUMNS, 2
				.fill COLUMNS, 3
				.fill COLUMNS, 4
				.fill COLUMNS, 5
				.fill COLUMNS, 6
				.fill COLUMNS, 7

	Player:		.fill FISH_PER_GRID, 0
				.fill FISH_PER_GRID, 1


	RowStart:	.fill ROWS, i * COLUMNS
				.fill ROWS, i * COLUMNS

	RowLookup:	.fill COLUMNS, i

	SideLookup:	.byte 0, ROWS * COLUMNS

	StartFrames:	.fill 8, i * 4

	FrameAdd:		.byte 254, 1, 255, 1, 255, 1, 255, 2

	NextFrameTimeOffset:	.byte 255
	TimeSinceMoved:			.byte 0, 0
	GridChecked:			.byte 0, 0
	CurrentPlayer:			.byte 0
	NextFrameTime:			.byte 0
	NextFrameID:			.byte 0


	Initialise: {

		ldx #0

		Loop:

			jsr RANDOM.Get
			and #%00000011
			lda #NO_FISH
			sta Fish, x

			jsr GetFrameTimeOffset
			sta FrameTimer, x

			jsr RANDOM.Get
			and #%00000111
			sta FrameID, x

			jsr CalculateFrame

			inx
			cpx #FISH_PER_GRID * 2
			bcc Loop
/*
		ldx #37

		lda #FISH_RED
		sta Fish, x

		jsr RANDOM.Get
		and #%00000111
		sta FrameID, x

		jsr CalculateFrame*/


		rts


	}



	Add: {

		//x = player

		lda #0
		sta ZP.Amount

		txa
		tay

		lda PLAYER.SelectedColumn, x
		clc
		adc PLAYER.GridAdd, x
		tax

		lda Fish, x
		bmi IsSpace

		ldx ZP.Player
		rts

		IsSpace:

		inc ZP.Amount

		lda PLAYER.CurrentFish, y
		sta Fish, x

		jsr GetFrameTimeOffset
		sta FrameTimer, x

		jsr RANDOM.Get
		and #%00000111
		sta FrameID, x

		jsr CalculateFrame

		ldx ZP.Player

		lda #0
		sta TimeSinceMoved, x
		sta GridChecked, x

		Finish:


		rts
	}

	CalculateFrame: {

		tay
		lda PLAYER.FrameSequence, y
		sta Frame, x

		lda Fish, x
		asl
		clc
		adc Player, x
		asl
		asl
		clc
		adc Frame, x
		sta Frame, x


		rts
	}


	GetFrameTimeOffset: {

		inc NextFrameTimeOffset

		lda NextFrameTimeOffset
		and #%00000111

		rts


	}

	CheckRise: {

		CheckNotRisingAlready:

			lda YOffset, x
			beq CheckNotTopRow

			jsr ClearFish

			ldy CurrentPlayer
			lda #0
			sta TimeSinceMoved, y

			dec YOffset, x
			rts

		CheckNotTopRow:

			lda Row, x
			beq Finish

			txa
			sec
			sbc #COLUMNS
			tay
			sty ZP.NewID

			lda Fish, y
			bpl Finish

		MoveUp:

			lda Fish, x
			sta Fish, y

			lda FrameID, x
			sta FrameID, y

			lda Frame, x
			sta Frame, y

			lda FrameTimer, x
			sta FrameTimer, y

			lda MoveTimer, x
			sta MoveTimer, y

			lda #1
			sta YOffset, y

			ldy CurrentPlayer
			lda #0
			sta TimeSinceMoved, y

		DeleteOld:	

			stx ZP.GridID
			jsr ClearFish

			lda #NO_FISH
			sta Fish, x

			ldx ZP.NewID

			jsr DrawFish

			ldx ZP.GridID


		Finish:


		rts
	}

	CheckFrame: {

		lda FrameTimer, x
		beq Ready

		dec FrameTimer, x
		rts

		Ready:

			lda #PLAYER.FrameTime
			sta FrameTimer, x

			inc FrameID, x

			lda FrameID, x
			cmp #8
			bcc NoWrap

			lda #0
			sta FrameID, x

			NoWrap:

			tay

			lda FrameAdd, y
			clc
			adc Frame, x
			sta Frame, x

			jsr DrawFish

		Finish:

			rts


	}


	CheckMove: {

		lda MoveTimer, x
		beq Ready

		dec MoveTimer, x
		rts

		Ready:

			lda #MoveTime
			sta MoveTimer, x

			jsr CheckRise

			lda Fish, x
			bmi Finish

			stx ZP.GridID

			jsr DrawFish

		Finish:



		rts
	}

	FrameUpdate: {	

		ldx #0

		Loop:

			stx ZP.GridID

			lda Fish, x
			bmi EndLoop

			lda Player, x
			sta CurrentPlayer

			jsr CheckFrame
			jsr CheckMove

			EndLoop:

				inx
				cpx #TOTAL_FISH
				bcc Loop


		jsr CheckGridSettled

		rts
	}


	CheckGridSettled: {

		ldy #0

		Loop:

			lda TimeSinceMoved, y
			clc
			adc #1
			bcc NoWrap

			lda #255

			NoWrap:

			sta TimeSinceMoved, y

			cmp #GridSettleTime
			bne EndLoop

			jsr CheckGrid

			EndLoop:

			iny 
			cpy #2
			bcc Loop



		rts
	}



	CheckGrid: {

		lda GridChecked, y
		bne Finish

		lda GridChecked, y
		clc
		adc #1
		sta GridChecked, y


		lda PLAYER.Status, y
		cmp #PLAYER_LAUNCH_FISH
		bne Finish

		jsr PLAYER.TransferNextFish


		Finish:



		rts
	}



	
}