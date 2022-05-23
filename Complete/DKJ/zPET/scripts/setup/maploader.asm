MAPLOADER: {


	DrawMap: {

		.label CHAR_ID = TEMP1
	 	.label BYTE_ID = TEMP2
	
		ldx #0

		ldy #0
		sty CHAR_ID

		lda #ZERO
		sta BYTE_ID

		//jmp Nope

		First: {

		Loop2: 

			lda SCREEN_DATA.Game, x
			sta $8000, x

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


		ldx #ZERO

		Second: {

		Loop2: 

			lda SCREEN_DATA.Game +256, x
			sta $8000 + 256, x

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

		ldx #ZERO

		Third: {

		Loop2: 

			lda SCREEN_DATA.Game +512, x
			sta $8000 + 512, x
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
	

		ldx #ZERO

		Fourth: {

		Loop2: 

			lda SCREEN_DATA.Game +768, x
			sta $8000 +768, x

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

		Nope:
			rts




	}




}