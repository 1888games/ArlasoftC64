	GetRandNum: {

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



	TwosCompliment: {
		
			L7708:  adc #$FF                //
			L770A:  clc                     //Calculate the 2's compliment of the value in A.
			L770B:  adc #$01                //
			L770D:  rts                     //

	}




