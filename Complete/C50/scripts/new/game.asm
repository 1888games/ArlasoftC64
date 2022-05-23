GAME: {

		* = $032a  "Game"




		DrawCell: {








			rts
		}


		CalculateAddresses:{

			//get row for this position
			ldy ZP.Row
			lda ScreenRowLSB, y
		
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




	
}