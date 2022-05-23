GYPSY: {

	* = $e000 "Gypsy Code"

	.label HeadPointer = 74
	.label LeftArm = 79
	.label RightArm = 75
	.label LeftLeg = 83
	.label RightLeft = 87
	.label FrameTime = 5
	.label BallPointer = 91
	.label ControlCooldown = 10
	.label NumberStart = 35
	.label GAME_STATUS_MENU = 0
	.label GAME_STATUS_PLAY = 1
	.label GAME_STATUS_DEAD = 2
	.label GAME_STATUS_NEXT = 3
	.label GAME_STATUS_OVER = 4
	.label FlashTime = 12
	.label MaxYSpeed = 2
	.label MaxYSpeed_SUB = 150
	.label BirdY = 234
	.label MinX = 46
	.label MaxX = 251
	.label MinBallX = 13
	.label MaxBallX = 249
	.label MaxPlayerSpeed = 4
	.label SpeedChangeTime = 7
	.label SpeedReduceTime = 1
	.label MaxLeftSpeed = 252
	.label MaxRightSpeed = 4
	.label MaxFallingSpeed = 4
	.label GravityForce = 10
	.label BALL_STATUS_DEAD= 0
	.label BALL_STATUS_OFF_SCREEN = 1
	.label BALL_STATUS_ON_SCREEN = 2
	.label StartX_SUB = 50
	.label MaxBallHeadDistance = 5
	.label MaxFlickDistance = 18
	.label Lives = 3
	.label PosY = 219
	.label FlashBigTime = 24


	Gypsy: 			.byte 0, 0, 0
	PosX_LSB: 		.byte 150
	PosX_MSB: 		.byte 0	

	LivesLeft:		.byte 1, 3, 3, 3
	NumPlayers:		.byte 1
	CurrentPlayer:	.byte 0

	Lag:			.byte 0
	BirdPointers:	.byte 92, 95

	Scores:			.byte 0, 0, 0 
	ScoreHigh:	.byte 0, 0, 0, 0
	ScoreMed:	.byte 0, 0, 0, 0
	ScoreLow:	.byte 0, 0, 0, 0
	ExtendedPlay:	.byte 0, 0, 0, 0
	FlashText:	.byte 0
	FlashBigTimer:	.byte 0
	FlashTextOn:	.byte 0

	YOffsets:		.byte -6, -6, 15, 15
	Frames:			.byte 0, 0, 0, 3
	StartPointer:	.byte 79, 75, 83, 87
	XOffsets:		.byte -20, 4, -20, 4

	LegCounter:		.byte FrameTime
	ArmCounter:		.byte 255, 255

	FrameOrder:		.byte 0, 1, 2, 3, 2, 1
	Cooldown:		.byte 0

	Ball_X_LSB:			.byte 150, 190, 255, 220
	Ball_X_MSB:			.byte 0, 0, 0, 0
	Ball_X_SUB:			.fill 4, 0
	Ball_Y:				.byte 150, 190, 130, 210
	Ball_Y_SUB:			.fill 4, 0
	Ball_X_Speed:		.fill 4, 0
	Ball_X_Speed_SUB:	.fill 4, 0
	Ball_Y_Speed:		.fill 4, 0
	Ball_Y_Speed_SUB:	.fill 4, 0
	Ball_Status:		.byte 0, 0, 0, 0
	Ball_Falling:		.byte 1, 1, 1, 1
	Ball_GoingRight:	.byte 0, 0, 0, 0
	GameStatus:			.byte 0

	ArmFrameOrder:		.byte 0, 2, 3, 2, 1




	
	BirdX:		.byte 160
	BirdDirection:	.byte 0
	BirdFrame:	.byte 0
	BirdTimer:	.byte 0
	

	ScoreAddresses:	.word SCREEN_RAM + 129, SCREEN_RAM + 169, SCREEN_RAM + 146, SCREEN_RAM + 186, SCREEN_RAM + 593
	ColourAddresses:	.word COLOR_RAM + 129, COLOR_RAM + 169, COLOR_RAM + 146, COLOR_RAM + 186, COLOR_RAM + 593

	ScoreOn:	.byte 1
	FlashTimer:	.byte 0




	ScoreLookupLow:		.byte $5, $50, $00, $00
	ScoreLookupHigh:		.byte $0, $00, $01, $02

	PlayerSpeed:		.byte 0
	PlayerDirection:	.byte 0
	SpeedChangeTimer:	.byte 3
	SpeedReduceTimer:	.byte 0


	SpeedToLag:			.byte -2, -2, -2, -1, -1, 0, 1, 1, 2, 2, 2



	FeedXPositions:		.byte 123, 125, 141, 143
	FeedYPositions:		.byte 98, 100, 100, 98
	StartStatus:		.byte 1, 2, 1, 2
	StartRight:			.byte 1, 1, 0, 0

	BallsInPlay:		.byte 0	
	Credits:			.byte 0

						//    0    1   2     3    4    5    6    7    8    9    10    11
	Distance_To_X:		.fillword MaxBallHeadDistance, (i * 10) + 10
						.fillword MaxFlickDistance - MaxBallHeadDistance, (i * 9) + 5

	//Distance_To_X:		.byte 000, 000, 000, 000, 000, 000, 000, 000, 000, 000





	Show: {

			//Set VIC BANK 3, last two bits = 00

		lda #0
		jsr sid.init

		lda #0
		sta IRQ.Mode
		sta PlayerSpeed
		sta CurrentPlayer
		sta PlayerDirection
		sta Lag
		sta BallsInPlay

		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y
	
		jsr SetupVIC
		jsr SetupGameColours
		jsr DRAW.GypsyScreen
		jsr ColourText
		//jsr SetupSprites



		lda #GAME_STATUS_MENU
		sta GameStatus

		lda #Lives
		sta LivesLeft
		sta LivesLeft + 1
		sta LivesLeft + 2
		sta LivesLeft + 3

		ldx #0
		lda #0

		Loop2:

			sta ScoreHigh, x
			sta ScoreMed, x
			sta ScoreLow, x
			sta ExtendedPlay, x
			sta Ball_Status, x

			inx
			cpx #4
			bcc Loop2



		lda #1
		sta Credits
		sta FlashTextOn

		jsr DrawLives
		jsr DrawCredits

		jsr DrawHighScore

		jmp Loop

	}




	Score: {

		ldy CurrentPlayer

		ldx BallsInPlay
		dex
		sed

		lda ScoreLow, y
		clc
		adc ScoreLookupLow, x
		sta ScoreLow, y

		lda ScoreMed, y
		adc #0
		clc
		adc ScoreLookupHigh, x
		sta ScoreMed, y

		lda ScoreHigh, y
		adc #0
		sta ScoreHigh, y

		cld

		lda ExtendedPlay, y
		bne AlreadyAchieved

		lda ScoreMed, y
		cmp #$50
		bcc AlreadyAchieved

		lda #1
		sta ExtendedPlay, y

		AlreadyAchieved:
	
		ldx CurrentPlayer
		jsr DrawScore

		ldy CurrentPlayer

		lda ScoreHigh, y
		cmp Gypsy + 2
		bcc NotHigh
		beq CheckMed

		jmp Transfer

		CheckMed:

		lda ScoreMed, y
		cmp Gypsy + 1
		bcc NotHigh
		beq CheckLow

		jmp Transfer

		CheckLow:

			lda ScoreLow, y
			cmp Gypsy
			bcc NotHigh
		
		Transfer:

			lda ScoreHigh, y
			sta Gypsy + 2

			lda ScoreMed, y
			sta Gypsy + 1

			lda ScoreLow, y
			sta Gypsy

			jsr DrawHighScore


		NotHigh:


		rts
	}	



	DrawHighScore: {	

		lda #4
		asl
		tax
		lda ScoreAddresses, x
		sta ZP.ScoresAddress

		lda ScoreAddresses + 1, x
		sta ZP.ScoresAddress + 1


		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
		
		ScoreLoop:

			lda Gypsy,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {


			clc
			adc #NumberStart
			sta (ZP.ScoresAddress), y


			dey
			rts

		}



		rts
	}


	DrawScore: {	

		jsr GetScoreAddress

		ldx CurrentPlayer

		lda ScoreHigh, x
		sta Scores + 2

		lda ScoreMed, x
		sta Scores + 1

		lda ScoreLow, x
		sta Scores

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
		
		ScoreLoop:

			lda Scores,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {


			clc
			adc #NumberStart
			sta (ZP.ScoresAddress), y


			dey
			rts

		}



		rts
	}



	LaunchBall: {

		ldx BallsInPlay
		cpx #4
		bcc BallsLeft

		rts

		BallsLeft:

		lda #1
		sta FlashTextOn

		cpx #1
		bcc MakeOne

		dex
		lda Ball_Status, x
		inx

		cmp #1
		beq MakeTwo

		MakeOne:

		lda #1
		sta Ball_Status, x
		jmp Rest

		MakeTwo:

		lda #2
		sta Ball_Status, x

		Rest:


		lda FeedXPositions, x
		sta Ball_X_LSB, x

		lda FeedYPositions, x
		sta Ball_Y, x

		lda #1
		sta Ball_Falling, x
	
		sfx(SFX_BLOOP)

		lda StartRight, x
		sta Ball_GoingRight, x

		lda #0
		sta Ball_Y_Speed, x
		sta Ball_Y_Speed_SUB, x
		sta Ball_Y_SUB, x
		sta Ball_X_MSB, x
		sta Ball_X_Speed, x

		lda #StartX_SUB
		sta Ball_X_Speed_SUB, x


		inc BallsInPlay

		lda BallsInPlay
		cmp #4
		bcc Finish

		lda #0
		sta FlashTextOn


		Finish:




		rts
	}


	CheckFlick: {

		lda Ball_X_LSB, x
		clc
		adc #18
		bcc NoWrap

		lda #255


		NoWrap:

		sta ZP.Amount

		cmp PosX_LSB
		bcc BallLeft

		BallRight:

			sec
			sbc PosX_LSB
			cmp #MaxBallHeadDistance
			bcc Header

			cmp #MaxFlickDistance
			bcs NoHit

			pha

			lda #0
			sta Ball_GoingRight, x

			lda #FrameTime
			sta ArmCounter + 1

			pla

			jmp Hit

		BallLeft:

			lda PosX_LSB
			sec
			sbc ZP.Amount
			cmp #MaxBallHeadDistance
			bcc Header

			cmp #MaxFlickDistance
			bcs NoHit

			pha

			lda #1
			sta Ball_GoingRight, x

			lda #FrameTime
			sta ArmCounter

			pla

		Hit:



			jsr FlickBall
			rts

		Header:

			jsr HeadBall
			rts


		NoHit:



		rts
	}

	CheckHeader: {

		lda Ball_X_LSB, x
		clc
		adc #18
		bcc NoWrap

		lda #255

		NoWrap:

		sta ZP.Amount

		ldy PosX_LSB
	
		cmp PosX_LSB
		bcc BallLeft


		BallRight:

		sec
		sbc PosX_LSB
		cmp #MaxBallHeadDistance
		bcs NoHit

		pha

		lda #0
		sta Ball_GoingRight, x
		sta Frames + 1

		pla

		jmp Hit

		BallLeft:


		lda PosX_LSB
		sec
		sbc ZP.Amount
		cmp #MaxBallHeadDistance
		bcs NoHit

		pha

		lda #1
		sta Ball_GoingRight, x

		lda #0
		sta Frames

		pla

		Hit:

		jsr HeadBall

		
		NoHit:


		rts
	}

	HeadBall: {

		asl
		tay
		lda Distance_To_X, y
		sta Ball_X_Speed_SUB, x

		lda #1
		sta Ball_Y_Speed, x

		lda #190
		sta Ball_Y_Speed_SUB, x

		lda #0
		sta Ball_Falling, x

		lda #0
		sta Ball_X_Speed, x


		ldx #0
		sfxFromX()

	

		rts
	}


	FlickBall: {

		asl
		tay
		lda Distance_To_X, y
		sta Ball_X_Speed_SUB, x

		lda Distance_To_X + 1, y
		sta Ball_X_Speed, x

		lda #2
		sta Ball_Y_Speed, x

		lda #210
		sta Ball_Y_Speed_SUB, x

		lda #0
		sta Ball_Falling, x

		ldx #3
		sfxFromX()

		jsr Score

		Finish:


		rts
	}



	SetupBird: {

		lda #BirdY
		sta VIC.SPRITE_7_Y

		cmp #150
		bcc GoLeft

		GoRight:

			lda #0
			sta BirdDirection

			lda Ball_X_LSB, x
			clc
			adc #6
			sta VIC.SPRITE_7_X
			sta BirdX
			jmp Pointer

		GoLeft:

			lda #1
			sta BirdDirection

			lda Ball_X_LSB, x
			sec
			sbc #4
			sta VIC.SPRITE_7_X
			sta BirdX

		Pointer:


			ldx BirdDirection
			lda BirdPointers, x
			sta SPRITE_POINTERS + 7

			lda #YELLOW
			sta VIC.SPRITE_COLOR_7

			lda #0
			sta BirdFrame

			lda #FrameTime
			sta BirdTimer

		rts
	}


	BallLanded: {

		sfx(SFX_LAND)

		lda #GAME_STATUS_DEAD
		sta GameStatus

		lda Ball_X_LSB, x
		sta VIC.SPRITE_5_X

		lda Ball_Y, x
		sta VIC.SPRITE_5_Y

		lda #YELLOW
		sta VIC.SPRITE_COLOR_5

		jsr SetupBird

		lda #0
		sta FlashTimer
		sta VIC.SPRITE_6_Y

		lda #0
		sta ScoreOn

		inc FlashTextOn

		jsr FlashScore


		ldx CurrentPlayer
		dec LivesLeft, x
		
		jsr DrawLives
		inc LivesLeft, x

		rts
	}

	UpdateVertical: {


		lda Ball_Falling, x
		beq Rising


		Falling:

			lda Ball_Y_Speed_SUB, x
			clc
			adc #GravityForce
			sta Ball_Y_Speed_SUB, x

			lda Ball_Y_Speed, x
			adc #0
			sta Ball_Y_Speed, x

			lda Ball_Y_Speed, x
			cmp #MaxYSpeed
			bcc Okay

			lda Ball_Y_Speed_SUB, x
			cmp #MaxYSpeed_SUB
			bcc Okay

			lda #MaxYSpeed
			sta Ball_Y_Speed, x

			lda #MaxYSpeed_SUB
			sta Ball_Y_Speed_SUB, x

			Okay:


				lda Ball_Y_SUB, x
				clc
				adc Ball_Y_Speed_SUB, x
				sta Ball_Y_SUB, x

				lda Ball_Y, x
				adc #0
				clc
				adc Ball_Y_Speed, x
				sta Ball_Y, x

				cmp #213
				bcc NoHeader

				cmp #220
				bcs NoHeader

				jsr CheckHeader
				jmp Finish

			NoHeader:

				cmp #223
				bcc NoBounce	

				cmp #231
				bcs NoBounce

			Bounce:

			jsr CheckFlick
			jmp Finish

			NoBounce:
				
				cmp #240
				bcc Finish

				jsr BallLanded
				jmp Finish


		Rising:

			lda Ball_Y_Speed_SUB, x
			sec
			sbc #GravityForce
			sta Ball_Y_Speed_SUB, x

			lda Ball_Y_Speed, x
			sbc #0
			sta Ball_Y_Speed, x

			bpl NotFalling

			lda #1
			sta Ball_Falling, x

			lda #0
			sta Ball_Y_Speed, x
			sta Ball_Y_Speed_SUB, x
			jmp Finish


			NotFalling:

				lda Ball_Y_SUB, x
				sec
				sbc Ball_Y_Speed_SUB, x
				sta Ball_Y_SUB, x

				lda Ball_Y, x
				sbc #0
				sec
				sbc Ball_Y_Speed, x
				sta Ball_Y, x


		Finish:

		ldx ZP.X


		rts
	}

	UpdateHorizontal: {

		lda Ball_GoingRight, x
		beq Left


		Right:

	

			lda Ball_X_SUB, x
			clc
			adc Ball_X_Speed_SUB, x
			sta Ball_X_SUB, x

			lda Ball_X_LSB, x
			adc #0
			clc
			adc Ball_X_Speed, x
			sta Ball_X_LSB, x


			cmp #MaxBallX
			bcc NoBounce	

			Bounce:

				lda #0
				sta Ball_GoingRight, x

			NoBounce:

				jmp Finish


		Left:


			lda Ball_X_SUB, x
			sec
			sbc Ball_X_Speed_SUB, x
			sta Ball_X_SUB, x

			lda Ball_X_LSB, x
			sbc #0
			sec
			sbc Ball_X_Speed, x
			sta Ball_X_LSB, x

			cmp #MinBallX
			bcs Finish

			lda #1
			sta Ball_GoingRight, x

		Finish:





		rts
	}

	UpdateBalls: {

		ldx #0

		Loop:

			stx ZP.X

			lda Ball_Status, x
			beq EndLoop

			jsr UpdateVertical
			jsr UpdateHorizontal

			EndLoop:

				ldx ZP.X

				inx
				cpx #4
				bcc Loop




		rts
	}






	Control: {

		ldy #1


		CheckFire:

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq CheckLeft

			jsr LaunchBall


		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda PlayerSpeed
			bpl StartLeft

			lda SpeedChangeTimer
			beq ReadyToLeft

			NotReadyLeft:

				dec SpeedChangeTimer
				jmp Finish

			ReadyToLeft:

				lda PlayerSpeed
				cmp #MaxLeftSpeed
				beq Finish

				dec PlayerSpeed
				jmp Finish

			StartLeft:


				lda #255
				sta PlayerSpeed

				lda #SpeedChangeTime
				sta SpeedChangeTimer
				jmp Finish

		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq ReduceSpeed


			lda PlayerSpeed
			beq StartRight
			bmi StartRight

			lda SpeedChangeTimer
			beq ReadyToRight

			NotReadyRight:

				dec SpeedChangeTimer
				jmp Finish

			ReadyToRight:

				lda PlayerSpeed
				cmp #MaxRightSpeed
				beq Finish

				inc PlayerSpeed
				jmp Finish

			StartRight:

				lda #1
				sta PlayerSpeed

				lda #SpeedChangeTime
				sta SpeedChangeTimer
				jmp Finish

		ReduceSpeed:

			lda PlayerSpeed
			beq Finish

			lda SpeedReduceTimer
			beq Okay

			dec SpeedReduceTimer
			jmp Finish

			Okay:

			lda #SpeedReduceTime
			sta SpeedReduceTimer


			lda PlayerSpeed
			bmi GoingLeft

				dec PlayerSpeed
				jmp Finish

			GoingLeft:

				inc PlayerSpeed


		Finish:

		lda PlayerSpeed
		clc
		adc #5
		tax

		lda SpeedToLag, x
		sta Lag

		lda PlayerSpeed
		bne AddSpeed	

		rts

		AddSpeed:

		bmi LeftMove

		RightMove:

			lda PosX_LSB
			clc
			adc PlayerSpeed
			sta PosX_LSB

			bcs ClampRight
			jmp NoWrap

		LeftMove:

			lda PosX_LSB
			clc
			adc PlayerSpeed
			sta PosX_LSB

		NoWrap:

		cmp #MaxX
		bcs ClampRight

		cmp #MinX
		bcc ClampLeft

		rts

		ClampRight:

			lda #MaxX
			sta PosX_LSB
			rts

		ClampLeft:
			lda #MinX
			sta PosX_LSB
			rts

	}




	MoveBall: {










		rts
	}

	SetupVIC: {



		lda VIC.BANK_SELECT
		and #%11111100
		sta VIC.BANK_SELECT

		// multicolour mode off
		lda VIC.SCREEN_CONTROL_2
		and #%11101111
		sta VIC.SCREEN_CONTROL_2

		//$f800
		lda #%00001110
		sta VIC.MEMORY_SETUP




		rts
	}



	ColourText: {

		
		ldx #0

		Loop:
			lda #LIGHT_BLUE
			sta COLOR_RAM + 120, x
			sta COLOR_RAM + 160, x

			lda #GREEN
			sta COLOR_RAM + 40, x
			sta COLOR_RAM + 80, x

			inx
			cpx #32
			bcc Loop


		Column:

		ldx #0

		Loop2:

			lda #WHITE
			sta COLOR_RAM +72, x
			sta COLOR_RAM +112, x

			sta COLOR_RAM + 392, x
			sta COLOR_RAM + 432, x
			sta COLOR_RAM + 472, x

			lda #GREEN
			sta COLOR_RAM + 552, x
			sta COLOR_RAM + 592, x
			sta COLOR_RAM + 632, x


			lda #YELLOW
			
			sta COLOR_RAM + 192, x
			sta COLOR_RAM + 232, x
			sta COLOR_RAM + 272, x


			sta COLOR_RAM +752, x
			sta COLOR_RAM +792, x
			sta COLOR_RAM +872, x
			sta COLOR_RAM +912, x
			sta COLOR_RAM +952, x

			inx
			cpx #8
			bcc Loop2



		rts
	}

	SetupGameColours: {


		lda #BLACK
		sta VIC.BACKGROUND_COLOUR

		lda #BLACK
		sta VIC.BORDER_COLOUR



		rts

	
	}


	SetupSprites: {


		lda #HeadPointer
		sta SPRITE_POINTERS

		lda #PosY
		sta VIC.SPRITE_0_Y

		lda #%00000000
		sta VIC.SPRITE_MULTICOLOR	

		lda #%11111111
		sta VIC.SPRITE_ENABLE

		lda #WHITE
		sta VIC.SPRITE_COLOR_0
		sta VIC.SPRITE_COLOR_1
		sta VIC.SPRITE_COLOR_2
		sta VIC.SPRITE_COLOR_5
		sta VIC.SPRITE_COLOR_6

		lda #YELLOW
		sta VIC.SPRITE_COLOR_3
		sta VIC.SPRITE_COLOR_4
		sta VIC.SPRITE_COLOR_7

		lda #BallPointer
		sta SPRITE_POINTERS + 5
		sta SPRITE_POINTERS + 6


		lda BirdPointers
		sta SPRITE_POINTERS + 7

		lda #0
		sta VIC.SPRITE_7_Y
		sta Ball_Status
		sta Ball_Status + 1
		sta Ball_Status + 2
		sta Ball_Status + 3
		sta BallsInPlay

		lda BirdX
		sta VIC.SPRITE_7_X

		jsr PositionHead
		jsr PositionBody


		jsr LaunchBall

		rts


	}

	PositionBalls: {

		ldx #0
		ldy #0
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y

		stx ZP.Amount

		Loop:	

			stx ZP.X


			lda Ball_Status, x
			cmp #BALL_STATUS_DEAD
			beq EndLoop

			cmp #BALL_STATUS_ON_SCREEN
			bcc OffScreen

			dec Ball_Status, x

			lda Ball_X_LSB, x
			sta VIC.SPRITE_5_X, y

			lda Ball_Y, x
			sta VIC.SPRITE_5_Y, y

			lda #WHITE
			sta VIC.SPRITE_COLOR_5, x

			iny
			iny

			lda Ball_X_MSB, x
			beq NoMSB

			MSB:

				ldx ZP.Amount
				lda VIC.SPRITE_MSB
				ora DRAW.MSB_On + 5, x
				sta VIC.SPRITE_MSB

				inc ZP.Amount

				jmp EndLoop

			NoMSB:

				ldx ZP.Amount
				lda VIC.SPRITE_MSB
				and DRAW.MSB_Off + 5, x
				sta VIC.SPRITE_MSB

				inc ZP.Amount

				jmp EndLoop



			OffScreen:

				inc Ball_Status, x


			EndLoop:

				ldx ZP.X
				inx
				cpx #4
				bcc Loop




		rts
	}

	PositionHead: {

		lda PosX_LSB
		sta VIC.SPRITE_0_X

		lda PosX_MSB
		beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora #%00000001
			sta VIC.SPRITE_MSB

			jmp Finish

		NoMSB:

			lda VIC.SPRITE_MSB
			and #%11111110
			sta VIC.SPRITE_MSB

		Finish:

		rts

	}


	PositionBody: {

		ldx #0
		ldy #0

		Loop:

			stx ZP.X

			cmp #2
			bcc Arms

			Legs:

				lda Frames, x
				tax
				lda FrameOrder, x
				jmp SetPointer

			Arms:

				lda Frames, x
				tax
				lda ArmFrameOrder, x

			SetPointer:

				ldx ZP.X
				clc
				adc StartPointer, x
				sta SPRITE_POINTERS + 1, x

				lda #PosY
				clc
				adc YOffsets, x
				sta VIC.SPRITE_1_Y, y


				lda PosX_LSB
				clc
				adc XOffsets, x
				sec
				sbc Lag
				sta VIC.SPRITE_1_X, y

				inx
				iny
				iny
				cpx #4
			bcc Loop

		rts


	}


	Loop: {

		lda MAIN.PerformFrameCodeFlag
		beq Loop


		dec MAIN.PerformFrameCodeFlag
		jmp FrameCode

	}



	UpdateArms: {


		ldx #0

		Loop:

			lda ArmCounter, x
			bmi EndLoop

			beq Ready

			dec ArmCounter, x
			jmp EndLoop

			Ready:

			lda #FrameTime
			sta ArmCounter, x

			inc Frames, x
			lda Frames, x
			cmp #5
			bcc EndLoop

			lda #0
			sta Frames, x

			lda #255
			sta ArmCounter, x

			EndLoop:

			inx
			cpx #2
			bcc Loop





		rts
	}	


	DrawCredits: {

		lda Credits
		clc
		adc #NumberStart
		sta SCREEN_RAM + 54

		lda #GREEN
		sta COLOR_RAM + 54


		rts
	}



	DrawLives: {

		ldx CurrentPlayer
		lda LivesLeft, x
		clc
		adc #NumberStart
		sta SCREEN_RAM + 71

		lda #GREEN
		sta COLOR_RAM + 71

		rts
	}




	Menu: {

		lda Cooldown
		beq Ready

		dec Cooldown
		rts

		Ready:

		ldy #1
		lda INPUT.JOY_UP_NOW, y
		beq CheckStart

		Up:

			lda #ControlCooldown
			sta Cooldown

			inc Credits
			lda Credits
			cmp #10
			bcc Okay

			lda #9
			sta Credits

			Okay:

			sfx(SFX_ROTATE)

			jsr DrawCredits

		CheckStart:


		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		Fire:

			lda #GAME_STATUS_PLAY
			sta GameStatus

			lda Credits
			cmp #4
			bcc UseAllCredits	

			UseSomeCredits:

				lda #4
				sta NumPlayers

				lda Credits
				sec
				sbc #4
				sta Credits
				jmp Start

			UseAllCredits:

				sta NumPlayers

				lda #0
				sta Credits

			Start:

				lda #0
				sta CurrentPlayer
		
				jsr DrawCredits
				jsr DrawLives

				jsr SetupSprites
				jsr ClearArea

				jsr DisplayEggText


		Finish:


		rts
	}	


	GetScoreAddress: {

		lda CurrentPlayer
		asl
		tax
		lda ScoreAddresses, x
		sta ZP.ScoresAddress

		lda ScoreAddresses + 1, x
		sta ZP.ScoresAddress + 1


		rts
	}

	GetColourAddress: {


		lda CurrentPlayer
		asl
		tax
		lda ColourAddresses, x
		sta ZP.ColourAddress

		lda ColourAddresses + 1, x
		sta ZP.ColourAddress + 1

		rts



	}


	DisplayEggText: {


		ldy #0

		Loop:
			
			lda GYPSY_MORE_EGGS, y
			sta SCREEN_RAM + 753, y

			lda GYPSY_MORE_EGGS + 6, y
			sta SCREEN_RAM + 793, y

			lda GYPSY_MORE_EGGS + 12, y
			sta SCREEN_RAM + 833, y

			lda GYPSY_MORE_EGGS + 18, y
			sta SCREEN_RAM + 873, y

			lda GYPSY_MORE_EGGS + 24, y
			sta SCREEN_RAM + 913, y

			lda GYPSY_MORE_EGGS + 30, y
			sta SCREEN_RAM + 953, y

			iny
			cpy #6
			bcc Loop



		rts
	}

	DisplayCoinText: {


		ldy #0

		Loop:
			
			lda GYPSY_INSERT, y
			sta SCREEN_RAM + 753, y

			lda GYPSY_INSERT + 6, y
			sta SCREEN_RAM + 793, y

			lda GYPSY_INSERT + 12, y
			sta SCREEN_RAM + 833, y

			lda GYPSY_INSERT + 18, y
			sta SCREEN_RAM + 873, y

			lda GYPSY_INSERT + 24, y
			sta SCREEN_RAM + 913, y

			lda GYPSY_INSERT + 30, y
			sta SCREEN_RAM + 953, y

			iny
			cpy #6
			bcc Loop



		rts
	}


	FlashBigText: {

		lda FlashBigTimer
		beq Ready

		dec FlashBigTimer
		rts

		Ready:

		lda #FlashBigTime
		sta FlashBigTimer
	
		lda FlashText
		beq TurnOn

		TurnOff:

			lda FlashTextOn
			bne Okay

			rts

			Okay:

			dec FlashText
			lda #BLACK
			jmp Draw


		TurnOn:	

			inc FlashText
			lda #YELLOW
	
		Draw:

		ldy #0

		Loop:
			
			sta COLOR_RAM + 753, y
			sta COLOR_RAM + 793, y
			sta COLOR_RAM + 833, y
			sta COLOR_RAM + 873, y
			sta COLOR_RAM + 913, y
			sta COLOR_RAM + 953, y

			iny
			cpy #6
			bcc Loop


		rts
	}


	FlashScore: {

		lda FlashTimer
		beq Ready

		dec FlashTimer
		rts

		Ready:

		lda #FlashTime
		sta FlashTimer
	
		jsr GetColourAddress

		lda ScoreOn
		beq TurnOn

		TurnOff:

			dec ScoreOn
			lda #BLACK
			jmp Draw


		TurnOn:	

			inc ScoreOn
			lda #LIGHT_BLUE
	
		Draw:

		ldy #0

		Loop:

			sta (ZP.ColourAddress), y

			iny
			cpy #6
			bcc Loop


		rts
	}


	Dead: {


		MoveBird:
		
		lda BirdDirection
		bne GoingLeft

		GoingRight:

			lda BirdX
			clc
			adc #1
			sta BirdX

			CheckIfDone:

				cmp #254
				bcc NotFinished

				lda #0
				sta VIC.SPRITE_7_Y

				lda #GAME_STATUS_NEXT
				sta GameStatus
				jmp CheckFire

				NotFinished:

				jmp CheckFrame

		GoingLeft:

			lda BirdX
			sec
			sbc #1
			sta BirdX

			CheckIfDone2:

				cmp #5
				bcs NotFinished2

				lda #0
				sta VIC.SPRITE_7_Y

				lda #GAME_STATUS_NEXT
				sta GameStatus
				jmp CheckFire

				NotFinished2:

				jmp CheckFrame


		CheckFrame:

			lda BirdX
			sta VIC.SPRITE_7_X

			lda BirdTimer
			beq Ready

			dec BirdTimer
			jmp CheckFire

		Ready:

			lda #FrameTime
			sta BirdTimer

			inc BirdFrame
			lda BirdFrame
			cmp #3
			bcc Okay

			lda #0
			sta BirdFrame

			ldx #SFX_CHICK
			sfxFromX()


		Okay:

			ldx BirdDirection
			lda BirdPointers, x
			clc
			adc BirdFrame
			sta SPRITE_POINTERS + 7

		CheckFire:

		jsr CheckContinueFire

		rts
	}


	CheckContinueFire: {

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		NextPlayer:

			ldx CurrentPlayer
			lda ExtendedPlay, x
			cmp #1
			bne NotExtend

			lda #2
			sta ExtendedPlay, x
			jmp Skip

			NotExtend:

			dec LivesLeft, x

			inx
			inx
			cpx NumPlayers
			beq Okay
			bcc Okay

			ldx #0
			stx CurrentPlayer

			lda LivesLeft, x
			bne Skip

			lda #GAME_STATUS_OVER
			sta GameStatus

			jsr DrawLives

			jmp Finish

			
			Okay:

			dex
			stx CurrentPlayer

			Skip:

			lda #150
			sta PosX_LSB	

			lda #0
			sta Lag
			sta VIC.SPRITE_7_Y

			lda #GAME_STATUS_PLAY
			sta GameStatus

			jsr DrawLives
			jsr SetupSprites
			jsr ClearArea


		Finish:

		rts
	}

	FrameCode: {

		jsr FlashBigText

		lda GameStatus
		cmp #GAME_STATUS_PLAY
		bne NoPlay

		Play:

			jsr Control
			jsr UpdateLegs
			jsr UpdateArms
			jsr PositionHead
			jsr PositionBody
			jsr UpdateBalls


			lda GameStatus
			cmp #GAME_STATUS_PLAY 
			beq Okay
			jmp Loop

			Okay:

			jsr PositionBalls
			jsr FlashScore



			jmp Loop


		NoPlay:

			cmp #GAME_STATUS_MENU
			bne NotMenu	

			jsr Menu
			jmp Loop

		NotMenu:

			cmp #GAME_STATUS_DEAD
			bne NotDead

			jsr Dead
			jmp Loop

		NotDead:

			cmp #GAME_STATUS_NEXT
			bne NotNext

			jsr CheckContinueFire
			jmp Loop


		NotNext:

			jmp Show



		jmp Loop
	}	


	ClearArea: {

		ldx #0
		lda #0

		Loop:

			sta SCREEN_RAM + 401, x
			sta SCREEN_RAM + 521, x
			sta SCREEN_RAM + 801, x
			sta SCREEN_RAM + 641, x
			sta SCREEN_RAM + 681, x

			inx
			cpx #30
			bcc Loop
		
		rts

	}




	

	UpdateLegs: {

		lda LegCounter
		beq Ready

		dec LegCounter
		jmp Finish


		Ready:

			ldx #2

			Loop:

				inc Frames, x
				lda Frames, x
				cmp #6
				bcc Okay

				lda #0
				sta Frames, x

				Okay:

				inx
				cpx #4
				bcc Loop


			lda #FrameTime
			sta LegCounter



		Finish:

		rts
	}


}