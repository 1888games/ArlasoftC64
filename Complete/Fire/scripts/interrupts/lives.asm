LIVES:{


	Value: .byte 3, 3

	StartCharacterPosition: .byte 190
	HeartCharacter: .byte 223
	BlankCharacter: .byte 0

	.label DeadSFXId = 5
	.label GameOverSFXId = 6


	Reset:{

		.if(target == "VIC") {
			lda #90
			sta StartCharacterPosition
			lda #17
			sta HeartCharacter
		}

		.if(target == "PET") {
			lda #83
			sta HeartCharacter
			lda #32
			sta BlankCharacter
		}

		lda Value + 1
		sta Value

		jsr Draw

		rts
	}


	GainLife:{	

		inc Value
		jsr Draw
		rts


	}

	LoseLife: {

		dec Value
		beq NoLifeSound

		
		ldy #DeadSFXId
		jsr SOUND.StartSong

		jmp Finish

		NoLifeSound:

		ldy #GameOverSFXId
		jsr SOUND.StartSong

		Finish:

		jsr Draw
		rts
	}

	Draw:{


		.label LivesLeft = TEMP1

		clc
		lda Value
		sta LivesLeft
		ldx #5
		//sta $d020

		
		Loop:

			
			cpx LivesLeft

			beq DrawHeart
			jmp DrawBlank

			DrawHeart:

			txa
			clc
			adc StartCharacterPosition
			tay

			lda HeartCharacter

			sta (SCREEN_RAM), y

			.if(target != "PET") {
				lda #RED

				.if (target == "264") {
					clc
					adc #96
				}

				sta (COLOR_RAM), y

			}
			dec LivesLeft


			jmp EndLoop
			

			DrawBlank:

			txa
			clc
			adc StartCharacterPosition
			tay

			lda BlankCharacter
			sta (SCREEN_RAM), y
			//inc $d020
		

		EndLoop:

			tya 
			sec
			sbc StartCharacterPosition
			tax

			dex
			cpx #ZERO
			bne Loop
			rts


	
	}
}