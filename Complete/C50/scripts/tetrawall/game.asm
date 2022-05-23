GAME: {






	Reset:{

		ldx #48
		lda #0

		Loop:	

		
			sta ZP.BallX_LSB -1, x
			dex
			bne Loop






		rts

	}



	Launch: {







		rts
	}


}