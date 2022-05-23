

.label NUM_BELTS = 6

BELT: {




	Running:		.fill NUM_BELTS, 0
	Paused:			.fill NUM_BELTS, 0
	DishCount:		.fill NUM_BELTS, 0
	Progress_LSB:	.fill NUM_BELTS, 0
	Progress_MSB:	.fill NUM_BELTS, 0
	PauseTime:		.fill NUM_BELTS, 0
	UpdateWheel:	.fill NUM_BELTS, 0
	WheelPosition:	.fill NUM_BELTS, 0

	Flashing:	.fill NUM_BELTS, 0
	FlashTimer:	.fill NUM_BELTS, 0
	Speed:		.fill NUM_BELTS, StartSpeed

	MinSpeed:	.byte 0

	Rows:		.fill NUM_BELTS, 2 + (i * 4)

	WheelStart:	.byte 60, 64, 68, 72



	.label ProgressTarget = 3

	.label FlashTime = 12
	.label BeltCharID = 33
	.label PauseFlashThreshold = 72
	.label StartSpeed = 40
	.label PauseBeltTime = 250
	.label WheelChar = 60
	.label SpawnPerDish = 2


	SpawnTime:			.byte 0

	CurrentSpawnTime:	.byte 0

	SoundCountdown:		.byte 0


	NewGame: {

		lda #127
		sta CurrentSpawnTime

		lda #50
		sta SpawnTime


		jsr ResetAll

		jsr MAIN.PlayConveyor
	

		rts
	}


	ResetAll: {

		lda #StartSpeed
		sta MinSpeed

		ldx #0


		Loop:

			stx ZP.BeltID

			jsr Reset

			ldx ZP.BeltID
			inx
			cpx #NUM_BELTS
			bcc Loop

		//lda #1
		//sta DishCount

		rts
	}



	Reset: {

		lda #0
		sta Running, x
		sta PauseTime, x
		sta Progress_LSB, x
		sta WheelPosition, x
		sta Flashing, x
		sta Paused, x
		sta DishCount, x


		jsr RANDOM.Get
		and #%00000111
		sta Progress_MSB, x


		jsr UpdateBeltGraphics

		jsr DISH.ResetForBelt

		rts
	}



	UpdateWheelGraphics: {

		lda UpdateWheel, x
		beq Finish

		inc WheelPosition, x
		lda WheelPosition, x
		cmp #4
		bcc Okay

		lda #0
		sta WheelPosition, x


		Okay:

		lda Rows, x
		tay
		iny

		ldx #2

		jsr PLOT.GetCharacter

		ldx ZP.BeltID
		lda WheelPosition, x
		tay

		lda WheelStart, y
		sta ZP.CharID


		ldy #0
		lda ZP.CharID
		sta (ZP.ScreenAddress), y

		ldy #8
		sta (ZP.ScreenAddress), y

		ldy #16
		sta (ZP.ScreenAddress), y

		ldy #24
		sta (ZP.ScreenAddress), y

		clc
		adc #1


		ldy #40
		sta (ZP.ScreenAddress), y

		ldy #48
		sta (ZP.ScreenAddress), y

		ldy #56
		sta (ZP.ScreenAddress), y

		ldy #64
		sta (ZP.ScreenAddress), y

		clc
		adc #1


		ldy #1
		sta (ZP.ScreenAddress), y

		ldy #9
		sta (ZP.ScreenAddress), y

		ldy #17
		sta (ZP.ScreenAddress), y

		ldy #25
		sta (ZP.ScreenAddress), y


		clc
		adc #1


		ldy #41
		sta (ZP.ScreenAddress), y

		ldy #49
		sta (ZP.ScreenAddress), y

		ldy #57
		sta (ZP.ScreenAddress), y

		ldy #65
		sta (ZP.ScreenAddress), y


		lda #0
		sta UpdateWheel, x

		Finish:




		rts
	}


	
	UpdateBeltGraphics: {

		lda Rows, x
		tay

		ldx #0

		jsr PLOT.GetCharacter

		ldx ZP.BeltID

		lda Progress_MSB, x
		asl
		clc
		adc #BeltCharID
		sta ZP.CharID


		ldy #0

		Loop:

			lda ZP.CharID
			sta (ZP.ScreenAddress), y

			iny
			clc
			adc #1
			sta (ZP.ScreenAddress), y

			iny
			cpy #28
			bcc Loop


		lda ZP.CharID
		clc
		adc #43
		sta ZP.CharID

		ldy #80

		Loop2:

			lda (ZP.ScreenAddress), y
			cmp #76
			bcc Skip

			lda ZP.CharID
			sta (ZP.ScreenAddress), y

		Skip:

			iny
			lda (ZP.ScreenAddress), y
			cmp #76
			bcc EndLoop

			lda ZP.CharID
			clc
			adc #1
			sta (ZP.ScreenAddress), y


		EndLoop:

			iny
			cpy #80 + 28
			bcc Loop2



		rts
	}



	FrameUpdate: {

		jsr Play
		jsr UpdateBelts

		rts
	}




	Play: {

		lda SpawnTime
		beq ReadyToSpawn

		dec SpawnTime
		rts


		ReadyToSpawn:

			jsr Spawn

			beq NotThisFrame

			lda CurrentSpawnTime
			cmp #575
			bcc NoDecrease

			lda CurrentSpawnTime
			sec
			sbc #SpawnPerDish
			sta CurrentSpawnTime

		NoDecrease:

			lda MinSpeed
			cmp #190
			bcs NoIncrease

			inc MinSpeed
			inc MinSpeed
			

		NoIncrease:

			jsr RANDOM.Get
			and #%00111111
			clc
			adc CurrentSpawnTime
			sta SpawnTime

		NotThisFrame:

		rts
	}


	Spawn: {

		jsr RANDOM.Get
		and #%00000111
		cmp #6
		bcs Spawn

		sta ZP.BeltID
		tax

		lda Paused, x
		bne Finish

		lda DishCount, x
		cmp #MAX_DISHES
		beq Finish

		cmp #0
		bne SkipSpeed

		jsr RANDOM.Get
		and #%00011111
		clc
		adc MinSpeed
		sta Speed, x


		SkipSpeed:

		jsr DISH.SpawnForBelt

		lda #1
		rts

		Finish:

		lda #0


		rts
	}


	UpdateBelts: {



		ldx #0

		Loop:

			stx ZP.BeltID

			jsr Process

			ldx ZP.BeltID
			inx
			cpx #NUM_BELTS
			bcc Loop




		rts
	}


	Process: {

		jsr UpdatePause
		jsr CheckDishes
		jsr TurnBelt
		jsr UpdateWheelGraphics
		jsr UpdateLight

		jsr DISH.ProcessForBelt

		jsr CheckSound

		rts
	}	


	CheckSound: {

		lda SoundCountdown
		beq Ready

		dec SoundCountdown
		rts

		Ready:

		ldx #0

		Loop:

			lda Running, x
			bne Finish

			inx
			cpx #6
			bcc Loop

			jsr $21F9


		Finish:





		rts
	}

	UpdatePause: {

		lda Paused, x
		bne IsPaused

		lda #0
		sta Running, x
		rts


		IsPaused:

			lda PauseTime, x
			beq Unpause

			dec PauseTime, x
			rts

		Unpause:

			lda #0
			sta Paused, x

			jsr MAIN.PlayConveyor


		rts
	}


	CheckDishes: {

		lda #0
		sta Running, x

		lda DishCount, x
		beq Finish

		lda Paused, x
		bne Finish

		lda #1
		sta Running, x


		Finish:




		rts
	}

	PauseCommon: {


		lda #5
		sta PLAYER.Debounce

		lda #SFX_BUTTON
		jsr MAIN.PlayChannel2

		jsr MAIN.PlayConveyor



		rts
	}

	PauseBelt: {

		lda PauseTime, x
		beq NotPaused


		Unpause:



			lda #0
			sta PauseTime, x
			sta Paused, x

			jmp PauseCommon

		NotPaused:

			lda Running, x
			beq Finish

			lda #PauseBeltTime
			sta PauseTime, x

			lda #1
			sta Paused, x

			jsr PauseCommon

		Finish:


		rts
	}


	UpdateLight: {

		lda #RED + 8
		sta ZP.Colour

		lda Running, x
		beq NotRunning

		IsRunning:

			lda #GREEN + 8
			sta ZP.Colour
			jmp Finish

		NotRunning:

			lda Paused, x
			beq Finish

		IsPaused:

			lda PauseTime, x
			cmp #PauseFlashThreshold
			bcs Finish

			lda FlashTimer, x
			beq DoFlash

			dec FlashTimer, x
			jmp DoLight

		DoFlash:

			lda #FlashTime
			sta FlashTimer, x

			lda Flashing, x
			eor #%00000001
			sta Flashing, x

			lda #SFX_ALARM
   			jsr MAIN.PlayChannel2


		DoLight:

			lda Flashing, x
			beq Finish

			lda #YELLOW + 8
			sta ZP.Colour


		Finish:

			lda Rows, x
			tay
			iny

			ldx #28

			jsr PLOT.GetCharacter

			ldx ZP.BeltID

			lda ZP.Colour
			ldy #0

			sta (ZP.ColourAddress), y

		rts
	}


	TurnBelt: {

		lda Running, x
		beq Finish

		lda Progress_LSB, x
		clc
		adc Speed, x
		sta Progress_LSB, x
		bcc NoIncrease

		jsr DISH.MoveDishes

		inc Progress_MSB, x
		lda Progress_MSB, x
		cmp #8
		bcc NoWrap


		Wrap:

			lda #0
			sta Progress_MSB, x

		

		NoWrap:

			lda Progress_MSB, x
			and #%00000001
			bne Skip
			inc UpdateWheel, x


		Skip:
			jsr UpdateBeltGraphics
		
		

		NoIncrease:



		Finish:



		rts
	}



}