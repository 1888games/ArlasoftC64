.label SFX_INIT = $b000
.label SFX_PLAY = SFX_INIT+ $01F9

SOUND: {

		* = * "Sound"

	

	SoundCooldown:	.byte 50

	.label SFX_LOW_RUMBLE = 1
	.label SFX_ROBOT_DIE = 2
	.label SFX_FIRE = 3
	.label SFX_ROBOT_FIRE = 4
	.label SFX_TICK = 5
	.label SFX_GAME_OVER = 7

	Fire: {

		jsr SFX_PLAY

		lda #SFX_FIRE
		sta 680

		rts
	}


	RobotDie: {


		jsr SFX_PLAY

		lda #SFX_ROBOT_DIE
		sta 681

		rts
	}




}