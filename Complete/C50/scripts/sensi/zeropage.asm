*=$02 "Temp vars zero page" virtual


ZP: {

	Row:					.byte $00
	Column:					.byte $00
	Amount:					.byte $00
	Colour:					.byte $00
	
	Counter:				.byte $00

	CurrentID:				.byte $00
	StartID:				.byte $00
	EndID:					.byte $00
	Cooldown:				.byte $00
	GameMode:				.byte $00

	ColourAddress:			.word $0000
	ScreenAddress:			.word $0000
	TextAddress:			.word $0000
	ControlAddress:			.word $0000

	X:						.byte $00
	Y:						.byte $00

	Score:					.byte 0, 0, 0, 0
	Best:					.byte 0, 0, 0, 0




	BallSpeedLR_SUB:			.byte 0
	BallSpeedLR:				.byte 0
	BallSpeedFW_SUB:			.byte 0
	BallSpeedFW:				.byte 0
	BallSpeedUD_SUB:			.byte 0
	BallSpeedUD:				.byte 0
	BallHeight:					.byte 0
	BallHeight_SUB:				.byte 0
	BallPositionX_SUB:			.byte 0
	BallPositionX_LSB:			.byte 0
	BallPositionX_MSB:			.byte 0
	BallPositionY:				.byte 0
	BallPositionY_SUB:			.byte 0

	BallFrame:					.byte 0
	BallFrameTimer:				.byte 0


	BallForward:				.byte 0
	BallFalling:				.byte 0
	BallMovingLeft:				.byte 0
	BallInGoal:					.byte 0
	BallSwerve:					.byte 0
	BallSwerveLeft:				.byte 0
	BallSwerveTimer:			.byte 0



	PowerBarLevel:				.byte 0
	LoftLevel:					.byte 0
	SwerveLevel:				.byte 0

	PowerConversion:			.byte 0
	LoftConversion:				.byte 0

	BallMode:					.byte 0

	ControlLastFrame:			.byte 0

	WallPositionX:				.byte 0
	WallPositionY:				.byte 0
	WallJump:					.byte 0

	ScoreToAdd:					.byte 0

	LeftRightAim:				.byte 0
	AimMoveDirection:			.byte 0
	AimMSB:						.byte 0


}