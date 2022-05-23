TEXT: {

	*=* "---String Data"

				    // 0    1     2     3     4     5     6     7    8   9   10   11
	Bank1:		.word Tit1, Tit2, Tit3, Tit4, Tit5, Tit6, Tit7, P1, P2, HI, Sta1
				//    12    13    14   15
				.word Sta2, Sta3, Blk, Sta4
				


	Bank2:	  

	.label CharacterSetStart = 0
	.label Space = 32
	.label LineBreak = 47
	.label SpaceAscii = 32
	.label MonthStart = 0

	.encoding "screencode_upper"

	Tit1:	.text @"GAME OVER\$00"	
	Tit2:	.text @"1 GAME 1 COIN\$00"
	Tit3:	.text @"OVER SCORE 2000\$00"
	Tit4:	.text @"ONE EXTRA GUN "
			.byte $8B, $8C, $00
	Tit5:	.text @"PRESENTED BY\$00"
	Tit6:	.text @""
			.byte 59
			.text @" 1979 UNIVERSAL\$00"	

	Tit7:	
			.text @"C64 BY ARLASOFT 2020\$00"


	Sta1:	.text @"PUSH\$00"	
	Sta2:	.text @"ONLY 1 PLAYERS\$00"	
	Sta3:	.text @"BUTTON\$00"	
	Blk:	.text @"\$00"
	Sta4:	.text @"1 OR 2 PLAYERS\$00"

	P1:	.text @"1ST"
	P2:	.text @"2ND"	
	HI:	.text @"HI-SCORE"


	*=* "---Text"


	DrawByteInDigits: {

		jsr ByteToDigits
		ldx #3

		jsr DrawDigits

		rts
	}


	ByteToDigits: {


		ldx #$FF
		sec

		Dec100:

			inx
			sbc #100
			bcs Dec100

		adc #100
		stx Text.Digits

		ldx #$FF
		sec

		Dec10:

			inx
			sbc #10
			bcs Dec10

		adc #10
		stx Text.Digits + 1

		sta Text.Digits + 2

		rts	

	}

	PrDec16Tens: .word 1, 10, 100, 1000, 10000
  

	WordToDigits: {

		lda #0
		sta Text.Pad
		sta Text.Digit

		ldy #8

		Loop1:

			ldx #$FF
			sec

		Loop2:

			lda Text.Word + 0
			sbc PrDec16Tens +0, y
			sta Text.Word + 0

			lda Text.Word + 1
			sbc PrDec16Tens + 1, y
			sta Text.Word + 1

			inx
			bcs Loop2

			lda Text.Word + 0
			adc PrDec16Tens +0, y
			sta Text.Word + 0

			lda Text.Word + 1
			adc PrDec16Tens + 1, y
			sta Text.Word + 1

			txa

			Print:

				ldx Text.Digit
				inc Text.Digit
				sta Text.Digits, x

			Next:

				dey
				dey
				bpl Loop1


		rts
	}


	DrawDigits: {

		// TextRow
		// TextColumn
		// amount = number to draw
		// y=colour

		.label HadAValue = Temp1
		stx Amount	
		ldx #0
		sty Colour
		stx HadAValue

		Loop:

			stx CurrentID
	
			lda Text.Digits, x
			bne NonZero

			IsZero:

				lda HadAValue
				beq EndLoop

				lda #ZeroInCharSet
				jmp Draw

			NonZero:

				cmp #99
				bne NotBlank	

				lda #Space
				jmp Draw

			NotBlank:

				clc
				adc #ZeroInCharSet

			Draw:

				inc HadAValue

				ldx TextColumn
				ldy TextRow
				jsr PLOT.PlotText



				lda Colour	
				jsr PLOT.ColorCharacter

			SkipDraw:

				inc TextColumn


			EndLoop:

				ldx CurrentID
				inx
				inx
				cpx Amount

				bcc NotLast

				inc HadAValue

				NotLast:
				dex
				cpx Amount
				beq Finish
				
				jmp Loop


		Finish:

			rts


	}



	DrawCustom: {

		stx Colour
		jsr DrawText

		rts

	}


		
	DrawText: {

		ldy #0

		Loop:

			sty CharOffset

			lda (TextAddress), y
			beq Finish

			cmp #LineBreak
			bne Okay

			NextRow:

				lda Column
				sta TextColumn
				inc TextRow
				jmp EndLoop

			Okay:

			cmp #SpaceAscii
			bne NotSpace

			lda #Space
			jmp Write

			NotSpace:

			clc
			adc #CharacterSetStart

			Write:

			ldx TextColumn
			ldy TextRow

			jsr PLOT.PlotText

			lda Colour
			jsr PLOT.ColorCharacter

			inc TextColumn

			EndLoop:

			ldy CharOffset
			iny
			jmp Loop


		Finish:

		rts

	}


	Draw: {

		// a = textID
		// y = bank
		// x = colour
		// TextColumn
		// TextRow

		stx Colour

		cmp #128
		bcc FromBank1


		FromBank2:

			sec
			sbc #128
			asl
			tax

			lda Bank2, x

			sta TextAddress
			inx

			lda Bank2, x
			sta TextAddress + 1
			jmp DrawNow

		FromBank1:

			asl
			tax
			lda Bank1, x

			sta TextAddress
			inx

			lda Bank1, x
			sta TextAddress + 1

		DrawNow:

			jsr DrawText

		rts
		

	}

	
  
}