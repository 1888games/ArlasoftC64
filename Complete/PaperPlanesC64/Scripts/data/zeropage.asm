
*=$02 "Temp vars zero page" virtual


.label PADDING = 4
.label MAX_SPRITES = 23

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
	SoundID:				.byte


	ScreenAddress:			.word 0
	ColourAddress:			.word 0
	CharOffset:				.byte 0
	TextAddress:			.word 0
	DataAddress:			.word 0
	StageWaveOrderAddress:	.word 0

	* = * "LPAX" virtual
	PlayerDataAddress:		.word 0
	EnemyDataAddress:		.word 0
	LeftPathAddressY:		.word 0
	RightPathAddressY:		.word 0
	AttackAddressX:			.word 0
	AttackAddressY:			.word 0
	SoundFX:				.byte 0

	XDiff:					.byte 0
	YDiff:					.byte 0
	XReached:				.byte 0
	YReached:				.byte 0

	L:						.byte 0
	H:						.byte 0
	E:						.byte 0
	D:						.byte 0
	C:						.byte 0
	B:						.byte 0
	Repeat:					.byte 0
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

	* = * "SpriteCopyY" virtual
	SpriteCopyY:
		.fill MAX_SPRITES, 0


	TextRow:	.byte 0
	TextColumn:	.byte 0
	TEMP1:		.byte 0
	TEMP2:		.byte 0
