LOGO: {


	ActivisionCharset:	.fill 88, 0
	CopyrightCharset:	.fill 88, 0

	Active: .byte 1
	Timer: .byte 0, 5, 90
	ShiftStage:		.byte 8



	Update: {

		lda Active
		beq Finish

		lda Timer
		beq ReadyToUpdate

		dec Timer
		jmp Finish


		ReadyToUpdate:

		lda ShiftStage
		cmp #8
		beq FlipBackToCopyright

		cmp #9
		beq StartScrolling

		jsr ShiftRow

		lda Timer + 1
		sta Timer

		lda ShiftStage
		cmp #8
		bne Finish

		lda Timer + 2
		sta Timer

		jmp Finish

		StartScrolling:

			lda Timer + 1
			sta Timer

			lda #0
			sta ShiftStage
			jmp Finish


		FlipBackToCopyright:

			jsr ShowCopyright
			inc ShiftStage

			lda Timer + 2
			sta Timer
			jmp Finish



		Finish:



		rts
	}




	ShowCopyright: {

		.for(var i=0; i<88; i++) {

			lda CopyrightCharset + i
			sta CHAR_SET + (108 * 8) + i
			
		}
		

		



		rts
	}


	ShiftRow: {

		ldx #0

		Loop:

			lda CHAR_SET + (108 * 8) + 1, x
			sta CHAR_SET + (108 * 8) + 0, x
			lda CHAR_SET + (108 * 8) + 2, x
			sta CHAR_SET + (108 * 8) + 1, x
			lda CHAR_SET + (108 * 8) + 3, x
			sta CHAR_SET + (108 * 8) + 2, x
			lda CHAR_SET + (108 * 8) + 4, x
			sta CHAR_SET + (108 * 8) + 3, x
			lda CHAR_SET + (108 * 8) + 5, x
			sta CHAR_SET + (108 * 8) + 4, x
			lda CHAR_SET + (108 * 8) + 6, x
			sta CHAR_SET + (108 * 8) + 5, x
			lda CHAR_SET + (108 * 8) + 7, x
			sta CHAR_SET + (108 * 8) + 6, x

			stx New_X_index

			lda ShiftStage
			clc
			adc New_X_index
			tay

			lda ActivisionCharset, y
			sta CHAR_SET + (108 * 8) + 7, x

			txa
			clc
			adc #8
			tax

			cpx #96
			beq Finish
			jmp Loop

		Finish:


		inc ShiftStage











		rts
	}


	PutRightCharactersIn: {

		ldy #108
		ldx #0

		Loop:

			tya

			sta SCREEN_RAM + 967, x

			inx
			iny
			cpx #11
			beq Finish2
			jmp Loop

		
		Finish2:

		ldx #0

		Loop2:

			lda #0
			sta SCREEN_RAM + 983, x
			inx
			iny
			cpx #11
			beq Finish
			jmp Loop2

		Finish:

			rts






	}


	ShowActivision: {

		.for(var i=0; i<88; i++) {

			lda ActivisionCharset + i
			sta CHAR_SET + (108 * 8) + i
			
		}
		


		lda #8
		sta ShiftStage
	
		lda Timer + 2
		sta Timer



		rts
	}



	GrabCharacters: {

		lda #8
		sta ShiftStage

		lda #0
		ldx #0
		sta Timer

		CheckLoop:

			lda CHAR_SET + (3 * 8), x
			sta ActivisionCharset + 0, x

			lda CHAR_SET + (5 * 8), x
			sta ActivisionCharset + 8, x

			lda CHAR_SET + (8 * 8), x
			sta ActivisionCharset + 16, x

			lda CHAR_SET + (9 * 8), x
			sta ActivisionCharset+ 24, x

			lda CHAR_SET + (12 * 8), x
			sta ActivisionCharset + 32, x

			lda CHAR_SET + (13 * 8), x
			sta ActivisionCharset + 40, x

			lda CHAR_SET + (15 * 8), x
			sta ActivisionCharset + 48, x

			lda CHAR_SET + (17 * 8), x
			sta ActivisionCharset + 56, x

			lda CHAR_SET + (107 * 8), x
			sta ActivisionCharset + 64, x

			lda CHAR_SET + (107 * 8), x
			sta ActivisionCharset + 72, x

			lda CHAR_SET + (107 * 8), x
			sta ActivisionCharset + 80, x


			lda CHAR_SET + (92 * 8), x
			sta CopyrightCharset + 0, x

			lda CHAR_SET + (93 * 8), x
			sta CopyrightCharset + 8, x

			lda CHAR_SET + (94 * 8), x
			sta CopyrightCharset + 16, x

			lda CHAR_SET + (95 * 8), x
			sta CopyrightCharset+ 24, x

			lda CHAR_SET + (96 * 8), x
			sta CopyrightCharset + 32, x

			lda CHAR_SET + (97 * 8), x
			sta CopyrightCharset + 40, x

			lda CHAR_SET + (98 * 8), x
			sta CopyrightCharset + 48, x

			lda CHAR_SET + (99 * 8), x
			sta CopyrightCharset + 56, x

			lda CHAR_SET + (100 * 8), x
			sta CopyrightCharset + 64, x

			lda CHAR_SET + (101 * 8), x
			sta CopyrightCharset + 72, x

			lda CHAR_SET + (102 * 8), x
			sta CopyrightCharset + 80, x


			inx
			cpx #8
			beq Finish
			jmp CheckLoop


		Finish:


		jsr PutRightCharactersIn
		jsr ShowCopyright
	


		rts
	}




	
}