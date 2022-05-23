


INPUT: {

	* = * "Input"

	.label joyUpMask =  %00001
	.label joyDownMask = %00010
	.label joyLeftMask = %00100
	.label joyRightMask = %01000
	.label joyFireMask = %10000

	JOY_READING: 		.word $00
	PortToRead:			.byte 0

	JOY_RIGHT_LAST: 	.word $00
	JOY_LEFT_LAST:  	.word $00
	JOY_DOWN_LAST: 		.word $00
	JOY_UP_LAST:  		.word $00
	JOY_FIRE_LAST: 		.word $00

	JOY_RIGHT_NOW:  	.word $00
	JOY_LEFT_NOW:  		.word $00
	JOY_DOWN_NOW: 		.word $00
	JOY_UP_NOW:  		.word $00
	JOY_FIRE_NOW: 		.word $00

	FIRE_UP_THIS_FRAME: .word $00

	JOY_DIR_TIMES:		.fill 4, 0

	JOY_DIRECTION:		.byte 255


	ReadC64Joystick: {

		cpy #ZERO
		beq PortOne

	* = * "Joystick"

		lda $dc00
		jmp StoreReading

		PortOne:

		lda $dc01

		StoreReading:

		sta JOY_READING, y

		rts
	}


.label DIR_UP = 0
.label DIR_LEFT = 1
.label DIR_DOWN = 2
.label DIR_RIGHT = 3

	CalculateButtons: {

		ldy PortToRead

		CheckFire:

			// Check i fire held now
			lda JOY_READING, y
			and #INPUT.joyFireMask
			bne CheckFireUp

			// Fire held now
			lda #ONE
			sta JOY_FIRE_NOW, y

			jmp CheckLeft

			// Fire not held now
			CheckFireUp:

				lda JOY_FIRE_LAST, y
				sta FIRE_UP_THIS_FRAME, y

		CheckLeft:

			lda JOY_READING, y
			and #INPUT.joyLeftMask
			bne LeftUp

			lda #ONE
			sta JOY_LEFT_NOW, y

			inc JOY_DIR_TIMES + DIR_LEFT

			//jsr RANDOM.Change

			jmp CheckUp

			LeftUp:

			lda #0
			sta JOY_DIR_TIMES + DIR_LEFT

		CheckUp:

			lda JOY_READING, y
			and #INPUT.joyUpMask
			bne UpUp


			lda #ONE
			sta JOY_UP_NOW, y

			
			inc JOY_DIR_TIMES + DIR_UP


			//jsr RANDOM.Change


			jmp CheckRight
			
			UpUp:

				lda #0
				sta JOY_DIR_TIMES + DIR_UP

				

		CheckDown:

			lda JOY_READING, y
			and #INPUT.joyDownMask
			bne DownUp


			lda #ONE
			sta JOY_DOWN_NOW, y


			inc JOY_DIR_TIMES + DIR_DOWN

			//jsr RANDOM.Change

			jmp CheckRight
			
			DownUp:

			lda #0
				sta JOY_DIR_TIMES + DIR_DOWN
				

		CheckRight:

			lda JOY_READING, y
			and #INPUT.joyRightMask

			bne RightUp
			lda #ONE

			sta JOY_RIGHT_NOW, y

			inc JOY_DIR_TIMES + DIR_RIGHT

			//jsr RANDOM.Change

			jmp Finish
			
			RightUp:

				lda #0
				sta JOY_DIR_TIMES + DIR_RIGHT
				

		Finish:

			lda #255
			sta JOY_DIRECTION

			ldy #255
			sty ZP.Amount

		Loop:

			lda JOY_DIR_TIMES, y
			beq EndLoop

			cmp ZP.Amount
			bcs EndLoop

			sta ZP.Amount

			tya
			sta JOY_DIRECTION

			EndLoop:

				iny
				cpy #4
				bcc Loop




		rts
	}

	ReadJoystick: {

		dey
		sty INPUT.PortToRead

		lda INPUT.JOY_FIRE_NOW, y
		sta INPUT.JOY_FIRE_LAST, y

		lda INPUT.JOY_RIGHT_NOW, y
		sta INPUT.JOY_RIGHT_LAST, y

		lda INPUT.JOY_UP_NOW, y
		sta INPUT.JOY_UP_LAST, y

		lda INPUT.JOY_DOWN_NOW, y
		sta INPUT.JOY_DOWN_LAST, y

		lda INPUT.JOY_LEFT_NOW, y
		sta INPUT.JOY_LEFT_LAST, y
		
		lda #ZERO
		sta INPUT.JOY_FIRE_NOW, y
		sta INPUT.JOY_RIGHT_NOW, y
		sta INPUT.JOY_LEFT_NOW, y
		sta INPUT.JOY_UP_NOW, y
		sta INPUT.JOY_DOWN_NOW, y

		jsr INPUT.ReadC64Joystick
		jsr INPUT.CalculateButtons


		rts


	}


}



