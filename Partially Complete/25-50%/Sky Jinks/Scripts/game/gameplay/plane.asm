PLANE: {



	.label StartPointer = 23
	.label DIR_CENTRE = 0
	.label DIR_LEFT = 1
	.label DIR_RIGHT = 2
	.label PlanePointer = MAX_SPRITES - 5
	.label ShadowPointer = MAX_SPRITES - 4
	.label StartX = 320/2 + 24 - 12
	.label YPosition = 50 + 200 - 50

	Direction:	.byte DIR_CENTRE
	Frame:		.byte 0
	Height:		.byte 12
	Height_Frac:	.byte 0

	PosX_Frac:	.byte 0
	PosX_LSB:	.byte StartX
	PosX_MSB:	.byte 0


	SpeedFrac:		.byte 0
	SpeedPixel:		.byte 0
	TargetHeight:	.byte 0
	Speed:			.byte 0
	TargetHeights:	.byte 12, 16



	.label AddPerFrame = 30
	.label DecreasePerFrame = 45
	.label NoHoldDecrease = 70

	.label MaxSpeedPixel = 2
	.label MaxSpeedFrac = 102

	.label MinX = 24
	.label MaxX = 72

	.label HeightChangeFrame = 80




	Setup: {	

		lda #StartX
		sta PosX_LSB

		lda #0
		sta PosX_MSB
		sta Direction
		sta Frame
		sta Speed

		lda #127
		sta PosX_Frac

		lda #0
		sta Height
		sta Height_Frac

		lda #12
		sta TargetHeight

		lda #StartPointer
		sta SpritePointer + PlanePointer
		sta SpritePointer + ShadowPointer

		lda #YPosition
		sta SpriteY + PlanePointer

		lda #YELLOW
		sta SpriteColor + PlanePointer

		lda #DARK_GRAY
		sta SpriteColor + ShadowPointer



		jsr UpdateSprite


		rts
	}


	Control: {

		ldy #1

		lda Direction
		sta Frame

		lda INPUT.JOY_FIRE_NOW, y
		sta Speed
		tax

		lda TargetHeights, x
		sta TargetHeight

		NoFire:

		lda INPUT.JOY_LEFT_NOW, y
		beq CheckRight

		GoLeft:


			lda Direction
			sta Frame
			cmp #DIR_RIGHT
			beq SlowDownLeft

		JustAdd:

			lda #DIR_LEFT
			sta Direction
	
			jmp AddToSpeed

		SlowDownLeft:

			lda SpeedFrac
			sec
			sbc #DecreasePerFrame
			sta SpeedFrac

			lda SpeedPixel
			sbc #0
			sta SpeedPixel

			bmi Reverse

			jmp NoCheck

		Reverse:

			lda #0
			sta SpeedPixel

			lda SpeedFrac
			eor #%1111111
			adc #1
			sta SpeedFrac

			lda #DIR_LEFT
			sta Direction
			sta Frame

			jmp NoCheck


		CheckSlowDown:

			lda SpeedFrac
			clc
			adc SpeedPixel
			bne SlowDownNoDir

		Stopped:

			lda #0
			sta Direction
			sta SpeedPixel
			sta SpeedFrac

			jmp Finish

		SlowDownNoDir:

			lda #0
			//sta Frame

			lda SpeedFrac
			sec
			sbc #NoHoldDecrease
			sta SpeedFrac

			lda SpeedPixel
			sbc #0
			sta SpeedPixel
			bmi Stopped

			jmp NoCheck

		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckSlowDown

		GoRight:

			lda Direction
			sta Frame
			cmp #DIR_LEFT
			beq SlowDownRight

		JustAddRight:

			lda #DIR_RIGHT
			sta Direction
			sta Frame

			jmp AddToSpeed

		SlowDownRight:

			lda SpeedFrac
			sec
			sbc #DecreasePerFrame
			sta SpeedFrac

			lda SpeedPixel
			sbc #0
			sta SpeedPixel

			bpl NoCheck

			lda #0
			sta SpeedPixel

			lda SpeedFrac
			eor #%1111111
			adc #1
			sta SpeedFrac

			lda #DIR_RIGHT
			sta Direction

			jmp NoCheck


		AddToSpeed:

			lda SpeedFrac
			clc
			adc #AddPerFrame
			sta SpeedFrac

			lda SpeedPixel
			adc #0
			sta SpeedPixel

		ClampSpeed:

			lda SpeedPixel
			cmp #MaxSpeedPixel
			bcc NoCheck

			lda SpeedFrac
			cmp #MaxSpeedFrac
			bcc NoCheck

			lda #MaxSpeedFrac
			sta SpeedFrac


		NoCheck:

			lda Direction
			beq Finish

			cmp #DIR_RIGHT
			beq MoveRight

		MoveLeft:

			lda PosX_Frac
			sec
			sbc SpeedFrac
			sta PosX_Frac

			lda PosX_LSB
			sbc SpeedPixel
			sta PosX_LSB

			lda PosX_MSB
			sbc #0
			sta PosX_MSB
			bne Finish

			lda PosX_LSB
			cmp #MinX
			bcs Finish

			lda #MinX
			sta PosX_LSB

			jmp Finish


		MoveRight:

			lda PosX_Frac
			clc
			adc SpeedFrac
			sta PosX_Frac

			lda PosX_LSB
			adc SpeedPixel
			sta PosX_LSB

			lda PosX_MSB
			adc #0
			sta PosX_MSB
			beq NoWrapRight

			lda PosX_LSB
			cmp #MaxX
			bcc NoWrapRight

			lda #MaxX
			sta PosX_LSB


		NoWrapRight:


		Finish:

		rts
	}


	HeightAdjust: {

		lda Height

			cmp TargetHeight
			beq Finish
			bcc IncreaseHeight

		DecreaseHeight:

			lda Height_Frac
			sec
			sbc #HeightChangeFrame
			sta Height_Frac

			lda Height
			sbc #0
			sta Height
			bne NotOnGround

			lda #0
			sta Height_Frac
			rts


		NotOnGround:

			jmp Finish

		IncreaseHeight:

			lda Height_Frac
			clc
			adc #HeightChangeFrame
			sta Height_Frac

			lda Height
			adc #0
			sta Height



		Finish:



		rts
	}

	FrameUpdate: {


		jsr Control
		jsr HeightAdjust
		jsr UpdateSprite



		rts
	}

	UpdateSprite: {

		lda #StartPointer
		clc
		adc Frame
		sta SpritePointer + PlanePointer
		sta SpritePointer + ShadowPointer



		MainPlane:

			lda Height
			clc
			adc #YPosition
			sta SpriteY + ShadowPointer

			lda PosX_LSB
			sta SpriteX + PlanePointer

		CheckMSB:

			lda PosX_MSB
			beq NoMSB2

		MSB2:

			 lda SpriteColor + PlanePointer
			 ora #%10000000
			 sta SpriteColor + PlanePointer
			 jmp DoShadow

		NoMSB2:

			lda SpriteColor + PlanePointer
			and #%01111111
			sta SpriteColor + PlanePointer



		DoShadow:

			lda Height
			lsr
			sta ZP.Amount
	
			lda PosX_LSB
			clc
			adc ZP.Amount
			sta SpriteX + ShadowPointer

			lda PosX_MSB
			adc #0
			beq NoMSB

		MSB:

			 lda SpriteColor + ShadowPointer
			 ora #%10000000
			 sta SpriteColor + ShadowPointer

			 jmp Finish

		NoMSB:

			lda SpriteColor + ShadowPointer
			and #%01111111
			sta SpriteColor + ShadowPointer


		Finish:



		rts
	}
}