SpriteColumnLookup:		.fill 40, 24 + ( 8 * i)
SpriteRowLookup:		.fill 25, 50 + ( 8 * i)
SpriteMSBLookup:		.fill 29, 0
							.fill 11, 1

							
	.label XBoundaryLeft = 8
	.label XBoundaryRight = 25
	.label YBoundaryUp = 6
	.label YBoundaryDown = 16

	.label SpriteMinX = 24
	.label SpriteMaxX = 30
	.label SpriteMinY = 50
	.label SpriteMaxY = 238

HUMANS: {

	* = * "Humans"

	.label MAX_HUMANS = 31

	Type:			.fill MAX_HUMANS, 0
	SpriteID:		.fill MAX_HUMANS, 0
	BasePointer:	.fill MAX_HUMANS, 0

	CharX:			.fill MAX_HUMANS, 0
	CharY:			.fill MAX_HUMANS, 0
	OffsetX:		.fill MAX_HUMANS, 0
	OffsetY:		.fill MAX_HUMANS, 0
	XSpeed:			.fill MAX_HUMANS, 0
	YSpeed:			.fill MAX_HUMANS, 0
	Frame:			.fill MAX_HUMANS, 0
	MSBAdd:			.fill MAX_HUMANS, 0
	TurnCooldown:	.fill MAX_HUMANS, 0

	StartPointers:	.byte 61, 49, 73
	Colours:		.byte ORANGE, LIGHT_RED, RED
	BonusColours:	.byte RED, LIGHT_RED, BLUE, ORANGE, GREEN

	NumberToGenerate:	.byte 0
	FrameTimer:			.byte 0
	FrameLookup:		.byte 0, 1, 2, 1
	TargetPointer:		.byte 0


	DirectionChoice:	.byte -1, -1, -1, 0, 0, 1, 1, 1

	HumansCollected:	.byte 0


	AndLookup:	.fill 02, %00000001
				.fill 02, %00000011
				.fill 04, %00000111
				.fill 08, %00001111
				.fill 16, %00011111



	.label PixelSpeed = 1
	.label FracSpeed = 50
	.label BonusHidePoint = 97

	.label WalkSpeed = 1
	.label MinX = 24
	.label MaxX = 30
	.label MinY = 50
	.label MaxY = 238
	.label FrameTime = 2


	PointerAdd:		.byte 0 // 0
					.byte 0 // 1 left
					.byte 3 // 2 right
					.byte 0 // 3
					.byte 9 // 4 down
					.byte 0 // 5 downleft
					.byte 3 // 6 downright
					.byte 0 // 7
					.byte 6 // 8 up
					.byte 0 // 9 upleft
					.byte 3 // 10 upright



	SetupLevel: {

		// KIDS DONE FIRST SO WE CAN REPLICATE THE 'MIKEY BUG'

		ldy #0
		sty ZP.Amount
		
		lda #255
		sta TargetPointer

		ldx LEVEL_DATA.CurrentLevel

		lda LEVEL_DATA.Kids, x
		beq SkipDads
		sta ZP.Amount
		
		DadLoop:

			lda #HUMAN_KID
			sta Type, y

			iny
			cpy ZP.Amount
			bcc DadLoop

		SkipDads:

			lda LEVEL_DATA.Mums, x
			beq SkipMums
			clc
			adc ZP.Amount
			sta ZP.Amount

		MumLoop:

			lda #HUMAN_MUM
			sta Type, y

			iny
			cpy ZP.Amount
			bcc MumLoop

		SkipMums:

			lda LEVEL_DATA.Dads, x
			beq SkipKids
			clc
			adc ZP.Amount
			sta ZP.Amount

		KidLoop:

			lda #HUMAN_DAD
			sta Type, y

			iny
			cpy ZP.Amount
			bcc KidLoop


		SkipKids:

		sty NumberToGenerate
		

		rts
	}


	
	Initialise: {

		ldx #0
		stx HumansCollected
	
		lda NumberToGenerate	
		beq Finish

		Loop:

			stx ZP.X

			txa
			sta SpriteID, x

			lda Type, x
			bmi EndLoop

			inc SPRITE_MANAGER.HumansActive

			tay
			lda StartPointers, y
			sta BasePointer, x

			jsr Generate
			jsr RandomDirection


			ldx ZP.X

			EndLoop:

			inx
			cpx NumberToGenerate
			bcc Loop
		
		Finish:
	
		lda SPRITE_MANAGER.HumansActive
		sta SPRITE_MANAGER.FirstEnemySprite

		rts
	}


	GetRandomTarget: {

		ldy NumberToGenerate

		Again:

			jsr RANDOM.Get
			and AndLookup, y
			cmp NumberToGenerate
			bcs Again

		tay

		lda Frame, y
		cmp #4
		beq Again

		tya


		rts
	}

	GetNextTarget: {

		inc TargetPointer
		lda TargetPointer
		cmp NumberToGenerate
		bcc Okay

		lda #255
		rts

		Okay:

		ldy TargetPointer
		lda Frame, y
		cmp #4
		beq GetNextTarget

		Done:

		tya

		rts
	}


	RandomDirection: {

		ChooseX:

			jsr RANDOM.Get
			and #%00000111
			tay

			lda DirectionChoice, y
			sta XSpeed, x

		ChooseY:

			jsr RANDOM.Get
			and #%00000111
			tay

			lda DirectionChoice, y
			bne Okay

			cmp XSpeed, x
			beq ChooseY

		Okay:

			sta YSpeed, x


		rts
	}

	Generate: {

		lda #0
		sta Frame, x

		jsr SHARED.GetRandomCharAny
		
		jsr CalculateSpriteData
	
		rts
	}



			
	CalculateSpriteData: {

		lda ZP.Row
		sta CharY, x
		tay
		lda SpriteRowLookup, y
		sta SpriteY, x

		lda #SPRITE_HUMAN
		sta SpriteType, x

		lda ZP.Column
		sta CharX, x
		tay
		lda SpriteColumnLookup, y
		sta SpriteX, x

		lda #0
		sta MSBAdd, x

		lda SpriteMSBLookup, y
		sta SpriteMSB, x
		beq NotMSB

		lda #30
		sta MSBAdd, x

		NotMSB:


		lda BasePointer, x
		sta SpritePointer, x

		lda Type, x
		tay
		lda Colours, y
		sta SpriteColor, x

		lda SpriteMSB, x
		jsr UTILITY.StoreMSBColourX


		rts
	}




	Dead: {

		dec Frame, x
		lda Frame, x	
		cmp #BonusHidePoint
		bne Finish

		lda #10
		sta SpriteY, x

		lda #255
		sta Type, x
		sta SpriteType, x

		Finish:


		rts
	}	

	Collected: {

		sfx(SFX_COLLECT)
		jsr SOUND.Collect

		stx ZP.Temp4

		lda Frame, x
		cmp #4
		bcs Okay
	
		dec SPRITE_MANAGER.HumansActive

		ldy HumansCollected

		lda SpriteColor, x
		and #%10000000
		ora BonusColours, y
		sta SpriteColor, x

		tya
		clc
		adc #106
		sta Frame, x
		sta SpritePointer, x

		inc HumansCollected
		lda HumansCollected
		cmp #5
		bcc Okay

		lda #4
		sta HumansCollected

		ldy HumansCollected
		dey
		jsr SCORE.AddScore

		ldx ZP.Temp4

		Okay:



		rts
	}



	Process: {

		lda Frame, x
		cmp #4
		bcc StillAlive

		jmp Dead

		StillAlive:

		lda #0
		sta ZP.Amount

		CheckX:

			lda XSpeed, x
			beq CheckY
			bmi GoLeft


		GoRight:

			lda #RIGHT_MASK
			sta ZP.Amount

			lda SpriteX, x
			clc
			adc #1
			sta SpriteX, x

			lda SpriteMSB, x
			adc #0
			sta SpriteMSB, x
			beq NoWrapRight

			lda #29
			sta MSBAdd, x

			lda SpriteX, x
			cmp #MaxX
			bcc NoWrapRight

			lda #MaxX
			sta SpriteX, x

			jsr RandomDirection

		NoWrapRight:

			jmp CheckY

		GoLeft:

			lda #LEFT_MASK
			sta ZP.Amount

			lda SpriteX, x
			sec
			sbc #1
			sta SpriteX, x

			lda SpriteMSB, x
			sbc #0
			sta SpriteMSB, x
			bne NoWrapLeft

			lda #0
			sta MSBAdd, x

			lda SpriteX, x
			cmp #MinX
			bcs NoWrapLeft

			lda #MinX
			sta SpriteX, x

			jsr RandomDirection

		NoWrapLeft:



		CheckY:

			lda YSpeed, x
			beq Finish

			bmi GoUp


		GoDown:

			lda ZP.Amount
			clc
			adc #DOWN_MASK
			sta ZP.Amount

			lda SpriteY, x
			clc
			adc #1
			sta SpriteY, x

			cmp #MaxY
			bcc NoWrapDown

			lda #MaxY
			sta SpriteY, x

			jsr RandomDirection

		NoWrapDown:

			jmp Finish

		GoUp:

			lda ZP.Amount
			clc
			adc #UP_MASK
			sta ZP.Amount

			lda SpriteY, x
			sec
			sbc #1
			sta SpriteY, x

	
			cmp #MinY
			bcs NoWrapUp

			lda #MinY
			sta SpriteY, x

			jsr RandomDirection

		NoWrapUp:





		Finish:

			//jsr CheckMine

			lda SpriteMSB, x
			jsr UTILITY.StoreMSBColourX

			inc Frame, x
			lda Frame, x
			cmp #4
			bcc Okay

			lda #0
			sta Frame, x

		Okay:

			jsr UpdatePointer

		rts
	}


	TurnAround: {

			lda #90
			sta TurnCooldown, x

		ChangeX:

			lda XSpeed, x
			beq ChangeY
			bmi MakePosX

			lda #255
			sta XSpeed, x

			jmp ChangeY

		MakePosX:

			lda #1
			sta XSpeed, x

		ChangeY:

			lda YSpeed, x
			beq Done
			bmi MakePosY

			lda #255
			sta YSpeed, x

			rts

		MakePosY:

			lda #1
			sta YSpeed, x

			rts

		Done:


		rts
	}

	CheckMine: {

			lda SpriteX, x
			tay
			lda SpriteXToChar, y
			clc
			adc MSBAdd, x
			sta ZP.Column

			lda SpriteY, x
			tay
			lda SpriteYToChar, y
			tay

			ldx ZP.Column

			jsr PLOT.GetCharacter

			ldy #0
			lda #1
			sta (ZP.ScreenAddress), y
			sta (ZP.ColourAddress), y

		CheckChar:

			ldx ZP.CurrentID

			cmp #31
			bcc NotMine

			cmp #40
			bcs NotMine

		ChangeX:

			lda XSpeed, x
			beq ChangeY
			bmi MakePosX

			lda #255
			sta XSpeed, x

			jmp ChangeY

		MakePosX:

			lda #1
			sta XSpeed, x

		ChangeY:

			lda YSpeed, x
			beq NotMine
			bmi MakePosY

			lda #255
			sta YSpeed, x

			rts

		MakePosY:

			lda #1
			sta YSpeed, x

			rts

		NotMine:

		rts
	}

	UpdatePointer: {

		lda Frame, x
		tay
		lda FrameLookup, y
		clc
		adc BasePointer, x

		ldy ZP.Amount
		clc
		adc PointerAdd, y
		sta SpritePointer, x


		rts
	}


	CheckFrame: {

		lda FrameTimer
		beq Ready

		dec FrameTimer
		rts

		Ready:

		lda Frame, x
		eor #%00000001
		sta Frame, x

		lda #FrameTime
		sta FrameTimer

		rts
	}

	FrameUpdate: {

		//jsr CheckFrame

		SetDebugBorder(LIGHT_GRAY)

		lda PLAYER.Dead
		bne Finish

		ldx #0

		Loop:

			stx ZP.CurrentID

			lda Type, x
			bmi EndLoop

			txa
			clc
			adc ZP.Counter
			and #%00000110
			bne EndLoop

			jsr Process

			EndLoop:

			ldx ZP.CurrentID
			inx	
			cpx NumberToGenerate
			bcc Loop


		Finish:


		SetDebugBorder(DARK_GRAY)
		rts	

	}

}