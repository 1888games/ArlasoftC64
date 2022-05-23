SPRITES: {


	.label ActivisionPointer = 35
	.label ActivisionSpriteID =  MAX_SPRITES - 3
	.label ActivisionY = 242
	.label ActivisionX = 152





	Setup: {


		jsr ActivisionLogo

		lda #ActivisionPointer
		sta SpritePointer + ActivisionSpriteID

		lda #ActivisionPointer + 1
		sta SpritePointer + ActivisionSpriteID + 1

		lda #ActivisionPointer + 2
		sta SpritePointer + ActivisionSpriteID + 2

		lda #ActivisionY
		sta SpriteY + ActivisionSpriteID + 2
		sta SpriteY + ActivisionSpriteID + 1
		sta SpriteY + ActivisionSpriteID 

		lda #ActivisionX
		sta SpriteX + ActivisionSpriteID 
		clc
		adc #24
		sta SpriteX + ActivisionSpriteID + 1
		clc
		adc #24
		sta SpriteX + ActivisionSpriteID + 2


		lda #WHITE
		sta SpriteColor + ActivisionSpriteID
		sta SpriteColor + ActivisionSpriteID + 1
		sta SpriteColor + ActivisionSpriteID + 2





		rts
	}


	ActivisionLogo: {




		rts
	}
}