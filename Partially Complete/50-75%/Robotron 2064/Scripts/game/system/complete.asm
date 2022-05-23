COMPLETE: {


	* = * "Complete"

	FrameTimer:		.byte 0


	TopRow:		.byte 12
	BottomRow:	.byte 13

	StartX:		.byte 12
	Length:		.byte 16
	CurrentRow:	.byte 0
	CurrentColour:	.byte 15
	Phase:		.byte 0


	.label FrameTime = 2

	Set: {

		jsr SOUND.Complete

		lda #0
		sta PLAYER.Active

		lda #1
		sta PLAYER.Dead

		lda #GAME_MODE_LEVEL_COMPLETE
		sta MAIN.GameMode

		lda #100
		sta FrameTimer

		lda #1
		sta MAPLOADER.CurrentMapID

		lda $d011
		sta ZP.Amount


		lda #0
		sta VIC.SPRITE_ENABLE
		sta Phase

	  	lda #$7B 
   	 	sta $d011

   	 	lda #1
		jsr MAPLOADER.DrawMap
	//	jsr BlankColourRAM

		

		jsr ResetSettings

		lda #15
		sta CurrentColour

		jsr ColourSection

		lda #FrameTime
		sta FrameTimer

		lda ZP.Amount
		sta $d011



		rts
	}

	Loop2:

		jmp Loop2

	ResetSettings: {

		lda #12
		sta TopRow
		sta StartX

		lda #16
		sta Length

		lda #13
		sta BottomRow

		rts
	}


	ColourSection: {

		lda TopRow
		sta CurrentRow

		OuterLoop:

			ldy CurrentRow
			ldx StartX

			jsr PLOT.GetCharacter

			ldy #0

			Loop:

				lda CurrentColour
				sta (ZP.ColourAddress), y

				iny
				cpy Length
				bcc Loop

				inc CurrentRow
				lda CurrentRow
				cmp BottomRow
				bcc OuterLoop



		rts
	}

	BlankColourRAM: {

		ldx #250
    	lda #0

    	Loop:

    		sta VIC.COLOR_RAM - 1, x
    		sta VIC.COLOR_RAM + 249, x
    		sta VIC.COLOR_RAM  + 499, x
    		sta VIC.COLOR_RAM + 749, x

    		dex
    		bne Loop



		rts
	}

	FrameUpdate: {

		

		lda #0
		sta VIC.SPRITE_ENABLE

		lda FrameTimer
		beq ColourUpdate

		dec FrameTimer
		rts

		ColourUpdate:

			lda #FrameTime
			sta FrameTimer

			inc VIC.EXTENDED_BG_COLOR_1
	 		inc VIC.EXTENDED_BG_COLOR_2
			
			dec TopRow
			inc BottomRow

			dec StartX
			inc Length
			inc Length

			lda StartX
			bmi DoneIt

			jsr ColourSection
			rts

		DoneIt:

			inc Phase
			lda Phase
			cmp #2
			beq Ready

			lda #0
			sta CurrentColour

			jsr ResetSettings

			rts

		Ready:

			jsr PLAYER.NextLevel


		rts
	}
}