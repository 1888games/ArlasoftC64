PLOT: {

	.label CharID = TEMP2
	.label Row = TEMP3
	.label Column = TEMP4

	.label SCREEN_ADDRESS = VECTOR5
	.label COLOR_ADDRESS = VECTOR6

	CalculateAddresses:{

		 .label RowOffset = TEMP7

		//get row for this position
		ldy Row
		lda VIC.ScreenRowLSB, y
	
		// Get CharAddress
		
		clc
		adc Column

		sta SCREEN_ADDRESS
		sta COLOR_ADDRESS

		lda VIC.ScreenRowMSB, y	
		adc #0  // get carry bit from above
		sta RowOffset

		lda #>SCREEN_RAM
		clc
		adc RowOffset
		sta SCREEN_ADDRESS + 1

		lda #>VIC.COLOR_RAM
		clc
		adc RowOffset
		sta COLOR_ADDRESS +1

		rts

	}



	GetCharacter: {

		sty Row
		stx Column
	
		jsr CalculateAddresses

		ldy #ZERO
		lda (SCREEN_ADDRESS), y

		rts


	}


	PlotCharacter: {

		sty Row
		stx Column
		sta CharID

		jsr CalculateAddresses

		ldy #ZERO
		lda CharID
		sta (SCREEN_ADDRESS), y

		rts

	}


	ColorCharacter: {

		sta (COLOR_ADDRESS), y

		rts
	}


	

	




}