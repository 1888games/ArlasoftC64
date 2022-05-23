SOUND_DATA: {


	DataStart: 

		 .word SoundTest
		 .word MenMoveLeft, JumperMove, MenMoveRight, Bounce, Died, GameOver, StartSound, ScoreSound

	

	SongLength:
		 .byte 35, 0, 0, 0, 1, 1, 5, 35, 1, 2

	SoundTest:	.byte 0, 20, 1, 20, 2, 20, 3, 20, 4, 20, 5, 20, 6, 20, 7, 20, 8, 20, 9, 20, 10, 20, 11, 20
				.byte 12, 20, 13, 20, 14, 20, 15, 20, 16, 20, 17, 20, 18, 20, 19, 20, 20, 20, 21, 20, 22, 20, 23, 20
				.byte 24, 20, 25, 20, 26, 20, 27, 20, 28, 20, 29, 20, 30, 20, 31, 20, 32, 20, 33, 20, 34, 20, 35, 20	

	MenMoveLeft: 	.byte 12, 2
	JumperMove: 	.byte 40, 2
	MenMoveRight:	.byte 16, 2
	Bounce:			.byte 18, 4, 36, 4
	Died:			.byte 6, 6, 0, 30
	GameOver:		.byte 6, 6, 0, 12, 20, 1, 0, 20, 12, 1, 0, 20
	StartSound:		.byte 0, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1, 10, 1, 11, 1
					.byte 12, 1, 13, 1, 14, 1, 15, 1, 16, 1, 17, 1, 18, 1, 19, 1, 20, 1, 21, 1, 22, 1, 23, 1
					.byte 24, 1, 25, 1, 26, 1, 27, 1, 28, 1, 29, 1, 30, 1, 31, 1, 32, 1, 33, 1, 34, 1, 35, 1	
	ScoreSound:		.byte 12, 4, 18, 4, 24, 4
					

}