*=$02 "Temp vars zero page" virtual


ZP: {

	Row:					.byte $00
	Column:					.byte $00
	Amount:					.byte $00
	Colour:					.byte $00
	X:						.byte $00
	Y:						.byte $00
	Counter:				.byte $00

	CurrentID:				.byte $00
	StartID:				.byte $00
	EndID:					.byte $00
	Cooldown:				.byte $00
	XGap:					.byte $00
	YGap:					.byte $00

	ColourAddress:			.word $0000
	ScreenAddress:			.word $0000
	TextAddress:			.word $0000
	ControlAddress:			.word $0000

	YPositions:				.fill 6, 0
	XPositions:				.fill 6, 0
	XPositionsMSB:			.fill 6, 0



	SleighTargetY:			.byte 0
	SleighMode:				.byte 0
	SidewaysCounter:		.byte 0
	//SleighTrack:			.byte 3

	SantaFrameTimer:		.byte 0
	SantaFrame:				.byte 0
	ReindeerFrameTimer:		.byte 0
	ReindeerFrame:			.byte 0
	

	Falling:				.byte 0
	SleighYSpeed_SUB:		.byte 0
	SleighYSpeed:			.byte 0
	SleighY_SUB:			.byte 0
	SleighImpulse:			.byte 0

	PresentsPrepared:		.byte 0

	PresentXSub:			.byte 0

	//SleighYSpeed_LO:		.byte 0
	//SleighYSpeed_HI:		.byte 0

	

	// Columns:	.fill MAX_STARS, 255
	// Rows:		.fill MAX_STARS, 255
	// StartID:	.byte 0, MAX_STARS/2
	// FrameTimer:		.byte 0


	


}