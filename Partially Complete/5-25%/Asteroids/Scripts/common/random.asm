RANDOM: {	

	* = * "-Random"

	RandomAdd: .byte 0


	Get: {

		jsr Get2

		adc $D41B

		//lda $D41B
		adc ZP.Counter
		adc RandomAdd

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



    
    init: 

    	jsr init2
       
        lda #$FF  // maximum frequency values
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register
		rts
		


	GetRandNum:
	L77B5:  asl RandNumLB           //
	L77B7:  rol RandNumUB           //Use a shift register to store the random number.
	L77B9:  bpl RandNumbit          //

	L77BB:  inc RandNumLB           //increment lower byte.

	RandNumbit:
	L77BD:  lda RandNumLB           //If the second bit set in the random number?
	L77BF:  bit RandNumbitTbl       //
	L77C2:  beq RandNumORUB         //If not, branch to move on.

	L77C4:  adc #$01                //Invert LSB of random number.
	L77C6:  sta RandNumLB           //

	RandNumORUB:
	L77C8:  ora RandNumUB           //Is new random number = 0?
	L77CA:  bne RandNumDone         //If not, branch to exit.

	L77CC:  inc RandNumLB           //Ensure random number is never 0.

	RandNumDone:
	L77CE:  lda RandNumLB           //Return lower byte or random number.
	L77D0:  rts                     //

	RandNumbitTbl:
	L77D1:  .byte $02               //Used by random number generator above.



	}