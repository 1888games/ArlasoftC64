.namespace SCROLLER {	

	* = * "----------"
	* = * "SCROLLER"

	.label BOTTOM_ROWS_INVISIBLE_START =0
	.label TOP_BORDER_ROWS = 2
	.label BOTTOM_BORDER_ROWS = 0
	.label START_COLUMN = 6

	.label SCREEN_RAM1 = $C000
	.label SCREEN_RAM2 = $F400

	.label MAP_ROWS = 31
	.label MAP_COLUMNS = 28
	.label VIEWPORT_ROWS = 25 - TOP_BORDER_ROWS - BOTTOM_BORDER_ROWS
	.label INVISIBLE_ROWS = MAP_ROWS - VIEWPORT_ROWS
	.label FIRST_MAP_ROW = 3
	.label LAST_MAP_ROW = 33
	.label START_ROW = LAST_MAP_ROW - VIEWPORT_ROWS + 1 - BOTTOM_ROWS_INVISIBLE_START

	.label END_COLUMN = START_COLUMN + MAP_COLUMNS - 1


	.label VIEWPORT_QUARTER_ROWS = ceil((VIEWPORT_ROWS - 1)/ 4)

	.label VIEWPORT_QUARTER_CHARS = VIEWPORT_QUARTER_ROWS * 40

	.label LAST_QUARTER_ROWS = VIEWPORT_QUARTER_ROWS - ((VIEWPORT_QUARTER_ROWS * 4) - (VIEWPORT_ROWS - 1))
	.label LAST_QUARTER_CHARS  =LAST_QUARTER_ROWS * 40


	.label MAP_TOP_ADDRESS = ((LAST_MAP_ROW - VIEWPORT_ROWS) * MAP_COLUMNS) + MAP.MAP_LOCATION
	.label COLOUR_TOP_ADDRESS = ((LAST_MAP_ROW - VIEWPORT_ROWS) * MAP_COLUMNS) + MAP.MazeColours

	.label MAP_BOTTOM_ADDRESS = MAP_TOP_ADDRESS + ((1 + VIEWPORT_ROWS) * MAP_COLUMNS)
	.label COLOUR_BOTTOM_ADDRESS = COLOUR_TOP_ADDRESS + ((1 + VIEWPORT_ROWS) * MAP_COLUMNS)


	.label KILL_TOP_ADDRESS = ((LAST_MAP_ROW - VIEWPORT_ROWS) * MAP_COLUMNS) + MAP.KILL_MAP
	
	.label KILL_BOTTOM_ADDRESS = KILL_TOP_ADDRESS + ((1 + VIEWPORT_ROWS) * MAP_COLUMNS)

	
	.print "VIEWPORT QUARTER = " + VIEWPORT_QUARTER_ROWS
	.print "VIEWPORT Q CHARS = " + VIEWPORT_QUARTER_CHARS
	.print "LAST_QUARTER_ROWS = " + LAST_QUARTER_ROWS
	.print "LAST_QUARTER_CHARS = " + LAST_QUARTER_CHARS
	.print "MAP_TOP_ADDRESS = " + MAP_TOP_ADDRESS
	.print "CLR_TOP_ADDRESS = " + COLOUR_TOP_ADDRESS
	.print "MAP_BOT_ADDRESS = " + MAP_BOTTOM_ADDRESS
	.print "CLR_BOT_ADDRESS = " + COLOUR_BOTTOM_ADDRESS

	.label START_PIXEL_SCROLL = (START_ROW * 8) + 7

	TopRow:					.byte 0
	BottomRow:				.byte 0
	AboveRow:				.byte 0
	BelowRow:				.byte 0

	CanScrollDown:			.byte 0
	CanScrollUp:			.byte 0
	PixelScroll:			.byte 0
	YScroll:				.byte 0
	DirectionPreparing:		.byte 0
	PreparationProgress:	.byte 0

	D011:					.byte 0
	D011Copy:				.byte 0

	BufferingUp:			.byte 255
	BufferingDown:			.byte 255
	BufferedUp:				.byte 0
	BufferedDown:			.byte 0

	CurrentScreen:			.byte 0
	BufferScreen:			.byte 1
	ScreenLookup:			.byte %00001110, %11011110
	SwitchScreen:			.byte 0
	ScreenBuffered:			.byte 0
	ScrollingUp:			.byte 0
	ScrollingDown:			.byte 0
	MaxPixelScroll:			.byte 0
	SwapTheBuffers:			.byte 0
	FineScrollUp:			.byte 0
	FineScrollDown:			.byte 0


	BufferUpFunctions_LSB:	.byte <ShiftMap3, <ShiftMap2, <ShiftMap1, <ShiftMap0
	BufferUpFunctions_MSB:	.byte >ShiftMap3, >ShiftMap2, >ShiftMap1, >ShiftMap0

	BufferDownFunctions_LSB:	.byte <ShiftMap7, <ShiftMap6, <ShiftMap5, <ShiftMap4
	BufferDownFunctions_MSB:	.byte >ShiftMap7, >ShiftMap6, >ShiftMap5, >ShiftMap4
	


	InitialSetup: {

		lda #START_ROW
		
		jsr CalculateOtherRows

		lda #START_PIXEL_SCROLL
		clc
		//adc #3
		sta PixelScroll
		sta MaxPixelScroll

		and #%00000111
		sta YScroll

		lda #7
		sec
		sbc YScroll
		sta YScroll
		

		lda $d011
		and #%11111000
		ora #%00010000
		ora YScroll
		sta D011
		sta D011Copy

		lda #255
		sta DirectionPreparing

		lda #50
		sta BufferingUp
		sta BufferingDown

		lda #0
		sta ScrollingUp
		sta ScrollingDown
		sta BufferedUp
		sta BufferedDown
		sta FineScrollUp
		sta FineScrollDown

		lda #<SCREEN_RAM1
		sta ZP_CurrentBuffer + 0
		lda #>SCREEN_RAM1
		sta ZP_CurrentBuffer + 1
		lda #<SCREEN_RAM2
		sta ZP_NextBuffer + 0
		lda #>SCREEN_RAM2
		sta ZP_NextBuffer + 1

		lda GAME.KillScreen
		beq NotKill

		KillScreen:

			lda #<KILL_TOP_ADDRESS
			sta ZP.AboveRowAddress

			lda #>KILL_TOP_ADDRESS
			sta ZP.AboveRowAddress + 1

			lda #<KILL_BOTTOM_ADDRESS
			sta ZP.BelowRowAddress

			lda #>KILL_BOTTOM_ADDRESS
			sta ZP.BelowRowAddress + 1

			jmp Skip

		NotKill:

			lda #<MAP_TOP_ADDRESS
			sta ZP.AboveRowAddress

			lda #>MAP_TOP_ADDRESS
			sta ZP.AboveRowAddress + 1


			lda #<MAP_BOTTOM_ADDRESS
			sta ZP.BelowRowAddress

			lda #>MAP_BOTTOM_ADDRESS
			sta ZP.BelowRowAddress + 1

		Skip:

			lda #<COLOUR_TOP_ADDRESS
			sta ZP.AboveColourAddress

			lda #>COLOUR_TOP_ADDRESS
			sta ZP.AboveColourAddress + 1

			lda #<COLOUR_BOTTOM_ADDRESS
			sta ZP.BelowColourAddress

			lda #>COLOUR_BOTTOM_ADDRESS
			sta ZP.BelowColourAddress + 1

			jsr SetToScreen0


		
		rts
	}


	CalculateOtherRows: {

		sta TopRow

		sec
		sbc #1
		sta AboveRow

		clc
		adc #VIEWPORT_ROWS
		sec
		sbc #1
		sta BottomRow

		clc
		adc #1
		sta BelowRow

		rts
	}

	ValidateRows: {

		CheckAbove:

			lda AboveRow
			cmp #FIRST_MAP_ROW
			bcs CheckBelow

			lda #255
			sta AboveRow


		CheckBelow:

			lda BelowRow
			cmp #LAST_MAP_ROW
			bcs Finish

			lda #255
			sta BelowRow

		Finish:

		rts
	}



	SetToScreen0: {

		lda #0
		sta CurrentScreen

		tax
		lda ScreenLookup, x
		sta VIC.MEMORY_SETUP

		rts
	}

	SwapBuffers: {


		lda CurrentScreen
		eor #%00000001
		sta CurrentScreen
		tax

		lda ScreenLookup, x
		sta VIC.MEMORY_SETUP

		lda ScrollingUp
		beq Down

		Up:	

			jsr ShiftColor
			jsr MoveRowUp

			lda #0
			sta ScrollingUp

			lda #3
			sta BufferingUp


			lda #50
			sta BufferingDown

			lda ZP.AboveRowAddress
			sec
			sbc #28
			sta ZP.AboveRowAddress

			lda ZP.AboveRowAddress + 1
			sbc #0
			sta ZP.AboveRowAddress + 1


			lda ZP.AboveColourAddress
			sec
			sbc #28
			sta ZP.AboveColourAddress

			lda ZP.AboveColourAddress + 1
			sbc #0
			sta ZP.AboveColourAddress + 1

			lda ZP.BelowRowAddress
			sec
			sbc #28
			sta ZP.BelowRowAddress

			lda ZP.BelowRowAddress + 1
			sbc #0
			sta ZP.BelowRowAddress + 1


			lda ZP.BelowColourAddress
			sec
			sbc #28
			sta ZP.BelowColourAddress

			lda ZP.BelowColourAddress + 1
			sbc #0
			sta ZP.BelowColourAddress + 1

			jmp Switch


		Down:	

			jsr ShiftColorDown
			jsr MoveRowDown


			lda #0
			sta ScrollingDown

			lda #50
			sta BufferingUp

			lda #3
			sta BufferingDown

			lda ZP.BelowRowAddress
			clc
			adc #28
			sta ZP.BelowRowAddress

			lda ZP.BelowRowAddress + 1
			adc #0
			sta ZP.BelowRowAddress + 1


			lda ZP.BelowColourAddress
			clc
			adc #28
			sta ZP.BelowColourAddress

			lda ZP.BelowColourAddress + 1
			adc #0
			sta ZP.BelowColourAddress + 1

			lda ZP.AboveRowAddress
			clc
			adc #28
			sta ZP.AboveRowAddress

			lda ZP.AboveRowAddress + 1
			adc #0
			sta ZP.AboveRowAddress + 1


			lda ZP.AboveColourAddress
			clc
			adc #28
			sta ZP.AboveColourAddress

			lda ZP.AboveColourAddress + 1
			adc #0
			sta ZP.AboveColourAddress + 1

		Switch:	
		

		lda BufferScreen
		eor #%00000001
		sta BufferScreen

		ldx ZP_CurrentBuffer + 0
		ldy ZP_CurrentBuffer + 1
		lda ZP_NextBuffer + 0
		sta ZP_CurrentBuffer + 0
		lda ZP_NextBuffer + 1
		sta ZP_CurrentBuffer + 1
		stx ZP_NextBuffer + 0
		sty ZP_NextBuffer + 1


	

		rts
	}



	IRQ_Update: {

		///inc $d020
		
		lda SCROLLER.SwitchScreen
		beq NoSwap
		lda SCROLLER.ScreenBuffered
		beq NoSwap

		lda #0
		sta SwitchScreen
		sta ScreenBuffered
		
		
		lda #1
		sta SCROLLER.SwapTheBuffers

		NoSwap:

		


		//dec $d020


		rts
	}


	DebugInfo: {

		lda SwapTheBuffers
		clc
		adc #48
		sta SCREEN_RAM
		sta SCREEN_RAM_2

		lda BufferedUp
		clc
		adc #48
		sta SCREEN_RAM + 2
		sta SCREEN_RAM2 + 2

		lda BufferedDown
		clc
		adc #48
		sta SCREEN_RAM + 4
		sta SCREEN_RAM2 + 4

		lda BufferingUp
		clc
		adc #48
		sta SCREEN_RAM + 42
		sta SCREEN_RAM2 + 42

		lda BufferingDown
		clc
		adc #48
		sta SCREEN_RAM + 44
		sta SCREEN_RAM2 + 44

		lda YScroll
		clc
		adc #48
		sta SCREEN_RAM + 40
		sta SCREEN_RAM2 + 40

		lda #YELLOW
		sta VIC.COLOR_RAM 
		sta VIC.COLOR_RAM + 2
		sta VIC.COLOR_RAM + 4
		sta VIC.COLOR_RAM + 40
		sta VIC.COLOR_RAM + 42
		sta VIC.COLOR_RAM + 44

		rts
	}



	ScreenShift: {


		jsr CheckBufferingUp
		jsr CheckBufferingDown


		rts
	}


	ScreenSwap: {

	//	jsr DebugInfo

		lda SwapTheBuffers
		beq noswap2

		lda #0
		sta SwapTheBuffers

		jmp SwapBuffers

		noswap2:



		rts
	}

	FrameUpdate: {

		jsr CheckScrollingUp
		jsr CheckScrollingDown
		

		rts
	}




}
