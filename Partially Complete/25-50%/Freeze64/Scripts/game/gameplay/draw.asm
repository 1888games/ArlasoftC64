.namespace GRID {

	.label StartX_Left = 1
	.label StartX_Right = 24
	.label StartY = 4

	* = * "Draw"

	RowCharLookup:		.for(var i=0; i<ROWS; i++) {
					.fill COLUMNS, 4
					.fill COLUMNS, 6
					.fill COLUMNS, 8
					.fill COLUMNS, 10
					.fill COLUMNS, 12
					.fill COLUMNS, 14
					.fill COLUMNS, 16
					.fill COLUMNS, 18


				}

				.for(var i=0; i<ROWS; i++) {
					.fill COLUMNS, 4
					.fill COLUMNS, 6
					.fill COLUMNS, 8
					.fill COLUMNS, 10
					.fill COLUMNS, 12
					.fill COLUMNS, 14
					.fill COLUMNS, 16
					.fill COLUMNS, 18

				}
	
	ColumnCharLookup: 	.for(var j=0; j<ROWS; j++) {
					.byte 1, 4, 7, 10, 13
				}
				.for(var j=0; j<ROWS; j++) {
					.byte 24, 27, 30, 33, 36
				}


	TopLeft:		.byte 102, 105, 105, 107, 165, 165, 169, 171
					.byte 110, 113, 113, 115, 174, 174, 178, 179
					.byte 118, 113, 113, 123, 182, 182, 187, 189
					.byte 126, 113, 113, 162, 192, 192, 196, 232

	TopCentre:		.byte 103, 103, 103, 108, 166, 166, 170, 172
					.byte 111, 111, 111, 116, 175, 175, 175, 180
					.byte 119, 121, 121, 124, 183, 185, 188, 190
					.byte 127, 127, 129, 163, 193, 193, 197, 233

	TopRight:		.byte 104, 104, 106, 109, 167, 168, 168, 173
					.byte 112, 112, 114, 117, 176, 177, 177, 181
					.byte 120, 120, 122, 125, 184, 186, 186, 191
					.byte 128, 128, 130, 164, 194, 195, 195, 234

	BottomLeft:		.byte 131, 134, 134, 138, 201, 204, 207, 209
					.byte 141, 144, 144, 147, 212, 212, 212, 217
					.byte 150, 153, 153, 154, 220, 220, 220, 224
					.byte 157, 160, 160, 198, 227, 227, 227, 236


	BottomCentre:	.byte 132, 135, 135, 139, 202, 205, 208, 210
					.byte 142, 145, 145, 148, 213, 215, 215, 218
					.byte 151, 151, 151, 155, 221, 221, 221, 225
					.byte 158, 161, 161, 199, 228, 230, 230, 237


	BottomRight:	.byte 133, 136, 137, 140, 203, 206, 206, 211
					.byte 143, 146, 146, 149, 214, 216, 216, 219
					.byte 152, 152, 152, 156, 222, 223, 223, 226
					.byte 159, 159, 159, 200, 229, 231, 231, 238


	




	// FishID - 1 x 4 + Frame + DirectionLookup

	ClearFish: {

		
		lda #1
		sta ZP.Amount

		lda RowCharLookup, x
		clc
		adc YOffset, x
		tay

		cpy #19
		bcc CanDrawAll

		dec ZP.Amount


		CanDrawAll:

			lda ColumnCharLookup, x 
			tax

			jsr PLOT.GetCharacter

		TopRow:

			ldy #0
			lda #32
			sta (ZP.ScreenAddress), y

			iny
			sta (ZP.ScreenAddress), y

			iny
			sta (ZP.ScreenAddress), y

		CheckInBounds:

			lda ZP.Amount
			beq Finish

		BottomRow:

			lda #32
			ldy #40
			sta (ZP.ScreenAddress), y

			iny
			sta (ZP.ScreenAddress), y

			iny
			sta (ZP.ScreenAddress), y

		Finish:

			ldx ZP.GridID


		rts
	}

	DrawFish: {


		lda #1
		sta ZP.Amount

		lda Frame, x
		sta ZP.CharID

		lda Fish, x
		tay
		lda PLAYER.FishColours, y
		clc
		adc #8
		sta ZP.Colour

		lda RowCharLookup, x
		clc
		adc YOffset, x
		tay

		cpy #19
		bcc CanDrawAll

		dec ZP.Amount

		CanDrawAll:

			lda ColumnCharLookup, x 
			tax

			jsr PLOT.GetCharacter

		TopRow:

			ldx ZP.CharID
			lda TopLeft, x

			ldy #0
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			lda TopCentre, x
			iny
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y


			lda TopRight, x
			iny
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			lda ZP.Amount
			beq Finish

		BottomRow:


			lda BottomLeft, x
			ldy #40
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			lda BottomCentre, x
			iny
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			lda BottomRight, x
			iny
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y

		Finish:

			ldx ZP.GridID

		rts
	}			


	
	/*	

	GREEN_FISH_1_R:	.byte 102, 103, 104, 131, 132, 133
	GREEN_FISH_2_R:	.byte 105, 103, 104, 134, 135, 137
	GREEN_FISH_3_R:	.byte 105, 103, 106, 134, 135, 137
	GREEN_FISH_F_R:	.byte 107, 108, 109, 138, 139, 140
	
	GREEN_FISH_1_L:	.byte 165, 166, 167, 201, 202, 203
	GREEN_FISH_2_L:	.byte 165, 166, 168, 204, 205, 206
	GREEN_FISH_3_L:	.byte 169, 170, 168, 207, 208, 206
	GREEN_FISH_F_L:	.byte 171, 172, 173, 209, 210, 211

	RED_FISH_1_R:	.byte 110, 111, 112, 141, 142, 143
	RED_FISH_2_R:	.byte 113, 111, 112, 144, 145, 146
	RED_FISH_3_R:	.byte 113, 111, 114, 144, 145, 146
	RED_FISH_F_R:	.byte 115, 116, 117, 147, 148, 149
	
	RED_FISH_1_L:	.byte 174, 175, 176, 212, 213, 214
	RED_FISH_2_L:	.byte 174, 175, 177, 212, 215, 216
	RED_FISH_3_L:	.byte 178, 175, 177, 212, 215, 216
	RED_FISH_F_L:	.byte 179, 180, 181, 217, 218, 219

	BLUE_FISH_1_R:	.byte 118, 119, 120, 150, 151, 152
	BLUE_FISH_2_R:	.byte 113, 121, 120, 153, 151, 152
	BLUE_FISH_3_R:	.byte 113, 121, 122, 153, 151, 152
	BLUE_FISH_F_R:	.byte 123, 124, 125, 154, 155, 156
	
	BLUE_FISH_1_L:	.byte 182, 183, 184, 220, 221, 222
	BLUE_FISH_2_L:	.byte 182, 185, 186, 220, 221, 223
	BLUE_FISH_3_L:	.byte 187, 188, 186, 220, 221, 223
	BLUE_FISH_F_L:	.byte 189, 190, 191, 224, 225, 226


	YELLOW_FISH_1_R:	.byte 126, 127, 128, 157, 158, 159
	YELLOW_FISH_2_R:	.byte 113, 127, 128, 160, 161, 159
	YELLOW_FISH_3_R:	.byte 113, 129, 130, 160, 161, 159
	YELLOW_FISH_F_R:	.byte 162, 163, 164, 198, 199, 200
	
	YELLOW_FISH_1_L:	.byte 192, 193, 194, 227, 228, 229
	YELLOW_FISH_2_L:	.byte 192, 193, 195, 227, 230, 231
	YELLOW_FISH_3_L:	.byte 196, 197, 195, 227, 230, 231
	YELLOW_FISH_F_L:	.byte 232, 233, 234, 236, 237, 238
*/



	// FishCharData:	.word GREEN_FISH_1_R, GREEN_FISH_2_R, GREEN_FISH_3_R, GREEN_FISH_F_R
	// 				.word RED_FISH_1_R, RED_FISH_2_R, RED_FISH_3_R, RED_FISH_F_R
	// 				.word BLUE_FISH_1_R, BLUE_FISH_2_R, BLUE_FISH_3_R, BLUE_FISH_F_R
	// 				.word YELLOW_FISH_1_R, YELLOW_FISH_2_R, YELLOW_FISH_3_R, YELLOW_FISH_F_R

	// 				.word GREEN_FISH_1_L, GREEN_FISH_2_L, GREEN_FISH_3_L, GREEN_FISH_F_L
	// 				.word RED_FISH_1_L, RED_FISH_2_L, RED_FISH_3_L, RED_FISH_F_L
	// 				.word BLUE_FISH_1_L, BLUE_FISH_2_L, BLUE_FISH_3_L, BLUE_FISH_F_L
	// 				.word YELLOW_FISH_1_L, YELLOW_FISH_2_L, YELLOW_FISH_3_L, YELLOW_FISH_F_L

}