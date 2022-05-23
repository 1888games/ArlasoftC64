INTERFACE: {
	
	*= $2000 "Shared Variables" 	
	FlashBorder:	.byte 0

	
	*=$2100 "Interface Code"
	
	Update: {


		 lda FlashBorder
		 beq Finish

		 inc $d021
		

		Finish:	
			rts

	}



}