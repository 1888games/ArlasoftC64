SCORING: {



* = * "Scoring"
	Value: 		.byte 0, 0, 0	
	Value2: 	.byte 0, 0, 0

	Best: 		.byte 0, 0, 0

	* = * "p1"

	PlayerOne: 	.byte 0, 0, 0
	PlayerTwo:	.byte 0, 0, 0

	Amount:	.byte 0

	Rounds:		.byte 0, 0


	.label CharacterSetStart = 48
	.label DoubleCharStart = 206
	.label GemsPerLevel = $50


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


	PerGem:				.byte 0, 0, 0, 0
	DropScore:			.byte 0, 0, 0
	Gems:				.byte 0, 0, 0, 0
	GemsLevelCounter:	.byte 0, 0, 0, 0
	Timer:				.byte $03, $00

	Reset:{

		lda #ZERO
		sta PlayerTwo + 0
		sta PlayerTwo + 1
		sta PlayerTwo + 2
		sta Gems 
		sta Gems + 1
		sta Gems + 2
		sta Gems + 3
		sta GemsLevelCounter
		sta GemsLevelCounter + 1
		sta ScoreToAdd
		sta Amount
		
		ldx #0
		jsr ResetMultipliers

		ldx #1
		jsr ResetMultipliers

		Loop:

		jsr CalculateLevelScore
		jsr DrawPlayerOne
		jsr DrawPlayerOneGems
		jsr DrawPlayerOneLevel

		lda MENU.SelectedOption
		cmp #PLAY_MODE_2P
		bne Finish

		jsr DrawPlayerTwo
		jsr DrawPlayerTwoGems
		jsr DrawPlayerTwoLevel

		Finish:

		lda MENU.SelectedOption
		cmp #PLAY_MODE_TIME
		bne NotTimed

		jsr SetupTimer


		NotTimed:

		

		rts

	}


	SetupTimer: {

		lda #3
		sta Timer + 1

		lda #0
		sta Timer + 0

		jsr DrawTimer

		rts
	}


	CalculateLevelScore: {

		ldx #0
		stx PerGem
		stx PerGem + 1
		stx PerGem + 2
		stx PerGem + 3

		sed

		PlayerLoop:

			ldy #0

			lda PLAYER.Level, x
			clc
			adc #1
			sta ZP.Amount

		LevelLoop:

			lda PerGem, x
			clc
			adc #$10
			sta PerGem, x

			lda PerGem + 2, x
			adc #0
			sta PerGem + 2, x

			iny
			cpy ZP.Amount
			bcc LevelLoop

			inx 
			cpx #2
			bcc PlayerLoop

		cld


		rts
	}

	IncreaseLevelScore: {

		lda PerGem, x
		clc
		adc #$10
		sta PerGem, x

		lda PerGem + 2, x
		adc #0
		sta PerGem + 2, x

		rts
	}


	DrawPlayer: {

		//rts
			
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
			clc
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

			clc
			adc #CharacterSetStart
			sta SCREEN_RAM + 696, y

			ColourText:

				lda #YELLOW
				sta COLOR_RAM + 696, y
			

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

			clc
			adc #CharacterSetStart
			sta SCREEN_RAM + 778, y

			ColourText:
			
				lda #YELLOW
				sta COLOR_RAM +778, y
			

			Skip:

			dey
			rts

		}


		rts
	}


	DrawPlayerOneLevel: {

		ldy #1	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #1
		sta ZP.EndID

		InMills:

		ScoreLoop:

			lda PLAYER.Level, x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			clc
			adc #CharacterSetStart
			sta SCREEN_RAM + 536, y

			ColourText:
			
				lda #YELLOW
				sta COLOR_RAM +536, y
				

			Skip:

			dey
			rts

			}

		Finish:

		rts
	}


	DrawPlayerTwoLevel: {

		ldy #1	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #1
		sta ZP.EndID

		InMills:

		ScoreLoop:

			lda PLAYER.Level + 2, x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			clc
			adc #CharacterSetStart
			sta SCREEN_RAM + 622, y

			ColourText:
			
				lda #YELLOW
				sta COLOR_RAM +622, y
				

			Skip:

			dey
			rts

			}

		Finish:

		rts
	}

	DrawPlayerOneGems: {

		ldy #3	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #2
		sta ZP.EndID

		lda Gems + 1, x
		bne ScoreLoop

		dec ZP.EndID
		dey

		InMills:

		ScoreLoop:

			lda Gems, x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			clc
			adc #CharacterSetStart
			sta SCREEN_RAM + 856, y

			ColourText:
			
				lda #YELLOW
				sta COLOR_RAM +856, y
				

			Skip:

			dey
			rts

			}

		Finish:

		rts
	}

	DrawPlayerTwoGems: {

		ldy #3	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #2
		sta ZP.EndID

		lda Gems + 3, x
		bne ScoreLoop

		dec ZP.EndID
		dey

		InMills:

		ScoreLoop:

			lda Gems + 2, x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			clc
			adc #CharacterSetStart
			sta SCREEN_RAM + 941, y

			ColourText:
			
				lda #YELLOW
				sta COLOR_RAM +941, y
				

			Skip:

			dey
			rts

			}

		Finish:

		rts
	}


	DrawPlayerOneDrop: {

		ldy #4	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #3
		sta ZP.EndID

		lda DropScore + 2, x
		bne ScoreLoop

		dec ZP.EndID
		dey

		lda DropScore + 1, x
		bne ScoreLoop

		dec ZP.EndID

		InMills:

		ScoreLoop:

			lda DropScore, x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			asl
			clc
			adc #DoubleCharStart
			sta SCREEN_RAM + 415, y

			clc
			adc #1
			sta SCREEN_RAM + 455, y

			ColourText:
			
				lda #YELLOW
				sta COLOR_RAM +415, y
				sta COLOR_RAM + 455, y
			

			Skip:

			dey
			rts

			}

		Finish:

		rts
	}

	DrawPlayerTwoDrop: {

		ldy #4	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #3
		sta ZP.EndID

		lda DropScore + 2, x
		bne ScoreLoop

		dec ZP.EndID
		dey

		lda DropScore + 1, x
		bne ScoreLoop

		dec ZP.EndID

		InMills:

		ScoreLoop:

			lda DropScore, x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			asl
			clc
			adc #DoubleCharStart
			sta SCREEN_RAM + 460, y

			clc
			adc #1
			sta SCREEN_RAM + 500, y

			ColourText:
			
				lda #YELLOW
				sta COLOR_RAM +460, y
				sta COLOR_RAM + 500, y
			

			Skip:

			dey
			rts

			}

		Finish:

		rts
	}


	CheckTimer: {

		lda MENU.SelectedOption
		cmp #PLAY_MODE_TIME
		bne Finish

		lda PLAYER.RoundOver
		bne Finish
		
		sed

		lda Timer
		sec
		sbc #1
		sta Timer
		bcs NoWrap

		lda Timer + 1
		bne MinutesLeft

		lda #0
		sta Timer
		sta ZP.Player

		cld
		jmp PLAYER.LostRound

		MinutesLeft:

		lda #$59
		sta Timer

		lda Timer + 1
		sec
		sbc #1
		sta Timer + 1

		NoWrap:

		cld

		jsr DrawTimer


		Finish:



		rts
	}


	DrawTimer: {


		ldy #3	// screen offset, right most digit
		ldx #ZERO	// score byte index

		ScoreLoop:

			lda Timer, x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			jsr PlotDigit

			inx

			cpx #2
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			cpy #255
			beq Skip

			asl
			clc
			adc #DoubleCharStart
			sta SCREEN_RAM + 460, y

			clc
			adc #1
			sta SCREEN_RAM + 500, y

			ColourText:
			
				lda #GREEN
				sta COLOR_RAM +460, y
				sta COLOR_RAM + 500, y

			cpy #2
			bne Skip

			dey

			lda #183
			sta SCREEN_RAM + 460, y
			sta SCREEN_RAM + 500, y

			lda #GREEN
			sta COLOR_RAM +460, y
			sta COLOR_RAM + 500, y
			

			Skip:

			dey
			rts

			}

		Finish:

		rts
	}




	FrameUpdate: {

		
		lda #0
		sta DropScore + 0
		sta DropScore + 1
		sta DropScore + 2

		Player1:

			lda CurrentMultiplier + 0
			beq Player2

	
			lda CurrentChain + 0
			tay

			ChainLoop1:	

			ldx CurrentMultiplier + 0
			dex

			MultLoop1:

				CheckLoop1:


					jsr AddDropP1

					dex
					bpl MultLoop1


					lda CurrentMultiplier

					

					dey
					bpl ChainLoop1

			lda #0
			sta CurrentMultiplier

			jsr DrawPlayerOneDrop
			jsr AddGemP1


		Player2:

			lda CurrentMultiplier + 1
			beq Finish
			
			lda CurrentChain + 1
			tay

			ChainLoop2:	

			ldx CurrentMultiplier + 1
			dex

			MultLoop2:

				CheckLoop2:

					jsr AddDropP2

					dex
					bpl MultLoop2

					dey
					bpl ChainLoop2

			lda #0
			sta CurrentMultiplier + 1

			jsr DrawPlayerTwoDrop


			jsr AddGemP2



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

			sta SCREEN_RAM + 460, y
			sta SCREEN_RAM + 500, y
			
			iny
			cpy #5
			bcc Loop1

			rts

		Player1:

			lda #0
			ldy #0

			Loop2:

			sta SCREEN_RAM + 415, y
			sta SCREEN_RAM + 455, y
			
				
			iny
			cpy #5
			bcc Loop2



		rts


	}

	DrawMultiplier: {

		rts

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

	AddGems: {

		txa
		asl
		tay

		ldx #0
		sed

		Loop:

			lda Gems + 0, y
			clc
			adc #1
			sta Gems + 0, y

			lda Gems + 1, y
			adc #0
			sta Gems + 1, y

			lda GemsLevelCounter, y
			clc
			adc #1
			sta GemsLevelCounter, y

			inx
			cpx GRID.MatchCount
			bcc Loop

		cld

		ldx GRID.CurrentSide

		lda GemsLevelCounter, y
		cmp #GemsPerLevel
		bcc NotNewLevel

		sed

		sec
		sbc #GemsPerLevel
		sta GemsLevelCounter, y

		jsr IncreaseLevel


		NotNewLevel:

		ldx GRID.CurrentSide
		beq Player1_	

		Player2_:

			jsr DrawPlayerTwoGems

			rts



		Player1_:

			jsr DrawPlayerOneGems


		rts
	}


	IncreaseLevel: {

		jsr IncreaseLevelScore

		lda PLAYER.CurrentAutoDropTime, x
		cmp #7
		bcs ReduceByThree

		dec PLAYER.CurrentAutoDropTime, x

		jmp CheckFloor

		ReduceByThree:

			lda PLAYER.CurrentAutoDropTime, x
			sec
			sbc #3
			sta PLAYER.CurrentAutoDropTime, x

		CheckFloor:

			cmp #2
			bcs Done

			lda #2
			sta PLAYER.CurrentAutoDropTime, x
		
		Done:

			lda PLAYER.Level, x
			clc
			adc #1
			sta PLAYER.Level, x

			cld

			cpx #0
			beq Player1

		Player2:

			jsr DrawPlayerTwoLevel

			lda #250
			ldy #192
			ldx #255

			jmp ShowRockford

		Player1:

			jsr DrawPlayerOneLevel

			lda GRID.Active + 1
			beq NoSecondPlayer

			lda #250
			ldy #192
			ldx #70

			jmp ShowRockford

		NoSecondPlayer:

			lda #250
			ldy #192
			ldx #255
		
		ShowRockford:

			jsr ROCKFORD.Start
		
			ldx GRID.CurrentSide



		rts
	}

	CalculateMultiplier: {

		// x = player

		jsr AddGems

		ldx GRID.CurrentSide

		lda #0
		sta CurrentMultiplier, x

		ldy #0

		ColourLoop:


			lda GRID.MatchesByColour, y
			beq EndLoop
			clc
			adc CurrentMultiplier, x
			sta CurrentMultiplier, x

			lda GRID.MatchesByColour, y
			sec
			sbc #3
			clc
			adc CurrentMultiplier, x
			sta CurrentMultiplier, x

			EndLoop:

			iny
			cpy #8
			bcc ColourLoop


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








	AddOne: {

		lda PLAYER.Level, x
		clc
		adc #1

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


	AddDropP1: {

		sed
		
		lda DropScore + 0
		clc
		adc PerGem + 0
		sta DropScore + 0

		lda DropScore + 1
		adc #0
		sta DropScore + 1

		lda DropScore + 2
		adc #0
		sta DropScore + 2

		lda DropScore + 1
		clc
		adc PerGem + 2
		sta DropScore + 1

		lda DropScore+ 2
		adc #0
		sta DropScore + 2

		cld

		rts
	}


	AddDropP2: {

		sed
		
		lda DropScore + 0
		clc
		adc PerGem + 1
		sta DropScore + 0

		lda DropScore + 1
		adc #0
		sta DropScore + 1

		lda DropScore + 2
		adc #0
		sta DropScore + 2

		lda DropScore + 1
		clc
		adc PerGem + 3
		sta DropScore + 1

		lda DropScore+ 2
		adc #0
		sta DropScore + 2

		cld


		rts
	}


	AddGemP1: {

		sed

		lda PlayerOne + 0
		clc
		adc DropScore + 0
		sta PlayerOne + 0

		lda PlayerOne + 1
		adc #0
		sta PlayerOne + 1

		lda PlayerOne + 2
		adc #0
		sta PlayerOne + 2

		lda PlayerOne + 1
		clc
		adc DropScore + 1
		sta PlayerOne + 1

		lda PlayerOne + 2
		adc #0
		clc
		adc DropScore + 2
		sta PlayerOne + 2

		cld

		lda #1
		sta DrawWhenFree

		rts
	}

	AddGemP2: {

		sed

		lda PlayerTwo + 0
		clc
		adc DropScore + 0
		sta PlayerTwo + 0

		lda PlayerTwo + 1
		adc #0
		sta PlayerTwo + 1

		lda PlayerTwo + 2
		adc #0
		sta PlayerTwo + 2

		lda PlayerTwo + 1
		clc
		adc DropScore + 1
		sta PlayerTwo + 1

		lda PlayerTwo + 2
		adc #0
		clc
		adc DropScore + 2
		sta PlayerTwo + 2

		cld

		lda #1
		sta DrawWhenFree

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