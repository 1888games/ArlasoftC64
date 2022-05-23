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

	Queue:		.byte 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0


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

	DropTimeout:	.byte 0, 0
	OnWayToUs:		.byte 0, 0
	Failsafe:		.byte 0, 0

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
	Colours:				.byte YELLOW, YELLOW
	Colours2:				.byte LIGHT_RED, LIGHT_BLUE
	TargetColumns:			.byte 7, 32

	BaseLookup:				.byte 1, 2, 4, 5, 7, 10, 14, 19, 25  //4-12
	ChainLookup:			.byte 2, 6, 11, 17, 24		// 1 - 6
//	ComboLookup:			.byte 5, 14, 26, 41, 59 		// 1 - 6
	ComboLookup:			.byte 5, 9, 12, 15, 18

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





		
	TransferCountToQueue: {

		ldy GRID.CurrentSide

		lda Count, y
		bne AreRocks

		NoRocks:

			lda #1
			sta PLAYER.Status, y

			jsr PANEL.KickOff


			lda #0
			sta Mode, y
			rts

		AreRocks:

		rts
	}

	GridCleared: {

	//	.break

		// x = player

		//.break

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
		//jsr DecideWhereToSendFlare
	
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

				lda Colours, x
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





	AddLayers: {

		
		lda PLAYER.LayersToAdd, y
		beq Finish

		tya
		pha

		lda GRID.PlayerLookup, y
		tax
		stx ZP.Temp2

		lda GRID.BottomRightIDs, y
		clc
		adc #1
		sta ZP.EndID
		sec
		sbc #6
		sta ZP.Amount

		lda PLAYER.LayersToAdd, y
		tax

		ChainLoop:

			ldy ZP.Temp2
			
		Loop:

			cpy ZP.Amount
			bcc Copy

			lda #1
			sta GRID.PlayerOne + 0, y

			jmp EndLoop


		Copy:

			lda GRID.PlayerOne + 6, y
			sta GRID.PlayerOne + 0, y

			EndLoop:

			iny
			cpy ZP.EndID
			bcc Loop

			dex
			bne ChainLoop



		pla
		tay

		lda #0
		sta PLAYER.LayersToAdd, y

		Finish:



		rts
	}


	CalculateComboRocks: {

		pha
		
		txa
		eor #%00000001
		tax

		pla
		sta PLAYER.LayersToAdd, x
		inc PLAYER.LayersToAdd, x

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

			ldx GRID.CurrentSide
			sta ComboFrame, x

			
			

		jsr StartCombo


		rts

	}

	

	UpdateTime: {

		lda SecondsTimer
		beq Ready

		dec SecondsTimer
		jmp Finish

		Ready:

		jsr SCORING.CheckTimer

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
		
		Finish:


		rts
	}

	FrameUpdate: {

		jsr UpdateTime
		jsr UpdateCombo
		//jsr UpdateOrb

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

		//.break
	//	lda #3
	//	sta SCREEN_RAM + 520
	//	sta COLOR_RAM + 520

		sty ZP.Player
		jsr PLAYER.LostRound
		rts

		Okay2:

		lda #0
		sta ZP.Okay
		sta ZP.Blocked

		ldy ZP.Player
		lda QueueOffset, y
		sta ZP.StartID
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

			CheckIfColumnBlocked:

				lda GRID.PlayerOne, y
				beq Okay

			ColumnBlocked:

				cpx #2
				beq MainColumnBlocked

				cpx #8
				beq MainColumnBlocked

				txa
				tay

			MoveAlong:

				iny
				cpy #2
				beq MoveAlong

				cpy #8
				beq MoveAlong

				cpy ZP.EndID
				bne CanMove

				ldy ZP.StartID

			CanMove:

				dec Queue, x

				lda Queue, y
				clc
				adc #1
				sta Queue, y

			MainColumnBlocked:

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

			ldx ZP.Player
			inc GRID.RunningCount, x

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

			lda #90
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

				lda Order, y
				tay

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