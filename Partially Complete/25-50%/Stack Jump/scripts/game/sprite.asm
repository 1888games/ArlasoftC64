SPRITE:{





	PosY:	.byte 0

	.label UsualYPosition = 170
	.label UsualXPosition = 174
	.label CanJumpAgainFrame = 9
	

	CurrentFrame:	.byte 16

	JumpSpeeds:		.byte 04, 03, 02, 01, 00, 01, 02, 03, 01, 00, 00, 00, 00, 00, 00, 00, 99
	JumpTimes:		.byte 02, 02, 03, 04, 05, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 99
	JumpFrames:		.byte 00, 01, 02, 03, 04, 05, 06, 07, 08, 08, 09, 10, 11, 12, 13, 00, 99
	JumpDirections:	.byte 00, 00, 00, 00, 00, 01, 01, 01, 01, 00, 00, 00, 00, 00, 00, 00, 99

	JumpSequenceID: .byte 0
	JumpTimer:	.byte 0
	JumpDirection: .byte 0

	IsJumping:	.byte 0
	JumpSpeed:	.byte 0
	CanJump:	.byte 1


	Reset: {

		lda #LIGHT_RED
		sta VIC.SPRITE_MULTICOLOR_1 

		lda #RED
		sta VIC.SPRITE_MULTICOLOR_2

		lda CurrentFrame
		sta SPRITE_POINTERS

		lda #UsualYPosition
		sta PosY

		lda #UsualXPosition
		sta VIC.SPRITE_0_X

		lda #UsualYPosition
		sta VIC.SPRITE_0_Y

	//	jsr Jump

		rts
	}

	Update: {

		ldy #1

		lda INPUT.JOY_FIRE_NOW, y
		beq NoFire


		lda INPUT.JOY_FIRE_LAST, y
		bne NoFire

		jsr Jump

		NoFire:

		lda IsJumping
		beq Draw


		lda JumpTimer
		beq NextSequence

		dec JumpTimer
		jmp UpdatePosition

		NextSequence:

			jsr NextJumpSequence

		lda IsJumping
		beq Draw
		
		UpdatePosition:

			lda JumpDirection
			beq GoingUp

		GoingDown:

			lda PosY
			clc
			adc JumpSpeed
			sta PosY
			jmp Draw


		GoingUp:

			lda PosY
			sec
			sbc JumpSpeed
			sta PosY
			
		Draw:

		lda CurrentFrame
		sta SPRITE_POINTERS

		lda #UsualXPosition
		sta VIC.SPRITE_0_X

		lda PosY
		sta VIC.SPRITE_0_Y




		rts
	}



	NextJumpSequence: {

		ldx JumpSequenceID

		lda JumpSpeeds, x
	

		cmp #99
		bne StillJumping

		lda #0
		sta IsJumping
		jmp Finish


		StillJumping:

			sta JumpSpeed

			lda JumpTimes, x
			sta JumpTimer

		//	lda #8
			//sta JumpTimer

			lda JumpDirections, x
			sta JumpDirection

			lda JumpFrames, x
			clc
			adc #16
			sta CurrentFrame

			inc JumpSequenceID

			lda JumpSequenceID

			cmp #CanJumpAgainFrame
			bcc Finish

			lda #1
			sta CanJump

			lda #0
			sta PLATFORM.Active

			lda #1
			sta SCROLLER.Active


			//lda #14
		//	sta PLATFORM.CurrentRow

		//	/jsr PLATFORM.Generate



		Finish:

		rts
	}

	Jump: {

		lda CanJump
		beq Finish

		lda #1
		sta IsJumping

		lda #0
		sta JumpSequenceID
		sta CanJump

		jsr NextJumpSequence




		Finish:


		rts
	}

}