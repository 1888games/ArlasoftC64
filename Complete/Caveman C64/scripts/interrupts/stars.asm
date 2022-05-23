STARS:{

	Column: .byte 0
	Row: 	.byte 0

	Rows: .byte 0, 0, 0, 0
	Columns: .byte 99, 99, 99, 99
	TimeLeft: .byte 5, 25, 10, 40


	StarChars: .byte 0, 3, 1, 4, 5, 3, 7, 4
			.byte 5, 8, 9, 6, 13, 10, 14, 3
			.byte 17, 3, 17, 9, 21, 5, 21, 8
			.byte 26, 3, 27, 5,34, 6, 38, 3


	.label StarCharacter = 239

	.label SCREEN_ADDRESS = VECTOR5
	.label COLOR_ADDRESS = VECTOR6

	CalculateAddresses:{

		//get row for this position
		ldy Row

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

	Update:{

		ldx #ZERO

		Loop:

			lda TimeLeft, x
			beq NewStar

			ldy TimeLeft, x
			dey
			tya
			sta TimeLeft, x

			jmp EndLoop

			NewStar:

				//inc $d020

				lda Rows, x
				beq NoDelete

				sta Row
				lda Columns, x
				sta Column
				jsr CalculateAddresses

				lda #ZERO
				ldy #ZERO
				sta (COLOR_ADDRESS), y

				NoDelete:


				jsr MAIN.Random
				lsr
				lsr
				lsr		
				lsr		

				//.break
				//and #$20
				asl
				tay
				lda StarChars, y

				sta Column
				sta Columns, x
				iny
				lda StarChars, y
				sta Row
				sta Rows, x

				jsr CalculateAddresses

				lda #ONE
				ldy #ZERO
				sta (COLOR_ADDRESS), y

				jsr MAIN.Random
				lsr
				lsr
				lsr
				lsr
				adc #20
				sta TimeLeft, x

			EndLoop:

				inx
				cpx #4
				bcc Loop


		Finish:

			

			rts




	}


}