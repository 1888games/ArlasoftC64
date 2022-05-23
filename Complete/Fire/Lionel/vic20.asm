
VIC20: {

	.label Memory_Setup_Register = $9005

	CharLookup:

	.if (target == "VIC") {

	 .byte %00000000,%00000011,%00000001,%00000010,%00001100,%00001111,%00001101,%00001110,%00000100,%00000111,%00000101,%00000110,%00001000,%00001011,%00001001,%00001010,%00110000,%00110011,%00110001,%00110010,%00111100,%00111111,%00111101,%00111110,%00110100,%00110111,%00110101,%00110110,%00111000,%00111011,%00111001,%00111010,%00010000,%00010011,%00010001,%00010010,%00011100,%00011111,%00011101,%00011110,%00010100,%00010111,%00010101,%00010110,%00011000,%00011011,%00011001,%00011010,%00100000,%00100011,%00100001,%00100010,%00101100,%00101111,%00101101,%00101110,%00100100,%00100111,%00100101,%00100110,%00101000,%00101011,%00101001,%00101010,%11000000,%11000011,%11000001,%11000010,%11001100,%11001111,%11001101,%11001110,%11000100,%11000111,%11000101,%11000110,%11001000,%11001011,%11001001,%11001010,%11110000,%11110011,%11110001,%11110010,%11111100,%11111111,%11111101,%11111110,%11110100,%11110111,%11110101,%11110110,%11111000,%11111011,%11111001,%11111010,%11010000,%11010011,%11010001,%11010010,%11011100,%11011111,%11011101,%11011110,%11010100,%11010111,%11010101,%11010110,%11011000,%11011011,%11011001,%11011010,%11100000,%11100011,%11100001,%11100010,%11101100,%11101111,%11101101,%11101110,%11100100,%11100111,%11100101,%11100110,%11101000,%11101011,%11101001,%11101010,%01000000,%01000011,%01000001,%01000010,%01001100,%01001111,%01001101,%01001110,%01000100,%01000111,%01000101,%01000110,%01001000,%01001011,%01001001,%01001010,%01110000,%01110011,%01110001,%01110010,%01111100,%01111111,%01111101,%01111110,%01110100,%01110111,%01110101,%01110110,%01111000,%01111011,%01111001,%01111010,%01010000,%01010011,%01010001,%01010010,%01011100,%01011111,%01011101,%01011110,%01010100,%01010111,%01010101,%01010110,%01011000,%01011011,%01011001,%01011010,%01100000,%01100011,%01100001,%01100010,%01101100,%01101111,%01101101,%01101110,%01100100,%01100111,%01100101,%01100110,%01101000,%01101011,%01101001,%01101010,%10000000,%10000011,%10000001,%10000010,%10001100,%10001111,%10001101,%10001110,%10000100,%10000111,%10000101,%10000110,%10001000,%10001011,%10001001,%10001010,%10110000,%10110011,%10110001,%10110010,%10111100,%10111111,%10111101,%10111110,%10110100,%10110111,%10110101,%10110110,%10111000,%10111011,%10111001,%10111010,%10010000,%10010011,%10010001,%10010010,%10011100,%10011111,%10011101,%10011110,%10010100,%10010111,%10010101,%10010110,%10011000,%10011011,%10011001,%10011010,%10100000,%10100011,%10100001,%10100010,%10101100,%10101111,%10101101,%10101110,%10100100,%10100111,%10100101,%10100110,%10101000,%10101011,%10101001,%10101010

	}

	.label Channel1 = $900A
	.label Channel2 = $900B
	.label Channel3 = $900C
	.label Channel4 = $900D

	Countdown: .byte 0, 0, 0
	Channels: .word Channel1, Channel2, Channel3

	Channel: .byte 0


	PlayNote: {


		.if (target == "VIC") {

			txa
			pha


			asl
			tax
			lda Channels, x
			sta Address + 1
			inx
			lda Channels, x
			sta Address + 2

			lda <SOUND.NoteValue

			Address:
			
			sta $BEEF

			pla
			tax

		}

		rts
	}

	StopNote: {


		.if (target == "VIC") {
	
			txa
			pha

			asl
			tax
			lda Channels, x
			sta Address + 1
			inx
			lda Channels, x
			sta Address + 2

			lda #ZERO

			Address:
			
			sta $BEEF

			pla
			tax

		}

		rts

	}

	ConvertCharacterSet: {

		.if (target == "VIC") {

			.label CHAR_ID = TEMP1
		 	.label BYTE_ID = TEMP2
		
			ldx #0

			ldy #0
			sty CHAR_ID

			lda #ZERO
			sta BYTE_ID

			//sjmp Nope

			First: {

			Loop2: 

				//.break

				ldy CHAR_ID

				lda IsMulti, y
			//	lda #ZERO
				beq CheckNextChar

				lda CHAR_SET, x
				tay

				lda CharLookup, y
				sta CHAR_SET, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}

			lda CHAR_ID

			ldx #0

			//jmp Nope

			Second: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMulti, y
				beq CheckNextChar

				lda CHAR_SET + 256, x
				tay

				lda CharLookup, y
				sta CHAR_SET + 256, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}

			Third: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMulti, y
				beq CheckNextChar

				lda CHAR_SET + 256, x
				tay

				lda CharLookup, y
				sta CHAR_SET + 256, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}

			Fourth: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMulti, y
				beq CheckNextChar

				lda CHAR_SET +256, x
				tay

				lda CharLookup, y
				sta CHAR_SET + 256, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}
		}


		rts


		}

		ConvertTitleSet: {

			.if (target == "VIC") {

			.label CHAR_ID = TEMP1
		 	.label BYTE_ID = TEMP2
		
			ldx #0

			ldy #0
			sty CHAR_ID

			lda #ZERO
			sta BYTE_ID

			//sjmp Nope

			First: {

			Loop2: 

				//.break

				ldy CHAR_ID

				lda IsMultiTitle, y
			//	lda #ZERO
				beq CheckNextChar

				lda TITLE_CHAR_SET, x
				tay

				lda CharLookup, y
				sta TITLE_CHAR_SET, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}

			lda CHAR_ID
			ldx #0

			//jmp Nope

			Second: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMultiTitle, y
				beq CheckNextChar

				lda TITLE_CHAR_SET + 256, x
				tay

				lda CharLookup, y
				sta TITLE_CHAR_SET + 256, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}

			ldx #0
			Third: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMultiTitle, y
				beq CheckNextChar

				lda TITLE_CHAR_SET + 512, x
				tay

				lda CharLookup, y
				sta TITLE_CHAR_SET + 512, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}

				ldx #0
			Fourth: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMultiTitle, y
				beq CheckNextChar

				lda TITLE_CHAR_SET +768, x
				tay

				lda CharLookup, y
				sta TITLE_CHAR_SET + 768, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}
			ldx #0
			Fifth: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMultiTitle, y
				beq CheckNextChar

				lda TITLE_CHAR_SET +1024, x
				tay

				lda CharLookup, y
				sta TITLE_CHAR_SET + 1024, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}

				ldx #0
			Sixth: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMultiTitle, y
				beq CheckNextChar

				lda TITLE_CHAR_SET +1280, x
				tay

				lda CharLookup, y
				sta TITLE_CHAR_SET + 1280, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}

			ldx #0
			Seventh: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMultiTitle, y
				beq CheckNextChar

				lda TITLE_CHAR_SET +1536, x
				tay

				lda CharLookup, y
				sta TITLE_CHAR_SET + 1536, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}

			ldx #0
			Eighth: {

			Loop2: 

				//.break

				ldy CHAR_ID
				lda IsMultiTitle, y
				beq CheckNextChar

				lda TITLE_CHAR_SET +1792, x
				tay

				lda CharLookup, y
				sta TITLE_CHAR_SET + 1792, x

				CheckNextChar:
					inc BYTE_ID
					lda BYTE_ID
					cmp #8
					beq NewChar
					jmp EndLoop

				NewChar:

					inc CHAR_ID
					lda #0
					sta BYTE_ID

				EndLoop:

					cpx #255
					beq Finish2
					inx
					jmp Loop2

			Finish2:

			}
		}


	rts


	}

	
}

.macro SetVICScreenMemory (location) {

	.if(target == "VIC") {


		lda #<location
		sta SCREEN_RAM
		lda #>location
		sta SCREEN_RAM + 1

	}

}


.macro SetVICCharacterMemory(location) {


	.if(target == "VIC") {

		.label ShiftedPointer = TEMP1
		lda #VICCharRamLocations.get(location)
		sta ShiftedPointer

		lda VIC20.Memory_Setup_Register
		and #%11110000
		ora ShiftedPointer
		sta VIC20.Memory_Setup_Register

	}



}


.macro SetVICRows(value) {

	.if(target == "VIC") {

		.label ValueToAnd = TEMP1

		lda value
		asl
		clc
		adc #01
		sta ValueToAnd

		lda $9003
		and ValueToAnd
		sta $9003
	}


}


	.var VICCharRamLocations = Hashtable()
	.var NoteValuesVIC = Hashtable()
	

	.eval VICCharRamLocations.put($8000, 0)
	.eval VICCharRamLocations.put($8400, 1)
	.eval VICCharRamLocations.put($8800, 2)
	.eval VICCharRamLocations.put($8C00, 3)
	.eval VICCharRamLocations.put($0000, 8)
	.eval VICCharRamLocations.put($1000, 12)
	.eval VICCharRamLocations.put($1400, 13)
	.eval VICCharRamLocations.put($1800, 14)
	.eval VICCharRamLocations.put($1C00, 15)

	IsMulti: 

	.if(target == "VIC") {
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 1, 1
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0

		}

 IsMultiTitle: 	

 	.if(target == "VIC") {

		.byte 1, 1, 1, 1, 1, 1, 1, 1
		.byte 0, 1, 1, 1, 1, 1, 1, 0
		.byte 0, 1, 0, 0, 0, 1, 1, 1
		.byte 1, 1, 1, 1, 1, 1, 1, 1

		.byte 1, 1, 1, 0, 1, 1, 1, 1
		.byte 1, 1, 1, 1, 1, 1, 1, 1
		.byte 1, 1, 0, 1, 1, 1, 1, 1
		.byte 0, 1, 1, 1, 1, 1, 1, 1

		.byte 1, 1, 1, 1, 1, 1, 1, 1
		.byte 1, 1, 1, 1, 1, 1, 1, 1
		.byte 1, 0, 1, 1, 1, 1, 1, 1
		.byte 1, 1, 1, 1, 1, 1, 1, 1

		.byte 1, 1, 1, 1, 1, 1, 1, 1
		.byte 1, 1, 1, 1, 1, 1, 1, 1
		.byte 1, 1, 1, 1, 1, 1, 1, 1
		.byte 1, 0, 1, 1, 1, 1, 1, 1

		.byte 1, 1, 1, 1, 1, 0, 0, 1
		.byte 1, 1, 1, 1, 1, 1, 1, 1
		.byte 1, 0, 1, 0, 1, 1, 0, 1
		.byte 0, 0, 1, 1, 1, 1, 1, 0

		.byte 1, 1, 1, 1, 1, 1, 1, 1
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0

		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 1, 1, 1, 1, 1, 1, 1
		.byte 1, 1, 1, 1, 0, 1, 1, 1
	}

