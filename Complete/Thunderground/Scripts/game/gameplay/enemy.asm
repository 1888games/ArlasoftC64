ENEMY: {


	* = * "Enemy"

	Colour:				.byte 0, 0
	Active:				.byte 0, 0
	SpawnTimer:			.byte 0, 0
	ShootTimer:			.byte 0, 0

	SpawnX:				.byte 32, 64
	SpawnY:				.byte 74, 74
	SpawnX_MSB:			.byte 0, 1
	SpawnDirection:		.byte RIGHT, LEFT
	DigCharX:			.byte 0, 0
	DigCharY:			.byte 0, 0
	CharX:				.byte 0, 0
	CharY:				.byte 0, 0

	* = * "Error2"
	XAdd:				.byte 255, 1, 0, 0

	* = * "Error"
	YAdd:				.byte 0, 0, 1, 255


	SpawnCharX:			.byte 3, 35
	SpawnCharY:			.byte 3, 3

	SPEED_Frac:			.byte 100
	SPEED_Pixel:		.byte 0

	Bullet_Speed_Frac:	.byte 120
	Bullet_Speed_Pixel:	.byte 0

	PosX_Frac:			.byte 0, 0
	PosX_LSB:			.byte 0, 0
	PosX_MSB:			.byte 0, 0
	PosY:				.byte 0, 0
	PosY_Frac:			.byte 0, 0
	MoveDirection:		.byte 0, 0
	PixelsRemaining:	.byte 0, 0


	StalkFactors:		.byte 0, 0

	FlashColour:		.byte 0, 0

	Dead:				.byte 0, 0


	DeadColours:		.byte 255, PURPLE, 255, PURPLE, 255, PURPLE, 255
						.byte PURPLE, PURPLE, PURPLE, 255, PURPLE, PURPLE
						.byte PURPLE, 255, PURPLE, PURPLE, PURPLE, 255
						.byte PURPLE, 255, PURPLE, PURPLE, PURPLE, 255
						.byte LIGHT_GRAY, 255, GRAY, 255, DARK_GRAY, 255
						.byte BLACK






	ValidDirections:	
	ValidDirectionLeft:		.byte 0
	ValidDirectionRight: 	.byte 0
	ValidDirectionDown:  	.byte 0
	ValidDirectionUp:		.byte 0

	OppositeDirections:	.byte RIGHT, LEFT, UP, DOWN

	PreferredDirections:	.byte LEFT, UP, DOWN, RIGHT
							.byte RIGHT, UP, DOWN, LEFT
							.byte DOWN, LEFT, RIGHT, UP
							.byte UP, RIGHT, LEFT, DOWN

	.label DeadFrames = 32				
	.label StartSpeed = 150
	.label BulletSpeed = 0

	.label SpeedIncrease = 20
	.label BulletIncrease = 64

	.label InitialShootTime = 95
	.label PointerStart = 19

	.label InitialPixels = 24




	NewGame: {


		lda #100
		sta StalkFactors

		lda #180
		sta StalkFactors + 1

		lda #StartSpeed
		sta SPEED_Frac

		lda #1
		sta BOMB.SPEED_Pixel
		sta Bullet_Speed_Pixel

		lda #BulletSpeed
		sta Bullet_Speed_Frac

		jsr Reset

		rts
	}

	Reset: {

		jsr Generate

		lda #0
		sta SPEED_Pixel
		sta Active
		sta Active + 1
		sta Dead
		sta Dead + 1

		ldx #0

		Loop:

			lda #5
			sta SpawnTimer, x

			lda #0
			sta PosX_LSB, x
			sta PosX_MSB, x
			sta PosY, x
			sta Dead, x
			sta CharX, x
			sta CharY, x
			sta DigCharX, x
			sta DigCharY, x
			sta PixelsRemaining, x
			sta ShootTimer, x
			sta FlashColour, x

			inx
			cpx #2
			bcc Loop


		rts
	}



	Spawn: {

		lda SpawnTimer, x
		bmi Finish

		beq ReadyToSpawn

		dec SpawnTimer, x
		rts

		ReadyToSpawn:

			lda #0
			sta PosX_Frac, x
			sta PosY_Frac, x
			sta FlashColour, x
			sta Dead, x

			lda SpawnDirection, x
			sta MoveDirection, x

			lda #InitialPixels
			sta PixelsRemaining, x
				
			lda #255
			sta SpawnTimer, x

			lda SpawnX, x
			sta PosX_LSB, x

			lda SpawnCharX, x
			sta CharX, x
			sta DigCharX, x

			lda SpawnCharY, x
			sta CharY, x
			sta DigCharY, x

			lda SpawnY, x
			sta PosY, x

			lda SpawnX_MSB, x
			sta PosX_MSB, x

			jsr MoveDigLocation

		
			jsr RANDOM.Get
			and #%00011111
			clc
			adc #InitialShootTime
			sta ShootTimer, x

			lda #1
			sta Active, x


		Finish:

		rts

	}


	NewLevel: {

		jsr Reset

		lda StalkFactors
		cmp #51
		bcc Okay1
		sec
		sbc #3
		sta StalkFactors

		Okay1:

		lda StalkFactors + 1
		cmp #51
		bcc Okay2
		sec
		sbc #5
		sta StalkFactors + 1

		Okay2:


		rts
	}

	Generate: {

		ldx LEVEL.SubLevel
		lda LEVEL.Enemy_1, x
		sta Colour

		lda LEVEL.Enemy_2, x
		sta Colour + 1


		rts
	}	


	AI: {

		lda PixelsRemaining, x
		beq LookForMove

		jsr Move

		lda PixelsRemaining, x
		beq LookForMove

		jmp CheckFire

		LookForMove:

			Blue:

				lda Colour, x
				cmp #WHITE
				beq White

				jsr BlueEnemy
				jmp CheckFire

			White:

				jsr WhiteEnemy
		
		CheckFire:

				ldx ZP.EnemyX

				lda ShootTimer, x
				bmi Finish

				beq ReadyToFire

				dec ShootTimer, x
				jmp Finish

				ReadyToFire:

				jsr BOMB.Fire

				lda #255
				sta ShootTimer, x

		Finish:

			rts

	}


	BlueEnemy: {

		stx ZP.EnemyX

		lda #1
		sta ValidDirections
		sta ValidDirections + 1
		sta ValidDirections + 2
		sta ValidDirections + 3

		CheckTunnelRight:

			lda CharX, x
			clc
			adc #2
			cmp #36
			bcc CheckTunnelLeft

			dec ValidDirectionRight

		CheckTunnelLeft:

			lda CharX, x
			sec
			sbc #1
			cmp #4
			bcs CheckTunnelDown

			dec ValidDirectionLeft

		CheckTunnelDown:

			lda CharY, x
			clc
			adc #2
			cmp #16
			bcc CheckTunnelUp
		
			dec ValidDirectionDown

		CheckTunnelUp:

			lda CharY, x
			sec
			sbc #1
			cmp #3
			bcs CheckDone

			dec ValidDirectionUp

		CheckDone:

			ldx ZP.EnemyX

		CheckForward:

			jsr RANDOM.Get
			cmp StalkFactors + 1
			bcc ChooseDirection

		CantGoForward:

			lda PLAYER.CharY
			sec
			sbc CharY, x
			sta ZP.Temp3
			bpl NoReverse

			eor #%11111111
			clc
			adc #1

			NoReverse:

			sta ZP.Temp3

			lda CharX, x
			sec
			sbc PLAYER.CharX
			bpl NoReverse2

			eor #%11111111
			clc
			adc #1

		NoReverse2:

			sta ZP.Temp2
		
			cmp ZP.Temp3
			bcc UpDown

		LeftRight:

			lda CharX, x
			sec
			sbc PLAYER.CharX
			bpl TryLeft
			bmi TryRight

			jmp ChooseDirection

		UpDown:


			lda PLAYER.CharY
			sec
			sbc CharY, x
			bpl TryDown
			bmi TryUp

		TryRight:

			lda ValidDirectionRight
			beq ChooseDirection

			lda #RIGHT
			sta MoveDirection, x
			jmp DoneMove

		TryLeft:

			lda ValidDirectionLeft
			beq ChooseDirection

			lda #LEFT
			sta MoveDirection, x
			jmp DoneMove

		TryUp:

			lda ValidDirectionUp
			beq LeftRight

			lda #UP
			sta MoveDirection, x
			jmp DoneMove

		TryDown:

			lda ValidDirectionDown
			beq LeftRight

			lda #DOWN
			sta MoveDirection, x
			jmp DoneMove

	
		ChooseDirection:

			ldx ZP.EnemyX

			.label TryDirection = ZP.Temp3
			.label Errors = ZP.Temp2
			.label DirectionLook = ZP.Temp1

			lda #0
			sta Errors

		DecisionLoop:

			inc Errors
			lda Errors
			cmp #6
			bcc NoTurn

			cmp #7
			beq ForceTurn

		TryForward:

			lda #0
			sta TryDirection
			jmp TryPreferred

		ForceTurn:

			ldx ZP.StoredXReg

			lda MoveDirection, x
			asl
			asl
			clc
			adc #3
			tay
			lda PreferredDirections, y
			sta TryDirection
			jmp Selected

		NoTurn:

			lda #0
			sta TryDirection

			jsr RANDOM.Get

			cmp #230
			bcc TryPreferred

			cmp #243
			bcc TryTwo

		TryThree:

			lda #2
			sta TryDirection
			jmp TryPreferred

		TryTwo:

			lda #1
			sta TryDirection

		TryPreferred:

			lda MoveDirection, x
			asl
			asl
			clc
			adc TryDirection
			tay
			lda PreferredDirections, y
			sta TryDirection
			tay
			lda ValidDirections, y
			beq DecisionLoop


		Selected:

			lda TryDirection
			sta MoveDirection, x

		DoneMove:

			lda #8
			sta PixelsRemaining, x

			jsr MoveDigLocation

			
		rts

	}


	CheckEachOther: {

		lda ZP.EnemyX
		eor #%00000001
		tay

		lda PosX_LSB, y
		sec
		sbc PosX_LSB, x
		cmp #20
		bcs NotRight

		lda PosY, y
		sec
		sbc PosY, x
		clc
		adc #8
		cmp #16
		bcs NotRight

		lda #0
		sta ValidDirectionRight


		NotRight:

		lda PosX_LSB, x
		sec
		sbc PosX_LSB, y
		cmp #20
		bcs NotLeft

		lda PosY, y
		sec
		sbc PosY, x
		clc
		adc #8
		cmp #16
		bcs NotLeft

		lda #0
		sta ValidDirectionLeft

		NotLeft:

		lda PosX_LSB, x
		sec
		sbc PosX_LSB, y
		adc #8
		cmp #16
		bcs NotUp

		lda PosY, y
		sec
		sbc PosY, x
		cmp #20
		bcs NotUp
		
		lda #0
		sta ValidDirectionUp

		NotUp:

		lda PosX_LSB, x
		sec
		sbc PosX_LSB, y
		adc #8
		cmp #16
		bcs NotDown

		lda PosY, x
		sec
		sbc PosY, y
		cmp #20
		bcs NotDown

		lda #0
		sta ValidDirectionDown



		NotDown:
	




		rts
	}

	WhiteEnemy: {

		stx ZP.EnemyX

		lda #0
		sta ValidDirections
		sta ValidDirections + 1
		sta ValidDirections + 2
		sta ValidDirections + 3

		CheckTunnelRight:

			lda CharX, x
			clc
			adc #2
			sta ZP.Column



			lda CharY, x
			tay

			ldx ZP.Column
		
			jsr PLOT.GetCharacter
			cmp #CHAR_TUNNEL
			bne CheckTunnelLeft

			ldy #40
			lda (ZP.ScreenAddress), y

			cmp #CHAR_TUNNEL
			bne CheckTunnelLeft

			inc ValidDirectionRight


		CheckTunnelLeft:

			ldx ZP.EnemyX

			lda CharX, x
			sec
			sbc #1
			sta ZP.Column

			lda CharY, x
			tay

			ldx ZP.Column
		
			jsr PLOT.GetCharacter
			cmp #CHAR_TUNNEL
			bne CheckTunnelDown

			ldy #40
			lda (ZP.ScreenAddress), y

			cmp #CHAR_TUNNEL
			bne CheckTunnelDown

		
			inc ValidDirectionLeft

		CheckTunnelDown:

			ldx ZP.EnemyX
			lda CharX, x
			sta ZP.Column

			lda CharY, x
			clc
			adc #2
			tay

			ldx ZP.Column
		
			jsr PLOT.GetCharacter
			cmp #CHAR_TUNNEL
			bne CheckTunnelUp


			ldy #1
			lda (ZP.ScreenAddress), y

			cmp #CHAR_TUNNEL
			bne CheckTunnelUp

			
			inc ValidDirectionDown

		CheckTunnelUp:

			ldx ZP.EnemyX
			lda CharX, x
			sta ZP.Column

			lda CharY, x
			sec
			sbc #1
			tay

			cpy #3
			bcc CheckDone

			ldx ZP.Column
		
			jsr PLOT.GetCharacter
			cmp #CHAR_TUNNEL
			bne CheckDone

			ldy #1
			lda (ZP.ScreenAddress), y

			cmp #CHAR_TUNNEL
			bne CheckDone

			inc ValidDirectionUp


		CheckDone:

			ldx ZP.EnemyX

			jsr CheckEachOther

		CheckForward:

			jsr RANDOM.Get
			cmp StalkFactors
			bcc ChooseDirection

			lda MoveDirection, x
			asl
			asl
			tay
			lda PreferredDirections, y
			tay
			lda ValidDirections, y
			bne ChooseDirection

		CantGoForward:

			lda PLAYER.CharY
			sec
			sbc CharY, x
			bpl TryDown
			bmi TryUp

		CheckLeftRight:

			lda CharX, x
			sec
			sbc PLAYER.CharX
			bpl TryLeft
			bmi TryRight

			jmp ChooseDirection


		TryRight:

			lda ValidDirectionRight
			beq ChooseDirection

			lda #RIGHT
			sta MoveDirection, x
			jmp DoneMove

		TryLeft:

			lda ValidDirectionLeft
			beq ChooseDirection

			lda #LEFT
			sta MoveDirection, x
			jmp DoneMove

		TryUp:

			lda ValidDirectionUp
			beq CheckLeftRight

			lda #UP
			sta MoveDirection, x
			jmp DoneMove

		TryDown:

			lda ValidDirectionDown
			beq CheckLeftRight

			lda #DOWN
			sta MoveDirection, x
			jmp DoneMove


	
		ChooseDirection:

			ldx ZP.EnemyX

			.label TryDirection = ZP.Temp3
			.label Errors = ZP.Temp2
			.label DirectionLook = ZP.Temp1

			lda #0
			sta Errors

		DecisionLoop:

			inc Errors
			lda Errors
			cmp #6
			bcc NoTurn

			cmp #7
			beq ForceTurn

		TryForward:

			lda #0
			sta TryDirection
			jmp TryPreferred

		ForceTurn:

			ldx ZP.EnemyX

			lda MoveDirection, x
			asl
			asl
			clc
			adc #3
			tay
			lda PreferredDirections, y
			sta TryDirection
			jmp Selected

		NoTurn:

			lda #0
			sta TryDirection

			jsr RANDOM.Get

			cmp #180
			bcc TryPreferred

			cmp #230
			bcc TryTwo

		TryThree:

			lda #2
			sta TryDirection
			jmp TryPreferred

		TryTwo:

			lda #1
			sta TryDirection

		TryPreferred:

			lda MoveDirection, x
			asl
			asl
			clc
			adc TryDirection
			tay
			lda PreferredDirections, y
			sta TryDirection
			tay
			lda ValidDirections, y
			beq DecisionLoop


		Selected:

			ldx ZP.EnemyX

			lda TryDirection
			sta MoveDirection, x

		DoneMove:

			lda #8
			sta PixelsRemaining, x

			jsr MoveDigLocation


		rts
	}

	
	MoveDigLocation: {

		ldx ZP.EnemyX
	
		lda MoveDirection, x
		tay
		lda XAdd, y
		clc
		adc CharX, x
		sta DigCharX, x

		lda YAdd, y
		clc
		adc CharY, x
		sta DigCharY, x

		rts
	}


	CheckDead: {



		rts
	}

	UpdateSprites: {

		Mask:

			lda #32
			sta VIC.SPRITE_0_X

			lda #56
			sta VIC.SPRITE_1_X

			lda LEVEL.WallColour
			sta VIC.SPRITE_COLOR_0
			sta VIC.SPRITE_COLOR_1

			lda SpawnY
			sta VIC.SPRITE_0_Y
			sta VIC.SPRITE_1_Y

			lda VIC.SPRITE_MSB
			and #%11111100
			ora #%00000010
			sta VIC.SPRITE_MSB

		
		Ships:


		ldx #0
		stx VIC.SPRITE_2_Y
		stx VIC.SPRITE_3_Y

		ldy #0

		Loop:

			lda Active, x
			beq Hide

			jsr UpdateSprite
			jmp EndLoop

		Hide:

		EndLoop:

			inx
			iny
			iny
			cpx #2
			bcc Loop

		FinallyPointers:

			lda #PointerStart
			clc
			adc MoveDirection
			sta SPRITE_POINTERS + 2

			lda #PointerStart
			clc
			adc MoveDirection + 1
			sta SPRITE_POINTERS + 3

			lda #38
			sta SPRITE_POINTERS + 0
			sta SPRITE_POINTERS + 1

		rts
	}

	UpdateSprite: {
		
		lda PosX_LSB, x
		sta VIC.SPRITE_2_X, y

		lda PosY, x
		sta VIC.SPRITE_2_Y, y

		DoColour:

			lda Dead, x
			beq NotDead

			sty ZP.Temp4

			tay
			lda DeadColours, y
			bpl UseThis

			lda Colour, x

		UseThis:

			sta VIC.SPRITE_COLOR_2, x

			ldy ZP.Temp4

			jmp NowMSB

		NotDead:

			lda Colour, x
			clc
			adc FlashColour, x
			sta VIC.SPRITE_COLOR_2, x

		NowMSB:

			lda PosX_MSB, x
			beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + 2, x
			sta VIC.SPRITE_MSB
			jmp DoneMSB

		NoMSB:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 2, x
			sta VIC.SPRITE_MSB



		DoneMSB:


		rts
	}

	HandleDead: {

		lda ZP.Counter
		and #%00000001
		bne NotYet

		inc Dead, x

		lda Dead, x
		cmp #DeadFrames
		bcc NotYet

		lda #0
		sta Active, x
		sta Dead, x

		lda #0
		sta SpawnTimer, x

		NotYet:


		rts
	}


	UpdateTunnel: {

		lda Colour, x
		cmp #WHITE
		beq Finish

		lda DigCharX, x
		sta ZP.Column
		cmp #4
		bcc Finish

		cmp #35
		bcs Finish

		lda DigCharY, x
		cmp #4
		bcc Finish

		
		tay

		ldx ZP.Column

		jsr PLOT.GetCharacter

		ldx ZP.EnemyX

		ldy #0
		lda #CHAR_TUNNEL
		sta (ZP.ScreenAddress), y

		iny
		lda #CHAR_TUNNEL
		sta (ZP.ScreenAddress), y

		ldy #40
		lda #CHAR_TUNNEL
		sta (ZP.ScreenAddress), y

		iny
		lda #CHAR_TUNNEL
		sta (ZP.ScreenAddress), y

		ldy ZP.StoredYReg

		Finish:

		rts

	}
	


	FrameUpdate: {

		lda PLAYER.CollectTimer
		bpl Finish

		lda PLAYER.Active
		beq Finish

		ldx #0
		ldy #0


		Loop:
			stx ZP.EnemyX
			sty ZP.StoredYReg

			lda Dead, x
			beq NotDead	

			jsr HandleDead
			jmp EndLoop


		NotDead:

			lda Active, x
			beq CheckSpawn

			
				jsr AI
				jsr UpdateTunnel
				jsr CheckDead
			
				jmp EndLoop

			CheckSpawn:

				jsr Spawn


			EndLoop:

				inx
				ldy ZP.StoredYReg
				iny
				iny
				cpx #2
				bcc Loop


		Finish:

		
		rts
	}



	

	Move: {	

		lda Active, x
		bne NotDead

		jmp Finish

		NotDead:

			lda PLAYER.CollectTimer
			bmi CheckRight

			jmp Finish


		CheckRight:

			lda MoveDirection, x
			cmp #RIGHT
			bne CheckLeft

		Right:	

			lda CharX, x
			cmp #34
			bcc OkayRight

			lda #0
			sta PixelsRemaining, x

			rts

		OkayRight:

		DoneCharRight:

			lda PosX_Frac, x
			clc
			adc SPEED_Frac
			sta PosX_Frac, x

			lda PosX_LSB, x
			sta ZP.Amount
			adc #0
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x

			lda PosX_LSB, x
			clc
			adc SPEED_Pixel
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x

			lda ZP.Amount
			sec
			sbc PosX_LSB, x
			clc
			adc PixelsRemaining, x
			sta PixelsRemaining, x

			bpl NoWrapRight

			lda #0
			sta PixelsRemaining, x

			lda PosX_LSB, x
			sec
			sbc #1
			sta PosX_LSB, x

			lda PosX_MSB, x
			sbc #0
			sta PosX_MSB, x

		NoWrapRight:

			lda PixelsRemaining, x
			bne StillGoingRight

			inc CharX, x

	

		StillGoingRight:

			rts



		CheckLeft:

			lda MoveDirection, x
			cmp #LEFT
			bne CheckDown

		Left:	

			lda CharX, x
			cmp #5
			bcs OkayLeft

			lda #0
			sta PixelsRemaining, x
		
			rts

		OkayLeft:

		

		DoneCharLeft:

			lda PosX_Frac, x
			sec
			sbc SPEED_Frac
			sta PosX_Frac, x

			lda PosX_LSB, x
			sta ZP.Amount
			sbc #0
			sta PosX_LSB, x

			lda PosX_MSB, x
			sbc #0
			sta PosX_MSB, x

			lda PosX_LSB, x
			sec
			sbc SPEED_Pixel
			sta PosX_LSB, x

			lda PosX_MSB, x
			sbc #0
			sta PosX_MSB, x

			lda PosX_LSB, x
			sec
			sbc ZP.Amount
			clc
			adc PixelsRemaining, x
			sta PixelsRemaining, x

			bpl NoWrapLeft

			lda #0
			sta PixelsRemaining, x

			lda PosX_LSB, x
			clc
			adc #1
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x

		NoWrapLeft:

			lda PixelsRemaining, x
			bne StillGoingLeft

			dec CharX, x

		
		StillGoingLeft:

			rts


		CheckDown:

			lda MoveDirection, x
			cmp #DOWN
			bne CheckUp

		Down:	

			lda CharY, x
			cmp #14
			bcc OkayDown

			lda #0
			sta PixelsRemaining, x

			rts

		OkayDown:


		DoneCharDown:

			lda PosY_Frac, x
			clc
			adc SPEED_Frac
			sta PosY_Frac, x

			lda PosY, x
			sta ZP.Amount
			adc #0
			clc
			adc SPEED_Pixel
			sta PosY, x
		
			lda ZP.Amount
			sec
			sbc PosY, x
			clc
			adc PixelsRemaining, x
			sta PixelsRemaining, x
			bpl NoWrapDown

			lda #0
			sta PixelsRemaining,  x

			dec PosY, x

		NoWrapDown:


			lda PixelsRemaining, x
			bne StillGoingDown

			inc CharY, x

		StillGoingDown:

			rts


		CheckUp:

			lda MoveDirection, x
			cmp #UP
			bne Finish

		Up:	

			lda CharY, x
			cmp #3
			bcs OkayUp

			lda #0
			sta PixelsRemaining, x

			rts

		OkayUp:


		DoneCharUp:

			lda PosY_Frac, x
			sec
			sbc SPEED_Frac
			sta PosY_Frac, x

			lda PosY, x
			sta ZP.Amount
			sbc #0
			sec
			sbc SPEED_Pixel
			sta PosY, x
		
			lda PosY, x
			sec
			sbc ZP.Amount
			clc
			adc PixelsRemaining, x
			sta PixelsRemaining, x

			bpl NoWrapUp

			lda #0
			sta PixelsRemaining, x

			inc PosY, x

		NoWrapUp:

			lda PixelsRemaining, x
			bne StillGoingUp

			dec CharY, x

		StillGoingUp:

			rts

		Finish:

	
			rts


	}



	rts
}