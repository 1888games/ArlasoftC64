BOTTOM_HUD: {


	//.label StartX = TOP_HUD.OneUp - 16
	//.label Y = 253

	.label StartX = 242
	.label Y = TOP_HUD.LabelY + 3

	FruitColours:		.byte WHITE, ORANGE, WHITE, LIGHT_GREEN, YELLOW, WHITE, YELLOW, CYAN
	MultiColours_1:		.byte 


	.label StartPointer = 5
	.label CreditPointer = 143
					// 0       1        2        3        4        5
	Pointer1:	.byte 75 + 48, 82 + 48, 81 + 48, 81 + 48, 81 + 48, 81 + 48, 81 + 48
	Pointer2:	.byte 75 + 48, 75 + 48, 75 + 48, 82 + 48, 81 + 48, 81 + 48, 81 + 48
	Pointer3:	.byte 75 + 48, 75 + 48, 75 + 48, 75 + 48, 75 + 48, 82 + 48, 81 + 48

	ShowLives:		.byte 0


	Draw: {


		lda MAIN.GameMode
		cmp #GAME_MODE_INTERMISSION
		bne NotInter

		lda INTERMISSION.ID
		bne Finish

		NotInter: 


		lda ShowLives
		beq Credits


		Lives:

			lda #Y
			sta VIC.SPRITE_5_Y
			sta VIC.SPRITE_6_Y
			sta VIC.SPRITE_7_Y

			ldx GAME.Lives

			lda Pointer1, x
			sta SPRITE_POINTERS + 5
			sta SPRITE_POINTERS_2 + 5
			

			lda #YELLOW
			sta VIC.SPRITE_COLOR_5
			sta VIC.SPRITE_COLOR_6
			sta VIC.SPRITE_COLOR_7

			lda #StartX
			sta VIC.SPRITE_5_X

			clc
			adc #24
			sta VIC.SPRITE_6_X

			clc
			adc #24
			sta VIC.SPRITE_7_X

			
			lda Pointer2, x
			sta SPRITE_POINTERS + 6
			sta SPRITE_POINTERS_2 + 6

			lda Pointer3, x
			sta SPRITE_POINTERS + 7
			sta SPRITE_POINTERS_2 + 7
	

			rts

		Credits:

			lda #Y- 3
			sta VIC.SPRITE_5_Y
			sta VIC.SPRITE_6_Y

			ldx #CreditPointer
			stx SPRITE_POINTERS + 5
			stx SPRITE_POINTERS_2 + 5

			inx

			stx SPRITE_POINTERS + 6
			stx SPRITE_POINTERS_2 + 6

			lda #StartX + 8
			sta VIC.SPRITE_5_X

			clc
			adc #24
			sta VIC.SPRITE_6_X

			lda #WHITE
			sta VIC.SPRITE_COLOR_5
			sta VIC.SPRITE_COLOR_6


		Finish:


	
		rts


	}


	Level: {

		lda ShowLives
		beq Credits


		Fruit:

			lda #41
			sta VIC.SPRITE_7_Y
			sta VIC.SPRITE_6_Y
			sta VIC.SPRITE_5_Y

			jsr FRUIT.ColoursAndPointers

			lda #22
			sta VIC.SPRITE_7_X
			sta VIC.SPRITE_6_X
			sta VIC.SPRITE_5_X


			lda VIC.SPRITE_MULTICOLOR
			and #%00011111
			sta VIC.SPRITE_MULTICOLOR

			lda VIC.SPRITE_MSB
			ora #%11100000
			sta VIC.SPRITE_MSB

			rts

		Credits:

			lda #Y + 22
			sta VIC.SPRITE_7_Y
			
			lda #CreditPointer + 2
			clc
			adc TITLE.Credits
			sta SPRITE_POINTERS + 7
			sta SPRITE_POINTERS_2 + 7

			lda #18
			sta VIC.SPRITE_7_X

		

			lda #WHITE
			sta VIC.SPRITE_COLOR_7

			lda VIC.SPRITE_MULTICOLOR
			and #%01111111
			sta VIC.SPRITE_MULTICOLOR



		rts
	}







}