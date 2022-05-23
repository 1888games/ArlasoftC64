SOUND: {

		* = * "Sound"

	SoundCooldown:	.byte 50

	.label SFX_EXTRA_LIFE = 5
	.label SFX_COLLECT = 6
	.label SFX_DEAD = 4
	.label SFX_TICK = 3
	.label SFX_GAME_OVER = 2


	Collect: {

		jsr $31F9

		lda #SFX_COLLECT
		sta 679

		rts
	}

	Dead: {


		lda #SFX_DEAD
		sta 680

		rts
	}

	ExtraLife: {


		lda #SFX_EXTRA_LIFE
		sta 681
		rts
	}

	GameOver: {


		lda #SFX_GAME_OVER
		sta 681
		rts
	}

	Tick: {


		lda #SFX_TICK
		sta 680
		rts
	}
	
	







}