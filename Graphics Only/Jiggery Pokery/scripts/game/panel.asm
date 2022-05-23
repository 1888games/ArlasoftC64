PANEL: {

	* = * "Panel"

	MaxColours:	.byte 5, 5
	Colours:	.byte RED, GREEN, BLUE, YELLOW, PURPLE, CYAN


	.label WAITING = 0
	.label MOVING = 1

	.label MinRow = 3
	.label FrameTime = 4


	Queue:		.byte 99, 99, 99, 99
	PlayerTwo:	.byte 99, 99, 99, 99

	QueueColumns:	.byte 17, 20, 17, 20, 17, 20, 17,20
	QueueRows:		.byte 3, 3, 6, 6, 18, 18, 21, 21

	TargetColumn:	.byte 17, 20, 17, 20, 17, 20, 17, 20
	TargetRow:		.byte 0, 0, 3, 3, 15, 15, 18, 18

	CurrentColumn:	.byte 0, 0, 0, 0, 0, 0, 0, 0
	CurrentRow:		.byte 0, 0, 0, 0, 0, 0, 0, 0

	ReachedTargetColumn:	.byte 1, 1, 0, 0, 0, 0, 0, 0
	ReachedTargetRow:		.byte 0, 0, 0, 0, 0, 0, 0, 0

	* = * "Queue Data"

	MasterQueueIterations:	.byte 0
	MasterQueuePosition:	.byte 0
	QueuePosition:			.byte 0, 0
	QueueIterations:		.byte 0, 0
	FirstKickOff:			.byte 0, 0

	QueueValues:			.fill 32, 0


	Mode:		.byte 0, 0
	FrameTimer:	.byte 0, 0
	Offsets:	.byte 0, 4



	Reset: {

		
		lda #0
		sta QueuePosition
		sta QueuePosition + 1
		sta QueueIterations
		sta QueueIterations + 1
		sta MasterQueueIterations
		sta MasterQueuePosition
		sta FrameTimer
		sta FrameTimer + 1
		sta FirstKickOff
		sta FirstKickOff + 1

		jsr DECK.Shuffle
		jsr FillQueue
		jsr StartMove
		jsr DrawInitialCards

		lda #0
		sta Mode
		sta Mode + 1

		ldy #0
		jsr KickOff

		ldy #1
		jsr KickOff

		rts	

	}


	DrawInitialCards: {

		ldx #0
		lda #8
		sta ZP.Amount

		lda MENU.SelectedOption
		cmp #PLAY_MODE_PRACTICE
		bne Loop

		lda #4
		sta ZP.Amount

		Loop:

			stx ZP.X

			jsr DrawCard

			ldx ZP.X

			inx
			cpx ZP.Amount
			bcc Loop


		rts

	}


	FrameUpdate: {

		ldx #0

		Loop:

			stx ZP.Player

			lda Mode, x
			beq EndLoop

			jsr MoveCards


			ldx ZP.Player

			EndLoop:

			jsr RANDOM.Get
			cmp #1
			bcs NoForce

			lda #1
			//sta Mode, x

			NoForce:

			inx
			cpx #2
			bcc Loop

	
		rts

	}


	KickOff: {

		lda #1
		sta Mode, y

		cpy #0
		beq NotCPU

		lda PLAYER.CPU, y
		beq NotCPU

		jsr OPPONENTS.SetActive

		NotCPU:

			
		Finish:

		lda #1
		sta FirstKickOff, y
		sta GRID.GridClearAllowed, y



		rts
	}

	MoveCards: {

		stx ZP.Player

		lda #0
		sta ZP.AtTarget

		lda FrameTimer, x
		beq Ready

		dec FrameTimer, x
		jmp Finish


		Ready:

			lda #FrameTime
			sta FrameTimer, x

			lda Offsets, x
			sta ZP.StartID
			tax
			clc
			adc #4
			sta ZP.EndID

		Loop:

			stx ZP.BeanID

			jsr DeleteCard

			ldx ZP.BeanID

			lda TargetRow, x
			cmp CurrentRow, x
			beq AlreadyAtY

		MoveY:
			
			dec CurrentRow, x
			inc ZP.AtTarget
			jmp EndLoop

		AlreadyAtY:

			lda TargetColumn, x
			sec
			sbc CurrentColumn, x
			beq EndLoop

			bcc ReduceX

			IncreaseX:

				inc CurrentColumn, x
				jmp Skip

			ReduceX:	

				dec CurrentColumn, x

			Skip:

				inc ZP.AtTarget

			EndLoop:
				
				jsr DrawCard

				ldx ZP.BeanID
				inx
				cpx ZP.EndID
				bcc Loop	

		lda ZP.AtTarget
		bne Finish

		ldy ZP.Player

		jsr PLAYER.SetupCards

		ldx ZP.Player
		stx ZP.X

		jsr PullFromQueue	
		jsr PullFromQueue

		ldx ZP.StartID

		Loop2:

			lda QueueColumns, x
			sta CurrentColumn, x

			lda QueueRows, x
			sta CurrentRow, x

			inx
			cpx ZP.EndID
			bcc Loop2

		ldx ZP.StartID
		inx
		inx
		stx ZP.X

		jsr DrawCard

		ldx ZP.X
		inx

		jsr DrawCard

		ldx ZP.Player

		lda #0
		sta Mode, x




		Finish:

		rts
	}


	StartMove: {

		lda #1
		sta ReachedTargetColumn
		sta ReachedTargetColumn + 1
		sta ReachedTargetColumn + 4
		sta ReachedTargetColumn + 5

		lda #0
		sta ReachedTargetColumn + 2
		sta ReachedTargetColumn + 3
		sta ReachedTargetColumn + 6
		sta ReachedTargetColumn + 7


		ldx #0

		Loop:

			lda QueueColumns, x
			sta CurrentColumn, x

			lda QueueRows, x
			sta CurrentRow, x

			inx
			cpx #8
			bcc Loop



		rts
	}


	DrawCharacter: {


		cpy #3
		bcc NoDraw

		cpx #17
		bcc NoDraw

		cpy #7
		bcc Okay

		cpy #18
		bcc NoDraw

		cpy #22
		bcs NoDraw

		Okay:

		jsr DRAW.PlotCharacter

		lda ZP.BeanColour
		jsr DRAW.ColorCharacter

		lda ZP.CharID


		NoDraw:

		rts
	}

	DeleteCard: {

		lda CurrentRow, x
		sta ZP.Row

		lda CurrentColumn, x
		sta ZP.Column

		lda #0
		sta ZP.CharID

		TopLeft:
		
			ldx ZP.Column
			ldy ZP.Row
			jsr DrawCharacter
				
		TopCentre:

			inx	
			jsr DrawCharacter

		TopRight:

			inx	
			jsr DrawCharacter

		MiddleRight:

			iny
			jsr DrawCharacter

		MiddleCentre:

			dex	
			jsr DrawCharacter
	

		MiddleLeft:

			dex	
			jsr DrawCharacter


		BottomLeft:

			iny
			jsr DrawCharacter

		BottomCentre:

			inx
			jsr DrawCharacter
	

		Bottomight:

			inx
			jsr DrawCharacter


		Finish:





		rts
	}

	DrawCard: {

		lda CurrentRow, x
		sta ZP.Row

		lda CurrentColumn, x
		sta ZP.Column
		sta ZP.TempX

		lda #8
		sta ZP.BeanColour

		lda Queue, x
		tay

		TopLeft:

			sty ZP.Y

			lda DRAW.TopLeft, y
			clc
			adc #DRAW.AmountToAdd
		
			ldx ZP.Column
			ldy ZP.Row
			jsr DrawCharacter
				
		TopCentre:

			ldy ZP.Y
			lda DRAW.TopCentre, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr DrawCharacter

		TopRight:

			ldy ZP.Y
			lda DRAW.TopRight, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr DrawCharacter

			iny
			sty ZP.Row
			ldx ZP.TempX

		MiddleLeft:

			ldy ZP.Y
			lda DRAW.MiddleLeft, y
			clc
			adc #DRAW.AmountToAdd
		
			ldy ZP.Row
			jsr DrawCharacter
				
		Middle:

			ldy ZP.Y
			lda DRAW.Middle, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr DrawCharacter

		MiddleRight:

			ldy ZP.Y
			lda DRAW.MiddleRight, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr DrawCharacter

			iny
			sty ZP.Row
			ldx ZP.TempX
			
		BottomLeft:

			ldy ZP.Y
			lda DRAW.BottomLeft, y
			clc
			adc #DRAW.AmountToAdd
		
			ldy ZP.Row
			jsr DrawCharacter
				
		BottomCentre:

			ldy ZP.Y
			lda DRAW.BottomCentre, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr DrawCharacter

		Bottomight:

			ldy ZP.Y
			lda DRAW.BottomRight, y
			clc
			adc #DRAW.AmountToAdd

			ldy ZP.Row
			inx	
			jsr DrawCharacter



		Finish:


		rts
	}




	FillQueue: {

		ldx #0

		Loop:

			stx ZP.X

			jsr PullFromQueue
			jsr PullFromQueue
			jsr PullFromQueue
			jsr PullFromQueue

			ldx ZP.X

			inx
			cpx #2
			bcc Loop

		rts
	}



	AddToQueue: {

		jsr DECK.GetNextCard

		ldy MasterQueuePosition
		sta QueueValues, y


		rts
	}

	PullFromQueue: {

		ldx ZP.X

		CheckIfOwnQueueWrap:

			inc QueuePosition, x
			lda QueuePosition, x
			cmp #32
			bcc CheckIfAheadOfMaster

		WrapOwnQueue:

			lda #0
			sta QueuePosition, x
			inc QueueIterations, x

		CheckIfAheadOfMaster:
		
			lda QueueIterations, x
			cmp MasterQueueIterations
			bcc NoMasterWrap
			beq NoMasterWrap

			inc MasterQueueIterations
			lda #0
			sta MasterQueuePosition

			jsr AddToQueue
			jmp Done


		NoMasterWrap:

			lda QueuePosition, x
			cmp MasterQueuePosition
			bcc Done
			beq Done
			
			inc MasterQueuePosition
			jsr AddToQueue
			
			ldx ZP.X

		Done:

			lda QueuePosition, x
			tay
			
			cpx #0
			beq Player1

			Player2:

				lda Queue + 5
				sta Queue + 4

				lda Queue + 6
				sta Queue + 5

				lda Queue + 7
				sta Queue + 6

				lda QueueValues, y
				sta Queue + 7
				jmp Finish

			Player1:

				lda Queue + 1
				sta Queue

				lda Queue + 2
				sta Queue + 1

				lda Queue + 3
				sta Queue + 2

				lda QueueValues, y
				sta Queue + 3

		Finish:


			rts




	}




}