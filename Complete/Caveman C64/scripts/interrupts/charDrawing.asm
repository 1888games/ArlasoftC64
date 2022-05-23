CHAR_DRAWING:{


	.label ObjectID = TEMP1
	.label StartAddress = VECTOR1
	.label BytesToRead = TEMP2
	.label Row = TEMP3
	.label Column = TEMP4
	.label ByteID = TEMP5

	LoopID: .byte 0
	Colour: .byte 0

	.label SCREEN_ADDRESS = VECTOR5
	.label COLOR_ADDRESS = VECTOR6

	.label TotalObjects = 54


	CalculateAddresses:{

		//get row for this position
		ldy Row

		//sty $d020

		// Get CharAddress
		lda VIC.ScreenRowLSB, y
		clc
		adc Column


		sta SCREEN_ADDRESS
		sta COLOR_ADDRESS

		lda VIC.ScreenRowMSB, y
		adc #$00
		sta SCREEN_ADDRESS + 1

		// Calculate colour ram address
		adc #>[VIC.COLOR_RAM-SCREEN_RAM]
		sta COLOR_ADDRESS +1

		rts

	}


	ClearAll:{

		ldx #ZERO
		
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

		rts

	}

	ColourObject:{

		stx ObjectID
		.label ColourRequest = TEMP4
		sty ColourRequest

		cpy #ZERO
		beq Hide
		jsr GetColour

		Hide:
	///	lda MAIN.BackgroundColour
		sty Colour
		
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
			beq NotDino

			lda Column
			cmp #30
			bne NotDino

			lda Row
			cmp #7
			bne NotDino

			lda #CYAN
			jmp ColourChar


			NotDino:

			lda Colour
			beq ColourChar

			ldy ObjectID
			cpy #ONE
			bne ColourChar

			ldy Column
			cpy #ZERO
			bne ColourChar

			lda #ONE
			
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