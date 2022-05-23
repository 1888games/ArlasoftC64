CHAR_DRAWING:{


	.label ObjectID = TEMP1
	.label StartAddress = VECTOR1
	.label BytesToRead = TEMP2
	.label Row = TEMP3
	.label Column = TEMP4
	.label ByteID = TEMP5
	.label SCREEN_RAM = VIC.SCREEN_RAM

	LoopID: .byte 0
	Colour: .byte 0

	.label COLOR_ADDRESS = VECTOR2

	.label TotalObjects = 57


	CalculateAddresses:{

		//get row for this position
		ldy Row

		lda VIC.ColorRowLSB, y
		clc
		adc Column
		sta COLOR_ADDRESS
		
		lda VIC.ColorRowMSB, y
		adc #$00
		sta COLOR_ADDRESS + 1

		

		rts

	}


	ClearAll:{


		ldx #ZERO

		//.break
		
		Loop:

			clc
			ldy #ZERO
			stx LoopID
			jsr ColourObject

			ldx LoopID
			//cpx #ONE
			cpx #TotalObjects
			beq Finish
			inx
			jmp Loop


		Finish:

			rts


	}


	GetColour:{

		ldy CHAR_DATA.ObjectType, x
		lda CHAR_DATA.TypeColours, y
		tay
		sty Colour

		rts

	}

	ColourObject:{

		stx ObjectID

		.label ColourRequest = TEMP4
		sty ColourRequest

		cpx #99
		beq Finish

		cpy #ZERO
		beq Hide
		jsr GetColour
		jmp ColourObject

		Hide:

		ldy #CYAN
		sty Colour

		ColourObject:
		
		lda CHAR_DATA.Sizes, x
		sta BytesToRead
		

		lda ObjectID 
		asl 
		tax
		
		lda CHAR_DATA.DataStart, x
		sta StartAddress
		inx
		lda CHAR_DATA.DataStart, x
		sta StartAddress + 1

		ldy #ZERO

		Loop:

			lda (StartAddress), y
			sta Column

			iny
			lda (StartAddress), y
			sta Row

			sty ByteID

			jsr CalculateAddresses

			lda Colour
			
			ColourChar:
			
			ldy #ZERO

			sta (COLOR_ADDRESS), y

			ldy ByteID

			iny
			cpy BytesToRead
			beq Finish
			jmp Loop


		Finish:

			ldx ObjectID
			ldy ColourRequest

			rts



	}





}