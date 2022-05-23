PLAYER: {


	PosX_LSB:	.byte 0
	PosX_MSB:	.byte 0
	PosX_Frac:	.byte 0


	PosY:		.byte 0
	PosY_Frac:	.byte 0




	TurnByte_LSB:	.byte 0
	TurnByte_MSB:	.byte 0


	Active:		.byte 0


	Angle_MSB:	.byte 0
	Angle_LSB:	.byte 0
	Pointer:	.byte 0


	X_Speed_Pixel:	.byte 0
	X_Speed_Frac:	.byte 0

	Y_Speed_Pixel:	.byte 2
	Y_Speed_Frac:	.byte 50

	X_Direction:	.byte 0
	Y_Direction:	.byte 255

	GameOverTime:	.byte 100



	.label StartX = 173
	.label StartY = 193

	.label StartPointer = 17

	.label MinY = 33
	.label MaxY = 245
	.label MaxX = 85
	.label MinX = 12
	.label AnglePerFrame_LSB = 180
	.label AnglePerFrame_MSB = 3



	Reset: {

		lda #WHITE
		sta SpriteColor

		lda #47
		sta SpritePointer

		lda #StartX
		sta SpriteX
		sta PosX_LSB

		lda #StartY
		sta SpriteY
		sta PosY

		lda #$a0
		sta ZP.PlayerDataAddress + 1

		lda #0
		sta VIC.SPRITE_MULTICOLOR
		sta ZP.PlayerDataAddress	
		sta Angle_MSB
		sta PosX_MSB
		sta Angle_LSB

		lda #StartPointer
		sta SpritePointer
		cmp #32
		bcs UseHires	

		dec VIC.SPRITE_MULTICOLOR

		UseHires:


		inc Active

		jsr AngleToSpeed

		rts
	}


	AngleToSpeed: {

		ldx Angle_MSB

		lda LOOKUP.X_Pixel, x
		sta X_Speed_Pixel

		lda LOOKUP.Y_Pixel, x
		sta Y_Speed_Pixel

		lda LOOKUP.X_Frac, x
		sta X_Speed_Frac

		lda LOOKUP.Y_Frac, x
		sta Y_Speed_Frac

		lda LOOKUP.Pointers, x
		clc
		adc #StartPointer
		sta SpritePointer

		lda LOOKUP.X_PosNeg, x
		sta X_Direction

		lda LOOKUP.Y_PosNeg, x
		sta Y_Direction




		rts
	}


	CheckPowerup: {
		lda POWERUP.PowerActive
		bmi NoCollision

		lda PosX_MSB
		cmp POWERUP.PosX_MSB
		bne NoCollision

		lda PosX_LSB
		sec
		sbc POWERUP.PosX_LSB
		clc 
		adc #8
		cmp #16
		bcs NoCollision

		lda PosY
		sec
		sbc POWERUP.PosY
		clc
		adc #8
		cmp #16
		bcs NoCollision


		Collided:

			sfx(SFX_POWER)
			jsr POWERUP.Collect


		NoCollision:

		rts


	}

	CheckCollision: {

		lda PosX_MSB
		cmp COLLECT.PosX_MSB
		bne NoCollision

		lda PosX_LSB
		sec
		sbc COLLECT.PosX_LSB
		clc 
		adc #8
		cmp #16
		bcs NoCollision

		lda PosY
		sec
		sbc COLLECT.PosY
		clc
		adc #8
		cmp #16
		bcs NoCollision


		Collided:	


			sfx(SFX_COLLECT)

			jsr SCORING.Increase
			jsr COLLECT.New





		NoCollision:

		rts
	}

	Control: {

		ldy #1

		lda #0
		sta ZP.Temp4


		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
		 	beq CheckLeft

		 Right:

		 	lda Angle_LSB
		 	clc
		 	adc #AnglePerFrame_LSB
		 	sta Angle_LSB

		 	lda Angle_MSB
		 	adc #0
		 	clc
		 	adc #AnglePerFrame_MSB
		 	sta Angle_MSB

		 	inc ZP.Temp4

		 	jmp UpdateAngle

		 CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
		 	beq NoAngleChange

		 Left:

		 	lda Angle_LSB
		 	sec
		 	sbc #AnglePerFrame_LSB
		 	sta Angle_LSB

		 	lda Angle_MSB
		 	sbc #0
		 	sec
		 	sbc #AnglePerFrame_MSB
		 	sta Angle_MSB

		 	dec ZP.Temp4


		 UpdateAngle:

		 	lda ZP.Temp4
		 	beq NoAngleChange

		 	jsr AngleToSpeed

		 NoAngleChange:

		 	lda ZP.Temp4
		 	ldy #0
		 	sta (ZP.PlayerDataAddress), y


		 NoMove:

		 	lda ZP.PlayerDataAddress
			clc
			adc #1
			sta ZP.PlayerDataAddress

			lda ZP.PlayerDataAddress + 1
			adc #0
			sta ZP.PlayerDataAddress + 1

			cmp #$c0
			bcc NoWrap

			lda #$a0
			sta ZP.PlayerDataAddress + 1

		NoWrap:

		Finish:


		rts
	}




	UpdateYPosition: {

		lda Y_Direction
		bmi Upwards

		Downwards:

			lda PosY_Frac
			clc
			adc Y_Speed_Frac
			sta PosY_Frac

			lda PosY
			adc #0
			clc
			adc Y_Speed_Pixel
			sta PosY

			cmp #MaxY
			bcc SetSprite

				
			lda #MinY
			sta PosY

			jmp SetSprite

		Upwards:

			lda PosY_Frac
			sec
			sbc Y_Speed_Frac
			sta PosY_Frac

			lda PosY
			sbc #0
			sec 
			sbc Y_Speed_Pixel
			sta PosY

			cmp #MinY
			bcs SetSprite

			lda #MaxY
			sta PosY

		SetSprite:

			lda PosY
			sta SpriteY





		rts
	}


	UpdateXPosition: {

		lda X_Direction
		bmi Left

		Right:

			lda PosX_Frac
			clc
			adc X_Speed_Frac
			sta PosX_Frac

			lda PosX_LSB
			adc #0
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB

			lda PosX_LSB
			clc
			adc X_Speed_Pixel
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB
			beq SetSprite

			lda PosX_LSB
			cmp #MaxX
			bcc SetSprite

			lda #MinX
			sta PosX_LSB

			lda #0
			sta PosX_MSB

			jmp SetSprite


		Left:

			lda PosX_Frac
			sec
			sbc X_Speed_Frac
			sta PosX_Frac

			lda PosX_LSB
			sbc #0
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB

			lda PosX_LSB
			sec
			sbc X_Speed_Pixel
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB
			bne SetSprite

			lda PosX_LSB
			cmp #MinX
			bcs SetSprite

			lda #MaxX
			sta PosX_LSB

			lda #1
			sta PosX_MSB
			

		SetSprite:

			lda PosX_LSB
			sta SpriteX

			lda PosX_MSB
			beq NoMSB

			lda SpriteColor
			ora #%10000000
			sta SpriteColor

			jmp Finish

		NoMSB:

			lda SpriteColor
			and #%01111111
			sta SpriteColor


		Finish:

		rts
	}


	UpdateSprite: {









		rts
	}



	CheckInvincible: {

		lda #WHITE
		sta SpriteColor

		lda ENEMY.Invincible
		beq Finish

		lda ZP.Counter
		and #%00001111
		cmp #8
		bcs Finish

		lda #LIGHT_GRAY
		sta SpriteColor



		Finish:

		rts
	}


	FrameUpdate: {

		lda Active
		bne GameActive

		lda GameOverTime
		beq NewGame

		dec GameOverTime
		rts

		NewGame:

			ldy #1
			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq Finish

			jsr MAIN.ResetGame
			rts


		GameActive:

		jsr CheckInvincible
		jsr Control
		jsr UpdateXPosition
		jsr UpdateYPosition
		jsr CheckCollision
		jsr CheckPowerup









		Finish:

		rts
	}

}