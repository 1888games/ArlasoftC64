
*=$10 "Temp vars zero page" virtual


.label PADDING = 4
.label MAX_SPRITES = 23

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
	Colour:					.byte 0
	StoredXReg:				.byte 0
	EndID:					.byte 0
	Amount:					.byte 0
	StoredYReg:				.byte 0
	CurrentID:				.byte 0
	StarEndID:				.byte 0
	EnemyID:				.byte 0
	EnemyType:				.byte 0
	SlotID:					.byte 0
	StageOrderID:			.byte 0
	FormationID:			.byte 0
	KillID:					.byte 0
	SoundID:				.byte 0


	ScreenAddress:			.word 0
	ColourAddress:			.word 0
	CharOffset:				.byte 0
	TextAddress:			.word 0
	DataAddress:			.word 0
	
}


//* = * $21

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
	TEMP1:		.byte 0
	TEMP2:		.byte 0
