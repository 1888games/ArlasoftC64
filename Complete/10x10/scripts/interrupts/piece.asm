PIECE:{

	SelectedPieceID:	.byte 99

	.label SpriteHeight = 21
	.label SpriteWidth = 24


	SpriteXOffsets:		.byte 0, 0, 0, 0, 0, 0, 0, 0
	SpriteYOffsets:		.byte 0, 0, 0, 0, 0, 0, 0, 0
	NumberOfSprites:	.byte 0
	PreviousFrameIndex:	.byte 0
	SpriteColour:		.byte 0
	NumberOfChars:		.byte 0


	MSB_On:		.byte %00000001, %00000010, %00000100,%00001000,%00010000,%00100000,%01000000
	MSB_Off:	.byte %11111110, %11111101, %11111011,%11110111,%11101111,%11011111,%10111111




	Reset: {


		lda #BLACK
		//sta VIC.SPRITE_COLOR_0
		sta VIC.SPRITE_COLOR_1
		sta VIC.SPRITE_COLOR_2
		sta VIC.SPRITE_COLOR_3
		sta VIC.SPRITE_COLOR_4
		sta VIC.SPRITE_COLOR_5
		sta VIC.SPRITE_COLOR_6


		lda #99
		sta SelectedPieceID
		//ldx #30
		//jsr PIECE.SelectNewPiece

		rts

	}


	Update: {

		lda MAIN.GameActive
		bne DrawPieces

		jsr HideSprites

		DrawPieces:

			jsr CheckSelectedPiece

		Finish:

		rts

	}


	CheckSelectedPiece: {

		lda SelectedPieceID
		cmp #99
		beq Finish

		lda #0
		//sta VIC.SPRITE_0_Y

		jsr DrawSprites
		//jsr GRID.CheckPieceIsValid

		Finish:

			rts

	}


	SelectRandomPiece: {

		jsr RANDOM.Get
		and #%00111111

		tax

		lda PIECE_DATA.Frequency, x
		tax

		jsr SelectNewPiece

		rts


	}

	SelectNewPiece: {


		lda #1
		sta CurrentPointerIndex

		stx SelectedPieceID


		lda PIECE_DATA.SpriteSizes, x
		sta NumberOfSprites

		lda PIECE_DATA.Colours, x
		sta SpriteColour

		txa
		asl
		tax

		lda PIECE_DATA.Pieces, x
		sta PIECE_DATA_ADDRESS



		inx
		lda PIECE_DATA.Pieces, x
		sta PIECE_DATA_ADDRESS + 1

		ldx SelectedPieceID
		lda PIECE_DATA.CharSizes, x
		sta NumberOfChars
		tay

		clc
		adc NumberOfSprites
		sta NumberOfSprites



		Loop:

			sty CurrentSpriteIndex

			ldx CurrentPointerIndex
			
			lda (PIECE_DATA_ADDRESS), y


			clc
			adc #16

			sta SPRITE_POINTERS, x

			lda SpriteColour
			sta VIC.SPRITE_COLOR_0, x

			lda CurrentPointerIndex
			sec
			sbc #1
			asl
			clc
			adc NumberOfSprites
			tay

			lda (PIECE_DATA_ADDRESS), y
			clc
			adc #09
			sta SpriteXOffsets, x
			
			iny
			lda (PIECE_DATA_ADDRESS), y
			sta SpriteYOffsets, x

			ldy CurrentSpriteIndex

			inc CurrentPointerIndex
			iny
			cpy NumberOfSprites
			beq Finish
			jmp Loop


		Finish:


			rts
	}


	CheckAgainstGrid: {

		lda MOUSE.MouseFireX
		cmp #20
		bcs Finish

		lda MOUSE.MouseFireY
		cmp #4
		bcc Finish


		ldx SelectedPieceID






		Finish:


		rts
	}

	HideSprites: {



		lda #0
		sta VIC.SPRITE_0_X
		sta VIC.SPRITE_1_X
		sta VIC.SPRITE_2_X
		sta VIC.SPRITE_3_X
		sta VIC.SPRITE_4_X 
		sta VIC.SPRITE_5_X
		sta VIC.SPRITE_6_X

		lda VIC.SPRITE_MSB
		and #%00000000
		sta VIC.SPRITE_MSB

		rts


	}
	DrawSprites: {


		ldx SelectedPieceID

		lda PIECE_DATA.SpriteSizes, x
		sta NumberOfSprites

		jsr HideSprites

		ldy #1

		Loop:

			sty PointerIndex

			lda MOUSE.MouseX_MSB
			sta MSBThisSprite


			XandY:

				tya
				tax
				asl
				tay
			//	dex

		
				lda MOUSE.MouseY
				and #%11110000		
				sec
				sbc #01	
				clc
				adc SpriteYOffsets, x
				sta VIC.SPRITE_0_Y, y

			

				lda MOUSE.MouseX_LSB
				and #%11110000
				clc
				//adc #09
				adc SpriteXOffsets, x
				sta VIC.SPRITE_0_X, y

				lda MSBThisSprite
				adc #00

				beq MSBOff

			MSBOn:

				lda VIC.SPRITE_MSB
				ora MSB_On, x
				sta VIC.SPRITE_MSB

				jmp EndLoop


			MSBOff:

				lda VIC.SPRITE_MSB
				and MSB_Off, x
				sta VIC.SPRITE_MSB



			EndLoop:

				ldy PointerIndex
				cpy NumberOfSprites
				beq Finish
				iny
				jmp Loop


		Finish:





		rts
	}


	




}