PLAYER: {

	* = * "Player"
	
	Direction:	.byte UP

	PosX_LSB:	.byte 0
	PosX_MSB:	.byte 0
	PosX_Frac:	.byte 0

	PosY:		.byte 0
	PosY_Frac:	.byte 0

	CharX:		.byte 0
	CharY:		.byte 0
	DigCharX:	.byte 0
	DigCharY:	.byte 0

	OffsetX:	.byte 0
	OffsetY:	.byte 0

	.label PointerStart = 24
	.label StartX = 176
	.label StartY = 162
	.label StartCharX = 19
	.label StartCharY = 14

	.label SPEED_Frac = 1
	.label SPEED_Pixel = 1


	.label MaxX = 75
	.label MinX = 24
	.label MaxY = 162
	.label MinY = 64

	Colour:					.byte LIGHT_RED
	TunnelColour:			.byte BROWN
	StartTunnelColour:		.byte BROWN

	Active:		.byte 1
	HasToken:	.byte 0


	Moving:				.byte 0
	MoveDirection:		.byte 0
	PixelsRemaining:	.byte 0

	ExplosionFrame:		.byte 0
	ExplosionTimer:		.byte 0

	CollectTimer:		.byte 255
	GameOver:			.byte 0

	.label ExplosionTime =12





	Initialise: {


		lda StartTunnelColour 
		sta TunnelColour

		lda #0
		sta HasToken
		sta GameOver

		jsr Reset

		

		rts
	}


	Reset: {

		lda #StartX
		sta PosX_LSB

		lda #0
		sta PosX_MSB

		lda #LIGHT_RED
		sta Colour

		lda #StartY
		sta PosY

		lda #StartCharX
		sta CharX
		sta DigCharX

		lda #StartCharY
		sta CharY
		sta DigCharY

		lda #1
		sta Active

		lda #3
		sta OffsetX
		sta OffsetY

		lda #UP
		sta MoveDirection

		lda #0
		sta ExplosionFrame
		sta PixelsRemaining

		lda #255
		sta CollectTimer

		lda #100
		sta ENEMY.ShootTimer
		sta ENEMY.ShootTimer + 1

		jsr LEVEL.ResetTicks





		rts
	}


	UpdateSprite: {

		lda PosX_LSB
		sta VIC.SPRITE_7_X

		lda PosY
		sta VIC.SPRITE_7_Y	

		lda CollectTimer
		bmi Pointer

		
			lda #28
			clc
			adc TOKEN.Type
			sta SPRITE_POINTERS + 7
			jmp DoColour

		Pointer:

			lda #PointerStart
			clc
			adc MoveDirection
			clc
			adc ExplosionFrame
			sta SPRITE_POINTERS + 7

		DoColour:

			lda Colour
			sta VIC.SPRITE_COLOR_7

			lda PosX_MSB
			beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + 7
			sta VIC.SPRITE_MSB
			jmp DoneMSB

		NoMSB:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 7
			sta VIC.SPRITE_MSB


		DoneMSB:


		rts
	}


	CheckDead: {

		lda ExplosionFrame
		beq Finish


		lda ExplosionTimer
		beq Ready

		dec ExplosionTimer
		rts


		Ready:


		lda ExplosionFrame
		cmp #9
		beq Increment


		ResetAlive:

			lda #0
			sta ExplosionFrame

			lda GameOver
			beq NotGameOver

			lda #GAME_MODE_OVER
			sta MAIN.GameMode

			lda #60
			sta MAIN.GameOverTimer
			rts


		NotGameOver:

			
			jsr Reset
			jsr ENEMY.Reset
			jsr BOMB.NewLevel
			rts

		Increment:

			lda #37
			sec
			sbc #PointerStart
			sec
			sbc MoveDirection
			sta ExplosionFrame

			lda #ExplosionTime
			sta ExplosionTimer
			rts

		Finish:

		rts
	}


	CheckToken: {

		lda CollectTimer
		bmi NotCollecting

		beq DoneCollecting

		dec CollectTimer
		rts

		DoneCollecting:

			lda #1
			sta Active

			lda #255
			sta CollectTimer

			rts


		NotCollecting:

		lda Active
		beq Finish

		lda TOKEN.Collected
		bne Finish


			lda CharX
			sec 
			sbc TOKEN.CharX
			cmp #2
			bcs Finish

			lda CharY
			sec
			sbc TOKEN.CharY
			cmp #2
			bcs Finish

		Collected:

			lda #64
			clc
			adc TOKEN.Type
			tay

			jsr SCORE.AddScore

			lda #70
			sta CollectTimer

			lda #0
			sta Active

			lda #CYAN
			sta Colour

			lda #1
			sta HasToken
			sta TOKEN.Collected

			sfx(SFX_ALARM)
		
	
		Finish:




		rts
	}

	FrameUpdate: {


	
		jsr Control
		jsr UpdateTunnel
		jsr UpdateSprite
		jsr CheckDead
		jsr CheckToken
		jsr CheckCollisionEnemy
		jsr CheckCollisionBomb




		rts
	}

	UpdateTunnel: {

		ldx DigCharX
		ldy DigCharY

		jsr PLOT.GetCharacter

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



		rts

	}

	CheckCollisionEnemy: {

		lda Active
		beq Finish

		lda CollectTimer
		bpl Finish

		ldx #0

		Loop:

			lda ENEMY.Active, x
			beq EndLoop

			lda ENEMY.Dead, x
			bne EndLoop

			lda ENEMY.PosX_MSB, x
			sec
			sbc PosX_MSB
			bne EndLoop

			lda ENEMY.PosY, x
			sec
			sbc PosY
			clc
			adc #10
			cmp #20
			bcs EndLoop

			lda ENEMY.PosX_LSB, x
			sec
			sbc PosX_LSB
			clc
			adc #12
			cmp #24
			bcs EndLoop

			lda #1
			sta ENEMY.Dead, x

			lda #0
			sta Active

			jsr Died

			EndLoop:

				inx
				cpx #2
				bcc Loop



			Finish:

				rts



		rts
	}


	Died: {

		lda #0
		sta Active

		lda #ExplosionTime
		sta ExplosionTimer

		lda #9
		sta ExplosionFrame

		jsr BASES.FlashTunnel

		jsr LIVES.Lose

		sfx(SFX_DEAD)

		rts
	}


	CheckCollisionBomb: {

		lda Active
		beq Finish


		ldx #0

		Loop:

			lda BOMB.Active, x
			beq EndLoop


			lda BOMB.PosX_MSB, x
			sec
			sbc PosX_MSB
			bne EndLoop

			lda BOMB.PosY, x
			sec
			sbc PosY
			clc
			adc #10
			cmp #20
			bcs EndLoop

			lda BOMB.PosX_LSB, x
			sec
			sbc PosX_LSB
			clc
			adc #12
			cmp #24
			bcs EndLoop

			lda #0
			sta Active
			
			jsr BOMB.Despawn
			
			jsr Died

			EndLoop:

				inx
				cpx #2
				bcc Loop



			Finish:

				rts



		rts
	}


	Control: {

		lda Active
		beq Finish

		ldy #1

		lda PixelsRemaining
		beq CheckLeft

		jsr Move

		lda PixelsRemaining
		beq CheckLeft

		jmp CheckFire

		CheckLeft:

			
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda #LEFT
			sta MoveDirection

			lda #8
			sta PixelsRemaining

			//lda #0
			//sta PosX_Frac
			//sta PosY_Frac

			jsr Move

			jmp CheckFire

		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda #RIGHT
			sta MoveDirection

			lda #8
			sta PixelsRemaining

			//lda #0
			//sta PosX_Frac
			//sta PosY_Frac

			jsr Move
			jmp CheckFire

		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			lda #DOWN
			sta MoveDirection

			lda #8
			sta PixelsRemaining

			lda #0
			sta PosX_Frac
			sta PosY_Frac

			jsr Move
			jmp CheckFire

		CheckUp:


			lda INPUT.JOY_UP_NOW, y
			beq CheckFire

			lda #UP
			sta MoveDirection

			lda #8
			sta PixelsRemaining

			lda #0
			sta PosX_Frac
			sta PosY_Frac

			jsr Move
		
		CheckFire:

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq Finish

			jsr BULLET.Fire


		Finish:

			lda PixelsRemaining
			cmp #6
			bcc NoSound


			sfx(SFX_ENGINE)

		NoSound:

			rts
	}


	

	Move: {	

		lda Active
		bne NotDead

		jmp Finish

		NotDead:

		ldy #1

		CheckRight:

			lda MoveDirection
			cmp #RIGHT
			bne CheckLeft

		Right:	

			lda CharX
			cmp #34
			bne OkayRight

			lda #0
			sta PixelsRemaining

			rts

		OkayRight:

			lda PixelsRemaining
			cmp #8
			bcc DoneCharRight

			inc DigCharX

		DoneCharRight:

			lda PosX_Frac
			clc
			adc #SPEED_Frac
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
			adc #SPEED_Pixel
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB

			lda ZP.Amount
			sec
			sbc PosX_LSB
			clc
			adc PixelsRemaining
			sta PixelsRemaining

			bpl NoWrapRight

			lda #0
			sta PixelsRemaining

			lda PosX_LSB
			sec
			sbc #1
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB

		NoWrapRight:

			lda PixelsRemaining
			bne StillGoingRight

			inc CharX

	

		StillGoingRight:

			rts



		CheckLeft:

			lda MoveDirection
			cmp #LEFT
			bne CheckDown

		Left:	

			lda CharX
			cmp #5
			bcs OkayLeft

			lda #0
			sta PixelsRemaining
		
			rts

		OkayLeft:

			lda PixelsRemaining
			cmp #8
			bcc DoneCharLeft

			dec DigCharX

		DoneCharLeft:

			lda PosX_Frac
			sec
			sbc #SPEED_Frac
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
			sbc #SPEED_Pixel
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB

			lda PosX_LSB
			sec
			sbc ZP.Amount
			clc
			adc PixelsRemaining
			sta PixelsRemaining

			bpl NoWrapLeft

			lda #0
			sta PixelsRemaining

			lda PosX_LSB
			clc
			adc #1
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB

		NoWrapLeft:

			lda PixelsRemaining
			bne StillGoingLeft

			dec CharX

		
		StillGoingLeft:

			rts


		CheckDown:

			lda MoveDirection
			cmp #DOWN
			bne CheckUp

		Down:	

			lda CharY
			cmp #14
			bcc OkayDown

			lda #0
			sta PixelsRemaining

			rts

		OkayDown:

			lda PixelsRemaining
			cmp #8
			bcc DoneCharDown

			inc DigCharY

		DoneCharDown:

			lda PosY_Frac
			clc
			adc #SPEED_Frac
			sta PosY_Frac

			lda PosY
			sta ZP.Amount
			adc #0
			clc
			adc #SPEED_Pixel
			sta PosY
		
			lda ZP.Amount
			sec
			sbc PosY
			clc
			adc PixelsRemaining
			sta PixelsRemaining

			bpl NoWrapDown

			lda #0
			sta PixelsRemaining

			dec PosY

		NoWrapDown:


			lda PixelsRemaining
			bne StillGoingDown

			inc CharY

		StillGoingDown:

			rts


		CheckUp:

			lda MoveDirection
			cmp #UP
			bne Finish

		Up:	

			lda CharY
			cmp #3
			bcs OkayUp

			lda #0
			sta PixelsRemaining

			rts

		OkayUp:

			lda PixelsRemaining
			cmp #8
			bcc DoneCharUp

			dec DigCharY

		DoneCharUp:

			lda PosY_Frac
			sec
			sbc #SPEED_Frac
			sta PosY_Frac

			lda PosY
			sta ZP.Amount
			sbc #0
			sec
			sbc #SPEED_Pixel
			sta PosY
		
			lda PosY
			sec
			sbc ZP.Amount
			clc
			adc PixelsRemaining
			sta PixelsRemaining

			bpl NoWrapUp

			lda #0
			sta PixelsRemaining

			inc PosY

		NoWrapUp:

			lda PixelsRemaining
			bne StillGoingUp

			dec CharY

		StillGoingUp:

			rts

		

		Finish:


			
			rts




	}





}