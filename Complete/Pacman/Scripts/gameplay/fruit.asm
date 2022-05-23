FRUIT: {

	* = * "FRUIT"

	AppearTimer:		.byte 0, 0
	Active:				.byte 0
	
	Colour1:			.byte WHITE, ORANGE, WHITE, CYAN, BLUE, WHITE, WHITE, CYAN
	Colour2:			.byte ORANGE, BROWN, ORANGE, GREEN, YELLOW, GREEN, YELLOW, WHITE
	Colour3:			.byte RED, GREEN, RED, WHITE, RED, RED, CYAN, BLACK

	ScoreTimer:			.byte 0
	FruitTypes:			.byte 0, 5, 1, 1, 2, 2, 3, 3, 4, 4, 6, 6, 7
	FruitScores:		.byte 0, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7
	CurrentFruit:		.byte 0

	* = * "FruitScore"
	CurrentScore:		.byte 0

	.label PixelX = TILE_SIZE * (1+13) - 1 
	.label PixelY = TILE_SIZE * 20 + MID_TILE_Y

	.label FruitSpriteX = PixelX + 19 + (SCROLLER.START_COLUMN * TILE_SIZE)
	.label FruitSpriteY = PixelY + 48 + SCROLLER.TOP_BORDER_ROWS * 8

	.label Debug_Factor = 1
	.label DotLimit1 = 70 * Debug_Factor
	.label DotLimit2 = 170 * Debug_Factor

	.label FruitPointer = 102 + 48
	.label ScoreTime = 120
	.label FruitSeconds = 9
	.label ScoreStartID = 6

	.label FruitTime_LSB = <(FruitSeconds * 60 * Debug_Factor)
	.label FruitTime_MSB = >(FruitSeconds * 60 * Debug_Factor)
	.label ScorePointer = 113


	Pointers:		.byte 0, 0, 0
	Colours:		.byte 0, 0, 0

	PosY:			.byte 0

	.label TileX = 13
	.label TileX2 = 14
	.label TileY = 20


	NewLevel: {

		lda #0
		sta Active
		sta AppearTimer
		sta AppearTimer + 1
		sta ScoreTimer

		//inc Active

		ldx GAME.FruitLevel
		lda FruitTypes, x
		sta CurrentFruit

		lda FruitScores, x
		sta CurrentScore


		ldx CurrentFruit
		lda Colour1, x
		sta Colours

		lda Colour2, x
		sta Colours + 1

		lda Colour3, x
		sta Colours + 2

		lda #FruitPointer
		clc
		adc FRUIT.CurrentFruit
		sta Pointers
		clc
		adc #8
		sta Pointers + 1
		clc
		adc #8
		sta Pointers + 2

	

		rts
	}	


	RestartLevel: {

		lda #0
		sta Active
		sta ScoreTimer

		rts

	}

	Show: {

		lda #1
		sta Active

		lda #FruitTime_LSB
		sta AppearTimer

		lda #FruitTime_MSB
		sta AppearTimer + 1

		jsr UpdateSpritePositions.DoY

		lda SpriteY + 5
		sta SpriteCopyY + 5


		rts
	}

	OnPelletEaten: {

		Check1:

			lda ACTOR.PLAYER.PelletsEaten
			cmp #DotLimit1
			bne Check2

			jmp Show

		Check2:

			cmp #DotLimit2
			bne Finish

			jmp Show

		Finish:



		rts
	}




	UpdateSpritePositions: {

		lda Active
		clc
		adc ScoreTimer
		beq Finish

		DoY:

			lda #FruitSpriteY
			sec
			sbc SCROLLER.PixelScroll

			cmp #55
			bcc NoDisplay

			cmp #240
			bcs NoDisplay

			jmp StoreY

			NoDisplay:

			rts

		StoreY:

			sta SpriteY + 5
		

		Finish:

		rts
	}

	FrameUpdate: {


		jsr UpdateSpritePositions
		jsr UpdateTimers
		

		rts
	}


	UpdateTimers: {

		lda ScoreTimer
		beq NotScoring

		dec ScoreTimer

		NotScoring:

			lda Active
			beq Finish


			lda AppearTimer
			sec
			sbc #1
			sta AppearTimer

			lda AppearTimer + 1
			sbc #0
			sta AppearTimer + 1
			bpl NotExpired

			lda #0
			sta Active

		NotExpired:


		Finish:

		rts
	}


	Check: {

		lda Active
		bne CheckY

		rts

		CheckY:

			lda ACTOR.PixelY
			sec
			sbc #PixelY
			cmp #MID_TILE_Y
			bcc CheckX
			beq CheckX

			rts

		CheckX:

			lda ACTOR.PixelX
			sec
			sbc #PixelX
			cmp #MID_TILE_X
			bcc Collide
			beq Collide

			cmp #255 - MID_TILE_X
			bcs Collide

			rts



		Collide:

			jmp GotFruit

	}


	GotFruit: {

		sfx(SFX_FRUIT)

		lda #0
		sta Active

		lda #ScoreTime
		sta ScoreTimer

		lda #ScoreStartID
		clc
		adc CurrentScore
		tay

		jsr SCORE.AddScore

		rts
	}



	Sprites: {


		lda Active
		beq Finish

		DoY:



			lda SpriteCopyY + 5
			sta VIC.SPRITE_5_Y
			sta VIC.SPRITE_6_Y
			sta VIC.SPRITE_7_Y

			lda #FruitSpriteX
			sta VIC.SPRITE_5_X
			sta VIC.SPRITE_6_X
			sta VIC.SPRITE_7_X

			lda VIC.SPRITE_ENABLE
			ora #%11100000
			sta VIC.SPRITE_ENABLE

			lda VIC.SPRITE_MSB
			and #%00011111
			sta VIC.SPRITE_MSB

			jsr ColoursAndPointers

		Finish:

			lda ScoreTimer
			beq NoScore

		ShowScore:

			lda SpriteCopyY + 5
			sta VIC.SPRITE_5_Y

			lda #FruitSpriteX
			sta VIC.SPRITE_5_X

			lda VIC.SPRITE_ENABLE
			ora #%00100000
			sta VIC.SPRITE_ENABLE

			lda VIC.SPRITE_MSB
			and #%00011111
			sta VIC.SPRITE_MSB

			lda #LIGHT_RED
			sta VIC.SPRITE_COLOR_5

			lda #ScorePointer
			clc
			adc CurrentScore
			sta SPRITE_POINTERS + 5
			sta SPRITE_POINTERS_2 + 5



		NoScore:

		rts
	}

	ColoursAndPointers: {

		lda Pointers
		sta SPRITE_POINTERS + 7
		sta SPRITE_POINTERS_2 + 7

		lda Pointers + 1
		sta SPRITE_POINTERS + 6
		sta SPRITE_POINTERS_2 + 6

		lda Pointers + 2
		sta SPRITE_POINTERS + 5
		sta SPRITE_POINTERS_2 + 5
		
		lda Colours
		sta VIC.SPRITE_COLOR_7

		lda Colours + 1
		sta VIC.SPRITE_COLOR_6

		lda Colours + 2
		sta VIC.SPRITE_COLOR_5



		rts
	}


}