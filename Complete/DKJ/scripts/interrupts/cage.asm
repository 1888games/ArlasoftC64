CAGE:{

	Frames: 	.byte 88, 85, 89, 90
	XPos:		.byte 82, 62, 62, 85
	YPos:		.byte 65, 65, 88, 88
	Pointers:	.byte 0, 5, 6 , 7
	PointerOne: .byte 0, 4

	SectionsUnlocked: .byte 0
	ShowUnlockedSections: .byte 0
	FlashCounter: .byte 2, 2
	SectionUnlocked: .byte 0,0,0,0

	.label MouthCharacterID = 167
	.label SmileCharacter = 250
	.label SadCharacter = 18
	.label NumberOfSections = 4

	LockCage: {

		lda #ZERO
		sta SectionUnlocked
		sta SectionUnlocked + 1
		sta SectionUnlocked + 2
		sta SectionUnlocked + 3

		lda #ZERO
		sta SectionsUnlocked
		jsr Sad
	}



	Reset:{

	
		lda #ZERO	
		sta ShowUnlockedSections
		sta Pointers
		ldx #ZERO
		lda FlashCounter + 1
		sta FlashCounter

		rts

	}


	SetupSprites:{

		lda VIC.SPRITE_ENABLE
		ora #%11110000
		sta VIC.SPRITE_ENABLE

		lda VIC.SPRITE_MSB
		and #%00001111
		sta VIC.SPRITE_MSB

		lda MONKEY.GoingForKey
		beq NotGoingForKey

		rts

		NotGoingForKey:

		lda VIC.SPRITE_ENABLE
		ora #%11100001
		sta VIC.SPRITE_ENABLE
		rts

	}

	// runs every frame
	Draw:{

		ldx #NumberOfSections - 1
		jsr SetupSprites

		// if going for key don't draw
		lda MONKEY.GoingForKey
		bne EndLoop

		Loop:

			// turn off if all sections unlocked
			lda SectionsUnlocked
			cmp #NumberOfSections
			beq TurnOff

			// always show if not unlocked
			lda SectionUnlocked, x
			beq TurnOn

			// flash unlocked cage sections
			lda ShowUnlockedSections
			bne TurnOn

			TurnOff:

			// hide sprites off screen
			lda Pointers, x
			rol
			tay
			lda #ZERO
			sta VIC.SPRITE_0_X, y
			jmp FinishSection


		TurnOn:

			// get pointer and set frame
			ldy Pointers, x
			lda Frames, x
			clc
			adc #64
			sta SPRITE_POINTERS, y

			// set cage to black
			lda #BLACK
			sta VIC.SPRITE_COLOR_0, y

			// Get offset for X & Y registers, store new position
			lda Pointers, x
			rol
			tay
			lda XPos, x
			sta VIC.SPRITE_0_X, y
			lda YPos, x
			sta VIC.SPRITE_0_Y, y
			

		FinishSection:

			// increment and loop back round
			cpx #ZERO
			beq EndLoop
			dex
			jmp Loop


		EndLoop:

			rts

	}

	// runs on game tick, not every frame
	Update:{

		// check whether to switch flashing flag
		dec FlashCounter
		beq Switch
		jmp CheckMonkeyPosition

		Switch:
		
			lda FlashCounter + 1
			sta FlashCounter

			lda ShowUnlockedSections
			beq TurnOn

			// turn off flag
			dec ShowUnlockedSections
			jmp CheckMonkeyPosition

			TurnOn:

				inc ShowUnlockedSections

		// change pointers between key/monkey1 depending if at cage
		CheckMonkeyPosition:
			ldx MONKEY.AtCage
			lda PointerOne, x
			sta Pointers
			lda ShowUnlockedSections
		
			rts

	}


	Sad:{

		lda #SadCharacter
		ldx #MouthCharacterID
		sta SCREEN_RAM, x
		rts

	}

	Smile:{

		lda #SmileCharacter
		ldx #MouthCharacterID
		sta SCREEN_RAM, x
		rts

	}

}