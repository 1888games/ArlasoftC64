INSTRUCT: {



	BeanColours:	.byte PURPLE + 8, PURPLE+ 8, BLACK 
					.byte GREEN + 8, GREEN + 8, BLACK 
					.byte BLUE + 8, BLUE + 8, BLACK 
					.byte RED + 8, RED + 8, BLACK 
					.byte YELLOW + 8, YELLOW + 8, BLACK 
					.byte CYAN + 8, CYAN +8, BLACK 
					.byte PURPLE + 8, PURPLE + 8



	Show: {


		lda #0
		sta VIC.SPRITE_ENABLE

		lda #BLACK
		sta VIC.BORDER_COLOUR


		jsr DRAW.InstructionsScreen
		jsr ColourRows


		// lda #BLACK 
		// sta COLOR_RAM
		// sta COLOR_RAM + 39
		// sta COLOR_RAM + 960
		// sta COLOR_RAM + 999

		jmp InstructionsLoop


	}


	InstructionsLoop: {


		WaitForRasterLine:

			lda VIC.RASTER_LINE
			cmp #175
			bne WaitForRasterLine

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		jmp MENU.Show

		Finish:

		jmp InstructionsLoop
	}



	ColourRows: {

		ldx #0
		ldy #0

		lda #COLOR_RAM + 161
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 161
		sta ZP.ColourAddress + 1


		RowLoop:

			ColumnLoop:

				cpy #4
				bcc Bean


				Text:

				lda BeanColours, x
				sec
				sbc #8
				sta (ZP.ColourAddress), y
				jmp EndColumn

				Bean:


				lda BeanColours, x
			
				sta (ZP.ColourAddress), y

				EndColumn:

					iny
					cpy #4
					bcc ColumnLoop

					ldy #0
					
				EndRow:

					lda ZP.ColourAddress
					clc
					adc #40
					sta ZP.ColourAddress

					lda ZP.ColourAddress + 1
					adc #0
					sta ZP.ColourAddress + 1

					inx
					cpx #20
					bcc RowLoop





		rts
	}


}