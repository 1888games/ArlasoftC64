BOX: {	

	.label TOP_ROW_CHARS = 1
	.label BOT_ROW_CHARS = 4

	LeftChar:	.byte 07, 07, 07, 07, 07, 07, 07, 07, 07, 07, 19, 22, 19, 19, 19, 19, 19, 19, 19, 19, 38
	MiddleChar:	.byte 09, 08, 11, 12, 13, 14, 15, 16, 17, 18, 20, 23, 25, 27, 29, 31, 33, 34, 35, 37, 39
	RightChar:	.byte 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 21, 24, 26, 30, 28, 32, 32, 36, 30, 66, 66
	

	Colours:	.byte WHITE, YELLOW, RED, LIGHT_GREEN, CYAN, LIGHT_BLUE, GREEN, LIGHT_RED, PURPLE
				.byte ORANGE, LIGHT_GRAY, LIGHT_GREEN, YELLOW, RED, BLUE, GRAY, CYAN
				.byte PURPLE, LIGHT_RED, DARK_GRAY, WHITE



	Clear: {

		lda GRID.CharX, x
		sta ZP.Column

		lda GRID.CharY, x
		clc
		adc GRID.Offset, x
		sta ZP.Row
		tay

		ldx ZP.Column

		jsr PLOT.GetCharacter

		lda #0
		ldy #0
		sta (ZP.ScreenAddress), y

		iny
		sta (ZP.ScreenAddress), y

		iny
		sta (ZP.ScreenAddress), y

		ldy #40
		sta (ZP.ScreenAddress), y
		iny
		sta (ZP.ScreenAddress), y

		iny
		sta (ZP.ScreenAddress), y


		ldy #80
		sta (ZP.ScreenAddress), y
		iny
		sta (ZP.ScreenAddress), y

		iny
		sta (ZP.ScreenAddress), y




		rts
	}


	Combine: {

		jsr SOUND.Catch

		jsr JOIN.CheckBreak

		ldx ZP.ClearID

		lda GRID.Cells, x
		tay
		lda Colours, y
		sta ZP.Colour

		lda #0
		sta GRID.Cells, x
		sta GRID.Offset, x

		jsr Clear

		ldx ZP.CombineID

		inc GRID.Cells, x

		lda GRID.Cells, x
		cmp GRID.Score
		bcc NoNew	

		sta GRID.Score

		cmp #20
		bcc NoComplete

		lda #GAME_MODE_OVER
		sta MAIN.GameMode

		lda #100
		sta MAIN.GameOverTimer

	NoComplete:

		cmp #8
		bcc NoNew

		inc GRID.AllowFixed

		NoNew:

		stx ZP.CurrentID

		jsr EXPLODE.Setup

		jsr Draw

		lda #10
		sta GRID.GravityTimer

		lda MAIN.GameMode
		cmp #GAME_MODE_OVER
		bne NotDone	

		jmp HUD.DrawTwenty



	NotDone:

		
		

		rts
	}

	Draw: {

		cpx #NUM_ROWS * NUM_COLS
		bcs HasNumber

	IsPlay:

		lda GRID.Cells, x
		bne HasNumber

		rts

	HasNumber:
		lda GRID.Cells, x
		sta ZP.Number
		tay

		cpx #NUM_ROWS * NUM_COLS + 2
		bcc DoColour

		lda #LIGHT_BLUE
		sta ZP.Colour
		jmp SkipColour

	DoColour:

		lda Colours, y
		sta ZP.Colour

	SkipColour:

		lda GRID.CharX, x
		sta ZP.Column

		lda GRID.CharY, x
		clc
		adc GRID.Offset, x
		sta ZP.Row
		tay

		ldx ZP.Column

		jsr PLOT.GetCharacter

	TopLeft:

		ldx ZP.CurrentID

		lda #TOP_ROW_CHARS
		sta ZP.CharID

		ldy #0

		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

	TopMiddle:

		inc ZP.CharID
		lda ZP.CharID
		iny

		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y


	TopRight:

		inc ZP.CharID
		lda ZP.CharID
		iny

		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

		ldy #79

	BottomLeft:

		inc ZP.CharID
		lda ZP.CharID
		iny

		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

	BottomMiddle:

		inc ZP.CharID
		lda ZP.CharID
		iny

		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

	BottomRight:

		inc ZP.CharID
		lda ZP.CharID
		iny

		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y


	MiddleLeft:

		ldy #40
		ldx ZP.Number

		lda LeftChar, x
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y



	Middle:

		iny
		lda MiddleChar, x
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

	MiddleRight:

		iny

		lda RightChar, x
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y



		rts
	}




}