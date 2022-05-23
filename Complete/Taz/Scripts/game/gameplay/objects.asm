OBJECTS: {


	.label ROWS = 8
	.label LIVES = 7
	.label BORDER_SIZE = 30

	.label LEFT = 0
	.label RIGHT = 1

	.label MinX = TAZ.MinX - BORDER_SIZE
	.label MaxX = TAZ.MaxX + BORDER_SIZE
	.label FoodStartPointer = 20
	.label FoodPerCourse = 20

	Type:			.fill ROWS + LIVES, 0
	Direction:		.fill ROWS + LIVES, 0
	PosX_Frac:		.fill ROWS + LIVES, 0

	PosX_LSB:		.fill ROWS, 0
					.fill LIVES, 55 + (i * 30)

	PosX_MSB:		.fill ROWS + LIVES, 0
	Cooldown:		.fill ROWS + LIVES, 0

	Pointer:		.fill ROWS, 0
					.fill LIVES, 18
	Colour:			.fill ROWS, 0
					.fill LIVES, BLACK


	Speed_Frac:		.byte 0
	Speed_Pixel:	.byte 4


	.label AddPerCollect = 1

	ScoreLevel:		.byte 0
	FoodCollected:	.byte 0
	FoodType:		.byte 0
	Meal:			.byte 0

	LivesLeft:		.byte 3

	FoodColours:	.byte GREEN, WHITE, RED, YELLOW, YELLOW, GREEN, RED, GRAY, RED


	InitialiseGame: {

		
		lda #18
		sta Pointer 

		lda #RIGHT
		sta Direction
		sta Direction + 2
		sta Direction + 4
		sta Direction + 6

		lda #LEFT
		sta Direction + 1 
		sta Direction + 3
		sta Direction + 5
		sta Direction + 7


		lda #1
		sta Speed_Pixel

		lda #220
		sta Speed_Frac

		lda #3
		sta LivesLeft

		lda #0
	
		sta PosX_Frac
		sta PosX_Frac + 1
		sta PosX_Frac + 2
		sta PosX_Frac + 3
		sta PosX_Frac + 4
		sta PosX_Frac + 5
		sta PosX_Frac + 6
		sta PosX_Frac + 7
		sta Meal
		sta FoodType
		sta FoodCollected
		sta ScoreLevel

		lda #OBJ_FOOD
		sta Type
		sta Type + 1
		sta Type + 2
		sta Type + 3
		sta Type + 4
		sta Type + 5
		sta Type + 6
		sta Type + 7

		lda #GREEN
		sta Colour
		sta Colour + 1
		sta Colour + 2
		sta Colour + 3
		sta Colour + 4
		sta Colour + 5
		sta Colour + 6
		sta Colour + 7

		lda #FoodStartPointer
		sta Pointer
		sta Pointer + 1
		sta Pointer + 2
		sta Pointer + 3
		sta Pointer + 4
		sta Pointer + 5
		sta Pointer + 6
		sta Pointer + 7

		lda #MinX
		sta PosX_LSB
		sta PosX_LSB + 2
		sta PosX_LSB + 4
		sta PosX_LSB + 6

		lda #MaxX
		sta PosX_LSB + 1
		sta PosX_LSB + 3
		sta PosX_LSB + 5
		sta PosX_LSB + 7

		lda #0
		sta PosX_MSB
		sta PosX_MSB + 2
		sta PosX_MSB + 4
		sta PosX_MSB + 6

		lda #1
		sta PosX_MSB + 1
		sta PosX_MSB + 3
		sta PosX_MSB + 5
		sta PosX_MSB + 7




		rts
	}


	LoseLife: {

		dec LivesLeft

		lda LivesLeft
		bne NotGameOver



		NotGameOver:





		rts
	}

	AddLife: {

		inc LivesLeft

		cmp #9
		bcc Okay

		lda #8
		sta LivesLeft

		Okay:

			rts

	}

	UpdateLives: {

		ldx #13
		lda LivesLeft
		sec
		sbc #1
		sta ZP.Amount

		bpl Loop

		lda #0
		sta ZP.Amount

		Loop:

			lda ZP.Amount
			beq Off

			On:

				lda #YELLOW
				sta Colour, x
				jmp EndLoop

			Off:

				lda #BLACK
				sta Colour, x


			EndLoop:

				dec ZP.Amount

				lda ZP.Amount
				bpl Okay

				lda #0
				sta ZP.Amount


				Okay:

				dex
				cpx #8
				bcs Loop

		rts
	}



	ResetDead: {



		ldx #0


		Loop:

			lda #0
			sta PosX_MSB, x
			sta PosX_LSB, x
			sta Type, x

			jsr RANDOM.Get
			and #%01111111
			clc
			adc #10
			sta Cooldown, x

			inx
			cpx #8
			bcc Loop

		jsr RANDOM.Get
		and #%00000111
		tax

		lda #0
		sta Cooldown, x


		rts
	}


	EatFood: {

	//	jsr SOUND.Collect

		lda Speed_Frac
		clc
		adc #AddPerCollect
		sta Speed_Frac

		lda Speed_Pixel
		adc #0
		sta Speed_Pixel


		inc FoodCollected

		ldy ScoreLevel
		jsr SCORE.AddScore

		lda FoodCollected
		cmp #FoodPerCourse
		bcc NoLevelIncrease

		IncreaseFood:

			inc FoodType

			lda #8
			sta ZP.Amount

			lda Meal
			cmp #2
			bcc NoPie

			lda #9
			sta ZP.Amount

		NoPie:

			lda FoodType
			cmp ZP.Amount
			bcc IncreaseScore

			lda #0
			sta FoodType

			inc Meal

		IncreaseScore:

			inc ScoreLevel

			lda ScoreLevel
			cmp #6
			bcc NoWrapScore

			lda #5
			sta ScoreLevel

		NoWrapScore:

			lda #0
			sta FoodCollected


		NoLevelIncrease:




		rts
	}


	BottomSprite: {

		lda PosX_LSB + 7
		sta VIC.SPRITE_1_X

		lda TAZ.RowY + 7
		sta VIC.SPRITE_1_Y

		lda Pointer + 7
		sta SPRITE_POINTERS + 1

		lda Colour + 7
		sta VIC.SPRITE_COLOR_1

		lda PosX_MSB + 7
		beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + 1
			sta VIC.SPRITE_MSB

			rts


		NoMSB:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 1
			sta VIC.SPRITE_MSB


		rts
	}

	Bottom: {

		ldx #8
		ldy #4

		Loop:

			lda PosX_LSB, x
			sta VIC.SPRITE_0_X, y

			lda TAZ.RowY, x
			sta VIC.SPRITE_0_Y, y

			lda TAZ.Frame
			clc
			adc #18
			sta SPRITE_POINTERS - 6, x

			lda Colour, x
			sta VIC.SPRITE_COLOR_1 - 7, x

			lda PosX_MSB, x
			beq NoMSB

			MSB:

				lda VIC.SPRITE_MSB
				ora VIC.MSB_On - 6, x
				sta VIC.SPRITE_MSB

				jmp EndLoop


			NoMSB:

				lda VIC.SPRITE_MSB
				and VIC.MSB_Off - 6, x
				sta VIC.SPRITE_MSB

			EndLoop:


			inx
			iny
			iny

			cpx #14
			bcc Loop

		rts
	}


	Top7: {

		lda #%11111110
		sta VIC.SPRITE_MULTICOLOR


		ldx #0
		ldy #2

		Loop:

			lda PosX_LSB, x
			sta VIC.SPRITE_0_X, y

			lda TAZ.RowY, x
			sta VIC.SPRITE_0_Y, y

			lda Pointer, x
			sta SPRITE_POINTERS + 1, x

			lda Colour, x
			sta VIC.SPRITE_COLOR_1, x

			lda PosX_MSB, x
			beq NoMSB

			MSB:

				lda VIC.SPRITE_MSB
				ora VIC.MSB_On + 1, x
				sta VIC.SPRITE_MSB

				jmp EndLoop


			NoMSB:

				lda VIC.SPRITE_MSB
				and VIC.MSB_Off + 1, x
				sta VIC.SPRITE_MSB

			EndLoop:


			inx
			iny
			iny

			cpx #7
			bcc Loop


		rts
	}


	Spawn: {

		//jsr RANDOM.Get
	///	and #%00000001

		lda #0
		sta ZP.EndID
		sta ZP.Temp3

		lda #255
		sta ZP.Temp2
	

		stx ZP.StoredXReg

		Respawn:

		lda Type, x
		beq CanSpawn

		cmp #OBJ_SCORE
		beq CanSpawn

		jmp CantAdd


		CanSpawn:

		lda Direction, x
		bne Left


		Right:

			lda #MaxX
			sta PosX_LSB, x

			lda #1
			sta PosX_MSB, x
			sta PosX_Frac, x

			jmp DoType

		Left:

			lda #MinX
			sta PosX_LSB, x

			lda #0
			sta PosX_MSB, x
			sta PosX_Frac, x

		lda ZP.Temp3
		cmp #1
		beq Food

		cmp #2
		beq Bomb

		DoType:

			jsr RANDOM.Get
			cmp #128
			bcc Food


		Bomb:

			lda #2
			sta Type, x
			sta ZP.Temp3

			lda #29
			clc
			adc Direction, x
			sta Pointer, x

			lda #RED
			sta Colour, x

			rts

		Food:

			lda #1
			sta Type, x
			sta ZP.Temp3

			lda #FoodStartPointer
			clc
			adc FoodType
			sta Pointer, x

			ldy FoodType
			lda FoodColours, y
			sta Colour, x

		jsr RANDOM.Get
		cmp #180
		bcs CantAdd

		AddMates:

			lda ZP.EndID
			cmp #2
			bcs CantAdd

			lda ZP.Temp2
			beq TryUp

			cmp #1
			beq TryDown

			inc ZP.EndID

			jsr RANDOM.Get
			and #%00000001
			sta ZP.Temp2
			beq TryUp

		TryDown:	

			cpx #2
			bcc CantAdd

			dex
			dex

			jmp Respawn


		TryUp:

			cpx #6
			bcs CantAdd

			inx
			inx

			jmp Respawn


		CantAdd:

		ldx ZP.StoredXReg

		rts
	}

	FrameUpdate: {

		jsr UpdateLives

		lda TAZ.Dead
		beq IsAlive

		rts

		IsAlive:

		ldx #0

		Loop:

			lda Type, x
			beq OkayToLaunch

			cmp #OBJ_SCORE
			beq OkayToLaunch

			jmp Moving

			OkayToLaunch:

			lda Cooldown, x
			beq ReadyToLaunch

			dec Cooldown, x
			jmp EndLoop

			ReadyToLaunch:

				jsr Spawn


				jmp EndLoop


			Moving:

				lda Direction, x
				beq GoingLeft


			GoingRight:

				lda PosX_Frac, x
				clc
				adc Speed_Frac
				sta PosX_Frac, x

				lda PosX_LSB, x
				adc #0
				sta PosX_LSB, x

				lda PosX_MSB, x
				adc #0
				sta PosX_MSB, x

				lda PosX_LSB, x
				clc
				adc Speed_Pixel
				sta PosX_LSB, x

				lda PosX_MSB, x
				adc #0
				sta PosX_MSB, x
				beq NoExitRight

				lda PosX_LSB, x
				cmp #MaxX
				bcc NoExitRight

			ExitRight:

				jsr Despawn

			NoExitRight:

				jmp EndLoop


			GoingLeft:

				lda PosX_Frac, x
				sec 
				sbc Speed_Frac
				sta PosX_Frac, x

				lda PosX_LSB, x
				sbc #0
				sta PosX_LSB, x

				lda PosX_MSB, x
				sbc #0
				sta PosX_MSB, x

				lda PosX_LSB, x
				sec
				sbc Speed_Pixel
				sta PosX_LSB, x

				lda PosX_MSB, x
				sbc #0
				sta PosX_MSB, x
				bne NoExitLeft

				lda PosX_LSB, x
				cmp #MinX
				bcs NoExitLeft

			ExitLeft:

				jsr Despawn


			NoExitLeft:


			EndLoop:

				inx
				cpx #8
				beq Finish

				jmp Loop

		Finish:





		rts
	}


	Despawn: {

		lda Type, x
		cmp #OBJ_BOMB
		beq NoNeed

		jsr RANDOM.Get
		and #%00000001
		clc
		adc #1
		sta ZP.Amount

		lda Speed_Frac
		clc
		adc ZP.Amount
		sta Speed_Frac

		lda Speed_Pixel
		adc #0
		sta Speed_Pixel

		NoNeed:

		lda #0
		sta Type, x
		sta PosX_LSB, x
		sta PosX_MSB, x

		jsr RANDOM.Get
		and #%01111111
		clc
		adc #10
		sta Cooldown, x




		rts
	}



}