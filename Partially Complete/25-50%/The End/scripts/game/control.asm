CONTROL: {

	* = * "-Control"

	.label MinY = 60
	.label MaxY = 232

	.label MaxX = 220
	.label MinX = 29

	MoveSpeed:	.byte 3

	
	Reset: {


		rts
	}



	Update: {	

		SetDebugBorder(1)

		lda #0
		beq NotDead

		jmp Finish

		NotDead:

		ldy #1

		CheckRight:
			
			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckLeft

		Right:

			lda PLAYER.PosX
			clc
			adc MoveSpeed
			sta PLAYER.PosX

			cmp #MaxX
			bcc CheckFire

			lda #MaxX
			sta PLAYER.PosX
			
			jmp CheckFire

		CheckLeft:
			
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckFire

		Left:

			lda PLAYER.PosX
			sec
			sbc MoveSpeed
			sta PLAYER.PosX

			cmp #MinX
			bcs CheckFire

			lda #MinX
			sta PLAYER.PosX


		CheckFire:

			lda INPUT.JOY_FIRE_NOW, y
			beq Finish

			jsr PLAYER.Fire


		Finish:
	

		rts




	}






}