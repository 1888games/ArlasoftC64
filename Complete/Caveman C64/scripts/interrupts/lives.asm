LIVES:{


	Value: .byte 4, 4

	.label HeartCharacter = 243
	.label BlankCharacter = 0

	.label StartCharacterPosition = SCREEN_RAM + 62
	.label StartColourPosition = VIC.COLOR_RAM + 62





	Reset:{

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

		ldx #3
		jsr SOUND.InitialiseSid
		jmp Finish

		NoLifeSound:

		ldx #2
		jsr SOUND.InitialiseSid

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

			
			clc
			cpx LivesLeft
		
			beq DrawHeart
			jmp DrawBlank

			DrawHeart:

			lda #HeartCharacter
			sta StartCharacterPosition, x
			lda #YELLOW
			sta StartColourPosition, x
			dec LivesLeft
			jmp EndLoop
			

			DrawBlank:

			lda #BlankCharacter
			sta StartCharacterPosition, x
			//inc $d020
		

		EndLoop:

			dex
			cpx #ZERO
			bne Loop
			rts


	
	}
}