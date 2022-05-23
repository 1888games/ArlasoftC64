READY: {


	* = * "READY"

	GameStarted:		.byte 0
	ReadyShowing:		.byte 0

	.label TIME_FACTOR = TITLE.PAUSE_FACTOR


	PlayerOne:	.text @"player one\$00"	
	Ready:		.text @"ready!\$00"	

	NewGame: {	

		lda GAME.AttractMode
		beq NotAttractMode

		IsAttractMode:

			jmp DoAttractMode

		NotAttractMode:	

			lda #0
			sta GameStarted
		
			lda #140 * TIME_FACTOR
			sta GAME.Delay

			jsr ShowPlayerOne
			jsr ShowReady

		rts
	}



	ResetLevel: {	

		lda #0
		sta GAME.Active

		jsr ShowReady

		lda #100 * TIME_FACTOR
		sta GAME.Delay

		lda #1
		sta GameStarted
		sta ReadyShowing

		rts
	}

	ShowSprites: {


		jsr ACTOR.PLAYER.ResetPacman
		jsr ACTOR.GHOST.ResetAll
 		
 		jsr GAME.LoseLife



		rts
	}

	DoAttractMode: {

		jsr GAME.ShowGameOver
		jsr ShowSprites

		lda #50 * TIME_FACTOR
		sta GAME.Delay

		lda #1
		sta GameStarted

		rts
	}


	HidePlayerOne: {

		ldx #0

		Loop:

	
			lda #0
			sta SCREEN_RAM + (40 * 5) + 15, x

			inx
			cpx #10
			bcc Loop
			

		Finish:		

		jsr ShowSprites

		lda #100 * TIME_FACTOR
		sta GAME.Delay

		lda #1
		sta GameStarted
		sta ReadyShowing

		rts
	}


	HideReady: {

		ldx #0

		Loop:

			lda #0
			sta SCREEN_RAM + (40 * 11) + 17, x

			inx
			cpx #6
			bcc Loop
		

		Finish2:

		lda #0
		sta ReadyShowing


		jsr ACTOR.PLAYER.SetAlarm

		rts
	}

	ShowPlayerOne: {

		ldx #0

		Loop:

	
			lda PlayerOne, x
			beq Finish
			sta SCREEN_RAM + (40 * 5) + 15, x

			lda #CYAN
			sta VIC.COLOR_RAM + (40 * 5) + 15, x

			inx
			jmp Loop


		Finish:

		

		rts
	}


	ShowReady: {

		ldx #0

		Loop2:

			lda Ready, x
			beq Finish2
			sta SCREEN_RAM + (40 * 11) + 17, x

			lda #YELLOW
			sta VIC.COLOR_RAM + (40 * 11) + 17, x

			inx
			jmp Loop2


		Finish2:



		rts
	}








}