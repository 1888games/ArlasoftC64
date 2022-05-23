*=$02 "Temp vars zero page" virtual


.label PADDING = 5
.label MAX_SPRITES = 20

ZP: {

	Counter:				.byte 0


	Row:					.byte 0
	Column:					.byte 0
	RowOffset:				.byte 0
	CharID:					.byte 0
	Temp1:					.byte 0
	Temp2:					.byte 0
	Temp3:					.byte 0
	Temp4:					.byte 0
	Colour:					.byte 0
	StoredXReg:				.byte 0
	EndID:					.byte 0
	Amount:					.byte 0
	StoredYReg:				.byte 0
	CurrentID:				.byte 0
	StartID:				.byte 0
	SpriteX_MSB:			.byte 0
	SpriteX:				.byte 0
	SpriteY:				.byte 0
	X:						.byte 0
	Y:						.byte 0
	EnemyX:					.byte 0
	CurrentRow:				.byte 0

	CharX:			.byte 0
	CharY:			.byte 0

	OrderAddress:			.word 0

	ScreenAddress:			.word 0
	ColourAddress:			.word 0
	CharOffset:				.byte 0
	TextAddress:			.word 0

	SoundFX:				.byte 0



	HatAddress:				.word 0
	EyesAddress:			.word 0
	EarsAddress:			.word 0
	NoseAddress:			.word 0
	MouthAddress:			.word 0

	HeadAddress:			.word 0

	SpriteAddress:			.word 0

	DataAddress:			.word 0
}


	TextRow:	.byte 0
	TextColumn:	.byte 0
