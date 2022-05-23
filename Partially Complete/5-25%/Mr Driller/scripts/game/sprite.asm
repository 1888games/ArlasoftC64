SPRITE:{





	PosY:	.byte 0
	PosX:	.byte 0

	NewPosX:		.byte 0

	.label UsualYPosition = 118
	.label UsualXPosition = 126
	.label CanJumpAgainFrame = 9
	

	CurrentFrame:	.byte 16

	JumpSpeeds:		.byte 04, 03, 02, 01, 00, 01, 02, 03, 01, 00, 00, 00, 00, 00, 00, 00, 99
	JumpTimes:		.byte 02, 02, 03, 04, 05, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 99
	JumpFrames:		.byte 00, 01, 02, 03, 04, 05, 06, 07, 08, 08, 09, 10, 11, 12, 13, 00, 99
	JumpDirections:	.byte 00, 00, 00, 00, 00, 01, 01, 01, 01, 00, 00, 00, 00, 00, 00, 00, 99

	JumpSequenceID: .byte 0
	JumpTimer:	.byte 0
	JumpDirection: .byte 0

	IsJumping:	.byte 0
	JumpSpeed:	.byte 0
	CanJump:	.byte 1

	CurrentColumn:	.byte 4
	NewColumn:		.byte 4

	CurrentBlock:		.byte 32
	NewBlock:		.byte 32

	ControlActive: .byte 1

	MoveSpeed:		.byte 3

	Drilling:	.byte 0

	Active:	.byte 0

	IsFalling:	.byte 0

	ColumnRightBoundary:		.fill 9, 54 + (i * 24)
	ColumnLeftBoundary:		    .fill 9, 30 + (i * 24)
	//ColumnRightBoundary:		.fill 9, 30 + (i * 24)


	Reset: {

		lda #LIGHT_RED
		sta VIC.SPRITE_MULTICOLOR_1 

		lda #RED
		sta VIC.SPRITE_MULTICOLOR_2

		lda #RED
		sta VIC.SPRITE_COLOR_0

		lda #YELLOW
		sta VIC.SPRITE_COLOR_0 + 1

		lda #CYAN
		sta VIC.SPRITE_COLOR_0 + 2


		lda CurrentFrame
		sta SPRITE_POINTERS

		clc
		adc #32
		sta SPRITE_POINTERS + 1

		clc
		adc #32
		sta SPRITE_POINTERS + 2

		lda #UsualYPosition
		sta PosY

		lda #UsualXPosition
		sta PosX

		lda #UsualXPosition
		sta VIC.SPRITE_0_X
		sta VIC.SPRITE_0_X + 2
		sta VIC.SPRITE_0_X + 4

		lda #UsualYPosition
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_0_Y + 2
		sta VIC.SPRITE_0_Y + 4

		lda #0
		sta Active

		lda #4
		sta CurrentColumn
		sta NewColumn

		lda #49
		sta CurrentBlock
		sta NewBlock


	//	jsr Jump

		rts
	}







	Drill: {



		lda Drilling
		beq Finish


		lda SCROLLER.Active
		bne Finish


		ldx BlockToDrill

		lda BLOCK.Values, x
		cmp #2
		bcc Finish

		cmp #6
		beq Finish


		jsr BLOCK.DrillBlock




		Finish:

			rts


	}


	Control: {

		lda #0
		sta Drilling

		lda CurrentColumn
		sta NewColumn

		lda CurrentBlock
		sta NewBlock
		sec
		sbc #9
		sta BlockToDrill

		lda ControlActive
		bne Okay

		jmp Finish


		Okay:

		ldy #1

		CheckLeft:
	
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda PosX
			sec
			sbc MoveSpeed
			sta NewPosX

			ldx CurrentColumn
			lda ColumnLeftBoundary, x
			cmp NewPosX
			bcc NoLeftColumnChange

			LeftColumnChange:

					dec NewColumn
					dec NewBlock

					ldx NewBlock

					lda BLOCK.Values, x
					cmp #2
					bcc StoreNewXLeft

					HitObstacle:

						stx BlockToDrill
						ldx NewColumn
						lda ColumnRightBoundary, x
						sta NewPosX

						inc NewColumn
						inc NewBlock

						jmp StoreNewXLeft

			NoLeftColumnChange:


			StoreNewXLeft:

				lda NewPosX
				sta PosX
				lda NewColumn
				sta CurrentColumn
				lda NewBlock
				sta CurrentBlock
				jmp CheckFire




		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda PosX
			clc
			adc MoveSpeed
			sta NewPosX

			ldx CurrentColumn
			lda ColumnLeftBoundary, x
			cmp NewPosX
			bcs NoRightColumnChange

			RightColumnChange:

					inc NewColumn
					inc NewBlock

					ldx NewBlock
					lda BLOCK.Values, x
					cmp #2
					bcc StoreNewXRight

					HitObstacleRight:

						stx BlockToDrill
						ldx CurrentColumn
						lda ColumnLeftBoundary, x
						sta NewPosX

						dec NewColumn
						dec NewBlock

						jmp StoreNewXRight

			NoRightColumnChange:


			StoreNewXRight:

				lda NewPosX
				sta PosX
				lda NewColumn
				sta CurrentColumn
				lda NewBlock
				sta CurrentBlock
				jmp CheckFire




		CheckDown:



		CheckFire:

			lda INPUT.JOY_FIRE_NOW, y
			beq Finish

			lda INPUT.JOY_FIRE_LAST, y
			bne Finish

			lda #1
			sta Drilling



		Finish:



		rts
	}


	CheckFall: {

		lda IsFalling
		bne Finish

		lda CurrentBlock
		sec
		sbc #9

		tax

		lda BLOCK.Values, x

		cmp #2
		bcs DontFall


		Fall:



			//.break

			lda SCROLLER.RowCounter
			bne ContinueScroll

				lda #1
				sta SCROLLER.Active
				sta IsFalling

				lda SCROLLER.Times3Table
				sta  SCROLLER.RowCounter + 1
				lda #0
				sta  SCROLLER.RowCounter
				sta  SCROLLER.ScrollDelay
				jmp Finish

			ContinueScroll:


				lda  SCROLLER.RowCounter + 1
				clc
				adc  SCROLLER.Times3Table
				sta  SCROLLER.RowCounter + 1



		Finish:


		DontFall:






		rts
	}

	Update: {

		lda Active
		beq NotActive

		jsr Control
		jsr Drill
		jsr CheckFall


		NotActive:

		jsr Draw
		
		rts

	}


	Draw: {

		lda CurrentFrame
		sta SPRITE_POINTERS

		sta SPRITE_POINTERS

		clc
		adc #32
		sta SPRITE_POINTERS + 1

		clc
		adc #32
		sta SPRITE_POINTERS + 2


		lda PosX
		sta VIC.SPRITE_0_X
		sta VIC.SPRITE_0_X + 2
		sta VIC.SPRITE_0_X + 4

		lda PosY
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_0_Y + 2
		sta VIC.SPRITE_0_Y + 4



		rts
	}

	
	
}