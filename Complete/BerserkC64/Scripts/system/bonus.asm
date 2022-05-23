BONUS: {


	BonusDigits:	.byte 0, 0
	BonusID:		.byte 0
		
	BonusText:		.byte 97, 110, 109, 132, 130
					.byte 113, 126, 125, 148, 146

	AddBonusNextFrame:	.byte 0
					
	.label StartX = 35
	.label StartY = 18

	Show: {


		sta BonusID
		sta BonusDigits + 1

		ldy #0
		sty BonusDigits

		CheckAbove10:

			cmp #10
			bcc NoFirstDigit

			sec
			sbc #10
			sta BonusDigits + 1
			inc BonusDigits

		NoFirstDigit:

		jsr DrawText	
		jsr DrawNumber

		lda #1
		sta AddBonusNextFrame

		rts
	}


	DrawText: {

		ldx #StartX
		ldy #StartY

		jsr PLOT.GetCharacter

		ldy #0
		ldx #0

	Loop:

		lda BonusText, x
		sta (ZP.ScreenAddress), y

		lda #WHITE
		sta (ZP.ColourAddress), y

		iny
		cpy #5
		bne NoJump

		ldy #40

		NoJump:

		inx
		cpx #10
		bcc Loop


		rts
	}

	Clear: {

		lda #0
		sta ZP.Amount

		ldx #StartX
		ldy #StartY

		jsr PLOT.GetCharacter

		ldy #0
		ldx #0

		Loop:

			lda #0
			sta (ZP.ScreenAddress), y

			iny
			inx

			cpx #5
			bcc Loop

			inc ZP.Amount

			ldx #0

			tya
			clc
			adc #35
			tay

			lda ZP.Amount
			cmp #4
			bcc Loop

			
		rts
	}


	FrameUpdate: {

		lda AddBonusNextFrame
		beq Finish

		ldy BonusID
		

		jsr SCORE.AddScore

		dec AddBonusNextFrame

		Finish:


		rts
	}

	DrawNumber: {


		ldy #82

		Hundreds:

			lda BonusDigits
			beq NoFirst

			clc
			adc #64
			sta (ZP.ScreenAddress), y

			pha

			lda #WHITE
			sta (ZP.ColourAddress), y

			pla

			ldy #122
			clc
			adc #16
			sta (ZP.ScreenAddress), y

			lda #WHITE
			sta (ZP.ColourAddress), y


		NoFirst:

			ldy #83
			lda BonusDigits + 1
			clc
			adc #64
			sta (ZP.ScreenAddress), y

			pha

			lda #WHITE
			sta (ZP.ColourAddress), y

			pla

			ldy #123
			clc
			adc #16
			sta (ZP.ScreenAddress), y

			pha

			lda #WHITE
			sta (ZP.ColourAddress), y

			pla

			ldy #84
			lda #0
			clc
			adc #64
			sta (ZP.ScreenAddress), y

			pha

			lda #WHITE
			sta (ZP.ColourAddress), y

			pla

			ldy #124
			clc
			adc #16
			sta (ZP.ScreenAddress), y

			lda #WHITE
			sta (ZP.ColourAddress), y




		rts
	}
	
}