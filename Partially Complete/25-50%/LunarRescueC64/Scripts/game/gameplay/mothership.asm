MOTHERSHIP: {



	.label PosY = 50
	.label Pointer = 34
	.label StartX = 110
	.label SpriteID = 20
	.label MoveSpeed = 160
	.label MaxX = 200
	.label MinX = 32

	PosX:	.byte 110
	PosX_LSB:	.byte 0
	Direction:	.byte 0
	Moving:		.byte 1

	Initialise: {


		lda #Pointer
		sta SpritePointer + SpriteID

		lda #Pointer + 1
		sta SpritePointer + SpriteID + 1

		lda #StartX
		sta PosX

		lda #PosY
		sta SpriteY + SpriteID
		sta SpriteY + SpriteID + 1

		lda #YELLOW
		sta SpriteColor + SpriteID 
		sta SpriteColor + SpriteID + 1


		lda #0
		sta PosX_LSB

		rts


	}


	UpdateSprites: {

		lda PosX
		sta SpriteX + SpriteID
		clc
		adc #24
		sta SpriteX + SpriteID + 1



		rts
	}


	Move: {

		lda Moving
		beq Finish


		lda Direction
		beq GoRight


		GoLeft:

			lda PosX_LSB
			sec
			sbc #MoveSpeed
			sta PosX_LSB

			lda PosX
			sbc #0
			sta PosX

			cmp #MinX
			bcs NoBounceRight

			lda #MinX
			sta PosX

			dec Direction

			jmp NoBounceRight


		GoRight:

			lda PosX_LSB
			clc
			adc #MoveSpeed
			sta PosX_LSB

			lda PosX
			adc #0
			sta PosX

			cmp #MaxX
			bcc NoBounceRight

			lda #MaxX
			sta PosX

			inc Direction

		NoBounceRight:



		Finish:



		rts
	}

	FrameUpdate: {

		jsr Move
		jsr UpdateSprites








		rts
	}


}