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

	Direction:	.byte LEFT


	.label StartX = 158
	.label StartY = 97
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
		sta SPRITE_POINTERS

		rts
	}


}
