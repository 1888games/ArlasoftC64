WALL_DATA: {
	
	* = * "Wall Data"

	Segment_1_Chars:		.word NorthTop_1, SouthTop_1, EastTop_1, WestTop_1
	Segment_2_Chars:		.word NorthTop_2, SouthTop_1, EastTop_1, WestTop_1 
	Segment_3_Chars:		.word NorthTop_1, SouthTop_1, EastTop_1, WestTop_1
	Segment_4_Chars:		.word NorthTop_1, SouthTop_1, EastTop_2, WestTop_1

	Segment_5_Chars:		.word NorthBot_1, SouthBot_1, EastBot_1, WestBot_1
	Segment_6_Chars:		.word NorthBot_1, SouthBot_2, EastBot_1, WestBot_1
	Segment_7_Chars:		.word NorthBot_1, SouthBot_1, EastBot_1, WestBot_1
	Segment_8_Chars:		.word NorthBot_1, SouthBot_1, EastBot_2, WestBot_1

	.label SX1 = 7
	.label SX2 = 13
	.label SX3 = 19
	.label SX4 = 25

	.label SY1 = 7
	.label SY2 =16

	Segment_Start_X:		.byte SX1, SX2, SX3, SX4, SX1, SX2, SX3, SX4
	Segment_Start_Y:		.byte SY1, SY1, SY1, SY1, SY2, SY2, SY2, SY2

	NorthTop_1:		.byte 3, 3, 3, 3, 3, 3, 3, 8, 0
	SouthTop_1:		.byte 7, 3, 3, 3, 3, 3, 3, 3, 3, 4, 0
	EastTop_1:		.byte 5, 5, 5, 5, 5, 5, 7, 0
	WestTop_1:		.byte 7, 5, 5, 5, 5, 5, 5, 0

	NorthTop_2:		.byte 3, 3, 3, 3, 3, 3, 3, 3, 0
	EastTop_2:		.byte 5, 5, 5, 5, 5, 5, 0

	NorthBot_1:		.byte 4, 3, 3, 3, 3, 3, 3, 3, 3, 7, 0
	SouthBot_1:		.byte 3, 3, 3, 3, 3, 3, 3, 3, 6, 0
	EastBot_1:		.byte 2, 2, 2, 2, 2, 2, 4, 0
	WestBot_1:		.byte 4, 2, 2, 2, 2, 2, 2, 0

	SouthBot_2:		.byte 3, 3, 3, 3, 3, 3, 3, 3, 3, 0
	EastBot_2:		.byte 2, 2, 2, 2, 2, 2, 0


						//N    S    E    W
	Wall_1_X_Start:	.byte 056, 056, 056, 004
	Wall_2_X_Start:	.byte 104, 104, 104, 060
	Wall_3_X_Start:	.byte 152, 152, 152, 108
	Wall_4_X_Start:	.byte 200, 200, 200, 156
	Wall_5_X_Start:	.byte 056, 056, 056, 004
	Wall_6_X_Start:	.byte 104, 104, 104, 060
	Wall_7_X_Start:	.byte 152, 152, 152, 108
	Wall_8_X_Start:	.byte 200, 200, 200, 156

	Wall_1_X_End:	.byte 059, 059, 103, 059
	Wall_2_X_End:	.byte 107, 107, 151, 107
	Wall_3_X_End:	.byte 155, 155, 199, 155
	Wall_4_X_End:	.byte 203, 203, 247, 203
	Wall_5_X_End:	.byte 059, 059, 103, 059
	Wall_6_X_End:	.byte 107, 107, 151, 107
	Wall_7_X_End:	.byte 155, 155, 199, 155
	Wall_8_X_End:	.byte 203, 203, 247, 203	

	Wall_1_Y_Start:	.byte 004, 060, 060, 060
	Wall_2_Y_Start:	.byte 004, 060, 060, 060
	Wall_3_Y_Start:	.byte 004, 060, 060, 060
	Wall_4_Y_Start:	.byte 004, 060, 060, 060
	Wall_5_Y_Start:	.byte 064, 128, 128, 128
	Wall_6_Y_Start:	.byte 064, 128, 128, 128
	Wall_7_Y_Start:	.byte 064, 128, 128, 128
	Wall_8_Y_Start:	.byte 064, 128, 128, 128

	Wall_1_Y_End:	.byte 063, 131, 063, 063
	Wall_2_Y_End:	.byte 063, 131, 063, 063
	Wall_3_Y_End:	.byte 063, 131, 063, 063
	Wall_4_Y_End:	.byte 063, 131, 063, 063
	Wall_5_Y_End:	.byte 131, 196, 131, 131
	Wall_6_Y_End:	.byte 131, 196, 131, 131
	Wall_7_Y_End:	.byte 131, 196, 131, 131
	Wall_8_Y_End:	.byte 131, 196, 131, 131




.label WALL_NORTH = 0
.label WALL_SOUTH = 1
.label WALL_EAST = 2
.label WALL_WEST = 3
    

	CharWallDistance_Right:	.byte 8, 4, 0, 0, 0, 0, 0, 0, 0
	CharWallDistance_Left:	.byte 8, 0, 0, 4, 4, 4, 0, 4, 0
	CharWallDistance_Up:	.byte 8, 0, 4, 0, 4, 0, 0, 0, 0
	CharWallDistance_Down:	.byte 8, 0, 0, 0, 0, 4, 0, 4, 0

	


}