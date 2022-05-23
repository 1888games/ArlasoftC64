LEVELDATA:{

	NextLevelID: .byte 0

	MaxJumpers:		.byte 02, 03, 03, 03, 03, 04, 04, 04, 04, 04, 05, 05, 05, 05, 05, 05
	Speed:			.byte 10, 09, 08, 07, 06, 09, 08, 07, 06, 05, 09, 08, 07, 06, 05, 04
	Jumpers:		.byte 04, 04, 05, 05, 06, 04, 04, 05, 06, 08, 04, 05, 06, 10, 20, 255
	

	Ones: .byte 0
	Tens: .byte 0

	.label MaxLevels = 16

	ScreenPosition: .byte 25


	SetupNextLevel: {

		.if(target == "VIC") {
			lda #71
			sta ScreenPosition
		}

		.if(target == "PET") {
			lda #26
			sta ScreenPosition
		}
	
		ldx NextLevelID

	//	ldx #10

		lda MaxJumpers, x
		sta JUMPERS.MaxJumpers

		lda #0
		sta JUMPERS.SavedThisLevel

		lda Jumpers, x
		sta JUMPERS.JumpersToSave


		lda Speed, x
		sta MAIN.GameCounter + 2
		sta MAIN.GameCounter + 1
		sta MAIN.GameCounter

		lda MAIN.GameMode
		beq NoIncrease

		lda Speed, x
		sec
		sbc #6
		sta Speed, x


		NoIncrease:

		//jsr UpdateLevelText

		inx
		cpx #MaxLevels
		beq Wrap

		jmp Finish

		Wrap:

			dex
			

		Finish:
			stx NextLevelID

			

			rts


	}


	UpdateLevelText: {

		lda Tens

		clc
		adc SCORE.CharacterSetStart

		ldy ScreenPosition
		sta (SCREEN_RAM), y

		lda Ones
		clc
		adc SCORE.CharacterSetStart

		iny
		sta (SCREEN_RAM), y

		.if(target != "PET") {

			lda #ONE

			.if(target == "264") {
					clc
					adc #96
				}

			sta (COLOR_RAM), y
			dey
			sta (COLOR_RAM), y

		}

		inc Ones
		lda Ones
		cmp #10
		bne Finish

		lda #ONE
		sta Ones
		inc Tens



		Finish:

		rts


	}



}