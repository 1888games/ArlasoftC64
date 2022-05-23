FIRE: {


	PosX_LSB:	.byte 0
	PosX_MSB:	.byte 0
	PosY:		.byte 0


	DirectionX:	.byte 0
	DirectionY:	.byte 0



	Active:		.byte 0



	FireTimer:	.byte 255


	.label FireTime = 16
	.label FirePointer = 84






	Frame:		.byte 0

	.label Pointer = PLAYER.PlayerSprite - 1


	Initialise: {

		lda #255
		sta FireTimer

		lda #0
		sta Active
		sta PosY


		rts
	}

	Do: {

		lda Active
		beq Canfire

	CantFire:

		rts

	Canfire:

		jsr BULLET.GetFreeID
		bpl CantFire

	//	inc $d020

		stx ZP.BulletID


		lda #0
		sta DirectionX
		sta DirectionY

		GetDirection:

			ldy #1
			lda INPUT.JOY_LEFT_NOW, y
			beq NotLeft

			lda #255
			sta DirectionX

			lda #4
			sta Frame

			jmp CheckDown

		NotLeft:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda #1
			sta DirectionX

			lda #0
			sta Frame


		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq NotDown

			lda #1
			sta DirectionY

			lda #2
			clc
			adc DirectionX
			sta Frame

			jmp Exit

		NotDown:

			lda INPUT.JOY_UP_NOW, y
			beq Exit

			lda #255
			sta DirectionY

			lda #6
			clc
			adc DirectionX
			sta Frame

		Exit:

			lda DirectionX
			bne Firing

			lda DirectionY
			bne Firing

			jmp Finish

		Firing:

			lda #FireTime
			sta FireTimer

		
			lda Frame
			clc
			adc #FirePointer
			sta SpritePointer + PLAYER.PlayerSprite

			inc Active

			jsr BULLET.FirePlayer

			ldy #S_FIRE

			jsr SPEECH.StartSequence

			


		Finish:


		//	dec $d020

		rts
	}

	HandleTimer: {

		lda FireTimer
		bmi Finish

		bne NotReady

		lda #0
		sta Active


		NotReady:

		dec FireTimer
		//inc $d020

		Finish:


		rts
	}

	FrameUpdate: {

		SetDebugBorder(CYAN)
		jsr HandleTimer



		SetDebugBorder(BLACK)


		rts
	}



}