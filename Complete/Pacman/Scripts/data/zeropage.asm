*=$02 "Temp vars zero page" virtual


.label PADDING = 4
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
	IsTrue:					.byte 0
	Steps:					.byte 0
	Repeated:				.byte 0
	GhostID:				.byte 0
	CharDataAddress:		.word 0
	ShortestDistance:		.word 0
	ShortestTurn:			.byte 0
	BadTurnCount:			.byte 0
	TurnID:					.byte 0

	ScreenAddress:			.word 0
	ScreenMapAddress:		.word 0
	ColourMapAddress:		.word 0
	ColourAddress:			.word 0
	CharOffset:				.byte 0
	TextAddress:			.word 0
	DataAddress:			.word 0
	PacmanAddress:			.word 0

	SourceAddress:			.word 0
	DestAddress:			.word 0
	PacSteps:				.byte 0
	PixelsThisFrame:		.byte 0

	DistanceX:				.word 0
	DistanceY:				.word 0

	AboveColourAddress:		.word 0
	AboveRowAddress:		.word 0
	BelowRowAddress:		.word 0
	BelowColourAddress:		.word 0

	SoundFX:				.byte 0
	NextLine:				.byte 0

	NextTileAddress:		.word 0

	PillAddress_1:			.word 0
	PillAddress_2:			.word 0
	PillAddress_3:			.word 0
	PillAddress_4:			.word 0

	OriginalSeed:			.word 0
	RandomSeed:				.word 0
	RandomAddress:			.word 0



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
	* = * "SpriteOrder" virtual
	SpriteOrder:
		.fill MAX_SPRITES, 0

	SpriteCopyX:
		.fill MAX_SPRITES, 0

	* = * "SpriteCopyY" virtual
	SpriteCopyY:
		.fill MAX_SPRITES, 0

	ColourCopy:
		.fill MAX_SPRITES, 0

	* = * "PointerCopy" virtual
	PointerCopy:
		.fill MAX_SPRITES, 0



	TextRow:	.byte 0
	TextColumn:	.byte 0

	ZP_CurrentBuffer: .word $0000
	ZP_NextBuffer: 		.word $0000

	ZP_MapLookup: 		.word $0000
	ZP_ScreenLookup: .word $0000

