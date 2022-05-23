.namespace ACTOR {
.namespace PLAYER {


	* = * "--Control"


	CheckUpDownDrift: {

		lda DistToMidY
		beq NoMoveY

		bmi Up

		Down:

			jmp MoveDown

		Up:

			jmp MoveUp

		NoMoveY:


		rts
	}

	
	CheckLeftRightDrift: {

		lda DistToMidX
		beq NoMoveX



		bmi Left

		Right:

			jmp MoveRight

		Left:

			jmp MoveLeft

		NoMoveX:

		rts
	}


	AttractMode: {

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		lda #GAME_MODE_TITLE
		sta MAIN.GameMode

		jsr TITLE.ShowPushStart

		Finish:



		rts
	}

	//XLookup:	.byte 0, -1, 0, 1
//	YLookup:	.byte -1, 0, 1, 0

	Control: {

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERMISSION
		bne NotIntermission

		rts

		NotIntermission:

			lda GAME.AttractMode
			beq NotAttractMode

			jmp AttractMode

		NotAttractMode:

			lda INPUT.JOY_DIRECTION
			sta NextDirection

			bmi Finish

			ldy InTunnel
			beq NotTunnel

			cmp #DIR_UP
			beq NoTurn

			cmp #DIR_DOWN
			beq NoTurn

			jmp NotTunnel

		NoTurn:

			lda #255
			sta NextDirection
			rts


		NotTunnel:

			tay
			lda XLookup, y
			sta NextDirX 

			lda YLookup, y
			sta NextDirY

			rts

		Finish:

		rts
	}



}

}