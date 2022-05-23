EXPLOSIONS: {


	* = * "Explosions"
	.label FrameTime = 4
	.label FirstSprite = 6
	.label MaxSprites = 8 - FirstSprite

	XPosLSB:	.fill 29, 26 + (i * 8)
				.fill 11, i * 8
	XPosMSB:	.fill 29, 0
				.fill 11, 1
	YPos:		.fill 25, 52 + (i * 8)



	NextSprite:			.byte 7

	EndFrame:			.fill 8, 0
	FrameTimer:			.fill 8, 0

	StartPointers:	.byte 20, 24, 30
	EndPointers:	.byte 23, 29, 35





	Reset: {

		lda #0
		ldx #0

		Loop:

			sta EndFrame, x
			sta FrameTimer, x

			inx
			cpx #8
			bcc Loop

		lda #7
		sta NextSprite

		rts


	}


	StartExplosion: {

	
		// y = explosion colour
		// x = explosion type


		lda EndPointers, x
		pha

		lda StartPointers, x
		ldx NextSprite
		sta SPRITE_POINTERS, x

		pla
		sta EndFrame, x

		lda #FrameTime
		sta FrameTimer, x

		lda NextSprite
		asl
		tax

		ldy ZP.Row
		lda YPos, y
		sta VIC.SPRITE_0_Y, x

		ldy ZP.Column
		lda XPosLSB, y
		sta VIC.SPRITE_0_X, x

		ldx NextSprite

		lda VIC.SPRITE_DOUBLE_Y
		ora DRAW.MSB_On, x
		sta VIC.SPRITE_DOUBLE_Y

		lda VIC.SPRITE_DOUBLE_X
		ora DRAW.MSB_On, x
		sta VIC.SPRITE_DOUBLE_X

		lda XPosMSB, y
		beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora DRAW.MSB_On, x
			sta VIC.SPRITE_MSB
			jmp Finish

		NoMSB:

			lda VIC.SPRITE_MSB
			and DRAW.MSB_Off, x
			sta VIC.SPRITE_MSB


		Finish:

			lda ZP.BeanColour
			sta VIC.SPRITE_COLOR_0, x

		dex
		stx NextSprite

		cpx #FirstSprite
		bcs Okay

		ldx #7
		stx NextSprite

		Okay:

		rts
	}





	FrameUpdate: {

		ldx #7

		Loop:

			stx ZP.TempX

			lda EndFrame, x
			beq EndLoop

			lda FrameTimer, x
			beq Ready

			dec FrameTimer, x
			jmp EndLoop

			Ready:

				txa
				asl
				tax

				dec VIC.SPRITE_0_Y, x
				dec VIC.SPRITE_0_Y, x

				ldx ZP.TempX

				lda #FrameTime
				sta FrameTimer, x

				inc SPRITE_POINTERS, x
				lda SPRITE_POINTERS, x
				cmp EndFrame, x
				bcc EndLoop
				beq EndLoop

				Delete:

					lda #0
					sta EndFrame, x

					txa
					asl
					tax
					lda #0
					sta VIC.SPRITE_0_Y, x


			EndLoop:

				ldx ZP.TempX
				dex
				cpx #FirstSprite
				bcs Loop



		rts
	}




}