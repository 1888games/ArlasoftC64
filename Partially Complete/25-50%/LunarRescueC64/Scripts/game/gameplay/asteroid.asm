ASTEROID: {


	.label MAX_NUMBER = 19

	.label MaxX = 220
	.label MinX = 28
	.label StartSpeed = 90


	PosX_LSB:	.fill MAX_NUMBER, 0	
	Status:		.fill MAX_NUMBER, 0


	StartPosX:	.byte 88, 196, 99, 79, 116, 96, 167, 148, 56, 92
	StartPosY:	.byte 37, 53, 77, 85, 109, 117, 125, 133, 149, 157
	Colours:	.byte GREEN, PURPLE, CYAN, CYAN, YELLOW, YELLOW, YELLOW, RED, RED, GREEN
	Size:		.byte 1, 0, 0, 1, 0, 1, 1, 0, 1, 0
	Direction:	.byte 0, 1, 1, 0, 1, 0, 0, 1, 0, 1

	CurrentStage:	.byte 0

	StageStart:		.byte 0, 10
	StageEnd:		.byte 9, 16

	CurrentSpeed:	.byte 90



	Reset: {

		lda #StartSpeed
		sta CurrentSpeed

		ldx #0
		lda #0



		Loop:

			sta Status, x
			sta SpriteY, x

			inx
			cpx #MAX_NUMBER
			bcc Loop




		rts
	}

	CreateNew: {

		ldx CurrentStage
		lda StageEnd, x
		sta ZP.EndID

		lda StageStart, x
		tax

		Loop:

			lda StartPosX, x
			clc
			adc #12
			sta SpriteX, x

			lda #0
			sta PosX_LSB, x

			lda StartPosY, x
			clc
			adc #38
			sta SpriteY, x

			lda Colours, x
			sta SpriteColor, x

			lda Size, x
			clc
			adc #17
			sta SpritePointer, x

			lda #255
			sta Status, x

			inx
			cpx ZP.EndID
			bcc Loop


		rts
	}


	Move: {

		lda Direction, x
		beq GoRight

		GoLeft:

			lda PosX_LSB, x
			sec
			sbc CurrentSpeed
			sta PosX_LSB, x

			lda SpriteX, x
			sbc #0
			sta SpriteX, x

			cmp #MinX
			bcs NoBounceRight

			lda #MaxX
			sta SpriteX, x

			jmp NoBounceRight


		GoRight:

			lda PosX_LSB, x
			clc
			adc CurrentSpeed
			sta PosX_LSB, x

			lda SpriteX, x
			adc #0
			sta SpriteX, x

			cmp #MaxX
			bcc NoBounceRight

			lda #MinX
			sta SpriteX, x

			
		NoBounceRight:






		rts
	}

	FrameUpdate: {


		ldx #0

		Loop:

			lda Status, x
			bpl EndLoop
			
			jsr Move




			EndLoop:

			inx
			cpx #MAX_NUMBER
			bcc Loop




		rts
	}

}