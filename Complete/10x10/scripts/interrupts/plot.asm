PLOT: {


	.label COLOR_ADDRESS = VECTOR1
	.label SCREEN_ADDRESS = VECTOR2


	CalculateAddresses:{

		
		

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

	GetColor: {

		sty Row
		stx Column
	
		jsr CalculateAddresses


		ldy #ZERO
		lda (COLOR_ADDRESS), y
		and #%00001111

		ldy Row
		ldx Column


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

	ColorCharacterOnly: {


		sty Row
		stx Column
		sta CharID

		jsr CalculateAddresses

		ldy #ZERO
		lda CharID

		sta (COLOR_ADDRESS), y



		ldy Row
		ldx Column
		lda CharID

		rts



	}

	ColorCharacter: {

		sta (COLOR_ADDRESS), y

		rts
	}


	

	




}