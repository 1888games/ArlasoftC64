DRAW: {



	.label BlankCharacterID = 188
	.label ButtonCharacterID = 196
	.label FullBar = 197


	TopLeft:		.byte 01, 01, 01, 01, 01, 01, 01, 01, 28, 01, 01, 01, 01
					.byte 01, 01, 01, 01, 01, 01, 01, 01, 28, 01, 01, 01, 01
					.byte 01, 01, 01, 01, 01, 01, 01, 01, 56, 01, 01, 01, 01
					.byte 01, 01, 01, 01, 01, 01, 01, 01, 56, 01, 01, 01, 01

	TopCentre:		.byte 17, 16, 15, 14, 13, 07, 10, 12, 27, 21, 23, 25, 19
					.byte 17, 16, 15, 14, 13, 07, 10, 12, 27, 21, 23, 25, 19
					.byte 39, 44, 49, 51, 52, 53, 54, 55, 57, 60, 62, 64, 66
					.byte 39, 44, 49, 51, 52, 53, 54, 55, 57, 60, 62, 64, 66

	TopRight:		.byte 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06
					.byte 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06
					.byte 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06
					.byte 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06, 06


	MiddleLeft:		.byte 02, 02, 02, 02, 02, 02, 02, 02, 29, 02, 02, 02, 02
					.byte 31, 31, 31, 31, 31, 31, 31, 31, 35, 31, 31, 31, 31
					.byte 40, 40, 40, 40, 40, 40, 40, 40, 58, 40, 40, 40, 40
					.byte 40, 40, 40, 40, 40, 40, 40, 40, 70, 40, 40, 40, 40

	Middle:			.byte 18, 08, 11, 08, 08, 11, 08, 08, 26, 22, 24, 20, 20
					.byte 30, 32, 33, 32, 32, 33, 32, 32, 34, 36, 37, 38, 38
					.byte 41, 45, 50, 45, 45, 50, 45, 45, 59, 61, 63, 65, 65
					.byte 46, 67, 68, 67, 67, 68, 67, 67, 69, 71, 72, 73, 73

	MiddleRight:	.byte 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04
					.byte 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04
					.byte 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04
					.byte 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04

	BottomLeft:		.byte 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03
					.byte 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03
					.byte 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48
					.byte 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42, 42

	BottomCentre:	.byte 09, 09, 09, 09, 09, 09, 09, 09, 09, 09, 09, 09, 09
					.byte 09, 09, 09, 09, 09, 09, 09, 09, 09, 09, 09, 09, 09
					.byte 43, 43, 43, 43, 43, 43, 43, 43, 43, 43, 43, 43, 43
					.byte 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47

	BottomRight:	.byte 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05
					.byte 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05
					.byte 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05
					.byte 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05
					


	TopLeftBlank:		.byte 162
	TopCentreBlank:		.byte 186
	TopRightBlank:		.byte 163
	MiddleLeftBlank:	.byte 164
	MiddleBlank:		.byte 187
	MiddleRightBlank:	.byte 165
	BottomLeftBlank:	.byte 166
	BottomCentreBlank:	.byte 167
	BottomRightBlank:	.byte 168

	TopLeftBack:		.byte 153
	TopCentreBack:		.byte 154
	TopRightBack:		.byte 155
	MiddleLeftBack:		.byte 156
	MiddleBack:			.byte 157
	MiddleRightBack:	.byte 158
	BottomLeftBack:		.byte 159
	BottomCentreBack:	.byte 160
	BottomRightBack:	.byte 161


	startColumn:	.byte 0
	startRow:		.byte 0





	ClearScreen: {

		lda #BlankCharacterID
		ldx #0

		Loop:

			sta SCREEN_RAM + 0, x
			sta SCREEN_RAM + 250, x
			sta SCREEN_RAM + 500, x
			sta SCREEN_RAM + 750, x

			inx
			cpx #250
			beq Finish
			jmp Loop


		Finish:

		rts
	}


	YReg:	.byte 0

	Reset: {

		jsr DECK.Shuffle

		//jsr SPRITE.DealCard

		
		lda #1
		//sta DECK.CurrentlyDealing
		
		jsr ClearBoard

		jsr PLAYER.Reset

		ldx #2
		jsr TEXT.DrawNames
		jsr TEXT.ClearMessages

		rts

	}




	


	ClearBoard: {

		ldy #16
		jsr DrawOutline

		ldy #17
		jsr DrawOutline

		ldy #18
		jsr DrawOutline

		ldy #19
		jsr DrawOutline

		ldy #20
		jsr DrawOutline


		rts



	}


	DrawDealerButton: {

		stx PlayerID

		lda SLOTS.ButtonRows, x
		sta Row

		lda SLOTS.ButtonColumns, x
		sta Column

		tax
		ldy Row	

		lda #ButtonCharacterID

		jsr PLOT.PlotCharacter

		ldx PlayerID


		rts
	}

	ClearDealerButton: {

		stx PlayerID

		lda SLOTS.ButtonRows, x
		sta Row

		lda SLOTS.ButtonColumns, x
		sta Column

		tax
		ldy Row	

		lda #BlankCharacterID

		jsr PLOT.PlotCharacter

		ldx PlayerID


		rts
	}

	DrawBack: {


		lda SLOTS.Columns, y
		sta startColumn

		lda SLOTS.Rows, y
		sta startRow

		ldy startRow
		lda TopLeftBack
		ldx startColumn
		
		jsr PLOT.PlotCharacter

		lda TopCentreBack
		ldx startColumn
		inx

		jsr PLOT.PlotCharacter


		lda TopRightBack
		ldx startColumn
		inx
		inx

		jsr PLOT.PlotCharacter

		lda MiddleLeftBack
		iny
		ldx startColumn

		jsr PLOT.PlotCharacter

		lda MiddleBack
		ldx startColumn
		inx

		jsr PLOT.PlotCharacter

		lda MiddleRightBack
		ldx startColumn
		inx
		inx

		jsr PLOT.PlotCharacter

		lda BottomLeftBack
		ldx startColumn
		iny
		
		jsr PLOT.PlotCharacter


		lda BottomCentreBack
		ldx startColumn
		inx
		
		jsr PLOT.PlotCharacter

		lda BottomRightBack
		ldx startColumn
		inx
		inx
		
		jsr PLOT.PlotCharacter



		rts



	}




	UpdateTimerBar: {

		ldx TABLE.PlayerToAct

		lda SLOTS.Columns, x
		clc
		adc TABLE.TickChar
		sta Column

		lda SLOTS.TextRows, x
		sta Row
		tay

		lda TABLE.TickCount
		clc
		adc #FullBar

		ldx Column

		jsr PLOT.PlotCharacter

		rts


	}

	DeleteTimerChar: {

		ldx TABLE.PlayerToAct

		lda SLOTS.Columns, x
		clc
		adc TABLE.TickChar
		sta Column

		lda SLOTS.TextRows, x
		sta Row
		tay

		lda #BlankCharacterID
	
		ldx Column

		jsr PLOT.PlotCharacter

		rts



	}

	FillTimerBar: {


		lda SLOTS.Columns, x
		sta Column

		lda SLOTS.TextRows, x
		sta Row
		tay

		lda #FullBar
		ldx Column

		jsr PLOT.PlotCharacter

		lda #6
		jsr PLOT.ColorCharacter

		lda #FullBar
		inx
		jsr PLOT.PlotCharacter

		lda #6
		jsr PLOT.ColorCharacter

		lda #FullBar
		inx
		jsr PLOT.PlotCharacter

		lda #6
		jsr PLOT.ColorCharacter


		lda #FullBar
		inx
		jsr PLOT.PlotCharacter

		lda #6
		jsr PLOT.ColorCharacter

		lda #FullBar
		inx
		jsr PLOT.PlotCharacter

		lda #6
		jsr PLOT.ColorCharacter

		lda #FullBar
		inx
		jsr PLOT.PlotCharacter

		lda #6
		jsr PLOT.ColorCharacter





		rts
	}

	DrawOutline: {

		lda SLOTS.Columns, y
		sta startColumn

		lda SLOTS.Rows, y
		sta startRow

		ldy startRow
		lda TopLeftBlank
		ldx startColumn
		
		jsr PLOT.PlotCharacter

		lda TopCentreBlank
		ldx startColumn
		inx

		jsr PLOT.PlotCharacter


		lda TopRightBlank
		ldx startColumn
		inx
		inx

		jsr PLOT.PlotCharacter

		lda MiddleLeftBlank
		iny
		ldx startColumn

		jsr PLOT.PlotCharacter

		lda MiddleBlank
		ldx startColumn
		inx

		jsr PLOT.PlotCharacter

		lda MiddleRightBlank
		ldx startColumn
		inx
		inx

		jsr PLOT.PlotCharacter

		lda BottomLeftBlank
		ldx startColumn
		iny
		
		jsr PLOT.PlotCharacter


		lda BottomCentreBlank
		ldx startColumn
		inx
		
		jsr PLOT.PlotCharacter

		lda BottomRightBlank
		ldx startColumn
		inx
		inx
		
		jsr PLOT.PlotCharacter



		rts
	}


	
	DrawCard: {


		lda SLOTS.Shown, y
		bne CardIsFaceUp



		jsr DrawBack
		jmp Finish

		CardIsFaceUp:

		// x = cardID
		// y = slotID

		stx CurrentID

		lda SLOTS.Columns, y
		sta startColumn

		lda SLOTS.Rows, y
		sta startRow


		ldy startRow
		lda TopLeft, x
		ldx startColumn
		
		jsr PLOT.PlotCharacter


		ldx CurrentID
		lda TopCentre, x
		ldx startColumn
		inx

		jsr PLOT.PlotCharacter


		ldx CurrentID
		lda TopRight, x
		ldx startColumn
		inx
		inx

		jsr PLOT.PlotCharacter

		ldx CurrentID
		lda MiddleLeft, x
		iny
		ldx startColumn

		jsr PLOT.PlotCharacter

		ldx CurrentID
		lda Middle, x
		ldx startColumn
		inx

		jsr PLOT.PlotCharacter

		ldx CurrentID
		lda MiddleRight, x
		ldx startColumn
		inx
		inx

		jsr PLOT.PlotCharacter

		ldx CurrentID
		lda BottomLeft, x
		ldx startColumn
		iny
		
		jsr PLOT.PlotCharacter


		ldx CurrentID
		lda BottomCentre, x
		ldx startColumn
		inx
		
		jsr PLOT.PlotCharacter

		ldx CurrentID
		lda BottomRight, x
		ldx startColumn
		inx
		inx
		
		jsr PLOT.PlotCharacter


		Finish:

		rts
	}

	

}