*=$02 "Temp vars zero page" virtual


.label PADDING = 5
.label MAX_SPRITES = 16



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
	CharX:					.byte 0
	CharY:					.byte 0
	PlayerID:				.byte 0
	Facing:					.byte 0
	ReverseX:				.byte 0
	ReverseY:				.byte 0

	AnimationID:			.byte 0

	CharDataAddress:			.word 0

	ScreenAddress:			.word 0
	ColourAddress:			.word 0
	CharOffset:				.byte 0
	TextAddress:			.word 0
	FunctionAddress:		.word 0

	SoundFX:				.byte 0


	AnimationAddresses:		.word 0, 0
	DataAddress:			.word 0



}


	* = * "SpriteX" virtual
	SpriteX:
		.fill MAX_SPRITES, 0

//* = * "SpriteY"

	* = * "SpriteY" virtual
	SpriteY:
		.fill MAX_SPRITES, 0
	SpriteColor:
		.fill MAX_SPRITES, 0
	SpritePointer:
		.fill MAX_SPRITES, 0
	SpriteOrder:
		.fill MAX_SPRITES, 0

	SpriteCopyX:
		.fill MAX_SPRITES, 0


	* = * "SpriteCopyY" virtual
	SpriteCopyY:
		.fill MAX_SPRITES, 0


	TextRow:	.byte 0
	TextColumn:	.byte 0
