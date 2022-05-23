TITLE: {

	* = * "Title"

	DelayTimer:	.byte DelayTime

	.label DelayTime = 5

	TargetRow:	.byte 1

	//CurrentRows:	.byte 25, 26, 36, 38, 43, 47
	CurrentRows:	.byte 2, 3, 13, 15, 17, 20, 22

	Columns:		.byte 5, 7, 14, 14, 14, 8, 9
	Colours:		.byte WHITE, RED, WHITE, WHITE, WHITE, WHITE, RED
	Mode:			.byte 1
	Finishing:		.byte 0

	ScrollValue:	.byte 7

	Scrolling:		.byte 0

	LogoColours:	.byte GREEN, GREEN, BLUE, BLUE, CYAN, CYAN
	LogoColour:		.byte 0

	FlipTimer:		.byte 0

	Players:		.byte 0
	Speedrun:		.byte 0
	Infinite:		.byte 0
	DebounceTimer:	.byte 0

	.label FlipTime = 150
	.label DebounceTime = 40

	FrameUpdate: {


		lda Mode
		bne NotScroll


		NotScroll:

	
		jsr Controls

		lda FlipTimer
		beq Flip

		lda ZP.Counter
		and #%00000001
		beq Exit

		//dec FlipTimer

		Exit:

		rts


		Flip:

		lda #0
		jsr HI_SCORE.Show

		rts

	}


	

	CheckLeft: {

		lda INPUT.JOY_LEFT_NOW, y
		beq Finish

		lda INPUT.JOY_LEFT_LAST, y
		bne Finish

		lda Infinite
		eor #%00000001
		lda Infinite
		lda VIC.BORDER_COLOR

		 //nop
		 //nop
		 //nop
		 //nop
		//nop
		 //nop

		* = * "Check Left Finish"

		Finish:


		rts
	}

	Controls: {

		lda DebounceTimer
		beq Okay

		dec DebounceTimer
		rts


		Okay:

		ldy #1


		jsr CheckLeft


		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq CheckUp

		Start:

			jsr MAIN.ResetGame

			
		//	lda #SUBTUNE_START
		//	jsr sid.init

			rts

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


	Initialise: {

		lda HI_SCORE.NeedToSave
		beq SkipSave

		jsr HI_SCORE.ShowSave

		SkipSave:

		lda #0
		sta INPUT.FIRE_UP_THIS_FRAME + 1
		sta LogoColour

		lda #DebounceTime
		sta DebounceTimer

		
		lda #FlipTime
		sta FlipTimer

		
		lda #0
		sta Finishing
		sta Mode
		

		lda #2
		sta CurrentRows

		lda #3
		sta CurrentRows + 1

		lda #13
		sta CurrentRows + 2

		lda #15
		sta CurrentRows + 3

		lda #17
		sta CurrentRows + 4

		lda #20
		sta CurrentRows + 5

		lda #22
		sta CurrentRows + 6

		//jsr DrawLogo

		lda #SUBTUNE_BLANK
		jsr sid.init

		lda #1
		sta allow_channel_1

		//jsr DrawArrow

	

		rts
	}


	DeleteRow: {


		lda Columns, x
		sta ZP.Column

		lda CurrentRows, x
		sta ZP.Row
		tay

		lda #0
		ldx ZP.Column

		jsr PLOT.PlotCharacter

		ldy #255

		Loop:

			iny
			cpy #25
			bcs Finish

			lda (ZP.ScreenAddress), y
			cmp #197
			bcs NoDelete

			lda #0
			sta (ZP.ScreenAddress), y

			NoDelete:

			jmp Loop

		Finish:


		rts
	}


	
}