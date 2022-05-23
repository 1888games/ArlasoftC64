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



	Cells:					.fill 36, 0



}