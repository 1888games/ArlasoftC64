CAGE:{



	MonkeyLockID: .byte 110
	FinalPieceID: .byte 121

	ObjectIDs: .byte 54, 55, 56, 57

	HappyFace: .byte 22
	SadFace: .byte 214
	FacePosition: .byte 127


	SectionsUnlocked: .byte 0
	ShowUnlockedSections: .byte 0
	FlashCounter: .byte 2, 2
	SectionUnlocked: .byte 0,0,0,0


	.label MouthCharacterID = 167
	.label SmileCharacter = 250
	.label SadCharacter = 18
	.label NumberOfSections =4

	LockCage: {

		lda #ZERO
		sta SectionUnlocked
		sta SectionUnlocked + 1
		sta SectionUnlocked + 2
		sta SectionUnlocked + 3

		lda #ZERO
		sta SectionsUnlocked
		jsr Sad

		lda SadFace
		ldx FacePosition
		sta VIC.SCREEN_RAM, x

		//lda SadFace + 1
		//inx
		//sta VIC.SCREEN_RAM, x

		rts
	}


	UnlockCage: {

			lda HappyFace
			ldx FacePosition
			sta VIC.SCREEN_RAM, x

			//lda HappyFace + 1
			//inx
			//sta VIC.SCREEN_RAM, x

		rts
	}


	Reset:{

	
		lda #ZERO	
		sta ShowUnlockedSections
		ldx #ZERO
		lda FlashCounter + 1
		sta FlashCounter

		rts

	}


	
	// runs every frame
	Draw:{

		ldx #NumberOfSections
		dex

		// if going for key don't draw
		lda MONKEY.GoingForKey
		bne EndLoop

		.label SectionID = TEMP10

		Loop:

		
			stx SectionID

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

			lda ObjectIDs, x
			tax
			ldy #ZERO
			jsr CHAR_DRAWING.ColourObject
			jmp FinishSection

			ldx SectionID
			cpx #3
			bne FinishSection

			lda MONKEY.AtCage
			bne FinishSection

			//lda FinalPieceID
			//ldx #91
			//sta VIC.SCREEN_RAM, x

			//lda #3
			//sta VIC.COLOR_RAM, x
			

		TurnOn:


			lda ObjectIDs, x
			tax
			ldy #ONE
			jsr CHAR_DRAWING.ColourObject
				
			ldx SectionID
			cpx #3
			bne FinishSection

			lda MONKEY.AtCage
			bne FinishSection

			//jsr PutBackPiece

		
			// get pointer and set frame
			
			
		FinishSection:

			ldx SectionID
			// increment and loop back round
			cpx #ZERO
			beq EndLoop
			dex
			jmp Loop


		EndLoop:

			lda MONKEY.AtCage
			beq NoMonkey


		
			//lda MonkeyLockID
			//ldx #91
			//sta VIC.SCREEN_RAM, x

			//lda #2
			//sta VIC.COLOR_RAM, x

			NoMonkey:


			rts

	}

	PutBackPiece:{

		lda FinalPieceID
		ldx #91
		//sta VIC.SCREEN_RAM, x

		lda #0
		//sta VIC.COLOR_RAM, x

		rts

	}

	TurnOffMonkey:{

		//lda MonkeyLockID
		//ldx #91
		//sta VIC.SCREEN_RAM, x

		//lda #3
		//sta VIC.COLOR_RAM, x

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
			lda ShowUnlockedSections
		
			rts

	}


	Sad:{

		lda #SadCharacter
		ldx #MouthCharacterID
		//sta SCREEN_RAM, x
		rts

	}

	Smile:{

		lda #SmileCharacter
		ldx #MouthCharacterID
		//sta SCREEN_RAM, x
		rts

	}

}