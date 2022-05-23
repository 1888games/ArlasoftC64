EXPLODE: {


	Frame:		.byte 255


	Timer:	.byte 0

	.label FrameTime = 2



	Reset: {

		lda #255
		sta Frame

		lda #0
		sta VIC.SPRITE_7_Y


		lda $d01d
		ora #%10000000
		sta $d01d
		sta $d017



		rts
	}



	Setup: {


		ldx ZP.CurrentID

		lda GRID.CharX, x
		asl
		asl
		asl
		clc
		adc #14
		sta VIC.SPRITE_7_X

		lda GRID.CharY, x
		asl
		asl
		asl
		clc
		adc #48
		sta VIC.SPRITE_7_Y

		ldx ZP.CurrentID
		lda GRID.Cells, x
		tay

		lda ZP.Colour
		sta VIC.SPRITE_COLOR_7

		lda #17
		sta SPRITE_POINTERS + 7

		lda #0
		sta Frame

		lda #FrameTime
		sta Timer

		rts
	}



	FrameUpdate: {

		lda Frame
		bmi Finish


		lda Timer
		beq Ready

		dec Timer
		rts

		Ready:

			lda #FrameTime
			sta Timer

			inc Frame
			lda Frame
			cmp #10
			bcc NoEnd

		End:

			lda #255
			sta Frame

			lda #0
			sta VIC.SPRITE_7_Y

			rts

		NoEnd:

			lda #17
			clc
			adc Frame
			sta SPRITE_POINTERS + 7

		Finish:



		rts
	}





}