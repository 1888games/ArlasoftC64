DRAW: {

	* = * "-Draw"

	.label BlankCharacterID = 32


	Rows:	.byte GREEN, RED, RED, PURPLE, PURPLE, CYAN, CYAN, YELLOW, YELLOW, GREEN, GREEN	
			.byte RED, RED, PURPLE, PURPLE, CYAN, CYAN, GREEN, GREEN, RED, RED, CYAN, CYAN, YELLOW, YELLOW

	SideRows:	.byte BLACK, GREEN, CYAN, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, RED, PURPLE
			.byte BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, CYAN, BLACK, BLACK, GREEN, BLACK


	.label StartColumn = 1
	.label EndColumn = 26 + 1


	ClearScreen: {

		lda #BlankCharacterID
		ldx #0

		Loop:

			sta SCREEN_RAM + 0, x
			sta SCREEN_RAM + 250, x
			sta SCREEN_RAM + 500, x
			sta SCREEN_RAM + 750, x

			inx
			cpx #250
			beq Finish
			jmp Loop


		Finish:

		rts
	}



	DrawCredits: {

		lda MAIN.Credits
		clc
		adc #48

		sta SCREEN_RAM + 837

		lda #RED
		sta VIC.COLOR_RAM + 837

		rts
	}



	ClearCentre: {


		lda #<SCREEN_RAM
		sta ScreenAddress

		lda #>SCREEN_RAM
		sta ScreenAddress + 1


		ldx #0

		RowLoop:

			ldy #2
		
			ColumnLoop:

					lda #BlankCharacterID

				Colour:
				
					sta (ScreenAddress), y

					iny
					cpy #25
					bcc ColumnLoop

					lda ScreenAddress
					clc
					adc #40
					sta ScreenAddress

					lda ScreenAddress + 1
					adc #0
					sta ScreenAddress + 1

					inx
					cpx #24
					bcc RowLoop

		

		rts
	}

	SetDeadColourRam: {


		lda #<VIC.COLOR_RAM
		sta ScreenAddress

		lda #>VIC.COLOR_RAM
		sta ScreenAddress + 1


		ldx #0

		RowLoop:

			ldy #1
		
			ColumnLoop:

				cpx #12
				bcs Red

				cpy #10
				bcc Red
						
				cpy #18
				bcs Red

				Pink:

					lda #PURPLE
					jmp Colour

				Red:

					lda #RED

				Colour:
				
					sta (ScreenAddress), y

					iny
					cpy #EndColumn
					bcc ColumnLoop

					lda ScreenAddress
					clc
					adc #40
					sta ScreenAddress

					lda ScreenAddress + 1
					adc #0
					sta ScreenAddress + 1

					inx
					cpx #25
					bcc RowLoop

		rts

	}

	
	SetColourRam: {

		lda #<VIC.COLOR_RAM
		sta ScreenAddress

		lda #>VIC.COLOR_RAM
		sta ScreenAddress + 1

		ldx #0
		
		RowLoop:

			ldy #StartColumn

			ColumnLoop:

				cpy #2
				bcc Yellow

				cpy #26
				beq Yellow

				bcs Side

				jmp Normal

				Yellow:

					lda #YELLOW
					jmp Colour

				Side:

					lda SideRows, x
					jmp Colour

				Normal:

					lda Rows, x

				Colour:

					sta (ScreenAddress), y

					iny
					cpy #40
					bcc ColumnLoop

					lda ScreenAddress
					clc
					adc #40
					sta ScreenAddress

					lda ScreenAddress + 1
					adc #0
					sta ScreenAddress + 1

					inx
					cpx #25
					bcc RowLoop






		rts



	}



	MergeChars: {

		Source1:

			ldy Source1ID
			lda VIC.CharsetMSB, y
			sta TableAddress + 1

			lda VIC.CharsetLSB, y
			sta TableAddress

		Source2:

			ldy Source2ID
			lda VIC.CharsetMSB, y
			sta CharAddress + 1

			lda VIC.CharsetLSB, y
			sta CharAddress

		Destination:
		
			ldy DestinationID
			lda VIC.CharsetMSB, y
			sta BulletAddress + 1

			lda VIC.CharsetLSB, y
			sta BulletAddress


		ldy #7

		MergeLoop:

			lda (TableAddress), y
			ora (CharAddress), y
			sta (BulletAddress), y

			dey
			bpl MergeLoop

		rts	// y = destination

	}



	

}