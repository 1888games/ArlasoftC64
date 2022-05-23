MAPLOADER: {

	
	 TileScreenLocations: .byte 0, 1, 40, 41

	Column: .byte 0
	Row: .byte 0

	Columns: .byte 20
	Rows: .byte 12
	TileSize: .byte 4

	Initialise: {

		.if (target =="VIC") {

			lda #22	
			sta TileScreenLocations + 2
			lda #23
			sta TileScreenLocations + 3

			lda #11
			sta Columns
			sta Rows

		}

		rts

	}

	

	DrawMap: {

		.if(target != "PET") {

			// load first char address into first FEED

			lda #5
			ldy #2
			sta (SCREEN_RAM), y
			sta (COLOR_RAM), y

		

			lda SCREEN_RAM
			sta Screen + 1
			lda SCREEN_RAM +1
			sta Screen + 2

			lda #<SCREEN_DATA.Game
			sta Buffer + 1
			lda #>SCREEN_DATA.Game
			sta Buffer + 2

			// load first colour address into second FEED
			lda COLOR_RAM
			sta Colour + 1
			lda COLOR_RAM + 1
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

						Buffer:

							sta $FEED, x

						Screen:
							sta $FEED, x

							// load the character colour for same position
							tax
							lda CHAR_COLORS, x

							.if(target == "264") {

								clc
								adc #80

							}
							ldx TileScreenLocations, y

						Colour:

						

							sta $FEED, x

							//check whether all tiles loaded
							iny
							cpy #4
							bne !FourTileLoop-

						// FourTileLoop

					jsr NextColumn
					cpx Columns
					bne TileColumnLoop

				// TileColumnLoop

				jsr NextRow
				
				
				cpx Rows
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

				lda Buffer + 1
				adc #2
				sta Buffer + 1
				lda Buffer + 2
				adc #0
				sta Buffer + 2

				inc Column
				ldx Column
				rts


			NextRow:
				// move to the next screen row start address
				clc
				lda Screen + 1
				adc TileScreenLocations + 2
				sta Screen + 1
				lda Screen + 2
				adc #0
				sta Screen + 2

				// move to the next screen row startaddress
				lda Colour + 1
				adc TileScreenLocations + 2
				sta Colour + 1
				lda Colour + 2
				adc #0
				sta Colour + 2

				lda Buffer + 1
				adc TileScreenLocations + 2
				sta Buffer + 1
				lda Buffer + 2
				adc #0
				sta Buffer + 2

				inc Row
				ldx Row

				rts


		}


	else {

		.label CHAR_ID = TEMP1
	 	.label BYTE_ID = TEMP2
	
		ldx #0

		ldy #0
		sty CHAR_ID

		lda #ZERO
		sta BYTE_ID

		//jmp Nope

		First: {

		Loop2: 

			lda SCREEN_DATA.Game, x
			sta $8000, x

			CheckNextChar:
				inc BYTE_ID
				lda BYTE_ID
				cmp #8
				beq NewChar
				jmp EndLoop

			NewChar:

				inc CHAR_ID
				lda #0
				sta BYTE_ID

			EndLoop:

				cpx #255
				beq Finish2
				inx
				jmp Loop2

		Finish2:

		}


		ldx #ZERO

		Second: {

		Loop2: 

			lda SCREEN_DATA.Game +256, x
			sta $8000 + 256, x

			CheckNextChar:
				inc BYTE_ID
				lda BYTE_ID
				cmp #8
				beq NewChar
				jmp EndLoop

			NewChar:

				inc CHAR_ID
				lda #0
				sta BYTE_ID

			EndLoop:

				cpx #255
				beq Finish2
				inx
				jmp Loop2

		Finish2:

		}

		ldx #ZERO

		Third: {

		Loop2: 

			lda SCREEN_DATA.Game +512, x
			sta $8000 + 512, x
			CheckNextChar:
				inc BYTE_ID
				lda BYTE_ID
				cmp #8
				beq NewChar
				jmp EndLoop

			NewChar:

				inc CHAR_ID
				lda #0
				sta BYTE_ID

			EndLoop:

				cpx #255
				beq Finish2
				inx
				jmp Loop2

		Finish2:

		}
	

		ldx #ZERO

		Fourth: {

		Loop2: 

			lda SCREEN_DATA.Game +768, x
			sta $8000 +768, x

			CheckNextChar:
				inc BYTE_ID
				lda BYTE_ID
				cmp #8
				beq NewChar
				jmp EndLoop

			NewChar:

				inc CHAR_ID
				lda #0
				sta BYTE_ID

			EndLoop:

				cpx #255
				beq Finish2
				inx
				jmp Loop2

		Finish2:

		}

		Nope:
			rts
	}

}



}