
RANDOM: {	

	* = * "Random"

	//RandomAdd:	.byte random() * 256

	Get: {

		// lda seed
  //       beq doEor
  //       asl
  //       beq noEor
  //       bcc noEor
		// doEor:  
		// 	eor #$1d
		// noEor:  
		// 	sta seed

		lda $D41B
		//clc
		//adc ZP.Counter
		//adc RandomAdd
		rts

	}

	
	
	}

	



