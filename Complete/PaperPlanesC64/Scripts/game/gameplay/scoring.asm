SCORING: {


	Score_Digits:	.byte 0
	Score_Tens:		.byte 0
	Score_Hundreds:	.byte 0



	High_Digits:	.byte 0
	High_Tens:		.byte 0
	High_Hundreds:	.byte 0


	GotHigh:		.byte 0




	Reset: {

		lda #0
		sta Score_Digits
		sta Score_Tens
		sta Score_Hundreds
		sta GotHigh

		jsr DrawScore
		jsr DrawBest





		rts
	}


	DrawDigit: {

		ldy #0
		sta (ZP.ScreenAddress), y

		lda #BLUE
		sta (ZP.ColourAddress), y

		iny
		inc ZP.CharID
		lda ZP.CharID
		sta (ZP.ScreenAddress), y

		lda #BLUE
		sta (ZP.ColourAddress), y

		ldy #40
		inc ZP.CharID
		lda ZP.CharID
		sta (ZP.ScreenAddress), y

		lda #BLUE
		sta (ZP.ColourAddress), y

		iny
		inc ZP.CharID
		lda ZP.CharID
		sta (ZP.ScreenAddress), y

		lda #BLUE
		sta (ZP.ColourAddress), y

		inc ZP.Temp1




		rts
	}


	Increase: {

		lda Score_Digits
		clc
		adc #1
		sta Score_Digits

		cmp #10
		bcc OkayDigit

		lda #0
		sta Score_Digits

		lda Score_Tens
		clc
		adc #1
		sta Score_Tens

		cmp #10
		bcc OkayDigit

		lda #0
		sta Score_Tens

		inc Score_Hundreds


		OkayDigit:

		jsr DrawScore

		lda Score_Hundreds
		cmp High_Hundreds
		bcc NoRecord
		bne Record

		lda Score_Tens
		cmp High_Tens
		bcc NoRecord
		bne Record

		lda Score_Digits
		cmp High_Digits
		bcc NoRecord

		Record:

		lda GotHigh
		bne NotFirstHigh

		inc GotHigh

		sfx(SFX_HIGH)


		NotFirstHigh:

		lda Score_Hundreds
		sta High_Hundreds

		lda Score_Tens
		sta High_Tens

		lda Score_Digits
		sta High_Digits

		jsr DrawBest



		NoRecord:



		rts
	}

	DrawBest: {

		lda #0
		sta ZP.Temp1


		Hundreds:

			lda High_Hundreds
			beq NoHundreds

			lda #20
			sta ZP.Column

			lda #1
			sta ZP.Row
			tay

			ldx ZP.Column

			jsr PLOT.GetCharacter

			lda High_Hundreds
			asl
			asl
			clc
			adc #17
			sta ZP.CharID

			jsr DrawDigit


		NoHundreds:

			lda High_Tens
			clc
			adc ZP.Temp1
			beq NoTens

			lda #22
			sta ZP.Column

			lda #1
			sta ZP.Row
			tay

			ldx ZP.Column

			jsr PLOT.GetCharacter

			lda High_Tens
			asl
			asl
			clc
			adc #17
			sta ZP.CharID

			jsr DrawDigit


		NoTens:

			lda #24
			sta ZP.Column

			lda #1
			sta ZP.Row
			tay

			ldx ZP.Column

			jsr PLOT.GetCharacter

			lda High_Digits
			asl
			asl
			clc
			adc #17
			sta ZP.CharID

			jsr DrawDigit


			rts
	}

	DrawScore: {

		lda #0
		sta ZP.Temp1


		Hundreds:

			lda Score_Hundreds
			beq NoHundreds

			lda #10
			sta ZP.Column

			lda #1
			sta ZP.Row
			tay

			ldx ZP.Column

			jsr PLOT.GetCharacter

			lda Score_Hundreds
			asl
			asl
			clc
			adc #17
			sta ZP.CharID

			jsr DrawDigit


		NoHundreds:

			lda Score_Tens
			clc
			adc ZP.Temp1
			beq NoTens

			lda #12
			sta ZP.Column

			lda #1
			sta ZP.Row
			tay

			ldx ZP.Column

			jsr PLOT.GetCharacter

			lda Score_Tens
			asl
			asl
			clc
			adc #17
			sta ZP.CharID

			jsr DrawDigit


		NoTens:

			lda #14
			sta ZP.Column

			lda #1
			sta ZP.Row
			tay

			ldx ZP.Column

			jsr PLOT.GetCharacter

			lda Score_Digits
			asl
			asl
			clc
			adc #17
			sta ZP.CharID

			jsr DrawDigit



		rts
	}

}