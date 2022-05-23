TAZ: {


	FrameTimer:		.byte 0
	Frame:			.byte 0

	.label FrameTime = 6

	PosX_MSB:	.byte 0
	PosX_LSB:	.byte 0
	PosY:		.byte 0
	Row:		.byte 3

	.label StartY = 80
	.label VerticalTime = 4
	.label ScoreStartPointer = 31



	RowY:		.fill 8, StartY + (i * 16)
				.fill 6, 222

	Active:		.byte 1
	Dead:		.byte 0

	VerticalTimer:	.byte 0
	DeadTimer:		.byte 0

	.label Speed = 4
	.label MinX = 68
	.label MaxX = 18	
	.label DeadTime = 40

	ScoreColours:	.byte PURPLE, YELLOW, CYAN, LIGHT_RED, LIGHT_GREEN, LIGHT_BLUE



	InitialiseGame: {

		lda #3
		sta Row

		lda #174
		sta PosX_LSB

		lda #0
		sta PosX_MSB

		lda #YELLOW
		sta VIC.SPRITE_COLOR_0

		lda #0
		sta Dead


		rts
	}



	UpdateFrame: {

		lda FrameTimer
		beq Ready

		dec FrameTimer
		rts


		Ready:

			lda Frame
			eor #%00000001
			sta Frame

			lda #FrameTime
			sta FrameTimer


		rts
	}


	Control: {

		lda Active
		bne Okay

		rts

		Okay:

			ldy #1

		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda PosX_LSB
			sec
			sbc #Speed
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB

			bne NoWrap

			lda PosX_LSB
			cmp #MinX
			bcs NoWrap

			lda #MinX
			sta PosX_LSB

			NoWrap:


		CheckRight:


			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda PosX_LSB
			clc
			adc #Speed
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB

			beq CheckDown

			lda PosX_LSB
			cmp #MaxX
			bcc NoWrapRight

			lda #MaxX
			sta PosX_LSB

			NoWrapRight:


		CheckDown:

			lda VerticalTimer
			beq Ready

			dec VerticalTimer
			rts

			Ready:

			lda Row
			cmp #7
			bcs CheckUp 

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			inc Row

			lda #VerticalTime
			sta VerticalTimer
			rts

		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq Finish

			lda Row
			beq Finish
		
			dec Row


			lda #VerticalTime
			sta VerticalTimer
			
		
		Finish:

			
			rts

	}

	Collisions: {

		ldx Row

		CheckSolid:

			lda OBJECTS.Type, x
			cmp #OBJ_SCORE
			beq Finish

		CheckX:
			
			lda OBJECTS.PosX_MSB, x
			sec
			sbc PosX_MSB
			bne Finish

			lda OBJECTS.PosX_LSB, x
			//clc
			//adc #3
			sec
			sbc PosX_LSB
			clc
			adc #9
			cmp #18
			bcs Finish

		Hit:

			lda OBJECTS.Type, x
			cmp #OBJ_BOMB
			beq Killed

			jmp Eat

		Killed:

			jmp Die

		Finish:


		rts
	}

	Eat: {

		lda #OBJ_SCORE
		sta OBJECTS.Type, x

		ldy OBJECTS.ScoreLevel
		lda ScoreColours, y
		sta OBJECTS.Colour, x

		lda #ScoreStartPointer
		clc
		adc OBJECTS.ScoreLevel
		sta OBJECTS.Pointer, x

		jsr RANDOM.Get
		sta OBJECTS.Cooldown, x

		jsr OBJECTS.EatFood

		rts
	}


	Die: {

		jsr SOUND.Dead

		lda #1
		sta Dead

		lda #%00000001
		sta $d01d

		lda PosX_LSB
		sec
		sbc #10
		sta PosX_LSB

		lda PosX_MSB
		sbc #0
		sta PosX_MSB


		lda #DeadTime
		sta DeadTimer


		rts
	}

	UpdateSprite: {

		ldx Row
		lda RowY, x
		sta VIC.SPRITE_0_Y

		lda PosX_LSB
		sta VIC.SPRITE_0_X

		lda PosX_MSB
		beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora #%00000001
			sta VIC.SPRITE_MSB
			jmp DoneMSB

		NoMSB:


			lda VIC.SPRITE_MSB
			and #%11111110
			sta VIC.SPRITE_MSB

		DoneMSB:

			lda #18
			clc
			adc Frame
			sta SPRITE_POINTERS



		rts
	}

	HandleDead: {


		lda DeadTimer
		beq Ready

		dec DeadTimer
		rts

		Ready:

			inc Dead
			
			lda Dead
			cmp #3
			bcc Continue

			jsr OBJECTS.LoseLife

			lda OBJECTS.LivesLeft
			beq GameOver

			jsr InitialiseGame
			jsr OBJECTS.ResetDead
			rts

		Continue:

			lda #0
			sta $d01d

			lda PosX_LSB
			clc
			adc #10
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB

			lda #DeadTime
			sta DeadTimer
			rts


		GameOver:

			jsr SOUND.GameOver

			lda #GAME_MODE_OVER
			sta MAIN.GameMode

			lda #100
			sta MAIN.GameOverTimer


		rts
	}

	FrameUpdate: {

		lda Dead
		beq NotDead

			jsr HandleDead
			jmp IsDead


		NotDead:

			jsr Control
			jsr Collisions

		IsDead:

			jsr UpdateSprite
			jsr UpdateFrame
		

		rts
	}
}