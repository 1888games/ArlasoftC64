JOIN: {


	.label MAX_JOINS = 4
	.label Chance = 32
	.label LEFT = 0
	.label RIGHT = 1
	.label UP = 2


	YOffset:	.byte 6, 6, -4
	XOffset:	.byte -3, 21, 6
	Pointer:	.byte 29, 29, 30

	Number:		.byte 0

	One:		.fill MAX_JOINS, 255
	Two:		.fill MAX_JOINS, 255
	Direction:	.fill MAX_JOINS, 255



	Reset: {


		lda #255

		ldx #0
		stx Number

		Loop:

			sta One, x

			inx
			cpx #MAX_JOINS * 3
			bcc Loop


		lda #DARK_GRAY
		sta VIC.SPRITE_COLOR_2
		sta VIC.SPRITE_COLOR_3
		sta VIC.SPRITE_COLOR_4
		sta VIC.SPRITE_COLOR_5


		rts




	}


	MoveUp: {

		ldy #0

		Loop:

			lda One, y
			bmi EndLoop

			sec
			sbc #NUM_COLS
			sta One, y

			lda Two, y
			sec
			sbc #NUM_COLS
			sta Two, y

		EndLoop:

			iny
			cpy #MAX_JOINS
			bcc Loop






		rts
	}

	GetFreeID: {

		ldy #0

		Loop:

			lda One, y
			bmi Found

			iny
			cpy #MAX_JOINS
			bcc Loop


		Found:




		rts
	}


	CheckCellFixed: {

		stx ZP.CellID
		// x = Cell ID

		sty ZP.Y

		ldy #0

		Loop:

			lda One, y
			cmp ZP.CellID
			bne NotOne

			lda Two, y
			sta ZP.Joined

			jmp Return

		NotOne:

			lda Two, y
			cmp ZP.CellID
			bne EndLoop

			lda One, y
			sta ZP.Joined

		Return:

			ldy ZP.Y

			sec
			rts

			EndLoop:

			iny
			cpy #MAX_JOINS
			bcc Loop


		ldy ZP.Y
		clc

		rts
	}

	CheckAdd: {

		CheckAvailable:

			lda Number
			cmp #MAX_JOINS
			beq Finish

		CheckChance:

			jsr RANDOM.Get

			cmp #Chance
			bcs Finish



		WillAdd:

			jsr GetFreeID

			ldx ZP.CurrentID
			//tya
			//sta GRID.Fixed, x

			txa
			sec
			sbc #NUM_COLS
			tax

			lda GRID.Cells, x
			beq GoRight

			jsr CheckCellFixed
			bcs Finish

			jsr RANDOM.Get
			cmp #128
			bcc GoRight

		GoUp:

			lda #UP
			sta Direction, y

			jmp StoreData
			
		GoRight:

			lda #RIGHT
			sta Direction, y

			ldx ZP.CurrentID
			lda GRID.Column, x
			inx
			cmp #NUM_COLS - 1
			bcc StoreData

			lda #LEFT
			sta Direction, y

			dex
			dex

		StoreData:

			txa
			sta Two, y

			lda ZP.CurrentID
			sta One, y

			inc Number

			lda #2
			sta GRID.FixedThisRow





		Finish:

		rts
	}

	CheckBreak: {




		ldy #0

		Loop:
			lda One, y
			bmi EndLoop

			cmp ZP.CombineID
			bne NotThisOne

			
			lda Two, y
			tax

			lda #255
			sta Two, y
			sta One, y

			dec Number
			
			rts

		NotThisOne:

			lda Two, y
			cmp ZP.CombineID
			bne EndLoop
		
			lda One, y
			tax

			lda #255
			sta One, y
			sta Two, y

			dec Number

			rts

		EndLoop:

			iny
			cpy #MAX_JOINS
			bcc Loop

		rts




	}


	FindToFall: {

		sta ZP.Amount

		ldy #0

		Loop:

			lda One, y
			bmi EndLoop

			cmp ZP.Amount
			bne NotThisOne

			clc
			adc #NUM_COLS
			sta One, y

			rts
		NotThisOne:

			lda Two, y
			cmp ZP.Amount
			bne EndLoop

			clc
			adc #NUM_COLS
			sta Two, y

			rts


		EndLoop:

			iny
			cpy #MAX_JOINS
			bcc Loop



		rts
	}


	Process: {

		lda One, y
		bpl IsJoined

		NotJoined:


			lda #16
			sta SPRITE_POINTERS + 2, y

			tya
			asl
			tay

			lda #0
			sta VIC.SPRITE_2_Y, y


			rts

		IsJoined:	


			sta ZP.CellID

		GetY:

			lda Direction, y
			tay
			lda YOffset, y
			sta ZP.Y

		GetX:

			lda XOffset, y
			sta ZP.X

		GetPointer:

			lda Pointer, y
			ldy ZP.CurrentID
			sta SPRITE_POINTERS + 2, y

		MultBy2:

			tya
			asl
			tay

			ldx ZP.CellID
			
			lda GRID.CharX, x
			asl
			asl
			asl
			clc
			adc #24
			clc
			adc ZP.X
			sta VIC.SPRITE_2_X, y

			lda GRID.CharY, x
			asl
			asl
			asl
			clc
			adc #50
			clc
			adc ZP.Y
			sta VIC.SPRITE_2_Y, y







		rts
	}


	FrameUpdate: {

		ldy #0

		Loop:	

			sty ZP.CurrentID

			jsr Process


		EndLoop:

			ldy ZP.CurrentID
			iny
			cpy #MAX_JOINS
			bcc Loop




		rts
	}







}