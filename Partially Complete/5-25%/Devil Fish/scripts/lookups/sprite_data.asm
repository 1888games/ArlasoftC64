SPRITE_DATA: {
	

	Animations: .word Dog_Normal, Dog_Normal_Squeeze_Left, Dog_Normal_Squeeze_Right
				.word Dog_Normal_Squeeze_Up, Dog_Red, Dog_Red_Squeeze_Left, Dog_Red_Squeeze_Right,Dog_Red_Squeeze_Up
				.word Dog_Dead


	Animation_Size:		.byte 6, 1, 1, 1, 6, 1, 1, 1, 3
	Animation_Speed:	.byte 10, 10, 10, 10, 10, 10, 10, 10, 10, 10


	Dog_Normal: 				.byte 0
	Dog_Normal_Squeeze_Left: 	.byte 7
	Dog_Normal_Squeeze_Right: 	.byte 6
	Dog_Normal_Squeeze_Up:		.byte 8
	Dog_Red:					.byte 9	
	Dog_Red_Squeeze_Left: 		.byte 17
	Dog_Red_Squeeze_Right: 		.byte 15
	Dog_Red_Squeeze_Up:			.byte 16
	Dog_Dead:					.byte 54








}