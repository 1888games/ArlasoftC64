BOMB: {

	Active: 	.byte 0, 0
	XOffset:	.byte 245, 9, 253, 253
				.byte 245, 9, 1, 1

	YOffset:	.byte 254, 254, 10, 246
				.byte 2, 2, 10, 246


	Direction:	.byte 0, 0

	CharXOffset: .byte 0, 1, 0, 0
				 .byte 0, 1, 1, 1

	CharYOffset: .byte 1, 1, 1, 0 
				 .byte 1, 1, 1, 0 

	ChecksX_Left:	.byte 0, 0, 255, 255
	ChecksX_Right:	.byte 0, 0, 1, 1
	ChecksX_Down:	.byte 0, 0, 0, 0
	ChecksX_Up:		.byte 0, 0, 0, 0

	ChecksY_Left:	.byte 0, 0, 0, 0
	ChecksY_Right:	.byte 0, 0, 0, 0
	ChecksY_Down:	.byte 0, 0, 1, 1
	ChecksY_Up:		.byte 0, 0, 255, 255

	// ChecksX_Left:	.byte 0, 0, 255, 255
	// ChecksX_Right:	.byte 0, 0, 1, 1
	// ChecksX_Down:	.byte 0, 1, 0, 1
	// ChecksX_Up:		.byte 0, 1, 0, 1

	// ChecksY_Left:	.byte 0, 1, 0, 1
	// ChecksY_Right:	.byte 0, 1, 0, 1
	// ChecksY_Down:	.byte 0, 0, 1, 1
	// ChecksY_Up:		.byte 0, 0, 255, 255

	PosX_Frac:	.byte 0, 0
	PosX_LSB:	.byte 0, 0
	PosX_MSB:	.byte 0, 0
	PosY:		.byte 0, 0
	PosY_Frac:	.byte 0, 0
	PixelCount:	.byte 0, 0

	Side:		.byte LEFT, RIGHT
	SideAdd:	.byte 0, 4
	SideLook:	.byte 0


	.label Pointer = 23

	CharX:		.byte 0, 0
	CharY:		.byte 0, 0

	Cooldown:		.byte 0, 0

	SPEED_Pixel:	.byte 5



	NewLevel: {

		lda #0
		sta Active
		sta Active + 1


		rts
	}

	Fire: {

		lda ENEMY.PosX_LSB, x
		sta PosX_LSB, x

		lda ENEMY.PosX_MSB, x
		sta PosX_MSB, x

		lda ENEMY.MoveDirection, x
		sta Direction, x



		ldy Side
		lda Direction, x
		clc
		adc SideAdd, y
		tay
		sty SideLook

		lda XOffset, y
		bmi Subtract

		Add:

			lda ENEMY.PosX_LSB, x
			clc
			adc XOffset, y
			sta PosX_LSB, x
			sta ZP.SpriteX

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x
			sta ZP.SpriteX_MSB

			jmp Y

		Subtract:

			lda ENEMY.PosX_LSB, x
			clc
			adc XOffset, y
			sta PosX_LSB, x
			sta ZP.SpriteX

			lda PosX_MSB, x
			sbc #0
			sta PosX_MSB, x
			sta ZP.SpriteX_MSB

		Y:

			lda ENEMY.PosY, x
			clc
			adc YOffset, y
			sta PosY, x
			sta ZP.SpriteY

			lda #1
			sta Active, x
			sta Cooldown, x

		jsr ConvertToChars

		lda #0
		sta PixelCount, x

		Finish:

		rts
	}

	ConvertToChars: {

		jsr BULLET.ConvertSpritePosToChars

	
		ldy SideLook

		lda ZP.CharX
		clc
		adc CharXOffset, y
		sta CharX, x

		cmp #40
		bcs InvalidShot

		lda ZP.CharY
		clc
		adc CharYOffset, y
		sta CharY, x

		cmp #1
		bcc InvalidShot

		cmp #17
		bcs InvalidShot

		//rts

		lda Side, x
		eor #%00000001
		sta Side, x

		
		rts

		InvalidShot:

		lda #0
		sta Active, x

		jsr RANDOM.Get
		and #%00011111
		sta ENEMY.ShootTimer, x


		rts
	}


	UpdateSprites: {

		lda #0
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_4_X
		sta VIC.SPRITE_5_X


		CheckBomb1:

			lda Active
			beq CheckBomb2


		DoBomb1:	

			
			lda PosX_LSB
			sta VIC.SPRITE_4_X

			lda PosY
			sta VIC.SPRITE_4_Y

			lda ENEMY.Colour
			sta VIC.SPRITE_COLOR_4

			lda PosX_MSB
			beq NoMSB

			MSB:

				lda VIC.SPRITE_MSB
				ora VIC.MSB_On + 4
				sta VIC.SPRITE_MSB
				jmp DoneMSB

			NoMSB:

				lda VIC.SPRITE_MSB
				and VIC.MSB_Off + 4
				sta VIC.SPRITE_MSB


			DoneMSB:

			lda #Pointer
			sta SPRITE_POINTERS + 4



		CheckBomb2:

			lda Active + 1
			beq Done

			lda PosX_LSB + 1
			sta VIC.SPRITE_5_X

			lda PosY + 1
			sta VIC.SPRITE_5_Y

			lda ENEMY.Colour + 1
			sta VIC.SPRITE_COLOR_5

			lda PosX_MSB + 1
			beq NoMSB2

			MSB2:

				lda VIC.SPRITE_MSB
				ora VIC.MSB_On + 5
				sta VIC.SPRITE_MSB
				jmp DoneMSB2

			NoMSB2:

				lda VIC.SPRITE_MSB
				and VIC.MSB_Off + 5
				sta VIC.SPRITE_MSB


			DoneMSB2:

			lda #Pointer
			sta SPRITE_POINTERS + 5
			rts


		Done:


		rts
	}	



	Move: {


		lda Active, x
		bne Moving

		rts

	Moving:

		lda PLAYER.CollectTimer
		bmi NotCollecting

		jmp Finish

	NotCollecting:

		lda Direction, x
		cmp #LEFT
		beq MoveLeft

		cmp #RIGHT
		bne NotRight

		jmp MoveRight

	NotRight:

		cmp #DOWN
		beq MoveDown

	MoveUp:

		lda PosY, x
		sec
		sbc SPEED_Pixel
		sta PosY, x

		lda PixelCount, x
		clc
		adc SPEED_Pixel
		sta PixelCount, x

		sec
		sbc #8
		bmi NotCharUp

		sta PixelCount, x

		dec CharY, x


	NotCharUp:

		lda CharY, x
		cmp #1
		bcs NoBoundUp

		jmp Despawn 

	NoBoundUp:

		rts

	MoveDown:

		lda PosY, x
		clc
		adc SPEED_Pixel
		sta PosY, x

		lda PixelCount, x
		clc
		adc SPEED_Pixel
		sta PixelCount, x
		
		sec
		sbc #8
		bmi NotCharDown

		sta PixelCount, x

		inc CharY, x

	NotCharDown:

		lda CharY, x
		cmp #17
		bcc NoBoundDown

		jmp Despawn 

	NoBoundDown:
		rts


	MoveLeft:	

		lda PosX_LSB, x
		sec
		sbc SPEED_Pixel
		sta PosX_LSB, x

		lda PosX_MSB, x
		sbc #0
		sta PosX_MSB, x

		lda PixelCount, x
		clc
		adc SPEED_Pixel
		sta PixelCount, x

		sec
		sbc #8
		bmi NotCharLeft

		sta PixelCount, x

		dec CharX, x


	NotCharLeft:

		lda CharX, x
		cmp #4
		bcs NoBoundLeft

		jmp Despawn 

	NoBoundLeft:

		rts


	MoveRight:

		lda PosX_LSB, x
		clc
		adc SPEED_Pixel
		sta PosX_LSB, x

		lda PosX_MSB, x
		adc #0
		sta PosX_MSB, x

		lda PixelCount, x
		clc
		adc SPEED_Pixel
		sta PixelCount, x

		sec
		sbc #8
		bmi NotCharRight

		sta PixelCount, x

		inc CharX, x

	NotCharRight:

		lda CharX, x
		cmp #36
		bcc NoBoundRight

		jmp Despawn 

	NoBoundRight:

		rts


	Finish:

		


		rts


	}


	Despawn: {

		lda #0
		sta Active, x

		jsr RANDOM.Get
		and #%01111111
		sta ENEMY.ShootTimer, x


		rts
	}

	CheckCollisionWall: {

		lda Direction, x
		asl
		asl
		sta ZP.StartID
		tay

		clc
		adc #4
		sta ZP.EndID

		Loop:

			sty ZP.Y

			lda CharX, x
			clc
			adc ChecksX_Left, y
			sta ZP.Column

			lda CharY, x
			clc
			adc ChecksY_Left, y
			sta ZP.Row

			ldx ZP.Column
			ldy ZP.Row

			jsr PLOT.GetCharacter

			

			cmp #CHAR_TUNNEL
			bne HitWall

			ldy ZP.Y
			ldx ZP.X

			iny
			cpy ZP.EndID
			bcc Loop

			

			rts

		HitWall:

			ldx ZP.X
			jmp Despawn



		rts
	}


	CheckCollisionEnemy: {


		txa
		eor #%00000001
		tay

		lda ENEMY.Active, y
		beq EndLoop

		lda ENEMY.Dead, y
		bne EndLoop

		lda ENEMY.PosX_MSB, y
		sec
		sbc PosX_MSB, x
		bne EndLoop

		lda ENEMY.PosY, y
		sec
		sbc PosY, x
		clc
		adc #10
		cmp #20
		bcs EndLoop

		lda ENEMY.PosX_LSB, y
		sec
		sbc PosX_LSB, x
		clc
		adc #12
		cmp #24
		bcs EndLoop

		
		jmp Despawn

		EndLoop:

			rts

	}



	FrameUpdate: {

		ldx #0

		Loop:

			lda Active, x
			bne Moving

			jmp EndLoop

		Moving:

			//da Cooldown, x
			//beq Ready

			//dec Cooldown, x
		//	rts

			Ready:

			stx ZP.X
		
			jsr CheckCollisionWall
			jsr CheckCollisionEnemy
			jsr Move
			//jsr CheckCollisionWall

			// lda Direction, x
			// cmp #3
			// bcc NoDisplay

			// stx ZP.X

			// lda CharX, x
			// sta ZP.Column

			// lda CharY, x
			// tay

			// ldx ZP.Column

			// jsr PLOT.GetCharacter

			// ldy #0
			// lda #YELLOW_MULT
			// sta (ZP.ColourAddress), y

			ldx ZP.X


			NoDisplay:



		EndLoop:

			inx
			cpx #2
			bcc Loop

			


		Finish:

			rts

			
	}	





}