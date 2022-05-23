CHAR_DATA:{


	DataStart: 

		 .word Men_1, Men_2, Men_3, Help_1, Help_2
		 .word Fall_1, Fall_2, Fall_3, Fall_4
		 .word Bounce_1, Bounce_2, Bounce_3
		 .word Fall_5, Fall_6, Fall_7, Fall_8, Fall_9
		 .word Bounce_4, Bounce_5, Bounce_6
		 .word Fall_10, Fall_11, Fall_12
		 .word Ambu_1, Ambu_2, Ambu_3
		 .word Drop_1, Drop_2, Drop_3
		 .word Smoke_1, Smoke_2, Smoke_3, Smoke_4
		 .word Fire_1, Fire_2, Fire_3
	

	ObjectType:
		.fill 3, 0 // men
		.fill 2, 0 // Help
		.fill 4, 0 // column 1
		.fill 3, 0 // column 2
		.fill 5, 0 // column 3
		.fill 3, 0 // column 4
		.fill 3, 0	// column 5
		.fill 3, 0 // ambulance
		.fill 3, 0 // drop
		.fill 4, 0 // smoke
		.fill 3, 2 // fire
		


	TypeColours:
		.byte 0

	Sizes: {

		.if (target == "C64" || target == "264") {

			.byte 28, 34, 34 // 0-2  	// MEN
			.byte 8, 8 // 3-4 he;p
			.byte 16, 14, 16, 16 // 5-8 col 1
			.byte 12, 16, 16 // 9-11 col 2
			.byte 12, 10, 10, 16, 12 // 12-16 col 3
			.byte 16, 16, 20 // 17-19 col 4
			.byte 10, 16, 12 // 20-22 col 5
			.byte 16, 12, 12 // 23-25 Ambu
			.byte 12, 12, 12 // 26-28 Drop
			.byte 6, 8, 8, 8 // 29-32 Smoke
			.byte 8, 16, 12 // 33 - 35 Fire
	
		}

		.if (target == "VIC") {

			.byte 8, 8, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8// 0-11  	// BIRD
			
		
			
		}

		.if (target == "PET") {

			.byte 8, 8, 8, 10, 8, 8, 10, 8, 8, 10, 10, 8// 0-11  	// BIRD
			
		

		}
			


	}


	
	Men_1:	.if (target == "C64" || target == "264") {			
					.byte 6, 18, 7, 18, 6, 19, 6, 20, 7, 19, 8, 19, 9, 19, 10, 19, 11, 19, 12, 19, 13, 19, 12, 18, 12, 17, 13, 18
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Men_2:	.if (target == "C64" || target == "264") {			
					.byte 15, 17, 15, 18, 15, 19, 15, 20, 16, 17, 16, 18, 16, 19, 17, 19, 18, 19, 19, 19, 20, 19, 21, 19, 21, 20, 21, 18, 21, 17, 20, 17, 20, 18
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Men_3:	.if (target == "C64" || target == "264") {			
					.byte 23, 17, 23, 18, 23, 19, 22, 19, 22, 20, 24, 18, 24, 19, 24, 20, 25, 19, 26, 19, 27,19, 28, 19, 28, 18, 29, 17, 29, 18, 29, 19, 28, 20
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Help_1:	.if (target == "C64" || target == "264") {			
					.byte 6, 5, 7, 5, 6, 6, 7, 6
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Help_2:	.if (target == "C64" || target == "264") {			
					.byte 6, 9, 6, 10, 7, 9, 7, 10
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}



	Fall_1:	.if (target == "C64" || target == "264") {			
					.byte 8, 7, 9, 7, 8, 8, 9, 8, 8, 9, 9, 9, 10, 9, 10, 8
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Fall_2:	.if (target == "C64" || target == "264") {			
					.byte 9, 10, 9, 11, 9, 12, 8, 11, 8, 12, 10, 11, 10, 12
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Fall_3:	.if (target == "C64" || target == "264") {			
					.byte 8, 13, 9, 13, 8, 14, 9, 14, 10, 14, 8, 15, 9, 15, 10, 15
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Fall_4:	.if (target == "C64" || target == "264") {			
					.byte 8, 17, 9, 17, 10, 17, 11, 17, 8, 18, 9, 18, 10, 18, 11, 18
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Bounce_1:	.if (target == "C64" || target == "264") {			
					.byte 11, 14, 12, 14, 13, 14, 11, 15, 12, 15, 13, 15
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Bounce_2:	.if (target == "C64" || target == "264") {			
					.byte 11, 10, 12, 10, 11, 11, 12, 11, 13, 11, 11, 12, 12, 12, 13, 12
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}



	Bounce_3:	.if (target == "C64" || target == "264") {			
					.byte 12, 7, 14, 7, 12, 8, 13, 8, 14, 8, 12, 9, 13, 9, 14, 9
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}




	Fall_5:	.if (target == "C64" || target == "264") {			
					.byte 15, 6, 16, 6, 17, 6, 15, 7, 16, 7, 17, 7
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Fall_6:	.if (target == "C64" || target == "264") {			
					.byte 16, 8, 17, 8, 15, 9, 16, 9, 17, 9
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}
	


	Fall_7:	.if (target == "C64" || target == "264") {			
					.byte 17, 10, 16, 11, 17, 11, 16, 12, 17, 12 
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Fall_8:	.if (target == "C64" || target == "264") {			
					.byte 16, 13, 17, 13, 16, 14, 17, 14, 18, 14,16, 15, 17, 15, 18, 15
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Fall_9:	.if (target == "C64" || target == "264") {			
					.byte 17, 17, 18, 17, 19, 17, 17, 18, 18, 18, 19, 18
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Bounce_4:	.if (target == "C64" || target == "264") {			
					.byte 19, 13, 20, 13, 19, 14, 20, 14, 21, 14, 19, 15, 20, 15, 21, 15
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Bounce_5:	.if (target == "C64" || target == "264") {			
					.byte 21, 10, 22, 10, 20, 11, 21, 11, 22, 11, 20, 12, 21, 12, 22, 12
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Bounce_6:	.if (target == "C64" || target == "264") {			
					.byte 21, 7, 22, 7, 23, 7, 24, 7, 21, 8, 22, 8, 23, 8, 24, 8, 22, 9, 23, 9
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}
	
	Fall_10:	.if (target == "C64" || target == "264") {			
					.byte 25, 10, 24, 11, 25, 11, 24, 12, 25, 12
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Fall_11:	.if (target == "C64" || target == "264") {			
					.byte 24, 13, 25, 13, 24, 14, 25, 14, 26, 14, 24, 15, 25, 15, 26, 15
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Fall_12:	.if (target == "C64" || target == "264") {			
					.byte 25, 17, 26, 17, 27, 17, 25, 18, 26, 18, 27, 18
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Ambu_1:		.if (target == "C64" || target == "264") {			
					.byte 27, 13, 28, 13, 27, 14, 28, 14, 29, 14, 27, 15, 28, 15, 29, 15
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Ambu_2:		.if (target == "C64" || target == "264") {			
					.byte 29, 11, 30, 11, 31, 11, 29, 12, 30, 12, 31, 12
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Ambu_3:		.if (target == "C64" || target == "264") {			
					.byte 30, 14, 31, 14, 32, 14, 30, 15, 31, 15, 32, 15
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Drop_1:		.if (target == "C64" || target == "264") {			
					.byte 9, 20, 10, 20, 11, 20, 9, 21, 10, 21, 11, 21
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}
	

	Drop_2:		.if (target == "C64" || target == "264") {			
					.byte 17, 20, 18, 20, 19, 20, 17, 21, 18, 21, 19, 21
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}
	

	Drop_3:		.if (target == "C64" || target == "264") {			
					.byte 25, 20, 26, 20, 27, 20, 25, 21, 26, 21, 27, 21
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Smoke_1:	.if (target == "C64" || target == "264") {			
					.byte 12, 3, 12, 4, 12, 5
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Smoke_2:	.if (target == "C64" || target == "264") {			
					.byte 13, 2, 13, 3, 13, 4, 13, 5
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}


	Smoke_3:	.if (target == "C64" || target == "264") {			
					.byte 15, 1, 15, 2, 15, 3, 15, 4
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Smoke_4:	.if (target == "C64" || target == "264") {			
					.byte 17,1, 17, 2, 17, 3, 17, 4
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Fire_1:		.if (target == "C64" || target == "264") {			
					.byte 6, 1, 7, 1, 8, 1, 9, 1
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}

	Fire_2:		.if (target == "C64" || target == "264") {			
					.byte 6, 2, 7, 2, 8, 2, 9, 2, 10, 2, 8, 3, 9, 3, 10, 3
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}
	
	Fire_3:		.if (target == "C64" || target == "264") {			
					.byte 8, 4, 9, 4, 10, 4, 8, 5, 9, 5, 10, 5
				}

				.if (target == "VIC") {
					.byte 0, 9, 1, 9, 0, 10, 1, 10
				}

				.if (target == "PET") {
					.byte 1, 6, 2, 6, 3, 6, 2, 7
				}
	
	
	
	
	
	
	
	
	


	


}