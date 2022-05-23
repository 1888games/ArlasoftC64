PLAYER: {

	CharX:	.byte 0
	CharY:	.byte 0

	OffsetX:	.byte 0
	OffsetY:	.byte 0

	PosX_LSB:	.byte 0
	PosX_Frac:	.byte 0
	PosX_MSB:	.byte 0

	PosY_Frac:	.byte 0
	PosY:		.byte 0

	Frame: 		.byte 0

	Side:		.byte SIDE_TOP
	Direction:	.byte DIR_LEFT


	.label StartX = 160
	.label StartY = 79
	.label StartPointer = 17

	SideLookup:			.byte 0, 4, 8, 16
	DirectionLookup:	.byte 0, 2


	Initialise: {

		lda #StartX
		sta PosX_LSB

		lda #0
		sta PosX_MSB

		lda #StartY
		sta PosY

		jsr CalculatePointer

		lda #BLUE
		sta VIC.SPRITE_COLOR_0

		jsr UpdateSprite


		rts
	}


	UpdateSprite: {

		lda PosX_LSB
		sta VIC.SPRITE_0_X

		lda PosY
		sta VIC.SPRITE_0_Y






		rts
	}



	CalculatePointer: {


		lda #StartPointer
		clc
		adc Frame

		ldx Side
		clc
		adc SideLookup, x

		ldx Direction
		clc
		adc DirectionLookup, x
		sta SPRITE_POINTERS

		rts
	}


}