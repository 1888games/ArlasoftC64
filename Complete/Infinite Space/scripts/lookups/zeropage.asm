*=$02 "Temp vars zero page" virtual



VECTOR1:				.word $0000
VECTOR2: 				.word $0000
CharID:					.byte $00
Row:					.byte $00
Column:					.byte $00
Amount:					.byte $00
CurrentID:				.byte $00
Colour:					.byte $00
CharOffset:				.byte $00
RowOffset:				.byte $00


ZP_COUNTER: 			.byte $00
StoredXReg:				.byte $00
StartID:				.byte $00
EndID:					.byte $00
TEMP9:					.byte $00
TEMP3:					.byte $00
TEMP2:					.byte $00	

WaveFunction: 			.word $0000

Diff_MSB:				.byte $00
Diff_LSB:				.byte $00	
TextColumn:				.byte $00


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



