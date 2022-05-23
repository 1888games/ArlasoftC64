TOKEN: {


	Type: 		.byte 0
	CharX:		.byte 0
	CharY:		.byte 0

	Types:		.byte 0, 0, 0, 1, 1, 2, 2, 3

	Collected:	.byte 0

	Generate: {

		jsr RANDOM.Get
		and #%00000111
		tax

		lda Types, x
		sta Type

		jsr RANDOM.Get
		and #%00011111
		clc
		adc #4
		sta CharX

		Again:

			jsr RANDOM.Get
			and #%00000111
			clc
			adc #5
			sta CharY

			cmp #14
			bcc Okay



		lda CharX
		cmp #21
		beq Again

		cmp #22
		beq Again

		Okay:

			ldx CharX
			ldy CharY

			lda #0
			sta Collected


		rts
	}


}