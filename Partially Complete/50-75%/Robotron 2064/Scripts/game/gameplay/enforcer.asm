ENFORCER: {


	* = * "Enforcer"

	.label MAX_ENFORCERS = 8

	SpriteID:		.fill MAX_ENFORCERS, 0
	MoveTimer:		.fill MAX_ENFORCERS, 0
	SpawnTimer:		.fill MAX_ENFORCERS, 0
	Frame:			.fill MAX_ENFORCERS, 0
	FireTimer:		.fill MAX_ENFORCERS, 0
	AITimer:		.fill MAX_ENFORCERS, 0

	XDeltaLSB:		.fill MAX_ENFORCERS, 0
	XDeltaMSB:		.fill MAX_ENFORCERS, 0
	YDeltaLSB:		.fill MAX_ENFORCERS, 0
	YDeltaMSB:		.fill MAX_ENFORCERS, 0
	XFrac:			.fill MAX_ENFORCERS, 0
	YFrac:			.fill MAX_ENFORCERS, 0
	XPositive:		.fill MAX_ENFORCERS, 0
	YPositive:		.fill MAX_ENFORCERS, 0

	NumberToGenerate:	.byte 0

	* = * "Enforcer Num Remaining"
	NumberRemaining:	.byte 0
	ColourFrame:		.byte 0
	FrameTimer:			.byte 0

	FirstID:			.byte 0
	LastID:				.byte 0
	MaxFireTime:		.byte 0
	NumberGenerated:	.byte 0
	

	.label BasePointer = 85
	.label PixelsPerMove = 4
	.label AI_Time = 2

	.label MinX = 24
	.label MaxX = 22
	.label MinY = 50
	.label MaxY = 236

	.label MiddleX = 152 - 24
	.label MiddleY = 143
	.label FrameTime = 4
	.label SpawnTime = 5

	Initialise: {

		lda HUMANS.NumberToGenerate
		clc
		adc HULK.NumberToGenerate
		clc
		adc SPHEROID.NumberToGenerate
		sta FirstID


		ldx #0
		stx NumberRemaining
		lda #255

		Loop:

			sta SpriteID, x

			inx
			cpx #MAX_ENFORCERS
			bcc Loop
	
		rts
	}


	CalcXDelta: {

		lda #0
		sta XDeltaMSB, x

		jsr RANDOM.Get
		and #%00111111
		sec
		sbc #32   // -32 to 31
		clc
		adc PLAYER.PosX_LSB

		cmp #MinX
		bcs Okay

		lda #255

		Okay:

		sta ZP.Column // target position

		lda SpriteMSB, y
		beq NotFarRight

		lda #255
		jmp GoLeft

		NotFarRight:

		lda SpriteX, y
		cmp ZP.Column
		bcs GoLeft

		GoRight:

			lda ZP.Column
			sec
			sbc SpriteX, y
			sta XDeltaLSB, x

			lda #1
			sta XPositive, x

			jmp DoneX

		GoLeft:

			sec
			sbc ZP.Column
			sta XDeltaLSB, x

			lda #0
			sta XPositive, x

		DoneX:


			.for(var i=0; i<3; i++) {

				asl XDeltaLSB, x

				lda XDeltaMSB, x
				adc #0
				sta XDeltaMSB, x
			}
			
	
	

		rts
	}


	CalcYDelta: {

		lda #0
		sta YDeltaMSB, x

		jsr RANDOM.Get
		and #%00111111
		sec
		sbc #32   // -32 to 31
		clc
		adc PLAYER.PosY

		cmp #MinY
		bcs Okay

		lda #MinY

		Okay:

		cmp #MaxY
		bcc Okay2

		lda #MaxY

		Okay2:

		sta ZP.Column // target position

		lda SpriteY, y
		cmp ZP.Column
		bcs GoUp

		GoDown:

			lda ZP.Column
			sec
			sbc SpriteY, y
			sta YDeltaLSB, x

			lda #1
			sta YPositive, x

			jmp DoneY

		GoUp:

			sec
			sbc ZP.Column
			sta YDeltaLSB, x

			lda #0
			sta YPositive, x

		DoneY:	

			.for(var i=0; i<3; i++) {

				asl YDeltaLSB, x

				lda YDeltaMSB, x
				adc #0
				sta YDeltaMSB, x
			}

			

		rts
	}

	ChangeDirection: {

		lda SpriteID, x
		tay

		jsr RANDOM.Get
		and #%00001111
		clc
		adc #1
		sta MoveTimer, x

		jsr CalcXDelta
		jsr CalcYDelta

		rts

	
	}

	FireSpark: {

		jsr GetFireDelay

		jsr SPARK.GetAvailableID

		cpx #255
		bne SlotAvailable

		ldx ZP.X
		rts

		SlotAvailable:

			stx ZP.LocalID
		
			ldx ZP.X
			lda SpriteID, x
			tay

			lda SpriteX, y
			sta ZP.Column

			lda SpriteMSB, y
			sta ZP.Amount

			lda SpriteY, y
			sta ZP.Row

			jsr SPARK.Spawn

			ldx ZP.X


		rts
	}

	Process: {

		jsr Move

	

		CheckIfReady:

			dec AITimer, x
			beq ReadyToAct

			rts

		ReadyToAct:

			lda #AI_Time
			sta AITimer, x

			lda ZP.Counter
			and #%00011111
			sta ZP.Colour

			lda SpriteID, x
			tay

			lda SpriteColor, y
			and #%10000000
			ora ZP.Colour
			sta SpriteColor, y

			

			dec MoveTimer, x
			bne KeepGoing

			jsr ChangeDirection

		KeepGoing:

			dec FireTimer, x
			bne DontFire

			jsr FireSpark

		DontFire:




		rts
	}

	Move: {



			ldx ZP.X

			lda SpriteID, x
			tay

		CheckX:

			lda XPositive, x
			bne Right

		Left:

			lda XFrac, x
			sec
			sbc XDeltaLSB, x
			sta XFrac, x

			lda SpriteX, y
			sbc XDeltaMSB, x
			sta SpriteX, y

			lda SpriteMSB, y
			sbc #0
			sta SpriteMSB, y
			bne CheckY

			lda SpriteX, y
			cmp #MinX
			bcs CheckY

			lda #MinX
			sta SpriteX, y

			jmp CheckY

		Right:

			lda XFrac, x
			clc
			adc XDeltaLSB, x
			sta XFrac, x

			lda SpriteX, y
			adc XDeltaMSB, x
			sta SpriteX, y

			lda SpriteMSB, y
			adc #0
			sta SpriteMSB, y
			beq NoWrapLeft

			lda SpriteX, y
			cmp #MaxX
			bcc NoWrapLeft

			lda #MaxX
			sta SpriteX, y

		NoWrapLeft:

		
		CheckY:

			lda YPositive, x
			bne Down

		Up:

			lda YFrac, x
			sec
			sbc YDeltaLSB, x
			sta YFrac, x

			lda SpriteY, y
			sbc YDeltaMSB, x
			sta SpriteY, y

			cmp #MinY
			bcs Finish

			lda #MinY
			sta SpriteY, y


			jmp Finish

		Down:

			lda YFrac, x
			clc
			adc YDeltaLSB, x
			sta YFrac, x

			lda SpriteY, y
			adc YDeltaMSB, x
			sta SpriteY, y

			cmp #MaxY
			bcc Finish

			lda #MaxY
			sta SpriteY, y

		Finish:

			lda SpriteMSB, y
			jsr UTILITY.StoreMSBColourY


		rts
	}


		

	* = * "EnforcerFrameUpdatwe"

	FrameUpdate: {

		lda NumberRemaining
		beq NoColourChange

		lda PLAYER.Active
		beq  NoColourChange

		lda PLAYER.Dead
		bne NoColourChange

		ldx #0

		Loop:

			stx ZP.X

			lda SpriteID, x
			bmi Next
			tay

			lda Frame, x
			cmp #4
			bcc StillSpawning

			jsr Process
			jmp EndLoop

		StillSpawning:

			dec SpawnTimer, x
			bne Next

		NextFrame:

			inc Frame, x
			lda Frame, x
			clc
			adc #BasePointer
			sta SpritePointer, y

			lda #SpawnTime
			sta SpawnTimer, x

		EndLoop:

			//jsr CheckBullet

			ldx ZP.X

		Next:
			inx	
			cpx #MAX_ENFORCERS
			bcc Loop


		Finish:

			dec FrameTimer
			bne NoColourChange

			lda #FrameTime
			sta FrameTimer

			inc ColourFrame
			lda ColourFrame
			cmp #4
			bcc NoColourChange

			lda #0
			sta ColourFrame

		NoColourChange:

		SetDebugBorder(DARK_GRAY)



		rts

	}




	GetAvailableID: {

		jsr SPRITE_MANAGER.GetAvailableEnemySprite
		cpx #255
		bne SpriteAvailable


		rts

		SpriteAvailable:

		stx ZP.SpriteID
		ldx #0

		Loop:

			lda SpriteID, x
			bpl EndLoop

			rts

			EndLoop:

			inx
			cpx #MAX_ENFORCERS
			bcc Loop

		ldx #255
		rts
	}


	GetFireDelay: {

		CheckMaxFire:

			lda MaxFireTime
			cmp #16
			bcs BigNumber

		SmallNumber:

			jsr RANDOM.Get
			and #%00001111	
			jmp AddMin

		BigNumber:

			jsr RANDOM.Get
			and #%00011111

		AddMin:
			cmp MaxFireTime
			bcs CheckMaxFire

		sta FireTimer, x


		rts
	}

	Spawn: {

	
		ldx ZP.LocalID

		inc NumberRemaining

		inc NumberGenerated
		lda NumberGenerated
		cmp #MAX_ENFORCERS
		bcs Recycled	

		inc PLAYER.LastEnemySprite

		Recycled:

		jsr GetFireDelay

		lda #SpawnTime
		sta SpawnTimer, x

		lda #0
		sta Frame, x
		sta YFrac, x
		sta XFrac, x
		sta XDeltaLSB, x
		sta YDeltaLSB, x
		sta XDeltaMSB, x
		sta YDeltaMSB, x

		lda #AI_Time
		sta AITimer, x

		lda #1
		sta MoveTimer, x

		jsr CalculateSpriteData

		Finish:

		rts
	}

	NextLevel: {

		ldx #0

		Loop:

			lda #0
			sta SpriteID, x

			inx
			cpx #MAX_ENFORCERS
			bcc Loop

		rts
	}


	CalculateSpriteData: {

		inc SPRITE_MANAGER.EnemiesActive

		ldy ZP.LocalID
		ldx ZP.SpriteID
		
		tya
		sta LocalSpriteID, x

		txa
		sta SpriteID, y

		lda ZP.Row
		sta SpriteY, x

		lda #SPRITE_ENFORCER
		sta SpriteType, x

		lda ZP.Column
		sta SpriteX, x

		lda #RED
		sta SpriteColor, x

		lda ZP.Amount
		sta SpriteMSB, x

		jsr UTILITY.StoreMSBColourX

		lda #BasePointer
		sta SpritePointer, x


		rts
	}

	


	

}