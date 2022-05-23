.namespace ACTOR {

	.label MAX_ACTORS = 5
	.label DIR_UP = 0
	.label DIR_LEFT = 1
	.label DIR_DOWN = 2
	.label DIR_RIGHT = 3
	.label TUNNEL_ROW = 17



	* = * "---------"
	* = * "ACTOR"

	* = * "-Data"

	DirX:			.fill MAX_ACTORS, 0
	DirY:			.fill MAX_ACTORS, 0
	Direction:		.fill MAX_ACTORS, 0

	NextDirX:		.fill MAX_ACTORS, 0
	NextDirY:		.fill MAX_ACTORS, 0
	NextDirection:	.fill MAX_ACTORS, 0

	*= * "-TileX"
	TileX:			.fill MAX_ACTORS, 0
	TileY:			.fill MAX_ACTORS, 0
	DistToMidX:		.fill MAX_ACTORS, 0
	DistToMidY:		.fill MAX_ACTORS, 0
	Steps:			.fill MAX_ACTORS, 0

	AnimFrame:		.fill MAX_ACTORS, 0
	Pause:			.fill MAX_ACTORS, 0

	PixelX:			.fill MAX_ACTORS, 0

	* = * "PixelY"
	PixelY:			.fill MAX_ACTORS, 0

	TilePixelX:		.fill MAX_ACTORS, 0
	TilePixelY:		.fill MAX_ACTORS, 0

	
	Frames:			.fill MAX_ACTORS, 0
	

	MapAddress_LSB:	.fill MAX_ACTORS, 0
	MapAddress_MSB:	.fill MAX_ACTORS, 0


	* = * "In Tunnel"
	InTunnel:		.fill MAX_ACTORS, 0
	

	Pointer:		.fill MAX_ACTORS, 0

	SpriteMSB:		.fill MAX_SPRITES, 0


	DirectionYIndexes:	.byte 1, 28, 57, 30

	

	.label LEFT_EXIT = 19 + (SCROLLER.START_COLUMN - 2) * TILE_SIZE


	* = * "-Code"

	CommitPosition: 	{

	
		lda PixelX, x
		lsr
		lsr
		lsr
		sta TileX, x
		asl
		asl
		asl
		sta ZP.Amount

		lda PixelX, x
		sec
		sbc ZP.Amount
		sta TilePixelX, x

		lda #MID_TILE_X
		sec
		sbc TilePixelX, x
		sta DistToMidX, x


		lda PixelY, x
		lsr
		lsr
		lsr
		sta TileY, x
		asl
		asl
		asl
		sta ZP.Amount	


		lda PixelY, x
		sec
		sbc ZP.Amount
		sta TilePixelY, x

		lda #MID_TILE_Y
		sec
		sbc TilePixelY, x
		sta DistToMidY, x

		jsr CalculateMapAddress

		lda #0
		sta AnimFrame, x
		sta Frames, x
		sta Steps, x
		


		rts
	}


	

	CalculateMapAddress: {

		ColourMapPosition:

			lda #<MAP.MazeColours
			sta MapAddress_LSB, x

			lda #>MAP.MazeColours
			sta MapAddress_MSB, x

			ldy #0

		Loop:

			tya
			cmp TileY, x
			bcc NextRow

		FoundRow:
			
			lda MapAddress_LSB, x
			clc
			adc TileX, x
			sta MapAddress_LSB, x

			lda MapAddress_MSB, x
			adc #0
			sta MapAddress_MSB, x

			jmp Done

		NextRow:

			lda MapAddress_LSB, x
			clc
			adc #SCROLLER.MAP_COLUMNS
			sta MapAddress_LSB, x

			lda MapAddress_MSB, x
			adc #0
			sta MapAddress_MSB, x

			iny
			jmp Loop

		Done:

			lda MapAddress_LSB, x
			sec
			sbc #(SCROLLER.MAP_COLUMNS + 1)
			sta MapAddress_LSB, x

			lda MapAddress_MSB, x
			sbc #0
			sta MapAddress_MSB, x

					
			lda MapAddress_LSB, x
			sta ZP.DataAddress

			lda MapAddress_MSB, x
			sta ZP.DataAddress + 1

			ldy #0
			lda (ZP.DataAddress), y

		

		rts
	}

	GetOpenTiles: {


		ldy #0
		sty ZP.BadTurnCount

		Loop:

			lda #1
			sta GHOST.OpenTiles, y

			sty ZP.TurnID

		// 	cpx #0
		// 	beq NotInTunnel

		// 	lda InTunnel, x
		// 	beq NotInTunnel

		// YesTunnel:
		
		// 	tya
		// 	cmp Direction, x
		// 	beq Okay

		// 	jmp BlockWay

		// NotInTunnel:

			lda DirectionYIndexes, y
			tay
			
			lda (ZP.NextTileAddress), y
			ldy ZP.TurnID
			and #%11110000
			cmp #TILE_WALL
			bcc Okay

		BlockWay:

			lda #0	
			sta GHOST.OpenTiles, y

			inc ZP.BadTurnCount
			
			Okay:

				iny
				cpy #4
				bcc Loop

		CantGoBack:

			lda GHOST.OppositeDirection, x
			tay
			lda #0
			sta GHOST.OpenTiles, y

			inc ZP.BadTurnCount

			lda ZP.BadTurnCount
			cmp #5
			bcc OneVALID

			.break
			nop

			jmp GetOpenTiles


		OneVALID:


		rts



	}


	IsNextTileFloor: {

		ldy Direction, x
		jmp CheckTileValue
		
	}

	CheckTileValue: {

		lda TileX, x
		bmi CheckTunnel
		beq CheckTunnel

		cmp #28
		bcs CheckTunnel

		jmp NotTunnel

	CheckTunnel:

		jmp Okay


	NotTunnel:

		lda MapAddress_LSB, x
		sta ZP.DataAddress

		lda MapAddress_MSB, x
		sta ZP.DataAddress + 1

		lda DirectionYIndexes, y
		tay

		lda (ZP.DataAddress), y
		and #%11110000
		cmp #TILE_WALL
		bcc Okay

			lda #0
			rts

		Okay:

		lda #1


		rts
	}

	GetStepSize: {







		rts
	}

	IsPotentialNextTileFloor: {

		ldy NextDirection, x
		jmp CheckTileValue

	}


	
}