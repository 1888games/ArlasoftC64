PAC_RAND: {


	* = * "RandCode"

	Get: {

		ldy #0
		lda (ZP.RandomSeed), y
		pha

		lda ZP.RandomSeed
		clc
		adc #1
		sta ZP.RandomSeed
		
		lda ZP.RandomSeed + 1
		adc #0
		sta ZP.RandomSeed + 1

		cmp #$a0
		bcc NoWrap

		lda #$80
		sta ZP.RandomSeed

		NoWrap:

		pla


		rts


	}
	






}