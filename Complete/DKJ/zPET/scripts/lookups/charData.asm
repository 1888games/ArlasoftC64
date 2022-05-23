CHAR_DATA:{


	DataStart: 

		.word Monkey_0, Monkey_1, Monkey_2, Monkey_3, Monkey_4, Monkey_5
		.word Monkey_6, Monkey_7, Monkey_8, Monkey_9, Monkey_10, Monkey_11
		.word Monkey_12, Monkey_13, Monkey_14, Monkey_15, Monkey_16, Monkey_17
		.word Monkey_18, Monkey_19, Monkey_20, Monkey_21, Monkey_22, Monkey_23, Monkey_24
		.word Snapper_0, Snapper_1, Snapper_2, Snapper_3, Snapper_4, Snapper_5
		.word Bird_0, Bird_1, Bird_2, Bird_3, Bird_4, Bird_5, Bird_6, Bird_7
		.word Snapper_12, Snapper_11, Snapper_10, Snapper_9, Snapper_8, Snapper_7, Snapper_6
		.word Key_0, Key_1, Key_2, Key_3, Pineapple_0, Pineapple_1, Pineapple_2, Pineapple_3
		.word Cage_1, Cage_2, Cage_3, Cage_4
	
	ObjectType:
		.fill 25, 0 // monkey
		.fill 21, 1 // enemy
		.fill 4, 2 // key
		.fill 4, 3 // pineapple
		.fill 4, 4 // cage

	TypeColours:
		.byte 2, 0, 0, 4, 0

	Sizes: {


			// MONKEY
		.byte 18, 18, 18, 18, 18, 18 // 0-5
		.byte 18, 18, 18, 18, 18, 18 // 6-11
		.byte 20, 18, 18, 18, 18, 18 // 12-17
		.byte 8, 18, 18, 18, 18, 2, 20 // 18-24
		

		// ENEMIES
		.byte 2, 2, 2, 2, 2, 2   // 25-30
		.byte 2, 2, 2, 2, 2, 2, 2, 2  // 31 - 38
		.byte 2, 2, 2, 2, 2, 2, 2 // 39 - 45

		// KEYS
		.byte 4, 4, 4, 4  // 46 - 49

		// PINEAPPLE

		.byte 2, 2, 2, 2 // 50 - 53

		//  CAGE-
		.byte 6, 8, 6, 6 // 54-57

		// KONG

	

		
	}
	
	Monkey_0:	.byte 8, 21, 9, 21, 10, 21, 8, 19, 9, 19, 10, 19, 8, 20, 9, 20, 10, 20
	Monkey_1:	.byte 13, 21, 14,21, 15, 21, 13, 19, 14, 19, 15, 19, 13, 20, 14, 20, 15, 20
	Monkey_2:	.byte 17, 21, 18, 21, 19, 21, 17, 19, 18, 19, 19, 19, 17, 20, 18, 20, 19, 20
	Monkey_3:	.byte 22, 21, 23, 21, 24, 21, 22, 19, 23, 19, 24, 19, 22, 20, 23, 20, 24, 20
	Monkey_4:	.byte 27, 21, 28, 21, 29, 21, 27, 19, 28, 19, 29, 19, 27, 20, 28, 20, 29, 20
	Monkey_5:	.byte 31, 21, 32, 21, 33, 21, 31, 19, 32, 19, 33, 19, 31, 20, 32, 20, 33, 20


	Monkey_6:	.byte 8, 18, 9, 18, 10, 18, 8, 16, 9, 16, 10, 16, 8, 17, 9, 17, 10, 17
	Monkey_7:	.byte 13, 18, 14, 18, 15, 18, 13, 16, 14, 16, 15, 16, 13, 17, 14, 17, 15, 17
	Monkey_8:	.byte 17, 18, 18, 18, 19, 18, 17, 16, 18, 16, 19, 16, 17, 17, 18, 17, 19, 17
	Monkey_9:	.byte 22, 18, 23, 18, 24, 18, 22, 16, 23, 16, 24, 16, 22, 17, 23, 17, 24, 17
	Monkey_10:	.byte 27, 18, 28, 18, 29, 18, 27, 16, 28, 16, 29, 16, 27, 17, 28, 17, 29, 17
	Monkey_11:	.byte 31, 18, 32, 18, 33, 18, 31, 16, 32, 16, 33, 16, 31, 17, 32, 17, 33, 17

	Monkey_12:	.byte 11, 10, 12, 10, 13, 10, 11, 11, 12, 11, 13, 11, 11, 12, 12, 12, 13, 12, 11, 13
	Monkey_13:	.byte 11, 7, 12, 7, 13, 7, 11, 8, 12, 8, 13, 8, 11, 9, 12, 9, 13, 9
	Monkey_14:	.byte 17, 14, 18, 14, 19, 14, 17, 12, 18, 12, 19, 12, 17, 13, 18, 13, 19, 13
	Monkey_15:	.byte 22, 14, 23, 14, 24, 14, 22, 12, 23, 12, 24, 12, 22, 13, 23, 13, 24, 13
	Monkey_16:	.byte 26, 14, 27, 14, 28, 14, 26, 12, 27, 12, 28, 12, 26, 13, 27, 13, 28, 13
	Monkey_17:	.byte 30, 14, 31, 14, 32, 14, 30, 12, 31, 12, 32, 12, 30, 13, 31, 13, 32, 13

	Monkey_18:	.byte 5, 19, 6, 19, 7, 19, 6, 20
	Monkey_19:	.byte 14, 8, 15, 9, 16, 9, 14, 10, 15, 10, 16, 10, 15, 11, 14, 9
	Monkey_20:	.byte 17, 11, 18, 11, 19, 11, 17, 9, 18, 9, 19, 9, 17, 10, 18, 10, 19, 10
	Monkey_21:	.byte 22, 11, 23, 11, 24, 11, 22, 9, 23, 9, 24, 9, 22, 10, 23, 10, 24, 10
	Monkey_22:	.byte 26, 11, 27, 11, 28, 11, 26, 9, 27, 9, 28, 9, 26, 10, 27, 10, 28, 10
	Monkey_23:	.byte 99, 99
	Monkey_24:	.byte 11, 3, 10, 4, 11, 4, 12, 4, 10, 5, 11, 5, 12, 5, 10, 6, 11, 6, 12, 6 

	Snapper_0: .byte 12, 14   // 26
	Snapper_1: .byte 16, 14
	Snapper_2: .byte 21, 14
	Snapper_3: .byte 25, 14
	Snapper_4: .byte 29, 14
	Snapper_5: .byte 34, 16

	Bird_0: .byte 5, 16
	Bird_1: .byte 7, 17
	Bird_2: .byte 12, 17
	Bird_3: .byte 16, 17
	Bird_4: .byte 21, 17
	Bird_5: .byte 26, 17
	Bird_6: .byte 30, 17
	Bird_7: .byte 34, 14

	Snapper_12: .byte 7, 21
	Snapper_11: .byte 12, 21
	Snapper_10: .byte 16, 21
	Snapper_9: .byte 21, 21
	Snapper_8: .byte 25, 21
	Snapper_7: .byte 30, 21
	Snapper_6: .byte 34, 21 

	Key_0: .byte 14, 5, 13, 6
	Key_1: .byte 15, 5, 15, 6
	Key_2: .byte 16, 5, 17, 6
	Key_3: .byte 17, 5, 18, 5

	Pineapple_0: .byte 21, 8
	Pineapple_1: .byte 21, 13
	Pineapple_2: .byte 21, 16
	Pineapple_3: .byte 21, 20

	Cage_1: .byte 5, 6, 5, 5, 5, 4
	Cage_2: .byte 5, 3, 5, 2, 6, 2, 7, 2 
	Cage_3: .byte 8, 2, 9, 2, 9, 3
	Cage_4: .byte 9, 4, 9, 5, 9, 6

	



	



	









}



