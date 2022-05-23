SCORE:{

	Value: .byte 0, 0, 0	// H M L

	Best: .byte 0, 0, 0


	.label Amount = TEMP1
	.label CharacterSetStart = 33

	ScoreToAdd: .byte 0



	Reset:{

		lda #ZERO
		sta Value
		sta Value + 1
		sta Value + 2
		sta ScoreToAdd
		sta Amount

		jsr Draw
		//jsr DrawBest
		rts

	}



	Set: {
		ldy #0
		sty Value

		sta Amount
		
		jsr AddToScore

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
			sta SCREEN_RAM + 71, y
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
			sta SCREEN_RAM + 43, y
			dey
			rts


		}



		rts


	}



}