.namespace SCROLLER {


		* = * "-Down"

	CheckBufferingDown: {

		
		lda BufferingDown
		bmi Finish

		cmp #50
		beq Finish

		Ready:


		tax
		lda BufferDownFunctions_LSB, x
		sta ZP.DataAddress

		lda BufferDownFunctions_MSB, x
		sta ZP.DataAddress + 1

		NotYet:

		dec BufferingDown
		//dec BufferingDown
		bpl NotComplete

		lda #1
		sta ScreenBuffered
		sta BufferedDown

		lda #0
		sta BufferedUp

		NotComplete:
		
		jmp (ZP.DataAddress)
	
		
		Finish:

			rts
	}

		
	CheckScrollingDown: {


		CheckConditions:

			lda SwapTheBuffers
			bne NotScrollingUp

		Continue:

			lda ACTOR.Direction
			cmp #DIR_DOWN
			bne NotScrollingUp

			lda BufferedDown
			beq NotScrollingUp

			lda SpriteY
			cmp #136
			bcc NotScrollingUp

			lda PixelScroll
			cmp MaxPixelScroll
			bcs NotScrollingUp

		ScrollUp:

			lda PixelScroll
			sta ZP.Temp4
			clc
			adc ZP.PixelsThisFrame
			sta PixelScroll

			
		Positive:

			lda YScroll
			sta ZP.Temp3
			sec
			sbc ZP.PixelsThisFrame
			sta YScroll
			
			bpl NoWrap
	
			clc
			adc #8
			sta YScroll

			lda BufferingDown
			bmi DontCancel
		//	beq DontCancel

		CancelScroll:

			lda ZP.Temp3
			sta YScroll

			lda ZP.Temp4
			sta PixelScroll

			jmp NotScrollingUp

		DontCancel:


			inc SwitchScreen
			inc ScrollingDown

			lda #0
			sta FineScrollDown
		

			NoWrap:

			
			lda #0
			sta ACTOR.PLAYER.LastMove

			

		NoSwitch:

			lda $d011
			and #%11111000
			ora YScroll
			sta D011

		NotScrollingUp:

		rts
	}




	ShiftMap4: {

		

		lda ZP_CurrentBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + 1)]
		sta Source + 1
		lda ZP_CurrentBuffer + 1
		adc #>[40 * (TOP_BORDER_ROWS + 1)]
		sta Source + 2

		lda ZP_NextBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + 0)]	
		sta Dest + 1
		lda ZP_NextBuffer + 1
		clc
		adc #>[40 * (TOP_BORDER_ROWS + 0)]			
		sta Dest + 2

		ldx #VIEWPORT_QUARTER_CHARS - 1
	!:
	Source:
		lda $BEEF, x
	Dest:
		sta $BEEF, x
		dex
		cpx #$ff
		bne !-

		//dec BufferingDown
		//jmp ShiftMap5_2

		rts
	}

	

	ShiftMap5: {

		lda ZP_CurrentBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + VIEWPORT_QUARTER_ROWS + 1)]
		sta Source + 1
		lda ZP_CurrentBuffer + 1
		adc #>[40 * (TOP_BORDER_ROWS + VIEWPORT_QUARTER_ROWS + 1)]
		sta Source + 2

		lda ZP_NextBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + VIEWPORT_QUARTER_ROWS + 0)]	
		sta Dest + 1
		lda ZP_NextBuffer + 1
		clc
		adc #>[40 * (TOP_BORDER_ROWS + VIEWPORT_QUARTER_ROWS + 0)]		
		sta Dest + 2

		ldx #VIEWPORT_QUARTER_CHARS - 1
	!:
	Source:
		lda $BEEF, x
	Dest:
		sta $BEEF, x
		dex
		cpx #$ff
		bne !-




		rts
	}

	ShiftMap6: {

		

		lda ZP_CurrentBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 2) + 1)]
		sta Source + 1
		lda ZP_CurrentBuffer + 1
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 2) + 1)]
		sta Source + 2

		lda ZP_NextBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 2)+ 0)]	
		sta Dest + 1
		lda ZP_NextBuffer + 1
		clc
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 2)+ 0)]		
		sta Dest + 2

		ldx #VIEWPORT_QUARTER_CHARS - 1
	!:
	Source:
		lda $BEEF, x
	Dest:
		sta $BEEF, x
		dex
		cpx #$ff
		bne !-

		//dec BufferingDown
		//jmp ShiftMap7
		rts
	}

	ShiftMap7: {



		lda ZP_CurrentBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3)+ 1)]
		sta Source + 1
		lda ZP_CurrentBuffer + 1
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3) + 1)]
		sta Source + 2

		lda ZP_NextBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3) + 0)]	
		sta Dest + 1
		lda ZP_NextBuffer + 1
		clc
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3) + 0)]		
		sta Dest + 2

		ldx #LAST_QUARTER_CHARS
	!:
	Source:
		lda $BEEF, x
	Dest:
		sta $BEEF, x
		dex
		cpx #$ff
		bne !-

		jsr CopyFromMapToLastRow

		

		rts
	}


	ShiftColorDown: {


		.for(var i=TOP_BORDER_ROWS; i<24 - BOTTOM_BORDER_ROWS; i++) {
			.for(var j=START_COLUMN; j<END_COLUMN + 1; j++) {
				lda VIC.COLOR_RAM + $28 + i * $28 + j
				sta VIC.COLOR_RAM + $00 + i * $28 + j	
			}
		}


		jmp CopyColoursToLastRow
		
	}

	CopyColoursToLastRow: {

		ldy #0
		ldx #START_COLUMN

		Loop:

			lda (ZP.BelowColourAddress), y
			pha

			sty ZP.Y

			txa
			tay

			pla
			sta VIC.COLOR_RAM + (24 * 40) - (BOTTOM_BORDER_ROWS * 40), y

			ldy ZP.Y	
			iny
			inx
			cpy #MAP_COLUMNS
			bcc Loop

		lda ZP.PillAddress_1
		sec
		sbc #40
		sta ZP.PillAddress_1

		lda ZP.PillAddress_1 + 1
		sbc #0
		sta ZP.PillAddress_1 + 1

		lda ZP.PillAddress_3
		sec
		sbc #40
		sta ZP.PillAddress_3

		lda ZP.PillAddress_3 + 1
		sbc #0
		sta ZP.PillAddress_3 + 1

		dec ENERGIZER.CurrentPillRow
		dec ENERGIZER.CurrentPillRow + 2



		rts
	}



	CopyFromMapToLastRow: {


		lda ZP_NextBuffer
		sta ZP.DataAddress

		lda ZP_NextBuffer + 1
		sta ZP.DataAddress + 1

		lda ZP.DataAddress
		clc
		adc #<[40 * (24 - BOTTOM_BORDER_ROWS)]
		sta ZP.DataAddress

		lda ZP.DataAddress + 1
		adc #>[40 * (24 - BOTTOM_BORDER_ROWS)]
		sta ZP.DataAddress + 1



		ldy #0
		ldx #START_COLUMN

		Loop:

			lda (ZP.BelowRowAddress), y
			pha

			sty ZP.Y

			txa
			tay

			pla
			sta (ZP.DataAddress), y

				
			ldy ZP.Y	
			iny
			inx
			cpy #MAP_COLUMNS
			bcc Loop

		

		rts
	}



	MoveRowDown: {

		lda TopRow
		clc
		adc #1
		
		jsr CalculateOtherRows
		jsr ValidateRows


		rts
	}



}