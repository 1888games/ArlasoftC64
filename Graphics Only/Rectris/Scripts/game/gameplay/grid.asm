GRID: {


	.label ROWS = 13
	.label COLUMNS = 13


	PlayerOne:	.fill ROWS * COLUMNS, 255
	PlayerTwo:	.fill ROWS * COLUMNS, 255

	PlayerOffset:	.byte 0, ROWS * COLUMNS








	NewGame: {


		rts
	}


	
}