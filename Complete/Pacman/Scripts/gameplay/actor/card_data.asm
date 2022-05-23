.label LF = 0
.label RT = 16
.label UP = 32
.label UL = 48
.label UR = 64


.label NO = 255

.label MV = 0
.label GK = 1
.label FK = 2
.label PN = 3
.label CN = 4

.label GL = 0
.label CL = 8
.label CR = 16
.label SV = 24



MoveDirection_1:		.byte RT + 02, LF + 03, UL + 06
MoveDirection_2:		.byte UP + 07, UP + 06, UP + 05
MoveDirection_3:		.byte NO + 00, NO + 00, NO + 00
CardType:				.byte MV + SV, MV + SV, MV + CL




