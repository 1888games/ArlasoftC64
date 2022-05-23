PLAYER: {


	Cell:			.byte 0
	PreviousCell:	.byte 0

	Selected:	.byte 255



	Cooldown:	.byte 0

	.label CooldownTime = 4



	Reset: {

	
		lda #(NUM_ROWS - 1) * NUM_COLS
		sta Cell

		lda #255
		sta Selected

		lda #27
		sta SPRITE_POINTERS

		lda #28
		sta SPRITE_POINTERS + 1


		rts
	}


	CheckValid: {

		ldx Cell

	Loop:

		lda GRID.Cells, x
		bne Finish

		inx
		cpx #NUM_COLS * NUM_ROWS
		bcc Loop

		ldx #0

		Finish:

		stx Cell



		rts
	}

	FrameUpdate: {

		lda GRID.Falling
		bne Finish

		lda GRID.GravityTimer
		cmp #2
		bcs Finish

		jsr CheckValid
		jsr CheckFire
		jsr Control
		jsr UpdateSprite

		lda Cell
		sta PreviousCell


		Finish:

		rts
	}


	CheckFire: {

		ldy #1

		lda INPUT.JOY_FIRE_NOW, y
		beq NotHolding


		HoldingFire:

			ldx Cell
			lda GRID.Cells, x
			beq NotHolding

			sta Selected

			jsr JOIN.CheckCellFixed
			bcs NotHolding

			rts

		NotHolding:

			lda #255
			sta Selected



		rts
	}


	Move: {

		ldy #1

		CheckUp:

			lda Cell
			cmp #NUM_COLS
			bcc CheckDown

			lda INPUT.JOY_UP_NOW, y
			beq CheckDown

			lda Cell
			sec
			sbc #NUM_COLS
			tax

			lda GRID.Cells, x
			beq CheckLeft

			stx Cell

			lda #CooldownTime
			sta Cooldown

			rts
		
		CheckDown:


			lda Cell
			cmp #(NUM_COLS * (NUM_ROWS - 1))
			bcs CheckLeft

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckLeft

			lda Cell
			clc
			adc #NUM_COLS
			tax

			lda GRID.Cells, x
			beq CheckLeft

			stx Cell

			lda #CooldownTime
			sta Cooldown
			
			rts


		CheckLeft:


			lda Cell
			beq CheckRight

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			ldx Cell

		LeftLoop:

			dex
			bmi Finish

			ldy GRID.Cells, x
			beq LeftLoop

			stx Cell

			lda #CooldownTime
			sta Cooldown

			rts

		CheckRight:

			lda Cell
			cmp #(NUM_COLS * NUM_ROWS) - 1
			beq Finish

			lda INPUT.JOY_RIGHT_NOW, y
			beq Finish

			ldx Cell

		RightLoop:

			inx
			cpx #(NUM_COLS * NUM_ROWS)
			beq Finish

			ldy GRID.Cells, x
			beq RightLoop

			stx Cell

			lda #CooldownTime
			sta Cooldown


		Finish:





		rts
	}



	MoveUp: {

		lda #CooldownTime
		sta Cooldown

		lda Cell
		sta ZP.ClearID
		sec
		sbc #NUM_COLS
		sta ZP.CombineID
		tax

		lda GRID.Cells, x
		beq SpaceUp

		cmp Selected
		bne Blocked

	Combine:

		lda #255
		sta Selected

		lda Cell
		sec
		sbc #NUM_COLS
		sta Cell

		jmp BOX.Combine

	Blocked:	

		rts

	SpaceUp:

		ldx Cell

		jsr BOX.Clear

		ldx Cell
		lda GRID.Cells, x
		pha
		txa
		sec
		sbc #NUM_COLS
		tax
		stx ZP.CurrentID
		pla
		sta GRID.Cells, x
		
		ldx Cell

		lda #0
		sta GRID.Cells, x
		sta GRID.Offset, x

		lda Cell
		sec
		sbc #NUM_COLS
		sta Cell

		ldx Cell
		jsr BOX.Draw


		rts

	}	


	MoveDown: {

		lda #CooldownTime
		sta Cooldown


		
		lda Cell
		sta ZP.ClearID
		clc
		adc #NUM_COLS
		sta ZP.CombineID
		tax

		lda GRID.Cells, x
		beq SpaceDown

		cmp Selected
		bne Blocked

	Combine:

		lda #255
		sta Selected

		lda Cell
		clc
		adc #NUM_COLS
		sta Cell

		jmp BOX.Combine

	Blocked:	

		rts

	SpaceDown:

		ldx Cell

		jsr BOX.Clear

		ldx Cell
		lda GRID.Cells, x
		pha
		txa
		clc
		adc #NUM_COLS
		tax
		stx ZP.CurrentID
		pla
		sta GRID.Cells, x
		
		ldx Cell

		lda #0
		sta GRID.Cells, x
		sta GRID.Offset, x

		lda Cell
		clc
		adc #NUM_COLS
		sta Cell

		ldx Cell
		jsr BOX.Draw


		rts
	}


	MoveLeft: {

		lda #CooldownTime
		sta Cooldown

		ldx Cell
		stx ZP.ClearID
		dex
		stx ZP.CombineID

		lda GRID.Cells, x
		beq SpaceLeft

		cmp Selected
		bne Blocked

	Combine:

		lda #255
		sta Selected

		dec Cell

		jmp BOX.Combine

	Blocked:	

		rts

	SpaceLeft:

		ldx Cell

		jsr BOX.Clear

		ldx Cell
		lda GRID.Cells, x
		dex
		stx ZP.CurrentID
		sta GRID.Cells, x
		inx

		lda #0
		sta GRID.Cells, x
		sta GRID.Offset, x

		dec Cell

		ldx Cell
		jsr BOX.Draw


		rts
	}


	MoveRight: {

		lda #CooldownTime
		sta Cooldown

		ldx Cell
		stx ZP.ClearID
		inx
		stx ZP.CombineID

		lda GRID.Cells, x
		beq SpaceRight

		cmp Selected
		bne Blocked

	Combine:

		lda #255
		sta Selected

		inc Cell

		jmp BOX.Combine


	Blocked:

		rts

	SpaceRight:

		ldx Cell

		jsr BOX.Clear

		ldx Cell
		lda GRID.Cells, x
		inx
		stx ZP.CurrentID
		sta GRID.Cells, x
		dex

		lda #0
		sta GRID.Cells, x
		sta GRID.Offset, x

		inc Cell

		ldx Cell
		jsr BOX.Draw

		rts
	}


	Control: {	

		lda GRID.GravityTimer
		cmp #2
		bcc Okay

		rts

		Okay:

		lda Cooldown
		beq Ready

			dec Cooldown
			rts

		Ready:

			lda Selected
			bpl GotOne

			jmp Move

		GotOne:

		
		ldy #1

		CheckUp:

			ldx Cell
			lda GRID.Row, x
			beq CheckDown

			lda INPUT.JOY_UP_NOW, y
			beq CheckDown

			jmp MoveUp

		
		CheckDown:


			ldx Cell
			lda GRID.Row, x
			cmp #NUM_ROWS - 1
			beq CheckLeft

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckLeft

			jmp MoveDown


		CheckLeft:


			ldx Cell
			lda GRID.Column, x
			beq CheckRight

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			jmp MoveLeft


		CheckRight:

			ldx Cell
			lda GRID.Column, x
			cmp #NUM_COLS - 1
			beq Finish

			lda INPUT.JOY_RIGHT_NOW, y
			beq Finish

			jmp MoveRight

		
		Finish:



		rts
	}

	UpdateSprite: {

		ldx Cell
		lda GRID.CharY, x
		asl
		asl
		asl
		clc
		adc #50
		sta VIC.SPRITE_0_Y
		clc
		adc #21
		sta VIC.SPRITE_1_Y

		lda GRID.CharX, x
		asl
		asl
		asl
		clc
		adc #24
		sta VIC.SPRITE_0_X
		sta VIC.SPRITE_1_X


		lda Selected
		bmi DoWhite


	Coloured:

		lda ZP.Counter
		and #%00000011
		bne Finish

		inc VIC.SPRITE_COLOR_0
		inc VIC.SPRITE_COLOR_1
		rts

	DoWhite:

		lda #WHITE
		sta VIC.SPRITE_COLOR_0
		sta VIC.SPRITE_COLOR_1


	Finish:


		rts
	}

	

}