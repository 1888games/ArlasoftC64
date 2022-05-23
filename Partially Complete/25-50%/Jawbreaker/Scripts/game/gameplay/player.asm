
PLAYER: {


	.label MOVE_LEFT = 255
	.label MOVE_STILL = 0
	.label MOVE_RIGHT = 1

	PosX_LSB:		.byte 0
	PosX_MSB:		.byte 0
	PosX_Frac:		.byte 0


	PosY:			.byte 0
	TargetY:		.byte 0

	CharX:			.byte 0
	CharY:			.byte 0
	OffsetX:		.byte 0
	OffsetY:		.byte 0

	Direction:		.byte 0
	Frame:			.byte 0

	.label StartCharX = 19
	.label StartCharY = 12
	.label StartRow = 4
	.label SpriteNumber = 7
	.label SpriteNumberY = SpriteNumber * 2

	.label StartPointer = 25

	.label StartOffsetX = 6


	Reset:	 {


		lda #StartCharY
		sta CharY
		sec
		sbc #1
		tay

		lda #StartCharX
		sta CharX
		sec
		sbc #1
		tax

		jsr PLOT.GetCharacter

		lda #1
		ldy #0
		sta (ZP.ScreenAddress), y

		lda #GREEN
		sta (ZP.ColourAddress), y

		lda ZP.ScreenAddress
		sta ZP.PlayerAddress

		lda ZP.ScreenAddress + 1
		sta ZP.PlayerAddress + 1

		lda #127
		sta PosX_Frac

		lda #StartOffsetX
		sta OffsetX

		lda CharX
		asl
		asl
		asl
		clc
		adc #24
		clc
		adc #StartOffsetX
		sta PosX_LSB

		lda #0
		sta PosX_MSB
		sta Direction
		sta Frame
		sta OffsetY

		ldx #StartRow
		lda HEAD.RowY, x
		sta PosY
		sta TargetY

		jsr UpdateSprite


		rts



	}


	Control: {


		








		rts
	}


	FrameUpdate: {





		jsr UpdateSprite

		rts
	}

	UpdateSprite: {

		lda Frame
		clc
		adc #StartPointer
		sta SPRITE_POINTERS + SpriteNumber

		lda PosX_LSB
		sta VIC.SPRITE_0_X + SpriteNumberY
		
		lda PosX_MSB
		beq NoMSB

		MSB_On:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + SpriteNumber
			sta VIC.SPRITE_MSB

		NoMSB:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + SpriteNumber
			sta VIC.SPRITE_MSB


		lda #YELLOW
		sta VIC.SPRITE_COLOR_7


		lda PosY
		sta VIC.SPRITE_0_Y + SpriteNumberY





		rts
	}



}