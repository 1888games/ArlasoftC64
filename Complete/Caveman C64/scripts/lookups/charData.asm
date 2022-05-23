CHAR_DATA:{


	DataStart: 

		.word Top_Leave, Got_Egg, Miss_Egg, Swoop_Egg, Top_1, Top_2
		.word Top_3, Top_4, Bottom_1, Bottom_2, Bottom_3, Bottom_4
		.word On_Tee, Egg_1, Egg_2, Egg_3, Egg_4, Egg_Front, Egg_Back, Egg_Open
		.word Baby1, Lava_1, Lava_2, Lava_3, Stars, Breath, Head_Up
		.word Man_0, Man_1, Man_2, Man_3, Man_4, Man_5, Died_1, Died_2, Died_3, Died_4
		.word Away, Fire, Star, Wobble, Lava_Crack, Egg_Legs, Baby2, Tongue, Baby1Back, Baby2Back
		.word Eggs1, Eggs2, Eggs3, Eggs4, Eggs5, Eggs6, Eggs7, Eggs8, FireText



	ObjectType:
		.fill 12, 0 // bird
		.fill 8, 1 // egg
		.fill 1, 2 // babies
		.fill 3, 3 // lava
		.fill 1, 4 // stars
		.fill 2, 5 // dino
		.fill 6, 6 // man
		.fill 4, 7 // died
		.fill 1, 5 // dino away
		.fill 1, 8 // fire
		.fill 2, 9 // starWobble
		.fill 1, 3 // lava_crack
		.fill 1, 1 // egg legs
		.fill 1, 2 // baby2
		.fill 1, 3 // tongue
		.fill 2, 4	// babybacks
		.fill 8, 1 // eggsCave
		.fill 1, 9 // text



	TypeColours:
		.byte 4, 1, 3, 2, 5, 5, 6, 2, 2, 7

	Sizes: {


		// BIRD
		.byte 16, 22, 20, 28, 12, 12 // 0-5
		.byte 14, 14, 18, 16, 12, 14 // 6-11

		// EGGS
		.byte 6, 4, 6, 4, 4, 4, 4, 4 // 12- 19

		// BABIES EGGS

		.byte 6 // 20

		// LAVA

		.byte 6, 6, 36 // 21-23

		// STARS

		.byte 6 //24

		// DINO

		.byte 24, 12 // 25-26

		// MAN

		.byte 4, 8, 4, 6, 4, 8 // 27-32

		// DIED

		.byte 4, 4, 4, 4 // 33-36

		// DINO AWAY

		.byte 6		// 37

		// DINO SECONDARY

		.byte 6, 2, 6 // 38, 39, 40

		// LAVA CRACK

		.byte 8  // 41

		// Egg Legs

		.byte 4 // 42

		// Baby 2

		.byte 6 // 43

		// Tongue

		.byte 2 // 44

		// Baby1Back

		.byte 2 // 45


		// Baby2Back

		.byte 2 // 46

		//Eggs
		.byte 2 // 47
		.byte 2 // 48
		.byte 2 // 49
		.byte 2 // 50
		.byte 2 // 51
		.byte 2 // 52
		.byte 2 // 53
		.byte 2 // 54

		.byte 10 // test

	}
	
	Top_Leave:	.byte 0, 6, 1, 6, 2, 6, 3, 6
				.byte 0, 7, 1, 7, 2, 7, 3, 7	 // top leave

	Got_Egg:	.byte 0, 8, 1, 8, 2, 8, 3, 8
				.byte 0, 9, 1, 9, 2, 9, 3, 9
				.byte 1, 10, 2, 10, 3, 10 // got egg

	Miss_Egg:	.byte 6, 6, 7, 6, 8, 6
				.byte 5, 7, 6, 7, 7, 7, 8, 7
				.byte 6, 8, 7, 8, 8, 8 // miss egg

	Swoop_Egg:	.byte 6, 9, 7, 9, 8, 9
				.byte 6, 10, 7, 10, 8, 10
				.byte 6, 11, 7, 11, 8, 11, 9, 11
				.byte 5, 12, 6, 12, 8, 12
				.byte 6, 13  // swoop egg

	Top_1:		.byte 11, 3
				.byte 10, 4, 11, 4, 12, 4
				.byte 11, 5, 12, 5 // top 1

	Top_2: 		.byte 14, 4, 15, 4, 16, 4
				.byte 14, 5, 15, 5, 16, 5, 17, 5 // top 2

	Top_3:		.byte 18, 4, 19, 4, 20, 4, 21, 4
				.byte 18, 5, 19, 5, 20, 5 // top 3
				
	Top_4:		.byte 22, 4, 23, 4, 24, 4, 25, 4
				.byte 22, 5, 23, 5, 24, 5 // top 4

	Bottom_1:	.byte 10, 6, 11, 6, 12, 6
				.byte 10, 7, 11, 7, 12, 7
				.byte 10, 8, 11, 8, 12, 8 // bottom 1

	Bottom_2:	.byte 14, 6, 15, 6, 16, 6, 17, 6
				.byte 14, 7, 15, 7, 16, 7, 17, 7 // bottom 2

	Bottom_3:	.byte 18, 6, 19, 6, 20, 6
				.byte 18, 7, 19, 7, 20, 7 // bottom 3

	Bottom_4:	.byte 22, 6, 23, 6, 24, 6, 25, 6 
				.byte 23, 7, 24, 7, 25, 7 // bottom 4


				// EGG

	On_Tee:		.byte 5, 13
				.byte 4, 14, 5, 14  // on tee

	Egg_1:		.byte 10, 13
				.byte 10, 14 // man 1

	Egg_2:		.byte 16, 13
				.byte 16, 14, 17, 14 // man 2

	Egg_3:		.byte 18, 13
				.byte 18, 14 // man 3

	Egg_4:		.byte 24, 13
				.byte 24, 14 // man 4

	Egg_Front:	.byte 28, 14
				.byte 28, 15 // dino front

	Egg_Back:	.byte 34, 14
				.byte 34, 15 // dino back

	Egg_Open:	
				.byte 35, 15, 36, 15  // egg open


				// BABIES

	Baby1:		.byte 36, 13
				.byte 35, 14, 36, 14
				// LAVA

	Lava_1:  	.byte 36, 7, 37, 7, 38, 7 // bottom

	Lava_2:		.byte 36, 6, 37, 6, 38, 6 // middle

	Lava_3:		.byte 35, 3, 36, 3, 37, 3, 38, 3
				.byte 35, 4, 36, 4, 37, 4, 38, 4, 39,4  // top
				.byte 35, 5, 36, 5, 37, 5, 38, 5  // top
				.byte 28, 3, 29, 3, 30, 3, 31, 3, 32, 3

				// STARS

	Stars:		.byte 31, 5, 33, 5
				.byte 33, 6


				// DINO

	Breath:		.byte 28, 7, 29, 7
				.byte 27, 8, 28, 8
				.byte 26, 9, 27, 9, 28, 9
				.byte 26, 10, 27, 10
				.byte 27, 11, 28, 11, 30, 7  // breath fire

	Head_Up:	.byte 28, 4, 29, 4
				.byte 28, 5, 29, 5
				.byte 28, 6, 30, 7  // head up




				// MAN

	Man_0: 		.byte 7, 15, 8, 15


	Man_1:		.byte 11, 12
				.byte 11, 13, 12, 13
				.byte 11, 14 // 1

	Man_2:		.byte 15, 13 
				.byte 15, 14 // 2

	Man_3:		.byte 19, 13, 20, 13
				.byte 19, 14 // 3

	Man_4:		.byte 23, 13
				.byte 23, 14 // 4

	Man_5:		.byte 26, 14, 27, 14
				.byte 26, 15, 27, 15 // 5

				// DIED

	Died_1:		.byte 10, 15, 11, 15 // 1
	Died_2:		.byte 15, 15, 16, 15 // 2
	Died_3:		.byte 18, 15, 19, 15 // 3
	Died_4:		.byte 23, 15, 24, 15 // 4


	Away:		.byte 32, 7, 33, 7
				.byte 33, 8


	Fire:		.byte 26, 12, 27, 12, 28, 12
	
	Star:		.byte 27, 7

	Wobble:		.byte 32, 5
				.byte 31, 6, 32, 6


	Lava_Crack:	.byte 37, 9
				.byte 36, 10, 37, 10, 38, 10

	Egg_Legs:	.byte 31, 14
				.byte 31, 15

	Baby2:		.byte 38, 14
				.byte 37, 15, 38, 15

	Tongue:		.byte 37, 13

	Baby1Back:	.byte 35, 13

	Baby2Back:	.byte 37, 14

	Eggs1: .byte 3, 14
	Eggs2: .byte 2, 14
	Eggs3: .byte 1, 14
	Eggs4: .byte 3, 13
	Eggs5: .byte 2, 13
	Eggs6: .byte 1, 13
	Eggs7: .byte 2, 12
	Eggs8: .byte 1, 12

	FireText: .byte 18, 10, 19, 10, 20, 10, 21, 10, 22, 10










}