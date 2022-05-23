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

	ColourAddress:			.word $0000
	ScreenAddress:			.word $0000
	TextAddress:			.word $0000
	ControlAddress:			.word $0000

	NumberPlayers:			.byte 0
	SquadStart:				.byte 0

	Defence:			.byte 0
	Attack:				.byte 0
	Reliability:		.byte 0
	Influence:			.byte 0
	Wealth:				.byte 0
	Violence:			.byte 0
	Foot:				.byte 0
	CurrentPosition:	.byte 0


	TotalDefence:		.byte 0
	TotalMidfield:		.byte 0
	TotalAttack:		.byte 0


	Selection:			.fill 16, 0
	Formation:			.fill 4, 0
	SelectedOption:		.byte 0
	Mode:				.byte 0
	Cooldown:			.byte 0

	SelectPlayer1:		.byte 255
	SelectPlayer2:		.byte 255



	OppositionDefence:	.byte 0
	OppositionMidfield: .byte 0
	OppositionAttack:	.byte 0

	Minute:				.byte 0
	MinuteCounter:		.byte 15

	Possession:			.byte 16, 16
	Goals:				.byte 0, 0


	League:				.byte 0, 0, 0, 0, 0, 0, 0, 0
	TableOrder:			.byte 0, 0, 0, 0, 0, 0, 0, 0
	


	* = $80 "Data" virtual
	SkillsLookup:			.fill 64, 0



}




