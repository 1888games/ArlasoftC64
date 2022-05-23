CHAR_DRAWING:{


	.label ObjectID = TEMP1
	.label StartAddress = VECTOR1
	.label BytesToRead = TEMP2
	.label Row = TEMP3
	.label Column = TEMP4
	.label ByteID = TEMP5
	.label SCREEN_RAM = VIC.SCREEN_RAM
	.label SCREEN_ADDRESS = VECTOR2
	.label BUFFER_ADDRESS = VECTOR3

	LoopID: .byte 0
	Colour: .byte 0


	.label TotalObjects = 57

	CurrentColour: .byte 0

	.label BlankCharacter = 96


	CalculateAddresses:{

		//get row for this position
		ldy Row

		lda VIC.ScreenRowLSB, y
		clc
		adc Column
		sta SCREEN_ADDRESS
		
		lda VIC.ScreenRowMSB, y
		adc #$00
		sta SCREEN_ADDRESS + 1

		lda VIC.GameScreenRowLSB, y
		clc
		adc Column
		sta BUFFER_ADDRESS
		
		lda VIC.GameScreenRowMSB, y
		adc #$00
		sta BUFFER_ADDRESS + 1



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

		ldy CurrentColour
		ldy #BlankCharacter
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
			cmp #BlankCharacter

			beq DrawBlank

			lda (BUFFER_ADDRESS), y

			DrawBlank:
	
			sta (SCREEN_ADDRESS), y

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