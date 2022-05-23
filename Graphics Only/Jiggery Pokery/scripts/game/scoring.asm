SCORING: {



* = * "Scoring"
	Value: 		.byte 0, 0, 0	
	Value2: 	.byte 0, 0, 0

	Best: 		.byte 0, 0, 0

	PlayerOne: 	.byte 0, 0, 0
	PlayerTwo:	.byte 0, 0, 0

	Amount:	.byte 0

	Rounds:		.byte 0, 0


	.label CharacterSetStart = 206


	ScoreToAdd: 		.byte 0, 0
	DrawWhenFree:		.byte 0
	ScoreInitialised: 	.byte 0

	CurrentMultiplier:	.byte 0, 0
	CurrentBeans:		.byte 0, 0
	CurrentGroupBonus:	.byte 0, 0
	CurrentColours:		.byte 0, 0
	TempBeans:			.byte 0

	Colours:		.byte 0, 0, 0, 0, 0, 0, 0, 0
					.byte 0, 0, 0, 0, 0, 0, 0, 0

	ColourOffset:	.byte 0, 8
	ColourCount:	.byte 0, 0
	CurrentChain:	.byte 0, 0

	MultColumns:	.byte 21, 22
	MultRows:		.byte 18, 21
	TextColours:	.byte RED+8, CYAN + 8
	BeanColumns:	.byte 16, 17


	.label PointsPerBean = 10
	.label MaxPerFrame = 50
		.label MultiplierCharID = 125

	ChainPowerSingle:	.byte 4, 20, 24, 32, 48, 96, 160, 240, 255, 255, 255
	ChainPower2P:		.byte 1, 8, 16, 32, 64, 96, 128, 160, 192, 224, 255
	ColourBonus:		.byte 0, 3, 6, 12, 24
	GroupBonus:			.byte 0, 2, 3, 4, 5, 6, 7, 10
	TimesTen:			.byte 0, $10, $20, $30, $40, $50, $60, $70, $80, $90

	Reset:{

		lda #ZERO
		sta PlayerTwo + 0
		sta PlayerTwo + 1
		sta PlayerTwo + 2
		sta ScoreToAdd
		sta Amount
		
		ldx #0
		jsr ResetMultipliers

		ldx #1
		jsr ResetMultipliers

		Loop:


		Finish:

		//jsr DrawPlayerOne
		//jsr DrawPlayerTwo

		rts

	}




	DrawPlayer: {
			
		jsr ClearScorePanel

		cpx #0
		beq Player1

		Player2:

			jsr DrawPlayerTwo
			rts

		Player1:

			jsr DrawPlayerOne
			rts
	}

	DrawExperience: {


		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
	
		ScoreLoop:

			lda PlayerOne,x
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

			asl
			adc #CharacterSetStart
			sta SCREEN_RAM + 86, y

			clc
			adc #1
			sta SCREEN_RAM + 126, y

			ColourText:

				lda #RED +8

				sta COLOR_RAM +86, y
				sta COLOR_RAM +126, y

			dey
			rts

		}


		rts
	}

	DrawPlayerOne: {

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
	
		ScoreLoop:

			lda PlayerOne,x
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

			asl
			adc #CharacterSetStart
			sta SCREEN_RAM + 736, y

			clc
			adc #1
			sta SCREEN_RAM + 776, y

			ColourText:

				lda #RED +8

				sta COLOR_RAM +736, y
				sta COLOR_RAM +776, y

			dey
			rts

		}


		rts
	}







	DrawPlayerTwo: {

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
		
		ScoreLoop:

			lda PlayerTwo,x
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

			asl
			adc #CharacterSetStart
			sta SCREEN_RAM + 858, y

			clc
			adc #1
			sta SCREEN_RAM + 898, y

			ColourText:
			
				lda #CYAN +8
				sta COLOR_RAM +858, y
				sta COLOR_RAM +898, y

			Skip:

			dey
			rts

		}


		rts
	}



	FrameUpdate: {

		Player1:

			lda CurrentMultiplier + 0
			beq Player2

			tax
			dex
			ldy #MaxPerFrame

			MultLoop1:

				stx ZP.X

				lda CurrentBeans
				sta ZP.TempBeans

				CheckLoop1:

					cmp #10
					bcc Okay

					sec
					sbc #9
					sta ZP.TempBeans

					lda TimesTen + 9
					
					jsr AddPlayerOne

					lda ZP.TempBeans
					jmp CheckLoop1

				Okay:

					tax
					lda TimesTen, x
					
					jsr AddPlayerOne

					//dey
					//bmi Player2

					ldx ZP.X
					dex
					bpl MultLoop1

			lda #0
			sta CurrentMultiplier



		Player2:

			lda CurrentMultiplier + 1
			beq Finish

			tax
			dex
			ldy #MaxPerFrame

			MultLoop2:

				stx ZP.X

				lda CurrentBeans + 1
				sta ZP.TempBeans

				CheckLoop2:

					cmp #10
					bcc Okay2

					sec
					sbc #9
					sta ZP.TempBeans

					lda TimesTen + 9
					
					jsr AddPlayerTwo

					lda ZP.TempBeans
					jmp CheckLoop2

				Okay2:

					tax
					lda TimesTen, x
				
					jsr AddPlayerTwo

					//dey
					//bmi Finish

					ldx ZP.X
					dex
					bpl MultLoop2

			lda #0
			sta CurrentMultiplier + 1



		Finish:


		rts
	}




	ResetMultipliers: {

		lda #0
		sta CurrentGroupBonus, x
		sta ColourCount, x
		sta CurrentChain, x
		sta CurrentBeans ,x
		sta CurrentMultiplier, x
		sta CurrentColours, x

		lda ColourOffset, x
		tay

		lda #0
		sta Colours, y
		sta Colours + 1, y
		sta Colours + 2, y
		sta Colours + 3, y
		sta Colours + 4, y
		sta Colours + 5, y
		sta Colours + 6, y
		sta Colours + 7, y



		rts
	}



	ClearScorePanel: {

		cpx #0
		beq Player1

		Player2:

			lda #0
			ldy #0

			Loop1:

				sta SCREEN_RAM + 857, y
				sta SCREEN_RAM + 897, y
					
				iny
				cpy #9
				bcc Loop1

			rts

		Player1:

			lda #0
			ldy #0

			Loop2:

				sta SCREEN_RAM + 735, y
				sta SCREEN_RAM + 775, y
					
				iny
				cpy #8
				bcc Loop2



		rts


	}

	DrawMultiplier: {

		jsr ClearScorePanel

		ConvertToDigits:

			lda CurrentMultiplier, x
			jsr TEXT.ByteToDigits

		GetPosition:

			ldx GRID.CurrentSide

			lda MultRows, x
			sta ZP.TextRow

			lda MultColumns, x
			sta ZP.TextColumn	

		DrawX:

			ldy ZP.TextRow

			ldx ZP.TextColumn
			dex
			dex

			lda #0
			jsr DRAW.PlotCharacter

			lda #MultiplierCharID
			iny

			jsr DRAW.PlotCharacter

		DrawMult:

			ldx GRID.CurrentSide

			lda TextColours, x
			tay

			lda #0
			ldx #3
			jsr TEXT.DrawTallDigits


		Beans:

			ldx GRID.CurrentSide

			lda CurrentBeans, x
			jsr TEXT.ByteToDigits

			lda TEXT.Digits + 1
			sta TEXT.Digits 

			lda TEXT.Digits + 2
			sta TEXT.Digits + 1

			lda #0
			sta TEXT.Digits + 2

		GetPosition2:

			ldx GRID.CurrentSide
			lda BeanColumns, x
			sta ZP.TextColumn	

			lda TextColours, x
			tay

		DrawBean:

			ldx #3
			lda #0
			jsr TEXT.DrawTallDigits

			ldx GRID.CurrentSide



		rts
	}

	DrawDigits: {





		rts
	}


	CalculateMultiplier: {

		// x = player


		lda #0
		sta CurrentMultiplier, x

		AddChain:

			lda CurrentChain, x
			tay

			lda MENU.SelectedOption
			cmp #1
			bne SinglePlayer

		TwoPlayer:

			lda ChainPower2P, y
			jmp Skip
			
		SinglePlayer:

			lda ChainPowerSingle, y

		Skip:

			sta CurrentMultiplier, x

		AddColour:

			lda ColourCount, x
			tay
			dey
			lda ColourBonus, y
			clc
			adc CurrentMultiplier, x
			sta CurrentMultiplier, x
			bcc NoCarry1

			lda #255
			sta CurrentMultiplier, x

			NoCarry1:

			lda CurrentGroupBonus, x
			clc
			adc CurrentMultiplier, x
			sta CurrentMultiplier, x

			bcc NoCarry2

			lda #255
			sta CurrentMultiplier, x

			NoCarry2:

		jsr DrawMultiplier

		lda #0
		sta CurrentGroupBonus, x
		sta ColourCount, x

		rts
	}





	BeansCleared: {

		// x = player
		// a = beans cleared - 4
		pha

		CalculateGroupMultiplerAdd:

			tay
			lda GroupBonus, y
			clc
			adc CurrentGroupBonus, x
			sta CurrentGroupBonus, x

		AddToCurrentBeans:

			tya
			clc
			adc #4
			adc CurrentBeans, x
			sta CurrentBeans, x

		lda ColourOffset, x
		clc
		adc ZP.BeanColour
		tay

		lda Colours, y
		bne Finish

		inc ColourCount, x

		lda #1
		sta Colours, y

		Finish:

		pla

		rts
	}





	AddToScore:{

		lda ScoreToAdd
		clc
		adc Amount
		sta ScoreToAdd
		rts


	}

	ScorePoints: {

		sta Amount
		jsr AddToScore

		rts
	}



	AddOne: {

		lda #1

		cpx #0
		beq Player1

		Player2:

			jsr AddPlayerTwo
			jsr DrawPlayerTwo
			jmp Finish		

		Player1:

			jsr AddPlayerOne
			jsr DrawPlayerOne

		Finish:



		rts



	}

	AddPlayerOne: {

		sta ZP.Amount
		sed
		clc
		lda PlayerOne
		adc ZP.Amount
		sta PlayerOne
		lda PlayerOne + 1
		adc #ZERO
		sta PlayerOne + 1
		lda PlayerOne + 2

		adc #ZERO
		sta PlayerOne + 2
		cld

		lda #1
		sta DrawWhenFree
		
		rts


	}


	AddPlayerTwo: {

		sta ZP.Amount
		sed
		clc
		lda PlayerTwo
		adc ZP.Amount
		sta PlayerTwo
		lda PlayerTwo + 1
		adc #ZERO
		sta PlayerTwo + 1
		lda PlayerTwo + 2

		adc #ZERO
		sta PlayerTwo + 2
		cld

		lda #1
		sta DrawWhenFree
		
		rts


	}

	



}