DRAW: {

	*=* "Draw"


	MSB_On:		.byte %00000001, %00000010, %00000100,%00001000,%00010000,%00100000,%01000000,%10000000
	MSB_Off:	.byte %11111110, %11111101, %11111011,%11110111,%11101111,%11011111,%10111111,%01111111
	
	ScreenRowLSB:	.fill 25, <[i * $28]
	ScreenRowMSB:	.fill 25, >[i * $28]

	CharTimer:	.byte 3
	.label CharTime = 3

	ClearScreen: {

		ldx #0
		lda #0


		Loop:

			sta SCREEN_RAM + 0, x
			sta SCREEN_RAM + 250, x
			sta SCREEN_RAM + 500, x
			sta SCREEN_RAM + 750, x

			inx
			bne Loop



		rts
	}





	CalculateAddresses:{

		//get row for this position
		ldy ZP.Row
		lda ScreenRowLSB, y
	
		// Get CharAddress
		
		clc
		adc ZP.Column

		sta ZP.ScreenAddress
		sta ZP.ColourAddress

		lda ScreenRowMSB, y	
		adc #0  // get carry bit from above
		sta ZP.RowOffset

		lda #>SCREEN_RAM
		clc
		adc ZP.RowOffset
		sta ZP.ScreenAddress + 1

		lda #>COLOR_RAM
		clc
		adc ZP.RowOffset
		sta ZP.ColourAddress +1


		rts

	}


	GetCharacter: {

		sty ZP.Row
		stx ZP.Column
	
		jsr CalculateAddresses

		ldy #ZERO
		lda (ZP.ScreenAddress), y

		ldy ZP.Row
		ldx ZP.Column

		rts

	}



	GetColor: {

		sty ZP.Row
		stx ZP.Column
	
		jsr CalculateAddresses

		ldy #ZERO
		lda (ZP.ColourAddress), y
		and #%00001111

		ldy ZP.Row
		ldx ZP.Column

		rts

	}

	PlotCharacterWithAddress: {

		sty ZP.Row

		ldy #ZERO
		sta (ZP.ScreenAddress), y

		ldy ZP.Row


		Finish:

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
		sta (ZP.ScreenAddress), y


		ldy ZP.Row
		ldx ZP.Column
		lda ZP.CharID


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

		sta (ZP.ColourAddress), y

		ldy ZP.Row
		ldx ZP.Column
		lda ZP.Colour

		rts



	}

	

	ColorCharacter: {

		cpx #40
		bcs Finish

		sty ZP.Row
		
		ldy #0
		sta (ZP.ColourAddress), y

		ldy ZP.Row

		
		Finish:

		rts
	}


	

	


	GypsyScreen: {

		ldx #0
		
		Loop:

			lda GYPSY_MAP + 0, x
			sta SCREEN_RAM + 0, x

			tay
			lda GYPSY_COLORS, y
			sta COLOR_RAM + 0, x

			lda GYPSY_MAP  + 250, x
			sta SCREEN_RAM + 250, x

			tay
			lda GYPSY_COLORS, y
			sta COLOR_RAM + 250, x

			lda GYPSY_MAP + 500, x
			sta SCREEN_RAM + 500, x

			tay
			lda GYPSY_COLORS, y
			sta COLOR_RAM + 500, x

			lda GYPSY_MAP + 750, x
			sta SCREEN_RAM + 750, x

			tay
			lda GYPSY_COLORS, y
			sta COLOR_RAM + 750, x

			inx
			bne Loop


		rts

	}

	


	
}
