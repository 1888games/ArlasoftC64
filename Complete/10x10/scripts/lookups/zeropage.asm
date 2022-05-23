*=$02 "Temp vars zero page" virtual



VECTOR1:				.word $0000
VECTOR2: 				.word $0000
PIECE_DATA_ADDRESS:		 .word $0000
CharID:					.byte $00
Row:					.byte $00
Column:					.byte $00
RowOffset:				.byte $00
Amount:					.byte $00
CurrentRow:				.byte $00
CurrentCol:				.byte $00
CharByteID:				.byte $00
RowColID:				.byte $00
RowID:					.byte $00
ColID:					.byte $00
CurrentSpriteIndex: 	.byte $00
CurrentPointerIndex:	.byte $00
PointerIndex:			.byte $00
MSBThisSprite:			.byte $00
CurrentDrawPiece:		.byte $00
CurrentColour:			.byte 00


ZP_COUNTER: 	.byte $00


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



