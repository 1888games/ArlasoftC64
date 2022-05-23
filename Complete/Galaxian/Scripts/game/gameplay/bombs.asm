BOMBS: {

	* = * "Bombs"

	// Explosion = 0
	// Enemies - Sprites 1-7
	// Flagship = 1
	// Escorts = 2 & 3
	// Individuals 4 - 7


	// Bombs - Sprites 8-16

	// Our bullet = 17
	// Ship - Sprites 18-19

	.label BombStartID = 8
	.label Pointer =49
	//.label BombEndID = BombStartID + 7
	.label ReloadTime = 15

	Active: 		.fill MAX_ENEMIES + MAX_BOMBS, 0

	PixelSpeedX:	.fill MAX_ENEMIES + MAX_BOMBS, 0
	PixelSpeedY:	.fill MAX_ENEMIES + MAX_BOMBS, 1
	FractionSpeedX:	.fill MAX_ENEMIES + MAX_BOMBS, 0
	FractionSpeedY:	.fill MAX_ENEMIES + MAX_BOMBS, 0

	ActiveBombs:	.byte 0
	BombEndID:		.byte BombStartID + 7	

	.label MaxY = 252

	Fire: {

		ldy #BombStartID

		lda SHIP.Active
		beq Finish

		FindLoop:

			lda Active, y
			beq Found

			iny
			cpy BombEndID
			bcc FindLoop

			jmp Finish


		Found:

			ldx ZP.EnemyID
		
			jsr SetupSprite

			//.//lda Active y
			//beq Finish

			jsr CalculateDistanceToPlayer
	
			inc ActiveBombs

			ldx ZP.EnemyID

		Finish:

		rts

	}


	SetupSprite: {

		lda SpriteX, x
		clc
		adc #4
		sta SpriteX, y

		//cmp #35
		//bcc Skip

		//cmp #245
		//bcs Skip

		lda SpriteY, x
		sec
		sbc #8
		sta SpriteY, y

		lda #1
		sta Active, y

		lda #0
		sta SpriteX_LSB, y
		sta SpriteY_LSB, y

		lda #WHITE + 128
		sta SpriteColor, y

		lda #Pointer
		sta SpritePointer, y

		sty ZP.CurrentID


		Skip:


		rts	
	}

	CalculateDistanceToPlayer: {

		lda #-16
		sec 
		sbc SpriteY, x
		sta ZP.D

		lda CHARGER.ShipX
		sec
		sbc SpriteX, x
		bcs DontNegate


	Negate:

		eor #%11111111
		clc
		adc #1

		jsr ComputeBulletDelta

		ldy ZP.CurrentID
		sta FractionSpeedX, y

		
		lda #1
		sta PixelSpeedX, y

		rts

	DontNegate:

		jsr ComputeBulletDelta

		ldy ZP.CurrentID
		sta FractionSpeedX, y

	
		lda #0
		sta PixelSpeedX, y

		rts
	}


	ComputeBulletDelta: {

		jsr CalculateTangent
		jsr RANDOM.Get
		and #%00011111
		clc
		adc ZP.C
		clc
		adc #6
		bpl Finish

		jsr RANDOM.Get
		and #%00011111
		clc
		adc #80

		Finish:




		Okay:



		rts
	}


	CalculateTangent: {

		ldy #0
		sty ZP.C

		ldy #8

		Loop:

			cmp ZP.D
			bcs Skip

			sec
			sbc ZP.D

		Skip:

			rol
			eor #%00000001
			ror

			rol ZP.C
			ror ZP.D

			dey
			bne Loop

		rts
			

	}


	 CheckMove: {

	 	lda SpriteY, x
	 	cmp #20
	 	bcc Reached
	
			lda PixelSpeedX, x
			bne MoveLeft


		MoveRight:

			lda SpriteX_LSB, x
			clc
			adc FractionSpeedX, x
			sta SpriteX_LSB, x

			lda SpriteX, x
			adc #0
			sta SpriteX, x

			jmp MoveYNow

		MoveLeft:

			lda SpriteX_LSB, x
			sec
			sbc FractionSpeedX, x
			sta SpriteX_LSB, x

			lda SpriteX, x
			sbc #0
			sta SpriteX, x

			cmp #16
			bcc Reached

		MoveYNow:

			lda SpriteY, x
			clc
			adc #2
			sta SpriteY, x

	 		cmp #20
	 		bcc Reached
				
			rts

		Reached:

			lda #0
			sta Active, x

			lda #10
			//sta SpriteX, x
			sta SpriteY, x

			dec ActiveBombs

		Done:

		rts
	}	


	

	CheckCollision: {

		lda SHIP.Active
		beq NoCollision

		lda #SHIP.SHIP_Y
		sec
		sbc #5
		sec
		sbc SpriteY, x
		adc #8
		cmp #16
		bcs NoCollision

		lda SHIP.PosX_MSB
		clc
		adc #3
		sec
		sbc SpriteX, x
		clc
		adc #7
		cmp #14
		bcs CheckDualFighter

		Collision:

			jsr SHIP.KillMainShip

		DestroyBombs:

			lda SHIP.Active
			bne NotDead

			ldy #BombStartID

			DestroyLoop:

				lda #0
				sta Active, y

				lda #10
			//	sta SpriteX, y
				sta SpriteY, y

				iny
				cpy #BombStartID + 6
				bcc DestroyLoop

				lda #0
				sta ActiveBombs

				rts

			NotDead:

				lda #0
				sta Active, x


				lda #10
			//	sta SpriteX, x
				sta SpriteY, x

				dec ActiveBombs

				rts



		CheckDualFighter:

			lda SHIP.DualFighter
			clc
			adc SHIP.TwoPlayer
			beq NoCollision

			lda SHIP.PosX_MSB + 1
			clc
			adc #3
			sec
			sbc SpriteX, x
			clc
			adc #7
			cmp #14
			bcs NoCollision

			jsr SHIP.KillDualShip
			jmp DestroyBombs

		NoCollision:




		rts
	}

	FrameUpdate: {

		Again:

		lda #0
		sta ActiveBombs

		ldx #BombStartID

		Loop:	

			stx ZP.StoredXReg

			lda Active, x
			beq EndLoop

			jsr CheckCollision

			lda Active, x
			beq EndLoop

			jsr CheckMove

			lda Active, x
			beq EndLoop

			inc ActiveBombs
		

		EndLoop:

			ldx ZP.StoredXReg
			inx
			cpx BombEndID
			bcc Loop

		Finish:

			lda ENEMY.Repeated
			cmp #1
			bne DontRepeat

			inc ENEMY.Repeated
			jmp Again

		DontRepeat:

	 	rts
	 }


	

	


}