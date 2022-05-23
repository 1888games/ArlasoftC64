TITLE: {

	* = * "Title"

	DelayTimer:	.byte DelayTime

	.label DelayTime = 5

	TargetRow:	.byte 1

	Mode:			.byte 1
	Finishing:		.byte 0

	
	FlipTimer:		.byte 0

	Players:		.byte 0
	Speedrun:		.byte 0
	Infinite:		.byte 0
	DebounceTimer:	.byte 0
	CoinCooldown:	.byte 0

	.label FlipTime = 150
	.label DebounceTime = 40

	Rows:			.byte 0, 1
					.byte 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18
					.byte 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18
					.byte 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18
					.byte 23, 24

	Columns:		.byte 15, 15
					.fill 16, 12
					.fill 16, 14
					.fill 16, 21
					.byte 3, 3

	Fill:			.byte 11, 11
					.fill 16, 1
					.fill 16, 6
					.fill 16, 3
					.byte 6, 6

	Colours:		.byte GREEN, GREEN
					.fill 16, LIGHT_RED
					.fill 16, YELLOW
					.fill 16, PURPLE
					.byte GREEN, GREEN
					



	Initialise: {

		
//		You can disable the screen if you put $0B value into the register $D011.
//By setting the register value to $1B you can restore the screen.
	
		
		SkipSave:

		lda #0
		sta INPUT.FIRE_UP_THIS_FRAME + 1
		

		lda #DebounceTime
		sta DebounceTimer

		lda #FlipTime
		sta FlipTimer

		lda #0
		sta Finishing
		sta Mode

		lda #40
		sta CoinCooldown
		
		jsr ColourRows

		jsr SCORE.DrawTitle

		jsr DisplayNames
		jsr DisplayScores


		ldy #35
		jsr SPEECH.StartSequence


		lda #$1B
		sta $d011

		rts
	}




	FrameUpdate: {

		lda CoinCooldown
		cmp #255
		beq NoCoinShow

		cmp #0
		beq Ready

		dec CoinCooldown
		jmp NoCoinShow


		Ready:

		lda #65
		sta SCREEN_RAM + (23 * 40) + 20

		lda #81
		sta SCREEN_RAM + (24 * 40) + 20
		

		NoCoinShow:

		jsr Controls

		jsr RANDOM.Get
		cmp #67
		bne NoSpeech

		jsr RANDOM.Get
		cmp #120
		bcs NoSpeech

		ldy #35
		jsr SPEECH.StartSequence




		NoSpeech:

		rts

	}


	



	Controls: {

		lda DebounceTimer
		beq Okay

		dec DebounceTimer
		rts


		Okay:

		ldy #1



		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq CheckUp

		Start:

			jmp MAIN.ResetGame

		CheckUp:

			lda Players
			beq CheckDown

			lda INPUT.JOY_UP_NOW, y
			beq CheckDown

			dec Players


			lda #10
			sta DebounceTimer

			jmp Finish

		CheckDown:

			//jmp Finish

			lda Players
			cmp #2
			beq Finish

			lda INPUT.JOY_DOWN_NOW, y
			beq Finish

			inc Players

			lda #10
			sta DebounceTimer
		
		Finish:

			//jsr DrawArrow


		rts
	}


	MoveDownRow: {

		lda ZP.ScreenAddress
		clc
		adc #40
		sta ZP.ScreenAddress

		lda ZP.ScreenAddress + 1
		adc #0
		sta ZP.ScreenAddress + 1



		rts
	}

	DisplayScores: {


		ldx #0

		Loop:	

			stx ZP.CurrentID

			lda LowByte, x
			sta SCORE.Digit

			lda MedByte, x
			sta SCORE.Digit + 1

			lda HiByte, x
			sta SCORE.Digit + 2


			txa
			asl
			clc
			adc #3
			tay

			ldx #14


			lda #YELLOW
			sta ZP.Colour
	

			jsr PLOT.GetCharacter
			jsr SCORE.DrawScoreAnywhere


			ldx ZP.CurrentID
			inx
			cpx #8
			bcc Loop



		rts
	}
	// 	ldy #23
	// 	ldx #3

	// 	jsr PLOT.GetCharacter
	// 	jsr DrawScoreAnywhere

	DisplayNames: {

		ldx #21
		ldy #3

		jsr PLOT.GetCharacter

		ldx #0

		Loop:

			stx ZP.CurrentID

			ldy #0

			lda FirstInitials, x
			sta (ZP.ScreenAddress), y

			iny
			lda SecondInitials, x
			sta (ZP.ScreenAddress), y

			iny
			lda ThirdInitials, x
			sta (ZP.ScreenAddress), y

			jsr MoveDownRow


			ldy #0
			lda FirstInitials, x
			clc
			adc #16
			sta (ZP.ScreenAddress), y

			iny
			lda SecondInitials, x
			clc
			adc #16
			sta (ZP.ScreenAddress), y

			iny
			lda ThirdInitials, x
			clc
			adc #16
			sta (ZP.ScreenAddress), y

			jsr MoveDownRow

			inx
			cpx #8
			bcc Loop




		rts
	}


	ColourRows: {

		ldx #0


		Loop:

			stx ZP.StoredXReg


			lda Rows, x
			tay

			lda Fill, x
			sta ZP.Temp4

			lda Columns, x
			tax

			jsr PLOT.GetCharacter

			
			ldy #0
			ldx ZP.StoredXReg

		ColumnLoop:

			lda Colours, x
			sta (ZP.ColourAddress), y

			iny
			cpy ZP.Temp4
			bcc ColumnLoop

			
			inx
			cpx #52
			bcc Loop


		rts
	}


	
}