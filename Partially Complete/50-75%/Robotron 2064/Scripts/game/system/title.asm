TITLE: {


	* = * "Title"

	.label StartX = 61
	.label XGap = 44
	.label StartY= 52
	.label YGap = 44

	.label ReachXRight = StartX + (5 * XGap)
	.label ReachXLeft = StartX
	.label ReachYDown = StartY + (4 * YGap)
	.label ReachYUp = StartY

	PosX_Frac:	.fill 24, 0

	PosX_LSB:	.fill 6, StartX + (i * XGap) 
				.fill 3, StartX + (5 * XGap)
				.fill 6, StartX + (i * XGap)
				.fill 3, StartX

	PosX_MSB:	.fill 5, 0
				.fill 4, 1
				.fill 5, 0
				.fill 1, 1
				.fill 3, 0

	PosY:		.fill 6, StartY
				.fill 3, StartY + ((i + 1) * YGap)
				.fill 6, StartY + (4 * YGap)
				.fill 3, StartY + ((3 - i)) * YGap
			
	Frame:		.byte 0, 1, 0, 1, 0, 1, 0, 1
				.byte 0, 1, 0, 0, 1, 0, 1, 0, 1
				.byte 0, 1, 0, 1, 0, 1, 0, 1
				.byte 0, 1, 0, 1, 0, 1, 0, 1

	Direction:	.fill 5, RIGHT
				.fill 4, DOWN
				.fill 1, UP
				.fill 5, LEFT
				.fill 3, UP
		

	Colour:		.byte ORANGE, PURPLE, GREEN, BLUE, RED, YELLOW
				.byte ORANGE, PURPLE, GREEN
				.byte GREEN, PURPLE, ORANGE, YELLOW, RED, BLUE
				.byte BLUE, RED, YELLOW


	Rows:		.byte 14, 15, 17, 19, 20
	Colour1:	.byte RED, RED, BLUE, YELLOW, PURPLE
	Flash:		.byte 0, 0, 0, 0, 0
	FlashTimer:	.byte 0, 0, 0, 0, 0


	ColourWhite:	.byte 0

	WhiteTimer:	.byte 4
	ColourTimer:	.byte 3
			
	RoboColour:		.byte 1

	.label WhiteTime = 3
	.label PixelPerFrame = 1
	.label ColourTime = 6

	Show: {







		rts
	}

	Colours: {

		dec ColourTimer
		bne NotReady

		Ready:

		lda #ColourTime
		sta ColourTimer

		inc RoboColour
		lda RoboColour
		cmp #8
		bcc NotReady

		lda #1
		sta RoboColour


		NotReady:


		DrawRobo:

			ldx #8
			ldy #5
			jsr PLOT.GetCharacter


			ldy #0
			lda RoboColour

			Loop:

				sta (ZP.ColourAddress), y

				iny
				cpy #160
				bcc Loop



		ldx #0

		RowLoop:

			stx ZP.X

			lda FlashTimer, x
			beq ReadyFlash

			dec FlashTimer, x
			jmp EndLoop

		ReadyFlash:

			lda Rows, x
			tay

			ldx #0
			jsr PLOT.GetCharacter

			ldy #0
			ldx ZP.X
			lda Flash, x
			beq UseNormal

		UseWhite:

			jsr RANDOM.Get
			and #%00000011
			clc
			adc #2
			sta FlashTimer, x

			lda #0
			sta Flash, x

			lda #WHITE
			jmp DrawRow

		UseNormal:

			jsr RANDOM.Get
			and #%00001111
			clc
			adc #8
			sta FlashTimer, x

			lda #1
			sta Flash, x

			lda Colour1, x

		DrawRow:

			sta (ZP.ColourAddress), y
			iny
			cpy #40
			bcc DrawRow


		EndLoop:

			ldx ZP.X
			inx 
			cpx #5
			bcc RowLoop


		rts
	}
	FrameUpdate: {

		dec WhiteTimer
		bne NotReady

		lda #WhiteTime
		sta WhiteTimer

		dec ColourWhite
		lda ColourWhite
		bpl NotReady

		lda #5
		sta ColourWhite

		NotReady:

		lda #BLACK
		sta VIC.BORDER_COLOR

		lda #%11111111
		sta VIC.SPRITE_ENABLE

		lda #%00000000
		sta VIC.SPRITE_MULTICOLOR

		ldx #0


		Loop:

			lda Direction, x
			cmp #RIGHT
			beq Right

			cmp #LEFT
			beq Left

			cmp #DOWN
			beq Down


		Up:	

			lda PosY, x
			sec
			sbc #PixelPerFrame
			sta PosY, x


			cmp #ReachYUp
			bcs NowDraw

			lda #ReachYUp
			sta PosY, x

			lda #RIGHT
			sta Direction, x

			jmp NowDraw

		Down:

			lda PosY, x
			clc
			adc #PixelPerFrame
			sta PosY, x


			cmp #ReachYDown
			bcc NowDraw

			lda #ReachYDown
			sta PosY, x

			lda #LEFT
			sta Direction, x

			jmp NowDraw

		Left:	

			lda PosX_LSB, x
			sec
			sbc #PixelPerFrame
			sta PosX_LSB, x

			lda PosX_MSB, x
			sbc #0
			sta PosX_MSB, x
			bne NowDraw

			lda PosX_LSB, x
			cmp #ReachXLeft
			bcs NowDraw

			lda #ReachXLeft
			sta PosX_LSB, x

			lda #UP
			sta Direction, x

			jmp NowDraw

		Right:

			lda PosX_LSB, x
			clc
			adc #PixelPerFrame
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x
			beq NowDraw

			lda PosX_LSB, x
			cmp #ReachXRight
			bcc NowDraw

			lda #ReachXRight
			sta PosX_LSB, x

			lda #DOWN
			sta Direction, x

		NowDraw:


			lda Frame, x
			clc
			adc #121
			sta SpritePointer, x

			lda PosX_LSB, x
			sta SpriteX, x

			lda PosY, x
			sta SpriteY, x

			ldy ColourWhite
			lda Colour, y
			sta ZP.Colour

			lda Colour, x
			cmp ZP.Colour
			bne UseNormal

			lda #WHITE

		UseNormal:
			sta SpriteColor, x

			lda PosX_MSB, x
			beq NoAddMSB

			lda SpriteColor, x
			ora #%10000000
			sta SpriteColor, x

			NoAddMSB:

			inx
			cpx #18
			bcs Done

			jmp Loop
		Done:

		jsr Colours


		rts
	}
}