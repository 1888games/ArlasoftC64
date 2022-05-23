MOUTH: {


	Frame:			.byte 0

	Pointers:		.byte 63, 64, 65, 66, 65, 64
	Direction:		.byte 0
	DirectionAdd:	.byte 0, 4
	FrameTimer:		.byte 0

	PosX_LSB:		.byte 0
	PosX_MSB:		.byte 0
	PosY:			.byte 0
	Active:			.byte 0

	PicklesEaten:	.byte 0


	.label MinX = 85
	.label MaxX = 55

	.label FrameTime = 2

	.label SpeedFrac = 4
	.label Speed = 4

	.label StartY = 172
	.label StartX = 248

	.label MaxY = 208
	.label MinY = 108



	NewGame: {

		lda #0
		sta PicklesEaten

		rts
	}

	Initialise: {

		lda #StartY
		sta PosY
		sta VIC.SPRITE_7_Y

		lda #0
		sta PosX_MSB
		sta Direction

		lda #%00000000
		sta VIC.SPRITE_MSB

		lda #StartX
		sta PosX_LSB
		sta VIC.SPRITE_7_X

		lda #PURPLE
		sta VIC.SPRITE_COLOR_7

		lda Pointers
		sta SPRITE_POINTERS + 7

		lda #1
		sta Active

		rts
	}



	
	Control: {

		lda Active
		bne Okay

		rts

		Okay:

			ldy #1

		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda #0
			sta Direction

			lda PosX_LSB
			sec
			sbc #Speed
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB

			bne NoWrap

			lda PosX_LSB
			cmp #MinX
			bcs NoWrap

			lda #MinX
			sta PosX_LSB

			NoWrap:


		CheckRight:


			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda #1
			sta Direction

			lda PosX_LSB
			clc
			adc #Speed
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB

			beq CheckDown

			lda PosX_LSB
			cmp #MaxX
			bcc NoWrapRight

			lda #MaxX
			sta PosX_LSB

			NoWrapRight:


		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			lda PosY
			clc
			adc #Speed
			sta PosY
	
			cmp #MaxY
			bcc NoWrapDown

			lda #MaxY
			sta PosY

		NoWrapDown:

		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq Finish

			lda PosY
			sec
			sbc #Speed
			sta PosY

	
			cmp #MinY
			bcs Finish

			lda #MinY
			sta PosY
		
		Finish:

			
			rts

	}


	CheckFrame: {

		lda FrameTimer
		beq Ready

		dec FrameTimer
		rts


		Ready:

		lda #FrameTime
		sta FrameTimer

		inc Frame

		lda Frame
		cmp #6
		bcc Okay

		lda #0
		sta Frame

		Okay:

		rts
	}

	.label PICK_COLUMN = 12
	.label PICK_ROW = 3

	DrawPickles: {

		ldx #PICK_COLUMN
		ldy #PICK_ROW

		jsr PLOT.GetCharacter

		lda #PURPLE
		sta ZP.Colour

		ldx #0
		ldy #0

		Loop:

			cpx PicklesEaten
			bcc DrawPickles

			ClearPickle:

				lda #BLACK
				sta ZP.Colour

			DrawPickles:	

				lda ZP.Colour
				sta (ZP.ColourAddress), y
				iny
				sta (ZP.ColourAddress), y

				tya
				clc
				adc #39
				tay

				lda ZP.Colour
				sta (ZP.ColourAddress), y

				iny
				sta (ZP.ColourAddress), y


				tya
				sec
				sbc #39
				tay

			EndLoop:

				inx
				cpx #6
				bcc Loop


		rts





	}


	UpdateSprite: {

		ldx Frame
		lda Pointers, x
		sta ZP.Amount

		ldx Direction
		lda DirectionAdd, x
		clc
		adc ZP.Amount
		sta SPRITE_POINTERS + 7

		lda PosX_LSB
		sta VIC.SPRITE_7_X

		lda PosY
		sta VIC.SPRITE_7_Y

		lda PosX_MSB
		beq NoMSB


		MSB:

			lda VIC.SPRITE_MSB
			ora #%10000000
			sta VIC.SPRITE_MSB
			jmp MSB_Done

		NoMSB:

			lda VIC.SPRITE_MSB
			and #%01111111
			sta VIC.SPRITE_MSB

		MSB_Done:


		rts
	}


	FrameUpdate: {


		jsr Control
		jsr CheckFrame
		jsr UpdateSprite

		jsr DrawPickles




		rts
	}


	
}