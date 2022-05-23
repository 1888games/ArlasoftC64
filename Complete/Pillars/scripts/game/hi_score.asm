HI_SCORE:  {
		
	.label ScreenTime = 250
	.label ColourTime = 5
	.label SCORE_MODE_VIEW = 0
	.label SCORE_MORE_ENTER = 1
	.label InputCooldown = 5



	ScreenTimer: 		.byte ScreenTime
	Screen:				.byte 0

	Colour:			.byte 1
	ColourTimer:	.byte ColourTime

	StartIndexes:	.byte 0, 5, 10

	Rows:		.byte 8, 11, 14, 17, 20

	NameAddresses:	.word SCREEN_RAM + 335, SCREEN_RAM + 455, SCREEN_RAM + 575, SCREEN_RAM + 695, SCREEN_RAM + 815
	ScoreAddresses:	.word SCREEN_RAM + 344, SCREEN_RAM + 464, SCREEN_RAM + 584, SCREEN_RAM + 704, SCREEN_RAM + 824

	Scores:	.byte 0, 0, 0


	PlayerPosition:	.byte 0
	InitialPosition:	.byte 0

	Mode:		.byte 0
	Cooldown:	.byte 0

	PositionLookup:	.byte 0, 3, 6, 9, 12



	* = $fa00 "Hi score_Code"
	Show: {

		//lda #1
		sta Mode

		jsr MAIN.SetupVIC

		lda #0
		sta VIC.SPRITE_ENABLE

		lda #1
		sta Colour

		lda #ScreenTime
		sta ScreenTimer

		lda #BLACK
		sta VIC.BORDER_COLOUR

		lda #BLACK
		sta VIC.BACKGROUND_COLOUR

		jsr DRAW.HiScoreScreen
	//	jsr ColourRows

		

		jsr PopulateTable

		lda Mode
		beq ViewMode

		jmp ShowEnterMode

		ViewMode:

		lda #0
		sta Screen

		jmp HiScoreLoop


	}


	ShowEnterMode: {






		jmp HiScoreLoop
	}



	Check: {


		lda MENU.SelectedOption
		sta Screen
		cmp #PLAY_MODE_2P
		bne Player1

		ldx ROUND_OVER.Winner
		beq Player1

		Player2:

			lda SCORING.PlayerTwo
			sta Scores

			lda SCORING.PlayerTwo + 1
			sta Scores + 1

			lda SCORING.PlayerTwo + 2
			sta Scores + 2
			jmp CheckScore

		Player1:

			lda SCORING.PlayerOne
			sta Scores

			lda SCORING.PlayerOne + 1
			sta Scores + 1

			lda SCORING.PlayerOne + 2
			sta Scores + 2

		CheckScore:

		ldx Screen
		lda StartIndexes, x
		sta ZP.StartID

		lda #255
		sta ZP.Amount

		ldx #0

		Loop:

			stx ZP.X

			ldx ZP.StartID 
			lda Scores + 2
			cmp HiByte, x
			bcc EndLoop

			beq EqualsHigh

			BiggerHigh:

				stx ZP.Amount
				jmp Done

			EqualsHigh:

				lda Scores + 1
				cmp MedByte, x
				bcc EndLoop

				beq EqualsMed

			BiggerMed:

				stx ZP.Amount
				jmp Done

			EqualsMed:

				lda Scores
				cmp LowByte, x
				bcc EndLoop

				stx ZP.Amount
				jmp Done

			EndLoop:	

				inc ZP.StartID

				ldx ZP.X
				inx
				cpx #5
				bcc Loop


		Done:

			lda ZP.Amount
			bmi Finish

			lda Scores + 2
			sta HiByte, x

			lda Scores + 1
			sta MedByte, x

			lda Scores
			sta LowByte, x

			lda #0
			sta InitialPosition

			lda #1
			sta FirstInitials, x

			lda #32
			
			sta SecondInitials, x
			sta ThirdInitials, X

			lda ZP.X
			sta PlayerPosition

			lda #GAME_MODE_SWITCH_SCORE
			sta MAIN.GameMode


		Finish:


		rts






	}

	PopulateHeader: {

		lda #16
		sta ZP.TextColumn

		lda #5
		sta ZP.TextRow

		lda Screen
	
		ldx #WHITE

		jsr TEXT.Draw
	


		rts
	}


	PopulateTable: {


		jsr PopulateHeader

		ldx Screen
		lda StartIndexes, x
		sta ZP.StartID

		Names:

		ldx #0

		Loop:

			stx ZP.X

			txa
			asl
			tax
			lda NameAddresses, x
			sta ZP.ScreenAddress

			lda NameAddresses + 1, x
			sta ZP.ScreenAddress + 1

			ldx ZP.StartID
			lda FirstInitials, x

			ldy #0
			sta (ZP.ScreenAddress), y

			lda SecondInitials, x

			iny
			sta (ZP.ScreenAddress), y

			lda ThirdInitials, x

			iny
			sta (ZP.ScreenAddress), y

			inc ZP.StartID

			ldx ZP.X
			inx
			cpx #5
			bcc Loop


		Score:

		ldx Screen
		lda StartIndexes, x
		sta ZP.StartID


		ldx #0

		Loop2:

			stx ZP.X

			txa
			asl
			tax
			lda ScoreAddresses, x
			sta ZP.ScreenAddress

			lda ScoreAddresses + 1, x
			sta ZP.ScreenAddress + 1

			ldx ZP.StartID

			lda HiByte, x
			sta Scores + 2

			lda MedByte, x
			sta Scores + 1

			lda LowByte, x
			sta Scores

			jsr DrawScore

			inc ZP.StartID

			ldx ZP.X
			inx
			cpx #5
			bcc Loop2





		rts
	}




	DrawScore: {

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
		
		ScoreLoop:

			lda Scores,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {


			clc
			adc #48
			sta (ZP.ScreenAddress), y


			dey
			rts

		}


		rts
	}


	HiScoreLoop: {


		WaitForRasterLine:

			lda VIC.RASTER_LINE
			cmp #175
			bne WaitForRasterLine


		lda Mode
		bne Finish

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		jmp MENU.Show

		Finish:

		jmp FrameCode
	}




	EnterMode: {

		lda Cooldown
		beq Ready

		dec Cooldown
		jmp Finish

		Ready:	

		lda #InputCooldown
		sta Cooldown

		ldx Screen
		lda StartIndexes, x
		clc
		adc PlayerPosition
		sta ZP.StartID

		CheckRight:

			ldy #1
			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckLeft


			ldx ZP.StartID
			lda InitialPosition
			beq First

			cmp #1
			beq Second

		Third:

			inc ThirdInitials, x
			lda ThirdInitials, x
			cmp #27
			bcc Draw

			lda #1
			sta ThirdInitials, x
			jmp Draw

		Second:

			inc SecondInitials, x
			lda SecondInitials, x
			cmp #27
			bcc Draw

			lda #1
			sta SecondInitials, x
			jmp Draw

		First:

			inc FirstInitials, x
			lda FirstInitials, x
			cmp #27
			bcc Draw

			lda #1
			sta FirstInitials, x
			jmp Draw

		CheckLeft:
			
			lda INPUT.JOY_LEFT_NOW, y
			beq Finish

			ldx ZP.StartID
			lda InitialPosition
			beq First2

			cmp #1
			beq Second2

		Third2:

			dec ThirdInitials, x
			lda ThirdInitials, x
			bne Draw

			lda #26
			sta ThirdInitials, x
			jmp Draw

		Second2:

			dec SecondInitials, x
			lda SecondInitials, x
			bne Draw
		
			lda #26
			sta SecondInitials, x
			jmp Draw

		First2:

			dec FirstInitials, x
			lda FirstInitials, x
			bne Draw
		
			lda #26
			sta FirstInitials, x
			jmp Draw


		Draw:

			jsr PopulateTable
			jmp HiScoreLoop


		Finish:

			ldy #1
			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq NoFire

			ldx ZP.StartID

			inc InitialPosition
			lda InitialPosition
			cmp #3
			beq Fire

			cmp #2
			bne Second3

			Third3:

				lda #1
				sta ThirdInitials, x
				jsr PopulateTable
				jmp NoFire

			Second3:

				lda #1
				sta SecondInitials, x
				jsr PopulateTable
				jmp NoFire

			Fire:

				lda #0
				sta Mode

			    sta $d404               // Sid silent 
	            sta $d404+7 
	            sta $d404+14

				jsr DISK.SAVE	

				lda #0
				sta VIC.SPRITE_ENABLE


			NoFire:

			jmp HiScoreLoop

	}

	FrameCode: {

		jsr ColourRows

		lda Mode
		beq ViewMode

		jmp EnterMode


		ViewMode:

		lda ScreenTimer
		beq Ready

		dec ScreenTimer
		jmp HiScoreLoop

		Ready:

		lda #ScreenTime
		sta ScreenTimer

		lda ZP.FrameCounter
		and #%00000001
		beq Flip

		jmp HiScoreLoop

		Flip:

		inc Screen
		lda Screen
		cmp #3
		bcc Okay

		lda #0
		sta Screen

		jmp MENU.Show

		Okay:

		jsr PopulateTable


		jmp HiScoreLoop


	}


	NextColour: {

		ldy Colour
		iny
		cpy #8
		bcc Okay


		ldy #1

		Okay:

		sty Colour
		tya

		rts



	}


	One:

	jsr NextColour
	sta COLOR_RAM + 331, x
	rts

	Two:

	jsr NextColour
	sta COLOR_RAM + 451, x
	rts

	Three:

	jsr NextColour
	sta COLOR_RAM + 571, x
	rts

	Four:

	jsr NextColour
	sta COLOR_RAM + 691, x
	rts

	Five:

	jsr NextColour
	sta COLOR_RAM + 811, x
	rts



	ColourRows: {

		lda ColourTimer
		beq Ready

		dec ColourTimer
		rts


		Ready:


		lda #ColourTime
		sta ColourTimer

		ldx #0

		Loop:	

			lda Mode
			beq DrawAll


			DrawOne:

			lda PlayerPosition
			bne Not1

			jsr One
			jmp EndLoop

			Not1:

			cmp #1
			bne Not2

			jsr Two
			jmp EndLoop

			Not2:

			cmp #2
			bne Not3

			jsr Three
			jmp EndLoop


			Not3:

			cmp #3
			bne Not4

			jsr Four
			jmp EndLoop

			Not4:

			jsr Five
			jmp EndLoop


			DrawAll:

			jsr One
			jsr Two
			jsr Three
			jsr Four
			jsr Five

			EndLoop:

			inx
			cpx #19
			bcc Loop


		rts
	}




	* = $3900 "Hi score_Data"

		FirstInitials:		.text "ATNKFSMSLJNIPRT"
		SecondInitials:		.text "MIIEATEAEAEAAIO"
		ThirdInitials:		.text "YMCVZEGMNKDNTCM"

		// HiByte:				.byte $10, $07, $04, $02, $01, $10, $07, $04, $02, $01, $10, $07, $05, $02, $01
		// MedByte:			.byte $45, $69, $82, $57, $50, $45, $69, $82, $57, $29, $52, $41, $11, $40, $58
		// LowByte:			.byte $23, $12, $70, $63, $78, $91, $52, $46, $02, $08, $99, $31, $47, $28, $12

		HiByte:				.byte $10, $05, $02, $00, $00, $02, $01, $00, $00, $00, $07, $03, $01, $00, $00
		MedByte:			.byte $00, $00, $50, $50, $10, $50, $00, $50, $20, $05, $50, $75, $50, $75, $10
		LowByte:			.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
		
		Gypsy:				.byte $00, $00, $00
		Unlocked:			.byte $00
		


}