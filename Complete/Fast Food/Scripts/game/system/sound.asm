

SOUND: {

		* = * "Sound"

	SoundCooldown:	.byte 50

	.label SFX_FATTER = 1
	.label SFX_SCORE = 2
	.label SFX_EAT = 3
	.label SFX_PICKLE = 4
	.label SFX_TICK = 5
	.label SFX_GAME_OVER = 7


	Eat: {

		//jsr $31F9

		lda #SFX_EAT
		sta 680

		rts
	}

	Fatter: {

		jsr $31F9

		lda #SFX_FATTER
		sta 681

		rts
	}

	Score: {

		jsr $31F9

		lda #SFX_SCORE
		sta 681

		rts
	}

	Pickle: {


		lda #SFX_PICKLE
		sta 680

		rts
	}

	

	GameOver: {

		jsr $31F9

		lda #SFX_GAME_OVER
		sta 679
		rts
	}

	Tick: {


		lda #SFX_TICK
		sta 681
		rts
	}
	
	







}