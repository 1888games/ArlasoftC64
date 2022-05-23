BULLET: {

	* = * "Bullet"

	CharX:		.fill 4, 0
	CharY:		.fill 4, 0
	CharID:		.fill 4, 0
	BulletSpriteX:	.fill 4, 0
	BulletSpriteY:	.fill 4, 0
	BulletSpriteMSB:	.fill 4, 0

	SpeedX:		.fill 4, 0
	SpeedY:		.fill 4, 0

	ScreenAddress_LSB:	.fill 4, 0
	ColourAddress_LSB:	.fill 4, 0
	ScreenAddress_MSB:	.fill 4, 0
	ColourAddress_MSB:	.fill 4, 0


	NumberActive:	.byte 0


	CharXOffset:	.byte -1, 1, 0, 0


	CharLookup:		.byte 0, 61, 61, 0, 62, 64, 63, 0, 62, 63, 64

	Cooldown:		.byte 0

	.label MAX_BULLETS = 3


	Fire: {

		lda Cooldown
		beq Okay

		rts

		Okay:
		
		jsr GetBulletID
		cpx #MAX_BULLETS
		bcc CanFire

		rts

		

		CanFire:

			sfx(SFX_FIRE)
			jsr SOUND.Fire

			ldy #0

			lda #0
			sta SpeedX, x
			sta SpeedY, x
			
			
		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda CharID, x
			clc
			adc #LEFT_MASK
			sta CharID, x

			lda #255
			sta SpeedX, x


			jmp CheckDown

		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda CharID, x
			clc
			adc #RIGHT_MASK
			sta CharID, x

			lda #1
			sta SpeedX, x



		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			lda CharID, x
			clc
			adc #DOWN_MASK
			sta CharID, x

			lda #1
			sta SpeedY, x

			jmp GotInput

		CheckUp:


			lda INPUT.JOY_UP_NOW, y
			beq GotInput

			lda CharID, x
			clc
			adc #UP_MASK
			sta CharID, x

			lda #255
			sta SpeedY, x

		


		GotInput:

		lda CharID, x
		tay

		lda CharLookup, y
		sta CharID, x

		lda PLAYER.CharX
		sta CharX, x

		lda PLAYER.PosX_LSB
		sta BulletSpriteX, x

		lda PLAYER.PosY
		sta BulletSpriteY, x

		lda PLAYER.PosX_MSB
		sta BulletSpriteMSB, x


		lda PLAYER.CharY
		sta CharY, x

		

		jsr GetAddress

		jsr DrawBullet

		lda #0
		sta Cooldown

	

		Finish:

		rts
	}



	HitSprite: {








		rts
	}



	Destroy: {

		lda #0
		sta CharID, x
		rts

	}

	Move: {


		lda CharX, x
		clc
		adc SpeedX, x
		sta CharX, x

		bmi Destroy

		cmp #34
		bcs Destroy


		lda CharY, x
		clc
		adc SpeedY, x
		sta CharY, x

		bmi Destroy

		cmp #25
		bcs Destroy

		CheckX:

			lda SpeedX, x
			beq CheckY
			bpl Right	
			
			Left:

				lda BulletSpriteX, x
				sec
				sbc #8
				sta BulletSpriteX, x

				lda BulletSpriteMSB, x
				sbc #0
				sta BulletSpriteMSB, x

				lda ScreenAddress_LSB, x
				sec
				sbc #1
				sta ScreenAddress_LSB, x

				lda ScreenAddress_MSB, x
				sbc #0
				sta ScreenAddress_MSB, x

				lda ColourAddress_LSB, x
				sec
				sbc #1
				sta ColourAddress_LSB, x

				lda ColourAddress_MSB, x
				sbc #0
				sta ColourAddress_MSB, x

				jmp CheckY

			Right:

				lda BulletSpriteX, x
				clc
				adc #8
				sta BulletSpriteX, x


				lda BulletSpriteMSB, x
				adc #0
				sta BulletSpriteMSB, x

				lda ScreenAddress_LSB, x
				clc
				adc #1
				sta ScreenAddress_LSB, x

				lda ScreenAddress_MSB, x
				adc #0
				sta ScreenAddress_MSB, x

				lda ColourAddress_LSB, x
				clc
				adc #1
				sta ColourAddress_LSB, x

				lda ColourAddress_MSB, x
				adc #0
				sta ColourAddress_MSB, x


		CheckY:

			lda SpeedY, x
			beq Draw
			bpl Down


			Up:

				lda BulletSpriteY, x
				sec
				sbc #8
				sta BulletSpriteY, x

				lda ScreenAddress_LSB, x
				sec
				sbc #40
				sta ScreenAddress_LSB, x

				lda ScreenAddress_MSB, x
				sbc #0
				sta ScreenAddress_MSB, x

				lda ColourAddress_LSB, x
				sec
				sbc #40
				sta ColourAddress_LSB, x

				lda ColourAddress_MSB, x
				sbc #0
				sta ColourAddress_MSB, x

				jmp Draw

			Down:

				lda BulletSpriteY, x
				clc
				adc #8
				sta BulletSpriteY, x

				lda ScreenAddress_LSB, x
				clc
				adc #40
				sta ScreenAddress_LSB, x

				lda ScreenAddress_MSB, x
				adc #0
				sta ScreenAddress_MSB, x


				lda ColourAddress_LSB, x
				clc
				adc #40
				sta ColourAddress_LSB, x

				lda ColourAddress_MSB, x
				adc #0
				sta ColourAddress_MSB, x


		Draw:

		jsr DrawBullet

		rts
	}

	DeleteBullet: {

		lda ScreenAddress_LSB, x
		sta ZP.ScreenAddress

		lda ScreenAddress_MSB, x
		sta ZP.ScreenAddress + 1

		lda ColourAddress_LSB, x
		sta ZP.ColourAddress

		lda ColourAddress_MSB, x
		sta ZP.ColourAddress + 1

		ldy #0
		lda (ZP.ScreenAddress), y
		cmp #25
		bcc Skip
	
		lda #0
		sta (ZP.ScreenAddress), y

		Skip:


		rts
	}

	FrameUpdate: {
//
		//inc $d020

		SetDebugBorder(RED)


		lda PLAYER.Dead
		bne Finish

		lda Cooldown
		beq Ready

		dec Cooldown
		

		Ready:

		ldx #0

		Loop:

			stx ZP.CurrentID

			lda CharID, x
			beq EndLoop

			jsr DeleteBullet
			jsr Move
			jsr SpriteCollisions

			EndLoop:

				inx
				cpx #MAX_BULLETS
				bcc Loop

		Finish:

		SetDebugBorder(DARK_GRAY)
	//	dec $d020

		rts
	}


	SpriteCollisions: {

		lda CharID, x
		beq Finish

		ldy SPRITE_MANAGER.FirstEnemySprite

		Loop:

			sty ZP.SpriteID

		IsSpriteAlive:

			lda SpriteType, y
			bmi EndLoop
			//beq EndLoop
			
		SpriteOk:

			jsr CheckSpriteCollision

		EndLoop:

			ldy ZP.SpriteID
			iny
			cpy #PLAYER.PlayerSprite
			bcc Loop

		Finish:


		rts
	}

	CheckSpriteCollision: {

		lda SpriteMSB, y
		cmp BulletSpriteMSB, x
		bne NoCollision

		lda SpriteY, y
		sec
		sbc BulletSpriteY, x
		clc
		adc #6
		cmp #12
		bcs NoCollision

		lda SpriteX, y
		sec
		sbc BulletSpriteX, x
		adc #6
		cmp #12
		bcs NoCollision

		lda SpriteType, y

			cmp #SPRITE_HULK
			bne NotHulk

		IsHulk:

			//jmp Kill

		NotHulk:

			cmp #SPRITE_SPHEROID
			bne NotSpheroid

		IsSpheroid:

			jsr KillSpriteEnemy

			lda LocalSpriteID, y
			tay

			lda #255
			sta SPHEROID.SpriteID, y

			jsr SOUND.KillSpheroid

			dec SPHEROID.NumberRemaining
			bne NoCollision

			jmp GRUNT.CheckAllEnemies

		NotSpheroid:

			cmp #SPRITE_ENFORCER
			bne NotEnforcer

		IsEnforcer:

			jsr KillSpriteEnemy

			lda LocalSpriteID, y
			tay

			lda #255
			sta ENFORCER.SpriteID, y

			jsr SOUND.KillSpheroid

			dec ENFORCER.NumberRemaining
			bne NoCollision

			jmp GRUNT.CheckAllEnemies

			//jmp Kill

		NotEnforcer:

			cmp #SPRITE_SPARK
			bne NotSpark

		IsSpark:

			jsr KillSpriteBullet

			lda LocalSpriteID, y
			tay

			lda #255
			sta SPARK.SpriteID, y

			jsr SOUND.KillSpheroid

			dec SPARK.NumberRemaining
			bne NoCollision

			jmp GRUNT.CheckAllEnemies


		NotSpark:



		NoCollision:

		rts
	}


	KillSpriteBullet: {
	
		dec SPRITE_MANAGER.BulletsActive
		jsr KillSprite

		rts
	}


	CreateDestroyAnim: {


		lda BULLET.CharX, x
		sta ZP.Column

		lda BULLET.CharY, x
		sta ZP.Row

		jsr GRUNT_PIECE.Add

		rts
	}



	KillSprite: {

		ldx ZP.CurrentID

		lda #0
		sta BULLET.CharID, x
		jsr BULLET.DeleteBullet

		ldy ZP.SpriteID
		lda #10
		sta SpriteY, y

		lda #255
		sta SpriteType, y

		rts
	}

	KillSpriteEnemy: {


		dec SPRITE_MANAGER.EnemiesActive

		jsr CreateDestroyAnim
		jsr KillSprite
	
		rts
	}
	
	DrawBullet: {


		lda ScreenAddress_LSB, x
		sta ZP.ScreenAddress

		lda ScreenAddress_MSB, x
		sta ZP.ScreenAddress + 1

		lda ColourAddress_LSB, x
		sta ZP.ColourAddress

		lda ColourAddress_MSB, x
		sta ZP.ColourAddress + 1

		
		ldy #0
		stx ZP.CurrentID

		lda (ZP.ScreenAddress), y
		sta ZP.Amount
		beq NoCollision
	
		cmp #39
		bcc HitSomething

		cmp #43
		bcc NoDraw

		jmp NoCollision

		HitSomething:

			lda CharX, x
			sta ZP.Column

			lda CharY, x
			sta ZP.Row

			lda #0
			sta CharID, x

			lda ZP.Amount
			cmp #31
			bcc Grunt

			Mine:

				lda #0
				sta (ZP.ScreenAddress), y
				rts

			Grunt:

				jsr GRUNT.CheckCollision
				ldx ZP.CurrentID
				rts

		NoCollision:

			lda CharID, x
			sta (ZP.ScreenAddress), y

		Again:

			lda ZP.Counter
			and #%00000111
			bne Ok

			lda #RED

		Ok:

			sta (ZP.ColourAddress), y

		NoDraw:
			

		rts
	}

	GetAddress: {

		tay
		stx ZP.CurrentID

		lda CharX, x
		tax

		jsr PLOT.GetCharacter



		ldx ZP.CurrentID

		lda ZP.ScreenAddress
		sta ScreenAddress_LSB, x

		lda ZP.ScreenAddress + 1
		sta ScreenAddress_MSB, x


		lda ZP.ColourAddress
		sta ColourAddress_LSB, x

		lda ZP.ColourAddress + 1
		sta ColourAddress_MSB, x



		rts

	}

	GetBulletID: {

		ldx #0

		Loop:

			lda CharID, x
			beq Found

			inx
			cpx #4
			bcc Loop

			rts

		Found:

			rts


	}

	
}