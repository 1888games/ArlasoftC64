SCROLLER: {



	ScrollTimer: .byte 6, 0
	VScroll:	.byte 0, 0

	Active: .byte 0
	RowCounter: .byte 0, 2
	ScrollDelay: .byte 0, 30

	Times3Table: .byte 3, 6, 9, 12, 15, 18



	Reset: {

		lda ScrollTimer + 1
		sta ScrollTimer

		lda #7
		sta VScroll

		lda VIC.SCREEN_CONTROL
		and #%11111000
		ora VScroll
		sta VIC.SCREEN_CONTROL

		lda #1
		sta Active

		//jsr NewScroll

		jsr InitialScroll
		

		rts
	}


	InitialScroll: {



		lda Times3Table + 4
		sta RowCounter + 1

		lda #0
		sta RowCounter

		sta ScrollDelay

		rts

	}

	Update: {

	//	rts

		lda ScrollDelay
		beq ReadyToScroll

		dec ScrollDelay
		jmp Finish


		ReadyToScroll:

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

			//inc SPRITE.PosY


			dec VScroll
			dec VScroll
			lda VScroll
			cmp #255
			beq MoveCharacters

			jmp DontMove

			MoveCharacters:

			lda #7
			sta VScroll



			lda VIC.SCREEN_CONTROL
			and #%11111000
			ora VScroll
		//	sta VIC.SCREEN_CONTROL


		


			.for(var y=0; y<24; y++) {
				
				.for(var x=0; x<27; x++) {

					lda SCREEN_RAM + 40 + x + (y * 40)
					sta SCREEN_RAM + 00 + x + (y * 40)

					lda VIC.COLOR_RAM + 40 + x + (y * 40) 
					sta VIC.COLOR_RAM + 00 + x + (y * 40)
				}
			}

		//	jsr BLOCK.NextRow

			lda #1
			sta BLOCK.ScrolledLastFrame

			//dec PLATFORM.CurrentRow

			inc RowCounter
			lda RowCounter
			cmp RowCounter + 1
			bcc Finish



			lda #0
			sta Active
			sta RowCounter

			lda #1
			sta SPRITE.Active

		

			jmp Finish

	

			DontMove:


			lda VIC.SCREEN_CONTROL
			and #%11111000
			ora VScroll
			//sta VIC.SCREEN_CONTROL



		Finish:

			rts


	}



	NewScroll: {

		jsr RANDOM.Get
		and #%00000011
		tax

		lda Times3Table, x
		sta RowCounter + 1

		lda #0
		sta RowCounter

		jsr RANDOM.Get
		and #%00001111

		sta ScrollDelay



		rts





	}
}