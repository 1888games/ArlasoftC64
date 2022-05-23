GAME: {


		* = * "GAME"

	Level: 		.byte 1
	Lives:		.byte 3
	FruitLevel:	.byte 0
	BackupLevel:	.byte 0

	Colours_1:	.byte RED, RED, RED, RED, RED, RED, RED, RED, RED
	Colours_2:	.byte GREEN, GREEN, GREEN, GREEN, GREEN, GREEN, GREEN, GREEN

	KillScreen:	.byte 0


	GameOverText:	.text @"game  over\$00"	


	Multi1:		.byte 0
	Multi2:		.byte 0

	Active:		.byte 0
	Delay:		.byte 0
	Started:	.byte 0

	AttractMode: .byte 0
	StartLevel: .byte 1
	Invincible:	.byte 0



	.label StartLives = 3

	* = * "---------"
	* = * "GAME"

	New: {

		lda #0
		sta Active
		sta INTERMISSION.Intermission

		
		lda StartLevel
		sec
		sbc #1
		sta Level

		lda TITLE.Lives
		sec
		sbc #48
		sta Lives

		lda AttractMode
		beq NotAttractMode

		sta Lives

	NotAttractMode:

		lda StartLevel
		sec
		sbc #2
		sta FruitLevel

		lda KillScreen
		beq NotKillScreen

	IsKillScreen:

		lda #12
		sta FruitLevel

		lda #19
		sta Level

		NotKillScreen:

		jsr GAME_SPRITES.HideAll
		jsr NewLevel

		jsr READY.NewGame

		jsr ACTOR.PLAYER.NewLevel

		lda #1
		sta Started


		rts
	}



	ShowGameOver: {

		ldx #15

		lda #22
		sec
		sbc SCROLLER.TopRow
		tay

		jsr PLOT.GetCharacter

		lda ZP.ScreenAddress
		sta ZP.DataAddress

		lda ZP.ScreenAddress + 1
		clc
		adc #$34
		sta ZP.DataAddress + 1

		ldy #0

		Loop:

	
			lda GameOverText, y
			beq Finish

			sta (ZP.ScreenAddress), y
			sta (ZP.DataAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

			iny
			jmp Loop


		Finish:

		

		rts
	}


	LoseLife: {


		lda GAME.Invincible
		bne Skip
		

		dec Lives

		Skip:

		rts
	}


	Over: {

		lda #GAME_MODE_OVER
		sta MAIN.GameMode

		jsr ShowGameOver

		lda #120
		sta MAIN.Timer


		rts
	}


	FrameUpdate: {

		lda Delay
		beq Ready

		dec Delay
		rts

		Ready:

			lda READY.GameStarted
			bne GameInProgress

			jmp READY.HidePlayerOne

		GameInProgress:

			lda READY.ReadyShowing
			beq NotShowing

			jsr READY.HideReady

		NotShowing:

			lda #1
			sta Active
			
			lda #GAME_MODE_PLAY
			sta MAIN.GameMode

		rts
	}
	

	NewLevel: {

		inc FruitLevel
		inc Level

		lda Level
		bne NotKill

		DoKill:

		inc KillScreen

		lda #12
		sta FruitLevel

		NotKill:

			lda FruitLevel
			cmp #13
			bcc Okay

			lda #12
			sta FruitLevel

		Okay:

			tax
			lda Colours_1, x
			sta Multi1
			
			lda Colours_2, x
			sta Multi2

			jsr ACTOR.GHOST.ReleaseNewLevel
			jsr FRUIT.NewLevel



		rts
	}



}