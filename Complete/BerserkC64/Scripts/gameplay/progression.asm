PROGRESSION: {

	* = * "Progression"

	Level:				.byte 0

	Bullets:			.byte 0, 1, 2, 3, 4, 5, 1, 1, 2, 3, 4, 5, 5, 5
	Colours:			.byte YELLOW, RED, CYAN, GREEN, PURPLE, YELLOW, WHITE, WHITE, CYAN, PURPLE, GRAY, YELLOW, RED, CYAN 

	ScoreLevelH:		.byte $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01
	ScoreLevelM:		.byte $03, $15, $30, $45, $60, $75, $90, $00, $11, $13, $15, $17, $19
	FrameSpeed:			.byte 020, 019, 018, 017, 016, 015, 014, 013, 012, 011, 010, 009, 008, 007		

	FrameDelay:			.byte 67, 67, 17, 9, 9, 12, 50, 42, 29, 21, 17, 12, 9, 4

	BulletSpeed_LSB:	.byte 0
	BulletSpeed_MSB:	.byte 0

	RobotSpeed_LSB:		.byte 0
	RobotSpeed_MSB:		.byte 0

	.label RobotsPerFrame = 1


	.label RobotSpeedStart_LSB = 100 / RobotsPerFrame
	.label RobotSpeedStart_MSB = 0

	.label RobotSpeedPerLevel = 20 / RobotsPerFrame
	.label RobotSpeedPerRobot = 25 / RobotsPerFrame

	.label BulletSpeedStart_MSB = 0
	.label BulletSpeedStart_LSB = 200
	.label BulletSpeedPerLevel = 15

	.label BulletSpeedFast_LSB = 100
	.label BulletSpeedFast_MSB = 1

	.label MaxScoreIncrease_H = $01
	.label MaxScoreIncrease_M = $20


	NewGame: {

		lda #BulletSpeedStart_LSB
		sta BulletSpeed_LSB

		lda #BulletSpeedStart_MSB
		sta BulletSpeed_MSB

		lda #RobotSpeedStart_LSB
		sta RobotSpeed_LSB

		lda #RobotSpeedStart_MSB
		sta RobotSpeed_MSB

		lda #MaxScoreIncrease_M
		sta ScoreLevelM + 7

		lda #MaxScoreIncrease_H
		sta ScoreLevelH + 7

		lda #0
		sta Level

		beq NoFake

		tay
		lda #0
		sta Level
		tax

		Loop:

			jsr IncreaseLevel

			dey
			bne Loop




		NoFake:

	
		jsr GetLevelData




		rts
	}

	CheckLevel: {

			ldx Level

		CheckHigh:
		
			lda SCORE.Value + 2
			cmp ScoreLevelH, x
			bcc NotYet
			beq CheckMid

			jmp IncreaseLevel


		CheckMid:

			lda SCORE.Value + 1
			cmp ScoreLevelM, x
			bcc NotYet

			jmp IncreaseLevel


		CheckLow:

		NotYet:

		rts
	}


	GetLevelData: {


		

		BulletNum:

			ldx Level
			lda Bullets, x
			clc
			adc #2
			sta BULLET.MaxBullets

		RobotColour:

			lda Colours, x
			sta ROBOT.CurrentColour


		BulletSpeed:

			lda BulletSpeed_LSB
			sta BULLET.RobotFracSpeed
			sta BULLET.RobotFracSpeed + 1

			lda BulletSpeed_MSB
			sta BULLET.RobotPixelSpeed
			sta BULLET.RobotPixelSpeed + 1

		RobotSpeed:

			lda RobotSpeed_LSB
			sta ROBOT.FracSpeed

			lda RobotSpeed_MSB
			sta ROBOT.PixelSpeed

		Delay:

			lda FrameDelay, x
			sta ROBOT.Delay

			lda FrameSpeed, x
			sta ROBOT.FrameSpeeds + 1
			sta ROBOT.FrameSpeeds + 2
			sta ROBOT.FrameSpeeds + 3
			sta ROBOT.FrameSpeeds+ 4
			sta ROBOT.FrameSpeeds + 5



		rts
	}



	IncreaseLevel: {

		cpx #13
		beq NoDouble

		IncreaseSpeeds:

			lda RobotSpeed_LSB
			clc
			adc #RobotSpeedPerLevel
			sta RobotSpeed_LSB

			lda RobotSpeed_MSB
			adc #0
			sta RobotSpeed_MSB

			lda BulletSpeed_LSB
			clc
			adc #BulletSpeedPerLevel
			sta BulletSpeed_LSB

			lda BulletSpeed_MSB
			adc #0
			sta BulletSpeed_MSB

		IncreaseID:

			inx
			inc Level

			cpx #6
			bne NoDouble

		DoubleBulletSpeed:

			lda #BulletSpeedFast_LSB
			sta BulletSpeed_LSB

			lda #BulletSpeedFast_MSB
			sta BulletSpeed_MSB

		NoDouble:




		rts
	}




}