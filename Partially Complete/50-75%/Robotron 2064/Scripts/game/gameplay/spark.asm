SPARK: {


	* = * "Spark"

	.label MAX_SPARKS = 8

	SpriteID:		.fill MAX_SPARKS, 0
	MoveTimer:		.fill MAX_SPARKS, 0
	LiveTimer:		.fill MAX_SPARKS, 0
	AITimer:		.fill MAX_SPARKS, 0

	TotalFired:			.byte 0

	XDeltaLSB:		.fill MAX_SPARKS, 0
	XDeltaMSB:		.fill MAX_SPARKS, 0
	YDeltaLSB:		.fill MAX_SPARKS, 0
	YDeltaMSB:		.fill MAX_SPARKS, 0
	XFrac:			.fill MAX_SPARKS, 0
	YFrac:			.fill MAX_SPARKS, 0
	XPositive:		.fill MAX_SPARKS, 0
	YPositive:		.fill MAX_SPARKS, 0
	XCurvature:		.fill MAX_SPARKS, 0
	YCurvature:		.fill MAX_SPARKS, 0

	NumberRemaining:	.byte 0
	ColourFrame:		.byte 0
	FrameTimer:			.byte 0

	FirstID:			.byte 0
	LastID:				.byte 0
	MaxFireTime:		.byte 0
	Frame:				.byte 0

	.label BasePointer = 132
	.label PixelsPerMove = 5
	.label AI_Time = 2

	.label MinX = 24
	.label MaxX = 32
	.label MinY = 50
	.label MaxY = 236

	.label MiddleX = 152 - 24
	.label MiddleY = 143
	.label FrameTime = 3
	.label SpawnTime = 5
	.label DeltaIterations = 6
	.label MinDeltaLSB = 50
	.label MinSparkLife = 45

	

	Initialise: {


		ldx #0
		stx NumberRemaining

		lda #255
	
		Loop:

			sta SpriteID, x

			inx
			cpx #MAX_SPARKS
			bcc Loop


		rts
	}


	CalcXDelta: {

		jsr RANDOM.Get
		and #%10001111
		sta XCurvature, x

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

		lda SpriteX, y
		sta ZP.Amount

		lda SpriteMSB, y
		beq NotFarRight

		lda #255
		sta ZP.Amount
		jmp GoRight

		NotFarRight:

		lda ZP.Amount
		cmp ZP.Column
		bcs GoLeft

		GoRight:

			lda ZP.Column
			sec
			sbc ZP.Amount
			sta XDeltaLSB, x

			lda #1
			sta XPositive, x

			jmp DoneX

		GoLeft:

			sec
			sbc ZP.Column
			clc
			adc #MinDeltaLSB
			sta XDeltaLSB, x

			lda XDeltaMSB, x
			adc #0
			sta XDeltaMSB, x

			lda #0
			sta XPositive, x

		DoneX:


			lda XDeltaMSB, x

			.for(var i=0; i<DeltaIterations; i++) {

				asl XDeltaLSB, x
				adc #0
			}

			sta XDeltaMSB, x
			

		rts
	}


	CalcYDelta: {

		jsr RANDOM.Get
		and #%10001111
		sta YCurvature, x

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
			clc
			adc #MinDeltaLSB
			sta YDeltaLSB, x

			lda YDeltaMSB, x
			adc #0
			sta YDeltaMSB, x

			lda #0
			sta YPositive, x

		DoneY:	

			lda YDeltaMSB, x

			.for(var i=0; i<DeltaIterations; i++) {

				asl YDeltaLSB, x
				adc #0
			}

			sta YDeltaMSB, x
			


		rts
	}




	Process: {

		dec LiveTimer, x
		bne ReadyToAct


	DestroyNow:

		jsr Destroy
		rts

	ReadyToAct:

		jsr Move

		CheckIfReady:

			lda ZP.Counter
			and #%00001111
			sta ZP.Colour

			lda SpriteID, x
			tay

			lda SpriteColor, y
			and #%10000000
			ora ZP.Colour
			sta SpriteColor, y

			lda #BasePointer
			clc
			adc Frame
			sta SpritePointer, y


		KeepGoing:




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




	Destroy: {

		lda SpriteID, x
		tay

		lda #10
		sta SpriteY, y

		lda #255
		sta SpriteType, y

		lda #255
		sta SpriteID, x

		dec NumberRemaining

		Finish:


		rts
	}


	FrameUpdate: {

		lda NumberRemaining
		beq NoColourChange

		lda PLAYER.Active
		beq NoColourChange

		lda PLAYER.Dead
		bne NoColourChange

		ldx #0

		Loop:

			stx ZP.X

			lda SpriteID, x
			bmi Next
			tay

			jsr Process

			ldx ZP.X

		Next:
			inx	
			cpx #MAX_SPARKS
			bcc Loop


		Finish:

			
			dec FrameTimer
			bne NoColourChange

			lda #FrameTime
			sta FrameTimer

			lda Frame
			eor #%00000001
			sta Frame

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

		jsr SPRITE_MANAGER.GetAvailableBulletSprite
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
			cpx #MAX_SPARKS
			bcc Loop

		ldx #255
		rts
	}


	
	Spawn: {


		ldy ZP.LocalID
		ldx ZP.SpriteID

		inc NumberRemaining
		inc SPRITE_MANAGER.BulletsActive

		txa
		sta SpriteID, y

		lda #0
		sta YFrac, y
		sta XFrac, y
		sta XDeltaLSB, y
		sta YDeltaLSB, y
		sta XDeltaMSB, y
		sta YDeltaMSB, y

		lda #1
		sta MoveTimer, y

		jsr RANDOM.Get
		and #%00011111
		clc
		adc #MinSparkLife
		sta LiveTimer, y

	
		jsr CalculateSpriteData

		ldx ZP.LocalID
		ldy ZP.SpriteID

		jsr CalcXDelta
		jsr CalcYDelta



		Finish:

		rts
	}



	CalculateSpriteData: {
		
		tya
		sta LocalSpriteID, x

		lda ZP.Row
		sta SpriteY, x

		lda #SPRITE_SPARK
		sta SpriteType, x

		lda ZP.Column
		sta SpriteX, x

		lda #RED
		sta SpriteColor, x

		lda ZP.Amount
		sta SpriteMSB, x

		jsr UTILITY.StoreMSBColourX

		lda #BasePointer
		clc
		adc Frame
		sta SpritePointer, x


		rts
	}

	


	

}