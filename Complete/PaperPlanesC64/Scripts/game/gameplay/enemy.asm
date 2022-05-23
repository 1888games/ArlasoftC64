ENEMY: {

	.label MAX_ENEMIES = MAX_SPRITES - 1




	DataPosition_LSB:	.fill MAX_ENEMIES, 0
	DataPosition_MSB:	.fill MAX_ENEMIES, 0
	LifeRemaining_LSB:	.fill MAX_ENEMIES, 0
	LifeRemaining_MSB:	.fill MAX_ENEMIES, 0
	X_Speed_Frac:		.fill MAX_ENEMIES, 0
	X_Speed_Pixel:		.fill MAX_ENEMIES, 0
	Y_Speed_Frac:		.fill MAX_ENEMIES, 0
	Y_Speed_Pixel:		.fill MAX_ENEMIES, 0
	Angle_LSB:			.fill MAX_ENEMIES, 0
	Angle_MSB:			.fill MAX_ENEMIES, 0
	X_Direction:		.fill MAX_ENEMIES, 0
	Y_Direction:		.fill MAX_ENEMIES, 0
	PosY_Frac:			.fill MAX_ENEMIES, 0
	PosX_LSB:			.fill MAX_ENEMIES, 0
	PosX_Frac:			.fill MAX_ENEMIES, 0
	PosX_MSB:			.fill MAX_ENEMIES, 0
	PosY:				.fill MAX_ENEMIES, 0


	Lifetime:		.byte 0
	SpawnDelay:		.byte 4
	SpawnTimer:		.byte 4
	SecondTimer:	.byte 50
	SlowMode:		.byte 0
	Invincible:		.byte 0
	Exit:			.byte 0

	Colours:		.byte RED, BLUE, GREEN, PURPLE, YELLOW, LIGHT_RED, DARK_GRAY, ORANGE

	.label StartLifetime = 8
	.label StartDelay = 2
	.label StartFrames = 50
	.label IncreasePerSpawn = 20

	.label MinY = 37
	.label MaxY = 241
	.label MaxX = 81
	.label MinX = 16


	Reset: {

		lda #StartLifetime
		sta Lifetime

		lda #StartFrames
		sta SpawnDelay
		sta SpawnTimer

		lda #50
		sta SecondTimer

		lda #0
		sta SlowMode
		sta Invincible
		sta Exit

		
		ldx #0

		Loop:

			lda #0
			sta DataPosition_MSB, x

			lda #10
			sta SpriteY + 1, x
			//sta SpriteX + 2, x

			inx
			cpx #MAX_ENEMIES
			bcc Loop

		//jsr Spawn
		//jsr AngleToSpeed


		rts
	}


	GetAvailableID: {

		ldx #0

		Loop:

			lda DataPosition_MSB, x
			bne EndLoop

		Found:

			rts

		EndLoop:

			inx
			cpx #MAX_ENEMIES
			bcc Loop

		rts
	}

	AngleToSpeed: {

		stx ZP.CurrentID

		lda Angle_MSB, x
		tay

		lda LOOKUP.X_Pixel, y
		sta X_Speed_Pixel, x

		lda LOOKUP.Y_Pixel, y
		sta Y_Speed_Pixel, x

		lda LOOKUP.X_Frac, y
		sta X_Speed_Frac, x

		lda LOOKUP.Y_Frac, y
		sta Y_Speed_Frac, x

		lda LOOKUP.Pointers, y
		clc
		adc #PLAYER.StartPointer
		sta SpritePointer + 1, x

		lda LOOKUP.X_PosNeg, y
		sta X_Direction, x

		lda LOOKUP.Y_PosNeg, y
		sta Y_Direction, x


		rts
	}




	Spawn: {

		jsr GetAvailableID

		cpx #MAX_ENEMIES
		bcc Available


		rts

		Available:

			lda #$a0
			sta DataPosition_MSB, x

			lda #0
			sta DataPosition_LSB, x
			sta Angle_LSB, x
			sta Angle_MSB, x
			sta PosY_Frac, x
			sta PosX_Frac, x
			sta PosX_MSB, x
			sta PosX_Frac, x

		
			lda #PLAYER.StartX
			sta SpriteX + 1, x
			sta PosX_LSB, x

			lda #PLAYER.StartY
			sta SpriteY + 1, x
			sta PosY, x

			jsr RANDOM.Get
			and #%00000111
			tay
			lda Colours, y
			sta SpriteColor + 1, x

			lda #PLAYER.StartPointer
			sta SpritePointer + 1, x

			jsr AngleToSpeed


		Finish:


		rts
	}

	UpdateYPosition: {

		lda Y_Direction, x
		bmi Upwards

		Downwards:

			lda PosY_Frac, x
			clc
			adc Y_Speed_Frac, x
			sta PosY_Frac, x

			lda PosY, x
			adc #0
			clc
			adc Y_Speed_Pixel, x
			sta PosY, x

			cmp #MaxY
			bcc SetSprite

			jmp Bounce

		Upwards:

			lda PosY_Frac, x
			sec
			sbc Y_Speed_Frac, x
			sta PosY_Frac, x

			lda PosY, x
			sbc #0
			sec 
			sbc Y_Speed_Pixel, x
			sta PosY, x

			cmp #MinY
			bcs SetSprite

		Bounce:

			lda Exit
			beq DoBounce

			lda #0
			sta DataPosition_MSB, x
			sta PosY, x

			jmp SetSprite


		DoBounce:

			lda Angle_MSB, x
			clc
			adc #128
			sta Angle_MSB, x

			jsr AngleToSpeed

			//lda #PLAYER.MaxY
			//sta PosY, x

		SetSprite:

			lda PosY, x
			sta SpriteY + 1, x





		rts
	}


	UpdateXPosition: {

		lda X_Direction, x
		bmi Left

		Right:

			lda PosX_Frac, x
			clc
			adc X_Speed_Frac, x
			sta PosX_Frac,x 

			lda PosX_LSB, x
			adc #0
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x

			lda PosX_LSB, x
			clc
			adc X_Speed_Pixel, x
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x
			beq SetSprite

			lda PosX_LSB, x
			cmp #MaxX
			bcc SetSprite

			jmp Bounce
			
		Left:

			lda PosX_Frac, x
			sec
			sbc X_Speed_Frac, x
			sta PosX_Frac, x

			lda PosX_LSB, x
			sbc #0
			sta PosX_LSB, x

			lda PosX_MSB, x
			sbc #0
			sta PosX_MSB, x

			lda PosX_LSB, x
			sec
			sbc X_Speed_Pixel, x
			sta PosX_LSB, x

			lda PosX_MSB, x
			sbc #0
			sta PosX_MSB, x
			bne SetSprite

			lda PosX_LSB, x
			cmp #MinX
			bcs SetSprite

		Bounce:

			lda Exit
			beq DoBounce

			lda #0
			sta DataPosition_MSB, x
			sta PosY, x

			jmp SetSprite


		DoBounce:

			lda Angle_MSB, x
			clc
			adc #128
			sta Angle_MSB, x

			jsr AngleToSpeed
			

		SetSprite:

			lda PosX_LSB, x
			sta SpriteX + 1, x

			lda PosX_MSB, x
			beq NoMSB

			lda SpriteColor + 1, x
			ora #%10000000
			sta SpriteColor + 1, x

			jmp Finish

		NoMSB:

			lda SpriteColor + 1, x
			and #%01111111
			sta SpriteColor + 1, x


		Finish:

		rts
	}


	Control: {

		lda DataPosition_MSB, x
		sta ZP.EnemyDataAddress + 1

		lda DataPosition_LSB, x
		sta ZP.EnemyDataAddress

		ldy #0
		lda (ZP.EnemyDataAddress), y
		sta ZP.Temp4
		beq NoAngleChange
		bmi Left

		Right:

		 	lda Angle_LSB, x
		 	clc
		 	adc #PLAYER.AnglePerFrame_LSB
		 	sta Angle_LSB, x

		 	lda Angle_MSB, x
		 	adc #0
		 	clc
		 	adc #PLAYER.AnglePerFrame_MSB
		 	sta Angle_MSB, x

		 	jmp UpdateAngle

		 Left:

		 	lda Angle_LSB, x
		 	sec
		 	sbc #PLAYER.AnglePerFrame_LSB
		 	sta Angle_LSB, x

		 	lda Angle_MSB, x
		 	sbc #0
		 	sec
		 	sbc #PLAYER.AnglePerFrame_MSB
		 	sta Angle_MSB, x

		 UpdateAngle:

		 	jsr AngleToSpeed

		 NoAngleChange:

		 	lda DataPosition_LSB, x
			clc
			adc #1
			sta DataPosition_LSB, x

			lda DataPosition_MSB, x
			adc #0
			sta DataPosition_MSB, x

			cmp #$c0
			bcc NoWrap

			lda #$a0
			sta DataPosition_MSB, x

		NoWrap:

		Finish:

		rts
	}

	CheckCollision: {

		lda Invincible
		bne NoCollision

		lda PosX_MSB, x
		cmp PLAYER.PosX_MSB
		bne NoCollision

		lda PosX_LSB, x
		sec
		sbc PLAYER.PosX_LSB
		clc 
		adc #6
		cmp #12
		bcs NoCollision

		lda PosY, x
		sec
		sbc PLAYER.PosY
		clc
		adc #6
		cmp #12
		bcs NoCollision

		Collided:

			sfx(SFX_DEAD)
			
			lda #0
			sta PLAYER.Active

			lda #RED
			sta $d020

			lda #100
			sta PLAYER.GameOverTime



		NoCollision:

		rts
	}

	FrameUpdate: {

		lda PLAYER.Active
		beq Finish

		//lda SecondTimer
		//beq Ready

		//dec SecondTimer
		//jmp UpdateEnemies

			lda ZP.Counter
			and SlowMode
			bne Finish

		
			lda SpawnTimer
			beq Ready

			dec SpawnTimer
			jmp UpdateEnemies


		Ready:

			lda SpawnDelay
			clc
			adc #IncreasePerSpawn
			bcc Okay

			lda #250

		Okay:

			//lda #20
			sta SpawnDelay
			sta SpawnTimer

			jsr Spawn

		UpdateEnemies:

			ldx #0

		Loop:

			lda DataPosition_MSB, x
			beq EndLoop

			jsr Control
			jsr UpdateXPosition
			jsr UpdateYPosition
			jsr CheckCollision

		EndLoop:

			inx
			cpx #MAX_ENEMIES
			bcc Loop




		Finish:


		rts
	}




}