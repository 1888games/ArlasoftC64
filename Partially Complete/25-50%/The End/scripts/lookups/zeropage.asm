*=$02 "Temp vars zero page" virtual



VECTOR1:				.word $0000
VECTOR2: 				.word $0000
CharID:					.byte $00
Row:					.byte $00
Column:					.byte $00
Amount:					.byte $00

Colour:					.byte $00
CharOffset:				.byte $00
RowOffset:				.byte $00

ZP_COUNTER: 			.byte $00
StoredXReg:				.byte $00
StoredYReg:				.byte $00
CurrentID:				.byte $00
StartID:				.byte $00
EndID:					.byte $00

FunctionAddress:		.word $0000
TableAddress:			.word $0000
ScreenAddress:			.word $0000
TextAddress:			.word $0000
CharAddress:			.word $0000
BulletAddress:			.word $0000

Diff_MSB:				.byte $00
Diff_LSB:				.byte $00	
TextColumn:				.byte $00
TextRow:				.byte $00

Temp1:					.byte $00
Temp2:					.byte $00
EnemyCount:				.byte $00
TrueResult:				.byte $00

Source1ID:				.byte $00
Source1ID_b:			.byte $00
Source2ID:				.byte $00
DestinationID:			.byte $00
BombID:					.byte $00
CharType:				.byte $00
Collided:				.byte $00
RandomMask:				.byte $00
LivesLeft:				.byte $00

EarlySprites:			.byte $00
LateSprites:			.byte $00


JOY_ZP1: 			.byte $00
JOY_ZP2: 			.byte $00
JOY_RIGHT_LAST: 	.byte $00
JOY_LEFT_LAST:  	.byte $00
JOY_DOWN_LAST: 		.byte $00
JOY_UP_LAST:  		.byte $00
JOY_FIRE_LAST: 		.byte $00
JOY_RIGHT_NOW: 		.byte $00
JOY_LEFT_NOW: 		.byte $00
JOY_DOWN_NOW: 		.byte $00
JOY_UP_NOW:  		.byte $00
JOY_FIRE_NOW: 		.byte $00



