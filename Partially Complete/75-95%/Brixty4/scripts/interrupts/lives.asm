LIVES:{


	Value: .byte 3, 3

	.label HeartCharacter = 44
	.label BlankCharacter = 0

	.label StartCharacterPosition = SCREEN_RAM + 58
	.label StartColourPosition = VIC.COLOR_RAM + 58



	Reset:{

		lda Value + 1
		sta Value

		jsr Draw

		rts
	}



	LoseLife: {

		lda Value
		beq Continue

		dec Value
		jsr Draw


		lda #LIGHT_RED
		sta $d020

		lda #MAIN.LifeLostTimeOut
		sta MAIN.LifeLostTimer

		lda Value
		bne Continue
		
		lda #RED
		sta $d020

		jsr MAIN.GameOver


		Continue:


		rts
	}

	AddLife: {

		lda Value
		cmp #3
		beq NoAdd

		inc Value
		jsr Draw

		NoAdd:
			rts


	}




	Draw:{

		.label LivesLeft = TEMP1

		clc
		lda Value
		sta LivesLeft
		ldx #3

		//sta $d020

		
		Loop:

			
			clc
			cpx LivesLeft
		
			beq DrawHeart
			jmp DrawBlank

			DrawHeart:

			lda #HeartCharacter
			sta StartCharacterPosition, x
			lda #RED
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