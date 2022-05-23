TEXT: {


	* = * "Text"

	Bank1:	.word Scen, TwoP, Prac, Conti, Ended, Music, Colour, On, Off, Normal, Switch

	Bank2:	


	.label CharacterSetStart = 0
	.label Space = 48
	.label LineBreak = 70
	.label SpaceAscii = 32
	.label MonthStart = 0
	.label NumberSetStart = 48
	.label TallNumberStart = 206


	Digits:			.byte 0, 0, 0


	.encoding "screencode_upper"


	Scen:	.text @"ORIGINAL\$00"	
	TwoP:	.text @"3 MINUTES\$00"	
	Prac:	.text @"2 PLAYER\$00"	
	
	Conti:	.text @"CONTINUE\$00"	
	Ended:	.text @"        \$00"


	.label MUSIC = 5
	Music:	.text @"JINGLE\$00"

	.label COLOUR = 6
	Colour:	.text @"COLOUR\$00"

	.label SOUND_OPTIONS = 7

	On:		.text @"PLAYED\$00"
	Off:	.text @"SILENT \$00"
	
	.label COLOUR_OPTIONS = 9
	Normal:	.text @"NORMAL\$00"
	Switch:	.text @"BLIND \$00"


	ByteToDigits: {

		ldx #$FF
		sec

		Dec100:

			inx
			sbc #100
			bcs Dec100

		adc #100
		stx TEXT.Digits

		ldx #$FF
		sec

		Dec10:

			inx
			sbc #10
			bcs Dec10

		adc #10
		stx TEXT.Digits + 1
		sta TEXT.Digits + 2

		rts	

	}



	DrawTallDigits: {

		// TextRow
		// TextColumn
		// amount = number to draw
		// y=colour

		sta ZP.ShowSpaces

		stx ZP.Amount	
		ldx #0
		sty ZP.Colour
		stx ZP.Okay

		Loop:

			stx ZP.X
	
			lda Digits, x
			bne NonZero

			ldy ZP.Okay
			bne NonZero

			jmp SkipDraw

			NonZero:	

			lda Digits, x
			asl
			clc
			adc #TallNumberStart


			Draw:

				inc ZP.Okay

				ldx ZP.TextColumn
				ldy ZP.TextRow
				jsr DRAW.PlotCharacter

				lda ZP.Colour	
				jsr DRAW.ColorCharacter

				lda ZP.CharID
				clc
				adc #1

				iny

				jsr DRAW.PlotCharacter

				lda ZP.Colour
				jsr DRAW.ColorCharacter


				inc ZP.TextColumn

				jmp EndLoop


			SkipDraw:

				lda ZP.ShowSpaces
				beq EndLoop

				lda #0
				ldx ZP.TextColumn
				ldy ZP.TextRow
				jsr DRAW.PlotCharacter

				iny
				jsr DRAW.PlotCharacter

				inc ZP.TextColumn


			EndLoop:


			

				ldx ZP.X
				inx
				inx
				cpx ZP.Amount

				bcc NotLast

				inc ZP.Okay

				NotLast:
				dex
				cpx ZP.Amount
				beq Finish
				
				jmp Loop


		Finish:

			rts


	}


	Draw: {

		// a = textID
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
				sta ZP.TextColumn
				inc ZP.TextRow
				jmp EndLoop

			Okay:

			clc
			adc #CharacterSetStart

			Write:

			ldx ZP.TextColumn
			ldy ZP.TextRow

			jsr DRAW.PlotCharacter

			lda ZP.Colour
			jsr DRAW.ColorCharacter

			inc ZP.TextColumn

			EndLoop:

			ldy ZP.CharOffset
			iny
			jmp Loop


		Finish:

		rts

	}







}