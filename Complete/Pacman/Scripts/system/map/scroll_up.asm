.namespace SCROLLER {


	* = * "-Up"


	CheckScrollingUp: {

			
			lda SwapTheBuffers
			bne NotScrollingUp
			
		CheckConditions:

			lda ACTOR.Direction
			cmp #DIR_UP
			bne NotScrollingUp

			lda BufferedUp
			bne YesBuffered

			jmp NotScrollingUp

		YesBuffered:


			lda SpriteY
			cmp #168
			bcc Okay

			jmp NotScrollingUp

		Okay:

			lda PixelScroll
			cmp #32
			bcc NotScrollingUp

		ScrollUp:

			lda PixelScroll
			sta ZP.Temp4
			sec
			sbc ZP.PixelsThisFrame
			sta PixelScroll

		Positive:

			lda YScroll
			sta ZP.Temp3
			clc
			adc ZP.PixelsThisFrame
			sta YScroll
			
			cmp #8
			bcc NoWrap

			sec
			sbc #8
			sta YScroll

			lda BufferingUp
			bmi DontCancel
		
		CancelScroll:

			lda ZP.Temp3
			sta YScroll

			lda ZP.Temp4
			sta PixelScroll

			jmp NotScrollingUp

		DontCancel:


			inc SwitchScreen
			inc ScrollingUp
		
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



	CheckBufferingUp: {

	
		lda BufferingUp
		bmi Finish

		cmp #50
		beq Finish
	
		Ready:
		tax

		lda BufferUpFunctions_LSB, x
		sta ZP.DataAddress

		lda BufferUpFunctions_MSB, x
		sta ZP.DataAddress + 1

		NotYet:

		dec BufferingUp
	//	dec BufferingUp
		bpl NotComplete

		lda #1
		sta ScreenBuffered
		sta BufferedUp

		lda #0
		sta BufferedDown

		NotComplete:
		
		jmp (ZP.DataAddress)
	
		
		Finish:

			rts
	}


	Temp:	.fill 26, 0


	ShiftColor: {

		* = * "C1"

		.label Half = (24 - BOTTOM_BORDER_ROWS) / 2
		
		.for(var j=START_COLUMN + 1; j<END_COLUMN; j++) {
				lda VIC.COLOR_RAM + $28  + j + ($28* (24 - 12 - BOTTOM_BORDER_ROWS))
				sta Temp + j - START_COLUMN - 1
		}


		* = * "C2"

		.for(var i=24 - BOTTOM_BORDER_ROWS - 12; i>TOP_BORDER_ROWS - 1; i--) {
			.for(var j=START_COLUMN + 1; j<END_COLUMN; j++) {
				lda VIC.COLOR_RAM + $00 + i * $28 + j
				sta VIC.COLOR_RAM + $28 + i * $28 + j	
			}
		}

		* = * "C3"

		jsr CopyColoursToFirstRow


		* = * "C4"

		.for(var i=24 - BOTTOM_BORDER_ROWS - 1; i>TOP_BORDER_ROWS - 1 + 12 - BOTTOM_BORDER_ROWS; i--) {
			.for(var j=START_COLUMN + 1; j<END_COLUMN; j++) {
				lda VIC.COLOR_RAM + $00 + i * $28 + j
				sta VIC.COLOR_RAM + $28 + i * $28 + j	
			}
		}

		* = * "C5"

		.for(var j=START_COLUMN + 1; j<END_COLUMN; j++) {
				
				lda Temp + j - START_COLUMN - 1
				sta VIC.COLOR_RAM + $28  + j + ($28* (24 - BOTTOM_BORDER_ROWS - (12-1)))
		}
		

		lda ZP.PillAddress_1
		clc
		adc #40
		sta ZP.PillAddress_1

		lda ZP.PillAddress_1 + 1
		adc #0
		sta ZP.PillAddress_1 + 1

		lda ZP.PillAddress_3
		clc
		adc #40
		sta ZP.PillAddress_3

		lda ZP.PillAddress_3 + 1
		adc #0
		sta ZP.PillAddress_3 + 1

		inc ENERGIZER.CurrentPillRow
		inc ENERGIZER.CurrentPillRow + 2
		


		rts
		
	}

	CopyColoursToFirstRow: {

		ldy #0
		ldx #START_COLUMN

		Loop:

			lda (ZP.AboveColourAddress), y
			pha

			sty ZP.Y

			txa
			tay

			pla
			sta VIC.COLOR_RAM + (TOP_BORDER_ROWS * 40), y

			ldy ZP.Y	
			iny
			inx
			cpy #MAP_COLUMNS
			bcc Loop



		rts
	}


	ShiftMap0: {


		lda ZP_CurrentBuffer + 0
		clc
		adc #<[40 * TOP_BORDER_ROWS]
		sta Source + 1
		lda ZP_CurrentBuffer + 1
		adc #>[40 * TOP_BORDER_ROWS]
		sta Source + 2

		lda ZP_NextBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + 1)]	
		sta Dest + 1
		lda ZP_NextBuffer + 1
		clc
		adc #>[0 * (TOP_BORDER_ROWS + 1)]			
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

		//dec BufferingUp
		//jmp ShiftMap1_2

		rts
	}



	ShiftMap1: {

	
		lda ZP_CurrentBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + VIEWPORT_QUARTER_ROWS)]
		sta Source + 1
		lda ZP_CurrentBuffer + 1
		adc #>[40 * (TOP_BORDER_ROWS + VIEWPORT_QUARTER_ROWS)]
		sta Source + 2

		lda ZP_NextBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + VIEWPORT_QUARTER_ROWS + 1)]	
		sta Dest + 1
		lda ZP_NextBuffer + 1
		clc
		adc #>[40 * (TOP_BORDER_ROWS + VIEWPORT_QUARTER_ROWS + 1)]		
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

	ShiftMap2: {

		lda ZP_CurrentBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 2))]
		sta Source + 1
		lda ZP_CurrentBuffer + 1
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 2))]
		sta Source + 2

		lda ZP_NextBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 2)+ 1)]	
		sta Dest + 1
		lda ZP_NextBuffer + 1
		clc
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 2)+ 1)]		
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

		//dec BufferingUp
		//jmp ShiftMap3_2
		
		rts
	}

	ShiftMap3_2: {

	
		lda ZP_CurrentBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3))]
		sta Source + 1
		lda ZP_CurrentBuffer + 1
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3))]
		sta Source + 2

		lda ZP_NextBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3) + 1)]	
		sta Dest + 1
		lda ZP_NextBuffer + 1
		clc
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3) + 1)]		
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

	
		jsr CopyFromMapToFirstRow

		rts
	}

	ShiftMap3: {


		lda ZP_CurrentBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3))]
		sta Source + 1
		lda ZP_CurrentBuffer + 1
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3))]
		sta Source + 2

		lda ZP_NextBuffer + 0
		clc
		adc #<[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3) + 1)]	
		sta Dest + 1
		lda ZP_NextBuffer + 1
		clc
		adc #>[40 * (TOP_BORDER_ROWS + (VIEWPORT_QUARTER_ROWS * 3) + 1)]		
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

	
		jsr CopyFromMapToFirstRow

		rts
	}

	CopyFromMapToFirstRow: {

		lda ZP_NextBuffer
		sta ZP.DataAddress

		lda ZP_NextBuffer + 1
		sta ZP.DataAddress + 1

		lda #TOP_BORDER_ROWS
		beq NoAdjustNeeded

		lda ZP.DataAddress
		clc
		adc #<[TOP_BORDER_ROWS * 40]
		sta ZP.DataAddress

		lda ZP.DataAddress + 1
		clc
		adc #>[TOP_BORDER_ROWS * 40]
		sta ZP.DataAddress + 1


		NoAdjustNeeded:

		ldy #0
		ldx #START_COLUMN

		Loop:

			lda (ZP.AboveRowAddress), y
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


	MoveRowUp: {

		lda TopRow
		sec
		sbc #1

		jsr CalculateOtherRows
		jsr ValidateRows


		rts
	}

}