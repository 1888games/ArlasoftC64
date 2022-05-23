PLAYER: {

	* = * "Player"

	.label AutoDropTime = 18
	.label FlashTime = 10
	.label ControlCooldown = 6
	.label FailsafeTime = 60

	.label PLAYER_STATUS_NORMAL = 0
	.label PLAYER_STATUS_WAIT = 1
	.label PLAYER_STATUS_PLACED = 2
	.label PLAYER_STATUS_END = 3
	.label InitialAICooldownTime = 40

	.label DoubleClickTime = 16


	Beans: 			.byte 0, 0, 0, 0
	GridPosition:	.byte 1, 1, 41, 41
	Offset:			.byte 255, 255, 255, 255

	
	Status:				.byte 1, 1
	DropTimer:			.byte AutoDropTime, AutoDropTime
	FlashTimer:			.byte 0, 0
	Flashing:			.byte 0, 0
	Rotation:			.byte 0, 0, 0, 0
	ClearUp:			.byte 1, 0, 1, 0
	AddForX:			.byte 1, 255, 255, 1
	AddForY:			.byte 5, 5,	 251, 251
	CPU:				.byte 0, 0

	FailsafeTimer:		.byte 255, 255
	

	CharIDs:			.byte 129, 197
	StartGridPositions:	.byte 2, 1, 42, 41
	StartOffsets:		.byte 254, 254, 254, 254

	BackgroundColours: 	.byte 0, 0, 0, 0
	BackgroundCharIDs: 	.byte 0, 0, 0, 0

	CurrentAutoDropTime:	.byte AutoDropTime, AutoDropTime

	TableOffset:		.byte 0, 2
	FlashBeans:			.byte 1, 3

	ControlPorts:		.byte 1, 0
	ControlTimer:		.byte 0, 0

	DoubleClickTimer:	.byte 0, 0
	RoundOver:			.byte 0
	InitialAICooldown:	.byte 30


	TargetRotation:		.byte 0
	TargetMove:			.byte 0
	CurrentMove:		.byte 0, 0
	CurrentRotation:	.byte 0, 0

	CPUDanger: .byte 0


	Reset: {


		lda #1
		sta Status
		sta Status + 1

		lda #0
		sta RoundOver
		sta Beans 
		sta Beans + 1
		sta Beans + 2
		sta Beans + 3

		sta ControlTimer
		sta ControlTimer + 1
		sta DoubleClickTimer
		sta DoubleClickTimer + 1
		sta FlashTimer
		sta FlashTimer + 1
		sta Flashing
		sta Flashing + 1
		sta Rotation + 1
		sta Rotation + 3

		lda #1
		sta Rotation
		sta Rotation + 2
		sta CurrentRotation + 1
		sta CurrentRotation

		lda StartGridPositions
		sta GridPosition
		sta GridPosition + 1

		lda StartGridPositions + 1
		sta GridPosition + 2
		sta GridPosition + 3



		rts
	}	


	FrameUpdate: {

		ldx #0

		Loop:

			stx ZP.Player

				lda DoubleClickTimer, x
				beq CheckActive

				dec DoubleClickTimer, x

			CheckActive:



				lda Status, x
				cmp #PLAYER_STATUS_NORMAL
				bne EndLoop

				lda FailsafeTimer, x
				bmi NotPlaced
				beq ForceCheck

				dec FailsafeTimer, x
				
				ForceCheck:

					//.break
					//nop

				NotPlaced:

				lda #1
				sta GRID.NumberMoving, x

				lda Status, x
				cmp #PLAYER_STATUS_NORMAL
				bne EndLoop

			Moving:

				lda #1
				sta GRID.NumberMoving, x
				
				jsr HandleControls

				ldx ZP.Player

			CheckDrop:

				lda DropTimer, x
				beq ReadyToDrop

			NoDrop:

				dec DropTimer, x
				jmp CheckFlash

			ReadyToDrop:	

				lda CurrentAutoDropTime, x
				sta DropTimer, x

				jsr DeleteCards

				ldx ZP.Player

				jsr DropBeans

				lda Status, x
				bne EndLoop

				

			 CheckFlash:

				
			// 	lda FlashTimer, x
			// 	beq ReadyToFlash

			// 	dec FlashTimer, x
			// 	jmp EndLoop

			// 	ReadyToFlash:

			// 	lda #FlashTime
			// 	sta FlashTimer, x

			// 	lda Flashing, x
			// 	beq MakeOne

			// 	lda #0
			// 	sta Flashing, x
			// 	jmp Draw

			// 	MakeOne:

			// 	lda #1
			// 	sta Flashing, x

			// Draw:	

			// 	lda FlashBeans, x
			// 	tay

			// 	jsr DrawCard


			EndLoop:

			ldx ZP.Player
			inx
			cpx #2
			beq Finish

			jmp Loop


		Finish:


		rts
	}	






	AI: {

		lda InitialAICooldown
		beq Ready

		dec InitialAICooldown
		jmp Finish



		Ready:

		ldy #0

		lda TargetRotation
		cmp Rotation + 2
		beq RotationOK

		jmp Rotate

		RotationOK:

			lda #0
			sta INPUT.FIRE_UP_THIS_FRAME, y

			lda TargetMove
			cmp CurrentMove + 1
			beq PositionOK

			bcc Left

			jmp Right

		PositionOK:

			 jsr RANDOM.Get
			// cmp #4
			// bcc Left

			// cmp #252
			// bcs Right

			// cmp #251
			// bcs Rotate

			 cmp #140
			 bcc Finish

			 jsr RANDOM.Get

			 ldx CAMPAIGN.OpponentID
			 cmp OPPONENTS.Speed, x
			 bcc Down

			 jmp Finish

		Rotate:

			lda #1
			sta INPUT.FIRE_UP_THIS_FRAME, y
			jmp Finish

		Down:

			lda #1
			sta INPUT.JOY_DOWN_NOW, y
			jmp Finish

		Left:

			lda #1
			sta INPUT.JOY_LEFT_NOW, y
			jmp Finish


		Right:

			lda #1
			sta INPUT.JOY_RIGHT_NOW, y


		Finish:

		ldx ZP.Player


		rts
	}

	HandleControls: {

		lda ControlTimer, x
		beq Ready

		dec ControlTimer, x
		jmp CheckFire

		Ready:

			lda CPU, x
			beq NotCPU

			jsr AI

			NotCPU:

			lda ControlPorts, x
			tay

		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

		HandleLeft:

			lda TableOffset, x
			tax

			CheckNotFarLeft:

				lda GridPosition, x
				tay

				lda GRID.RelativeColumn, y
				beq CheckDown

				dey
				lda GRID.PlayerOne, y
				bne CheckDown

				inx
				lda GridPosition, x
				tay

				lda GRID.RelativeColumn, y
				beq CheckDown

				dey
				lda GRID.PlayerOne, y
				bne CheckDown

			MoveLeft:	

				stx ZP.Offset

				ldx ZP.Player
				dec CurrentMove, x

				jsr DeleteCards

				ldx ZP.Offset

				dec GridPosition, x
				dec GridPosition - 1, x
				jmp DidMove

		CheckDown:
		 jmp CheckDown2


		CheckRight:


			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

		HandleRight:

			lda TableOffset, x
			tax

			CheckNotFarRight:

				lda GridPosition, x
				tay

				lda GRID.RelativeColumn, y
				cmp #4
				beq CheckDown2

				iny
				lda GRID.PlayerOne, y
				bne CheckDown2

				inx
				lda GridPosition, x
				tay

				lda GRID.RelativeColumn, y
				cmp #4
				beq CheckDown2

				iny
				lda GRID.PlayerOne, y
				bne CheckDown2

			MoveRight:	

				stx ZP.Offset

				ldx ZP.Player
				inc CurrentMove, x
			
				jsr DeleteCards

				ldx ZP.Offset

				inc GridPosition, x
				inc GridPosition - 1, x
				jmp DidMove


		CheckDown2:

			ldx ZP.Player
			lda ControlPorts, x
			tay
			lda INPUT.JOY_DOWN_NOW, y
			beq CheckFire

		HandleDown:

			ldx ZP.Player

			lda DropTimer, x
			beq Finish

			lda #0
			sta DropTimer, x

			ldx ZP.Offset
			lda Offset, x
			bne NoScore

			ldx ZP.Player
			//jsr SCORING.AddOne
			sfx(SFX_MOVE)

			NoScore:

			

			jmp Finish

		CheckFire:

			ldx ZP.Player
			lda ControlPorts, x
			tay
			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq Finish

			ldx ZP.Player
			jsr DeleteCards


			ldx ZP.Player

			jsr Rotate


		DidMove:	

			ldx ZP.Player
			bne NoSound

			sfx(SFX_MOVE)

			NoSound:

			lda #ControlCooldown
			sta ControlTimer, x

			lda TableOffset, x
			tay
			sty ZP.CurrentID

			jsr DrawCard

			ldy ZP.CurrentID
			iny

			jsr DrawCard
			

		Finish:


		rts

	}







	RotateUp: {



		lda GridPosition, x
		tay

		CheckNotTop:

			lda GRID_VISUALS.RowLookup, y
			cmp #1
			bcs NotTop

			jmp Finish

		NotTop:

			lda GridPosition, x
			sec
			sbc #4
			tay

			lda GRID.PlayerOne, y
			beq NotOccupiedUp

			jmp Finish

		NotOccupiedUp:

			tya
			sta GridPosition, x


			lda #0
			sta Rotation, x

			ldy ZP.Player
			lda #0
			sta DoubleClickTimer, y

			sfx(SFX_ROTATE)
			
		Finish:


		rts
	}




	UpToDown: {

		lda GridPosition, x
		tay

		lda GRID_VISUALS.RowLookup, y
		cmp #20
		bcs Finish

		lda GridPosition, x
		clc
		adc #10
		tay

		lda GRID.PlayerOne, y
		beq NotOccupiedDown

		jmp Finish


		NotOccupiedDown:

			tya
			sta GridPosition, x

		
			inc Rotation, x
			inc Rotation, x

			ldy ZP.Player
			lda #0
			sta DoubleClickTimer, y



			sfx(SFX_ROTATE)


		Finish:



		rts
	}

	RotateRight: {


		ldy ZP.Player
		lda DoubleClickTimer, y
		beq NoDoubleClick

		jmp UpToDown

		NoDoubleClick:

			lda GridPosition, x
			tay

		CheckNotFarRight:

			lda GRID.RelativeColumn, y
			cmp #4
			bcc NotFarRight

			jmp Finish

		NotFarRight:

			lda GridPosition, x
			clc
			adc #6
			tay

			lda GRID.PlayerOne, y
			beq NotOccupiedRight

			jmp Finish

		NotOccupiedRight:

			tya
			sta GridPosition, x


			inc Rotation, x

			ldy ZP.Player
			lda #0
			sta DoubleClickTimer, y

			sfx(SFX_ROTATE)

			rts


		Finish:


			ldx ZP.Player
			lda #DoubleClickTime
			sta DoubleClickTimer, x


			rts


	}


	RotateDown: {


		lda GridPosition, x
		tay

		CheckNotBottom:

			lda GRID_VISUALS.RowLookup, y
			cmp #20
			bcc NotBottom

			jmp Finish

		NotBottom:

			lda GridPosition, x
			clc
			adc #4
			tay

			lda GRID.PlayerOne, y
			beq NotOccupiedDown

			jmp Finish

		NotOccupiedDown:

			tya
			sta GridPosition, x
			inc Rotation, x

			ldy ZP.Player
			lda #0
			sta DoubleClickTimer, y

			sfx(SFX_ROTATE)

		Finish:

		rts

	}


	DownToUp: {

		lda GridPosition, x
		tay

		CheckNotTop:

			lda GRID_VISUALS.RowLookup, y
			cmp #2
			bcs NotTop

			jmp Finish

		NotTop:

			lda GridPosition, x
			sec
			sbc #10
			tay

			lda GRID.PlayerOne, y
			beq NotOccupiedUp

			jmp Finish

		NotOccupiedUp:

			tya
			sta GridPosition, x
			
			lda #0
			sta Rotation, x

			ldy ZP.Player
			lda #0
			sta DoubleClickTimer, y


			sfx(SFX_ROTATE)

		Finish:

		rts
	}

	RotateLeft: {

		ldy ZP.Player
		lda DoubleClickTimer, y
		beq NoDoubleClick

		jmp DownToUp

		NoDoubleClick:

		lda GridPosition, x
		tay

		CheckNotFarLeft:

			lda GRID.RelativeColumn, y
			bne NotFarLeft

			jmp Finish

		NotFarLeft:

			lda GridPosition, x
			sec
			sbc #6
			tay

			lda GRID.PlayerOne, y
			beq NotOccupiedLeft

			jmp Finish

		NotOccupiedLeft:

			tya
			sta GridPosition, x
			inc Rotation, x


			ldy ZP.Player
			lda #0
			sta DoubleClickTimer, y


			sfx(SFX_ROTATE)

			rts

			

		 Finish:

			ldx ZP.Player
			lda #DoubleClickTime
			sta DoubleClickTimer, x



		rts


	}






	Rotate: {

		// x = 0 or 1 
		lda TableOffset, x
		tax

		CheckRight:

			lda Rotation, x
			bne CheckDown

			jmp RotateRight

		CheckDown:

			cmp #1
			bne CheckLeft

			jmp RotateDown

		CheckLeft:

			cmp #2
			bne NotLeft

			jmp RotateLeft
		
		NotLeft:

		jmp RotateUp


		//x = 0 or 2


		Finish:



		rts
	}



	DrawCard: {


		// y = 0-3

		GetPosition:

			lda GridPosition, y
			tax

			lda GRID_VISUALS.RowLookup, x
			sta ZP.Row

			lda Offset, y
			clc
			adc ZP.Row
			sta ZP.Row

			lda GRID_VISUALS.ColumnLookup, x
			sta ZP.Column
			sta ZP.TempX

		GetColour:


			lda #8
			sta ZP.Colour

			
		GetChars:

			ldx #0

			cpy #0
			beq NoFlash

			cpy #2
			beq NoFlash

			ldx ZP.Player
			//lda Flashing, x
			//tax

			NoFlash:

			lda Beans, y
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


	DrawCharacter: {

		cpy #24
		bcs NoDraw

		jsr DRAW.PlotCharacter

		lda ZP.BeanColour
		jsr DRAW.ColorCharacter

		lda ZP.CharID


		NoDraw:

		rts
	}



	DeleteCards: {

		stx ZP.Player

		lda TableOffset, x
		tay
		iny
		iny
		sty ZP.EndID
		dey
		dey

		Loop:

			sty ZP.TempY
				
			jsr DeleteCard

			ldx ZP.Player

			EndLoop:

				ldy ZP.TempY
				iny 
				cpy ZP.EndID
				bcc Loop



		rts

	}


	DeleteCard: {


		// y = 0-3


		GetPosition:

			lda GridPosition, y
			tax

			lda GRID_VISUALS.RowLookup, x
			sta ZP.Row

			lda Offset, y
			clc
			adc ZP.Row
			sta ZP.Row

			lda GRID_VISUALS.ColumnLookup, x
			sta ZP.Column

		jsr GRID_VISUALS.ClearBehindFallingCard



		rts
	}

	DropBeans: {

		stx ZP.Player

		lda TableOffset, x
		tay

		Loop:

			sty ZP.CurrentID

			lda Offset, y
			beq MoveDownGrid

			clc
			adc #1
			sta Offset, y

			jmp Draw

			MoveDownGrid:

				lda #254
				sta Offset, y

				jsr CheckCollision

				ldx ZP.Player

				lda Status, x
				bne Finish


			Draw:

				jsr DrawCard

			EndLoop:

				ldy ZP.CurrentID
				iny 
				cpy ZP.EndID
				bcc Loop


		Finish:

		ldx ZP.Player


		rts




	}


	CheckCollision: {



		lda GridPosition, y
		tax
		lda GRID_VISUALS.RowLookup, x
		cmp #21
		beq Collision


		NoCollisionFloor:	

			lda GridPosition, y
			clc
			adc #GRID.Columns
					
			pha

			tax
			lda GRID.PlayerOne, x
			bne Skip

			jmp Finish

		Skip:

			pla

		Collision:

			sty ZP.CurrentID

			jsr DeleteCard

			ldy ZP.CurrentID

			lda GridPosition, y
			sta ZP.GridPosition
			tax

			lda ZP.Player
			beq Player1_

			Player2_:

			cpx #40
			bcs NotRoundOver_

				jsr LostRound
				rts

			Player1_:

			cpx #180
			bcc NotRoundOver_

				jsr LostRound
				rts

			NotRoundOver_:

			lda Beans, y
			//sta GRID.PlayerOne, x

			lda #GRID.BeanLandedType
			sta GRID.PreviousType, x

			sfx(SFX_LAND)

			cpy #0
			beq AddToY

			cpy #2
			beq AddToY

		DecreaseY:

			dey
			jmp PausePlayer
			

		AddToY:

			iny

		PausePlayer:

			sty ZP.CurrentID

			jsr DeleteCard

			ldy ZP.CurrentID

			lda GridPosition, y
			cmp ZP.GridPosition
			bne Okay

			sec
			sbc #6
		

			Okay:

			tax

			lda ZP.Player
			beq Player1

			Player2:

			cpx #40
			bcs NotRoundOver

				jsr LostRound
				rts

			Player1:

			cpx #180
			bcc NotRoundOver

				jsr LostRound
				rts

			NotRoundOver:


			lda Beans, y
			//sta GRID.PlayerOne, x

			lda #GRID.BeanLandedType
			sta GRID.PreviousType, x

			ldy ZP.Player

			lda #PLAYER_STATUS_PLACED
			sta Status, y

			lda #FailsafeTime
			sta FailsafeTimer, y


			ldy ZP.Player
			jsr PANEL.KickOff

			
			rts

		Finish:

		pla
		sta GridPosition, y


		ldx ZP.Player




		rts
	}


	LostRound:  {

		lda RoundOver
		bne Finish

		lda #1
		sta RoundOver

		lda #GRID_MODE_END
		sta GRID.Mode
		sta GRID.Mode + 1

		lda #0
		sta GRID.Active
		sta GRID.Active + 1

		ldy ZP.Player
		lda #GRID_MODE_FALL
		sta GRID.Mode, y

		lda #1
		sta GRID.NumberMoving, y
		sta GRID.Active, y

		lda #GRID.LastRowID
		sta GRID.StartRow
		sta GRID.CurrentRow

		lda #PLAYER_STATUS_END
		sta Status
		sta Status + 1

		lda #2
		sta ROCKS.Mode
		sta ROCKS.Mode + 1

		lda #0
		sta PANEL.Mode
		sta PANEL.Mode + 1

		lda #3
		jsr sid.init

		jsr ROUND_OVER.Show
		
		
		lda #2
		//sta GRID.RowsPerFrameUse

		Finish:

		rts
	}


	SetupCards: {

		// y = 0 or 1 

		lda #0
		sta Status, y
		sty ZP.Player

		lda #FlashTime
		sta FlashTimer, y

		lda CurrentAutoDropTime, y
		sta DropTimer, y

		lda PANEL.Offsets, y
		tax

		lda TableOffset, y
		tay

		// x = 0 or 4
		// y = 0 or 2 

		sty ZP.TempY

		lda PANEL.Queue, x
		sta Beans + 0, y

		lda PANEL.Queue + 1, x
		sta Beans + 1, y

		lda StartGridPositions, y
		sta GridPosition, y
		tax

		lda GRID.PlayerOne, x
		beq SpaceAvailable

		jsr LostRound
		jmp Finish

		SpaceAvailable:


		lda StartGridPositions + 1, y
		sta GridPosition + 1, y

		lda StartOffsets, y
		sta Offset, y

		lda StartOffsets + 1, y
		sta Offset + 1, y

		lda #1
		sta Rotation, y
		sta Rotation + 1, y

		jsr DrawCard

		ldy ZP.TempY
		iny

		jsr DrawCard


		ldy ZP.Player

		lda #PLAYER.PLAYER_STATUS_NORMAL
		sta PLAYER.Status, y

		cpy #0
		beq Skip

		lda CPUDanger
		beq NoDanger

		lda #10
		sta InitialAICooldown
		jmp Skip

		NoDanger:

		lda #InitialAICooldownTime
		sta InitialAICooldown

		Skip:

		lda #GRID_MODE_NORMAL
		sta GRID.Mode, y

		Finish:


		lda #1
		sta GRID.Active, y



		rts
	}







}