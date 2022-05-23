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
		.byte 8, 8, 8, 8, 8, 8 // 0-5
		.byte 4, 8, 4, 4, 8, 4 // 6-11
		.byte 8, 10, 8, 8, 8, 8 // 12-17
		.byte 4, 10, 8, 8, 4, 2, 10 // 18-24

		// ENEMIES
		.byte 2, 2, 2, 2, 2, 2   // 25-30
		.byte 2, 2, 2, 2, 2, 2, 2, 2  // 31 - 38
		.byte 2, 2, 2, 2, 2, 2, 2 // 39 - 45

		// KEYS
		.byte 2, 2, 2, 2  // 46 - 49

		// PINEAPPLE

		.byte 2, 2, 2, 2 // 50 - 53

		//  CAGE
		.byte 4, 4, 4, 6 // 54-57

		// KONG

		
	}
	
	Monkey_0:	.byte 3, 19, 4, 19, 3, 20, 4, 20	
	Monkey_1:	.byte 6, 19, 7, 19, 6, 20, 7, 20
	Monkey_2:	.byte 9, 19, 10, 19, 9, 20, 10, 20
	Monkey_3:	.byte 12, 19, 13, 19, 12, 20, 13, 20
	Monkey_4:	.byte 15, 19, 16, 19, 15, 20, 16, 20
	Monkey_5:	.byte 18, 19, 19, 19, 18, 20, 19, 20


	Monkey_6:	.byte 3, 15, 3, 16
	Monkey_7:	.byte 6, 15, 6, 16, 7, 15, 7, 16
	Monkey_8:	.byte 9, 15, 9, 16
	Monkey_9:	.byte 12, 15, 12, 16
	Monkey_10:	.byte 15, 15, 15, 16, 16, 15, 16, 16
	Monkey_11:	.byte 18, 15, 18, 16

	Monkey_12:	.byte 1, 13, 2, 13, 1, 14, 2, 14
	Monkey_13:	.byte 4, 11, 5, 11, 4, 12, 5, 12, 5, 10
	Monkey_14:	.byte 9, 12, 10, 12, 9, 13, 10, 13
	Monkey_15:	.byte 12, 12, 13, 12, 12, 13, 13, 13
	Monkey_16:	.byte 15, 12, 16, 12, 15, 13, 16, 13
	Monkey_17:	.byte 18, 12, 19, 12, 18, 13, 19, 13

	Monkey_18:	.byte 0, 18, 0, 19
	Monkey_19:	.byte 6, 7, 7, 7, 6, 8, 7, 8, 7, 9
	Monkey_20:	.byte 9, 8, 10, 8, 9, 9, 10, 9
	Monkey_21:	.byte 12, 8, 13, 8, 12, 9, 13, 9
	Monkey_22:	.byte 15, 8, 15, 9
	Monkey_23:	.byte 99, 99
	Monkey_24:	.byte 3, 4, 4, 4, 4, 5, 5, 5, 4, 3

	Snapper_0: .byte 5, 13   // 26
	Snapper_1: .byte 8, 13
	Snapper_2: .byte 11, 13
	Snapper_3: .byte 14, 13
	Snapper_4: .byte 17, 13
	Snapper_5: .byte 20, 15

	Bird_0: .byte 0, 14
	Bird_1: .byte 2, 15
	Bird_2: .byte 5, 16
	Bird_3: .byte 8, 16
	Bird_4: .byte 11, 16
	Bird_5: .byte 14, 16
	Bird_6: .byte 17, 16
	Bird_7: .byte 21, 12

	Snapper_12: .byte 2, 20
	Snapper_11: .byte 5, 20
	Snapper_10: .byte 8, 20
	Snapper_9: .byte 11, 20
	Snapper_8: .byte 14, 20
	Snapper_7: .byte 17, 20
	Snapper_6: .byte 20, 20 

	Key_0: .byte 6, 5
	Key_1: .byte 7, 5
	Key_2: .byte 8, 5
	Key_3: .byte 9, 5

	Pineapple_0: .byte 11, 7
	Pineapple_1: .byte 11, 12
	Pineapple_2: .byte 11, 15
	Pineapple_3: .byte 11, 19

	Cage_1: .byte 0, 5, 0, 4
	Cage_2: .byte 0, 3, 0, 2
	Cage_3: .byte 1, 2, 2, 2
	Cage_4: .byte 3, 2, 3, 3

	



	



	









}



