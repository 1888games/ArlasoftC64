SCROLLER: {



	ScrollTimer: .byte 6, 0
	VScroll:	.byte 0

	Active: .byte 0
	RowCounter: .byte 0


	Reset: {

		lda ScrollTimer + 1
		sta ScrollTimer

		lda #0
		sta VScroll

		lda VIC.SCREEN_CONTROL
		and #%11111000
		ora VScroll
		sta VIC.SCREEN_CONTROL

		rts
	}


	Update: {

	//	rts

		lda Active
		bne Okay

		jmp Finish

		Okay:

		lda ScrollTimer
		beq Scroll

		dec ScrollTimer
		jmp Finish

		Scroll:


			lda ScrollTimer + 1
			sta ScrollTimer

			inc SPRITE.PosY

			inc VScroll
			lda VScroll
			cmp #8
			beq MoveCharacters

			jmp DontMove



			MoveCharacters:



			lda #0
			sta VScroll



			lda VIC.SCREEN_CONTROL
			and #%11111000
			ora VScroll
			sta VIC.SCREEN_CONTROL


			.for(var y=0; y<11; y++) {
				
				.for(var x=0; x<19; x++) {

					lda SCREEN_RAM + 930 + x - (y * 40)
					sta SCREEN_RAM + 970 + x -  (y * 40)

					lda VIC.COLOR_RAM + 930 + x - (y * 40) 
					sta VIC.COLOR_RAM + 970 +x - (y * 40)
				}
			}

			//dec PLATFORM.CurrentRow

			inc RowCounter
			lda RowCounter
			cmp #2
			bne Finish

			lda #0
			sta Active

			lda #0
			sta RowCounter

			jsr PLATFORM.Generate

			jmp Finish

	

			DontMove:


			lda VIC.SCREEN_CONTROL
			and #%11111000
			ora VScroll
			sta VIC.SCREEN_CONTROL



		Finish:

			rts


	}
}