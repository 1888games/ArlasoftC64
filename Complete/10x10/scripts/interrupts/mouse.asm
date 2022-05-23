MOUSE:{

	.label MouseSpriteIndex = 1

	MouseX_LSB:	.byte 50
	MouseX_MSB: .byte 0
	MouseY:		.byte 100

	MoveSpeed: .byte 2


	.label MinX = 25
	.label MaxX = 43
	.label MinY = 82
	.label MaxY = 230

	MouseFireX: .byte 0
	MouseFireY: .byte 0

	Adjust:		.byte 0
	AddColumns: .byte 0


	.label PointerFrame = 17
	.label MaxSpeed = 7

	AnyMovement:	.byte 0


	Initialise: {

		lda #PointerFrame
		sta SPRITE_POINTERS

		lda #WHITE
		sta VIC.SPRITE_COLOR_0

		lda #BLACK
		sta VIC.SPRITE_COLOR_1
		sta VIC.SPRITE_COLOR_2
		sta VIC.SPRITE_COLOR_3
		sta VIC.SPRITE_COLOR_4
		sta VIC.SPRITE_COLOR_5
		sta VIC.SPRITE_COLOR_6
		

		rts

	}

	SetPosition: {

		lda MouseX_LSB
		sta VIC.SPRITE_0_X

		lda MouseY
		sta VIC.SPRITE_0_Y

		lda MouseX_MSB
		beq MSBOff

		lda VIC.SPRITE_MSB
		ora PIECE.MSB_On
		sta VIC.SPRITE_MSB
		jmp Finish

		MSBOff:

		lda VIC.SPRITE_MSB
		and PIECE.MSB_Off
		sta VIC.SPRITE_MSB


		Finish:

		rts


	}




	
	Update: {

			
		lda #0
		sta AnyMovement

		lda MAIN.GameActive
		bne Okay

		rts

		Okay:

		lda MoveSpeed
		cmp #MaxSpeed
		bcs NoIncrease

		inc MoveSpeed

		NoIncrease:


		lda #ZERO
		sta MouseFireX
		sta MouseFireY

		ldy #1

		CheckLeft:
	
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda #1
			sta AnyMovement

			lda MouseX_LSB
			sec
			sbc MoveSpeed
			sta MouseX_LSB

			lda MouseX_MSB
			sbc #00
			sta MouseX_MSB

			lda MouseX_MSB
			bne CheckDown

			CheckLeftEdge:

				lda MouseX_LSB
				cmp #MinX
				bcs CheckDown

				lda #MinX
				sta MouseX_LSB

				jmp CheckDown


		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda #1
			sta AnyMovement

			lda MouseX_LSB
			clc
			adc MoveSpeed
			sta MouseX_LSB

			lda MouseX_MSB
			adc #00
			sta MouseX_MSB

			lda MouseX_MSB
			beq CheckDown

			CheckRightEdge:

				lda MouseX_LSB
				cmp #MaxX
				bcc CheckDown

				lda #MaxX
				sta MouseX_LSB

				jmp CheckDown

		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			lda #1
			sta AnyMovement


			lda MouseY
			clc
			adc MoveSpeed

			cmp #MaxY
			bcc DownOkay

			lda #MaxY

			DownOkay:

			sta MouseY

			jmp CheckFire

		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq CheckFire

			lda #1
			sta AnyMovement

			lda MouseY
			sec
			sbc MoveSpeed

			cmp #MinY
			bcs UpOkay

			lda #MinY

			UpOkay:


			sta MouseY

		CheckFire:

			jsr CheckFirePosition

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq NoFire

			jsr CheckSelectPiece


		NoFire:

		jsr SetPosition

		lda AnyMovement
		bne MouseMoving

		lda #2
		sta MoveSpeed


		MouseMoving:
	
	//	dec $d020

		rts




	}


	CheckSelectPiece: {


		lda MouseFireX
		cmp #20
		bcc WithinGrid

		lda MouseFireY
		cmp #6
		bcs NotRow1

		ldx #0
		jmp CheckPieceAvailable

		NotRow1:

			cmp #13
			bcs NotRow2

			ldx #1
			jmp CheckPieceAvailable

		NotRow2:

			ldx #2

		CheckPieceAvailable:

			lda SELECTION.Pieces, x
			cmp #99
			beq Finish



			pha
			txa
			pha

			jsr SELECTION.DeselectPiece

			pla
			tax
			pla
			tay

			pha

			jsr SELECTION.SelectPiece

			pla
			tax
			jsr PIECE.SelectNewPiece

		
			sfx(4)

			jmp Finish


		WithinGrid:

			lda PIECE.SelectedPieceID
			cmp #99
			beq Finish

			jsr GRID.PlacePiece
			jmp Finish

	

		Finish:

		rts
	}

	


	CheckFirePosition: {

		lda MOUSE.MouseY
		and #%11110000		
		sec
		sbc #51
		lsr
		lsr
		lsr

		sta MouseFireY

		//jsr SCORE.Set

	

		lda #0
		sta Adjust

		lda #28
		sta AddColumns

		lda MouseX_MSB
		bne NoAdjust

		lda #24
		sta Adjust

		lda #0
		sta AddColumns

		NoAdjust:

		lda MouseX_LSB
		sec
		sbc Adjust

		lsr
		lsr
		lsr

		clc
		adc AddColumns


		sta MouseFireX

		
		//jsr SCORE.Set

		rts
	}



	



}