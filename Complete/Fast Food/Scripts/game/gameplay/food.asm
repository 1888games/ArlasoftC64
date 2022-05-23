FOOD: {


	.label MAX_FOOD = 3

	PosX_MSB:	.fill MAX_FOOD, 0
	PosX_LSB:	.fill MAX_FOOD, 0
	PosX_Frac:	.fill MAX_FOOD, 0
	FType:		.fill MAX_FOOD, 0
	PosY:		.fill MAX_FOOD, 0

	SpeedMult:	.fill MAX_FOOD, 0
	Active:		.fill MAX_FOOD, 0


	SpeedPixel:	.byte 3
	SpeedFrac:	.byte 0

	SpeedPixel_High:	.byte 3
	SpeedFrac_High:		.byte 160

	SpeedPixel_Low:		.byte 2
	SpeedFrac_Low:		.byte 100

	FoodEaten:		.byte 0
	MaxFood:		.byte 0
	GettingFatter:	.byte 0

	.label NumberForFatter = 30
	.label LowIncrease = 250
	.label HighIncrease = 100
	.label HighIncreasePixel = 1
	.label SpawnX = 50
	.label PicklePointer = 18
	.label FoodPointerStart = 19
	.label DespawnX = 72

	Colours:	.byte GREEN, CYAN, PURPLE, RED, BROWN, RED, RED, YELLOW, WHITE, CYAN, ORANGE, YELLOW

	NewGame: {

		lda #2
		sta SpeedPixel_Low

		lda #64
		sta SpeedFrac_Low

		lda #3
		sta SpeedPixel_High

		lda #128
		sta SpeedFrac_High



		rts
	}

	Initialise: {

		ldx #1
		stx MaxFood

		ldx #0
		stx FoodEaten
		stx GettingFatter
		stx Active
		stx Active + 1
		stx Active + 2
		stx FType
		stx FType + 1
		stx FType + 2
		stx PosX_LSB
		stx PosX_LSB + 1
		stx PosX_LSB + 2

 



		jsr Spawn


		rts
	}

	LevelUp: {

		lda SpeedFrac_Low
		clc
		adc #LowIncrease
		sta SpeedFrac_Low

		lda SpeedPixel_Low
		adc #0
		sta SpeedPixel_Low

		lda SpeedFrac_High
		clc
		adc #HighIncrease
		sta SpeedFrac_High

		lda SpeedPixel_High
		adc #0
		sta SpeedPixel_High

		lda SpeedPixel_High
		clc
		adc #HighIncreasePixel
		sta SpeedPixel_High


		rts
	}

	Spawn: {

		lda GettingFatter
		beq CanSpawn

		rts

		CanSpawn:

		stx ZP.StoredXReg
		txa
		asl
		tay

		YPosition:

			Again:

			jsr RANDOM.Get
			and #%01111111
			cmp #100
			bcs Again

			clc
			adc #MOUTH.MinY
			sta ZP.Amount

			
			ldx #0

			CheckLoop:

				cpx ZP.StoredXReg
				beq EndCheckLoop

				lda PosY, x
				sec
				sbc ZP.Amount
				clc 
				adc #21
				cmp #42
				bcc Again

				EndCheckLoop:

				inx
				cpx #MAX_FOOD
				bcc CheckLoop


			ldx ZP.StoredXReg
			lda ZP.Amount
			//sta VIC.SPRITE_1_Y, y
			sta PosY, x

		XPosition:

			lda #SpawnX
			sta PosX_LSB, x
			//sta VIC.SPRITE_1_X, y

			lda #0
			sta PosX_MSB, x
			sta PosX_Frac, x

			lda #1
			sta Active, x
			sta SpeedMult, x

		Speed:

			jsr RANDOM.Get
			and #%00000111
			cmp #5
			bcc SingleSpeed

			inc SpeedMult, x

			SingleSpeed:

		FoodType:

			jsr RANDOM.Get
			cmp #100
			bcc PurplePickle

		Food:

			jsr RANDOM.Get

			and #%00001111
			cmp #12
			bcs Food


		//	.break

			sta FType, x
			tay
			clc
			adc #FoodPointerStart
			sta SPRITE_POINTERS + 1, x


		
			lda Colours, y
			sta VIC.SPRITE_COLOR_1, x
			jmp Done

		PurplePickle:

			//.break

			lda #255
			sta FType, x

			lda #PicklePointer
			sta SPRITE_POINTERS + 1, x

			lda #PURPLE
			sta VIC.SPRITE_COLOR_1, x


		Done:

		rts
	}


	UpdateFood: {

		lda SpeedMult, x
		cmp #1
		beq Low

		lda SpeedPixel_High
		sta SpeedPixel

		lda SpeedFrac_High
		sta SpeedFrac

		jmp DoneSpeed


		Low:

		lda SpeedPixel_Low
		sta SpeedPixel


		lda SpeedFrac_Low
		sta SpeedFrac

		DoneSpeed:

		ldy #0

		UpdateLoop:

			lda PosX_Frac, x
			clc
			adc SpeedFrac
			sta PosX_Frac, x

			lda PosX_LSB, x
			adc #0
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x

			lda PosX_LSB, x
			clc
			adc SpeedPixel
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x

			cmp #0
			beq NoDespawn	

			lda PosX_LSB, x
			cmp #DespawnX
			bcc NoDespawn


			jsr Despawn

		
		
			NoDespawn:


		rts
	}

	Despawn: {


		inc MaxFood

		lda MaxFood
		cmp #MAX_FOOD + 1
		bcc OkayMax

		lda #3
		sta MaxFood

		OkayMax:

		lda #0
		sta Active, x
		sta PosX_LSB, x
		sta PosX_MSB, x
		sta PosY, x



		rts
	}

	UpdateSprite: {

		txa
		asl
		tay

		lda PosX_LSB, x
		sta VIC.SPRITE_1_X, y

		lda PosY, x
		sta VIC.SPRITE_1_Y, y

		lda PosX_MSB, x
		beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + 1, x
			sta VIC.SPRITE_MSB

			jmp MSB_Done

		NoMSB:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 1, x
			sta VIC.SPRITE_MSB

		MSB_Done:

		rts
	}

	EatFood: {


		lda FType, x
		bmi AtePickle

		sta ZP.Temp3

		jsr SOUND.Eat

		ldy ZP.Temp3

		lda SpeedMult, x
		cmp #1
		beq NoDouble

		tya
		clc
		adc #12
		tay

		NoDouble:
		
		jsr SCORE.AddScore

		ldx ZP.StoredYReg

		inc FoodEaten

		lda FoodEaten
		cmp #NumberForFatter
		bcc Done

		Fatter:

			lda #1
			sta GettingFatter
			jmp Done

		AtePickle:

			jsr SOUND.Pickle

			inc MOUTH.PicklesEaten

			lda MOUTH.PicklesEaten
			cmp #6
			bcc Done

			jsr BURP.Initialise

		Done:


		ldx ZP.StoredYReg
		jsr Despawn

	




		Finish:



		rts
	}


	CheckCollision: {

		lda Active, x
		beq Finish


		lda MOUTH.PosY
		sec
		sbc PosY, x
		clc
		adc #12
		cmp #24
		bcs Finish

		lda MOUTH.PosX_MSB
		cmp PosX_MSB, x
		bne Finish

		lda MOUTH.PosX_LSB
		sec
		sbc PosX_LSB, x
		clc
		adc #12
		cmp #24
		bcs Finish



		jsr EatFood


		Finish:



		rts
	}

	CheckFatter: {

		lda GettingFatter
		beq Finish

		lda Active
		clc
		adc Active + 1
		clc
		adc Active + 2
		bne Finish



		jsr INTER.Initialise

		Finish:




		rts
	}
	FrameUpdate: {

		lda MOUTH.Active
		beq Finish

		ldx #0

		Loop:

			stx ZP.StoredYReg

			lda Active, x
			beq SpawnNew

			bmi EndLoop

			jsr UpdateFood
			jsr CheckCollision

			jsr UpdateSprite
			
			jmp EndLoop


			SpawnNew:

				jsr Spawn

			EndLoop:

				ldx ZP.StoredYReg

				inx
				cpx MaxFood
				bcc Loop


		jsr CheckFatter

		Finish:

		rts
	}
}