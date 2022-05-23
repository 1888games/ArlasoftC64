PIECE_DATA: {



	Piece_1_0:		.byte 1
	Piece_1_90:		.byte 1
	Piece_1_180:	.byte 1
	Piece_1_270:	.byte 1
			

	Piece_2_0:		.byte 1, 1
					.byte 0, 0

	Piece_2_90:		.byte 1, 0
					.byte 1, 0

	Piece_2_180:	.byte 1, 1
					.byte 0, 0

	Piece_2_270:	.byte 1, 0
					.byte 1, 0


	Piece_3_0:		.byte 1, 1, 1
					.byte 0, 0, 0
					.byte 0, 0, 0

	Piece_3_90:		.byte 1, 0, 0
					.byte 1, 0, 0
					.byte 1, 0, 0

	Piece_3_180:	.byte 1, 1, 1
					.byte 0, 0, 0
					.byte 0, 0, 0


	Piece_3_270:	.byte 1, 0, 0
					.byte 1, 0, 0
					.byte 1, 0, 0


	Piece_4_0:		.byte 1, 1, 1, 1
					.byte 0, 0, 0, 0
					.byte 0, 0, 0, 0
					.byte 0, 0, 0, 0

	Piece_4_90:		.byte 1, 0, 0, 0
					.byte 1, 0, 0, 0
					.byte 1, 0, 0, 0
					.byte 1, 0, 0, 0

	Piece_4_180:	.byte 1, 1, 1, 1
					.byte 0, 0, 0, 0
					.byte 0, 0, 0, 0
					.byte 0, 0, 0, 0

	Piece_4_270:	.byte 1, 0, 0, 0
					.byte 1, 0, 0, 0
					.byte 1, 0, 0, 0
					.byte 1, 0, 0, 0



	Piece_5_0:		.byte 1, 1
					.byte 1, 1

	Piece_5_90:		.byte 1, 1
					.byte 1, 1

	Piece_5_180:	.byte 1, 1
					.byte 1, 1

	Piece_5_270:	.byte 1, 1
					.byte 1, 1




	Piece_6_0:		.byte 1, 0
					.byte 1, 1

	Piece_6_90:		.byte 1, 1
					.byte 1, 0

	Piece_6_180:	.byte 1, 1
					.byte 0, 1

	Piece_6_270:	.byte 0, 1
					.byte 1, 1


	Piece_7_0:		.byte 1, 0, 0
					.byte 1, 0, 0
					.byte 1, 1, 0

	Piece_7_90:		.byte 1, 1, 1
					.byte 1, 0, 0
					.byte 0, 0, 0

	Piece_7_180:	.byte 1, 1, 0
					.byte 0, 1, 0
					.byte 0, 1, 0


	Piece_7_270:	.byte 0, 0, 1
					.byte 1, 1, 1
					.byte 0, 0, 0



	Piece_8_0:		.byte 0, 1, 0
					.byte 0, 1, 0
					.byte 1, 1, 0

	Piece_8_90:		.byte 1, 0, 0
					.byte 1, 1, 1
					.byte 0, 0, 0

	Piece_8_180:	.byte 1, 1, 0
					.byte 1, 0, 0
					.byte 1, 0, 0


	Piece_8_270:	.byte 1, 1, 1
					.byte 0, 0, 1
					.byte 0, 0, 0


	Pieces:			.word Piece_1_0, Piece_2_0, Piece_3_0, Piece_4_0, Piece_5_0, Piece_6_0, Piece_7_0, Piece_8_0
					.word Piece_1_90, Piece_2_90, Piece_3_90, Piece_4_90, Piece_5_90, Piece_6_90, Piece_7_90, Piece_8_90
					.word Piece_1_180, Piece_2_180, Piece_3_180, Piece_4_180, Piece_5_180, Piece_6_180, Piece_7_180, Piece_8_180
					.word Piece_1_270, Piece_2_270, Piece_3_270, Piece_4_270, Piece_5_270, Piece_6_270, Piece_7_270, Piece_8_270




	Sizes:		.byte 1, 2, 3, 4, 2, 2, 3, 3
				.byte 1, 2, 3, 4, 2, 2, 3, 3
				.byte 1, 2, 3, 4, 2, 2, 3, 3
				.byte 1, 2, 3, 4, 2, 2, 3, 3

	StartX:		.byte 3, 2, 1, 0, 2, 2, 1, 1
				.byte 3, 2, 1, 0, 2, 2, 1, 1
				.byte 3, 2, 1, 0, 2, 2, 1, 1
				.byte 3, 2, 1, 0, 2, 2, 1, 1


	StartY:		.byte 2, 2, 2, 2, 2, 2, 2, 2
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 2, 2, 2, 2, 2, 2, 2, 2
				.byte 0, 0, 0, 0, 0, 0, 0, 0



	GetData: {

		ldy ZP.PieceID
		lda Sizes, y
		sta ZP.Size

		lda StartX, y
		clc
		adc ZP.StartX
		sta ZP.StartX

		lda StartY, y
		clc
		adc ZP.StartY
		sta ZP.StartY

		tya
		asl
		tay

		lda Pieces, y
		sta ZP.PieceAddress

		lda Pieces + 1, y
		sta ZP.PieceAddress + 1


		rts
	}




	
}