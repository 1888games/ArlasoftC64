

SpriteMSB:		.fill MAX_SPRITES, 0
SpriteCharX:	.fill MAX_SPRITES, 0
SpriteCharY:	.fill MAX_SPRITES, 0
SpriteWidth:	.fill MAX_SPRITES, 0
SpriteHeight:	.fill MAX_SPRITES, 0
SpriteType:		.fill MAX_SPRITES, 255


PLAYER: {


	* = * "Player"


	CharX:		.byte 0, 0
	CharY:		.byte 0, 0

	OffsetX:	.byte 0, 0
	OffsetY:	.byte 0, 0

	PosX_LSB:	.byte 0, 0
	PosX_MSB:	.byte 0, 0
	PosX_Frac:	.byte 0, 0

	PosY:		.byte 0, 0
	PosY_Frac:	.byte 0, 0

	Frame:		.byte 0
	ColourFrame:	.byte 0
	FrameTimer:	.byte 0
	LastEnemySprite: .byte 0
	FirstEnemySprite: .byte 0

	Direction:	.byte DOWN

	Active:		.byte 1
	Moving:		.byte 0
	Firing:		.byte 0
	
	

	.label SPEED_FRAC = 160
	.label SPEED_PIXEL = 0

	.label SPEED_FRAC_DIAG = 140
	.label SPEED_PIXEL_DIAG = 0

	.label FrameTime = 1

	.label PlayerSprite = MAX_SPRITES - 1
	.label FlashFrames = 6

	SpriteColour:		.byte GREEN
	Colours:			.byte GREEN, CYAN, BLUE, RED

	DeathColours:		.byte BLUE, RED, GREEN, PURPLE, WHITE, CYAN, PURPLE, LIGHT_GREEN
	DeathProgress:		.byte 0


	.label PointerStart = 41
	.label DeathFrames = 24


	PixelSpeed:		.byte SPEED_PIXEL
	FracSpeed:		.byte SPEED_FRAC
	Dead:			.byte 0

	FacingRight:	.byte 1
	CanMove:		.byte 0

	FrameSequence:	.byte 1, 2, 3, 2

	StartCharX:		.byte 0
	SpawnDelay:		.byte 0


	BlockDownTop_Left:		.byte 0, 1, 1, 1, 0, 1, 0, 1
	BlockDownTop_Right:		.byte 1, 1, 0, 0, 0, 0, 0, 1
	BlockDownBot_Left:		.byte 0, 1, 1, 1, 1, 1, 1, 1
	BlockDownBot_Right:		.byte 1, 1, 0, 0, 1, 1, 0, 1

	BlockUpTop_Left:		.byte 0, 1, 1, 1, 1, 1, 1, 1
	BlockUpTop_Right:		.byte 1, 1, 0, 0, 1, 1, 0, 1
	BlockUpBot_Left:		.byte 0, 0, 1, 0, 1, 1, 1, 1
	BlockUpBot_Right:		.byte 1, 0, 0, 0, 1, 1, 0, 0

	BlockLeftTop_Left:		.byte 0, 1, 1, 1, 0, 1, 0, 1
	BlockLeftTop_Right:		.byte 1, 1, 0, 0, 0, 0, 0, 1
	BlockLeftBot_Left:		.byte 0, 0, 1, 0, 1, 1, 1, 1
	BlockLeftBot_Right:		.byte 1, 0, 0, 0, 1, 1, 0, 0

	BlockRightTop_Left:		.byte 0, 1, 1, 1, 0, 1, 0, 1
	BlockRightTop_Right:	.byte 1, 1, 0, 0, 0, 0, 0, 1
	BlockRightBot_Left:		.byte 0, 0, 1, 0, 1, 1, 1, 1
	BlockRightBot_Right:	.byte 1, 0, 0, 0, 1, 1, 0, 0

	
	LeftChar:			.byte 0
	RightChar:			.byte 0

	UseCharX:			.byte 0
	UseCharY: 			.byte 0

	SpawnSide:			.byte 255

	SpawnX:				.byte 4, 59, 0, 0 
	SpawnY:				.byte 22, 22, 44, 2

	FlashesRemaining:	.byte 9
	Sector:				.byte 0

	CharConvert:	.byte 0, 0, 1, 2, 3, 4, 5, 6
					.byte 7, 0, 0, 0, 0, 3, 0, 0
					.byte 0, 2, 4, 1



	.label SpawnCharX = 5
	.label SpawnCharY = 22

	.label StartX = (SpawnCharX * 4) + 24
	.label StartY = (SpawnCharY * 4) + 50


	Initialise: {

		lda #0
		sta Active
		sta Firing

		ldx SpawnSide
		bmi Default

		NotDefault:

			lda #255
			sta FlashesRemaining

			lda #8
			sta SpawnDelay

			cpx #2
			bcc ChangeX

		ChangeY:

			lda SpawnY, x
			sta CharY

			jmp CalcPixels

		ChangeX:

			lda SpawnX, x
			sta CharX

			jmp CalcPixels

		Default:

			jsr SPEECH.RandomSpeech

			lda #9
			sta FlashesRemaining

			lda #6
			sta SpawnDelay

			lda #SpawnCharX
			sta CharX

			lda #SpawnCharY
			sta CharY

			lda #0
			sta PosX_MSB
			sta SpawnSide

			lda #1
			sta FacingRight

		CalcPixels:

			lda CharX
			clc
			adc CharX
			clc
			adc CharX
			clc
			adc CharX
			sta PosX_LSB

			
			lda CharY
			clc
			adc CharY
			clc
			adc CharY
			clc
			adc CharY
			clc
			adc #50
			sta PosY

		lda #0
	
		sta Dead
		sta OffsetX
		sta OffsetY

		lda #6
		sta SpriteWidth + PlayerSprite

		lda #16
		sta SpriteHeight + PlayerSprite

		
		jsr CalculateSegment

		jsr UpdateSprite


	
		
		rts
	}

	Hide: {

		lda #0
		sta SpriteY + PlayerSprite
		sta SpriteX + PlayerSprite
		sta SpriteCopyX +  PlayerSprite
		sta SpriteCopyY + PlayerSprite
		sta SpriteColor +  PlayerSprite

		lda #57
		sta PointerCopy + PlayerSprite
		sta SpritePointer + PlayerSprite


		lda #250
		sta SpawnDelay

		lda #0
		sta VIC.SPRITE_ENABLE
		

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


	
	ShowOffsets: {

		rts

		lda OffsetX
		clc
		adc #64
		sta SCREEN_RAM + 35

		lda #WHITE
		sta VIC.COLOR_RAM + 35

		lda OffsetY
		clc
		adc #64
		sta SCREEN_RAM + 37

		lda #WHITE
		sta VIC.COLOR_RAM + 37




		rts
	}


	CalculateBlockID: {

		GetXTablePos:

			lda UseCharX
			and #%00000001
			asl
			asl
			asl
			sta ZP.Temp3

		GetYTablePos:

			lda UseCharY
			and #%00000001
			asl
			asl
			asl
			asl
			clc
			adc ZP.Temp3

		AddCharIndex:

			adc ZP.CharID
			tax

			rts


		rts
	}



	CalculateSegment: {

		UseLSB:

			lda PosX_LSB
			lsr
			lsr
			lsr
			tay
			lda ROBOT.SegmentColumns, y
			sta ZP.B

		NowY:

			lda PosY
			sec
			sbc #50
			lsr
			lsr
			lsr
			tay

			lda ROBOT.SegmentRows, y
			clc
			adc ZP.B

			//cmp Sector, x
			//beq NoChange

			sta Sector

		NoChange:

			//clc
			//adc #64
			//sta SCREEN_RAM + 117


		rts
	}
	

	CheckPosition: {


		Setup:

			lda #0
			sta ZP.Y
			sta ZP.CurrentID

			lda #2
			sta ZP.Temp2

		HowManySquares:

			lda #8
			
			ldy OffsetY
			beq Use8

			lda #10

		Use8:

			sta ZP.EndID

			ldy OffsetX
			beq TwoColumns

			lda ZP.EndID
			lsr
			clc
			adc ZP.EndID
			sta ZP.EndID

			lda #3
			sta ZP.Temp2

		TwoColumns:


		GetTopLeftChar:

			lda CharY
			sta UseCharY
			lsr
			tay

			lda CharX
			sta UseCharX
			sta StartCharX
			lsr
			tax

			jsr PLOT.GetCharacter

			lda #0
			sta ZP.ColumnID

			lda ZP.Row
			cmp #23
			bcc Loop

			jmp Finish

		Loop:

			ldy ZP.Y
			lda (ZP.ScreenAddress), y

			beq NoBlock

			tax
			lda CharConvert, x
			sta ZP.CharID

			jsr CalculateBlockID

		CheckBlocked:

			lda BlockRightTop_Left, x
			beq NoBlock

		
		NoOverride:

			jsr Kill

			dec CanMove
			//inc $d020
			jmp Finish
		
		NoBlock:

			lda ZP.CurrentID
			clc
			adc #1
			sta ZP.CurrentID

			cmp ZP.EndID
			beq Finish

			lda ZP.ColumnID
			clc
			adc #1
			sta ZP.ColumnID

			cmp ZP.Temp2
			bcc NextColumn

			NewRow:

				inc UseCharY

				lda StartCharX
				sta UseCharX

				lda #0
				sta ZP.ColumnID

				jmp CheckChar

			NextColumn:

				inc UseCharX
				
			CheckChar:

				lda UseCharY
				lsr
				cmp ZP.Row
				beq NoRowCharChange

				sta ZP.Row

				lda ZP.Y
				clc
				adc #40
				sta ZP.Y

			NoRowCharChange:

				lda UseCharX
				lsr
				cmp ZP.Column
				beq NoRowColChange

				sta ZP.Column

				bcc GoLeft


				inc ZP.Y
				jmp EndLoop

			GoLeft:

				dec ZP.Y

			NoRowColChange:

			EndLoop:

				jmp Loop
	
		Finish:






		rts
	}

	

	ControlDirection: {	

		lda #0
		sta Moving
		sta Firing

	
		CheckDead:

			lda Active
			bne NotDead

		NotDead:

			lda FIRE.FireTimer
			bmi NotFiring

			inc Firing

			jmp Finish

		NotFiring:

			ldy #1
			lda INPUT.JOY_FIRE_NOW, y
			beq NotTryFire

			inc Firing
			jsr FIRE.Do
			rts

		NotTryFire:

			lda #0
			sta Moving

		CheckDown:
			
			lda INPUT.JOY_DOWN_NOW, y
			bne Down

			jmp CheckUp

		Down:

			lda #DOWN
			sta Direction

			inc Moving

			lda PosY_Frac
			clc
			adc #SPEED_FRAC_DIAG
			sta PosY_Frac

			lda PosY
			sta ZP.Amount
			adc #0
			clc
			adc #SPEED_PIXEL_DIAG
			sta PosY


		CheckOffsetDown:

			lda PosY
			sec
			sbc ZP.Amount
			clc
			adc OffsetY
			sta OffsetY

			
			cmp #4
			bcs WrapOffsetDown

			jmp NoWrapOffsetDown

		WrapOffsetDown:

			sec
			sbc #4
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
			sbc #SPEED_FRAC_DIAG
			sta PosY_Frac

			lda PosY
			sta ZP.Amount
			sbc #0
			sec
			sbc #SPEED_PIXEL_DIAG
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
			adc #4
			sta OffsetY

			dec CharY

		NoWrapOffsetUp:



		CheckRight:
			
			lda INPUT.JOY_RIGHT_NOW, y
			bne Right

			jmp CheckLeft

		Right:	

			lda #RIGHT
			sta Direction

			lda #1
			sta FacingRight
		
			inc Moving

			lda PosX_Frac
			clc
			adc FracSpeed
			sta PosX_Frac


			lda PosX_LSB
			sta ZP.Amount
			adc PixelSpeed
			sta PosX_LSB

			
		CheckOffsetRight:


			lda PosX_LSB
			sec
			sbc ZP.Amount
			clc
			adc OffsetX
			sta OffsetX


			cmp #4
			bne NoWrapOffsetRight

		Okay:

			sec
			sbc #4
			sta OffsetX


			inc CharX

		NoWrapOffsetRight:

			jmp CheckFire

		CheckLeft:
			
			lda INPUT.JOY_LEFT_NOW, y
			bne Left

			jmp CheckFire

		Left:	

			lda #LEFT
			sta Direction

			lda #0
			sta FacingRight

			inc Moving

			lda PosX_Frac
			sec
			sbc FracSpeed
			sta PosX_Frac

			lda PosX_LSB
			sta ZP.Amount
			sbc PixelSpeed
			sta PosX_LSB
		
		
		
		CheckOffsetLeft:

		
			lda PosX_LSB
			sec
			sbc ZP.Amount
			clc
			adc OffsetX
			sta OffsetX

			cmp #255
			bne NoWrapOffsetLeft

			clc
			adc #4
			sta OffsetX

			dec CharX

		NoWrapOffsetLeft:

		CheckFire:

		Finish:

		
			rts




	}

	Fire: {


		rts
	}

	UpdateSprite: {

			lda Firing
			bne MSB_Done

		Position:	

			lda #0
			sta PosX_MSB

			lda PosX_LSB
			clc
			adc #24
			sta SpriteX + PlayerSprite

			lda PosX_MSB
			adc #0
			sta PosX_MSB

			lda PosY
			sta SpriteY + PlayerSprite

			lda CharY
			sta SpriteCharY + PlayerSprite

			lda CharX
			sta SpriteCharX + PlayerSprite

		Colour:

			lda #GREEN

			ldy MAP_GENERATOR.Scrolling
			beq NotScrolling
	
			lda #BLUE

		NotScrolling:

			sta SpriteColor + PlayerSprite

		Animate:

			lda Moving
			bne IsMoving

		Idle:

			lda FacingRight
			asl
			asl
			adc #PointerStart
			sta SpritePointer + PlayerSprite


			jmp MSB

		IsMoving:

			lda FacingRight
			asl
			asl
			clc
			ldx Frame
			adc FrameSequence, x
			clc
			adc #PointerStart
			sta SpritePointer + PlayerSprite

		MSB:

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

			inc Frame
			lda Frame
			and #%00000011
			sta Frame



		Finish:

		rts
	}



	Kill: {

		//jsr SOUND.Dead

		lda Dead
		bne Finish

		jsr SPEECH.GotPlayer

		lda #1
		sta Dead

		lda #0
		sta FrameTimer
		sta DeathProgress


		lda #255
		sta SpawnSide


		lda PosX_LSB
		sec
		sbc #1
		sta PosX_LSB

		lda PosX_MSB
		sbc #0
		sta PosX_MSB

		ldy #PlayerSprite
		jsr UTILITY.StoreMSBColourY

		lda PosY
		sec
		sbc #2
		sta PosY

		jsr UpdateSprite
			

		Finish:

		
		rts
	}


	

	ResetAfterDead: {

		lda #9
		sta FlashesRemaining

		jsr OTTO.Disable

		jsr ROBOT.KillAll

		jsr LIVES.Decrease

		lda LIVES.GameOver
		beq NotGameOver

		lda #0
		sta VIC.SPRITE_ENABLE

		jsr HI_SCORE.Initialise
		rts

		NotGameOver:


		jsr MAP_GENERATOR.RandomMap
		jsr MAP_GENERATOR.Generate
		//jsr Initialise

		rts
	}


	

	HandleDead: {

		SetDebugBorder(DARK_GRAY)

		lda FrameTimer
		beq Ready

		dec FrameTimer
		rts

		Ready:

			lda #1
			sta FrameTimer

			ldx DeathProgress
			lda DeathColours, x
			and #%00000111
			sta SpriteColor + PlayerSprite

			ldy #PlayerSprite
			lda PosX_MSB
			jsr UTILITY.StoreMSBColourY

			lda DeathProgress
			and #%00000011
			clc
			adc #76
			sta SpritePointer + PlayerSprite

			inc DeathProgress
			lda DeathProgress
			cmp #DeathFrames
			bcc Finish

		lda #0
		sta Dead
		sta Active

		lda #0
		sta SpriteY + PlayerSprite
		sta SpriteCopyY + PlayerSprite

		jsr ResetAfterDead

		Finish:

		rts
	}


	CheckLeaveLevel: {

		//lda PosX_MSB
		//beq CheckLeft


		CheckRight:

			lda PosX_LSB
			cmp #245
			bcc CheckLeft

			lda #LEFT
			dec MAP_GENERATOR.X
			jmp MAP_GENERATOR.SetupScroll

		CheckLeft:

			lda PosX_LSB
			cmp #6
			bcs NotLeft

			inc MAP_GENERATOR.X
			lda #RIGHT
			jmp MAP_GENERATOR.SetupScroll
			
		NotLeft:

			lda PosY
			cmp #48
			bcs NotUp

			dec MAP_GENERATOR.Y
			lda #DOWN
			jmp MAP_GENERATOR.SetupScroll


		NotUp:

			lda PosY
			cmp #236
			bcc NotDown

			inc MAP_GENERATOR.Y

			lda #UP
			jmp MAP_GENERATOR.SetupScroll


		NotDown:



		Exit:

		rts


	}

	
	HandleFlash: {

		
		lda SpawnDelay
		beq DoFlash

		dec SpawnDelay
		rts

		DoFlash:

		dec FlashesRemaining
		lda FlashesRemaining
		bne StillGoing

		jsr Activate
	

		StillGoing:

			jsr UpdateSprite

			lda #FlashFrames
			sta SpawnDelay

			lda VIC.SPRITE_ENABLE
			bmi TurnOff

		TurnOn:

			lda #255
			sta VIC.SPRITE_ENABLE
			rts

		TurnOff:

			lda #0
			sta VIC.SPRITE_ENABLE



		rts
	}


	Activate: {

		jsr ROBOT.NewLevel
		jsr OTTO.NewLevel

		lda #0
		sta FlashesRemaining

		lda #255
		sta VIC.SPRITE_ENABLE


		rts
	}

	FrameUpdate: {

		//inc $d020

		SetDebugBorder(GREEN)


		lda FlashesRemaining
		beq NoFlash
		bmi Activate

		jsr HandleFlash
		jmp SkipControl

		NoFlash:

	
		lda SpawnDelay
		beq Spawned


		dec SpawnDelay
		lda SpawnDelay
		bne NotActive

		NowReady:

			lda #1
			sta Active

			lda #255
			sta VIC.SPRITE_ENABLE

			jmp Spawned

		NotActive:

			//jsr CheckFlash

			rts

		Spawned:

			lda Active
			beq Finish

			lda PLAYER.Dead
			beq NotDead

		//	dec $d020

			jmp HandleDead

		NotDead:

			lda MAP_GENERATOR.Scrolling
			bne SkipControl


			jsr ControlDirection
			//jsr CheckDiag
			jsr CheckFrame
			jsr CheckPosition
			jsr CheckLeaveLevel
			jsr CalculateSegment

		SkipControl:

			jsr UpdateSprite
		
			//jsr CheckCollision
			//jsr CheckMine

			lda #0
			sta ZP.Amount


		Finish:

		//dec $d020
		

		SetDebugBorder(BLACK)

		rts
	}



}