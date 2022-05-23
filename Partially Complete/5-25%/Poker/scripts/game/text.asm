TEXT: {

	.label CharacterSetstart = 74
	.label DollarSign = 122
	.label Blank = 111

	.label PotRow = 9
	.label PotColumn= 19

	.label BetRow = 7
	.label BetColumn = 0

	.label LeftArrow = 205
	.label RightArrow = 206

	Value:	.byte 0, 0, 0

	ArrowColour:	.byte 0
	ArrowTimer:	.byte 2, 2

	Messages:	.text "        "
				.text "        "
				.text "        "
				.text "  fold  "
				.text "  check "
				.text "  call  "
				.text "  bet   "
				.text "  raise "
	
				

	DrawNames: {

		ldx #0

		Loop:

			stx PlayerID

			jsr DrawName
			jsr DrawChips
			jsr ClearBet
			//jsr DrawBet

			ldx PlayerID
			inx
			cpx #8
			beq Finish
			jmp Loop



		Finish:

			rts
	}





	DrawCurrentStatus: {

		lda PLAYER.HandStatus, x
		tay

		jsr DrawMessage

		rts
	}

	ClearMessages: {

		ldx #0


		Loop:

			stx CurrentID
			ldy #0

			jsr DrawMessage

			ldx CurrentID
			inx
			cpx #8
			beq Finish
			jmp Loop



		Finish:

			rts



		rts
	}

	DrawArrows: {

		lda SLOTS.NameRows, x
		sta Row

		lda SLOTS.Columns, x
		tax

		ldy Row
		
		lda #LeftArrow

		jsr PLOT.PlotCharacter

		inx
		inx
		inx
		inx
		inx

		lda #RightArrow

		jsr PLOT.PlotCharacter

		rts

	}

	CycleArrows: {

		lda ArrowTimer
		beq Ready

		dec ArrowTimer
		jmp Finish

		Ready:

		lda ArrowTimer + 1
		sta ArrowTimer

		lda SLOTS.NameRows, x
		sta Row

		lda SLOTS.Columns, x
		tax

		ldy Row
		
		lda ArrowColour

		jsr PLOT.ColorCharacterOnly

		inx
		inx
		inx
		inx
		inx

		jsr PLOT.ColorCharacterOnly

		inc ArrowColour

		lda ArrowColour
		cmp #8
		bcc Finish

		lda #0
		sta ArrowColour


		Finish:

		rts
	}

	ClearArrows: {

		

		lda SLOTS.NameRows, x
		sta Row

		lda SLOTS.Columns, x
		tax

		ldy Row
		
		lda #Blank

		jsr PLOT.PlotCharacter

		inx
		inx
		inx
		inx
		inx

		lda #Blank

		jsr PLOT.PlotCharacter


		Finish:

		rts


	}

	DrawMessage: {

		// y = messageID
		// x = playerID

		lda SLOTS.TextRows, x
		sta Row

		lda SLOTS.Columns, x
		sta Column
		dec Column

		tya
		asl
		asl
		asl
		sta CharOffset
		inc CharOffset
		clc
		adc #7
		sta EndOfText


		Loop:

			ldx CharOffset
			lda Messages, x

			//.break

			clc
			adc #195

			inc Column

			ldx Column
			ldy Row

			jsr PLOT.PlotCharacter

			inc CharOffset
			lda CharOffset
			cmp EndOfText
			beq Finish

			jmp Loop


		Finish:
		


		rts
	}


	ClearBet: {

		ldy #0

		stx PlayerID

		Loop:

			ldx PlayerID
			sty CurrentChar

			tya
			clc
			adc SLOTS.BetColumns, x	
			sta Column

			lda SLOTS.BetRows, x
			sta Row

			tay
			ldx Column

			lda #Blank
			jsr PLOT.PlotCharacter

			inc CurrentChar
			ldy CurrentChar

			cpy #6
			bcc Loop

		Finish:

			ldx PlayerID
			rts


	}

	DrawCurrentBet: {

		lda #0
		sta Errors

		//stx PlayerID

		lda TABLE.CurrentBet + 2
		sta Value

		lda TABLE.CurrentBet + 1
		sta Value + 1

		lda TABLE.CurrentBet
		sta Value + 2


		ldy #0	// screen offset, right most digit
		ldx #2	// score byte index

		ScoreLoop:

			stx CurrentID

			lda Value,x
			pha
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			pla
			and #$0f	// keep lower nibble
		
			jsr PlotDigit

			ldx CurrentID
			dex 
			cpx #255
			bne ScoreLoop

			rts

		PlotDigit: {

			
		
			UseNumber:

				clc
				adc #CharacterSetstart
				sta CharID
				
				cmp #CharacterSetstart
				bne NotZero

				lda Errors
				bne GetPosition

				lda #Blank
				sta CharID
				jmp GetPosition

			NotZero:

				inc Errors


			GetPosition:

				sty CurrentChar
				tya
				clc
				adc #BetColumn
				sta Column

				lda #BetRow
				sta Row

				tay
				ldx Column

				lda CharID
				jsr PLOT.PlotCharacter

				lda Errors
				cmp #1
				bne NotStart

				dex
				lda #DollarSign
				jsr PLOT.PlotCharacter
				inc Errors

				NotStart:

				ldy CurrentChar

				iny
				rts


		}


		rts
	}


	DrawBet:{

		//.break

		lda #0
		sta Errors

		stx PlayerID

		lda PLAYER.BetLow, x
		sta Value

		lda PLAYER.BetMed, x
		sta Value + 1

		lda PLAYER.BetHigh, x
		sta Value + 2


		ldy #0	// screen offset, right most digit
		ldx #2	// score byte index

		ScoreLoop:

			stx CurrentID

			lda Value,x
			pha
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			pla
			and #$0f	// keep lower nibble
		
			jsr PlotDigit

			ldx CurrentID
			dex 
			cpx #255
			bne ScoreLoop

			rts

		PlotDigit: {

			ldx PlayerID

			UseNumber:

				clc
				adc #CharacterSetstart
				sta CharID
				
				cmp #CharacterSetstart
				bne NotZero

				lda Errors
				bne GetPosition

				lda #Blank
				sta CharID
				jmp GetPosition

			NotZero:

				inc Errors

			GetPosition:

				sty CurrentChar
				tya
				clc
				adc SLOTS.BetColumns, x	
				sta Column

				lda SLOTS.BetRows, x
				sta Row

				tay
				ldx Column

				lda CharID
				jsr PLOT.PlotCharacter

				lda Errors
				cmp #1
				bne NotStart

				dex
				lda #DollarSign
				jsr PLOT.PlotCharacter
				inc Errors

				NotStart:

				ldy CurrentChar

				iny
				rts


		}


		ldx PlayerID

		rts


	}


	DrawPot:{

		//.break

		lda #0
		sta Errors

		//stx PlayerID

		lda TABLE.Pots + 2
		sta Value

		lda TABLE.Pots + 1
		sta Value + 1

		lda TABLE.Pots + 0
		sta Value + 2


		ldy #0	// screen offset, right most digit
		ldx #2	// score byte index

		ScoreLoop:

			stx CurrentID

			lda Value,x
			pha
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			pla
			and #$0f	// keep lower nibble
		
			jsr PlotDigit

			ldx CurrentID
			dex 
			cpx #255
			bne ScoreLoop

			rts

		PlotDigit: {

			
		
			UseNumber:

				clc
				adc #CharacterSetstart
				sta CharID
				
				cmp #CharacterSetstart
				bne NotZero

				lda Errors
				bne GetPosition

				lda #Blank
				sta CharID
				jmp GetPosition

			NotZero:

				inc Errors


			GetPosition:

				sty CurrentChar
				tya
				clc
				adc #PotColumn
				sta Column

				lda #PotRow
				sta Row

				tay
				ldx Column

				lda CharID
				jsr PLOT.PlotCharacter

				lda Errors
				cmp #1
				bne NotStart

				dex
				lda #DollarSign
				jsr PLOT.PlotCharacter
				inc Errors

				NotStart:

				ldy CurrentChar

				iny
				rts


		}


		rts


	}


	DrawChips:{

		//.break

		lda #0
		sta Errors

		stx PlayerID

		lda PLAYER.ChipsLow, x
		sta Value

		lda PLAYER.ChipsMed, x
		sta Value + 1

		lda PLAYER.ChipsHigh, x
		sta Value + 2


		ldy #0	// screen offset, right most digit
		ldx #2	// score byte index

		ScoreLoop:

			stx CurrentID

			lda Value,x
			pha
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			pla
			and #$0f	// keep lower nibble
		
			jsr PlotDigit

			ldx CurrentID
			dex 
			cpx #255
			bne ScoreLoop

			jmp Finish

		PlotDigit: {

			ldx PlayerID

			UseNumber:

				clc
				adc #CharacterSetstart
				sta CharID
				
				cmp #CharacterSetstart
				bne NotZero

				lda Errors
				bne GetPosition

				lda #Blank
				sta CharID
				jmp GetPosition

			NotZero:

				inc Errors

			GetPosition:

				sty CurrentChar
				tya
				clc
				adc SLOTS.Columns, x	
				sta Column

				lda SLOTS.BankRows, x
				sta Row

				tay
				ldx Column

				lda CharID
				jsr PLOT.PlotCharacter

				lda Errors
				cmp #1
				bne NotStart

				dex
				lda #DollarSign
				jsr PLOT.PlotCharacter
				inc Errors

				NotStart:

				ldy CurrentChar

				iny
				rts


		}

		Finish:


		ldx PlayerID

		rts


	}

	DrawName: {

		//.break

		stx PlayerID

		lda SLOTS.NameRows, x
		sta Row

		lda SLOTS.Columns, x
		sta Column

		//ldx #8
		

		txa
		asl
		asl
		sta CharOffset
		clc
		adc #4
		sta EndOfText
		
	
		Loop:

			ldx CharOffset
			lda PLAYER.Name, x

			//.break

			clc
			adc #84

			inc Column

			ldx Column
			ldy Row

			jsr PLOT.PlotCharacter

			inc CharOffset
			lda CharOffset
			cmp EndOfText
			beq Finish

			jmp Loop


		Finish:

		ldx PlayerID

		rts



	}

}