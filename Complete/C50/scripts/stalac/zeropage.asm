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

	RowOffset:				.byte 0
	ResetLevel:				.byte 0


	Level:					.byte 0
	Lives:					.byte 0

	NewDelay:				.byte 0
	StartHeight:			.byte 0
	WaitFire:				.byte 0
	FallTime:				.byte 0

	NewTimer:				.byte 0
	FallChance:				.byte 0
	ShipColumn:				.byte 0
	ShipRow:				.byte 0
	BulletColumn:			.byte 0
	BulletRow:				.byte 0
	LastColumn:				.byte 0
	BatChance:				.byte 0

	BatsInPlay:				.byte 0
	MaxBats:				.byte 0
	BatSpeed:				.byte 0

	
	* = $32 "Columns" virtual

	Columns:				.fill 40, 0

	* = $72 "Data" virtual

	FallingColumns:			.byte 0, 0, 0, 0, 0, 0, 0,0 
	FallingRows:			.byte 0, 0, 0, 0, 0, 0, 0,0 
	FallingTimer:			.byte 0, 0, 0, 0, 0, 0, 0,0 
	Falling:				.byte 0

	DestroyedColumns:		.fill 16, 0
	DestroyedRows:			.fill 16, 0
	BatRows:				.byte 0, 0, 0, 0, 0, 0
	BatColumns:				.byte 0, 0, 0, 0, 0, 0
	BatDirection:			.byte 0, 0, 0, 0, 0, 0
	BatTimer:				.byte 0, 0, 0, 0, 0, 0





}