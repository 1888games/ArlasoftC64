.namespace ACTOR {
.namespace PLAYER {


	* = * "--Sprite"


	UpdateFrames: {

		lda IsMoving
		beq NoUpdate

		lda GHOST.IsBigPacman
		beq NormalFrame

		BigPacman:

			inc Frames
			lda Frames
			and #%00000011
			bne NoUpdate

			jmp NextFrame

		NormalFrame:

			inc Frames
			lda Frames
			and #%00000001
			bne NoUpdate

		NextFrame:

			inc AnimFrame
			lda AnimFrame
			cmp #4
			bcc NoUpdate

			lda #0
			sta AnimFrame

		NoUpdate:


		rts
	}
	

	UpdateSprite: {

		lda TileX
		bmi NotVisible

		cmp #28
		bcs NotVisible

		lda PixelY
		cmp #255
		beq NotVisible

		jmp Visible


	NotVisible:

		lda #0
		sta SpriteY
		//rts

	Visible:


		lda ACTOR.GHOST.IsBigPacman
		beq NotBig



		ldx AnimFrame
		lda GHOST.FrameLookup, x
		clc
		adc #147
		sta SpritePointer

		jmp DoColour

	NotBig:

		lda Direction
		asl
		asl
		clc
		adc AnimFrame
		tax

		lda FrameLookup, x
		clc
		adc #48
		sta SpritePointer

	DoColour:

		lda #YELLOW
		sta SpriteColor


		lda TileX
		bmi LeftSide
		cmp #12
		bcs RightSide

	LeftSide:
		
		lda #19 + SCROLLER.START_COLUMN * TILE_SIZE
		clc
		adc PixelX
		sta SpriteX

		lda #0
		sta SpriteMSB

		jmp NoMSB

	RightSide:

		lda #19 + SCROLLER.START_COLUMN * TILE_SIZE
		clc
		adc PixelX
		sta SpriteX

		lda #0
		adc #0
		sta SpriteMSB
		beq NoMSB

	MSB:

		lda SpriteColor
		ora #%10000000
		sta SpriteColor

		jmp DoY

	NoMSB:

		lda SpriteColor
		and #%01111111
		sta SpriteColor

	DoY:	

		lda PixelY
		clc
		adc #47
		sec
		sbc SCROLLER.PixelScroll
		clc
		adc #SCROLLER.TOP_BORDER_ROWS * 8

		sta SpriteY
		

		rts
	}


}

}