SCORE:{

	* = * "Score"
	
	Value: 	.byte 0, 0, 0	// H M L
	Digit:	.byte 0, 0, 0

	Best: 	.byte 0, 0, 0

	.label CharacterSetStart = 64

	.label ExtraLife = 70

	DrawWhenFree:	.byte 0
	ScoreInitialised: .byte 0

	ScoreM:		.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
	ScoreL:		.byte $50, $10, $20, $30, $40, $50, $60, $70, $80, $90, $00, $10

	

	HadExtra:	.byte 0, 0
	ExtraNormal:	.byte 0, 0

	Reset:{


		lda #ZERO
		sta Value
		sta Value + 1
		sta Value + 2

		//lda #1
		sta HadExtra 
		sta HadExtra + 1


		lda #$99
		//sta Value + 1

		
	
		jsr DrawP1

		Finish:

		rts

	}




	AddScore: {

		// y = scoreType
		// x = score index

		sty ZP.Temp2

		ldx #0

		
		Okay:
	//	asl
	//	asl
		//tax
		//stx ZP.StageOrderID

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
			sta ZP.Amount

			lda Value + 2, x
			adc #0
			sta ZP.H
			sta Value + 2, x

		SecondDigit:
		
			lda ScoreM, y
			beq Finish
			clc
			adc Value + 1, x
			sta Value + 1, x
			sta ZP.Amount

			lda Value + 2, x
			adc #0
			sta ZP.H
			sta Value + 2, x

		Finish:

			lda HadExtra
			beq CheckFirst

			cmp #2
			beq NotYet

		CheckSecond:

			lda ZP.H
			beq NotYet

			jmp GotNewLife

		CheckFirst:

			lda ZP.Amount
			cmp #$50
			bcc NotYet

		GotNewLife:

			inc HadExtra

		AddLife:

			cld
			jsr LIVES.Add

			ldy #S_LIFE
			jsr SPEECH.StartSequence

			jmp NowDraw

		NotYet:

			cld

		NowDraw:

			jsr DrawScore
	

		NoHigh:


		rts
	}


	
	

	DrawP1:{


		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #3
		sta ZP.EndID

		lda Value + 2, x
		bne ScoreLoop

		dec ZP.EndID

		lda Value + 1, x
		bne ScoreLoop

		dec ZP.EndID


		InMills:

		ScoreLoop:

			lda Value, x
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
			sta SCREEN_RAM + 432, y

			clc
			adc #16
			sta SCREEN_RAM + 472, y

			lda #GREEN
			sta VIC.COLOR_RAM + 432, y
			sta VIC.COLOR_RAM + 472, y

			
			dey
			rts


		}

		Finish:

		rts

	}


	DrawTitle: {

		lda Value 
		sta Digit

		lda Value + 1
		sta Digit + 1

		lda Value + 2
		sta Digit + 2

		lda #GREEN
		sta ZP.Colour
	
		ldy #23
		ldx #3

		jsr PLOT.GetCharacter
		jsr DrawScoreAnywhere



		rts
	}

	DrawScoreAnywhere:{

		

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #3
		sta ZP.EndID

		lda Digit + 2, x
		bne ScoreLoop

		dec ZP.EndID

		lda Digit + 1, x
		bne ScoreLoop

		dec ZP.EndID


		InMills:

		ScoreLoop:

			lda Digit, x
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
			sta (ZP.ScreenAddress), y

			clc
			adc #16
			sta ZP.CharID

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #40
			tay

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			lda ZP.CharID
			sta (ZP.ScreenAddress), y

			tya
			sec
			sbc #41
			tay
			
			rts


		}

		Finish:

		rts

	

	}


	DrawScore: {

		jmp DrawP1

	}	

	



}