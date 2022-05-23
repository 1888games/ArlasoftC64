PLOT: {


	*=* "-Plot"

	.label COLOR_ADDRESS = ZP.ColourAddress
	.label SCREEN_ADDRESS = ZP.ScreenAddress


	CalculateAddresses:{

		lda VIC.ScreenRowLSB, y
		clc
		adc ZP.Column

		sta ZP.ScreenAddress
		sta ZP.ColourAddress

		lda VIC.ScreenRowMSB, y	
		adc #0  // get carry bit from above
		sta ZP.RowOffset

		lda #>SCREEN_RAM
		clc
		adc ZP.RowOffset
		sta ZP.ScreenAddress + 1

		lda #>VIC.COLOR_RAM
		clc
		adc ZP.RowOffset
		sta ZP.ColourAddress + 1

		rts

	}

	PlotCharacter: {

		cpx #40
		bcs Finish

		cpy #25
		bcs Finish

		sty ZP.Row
		stx ZP.Column
		sta ZP.CharID

		jsr CalculateAddresses

		ldy #ZERO
		lda ZP.CharID
		sta (ZP.ScreenAddress), y

		Finish:

		rts

	}


	PlotStar: {

		lda ZP.Row
		cmp #25
		bcs Finish

		stx ZP.Column
		
		jsr CalculateAddresses

		CheckCanOverwrite:

			ldy #ZERO
			lda (SCREEN_ADDRESS), y
			beq Okay

			cmp #197
			bcc Finish

			cmp #205
			bcs Finish

		Okay:

			lda ZP.CharID
			sta (SCREEN_ADDRESS), y

			lda ZP.Colour

			jsr PLOT.ColorCharacter

		Finish:

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


	PlotText: {

		sta ZP.CharID

		lda ZP.Column
		sta ZP.Temp1

		stx ZP.Column
		sty ZP.Row	

		jsr CalculateAddresses

		ldy #ZERO
		lda ZP.CharID
		sta (SCREEN_ADDRESS), y

		ldy ZP.Row
		ldx ZP.Temp1
		stx ZP.Column
		
		rts

	}


	
	PlotCharacter: {

		cpx #40
		bcs Finish

		cpy #25
		bcs Finish

		sty ZP.Row
		stx ZP.Column
		sta ZP.CharID

		jsr CalculateAddresses

		ldy #ZERO
		lda ZP.CharID
		sta (ZP.ScreenAddress), y

		Finish:

		rts

	}

	ColorCharacterOnly: {

		sty ZP.Row
		stx ZP.Column
		sta ZP.Colour

		jsr CalculateAddresses

		ldy #ZERO
		lda ZP.Colour

		sta (COLOR_ADDRESS), y

		ldy ZP.Row
		ldx ZP.Column
		lda ZP.Colour

		rts



	}

	

	ColorCharacter: {

		ldy #0
		sta (COLOR_ADDRESS), y

		Finish:

		rts
	}


	

}
