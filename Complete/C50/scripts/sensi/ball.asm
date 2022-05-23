BALL: {


	* = $032a  "Game"

	.label FrameTime = 5
	.label Gravity = 40
	.label Drag = 3
	.label GroundDrag = 7

	.label Goalline = 95
	.label BarHeight = 13
	.label AdBoards = 68
	.label Net = 82

	.label LeftPostLeft = 147
	.label LeftPostRight = 151

	.label MiddleOfGoal = 183

	.label RightPostLeft = 215
	.label RightPostRight = 220

	.label BarHeightBottom = 11
	.label BarHeightTop = 13
	.label GoalHeight = 9

	.label StrikerPointer = 56


	.label PowerBarRow = 24


	.label PowerPerBar = 10

	.label PowerBarLength = 96

	.label PowerBarMax = 100
	.label PowerPerTick = 30
	.label LoftPerTick = 50
	.label SwervePerTick = 2

	.label WallHeight = 13
	.label WallWidth = 27


	.label AimWidth = 84
	.label AimWidthHalf = AimWidth / 2


	Reset: {

		
		lda #0
		sta VIC.SPRITE_COLOR_7
		sta ZP.BallFrame
		sta ZP.BallMode	
   		sta ZP.GameMode
   		sta ZP.ScoreToAdd

		lda #FrameTime
		sta ZP.BallFrameTimer

		lda #1
		sta VIC.SPRITE_COLOR_6
		sta VIC.SPRITE_COLOR_4

		lda #StrikerPointer 
		sta SPRITE_POINTERS + 0

		lda #53
		sta SPRITE_POINTERS +4

		lda #YELLOW
		sta VIC.SPRITE_COLOR_0

		jsr RandomPosition

		rts
	}





	RandomPosition: {

		lda #0
		sta ZP.BallPositionX_MSB
		sta ZP.PowerBarLevel
		sta ZP.LoftLevel
		sta ZP.SwerveLevel
		sta ZP.AimMoveDirection
		sta ZP.BallHeight
		sta ZP.BallHeight_SUB
		sta ZP.BallSpeedFW
		sta ZP.BallSpeedFW_SUB
		sta ZP.BallSpeedUD_SUB
		sta ZP.BallSpeedUD
		sta ZP.BallSpeedLR_SUB
		sta ZP.BallSpeedLR

		lda #30
		sta ZP.Cooldown

		lda #AimWidthHalf
		sta ZP.LeftRightAim

		Retry:

			jsr RANDOM.Get
			and #%11111111
			cmp #172
			bcs Retry
			clc
			adc #98
			sta ZP.BallPositionX_LSB
			
			bcc NoWrap

			inc ZP.BallPositionX_MSB
			inc ZP.EndID

		NoWrap:

			lda ZP.BallPositionX_LSB
			sec 
			sbc #5
			sta VIC.SPRITE_0_X

			bcs NoWrap2

			dec ZP.EndID

		NoWrap2:

			lda ZP.EndID
			bne MSB

		NoMSB:

			lda VIC.SPRITE_MSB
			and #%11111110
			sta VIC.SPRITE_MSB
			jmp Skip

		MSB:

			lda VIC.SPRITE_MSB
			ora #%00000001
			sta VIC.SPRITE_MSB

		Skip:


			jsr RANDOM.Get
			and #%00111111
			cmp #58
			bcs Skip

			clc
			adc #183
			sta ZP.BallPositionY

			sec
			sbc #7
			sta VIC.SPRITE_0_Y
		
			jsr SetupWall

			lda #BALL_MODE_AWAIT_FIRE
			sta ZP.BallMode

		rts


	}



	

	Frame: {

	
		lda ZP.BallSpeedFW
		clc
		adc ZP.BallSpeedUD
		clc
		adc ZP.BallSpeedLR
		clc
		adc ZP.BallSpeedFW_SUB
		bcs BallMoving
		bne BallMoving

		Stop:

		lda ZP.BallMode
		cmp #BALL_MODE_IN_PLAY
		bne Finish

	//	.break

		lda #BALL_MODE_STOPPED
		sta ZP.BallMode
		
		lda #100
		sta ZP.Cooldown
		rts

		BallMoving:

		lda ZP.BallFrameTimer
		beq Ready

		dec ZP.BallFrameTimer
		rts

		Ready:

		lda #FrameTime
		sta ZP.BallFrameTimer

		inc ZP.BallFrame

		Finish:

	


		NotComplete:

		rts
	}

	* = $07e8

.encoding "screencode_upper"
	Middle:	 .text 	"PTS 0000"
	TopRight: .text "GOALS 00"

	
	



* = $801 "Game code"	
	
		

	AddGoal: {
    	
		Scoring:

			ldx #2

			Loop:

				inc SCREEN_RAM + 34, x
				lda SCREEN_RAM + 34, x
				cmp #58
				bcc Okay

				lda #48
				sta SCREEN_RAM + 34, x

				dex
				bne Loop

			Okay:

    	Finish:



    	rts
    }	


	Takeaway: {

		ldx #2

		Loop:

			dec SCREEN_RAM + 8, x
			lda SCREEN_RAM + 8, x
			cmp #48
			bcs Okay


			lda #57
			sta SCREEN_RAM + 8, x

			dex
			bne Loop


		Okay:

		lda SCREEN_RAM + 9
		clc
		adc SCREEN_RAM + 10
		cmp #96
		bne NotComplete

		Completed:

			lda #RED
			sta VIC.BORDER_COLOR

			lda #1
			sta ZP.GameMode

			lda #150
			sta ZP.Cooldown

			rts
			
		
		
		NotComplete:

		jsr RandomPosition

		rts


	}


	
	Update: {

		lda ZP.BallMode
		cmp #BALL_MODE_IN_PLAY
		beq NotStopped

		cmp #BALL_MODE_STOPPED
		bne NotStopped

		lda ZP.Cooldown
		beq Restart

		dec ZP.Cooldown
		rts

		Restart:

			jsr Takeaway
			rts

		NotStopped:

		jsr UpDown
		jsr ForwardBack
		jsr Swerve
		jsr LeftRight

		NoMove:

		jsr Position
		jsr Frame

		Aim:

			lda ZP.BallMode
			cmp #BALL_MODE_AWAIT_FIRE
			bne Finish

			lda ZP.AimMoveDirection
			beq MoveLeft	

		MoveRight:

			lda ZP.LeftRightAim
			clc
			adc #3
			sta ZP.LeftRightAim

			cmp #AimWidth
			bcc Show

			dec ZP.AimMoveDirection
			jmp Show

		MoveLeft:
			
			lda ZP.LeftRightAim
			sec
			sbc #3
			sta ZP.LeftRightAim

			bne Show
			
			inc ZP.AimMoveDirection
	
		Show:

			lda VIC.SPRITE_6_Y
			sec
			sbc #30
			sta VIC.SPRITE_4_Y

			lda VIC.SPRITE_6_X
			sec
			sbc #AimWidthHalf
			clc
			adc ZP.LeftRightAim
			sta VIC.SPRITE_4_X

			cmp #57
			bcc MSB

		NoMSB:

			lda VIC.SPRITE_MSB
			and #%11101111
			sta VIC.SPRITE_MSB
			rts

		MSB:

			lda VIC.SPRITE_MSB
			ora #%00010000
			sta VIC.SPRITE_MSB
			rts

		Finish:

		lda #0
		sta VIC.SPRITE_4_Y
		rts
	}



		

	CalculateScore: {

		ldx #0
		jsr Crash

		jsr AddGoal

		CheckX:

			lda ZP.BallPositionX_LSB
			cmp VIC.SPRITE_5_X
			bcc LeftOfTarget

			RightOfTarget:

				sec
				sbc VIC.SPRITE_5_X
				sta ZP.Amount	
				jmp CheckY


			LeftOfTarget:

				
				lda VIC.SPRITE_5_X
				sec
				sbc ZP.BallPositionX_LSB
				sta ZP.Amount
			

		CheckY:		

			lda ZP.BallPositionY
			cmp VIC.SPRITE_5_Y
			bcc AboveTarget


		BelowTarget:

			sec
			sbc VIC.SPRITE_5_Y
			clc
			adc ZP.Amount
			asl
			sta ZP.Amount	

			jmp ChangeScore

		AboveTarget:

			lda VIC.SPRITE_5_Y
			sec
			sbc ZP.BallPositionY
			clc
			adc ZP.Amount
			asl
			sta ZP.Amount

		ChangeScore:

		lda #120
		sec
		sbc ZP.Amount
		sta ZP.ScoreToAdd


		rts
	}


	SetupWall: {

		lda #0
		sta ZP.EndID /// msb
		sta ZP.WallJump

		lda #175
		sta ZP.CurrentID

		lda ZP.BallPositionX_MSB
		beq Easy


		MSB2:

			lda #1
			sta ZP.EndID

			lda #255
			sec
			sbc #MiddleOfGoal
			clc
			adc ZP.BallPositionX_LSB
			lsr
			sta ZP.Amount

			lda ZP.BallPositionX_LSB
			sec
			sbc ZP.Amount
			sta ZP.Amount

			bcs NoWrap

			dec ZP.EndID

		NoWrap:


			jmp Place


		Easy:


			lda ZP.BallPositionX_LSB
			cmp #MiddleOfGoal
			bcc BallToLeft
		

		BallToRight:

			sec
			sbc #MiddleOfGoal
			lsr
			clc
			adc #MiddleOfGoal
			sta ZP.Amount
			jmp Place

		BallToLeft:

			lda #MiddleOfGoal
			sec
			sbc ZP.BallPositionX_LSB
			lsr
			clc
			adc ZP.BallPositionX_LSB
			sta ZP.Amount

			lda #189
			sta ZP.CurrentID


		Place:

		lda ZP.Amount
		sec
		sbc #8
		sta ZP.Amount
		sta ZP.WallPositionX

		lda ZP.BallPositionY
		sec
		sbc #52
		sta ZP.WallPositionY


		ldx #0
		ldy #0

		Loop:

			lda ZP.EndID
			beq NoMSB

			MSB:

				lda VIC.SPRITE_MSB
				ora MSB_On + 1, x
				sta VIC.SPRITE_MSB
				jmp Skip

			NoMSB:

				lda VIC.SPRITE_MSB
				and MSB_Off + 1, x
				sta VIC.SPRITE_MSB

			Skip:

			lda ZP.Amount
			sta VIC.SPRITE_1_X, y
			clc
			adc #9
			sta ZP.Amount

			lda ZP.EndID
			adc #0
			sta ZP.EndID


			jsr RANDOM.Get
			and #%000000001
			clc
			adc ZP.BallPositionY
			sec
			sbc #62
			sta VIC.SPRITE_1_Y, y

			lda #55
			sta SPRITE_POINTERS +1, x

			lda #CYAN
			sta SPRITE_COLOR_1, x

			inx
			iny
			iny

			cpx #3
			bcc Loop


		Target:

			lda #52
			sta SPRITE_POINTERS + 5

			jsr RANDOM.Get
			and #%00000111
			tax

			lda CornerPositionY, x
			sta VIC.SPRITE_5_Y

			lda CornerPositionX, x
			bne Okay

			lda #153
			Okay:
			sta VIC.SPRITE_5_X

			lda #YELLOW
			sta VIC.SPRITE_COLOR_5



		rts
	}



	Launch: {

		ldx #1
		jsr Crash

		lda #BALL_MODE_IN_PLAY
		sta ZP.BallMode

		lda #0
		sta ZP.BallFalling
		sta ZP.BallInGoal

		lda #30
		sta ZP.Cooldown

		Power:

			ldx ZP.PowerBarLevel

			Loop:

				lda ZP.BallSpeedFW_SUB
				clc
				adc #PowerPerTick
				sta ZP.BallSpeedFW_SUB

				bcc NoWrap

				inc ZP.BallSpeedFW

				NoWrap:

				dex
				bne Loop

		Loft:

			ldx ZP.LoftLevel
			beq Direction

			
			Loop2:

				lda ZP.BallSpeedUD_SUB
				clc
				adc #LoftPerTick
				sta ZP.BallSpeedUD_SUB

				bcc NoWrap2

				inc ZP.BallSpeedUD

				NoWrap2:

				dex
				bne Loop2


		Direction:

			lda #1
			sta ZP.BallMovingLeft
			sta ZP.BallForward

			lda ZP.LeftRightAim
			cmp #AimWidthHalf
			bcc Left

			Right:

			sec
			sbc #AimWidthHalf
			dec ZP.BallMovingLeft
			jmp Now

			Left:

			lda #AimWidthHalf
			sec 
			sbc ZP.LeftRightAim
			

			Now:

			tax	

			Loop3:

				lda ZP.BallSpeedLR_SUB
				clc
				adc #18
				sta ZP.BallSpeedLR_SUB

				bcc NoWrap3

				inc ZP.BallSpeedLR

				NoWrap3:

				dex
				bne Loop3

		rts

	}





	ForwardBack: {


		Drag:
			lda ZP.BallHeight
			bne NoWrap6

			lda ZP.BallSpeedFW_SUB
			sec
			sbc #GroundDrag
			sta ZP.BallSpeedFW_SUB

			bcs NoWrap6

			dec ZP.BallSpeedFW

			lda ZP.BallSpeedFW
			bpl NoWrap6

			lda #0
			sta ZP.BallSpeedFW_SUB
			sta ZP.BallSpeedFW

			NoWrap6:

			lda ZP.BallForward
			bne Forward

			jmp Backward


		Forward:

				lda ZP.BallPositionY_SUB
				sec
				sbc ZP.BallSpeedFW_SUB
				sta ZP.BallPositionY_SUB

				bcs NoWrap2

				dec ZP.BallPositionY

				NoWrap2:

				lda ZP.BallPositionY
				sec
				sbc ZP.BallSpeedFW
				sta ZP.BallPositionY

				

				WallCheck:

					lda ZP.BallPositionX_MSB
					bne BoardCheck

					lda ZP.BallHeight
					cmp #10
					bcs BoardCheck

					lda ZP.BallPositionY
					sec
					sbc ZP.WallPositionY
					cmp #5
					bcs BoardCheck

					lda ZP.BallPositionX_LSB
					sec
					sbc ZP.WallPositionX
					cmp #WallWidth
					bcs BoardCheck

					jmp StopBall



				BoardCheck:

					lda ZP.BallPositionY
					cmp #AdBoards
					bcs GoalCheck

					jmp StopBall

				GoalCheck:
				
					cmp #Goalline
					bcs NoGoal

					lda ZP.BallPositionX_LSB
					cmp #LeftPostLeft
					bcc NoGoal

					cmp #LeftPostRight
					bcc HitBar

					cmp #RightPostRight
					bcs NoGoal

					cmp #RightPostLeft
					bcs HitBar

					Goal:

						lda ZP.BallHeight
						cmp #BarHeightTop
						bcs NoGoal

						ldx ZP.BallInGoal
						bne AlreadyIn

						ldx #1
						stx ZP.BallInGoal

						jsr CalculateScore

						AlreadyIn:

						lda ZP.BallPositionY
						cmp #Net
						bcs NoGoal

						lda ZP.BallHeight
						cmp #BarHeightBottom
						bcc GoalScored

						HitBar:

							ldx #1
							jsr Crash
	
							lda #0
							sta ZP.BallForward
							sta ZP.BallSwerve
							sta ZP.BallSpeedLR

							lda #1
							sta ZP.BallSpeedFW
							
							jsr RANDOM.Get
							sta ZP.BallSpeedFW_SUB

							lda ZP.BallSpeedLR_SUB
							lsr
							lsr
							lsr
							sta ZP.BallSpeedLR_SUB

							rts

					GoalScored:

					jmp StopBall

					NoGoal:

						

				jmp Finish



		Backward:

			
				lda ZP.BallPositionY_SUB
				clc
				adc ZP.BallSpeedFW_SUB
				sta ZP.BallPositionY_SUB

				bcc NoWrap3

				inc ZP.BallPositionY

				NoWrap3:

				lda ZP.BallPositionY
				clc
				adc ZP.BallSpeedFW
				sta ZP.BallPositionY


			

		Finish:

		//	lda ZP.BallInGoal
		//	sta $d020

			rts

	}



	Controls: {

		OkayToMove:

			lda ZP.Cooldown
			beq Ready

			dec ZP.Cooldown
			rts

		Ready:

			lda $dc00
			sta ZP.Amount

		 CheckFire:

		 	and #JOY_FIRE
		 	bne	NoFire

		 	FirePressed:


			 	lda ZP.BallMode
			 	cmp #BALL_MODE_AWAIT_FIRE
			 	beq StartPower

			 	cmp #BALL_MODE_POWERING
			 	beq IncreasePower

			 	rts

			 	IncreasePower:

				 	inc ZP.PowerBarLevel
				 	lda ZP.PowerBarLevel
				 	sta SCREEN_RAM
				 	cmp #PowerBarMax
				 	bcc CheckDown
				 	
				 	lda #PowerBarMax
				 	sta ZP.PowerBarLevel

			 	StartPower:

				 	lda #BALL_MODE_POWERING
				 	sta ZP.BallMode
				 	rts


		CheckDown:

			lda ZP.BallMode
			cmp #BALL_MODE_POWERING
			bne CheckLeft

			lda ZP.Amount
			and #JOY_DOWN
			bne CheckLeft

			Down:

				inc ZP.LoftLevel

			jmp Finish

		CheckLeft:	

			lda ZP.BallPositionY
 			cmp #120
 			bcc Finish


			lda ZP.BallMode
			cmp #BALL_MODE_IN_PLAY
			beq Okay

			cmp #BALL_MODE_POWERING
			beq Okay

			jmp Finish

			Okay:

				lda ZP.Amount
				and #JOY_LEFT
				bne CheckRight

			Left:

				jsr MAIN.IncreaseSwerve
				lda #0
				sta ZP.BallSwerveLeft

				jmp Finish

		CheckRight:

			lda ZP.Amount
			and #JOY_RIGHT
			bne Finish

			Right:

				jsr MAIN.IncreaseSwerve
				lda #1
				sta ZP.BallSwerveLeft
				jmp Finish

		NoFire:

		lda ZP.BallMode
		cmp #BALL_MODE_IN_PLAY
		beq CheckLeft

		cmp #BALL_MODE_POWERING
		bne Finish


		jmp Launch


		Finish:


		rts
	
 	}


 


	Swerve: {

		lda ZP.BallSpeedFW
		beq Finish

		lda ZP.BallHeight
		beq Finish

		lda ZP.BallSwerve
		beq Finish

	//	lsr
		//lsr
		lsr
		sta ZP.Amount

		dec ZP.BallSwerve

		ldx ZP.BallSwerveLeft
		beq Left


		Right:

			lda ZP.BallMovingLeft
			beq IncreaseSpeed
			jmp DecreaseSpeed


		Left:	

			lda ZP.BallMovingLeft
			beq DecreaseSpeed

		IncreaseSpeed:

			lda ZP.BallSpeedLR_SUB
			clc
			adc ZP.Amount
			sta ZP.BallSpeedLR_SUB

			bcc NoWrap1

			inc ZP.BallSpeedLR

			NoWrap1:

				jmp Finish


		DecreaseSpeed:

			lda ZP.BallSpeedLR_SUB
			sec 
			sbc ZP.Amount
			sta ZP.BallSpeedLR_SUB

			bcs NoWrap2

			dec ZP.BallSpeedLR
			lda ZP.BallSpeedLR
			bpl Finish

			lda #0
			sta ZP.BallSpeedLR

			lsr ZP.BallMovingLeft
			bcs IsOne

			inc ZP.BallMovingLeft

			IsOne:

			// beq SwitchLeft

			// lda #0
			// sta ZP.BallMovingLeft
			// jmp Finish

			// SwitchLeft:

			// lda #1
			// sta ZP.BallMovingLeft


			NoWrap2:

		Finish:


		rts
	}



	LeftRight: {


		Drag:

			lda ZP.BallHeight
			bne NoWrap6

			lda ZP.BallSpeedLR_SUB
			sec
			sbc #GroundDrag
			sta ZP.BallSpeedLR_SUB

			bcs NoWrap6

			dec ZP.BallSpeedLR

			lda ZP.BallSpeedLR
			bpl NoWrap6

			lda #0
			sta ZP.BallSpeedLR_SUB
			sta ZP.BallSpeedLR
			rts


		NoWrap6:

			lda ZP.BallMovingLeft
			beq Right
		Left:

			lda ZP.BallInGoal
			beq NoGoal1

			lda ZP.BallPositionX_LSB
			cmp #LeftPostRight
			bcs Okay22

			rts

			Okay22:

			NoGoal1:


			lda ZP.BallPositionX_SUB
			sec
			sbc ZP.BallSpeedLR_SUB
			sta ZP.BallPositionX_SUB

			lda ZP.BallPositionX_LSB
			sbc #0
			sta ZP.BallPositionX_LSB

			lda ZP.BallPositionX_MSB
			sbc #0
			sta ZP.BallPositionX_MSB

			lda ZP.BallPositionX_LSB
			sec
			sbc ZP.BallSpeedLR
			sta ZP.BallPositionX_LSB

			lda ZP.BallPositionX_MSB
			sbc #0
			sta ZP.BallPositionX_MSB

			bpl Okay
			
			lda #0
			sta ZP.BallPositionX_MSB
			sta ZP.BallPositionX_LSB
			sta ZP.BallSpeedLR
			sta ZP.BallSpeedLR_SUB

			Okay:


			rts


		Right:

			lda ZP.BallInGoal
			beq NoGoal2

			lda ZP.BallPositionX_LSB
			cmp #RightPostLeft
			bcc Okay3

			rts

			Okay3:

			NoGoal2:

			lda ZP.BallPositionX_SUB
			clc
			adc ZP.BallSpeedLR_SUB
			sta ZP.BallPositionX_SUB

			lda ZP.BallPositionX_LSB
			adc #0
			sta ZP.BallPositionX_LSB

			lda ZP.BallPositionX_MSB
			adc #0
			sta ZP.BallPositionX_MSB

			lda ZP.BallPositionX_LSB
			clc
			adc ZP.BallSpeedLR
			sta ZP.BallPositionX_LSB

			lda ZP.BallPositionX_MSB
			adc #0
			sta ZP.BallPositionX_MSB

			cmp #2
			bcc Okay2

			lda #0
			sta ZP.BallPositionX_MSB
			sta ZP.BallPositionX_LSB
			sta ZP.BallSpeedLR
			sta ZP.BallSpeedLR_SUB

			Okay2:

			rts

	}






	UpDown: {

		
		lda ZP.BallFalling
		beq Rising

		Falling:

			lda ZP.BallSpeedUD_SUB
			clc
			adc #Gravity
			sta ZP.BallSpeedUD_SUB

			bcc NoWrap1

			inc ZP.BallSpeedUD

			NoWrap1:

				lda ZP.BallHeight_SUB
				sec
				sbc ZP.BallSpeedUD_SUB
				sta ZP.BallHeight_SUB

				bcs NoWrap2

				dec ZP.BallHeight

			NoWrap2:

				lda ZP.BallHeight
				sec
				sbc ZP.BallSpeedUD
				sta ZP.BallHeight

				bpl StillFalling

				lda #0
				sta ZP.BallFalling
				sta ZP.BallHeight
				sta ZP.BallSpeedUD_SUB

				 // lda ZP.BallSpeedUD_SUB
				 // sec
				 // sbc #200
				 // sta ZP.BallSpeedUD_SUB

				 bcs NoWrap5

				 dec ZP.BallSpeedUD
				 lda ZP.BallSpeedUD
				 bpl NoWrap5

				 lda #0
				 sta ZP.BallSpeedUD
				 sta ZP.BallSpeedUD_SUB

				 NoWrap5:


			StillFalling:

				jmp Finish




		Rising:

			
			lda ZP.BallSpeedUD_SUB
			sec
			sbc #Gravity
			sta ZP.BallSpeedUD_SUB

			bcs NoWrap3

			dec ZP.BallSpeedUD

			lda ZP.BallSpeedUD
			bpl NoWrap3

			StartFalling:

				lda #1
				sta ZP.BallFalling

				lda #0
				sta ZP.BallSpeedUD
				sta ZP.BallSpeedUD_SUB

				jmp Finish

			NoWrap3:

				lda ZP.BallHeight_SUB
				clc
				adc ZP.BallSpeedUD_SUB
				sta ZP.BallHeight_SUB

				bcc NoWrap4

				inc ZP.BallHeight

			NoWrap4:

				lda ZP.BallHeight
				clc
				adc ZP.BallSpeedUD
				sta ZP.BallHeight

				ldx ZP.BallInGoal
				beq Finish

				cmp #GoalHeight
				bcc Finish

				lda #GoalHeight
				sta ZP.BallHeight

				lda #1
				sta ZP.BallFalling


		Finish:


		rts
	}




	FX_AD:
	.byte %10111011,  %00000011
	FX_SR:
	.byte %00000100,  $01
	FX_HI:
	.byte $20,  $01
	FX_LO:
	.byte $20,  $12
	FX_WF:
	.byte $81, $81



	Crash: {

	   	lda #$08
		sta $d404

	    // Crank up volume
	    lda #$08
	    sta $d418
	    // ADSR Envelope Channel #1
	    lda FX_AD,x
	    sta $d405
	    lda FX_SR,x
	    sta $d406
	    // Frequency Channel #1
	    lda FX_HI,x
	    sta $d401
	    lda FX_LO,x
	    sta $d400
	    // Control Register Channel #1
	    lda FX_WF,x
	    sta $d404

	    rts

	}
	



	* = $232 "Bits of code"




	Position: {

		lda ZP.BallFrame
		and #%00000001
		clc
		adc #53
		sta SPRITE_POINTERS + 6
		sta SPRITE_POINTERS + 7


		lda ZP.BallPositionX_LSB
		sta VIC.SPRITE_6_X
		clc
		adc #2
		sta VIC.SPRITE_7_X

		lda ZP.BallPositionY
		sta VIC.SPRITE_7_Y
		sec
		sbc ZP.BallHeight
		sta VIC.SPRITE_6_Y

		inc VIC.SPRITE_7_Y
		inc VIC.SPRITE_7_Y

		lda ZP.BallPositionX_MSB
		beq NoMSB


		MSB:

			lda VIC.SPRITE_MSB
			ora #%11000000
			sta VIC.SPRITE_MSB
			jmp Finish

		NoMSB:

			lda VIC.SPRITE_MSB
			and #%00111111
			sta VIC.SPRITE_MSB

		Finish:



		rts
	}

	StopBall: {


		lda #0
		sta ZP.BallForward
		sta ZP.BallSpeedFW
		sta ZP.BallSwerve
		sta ZP.BallSpeedLR

		jsr RANDOM.Get
		and #%00111111
		adc #10
		sta ZP.BallSpeedFW_SUB

		lda ZP.BallSpeedLR_SUB
		lsr
		lsr
		sta ZP.BallSpeedLR_SUB

		
	
		rts
	}


	
	CornerPositionX:	.byte 153, 153, 153, 183, 183, 212, 212, 212
	CornerPositionY:	.byte 78, 83, 88, 78, 88, 78, 83, 88

	MSB_On:		.byte %00000001, %00000010, %00000100,%00001000,%00010000,%00100000,%01000000,%10000000
	MSB_Off:	.byte %11111110, %11111101, %11111011,%11110111,%11101111,%11011111,%10111111,%01111111

	

	 Colour: {

    	ldx #250

    	Loop:

	    	lda SCREEN_RAM - 1, x
	    	sec 
	    	sbc #200
	    	tay
	    	lda CHAR_COLORS, y
	    	sta COLOR_RAM - 1, x

	    	lda SCREEN_RAM + 249, x
	    	sec 
	    	sbc #200
	    	tay
	    	lda CHAR_COLORS, y
	    	sta COLOR_RAM + 249, x

	    	lda SCREEN_RAM + 499, x
	    	sec 
	    	sbc #200
	    	tay
	    	lda CHAR_COLORS, y
	    	sta COLOR_RAM + 499, x

	    	lda SCREEN_RAM + 749, x
	    	sec 
	    	sbc #200
	    	tay
	    	lda CHAR_COLORS, y
	    	sta COLOR_RAM + 749, x

	    	// cpx #214
	    	// bcs Nope

	    	// lda #208
	    	// sta SCREEN_RAM + 789, x

	     	Nope:

	    	cpx #41
	     	bcs Nope2

	  		lda #14
			sta COLOR_RAM + 39, x 

			lda #5
			sta COLOR_RAM - 1, x 

			Nope2:


	    	dex
	    	bne Loop


	    lda #1
	    sta SCREEN_RAM



    	rts
    }

    TopLeft: .text 	"SHOTS 20"
	


   // * = $07f8
	


}