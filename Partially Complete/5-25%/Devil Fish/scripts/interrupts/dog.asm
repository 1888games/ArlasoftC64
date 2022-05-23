DOG: {



	AnimationID:		.byte 0 
	State:				.byte 0			// 0 = Normal, 1 = Red, 2 = Dead 
	FrameID:			.byte 0
	StartFrameID:		.byte 0
	EndFrameID:			.byte 0
	FrameCounter:		.byte 0, 3

	.label Normal = 0
	.label Red = 1
	.label Dead = 2
	.label DeadAnimationID = 9 

	.label MinX = 0
	.label MaxX = 244
	.label MinY = 51
	.label MaxY = 228


	XPos_SubPixel:		.byte 0
	YPos_SubPixel:		.byte 0

	XPos:				.byte 100
	YPos:				.byte 100

	FirePosX:			.byte 0
	FirePosY:			.byte 0

	MoveSpeed:			.byte 160


	Reset: {

		lda #YELLOW
		sta VIC.SPRITE_COLOR_0

		lda #64
		sta FrameID
		sta StartFrameID

		lda #70
		sta EndFrameID

		lda #120
		sta XPos

		lda #203
		sta YPos

		lda FrameCounter + 1
		sta FrameCounter

		lda VIC.SPRITE_PRIORITY
		ora #%00000001
		sta VIC.SPRITE_PRIORITY

		rts

	}


	Update: {


		jsr Control
		jsr NextFrame
		jsr Draw

	}




	Control: {


		lda #ZERO
		sta FirePosX
		sta FirePosY

		ldy #1

		CheckLeft:
	
			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda XPos_SubPixel
			sec
			sbc MoveSpeed
			sta XPos_SubPixel

			lda XPos
			sbc #00
			sta XPos

			bcs NoWrap

			lda #MaxX
			sta XPos

			NoWrap:

			jmp CheckDown

		
		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckDown

			lda XPos_SubPixel
			clc
			adc MoveSpeed
			sta XPos_SubPixel

			lda XPos
			adc #00
			sta XPos

			cmp #MaxX
			bcc NoWrapRight

			lda #MinX
			sta XPos

			NoWrapRight:

			jmp CheckDown

		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckUp

			lda YPos_SubPixel
			clc
			adc MoveSpeed
			sta YPos_SubPixel

			lda YPos
			adc #00
			sta YPos
			
			CheckDownEdge:

				lda YPos
				cmp #MaxY
				bcc CheckFire

				lda #MaxY
				sta YPos

				jmp CheckFire


		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq CheckFire


			lda YPos_SubPixel
			sec
			sbc MoveSpeed
			sta YPos_SubPixel

			lda YPos
			sbc #00
			sta YPos

			CheckUpEdge:

				lda YPos
				cmp #MinY
				bcs CheckFire

				lda #MinY
				sta YPos

				jmp CheckFire

		CheckFire:

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq NoFire

			jsr CheckFirePosition


		NoFire:

		rts



	}

	CheckFirePosition: {


		lda YPos
		sec
		sbc #50
		lsr
		lsr
		lsr

		sta FirePosY

		//jsr SCORE.Set

		.label Adjust = TEMP2
		.label AddColumns = TEMP3

		lda #0
		sta Adjust

		lda #28
		sta AddColumns

		
		lda #24
		sta Adjust

		lda #0
		sta AddColumns

		NoAdjust:

			lda XPos
			sec
			sbc Adjust

			lsr
			lsr
			lsr

			clc
			adc AddColumns

			sta FirePosX

		//jsr SCORE.Set

		rts
	}


	NextFrame: {

		lda FrameCounter
		beq MoveToNextFrame

		dec FrameCounter
		jmp Finish

		MoveToNextFrame:


			lda FrameCounter + 1
			sta FrameCounter

			lda FrameID
			clc
			adc #01
			cmp EndFrameID
			bne StoreNewFrameID

			ResetFrameID:

				lda StartFrameID

		StoreNewFrameID:

			sta FrameID

		Finish:

			rts
	}

	
	Draw: {

		lda FrameID
		sta SPRITE_POINTERS


		lda XPos
		sta VIC.SPRITE_0_X

		lda #0
		sta VIC.SPRITE_MSB

		lda YPos
		sta VIC.SPRITE_0_Y




		rts



	}


}