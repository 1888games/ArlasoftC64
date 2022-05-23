TEXT: {


	* = * "Text"

	Bank1:	.word Na01, Na02, Na03, Na04, Na05, Na06, Na07, Na08, Na09, Na10, Na11, Na12
			.word Na13, Na14, Na15, Na16, Na17, Na18, Na19, Na20, Na21, Na22, Na23, Na24
			.word Na25, Na26, Na27, Na28, Na29, Na30, Na31, Na32, Na33, Na34, Na35, Na36
			.word Na37, Na38, Na39, Na40, Na41, Na42, Na43, Na44, Na45, Na46, Na47, Na48
			.word Name, Scen, TwoP, Prac, Conti, Ended, Music, Colour, On, Off, Normal, Switch

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


	Na01:	.text @"LILY\$00"	
	Na02:	.text @"TARJ\$00"
	Na03:	.text @"SARG\$00"	
	Na04:	.text @"KENT\$00"	
	Na05:	.text @"BERT\$00"	
	Na06:	.text @"KATE\$00"	
	Na07:	.text @"MEEP\$00"	
	Na08:	.text @"SAUL\$00"	
	Na09:	.text @"MOOG\$00"
	Na10:	.text @"WALT\$00"
	Na11:	.text @"MARY\$00"
	Na12:	.text @"PHIL\$00"

	Na13:	.text @"PORT\$00"	
	Na14:	.text @"MARK\$00"
	Na15:	.text @"CHEF\$00"	
	Na16:	.text @"GARY\$00"	
	Na17:	.text @"MERL\$00"	
	Na18:	.text @"LAMB\$00"	
	Na19:	.text @"HULI\$00"	
	Na20:	.text @"JOHN\$00"	
	Na21:	.text @"FRED\$00"
	Na22:	.text @"BULB\$00"
	Na23:	.text @"MAUD\$00"
	Na24:	.text @"HANS\$00"

	Na25:	.text @"LIZY\$00"	
	Na26:	.text @"PEEK\$00"
	Na27:	.text @"WILL\$00"	
	Na28:	.text @"RICK\$00"	
	Na29:	.text @"DANE\$00"	
	Na30:	.text @"CARL\$00"	
	Na31:	.text @"BASS\$00"	
	Na32:	.text @"CHIP\$00"	
	Na33:	.text @"LOOP\$00"
	Na34:	.text @"BRYN\$00"
	Na35:	.text @"CLEM\$00"
	Na36:	.text @"DOCK\$00"

	Na37:	.text @"SLYV\$00"	
	Na38:	.text @"PAUL\$00"
	Na39:	.text @"REFF\$00"	
	Na40:	.text @"JOBS\$00"	
	Na41:	.text @"TREV\$00"	
	Na42:	.text @"BLOB\$00"	
	Na43:	.text @"TYRE\$00"	
	Na44:	.text @"BEAN\$00"	
	Na45:	.text @"GOAT\$00"
	Na46:	.text @"NORM\$00"
	Na47:	.text @"LENS\$00"
	Na48:	.text @"NIGE\$00"

	Name:	.text @"ARLA\$00"	

	Scen:	.text @"SCENARIO\$00"	
	TwoP:	.text @"2 PLAYER\$00"	
	Prac:	.text @"PRACTICE\$00"	
	
	Conti:	.text @"CONTINUE\$00"	
	Ended:	.text @"        \$00"


	.label MUSIC = 54
	Music:	.text @"JINGLE\$00"

	.label COLOUR = 55
	Colour:	.text @"COLOUR\$00"

	.label SOUND_OPTIONS = 56

	On:		.text @"DURING\$00"
	Off:	.text @"SILENT\$00"
	
	.label COLOUR_OPTIONS = 58
	Normal:	.text @"NORMAL\$00"
	Switch:	.text @"BLIND\$00"


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