.namespace ACTOR {
.namespace GHOST {


.label DIR_UP = 0
.label DIR_LEFT = 1
.label DIR_DOWN = 2
.label DIR_RIGHT = 3

	ChooseTurn: {

		* = * "-AI"


		lda #0
		sta ZP.DistanceX
		sta ZP.DistanceY
		sta ZP.DistanceX + 1
		sta ZP.DistanceY + 1

		lda #255
		sta ZP.ShortestDistance
		sta ZP.ShortestDistance + 1
		sta ZP.ShortestTurn


		CheckConstrained:
	
			lda Mode, x
			cmp #GHOST_GOING_HOME
			beq GoingHome

			jsr ConstrainGhostTurns

		GoingHome:

			ldy #0

			Loop:

				ldx ZP.GhostID

				lda OpenTiles, y
				beq EndLoop

				XDistance:

					lda XLookup, y
					clc
					adc TileX, x
					sec
					sbc TargetTileX, x
					bcs TargetToLeft

				TargetToRight:

					ReverseSign()

				TargetToLeft:

					tax
					lda SquareLSB, x
					sta ZP.DistanceX

					lda SquareMSB, x
					sta ZP.DistanceX + 1

				YDistance:	

					ldx ZP.GhostID
					lda YLookup, y
					clc
					adc TileY, x
					sec
					sbc TargetTileY, x
					bcs TargetAbove

				TargetBelow:

					ReverseSign()

				TargetAbove:

					tax
					lda SquareLSB, x
					sta ZP.DistanceY

					lda SquareMSB, x
					sta ZP.DistanceY + 1

				AddTwoTogether:


					lda ZP.DistanceX
					clc
					adc ZP.DistanceY
					sta ZP.DistanceX

					lda ZP.DistanceX + 1
					adc ZP.DistanceY + 1
					sta ZP.DistanceX + 1

				CompareWithShortest:

					//lda DistanceX + 1
					cmp ZP.ShortestDistance + 1
					bcc IsShortest
					beq CheckLSB

					jmp EndLoop


				CheckLSB:

					lda ZP.DistanceX
					cmp ZP.ShortestDistance
					bcc IsShortest

					jmp EndLoop

				IsShortest:

					lda ZP.DistanceX
					sta ZP.ShortestDistance

					lda ZP.DistanceX + 1
					sta ZP.ShortestDistance + 1

					tya
					sta ZP.ShortestTurn


				EndLoop:

					iny
					cpy #4
					bcc Loop


			ldx ZP.GhostID
			lda ZP.ShortestTurn
			bpl IsValidDirection

			.break
			nop


		IsValidDirection:

			sta NextDirection, x

		rts
	}

	JustPassedMidTile_AI: {

		cpx #0
		beq Skip

		jsr GetOpenTiles

		lda Scared, x
		beq NotScared

		WasScared:

			jmp IsScared
			
		NotScared:

			jmp SetTarget


		Skip:


		rts
	}

	CheckUpdateFaceDirection: {



		lda TileX, x
		clc
		adc DirX, x
		sta NextTileX, x

		lda TileY, x
		clc
		adc DirY, x
		sta NextTileY, x 

		lda Direction, x
		beq Up

		cmp #1
		beq Left

		cmp #2
		beq Down


		Right:

			cpx #0
			beq AI_1

			lda #RIGHT_AI_TILE_X
			cmp TilePixelX, x
			beq AI_1

			jmp NoAIYet

		AI_1:

			lda MapAddress_LSB, x
			clc
			adc #1
			sta ZP.NextTileAddress

			lda MapAddress_MSB, x
			adc #0
			sta ZP.NextTileAddress + 1

		
			jmp JustPassedMidTile_AI
			
		Down:

			cpx #0
			beq DownAI

			lda #DOWN_AI_TILE_Y
			cmp TilePixelY, x
			bne NoAIYet

		DownAI:

			lda MapAddress_LSB, x
			clc
			adc #SCROLLER.MAP_COLUMNS
			sta ZP.NextTileAddress

			lda MapAddress_MSB, x
			adc #0
			sta ZP.NextTileAddress + 1



			jmp JustPassedMidTile_AI
			
		Left:

			cpx #0
			beq LeftAI

			lda #LEFT_AI_TILE_X
			cmp TilePixelX, x
			bne NoAIYet


		LeftAI:

			lda MapAddress_LSB, x
			sec
			sbc #1
			sta ZP.NextTileAddress

			lda MapAddress_MSB, x
			sbc #0
			sta ZP.NextTileAddress + 1

			jmp JustPassedMidTile_AI
				
		Up:

			cpx #0
			beq UpAI

		
			lda #UP_AI_TILE_Y
			cmp TilePixelY, x
			bne NoAIYet

		UpAI:

			lda MapAddress_LSB, x
			sec
			sbc #SCROLLER.MAP_COLUMNS
			sta ZP.NextTileAddress

			lda MapAddress_MSB, x
			sbc #0
			sta ZP.NextTileAddress + 1

			jmp JustPassedMidTile_AI


		NoAIYet:





		rts
	}


	Steer: {

		lda MAIN.GameMode
		cmp #GAME_MODE_INTERMISSION
		bne Okay

		rts

		Okay:

		jsr HomeSteer
		//jsr RotateAboutFace

		CheckTargeting:

			lda Mode, x
			cmp #GHOST_OUTSIDE
			beq IsTargeting

			cmp #GHOST_GOING_HOME
			beq IsTargeting

		NotTargeting:

			lda #0
			sta Targeting, x
			rts

		IsTargeting:

			lda DistToMidX, x
			bne NoUpdateDirection

			lda DistToMidY, x
			bne NoUpdateDirection

		UpdateMovement:

			jmp UpdateMovementDirection

		NoUpdateDirection:

			jsr CheckUpdateFaceDirection 


		rts
	}

	SetTarget: {

		lda Mode, x
		cmp #GHOST_GOING_HOME
		bne NotGoingHome

		GoingHome:

			lda #DOOR_TILE_X
			sta TargetTileX, x

			lda #DOOR_TILE_Y
			sta TargetTileY, x

			jmp ChooseTurn

		NotGoingHome:

			cpx #BLINKY
			bne NotElroy

			lda Elroy
			beq NotElroy

		IsElroy:

			jmp Blinky

		NotElroy:

			lda CommandMode
			cmp #GHOST_SCATTER
			bne CustomFunction

			lda CornerTileX, x
			sta TargetTileX, x

			lda CornerTileY, x
			sta TargetTileY, x

			jmp ChooseTurn

		CustomFunction:

			cpx #1
			bne NotBlinky

			jmp Blinky

		NotBlinky:

			cpx #2
			bne NotPinky

			jmp Pinky

		NotPinky:

			cpx #3
			bne NotInky

			jmp Inky


		NotInky:

			jmp Clyde

		rts
	}


	Blinky: {

		lda TileX
		sta TargetTileX, x

		lda TileY
		sta TargetTileY, x

		jmp ChooseTurn

		rts
	}

	* = * "Pinky AI"

	Pinky: {



		lda TileX
		clc
		adc DirX
		clc
		adc DirX
		clc
		adc DirX
		clc
		adc DirX
		sta TargetTileX, x

		lda TileY
		clc
		adc DirY
		clc
		adc DirY
		clc
		adc DirY
		clc
		adc DirY
		sta TargetTileY, x

		lda Direction
		cmp #DIR_UP
		bne NotUp

		lda TargetTileX, x
		sec
		sbc #4
		sta TargetTileX, x

		NotUp:

		jmp ChooseTurn



		rts
	}

// 	inky.getTargetTile = function() {
//     var px = pacman.tile.x + 2*pacman.dir.x;
//     var py = pacman.tile.y + 2*pacman.dir.y;
//     if (pacman.dirEnum == DIR_UP) {
//         px -= 2;
//     }
//     return {
//         x : blinky.tile.x + 2*(px - blinky.tile.x),
//         y : blinky.tile.y + 2*(py - blinky.tile.y),
//     };
// };

	BlinkyToPacmanAheadDistance: {

		.label BLINKY_TILE_X = TileX + 1
		.label BLINKY_TILE_Y = TileY + 1

		DoX:

			lda TargetTileX, x
			sec
			sbc BLINKY_TILE_X
			bcc AmountNegative

			asl
			clc
			adc BLINKY_TILE_X
			sta TargetTileX, x

			jmp DoY

		AmountNegative:

			ReverseSign()

			asl
			
			ReverseSign()

			clc
			adc BLINKY_TILE_X	

			sta TargetTileX, x


		DoY:

			lda TargetTileY, x
			sec
			sbc BLINKY_TILE_Y
			bcc AmountNegative2

			asl
			clc
			adc BLINKY_TILE_Y
			sta TargetTileY, x

			jmp ChooseTurn

		AmountNegative2:

			ReverseSign()

			asl
		
			ReverseSign()

			clc
			adc BLINKY_TILE_Y

			sta TargetTileY, x

			jmp ChooseTurn

	}

	Inky: {

		lda TileX
		clc
		adc DirX
		clc
		adc DirX
		sta TargetTileX, x

		lda TileY
		clc
		adc DirY
		clc
		adc DirY
		sta TargetTileY, x

		lda Direction
		cmp #DIR_UP
		bne NotUp

		lda TargetTileX, x
		sec
		sbc #2
		sta TargetTileX, x

		NotUp:

		jsr BlinkyToPacmanAheadDistance

		jmp ChooseTurn


		rts
	}

	Clyde: {

		.label DistanceX = ZP.Temp1
    	.label DistanceY = ZP.Temp3

		DoX:

			lda TileX
			sec
			sbc TileX, x
			sec
			sbc DirX, x
			bpl Positive

			ReverseSign()

		Positive:

			tay
			lda SquareLSB, y
			sta DistanceX

			lda SquareMSB, y
			sta DistanceX + 1


		DoY:


			lda TileY
			sec
			sbc TileY, x
			sec
			sbc DirY, x
			bpl Positive2

			ReverseSign()

		Positive2:

			tay
			lda SquareLSB, y
			sta DistanceY

			lda SquareMSB, y
			sta DistanceY + 1


		AddTwoTogether:


			lda DistanceX
			clc
			adc DistanceY
			sta DistanceX

			lda DistanceX + 1
			adc DistanceY + 1
			bne TargetPacman

		CheckDistance:

			lda DistanceX
			cmp #65
			bcs TargetPacman


		RunAway:

			lda CornerTileX, x
			sta TargetTileX, x

			lda CornerTileY, x
			sta TargetTileY, x

			jmp ChooseTurn

		TargetPacman:

			lda TileX
			sta TargetTileX, x

			lda TileY
			sta TargetTileY, x

			jmp ChooseTurn


		rts
	}


}
}