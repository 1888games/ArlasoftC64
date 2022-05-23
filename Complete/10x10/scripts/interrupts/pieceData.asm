PIECE_DATA: {
	

	Pieces:		.word Single, Small_L_Left, Small_L_UpsideLeft, Small_L_UpsideRight, Small_L_Right  // 0-4
				.word Square_2x2, Square_3x3, Square_L_UpsideRight, Square_L_UpsideLeft // 5-8
				.word Long_5, Long_4, Square_L_Right, Square_L_Left, Long_3, Tall_L_Left // 9-14
				.word Tall_L_Right, Tall_L_Upside, Tall_L_Right_Upside, Long_L_Left_Upside, Long_L_Right_Upside // 15-19
				.word Tall_2, Long_2, Tall_3, Tall_4, Tall_5, Long_L_Left, Long_L_Right, Stagger_Left_Tall // 20=27
				.word Stagger_Right_Tall, Stagger_Right_Long, Stagger_Left_Long, Single // 28-30


	Frequency:	
	.fill 2,0
	.fill 2,1
	.fill 2,2
	.fill 2,3
	.fill 2,4
	.fill 5,5
	.fill 1,6
	.fill 1,7
	.fill 1,8
	.fill 2,9
	.fill 2,10
	.fill 1,11
	.fill 1,12
	.fill 4,13
	.fill 2,14
	.fill 2,15
	.fill 2,16
	.fill 2,17
	.fill 2,18
	.fill 2,19
	.fill 4,20
	.fill 4,21
	.fill 4,22
	.fill 2,23
	.fill 2,24
	.fill 2,25
	.fill 2,26
	.fill 1,27
	.fill 1,28
	.fill 1,29
	.fill 1,30


	Colours:		.byte 02, 03, 03, 03, 03, 02, 02, 05, 05, 06, 07, 05, 05, 08, 14, 14, 14, 14, 13, 13, 13, 13, 06, 07, 07, 08, 10, 02, 02, 02, 02, 02
	CharSizes:		.byte 02, 06, 06, 06, 06, 08, 18, 10, 10, 10, 08, 10, 10, 06, 08, 08, 08, 08, 08, 08, 04, 04, 06, 08, 10, 08, 08, 08, 08, 08, 08, 02
	SpriteSizes:	.byte 01, 04, 03, 04, 04, 04, 06, 04, 04, 04, 03, 06, 05, 02, 05, 06, 04, 06, 03, 03, 02, 02, 03, 03, 04, 04, 04, 06, 06, 04, 04, 01


	// Character Offsets
	// Sprite Frames
	// Sprite Offsets



	Single:					.byte 00, 00
							.byte 00
							.byte 00


	Small_L_Left:			.byte 00, 00, 00, 01, 01, 01
							.byte 08, 09, 16, 17
							.byte 00, 00, 24, 00, 00, 21, 24, 21


	Small_L_UpsideLeft:		.byte 00, 00, 00, 01, 01, 00
							.byte 24, 25, 32
							.byte 00, 00, 24, 00, 00, 21

	Small_L_UpsideRight:	.byte 00, 00, 01, 00, 01, 01
							.byte 40, 41, 48, 49
							.byte 00, 00, 24, 00, 00, 21, 24, 21

	Small_L_Right:			.byte 01, 00, 00, 01, 01, 01
							.byte 56, 57, 64, 65
							.byte 00, 00, 24, 00, 00, 21, 24, 21


	Square_2x2:				.byte 00, 00, 01, 00, 00, 01, 01, 01
							.byte 72, 73, 80, 81
							.byte 00, 00, 24, 00, 00, 21, 24, 21


	Square_3x3:				.byte 00, 00, 01, 00, 02, 00, 00, 01, 01, 01, 02, 01, 00, 02, 01, 02, 02, 02
							.byte 88, 89, 96, 97, 104, 105
							.byte 00, 00, 24, 00, 00, 21, 24, 21, 00, 42, 24, 42

	Square_L_UpsideRight:	.byte 00, 00, 01, 00, 02, 00, 02, 01, 02, 02
							.byte 112, 113, 121, 129
							.byte 00, 00, 24, 00, 24, 21, 24, 42

	Square_L_UpsideLeft:	.byte 00, 00, 01, 00, 02, 00, 00, 01, 00, 02
							.byte 136, 137, 144, 152
							.byte 00, 00, 24, 00, 00, 21, 00, 42

	Long_5:					.byte 00, 00, 01, 00, 02, 00, 03, 00, 04, 00
							.byte 138, 139, 140, 141
							.byte 00, 00, 24, 00, 48, 00, 72, 00

	Long_4:					.byte 00, 00, 01, 00, 02, 00, 03, 00
							.byte 130, 131, 132
							.byte 00, 00, 24, 00, 48, 00

	Square_L_Right:			.byte 02, 00, 02, 01, 00, 02, 01, 02, 02, 02
							.byte 126, 127, 134, 135, 142, 143
							.byte 00, 00, 24, 00, 00, 21, 24, 21, 00, 42, 24, 42


	Square_L_Left:			.byte 00, 00, 00, 01, 00, 02, 01, 02, 02, 02
							.byte 54, 62, 63, 70, 71
							.byte 00, 00, 00, 21, 24, 21, 00, 42, 24, 42


	Long_3:					.byte 00, 00, 01, 00, 02, 00
							.byte 46, 47
							.byte 00, 00, 24, 00


	Tall_L_Left:			.byte 00, 00, 00, 01, 00, 02, 01, 02
							.byte 02, 10, 11, 18, 19
							.byte 00, 00, 00, 21, 24, 21, 00, 42, 24, 42

	Tall_L_Right:			.byte 01, 00, 01, 01, 00, 02, 01, 02
							.byte 26, 27, 34, 35, 42, 43
							.byte 00, 00, 24, 00, 00, 21, 24, 21, 00, 42, 24, 42

	Tall_L_Upside:			.byte 00, 00, 01, 00, 00, 01, 00, 02
							.byte 04, 05, 12, 20
							.byte 00, 00, 24, 00, 00, 21, 00, 42


	Tall_L_Right_Upside:	.byte 00, 00, 01, 00, 01, 01, 01, 02
							.byte 06, 07, 14, 15, 22, 23
							.byte 00, 00, 24, 00, 00, 21, 24, 21, 00, 42, 24, 42


	Long_L_Left_Upside:		.byte 00, 00, 01, 00, 02, 00, 00, 01
							.byte 28, 29, 36
							.byte 00, 00, 24, 00, 00, 21

	Long_L_Right_Upside:	.byte 00, 00, 01, 00, 02, 00, 02, 01
							.byte 44, 45, 53
							.byte 00, 00, 24, 00, 24, 21


	Tall_2:					.byte 00, 00, 00, 01
							.byte 31, 39
							.byte 00, 00, 00, 21


	Long_2:					.byte 00, 00, 01, 00
							.byte 51, 52
							.byte 00, 00, 24, 00


	Tall_3:					.byte 00, 00, 00, 01, 00, 02
							.byte 50, 58, 66
							.byte 00, 00, 00, 21, 00, 42


	Tall_4:					.byte 00, 00, 00, 01, 00, 02, 00, 03
							.byte 75, 83, 91
							.byte 00, 00, 00, 21, 00, 42


	Tall_5:					.byte 00, 00, 00, 01, 00, 02, 00, 03, 00, 04
							.byte 74, 82, 90, 98
							.byte 00, 00, 00, 21, 00, 42, 00, 63


	Long_L_Left:			.byte 00, 00, 00, 01, 01, 01, 02, 01
							.byte 76, 77, 84, 85 
							.byte 00, 00, 24, 00, 00, 21, 24, 21


	Long_L_Right:			.byte 02, 00, 00, 01, 01, 01, 02, 01
							.byte 60, 61, 68, 69
							.byte 00, 00, 24, 00, 00, 21, 24, 21


	Stagger_Left_Tall:		.byte 00, 00, 00, 01, 01, 01, 01, 02
							.byte 106, 107, 114, 115, 122, 123
							.byte 00, 00, 24, 00, 00, 21, 24, 21, 00, 42, 24, 42



	Stagger_Right_Tall:		.byte 01, 00, 00, 01, 01, 01, 00, 02
							.byte 108, 109, 116, 117, 124, 125
							.byte 00, 00, 24, 00, 00, 21, 24, 21, 00, 42, 24, 42


	Stagger_Right_Long:		.byte 01, 00, 02, 00, 00, 01, 01, 01
							.byte 94, 95, 102, 103
							.byte 00, 00, 24, 00, 00, 21, 24, 21



	Stagger_Left_Long:		.byte 00, 00, 01, 00, 01, 01, 02, 01
							.byte 110, 111, 118, 119
							.byte 00, 00, 24, 00, 00, 21, 24, 21





















}