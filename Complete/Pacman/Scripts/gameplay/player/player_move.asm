.namespace ACTOR {
.namespace PLAYER {


	* = * "--Move"


	Step: {

		lda #0
		sta AxisOfMotion
		sta IsMoving

		lda #1
		sta AxisPerpendicular

		lda InTunnel
		beq NotTunnel

	
		jmp MoveNow

		NotTunnel:


		lda DirX
		bne MovingX

		MovingY:
			
	 		inc AxisOfMotion
	 		dec AxisPerpendicular

		MovingX:

			ldy AxisOfMotion
			beq XAxis

		YAxis:

			lda DistToMidY
			bne NoWallCheck

			jmp WallCheck

		XAxis:

			lda DistToMidX
			bne NoWallCheck

		WallCheck:

			lda MAIN.GameMode
			cmp #GAME_MODE_INTERMISSION
			beq NoWallCheck

			lda GAME.AttractMode
			beq NotAttractMode

			jsr AttractAI
			jmp MoveNow

		NotAttractMode:

			ldx #PACMAN
			jsr IsNextTileFloor

			bne NoWallCheck

			lda #1
			sta Stopped

		NoWallCheck:
				
			lda Stopped
			bne CantMove

		MoveNow:

			jsr MoveInCurrentDirection



		CantMove:					

		rts
	}


	MoveDown: {


		lda #0
		sta SCROLLER.BufferedUp

		lda #50
		sta SCROLLER.BufferingUp

		lda SCROLLER.BufferedDown
		bne AlreadyBuffering

		lda SCROLLER.BufferingDown
		cmp #50
		bne AlreadyBuffering

		lda #3
		sta SCROLLER.BufferingDown

		AlreadyBuffering:

			inc IsMoving

		Move:

			inc PixelY
		
			inc TilePixelY
			dec DistToMidY

			lda TilePixelY
			cmp #8
			bcc NoNewTile

		NewTile:


			inc TileY

			lda #0
			sta TilePixelY

			lda MapAddress_LSB
			clc
			adc #SCROLLER.MAP_COLUMNS
			sta MapAddress_LSB

			lda MapAddress_MSB
			adc #0
			sta MapAddress_MSB

			lda #MID_TILE_Y
			sec
			sbc TilePixelY
			sta DistToMidY
			
			
		NoNewTile:


			

	

		rts
	}

	MoveUp: {

		lda #0
		sta SCROLLER.BufferedDown

		lda #50
		sta SCROLLER.BufferingDown

		lda SCROLLER.BufferedUp
		bne AlreadyBuffering

		StartBuffering:

			lda SCROLLER.BufferingUp
			cmp #50
			bne AlreadyBuffering

			lda #3
			sta SCROLLER.BufferingUp

		AlreadyBuffering:

			inc IsMoving
		

		Move:

			dec PixelY
		
			dec TilePixelY
			inc DistToMidY

			lda TilePixelY
			bpl NoNewTile

		NewTile:


			dec TileY

			lda #7
			sta TilePixelY

			lda MapAddress_LSB
			sec
			sbc #SCROLLER.MAP_COLUMNS
			sta MapAddress_LSB

			lda MapAddress_MSB
			sbc #0
			sta MapAddress_MSB

			lda #MID_TILE_Y
			sec
			sbc TilePixelY
			sta DistToMidY

			
		NoNewTile:


		rts
	}





	MoveLeft: {


		inc IsMoving

		Move:

			dec PixelX
			dec TilePixelX
			inc DistToMidX

			lda TilePixelX
			bpl NoNewTile

		NewTileLeft:


			dec TileX
		
			lda #7
			sta TilePixelX

			lda #MID_TILE_X
			sec
			sbc TilePixelX
			sta DistToMidX


			lda TileY
			cmp #TUNNEL_ROW
			bne NotTunnel

			lda TileX
			bmi OffScreen

			cmp #22
			bcs RightTunnel

			cmp #5
			bcs NotTunnel

			jmp RightTunnel

		OffScreen:
		RightTunnel:

			ldy #1
			sty InTunnel

			cmp #253
			beq Teleport

			jmp UpdateAddress

		Teleport:

			lda #223 + 16
			sta PixelX

			lda #29
			sta TileX

			lda #$DC
			sta MapAddress_LSB

			lda #$BC
			sta MapAddress_MSB

			rts
			
		NotTunnel:

			lda #0
			sta InTunnel

		UpdateAddress:

			lda MapAddress_LSB
			sec
			sbc #1
			sta MapAddress_LSB

			lda MapAddress_MSB
			sbc #0
			sta MapAddress_MSB

		
			
		NoNewTile:



		rts
	}

	MoveRight: {

		inc IsMoving

		Move:

			inc PixelX

		NoIncreasePixel:

			inc TilePixelX
			dec DistToMidX

			lda TilePixelX
			cmp #8
			bcc NoNewTile

		NewTile:


			inc TileX

			lda #0
			sta TilePixelX

			lda #MID_TILE_X
			sec
			sbc TilePixelX
			sta DistToMidX

			lda TileY
			cmp #TUNNEL_ROW
			bne NotTunnel

			lda TileX
			cmp #28
			bcs OffScreen

			cmp #5
			bcc LeftTunnel

			cmp #22
			bcc NotTunnel

			jmp RightTunnel
			
		OffScreen:
		RightTunnel:
		LeftTunnel:

			ldy #1
			sty InTunnel

			cmp #30
			beq Teleport

			jmp UpdateAddress

		Teleport:

			lda #-16
			sta PixelX

			lda #254
			sta TileX

			lda #$BD
			sta MapAddress_LSB

			lda #$BC
			sta MapAddress_MSB

			rts
		
		NotTunnel:

			lda #0
			sta InTunnel

		UpdateAddress:

			lda MapAddress_LSB
			clc	
			adc #1
			sta MapAddress_LSB

			lda MapAddress_MSB
			adc #0
			sta MapAddress_MSB

		NoNewTile:


			rts



	}


	MoveInCurrentDirection: {

		lda Direction
		beq Up

		cmp #1
		beq Left

		cmp #2
		beq Down


		Right:

			jsr MoveRight
			jsr CheckUpDownDrift

			jmp TunnelPriority



		Down:

			jsr MoveDown
			jsr CheckLeftRightDrift

			jmp TunnelPriority


		Left:

			jsr MoveLeft
			jsr CheckUpDownDrift

			jmp TunnelPriority



		Up:

			jsr MoveUp
			jsr CheckLeftRightDrift


		TunnelPriority:

			lda MAIN.GameMode
			cmp #GAME_MODE_INTERMISSION
			beq NoChange

			cmp #GAME_MODE_PLAY
			beq DoTunnel

			lda INTERMISSION.ID
			bne NoChange


		DoTunnel:

			lda InTunnel
			beq NotTunnel

			lda TITLE.SpritePriority
			ora #%00010000
			sta TITLE.SpritePriority

			rts

		NotTunnel:

			lda TITLE.SpritePriority
			and #%11101111
			sta TITLE.SpritePriority

		NoChange:

			rts
	}



}
}