GAME: {

	* = * "Game"

	

	.label NextCellTime = 20
	.label NextCellCount = 6
	.label SpritePointer = 56
	.label SpriteHomeX = 151
	.label SpriteHomeY = 123
	.label MoveTime = 2
	.label MovePixels = 4
	.label ZoomPixels = 8



	

	Show: {

		lda #0
		sta ZP.NextCellType
		sta ZP.PlayerDirection
		sta ZP.PlayerMode
		sta ZP.PlayerRow
		sta ZP.PlayerColumn
		sta ZP.PlayerTargetX
		sta ZP.PlayerTargetY
		sta VIC.SPRITE_MULTICOLOR_1
		sta ZP.PlayerCell

		lda #CELL_TYPE_PEAR
		sta ZP.PlayerType

		lda #255
		sta VIC.SPRITE_ENABLE
		sta VIC.SPRITE_MULTICOLOR

		lda #1
		sta VIC.SPRITE_MULTICOLOR_2

		jsr ClearGrid
		jsr FillScreen


		jsr CalculateTargetPosition

		lda ZP.PlayerTargetX
		sta ZP.PlayerX

		lda ZP.PlayerTargetY
		sta ZP.PlayerY

		lda ZP.PlayerTargetX_MSB
		sta ZP.PlayerX_MSB

		jsr DrawPlayerSprite

		jsr NewCell

		rts
	}







	ClearGrid: {

		ldx #88
		lda #0

		Loop:

			sta ZP.Grid - 1, x
			dex
			bne Loop


		rts
	}



	CalculateTargetPosition: {

		lda #0
		sta ZP.PlayerTargetX_MSB

		ldx ZP.PlayerColumn
		lda PosLook, x
		clc
		adc #SpriteHomeX
		sta ZP.PlayerTargetX

		ldx ZP.PlayerRow
		lda PosLook, x
		clc
		adc #SpriteHomeY
		sta ZP.PlayerTargetY
	
		rts
	}

	
	NewCell: {


			lda #15
			sta $d418



		Quadrant:

			jsr RANDOM.Get
			and #%00000011
			cmp ZP.LastQuadrant
			beq Quadrant

			sta ZP.LastQuadrant

			asl
			asl
			sta ZP.Amount

			jsr RANDOM.Get
			and #%00000011
			clc
			adc ZP.Amount

			tax
			lda StartIDs, x
			sta ZP.NextCellID

			inx
			lda StartIDs, x
			sta ZP.NextCellSectionEnd
			dec ZP.NextCellSectionEnd

			
			jsr RANDOM.Get
			and #%00000011
			clc
			adc #3
			sta ZP.NextCellType

			lda ZP.NextCellSpeed
			sta ZP.NextCellTimer

			lda #NextCellCount
			sta ZP.NextCellCountdown

			jsr Takeaway


		rts
	}	


	DrawPlayerSprite: {

		lda #56
		clc
		adc ZP.PlayerDirection
		sta SPRITE_POINTERS

		ldx ZP.PlayerType
		cpx #CELL_TYPE_STRAWBERRY
		bne Okay

		lda #RED
		jmp ColourIt

		Okay:

		lda Colours, x
		sec
		sbc #8

		ColourIt:

		sta SPRITE_COLOR_0

		lda VIC.SPRITE_MSB
		and #%11111110
		sta VIC.SPRITE_MSB

		lda ZP.PlayerX
		sta VIC.SPRITE_0_X

		lda ZP.PlayerY
		sta VIC.SPRITE_0_Y

		lda ZP.PlayerX_MSB
		beq NoChange

		lda VIC.SPRITE_MSB
		ora #%00000001
		sta VIC.SPRITE_MSB

		NoChange:

		rts


	}



	MoveCellsAlong: {

	

		ldx ZP.NextCellSectionEnd

		lda ZP.Grid, x
		bne GameOver

		Loop:

			stx ZP.X

			lda ZP.Grid - 1, x
			beq EndLoop

			sta ZP.Grid, x
			sta ZP.CharID

			lda RowLookup, x
			sta ZP.Row

			lda ColLookup, x
			sta ZP.Column

			jsr CalculateAddresses

			lda #0
			sta ZP.Y

			ldy ZP.CharID
			jsr DrawCell

			EndLoop:

			ldx ZP.X

			dex
			cpx ZP.NextCellID
			beq Finish

			jmp Loop



			GameOver:

			lda #RED
			sta VIC.BORDER_COLOR
			sta ZP.GameMode
			sta ZP.Cooldown


		Finish:


		rts
	}




	CheckMove: {

		lda ZP.PlayerMode
		beq Finish

		jmp MovePlayer

		Finish:

		rts
	}

	FrameUpdate: {

		jsr CheckMove

		lda ZP.NextCellType
		beq Finish
		
		lda ZP.NextCellTimer
		beq Ready

		dec ZP.NextCellTimer
		rts

		Ready:

			dec ZP.NextCellCountdown

			lda ZP.NextCellSpeed
			sta ZP.NextCellTimer

			lda ZP.NextCellCountdown
			bmi Complete
			and #%00000001
			beq ShowReticle


				ldx ZP.NextCellID
				lda ZP.Grid, x
				sta ZP.CharID
				jmp Draw

			ShowReticle:

				lda #2	
				sta ZP.CharID


			Draw:

				ldx ZP.NextCellID
				lda RowLookup, x
				sta ZP.Row

				lda ColLookup, x
				sta ZP.Column

				jsr CalculateAddresses

				lda #0
				sta ZP.Y

				ldy ZP.CharID
				jsr DrawCell
				rts


			Complete:

			jsr MoveCellsAlong

			ldx ZP.NextCellID
			lda ZP.NextCellType
			sta ZP.Grid, x

			lda RowLookup, x
			sta ZP.Row

			lda ColLookup, x
			sta ZP.Column

			jsr CalculateAddresses

			ldy #0
			sty ZP.Y

			ldy ZP.NextCellType
			jsr DrawCell

			jsr NewCell


		Finish:





		rts
	}



	FillScreen: {

		ldx #0
		ldy #0

		lda #<SCREEN_RAM + 40
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 40
		sta ZP.ScreenAddress + 1


		lda #<COLOR_RAM + 40
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 40
		sta ZP.ColourAddress + 1

		ldx #0

		RowLoop:

			ldy #0


			ColLoop:

				sty ZP.Y

				CheckIfMiddle:

					cpy #2
					bcc Middle

					cpy #38
					bcs Middle

					cpx #4
					bcc NotMiddle

					cpx #8
					bcs NotMiddle

					cpy #16
					bcc NotMiddle

					cpy #24
					bcs NotMiddle

					Middle:

					ldy #CELL_TYPE_CENTRE
					jmp Draw


				NotMiddle:	

					ldy #CELL_TYPE_BLANK

				Draw:
			
	
					jsr DrawCell

					ldy ZP.Y
					iny
					iny
					cpy #40
					bcc ColLoop

					jsr MoveDownRow
					jsr MoveDownRow

					inx
					cpx #12
					bcc RowLoop



		rts
	}



	DrawCell: {

		sty ZP.Amount

		lda Colours, y
		sta ZP.Colour

		tya
		asl
		asl
		clc
		adc #228
		sta ZP.CharID

		ldy ZP.Y
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

		iny

		lda ZP.Colour
		sta (ZP.ColourAddress), y

		inc ZP.CharID
		lda ZP.CharID
		sta (ZP.ScreenAddress), y

		lda ZP.Amount
		cmp #CELL_TYPE_STRAWBERRY
		bne NotStrawberry

		lda #10
		sta ZP.Colour

		NotStrawberry:

		
		tya
		clc
		adc #39
		tay

		inc ZP.CharID
		lda ZP.CharID
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y


		iny

		inc ZP.CharID
		lda ZP.CharID
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y



		rts
	}




	MoveLeft: {

		lda ZP.PlayerX
		sec
		sbc #16
		sta ZP.PlayerTargetX

		bcs NoWrap1

		dec ZP.PlayerTargetX_MSB

		NoWrap1:

		rts


	}

	MoveRight: {

		lda ZP.PlayerX
		clc
		adc #16
		sta ZP.PlayerTargetX

		bcc NoWrap2

		inc ZP.PlayerTargetX_MSB

		NoWrap2:

		rts

	}

	MoveUp: {

		lda ZP.PlayerY
		sec
		sbc #16
		sta ZP.PlayerTargetY

		rts



	}

	MoveDown: {

		lda ZP.PlayerY
		clc
		adc #16
		sta ZP.PlayerTargetY

		rts

	}



	StoreUD: {

		sta ZP.PlayerGridPosition
		sta ZP.PlayerStartPosition
		sec
		sbc #3
		sta ZP.PlayerEndPosition

		jmp Fire.PutInFireMode

	}


	StoreLR: {


		sta ZP.PlayerGridPosition
		sta ZP.PlayerStartPosition
		sec
		sbc #6
		sta ZP.PlayerEndPosition

		jmp Fire.PutInFireMode

	}

	Fire: {

		ldx ZP.PlayerCell
		lda CanFire, x
		beq Finish

		lda ZP.PlayerX_MSB
		sta ZP.PlayerTargetX_MSB

		lda ZP.PlayerDirection
		beq Left

		cmp #1
		beq Right

		cmp #2
		beq Up

		Down:

			jsr MoveDown

			ldx ZP.PlayerColumn
			lda DownLookup, x
			jmp StoreUD
			

		Up:

			jsr MoveUp

			ldx ZP.PlayerColumn
			lda UpLookup, x
			jmp StoreUD

		Right:

			jsr MoveRight


			ldx ZP.PlayerRow
			lda RightLookup, x

			jmp StoreLR


		Left:

			//.break

			jsr MoveLeft


			ldx ZP.PlayerRow
			lda LeftLookup, x
			jmp StoreLR

		PutInFireMode:

			lda #PLAYER_MODE_FIRE
			sta ZP.PlayerMode

			lda #ZoomPixels
			sta ZP.PlayerMovePixels

		Finish:



		rts
	}




	CheckControls: {

		ldx ZP.PlayerMode
		beq OkayToMove

		rts

		OkayToMove:

		lda ZP.Cooldown
		beq Ready

		dec ZP.Cooldown
		rts

		Ready:

		lda $dc00
		sta ZP.Amount


		CheckFire:

			and #JOY_FIRE
			bne	CheckLeft

			jmp Fire


		CheckLeft:

			lda ZP.Amount
			and #JOY_LEFT
			bne	CheckRight

			Left:

				lda #LEFT
				sta ZP.PlayerDirection
				
				lda ZP.PlayerColumn	
				beq Draw

				dec ZP.PlayerColumn
				dec ZP.PlayerCell
				jmp CalcNew
			

		CheckRight:

			lda ZP.Amount
			and #JOY_RIGHT
			bne	CheckUp

			Right:


				lda #RIGHT
				sta ZP.PlayerDirection

				lda ZP.PlayerColumn
				cmp #3
				beq Draw

				inc ZP.PlayerColumn
				inc ZP.PlayerCell
				jmp CalcNew


		CheckUp:

			lda ZP.Amount
			and #JOY_UP
			bne	CheckDown

			Up:

				lda #UP
				sta ZP.PlayerDirection


				lda ZP.PlayerRow
				beq Draw

				dec ZP.PlayerRow

				lda ZP.PlayerCell
				sec
				sbc #4
				sta ZP.PlayerCell

				jmp CalcNew


		CheckDown:

			lda ZP.Amount
			and #JOY_DOWN
			bne	Finish

			Down:

				lda #DOWN
				sta ZP.PlayerDirection

				lda ZP.PlayerRow
				cmp #3
				beq Draw

				inc ZP.PlayerRow


				lda ZP.PlayerCell
				clc
				adc #4
				sta ZP.PlayerCell


		CalcNew:

			lda #MovePixels
			sta ZP.PlayerMovePixels

			lda #PLAYER_MODE_MOVE
			sta ZP.PlayerMode
			jsr CalculateTargetPosition

		Draw:

		jsr DrawPlayerSprite


		Finish:

			jsr GAME.CheckFaceDirection

		rts

	}	



	

	MovePlayer: {

		lda ZP.PlayerDirection
		beq GoingLeft

		cmp #1
		beq GoingRight

		cmp #2
		beq GoingUp
			
		GoingDown:	

				lda ZP.PlayerY
				clc
				adc ZP.PlayerMovePixels
				sta ZP.PlayerY
				jmp CheckY
			

		GoingUp:

				lda ZP.PlayerY
				sec
				sbc ZP.PlayerMovePixels
				sta ZP.PlayerY

		CheckY:
				cmp ZP.PlayerTargetY
				beq Arrived

				jmp Finish

		GoingRight:

			lda ZP.PlayerX
			clc
			adc ZP.PlayerMovePixels
			sta ZP.PlayerX

			bcc NoWrap1

			inc ZP.PlayerX_MSB

			NoWrap1:

			jmp CheckX

		GoingLeft:

			lda ZP.PlayerX
			sec
			sbc ZP.PlayerMovePixels
			sta ZP.PlayerX

			bcs NoWrap2

			dec ZP.PlayerX_MSB

			NoWrap2:
			
		
		CheckX:

			lda ZP.PlayerTargetX_MSB
			cmp ZP.PlayerX_MSB
			bne Finish

			lda ZP.PlayerTargetX
			cmp ZP.PlayerX
			bne Finish

		Arrived:

			lda ZP.PlayerMode
			cmp #PLAYER_MODE_MOVE
			beq Stopped

			cmp #PLAYER_MODE_FIRE
			beq Firing

			ldx ZP.PlayerDirection
			lda OppositeTurn, x
			sta ZP.PlayerDirection

		
			jmp Stopped


			Firing:

				jsr CheckHitFruit
				jmp Finish


			Stopped:

				lda #0
				sta ZP.PlayerMode

				lda #2
				sta ZP.Cooldown


			//.break
			//nop

	

		Finish:

			jsr DrawPlayerSprite


		rts
	}



	Score: {


		ldx #4

		Loop:

			inc SCREEN_RAM + 20, x
			lda SCREEN_RAM + 20, x
			cmp #58
			bcc Okay

			lda #48
			sta SCREEN_RAM + 20, x

			dex
			bne Loop


		Okay:

		rts
	}

	Takeaway: {

		ldx #3

		Loop:

			dec SCREEN_RAM + 34, x
			lda SCREEN_RAM + 34, x
			cmp #48
			bcs Okay


			lda #57
			sta SCREEN_RAM + 34, x

			dex
			bne Loop


		Okay:

		lda SCREEN_RAM + 35
		clc
		adc SCREEN_RAM + 36
		clc
		adc SCREEN_RAM + 37
		cmp #144
		bne NotComplete

		Completed:

			lda #GREEN
			sta VIC.BORDER_COLOR
			sta ZP.Cooldown

			lda #1

			jsr Complete

			lda ZP.Takeaway + 1
			cmp #10
			bcc NotComplete

			lda #0
			sta ZP.Takeaway + 1
			inc ZP.Takeaway

			lda ZP.NextCellSpeed
			cmp #5
			bcc NotComplete

			dec ZP.NextCellSpeed
			dec ZP.NextCellSpeed
		
		
		NotComplete:

		rts


	}

	CheckHitFruit: {

		ldx ZP.PlayerGridPosition
		lda ZP.Grid, x
		beq NoHit


		HitSomething:

			cmp ZP.PlayerType
			beq PloughThrough

			SwitchColours:

			pha

			lda ZP.PlayerType
			sta ZP.Grid, x

			pla
			sta ZP.PlayerType

			ReturnBack:

				lda #PLAYER_MODE_RETURN
				sta ZP.PlayerMode

				ldx ZP.PlayerDirection
				lda OppositeTurn, x
				sta ZP.PlayerDirection

				jsr CalculateTargetPosition

				jmp UpdateGraphics

			PloughThrough:

				lda #0
				sta ZP.Grid, x
				jsr Score

			UpdateGraphics:

				ldx ZP.PlayerGridPosition
				lda RowLookup, x
				sta ZP.Row

				lda ColLookup, x
				sta ZP.Column

				jsr CalculateAddresses

				ldy #0
				sty ZP.Y
				
				lda ZP.Grid, x
				tay
				jsr DrawCell

				lda ZP.PlayerMode
				cmp #PLAYER_MODE_RETURN
				bne NoHit

				rts

		NoHit:

		ldx ZP.PlayerGridPosition
		cpx ZP.PlayerEndPosition
		beq ReturnBack


		KeepGoing:

		dec ZP.PlayerGridPosition

		lda ZP.PlayerDirection
		beq Left

		cmp #1
		beq Right

		cmp #2
		beq Up

		Down:

			jmp MoveDown

		Up:

			jmp MoveUp

		Left:

			jmp MoveLeft
		

		Right:

			jmp MoveRight


		rts
	}


	//* = $650 "CheckFaceDirection"

	CheckFaceDirection: {

		lda ZP.PlayerMode
		beq CheckFaceUpDown

		rts

		CheckFaceUpDown:

			lda ZP.PlayerRow
			beq TopRow

			cmp #3
			beq BottomRow

			jmp CheckFaceLeftRight

			TopRow:

				lda ZP.PlayerColumn
				beq Finish

				cmp #3
				beq Finish

				lda #UP
				sta ZP.PlayerDirection
				jmp Finish

			BottomRow:

				lda ZP.PlayerColumn
				beq Finish

				cmp #3
				beq Finish

				lda #DOWN
				sta ZP.PlayerDirection
				jmp Finish

		CheckFaceLeftRight:

			lda ZP.PlayerColumn
			beq LeftColumn

			cmp #3
			beq RightColumn

			rts

			LeftColumn:

				lda ZP.PlayerRow
				beq Finish

				cmp #3
				beq Finish

				lda #LEFT
				sta ZP.PlayerDirection
				jmp Finish

			RightColumn:

				lda ZP.PlayerRow
				beq Finish

				cmp #3
				beq Finish

				lda #RIGHT
				sta ZP.PlayerDirection
				jmp Finish




		CheckRight:


		Finish:

		jsr DrawPlayerSprite

		rts
	}


	* = * "MoveDownRow"
	
	MoveDownRow: {

		lda ZP.ScreenAddress
		clc
		adc #40
		sta ZP.ScreenAddress

		bcc NoWrap

		inc ZP.ScreenAddress + 1

		NoWrap:

		lda ZP.ColourAddress
		clc
		adc #40
		sta ZP.ColourAddress
		bcc NoWrap2

		inc ZP.ColourAddress + 1

		NoWrap2:


		rts
	}


	* = * "CalculateAddresses"

	CalculateAddresses:{

		//get row for this position
		ldy ZP.Row
		lda ScreenRowLSB, y
	
		clc
		adc ZP.Column

		sta ZP.ScreenAddress
		sta ZP.ColourAddress

		lda ScreenRowMSB, y	
		adc #0  // get carry bit from above
		sta ZP.RowOffset

		lda #>SCREEN_RAM
		clc
		adc ZP.RowOffset
		sta ZP.ScreenAddress + 1

		lda #>COLOR_RAM
		clc
		adc ZP.RowOffset
		sta ZP.ColourAddress +1


		rts

	}


	* = $0f00 "Gap"

	Complete: {

		sta ZP.GameMode
	
		inc SCREEN_RAM + 10
		lda SCREEN_RAM + 10
		cmp #58
		bcc Okay

		lda #48
		sta SCREEN_RAM + 10
		inc SCREEN_RAM + 9

		Okay:

		inc ZP.Takeaway + 1


		rts
	}


		* = $0540 "Data"

	ScreenRowLSB2:	.fill 25, <[i * $28]

	* = * "MSB" 
	ScreenRowMSB2:	.fill 25, >[i * $28]

	* = * "RowLookup" 
	RowLookup2:		.fill 7, 9
					.fill 7, 11
					.fill 7, 13
					.fill 7, 15

					.fill 7, 9
					.fill 7, 11
					.fill 7, 13
					.fill 7, 15

					.fill 4, 1 + (i * 2)
					.fill 4, 1 + (i * 2)
					.fill 4, 1 + (i * 2)
					.fill 4, 1 + (i * 2)

					.fill 4, 23 - (i*2)
					.fill 4, 23 - (i*2)
					.fill 4, 23 - (i*2)
					.fill 4, 23 - (i*2)
					

	* = * "ColLookup"		
	ColLookup2:		.fill 7, 2 + ( i * 2 )
					.fill 7, 2 + ( i * 2 )
					.fill 7, 2 + ( i * 2 )
					.fill 7, 2 + ( i * 2 )

					.fill 7, 36 - ( i * 2 )
					.fill 7, 36 - ( i * 2 )
					.fill 7, 36 - ( i * 2 )
					.fill 7, 36 - ( i * 2 )

					.fill 4, 16
					.fill 4, 18
					.fill 4, 20
					.fill 4, 22

					.fill 4, 16
					.fill 4, 18
					.fill 4, 20
					.fill 4, 22

	* = * "Colours"
	Colours2:	.byte WHITE + 8, WHITE + 8, YELLOW + 8, GREEN + 8, YELLOW + 8, GREEN + 8, PURPLE + 8

	* = * "StartIDs"
	StartIDs2:		.byte 0, 7, 14, 21, 28, 35, 42, 49, 56, 60, 64, 68, 72, 76, 80, 84, 88
	* = * "PosLook"
	PosLook2:		.byte 0, 16, 32, 48
	* = * "CanFire"
	CanFire2:		.byte 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1

	* = * "LeftLookup"
	LeftLookup2:		.byte 6, 13, 20, 27
	* = * "UpLookup"
	UpLookup2:		.byte 59, 63, 67, 71
	* = * "RightLookup"
	RightLookup2:	.byte 34, 41, 48 ,55
	* = * "DownLookup"
	DownLookup2:	.byte 75, 79, 83, 87
	* = * "OppositeTurn"
	OppositeTurn2: .byte 1, 0, 3, 2


	* = $140 virtual 
	ScreenRowLSB: .byte 0
	* = $159 virtual
	ScreenRowMSB: .byte 0
	* = $172 virtual
	RowLookup: .byte 0
	* = $1ca virtual
	ColLookup: .byte 0
	* = $222 virtual
	Colours: .byte 0
	* = $229 virtual
	StartIDs: .byte 0
	* = $23a virtual
	PosLook: .byte 0
	* = $23e virtual
	CanFire: .byte 0
	* = $24e virtual
	LeftLookup: .byte 0
	* = $252 virtual
	UpLookup: .byte 0
	* = $256 virtual
	RightLookup: .byte 
	* = $25a virtual
	DownLookup: .byte 0
	* = $25e virtual
	OppositeTurn: .byte 0

	* = $250 virtual
	//CheckFaceDirection: .byte 0
	* = $2a9 virtual
	//MoveDownRow: .byte 0
	* = $2c0 virtual
	//CalculateAddresses: .byte 0





}