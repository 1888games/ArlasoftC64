SPHEROID: {

	* = * "Spheroid"

	.label MAX_SPHEROIDS = 6


	SpriteID:		.fill MAX_SPHEROIDS, 0
	Frame:			.fill MAX_SPHEROIDS, 0
	MoveTimer:		.fill MAX_SPHEROIDS, 0

	EnforcerTime:	.fill MAX_SPHEROIDS, 0
	EnforcerCount:	.fill MAX_SPHEROIDS, 0

	DirectionTimer:	.fill MAX_SPHEROIDS, 0

	XCurvature:		.fill MAX_SPHEROIDS, 0
	YCurvature:		.fill MAX_SPHEROIDS, 0
	XDeltaLSB:		.fill MAX_SPHEROIDS, 0
	XDeltaMSB:		.fill MAX_SPHEROIDS, 0
	YDeltaLSB:		.fill MAX_SPHEROIDS, 0
	YDeltaMSB:		.fill MAX_SPHEROIDS, 0
	XFrac:			.fill MAX_SPHEROIDS, 0
	YFrac:			.fill MAX_SPHEROIDS, 0
	XPositive:		.fill MAX_SPHEROIDS, 0
	YPositive:		.fill MAX_SPHEROIDS, 0

	NumberToGenerate:	.byte 0
	NumberRemaining:	.byte 0
	LastID:				.byte 0
	MaxEnforcerCount:	.byte 0
	MaxEnforcerTime:	.byte 0
	FollowEnforcerTime:	.byte 0
	

	.label BasePointer = 91
	.label PixelsPerMove = 4

	.label MinX = 24
	.label MaxX = 22
	.label MinY = 50
	.label MaxY = 236

	.label MiddleX = 152 - 24
	.label MiddleY = 143

	.label FrameTime = 3

	FrameTimer:		.byte 0

	SpeedLookup:	.byte 0, 1, 1, 2

	FrameColours:	.byte RED, RED, YELLOW, ORANGE, RED, RED, RED

	Initialise: {
		
		ldx #0
		stx ZP.Amount
		stx LastID

		lda NumberRemaining
		beq Finish


		Loop:

			stx ZP.X

			lda SpriteID, x
			bmi EndLoop

			txa
			clc
			adc HUMANS.NumberToGenerate
			clc
			adc HULK.NumberToGenerate
			sta SpriteID, x
			sta LastID

			jsr Generate

			inc SPRITE_MANAGER.EnemiesActive
			
			ldx ZP.X

			EndLoop:


			inx
			cpx NumberToGenerate
			bcc Loop


		inc LastID
			


		Finish:	

	
		rts
	}


	NextLevel: {

		ldx #0

		Loop:

			lda #0
			sta SpriteID, x

			inx
			cpx #MAX_SPHEROIDS
			bcc Loop


		rts
	}


	GetEnforcerDropCount: {

		jsr RANDOM.Get
		and #%00000011
		clc
		adc #10
		cmp MaxEnforcerCount
		beq Okay
		bcs GetEnforcerDropCount

		Okay:

		clc
		ror
		adc #0
		sta EnforcerCount, x

		rts
	}


	GetEnforcerSpawnTime: {

		jsr RANDOM.Get
		and #%00011111
		clc
		adc #12
		cmp MaxEnforcerTime
		beq Okay

		bcs GetEnforcerSpawnTime

		Okay:

		sta EnforcerTime, x

		rts

	}


	Generate: {

		lda #0
		sta Frame, x
		sta XFrac, x
		sta YFrac, x
		sta XDeltaLSB, x
		sta XDeltaMSB, x
		sta YDeltaLSB, x
		sta YDeltaMSB, x

		jsr GetEnforcerSpawnTime
		jsr GetEnforcerDropCount

		jsr RANDOM.Get
		and #%00011111
		clc
		adc #32
		sta DirectionTimer, x
		//jsr GetDirection
		//jsr UpdateDeltaX
		//jsr UpdateDeltaY

	
		jsr SHARED.GetRandomCharAny

		jsr RANDOM.Get
		bmi SetLeft

		SetRight:

			lda #32
			sta ZP.Column
			jmp NowSprite

		SetLeft:

			lda #0
			sta ZP.Column

		NowSprite:

		jsr CalculateSpriteData

	
		rts
	}

	CalculateSpriteData: {

		txa
		tay

		lda SpriteID, x
		tax

		tya
		sta LocalSpriteID, x

		lda #SPRITE_SPHEROID
		sta SpriteType, x

		ldy ZP.Row
		lda SpriteRowLookup, y
		sta SpriteY, x

		lda ZP.Column
		tay
		lda SpriteColumnLookup, y
		sta SpriteX, x

		lda SpriteMSBLookup, y
		sta SpriteMSB, x

		jsr UTILITY.StoreMSBColourX

		lda #BasePointer
		sta SpritePointer, x

		lda #RED
		sta SpriteColor, x

		
		rts
	}

	

	GetDirection: {

		.label SkewAmount =160

		lda SpriteID, x
		tay

		jsr RANDOM.Get
		//and #%1111111
		sta XCurvature, x  // -16 to 15

		lda SpriteX, y
		cmp #150
		bcc SkewLeft

		SkewRight:

			jsr RANDOM.Get
			cmp #SkewAmount
			bcs NoSkew

			lda XCurvature, x
			and #%01111111
			sta XCurvature, x
			jmp NoSkew


		SkewLeft:

			jsr RANDOM.Get
			cmp  #SkewAmount
			bcs NoSkew

			lda XCurvature, x
			ora #%10000000
			sta XCurvature, x


		NoSkew:

			jsr RANDOM.Get
			and #%00000001
			asl
			sta XDeltaMSB, x

			jsr RANDOM.Get
			//and #%11011111
			sta YCurvature, x  // -16 to 15


			lda SpriteY, y
			cmp #150
			bcc SkewUp

		SkewDown:

			jsr RANDOM.Get
			cmp  #SkewAmount
			bcs NoSkew2

			lda YCurvature, x
			and #%01111111
			sta YCurvature, x
			jmp NoSkew2


		SkewUp:

			jsr RANDOM.Get
			cmp #SkewAmount
			bcs NoSkew2

			lda YCurvature, x
			ora #%10000000
			sta YCurvature, x


		NoSkew2:

			jsr RANDOM.Get
			and #%00000001
			asl
			sta YDeltaMSB, x
		

			jsr RANDOM.Get
			and #%00111111
			clc
			adc #32
			sta DirectionTimer, x

		rts
	}

	


	DropEnforcer: {

		lda EnforcerCount, x
		bne SomeLeft

		rts

		SomeLeft:

			jsr ENFORCER.GetAvailableID
			cpx #255
			bne SlotAvailable

		SlotNotAvailable:

			ldx ZP.X
			jsr GetEnforcerSpawnTime
			rts

		SlotAvailable:

			stx ZP.LocalID

			ldx ZP.X

		GetSpriteData:

			lda SpriteID, x
			tay

			lda SpriteX, y
			sta ZP.Column

			lda SpriteY, y
			sta ZP.Row

			lda SpriteMSB, y
			sta ZP.Amount

		NextEnforcer:

			jsr RANDOM.Get
			and #%00000111
			clc
			adc #3
			cmp FollowEnforcerTime
			beq Okay

			bcs NextEnforcer

		Okay:

			sta EnforcerTime, x

			dec EnforcerCount, x
			bne SpheroidStillOK

			jmp KillSpheroid
		
		SpheroidStillOK:


		jsr ENFORCER.Spawn

		ldx ZP.X


		rts
	}


	KillSpheroid: {




		rts
	}


	UpdateDeltaY: {


		lda YCurvature, x
		and #%00111111
		sta ZP.Amount

		lda YCurvature, x
		and #%01000000
		bne Increase

		Decrease:	

		
			lda YDeltaLSB, x
			sec
			sbc ZP.Amount
			sta YDeltaLSB, x

			lda YDeltaMSB, x
			sbc #0
			sta YDeltaMSB, x
			bpl Done

			lda #0
			sta YDeltaMSB, x
			sta YDeltaLSB, x

			jmp Done

		Increase:

			lda YDeltaLSB, x
			clc
			adc ZP.Amount
			sta YDeltaLSB, x

			lda YDeltaMSB, x
			adc #0
			sta YDeltaMSB, x

			cmp #3
			bcc Done

			lda YCurvature, x
			and #%10111111
			sta YCurvature, x
			
		Done:

			rts

	}


	UpdateDeltaX: {


		lda XCurvature, x
		and #%00111111
		sta ZP.Amount

		lda XCurvature, x
		and #%01000000
		bne Increase

		Decrease:	

		
			lda XDeltaLSB, x
			sec
			sbc ZP.Amount
			sta XDeltaLSB, x

			lda XDeltaMSB, x
			sbc #0
			sta XDeltaMSB, x
			bpl Done

			lda #0
			sta XDeltaMSB, x
			sta XDeltaLSB, x

		
			jmp Done

		Increase:

			lda XDeltaLSB, x
			clc
			adc ZP.Amount
			sta XDeltaLSB, x

			lda XDeltaMSB, x
			adc #0
			sta XDeltaMSB, x
			
			cmp #3
			bcc Done

			lda XCurvature, x
			and #%10111111
			sta XCurvature, x

			
		Done:

			rts

	}


	Move: {


			lda SpriteID, x
			tay

			lda Frame, x
			tax
			clc
			adc #BasePointer
			sta SpritePointer, y

			lda FrameColours, x
			sta SpriteColor, y

			ldx ZP.X

		CheckX:

			lda XCurvature, x
			bpl Right

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

			lda YCurvature, x
			bpl Down

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
	Process: {


		lda Frame, x
		bne NoCountdown

		dec EnforcerTime, x
		bne NoCountdown

		jmp DropEnforcer

		NoCountdown:

			dec DirectionTimer, x
			bne NoChange


		ChangeDir:

			jsr GetDirection

		NoChange:

			jsr UpdateDeltaX
			jsr UpdateDeltaY

			jsr Move

	

		rts
	}




	FrameUpdate: {

		//lda $d012
		//cmp #180
		//bcs Finish


		SetDebugBorder(BLUE)

		lda NumberRemaining
		beq Finish

		lda PLAYER.Active
		beq Finish

		lda PLAYER.Dead
		bne Finish

		ldx #0

		Loop:

			stx ZP.X

			lda SpriteID, x
			bmi Next

			lda FrameTimer
			bne NoFrameChange

				inc Frame, x
				lda Frame, x
				cmp #5
				bcc NoFrameChange

				lda #0
				sta Frame, x

			NoFrameChange:

			//	dec MoveTimer, x

			//	lda MoveTimer, x
			//	bne NoChange

			//	jsr RandomDirection

			NoChange:

				jsr Process

			EndLoop:

			///	jsr CheckBullet

				ldx ZP.X

			Next:
				inx	
				cpx NumberToGenerate
				bcc Loop

		lda FrameTimer
		beq Ready

		dec FrameTimer
		jmp Finish

		Ready:

		lda #FrameTime
		sta FrameTimer


		Finish:

		SetDebugBorder(DARK_GRAY)

		lda #YELLOW
	//	sta $d020



		rts
	}





}