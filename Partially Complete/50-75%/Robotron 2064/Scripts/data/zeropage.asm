*=$02 "Temp vars zero page" virtual


.label PADDING = 4
.label MAX_SPRITES = 30



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
	EndID:					.byte 0
	Amount:					.byte 0
	CurrentID:				.byte 0
	X:						.byte 0
	Y:						.byte 0
	MSB:					.byte 0
	Positive:				.byte 0
	CurrentFunctionID:		.byte 0
	SpriteID:				.byte 0
	LocalID:				.byte 0
	TargetX:				.byte 0
	TargetY:				.byte 0
	MoveSpeed:				.byte 0
	
	FunctionAddress:		.word 0
	ScreenAddress:			.word 0
	ColourAddress:			.word 0
	OffsetAddress:			.word 0
	TextAddress:s:			.word 0
	StageAddress:			.word 0

	BulletAddresses:		.fillword 4, 0

	Sort1:			.byte 0
	Sort2:			.byte 0

	* = * "Collision" virtual
	StartCollisionID:	.byte 0
	EndCollisionID:		.byte 0
	FoundCollision:		.byte 0
	QuitCollision:		.byte 0
}
	*=* "Sprite Data" virtual

//* = * $21

	*=* "X" virtual
	SpriteX:			.fill MAX_SPRITES, 0	
	*=* "Y" virtual
	SpriteY:			.fill MAX_SPRITES, 0
	SpriteColor:		.fill MAX_SPRITES, 0
	SpritePointer:		.fill MAX_SPRITES, 0
	SpriteOrder:		.fill MAX_SPRITES, 0
		

	TextRow:	.byte 0
	TextColumn:	.byte 0
