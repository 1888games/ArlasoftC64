.namespace ACTOR {
.namespace GHOST {


	* = * "-Move"

	MoveInCurrentDirection: {

		lda Direction, x
		beq Up

		cmp #1
		beq Left

		cmp #2
		beq Down


		Right:

			jmp MoveRight
			
		Down:

			jmp MoveDown
			
		Left:

			jmp MoveLeft
			
		Up:

			jmp MoveUp
	
	}


	MoveRight: {


			inc PixelX, x
			inc TilePixelX, x
			dec DistToMidX, x

			lda TilePixelX, x
			cmp #8
			bcc NoNewTile

		NewTile:

			inc TileX, x

			lda #0
			sta TilePixelX, x
			sta InTunnel, x

			lda #MID_TILE_X
			sec
			sbc TilePixelX, x
			sta DistToMidX, x

			lda TileY, x
			cmp #TUNNEL_ROW
			bne NotTunnel

			lda TileX, x
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

			inc InTunnel, x
		
			cmp #30
			beq Teleport

			jmp UpdateAddress

		Teleport:

			lda #-16
			sta PixelX, x

			lda #254
			sta TileX, x

			lda #$BD
			sta MapAddress_LSB, x

			lda #$BC
			sta MapAddress_MSB, x

			rts
		
		NotTunnel:


		UpdateAddress:


			lda MapAddress_LSB, x
			clc
			adc #1
			sta MapAddress_LSB, x

			lda MapAddress_MSB, x
			adc #0
			sta MapAddress_MSB, x

			
			
		NoNewTile:


		rts
	}

	MoveLeft: {

		

		Move:

			dec PixelX, x
			dec TilePixelX, x
			inc DistToMidX, x

			lda TilePixelX, x
			bpl NoNewTile

		NewTileLeft:

			lda #0
			sta InTunnel, x

			dec TileX, x
		
			lda #7
			sta TilePixelX, x

			lda #MID_TILE_X
			sec
			sbc TilePixelX, x
			sta DistToMidX, x


			lda TileY, x
			cmp #TUNNEL_ROW
			bne NotTunnel

			lda TileX, x
			bmi OffScreen

			cmp #22
			bcs RightTunnel

			cmp #5
			bcs NotTunnel

			jmp RightTunnel

		OffScreen:
		RightTunnel:

			inc InTunnel, x

			cmp #253
			beq Teleport

			jmp UpdateAddress

		Teleport:

			lda #223 + 16
			sta PixelX, x

			lda #29
			sta TileX, x

			lda #$DC
			sta MapAddress_LSB, x

			lda #$BC
			sta MapAddress_MSB, x

			rts
			
		NotTunnel:

		UpdateAddress:


			lda MapAddress_LSB, x
			sec
			sbc #1
			sta MapAddress_LSB, x

			lda MapAddress_MSB, x
			sbc #0
			sta MapAddress_MSB, x

		
			
		NoNewTile:

		rts
	}

	MoveUp: {

	
		Move:

			dec PixelY, x
		
			dec TilePixelY, x
			inc DistToMidY, x

			lda TilePixelY, x
			bpl NoNewTile

		NewTile:


			dec TileY, x

			lda TileY, x
			bpl Okay

			.break
			nop

		Okay:

			lda #7
			sta TilePixelY, x

			lda MapAddress_LSB, x
			sec
			sbc #SCROLLER.MAP_COLUMNS
			sta MapAddress_LSB, x

			lda MapAddress_MSB, x
			sbc #0
			sta MapAddress_MSB, x

			lda #MID_TILE_Y
			sec
			sbc TilePixelY, x
			sta DistToMidY, x
			
		NoNewTile:


		rts
	}

	MoveDown: {


		Move:

			inc PixelY, x
		
			inc TilePixelY, x
			dec DistToMidY, x

			lda TilePixelY, x
			cmp #8
			bcc NoNewTile

		NewTile:


			inc TileY, x

			lda #0
			sta TilePixelY, x

			lda MapAddress_LSB, x
			clc
			adc #SCROLLER.MAP_COLUMNS
			sta MapAddress_LSB, x

			lda MapAddress_MSB, x
			adc #0
			sta MapAddress_MSB, x

			lda #MID_TILE_Y
			sec
			sbc TilePixelY, x
			sta DistToMidY, x
		
		NoNewTile:


	


		rts
	}



	

}
}