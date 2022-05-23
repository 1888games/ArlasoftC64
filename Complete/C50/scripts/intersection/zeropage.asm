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



	LastSpawn:				.byte 0
	SpawnTimer:				.byte 0
	SpawnSpeed:				.byte 0

	CarsInPlay:				.byte 0
	SpriteCollision:		.byte 0
	GameMode:				.byte 0

	DirectionOn:			.byte 0, 0, 0, 0

	Speed_MSB:				.fill 8, 0
	Speed_LSB:				.fill 8, 0

	Position_SUB:			.fill 8, 0
	PositionX_MSB:			.fill 8, 0 

	LaneSpeed_MSB:			.fill 4, 0
	LaneSpeed:				.fill 4, 0

	* = * "To spawn" virtual
	CarsToSpawn:			.byte 0
	MinTimer:				.byte 100

	ColourAddress:			.word $0000
	ScreenAddress:			.word $0000
	TextAddress:			.word $0000
	ControlAddress:			.word $0000

	ShakeTimer:				.byte 0
	X:						.byte $00
	Y:						.byte $00

	Score:					.byte 0, 0, 0, 0
	Best:					.byte 0, 0, 0, 0


	CarScores:				.byte 16, 0


	* = $70 "IntersectionStatus" virtual
	IntersectionStatus:		.fill 8, 0
	CarsInLane:				.fill 8, 0
	WaitingTime:			.fill 8, 0




}