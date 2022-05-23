SCORE:{

	Value: .byte 0, 0, 0, 0	// H M L
	Value2: .byte 0, 0, 0, 0

	Best: .byte 0, 0, 0

	PlayerScores: .byte 0, 0, 0, 0
	 			  .byte 0, 0, 0, 0

	.label CharacterSetStart = 5

				//    0               1              2               3               4
	Characters:	.byte 33, 34, 35, 36, 37, 39, 38, 1, 40, 42, 41, 36, 43, 44, 41, 36, 45, 46, 47, 48
				//    5               6              7                 8                9
				.byte 49, 50, 51, 52, 53, 50, 35, 36,55,  58, 56, 57, 103, 44, 35, 36, 104, 105, 35, 36



	ScoreToAdd: .byte 0
	DrawWhenFree:	.byte 0
	ScoreInitialised: .byte 0

	Reset:{

		lda ScoreInitialised
		beq InitialiseScore

		jmp Finish

		InitialiseScore:

		lda #1
		sta ScoreInitialised

		lda #14

		.for(var i=21; i<24; i++) {
			.for(var j=0; j<40; j++) {
				sta VIC.COLOR_RAM + (i * 40) + j
			}
			
		}


		lda #ZERO
		sta Value
		sta Value + 1
		sta Value + 2
		sta Value + 4
		sta Value + 5
		sta Value + 6
		sta ScoreToAdd
		sta Amount

		//lda #153
		//sta Value + 1

		jsr Draw

		Finish:

		//jsr DrawBest
		rts

	}




	BackupScore:		{

		lda SHIP.CurrentPlayer
		asl
		asl
		tax

		lda Value
		sta PlayerScores, x

		lda Value + 1
		sta PlayerScores + 1, x

		lda Value + 2
		sta PlayerScores + 2, x

		rts

	}


	CopyScoreIn: {

		lda SHIP.CurrentPlayer
		asl
		asl
		tax

		lda PlayerScores, x
		sta Value

		lda PlayerScores + 1, x
		sta Value + 1

		lda PlayerScores + 2, x
		sta Value + 2

		jsr Draw 

		rts

	}

	DisplayBest: {

		lda #10

		.for(var i=22; i<24; i++) {
			.for(var j=0; j<40; j++) {
				sta VIC.COLOR_RAM + (i * 40) + j
			}
			
		}

		lda #0
		sta ScoreToAdd
		sta Amount


		lda Best
		sta Value

		lda Best + 1
		sta Value + 1

		lda Best + 2
		sta Value + 2

		lda #0
		sta ScoreInitialised

		jsr Draw 

		rts




	}

	Set: {
		ldy #0
		sty Value

		sta Amount
		
		jsr AddToScore

		rts

	}


	Hardcode: {


		sta Value
		jsr Draw
		rts

	}

	SetBest: {
		
		sta Best
		jsr DrawBest

		rts

	}



	AddToScore:{



		lda ScoreToAdd
		clc
		adc Amount
		sta ScoreToAdd
		rts


	}


 
	ScorePoints: {

		sta Amount
		jsr AddToScore

		rts
	}

	CheckScoreToAdd:{


		lda DrawWhenFree
		beq OkayToAddScore

		jsr Draw
		lda #0
		sta DrawWhenFree
		jmp Finish

		OkayToAddScore:

		lda ScoreToAdd
		beq Finish
		//Loop:

		sec
		sbc #10
		sta ScoreToAdd

		lda #10
		jsr Add


		lda SHIP.Paused
		beq Finish

		jsr Draw
		lda #0
		sta DrawWhenFree

		Finish:

		rts


	}
Add: {

		sta Amount
		sed
		clc
		lda Value
		adc Amount
		sta Value
		lda Value+1
		adc #ZERO
		sta Value+1
		lda Value+2

		adc #ZERO
		cmp Value+2
		beq NoExtraLife

		pha
		lda #1
		sta LIVES.AddLife
		pla

		NoExtraLife:

		sta Value+2
		cld

		cmp Best + 2
		bcs BetterOrEqualHigh

		jmp NoNewBest

		BetterOrEqualHigh:

		beq CheckMiddle

		jmp SetNewBest

		CheckMiddle:

		lda Value + 1
		cmp Best + 1
		bcs BetterOrEqualMiddle

		jmp NoNewBest

		BetterOrEqualMiddle:

		beq CheckLow

		jmp SetNewBest

		CheckLow:

		lda Value
		cmp Best
		bcc NoNewBest

		SetNewBest:

		lda Value + 2
		sta Best + 2
		lda Value + 1
		sta Best + 1
		lda Value + 0
		sta Best + 0

		//jsr DrawBest


		NoNewBest:

		lda #1
		sta DrawWhenFree
		
	
		//jsr SOUND.ScoreSound
		rts


	}

	DrawBest:{

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index

		ScoreLoop:

			lda Best,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			jsr PlotDigitBottom
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			jsr PlotDigitBottom
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {

			clc
			adc #CharacterSetStart
			sta SCREEN_RAM + 12, y
			rts


		}

		PlotDigitBottom: {

			clc
			adc #10
			sta SCREEN_RAM + 52, y
			dey
			rts


		}
	}




	Draw:{

	
		ldy #10	// screen offset, right most digit
		ldx #ZERO	// score byte index

		ScoreLoop:

			lda Value,x
			pha
			and #$0f	// keep lower nibble
			sta ScoreDigit
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {



			stx CurrentID

			asl
			asl
			tax

			lda Characters, x
			sta SCREEN_RAM + 935, y

			inx
			lda Characters, x
			sta SCREEN_RAM + 936, y

			inx
			lda Characters, x
			sta SCREEN_RAM + 895, y

			inx
			lda Characters, x
			sta SCREEN_RAM+ 896, y

			dey
			dey

			ldx CurrentID

			rts


		}


		


		rts


	}



}