SCORE:{

	* = * "Score"
	
	Value: 	.byte 0, 0, 0, 0	// H M L
	Best: 	.byte 0, $50, 0, 0

	.label CharacterSetStart = 49

	ScoreH:		.byte $00
	ScoreM:		.byte $02
	ScoreL:		.byte $50

	Reset:{

		lda #ZERO
		sta Value
		sta Value + 1
		sta Value + 2
		sta Value + 3

		
		jsr DrawP1
		jsr DrawBest

		Finish:

		rts

	}


	AddScore: {

		// y = scoreType
		// x = score index

		lda #0
		sta ZP.Amount

		ldx #0

		sed

		FirstDigit:

			lda ScoreL, y
			beq SecondDigit
			clc
			adc Value, x
			sta Value, x

			lda Value + 1, x
			adc #0
			sta Value + 1, x

			lda ZP.Amount
			adc #0
			sta ZP.Amount

		SecondDigit:
		
			lda ScoreM, y
			beq ThirdDigit
			clc
			adc Value + 1, x
			sta Value + 1, x

			lda ZP.Amount
			adc #0
			sta ZP.Amount

		ThirdDigit:

			lda ScoreH, y
			beq Finish
			sta ZP.Amount

			
		Finish:

			lda Value + 2, x
			clc
			adc ZP.Amount
			sta Value + 2, x

			lda Value + 3, x
			adc #0
			sta Value + 3, x

			cld

		NowDraw:

			ldx #0
			jsr DrawP1
			jsr CheckHighScore


		NoHigh:


		rts
	}


	CheckHighScore: {

		lda Value + 3
		cmp Best + 3
		bcc NoHigh

		beq Check2

		jmp IsHigh


	Check2:

		lda Value + 2
		cmp Best + 2
		bcc NoHigh

		beq Check3

		jmp IsHigh

	Check3:

		lda Value + 1
		cmp Best + 1
		bcc NoHigh

		beq Check4

		jmp IsHigh

	Check4:

		lda Value
		cmp Best
		bcc NoHigh

	IsHigh:

		lda Value
		sta Best

		lda Value + 1
		sta Best + 1

		lda Value + 2
		sta Best + 2

		lda Value + 3
		sta Best + 3


		jsr DrawBest


		NoHigh:

		rts
	}



	
	DrawP1:{

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
			sta SCREEN_RAM + 10, y
			dey
			rts


		}

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
			sta SCREEN_RAM + 24, y

			lda #YELLOW + 8
			sta VIC.COLOR_RAM + 24, y
			dey
			rts


		}

		rts


	}

	



}