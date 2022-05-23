UTILITY: {

	* = * "Utility"

	BankOutKernalAndBasic:{

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta PROCESSOR_PORT
		rts
	}

	BankInKernal: {

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000110
		sta PROCESSOR_PORT
		rts

	}
	
	

	ClearScreen: {

		ldx #250
		lda #0


		Loop:

			sta SCREEN_RAM - 1, x
			sta SCREEN_RAM + 249, x
			sta SCREEN_RAM + 499, x
			sta SCREEN_RAM + 749, x

			dex
			bne Loop


		rts	


	}


	BlockBorders: {

		sta ZP.Temp4
		stx ZP.CharID

		ldx #0
		
		Loop:

			stx ZP.X
			
			txa
			tay

			ldx #0

			jsr PLOT.GetCharacter

			ldy #0

		ColumnLoop:

			lda ZP.CharID
			sta (ZP.ScreenAddress), y

			lda #BLACK
			sta (ZP.ColourAddress), y

			iny
			cpy ZP.Temp4
			bcc ColumnLoop

			beq Skip

			cpy #40
			bcc ColumnLoop

			ldx ZP.X
			inx
			cpx #25
			bcc Loop

			rts

		Skip:

			ldy #34
			jmp ColumnLoop

		rts
	}


	DeleteText: {

		sta ZP.Amount

		jsr PLOT.GetCharacter

		ldy #0
		lda #0

		Loop:


			sta (ZP.ScreenAddress), y

			iny
			cpy ZP.Amount
			bcc Loop


		rts
	}
}