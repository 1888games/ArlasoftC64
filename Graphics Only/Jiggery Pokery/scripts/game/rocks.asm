ROCKS: {

	* = * "Rocks"

	.label FullCharID = 106
	.label SingleCharID = 105
	.label ComboTime = 50
	.label Stage1Time = 20
	.label Stage2Time = 40
	.label FrameTime = 6
	.label ComboStartPointer = 44
	.label ComboEndPointer  = 52
	.label BlobStartPointer = 16
	.label BlobEndPointer = 19
	.label Stage2Speed = 8
	.label Stage2Speed_Y = 6
	

	Count:			.byte 0, 0
	PendingCount:	.byte 0, 0
	PreviousCount:	.byte 0, 0
	FullCount:		.byte 0
	SingleCount:	.byte 0
	ColumnsDrawn:	.byte 0
	Mode:			.byte 0, 0
	FailsafeTimer:	.byte 0, 0

	* = * "Queue"

	Queue:		.byte 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0


	XPos_MSB:		.byte 0, 0
	XPos_LSB:		.byte 0, 0
	YPos:			.byte 0, 0
	Speed:			.byte 0, 0
	Frame:			.byte 0, 0
	Stage:			.byte 0, 0
	StageTimer:		.byte 0, 0
	FrameTimer:		.byte 0, 0
	FrameDirection:	.byte 1, 1
	LastColumn:		.byte 255, 255
	StageTimes:		.byte 20

	TargetXPos_MSB:	.byte 0, 0
	TargetXPos_LSB:	.byte 0, 0
	TargetYPos:		.byte 0, 0

	ComboTimer:		.byte 0, 0
	ComboFrame:		.byte 0, 0

	GridOffset:		.byte 0, 66

	DropTimeout:	.byte 0
	OnWayToUs:		.byte 0, 0


	ClearColumn:	.byte 6, 34

		
	SpriteLookup:	.byte 0, 2, 4, 6, 8, 10, 12, 14
	

	Order:					.byte 6, 7, 5, 8, 4, 9, 3, 10, 2, 11, 1, 0
	BackgroundCharOrder:	.byte 34, 35, 39, 38, 34, 35, 39, 38, 34, 35, 39, 38
	BackgroundColourOrder:	.byte PURPLE, YELLOW, CYAN, GREEN, PURPLE, YELLOW, CYAN, GREEN, PURPLE, YELLOW, CYAN, GREEN
	BackgroundCharIDs:		.byte 34, 35, 38, 39

	DropColumns:			.byte 0, 0, 0, 1, 1, 1, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5
	QueueOrder:				.byte 2, 3, 1, 4, 0, 5

	ColumnAdd:				.byte 2, 26
	QueueOffset:			.byte 0, 6
	Opponent:				.byte 1, 0
	Colours:				.byte RED, BLUE
	Colours2:				.byte LIGHT_RED, LIGHT_BLUE
	TargetColumns:			.byte 7, 32

	BaseLookup:				.byte 1, 2, 4, 5, 7, 10, 14, 19, 25  //4-12
	ChainLookup:			.byte 0, 3, 10, 27, 68, 90		// 1 - 6
	ComboLookup:			.byte 5, 14, 26, 41, 59 		// 1 - 6

	BaseScore:				.byte 5, 18, 28, 40, 54, 70, 88, 108, 130   //4-12

	RockLookupAdd:			.byte 0
	SecondsTimer:			.byte 0
	SecondsCounter:			.byte 0
	GameSeconds:			.byte 0
	FramesPerSecond:		.byte 50
	RampUpTime:				.byte 60


	Reset: {

		lda FramesPerSecond
		sta SecondsTimer
		sta LastColumn
		sta LastColumn + 1



		lda #0
		sta Count + 0
		sta Count + 1
		sta PreviousCount + 0
		sta PreviousCount + 1
		sta RockLookupAdd
		sta FullCount
		sta PendingCount
		sta PendingCount + 1
		sta GameSeconds
		sta SecondsCounter
		sta RockLookupAdd
		sta DropTimeout
		sta ComboTimer 
		sta ComboTimer + 1
		sta ComboFrame
		sta ComboFrame + 1
		sta Stage
		sta Stage + 1
		sta Mode
		sta Mode + 1
		sta OnWayToUs
		sta OnWayToUs + 1

		ldx #0

		Loop:

			sta Queue, x
			inx 
			cpx #12
			bcc Loop

		rts
	}



	DecideWhereToSendFlare: {

		SetupSprite:

			lda #BlobStartPointer
			sta SPRITE_POINTERS + 2, x
			sta Frame, x

			lda StageTimes
			sta StageTimer, x

			lda #FrameTime
			sta FrameTimer, x

			lda #1
			sta FrameDirection, x

			lda Colours, x
			sta VIC.SPRITE_COLOR_2, x

		CheckWhetherPlayerHasImminentRocks:

			lda Count, x
			beq HeadForOpponent

		HeadForOwn:

			ldy #0
			lda EXPLOSIONS.YPos, y
			sta TargetYPos, x

			lda TargetColumns, x
			tay
			lda EXPLOSIONS.XPosLSB, y
			sta TargetXPos_LSB, x

			lda EXPLOSIONS.XPosMSB, y
			sta TargetXPos_MSB, x

			lda #1
			sta OnWayToUs, x 

			jmp GetInitialPosition

		HeadForOpponent:

			ldy #0

			lda #0
			sta OnWayToUs, x 

			lda EXPLOSIONS.YPos, y
			sta TargetYPos, x

			lda Opponent, x
			tax

			lda TargetColumns, x
			tay

			lda Opponent, x
			tax

			lda EXPLOSIONS.XPosLSB, y
			sta TargetXPos_LSB, x

			lda EXPLOSIONS.XPosMSB, y
			sta TargetXPos_MSB, x

		GetInitialPosition:


			ldy ZP.Row
			iny
			lda EXPLOSIONS.YPos, y
			sta YPos, x

			ldy ZP.Column
			lda EXPLOSIONS.XPosLSB, y
			sta XPos_LSB, x

		CalcMSB:

			lda EXPLOSIONS.XPosMSB, y
			sta XPos_MSB, x



		rts
	}



	TransferCountToQueue: {

		ldy GRID.CurrentSide

		lda Count, y
		bne AreRocks

		NoRocks:

			lda #1
			sta PLAYER.Status, y

		//	jsr PANEL.KickOff


			lda #0
			sta Mode, y
			rts

		AreRocks:

		//.break


			lda #1
			sta Mode, y

			lda QueueOffset, y
			sta ZP.Offset
			tax

		Loop:

			lda Count, y
			beq Finish
			
			sec
			sbc #6
			bpl FullRow

			lda Count, y
			tay

			PartialLoop:

				sty ZP.Amount	

				ldy GRID.CurrentSide

				Random:

				jsr RANDOM.Get
				and #%00000111
				cmp #6
				bcs Random
				cmp LastColumn, y
				beq Random

				sta LastColumn, y

				clc
				adc ZP.Offset

				ldx GRID.CurrentSide
				dec Count, x

				tax
				inc Queue, x
				
				ldy ZP.Amount
				dey
				bne PartialLoop

				jmp Finish


			FullRow:

				sta Count, y

				ldx ZP.Offset

				inc Queue + 0, x
				inc Queue + 1, x
				inc Queue + 2, x
				inc Queue + 3, x
				inc Queue + 4, x
				inc Queue + 5, x

				jmp Loop


		Finish:

			ldx GRID.CurrentSide
			lda #0
			sta Count, x

		rts
	}


	
	Delete: {	

		ldx ZP.SlotID

		lda #0
		sta Frame, x

		txa
		asl
		tax

		lda #0
		sta VIC.SPRITE_2_Y, x

		rts

	}

	HeadForTop: {

		inc GRID.NumberMoving, x

		MoveX:

			lda TargetXPos_MSB, x
			cmp XPos_MSB, x
			beq CheckLSB

			bcc GoLeft
			jmp GoRight

		CheckLSB:

			lda TargetXPos_LSB, x
			cmp XPos_LSB, x
			bcc GoLeft
			beq MoveY


		GoRight:

			lda XPos_LSB, x
			clc
			adc #Stage2Speed
			sta XPos_LSB, x

			lda XPos_MSB, x
			adc #0
			sta XPos_MSB, x

			cmp TargetXPos_MSB, x
			bne MoveY

			lda XPos_LSB, x
			cmp TargetXPos_LSB, x
			bcc MoveY

			lda TargetXPos_LSB, x
			sta XPos_LSB, x

			lda YPos, x
			cmp TargetYPos, x
			beq Arrived

			jmp MoveY


		GoLeft:

			lda XPos_LSB, x
			sec
			sbc #Stage2Speed
			sta XPos_LSB, x

			lda XPos_MSB, x
			sbc #0
			sta XPos_MSB, x

			cmp TargetXPos_MSB, x
			bne MoveY

			lda TargetXPos_LSB, x
			cmp XPos_LSB, x
			bcc MoveY

			lda YPos, x
			cmp TargetYPos, x
			beq Arrived

			lda TargetXPos_LSB, x
			sta XPos_LSB, x


		MoveY:

			lda YPos, x
			cmp TargetYPos, x
			beq CheckArrived
			bcc SetTarget

			jmp MoveNow

			SetTarget:

				lda TargetYPos, x
				sta YPos, x

				jmp CheckArrived

			MoveNow:

				lda YPos, x
				sec
				sbc #Stage2Speed_Y
				sta YPos, x

			jmp NotArrived

		CheckArrived:

			lda TargetXPos_LSB, x
			cmp XPos_LSB, x
			bne NotArrived

			lda TargetXPos_MSB, x
			cmp XPos_MSB, x
			bne NotArrived

		Arrived:


			stx ZP.SlotID
			jsr FlareArrived


		NotArrived:



		rts
	}




	ClearFromOwnCount: {

		lda Opponent, x
		tay

	//	.break

		lda Count, x
		cmp PendingCount, y
		bcc ClearAll

		ClearPartial:

			lda Count, x
			sec
			sbc PendingCount, y
			sta Count, x

			lda #0
			sta PendingCount, y

			dec GRID.NumberMoving, x

			lda #0
			sta OnWayToUs, x 

			jsr Delete
			rts

		ClearAll:

			lda PendingCount, y
			sec
			sbc Count, x
			sta PendingCount, y

			lda #0
			sta Count, x

			lda PendingCount, y
			bne StillRocksLeft

			jsr Delete

			lda #0
			sta OnWayToUs, x 

			rts

			StillRocksLeft:

				lda Opponent, x
				tax

				lda TargetColumns, x
				tay

				lda Opponent, x
				tax

				lda EXPLOSIONS.XPosLSB, y
				sta TargetXPos_LSB, x

				lda EXPLOSIONS.XPosMSB, y
				sta TargetXPos_MSB, x
				rts




		rts
	}


	FlareArrived: {

		//.break

		ldx ZP.X
		beq Player1

		Player2:

			lda TargetXPos_MSB, x
			bne ClearOwn
		
			jmp AddToOpponent

		Player1:

			lda TargetXPos_MSB, x
			beq ClearOwn
		

			jmp AddToOpponent


		ClearOwn:

			jmp ClearFromOwnCount


		AddToOpponent:

			jsr Delete

			ldx ZP.X

			lda Opponent, x
			tay

			lda Count, y
			clc
			adc PendingCount, y
			sta Count, y

			lda #0
			sta PendingCount, y

			dec GRID.NumberMoving, x



		rts
	}


	GridCleared: {

	//	.break

		// x = player

		lda #15
		sta ZP.Row

		lda ClearColumn, x
		sta ZP.Column

		lda Opponent, x
		tay

		lda PendingCount, y
		clc
		adc #30
		sta PendingCount, y

		lda #67
		sta ComboFrame, x

		jsr StartCombo
		jsr ROCKS.DecideWhereToSendFlare

		ldx #0
		sfxFromX()

		ldx GRID.CurrentSide


		rts
	}

	UpdateSprite: {


		UpdateFrame:

			lda FrameTimer, x
			beq ReadyToChange

			dec FrameTimer, x
			jmp Position

			ReadyToChange:

				lda #FrameTime
				sta FrameTimer, x

				lda Frame, x
				clc
				adc FrameDirection, x
				sta Frame, x
				cmp #BlobEndPointer
				beq SwitchTo255

				cmp #BlobStartPointer
				beq SwitchToOne

				jmp Position

				SwitchTo255:

				lda #255
				sta FrameDirection, x
				jmp Position

				SwitchToOne:

				lda #1
				sta FrameDirection, x



		Position:

		lda Frame, x
		sta SPRITE_POINTERS + 2, x

		txa
		asl
		tay

		lda XPos_LSB, x
		sta VIC.SPRITE_2_X, y

		lda YPos, x
		sta VIC.SPRITE_2_Y, y



		lda XPos_MSB, x
		beq NoMSB

		MSB:


			inx
			inx

			lda VIC.SPRITE_MSB
			ora DRAW.MSB_On, x
			sta VIC.SPRITE_MSB
			jmp Finish

		NoMSB:

			inx
			inx

			lda VIC.SPRITE_MSB
			and DRAW.MSB_Off, x
			sta VIC.SPRITE_MSB



		Finish:


		dex
		dex



		rts
	}


	UpdateOrb: {


		ldx #0

		Loop:

			stx ZP.X

			lda Frame, x
			beq EndLoop

			jsr UpdateSprite

			lda Frame, x
			beq EndLoop

			lda Stage, x
			beq StageOne

			jsr HeadForTop
			jmp EndLoop

			StageOne:

				lda StageTimer, x
				beq Finished

				dec StageTimer, x

				ldy ZP.X
				lda StageTimer,y
				lsr
				lsr
				lsr
				sta ZP.Amount
				inc ZP.Amount
					
				lda YPos, x
				sec
				sbc ZP.Amount
				sta YPos, x

				cpy #0
				beq Left

				Right:

					lda XPos_LSB, x
					clc
					adc #1
					sta XPos_LSB, x

					lda XPos_MSB
					adc #0
					sta XPos_MSB

					jmp EndLoop

				Left:

					lda XPos_LSB, x
					sec
					sbc #1
					sta XPos_LSB, x

					lda XPos_MSB, x
					sbc #0
					sta XPos_MSB, x


				jmp EndLoop

			Finished:

				lda #1
				sta Stage, x

			EndLoop:	

				ldx ZP.X

				inx
				cpx #2
				bcc Loop



		rts
	}

	UpdateCombo: {

		ldx #0

		Loop:

			stx ZP.X

			lda ComboFrame, x
			beq EndLoop

			lda ComboTimer, x
			beq Finished

			and #%00000011
			beq Dark

			Light:

				lda Colours2, x
				sta VIC.SPRITE_COLOR_0, x
				jmp Done

			Dark:

				lda Colours, x
				sta VIC.SPRITE_COLOR_0, x

			Done:

			
				lda ComboTimer, x
				lsr
				lsr
				lsr
				lsr
				lsr
				sta ZP.Amount
				inc ZP.Amount

				dec ComboTimer, x

				txa
				asl
				tax

				lda VIC.SPRITE_0_Y, x
				sec
				sbc ZP.Amount
				sta VIC.SPRITE_0_Y, x

				jmp EndLoop

			Finished:

				lda #0
				sta ComboFrame, x

				txa
				asl
				tax

				lda #0
				sta VIC.SPRITE_0_Y, x

			EndLoop:	

				ldx ZP.X

				inx
				cpx #2
				bcc Loop




		rts
	}




	StartCombo: {


		lda ComboFrame, x
		sta SPRITE_POINTERS, x

		lda #ComboTime
		sta ComboTimer, x

		lda Colours, x
		sta VIC.SPRITE_COLOR_0, x

		txa
		asl
		tax

		ldy ZP.Row
		dey
		lda EXPLOSIONS.YPos, y
		sta VIC.SPRITE_0_Y, x

		ldy ZP.Column
		lda EXPLOSIONS.XPosLSB, y
		sta VIC.SPRITE_0_X, x

		ldx GRID.CurrentSide

		lda EXPLOSIONS.XPosMSB, y
		beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora DRAW.MSB_On, x
			sta VIC.SPRITE_MSB
			jmp Finish

		NoMSB:

			lda VIC.SPRITE_MSB
			and DRAW.MSB_Off, x
			sta VIC.SPRITE_MSB

		Finish:



		rts
	}





	CalculateBaseRocks: {


		cmp #9
		bcc Okay

		lda #8

		Okay:

		jsr SCORING.BeansCleared

	    tay

	    lda Opponent, x
		tax	

		lda PendingCount, x
		clc
		adc BaseLookup, y
		sta PendingCount, x

		lda Opponent, x
		tax


		rts
	}


	CalculateChainRocks: {

		cmp #6
		bcc Okay

		lda #5	

		Okay:

		tay

		lda Opponent, x
		tax	


		lda PendingCount, x
		clc
		adc ChainLookup, y
		clc
		adc RockLookupAdd
		sta PendingCount, x

		lda Opponent, x
		tax	

		rts
	}

	CalculateComboRocks: {

		pha

		CalculatePointer:

			clc
			adc #ComboStartPointer
			cmp #ComboEndPointer

		CheckInRange:

			bcs PointerOutOfRange
			jmp PointerInRange

		PointerOutOfRange:

			lda #ComboEndPointer

		PointerInRange:

			sta ComboFrame, x

		CalculateTableLookup:

			pla
			
			cmp #6
			bcc Okay

			lda #5	

			Okay:

			tay

		GetGarbage:

			lda Opponent, x
			tax	

			lda PendingCount, x
			clc
			adc ComboLookup, y
			clc
			adc RockLookupAdd
			sta PendingCount, x

			lda Opponent, x
			tax

		jsr StartCombo

		Finish:


		rts
	}


	UpdateTime: {

		lda SecondsTimer
		beq Ready

		dec SecondsTimer
		jmp Finish

		Ready:

		lda FramesPerSecond
		sta SecondsTimer

		inc SecondsCounter
		inc GameSeconds

		lda SecondsCounter
		cmp RampUpTime
		bcc Finish

		lda #0
		sta SecondsCounter

		inc RockLookupAdd

		lda MENU.SelectedOption
		cmp #PLAY_MODE_PRACTICE
		bne Finish

		lda PLAYER.CurrentAutoDropTime
		cmp #5
		bcc Finish

		dec PLAYER.CurrentAutoDropTime
		dec PLAYER.CurrentAutoDropTime

		Finish:


		rts
	}

	FrameUpdate: {

		jsr UpdateTime
		jsr UpdateCombo
		jsr UpdateOrb

		ldx #0

		Loop:	

			stx ZP.Player

			lda FailsafeTimer, x
			beq Okay




			Okay:

			lda Mode, x
			beq NoDrop

			Drop:	

				cmp #2
				beq EndLoop

				ldy ZP.Player
				jsr TryQueue
				ldx ZP.Player

			NoDrop:

				lda Count, x
				cmp PreviousCount, x
				beq EndLoop

				jsr Draw

				ldx ZP.Player

				lda Count, x
				sta PreviousCount, x

			EndLoop:

				inx	
				cpx #2
				bcc Loop


		rts
	}


	TryQueue: {

		lda DropTimeout
		beq Okay2

		dec DropTimeout
		lda DropTimeout
		bne Okay2

		sty ZP.Player
		jsr PLAYER.LostRound
		rts

		Okay2:

		lda #0
		sta ZP.Okay

		ldy ZP.Player
		lda QueueOffset, y
		tax
		clc
		adc #6
		sta ZP.EndID


		Loop:

			stx ZP.Column

			ldy ZP.Player

			lda Queue, x
			beq EndLoop

			txa
			clc
			adc GridOffset, y
			tay

			lda GRID.PlayerOne, y
			beq Okay

			inc ZP.Okay
			jmp EndLoop

			Okay:

			dec Queue,x

			lda #WHITE
			sta GRID.PlayerOne, y

			lda #255
			sta GRID.PreviousType, y
		
			lda ZP.Okay
			clc
			adc Queue, x
			sta ZP.Okay

			EndLoop:

				ldx ZP.Column

				inx
				cpx ZP.EndID
				bcc Loop


		Finish:

			lda ZP.Okay
			beq Done

			lda DropTimeout
			bne NotDone

			lda #150
			sta DropTimeout

			jmp NotDone

		Done:

			lda #0
			sta DropTimeout

			//.break
			ldy ZP.Player
			lda #0
			sta Mode, y

			lda PLAYER.Status, y
			cmp #PLAYER.PLAYER_STATUS_END
			beq NotDone

			
			jsr PANEL.KickOff
		

		NotDone:

			ldy ZP.Player
			lda #GRID_MODE_NORMAL
			sta GRID.Mode, y

			lda #1
			sta GRID.Active, y



		rts
	}




	DropRocks: {

		stx ZP.TempX

		lda Count, x
		tay

		Loop:

			sty ZP.TempY

			GetRandom:

			jsr RANDOM.Get
			and #%00000111
			cmp #6
			bcs GetRandom
			clc
			adc GRID.PlayerLookup, x
			tay

			lda GRID.PlayerOne, y
			bne Loop


		rts
	}




	Draw: {	

		stx ZP.X

		lda #0
		sta FullCount
		sta ColumnsDrawn

		lda #1
		sta ZP.Colour


		lda Count, x
		sta SingleCount


		DoWhile:

			lda SingleCount
			sec
			sbc #12
			bmi EndWhile

			inc FullCount
			sta SingleCount
			jmp DoWhile


		EndWhile:


		DrawLoop:

			lda ColumnsDrawn
			cmp #12
			beq Finish

			lda FullCount
			beq FullDone

			Full:

				lda #FullCharID
				dec FullCount
				jmp DoIt

			FullDone:

				lda SingleCount
				beq SingleDone

			Single:

				lda #SingleCharID
				dec SingleCount
				jmp DoIt

			SingleDone:

				ldy ColumnsDrawn

				lda BackgroundColourOrder, y
				clc
				adc #8
				sta ZP.Colour
				lda BackgroundCharOrder, y

			DoIt:

				pha

				ldx ColumnsDrawn
				lda Order, x
				ldx ZP.X
				clc
				adc ColumnAdd, x
				tax

				pla

				ldy #0

				jsr DRAW.PlotCharacter

				lda ZP.Colour

				jsr DRAW.ColorCharacter

				inc ColumnsDrawn
				jmp DrawLoop



		Finish:


		rts
	}


}