
*=$02 "Temp vars zero page" virtual


.label PADDING = 5
.label MAX_SPRITES = 20

SamplerTemp: .byte $00

ZP: {

	Counter:				.byte 0


	Row:					.byte 0
	Column:					.byte 0
	RowOffset:				.byte 0
	CharID:					.byte 0
	StartID:				.byte 0
	Temp1:					.byte 0
	Temp2:					.byte 0
	Temp3:					.byte 0
	Temp4:					.byte 0
	X:						.byte 0
	Y:						.byte 0
	Colour:					.byte 0
	StoredXReg:				.byte 0
	EndID:					.byte 0
	Amount:					.byte 0
	StoredYReg:				.byte 0
	CurrentID:				.byte 0
	SoundID:				.byte 0
	WallID:					.byte 0
	WallDirection:			.byte 0
	CharDirection:			.byte 0
	ScreenMove:				.byte 0
	SpriteID:				.byte 0
	ColumnID:				.byte 0
	RobotID:				.byte 0
	BulletID:				.byte 0

	ScreenAddress:			.word 0
	ColourAddress:			.word 0
	CharOffset:				.byte 0
	TextAddress:			.word 0
	DataAddress:			.word 0
	StageWaveOrderAddress:	.word 0
	CollideChar:			.byte 0
	CurrentSample:			.byte 0
	Died:					.byte 0
	
	
	SoundFX:				.byte 0

	XDiff:					.byte 0
	YDiff:					.byte 0
	Frequency:				.byte 0
	Frequency_MSB:			.byte 0
	YReached:				.byte 0

	L:						.byte 0
	H:						.byte 0
	E:						.byte 0
	D:						.byte 0
	C:						.byte 0
	B:						.byte 0
	Repeat:					.byte 0
	State:					.byte 0
	NextLine:				.byte 0
}


//* = * $21

	* = * "SpriteX" virtual
	SpriteX:
		.fill MAX_SPRITES, 0

//* = * "SpriteY"

	* = * "SpriteY" virtual
	SpriteY:
		.fill MAX_SPRITES, 0

	* = * "SpriteColor" virtual
	SpriteColor:
		.fill MAX_SPRITES, 0

	* = * "SpritePointer" virtual
	SpritePointer:
		.fill MAX_SPRITES, 0
	* = * "SpriteOrder" virtual
	SpriteOrder:
		.fill MAX_SPRITES, 0

	* = * "SpriteCopyX" virtual
	SpriteCopyX:
		.fill MAX_SPRITES, 0


	* = * "SpriteCopyY" virtual
	SpriteCopyY:
		.fill MAX_SPRITES, 0


	* = * "SpriteColorCopy" virtual
	ColourCopy:
		.fill MAX_SPRITES, 0



	* = * "PointerCopy" virtual
	PointerCopy:
		.fill MAX_SPRITES, 0


	TextRow:	.byte 0
	TextColumn:	.byte 0
	TEMP1:		.byte 0
	TEMP2:		.byte 0

