CONTROL: {

	CursorMode:			.byte 0, 0
	
	Reset: {


		
		rts
	}



	Update: {	

		rts

		ldy #1


		CheckFire:	

			lda INPUT.JOY_FIRE_NOW, y
			beq CheckLeft

			lda INPUT.JOY_LEFT_LAST, y
			bne CheckLeft

			jsr MAP.Teleport


		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda INPUT.JOY_LEFT_LAST, y
			bne CheckDown

			jsr MAP.MoveLeft

		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda INPUT.JOY_RIGHT_LAST, y
			bne CheckDown

			jsr MAP.MoveRight


		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			lda INPUT.JOY_DOWN_LAST, y
			bne Finish

			jsr MAP.MoveDown

		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq Finish

			lda INPUT.JOY_UP_LAST, y
			bne Finish

			jsr MAP.MoveUp
		
		Finish:
	

		rts




	}


	



}