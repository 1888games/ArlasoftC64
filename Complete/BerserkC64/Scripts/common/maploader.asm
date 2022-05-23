MAPLOADER: {

	* = * "Maploader"
	TileScreenLocations:
		.byte 0,1,40,41

	Column:
		.byte 0

	Row:
		.byte 0

	CurrentMap:		.word $0000
	CurrentTiles: 	.word $0000
	CurrentColours:	.word $0000

	Maps: 			.word $5104, $5000
	MapTiles:		.word $5208, $5208
	Colours:		.word $5308, $5308
	Columns:		.byte 16, 20

	CurrentMapID: 	.byte 1
	ColumnsToDraw:	.byte 20

	DrawMap: {


		ldx CurrentMapID
		lda Columns, x
		sta ColumnsToDraw

		lda CurrentMapID
		asl
		tax

		lda MapTiles, x
		sta CurrentTiles

		lda Colours, x
		sta CurrentColours

		lda Maps, x
		sta CurrentMap

		inx

		lda Maps, x
		sta CurrentMap + 1

		lda MapTiles, x
		sta CurrentTiles + 1

		lda Colours, x
		sta CurrentColours + 1

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
		jmp GetMapAddress

		

		GetMapAddress:

			lda CurrentMap
			sta Tile + 1
			lda CurrentMap + 1
			sta Tile + 2

			lda CurrentColours
			sta LoadColour + 1
			lda CurrentColours + 1
			sta LoadColour + 2

			lda #ZERO
			sta Row

		TileRowLoop: 

			lda #ZERO
			sta Column

			TileColumnLoop: 

				ldx Column
				cpx ColumnsToDraw
				bcs EndLoop


				ldy #ZERO

				lda #ZERO
				sta TileLookup+1
				sta TileLookup+2

				Tile:

				//.break

				lda $FEED
				sta TileLookup + 1
				asl TileLookup + 1
				rol TileLookup + 2
				asl TileLookup + 1
				rol TileLookup + 2

				clc
				lda CurrentTiles
				adc TileLookup + 1
				sta TileLookup + 1
				lda CurrentTiles + 1
				adc TileLookup + 2
				sta TileLookup + 2




				OkayToDraw:

					!FourTileLoop: 

						TileLookup:
						// load the map tile at position, offset
						lda $FEED,y
						ldx TileScreenLocations,y

					Screen:
						sta $FEED, x

						// load the character colour for same position
						tax

					LoadColour:
						lda $FEED, x
						ldx TileScreenLocations, y

					Colour:
						sta $FEED, x

						lda Row
						cmp #12
						bne NotLastRow

						iny 
						cpy #2
						bne !FourTileLoop-

						jmp EndLoop

					NotLastRow:

						//check whether all tiles loaded
						iny
						cpy #4
						bne !FourTileLoop-

					// FourTileLoop
				EndLoop:

				jsr NextColumn
				cpx #20
				bne TileColumnLoop

			// TileColumnLoop

			jsr NextRow
			
			
			cpx #13
			bne TileRowLoop

		// TileRowLoop


		rts

		NextColumn:

			ldx Column
			cpx ColumnsToDraw
			bcs NoTile

			clc
			lda Tile + 1
			adc #ONE
			sta Tile + 1
			lda Tile + 2
			adc #ZERO
			sta Tile + 2


			NoTile:

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