plaYER: {



	Cards:	.fill 16, 99

	ChipsLow:	.byte 0, 0, 0, 0, 0, 0, 0, 0
	ChipsMed:	.byte 0, 0, 0, 0, 0, 0, 0, 0
	ChipsHigh:	.byte 0, 0, 0, 0, 0, 0, 0, 0



	// 0 = out of game
	// 1 = yet to act
	// 2 = folded
	// 3 = checked
	// 4 = called
	// 5 = bet
	// 6 = raised

	
	
	Handstatus:	.byte 0, 0, 0, 0, 0, 0, 0, 0
	AllIn:		.byte 0, 0, 0, 0, 0, 0, 0, 0
	HandShown:	.byte 0, 0, 0, 0, 0, 0, 0, 0

	

}