HEAD: {

	.label NUM_ROWS = 9
	.label EMPTY = 255
	.label NUM_HEADS = 4

	RowHead:		.fill NUM_ROWS, EMPTY


	PosX_MSB:	.fill NUM_HEADS, 0
	PosX_LSB:	.fill NUM_HEADS, 0
	PosX_Frac:	.fill NUM_HEADS, 0
	Row:		.fill NUM_HEADS, 0
	Direction:	.byte RIGHT, LEFT, RIGHT, LEFT

	Speed_MSB:	.fill NUM_HEADS, 0
	Speed_LSB:	.fill NUM_HEADS, 0


	SpinProgress:	.byte 0
	SpinTimer:		.byte 5
	CurrentSpin:	.byte 5

	DefaultX:	.byte 73, 133, 193, 253
	DefaultRow:	.byte 1, 3, 5, 7
	DefaultDirection:	.byte RIGHT, LEFT, RIGHT, LEFT

	.label YStart = 76

	RowY:		.fill NUM_ROWS, YStart + (i * 16)

	Colours:		.byte LIGHT_GREEN, CYAN, ORANGE, LIGHT_RED

	.label StartPointer = 17
	.label SpinTime = 3

	.label SlowSpeed = 256 + 100
	.label MediumSpeed = 256 + 200
	.label FastSpeed = 256 + 250

	.label MaxX = 58
	.label MinX = 32

	DirectionX_LSB:	.byte MaxX, MinX
	DirectionX_MSB:	.byte 1, 0


	DefaultSpeeds_LSB:	.byte <SlowSpeed, <SlowSpeed, <MediumSpeed, <FastSpeed
	DefaultSpeeds_MSB:	.byte >SlowSpeed, >SlowSpeed, >MediumSpeed, >FastSpeed


	Reset: {

			
		jsr EmptyRows
		jsr SetupHeads

		lda #SpinTime
		sta SpinTimer
		sta CurrentSpin


		rts
	}

	EmptyRows: {

		ldx #0

		Loop:

			lda #255
			sta RowHead, x


			inx
			cpx #NUM_ROWS
			bcc Loop




		rts
	}

	SetupHeads: {


		ldx #0

		Loop:	



			lda DefaultX, x
			sta PosX_LSB, x

			lda DefaultSpeeds_LSB, x
			sta Speed_LSB, x

			lda DefaultSpeeds_MSB, x
			sta Speed_MSB, x


			lda #0
			sta PosX_MSB, x
			sta PosX_Frac, x

			lda DefaultRow, x
			sta Row, x
			tay

			txa
			sta RowHead, y

			lda RowY, y
			pha

			txa
			asl
			tay
			pla
			sta VIC.SPRITE_0_Y, y

			lda DefaultDirection, x
			sta Direction, x

			lda Colours, x
			sta VIC.SPRITE_COLOR_0, x

			lda #StartPointer
			sta SPRITE_POINTERS, x

			jsr UpdateSprite

			inx
			cpx #NUM_HEADS
			bcc Loop





		rts
	}


	UpdateSprite: {

		txa
		asl
		tay

		lda PosX_LSB, x
		sta VIC.SPRITE_0_X, y
		
		lda PosX_MSB, x
		beq NoMSB

		MSB_On:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On, x
			sta VIC.SPRITE_MSB

			jmp MSB_Done

		NoMSB:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off, x
			sta VIC.SPRITE_MSB


		MSB_Done:


		lda Colours, x
		sta VIC.SPRITE_COLOR_0, x



		rts
	}


	UpdateSpin: {

		lda SpinTimer
		beq Ready

		dec SpinTimer
		rts


		Ready:

			lda CurrentSpin
			sta SpinTimer

			inc SpinProgress
			lda SpinProgress
			cmp #8
			bcc NoWrap

		Wrap:

			lda #0
			sta SpinProgress


		NoWrap:

			lda #StartPointer
			clc
			adc SpinProgress
			sta SPRITE_POINTERS
			sta SPRITE_POINTERS + 1
			sta SPRITE_POINTERS + 2
			sta SPRITE_POINTERS + 3



		rts
	}

	Process: {

		jsr Move
		jsr UpdateSprite

		rts
	}




	Move: {

		lda Direction, x
		beq GoingLeft


		GoingRight:


			lda PosX_Frac, x
			clc
			adc Speed_LSB, x
			sta PosX_Frac, x

			lda PosX_LSB, x
			adc Speed_MSB, x
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x
			beq NoWrap

			lda PosX_LSB, x
			cmp #MaxX
			bcc NoWrap

			jmp SpawnHead

		NoWrap:

			rts


		GoingLeft:

			lda PosX_Frac, x
			sec
			sbc Speed_LSB, x
			sta PosX_Frac, x

			lda PosX_LSB, x
			sbc Speed_MSB, x
			sta PosX_LSB, x

			lda PosX_MSB, x
			sbc #0
			sta PosX_MSB, x
			bne NoWrapLeft

			lda PosX_LSB, x
			cmp #MinX
			bcs NoWrapLeft

			jmp SpawnHead




		NoWrapLeft:






		rts
	}

	FrameUpdate: {

		jsr UpdateSpin

		ldx #0

		Loop:

			stx ZP.CurrentID


			jsr Process

			ldx ZP.CurrentID
			inx
			cpx #NUM_HEADS
			bcc Loop


		rts
	}



	SpawnHead: {

		.label CurrentRow = ZP.Temp3

		lda Row, x
		sta CurrentRow

		jsr FindAvailableRow

		ldx ZP.CurrentID

		sta Row, x
		pha

		tay
		txa
		sta RowHead, y

		ldy CurrentRow
		lda #255
		sta RowHead, y

		jsr RANDOM.Get
		and #%00000001
		sta Direction, x

		tay
		lda DirectionX_LSB, y
		sta PosX_LSB, x

		lda DirectionX_MSB, y
		sta PosX_MSB, x

		pla
		tay
		lda RowY, y
		pha

		txa
		asl
		tay
		pla
		sta VIC.SPRITE_0_Y, y




		rts
	}

	FindAvailableRow: {


		jsr RANDOM.Get
		and #%00001111
		cmp #9
		bcs FindAvailableRow
		tax

		lda RowHead, x
		bpl FindAvailableRow

		txa



		rts
	}






}