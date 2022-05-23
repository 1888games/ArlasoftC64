PLAYER: {

	* = * "Player"

	CharX:		.byte 0
	CharY:		.byte 0

	OffsetX:	.byte 0
	OffsetY:	.byte 0


	PosX_LSB:	.byte 0
	PosX_MSB:	.byte 0
	PosX_Frac:	.byte 0

	PosY:		.byte 0
	PosY_Frac:	.byte 0
	Frame:		.byte 0
	ColourFrame:	.byte 0
	FrameTimer:	.byte 0
	LastEnemySprite: .byte 0
	FirstEnemySprite: .byte 0

	Direction:	.byte DOWN

	Active:		.byte 1
	Moving:		.byte 0

	.label StartCharX = 16
	.label StartCharY = 11

	.label StartX = (StartCharX * 8) + 24
	.label StartY = (StartCharY * 8) + 50 

	.label SPEED_FRAC = 100
	.label SPEED_PIXEL = 3

	.label SPEED_FRAC_DIAG = 0
	.label SPEED_PIXEL_DIAG = 3

	.label MaxX = (33 * 8) + 24 - 256

	.label MinX = 25
	.label FrameTime = 1

	.label MaxY = 25 * 8 + 38
	.label MinY = 51

	.label PlayerSprite = MAX_SPRITES - 1

	SpriteColour:		.byte GREEN
	Colours:			.byte GREEN, CYAN, BLUE, RED

	.label PointerStart = 17


	PixelSpeed:		.byte 0
	FracSpeed:		.byte 0
	Dead:			.byte 0
	

	Initialise: {

		
		//lda #<FrameUpdate
		//ldy #>FrameUpdate

		//jsr TASK.AddFunction



		lda #0
		sta Active

		lda #StartCharX
		sta CharX

		lda #StartCharY
		sta CharY

		lda #StartX
		sta PosX_LSB

		lda #StartY
		sta PosY

		lda #0
		sta PosX_MSB
		sta Dead

		lda #2
		sta OffsetY

		lda #3
		sta OffsetX

		jsr UpdateSprite


		rts
	}


	ControlDirection: {	

		lda Active
		bne NotDead

		jmp Finish

		NotDead:

		lda #0
		sta Moving

		ldy #1

		CheckDown:
			
			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

		Down:

			lda #DOWN
			sta Direction

			inc Moving

			lda PosY_Frac
			clc
			adc FracSpeed
			sta PosY_Frac

			lda PosY
			sta ZP.Amount
			adc #0
			clc
			adc PixelSpeed
			sta PosY

			cmp #MaxY
			bcc CheckOffsetDown

			lda #MaxY
			sta PosY

		CheckOffsetDown:

			lda PosY
			sec
			sbc ZP.Amount
			clc
			adc OffsetY
			sta OffsetY

			cmp #8
			bcc NoWrapOffsetDown

			sec
			sbc #8
			sta OffsetY

			inc CharY

		NoWrapOffsetDown:

			jmp CheckRight

		CheckUp:
			
			lda INPUT.JOY_UP_NOW, y
			beq CheckRight

		Up:	

			lda #UP
			sta Direction

			inc Moving

			lda PosY_Frac
			sec
			sbc FracSpeed
			sta PosY_Frac

			lda PosY
			sta ZP.Amount
			sbc #0
			sec
			sbc PixelSpeed
			sta PosY

			cmp #MinY
			bcs CheckOffsetUp

			lda #MinY
			sta PosY

		CheckOffsetUp:

			lda PosY
			sec
			sbc ZP.Amount
			clc
			adc OffsetY
			sta OffsetY

			bpl NoWrapOffsetUp

			clc
			adc #8
			sta OffsetY

			dec CharY

		NoWrapOffsetUp:


		CheckRight:
			
			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckLeft

		Right:	

			lda #RIGHT
			sta Direction

			inc Moving

			lda PosX_Frac
			clc
			adc FracSpeed
			sta PosX_Frac

			lda PosX_LSB
			sta ZP.Amount
			adc #0
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB

			lda PosX_LSB	
			clc
			adc PixelSpeed
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB
			beq CheckOffsetRight

			lda PosX_LSB
			cmp #MaxX
			bcc CheckOffsetRight

			lda #MaxX
			sta PosX_LSB

		CheckOffsetRight:

			lda PosX_LSB
			sec
			sbc ZP.Amount
			clc
			adc OffsetX
			sta OffsetX

			cmp #8
			bcc NoWrapOffsetRight

			sec
			sbc #8
			sta OffsetX

			inc CharX

		NoWrapOffsetRight:

			jmp CheckFire

		CheckLeft:
			
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckFire

		Left:	

			lda #LEFT
			sta Direction

			inc Moving

			lda PosX_Frac
			sec
			sbc FracSpeed
			sta PosX_Frac

			lda PosX_LSB
			sta ZP.Amount
			sbc #0
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB

			lda PosX_LSB
			sec
			sbc PixelSpeed
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB
			bne CheckOffsetLeft

			lda PosX_LSB
			cmp #MinX
			bcs CheckOffsetLeft

			lda #MinX
			sta PosX_LSB

		CheckOffsetLeft:

			lda PosX_LSB
			sec
			sbc ZP.Amount
			clc
			adc OffsetX
			sta OffsetX

			bpl NoWrapOffsetLeft

			clc
			adc #8
			sta OffsetX

			dec CharX

		NoWrapOffsetLeft:

		CheckFire:

			lda INPUT.JOY_FIRE_NOW, y
			beq Finish

			jsr Fire




		Finish:


			
			rts




	}

	Fire: {


		rts
	}

	UpdateSprite: {

		lda PosX_LSB
		sta SpriteX + PlayerSprite

		lda PosY
		sta SpriteY + PlayerSprite

		ldy ColourFrame
		lda Colours, y
		sta SpriteColor + PlayerSprite

		lda Direction
		asl
		clc
		adc Frame
		clc
		adc #17
		sta SpritePointer + PlayerSprite

		ldy #PlayerSprite
		lda PosX_MSB
		sta SpriteMSB, y
		jsr UTILITY.StoreMSBColourY
		

		MSB_Done:

		rts
	}

	CheckFrame: {


		lda FrameTimer
		beq Ready

		dec FrameTimer
		rts

		Ready:

			lda #FrameTime
			sta FrameTimer

			inc ColourFrame
			lda ColourFrame
			cmp #4
			bcc ColourOK

			lda #0
			sta ColourFrame

		ColourOK:
			
			lda Moving
			beq Finish

			lda Frame
			eor #%00000001
			sta Frame


		Finish:

		rts
	}


	CheckDiag: {

		ldy #1

		lda #SPEED_FRAC
		sta FracSpeed

		lda #SPEED_PIXEL
		sta PixelSpeed

		lda INPUT.JOY_LEFT_NOW, y
		clc
		adc INPUT.JOY_RIGHT_NOW, y
		beq NoDiag


		lda INPUT.JOY_DOWN_NOW, y
		clc
		adc INPUT.JOY_UP_NOW, y
		beq NoDiag

		lda #SPEED_FRAC_DIAG
		sta FracSpeed

		lda #SPEED_PIXEL_DIAG
		sta PixelSpeed


		NoDiag:




		rts
	}

	FireDirection: {


		ldy #0
		lda INPUT.JOY_READING, y
		and #%00001111
		cmp #%00001111
		beq Finish

		jsr BULLET.Fire

		Finish:

		rts
	}


	CheckSpriteCollision: {

		.label YDiff = ZP.Temp3
		.label XDiff = ZP.Temp4

		sec
		sbc PosY
		clc
		sta YDiff
		adc #6
		cmp #12
		bcs NoCollision

		lda SpriteMSB, x
		cmp PosX_MSB
		bne NoCollision

		lda SpriteX, x
		sec
		sbc PosX_LSB
		sta XDiff
		adc #6
		cmp #12
	
		bcs NoCollision

		lda SpriteType, x
		bne NotHuman

		Human:

			jmp HUMANS.Collected

		NotHuman:

			cmp #SPRITE_SPARK
			bne BigSprite

			lda YDiff
			clc
			adc #3
			cmp #6
			bcs NoCollision

			lda XDiff
			clc
			adc #3
			cmp #6
			bcs NoCollision

		BigSprite:

			jmp Kill

		// 	cmp #SPRITE_HULK
		// 	bne NotHulk

		// IsHulk:

		// 	jmp Kill

		// NotHulk:

		// 	cmp #SPRITE_SPHEROID
		// 	bne NotSpheroid

		// IsSpheroid:

		// 	jmp Kill

		// NotSpheroid:

		// 	cmp #SPRITE_ENFORCER
		// 	bne NotEnforcer

		// IsEnforcer:

		// 	jmp Kill

		// NotEnforcer:



		NoCollision:

		rts
	}

	CheckCharCollision: {

		lda GRUNT.CharX, x
		bmi Finish

		cmp CharX
		bne Finish


		lda CharY
		sec
		sbc GRUNT.CharY, x
		clc
		adc #1
		cmp #2
		bcs Finish

		jsr Kill

		Finish:


		rts
	}

	CheckCollision: {


		ldx #0

		Loop:

			stx ZP.CurrentID

			IsValidSpriteID:

				cpx #PlayerSprite
				bcs NoSprite

			IsSpriteAlive:

				lda SpriteY, x
				cmp #50
				bcc NoSprite

			SpriteOk:

				jsr CheckSpriteCollision

			NoSprite:

				jsr CheckCharCollision

			EndLoop:

			ldx ZP.CurrentID
			inx
			cpx GRUNT.MaxOfGruntsAndSprites
			bcc Loop

	

		rts
	}

	Kill: {

		jsr SOUND.Dead

		lda #1
		sta Dead

		lda #50
		sta FrameTimer
		


		rts
	}


	

	ResetAfterDead: {

		lda #0
		sta MAPLOADER.CurrentMapID
		jsr MAPLOADER.DrawMap

		lda #255
		sta VIC.SPRITE_ENABLE


		lda #GREEN
		sta VIC.EXTENDED_BG_COLOR_1
		
	 	lda #YELLOW
	 	sta VIC.EXTENDED_BG_COLOR_2

		jsr SCORE.DrawP1
		jsr SPRITE_MANAGER.Reset
		
		jsr Initialise
		jsr GRUNT.Initialise
		jsr MINE.Initialise
		jsr HUMANS.Initialise
		jsr HULK.Initialise
		jsr SPHEROID.Initialise
		jsr ENFORCER.Initialise
		jsr SPARK.Initialise
		jsr BRAIN.Initialise
	

		lda #GAME_MODE_PLAY
		sta MAIN.GameMode

		rts
	}


	NextLevel: {

		jsr LEVEL_DATA.NextLevel
		jsr LEVEL_DATA.NewLevel

		jsr ResetAfterDead


		rts
	}

	HandleDead: {

		SetDebugBorder(DARK_GRAY)

		lda FrameTimer
		beq Ready

		dec FrameTimer

		and #%00000001
		bne NoColourChange

		jsr RANDOM.Get
		and #%00001111
		sta SpriteColor + PlayerSprite

		NoColourChange:

		rts

		Ready:

			jsr ResetAfterDead


		rts
	}


	CheckMine: {

		ldy CharY
		ldx CharX

		jsr PLOT.GetCharacter

		cmp #31
		bcc NotMine1

		cmp #40
		bcs NotMine1

		ldy #0
		lda #0
		sta (ZP.ScreenAddress), y

		jsr Kill
		rts

		NotMine1:

		ldy #40
		lda (ZP.ScreenAddress), y

		cmp #31
		bcc NotMine2


		cmp #40
		bcs NotMine2

		lda #0
		sta (ZP.ScreenAddress), y

		jsr Kill

		NotMine2:


		rts
	}

	
	FrameUpdate: {

		//inc $d020

		SetDebugBorder(YELLOW)

		lda Active
		beq Finish

		lda PLAYER.Dead
		beq NotDead

	//	dec $d020

		jmp HandleDead

		NotDead:

			jsr CheckDiag
			jsr ControlDirection
			jsr FireDirection
			jsr CheckFrame
			jsr UpdateSprite
			jsr CheckCollision
			jsr CheckMine

			lda #0
			sta ZP.Amount

			// lda SpritesInPlay

			// RedLoop:

			// 	cmp #10
			// 	bcc Draw

			// 	inc ZP.Amount

			// 	sec
			// 	sbc #10
			// 	jmp RedLoop


			// Draw:

			// 	clc
			// 	adc #48
			// 	sta SCREEN_RAM + 39

			// 	lda ZP.Amount
			// 	clc
			// 	adc #48
			// 	sta SCREEN_RAM + 38
				

			
			// 	lda #1
			// 	sta VIC.COLOR_RAM + 38
			// 	sta VIC.COLOR_RAM + 39




		Finish:

		

		SetDebugBorder(DARK_GRAY)

		rts
	}


}