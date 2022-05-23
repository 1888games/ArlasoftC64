SCORE:{

	Value: .byte 0, 0, 0, 0	// H M L

	Best: .byte 0, 0, 0, 0


	Amount: .byte 0

	.label CharacterSetstart = 0

	ScoreToAdd: .byte 0



	Reset:{

		lda #ZERO
		sta Value
		sta Value + 1
		sta Value + 2
		sta Value + 3
		sta ScoreToAdd
		sta Amount

		//jsr Draw
	//	jsr DrawBest
		rts

	}



	AddToScore:{



		lda ScoreToAdd
		clc
		adc Amount
		sta ScoreToAdd
		rts


	}

	SetScore: {

		sta ScoreToAdd

		lda #ZERO
		sta Value
		sta Value + 1
		sta Value + 2
		sta Value + 3

		
		jsr AddToScore

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

		cmp #11
		bcc Singles

		lda ScoreToAdd
		sec
		sbc #10
		sta ScoreToAdd

		lda #10
		jsr Add
		jmp Finish

		Singles:

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
		lda Value+3
		adc #ZERO
		sta Value+3

		cld

		cmp Best + 3
		bcs BetterorEqualHigh

		jmp NoNewBest

		BetterorEqualHigh:

		beq CheckMiddle

		jmp SetNewBest

		CheckMiddle:

		lda Value + 2
		cmp Best + 2
		bcs BetterorEqualMiddle

		jmp NoNewBest

		BetterorEqualMiddle:

		beq CheckMiddleRight

		jmp SetNewBest

		CheckMiddleRight:

		lda Value + 1
		cmp Best + 1
		bcs BetterorEqualMiddleRight

		jmp NoNewBest

		BetterorEqualMiddleRight:

		beq CheckLow

		jmp SetNewBest

		CheckLow:

		lda Value
		cmp Best
		bcc NoNewBest

		SetNewBest:

		lda Value + 3
		sta Best + 3
		lda Value + 2
		sta Best + 2
		lda Value + 1
		sta Best + 1
		lda Value + 0
		sta Best + 0

		jsr DrawBest


		NoNewBest:

		
		jsr Draw
		//jsr SOUND.ScoreSound
		rts


	}

	DrawBest:{

		ldy #7	// screen offset, right most digit
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
			cpx #4
			bne ScoreLoop

			rts

		PlotDigit: {

			clc
			adc #CharacterSetstart
			sta SCREEN_RAM + 469, y
			dey
			rts


		}
	}


	Draw:{

		ldy #7	// screen offset, right most digit
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
			cpx #4
			bne ScoreLoop

			rts

		PlotDigit: {

			clc
			adc #CharacterSetstart
			sta SCREEN_RAM + 189, y
			dey
			rts


		}



		rts


	}



}