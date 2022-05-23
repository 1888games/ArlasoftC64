
	* = $1ed "Variables"
	    //This area can be used for runtime vars
	    //Once prg is loaded (1ed-1ff = 18 bytes)
	    //But is bashed by the loading process

	* = $1f8 "System - override return" //Override return from load vector on stack         
	    .byte <[MAIN.Entry-1], >[MAIN.Entry-1]



	* = $314 "System - IRQ/NMI" //IRQ, BRK and NMI Vectors
	    .byte $31, $ea, $66, $fe, $47,$fe
	    //Keep the following vectors also
	    .byte $4a,$f3,$91,$f2,$0e,$f2
	    .byte $50,$f2,$33,$f3,$57,$f1,$c1,$f1
	    .byte $ed,$f6 //STOP vector - Essential to avoid JAM


	
   