MAPLOADER: {

	TileScreenLocations:
		.byte 0,1,40,41

	Column:
		.byte 0

	Row:
		.byte 0

	DrawMap: {

		// load first char address into first FEED
		lda #<SCREEN_RAM
		sta Screen + 1
		lda #>SCREEN_RAM
		sta Screen + 2

		// load first colour address into second FEED
		lda #<VIC.COLOR_RAM
		sta Colour + 1
		lda #>VIC.COLOR_RAM
		sta Colour + 2

		lda #<MAP
		sta Tile + 1
		lda #>MAP
		sta Tile + 2

		lda #ZERO
		sta Row

		TileRowLoop: 

			lda #ZERO
			sta Column

			TileColumnLoop: 

				ldy #ZERO

				lda #ZERO
				sta TileLookup+1
				sta TileLookup+2

				Tile:

				lda $FEED
				sta TileLookup + 1
				asl TileLookup + 1
				rol TileLookup + 2
				asl TileLookup + 1
				rol TileLookup + 2

				clc
				lda #<MAP_TILES
				adc TileLookup + 1
				sta TileLookup + 1
				lda #>MAP_TILES
				adc TileLookup + 2
				sta TileLookup + 2


					!FourTileLoop: 

						TileLookup:
						// load the map tile at position, offset
						lda $FEED,y
						ldx TileScreenLocations,y

					Screen:
						sta $FEED, x

						// load the character colour for same position
						tax
						lda CHAR_COLORS, x
						ldx TileScreenLocations, y

					Colour:
						sta $FEED, x

						//check whether all tiles loaded
						iny
						cpy #4
						bne !FourTileLoop-

					// FourTileLoop

				jsr NextColumn
				cpx #20
				bne TileColumnLoop

			// TileColumnLoop

			jsr NextRow
			
			
			cpx #12
			bne TileRowLoop

		// TileRowLoop


		rts

		NextColumn:

			clc
			lda Tile + 1
			adc #ONE
			sta Tile + 1
			lda Tile + 2
			adc #ZERO
			sta Tile + 2

			clc
			lda Screen + 1
			adc #2
			sta Screen + 1
			lda Screen + 2
			adc #0
			sta Screen + 2

			// move to the next screen row start address
			lda Colour + 1
			adc #2
			sta Colour + 1
			lda Colour + 2
			adc #0
			sta Colour + 2

			inc Column
			ldx Column
			rts


		NextRow:
			// move to the next screen row start address
			clc
			lda Screen + 1
			adc #40
			sta Screen + 1
			lda Screen + 2
			adc #0
			sta Screen + 2

			// move to the next screen row startaddress
			lda Colour + 1
			adc #40
			sta Colour + 1
			lda Colour + 2
			adc #0
			sta Colour + 2

			inc Row
			ldx Row

			rts


	}




}