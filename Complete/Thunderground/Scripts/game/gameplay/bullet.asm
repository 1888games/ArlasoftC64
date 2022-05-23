BULLET: {

	* = * "Bullet"

	Active: 	.byte 0
	XOffset:	.byte 247, 7, 253, 253
				.byte 247, 7, 1, 1

	YOffset:	.byte 254, 254, 8, 248
				.byte 2, 2, 8, 248


	Direction:	.byte 0
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


	Side:		.byte LEFT
	SideAdd:	.byte 0, 4
	SideLook:	.byte 0

	PosX_LSB:	.byte 0
	PosX_MSB:	.byte 0
	PosY:		.byte 0

	.label Pointer = 23

	.label Speed = 5

	CharX:		.byte 0
	CharY:		.byte 0

	Cooldown:	.byte 0


	NewLevel: {


		lda #0
		sta Active
		sta Side


		rts
	}

	Fire: {

		lda Active
		bne Finish

		lda PLAYER.PosX_LSB
		sta PosX_LSB

		lda PLAYER.PosX_MSB
		sta PosX_MSB

		ldx PLAYER.MoveDirection
		stx Direction

		ldy Side
		txa
		clc
		adc SideAdd, y
		tay
		sty SideLook

		lda XOffset, y
		bmi Subtract

		Add:

			lda PLAYER.PosX_LSB
			clc
			adc XOffset, y
			sta PosX_LSB
			sta ZP.SpriteX

			lda PosX_MSB
			adc #0
			sta PosX_MSB
			sta ZP.SpriteX_MSB

			jmp Y

		Subtract:

			lda PLAYER.PosX_LSB
			clc
			adc XOffset, y
			sta PosX_LSB
			sta ZP.SpriteX

			lda PosX_MSB
			sbc #0
			sta PosX_MSB
			sta ZP.SpriteX_MSB

		Y:

			lda PLAYER.PosY
			clc
			adc YOffset, y
			sta PosY
			sta ZP.SpriteY

			lda #1
			sta Active
			sta Cooldown


		SubtractY:

		jsr ConvertToChars

		Finish:

		rts
	}


	ConvertToChars: {

		jsr ConvertSpritePosToChars

		ldx Direction

		ldy SideLook

		lda ZP.CharX
		clc
		adc CharXOffset, y
		sta CharX

		cmp #40
		bcs InvalidShot

		lda ZP.CharY
		clc
		adc CharYOffset, y
		sta CharY

		cmp #1
		bcc InvalidShot

		cmp #17
		bcs InvalidShot

		lda Side
		eor #%00000001
		sta Side

		sfx(SFX_FIRE)

		rts

		InvalidShot:

		lda #0
		sta Active


		rts
	}



	ConvertSpritePosToChars: {

		.label Adjust = ZP.Temp2
		.label AddColumns = ZP.Temp3



		SetupDefaults:

			lda #255
			sta Adjust

			lda #29
			sta AddColumns

		CheckIfMSBAdjust:

			lda ZP.SpriteX_MSB
			bne NoAdjust

			lda #20
			sta Adjust

			lda #0
			sta AddColumns

		NoAdjust:
		CalculateX:

			lda ZP.SpriteX
			sec
			sbc Adjust

			lsr
			lsr
			lsr
			clc
			adc AddColumns
			sta ZP.CharX

		CalculateY:
		
			lda ZP.SpriteY
			sec
			sbc #50
			lsr
			lsr
			lsr
			sta ZP.CharY

		
		
		rts
	}


	.label PixelsPerFrame = 8

	Move: {

			lda Direction
			cmp #LEFT
			beq MoveLeft

			cmp #RIGHT
			beq MoveRight

			cmp #DOWN
			beq MoveDown

		MoveUp:

			dec CharY
			//dec CharY

			lda PosY
			sec
			sbc #PixelsPerFrame
			sta PosY

			lda CharY
			bpl NoBoundUp

			jmp Despawn 

		NoBoundUp:

			rts

		MoveDown:

			inc CharY
			//inc CharY

			lda PosY
			clc
			adc #PixelsPerFrame
			sta PosY

			lda CharY
			cmp #17
			bcc NoBoundDown

			jmp Despawn 

		NoBoundDown:
			rts


		MoveLeft:	

			dec CharX
		//	dec CharX

			lda PosX_LSB
			sec
			sbc #PixelsPerFrame
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB
			bne NoBoundLeft

			lda CharX
			bpl NoBoundLeft

			jmp Despawn 

		NoBoundLeft:

			rts


		MoveRight:

			inc CharX
			//inc CharX

			lda PosX_LSB
			clc
			adc #PixelsPerFrame
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB
			beq NoBoundRight

			lda CharX
			cmp #40
			bcc NoBoundRight

			jmp Despawn 

		NoBoundRight:

			rts


		Finish:


		rts


	}


	CheckCollisionBase: {

		ldx #0


		Loop:

			lda BASES.Visible, x
			beq NotHit

			lda BASES.SpriteX, x
			sec
			sbc PosX_LSB
			clc
			adc #7
			cmp #14
			bcs NotHit

			lda #BASES.SpriteY
			clc
			adc #8
			sec
			sbc PosY
			clc
			adc #10
			cmp #20
			bcs NotHit

			jsr BASES.Hit
			rts


			NotHit:

				inx
				cpx #6
				bcc Loop

		rts
	}

	CheckCollisionEnemy: {

		ldx #0

		Loop:

			lda ENEMY.Active, x
			beq EndLoop

			lda ENEMY.Dead, x
			bne EndLoop


			lda ENEMY.PosX_MSB, x
			sec
			sbc PosX_MSB
			bne EndLoop

			lda ENEMY.PosY, x
			sec
			sbc PosY
			clc
			adc #12
			cmp #24
			bcs EndLoop

			lda ENEMY.PosX_LSB, x
			sec
			sbc PosX_LSB
			clc
			adc #14
			cmp #28
			bcs EndLoop

			lda #1
			sta ENEMY.Dead, x

			lda #0
			sta Active

			stx ZP.X

			ldy #68
			jsr SCORE.AddScore

			sfx(SFX_ENEMY)

			ldx ZP.X

			EndLoop:

				inx
				cpx #2
				bcc Loop



			Finish:

				rts



		rts
	}

	FrameUpdate: {

		lda Active
		bne Moving

		jmp Finish

		Moving:

			lda PLAYER.CollectTimer
			bmi NotCollecting

			jmp Finish

		NotCollecting:

			lda Cooldown
			beq Ready

			dec Cooldown
			rts

			Ready:

			jsr CheckCollisionEnemy
			jsr CheckCollisionBase
			jsr CheckCollisionWall
			jsr Move
			//jsr CheckCollisionWall

			


		Finish:

			rts

			
	}	


	CheckCollisionWall: {

		lda Direction
		asl
		asl
		sta ZP.StartID
		tax

		clc
		adc #4
		sta ZP.EndID

		Loop:

			stx ZP.StoredXReg

			lda CharX
			clc
			adc ChecksX_Left, x
			sta ZP.Column

			lda CharY
			clc
			adc ChecksY_Left, x
			sta ZP.Row

			ldx ZP.Column
			ldy ZP.Row

			jsr PLOT.GetCharacter

			cmp #CHAR_TUNNEL
			bne HitWall

			ldx ZP.StoredXReg

			inx
			cpx ZP.EndID
			bcc Loop

			rts

		HitWall:

			lda #0
			sta Active



		rts
	}


	Despawn: {

		lda #0
		sta Active


		rts
	}


	UpdateSprite: {

		lda Active
		beq Hide

		lda PosX_LSB
		sta VIC.SPRITE_6_X

		lda PosY
		sta VIC.SPRITE_6_Y

		lda PLAYER.Colour
		sta VIC.SPRITE_COLOR_6

		lda PosX_MSB
		beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + 6
			sta VIC.SPRITE_MSB
			jmp DoneMSB

		NoMSB:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 6
			sta VIC.SPRITE_MSB


		DoneMSB:

		lda #Pointer
		sta SPRITE_POINTERS + 6
		rts


		Hide:

			lda #0
			sta VIC.SPRITE_6_Y
 


		rts
	}

}