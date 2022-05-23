GRID: {

	.label Rows = 8
	.label Columns = 5
	.label RowsPerFrame = 2

	.label TotalSquaresOnGrid = 40
	.label TotalSquaresOnScreen = 80
	.label PlayerOneStartColumn = 1
	.label PlayerTwoStartColumn = 24
	.label LastRowID = 7
	.label LastColumnID = 4
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

	PlayerLookup:	.byte 0, Rows * Columns

	RowsPerFrameUse:	.byte RowsPerFrame



	RelativeColumn:	.fill TotalSquaresOnScreen, [0,1,2,3,4]

	RowStart:	.fill Rows, (i * Columns)
	BottomRightIDs:	.byte TotalSquaresOnGrid - 1, TotalSquaresOnScreen - 1

	BackgroundCharIDs:	.byte 202, 203, 204, 205, 202, 203
	BackgroundColours:	.byte GREEN, PURPLE, YELLOW, CYAN, GREEN, PURPLE

	ScreenShakeTimer:	.byte 0
	ScreenShakeValues:	.byte 3,4,3,5,3,6,3,6,3
	ScreenShakeValue:	.byte 0



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
	Active:				.byte 0, 0
	RealCheck:			.byte 1, 1


	// Matching

	Queue:				.fill 32, 0
	Matched:			.fill 32, 0
	QueueLength:		.byte 0
	MatchCount:			.byte 0
	NumberPopped:		.byte 0
	Combo:				.byte 0, 0
	ErrorCheck:			.byte 0
	StartLayers:		.byte 0, 0



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

		
		lda #1
		sta NumberMoving
		sta NumberMoving + 1
		sta Mode
		sta Mode + 1
		sta MAIN.GameActive
		//sta Active

		lda MENU.SelectedOption
		cmp #PLAY_MODE_PRACTICE
		beq NoSecondPlayer

		lda #1
		//sta Active + 1

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

				lda #EMPTY_CELL
				sta PlayerOne, x

				lda #FORCE_REFRESH
				sta PreviousType, x

				jsr GRID_VISUALS.ClearSquare

			EndLoop:

				ldx ZP.X
				dex
				cpx #255
				beq Finish

				jmp Loop


		Finish:

		
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
		sbc #TotalSquaresOnGrid
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

			sfx(SFX_EXPLODE)

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


	Scan: {

		lda #0
		sta QueueLength
		sta MatchCount
		sta NumberPopped

		ldx CurrentSide
		//bne NoStop

	//	inc $d020
	

		// lda NumberMoving, x
		// .break
		// nop

		// lda ErrorCheck
		// beq NoStop

		// .break
		// nop

		// lda #0
		// sta ErrorCheck


		

		NoStop:


		lda PlayerLookup, x
		sta ZP.EndID

		lda CheckProgress, x
		tax
			
		CellLoop:

			stx ZP.SlotID
			stx ZP.CurrentSlotID

			CheckWhichCellToLookAt:

				ldy QueueLength
				beq UseNextCell

			UseQueue:

				dey
				sty QueueLength
				lda Queue, y
				tax
				sta ZP.CurrentSlotID

			UseNextCell:

				lda Checked, x
				beq CheckIfCellEmpty

			AlreadyChecked:

				jmp EndCellLoop

			CheckIfCellEmpty:

				lda PlayerOne, x
				sta ZP.BeanColour
				bne CheckIfRockOrSingle

				jmp Empty

			CheckIfRockOrSingle:

				lda CurrentType, x
				sta ZP.BeanType
				bne NotEmpty

				jmp Empty

				NotEmpty:

				cmp #16
				beq Empty

				bcc Increase

				Error:

				jmp EndCellLoop

				Increase:

				ldy MatchCount
				txa
				sta Matched, y

				inc MatchCount
				

			CheckRight:

					lda ZP.BeanType
					and #RIGHT
					beq CheckLeft

				MatchToRight:

					ldx ZP.CurrentSlotID
					inx
					lda Checked, x
					bne CheckLeft

				AddToQueueRight:

					ldy QueueLength
					txa
					sta Queue, y
					inc QueueLength

			CheckLeft:

					lda ZP.BeanType
					and #LEFT
					beq CheckDown

				MatchToLeft:

					ldx ZP.CurrentSlotID
					dex
					lda Checked, x
					bne CheckDown

				AddToQueueLeft:

					ldy QueueLength
					txa
					sta Queue, y
					inc QueueLength

			CheckDown:

					lda ZP.BeanType
					and #DOWN
					beq CheckUp

				MatchToDown:

					lda ZP.CurrentSlotID
					clc
					adc #6
					tax
					lda Checked, x
					bne CheckUp

				AddToQueueDown:

					ldy QueueLength
					txa
					sta Queue, y
					inc QueueLength

			CheckUp:

					lda ZP.BeanType
					and #UP
					beq EndCellLoop

				MatchToUp:

					lda ZP.CurrentSlotID
					sec
					sbc #6
					tax
					lda Checked, x
					bne EndCellLoop

				AddToQueueUp:

					ldy QueueLength
					txa
					sta Queue, y
					inc QueueLength

			Empty:

			EndCellLoop:

				ldx ZP.CurrentSlotID
				lda #1	
				sta Checked, x

			CheckItemsInQueue:

				lda QueueLength
				bne ItemsInQueue

				jsr CheckHowManyMatched

				jmp NextCell

			ItemsInQueue:

				ldx ZP.SlotID
				jmp CellLoop

			NextCell:

				lda #0
				sta MatchCount

				ldx ZP.SlotID

				CheckLoop:

				dex
				cpx ZP.EndID
				beq CompleteScan

				lda Checked, x
				bne CheckLoop

				jmp CellLoop


		CompleteScan:
		
			ldx CurrentSide

			lda NumberPopped
			beq NextBeans

			WaitForDrop:

				inc Combo, x		

				lda NumberPopped
				sec
				sbc #2
				bmi NoGarbage

				jsr ROCKS.CalculateChainRocks

				NoGarbage:

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

				// jsr StartCheck

				// lda #CheckTime
				// asl
				// asl
				// asl
				// sta CheckTimer, x

				lda MENU.SelectedOption
				cmp #PLAY_MODE_PRACTICE
				beq Finish

						jsr ROCKS.DecideWhereToSendFlare

				jmp Finish

			NextBeans:

				ldy CurrentSide

				lda GRID.GridClearAllowed, y
				beq NoCheck

				lda #1
				sta GridClear, y

				lda #0
				sta GridClearAllowed, y

				NoCheck:

					lda ROCKS.OnWayToUs, y
					bne Finish

				Transfer:


					jsr ROCKS.TransferCountToQueue

					ldx CurrentSide

					lda #0
					sta Combo, x
					sta Active, x

					jsr SCORING.ResetMultipliers
					jsr SCORING.DrawPlayer

				
		Finish:



		rts
	}


	CheckHowManyMatched: {


		lda MatchCount
		cmp #4
		bcc NoPop

		inc NumberPopped

		lda NumberPopped
		cmp #2
		bcs NoSfx

		sfx(SFX_BLOOP)


		NoSfx:

		CalculateGarbage:

			ldx CurrentSide
			lda MatchCount
			sec
			sbc #4
			bmi NoGarbage

			jsr ROCKS.CalculateBaseRocks

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
		sta MatchCount



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

		lda BeanCount, x
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

		jsr ClearCheck

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

			// advanced checking here for straights, pairs, flushes etc.!
		
		
			MatchToLeft:

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
		
		// advanced checking here for straights, pairs, flushes etc.!

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

		
		MatchToRight:

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

			lda #FORCE_REFRESH
			sta PreviousType, x

			jsr GRID_VISUALS.DrawBean

		PreventCheckFiring:

			ldx CurrentSide
			inc NumberMoving, x

		DeleteOldGridSpace:

			ldx ZP.CurrentSlot
			lda #EMPTY_CELL
			sta PlayerOne, x

			lda #FORCE_REFRESH
			sta PreviousType, x

			jsr GRID_VISUALS.ClearSquare

		Finish:
		

		rts

	}

	UpdateRow: {


		jsr GetStartAndEnd

		Loop:

			stx ZP.CurrentSlot
			
			CheckIfEmpty:

				lda #0
				sta ZP.SolidBelow

				lda PlayerOne, x
				sta ZP.CardID
				bpl CheckLeft

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
				cmp #POPPED
				bne NotPopped

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
					cmp #FORCE_REFRESH
					beq NotAnimating

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

						sfx(SFX_EXPLODE)
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