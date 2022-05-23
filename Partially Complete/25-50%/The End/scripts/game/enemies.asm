ENEMIES: {

	* = * "Enemies"

	PosSpriteX:		.fill 8, 0
	PosSpriteY:		.fill 8, 0
	FracSpriteX:	.fill 8, 0
	FracSpriteY:	.fill 8, 0
	//PosCharX:		.fill 8, 2 + i * 2
	//PosCharY:		.fill 8, 4 + i * 2


	PosCharX:		.fill 8, 5
	PosCharY:		.fill 8, 5

	TargetCharX:	.fill 8, 0
	TargetCharY:	.fill 8, 0
	TargetSpriteX:	.fill 8, 0
	TargetSpriteY:	.fill 8, 0
	XDirection:		.fill 8, 0
	YDirection:		.fill 8, 0

	FrameTimer:		.fill 8, random() * FrameTime
	Frame:			.fill 8, 16
	BaseFrame:		.fill 8, 16
	Colour:			.fill 8, RED
	Mode:			.fill 8, 0
	TargetBlock:	.fill 8, 0
	BuildBlock:		.fill 8, 0

	MoveX:			.byte 0
	MoveY:			.byte 0
	SpawnCooldown:	.byte 0
	SpawnedEnemies:	.byte 0

	PixelSpeedX:	.fill 8, 0
	PixelSpeedY:	.fill 8, 0
	FractionSpeedX:	.fill 8, 0
	FractionSpeedY:	.fill 8, 0

	.label FrameTime = 3
	.label NumberOfEnemies = 8
	.label SpawnFrameID = 103
	.label SpawnCooldownTime = 30


	SpriteLookups:	.byte 0, 2, 4, 6, 8, 10, 12, 14

	EarlySpriteIDs:		.byte 0, 0, 0, 0
	LateSpriteIDs:		.byte 0, 0, 0, 0, 0, 0, 0, 0

	BaseFrames:		.byte 0, 24, 48
	Colours:		.byte RED, YELLOW, LIGHT_RED



PixelLookup:
.byte 0,000,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte 1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte 1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte 1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0
.byte 1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0
.byte 1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0
.byte 1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0
.byte 1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0
.byte 1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1


FractionLookup:
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.byte 104,104,180,120,90,72,60,51,45,40,36,33,30,28,26,24
.byte 104,104,104,240,180,144,120,103,90,80,72,65,60,55,51,48
.byte 104,104,104,104,14,216,180,154,135,120,108,98,90,83,77,72
.byte 104,104,104,104,104,32,240,206,180,160,144,131,120,111,103,96
.byte 104,104,104,104,104,104,44,1,225,200,180,164,150,138,129,120
.byte 104,104,104,104,104,104,104,53,14,240,216,196,180,166,154,144
.byte 104,104,104,104,104,104,104,104,59,24,252,229,210,194,180,168
.byte 104,104,104,104,104,104,104,104,104,64,32,6,240,222,206,192
.byte 104,104,104,104,104,104,104,104,104,104,68,39,14,249,231,216
.byte 104,104,104,104,104,104,104,104,104,104,104,71,44,21,1,240
.byte 104,104,104,104,104,104,104,104,104,104,104,104,74,49,27,8
.byte 104,104,104,104,104,104,104,104,104,104,104,104,104,76,53,32
.byte 104,104,104,104,104,104,104,104,104,104,104,104,104,104,78,56
.byte 104,104,104,104,104,104,104,104,104,104,104,104,104,104,104,80
.byte 104,104,104,104,104,104,104,104,104,104,104,104,104,104,104,104



	SpriteLookupX:	.fill 27, 24 + (i * 8)
	SpriteLookupY:	.fill 19, 50 + (i * 8)




	CheckFrameTimer: {

		CheckIfReady:

			lda FrameTimer, x
			beq Ready

			dec FrameTimer, x
			jmp Finish


		Ready:	

			lda #FrameTime
			sta FrameTimer, x

			inc Frame, x
			lda Frame, x
			cmp #40
			bcc Finish

			lda #16
			sta Frame, x

		Finish:

		rts


	}

	



	CheckMove: {
	
	 	CheckMoveX:

			lda TargetSpriteX, x
			cmp PosSpriteX, x
			beq MoveYNow

		MoveXNow:

			lda XDirection, x
			beq MoveLeft

		MoveRight:

			lda FracSpriteX, x
			clc
			adc FractionSpeedX, x
			sta FracSpriteX, x

			lda PosSpriteX, x
			adc #0
			clc
			adc PixelSpeedX, x
			sta PosSpriteX, x

			cmp TargetSpriteX, x
			bcc CheckYMove
			beq CheckYMove

			lda TargetSpriteX, x
			sta PosSpriteX, x
			jmp MoveYNow

		MoveLeft:

			lda FracSpriteX, x
			sec
			sbc FractionSpeedX, x
			sta FracSpriteX, x

			lda PosSpriteX, x
			sbc #0
			sec
			sbc PixelSpeedX, x
			sta PosSpriteX, x

			cmp TargetSpriteX, x
			bcs CheckYMove
			
			lda TargetSpriteX, x
			sta PosSpriteX, x
			

		MoveYNow:

			lda TargetSpriteY, x
			cmp PosSpriteY, x
			bne XMoved

		Reached:

			lda TargetCharX, x
			sta PosCharX,x 

			lda TargetCharY, x
			sta PosCharY,x 

			jsr NewDirection
			jmp Done

		CheckYMove:

			lda TargetSpriteY, x
			cmp PosSpriteY, x
			beq Done

		XMoved:

			lda YDirection,x
			beq MoveUp

		MoveDown:

			lda FracSpriteY, x
			clc
			adc FractionSpeedY, x
			sta FracSpriteY, x

			lda PosSpriteY, x
			adc #0
			clc
			adc PixelSpeedY, x
			sta PosSpriteY,x 

			cmp TargetSpriteY,x 
			bcc Done
			beq Done

			lda TargetSpriteY,x 
			sta PosSpriteY,x 
			jmp Done

		MoveUp:

			lda FracSpriteY, x
			sec
			sbc FractionSpeedY, x
			sta FracSpriteY, x

			lda PosSpriteY,x 
			sbc #0
			sec
			sbc PixelSpeedY, x
			sta PosSpriteY, x

			cmp TargetSpriteY, x
			bcs Done
			
			lda TargetSpriteY,x 
			sta PosSpriteY, x


		Done:

		rts
	}


	SpawnEnemy: {

		lda SpawnCooldown
		bne Finish

		lda #SpawnCooldownTime
		sta SpawnCooldown

		Finish:

		rts
	}

	FrameUpdate: {

		ldx #0
		stx EarlySprites
		stx LateSprites

		lda SpawnCooldown
		beq Loop

		dec SpawnCooldown

		Loop:

			stx StoredXReg

			lda PosCharY, x
			bne EnemyActive

			jsr SpawnEnemy
			jmp EndLoop

			EnemyActive:

			jsr CheckFrameTimer
			jsr CheckMove

			SkipMove:

			lda EarlySprites
			cmp #4
			bcs LateSprite

			lda PosSpriteY, x
			cmp #90
			bcs LateSprite

			EarlySprite:

				ldy EarlySprites
				txa
				sta EarlySpriteIDs, y
				inc EarlySprites
				jmp EndLoop

			LateSprite:

				ldy LateSprites
				txa
				sta LateSpriteIDs, y
				inc LateSprites

			EndLoop:

			inx
			cpx #NumberOfEnemies
		//	cpx #2
			bcc Loop





		rts
	}



	Reset: {

		ldx #0

		Loop:

			ldy PosCharX, x
			lda SpriteLookupX, y
			sta PosSpriteX, x

			ldy PosCharY, x
			lda SpriteLookupY, y
			sta PosSpriteY, x 

			RandomLoop:

				jsr RANDOM.Get
				and #%00000011
				cmp #3
				beq RandomLoop

			tay
			lda BaseFrames, y
			sta BaseFrame, x

			lda Colours, y
			sta Colour, x

			jsr NewDirection

		EndLoop:

			inx
			cpx #NumberOfEnemies
			bcc Loop


	//	.break

		//ldx #0

		jsr BLOCKS.GetAvailableBlock


		rts
	}



	NewDirection: {

		ChooseX:

			jsr RANDOM.Get
			and #%00001111

			clc
			adc #2
			sta TargetCharX, x
			tay
			lda SpriteLookupX, y
			sta TargetSpriteX, x

		ChooseY:

			jsr RANDOM.Get
			and #%00001111
			clc
			adc #3
			sta TargetCharY, x
			tay
			lda SpriteLookupY, y
			sta TargetSpriteY, x

		jsr CalculateRequiredSpeed

		rts


	}


	// 1 = right, 0 = left
	// 1 = down, 0 = up


	CalculateRequiredSpeed: {

		CalculateXMovement:

			lda PosCharX, x
			sec
			sbc TargetCharX, x
			bpl GoingLeft

			GoingRight:

				lda #1
				sta XDirection, x

				lda TargetCharX, x
				sec
				sbc PosCharX, x
				sta MoveX
				jmp CalculateYMovement

			GoingLeft:

				sta MoveX

				lda #0
				sta XDirection, x


		CalculateYMovement:
		
			lda PosCharY, x
			sec
			sbc TargetCharY, x
			bpl GoingUp

			GoingDown:

				lda #1
				sta YDirection, x

				lda TargetCharY, x
				sec
				sbc PosCharY, x
				sta MoveY
				jmp CalculateXSpeed

			GoingUp:

				sta MoveY

				lda #0
				sta YDirection, x

		CalculateXSpeed:

			lda MoveX
			asl
			asl
			asl
			asl
			clc
			adc MoveY
			tay

			lda PixelLookup, y
			sta PixelSpeedX, x

			lda FractionLookup, y
			sta FractionSpeedX, x


		CalculateYSpeed:

			lda MoveY
			asl
			asl
			asl
			asl
			clc
			adc MoveX
			tay

			lda PixelLookup, y
			sta PixelSpeedY, x

			lda FractionLookup, y
			sta FractionSpeedY, x

		rts


	}





}