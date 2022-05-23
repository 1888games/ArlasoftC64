GRID: {

	.label Rows = 12
	.label Columns = 6
	.label RowsPerFrame = 3

	.label TotalSquaresOnGrid = 72
	.label TotalSquaresOnScreen = 144
	.label PlayerOneStartColumn = 2
	.label PlayerTwoStartColumn = 26
	.label LastRowID = 11
	.label LastColumnID = 5
	.label CheckTime = 6
	.label SquashedBean = 233
	.label FirstAnimationFrame = 17

	.label BeanFallingType = 22
	.label BeanLandedType = BeanFallingType - 1
	.label BeanPoppedType = 25
	.label LastPoppedFrame = 23
	



	* = * "Grid Data"

	PlayerOne:	.fill Rows * Columns, GREEN
	PlayerTwo:	.fill Rows * Columns, BLACK

	Checked:	.fill TotalSquaresOnScreen, 0

	* = * "CurrentType"

	CurrentType:	.fill TotalSquaresOnScreen, 255
	PreviousType:	.fill TotalSquaresOnScreen, 255
	RocksAdjacent:	.fill TotalSquaresOnScreen, 255
	Delay:			.fill TotalSquaresOnScreen, 0

	PlayerLookup:	.byte 0, Rows * Columns

	RowsPerFrameUse:	.byte RowsPerFrame



	RelativeColumn:	.fill TotalSquaresOnScreen, [0,1,2,3,4,5]
	RelativeRow:	.fill TotalSquaresOnGrid, floor(i / 6)
					.fill TotalSquaresOnGrid, floor(i / 6)

	RowStart:	.fill 12, (i * Columns)
	BottomRightIDs:	.byte 71, 143

	BackgroundCharIDs:	.byte 158, 159, 160, 161, 158, 159
	BackgroundColours:	.fill 6, GRID_VISUALS.GRID_COLOUR

	ScreenShakeTimer:	.byte 0
	ScreenShakeValues:	.byte 3,4,3,5,3,6,3,6,3
	ScreenShakeValue:	.byte 0

	ColourLookup:		.byte 0, 1, 2, 3, 4, 5, 6, 7
	ColourBlind:		.byte 4, 5, 2, 0, 3, 1, 6, 7


	DirectionLookup:	.byte -1, -6, -7, -5


	CurrentRow:			.byte LastRowID
	StartRow:			.byte LastRowID

	CurrentSide:		.byte 0
	InitialDrawDone:	.byte 0
	GridClear:			.byte 255, 255
	GridClearAllowed:	.byte 0, 0
	BeanCount:			.byte 0, 0

	CheckTimer:			.byte 0, 0
	Mode:				.byte 1, 1
	CheckProgress:		.byte 0, 0
	NumberMoving:		.byte 1, 1
	NumberLanded:		.byte 0, 0
	Active:				.byte 1, 0
	RealCheck:			.byte 1, 1


	// Matching

	Matched:			.fill 64, 0
	QueueLength:		.byte 0
	MatchCount:			.byte 0
	NumberPopped:		.byte 0
	Combo:				.byte 0, 0
	ErrorCheck:			.byte 0
	StartLayers:		.byte 0, 0
	RunningCount:		.byte 0, 0


	* = * "Matches By Colour"
	MatchesByColour:	.fill 8, 0



	* = * "Grid"

	Reset: {

		jsr ClearGrid

		lda #LastRowID
		sta CurrentRow
		sta StartRow

		lda #0
		sta CurrentSide
		sta ScreenShakeTimer
		sta ZP.BeanType
		sta InitialDrawDone
		sta CheckTimer
		sta CheckTimer + 1
		sta QueueLength
		sta NumberPopped
		sta MatchCount
		sta Combo
		sta Combo + 1
		sta GridClear
		sta GridClear + 1
		sta GridClearAllowed
		sta GridClearAllowed + 1
		sta BeanCount
		sta BeanCount + 1
		sta RunningCount
		sta RunningCount + 1

		
		lda #1
		sta NumberMoving
		sta NumberMoving + 1
		sta Mode
		sta Mode + 1
		sta MAIN.GameActive
		sta Active

		lda MENU.SelectedOption
		cmp #PLAY_MODE_2P
		bne NoSecondPlayer

		lda #1
		sta Active + 1


		NoSecondPlayer:
		
		lda #RowsPerFrame
		sta RowsPerFrameUse

		//jsr DRAW.GamePlayerSprites
		//jsr DRAW.GamePlayerName
		//jsr DRAW.GameOpponentName
		//jsr DRAW.GameTitle

		

		
		


		rts
	}




	ScreenShake: {

		lda ScreenShakeTimer
		beq None

		dec ScreenShakeTimer
		lda ScreenShakeTimer
		beq Reset

		and #%00000111
		sta ScreenShakeValue

		tax

		lda ScreenShakeValues, x
		sta ScreenShakeValue
		rts

		Reset:

		lda #0
		sta ScreenShakeValue

		None:

		rts


	}


	FrameUpdate: {

		ldy #0
		lda INPUT.JOY_UP_NOW
		beq Nope

		lda #1
		sta ErrorCheck


		Nope:

		lda ZP.FrameCounter
		and #%00001111
		sta ZP.RowRefresh


		CheckIfGameActive:

			lda MAIN.GameActive
			beq Finish

		jsr ScreenShake

		UpdateLeftSide:

			ldx CurrentSide
			lda Active, x
			beq UpdateRightSide

			jsr UpdateSide

		UpdateRightSide:

			inc CurrentSide
			ldx CurrentSide
			lda Active, x
			beq PrepareForNextFrame

			jsr UpdateSide

		PrepareForNextFrame:

			dec CurrentSide
			lda CurrentRow
			sta StartRow

		Finish:

		rts
	}


	StartingGems: {








		rts
	}



	StartingRocks: {

		lda MENU.SelectedOption
		cmp #PLAY_MODE_SCENARIO
		beq Skip

		lda SETTINGS.RockLayers
		sta StartLayers

		lda SETTINGS.RockLayers + 1
		sta StartLayers + 1

		Skip:

		Player1:

			lda StartLayers
			beq Player2

			ldy #11
			tax
			dex

		Loop:	

			stx ZP.Y

			lda RowStart, y
			tax

			lda #WHITE
			sta PlayerOne, x
			sta PlayerOne + 1, x
			sta PlayerOne + 2, X
			sta PlayerOne + 3, x
			sta PlayerOne + 4, x
			sta PlayerOne + 5, x

			// lda RunningCount, x
			// clc
			// adc #5
			// sta RunningCount, x

			EndLoop:

				dey

				ldx ZP.Y
				dex
				bpl Loop



		Player2:

		lda Active + 1
		beq Finish

		lda StartLayers + 1
		beq Finish

		ldy #11
		tax
		dex

		Loop2:	

			stx ZP.X

			lda RowStart, y
			tax

			lda #WHITE
			sta PlayerOne + 72, x
			sta PlayerOne + 73, x
			sta PlayerOne + 74, X
			sta PlayerOne + 75, x
			sta PlayerOne + 76, x
			sta PlayerOne + 77, x

			EndLoop2:

				dey

				ldx ZP.X
				dex
				bpl Loop2


		Finish:

		rts
	}

	ClearGrid: {

		ldx BottomRightIDs + 1

		Loop:

			stx ZP.X

			EmptyCell:

				lda #BLACK
				sta PlayerOne, x

				lda #255
				sta PreviousType, x

				jsr GRID_VISUALS.ClearSquare

			EndLoop:

				ldx ZP.X
				dex
				cpx #255
				beq Finish

				jmp Loop


		Finish:

		jsr StartingRocks

		//jsr DummyBeans
	
		rts

	}



	DummyBeans: {

		ldy #0

		Loop2:

			sty ZP.TempY

			jsr RANDOM.Get
			and #%00111111
		//	clc
			//adc #72
			tax

			jsr RANDOM.Get
			and #%00000001
			sta PlayerOne, x

			jsr RANDOM.Get
			and #%00000011	
			clc
			adc PlayerOne, x
			tay
			lda PANEL.Colours, y
			sta PlayerOne, x

			ldy ZP.TempY

			iny
			cpy #80
			bcc Loop2

		lda #WHITE
		sta PlayerOne

		sta PlayerOne + 1
		sta PlayerOne + 2
		sta PlayerOne + 3


		rts
	}




	StartCheck: {

		lda #GRID_MODE_WAIT_CHECK
		sta Mode, x

		lda BottomRightIDs, x
		sta CheckProgress, x
		tay
		sec
		sbc #72
		sta ZP.EndID

		lda #CheckTime
		sta CheckTimer, x

		lda #0

		Loop:

			sta Checked, y

			dey
			cpy ZP.EndID
			bne Loop


		rts
	}





	PopBean: {

		stx ZP.BeanID

		lda PlayerOne, x
		beq AlreadyPopped
		sta ZP.PreviousBeanColour

		lda CurrentType, x
		cmp #BeanPoppedType
		beq AlreadyPopped

		CheckIfRock:

			ldx CurrentSide
			dec GRID.RunningCount, x

			ldx ZP.BeanID

			lda ZP.PreviousBeanColour
			cmp #WHITE
			bne NotRock

		IsRock:

		//	.break

			lda #0
			sta PlayerOne, x

			jsr GRID_VISUALS.ClearSquare

			jmp NoRockCheck

		NotRock:

			lda #BeanPoppedType
			sta CurrentType, x

			OnlyOneExplosionPerSet:

			ldy ZP.PoppedBeanNum
			cpy #1
			bne NoExplosion

			lda GRID_VISUALS.RowLookup, x
			sta ZP.Row

			lda GRID_VISUALS.ColumnLookup, x
			sta ZP.Column

			lda PlayerOne, x
			sta ZP.BeanColour

			jsr RANDOM.Get
			and #%00000001
			clc
			adc #1
			tax

			ldy ZP.BeanColour

			jsr EXPLOSIONS.StartExplosion

			//sfx(SFX_EXPLODE)

		NoExplosion:

			jsr CheckRocks

		NoRockCheck:

			ldx CurrentSide
			lda #1
			sta NumberMoving, x


		AlreadyPopped:

		rts
	}

		
	CheckRocks: {

		ldx ZP.PoppedBean
		lda RocksAdjacent, x
		sta ZP.Adjacency
		beq Finish

		CheckDown:

			and #DOWN
			beq CheckUp

			RockDown:

				lda ZP.PoppedBean
				clc
				adc #6
				tax

				jsr PopBean

		CheckUp:

			lda ZP.Adjacency
			and #UP
			beq CheckLeft

			RockUp:

				lda ZP.PoppedBean
				sec
				sbc #6
				tax

				jsr PopBean
	
		CheckLeft:

			lda ZP.Adjacency
			and #LEFT
			beq CheckRight

			RockLeft:

				ldx ZP.PoppedBean
				dex

				jsr PopBean

		CheckRight:

			lda ZP.Adjacency
			and #RIGHT
			beq Finish

	

			RockRight:

				ldx ZP.PoppedBean
				inx

				jsr PopBean

		Finish:






		rts
	}



	AddToMatched: {

		lda Checked, x
		bne SkipOne

		inc Checked, x

		ldy MatchCount
		txa
		sta Matched, y

		inc MatchCount

		ldy ZP.BeanColour
		lda MatchesByColour, y
		clc
		adc #1
		sta MatchesByColour, y

		SkipOne:

			ldy ZP.Temp1
			lda Checked, y
			bne SkipTwo	

			clc
			adc #1
			sta Checked, y

			tya
			ldy MatchCount
			sta Matched, y

			inc MatchCount

			ldy ZP.BeanColour
			lda MatchesByColour, y
			clc
			adc #1
			sta MatchesByColour, y

		SkipTwo:

			ldy ZP.Temp2
			lda Checked, y
			bne SkipThree

			clc
			adc #1
			sta Checked, y

			tya
			ldy MatchCount
			sta Matched, y

			inc MatchCount

			ldy ZP.BeanColour
			lda MatchesByColour, y
			clc
			adc #1
			sta MatchesByColour, y
			
		SkipThree:


		rts
	}

	

	Scan: {

		lda #0
		sta QueueLength
		sta MatchCount
		sta NumberPopped
		sta MatchesByColour
		sta MatchesByColour + 1
		sta MatchesByColour + 2
		sta MatchesByColour + 3
		sta MatchesByColour + 4
		sta MatchesByColour + 5
		sta MatchesByColour + 6
		sta MatchesByColour + 7

		ldx CurrentSide

		NoStop:

		lda PlayerLookup, x
		clc
		adc #1
		sta ZP.EndID

		lda CheckProgress, x
		tax

			
		CellLoop:

			stx ZP.CurrentSlotID

			CheckIfCellEmpty:

				lda PlayerOne, x
				sta ZP.BeanColour
				bne CheckIfRockOrSingle

				jmp Empty

			CheckIfRockOrSingle:

				cmp #1
				bne NotRock


				jmp Empty

			NotRock:

				lda CurrentType, x
				cmp #16
				bne Left

				jmp Empty

			Left:

				ldy CurrentSide
				lda PLAYER.MagicGems, y 
				cmp #3
				bne NotMagic

				lda ZP.BeanColour
				cmp PLAYER.MagicColours, y
				bne NotMagic

			MagicClearAll:

				stx ZP.Temp1
				stx ZP.Temp2

				jsr AddToMatched
				jmp EndLoop


			NotMagic:

				lda RelativeColumn, x
				cmp #2
				bcs CanDoLeft

				jmp Up

			CanDoLeft:

				txa
				sec
				sbc #1
				tay
				sty ZP.Temp1

				lda PlayerOne, x
				cmp PlayerOne, y
				bne UpLeft

				dey
				sty ZP.Temp2
				cmp PlayerOne, y
				bne UpLeft

				jsr AddToMatched
				
			UpLeft:

				lda RelativeRow, x
				cmp #2
				bcs CanDoUp

				jmp EndLoop

			CanDoUp:

				txa
				sec
				sbc #7
				tay
				sty ZP.Temp1

				lda PlayerOne, x
				cmp PlayerOne, y
				bne Up

				tya
				sec
				sbc #7
				tay
				sty ZP.Temp2


				lda PlayerOne, x
				cmp PlayerOne, y
				bne Up

				jsr AddToMatched

			Up:

				txa
				sec
				sbc #6
				tay
				sty ZP.Temp1

				lda PlayerOne, x
				cmp PlayerOne, y
				bne UpRight

				tya
				sec
				sbc #6
				tay
				sty ZP.Temp2


				lda PlayerOne, x
				cmp PlayerOne, y
				bne UpRight

				jsr AddToMatched


			UpRight:

				lda RelativeColumn, x
				cmp #4
				bcs EndLoop

				txa
				sec
				sbc #5
				tay
				sty ZP.Temp1

				lda PlayerOne, x
				cmp PlayerOne, y
				bne EndLoop

				tya
				sec
				sbc #5
				tay
				sty ZP.Temp2


				lda PlayerOne, x
				cmp PlayerOne, y
				bne EndLoop

				jsr AddToMatched


			Empty:

			EndLoop:

				ldx ZP.CurrentSlotID
				dex
				cpx ZP.EndID
				bcc Done

				jmp CellLoop


		Done:

			jsr CheckHowManyMatched

			ldx CurrentSide

			lda PLAYER.MagicGems, x
			cmp #3
			bne NoReset

			lda #255
			sta PLAYER.MagicGems, x

		NoReset:

			lda NumberPopped
			beq NextBeans

		WaitForDrop:

			inc Combo, x

			lda Combo, x
			clc
			adc #6
			cmp #12
			bcc OkaySound	

			lda #7

		OkaySound:

			tax
			sfxFromX()

			lda NumberPopped
			sec
			sbc #2
			bmi NoGarbage

			//.break

			//jsr ROCKS.CalculateChainRocks

		NoGarbage:

			ldx CurrentSide
			lda Combo, x
			sec
			sbc #1
			sta SCORING.CurrentChain, x
			sec
			sbc #1
			bmi NoGarbage2

			jsr ROCKS.CalculateComboRocks

		NoGarbage2: 

			ldx CurrentSide

			lda #PLAYER.PLAYER_STATUS_WAIT
			sta PLAYER.Status, x

			lda #GRID_MODE_NORMAL
			sta Mode, x


			jsr SCORING.CalculateMultiplier

			ldx CurrentSide
			lda RunningCount, x

			bne NotEmpty2

			//jsr ROCKS.GridCleared

		NotEmpty2:

			lda MENU.SelectedOption
			cmp #PLAY_MODE_PRACTICE
			beq Finish

			//jsr ROCKS.DecideWhereToSendFlare

			jmp Finish

		NextBeans:


				ldx CurrentSide
				jsr SCORING.ResetMultipliers
				jsr SCORING.DrawPlayer
		
				ldy CurrentSide
				lda ROCKS.OnWayToUs, y
				bne Finish

			Transfer:

				jsr ROCKS.TransferCountToQueue

				ldx CurrentSide

				lda #0
				sta Combo, x
				sta Active, x

				

		Finish:

				
		rts
	}

	


	CheckHowManyMatched: {


		lda MatchCount
		cmp #3
		bcc NoPop

		inc NumberPopped

		lda NumberPopped
		cmp #2
		bcs NoSfx

		sfx(SFX_BLOOP)


		NoSfx:

		CalculateGarbage:

			ldx CurrentSide
			beq NoSpeedCheck

			lda #0
			sta PANEL.FirstFourMatch


			NoSpeedCheck:

			lda MatchCount
			sec
			sbc #3
			bmi NoGarbage

			//jsr ROCKS.CalculateBaseRocks

		NoGarbage:

			ldy MatchCount
			dey

		Loop:
			sty ZP.PoppedBeanNum

			lda Matched, y
			tax
			stx ZP.PoppedBean

			//.break

			jsr PopBean

			ldx ZP.PoppedBean
			jsr GRID_VISUALS.DrawBean

			ldy ZP.PoppedBeanNum
			dey
			bpl Loop


		NoPop:



		lda #0
		//sta MatchCount



		rts
	}




	UpdateReadyToCheck: {

		lda Mode, x
		cmp #GRID_MODE_WAIT_CHECK
		bne Finish

		WaitingForCheck:

			lda CheckTimer, x
			beq ReadyToCheck

			dec CheckTimer, x
			jmp Finish

		ReadyToCheck:

			lda #GRID_MODE_CHECK
			sta Mode, x


		Finish:

			cmp #GRID_MODE_CHECK
			bne NotChecking

			jmp Scan

		NotChecking:


		rts
	}


	EndOfRound: {


		lda #0
		sta Active
		sta Active + 1

		lda #GRID_MODE_PAUSE
		sta Mode
		sta Mode + 1

		jsr ROUND_OVER.ShowRest


		rts
	}



	ClearCheck: {

		//jsr RANDOM.Get
		//and #%00000111
		//sta BeanCount, x

		//.break

		lda RunningCount, x
		bne Finish

		jsr ROCKS.GridCleared

		Finish:

		lda #0
		sta GridClear, x

		rts
	}


	EndOfCycle: {

		lda #LastRowID
		sta CurrentRow

		lda #1
		sta InitialDrawDone

		ldx CurrentSide

		lda GridClear, x
		beq NoClearCheck

		//jsr ClearCheck

		NoClearCheck:

		lda Mode, x
		cmp #GRID_MODE_WAIT_CHECK
		beq StillMoving

		cmp #GRID_MODE_CHECK
		beq StillMoving

		lda NumberMoving, x
		bne StillMoving

		Check:

			lda Mode, x
			cmp #GRID_MODE_FALL
			bne NotGameOver

			EndRound:	

				jsr EndOfRound
				rts

			NotGameOver:

				lda #PLAYER.PLAYER_STATUS_WAIT
				sta PLAYER.Status, x

				jsr StartCheck

		StillMoving:

			ldx CurrentSide

			lda #0
			sta NumberMoving, x
			sta NumberLanded, x
			sta BeanCount, x


		rts
	}

	UpdateSide: {

		ldx CurrentSide

		lda Mode, x
		cmp #GRID_MODE_END
		beq Finish

		jsr UpdateReadyToCheck

		NormalMode:

			lda StartRow
			sta CurrentRow

			ldy RowsPerFrameUse
			dey

		Loop:

			sty ZP.FrameRow

			lda #0
			sta ZP.BeanType

			jsr UpdateRow

			NextRow:

				dec CurrentRow
				ldx CurrentRow
				bpl EndLoop

			StartAgain:	

				jsr EndOfCycle

			EndLoop:

				ldy ZP.FrameRow
				dey
				bpl Loop

		Finish:
	

		rts
	}

	





	GetStartAndEnd: {

		GetFirstGridID:

			ldx CurrentRow
			lda RowStart, x
			sta ZP.StartID

		AddIfRightSide:

			ldy CurrentSide
			lda PlayerLookup, y
			clc
			adc ZP.StartID
			sta ZP.StartID

		CalculateEndID:

			clc
			adc #Columns
			sta ZP.EndID

		ldx ZP.StartID


		rts
	}



	CheckIfAnimating: {

		DefaultSingleBean:

			lda #0
			sta CurrentType, x
			sta RocksAdjacent, x

		IfMinusCantBe:

			lda PreviousType, x
			sta ZP.PreviousType
			bmi Finish

		CheckPopAnimation:

			cmp #LastPoppedFrame
			bcc Finish

		AnimatePop:

			tay
			jsr GRID_VISUALS.UpdateAnimation

			ldx ZP.CurrentSlot

		Finish:


		rts
	}





	CheckLeftBean: {

		cpx ZP.StartID
		beq Finish

		NotFarLeft:

			dex
			lda PlayerOne, x
			inx
			
			cmp #WHITE
			bne NotRock

			Rock:

			lda RocksAdjacent, x
			ora #LEFT
			sta RocksAdjacent, x
			jmp Finish

			
			NotRock:

			cmp ZP.BeanColour
			bne Finish

			MatchToLeft:

				lda ZP.BeanType
				ora #LEFT
				sta ZP.BeanType

		Finish:


		rts
	}

	CheckAboveBean: {

		ldx ZP.CurrentSlot
		lda CurrentRow
		beq Finish

		txa
		sec
		sbc #Columns
		tax

		lda PlayerOne, x
		cmp #WHITE
		bne NotRock

		Rock:

		ldx ZP.CurrentSlot
		lda RocksAdjacent, x
		ora #UP
		sta RocksAdjacent, x
		jmp Finish
		
		NotRock:

		cmp ZP.BeanColour
		bne Finish

		MatchUp:

			lda ZP.BeanType
			ora #UP
			sta ZP.BeanType

		Finish:


		rts
	}

	CheckRightBean: {

		CheckFarRight:

			ldx ZP.CurrentSlot
			inx
			cpx ZP.EndID
			beq Finish

		NotFarRight:

			lda PlayerOne, x
			dex

			cmp #WHITE
			bne NotRock

		Rock:

			lda RocksAdjacent, x
			ora #RIGHT
			sta RocksAdjacent, x
			jmp Finish
		
		NotRock:

			cmp ZP.BeanColour
			bne Finish

		MatchToRight:

			lda ZP.BeanType
			ora #RIGHT
			sta ZP.BeanType

		Finish:

		rts
	}


	FallDown: {

		CheckIfBottomRow:

			lda CurrentRow
			cmp #LastRowID
			beq DeleteOldGridSpace

		NotBottomRow:

			txa
			clc
			adc #Columns
			tax

		CheckBeanBelow:

			lda PlayerOne, x
			beq TransferDataBelow

			ldx CurrentSide
			inc NumberMoving, x

			jmp Finish

		TransferDataBelow:

			lda ZP.BeanColour
			sta PlayerOne, x

			lda #BeanFallingType
			sta CurrentType, x
			sta ZP.BeanType

			lda #255
			sta PreviousType, x

			jsr GRID_VISUALS.DrawBean

		PreventCheckFiring:

			ldx CurrentSide
			inc NumberMoving, x

		DeleteOldGridSpace:

			ldx ZP.CurrentSlot
			lda #0
			sta PlayerOne, x

			lda #255
			sta PreviousType, x

			jsr GRID_VISUALS.ClearSquare

		Finish:
		

		rts

	}

	UpdateRow: {


		jsr GetStartAndEnd

		Loop:

			stx ZP.CurrentSlot

			jsr CheckIfAnimating
			
			CheckIfEmpty:

				lda #0
				sta ZP.SolidBelow

				lda PlayerOne, x
				sta ZP.BeanColour
				bne CheckLeft

				jmp EndLoop

			CheckInitialDraw:

				lda InitialDrawDone
				bne CheckLeft
				jmp Draw

			CheckLeft:	

				ldx CurrentSide
				inc BeanCount, x
				ldx ZP.CurrentSlot

			CheckWhetherPopped:

				lda PreviousType, x
				bmi NotPopped
				cmp #32
				beq NotPopped
				cmp #BeanFallingType
				bcc NotPopped
				beq NotPopped

			Popped:
			
				jmp SolidBelow

			NotPopped:

				jsr CheckLeftBean

			CheckDown:

					lda CurrentRow
					cmp #LastRowID
					beq BottomRow

				NotBottomRow:

					txa
					clc
					adc #Columns
					tax

				CheckBeanBelow:

					lda PlayerOne, x
					bne SolidBelow


					jmp MoveBeanDown

				BottomRow:

					ldy CurrentSide
					lda Mode, y
					cmp #GRID_MODE_FALL
					bne SolidBelow

					tya
					tax
					inc NumberMoving, x

					jmp DeleteOldGridSpace

				SolidBelow:

					inc ZP.SolidBelow
				
					ldy ZP.PreviousType
					bmi NotAnimating

					cpy #BeanFallingType
					beq FinishedFalling

					cpy #32
					beq IsRock

					cpy #FirstAnimationFrame
					bcc NotAnimating

				Animating:

					jsr GRID_VISUALS.UpdateAnimation
					jmp Draw

				FinishedFalling:

					ldx ZP.CurrentSlot
					lda #BeanLandedType
					sta ZP.BeanType

				PreventCheckFiring:

					ldx CurrentSide	
					inc NumberMoving, x

				CheckSoundToPlay:

					IsBean:

						//sfx(SFX_EXPLODE)
						jmp Draw

					IsRock:

						ldx CurrentSide
						lda PLAYER.Status, x
						cmp #PLAYER.PLAYER_STATUS_NORMAL
						bne AlreadyLanded

						lda ScreenShakeTimer
						clc
						adc #3
						sta ScreenShakeTimer

						sfx(SFX_LAND)

						AlreadyLanded:

						
						jmp Draw

				NotAnimating:

					lda CurrentRow
					cmp #LastRowID
					beq CheckUp

				CheckIfMatchBelow:

					lda PlayerOne, x
					cmp ZP.BeanColour
					beq MatchBelow

				CheckIfRockBelow:
				
					cmp #WHITE
					bne CheckUp

					ldx ZP.CurrentSlot
					lda RocksAdjacent, x
					ora #DOWN
					sta RocksAdjacent, x
					jmp CheckUp


				MatchBelow:

					lda ZP.BeanType
					ora #DOWN
					sta ZP.BeanType
					jmp CheckUp

				MoveBeanDown:

					lda ZP.BeanColour
					sta PlayerOne, x

					lda #BeanFallingType
					sta CurrentType, x
					sta ZP.BeanType

					lda #255
					sta PreviousType, x

					jsr GRID_VISUALS.DrawBean

				PreventCheckFiring2:

					ldx CurrentSide
					inc NumberMoving, x

				DeleteOldGridSpace:

					ldx ZP.CurrentSlot
					lda #0
					sta PlayerOne, x

					lda #255
					sta PreviousType, x

					jsr GRID_VISUALS.ClearSquare
					jmp ResetForNextBean

			CheckUp:

				jsr CheckAboveBean
				jsr CheckRightBean
			
			Draw:

				ldx ZP.CurrentSlot
				lda ZP.BeanType
				sta CurrentType, x
				jsr GRID_VISUALS.DrawBean

			ResetForNextBean:

			EndLoop:

				lda #0
				sta ZP.BeanType

				ldx ZP.CurrentSlot
				inx
				cpx ZP.EndID
				beq Finish

				jmp Loop


		Finish:

		

		rts
	}


	


}