SCORE:{

	* = * "Score"
	
	Value: 	.byte 0, 0, 0, 0	// H M L
	Value2: .byte 0, 0, 0, 0

	Best: 	.byte 0, 0, 0, 0

	.label CharacterSetStart = 48

	.label ExtraLife = 70

	DrawWhenFree:	.byte 0
	ScoreInitialised: .byte 0

	ScoreH:		.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	ScoreM:		.byte $00, $00, $00, $00, $01, $01, $00, $00, $02, $03, $08
	ScoreL:		.byte $60, $50, $40, $30, $50, $00, $80, $60, $00, $00, $00
	
	PopupID:	.byte $00, $00, $00, $00, $01, $00, $00, $00, $02, $03, $04


	HadExtra:	.byte 0, 0
	ExtraNormal:	.byte 0, 0

	Reset:{

		lda ScoreInitialised
		beq InitialiseScore

		jmp Finish

		InitialiseScore:

		lda #1
		sta ScoreInitialised

		lda #ZERO
		sta Value
		sta Value + 1
		sta Value + 2
		sta Value + 3
		sta Value + 4
		sta Value + 5
		sta Value + 6
		sta Value + 7

		sta HadExtra 
		sta HadExtra + 1



		Finish:

		rts

	}






	AddScore: {

		// y = scoreType
		// x = score index

		sty ZP.Temp2

		lda BULLETS.PlayerShooting
		sta ZP.Amount
		
		Okay:
		asl
		asl
		tax
		stx ZP.StageOrderID

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
			sta Value + 2, x

			lda Value + 3, x
			adc #0
			sta Value + 3, x

		Finish:

			ldx STAGE.CurrentPlayer
			lda HadExtra, x
			bne NotYet

			lda ZP.Amount
			cmp #$70
			bcc NotYet

			inc HadExtra, x

		AddLife:

			cld
			jsr LIVES.Add
			jmp NowDraw

		NotYet:

			cld

		NowDraw:

			ldx BULLETS.PlayerShooting
			jsr DrawScore
			jsr CheckHighScore


		NoHigh:


		rts
	}


	CheckHighScore: {

		ldx ZP.StageOrderID

		lda Value + 3, x
		cmp Best + 3
		bcc NoHigh

		beq Check2

		jmp IsHigh


	Check2:

		lda Value + 2, x
		cmp Best + 2
		bcc NoHigh

		beq Check3

		jmp IsHigh

	Check3:

		lda Value + 1, x
		cmp Best + 1
		bcc NoHigh

		beq Check4

		jmp IsHigh

	Check4:

		lda Value, x
		cmp Best
		bcc NoHigh



	IsHigh:

		lda Value, x
		sta Best

		lda Value + 1, x
		sta Best + 1

		lda Value + 2, x
		sta Best + 2

		lda Value + 3, x
		sta Best + 3



		jsr DrawBest


		NoHigh:

		ldx BULLETS.PlayerShooting

		rts
	}



	DrawBestTitle:{

		ldy #7	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #4
		sta ZP.EndID

		lda Best+ 3, x
		bne ScoreLoop

		dec ZP.EndID

		lda Best + 2, x
		bne ScoreLoop

		dec ZP.EndID

		lda Best + 1, x
		bne ScoreLoop

		dec ZP.EndID


		InMills:

		ScoreLoop:

			lda Best, x
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
			sta SCREEN_RAM + 95, y

			lda #RED
			sta VIC.COLOR_RAM + 95, y
			dey
			rts


		}

		Finish:

		rts

	}


	
	DrawBest:{

		ldy #7	//screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #4
		sta ZP.EndID

		lda Best+ 3, x
		bne ScoreLoop

		dec ZP.EndID

		lda Best + 2, x
		bne ScoreLoop

		dec ZP.EndID

		lda Best + 1, x
		bne ScoreLoop

		dec ZP.EndID


		InMills:

		ScoreLoop:

			lda Best, x
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
			sta SCREEN_RAM + 149, y

			lda #RED
			sta VIC.COLOR_RAM + 149, y
			dey
			rts


		}

		Finish:

		rts

	}

	DrawP1:{

		ldy #7	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #4
		sta ZP.EndID

		lda Value + 3, x
		bne ScoreLoop

		dec ZP.EndID

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
			sta SCREEN_RAM + 309, y

			lda #RED
			sta VIC.COLOR_RAM + 309, y
			dey
			rts


		}

		Finish:

		rts

	}


	DrawP2Title:{

		ldy #7	// screen offset, right most digit
		ldx #4	// score byte index

		lda #8
		sta ZP.EndID

		lda Value + 3, x
		bne ScoreLoop

		dec ZP.EndID

		lda Value + 2, x

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
			sta SCREEN_RAM + 105, y

			lda #RED
			sta VIC.COLOR_RAM + 105, y
			dey
			rts


		}

		Finish:

		rts

	}

	DrawP1Title:{

		ldy #7	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #4
		sta ZP.EndID

		lda Value + 3, x
		bne ScoreLoop

		dec ZP.EndID

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
			sta SCREEN_RAM + 83, y

			lda #RED
			sta VIC.COLOR_RAM + 83, y
			dey
			rts


		}

		Finish:

		rts

	}


	DrawScore: {


		cpx #0
		beq PlayerOne

			jmp DrawP2

		PlayerOne:

			jmp DrawP1


	}	

	DrawP2:{

		ldy #7	// screen offset, right most digit
		ldx #4	// score byte index

		lda #8
		sta ZP.EndID

		lda Value + 3, x
		bne ScoreLoop

		dec ZP.EndID

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
			sta SCREEN_RAM + 469, y

			lda #RED
			sta VIC.COLOR_RAM + 469, y
			dey
			rts


		}

		Finish:

		rts

	}


	



}