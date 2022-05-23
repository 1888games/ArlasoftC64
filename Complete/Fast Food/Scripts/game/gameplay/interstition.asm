INTER: {


	.label LeftX = 140
	.label StartY = 70
	.label Y1 = StartY + 21
	.label Y2 = Y1 + 21
	.label Y3 = Y2 + 21

	PosX:	.fill 4, LeftX + (24 * i)
			.fill 4, LeftX + (24 * i)
			
	PosY:	.fill 4, 0


	Pointers: .fill 16, 31 + i
	Drawn: 	.byte 0


	Initialise: {

		jsr SOUND.Fatter

		lda #GAME_MODE_INTERSTITION
		sta MAIN.GameMode


		lda #0
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y

		jsr HideChars

		lda #StartY
		sta PosY

		lda #Y1
		sta PosY + 1

		lda #Y2
		sta PosY + 2

		lda #Y3
		sta PosY + 3

		lda #0
		sta VIC.SPRITE_MSB

		ldx #0
		ldy #0

		Loop:

			lda PosX, x
			sta VIC.SPRITE_0_X, y

			inx
			iny
			iny

			cpx #8
			bcc Loop

		lda #LIGHT_RED
		sta VIC.SPRITE_COLOR_0
		sta VIC.SPRITE_COLOR_1
		sta VIC.SPRITE_COLOR_2
		sta VIC.SPRITE_COLOR_3
		sta VIC.SPRITE_COLOR_4
		sta VIC.SPRITE_COLOR_5
		sta VIC.SPRITE_COLOR_6
		sta VIC.SPRITE_COLOR_7


		rts
	}


	TopSprites: {

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERSTITION
		bne Finish

		lda PosY
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y

		lda PosY + 1
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y
 
		lda Pointers + 0
		sta SPRITE_POINTERS + 0
		lda Pointers + 1
		sta SPRITE_POINTERS + 1
		lda Pointers + 2
		sta SPRITE_POINTERS + 2
		lda Pointers + 3
		sta SPRITE_POINTERS + 3
		lda Pointers + 4
		sta SPRITE_POINTERS + 4
		lda Pointers + 5
		sta SPRITE_POINTERS + 5
		lda Pointers + 6
		sta SPRITE_POINTERS + 6
		lda Pointers + 7
		sta SPRITE_POINTERS + 7

		Finish:


		rts
	}

	BottomSprites: {

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERSTITION
		bne Finish


		lda PosY + 2
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y

		lda Pointers + 8
		sta SPRITE_POINTERS + 0
		lda Pointers + 9
		sta SPRITE_POINTERS + 1
		lda Pointers + 10
		sta SPRITE_POINTERS + 2
		lda Pointers + 11
		sta SPRITE_POINTERS + 3
		

		lda PosY + 3
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y
			
		lda Pointers + 12
		sta SPRITE_POINTERS + 4
		lda Pointers + 13
		sta SPRITE_POINTERS + 5
		lda Pointers + 14
		sta SPRITE_POINTERS + 6
		lda Pointers + 15
		sta SPRITE_POINTERS + 7


		Finish:
		rts
	}

	HideChars: {

		ldx #0


		Loop:

			lda #0
			sta VIC.COLOR_RAM + 0, x
			sta VIC.COLOR_RAM + 250, x
			sta VIC.COLOR_RAM + 500, x
			sta VIC.COLOR_RAM + 750, x

			inx
			cpx #250
			bcc Loop


		rts
	}


	ShowChars: {

		ldx #0

		Loop:

			lda SCREEN_RAM + 0, x
			tay
			lda CHAR_COLORS, y
			sta VIC.COLOR_RAM + 0, x

			lda SCREEN_RAM + 250, x
			tay
			lda CHAR_COLORS, y
			sta VIC.COLOR_RAM + 250, x

			lda SCREEN_RAM + 500, x
			tay
			lda CHAR_COLORS, y
			sta VIC.COLOR_RAM + 500, x

			lda SCREEN_RAM + 750, x
			tay
			lda CHAR_COLORS, y
			sta VIC.COLOR_RAM + 750, x


			inx
			cpx #250
			bcc Loop

			rts

	}


	FrameUpdate: {

		inc PosY
		inc PosY + 1
		inc PosY + 2
		inc PosY + 3

		lda PosY
		cmp #180
		bcc Okay

		jsr ShowChars

		jsr SCORE.DrawBest

		lda #GAME_MODE_PLAY
		sta MAIN.GameMode

		jsr MOUTH.Initialise
		jsr FOOD.Initialise
		jsr FOOD.LevelUp

		lda #0
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y


		Okay:


		rts
	}




}