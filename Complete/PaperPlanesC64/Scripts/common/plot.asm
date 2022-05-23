PLOT: {


	*=* "-Plot"

	.label COLOR_ADDRESS = ZP.ColourAddress
	.label SCREEN_ADDRESS = ZP.ScreenAddress


	CalculateAddresses:{

		//get row for this position
		ldy ZP.Row
		cpy #25
		bcc Okay

	//	.break
		//nop
	//	rts

		InvalidRow:

		Okay:

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

		ldy ZP.Row
		ldx ZP.Column

		rts

	}


	
	PlotCharacter: {

		cpx #40
		bcs Finish

		sty ZP.Row
		stx ZP.Column
		sta ZP.CharID

		jsr CalculateAddresses

		ldy #ZERO
		lda ZP.CharID
		sta (SCREEN_ADDRESS), y


		ldy ZP.Row
		ldx ZP.Column
		lda ZP.CharID


		Finish:


		rts

	}

	

	ColorCharacter: {

		ldy #0
		sta (COLOR_ADDRESS), y

		Finish:

		rts
	}


	

}
