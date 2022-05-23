MOUSE:{


	.label SpriteFrame = 16
	.label MouseSpriteIndex = 0




	MouseX_LSB:	.byte 160
	MouseX_MSB: .byte 0

	MouseY:		.byte 100


	MoveSpeed: .byte 3

	.label MinX = 50
	.label MaxX = 50
	.label MinY = 30
	.label MaxY = 250

	MouseFireX: .byte 0
	MouseFireY: .byte 0


	Initialise: {

		lda #16
		sta SPRITE_POINTERS

		lda #15
		sta VIC.SPRITE_COLOR_0

		rts

	}

	SetPosition: {

		lda MouseX_LSB
		sta VIC.SPRITE_0_X

		lda MouseY
		sta VIC.SPRITE_0_Y

		lda MouseX_MSB
		sta VIC.SPRITE_MSB

		rts


	}

	Update: {

		lda #ZERO
		sta MouseFireX
		sta MouseFireY

		ldy #1

		CheckLeft:
	
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda MouseX_LSB
			sec
			sbc MoveSpeed
			sta MouseX_LSB

			lda MouseX_MSB
			sbc #00
			sta MouseX_MSB

			lda MouseX_MSB
			bne CheckDown

			CheckLeftEdge:

				lda MouseX_LSB
				cmp #MinX
				bcs CheckDown

				lda #MinX
				sta MouseX_LSB

				jmp CheckDown


		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda MouseX_LSB
			clc
			adc MoveSpeed
			sta MouseX_LSB

			lda MouseX_MSB
			adc #00
			sta MouseX_MSB

			lda MouseX_MSB
			beq CheckDown

			CheckRightEdge:

				lda MouseX_LSB
				cmp #MaxX
				bcc CheckDown

				lda #MaxX
				sta MouseX_LSB

				jmp CheckDown

		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			lda MouseY
			clc
			adc MoveSpeed
			sta MouseY
			jmp CheckFire

		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq CheckFire

			lda MouseY
			sec
			sbc MoveSpeed
			sta MouseY

		CheckFire:

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq NoFire

			jsr CheckFirePosition


		NoFire:


		
		jsr SetPosition

		rts




	}


	CheckFirePosition: {


		lda MouseY
		sec
		sbc #50
		lsr
		lsr
		lsr

		sta MouseFireY

		//jsr SCORE.Set

		.label Adjust = TEMP2
		.label AddColumns = TEMP3

		lda #0
		sta Adjust

		lda #28
		sta AddColumns

		lda MouseX_MSB
		bne NoAdjust

		lda #24
		sta Adjust

		lda #0
		sta AddColumns

		NoAdjust:

		lda MouseX_LSB
		sec
		sbc Adjust

		lsr
		lsr
		lsr

		clc
		adc AddColumns

		sta MouseFireX

		//jsr SCORE.Set

		rts
	}



	



}