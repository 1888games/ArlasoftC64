SCORE:{

	* = * "Score"
	
	Value: 	.byte 0, 0, 0, 0	// H M L
	Value2: .byte 0, 0, 0, 0

	Best: 	.byte 0, 5, 0, 0

	.label CharacterSetStart = 48


	DrawWhenFree:	.byte 0
	ScoreInitialised: .byte 0

	ScoreH:		.byte $00, $00, $00, $00, $00, $00
	ScoreM:		.byte $10, $20, $30, $40, $50, $01
	ScoreL:		.byte $00, $00, $00, $00, $00, $00


	Extras:		.byte 1, 2, 2, 3, 3, 4

	NextExtra:		.byte 0, 0
	CurrentExtra:	.byte 0, 0
	ExtraID:		.byte 0, 0

	CurrentPlayer:	.byte 0

	NumberChars:	.fill 40, 1 + i

	ScoreTimer:		.byte 15

	.label ScoreTime = 8

	Reset:{

		lda #ZERO
		sta Value
		sta Value + 1
		sta Value + 2
		sta Value + 3
		sta Value + 4
		sta Value + 5
		sta Value + 6
		sta Value + 7
	
		sta CurrentExtra 
		sta CurrentExtra + 1
		sta ExtraID
		sta ExtraID + 1

		lda #1
		sta NextExtra
		sta NextExtra + 1


		jsr NewLevel

	
		Finish:

		rts

	}


	NewLevel: {

		jsr DrawP1
		jsr DrawBest


		rts
	}




	AddScore: {

		// y = scoreType
		// x = score index

		lda #0
		sta ZP.Amount

		lda CurrentPlayer
		asl
		asl
		tax

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

			ldx CurrentPlayer
			lda CurrentExtra, x
			clc
			adc ZP.Amount
			sta CurrentExtra, x

			cmp NextExtra, X
			bne NotYet

		ExtraLife:

			lda #0
			sta CurrentExtra, x

			inc ExtraID, x
			lda ExtraID, x
			cmp #6
			bcc OkayExtra

			lda #5
			sta ExtraID, x

		OkayExtra:

			tay
			lda Extras, y
			sta NextExtra, x

		AddLife:

			cld
		//jsr OBJECTS.AddLife
		//	jsr SOUND.ExtraLife
			jmp NowDraw

		NotYet:

			cld

			//jsr SOUND.Collect

		NowDraw:

			ldx CurrentPlayer
			jsr DrawScore
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


		//jsr DrawBest


		NoHigh:

		rts
	}



	
	DrawP1:{

	

		ldx #38
		ldy #8

		jsr PLOT.GetCharacter

		ldx #ZERO	// score byte index

		lda #4
		sta ZP.EndID

		
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
			//beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			//.break
			clc
			adc #48

			sta (ZP.ScreenAddress), y
			
			lda #CYAN
			sta (ZP.ColourAddress), y

			lda ZP.ScreenAddress
			sec
			sbc #40
			sta ZP.ScreenAddress

			lda ZP.ScreenAddress + 1
			sbc #0
			sta ZP.ScreenAddress + 1

			rts


		}

		Finish:

		lda #ScoreTime
		sta ScoreTimer
		

		rts

	}

	FrameUpdate: {

		lda ScoreTimer
		bmi Finish

		beq Ready

		dec ScoreTimer
		rts

		Ready:

		lda #255
		sta ScoreTimer

		//jsr SOUND.Score


		Finish:




		rts
	}

	DrawBest:{

		ldx #12
		ldy #22

		jsr PLOT.GetCharacter

		ldy #14	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #4
		sta ZP.EndID

		lda Value + 3, x
		bne ScoreLoop

		dec ZP.EndID

		// lda Value + 2, x
		// bne ScoreLoop

		// dec ZP.EndID

		// lda Value + 1, x
		// bne ScoreLoop

		// dec ZP.EndID


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
			//beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			//.break

			stx ZP.X

			asl
			asl
			tax

			lda NumberChars, x

			dey
			sta (ZP.ScreenAddress), y

			
			lda #WHITE
			sta (ZP.ColourAddress), y

			inx
			lda NumberChars, x
			iny
			sta (ZP.ScreenAddress), y

			lda #WHITE
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #39
			tay

			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #WHITE
			sta (ZP.ColourAddress), y

		
			iny 
			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #WHITE
			sta (ZP.ColourAddress), y

			tya
			sec
			sbc #42
			tay

			ldx ZP.X

			rts


		}

		Finish:

		lda #ScoreTime
		sta ScoreTimer
		

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
			sta SCREEN_RAM + 458, y

			lda #WHITE
			sta VIC.COLOR_RAM + 458, y
			dey
			rts


		}

		Finish:

		rts

	}

	



}