HI_SCORE: {


	Text:

	* = * "Hi_Score"
	.byte C,o,n,g,r,a,t,u,l,a,t,i,o,n,s,SPACE,P,l,a,y,e,r,SPACE,65, 0
	.byte Y,o,u,SPACE,h,a,v,e,SPACE,j,o,i,n,e,d,SPACE,t,h,e,SPACE,i,m,m,o,r,t,a,l,s,0
	.byte i,n,SPACE,t,h,e,SPACE,B,E,R,Z,E,R,K,SPACE,h,a,l,l,SPACE,o,f,SPACE,f,a,m,e,0
	.byte E,n,t,e,r,SPACE,y,o,u,r,SPACE,i,n,i,t,i,a,l,s,Colon,0
	.byte A,SPACE,SPACE,0
	.byte Line,Line,Line,0
	.byte M,o,v,e,SPACE,s,t,i,c,k,SPACE,t,o,SPACE,c,h,a,n,g,e,SPACE,l,e,t,t,e,r,0
	.byte t,h,e,n,SPACE,p,r,e,s,s,SPACE,F,I,R,E,SPACE,t,o,SPACE,s,t,o,r,e,SPACE,i,t,Dot,0

	* = * "Hi_ScoreCode"

	Colours:	.byte WHITE, CYAN, CYAN, CYAN, WHITE, WHITE, LIGHT_GREEN, LIGHT_GREEN
	Columns:	.byte 8, 5, 6, 7, 19, 19, 5, 5
	Rows:		.byte 1, 4, 6, 10, 12, 14, 18, 20


	SelectedLetter:		.byte A
	Cooldown:			.byte 5
	LetterIndex:		.byte 0
	Initials:			.byte 0, 0, 0
	Scores:				.byte 0, 0, 0
	PlayerPosition: 	.byte 0

	.label MinLetter = A
	.label MaxLetter = Z
	.label CooldownTime = 3



	Initialise: {


		jsr Check

		lda ZP.Amount
		bpl GotHighScore

		NoHighScore:

		jmp MAIN.SetupTitleScreen

		GotHighScore:

		jsr UTILITY.ClearScreen

		lda #GAME_MODE_SCORE
		sta MAIN.GameMode

		lda #1
		sta MAIN.GameActive

		lda #0
		sta LetterIndex

		lda #A
		sta SelectedLetter

		jsr DrawText


		rts
	}


	DrawText: {

		ldx #0
		stx ZP.CharID


		RowLoop:	

			stx ZP.X

			lda Rows, x
			tay

			lda Colours, x
			sta ZP.Colour

			lda Columns, x
			tax

			jsr PLOT.GetCharacter

			ldy #0
			ldx ZP.CharID

		ColumnLoop:

			lda Text, x
			beq EndOfColumn

			
			sta (ZP.ScreenAddress), y
			clc
			adc #16
			sta ZP.Temp4

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #40
			tay

			lda ZP.Temp4
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			tya
			sec
			sbc #39
			tay

			inx
			jmp ColumnLoop



			EndOfColumn:
			
				inx
				stx ZP.CharID

				ldx ZP.X
				inx
				cpx #8
				bcc RowLoop



		Done:








		rts
	}


	LetterUp: {

		lda SelectedLetter
		cmp #MinLetter
		beq Finish


		dec SelectedLetter

		jsr DrawLetter

		
		Finish:



		rts
	}

	DrawLetter: {

		lda SelectedLetter
		cmp #112
		bne NotQ

		lda #128
		sta SelectedLetter
		jmp NowDraw


		NotQ:

		cmp #127
		bne NotP

		lda #111
		sta SelectedLetter
		jmp NowDraw

		NotP:

		NowDraw:

			ldx LetterIndex

			sta SCREEN_RAM + 499, x

			clc
			adc #16
			sta SCREEN_RAM + 539, x

			lda #CooldownTime
			sta Cooldown



		rts
	}

	LetterDown: {

		lda SelectedLetter
		cmp #MaxLetter
		beq Finish

		inc SelectedLetter

		jsr DrawLetter

		Finish:


		rts
	}


	Finished: {


		ldx PlayerPosition
		lda Initials
		sta FirstInitials, x

		lda Initials + 1
		sta SecondInitials, x

		lda Initials + 2
		sta ThirdInitials, x

		jsr UTILITY.ClearScreen

		jsr MAIN.DrawSaving

		jsr DISK.SAVE

		jmp MAIN.SetupTitleScreen

		rts
	}

	ConfirmLetter: {

		ldx LetterIndex
		lda SelectedLetter
		sta Initials, x

		lda #DARK_GRAY
		sta VIC.COLOR_RAM + 579, x

		inx
		cpx #3
		bcc NotEnded

		jmp Finished


		NotEnded:

		stx LetterIndex
		
		lda #A
		sta SelectedLetter
		jsr DrawLetter

		rts
	}

	FrameUpdate: {


		CheckDebounce:

			lda Cooldown
			beq Ready

			dec Cooldown
			rts

		Ready:

			ldy #1

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq CheckLeft


		Fire:

			jmp ConfirmLetter

		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

		Left:

			jmp LetterUp

		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

		Right:

			jmp LetterDown


		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

		Down:

			jmp LetterDown


		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq Finish

			jmp LetterUp

		Finish:

		rts
	}



	Check: {

		
		Player1:

			lda SCORE.Value
			sta Scores

			lda SCORE.Value + 1
			sta Scores + 1

			lda SCORE.Value + 2
			sta Scores + 2

		CheckScore:

			lda #255
			sta ZP.Amount

			ldx #0
			stx ZP.StartID

		Loop:

			stx ZP.StoredXReg

			ldx ZP.StartID 


				lda Scores + 2
				cmp HiByte, x
				bcc EndLoop

				beq EqualsHigh

			BiggerHigh:

				stx ZP.Amount
				jmp Done

			EqualsHigh:

				lda Scores + 1
				cmp MedByte, x
				bcc EndLoop

				beq EqualsMed

			BiggerMed:

				stx ZP.Amount
				jmp Done

			EqualsMed:

				lda Scores
				cmp LowByte, x
				bcc EndLoop

				stx ZP.Amount
				jmp Done

			EndLoop:	

				inc ZP.StartID

				ldx ZP.StoredXReg
				inx
				cpx #8
				bcc Loop


		Done:

			lda ZP.Amount
			bmi Finish

			stx PlayerPosition

			cpx #7
			bcs NoCopy


		ldx #6
		ldy #7

		CopyLoop:

			lda HiByte, x
			sta HiByte, y

			lda MedByte, x
			sta MedByte, y

			lda LowByte, x
			sta LowByte, y

			lda FirstInitials, x
			sta FirstInitials, y

			lda SecondInitials, x
			sta SecondInitials, y

			lda ThirdInitials, x
			sta ThirdInitials, y


			lda PlayerPosition

			dex
			dey
			cpx #255
			beq NoCopy
			cpx PlayerPosition
			bcs CopyLoop


		NoCopy:

			ldx PlayerPosition

			lda Scores + 2
			sta HiByte, x

			lda Scores + 1
			sta MedByte, x

			lda Scores
			sta LowByte, x

			

			
			//lda #GAME_MODE_SWITCH_SCORE
			//sta MAIN.GameMode


		Finish:


		rts






	}



}