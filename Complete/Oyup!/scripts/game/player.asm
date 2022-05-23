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
	GridPosition:	.byte 2, 2, 74, 74
	Offset:			.byte 255, 255, 255, 255

	
	Status:				.byte 1, 1
	DropTimer:			.byte AutoDropTime, AutoDropTime
	FlashTimer:			.byte 0, 0
	Flashing:			.byte 0, 0
	Rotation:			.byte 0, 0, 0, 0
	ClearUp:			.byte 1, 0, 1, 0
	AddForX:			.byte 1, 255, 255, 1
	AddForY:			.byte 6, 6,	 250, 250
	CPU:				.byte 0, 1

	FailsafeTimer:		.byte 255, 255
	

	CharIDs:			.byte 129, 197
	StartGridPositions:	.byte 2, 2, 74, 74
	StartOffsets:		.byte 253, 255, 253, 255

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
	Debug:	.byte 0
	DebugCols:	.byte 0, 38


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
		sta Rotation
		sta Rotation + 1
		sta Rotation + 2
		sta Rotation + 3

		lda #2
		sta GridPosition
		sta GridPosition + 1

		lda #74
		sta GridPosition + 2
		sta GridPosition + 3

		lda Debug
		beq Skip

		lda #1

		sta COLOR_RAM + 0
		sta COLOR_RAM + 80
		sta COLOR_RAM + 160
		sta COLOR_RAM + 240
		sta COLOR_RAM + 320
		sta COLOR_RAM + 400
		sta COLOR_RAM + 440
		sta COLOR_RAM + 441
		sta COLOR_RAM + 481
		sta COLOR_RAM + 521
		sta COLOR_RAM + 561
		sta COLOR_RAM + 601
		sta COLOR_RAM + 641
		sta COLOR_RAM + 681



		ldx DebugCols + 1

		sta COLOR_RAM + 0, x
		sta COLOR_RAM + 80, x
		sta COLOR_RAM + 160, x
		sta COLOR_RAM + 240,x
		sta COLOR_RAM + 320, x
		sta COLOR_RAM + 400, x
		sta COLOR_RAM + 440, x
		sta COLOR_RAM + 441, x
		sta COLOR_RAM + 481, x
		sta COLOR_RAM + 521, x
		sta COLOR_RAM + 561, x
		sta COLOR_RAM + 601, x
		sta COLOR_RAM + 641, x
		sta COLOR_RAM + 681, x


		Skip:


		rts
	}	



	ShowDebug: {



		lda DebugCols, x
		tay

		lda GRID.Mode, x
		clc
		adc #48
		sta SCREEN_RAM + 0, y

		lda GRID.Active, x
		clc
		adc #48
		sta SCREEN_RAM + 80, y

		lda PANEL.Mode, x
		clc
		adc #48
		sta SCREEN_RAM + 160, y

		lda PLAYER.Status, x
		clc
		adc #48
		sta SCREEN_RAM + 240, y

		lda ROCKS.Mode, x
		clc
		adc #48
		sta SCREEN_RAM + 320, y

		lda ROCKS.OnWayToUs, x
		clc
		adc #48
		sta SCREEN_RAM + 400, y



		txa
		pha

		lda ROCKS.QueueOffset, x
		tax

		


		lda ROCKS.Queue + 0, x
		clc
		adc #48
		sta SCREEN_RAM + 441, y


		lda ROCKS.Queue + 1, x
		clc
		adc #48
		sta SCREEN_RAM + 481, y


		lda ROCKS.Queue + 2, x
		clc
		adc #48
		sta SCREEN_RAM + 521, y


		lda ROCKS.Queue + 3, x
		clc
		adc #48
		sta SCREEN_RAM + 561, y


		lda ROCKS.Queue + 4, x
		clc
		adc #48
		sta SCREEN_RAM + 601, y


		lda ROCKS.Queue + 5, x
		clc
		adc #48
		sta SCREEN_RAM + 641, y

		pla
		tax

		rts
	}

	FrameUpdate: {

		ldx #0

	
		Loop:

			lda Debug
			beq Skip

			jsr ShowDebug

			Skip:

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

				jsr DeleteBeans

				ldx ZP.Player

				jsr DropBeans

				lda Status, x
				bne EndLoop

				

			CheckFlash:

				
				lda FlashTimer, x
				beq ReadyToFlash

				dec FlashTimer, x
				jmp EndLoop

				ReadyToFlash:

				lda #FlashTime
				sta FlashTimer, x

				lda Flashing, x
				beq MakeOne

				lda #0
				sta Flashing, x
				jmp Draw

				MakeOne:

				lda #1
				sta Flashing, x

			Draw:	

				lda FlashBeans, x
				tay

				jsr DrawBean


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

			 lda PANEL.FirstFourMatch
			 beq NoSpeedUp

			 jmp OpponentSpeed

			 NoSpeedUp:

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

			 OpponentSpeed:

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

				jsr DeleteBeans

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
				cmp #5
				beq CheckDown2

				iny
				lda GRID.PlayerOne, y
				bne CheckDown2

				inx
				lda GridPosition, x
				tay

				lda GRID.RelativeColumn, y
				cmp #5
				beq CheckDown2

				iny
				lda GRID.PlayerOne, y
				bne CheckDown2

			MoveRight:	

				stx ZP.Offset

				ldx ZP.Player
				inc CurrentMove, x
			
				jsr DeleteBeans

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
			jsr SCORING.AddOne
			sfx(SFX_DOWN)

			NoScore:

			

			jmp Finish

		CheckFire:

			ldx ZP.Player
			lda ControlPorts, x
			tay
			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq Finish

			ldx ZP.Player
			jsr DeleteBeans


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
			sty ZP.Y

			jsr DrawBean

			ldy ZP.Y
			iny

			jsr DrawBean
			

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
			sbc #5
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
		cmp #21
		bcs Finish

		lda GridPosition, x
		clc
		adc #12
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
			cmp #5
			bcc NotFarRight

			jmp Finish

		NotFarRight:

			lda GridPosition, x
			clc
			adc #7
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
			cmp #23
			bcc NotBottom

			jmp Finish

		NotBottom:

			lda GridPosition, x
			clc
			adc #5
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
			sbc #12
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
			sbc #7
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


	ConvertColour: {

		pha

		stx ZP.Okay

		ldx SETTINGS.ColourSwitch
		beq Normal

		tax
		pla
		lda GRID.ColourBlind, x
		ldx ZP.Okay
		rts
		
		Normal:

		ldx ZP.Okay
		pla

		rts
	}



	DrawBean: {


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

		GetColour:

			lda Beans, y
			jsr PLAYER.ConvertColour
			clc
			adc #8
			sta ZP.BeanColour

		GetChars:

			ldx #0

			cpy #0
			beq NoFlash

			cpy #2
			beq NoFlash

			ldx ZP.Player
			lda Flashing, x
			tax

			NoFlash:

			lda CharIDs, x
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


	DrawCharacter: {

		lda ZP.CharID

		cpy #1
		bcc NoDraw

		cpy #25
		bcs NoDraw

		jsr DRAW.PlotCharacter

		lda ZP.BeanColour
		jsr DRAW.ColorCharacter


		NoDraw:

		rts
	}



	DeleteBeans: {



		lda TableOffset, x
		tay
		iny
		iny
		sty ZP.EndID
		dey
		dey

		Loop:

			sty ZP.Y

			
				
			jsr DeleteBean

			EndLoop:

				ldy ZP.Y
				iny 
				cpy ZP.EndID
				bcc Loop



		rts

	}


	DeleteBean: {


		// y = 0-3


		ldx #0

		lda Offset, y
		beq NoChange

		ldx #2

		NoChange:

		GetChars:

			lda GRID.BackgroundCharIDs, x
			sta ZP.CharID

			lda GRID.BackgroundCharIDs + 1, x
			sta BackgroundCharIDs + 1

			lda GRID.BackgroundCharIDs + 2, x
			sta BackgroundCharIDs + 2


			lda GRID.BackgroundCharIDs + 3, x
			sta BackgroundCharIDs + 3

		GetColours:

			lda GRID.BackgroundColours, x
			sta BackgroundColours

			lda GRID.BackgroundColours + 1, x
			sta BackgroundColours + 1

			lda GRID.BackgroundColours + 2, x
			sta BackgroundColours + 2

			lda GRID.BackgroundColours+ 3, x
			sta BackgroundColours + 3




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

		TopLeft:
		
			ldx ZP.Column
			ldy ZP.Row
			lda BackgroundColours
			sta ZP.BeanColour

			jsr DrawCharacter
				
		TopRight:

			inx
			inc ZP.CharID	
			lda BackgroundColours + 1
			sta ZP.BeanColour	
			lda BackgroundCharIDs + 1
			sta ZP.CharID

			jsr DrawCharacter

		BottomRight:

			iny
			inc ZP.CharID
			lda BackgroundColours + 3
			sta ZP.BeanColour	
			lda BackgroundCharIDs + 3
			sta ZP.CharID
			jsr DrawCharacter
	

		BottomLeft:

			dex
			inc ZP.CharID	
			lda BackgroundColours + 2
			sta ZP.BeanColour	
			lda BackgroundCharIDs + 2
			sta ZP.CharID	
			jsr DrawCharacter


		Finish:


		rts
	}

	DropBeans: {


		lda TableOffset, x
		tay

		Loop:

			sty ZP.Y

			lda Offset, y
			beq MoveDownGrid

			clc
			adc #1
			sta Offset, y

			jmp Draw

			MoveDownGrid:

				lda #255
				sta Offset, y

				
				jsr CheckCollision

				ldx ZP.Player

				lda Status, x
				bne Finish


			Draw:

				jsr DrawBean

			EndLoop:

				ldy ZP.Y
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
		cmp #23
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

			sty ZP.Y

			jsr DeleteBean

			ldy ZP.Y

			lda GridPosition, y
			sta ZP.GridPosition
			tax

			lda ZP.Player
			beq Player1_

			Player2_:

				cpx #68
				beq RoundOver_

				cpx #72
				bcc DontAdd_

				jmp NotRoundOver_

			Player1_:

				cpx #252
				beq RoundOver_

				cpx #180
				bcs DontAdd_

				jmp NotRoundOver_

			RoundOver_:

			//.break
			//lda #1
			//sta SCREEN_RAM + 520
			//sta COLOR_RAM + 520

			jsr LostRound
			rts

			NotRoundOver_:

			lda Beans, y
			sta GRID.PlayerOne, x

			lda #GRID.BeanLandedType
			sta GRID.PreviousType, x

			ldx ZP.Player
			inc GRID.RunningCount, x

			sfx(SFX_LAND)

		DontAdd_:

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

			sty ZP.Y

			jsr DeleteBean

			ldy ZP.Y

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

				cpx #68
				beq RoundOver

				cpx #72
				bcc DontAdd

				jmp NotRoundOver

			Player1:

				cpx #252
				beq RoundOver

				cpx #180
				bcs DontAdd

				jmp NotRoundOver

			RoundOver:

			//	.break
			//	lda #2
			//	sta SCREEN_RAM + 520
				//sta COLOR_RAM + 520

				jsr LostRound
				rts

			NotRoundOver:

				lda Beans, y
				sta GRID.PlayerOne, x


				lda #GRID.BeanLandedType
				sta GRID.PreviousType, x

				ldx ZP.Player
				inc GRID.RunningCount, x

			DontAdd:

				ldy ZP.Player

				lda #PLAYER_STATUS_PLACED
				sta Status, y

				lda #FailsafeTime
				sta FailsafeTimer, y
				
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


	SetupBeans: {

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

		//.break

		//lda #4
		//sta SCREEN_RAM + 520
		//sta COLOR_RAM + 520


		jsr LostRound
		jmp Finish

		SpaceAvailable:


		lda StartGridPositions + 1, y
		sta GridPosition + 1, y

		lda StartOffsets, y
		sta Offset, y

		lda StartOffsets + 1, y
		sta Offset + 1, y

		lda #0
		sta Rotation, y
		sta Rotation + 1, y

		jsr DrawBean

		ldy ZP.TempY
		iny

		jsr DrawBean	


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