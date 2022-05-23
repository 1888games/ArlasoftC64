PANEL: {

	* = * "Panel"

	MaxColours:	.byte 5, 5
	Colours:		.byte RED, YELLOW, CYAN, GREEN, PURPLE, BLUE
	ColourToChar:	.byte 39, 64, 0, 4, 8, 12, 16, 20


	.label WAITING = 0
	.label MOVING = 1

	.label MinRow = 3
	.label FrameTime = 2


	Queue:		.byte 99, 99, 99
	PlayerTwo:	.byte 99, 99, 99

	QueueColumns:	.byte 16, 16, 16, 22, 22, 22
	QueueRows:		.byte 2, 4, 6, 3, 5, 7

	TargetColumn: 	.byte 16, 16, 16, 22, 22, 22
	TargetRow:		.byte 2, 4, 6, 3, 5, 7

	CurrentColumn:	.byte 0, 0, 0, 0, 0, 0
	CurrentRow:		.byte 0, 0, 0, 0, 0, 0


	ReachedTargetColumn:	.byte 1, 1, 1, 1, 1, 1
	ReachedTargetRow:		.byte 0, 0, 0, 0, 0, 0

	* = * "Queue Data"

	MasterQueueIterations:	.byte 0
	MasterQueuePosition:	.byte 0
	QueuePosition:			.byte 0, 0
	QueueIterations:		.byte 0, 0
	FirstKickOff:			.byte 0, 0

	QueueValues:			.fill 32, 0


	Mode:		.byte 0, 0
	FrameTimer:	.byte 0, 0
	Offsets:	.byte 0, 3

	FirstFourMatch:	.byte 0
	LastBean:		.byte 0

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

		lda #1
		sta FirstFourMatch

		lda #255
		sta LastBean

		jsr FillQueue
		jsr StartMove
		jsr DrawInitialBeans

		lda #0
		sta Mode
		sta Mode + 1

		rts	

	}


	DrawInitialBeans: {

		ldx #0
		lda #6
		sta ZP.Amount

		lda MENU.SelectedOption
		cmp #PLAY_MODE_2P
		beq Loop

		lda #3
		sta ZP.Amount

		Loop:

			stx ZP.X

			jsr DrawBean

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

			jsr MoveBeans


			ldx ZP.Player

			EndLoop:

			//jsr RANDOM.Get
			//cmp #1
			//bcs NoForce

			//lda #1
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

		jsr ROCKS.AddLayers

		rts
	}

	MoveBeans: {

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
			adc #3
			sta ZP.EndID

		Loop:

			stx ZP.BeanID

			jsr DeleteBean

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
				
				jsr DrawBean

				ldx ZP.BeanID
				inx
				cpx ZP.EndID
				bcc Loop	

		lda ZP.AtTarget
		bne Finish

		ldy ZP.Player

		jsr PLAYER.SetupBeans

		ldx ZP.Player
		stx ZP.X

		jsr PullFromQueue	
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
		stx ZP.X

		jsr DrawBean

		ldx ZP.X
		inx

		jsr DrawBean

		ldx ZP.X
		inx
		inx

		jsr DrawBean

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
		sta ReachedTargetColumn + 2
		sta ReachedTargetColumn + 3
		sta ReachedTargetColumn + 4
		sta ReachedTargetColumn + 5

		ldx #0

		Loop:

			lda QueueColumns, x
			sta CurrentColumn, x

			lda QueueRows, x
			sta CurrentRow, x

			inx
			cpx #6
			bcc Loop



		rts
	}


	DrawCharacter: {

		lda ZP.CharID


		jsr DRAW.PlotCharacter

		lda ZP.BeanColour
		jsr DRAW.ColorCharacter


		NoDraw:

		rts
	}

	DeleteBean: {

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
				
		TopRight:

			inx	
			jsr DrawCharacter

		BottomRight:

			iny
			jsr DrawCharacter
	

		BottomLeft:

			dex	
			jsr DrawCharacter


		Finish:





		rts
	}

	DrawBean: {

		lda CurrentRow, x
		sta ZP.Row

		lda CurrentColumn, x
		sta ZP.Column

		lda Queue, x
		sta ZP.Colour
		jsr PLAYER.ConvertColour
		clc
		adc #8
		sta ZP.BeanColour

		ldy ZP.Player
		lda PLAYER.MagicGems, y
		cmp #2
		bne NotMagic

		Magic:

			// lda PLAYER.MagicColours, y
			// sta ZP.Colour
			// jsr PLAYER.ConvertColour
			// clc
			// adc #8
			// sta ZP.BeanColour

		Char:

			lda #189
			sta ZP.CharID

			jmp TopLeft

		NotMagic:

			lda Queue, x
			sta ZP.Colour
			jsr PLAYER.ConvertColour
			clc
			adc #8
			sta ZP.BeanColour

			lda BEAN.Chars
			clc
			adc #3
			sta ZP.CharID

			ldx ZP.Colour
			lda PANEL.ColourToChar, x
			clc
			adc ZP.CharID
			sta ZP.CharID

			lda SETTINGS.ColourSwitch
			beq TopLeft

			lda ZP.BeanColour
			cmp #8
			bne TopLeft

			lda #176
			sta ZP.CharID

		TopLeft:
		
			ldx ZP.Column
			ldy ZP.Row
			jsr DrawCharacter
				
		TopRight:

			inx
			dec ZP.CharID		
			jsr DrawCharacter

		BottomRight:

			iny
			dec ZP.CharID
			jsr DrawCharacter
	

		BottomLeft:

			dex
			dec ZP.CharID		
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


			ldx ZP.X

			inx
			cpx #2
			bcc Loop



		rts
	}



	AddToQueue: {

		jsr RANDOM.Get

		ldx ZP.X

		and #%00000111
		cmp MaxColours, x
		bcs AddToQueue

		tay
		lda Colours, y


		ldy MasterQueuePosition
		sta QueueValues, y

		lda LastBean
		bmi Finish

		lda QueueValues, y
		cmp LastBean
		beq Finish

		lda #0
		sta FirstFourMatch
	
		Finish:

		lda QueueValues, y
		sta LastBean


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

		Done:

			lda QueuePosition, x
			tay
			
			cpx #0
			beq Player1

			Player2:

				lda Queue + 4
				sta Queue + 3

				lda Queue + 5
				sta Queue + 4

				lda QueueValues, y
				sta Queue + 5
				jmp Finish

			Player1:

				lda Queue + 1
				sta Queue

				lda Queue + 2
				sta Queue + 1

				lda QueueValues, y
				sta Queue + 2

		Finish:


			rts




	}




}