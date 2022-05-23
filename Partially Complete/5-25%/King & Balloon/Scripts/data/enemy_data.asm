
	* = * "Enemy Data"


	EnemyTypeFrameStart:		.byte 17, 63, 33, 33, 33
	Colours:					.byte YELLOW, YELLOW, YELLOW, CYAN, WHITE, WHITE
	ExplosionFrames:			.byte 50, 51, 52, 53
	ExplosionColours:			.byte WHITE, YELLOW, YELLOW, YELLOW, YELLOW, WHITE
	
	

	SpriteLookupX:	.fill 27, 24 + (i * 8)
	SpriteLookupY:	.fill 19, 50 + (i * 8)
	
	SpriteX_LSB:
		.fill MAX_SPRITES, 0
	TargetSpriteX:
		.fill MAX_SPRITES, 0
	TargetSpriteY:
		.fill MAX_SPRITES, 0
	SpriteY_LSB:
		.fill MAX_SPRITES, 0

	PathID:
		.fill MAX_SPRITES, 0


