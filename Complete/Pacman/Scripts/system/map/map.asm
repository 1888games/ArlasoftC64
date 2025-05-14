.namespace MAP {	

	


	
	RefreshColourMap: {

		lda GAME.KillScreen
		beq NormalMap

		IsKillMap:

			lda #<KillMap
			sta ZP.SourceAddress

			lda #>KillMap
			sta ZP.SourceAddress + 1

			jmp Skip

		NormalMap:

			lda #<MazeMap
			sta ZP.SourceAddress

			lda #>MazeMap
			sta ZP.SourceAddress + 1

		Skip:

			lda #<MazeColours
			sta ZP.DestAddress

			lda #>MazeColours
			sta ZP.DestAddress + 1

			ldx #0
			ldy #0

		Loop:

			stx ZP.X

			lda (ZP.SourceAddress), y
			tax

			lda CHAR_COLORS, x
			cmp #BLUE
			beq Wall
			cmp #BLUE + 48
			bne NotWalls

		Wall:

			sec
			sbc COMPLETE.ColourOffset
		

		NotWalls:

			sta (ZP.DestAddress), y

			ldx ZP.X

			iny
			bne Loop

			inc ZP.DestAddress + 1
			inc ZP.SourceAddress + 1
			
			
			inx
			cpx #4
			bcc Loop
			

		rts

	}

	
	ColourScreen: {

		ldx #0

		Loop:

			sta VIC.COLOR_RAM + 0, x
			sta VIC.COLOR_RAM + 250, x
			sta VIC.COLOR_RAM + 500, x
			sta VIC.COLOR_RAM + 750, x

			inx
			cpx #250
			bcc Loop


		rts
	}


	
	
	ClearPellets2: {

			ldy #0
			ldx #0

		Loop:

			lda SCREEN_RAM_2 + 0, y
			cmp #98
			bcc Skip1

			txa
			sta SCREEN_RAM_2 + 0, y

			Skip1:


			lda SCREEN_RAM_2 + 250, y
			cmp #98
			bcc Skip2

			txa
			sta SCREEN_RAM_2 + 250, y

			Skip2:

			lda SCREEN_RAM_2 + 500, y
			cmp #98
			bcc Skip3

			txa
			sta SCREEN_RAM_2 + 500, y

			Skip3:

			lda SCREEN_RAM_2 + 750, y
			cmp #98
			bcc Skip4

			txa
			sta SCREEN_RAM_2 + 750, y

			Skip4:

			iny
			cpy #250
			bcc Loop


		rts



	}
	

	ClearPellets: {

			lda SCROLLER.CurrentScreen
			bne ClearPellets2

			ldy #0
			ldx #0

		Loop:

			lda SCREEN_RAM + 0, y
			cmp #98
			bcc Skip1

			txa
			sta SCREEN_RAM + 0, y

			Skip1:


			lda SCREEN_RAM + 250, y
			cmp #98
			bcc Skip2

			txa
			sta SCREEN_RAM + 250, y

			Skip2:

			lda SCREEN_RAM + 500, y
			cmp #98
			bcc Skip3

			txa
			sta SCREEN_RAM + 500, y

			Skip3:

			lda SCREEN_RAM + 750, y
			cmp #98
			bcc Skip4

			txa
			sta SCREEN_RAM + 750, y

			Skip4:

			iny
			cpy #250
			bcc Loop


		rts


	}


	ColourOutlines: {

		ldy #0

		Loop:

			lda VIC.COLOR_RAM + 0, y
			and #%00001111
			beq Skip1

			txa
			sta VIC.COLOR_RAM + 0, y

			Skip1:


			lda VIC.COLOR_RAM + 250, y
			and #%00001111
			beq Skip2

			txa
			sta VIC.COLOR_RAM + 250, y

			Skip2:

			lda VIC.COLOR_RAM + 500, y
			and #%00001111
			beq Skip3

			txa
			sta VIC.COLOR_RAM + 500, y

			Skip3:

			lda VIC.COLOR_RAM + 750, y
			and #%00001111
			beq Skip4

			txa
			sta VIC.COLOR_RAM + 750, y

			Skip4:

			iny
			cpy #250
			bcc Loop




		rts
	}

	DisplayInitialScreen: {

		
		jsr UTILITY.ClearScreen

		lda #6
		ldx #29
		jsr UTILITY.BlockBorders

		lda GAME.KillScreen
		beq NormalMap

		IsKillMap:

			lda #<KILL_MAP + (SCROLLER.START_ROW * SCROLLER.MAP_COLUMNS)
			sta ZP.SourceAddress

			lda #>KILL_MAP + (SCROLLER.START_ROW * SCROLLER.MAP_COLUMNS)
			sta ZP.SourceAddress + 1

			jmp Skip

		NormalMap:

		lda #<MAP_LOCATION + (SCROLLER.START_ROW * SCROLLER.MAP_COLUMNS)
		sta ZP.SourceAddress

		lda #>MAP_LOCATION + (SCROLLER.START_ROW * SCROLLER.MAP_COLUMNS)
		sta ZP.SourceAddress + 1

		Skip:

		lda #<SCREEN_RAM + (SCROLLER.TOP_BORDER_ROWS * 40) + SCROLLER.START_COLUMN
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + (SCROLLER.TOP_BORDER_ROWS * 40) + SCROLLER.START_COLUMN
		sta ZP.ScreenAddress + 1

		lda #<MazeColours + (SCROLLER.START_ROW * SCROLLER.MAP_COLUMNS)
		sta ZP.DataAddress

		lda #>MazeColours + (SCROLLER.START_ROW * SCROLLER.MAP_COLUMNS)
		sta ZP.DataAddress + 1

		lda #<VIC.COLOR_RAM + (SCROLLER.TOP_BORDER_ROWS * 40) + SCROLLER.START_COLUMN
		sta ZP.ColourAddress

		lda #>VIC.COLOR_RAM + (SCROLLER.TOP_BORDER_ROWS * 40) + SCROLLER.START_COLUMN
		sta ZP.ColourAddress + 1



		ldy #0
		ldx #0

		Loop:

			
			lda (ZP.SourceAddress), y
			sta (ZP.ScreenAddress), y

			lda (ZP.DataAddress), y
			sta (ZP.ColourAddress), y

			cpy #18
			bcc NotKill

			lda GAME.KillScreen
			beq NotKill

			jsr RANDOM.Get
			sta (ZP.ColourAddress), y

			NotKill:

			iny
			cpy #SCROLLER.MAP_COLUMNS
			bcc Loop

			ldy #0

			lda ZP.SourceAddress
			clc
			adc #SCROLLER.MAP_COLUMNS
			sta ZP.SourceAddress

			lda ZP.SourceAddress + 1
			adc #0
			sta ZP.SourceAddress + 1

			
			lda ZP.DataAddress
			clc
			adc #SCROLLER.MAP_COLUMNS
			sta ZP.DataAddress

			lda ZP.DataAddress + 1
			adc #0
			sta ZP.DataAddress + 1

			lda ZP.ScreenAddress 
			clc
			adc #40
			sta ZP.ScreenAddress

			lda ZP.ScreenAddress + 1
			adc #0
			sta ZP.ScreenAddress + 1

			lda ZP.ColourAddress 
			clc
			adc #40
			sta ZP.ColourAddress 

			lda ZP.ColourAddress + 1
			adc #0
			sta ZP.ColourAddress + 1

			inx
			cpx #SCROLLER.VIEWPORT_ROWS
			bcc Loop




		rts
	}
	

}
