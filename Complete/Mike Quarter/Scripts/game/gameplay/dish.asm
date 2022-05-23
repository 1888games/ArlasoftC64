

.label MAX_DISHES = 3

DISH: {



	Colour:	.fill MAX_DISHES * NUM_BELTS, 255
	X_LSB:	.fill MAX_DISHES * NUM_BELTS, 0
	X_MSB:	.fill MAX_DISHES * NUM_BELTS, 0
	Y:		.fill MAX_DISHES * NUM_BELTS, 0
	Score_M: .fill MAX_DISHES * NUM_BELTS, 0
	Score_L: .fill MAX_DISHES * NUM_BELTS, 0

	YPositions:		.fill 6, YStart + (32 * i) + 4



	StartID:	.fill NUM_BELTS, MAX_DISHES * i

	DishStart:	.fill NUM_BELTS, i * MAX_DISHES
	DishEnd:	.fill NUM_BELTS, (i * MAX_DISHES) + MAX_DISHES

	Colours:	.byte GREEN, RED, YELLOW, CYAN, PURPLE, BLUE

	CurrentBeltID:	.byte 0

	.label StartFall = 253


	ResetForBelt: {

		jsr GetIDs

		Loop:

			lda #255
			sta Colour, y

			iny
			cpy ZP.EndID
			bcc Loop


		rts
	}



	GetIDs: {

		lda DishEnd, x
		sta ZP.EndID

		lda DishStart, x
		tay

		rts
	}



	SpritesForBelt: {

		ldx CurrentBeltID

		lda #0
		sta ZP.CurrentID

		jsr GetIDs

		Loop:

			sty ZP.DishID

			lda Colour, y
			bmi EndLoop

			jsr UpdateSprite

		EndLoop:

			inc ZP.CurrentID

			ldy ZP.DishID
			iny
			cpy ZP.EndID
			bcc Loop


		inc CurrentBeltID


		rts
	}


	ProcessForBelt: {


		jsr GetIDs


		Loop:

			sty ZP.DishID

			lda Colour, y
			bmi EndLoop

			jsr Process

		EndLoop:

			ldy ZP.DishID
			iny
			cpy ZP.EndID
			bcc Loop



		rts
	}

	Process:  {

	
		lda X_MSB, y
		bne IsFalling 

		lda X_LSB, y
		cmp #StartFall
		bcs IsFalling

		jmp NotFalling

	IsFalling:

		lda Y, y
		clc
		adc #1
		sta Y, Y

		lda ZP.Counter
		and #%00000011
		bne NotFalling


		lda X_LSB, y
		clc
		adc #1
		sta X_LSB, y

		lda X_MSB, y
		adc #0
		sta X_MSB, y
		beq NotFalling

		lda X_LSB, y
		cmp #3
		bcc NotFalling


		jmp HitGround

		NotFalling:

		jsr CheckPickUp


		rts
	}


	HitGround: {

		lda #GAME_MODE_DEAD
		sta MAIN.GameMode

		
		lda #SFX_CRASH
		jsr MAIN.PlayChannel2

		rts
	}

	CheckPickUp: {

		lda PLAYER.CarriedDish
		bpl NoGrab

		lda X_MSB, y
		bne InXRange

		lda X_LSB, y
		cmp #240
		bcs InXRange

		rts

	InXRange:

		lda Y, y
		sec
		sbc PLAYER.PosY
		clc
		adc #8
		cmp #16
		bcs NoGrab	

	GrabIt:

		lda #SFX_CATCH
		jsr MAIN.PlayChannel2

		lda Score_M, y
		sta PLAYER.Score_M

		lda Score_L, y
		sta PLAYER.Score_L

		lda Colour, y
		sta PLAYER.CarriedDish
		tax

		clc
		adc #17
		sta SPRITE_POINTERS + 5

		lda Colours, x
		sta VIC.SPRITE_COLOR_5

		ldx ZP.BeltID

		lda #255
		sta Colour, y

		dec BELT.DishCount, x

	NoGrab:


		rts
	}


	MoveDishes: {


		jsr GetIDs


		Loop:

			sty ZP.DishID

			lda Colour, y
			bmi EndLoop
		
		NotCarried:

			jsr MoveDish

		EndLoop:

			ldy ZP.DishID
			iny
			cpy ZP.EndID
			bcc Loop




		rts
	}


	MoveDish: {

		lda X_MSB, y
		bne Finish

		lda X_LSB, y
		cmp #StartFall
		bcs Finish

		clc
		adc #2
		sta X_LSB, y

		lda X_MSB, y
		adc #0
		sta X_MSB, y
		

		Finish:



		rts
	}


	SpawnForBelt: {

		jsr GetIDs

		Loop:

			lda Colour, y
			bmi Found

			iny
			cpy ZP.EndID
			bcc Loop

			rts


		Found:

			jsr RANDOM.Get
			and #%00000111
			cmp #6
			bcs Found

			sta Colour, y

			lda #10
			sta X_LSB, y

			lda #0
			sta X_MSB, y

			lda #$02
			sta Score_M, y

			lda #$50
			sta Score_L, y

			lda YPositions, x
			sta Y, y

			lda BELT.DishCount, x
			bne AlreadyRunning

			jsr MAIN.PlayConveyor

			AlreadyRunning:

			inc BELT.DishCount, x




		rts
	}


	UpdateSprite: {

		pha
		tax

		lda Y, y
		sta ZP.SpriteY

		lda X_LSB, y
		sta ZP.SpriteX

		lda X_MSB, y
		beq NoMSB

		MSB:

			ldy ZP.CurrentID

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + 2, y
			sta VIC.SPRITE_MSB

			jmp MSB_Done


		NoMSB:

			ldy ZP.CurrentID
			
			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 2, y
			sta VIC.SPRITE_MSB

		MSB_Done:

			pla
			clc
			adc #17
			sta SPRITE_POINTERS + 2, y

			lda Colours, x
			sta VIC.SPRITE_COLOR_2, y

			tya
			asl
			tay

			lda ZP.SpriteY
			sta VIC.SPRITE_2_Y, y

			lda ZP.SpriteX
			sta VIC.SPRITE_2_X, y




		rts
	}


}