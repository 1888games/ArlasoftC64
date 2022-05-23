
PLAYER: {


	* = * "Player"

	.label StartX = 125
	.label PosY = 230
	.label SpriteFrame = 88


	PosX:		.byte StartX


	BulletSpriteX:	.byte 0
	BulletCharX:	.byte 0
	BulletSpriteY:	.byte 0
	BulletCharY:	.byte 0
	BulletOffsetX:	.byte 0
	BulletOffsetY:	.byte 0
	YPosAdd:		.byte 0, 8


	.label BulletStartChar = 102
	.label BulletStartY = 23
	.label BulletStartYSprite = 226
	.label BlankCharacterID = 32



	DrawShip: {


		lda #SpriteFrame
		sta SPRITE_POINTERS

		lda PosX
		sta VIC.SPRITE_0_X

		lda #PosY
		sta VIC.SPRITE_0_Y

		lda #WHITE
		sta VIC.SPRITE_COLOR_0

		lda #RED
		sta VIC.SPRITE_MULTICOLOR_1

		lda #CYAN
		sta VIC.SPRITE_MULTICOLOR_2



		rts
	}


	
	Fire: {

		CheckCanFire:

			lda BulletCharY
			bne Finish

	//	.break

		lda PosX
		clc
		adc #13
		sta BulletSpriteX

		sec
		sbc #24
		lsr
		lsr
		lsr
		sta BulletCharX

		lda BulletSpriteX
		and #%00000111
		sta BulletOffsetX


		lda #BulletStartY
		sta BulletCharY

		lda #BulletSpriteY
		sta BulletSpriteY

		lda #0
		sta BulletOffsetY

		
		jsr Draw






		Finish:



		rts


	}


	Delete: {



		lda #BlankCharacterID
		ldx BulletCharX
		ldy BulletCharY

		jsr PLOT.PlotCharacter




		rts
	}

	HandleBullet: {

		lda BulletCharY
		beq Finish

		jsr Delete

		dec BulletCharY

		lda BulletCharY
		cmp #2
		bcs Okay

		lda #0
		sta BulletCharY
		jmp Finish


		Okay:

		jsr Draw

		jmp Finish

		lda BulletOffsetY
		clc
		adc #1
		sta BulletOffsetY
		cmp #2
		bcc One

		lda #0
		sta BulletOffsetY

		jsr Delete

		dec BulletCharY

		lda BulletCharY
		beq Finish

		One:

		jsr Draw



		Finish:

		rts
	}




	FrameUpdate: {


		jsr HandleBullet

		rts
	}

	Draw: {

		ldx BulletOffsetY
		lda YPosAdd, x
		clc
		adc BulletOffsetX
		adc #BulletStartChar
		sta CharID

		ldx BulletCharX
		ldy BulletCharY

		jsr PLOT.GetCharacter

		tay
		lda CHAR_COLORS, y
		and #%11110000
		cmp #CHAR_TYPE_SOLID
		bne Okay

		lda #0
		sta BulletCharY
		jmp Finish

		Okay:


		ldx BulletCharX
		ldy BulletCharY
		lda CharID

		jsr PLOT.PlotCharacter

		lda #PURPLE

		jsr PLOT.ColorCharacter


		Finish:


		rts
	}




}