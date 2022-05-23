PLOT: {


	*=* "-Plot"

	.label COLOR_ADDRESS = ZP.ColourAddress
	.label SCREEN_ADDRESS = ZP.ScreenAddress


	CalculateAddresses:{

		//get row for this position
		ldy ZP.Row
		lda VIC.ScreenRowLSB, y
	
		// Get CharAddress
		
		clc
		adc ZP.Column

		sta SCREEN_ADDRESS
		sta COLOR_ADDRESS

		lda VIC.ScreenRowMSB, y	
		adc #0  // get carry bit from above
		sta ZP.RowOffset

		lda #>SCREEN_RAM
		clc
		adc ZP.RowOffset
		sta SCREEN_ADDRESS + 1

		lda #>VIC.COLOR_RAM
		clc
		adc ZP.RowOffset
		sta COLOR_ADDRESS +1


		rts

	}


	GetCharacter: {

		sty ZP.Row
		stx ZP.Column
	
		jsr CalculateAddresses

		ldy #ZERO
		lda (SCREEN_ADDRESS), y

		
		rts

	}

	

}
