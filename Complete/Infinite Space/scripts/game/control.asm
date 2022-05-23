CONTROL: {

	CursorMode:			.byte 0, 0

	.label MinY = 60
	.label MaxY = 232

	
	Reset: {


		rts
	}



	Update: {	


		ldy #1

		lda SHIP.IsDying
		bne Finish

		CheckUp:
			
			lda INPUT.JOY_UP_NOW, y
			beq CheckDown

		Up:

			lda SHIP.PosY
			cmp #MinY
			bcc CheckLeft

			dec SHIP.PosY
			dec SHIP.PosY

			jmp CheckLeft

		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckLeft


		Down:

			lda SHIP.PosY
			cmp #MaxY
			bcs CheckLeft

			inc SHIP.PosY
			inc SHIP.PosY


		CheckLeft:





		CheckFire:

			lda INPUT.JOY_FIRE_NOW, y
			beq Finish

			lda SHIP.BulletX_LSB
			clc
			adc SHIP.BulletX_MSB
			beq FireBullet

			jmp Finish


			FireBullet:

				lda SHIP.PosX_LSB
				//sec
				//sbc #3
				sta SHIP.BulletX_LSB

				lda SHIP.PosY
				clc
				adc #5
				sta SHIP.BulletY

				sfx(SFX_FIRE)


		Finish:
	

		rts




	}






}