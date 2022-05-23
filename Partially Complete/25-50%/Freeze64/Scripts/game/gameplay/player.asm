PLAYER: {

	.label StartColumnX = 30
	.label StartY = 226


	CurrentFish:			.byte 3, 3
	NextFish:				.byte 0, 0
	SelectedColumn:			.byte 2, 2
	Active:					.byte 1, 1
	FrameTimer:				.byte FrameTime, FrameTime
	Status:					.byte PLAYER_SELECT_COLUMN, PLAYER_SELECT_COLUMN
	FrameID:				.byte 0, 0
	NextFrame:				.byte 0, 0
	Frame:					.byte 0, 0
	SpriteX_LSB:			.byte StartColumnX + (2 * 24), StartColumnX + (9 * 24) + 17
	SpriteX_MSB:			.byte 0, 1
	TargetSpriteX_LSB:		.byte 0, 0
	TargetSpriteX_MSB:		.byte 0, 0
	SpriteY:				.byte 0, 0
	Opposite:				.byte 1, 0
	NextX:					.byte 159, 183
	GridAdd:				.byte 35, 75


	ControlCooldown:		.byte 0, 0
	
	DirectionPointer:		.byte 0, 16
	FrameSequence:			.byte 0, 1, 0, 1, 0, 1, 0, 2
	NextSequence:			.byte 1, 0, 2, 0, 1, 0, 1, 0


	MiddleColumnX:			.byte StartColumnX + (2 * 24)
							.byte StartColumnX + (7 * 24) + 8

	MiddleColumnMSB:		.byte 0, 1
	

	ColumnAdd:				.byte 0, 5
	StartColumn:			.byte 1, 24

	.label FrameTime = 8
	.label SidePixelsFrame = 6


	FishColours:			.byte GREEN, RED, CYAN, YELLOW



	InitialiseFish: {

		jsr RANDOM.Get
		and #%00000111
		sta FrameTimer

		jsr RANDOM.Get
		and #%00000111
		sta FrameTimer + 1

		lda #2
		sta SelectedColumn
		sta SelectedColumn + 1

		lda #StartY
		sta SpriteY
		sta SpriteY + 1

		jsr RANDOM.Get
		and #%00000011
		sta NextFish

		jsr RANDOM.Get
		and #%00000011
		sta NextFish + 1

		jsr RANDOM.Get
		and #%00000011
		sta CurrentFish

		jsr RANDOM.Get
		and #%00000011
		sta CurrentFish + 1

		lda #255
		sta CurrentFish + 1

		rts
	}

	TransferNextFish: {

		lda NextFish, y
		sta CurrentFish, y

		jsr RANDOM.Get
		and #%00000011
		sta NextFish, y

		lda #PLAYER_SELECT_COLUMN
		sta Status, y


		rts
	}

	Control: {

		lda Opposite, x
		tay

		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckLeft

			lda SelectedColumn, x
			cmp #4
			bcs CheckFire

			inc SelectedColumn, x

			lda SpriteX_LSB, x
			clc
			adc #24
			sta TargetSpriteX_LSB, x

			lda SpriteX_MSB, x
			adc #0
			sta TargetSpriteX_MSB, x

			lda #PLAYER_MOVE_FISH
			sta Status, x

			rts

		CheckLeft:


			lda INPUT.JOY_LEFT_NOW, y
			beq CheckFire

			lda SelectedColumn, x
			beq CheckFire
	
			dec SelectedColumn, x

			lda SpriteX_LSB, x
			sec
			sbc #24
			sta TargetSpriteX_LSB, x

			lda SpriteX_MSB, x
			sbc #0
			sta TargetSpriteX_MSB, x

			lda #PLAYER_MOVE_FISH
			sta Status, x

			rts


		CheckFire:

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq Finish

			jsr Launch


		Finish:


		rts
	}	



	Launch: {

		jsr GRID.Add

		lda ZP.Amount
		beq Finish

		lda #PLAYER_LAUNCH_FISH
		sta Status, x

		lda #NO_FISH
		sta CurrentFish, x

		jsr LAUNCHER.Start


		Finish:


		rts
	}




	DisplayNextFish: {

		lda Opposite, x
		tay

		lda NextFish, x
		asl
		asl
		clc
		adc #17
		clc
		adc NextFrame, x
		clc
		adc DirectionPointer, y
		sta SPRITE_POINTERS + 2, x

		lda NextFish, x
		tay

		lda FishColours, y
		sta VIC.SPRITE_COLOR_2, x

		txa
		asl
		tay

		lda NextX, x
		sta VIC.SPRITE_2_X, y

		lda #StartY
		sta VIC.SPRITE_2_Y, y

		lda VIC.SPRITE_MSB
		and #%11110011
		sta VIC.SPRITE_MSB




		rts
	}

	DisplayCurrentFish: {

		
		lda CurrentFish, x
		bpl Display

		txa
		asl
		tay

		lda #0
		sta VIC.SPRITE_0_Y, y
		rts 

		Display:

		tay
		asl
		asl
		clc
		adc #17
		clc
		adc Frame, x
		clc
		adc DirectionPointer, x

		sta SPRITE_POINTERS, x

		lda FishColours, y
		sta VIC.SPRITE_COLOR_0, x

		txa
		asl
		tay


		lda SpriteX_LSB, x
		sta VIC.SPRITE_0_X, y

		lda #StartY
		sta VIC.SPRITE_0_Y, y

		lda SpriteX_MSB, x
		beq NoMSB	

		MSB:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On, x
			sta VIC.SPRITE_MSB
			jmp MSB_Done

		NoMSB:	

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off, x
			sta VIC.SPRITE_MSB

		MSB_Done:
		

		rts

			
	}


	UpdateFrame: {

		lda FrameTimer, x
		beq Ready
		
		dec FrameTimer, x
		rts

		Ready:

		lda #FrameTime
		sta FrameTimer, x

		inc FrameID, x
		lda FrameID, x
		cmp #8
		bcc NoWrap

		lda #0
		sta FrameID, x

		NoWrap:

		tay
		lda FrameSequence, y
		sta Frame, x

		lda NextSequence, y
		sta NextFrame, x


		rts
	}





	MoveFish: {

		CheckMSB:

			lda TargetSpriteX_MSB, x
			cmp SpriteX_MSB, x
			bcc GoingLeft
			beq CheckLSB

			jmp GoingRight

		CheckLSB:

			lda TargetSpriteX_LSB, x
			cmp SpriteX_LSB, x
			bcc GoingLeft

		GoingRight:

			lda SpriteX_LSB, x
			clc
			adc #SidePixelsFrame
			sta SpriteX_LSB, x

			lda SpriteX_MSB, x
			adc #0
			sta SpriteX_MSB, x

			jmp CheckArrive

		GoingLeft:

			lda SpriteX_LSB, x
			sec
			sbc #SidePixelsFrame
			sta SpriteX_LSB, x

			lda SpriteX_MSB, x
			sbc #0
			sta SpriteX_MSB, x


		CheckArrive:

			lda TargetSpriteX_MSB, x
			cmp SpriteX_MSB, x
			bne NotArrived

			lda TargetSpriteX_LSB, x
			cmp SpriteX_LSB, x
			bne NotArrived

			lda #PLAYER_SELECT_COLUMN
			sta Status, x

		NotArrived:


		rts
	}

	HandleColumnSelect: {

		jsr Control
		jsr UpdateFrame
		jsr DisplayCurrentFish
		jsr DisplayNextFish


		rts
	}

	HandleMovingFish: {

		jsr MoveFish
		jsr UpdateFrame
		jsr DisplayCurrentFish
		jsr DisplayNextFish




		rts
	}


	FrameUpdate: {

		ldx #0

		Loop:

			stx ZP.Player

			lda Active, x
			beq EndLoop

			lda Status, x
			cmp #PLAYER_SELECT_COLUMN
			bne NotColumn

			SelectColumn:

				jsr HandleColumnSelect
				jmp EndLoop

			NotColumn:	

				cmp #PLAYER_MOVE_FISH
				bne NotMove

				jsr HandleMovingFish
				jmp EndLoop

			NotMove:




			EndLoop:	

				ldx ZP.Player

				inx
				cpx #2
				bcc Loop





		rts
	}





}