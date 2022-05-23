CONTROL: {

	* = * "-Control"

	.label MinY = 60
	.label MaxY = 232

	.label MaxCharX = 23
	.label MinCharX = 2

	
	Reset: {


		rts
	}



	Update: {	

		lda SHIP.IsDead
		beq NotDead

		jmp Finish

		NotDead:

		ldy #1

		lda #0
		sta SHIP.MovedChars
		sta SHIP.UpdateChars

		inc SHIP.UpdateChars

		lda SHIP.CharX
		sta SHIP.PrevCharX


		CheckRight:
			
			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckLeft

		Right:

			lda SHIP.CharX
			cmp #MaxCharX
			bne Okay

			lda SHIP.OffsetX
			cmp #2
			bcs CheckFire

			Okay:

			lda SHIP.OffsetX
			cmp #3
			beq NextCharRight

			MoveRight:

				inc SHIP.OffsetX
				inc SHIP.UpdateChars
				jmp CheckFire

			NextCharRight:

				lda SHIP.CharX
				cmp #MaxCharX
				beq CheckFire

				inc SHIP.CharX
				inc SHIP.UpdateChars
				inc SHIP.MovedChars
				lda #0
				sta SHIP.OffsetX
				jmp CheckFire

		CheckLeft:
			
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckFire

		Left:

			lda SHIP.CharX
			cmp #MinCharX
			beq CheckFire

			lda SHIP.OffsetX
			beq NextCharLeft

			MoveLeft:

				dec SHIP.OffsetX
				inc SHIP.UpdateChars
				jmp CheckFire

			NextCharLeft:

	
				lda SHIP.CharX
				cmp #MinCharX
				beq CheckFire

				dec SHIP.CharX
				inc SHIP.UpdateChars
				inc SHIP.MovedChars
				lda #3
				sta SHIP.OffsetX
				jmp CheckFire


		CheckFire:

			lda INPUT.JOY_FIRE_NOW, y
			beq Finish

			jsr SHIP.FireBullet


		Finish:
	

		rts




	}






}