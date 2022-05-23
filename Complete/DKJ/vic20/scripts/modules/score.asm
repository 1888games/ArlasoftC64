SCORE:{


	KeyScore: .byte 10, 10
	UnlockScore: .byte 20
	JumpScore: .byte 1
	HitScores: .byte 9, 6, 3, 0
	Value: .byte 0, 0, 0	// H M L
	.label Amount = TEMP1
	.label CharacterSetStart = 176

	Best: .byte 0, 0, 0

	ScoreToAdd: .byte 0


	Reset:{

		lda #ZERO
		sta Value
		sta Value + 1
		sta Value + 2



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

	HitEnemy: {

		// enemy row passed in y

		lda HitScores, y
		sta Amount
		jsr AddToScore
		rts

	}

	JumpEnemy: {

		lda JumpScore
		sta Amount
		jsr AddToScore
		rts

	}

	UnlockSection: {

		lda KeyScore
		sta Amount
		jsr AddToScore
		rts

	}

	UnlockCage:{

		lda UnlockScore
		sta Amount
		jsr AddToScore
		rts

	}


	CheckScoreToAdd:{

		lda ScoreToAdd
		beq Finish

		dec ScoreToAdd
		lda #ONE
		jsr Add

		Finish:

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
		jsr SOUND.ScoreSound
		rts


	}

	DrawBest:{

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index

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

			clc
			adc #CharacterSetStart
			sta VIC.SCREEN_RAM + 103, y
			dey
			rts


		}
	}


	Draw:{

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index

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

			clc
			adc #CharacterSetStart
			sta VIC.SCREEN_RAM + 81, y
			dey
			rts


		}



		rts


	}



}