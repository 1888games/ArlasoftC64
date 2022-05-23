

SOUND: {

		* = * "Sound"

	SoundCooldown:	.byte 50

	



	Crash: {

		//jsr $31F9

		lda #SFX_CRASH
		sta 680

		rts
	}


	Catch: {

		//jsr $31F9

		lda #SFX_CATCH
		sta 681

		rts
	}


	
	





}