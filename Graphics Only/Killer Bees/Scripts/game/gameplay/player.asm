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
	.label UpdateTime = 3

	SideLookup:			.byte 0, 4, 8, 16
	DirectionLookup:	.byte 0, 2

	UpdateTimer:		.byte 0



	Bytes:			.byte %00000011
					.byte %00000110
					.byte %00001100
					.byte %00011000
					.byte %00110000
					.byte %01100000
					.byte %11000000
					.byte %00011000

	BytePositions:	.byte 0, 1, 3, 4, 6, 7, 9, 10
					.byte 12, 13, 15, 16, 18, 19, 21, 22
					.byte 24, 25, 27, 28, 30, 31, 33, 34
					.byte 36, 37, 39, 40, 42, 43, 45, 46

	SwarmSize:			.byte 12

	.label SWARM_POINTER = $C400 + 64


	Initialise: {

		lda #StartX
		sta PosX_LSB

		lda #0
		sta PosX_MSB

		lda #StartY
		sta PosY

		jsr CalculatePointer

		lda #17
		sta SPRITE_POINTERS

		lda #WHITE
		sta VIC.SPRITE_COLOR_0

		jsr UpdateSprite

		jsr PopulateSprite


		rts
	}


	PopulateSprite: {


		lda #<SWARM_POINTER
		sta ZP.TextAddress

		lda #>SWARM_POINTER
		sta ZP.TextAddress + 1

		ldx #0

		ClearLoop:

			lda BytePositions, x
			tay

			lda #0
			sta (ZP.TextAddress), y

			inx
			cpx #32
			bcc ClearLoop

		ldx #0

		Loop:

			jsr RANDOM.Get
			and #%00000111
			tay
			lda Bytes, y
			sta ZP.Amount

			jsr RANDOM.Get
			and #%00011111
			tay
			lda BytePositions, y
			tay

			lda (ZP.TextAddress), y
			ora ZP.Amount
			sta (ZP.TextAddress), y

			inx
			cpx SwarmSize
			bcc Loop




		rts
	}

	UpdateSprite: {

		lda PosX_LSB
		sta VIC.SPRITE_0_X

		lda PosY
		sta VIC.SPRITE_0_Y






		rts
	}


	FrameUpdate: {

		lda UpdateTimer
		beq Ready

		dec UpdateTimer
		rts

		Ready:

		lda #UpdateTime
		sta UpdateTimer

		jsr PopulateSprite


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