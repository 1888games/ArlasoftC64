POWERUP: {


	.label Margin = 30
	.label MinX = PLAYER.MinX + Margin
	.label MaxX = PLAYER.MaxX - Margin

	.label MinY = PLAYER.MinY + Margin
	.label MaxY = PLAYER.MaxY - Margin - 50

	.label FirstPointer = 67
	.label FrameTime = 8



	PosX_LSB:		.byte 0
	PosX_MSB:		.byte 0
	PosY:			.byte 0
	Frame:			.byte 0
	FrameTimer: 	.byte 0
	Delay:			.byte 10
	PosX_Char:		.byte 0
	PosY_Char:		.byte 0


	Collected:		.byte 0
	
	PowerActive:	.byte 255

	TypeChance:		.byte POWER_SLOW, POWER_SLOW, POWER_SLOW, POWER_SLOW, POWER_DESPAWN, POWER_INVINCIBLE, POWER_INVINCIBLE, POWER_INVINCIBLE
	Type:			.byte 0
	StartPointer:	.byte 0
	TypeColour:		.byte WHITE, BLUE, PURPLE
	Colour:			.byte 0

	Reset:	{

		lda #0
		sta FrameTimer
		sta PosY

		lda #YELLOW
	//	sta SpriteColor + 2

		lda #255
		sta PowerActive

		lda #0
		sta Collected

		lda #10
		//sta SpriteY + 2
		//sta PowerActive

		//jsr New

		
		rts
	}



	Collect: {



		ldx PowerActive
		bmi Finish
		lda #1
		sta ENEMY.SlowMode, x

		lda TypeColour, x
		sta $d020

		lda #255
		sta PowerActive

		lda #200
		sta Collected

		lda #10
		sta PosY

		jsr Delete


		Finish:

		rts
	}


	Delete: {

		ldx PosX_Char
		ldy PosY_Char
		lda #0

		jsr PLOT.PlotCharacter


		rts
	}


	New: {

		lda PowerActive
		clc
		adc #FirstPointer
		sta StartPointer

		ldx PowerActive
		lda TypeColour, x
		sta Colour

	NoDelete:


		lda #0
		sta PosX_MSB

	NewRandom:

		jsr RANDOM.Get
		and #%00111111
		cmp #40
		bcs NewRandom

		sta PosX_Char
		asl
		asl
		clc
		asl
		bcs IsMSB

	AddOffset1:

		clc
		adc #17
		bcc NoMSB1

		inc PosX_MSB
		jmp NoMSB1

	IsMSB:

		inc PosX_MSB
		jmp AddOffset1

	NoMSB1:
		
		sta PosX_LSB

		jsr RANDOM.Get
		and #%00001111
		clc
		adc #3
		sta PosY_Char

		tay
		asl
		asl
		asl
		clc
		adc #44
		sta PosY
		
		lda PosX_Char
		cmp #16
		bcc NoCheck

		lda PosX_Char
		cmp #15
		bcc NoCheck

		cmp #24
		bcs NoCheck

		jmp NoDelete


		NoCheck:

		ldx PosX_Char
		lda StartPointer

	
		jsr PLOT.PlotCharacter


		lda Colour
		jsr PLOT.ColorCharacter

		lda #0
		sta FrameTimer
		sta Frame

		lda #250
		sta Delay


		rts

	}

	CheckSpawn: {

		lda Collected
		beq NotCollected

		lda ZP.Counter
		and #%00000001
		beq Finish

		dec Collected
		lda Collected
		beq TimeUp

			cmp #28
			bcs Finish

			and #%00000011
			cmp #2
			bcc Finish

			sta $d020

			sfx(SFX_WARN)

			jmp Finish

		TimeUp:

			lda ENEMY.Exit
			beq NotExit

			lda #ENEMY.StartFrames
			sta ENEMY.SpawnDelay

		NotExit:

			lda #0
			sta ENEMY.Invincible
			sta ENEMY.SlowMode
			sta ENEMY.Exit
			sta $d020

		NotCollected:
		// Try every 5 seconds

			jsr RANDOM.Get
			cmp #67
			bne Finish

			jsr RANDOM.Get
			and #%00001111
			cmp #8
			bcs Finish

			tax
			lda TypeChance, x
			sta PowerActive

			jsr New


		Finish:

			rts
	}

	EndPowerup: {

		lda #255
		sta PowerActive

		lda #10
	//	sta SpriteY + 2

		lda #0
		sta Collected

		jsr Delete

		rts
	}

	ProcessPowerup: {

		CheckWhetherExpired:

			lda ZP.Counter
			and #%00000011
			bne NoReduceTimer

			lda Delay
			beq ClearPowerup

			dec Delay
			jmp NoReduceTimer

		ClearPowerup:

			jmp EndPowerup

		NoReduceTimer:

			lda PosY
			//sta SpriteY + 2

			lda FrameTimer
			beq Ready

			dec FrameTimer
			jmp NotYet

		Ready:

			lda #FrameTime
			sta FrameTimer

			inc Frame
			lda Frame
			cmp #4
			bcc Okay

			lda #0
			sta Frame

		Okay:

			clc
			adc StartPointer
		//	sta SpritePointer + 2

		NotYet:




		rts
	}

	FrameUpdate: {

		lda PLAYER.Active
		beq Finish

		lda PowerActive
		bpl ProcessPowerup

		jmp CheckSpawn


		Finish:
			

		rts
	}








}