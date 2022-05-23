SHIP:{


	PosX_LSB:		.byte 188
	PosX_MSB:		.byte 0
	PosX_SUB:		.byte 0
    PosY:			.byte 186


	.label MinX = 60
	.label MaxX = 28
	.label MinY = 82
	.label MaxY = 238

    MoveSpeed:		.byte 2
    AnyMovement:	.byte 0

    .label MaxSpeed = 3

    .label StartX = 170

    Colours:	.byte 6, 5

    CurrentPlayer:	.byte 0

    DeathSequence:	.byte 1, 99, 1, 99, 1, 99, 1, 99, 1, 15, 12, 11, 0, 50
    DeathSequencePosition: 	.byte 0
    DeathTimer:	.byte 5, 4
    Dead:	.byte 0
    Paused:	.byte 1



    .label KillShipSoundID= 1


    NewGame: {

    	lda #22
		sta SPRITE_POINTERS

		lda Colours
		sta VIC.SPRITE_COLOR_0

		lda #0
		sta CurrentPlayer

		jsr Reset

		jsr ENERGY.UpdateColours


    	rts

    }



	Reset: {


		lda #StartX
		sta PosX_LSB

		lda #0
		sta PosX_MSB

		jsr SetPosition

		rts
	}



	SetPosition: {

		lda PosX_LSB
		sta VIC.SPRITE_0_X

		lda PosY
		sta VIC.SPRITE_0_Y

		lda PosX_MSB
		beq MSBOff

		MSBOn:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On
			sta VIC.SPRITE_MSB
			jmp Finish

		MSBOff:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off
			sta VIC.SPRITE_MSB


		Finish:

			rts
	}



	Kill: {


		lda Dead
		bne Finish


		jsr ENEMIES.BackupMSB

		lda #1
		sta Dead
		sta Paused
		sta ENERGY.Died

		lda #0
		sta DeathSequencePosition

		


		lda DeathTimer + 1
		sta DeathTimer

		jsr ENERGY.SetEnergyZero

		sfx(1)

		Finish:


		rts
	}

	DeathUpdate: {

		lda DeathTimer
		beq TimerExpired

		dec DeathTimer
		jmp Finish

		TimerExpired:


			lda DeathTimer + 1
			sta DeathTimer

			ldy CurrentPlayer
			ldx DeathSequencePosition
			lda DeathSequence, x

			cmp #99

			bne ColourOk

			lda Colours, y 

			ColourOk:

			inc DeathSequencePosition

			sta VIC.SPRITE_COLOR_0
			cmp #50
			bne NotEnd

			lda #0
			sta Dead
			sta VIC.SPRITE_0_X

			lda VIC.SPRITE_MSB
			and #%11111110
			sta VIC.SPRITE_MSB

			lda #1
			sta Paused

			lda Colours, y 
			sta VIC.SPRITE_COLOR_0 

			jsr Reset
			jsr LIVES.LoseLife

			lda MAIN.GameIsOver
			beq Okay

			jmp Finish

			Okay:

			jsr ENERGY.Reset
			jsr BULLET.Reset
			jsr ENEMIES.ResetLevel

			jmp Finish

			NotEnd:

			cmp #0
			bne Finish

			lda #60
			sta DeathTimer


		Finish:

		rts


	}

	Update: {	

		//SetDebugBorder(7)

		lda #1
		sta AnyMovement

		lda Dead
		beq NotDead

		jsr DeathUpdate
		rts

		NotDead:

		lda Paused
		beq NotPaused
		jmp Finish

		NotPaused:

			ldx CurrentPlayer
			lda Colours, x
			sta VIC.SPRITE_COLOR_0
			
			lda MAIN.GameActive
			bne Okay

			rts

		Okay:

		lda MoveSpeed
		cmp #MaxSpeed
		bcs NoIncrease

		inc MoveSpeed

		NoIncrease:

		ldy #1

		CheckLeft:
	
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda #1
			sta AnyMovement

			lda PosX_LSB
			sec
			sbc MoveSpeed
			sta PosX_LSB

			lda PosX_MSB
			sbc #00
			sta PosX_MSB

			lda PosX_MSB
			bne CheckFire

			CheckLeftEdge:

				lda PosX_LSB
				cmp #MinX
				bcs CheckFire

				lda #MinX
				sta PosX_LSB

				jmp CheckFire


		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckFire

			lda #1
			sta AnyMovement

			lda PosX_LSB
			clc
			adc MoveSpeed
			sta PosX_LSB

			lda PosX_MSB
			adc #00
			sta PosX_MSB

			lda PosX_MSB
			beq CheckFire

			CheckRightEdge:

				lda PosX_LSB
				cmp #MaxX
				bcc CheckFire

				lda #MaxX
				sta PosX_LSB

				jmp CheckFire

	
		CheckFire:

			lda MAIN.AutoFire
			bne CheckUpThisFrame

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq NoFire

			jsr Fire

			CheckUpThisFrame:

			lda INPUT.JOY_FIRE_NOW, y
			beq NoFire

			jsr Fire
			
		NoFire:

			jsr SetPosition

			lda AnyMovement
			bne Finish

			lda #1
			sta MoveSpeed


		Finish:
	
	//	dec $d020

	SetDebugBorder(0)

		rts




	}


	Fire: {

		jsr BULLET.PlayerFire



		rts
	}


}