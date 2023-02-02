SCORE:{


	P1:		.byte 0, 0, 0, 0, 0, 0

	* = * "Hi score_Data"
	High:	.byte 0, 0, 0, 0, 0, 0
	* = * "Hi score_End"
	High_End:

	Score_4:	.byte 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 2, 3, 5
	Score_3:	.byte 0, 0, 2, 4, 8, 6, 1, 3, 5, 7, 0, 0, 0, 0
	Score_2:	.byte 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0



	.label START_ADDRESS = $C000 + (64 * (83 + 48))

	DigitAddress_LSB: .fill 3, <[START_ADDRESS + (i)]
					  .fill 3, <[START_ADDRESS + 64 + (i)]		
					  .fill 3, <[START_ADDRESS + 128 + (i)]
					  .fill 3, <[START_ADDRESS + 192 + (i)]


	DigitAddress_MSB: .fill 3, >[START_ADDRESS + (i * 8)]
					  .fill 3, >[START_ADDRESS + 64 + (i * 8)]		
					  .fill 3, >[START_ADDRESS + 128 + (i * 8)]
					  .fill 3, >[START_ADDRESS + 192 + (i * 8)]				



	.label CHAR_SET_LOCATION = $f800

	* = * "Chars"

	CharAddress_LSB:  .fill 11, <[CHAR_SET_LOCATION + ((48 + i) * 8)]
	CharAddress_MSB:  .fill 11, >[CHAR_SET_LOCATION + ((48 + i) * 8)]

		.print [CHAR_SET_LOCATION + ((48 + 0) * 8)]

	Extras:		.byte 1, 2, 2, 3, 3, 4

	NextExtra:		.byte 0, 0
	CurrentExtra:	.byte 0, 0
	ExtraID:		.byte 0, 0

	HadExtra:		.byte 0

	CurrentPlayer:	.byte 0

	NumberChars:	.fill 40, 1 + i

	ScoreTimer:		.byte 15
	ScoreChanged:	.byte 0
	DrawHighScore:	.byte 0
	GotHighScore:	.byte 0

	.label ScoreTime = 15

	Reset:{

		lda #0
		sta ScoreChanged
		sta GotHighScore
		sta HadExtra

		ldx #5

		Loop:

			sta P1, x
			dex
			bpl Loop

		sta CurrentExtra 
		sta CurrentExtra + 1
		sta ExtraID
		sta ExtraID + 1

		lda #1
		sta NextExtra
		sta NextExtra + 1

		jsr DrawP1_Digits
	
		Finish:

			rts

	}

	YToY:	.byte 0, 3, 6, 9, 12, 15, 18, 21


	DrawP1_Digits: {

		ldy #0
		sty ZP.Amount
		sty ZP.Temp1

		Loop:

			sty ZP.X

			lda GotHighScore
			beq DoCheck

			lda P1, y
			sta High, y
			jmp Skip

		DoCheck:

			lda ZP.Temp1
			bne NotHigh

			lda P1, y
			cmp High, y
			beq Skip

			bcc NotHigh

		IsHigh:

			inc GotHighScore
			jmp NoCheck

		NotHigh:

			inc ZP.Temp1

		NoCheck:

			lda P1, y

		Skip:
			tax

			lda ZP.Amount
			bne AlreadyIncreased

			cpy #4
			bcs MakeOne

			cpx #0
			bne MakeOne

			ldx #10
			jmp AlreadyIncreased

		MakeOne:

			inc ZP.Amount

		AlreadyIncreased:

			jsr CopyCharToSprite

			ldy ZP.X
			iny
			cpy #6
			bcc Loop

		rts
	}


	DrawHighDigits: {

		ldx #0
		stx ZP.Amount
		ldy #6
		
		Loop:

			stx ZP.X
			sty ZP.StoredYReg

			lda High, x
			tax

			lda ZP.Amount
			bne AlreadyIncreased

			cpy #10
			bcs MakeOne

			cpx #0
			bne MakeOne

			ldx #10
			jmp AlreadyIncreased

		MakeOne:

			inc ZP.Amount

		AlreadyIncreased:

			jsr CopyCharToSprite

			ldx ZP.X
			ldy ZP.StoredYReg
			inx
			iny
			cpx #6
			bcc Loop

		rts
	}

	FrameUpdate: {

		lda ScoreChanged
		bne DoTheChange

		lda DrawHighScore
		beq Finish

		DoHigh:

			lda #0
			sta DrawHighScore

			jmp DrawHighDigits

		DoTheChange:

			lda #0
			sta ScoreChanged

			jsr DrawP1_Digits

			lda GotHighScore
			sta DrawHighScore

		Finish:





		rts
	}

	AddScore: {

		// y = ID

		lda GAME.AttractMode
		beq OkayToAdd

		rts

	OkayToAdd:

		lda P1 + 1
		sta ZP.Amount

		lda P1 + 4
		clc
		adc Score_2, y

		cmp #10
		bcc NoWrap1

		inc P1 + 3

		sec
		sbc #10

	NoWrap1:

		sta P1 + 4

		lda P1 + 3
		clc
		adc Score_3, y
		
		cmp #10
		bcc NoWrap2

		inc P1 + 2

		sec
		sbc #10

	NoWrap2:

		sta P1 + 3

		lda P1 + 2
		clc
		adc Score_4, y

		cmp #10
		bcc NoWrap3

		inc P1 + 1

		sec
		sbc #10

	NoWrap3:

		sta P1 + 2

		lda P1 + 1
		cmp #10
		bcc NoWrap4

		inc P1 + 0

		sec
		sbc #10

	NoWrap4:

		sta P1 + 1

		lda P1 + 0
		cmp #10
		bcc NoWrap5

		lda #0
		sta P1 + 0


	NoWrap5:

		lda HadExtra
		bne NoExtra

		lda ZP.Amount
		bne NoExtra

		lda P1 + 1
		cmp #1
		bne NoExtra

	ExtraLife:


		inc GAME.Lives
		inc HadExtra
		
		sfx(SFX_BEEP)
		


	NoExtra:

		inc ScoreChanged

		rts
	}


	CopyCharToSprite: {

		// x = char
		// y = digit


		lda CharAddress_LSB, x
		sta ZP.SourceAddress

		lda CharAddress_MSB, x
		sta ZP.SourceAddress + 1

		lda DigitAddress_LSB, y
		sta ZP.DestAddress

		lda DigitAddress_MSB, y
		sta ZP.DestAddress + 1

		ldy #0

		Loop:

			sty ZP.Y

			lda (ZP.SourceAddress), y

			pha

			lda YToY, y
			tay
			pla
			sta (ZP.DestAddress), y

			ldy ZP.Y

			iny
			cpy #8
			bcc Loop







		rts
	}



}
