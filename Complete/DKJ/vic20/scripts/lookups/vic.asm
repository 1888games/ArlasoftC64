VIC: {

.label SCREEN_RAM = $1000
.label COLOR_RAM = $9400
.label BORDER_BACKGROUND = $900f
.label CHAR_RAM = $9005
.label ROWS_AND_8v16 = $9003
.label AUX_COLOR_AND_VOl = $900E
.label RASTER_LINE = $9004

ScreenRowLSB:
		.fill 23, <[SCREEN_RAM + i * 22]
ScreenRowMSB:
		.fill 23, >[SCREEN_RAM + i * 22]

ColorRowLSB:
		.fill 23, <[COLOR_RAM + i * 22]
ColorRowMSB:
		.fill 23, >[COLOR_RAM + i * 22]



Setup:{

	

		lda #%00111101
		sta BORDER_BACKGROUND

		lda CHAR_RAM
		ora #%00001111  // $1C00
		//sta CHAR_RAM

		lda ROWS_AND_8v16
		and #%00101101
		sta ROWS_AND_8v16

		lda #223
		sta AUX_COLOR_AND_VOl


		rts

}


ConvertCharacterSet: {

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


	rts


	}

	


}