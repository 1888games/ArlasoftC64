SOUND: {

		* = * "Sound"

	SoundCooldown:	.byte 50

	.label SFX_FATTER = 1
	.label SFX_SCORE = 2
	.label SFX_EAT = 3
	.label SFX_PICKLE = 4
	.label SFX_TICK = 5
	.label SFX_GAME_OVER = 7


	.label SFX_FIRE = 11
	.label SFX_DEAD = 31
	.label SFX_SPAWN = 8
	.label SFX_COLLECT = 17
	.label SFX_GRUNT = 25
	.label SFX_COMPLETE = 1

	.label SFX_KILL_SPHEROID = 23

	KillSpheroid: {

		jsr Reset

		lda #SFX_KILL_SPHEROID
		sta 680


		rts
	}

	Fire: {
		
		jsr Reset

		lda #SFX_FIRE
		sta 681

		rts
	}

	Spawn: {
		
		jsr Reset

		lda #SFX_SPAWN
		sta 681

		rts
	}


	Dead: {
		
		jsr Reset

		lda #SFX_DEAD
		sta 681

		rts
	}

	Collect: {
		
		jsr Reset

		lda #SFX_COLLECT
		sta 680

		rts
	}


	Complete: {

		jsr Reset

		lda #SFX_COMPLETE
		sta 679

		rts
	}


	KillGrunt: {
		
		jsr Reset

		lda #SFX_GRUNT
		sta 679

		rts
	}

	Reset: {

		stx ZP.Temp4
		jsr $41F9
		ldx ZP.Temp4
		rts

		

		ldx #$17
		lda #0

		Loop:

			sta 54272, x
			dex
			bpl Loop


		ldx ZP.Temp4


		rts
	}

}

