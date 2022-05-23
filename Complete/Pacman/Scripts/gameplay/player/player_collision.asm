.namespace ACTOR {
.namespace PLAYER {


	* = * "--Collision"


	EatPellet: {

		inc Waiting

		sty ZP.StoredYReg

		//tya
		//pha

		ldy #0
		jsr SCORE.AddScore

		Common:

		jsr PlayWaka
		jsr CheckAlarmStatus

		ldy ZP.StoredYReg

		lda #0
		sta (ZP.DataAddress), y

		lda TileY
		sec
		sbc SCROLLER.TopRow
		clc
		adc #SCROLLER.TOP_BORDER_ROWS
		tay

		lda TileX
		clc
		adc #SCROLLER.START_COLUMN
		tax

		lda #0
		jsr PLOT.ColorCharacterOnly

		jsr ACTOR.GHOST.ReleaseOnDotEat
		jsr FRUIT.OnPelletEaten

		rts
	}


	EatEnergizer: {

		lda Waiting
		clc
		adc #3
		sta Waiting

		sty ZP.StoredYReg

		jsr EatPellet.Common

	
		ldy #1
		jsr SCORE.AddScore

		ldy ZP.StoredYReg

		jsr ENERGIZER.OnEnergized
	

		rts
	}


	CheckEat: {

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERMISSION
		beq NothingHere


		lda MapAddress_LSB
		sta ZP.DataAddress

		lda MapAddress_MSB
		sta ZP.DataAddress + 1

		ldy #SCROLLER.MAP_COLUMNS+ 1

		lda (ZP.DataAddress), y 
		and #%11110000
		beq NothingHere


		cmp #TILE_PELLET
		beq Pellet

		cmp #TILE_PILL 
		beq Energizer

		jmp NothingHere

		Energizer:
 
			jmp EatEnergizer    

		Pellet:

			jmp EatPellet

		NothingHere: 

		rts
	}



	WeGotOne: {

		lda MAIN.GameMode
		sta MAIN.PreviousMode
		cmp #GAME_MODE_PLAY
		beq DuringPlay


		DuringInter:	

			jsr EatCommon
			rts

		DuringPlay:

			sfx(SFX_EAT)

			jsr EatCommon

			lda #GhostScoreStartID
			clc
			adc GHOST.EatenInRow
			tay

			jsr SCORE.AddScore

		rts
	}


	EatCommon: {

		lda #GHOST_EATEN
		sta ACTOR.GHOST.Mode, x

		lda #0
		sta ACTOR.GHOST.Scared, x

		txa
		sta GHOST.EatenID

		lda #60
		sta GHOST.PointsFramesLeft

		inc GHOST.EatenInRow

		lda #GAME_MODE_EATEN
		sta MAIN.GameMode


		rts
	}

	GhostCollision: {

		lda MAIN.GameMode
		cmp #GAME_MODE_EATEN
		beq Finish

		ldx #1

		Loop:

			lda GHOST.Mode, x
			cmp #GHOST_OUTSIDE
			bne EndLoop

			lda TileX, x
			cmp TileX
			bne EndLoop

			lda TileY, x
			cmp TileY
			bne EndLoop

			lda GHOST.Scared, x
			bne CaughtGhost

			lda MAIN.GameMode
			cmp #GAME_MODE_PLAY
			bne EndLoop

			lda Invincible
			bne EndLoop

			jsr SetDead
			rts

			CaughtGhost:

				jmp WeGotOne


		EndLoop:

			inx
			cpx #5
			bcc Loop
				

		Finish:



		rts
	}





}

}