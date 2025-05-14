COMPLETE: {

	* = * "COMPLETE"


	Flashes:		.byte 0
	FlashTimer:		.byte 0
	PelletsCleared:	.byte 0

	.label NUM_FLASHES = 9
	.label INIT_TIME = 120
	.label FLASH_TIME = 12

	CurrentColour:	.byte BLUE
	MainColour:		.byte BLUE
	ColourOffset:	.byte 0


	Initialise: {

		lda #GAME_MODE_COMPLETE
		sta MAIN.GameMode

		lda #MAIN.SONG_BLANK
		jsr sid.init

		lda #INIT_TIME
		sta FlashTimer

		lda #0
		sta Flashes
		sta PelletsCleared

		lda #6
		ldx #0
		jsr UTILITY.BlockBorders

		
		rts
	}


	


	SwitchColour: {


		lda CurrentColour
		cmp MainColour
		beq MakeWhite

		MakeBlue:

			lda MainColour
			sta CurrentColour
			rts

		MakeWhite:

			lda #WHITE
			sta CurrentColour
			rts
	}

	ColourScreen: {


		lda CurrentColour
		jsr MAP.ColourScreen

		rts
	}

	FrameUpdate: {


		lda FlashTimer
		beq Ready

		dec FlashTimer

		lda PelletsCleared
		bne AlreadyDone

		inc PelletsCleared
		jsr MAP.ClearPellets


		AlreadyDone:
		rts

		Ready:

		lda #0
		sta ACTOR.GHOST.DrawSprites

		lda #FLASH_TIME
		sta FlashTimer

		jsr SwitchColour

		lda Flashes
		cmp #NUM_FLASHES - 2
		bne NotBlack

		lda #0
		sta CurrentColour

		lda FlashTimer
		asl
		sta FlashTimer

		lda #0
		sta SpriteY

		NotBlack:


		inc Flashes
		lda Flashes
		cmp #NUM_FLASHES
		bne Finish

		lda #0
		sta CurrentColour

		jsr ColourScreen
		jmp MAIN.NewLevel

		Finish:

		jsr ColourScreen


		rts
	}




}
