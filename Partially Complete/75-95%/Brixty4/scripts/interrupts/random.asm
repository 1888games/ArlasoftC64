
RANDOM: {

	RandomAdd: .byte 0

	IntegerLookup:

	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9


	Get: {

		jsr Get2

		adc $D41B

		//lda $D41B
		//adc ZP_COUNTER
		//adc RandomAdd

		rts

	}

	init2: {
			lda #$7f
			sta $dc04
			lda #$33
			sta $dc05
			lda #$2f
			sta $dd04
			lda #$79
			sta $dd05

			lda #$91
			sta $dc0e
			sta $dd0e
			rts

		}

	Get2: {
	        lda seed
	        beq doEor
	        asl
	        beq noEor
	        bcc noEor
	    doEor:    
	        eor #$1d
	        eor $dc04
	        eor $dd04
	    noEor:  
	        sta seed
	        rts
	    seed:
	        .byte $62
	}



	Change: {


		lda RandomAdd
		adc #2
		sta RandomAdd

		rts
	}
    
    init: 

    	jsr init2
       
        lda #$FF  // maximum frequency values
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register
		rts
		


	Integer:

		.label value = TEMP12

		tya
		pha
		txa
		pha

		jsr Get
		tax

		lda IntegerLookup, x
		sta value

		pla
		tax
		pla
		tay

		lda value

		rts




	}



