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
	.label BUFFER_ADDRESS = VECTOR4

	.label TotalObjects  = 33- 1
	.label BlankCharacter = 0


GameScreenRowLSB:
		//.if(target == "PET") {
			.fill 25, <[SCREEN_DATA.Game + i * 40]
		//}
		

		
GameScreenRowMSB:
	//	.if(target == "PET") {
			.fill 25, >[SCREEN_DATA.Game + i * 40]
	//	}


	CalculateAddresses:{

		
		 .label RowOffset = TEMP7

		//get row for this position
		ldy Row
		lda VIDEO.ScreenRowLSB, y
	
		// Get CharAddress
		
		clc
		adc Column

		sta SCREEN_ADDRESS
		sta COLOR_ADDRESS

		lda VIDEO.ScreenRowMSB, y	
		adc #0  // get carry bit from above
		sta RowOffset

		lda SCREEN_RAM + 1
		clc
		adc RowOffset
		sta SCREEN_ADDRESS + 1

		lda COLOR_RAM + 1
		clc
		adc RowOffset
		sta COLOR_ADDRESS +1


		//.if(target == "PET") {

			lda GameScreenRowLSB, y
			clc
			adc Column
			sta BUFFER_ADDRESS
			
			lda GameScreenRowMSB, y
			adc #$00
			sta BUFFER_ADDRESS + 1

		//}



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
		sty Colour

		rts

	}

	ColourObject:{

		stx ObjectID
		.label ColourRequest = TEMP4
		sty ColourRequest

		cpy #ZERO
		beq Hide
		jsr GetColour

		ldy #ONE
		sty Colour
		jmp ColourObject

		Hide:

		ldy #BlankCharacter
		//ldy #12
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

			.if(target == "PETA") {

				beq ColourChar

				ldy ObjectID
				cpy #ONE
				bne ColourChar

				ldy Column
				cpy #ZERO
				bne ColourChar

				lda #3
				
				ColourChar:

				.if(target == "264") {

					clc
					adc #64

				}
				
				ldy #ZERO

				sta (SCREEN_ADDRESS), y
				//sta (COLOR_ADDRESS), y
			}

			else {

				ldy #ZERO
				cmp #BlankCharacter

				beq DrawBlank

				lda (BUFFER_ADDRESS), y

				DrawBlank:

				sta (SCREEN_ADDRESS), y

			}

			

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