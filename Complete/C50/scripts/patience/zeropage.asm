
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

	SelectedCardID:			.byte 255
	MouseX_LSB:				.byte 0
	MouseX_MSB:				.byte 0
	MouseY:					.byte 0


	Deck:					.fill 52, 0
	CardValues:				.fill 52, 0
	CardSuits:				.fill 52, 0

	// lower byte = pile
	// upper byte = position

	Piles:			.fill 24 + 24 + (13 * 4) + (12 * 7), 0
	CardsInPile:	.fill 15, 0






}