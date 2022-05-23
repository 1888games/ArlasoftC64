SCORE:{


	
	HitBirdScore: .byte 10
	HitDinoScore: .byte 30
	GotEggScore: .byte 50
	LevelCompleteScore: .byte 200


	Value: .byte 0, 0, 0	// H M L
	.label Amount = TEMP1
	.label CharacterSetStart = 228
	.label ScreenPosition = 97

	ScoreToAdd: .byte 0

	ExtraLifeLSB: .byte 208
	ExtraLifeMSB: .byte 32
	ExtraLifeAwarded: .byte 0

	.label ScorePerFrame = 5


	Reset:{

		lda #25
		lda #ZERO
		sta Value
		sta Value + 1
		lda #ZERO
		sta Value + 2
		sta ExtraLifeAwarded

		jsr Draw
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

		lda LevelCompleteScore
		sta Amount
		jsr AddToScore
		rts



	}

	HitBird: {

		// enemy row passed in y

		lda HitBirdScore
		sta Amount
		jsr AddToScore
		rts

	}

	HitDino: {

		// enemy row passed in y

		lda HitDinoScore
		sta Amount
		jsr AddToScore
		rts

	}

	GotEgg: {

		// enemy row passed in y

		lda GotEggScore
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
			adc #CharacterSetStart

			sta SCREEN_RAM + 71, y

			lda #ONE
			sta VIC.COLOR_RAM + 71, y

			dey
			rts


		}

		rts


	}



}