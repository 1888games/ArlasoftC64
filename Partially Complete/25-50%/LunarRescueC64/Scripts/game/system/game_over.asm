END_GAME: {

	* = * "GAME OVER"

	Timer:		.byte 0
	Progress: 	.byte 0

	.label GameOverTime = 75
	.label StatsTime = 250
	.label OverRow = 14
	.label OverColumn = 9


	.label StatsColumn = 1

	.label ValuesColumn = 17

	.label ResultRow = 12
	.label ResultColumn = 8

	* = * ""

	Initialise: {


		lda #GAME_MODE_OVER
		sta MAIN.GameMode


		lda #0
		sta Progress

		jsr DisplayGameOver

		lda #GameOverTime
		sta Timer

		lda #10
		ldx #0

		Loop:

			sta SpriteX, x
			sta SpriteY, x

			inx
			cpx #MAX_SPRITES
			bcc Loop

		lda #SUBTUNE_DANGER
		//jsr sid.init


		rts

	}

	* = * "DisplayGameOver"
	DisplayGameOver: {

		lda #OverRow
		sta TextRow

		lda #OverColumn
		sta TextColumn

		ldx #RED
		lda #TEXT.GAME_OVER

		jsr TEXT.Draw



		rts
	}

	FrameUpdate: {

		lda Progress
		cmp #GAME_OVER_STATS
		bne NoJoyCheck

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq NoJoyCheck

		jmp BackToTitle

		NoJoyCheck:

			lda ZP.Counter
			and #%00000001
			beq Finish

			lda Timer
			beq Ready

			dec Timer
			rts

		Ready:

		

			jmp BackToTitle

		NotEndStats:

			lda #GameOverTime
			sta Timer

		Finish:


		rts
	}


	BackToTitle: {	

		
		jsr HI_SCORE.Check

		lda ZP.Amount
		bmi TitleScreen

		HiScore:

			ldy #ResultRow
			ldx #ResultColumn
			lda #10
			jsr UTILITY.DeleteText

			ldy #15
			ldx #StatsColumn
			lda #25
			jsr UTILITY.DeleteText

			ldy #18
			ldx #StatsColumn
			lda #25
			jsr UTILITY.DeleteText

			ldy #21
			ldx #StatsColumn
			lda #25
			jsr UTILITY.DeleteText

			lda #1
			jsr HI_SCORE.Show
		
			rts

		TitleScreen:

			lda #GAME_MODE_SWITCH_TITLE
			sta MAIN.GameMode
			rts

	}



}