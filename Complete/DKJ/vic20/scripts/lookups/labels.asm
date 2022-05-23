.label ZERO= 0
.label ALL_ON = 255
.label ONE=1

.label JOY_UP =	 	%00000100
.label JOY_DOWN = 	%00001000
.label JOY_LEFT = 	%00010000
.label JOY_RIGHT =	%10000000
.label JOY_FIRE = 	%00100000

TEMP1:		.byte $00
TEMP2:		.byte $00
TEMP3:		.byte $00
TEMP4:		.byte $00
TEMP5:		.byte $00
TEMP6:		.byte $00
TEMP7:		.byte $00
TEMP8:		.byte $00
TEMP9:		.byte $00
TEMP10:		.byte $00

ZP_COUNTER: 	.byte $00
ZP_ODD_EVEN: .byte $00

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


