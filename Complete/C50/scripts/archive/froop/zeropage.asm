*=$02 "Temp vars zero page" virtual


ZP: {

	Row:					.byte $00
	Column:					.byte $00
	Amount:					.byte $00
	Colour:					.byte $00
	X:						.byte $00
	Y:						.byte $00
	Counter:				.byte $00
	RowOffset:				.byte $00

	CurrentID:				.byte $00
	StartID:				.byte $00
	EndID:					.byte $00
	Cooldown:				.byte $00
	CharID:					.byte $00

	ColourAddress:			.word $0000
	ScreenAddress:			.word $0000
	TextAddress:			.word $0000
	ControlAddress:			.word $0000


	LastQuadrant:			.byte 8

	NextCellID:				.byte 0
	NextCellCountdown:		.byte 4
	NextCellTimer:			.byte 0
	NextCellType:			.byte 0
	NextCellSpeed:			.byte 14
	NextCellSectionEnd:		.byte 0


	PlayerDirection:	.byte 0
	PlayerMode:			.byte 0
	PlayerTargetX:		.byte 0
	PlayerTargetX_MSB:	.byte 0
	PlayerTargetY:		.byte 0
	PlayerRow:			.byte 0
	PlayerColumn:		.byte 0
	PlayerX:			.byte 0
	PlayerY:			.byte 0
	PlayerX_MSB:		.byte 0
	PlayerType:			.byte 0
	PlayerMoveTimer:	.byte 0
	PlayerMovePixels:	.byte 2
	PlayerCell:			.byte 0
	PlayerGridPosition:	.byte 0
	PlayerEndPosition: .byte 0
	PlayerStartPosition: .byte 0

	Level:				.byte 1
	Takeaway:			.byte 0, 0, 0

	GameMode:			.byte 0



	*=$40 "grid" virtual
	Grid:			.fill 88, 0






}