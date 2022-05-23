.namespace BULLET {



	CheckPlayerCollision: {

		.label XSize = 3
		.label YSize = 8

		CheckIfPlayerBullet:

			cpx #2
			bcc NoCollision

			lda PLAYER.Dead
			bne NoCollision

		DoX:

			ldy #PLAYER.PlayerSprite

			lda SpriteX, y
			sec
			sbc SpriteX, x
			clc
			adc CollisionOffsetX, x
			clc
			adc #XSize
			cmp #XSize * 2
			bcs NoCollision

		DoY:

			lda SpriteY, y
			sec
			sbc SpriteY, x
			clc
			adc CollisionOffsetY, x
			clc
			adc #YSize
			cmp #YSize * 2
			bcs NoCollision	

			cmp #13
			beq NoCollision

		HitPlayer:

			jsr PLAYER.Kill
			jsr Destroy

			ldx ZP.X
	
		SkipKill:

	
		NoCollision:



		rts
	}

	CheckOttoCollision: {







		rts
	}


	CheckRobotCollision2: {


		.label XSize = 4
		.label YSize = 6
		// x = bullet
		// y = other sprite

		ldy #0

		Loop:

			sty ZP.Y

			lda ROBOT.PosY, y
			beq EndLoop

			tya 
			cmp IDThatFired, x
			beq EndLoop

			lda ROBOT.Sector, y
			cmp Sector, x
			bne EndLoop

			lda ROBOT.PosX_LSB, y
			sec
			sbc PosX_LSB, x
			clc
			adc CollisionOffsetX, x
			clc
			adc #XSize
			cmp #XSize * 2
			bcs EndLoop


			lda ROBOT.PosY, y
			sec
			sbc PosY, x
			clc
			adc CollisionOffsetY, x
			clc
			adc #YSize
			cmp #YSize * 2
			bcs EndLoop

			tya
			tax
			sta ZP.RobotID

			lda ROBOT.State, x
			cmp #ROBOT_DYING
			beq SkipKill

			* = * "Horse"
			jsr Destroy

			jsr ROBOT.Kill

		SkipKill:

			ldx ZP.X
			ldy ZP.Y

		EndLoop:


			iny
			cpy ROBOT.StartCount
			bcc Loop



		rts
	}

	CheckRobotCollision: {


		.label XSize = 4
		.label YSize = 6
		// x = bullet
		// y = other sprite

		ldy #MAX_BULLETS

		Loop:

			sty ZP.Y

			lda SpriteY, y
			beq EndLoop

			tya 
			cmp IDThatFired, x
			beq EndLoop

			lda SpriteX, y
			sec
			sbc SpriteX, x
			clc
			adc CollisionOffsetX, x
			clc
			adc #XSize
			cmp #XSize * 2
			bcs EndLoop


			lda SpriteY, y
			sec
			sbc SpriteY, x
			clc
			adc CollisionOffsetY, x
			clc
			adc #YSize
			cmp #YSize * 2
			bcs EndLoop

			tya
			sec
			sbc #BULLET.MAX_BULLETS
			tax
			sta ZP.RobotID

			cmp #11
			bne NotOtto

			jsr Destroy
			jmp SkipKill

		NotOtto:

			lda ROBOT.State, x
			cmp #ROBOT_DYING
			beq SkipKill

			* = * "Horse"
			jsr Destroy


			jsr ROBOT.Kill

		SkipKill:

			ldx ZP.X
			ldy ZP.Y

		EndLoop:


			iny
			cpy #MAX_BULLETS + ROBOT.MAX_ROBOTS + 1
			bcc Loop


			

		rts
	}

	CheckWallCollision: {

			jmp NoBlock

			lda CharY, X
			sta PLAYER.UseCharY
			lsr
			tay

			lda CharX, X
			sta PLAYER.UseCharX
			lsr
			tax

			jsr PLOT.GetCharacter

			beq NoBlock

			sec
			sbc #1
			sta ZP.CharID

			jsr PLAYER.CalculateBlockID

			//ldy ZP.XY			//lda Diagonal, y
		//	bne KillMe


			lda PLAYER.BlockRightTop_Left, x
			beq NoBlock

			ldx ZP.X


		KillMe:

			jmp Destroy

		NoBlock:

			ldx ZP.X
			lda CharY_2, X
			sta PLAYER.UseCharY
			lsr
			tay

			lda CharX_2, X
			bmi NoBlock2
			sta PLAYER.UseCharX
			lsr
			tax

			jsr PLOT.GetCharacter

			beq NoBlock2

			sec
			sbc #1
			sta ZP.CharID

			jsr PLAYER.CalculateBlockID
	//ldy ZP.X
			//lda Diagonal, y
		//	bne KillMe

			lda PLAYER.BlockRightTop_Left, x
			beq NoBlock2

			ldx ZP.X

			jmp Destroy

		NoBlock2:


			ldx ZP.X
			lda CharY_3, X
			sta PLAYER.UseCharY
			lsr
			tay

			lda CharX_3, X
			sta PLAYER.UseCharX
			bmi NoBlock3
			lsr
			tax

			jsr PLOT.GetCharacter

			beq NoBlock3

			sec
			sbc #1
			sta ZP.CharID

			jsr PLAYER.CalculateBlockID
	//ldy ZP.X
			//lda Diagonal, y
		//	bne KillMe


			lda PLAYER.BlockRightTop_Left, x
			beq NoBlock3

			ldx ZP.X


			jmp Destroy

		NoBlock3:



		rts
	}



}