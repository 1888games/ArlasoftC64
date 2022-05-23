CHICKEN: {

	* = * "Chicken"

	.label Start_Y = 232

	Y_Pos:		.byte Start_Y, Start_Y
	X_Pos:		.byte 95, 221
	Frame:		.byte 0, 0
	FrameTimer:	.byte 0, 0
	Mode:		.byte 0, 0
	Joystick:	.byte 1, 0
	Active:		.byte 1, 1
	Moved:		.byte 0, 0
	Score:		.byte 0, 0
	Knockback:	.byte 0, 0
	ControlTimer:	.byte 0

	GameSeconds:	.byte 0
	SecondTimer:	.byte 0
	Difficulty:		.byte 0, 0
	CPU:			.byte 0


	.label FrameTime = 2
	.label Seconds = 136
	.label FramesPerSecond = 50
	.label MaxLevels = 8
	.label ControlBounce = 10


	.label KnockBackDistance = 24

	TextColour:	.byte RED_MULT, RED_MULT

	DifficultyColours:	.byte RED_MULT, BLUE_MULT


	NumberChars:	.byte 11, 12, 9, 10
					.byte 14, 15, 13, 10
					.byte 23, 24, 13, 22
					.byte 25, 26, 9, 10
					.byte 29, 30, 27, 28
					.byte 31, 32, 33, 28
					.byte 34, 35, 33, 28
					.byte 38, 39, 36, 37
					.byte 40, 41, 33, 28
					.byte 42, 43, 33, 28

	Blank:			.byte 15, 15, 21, 21

	Column:			.byte 8, 25






	NewGame: {

		lda #Seconds
		sta GameSeconds

		lda #FramesPerSecond
		sta SecondTimer

		ldx Difficulty
		lda DifficultyColours, x
		sta TextColour

		ldx Difficulty + 1
		lda DifficultyColours, x
		sta TextColour + 1

		lda #0
		sta Score
		sta Score + 1

		lda #Start_Y
		sta Y_Pos
		sta Y_Pos + 1

		jsr UpdateSprites

		rts




	}

	DrawCharacter: {

		ldx ZP.Column
		ldy ZP.Row

		jsr PLOT.GetCharacter


		ldx ZP.Temp3
		ldy #0




		lda NumberChars, x
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

		ldy #1
		lda NumberChars + 1, x
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y
		

		ldy #40
		lda NumberChars + 2, x
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

		ldy #41
		lda NumberChars + 3, x
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y
		

		rts

	}

	DisplayScore: {

		ldx #0
	

		Loop:

			lda #0
			sta ZP.Row
			sta ZP.Temp2
			stx ZP.Temp1

			lda TextColour, x
			sta ZP.Colour

			cpx #1
			bcc NoAI

			lda CPU
			beq NoAI

			lda #8
			sta ZP.Colour

			NoAI:


			lda Column, x
			sta ZP.Column

			lda Score, x
			sta ZP.CharID
			cmp #10
			bcc NoFirstDigit

			CountLoop:

				sec  
				sbc #10

				bmi DrawFirstDigit

				inc ZP.Temp2
				sta ZP.CharID

				jmp CountLoop

			DrawFirstDigit:

				lda ZP.Temp2
				asl
				asl
				sta ZP.Temp3

			FirstChar:

				jsr DrawCharacter

				jmp MainDigit


			NoFirstDigit:

				lda #40
				sta ZP.Temp3

				jmp FirstChar

			MainDigit:

				inc ZP.Column
				inc ZP.Column

				lda ZP.CharID
				asl
				asl
				sta ZP.Temp3

				
				jsr DrawCharacter


			EndLoop:

				ldx ZP.Temp1
				inx
				cpx #2
				beq Finish

				jmp Loop


			Finish:




		rts
	}

	UpdateSprites: {

		lda Frame
		clc
		adc Mode
		clc
		adc #23
		sta SPRITE_POINTERS + 6

		lda #YELLOW
		sta VIC.SPRITE_COLOR_6

		lda X_Pos
		sta VIC.SPRITE_6_X

		lda Y_Pos
		sta VIC.SPRITE_6_Y


		lda Frame + 1
		clc
		adc Mode + 1
		clc
		adc #23
		sta SPRITE_POINTERS + 7

		lda #YELLOW
		sta VIC.SPRITE_COLOR_7

		lda X_Pos + 1
		sta VIC.SPRITE_7_X

		lda Y_Pos + 1
		sta VIC.SPRITE_7_Y



		rts

	}	


	Control: {



		ldx #0
		stx Moved
		stx Moved + 1


		PlayerLoop:

			lda Active, x
			beq EndLoop

			lda Mode, x
			bne EndLoop

			lda Joystick, x
			tay

		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq CheckDown

			inc Moved, x

			dec Y_Pos, x

			lda Y_Pos, x
			cmp #62
			bcs EndLoop

			inc Score, x

			jsr SOUND.Tick

			lda #Start_Y
			sta Y_Pos, x

			jmp EndLoop


		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq EndLoop

			inc Moved, x

			inc Y_Pos, x

			lda Y_Pos, x
			cmp #Start_Y
			bcc EndLoop

			lda #Start_Y
			sta Y_Pos, x


		EndLoop:

			inx
			cpx #2
			bcc PlayerLoop




		rts
	}



	CheckFrame: {

		ldx #0

		Loop:

			lda Moved, x
			beq EndLoop

			lda FrameTimer, x
			beq Ready	

			dec FrameTimer, x
			jmp EndLoop


			Ready:

				lda #FrameTime
				sta FrameTimer, x

				lda Frame, x
				eor #%00000001
				sta Frame, x

			EndLoop:

				inx 
				cpx #2
				bcc Loop


		rts
	}


	Collisions: {

		ldx #0

		PlayerLoop:

			stx ZP.CurrentID

			lda Active, x
			beq EndPlayerLoop

			lda Mode, x
			bne EndPlayerLoop

			ldy #0

			TrafficLoop:

				lda TRAFFIC.VehicleType, y
				beq EndTrafficLoop

				lda TRAFFIC.VehicleX_MSB, y
				bne EndTrafficLoop

				lda Y_Pos, x
				//sec
				//sbc #2
				sec
				sbc TRAFFIC.YPositions, y
				clc
				adc #7
				cmp #14
				bcc CloseY

				//iny
				//iny
				jmp EndTrafficLoop

				CloseY:

				lda X_Pos, x
				sec 
				sbc TRAFFIC.VehicleX_LSB, y
				clc
				adc #13
				cmp #26
				bcs EndTrafficLoop

			

			GoBack:

				jsr SOUND.HitChick

				
				lda Difficulty, x
				bne GoBackStart

				lda #1
				sta Mode, x

				lda #KnockBackDistance
				sta Knockback, x

				jmp EndPlayerLoop

			GoBackStart:

				lda #Start_Y
				sta Y_Pos, x

				jmp EndPlayerLoop

			EndTrafficLoop:

				iny
				cpy #30
				bcs EndPlayerLoop

				jmp TrafficLoop



		EndPlayerLoop:

			inx
			cpx #2
			beq Finish	

			jmp PlayerLoop



		Finish:

			rts


	}


	KnockBack: {

		ldx #0

		Loop:

			lda Mode, x
			beq EndLoop

			lda Knockback, x
			beq Done

			inc Y_Pos, x

			lda Y_Pos, x
			cmp #Start_Y
			bcc Setup


			lda #Start_Y
			sta Y_Pos, x

			Setup:

			lda #1
			sta Moved, x

			dec Knockback, x

			jmp EndLoop

			Done:

				lda #0
				sta Mode, x
				sta Moved, x


			EndLoop:

				inx
				cpx #2
				bcc Loop


		rts
	}

	GameTimer: {

		lda GameSeconds
		cmp #8
		bcs NoWarning

		lda ZP.Counter
		and #%00000011
		bne NoWarning

		inc TextColour
		inc TextColour + 1
		lda TextColour
		cmp #16
		bcc NoFirstColour

		lda #8
		sta TextColour

		NoFirstColour:

		lda TextColour + 1
		cmp #16
		bcc NoWarning

		lda #8
		sta TextColour + 1

		NoWarning:

			lda SecondTimer
			beq Ready

			dec SecondTimer
			rts

		Ready:

			lda #FramesPerSecond
			sta SecondTimer

			dec GameSeconds
			lda GameSeconds
			beq GameOver

			rts

		GameOver:

			lda #GAME_MODE_OVER
			sta MAIN.GameMode

			lda #30
			sta MAIN.GameOverTimer

		rts
	}


	GameSelect: {

		lda TRAFFIC.Level
		clc
		adc #1
		sta Score
		sta Score + 1

		ldx Difficulty
		lda DifficultyColours, x
		sta TextColour

		ldx Difficulty + 1
		lda DifficultyColours, x
		sta TextColour + 1

		jsr SelectControl
		jsr DisplayScore


		rts
	}

	SelectControl: {

		lda ControlTimer
		beq Ready	

		dec ControlTimer
		rts

		Ready:

		ldx #0
		stx ZP.Amount

		PlayerLoop:

			lda Joystick, x
			tay

		CheckFire:

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq CheckUp

			jsr NewGame

			jsr SOUND.StartHum

			lda #GAME_MODE_PLAY
			sta MAIN.GameMode

			rts

		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq CheckDown

			inc TRAFFIC.Level
			inc ZP.Amount

			lda #ControlBounce
			sta ControlTimer

			jsr SOUND.Tick

			lda TRAFFIC.Level
			cmp #8
			beq Wrap

			jmp EndLoop

			Wrap:

				lda #0
				sta TRAFFIC.Level

				jmp EndLoop

		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckLeft

			dec TRAFFIC.Level

			lda #ControlBounce
			sta ControlTimer

			inc ZP.Amount

			jsr SOUND.Tick

			lda TRAFFIC.Level
			bmi Wrap2

			jmp EndLoop

			Wrap2:

			lda #MaxLevels
			sta TRAFFIC.Level


		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda Difficulty, x
			eor #%00000001
			sta Difficulty, x

			lda #ControlBounce
			sta ControlTimer

			jsr SOUND.Tick

		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq EndLoop

			lda CPU
			eor #%00000001
			sta CPU

			lda #ControlBounce
			sta ControlTimer

			jsr SOUND.Tick

		EndLoop:

			inx
			cpx #2
			beq Done

			jmp PlayerLoop


		Done:

		lda ZP.Amount
		beq NoUpdate


		jsr TRAFFIC.NewGame
		jsr UpdateSprites



		NoUpdate:


		rts
	}

	CheckSpeed: {

		lda TRAFFIC.Level
		cmp #4
		bcc NoChange

		jsr RANDOM.Get
		cmp #235
		bcc NoChange

		ChooseLane:

		jsr RANDOM.Get
		and #%00001111
		cmp #10
		bcs ChooseLane

		sta ZP.Row


		jsr TRAFFIC.GetNewLaneSpeed


		NoChange:


		rts
	}


	AI: {

		//inc $d020

		lda CPU
		beq Finish

		lda Active + 1
		beq Finish

		lda Mode + 1
		bne Finish

		lda #0
		sta ZP.Temp3

		ldy #0

		jsr RANDOM.Get
		cmp #30
		bcc Finish

		cmp #240
		bcs Move

		TrafficLoop:

			lda TRAFFIC.VehicleType, y
			beq EndTrafficLoop

			lda TRAFFIC.VehicleX_MSB, y
			bne EndTrafficLoop

			lda Y_Pos + 1
			sec
			sbc TRAFFIC.YPositions, y
			clc
			adc #20
			cmp #40
			bcc CloseY

			iny
			iny
			jmp EndTrafficLoop

			CloseY:
			
			lda X_Pos + 1
			sec 
			sbc TRAFFIC.VehicleX_LSB, y
			clc
			adc #20
			cmp #40
			bcs EndTrafficLoop

			inc ZP.Temp3

		EndTrafficLoop:

			iny
			cpy #30
			bcs Decide

			jmp TrafficLoop



		Decide:

			lda ZP.Temp3
			bne Finish

		Move:

			inc Moved + 1
			dec Y_Pos + 1

			lda Y_Pos + 1
			cmp #62
			bcs Finish

			inc Score + 1

			jsr SOUND.Tick

			lda #Start_Y
			sta Y_Pos + 1


		Finish:

			//dec $d020

			rts


	}

	FrameUpdate: {

		Playing:

		//inc $d020

		jsr Control
		jsr AI
		jsr Collisions
		jsr KnockBack
		jsr CheckFrame
		jsr CheckSpeed

		jsr UpdateSprites
		jsr DisplayScore
		jsr GameTimer


		//dec $d020

		rts
	}




}