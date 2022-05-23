SHARED: {

	* = * "Shared"


	PixelSafeAreaLeft:		.byte 088, 096, 104, 108, 117, 122
	PixelSafeAreaRight:		.byte 214, 192, 184, 181, 174, 172
	PixelSafeAreaTop:		.byte 076, 076, 092, 098, 103, 106
	PixelSafeAreaBottom:	.byte 172, 172, 156, 146, 139, 142

	CharSafeAreaLeft:		.byte 009, 010, 011, 011, 012, 013
	CharSafeAreaRight:		.byte 022, 021, 020, 020, 019, 019
	CharSafeAreaTop:		.byte 003, 003, 005, 006, 006, 007
	CharSafeAreaBottom:		.byte 015, 015, 013, 012, 011, 011 



	CurrentPixelSafeLeft:	.byte 0
	CurrentPixelSafeRight:  .byte 0
	CurrentPixelSafeTop:	.byte 0
	CurrentPixelSafeBottom: .byte 0

	CurrentCharSafeLeft:	.byte 0
	CurrentCharSafeRight:  	.byte 0
	CurrentCharSafeTop:		.byte 0
	CurrentCharSafeBottom: 	.byte 0





	SetupData: {

		jsr GetSafeAreas



		rts
	}


	GetSafeAreas: {

		ldx LEVEL_DATA.CurrentLevel
		cpx #6
		bcc Okay

		ldx #5

		Okay:

			lda PixelSafeAreaLeft, x
			sta CurrentPixelSafeLeft

			lda PixelSafeAreaRight, x
			sta CurrentPixelSafeRight

			lda PixelSafeAreaTop, x
			sta CurrentPixelSafeTop

			lda PixelSafeAreaBottom, x
			sta CurrentPixelSafeBottom

			lda CharSafeAreaLeft, x
			sta CurrentCharSafeLeft

			lda CharSafeAreaRight, x
			sta CurrentCharSafeRight

			lda CharSafeAreaTop, x
			sta CurrentCharSafeTop

			lda CharSafeAreaBottom, x
			sta CurrentCharSafeBottom



		rts
	}


	GetRandomCharAny: {

		GetX:

			jsr RANDOM.Get
		 	and #%00011111
		 //	clc
		 //	adc #1
			sta ZP.Column

		GetY:

			jsr RANDOM.Get
			and #%00011111
			cmp #24
			bcs GetY

			sta ZP.Row

		rts
	}

	GetRandomCharPosition: {

		GetX:

			jsr RANDOM.Get
		 	and #%00011111
		 //	clc
		 //	adc #1
			sta ZP.Column

		GetY:

			jsr RANDOM.Get
			and #%00011111
			cmp #24
			bcs GetY

			sta ZP.Row

			cmp CharSafeAreaTop
			bcc Okay

			cmp CharSafeAreaBottom
			bcs Okay

		OkayY:

			lda ZP.Column
			cmp CharSafeAreaLeft
			bcc Okay

			cmp CharSafeAreaRight
			bcs Okay

			jmp GetY

		Okay:



		rts
	}








}