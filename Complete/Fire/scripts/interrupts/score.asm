SCORE:{


	
	BounceScore: .byte 1


	Value: .byte 0, 0, 0	// H M L
	Best: .byte 0, 0, 0

	.label Amount = TEMP1

	ScoreToAdd: .byte 0
	CharacterSetStart: .byte 213
	ScreenPosition: .byte 109
	BestPosition: .byte 149

	ExtraLifeLSB: .byte 208
	ExtraLifeMSB: .byte 32
	ExtraLifeAwarded: .byte 0

	.label ScorePerFrame = 1






	Reset:{

		.if(target == "VIC") {
			lda #1
			sta CharacterSetStart

			lda #100
			sta ScreenPosition
			lda #78
			sta BestPosition
		}

		.if(target == "PET") {
			lda #48
			sta CharacterSetStart
		}

		lda #25
		lda #ZERO
		sta Value
		sta Value + 1
		lda #ZERO
		sta Value + 2
		sta ExtraLifeAwarded

		jsr Draw
		jsr DrawBest
		rts

	}



	AddToScore:{

		lda ScoreToAdd
		clc
		adc Amount
		sta ScoreToAdd
		rts


	}

	LevelComplete:{

		//lda LevelCompleteScore
		sta Amount
		jsr AddToScore
		rts



	}

	SuccessfulBounce: {

		// enemy row passed in y

		lda BounceScore
		sta Amount
		jsr AddToScore
		rts

	}

	


	CheckScoreToAdd:{

		lda ScoreToAdd
		beq Finish

		sec
		sbc #ScorePerFrame

		sta ScoreToAdd

		lda #ScorePerFrame
		jsr Add

		

		Finish:

		rts


	}




	CheckExtraLife:{

		pha

		lda ExtraLifeAwarded
		bne Finish

		jsr LIVES.GainLife

		lda #ONE
		sta ExtraLifeAwarded
		
		Finish:

		pla
		rts
	}

	Add: {

		sta Amount
		sed
		clc
		lda Value
		adc Amount
		sta Value
		lda Value+1
		adc #ZERO
		sta Value+1
		lda Value+2
		adc #ZERO
		sta Value+2

		cld

		cmp Best + 2
		bcs BetterOrEqualHigh

		jmp NoNewBest

		BetterOrEqualHigh:

		beq CheckMiddle

		jmp SetNewBest

		CheckMiddle:

		lda Value + 1
		cmp Best + 1
		bcs BetterOrEqualMiddle

		jmp NoNewBest

		BetterOrEqualMiddle:

		beq CheckLow

		jmp SetNewBest

		CheckLow:

		lda Value
		cmp Best
		bcc NoNewBest

		SetNewBest:

		lda Value + 2
		sta Best + 2
		lda Value + 1
		sta Best + 1
		lda Value + 0
		sta Best + 0

		jsr DrawBest

		NoNewBest:
	
		jsr Draw
		rts


	}


	Draw:{

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index

		.label YReg = TEMP5
		.label XReg = TEMP6

		ScoreLoop:

			lda Value,x
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

			cpy #2
			bne NotYet
			
			cmp #2
			bne NotYet

			sty YReg
			stx XReg

			jsr CheckExtraLife

			ldx XReg
			ldy YReg

			NotYet:

			clc
			adc CharacterSetStart

			pha
			tya
			clc
			adc ScreenPosition
			tay
			pla

			sta (SCREEN_RAM), y

			.if (target != "PET") {

				lda #ZERO

				.if(target == "264") {
					clc
					adc #96
				}
				
				sta (COLOR_RAM), y
			}

			tya
			sec
			sbc ScreenPosition
			tay

			dey
			rts


		}

		rts


	}


	DrawBest:{

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index

		.label YReg = TEMP5
		.label XReg = TEMP6

		ScoreLoop:

			lda Best,x
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

			cpy #2
			bne NotYet
			
			cmp #2
			bne NotYet

			sty YReg
			stx XReg

			ldx XReg
			ldy YReg

			NotYet:

			clc
			adc CharacterSetStart

			pha
			tya
			clc
			adc BestPosition
			tay
			pla

			sta (SCREEN_RAM), y

			.if (target != "PET") {

				lda #ZERO

				.if(target == "264") {
					clc
					adc #96
				}
				
				sta (COLOR_RAM), y

			}

			tya
			sec
			sbc BestPosition
			tay

			dey
			rts


		}

		rts


	}



}