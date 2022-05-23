MOTHERSHIP: {

	* = * "Mothership"

	.label YPos = 38
	.label DefaultX = 160
	.label YPos2 = 59


	PosX_MSB:	.byte 0, 0
	PosX_LSB:	.byte 160, 184

	.label StartFrameID = 90
	.label FrameTime = 0
	.label MaxX = 220
	.label MinX= 29

	FrameTimer:	.byte 0
	Direction:	.byte 1




	Reset: {

		lda #DefaultX
		sta PosX_LSB

		clc
		adc #24
		sta PosX_LSB + 1

		rts

	}



	DrawSprites: {

		SetDebugBorder(7)

		ldx #StartFrameID
		stx SPRITE_POINTERS

		inx
		stx SPRITE_POINTERS + 1

		inx
		stx SPRITE_POINTERS + 2

		inx
		stx SPRITE_POINTERS + 3

		lda PosX_LSB
		sta VIC.SPRITE_0_X
		sta VIC.SPRITE_2_X

		lda PosX_LSB + 1
		sta VIC.SPRITE_1_X
		sta VIC.SPRITE_3_X

		lda #YPos
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y

		lda #YPos2
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y

		lda #ORANGE
		sta VIC.SPRITE_COLOR_0
		sta VIC.SPRITE_COLOR_1

		lda #BLUE
		sta VIC.SPRITE_MULTICOLOR_1

		lda #YELLOW
		sta VIC.SPRITE_MULTICOLOR_2

		rts
	}

	ColourBottomHalf: {

		SetDebugBorder(8)


		lda #RED
		sta VIC.SPRITE_COLOR_2
		sta VIC.SPRITE_COLOR_3

		lda #CYAN
		sta VIC.SPRITE_MULTICOLOR_1

		lda #WHITE
		sta VIC.SPRITE_MULTICOLOR_2


		rts
	}



	FrameUpdate: {


		SetDebugBorder(3)

		CheckTimer:

			lda FrameTimer
			beq Ready

			dec FrameTimer
			jmp Finish

		Ready:

			lda #FrameTime
			sta FrameTimer

			lda Direction
			beq GoingLeft

			GoingRight:	

				inc PosX_LSB
				inc PosX_LSB + 1

				lda PosX_LSB + 1
				cmp #MaxX
				bcs GoLeft

				jmp Finish

			GoLeft:

				lda #0
				sta Direction

				jmp Finish

			GoingLeft:	

				dec PosX_LSB
				dec PosX_LSB + 1

				lda PosX_LSB
				cmp #MinX
				bcc GoRight

				jmp Finish

			GoRight:

				lda #1
				sta Direction


		Finish:

		


		rts
	}








	rts
}