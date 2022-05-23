

DOOR: {


	.label NUM_DOORS = 8

	Direction:	.byte LEFT, RIGHT, LEFT, RIGHT, LEFT, RIGHT, LEFT, RIGHT

	Speed:		.byte 2, 3, 2, 1, 4, 4, 2, 2
	Char:		.byte 28, 16, 28, 17, 27, 17, 6, 9
	Offset:		.byte 3, 1, 1, 2, 2, 2, 2, 1


	Rows:		.byte 5, 7, 9, 11, 13, 15, 17, 19

	LeftOffsetChar:		.byte 0, 16, 15, 14
	RightOffsetChar:	.byte 7, 19, 18, 17

	StartChar:		.byte 5, 7, 14, 16, 19, 27, 27, 33


	.label FullCharID = 7
	.label EmptyCharID = 0
	.label MinColumn = 5
	.label MaxColumn = 33
	.label LastDrawableColumn = 34

	.label SlowSpeed = 160

	.label HighSpeed = 290

	.label VerySpeed = 120


	FrameSpeed_MSB:		.byte >SlowSpeed, >HighSpeed, >SlowSpeed, >VerySpeed, >HighSpeed, >HighSpeed, >VerySpeed, >VerySpeed
	FrameSpeed_LSB:		.byte <SlowSpeed, <HighSpeed, <SlowSpeed, <VerySpeed, <HighSpeed, >HighSpeed, <VerySpeed, <VerySpeed
	Progress_MSB:		.fill NUM_DOORS, 0
	Progress_LSB:		.fill NUM_DOORS, 0


	Reset: {



		jsr CloseDoors
		jsr SetDoorStart



		rts
	}


	SetDoorStart: {

		ldx #0
		

		Loop:	

			lda StartChar, x
			sta Char, x

			stx ZP.CurrentID

			jsr DrawDoor

			ldx ZP.CurrentID
			inx
			cpx #NUM_DOORS
			bcc Loop





		rts
	}

	CloseDoor: {

		jsr GetDoorAddress

		lda #FullCharID
		ldy #0
		sta (ZP.ScreenAddress), y

		iny
		sta (ZP.ScreenAddress), y

		ldx ZP.CurrentID

		lda Char, x
		cmp #MaxColumn
		bcs NotThisColumn

		iny
		lda #FullCharID
		sta (ZP.ScreenAddress), y

		NotThisColumn:


		rts



	}

	FrameUpdate: {


		ldx #0

		Loop:

			stx ZP.CurrentID

			jsr UpdateProgress
			jsr ProcessDoor

			ldx ZP.CurrentID
			inx
			cpx #NUM_DOORS
			bcc Loop

		rts
	}


	UpdateProgress: {

		lda #0
		sta Progress_MSB, x

		lda Progress_LSB, x
		clc
		adc FrameSpeed_LSB, x
		sta Progress_LSB, x

		lda Progress_MSB, x
		adc FrameSpeed_MSB, x
		sta Progress_MSB, x

		rts


	}

	ProcessDoor: {

		lda Direction, x
		bne GoingRight

		GoingLeft:

			lda Offset, x
			sec
			sbc Progress_MSB, x
			sta Offset, x
			bcs NoWrap

		NextCharLeft:

			lda Char, x
			cmp #MinColumn
			bne NoReverseLeft

		ReverseLeft:

			lda #RIGHT
			sta Direction, x
			jmp GoingRight

		NoReverseLeft:

			jsr CloseDoor

			ldx ZP.CurrentID

			dec Char, x

			lda Offset, x
			clc
			adc #4
			sta Offset, x

		
		NoWrap:

			jmp DrawDoor


		GoingRight:

			lda Offset, x
			clc
			adc Progress_MSB, x
			sta Offset, x
			cmp #4
			bcc NoWrapRight

		NextCharRight:

			lda Char, x
			cmp #MaxColumn
			bcc NoReverseRight

		ReverseRight:

			lda #LEFT
			sta Direction,x
			jmp GoingLeft

		NoReverseRight:

			jsr CloseDoor

			ldx ZP.CurrentID

			inc Char, x

			lda Offset, x
			sec
			sbc #4
			sta Offset, x

		
		NoWrapRight:

			jmp DrawDoor



		rts

	}



	GetDoorAddress: {

		lda Rows, x
		tay

		lda Char, x
		tax

		jsr PLOT.GetCharacter

		rts
	}

	DrawDoor: {

		jsr GetDoorAddress

		ldx ZP.CurrentID

		lda Offset, x
		sta ZP.Temp4
		tax
		lda LeftOffsetChar, x
		ldy #0

		sta (ZP.ScreenAddress), y

		iny
		lda #EmptyCharID
		sta (ZP.ScreenAddress), y

		ldx ZP.CurrentID

		lda Char, x
		cmp #MaxColumn
		bcs NotThisColumn

		iny
		ldx ZP.Temp4
		lda RightOffsetChar, x
		sta (ZP.ScreenAddress), y


		NotThisColumn:


		rts
	}


	CloseDoors: {

		ldx #0

		Loop:

			stx ZP.CurrentID

			jsr CloseDoor

			ldx ZP.CurrentID
			inx
			cpx #NUM_DOORS
			bcc Loop


		rts
	}


}