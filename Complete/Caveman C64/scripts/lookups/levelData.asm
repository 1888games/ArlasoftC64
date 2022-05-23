LEVELDATA:{

	NextLevelID: .byte 0

	BirdActive: 	.byte 0, 1, 0, 1, 1, 0, 1, 1, 1, 1
	VolcanoActive:  .byte 0, 0, 1, 1, 1, 1, 0, 1, 1, 1
	Speed:			.byte 36, 34, 32, 30, 29, 28, 27, 26, 25, 24
	MaxLava:		.byte 2, 2, 2, 2, 3, 3, 3, 3, 3, 3
	HatchTime:		.byte 8, 8, 7, 7, 6, 6, 5, 5, 4
	DinoStunTime: 	.byte 9, 9, 9, 9, 8, 8, 7, 7, 7, 6, 6

	Ones: .byte 1
	Tens: .byte 0

	.label MaxLevels = 10


	SetupNextLevel: {

		ldx NextLevelID

		lda BirdActive, x
		sta BIRD.IsActive

		lda VolcanoActive, x
		sta VOLCANO.IsActive

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

		lda MaxLava, x
		sta LAVA.MaxInstance

		lda DinoStunTime, x
		sta DINO.StunCounter + 1

		lda HatchTime, x
		sta EGG.HatchCounter + 1

		jsr UpdateLevelText

		inx
		cpx #MaxLevels
		beq Wrap

		jmp Finish

		Wrap:

			ldx #ZERO
			

		Finish:
			stx NextLevelID

			rts


	}


	UpdateLevelText: {

		lda Tens

		clc
		adc #SCORE.CharacterSetStart

		ldy #ZERO
		sta SCREEN_RAM + 25, y

		lda Ones
		clc
		adc #SCORE.CharacterSetStart

		sta SCREEN_RAM + 26, y

		lda #ONE
		sta VIC.COLOR_RAM + 26, y
		sta VIC.COLOR_RAM + 25, y

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