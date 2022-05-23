MONKEYDATA:{
	Row:
		.byte 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3

	Column:
		.byte 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5

	ReplacementObjectID:
		.byte 99, 99, 99, 99, 99, 99
		.byte  

	WillFall: 
		.byte 0, 0, 0, 0, 0, 0
		.byte 0, 1, 0, 0, 1, 0
		.byte 0, 0, 0, 0, 0, 0
		.byte 0, 0, 1, 1, 0, 0

	OnVine:
		.byte 0, 0, 0, 0, 0, 0
		.byte 1, 0, 1, 1, 0, 1
		.byte 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 1, 0

	CanJump:
		.byte 1, 1, 1, 1, 1, 1
		.byte 0, 0, 0, 0, 0, 0
		.byte 0, 1, 1, 1, 1, 0
		.byte 0, 0, 0, 0, 0, 0

	SwingOverEnemyID:
		.byte 0, 0, 0, 0, 0, 0
		.byte 16, 0, 0, 0, 19, 0
		.byte 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0


	CanMoveRight:
		.byte 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0

	CheckWhenMovingRight:
		.byte 15, 16, 17, 18, 19, 20
		.byte 98, 98, 98, 98, 98, 98
		.byte 98, 98, 98, 98, 98, 98
		.byte 98, 98, 98, 98, 98, 98

	CheckWhenMovingLeft:
		.byte 98, 98, 98, 98, 98, 98
		.byte 98, 8, 9, 10, 11, 12
		.byte 98, 98, 1,2,3,4
		.byte 98, 98, 98, 98, 98, 98




}