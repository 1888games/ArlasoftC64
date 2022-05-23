
.label LEFT = 0
.label RIGHT = 1
.label DOWN = 2
.label UP = 3
.label YStart = 49


PLAYER: {

	PosY:		.byte 0
	PosY_Frac:	.byte 0
	TargetY:	.byte 0
	Row:		.byte 0
	Cooldown:	.byte 0
	TargetRow:	.byte 0

	Score_M:	.byte 0
	Score_L:	.byte 0

	CarriedDish:	.byte 255


	
	.label SecondSpriteOffset = 4
	.label XPosition = 255

	.label PixelMove = 3
	.label FracMove = 100
	.label FrameTime = 6

	YPositions:		.fill 6, YStart + (32 * i)


	Direction:		.byte LEFT

	StartPointer:	.byte 25, 26, 23, 24
	SpriteNumbers:	.byte 6, 6, 6, 0

	CurrentPointer:	.byte 0

	SpriteNumber:	.byte 0
	FrameTimer:		.byte 0

	FaceRightTime:	.byte 0

	Debounce:		.byte 0

	DeadTimer:		.byte 0

	DishOffsetsX:	.byte -13, 10, 0, 0
	DishOffsetsY:	.byte 10, 16, 16, 4

	SoundDelay:		.byte 255
	SoundID:		.byte 0


	NewGame: {

		lda #YStart
		sta PosY
		sta TargetY

		lda #127
		sta PosY_Frac
		sta Direction

		lda #255
		sta CarriedDish
		sta SoundDelay

		lda #LIGHT_RED
		sta VIC.SPRITE_COLOR_0
		sta VIC.SPRITE_COLOR_1
		sta VIC.SPRITE_COLOR_6
		sta VIC.SPRITE_COLOR_7
		
		lda #255
		sta VIC.SPRITE_0_X
		sta VIC.SPRITE_1_X
		sta VIC.SPRITE_6_X
		sta VIC.SPRITE_7_X

		lda #2
		sta Row
		sta TargetRow
		sta Debounce

		lda #150
		sta DeadTimer

		ldx Row
		lda YPositions, x
		sta PosY
		sta TargetY


		ldx #LEFT
		jsr ChangeDirection
		jsr UpdateSprite

	

		rts
	}




	Dead: {


		lda DeadTimer
		beq Ready


		dec DeadTimer

		cmp #90
		bcc NoShake


		ShakeScreen:

			jsr RANDOM.Get
			and #%00000111
			sta ZP.Amount

			lda $d016
			and #%11111000
			ora ZP.Amount
			sta $d016

			lda $d011
			and #%11111000
			ora ZP.Amount
			sta $d011

			rts

		NoShake:

			lda $d016
			and #%11111000
			sta $d016

			lda $d011
			and #%11111000
			ora #%00000011
			sta $d011

		Ready:

			jmp GameOver





		rts
	}

	FiredText:		.byte 92, 93, 94, 95, 96, 97, 32, 98, 99, 96, 97, 100, 101

	GameOver: {

		lda #GAME_MODE_OVER
		sta MAIN.GameMode

		jsr $21F9

		jsr UTILITY.ClearScreen

		jsr SCORE.DrawP1
		jsr SCORE.DrawBest

		lda #0
		sta VIC.SPRITE_ENABLE

		lda #120
		sta MAIN.GameOverTimer

		lda #0
		sta $d021

		Text:

			ldx #14
			ldy #11
			jsr PLOT.GetCharacter

			ldy #0

			jsr RANDOM.Get
			and #%00000111
			clc
			adc #8
			sta ZP.Colour
			bne Loop

			inc ZP.Colour

		Loop:

			lda FiredText, y
			sta (ZP.ScreenAddress),y 

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			iny
			cpy #13
			bcc Loop

		rts
	}


	ChangeDirection: {

		cpx Direction
		beq Finish

		stx Direction

		lda StartPointer, x
		sta CurrentPointer

		lda SpriteNumbers, x
		sta SpriteNumber

		lda #FrameTime
		sta FrameTimer

		lda #16
		sta SPRITE_POINTERS
		sta SPRITE_POINTERS + 1
		sta SPRITE_POINTERS + 6
		sta SPRITE_POINTERS + 7


		Finish:


		rts
	}


	HandleMove: {

		lda PosY
		cmp TargetY
		bne NeedMove

		rts


		NeedMove:

		bcc MoveDown

		MoveUp:

			lda PosY_Frac
			sec
			sbc #FracMove
			sta PosY_Frac

			lda PosY
			sbc #PixelMove
			sta PosY

			cmp TargetY
			bcs Finish

			lda TargetY
			sta PosY

			jmp Finish


		MoveDown:


			lda PosY_Frac
			clc
			adc #FracMove
			sta PosY_Frac

			lda PosY
			adc #PixelMove
			sta PosY

			cmp TargetY
			bcc Finish

			lda TargetY
			sta PosY

			
		Finish:

			lda TargetY
			cmp PosY
			bne NotYet


			lda TargetRow
			sta Row


		NotYet:


		rts
	}


	DoScore: {

		lda Row
		cmp CarriedDish
		beq Correct

		lda #SFX_WRONG
		sta SoundID

		lda #15
		sta SoundDelay
		

		rts


	Correct:


		lda #SFX_CORRECT
		sta SoundID

		lda #15
		sta SoundDelay

		lda Score_L
		sta SCORE.ScoreL

		lda Score_M
		sta SCORE.ScoreM

		ldy #0
		jsr SCORE.AddScore




		rts
	}

	Control: {

		CheckStill:

			lda PosY
			cmp TargetY
			beq CanControl

			rts

		CanControl:

			lda FaceRightTime
			beq NotThrowing

			dec FaceRightTime

			lda FaceRightTime
			bne NotFinishedThrowing

			jsr DoScore

			lda #255
			sta CarriedDish
			sta VIC.SPRITE_5_Y

		NotFinishedThrowing:

			rts

		NotThrowing:

			ldy #1

		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq CheckDown

			lda Row
			beq CheckRight

			sec
			sbc #1
			sta TargetRow

			ldx #UP
			jsr ChangeDirection

			jmp CheckTarget


		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckRight

			lda Row
			cmp #5
			beq CheckRight

			clc
			adc #1
			sta TargetRow

			ldx #DOWN
			jsr ChangeDirection

			jmp CheckTarget


		CheckRight:

			lda CarriedDish
			bmi Finish

			lda INPUT.JOY_RIGHT_NOW, y
			beq Finish

			jsr ThrowDish
			

		Finish:




		rts
	}

	ThrowDish: {

		lda #SFX_THROW
		jsr MAIN.PlayChannel2

		ldx #RIGHT
		jsr ChangeDirection

		jsr UpdateCarried

		lda #8
		sta FaceRightTime

		lda VIC.SPRITE_5_Y
		sec
		sbc #10
		sta VIC.SPRITE_5_Y


		rts
	}


	UpdateSprite: {

		ldy SpriteNumber

		lda CurrentPointer
		sta SPRITE_POINTERS, y

		clc
		adc #SecondSpriteOffset
		sta SPRITE_POINTERS + 1, y

		tya
		asl
		tay

		
		lda PosY
		sta VIC.SPRITE_0_Y, y
		clc
		adc #21
		sta VIC.SPRITE_1_Y, y





		rts
	}


	CheckTarget: {


		ldx TargetRow
		cmp Row
		beq Finish

		lda YPositions, x
		sta TargetY


		Finish:




		rts
	}


	CheckLeft: {

		lda FaceRightTime
		bne DontFaceLeft

		lda TargetRow
		cmp Row
		bne DontFaceLeft

		ldx #LEFT
		jsr ChangeDirection


		DontFaceLeft:






		rts
	}




	CheckFire: {

		lda Debounce
		beq Ready

		dec Debounce
		rts


		Ready:

		lda Row
		cmp TargetRow
		bne Finish

		ldy #1

		lda INPUT.JOY_FIRE_NOW, y
		beq Finish

		ldx Row
		jsr BELT.PauseBelt

		lda #5
		sta Debounce





		Finish:




		rts
	}


	FrameUpdate: {

		
		jsr HandleMove
		jsr Control
	
		jsr CheckLeft
		jsr CheckFire	

		jsr UpdateCarried
		jsr UpdateSprite

		jsr CheckSound

		rts
	}


	CheckSound: {

		lda SoundDelay
		bmi Finish

		beq Ready

		dec SoundDelay
		rts

		Ready:

		lda SoundID
		jsr MAIN.PlayChannel2

		dec SoundDelay

		Finish:



		rts
	}


	Throwing: {

		lda VIC.SPRITE_5_X
		clc
		adc #8
		sta VIC.SPRITE_5_X

		rts
	}


	UpdateCarried: {

		lda CarriedDish
		bmi Finish

		lda FaceRightTime
		beq Carrying

		jmp Throwing

		Carrying:

			lda Score_L
			clc
			adc Score_M
			beq NoDecrease

			sed

			lda Score_L
			sec
			sbc #1
			sta Score_L

			lda Score_M
			sbc #0
			sta Score_M

			cld

		NoDecrease:

			lda VIC.SPRITE_MSB
			and #%11011111
			sta VIC.SPRITE_MSB

			ldx Direction

			lda VIC.SPRITE_0_X
			clc
			adc DishOffsetsX, x
			sta VIC.SPRITE_5_X
			bmi NoMSB

			lda VIC.SPRITE_MSB
			ora #%00100000
			sta VIC.SPRITE_MSB

		NoMSB:

			lda PosY
			clc
			adc DishOffsetsY, x
			sta VIC.SPRITE_5_Y


		Finish:


		rts
	}




}