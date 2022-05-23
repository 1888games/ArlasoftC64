SLOTS: {



	//Columns:	.byte 7, 10, 17, 20, 27, 30, 34, 37, 27, 30,  17, 20, 7, 10, 0, 3, 12, 15, 18, 21, 24
	//Rows:		.byte 0, 0, 0, 0, 0, 0, 10, 10,  21, 21, 21, 21, 21, 21, 10, 10, 10, 10, 10, 10, 10, 10

	Columns:	.byte 7, 17, 27, 34, 27, 17, 7, 0
				.byte 10, 20, 30, 37, 30, 20, 10, 3
				.byte 12, 15, 18, 21, 24

	Rows:		.byte 0, 0, 0, 10, 21, 21, 21, 10
				.byte 0, 0, 0, 10, 21, 21, 21, 10
				.byte 10, 10, 10, 10, 10

	NameRows:	.byte 3, 3, 3, 13, 20, 20, 20, 13
	BankRows:	.byte 4, 4, 4, 14, 19, 19, 19, 14
	TextRows:	.byte 5, 5, 5, 15, 18, 18, 18, 15
	BetRows:	.byte 7, 7, 7, 13, 16, 16, 16, 13
	ChipRows:	.byte 8, 7, 8, 12, 16, 16, 16, 12
	ButtonRows:	.byte 8, 8, 8, 12, 15, 15, 15, 12

	BetColumns:	.byte 9, 17, 26, 26, 26, 17, 9, 8
	ButtonColumns:	.byte 11, 19, 28, 29, 29, 19, 11, 10


	Shown:		.byte 1, 0, 0, 0, 0, 0, 0, 0
				.byte 1, 0, 0, 0, 0, 0, 0, 0
				.byte 1, 1, 1, 1, 1

	XPosLSB:	.fill 29, 26 + (i * 8)
				.fill 11, i * 8
	XPosMSB:	.fill 29, 0
				.fill 11, 1
	YPos:		.fill 25, 52 + (i * 8)


	NextSlotID:	.byte 0

	

}