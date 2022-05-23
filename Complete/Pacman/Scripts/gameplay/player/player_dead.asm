.namespace ACTOR {
.namespace PLAYER {



	DeathTimer:		.byte 0
	DeathProgress:	.byte 0
	DeathFrame:		.byte 0
	DeathFrameTimer:	.byte 0

	DeathSteps:		.byte 60, 40, DeathFrameTime * 11

	.label DeathSpritePointer = 74
	.label DeathFrameTime = 6


	SetDead: {

		

	
		lda #GAME_MODE_DEAD
		sta MAIN.GameMode

		lda #0
		sta DeathProgress
		sta DeathFrame

		lda DeathSteps
		sta DeathTimer


		lda #MAIN.SONG_BLANK
		jsr sid.init

		jsr FRUIT.RestartLevel

		lda #1
		sta GHOST.WaitForClyde




		rts
	}





	Animate: {

		lda DeathProgress
		cmp #2
		bne Finish

		lda DeathFrameTimer
		beq Ready

		dec DeathFrameTimer
		rts

		Ready:

			inc SpritePointer
			lda #DeathFrameTime
			sta DeathFrameTimer

		Finish:




		rts
	}



	DeadUpdate: {

		jsr Animate

		lda DeathTimer
		beq NextStep

		dec DeathTimer
		rts


		NextStep:

			inc DeathProgress
			ldx DeathProgress
			cpx #3
			bcc StillGoing
			bne ShowingBlank

			lda #64
			sta SpritePointer

			lda #30
			sta DeathTimer

			inc DeathProgress

			rts


		ShowingBlank:


			lda GAME.Lives
			beq GameOver

			jsr GAME.LoseLife

			jmp MAIN.ResetLevel
			
		GameOver:

			jmp GAME.Over

		
		StillGoing:

			lda DeathSteps, x
			sta DeathTimer

			cpx #1
			bne NotTurnOnBack

		TurnOnBack:

			lda #DeathSpritePointer
			sta SpritePointer

			dec SpriteCopyX
			dec SpriteX
		
			rts

		NotTurnOnBack:

			cpx #2
			bne NotAnimate


		StartAnimate:

			inc SpritePointer


			sfx(SFX_DEAD)



			lda #DeathFrameTime
			sta DeathFrameTimer
			rts

		NotAnimate:


		rts
	}


	
}
}