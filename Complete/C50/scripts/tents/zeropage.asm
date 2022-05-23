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

	ColourAddress:			.word $0000
	ScreenAddress:			.word $0000
	TextAddress:			.word $0000
	ControlAddress:			.word $0000


	GridSize:				.byte $00

	YValues:				.byte 0, 1, 40, 41


	CurrentRow:				.byte 0
	CurrentColumn:			.byte 0
	StartRow:			.byte 0

	SelectedCell:			.byte 0
	SelectedRow:			.byte 0
	SelectedColumn:			.byte 0
	PointerPositionX:		.byte 0
	PointerPositionY:		.byte 0
	LevelNotComplete:		.byte 0
	GameMode:				.byte 0
	GameOverCount:			.byte 0
	Level:					.byte 0, 0
	Score:					.byte 0, 0
	ScoreThisRound:			.byte 0
	ScoreCounter:			.byte 0

	* = $40 "Data" virtual
	Grid:				.fill 121, 0

	RowCounts:			.fill 11, 0
	ColumnCounts:		.fill 11, 0

	YourRowCounts:		.fill 11, 0
	YourColumnCounts:	.fill 11, 0





}