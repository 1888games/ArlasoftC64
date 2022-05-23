TEXT: {

	*=* "---String Data"


	Text: {

		Digits: .fill 7, 0
		Pad:	.byte 0
		Digit:	.byte 0
		Word:	.byte 0, 0
	}
		
				    // 0   1    2    3    4    5    6    7    8    9    10   11	  12   13   14   15  16.   17   18.  19,  20,  21, 22
	Bank1:		.word High, Plyr, HgSc, Plea, PuRo, PuHy, Push, Game, Coi1, Coi2

	Bank2:	  

	.label CharacterSetStart = 0
	.label Space = 32
	.label LineBreak = 47
	.label SpaceAscii = 32
	.label MonthStart = 0
	.label ZeroInCharSet = 48


	.label TITLE_GALAGA = 0
	
	.encoding "screencode_mixed"
	High:	.text @"high scores\$00"	
	Plyr:	.text @"player\$00"	
	HgSc:	.text @"your score is one of the ten best\$00"	
	Plea:	.text @"please enter your initials\$00"	
	PuRo:	.text @"push rotate to select letter\$00"	
	PuHy:	.text @"push hyperspace when letter is correct\$00"	
	Push:	.text @"push start\$00"	
	Game:	.text @"game over\$00"
	Coi1:	.text @"1 coin 2 plays\$00"	
	Coi2:	.text @"1 coin 1 play\$00"	

	*=* "---Text"




	//EnglishTextTbl:
	// L571E: .byte $0B                //HIGH SCORES 
	// L571F: .byte $13                //PLAYER
	// L5720: .byte $19                //YOUR SCORE IS ONE OF THE TEN BEST 
	// L5721: .byte $2F                //PLEASE ENTER YOUR INITIALS
	// L5722: .byte $41                //PUSH ROTATE TO SELECT LETTER 
	// L5723: .byte $55                //PUSH HYPERSPACE WHEN LETTER IS CORRECT 
	// L5724: .byte $6F                //PUSH START 
	// L5725: .byte $77                //GAME OVER
	// L5726: .byte $7D                //1 COIN 2 PLAYS 
	// L5727: .byte $87                //1 COIN 1 PLAY 



	DrawByteInDigits: {

		stx ZP.CurrentID

		jsr ByteToDigits
		ldx #3

		jsr DrawDigits

		rts
	}

	DrawWordInDigits: {

		sty ZP.Temp4
		stx ZP.CurrentID

		jsr WordToDigits

		ldx #5

		ldy ZP.Temp4
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
			bne Print



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

		.label HadAValue = ZP.Temp1
		stx ZP.Amount	
		ldx #0
		sty ZP.Colour

		ldy ZP.CurrentID
		sty HadAValue

		Loop:

			stx ZP.CurrentID
	
			lda Text.Digits, x
			bne NonZero

			IsZero:

				lda HadAValue
				beq SkipDraw

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



				lda ZP.Colour	
				jsr PLOT.ColorCharacter

			SkipDraw:

				inc TextColumn


			EndLoop:

				ldx ZP.CurrentID
				inx
				inx
				cpx ZP.Amount

				bcc NotLast

				inc HadAValue

				NotLast:
				dex
				cpx ZP.Amount
				beq Finish
				
				jmp Loop


		Finish:

			rts


	}



	DrawCustom: {

		stx ZP.Colour
		jsr DrawText

		rts

	}


		
	DrawText: {

		ldy #0

		Loop:

			sty ZP.CharOffset

			lda (ZP.TextAddress), y
			beq Finish

			cmp #LineBreak
			bne Okay

			NextRow:

				lda ZP.Column
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

			lda ZP.Colour
			jsr PLOT.ColorCharacter

			inc TextColumn

			EndLoop:

			ldy ZP.CharOffset
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

		stx ZP.Colour

		cmp #128
		bcc FromBank1


		FromBank2:

			sec
			sbc #128
			asl
			tax

			lda Bank2, x

			sta ZP.TextAddress
			inx

			lda Bank2, x
			sta ZP.TextAddress + 1
			jmp DrawNow

		FromBank1:

			asl
			tax
			lda Bank1, x

			sta ZP.TextAddress
			inx

			lda Bank1, x
			sta ZP.TextAddress + 1

		DrawNow:

			jsr DrawText

		rts
		

	}

	
  
}