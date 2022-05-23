.namespace ACTOR {
.namespace GHOST {

	* = * "-Sprite"

	SpriteOffsets:	.byte 0, 0, -2, -4, -6
	DirectionFrames:	.byte 86, 95, 90, 88
	DrawSprites:		.byte 0

	FrameLookup:		.byte 0, 1, 2, 1

	.label ScaredPointer = 97
	.label EyesPointer = 102


	UpdateFrames: {

		lda IsBigPacman, x
		beq NormalFrame

		BigPacman:

			inc Frames, x
			lda Frames, x
			and #%00000011
			bne NoUpdate

			jmp NextFrame

		NormalFrame:
			
			inc Frames, x
			lda Frames, x
			and #%00000111
			bne NoUpdate

		NextFrame:

			lda MAIN.GameMode
			cmp #GAME_MODE_INTERMISSION
			bne NotIntermission

		IntermissionPointer:

			lda INTERMISSION.Pointers, x
			cmp #255
			beq NotIntermission

		Intermission:

			lda INTERMISSION.CurrentFrame, x
			clc
			adc #1
			sta INTERMISSION.CurrentFrame, x

			cmp INTERMISSION.Frames, x
			bcc NoWrap

			lda #0
			sta INTERMISSION.CurrentFrame, x

		NoWrap:

			tay
			lda FrameLookup, y
			clc
			adc INTERMISSION.Pointers, x
			sta AnimFrame, x

			rts


		NotIntermission:

			lda AnimFrame, x
			eor #%00000001
			sta AnimFrame, x

		NoUpdate:


		rts
	}


	BigPacman: {

		cmp #RED
		bne UseYellow

		sta SpriteColor, x
		rts

	UseYellow:

		lda #YELLOW	
		sta SpriteColor, x

		lda #4
		sec
		sbc ZP.GhostID
		tay

		lda GAME_SPRITES.MultiColourFlag
		and VIC.MSB_Off, y
		sta GAME_SPRITES.MultiColourFlag

		rts
	}

	UpdateSprite: {

			lda Pause, x
			beq CheckScared

			lda MAIN.GameMode
			cmp #GAME_MODE_INTERMISSION
			beq CheckY


			jmp NoDisplay

		CheckY:

			lda PixelY, x
			cmp #200
			bne CheckScared

			jmp NoDisplay

		CheckScared:

			lda IsBigPacman, x
			beq NotBigPacman

			jsr BigPacman
			jmp DoPointer

		NotBigPacman:

			lda Scared, x
			beq NotScared

		IsScared:

			lda ENERGIZER.FlashState
			asl
			clc
			adc AnimFrame, x
			clc
			adc #ScaredPointer
			sta SpritePointer, x

			lda ENERGIZER.FlashState
			beq Blue

		White:

			lda #RED
			sta SpriteColor, x
			jmp Position

		Blue:

			lda #LIGHT_RED
			sta SpriteColor, x
			jmp Position

		NotScared:

			lda Mode, x
			cmp #GHOST_EATEN
			bne NotEaten

		EatenShowScore:

			lda GHOST.EatenInRow
			clc
			adc #ScorePointer - 1
			sta SpritePointer, x

			lda #CYAN
			sta SpriteColor, x

		HiRes:	

			lda #4
			sec
			sbc ZP.GhostID
			tay
			lda GAME_SPRITES.MultiColourFlag
			and VIC.MSB_Off, y
			sta GAME_SPRITES.MultiColourFlag

			jmp Position

		Eyes:

			lda NextDirection, x
			clc
			adc #EyesPointer
			sta SpritePointer, x

			lda #WHITE
			sta SpriteColor, x

			jmp HiRes

		NotEaten:

			cmp #GHOST_GOING_HOME
			beq Eyes

			cmp #GHOST_ENTERING_HOME
			beq Eyes

		Normal:
			
			lda #4
			sec
			sbc ZP.GhostID
			tay
			lda GAME_SPRITES.MultiColourFlag
			ora VIC.MSB_On, y
			sta GAME_SPRITES.MultiColourFlag

		DoColours:

			lda Colours, x
			sta SpriteColor, x


		DoPointer:


			lda NextDirection, x
			tay
			lda DirectionFrames, y
			clc
			adc AnimFrame, x
			sta SpritePointer, x

		
		Position:

			lda TileX, x
			bmi LeftSide
			cmp #12
			bcs RightSide

		LeftSide:
			
			lda #18 + SCROLLER.START_COLUMN * TILE_SIZE
			clc
			adc PixelX, x
			sta SpriteX, x

			lda #0
			sta SpriteMSB, x

			jmp NoMSB

		RightSide:

			lda #18 + SCROLLER.START_COLUMN * TILE_SIZE
			clc
			adc PixelX, x
			sta SpriteX, x

			lda #0
			adc #0
			sta SpriteMSB, x
			beq NoMSB

		MSB:

			 lda SpriteColor, x
			 ora #%10000000
			 sta SpriteColor, x

			jmp DoY

	NoMSB:

		lda SpriteColor, x
		and #%01111111
		sta SpriteColor, x

	

	DoY:	


		lda PixelY, x
		clc
		adc #47
		sec
		sbc SCROLLER.PixelScroll
		clc
		adc #SCROLLER.TOP_BORDER_ROWS * 8

		cmp #55
		bcc NoDisplay

		cmp #240
		bcs NoDisplay


		jmp Display

		NoDisplay:

		lda #64
		sta SpritePointer, x
		sta PointerCopy, x

		lda #0
		sta SpriteX, x

		lda #255
		sta SpriteY, x
	

		rts

		Display:

		sta SpriteY, x
	

		rts
	}

	

}
}