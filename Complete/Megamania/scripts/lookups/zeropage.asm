*=$02 "Temp vars zero page" virtual



VECTOR1:				.word $0000
VECTOR2: 				.word $0000
CharID:					.byte $00
Row:					.byte $00
Column:					.byte $00
RowOffset:				.byte $00
Amount:					.byte $00
CurrentID:				.byte $00
CharacterID:			.byte $00
BulletPositionAdjX:		.byte $00
BulletPositionAdjY:		.byte $00
Colour:					.byte $00
LivesLeft:				.byte $00
CharOffset:				.byte $00
WaveAddress:			.word $0000
RowLoopEnd:				.byte $00
RowIRQIndex:			.byte $00

CurrentX_LSB:		.byte 0
CurrentX_MSB:		.byte 0
CurrentY_LSB:		.byte 0
CurrentY_MSB:		.byte 0

NewBulletX_LSB:		.byte 80
NewBulletX_MSB:		.byte 0
NewBulletY:			.byte 100
NextRowStartIndex:	.byte 0
NewBulletEnemyID:	.byte 0
RowIsOdd:			.byte 0
New_X_index:		.byte 0
ScoreDigit:			.byte 0

ZP_COUNTER: 	.byte $00

Diff_MSB:		.byte $00
Diff_LSB:		.byte 400




JOY_ZP1: 	.byte $00
JOY_ZP2: 	.byte $00
JOY_RIGHT_LAST:  .byte $00
JOY_LEFT_LAST:  .byte $00
JOY_DOWN_LAST: .byte $00
JOY_UP_LAST:  .byte $00
JOY_FIRE_LAST: .byte $00
JOY_RIGHT_NOW:  .byte $00
JOY_LEFT_NOW:  .byte $00
JOY_DOWN_NOW: .byte $00
JOY_UP_NOW:  .byte $00
JOY_FIRE_NOW: .byte $00



