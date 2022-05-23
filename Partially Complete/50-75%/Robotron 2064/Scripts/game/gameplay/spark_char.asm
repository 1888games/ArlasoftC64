SPARK: {


	* = * "Spark"

	.label MAX_SPARKS = 20
	.label StartCharID = 218

	NumberActive:		.byte 0
	TotalFired:			.byte 0

	XCurvature:		.fill MAX_SPARKS, 0
	YCurvature:		.fill MAX_SPARKS, 0
	XDeltaLSB:		.fill MAX_SPARKS, 0
	XDeltaMSB:		.fill MAX_SPARKS, 0
	YDeltaLSB:		.fill MAX_SPARKS, 0
	YDeltaMSB:		.fill MAX_SPARKS, 0
	XFrac:			.fill MAX_SPARKS, 0
	YFrac:			.fill MAX_SPARKS, 0
	XPositive:		.fill MAX_SPARKS, 0
	YPositive:		.fill MAX_SPARKS, 0
	Offset:			.fill MAX_SPARKS, 0

	CharX:			.fill MAX_SPARKS, 0
	CharY:			.fill MAX_SPARKS, 0

	ScreenAddress_LSB:	.fill MAX_SPARKS, 0
	ColourAddress_LSB:	.fill MAX_SPARKS, 0
	ScreenAddress_MSB:	.fill MAX_SPARKS, 0
	ColourAddress_MSB:	.fill MAX_SPARKS, 0

	Frame:			.byte 0
	Colour:			.byte RED


	Initialise: {

		lda #0
		sta NumberActive
		sta Frame

		ldx #0

		Loop:

			lda #255
			sta CharX, x

			inx
			cpx #MAX_SPARKS
			bcc Loop

		rts
	}

	GetNextID: {

		ldx #0


		Loop:

			lda CharX, x
			bmi Found

			EndLoop:

			inx
			cpx #MAX_SPARKS
			bcc Loop

		Found:

		rts
	}


	Spawn: {

		CheckAvailable:

			lda NumberActive
			cmp #MAX_SPARKS
			bcc SparkAvailable

			rts

		SparkAvailable:

			inc TotalFired
			inc NumberActive

			jsr GetNextID

		Setup:

			stx ZP.CurrentID

			lda #0
			sta YFrac, x
			sta XFrac, x
			sta XDeltaLSB, x
			sta YDeltaLSB, x
			sta XDeltaMSB, x
			sta YDeltaMSB, x
			sta Offset, x


			lda ZP.Row
			sta CharY, x
			tay

			lda ZP.Column
			sta CharX, x
			tax

			jsr PLOT.GetCharacter

			ldx ZP.CurrentID

			lda ZP.ScreenAddress
			sta ScreenAddress_LSB, x

			lda ZP.ScreenAddress + 1
			sta ScreenAddress_MSB, x

			lda ZP.ColourAddress
			sta ColourAddress_LSB, x

			lda ZP.ColourAddress + 1
			sta ColourAddress_MSB, x

			jsr Draw


		Finish:

		rts
	}


	Draw: {

		ldy #0
		lda (ZP.ScreenAddress), y
		bne DontDraw

		lda Offset, x
		asl
		adc Frame
		adc #StartCharID
		sta (ZP.ScreenAddress), y

		lda Colour
		sta (ZP.ColourAddress), y


		DontDraw:





		rts
	}


	Process: {






		rts
	}



	FrameUpdate: {

		ldx #0


		Loop:

			lda CharX, x
			bmi EndLoop

			jsr Process

			EndLoop:

			inx
			cpx TotalFired
			bcs Finish

			cpx #MAX_SPARKS
			bcc Loop



		Finish:




		rts
	}




	
}