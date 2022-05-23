ENEMY_DRAW: {


	SetSprites: {

		lda LateSprites
		bne Draw

		jmp Finish

		Draw:

		lda #BLUE
		sta VIC.SPRITE_MULTICOLOR_1

		lda #PURPLE
		sta VIC.SPRITE_MULTICOLOR_2

		First:

			ldx ENEMIES.LateSpriteIDs + 0
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_0_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_0_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 0


			lda Colour, x
			sta VIC.SPRITE_COLOR_0

		dec LateSprites

		Second:

			ldx ENEMIES.LateSpriteIDs + 1
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_1_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_1_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 1


			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_1


		dec LateSprites
		

		Third:

			ldx ENEMIES.LateSpriteIDs + 2
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_2_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_2_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 2


			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_2


		dec LateSprites
	

		Fourth:

			ldx ENEMIES.LateSpriteIDs + 3
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_3_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_3_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 3


			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_3


		dec LateSprites
		bne Fifth

		jmp Finish

		Fifth:

			ldx ENEMIES.LateSpriteIDs + 4
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_7_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_7_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 7


			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_7


		dec LateSprites
		beq Finish


		Sixth:

			ldx ENEMIES.LateSpriteIDs + 5
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_6_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_6_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 6


			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_6


		dec LateSprites
		beq Finish


		Seventh:

			ldx ENEMIES.LateSpriteIDs + 6
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_5_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_5_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 5


			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_5


		dec LateSprites
		beq Finish


		Eighth:

			ldx ENEMIES.LateSpriteIDs + 7
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_4_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_4_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 4


			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_4


		Finish:


		rts
	}





	SetSpritesEarly: {

		lda EarlySprites
		bne First

		jmp Finish

		First:

			ldx ENEMIES.EarlySpriteIDs + 0
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_4_X

			lda ENEMIES. PosSpriteY, x
			sta VIC.SPRITE_4_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 4

			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_4

		dec EarlySprites
		beq Finish

		Second:

			ldx ENEMIES.EarlySpriteIDs + 1
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_5_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_5_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 5

			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_5

		dec EarlySprites
		beq Finish

		Third:

			ldx ENEMIES.EarlySpriteIDs + 2
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_6_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_6_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 6

			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_6

		dec EarlySprites
		beq Finish


		Fourth:

			ldx ENEMIES.EarlySpriteIDs + 3
			lda ENEMIES.PosSpriteX, x
			sta VIC.SPRITE_7_X

			lda ENEMIES.PosSpriteY, x
			sta VIC.SPRITE_7_Y

			lda ENEMIES.Frame, x
			clc
			adc ENEMIES.BaseFrame, x
			sta SPRITE_POINTERS + 7

			lda ENEMIES.Colour, x
			sta VIC.SPRITE_COLOR_7


		Finish:

				rts
			
	}

}