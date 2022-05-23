PLAYER: {

	* = * "Player"

	.label AutoDropTime = 33
	.label FlashTime = 10
	.label ControlCooldown = 6
	.label FailsafeTime = 60

	.label PLAYER_STATUS_NORMAL = 0
	.label PLAYER_STATUS_WAIT = 1
	.label PLAYER_STATUS_PLACED = 2
	.label PLAYER_STATUS_END = 3
	.label PLAYER_STATUS_COLLIDED = 4
	.label InitialAICooldownTime = 40

	.label DoubleClickTime = 16


	Beans: 			.byte 0, 0, 0, 0, 0, 0
	GridPosition:	.byte 2, 2, 2, 74, 74, 74
	Offset:			.byte 255, 255, 255, 255, 255, 255
	PrevGridPosition:	.byte 2, 2, 2, 74, 74, 74

	
	Status:				.byte 1, 0
	DropTimer:			.byte AutoDropTime, AutoDropTime
	FlashTimer:			.byte 0, 0
	Flashing:			.byte 0, 0
	Rotation:			.byte 0, 0, 0, 0
	ClearUp:			.byte 1, 0, 1, 0
	AddForX:			.byte 1, 255, 255, 1
	AddForY:			.byte 6, 6,	 250, 250
	CPU:				.byte 0, 1
	Level:				.byte 0, 0
	Gems:				.byte 0, 0, 0, 0
	GemLevelCounter:	.byte 0, 0

	FailsafeTimer:		.byte 255, 255
	

	CharIDs:			.byte 137, 138
	StartGridPositions:	.byte 2, 2, 2, 74, 74, 74
	StartOffsets:		.byte 251, 253, 255, 251, 253, 255
	StartIDs:			.byte 0, 0, 0, 3, 3, 3

	BackgroundColours: 	.byte 0, 0, 0, 0
	BackgroundCharIDs: 	.byte 0, 0, 0, 0

	CurrentAutoDropTime:	.byte AutoDropTime, AutoDropTime

	TableOffset:		.byte 0, 3
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

	CPUDanger: 		.byte 0
	Debug:			.byte 0
	DebugCols:		.byte 0, 38
	MagicGems:		.byte 0, 0
	LayersToAdd:	.byte 0, 0
	MagicColours:	.byte 0, 0
	DownNow:		.byte 0, 0
	DownTimer:		.byte 0, 0
	PlacedLocation:	.byte 0, 0


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
		sta Beans + 4
		sta Beans + 5
		sta Gems
		sta Gems + 1
		sta Gems + 2
		sta Gems + 3
		sta GemLevelCounter
		sta GemLevelCounter + 1

		sta MagicGems
		sta MagicGems + 1
		sta MagicColours
		sta MagicColours + 1


		sta LayersToAdd
		sta LayersToAdd + 1

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
		sta GridPosition + 2

		lda #74
		sta GridPosition + 3
		sta GridPosition + 4
		sta GridPosition + 5

		lda #255
		sta DownTimer
		sta DownTimer + 1


		rts
	}	


	CheckPlaceRotate: {

		lda ControlPorts, x
		tay
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		Rotate:

			lda PlacedLocation, x
			tay

			lda GRID.PlayerOne, y
			sta ZP.TempBeans
			tya
			
			cpx #0
			beq Player1

		Player2:

			sec
			sbc #12

			cmp #72
			bcc Finish

			jmp Swap

		Player1:

			sec
			sbc #12
			bmi Finish

		Swap:

			lda GRID.PlayerOne - 6, y
			sta GRID.PlayerOne, y

			lda GRID.PlayerOne - 12, y
			sta GRID.PlayerOne - 6, y

			lda ZP.TempBeans
			sta GRID.PlayerOne - 12, y

			sfx(SFX_SWAP)



		Finish:



		rts
	}



	FrameUpdate: {

		ldx #0
		lda #0
		sta DownNow, x

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
				cmp #PLAYER_STATUS_PLACED
				bne NotPlaced2

				jsr CheckPlaceRotate
				jmp EndLoop

			NotPlaced2:

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

				lda #0
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




	HandleControls: {

		lda ControlTimer, x
		beq Ready

		dec ControlTimer, x
		jmp CheckFire

		Ready:

			lda CPU, x
			beq NotCPU

			//jsr AI

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

				dey
				lda GRID.PlayerOne, y
				bne CheckDown

				inx
				lda GridPosition, x
				tay

				dey
				lda GRID.PlayerOne, y
				bne CheckDown

				dex
				dex

			MoveLeft:	

				stx ZP.Offset

				ldx ZP.Player
				dec CurrentMove, x

				jsr DeleteBeans

				ldx ZP.Offset

				dec GridPosition, x
				dec GridPosition + 1, x
				dec GridPosition + 2, x

			

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

				iny
				lda GRID.PlayerOne, y
				bne CheckDown2

				inx
				lda GridPosition, x
				tay

				iny
				lda GRID.PlayerOne, y
				bne CheckDown2

				dex
				dex

			MoveRight:	

				stx ZP.Offset

				ldx ZP.Player
				inc CurrentMove, x
			
				jsr DeleteBeans

				ldx ZP.Offset

				inc GridPosition, x
				inc GridPosition + 1, x
				inc GridPosition + 2, x
				jmp DidMove


		CheckDown2:

			ldx ZP.Player
			lda ControlPorts, x
			tay
			lda INPUT.JOY_DOWN_NOW, y
			bne HandleDown

			lda INPUT.JOY_DOWN_LAST, y
			beq CheckFire

			lda CurrentAutoDropTime, x
			sta DropTimer, x

			jmp CheckFire

		HandleDown:

			ldx ZP.Player

			lda #1
			sta DownNow, x

			lda DropTimer, x
			beq Finish

			lda #0
			sta DropTimer, x

			ldx ZP.Offset
			lda Offset, x
			bne NoScore

			ldx ZP.Player
			jsr SCORING.AddOne
			//sfx(SFX_DOWN)

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
			inc DropTimer, x
			bne NoSound

		//	sfx(SFX_MOVE)

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

			ldy ZP.Y
			iny
			iny

			jsr DrawBean
			

		Finish:


		rts

	}



	Rotate: {

		// x = 0 or 1 
		lda TableOffset, x
		tax


		lda GridPosition + 2, x
		sta ZP.TempBeans

		lda Offset + 2, x
		sta ZP.Amount

		lda GridPosition + 1, x
		sta GridPosition + 2, x
		sta PrevGridPosition + 2, x

		lda Offset + 1, x
		sta Offset + 2, x

		lda GridPosition + 0, x
		sta GridPosition + 1, x
		sta PrevGridPosition + 1, x

		lda Offset + 0, x
		sta Offset + 1, x

		lda ZP.TempBeans
		sta GridPosition + 0, x
		sta PrevGridPosition + 0, x

		lda ZP.Amount
		sta Offset + 0, x

		sfx(SFX_SWAP)

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

			ldx ZP.Player
			lda PLAYER.MagicGems, x
			cmp #1
			bne NotMagic


			Magic:

				jsr RANDOM.Get
				and #%00000111
  				cmp PANEL.MaxColours, x
				bcs Magic

				tax
				lda PANEL.Colours, x

				//lda MagicColours, x
				sta ZP.Colour
				jsr PLAYER.ConvertColour
				clc
				adc #8
				sta ZP.BeanColour

			Char:

				lda #189
				sta ZP.CharID

				jmp TopLeft

		NotMagic:

			lda Beans, y
			sta ZP.Colour
			jsr PLAYER.ConvertColour
			clc
			adc #8
			sta ZP.BeanColour

			ldx ZP.Colour
			lda PANEL.ColourToChar, x
			sta ZP.Colour

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
			clc
			adc ZP.Colour
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

		clc
		adc #3
		sta ZP.EndID

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
		clc
		adc #3
		sta ZP.EndID

		Loop:

			sty ZP.TempY

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

	

				ldy ZP.TempY
				iny 
				cpy ZP.EndID
				bcc Loop


		Finish:

		ldx ZP.Player
		lda TableOffset, x
		tax

		BackupLoop:

			lda GridPosition + 0, x
			sta PrevGridPosition + 0,  x

			inx
			cpx ZP.EndID
			bcc BackupLoop

		ldx ZP.Player
		

		rts




	}


	CheckCollision: {

		ldx ZP.Player
		lda Status, x
		cmp #PLAYER_STATUS_PLACED
		bne NotPlaced

		rts

		NotPlaced:

		lda GridPosition, y
		sta PrevGridPosition, y
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
			sta ZP.BeanColour
			bne Skip

			jmp Finish

		Skip:

			pla

		Collision:

			sty ZP.Y
			sty ZP.BeanID

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

				lda PrevGridPosition, y
				ldx ZP.Player
				sta PlacedLocation, x

				lda StartIDs, y
				tay
				clc
				adc #3
				sta ZP.Amount

				lda MagicGems, x
				cmp #1
				bne Loop


			PlacedMagic:

				lda #3
				sta MagicGems, x

				lda ZP.BeanColour
				sta MagicColours, x
				sta Beans, y
				sta Beans + 1, y
				sta Beans + 2, y

			Loop:

				sty ZP.Y

				lda PrevGridPosition, y
				tax

				lda Beans, y		
				sta GRID.PlayerOne, x

				lda #GRID.BeanLandedType
				sta GRID.PreviousType, x

				lda #2
				sta GRID.Delay, x

				ldx ZP.Player
				inc GRID.RunningCount, x

				jsr DeleteBean

				ldy ZP.Y
				lda #0
				sta GridPosition, y
				sta PrevGridPosition, y
				iny
				cpy ZP.Amount
				bcc Loop

		Placed:

			sfx(SFX_LAND)

		DontAdd_:

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

	//	lda #3
	//	jsr sid.init

		jsr ROUND_OVER.Show
		
		
		lda #2
		//sta GRID.RowsPerFrameUse

		Finish:

		rts
	}

	TriggerMagicGems: {

		lda GRID.RunningCount, y
		cmp #36
		bcc Finish

		jsr RANDOM.Get
		cmp #200
		bcc Finish

		jsr RANDOM.Get
		cmp GRID.RunningCount, y
		bcs Finish

		jsr RANDOM.Get
		and #%00000111
		cmp PANEL.MaxColours, y
		bcs TriggerMagicGems

		tax
		lda PANEL.Colours, x
		sta PLAYER.MagicColours, y


		lda #2
		sta PLAYER.MagicGems, y


		Finish:

		rts

	}

	SetupBeans: {

		// y = 0 or 1 

		lda MagicGems, y
		bmi NotMagic
		bne Magic

			jsr TriggerMagicGems
			jmp NotMagic

		Magic:

			sec
			sbc #1
			sta MagicGems, y

		NotMagic:

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

			// x = 0 or 3
			// y = 0 or 3

			sty ZP.TempY

			lda PANEL.Queue, x
			sta Beans + 0, y

			lda PANEL.Queue + 1, x
			sta Beans + 1, y

			lda PANEL.Queue + 2, x
			sta Beans + 2, y

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


			lda StartGridPositions + 2, y
			sta GridPosition + 2, y

			lda StartOffsets, y
			sta Offset, y

			lda StartOffsets + 1, y
			sta Offset + 1, y

			lda StartOffsets + 2, y
			sta Offset + 2, y

			lda #0
			sta Rotation, y
			sta Rotation + 1, y
			sta Rotation + 2, y

			jsr DrawBean

			ldy ZP.TempY
			iny

			jsr DrawBean	

			ldy ZP.TempY
			iny
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