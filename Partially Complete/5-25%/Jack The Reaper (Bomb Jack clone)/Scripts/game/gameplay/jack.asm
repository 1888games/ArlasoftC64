JACK: {


	PosX_Frac:	.byte 0
	PosX_LSB:	.byte 0
	PosY:		.byte 0
	PosY_Frac:	.byte 0
	Facing:		.byte 0
	Frame:		.byte 0
	Grounded:	.byte 0
	Falling:	.byte 0
	FrameTimer:	.byte 0
	Moving:		.byte 0

	YSpeed:		.byte 0
	YSpeed_Frac:	.byte 0
	Cooldown:	.byte 3
	WillJump:	.byte 0
	Landed:		.byte 0




	.label Speed_Pixel_LR = 1
	.label Speed_Frac_LR = 202
	.label GravityPerFrame = 14

	.label Fly_Pixel_LR = 1
	.label Fly_Frac_LR = 90

	.label MinX = 22
	.label MaxX = 222
	.label StartY = 132
	.label StartX = 144
	.label TopY = 47
	.label StartPointer = 17
	.label FrameTime = 4
	.label MaxYSpeed = 4
	.label MaxYSpeed_Frac = 100
	.label BottomY = 232

	.label JumpPixelAdd = 3
	.label JumpFracAdd = 180
	.label FireCooldown = 0

	.label HoldUpAdd = 7
	.label JumpDelay = 6


	.label TopLeftChar = 0
	.label TopMiddleChar = 1
	.label TopRightChar = 2
	.label MiddleLeftChar = 40
	.label MiddleChar = 41
	.label MiddleRightChar = 42
	.label BottomLeftChar = 80
	.label BottomMiddleChar = 81
	.label BottomRightChar = 82
	


	Initialise: {

		lda #17
		sta SPRITE_POINTERS

		lda #0
		sta PosX_Frac
		sta PosY_Frac
		sta Facing
		sta Frame
		sta Grounded

		lda #1
		sta Falling

		lda #StartX
		sta PosX_LSB

		lda #TopY
		sta PosY

		lda #RED
		sta VIC.SPRITE_COLOR_0

		lda #FrameTime
		sta FrameTimer



		rts
	}


	Control: {

		lda #0
		sta Moving

		lda WillJump
		beq NotAboutToJump

		AboutToJump:

			dec WillJump
			beq ReadyToJump	
			rts

		ReadyToJump:

			lda #JumpPixelAdd
			sta YSpeed

			lda #JumpFracAdd
			sta YSpeed_Frac

			lda #0
			sta Falling
			sta Grounded


		NotAboutToJump:

		ldy #1



		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight

			lda #FACING_LEFT
			sta Facing

			inc Moving

			lda Falling
			beq OnGroundLeft

		FallingLeft:

			lda PosX_Frac
			sec
			sbc #Fly_Frac_LR
			sta PosX_Frac

			lda PosX_LSB
			sbc #0
			sec
			sbc #Fly_Pixel_LR
			sta PosX_LSB

			jmp CheckBoundsLeft


		OnGroundLeft:

			lda PosX_Frac
			sec
			sbc #Speed_Frac_LR
			sta PosX_Frac

			lda PosX_LSB
			sbc #0
			sec
			sbc #Speed_Pixel_LR
			sta PosX_LSB

		CheckBoundsLeft:

			cmp #MinX
			bcc HitBoundsLeft
			jmp CheckUp

		HitBoundsLeft:

			lda #MinX
			sta PosX_LSB

			jmp CheckUp

		CheckRight:

			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckUp

			lda #FACING_RIGHT
			sta Facing

			inc Moving

			lda Falling
			beq OnGroundRight

		FallingRight:

			ldy #MiddleRightChar
			lda (ZP.ScreenAddress), y
			tay

			lda CHAR_COLORS, y
			and #%11110000
			beq Air

			cmp #CHAR_SOLID
			bne Air

			jmp CheckUp

		Air:

			ldy #TopRightChar
			lda (ZP.ScreenAddress), y
			tay

			lda CHAR_COLORS, y
			and #%11110000
			beq Air2

			cmp #CHAR_SOLID
			bne Air2


			jmp CheckUp

		Air2:


			ldy #BottomRightChar
			lda (ZP.ScreenAddress), y
			tay

			lda CHAR_COLORS, y
			and #%11110000
			beq Air3

			cmp #CHAR_SOLID
			bne Air3


			jmp CheckUp
			
		Air3:

			lda PosX_Frac
			clc
			adc #Fly_Frac_LR
			sta PosX_Frac

			lda PosX_LSB
			adc #0
			clc
			adc #Fly_Pixel_LR
			sta PosX_LSB

			jmp CheckBoundsRight


		OnGroundRight:

			lda PosX_Frac
			clc
			adc #Speed_Frac_LR
			sta PosX_Frac

			lda PosX_LSB
			adc #0
			clc
		    adc #Speed_Pixel_LR
			sta PosX_LSB

		CheckBoundsRight:

			cmp #MaxX
			bcc CheckUp

			lda #MaxX
			sta PosX_LSB

			jmp CheckUp




		CheckUp:

			ldy #1

			lda Grounded
			bne CheckFire

			lda Falling
			bne CheckFire

			lda INPUT.JOY_UP_NOW, y
			beq CheckFire


		AddToYSpeed:

			lda YSpeed_Frac
			clc
			adc #HoldUpAdd
			sta YSpeed_Frac

			lda YSpeed
			adc #0
			sta YSpeed

		CheckFire:

			lda Cooldown
			beq Ready

			dec Cooldown
			rts

			Ready:

			lda INPUT.FIRE_UP_THIS_FRAME, y
			beq Finish

			lda #FireCooldown
			sta Cooldown

			lda Grounded
			bne Jump

			Stop:

				lda #0
				sta YSpeed_Frac
				sta YSpeed

				lda #1
				sta Falling
				jmp Finish

			Jump:

				lda #JumpDelay
				sta WillJump

				lda #0
				sta Landed


		Finish:


		rts
	}

	UpdateSprite: {

		lda Landed
		beq NotLanded

			lda #28
			sta SPRITE_POINTERS

			dec Landed
			jmp Position

		NotLanded:

			lda WillJump
			beq NotAboutToJump

			lda #28
			clc
			adc Facing
			sta SPRITE_POINTERS
			jmp Position


		NotAboutToJump:

			lda Grounded
			bne OnGround

		InAir:

			lda Falling
			bne IsFalling


		Jumping:

			lda Moving
			beq StraightJump

		JumpMove:

			lda Facing
			clc
			adc #25
			sta SPRITE_POINTERS

			jmp Position




		StraightJump:

			lda #17
			sta SPRITE_POINTERS
			jmp Position

		IsFalling:

			lda Moving
			beq StraightFall

		FallMove:

			lda Facing
			clc
			adc #22
			sta SPRITE_POINTERS
			jmp Position

		StraightFall:

			lda #25
			sta SPRITE_POINTERS
			jmp Position

		OnGround:

			lda Facing
			asl
			clc
			adc Frame
			clc
			adc #StartPointer
			sta SPRITE_POINTERS

		Position:

			lda PosX_LSB
			sta VIC.SPRITE_0_X

			lda PosY
			sta VIC.SPRITE_0_Y


		rts
	}

	UpdateFrame: {

		lda Moving
		beq Finish

		lda FrameTimer
		beq Ready

		dec FrameTimer
		rts

		Ready:

		lda #FrameTime
		sta FrameTimer

		lda Frame
		eor #%00000001
		sta Frame


		Finish:

		rts
	}

	ApplyGravity: {

		lda Grounded
		beq DoYSpeed

		NoFall:

			lda #0
			sta YSpeed
			sta YSpeed_Frac
			rts

		DoYSpeed:

			lda Falling
			bne IncreaseSpeed

		DecreaseSpeed:

			lda YSpeed_Frac
			sec
			sbc #GravityPerFrame
			sta YSpeed_Frac

			lda YSpeed
			sbc #0
			sta YSpeed
			bpl Finish

			lda #0
			sta YSpeed
			sta YSpeed_Frac

			lda #1
			sta Falling
			rts

		IncreaseSpeed:

			lda YSpeed_Frac
			clc
			adc #GravityPerFrame
			sta YSpeed_Frac

			lda YSpeed
			adc #0
			sta YSpeed

			cmp #MaxYSpeed
			bcc Finish


			lda YSpeed_Frac
			cmp #MaxYSpeed_Frac
			bcc Finish

			lda #MaxYSpeed_Frac
			sta YSpeed_Frac

			rts

		Finish:



		rts
	}

	MoveUpDown: {


		lda Grounded
		bne Finish


		lda Falling
		bne GoDown

		GoUp:

			lda PosY_Frac
			sec
			sbc YSpeed_Frac
			sta PosY_Frac

			lda PosY
			sbc #0
			sec
			sbc YSpeed
			sta PosY

			cmp #TopY
			bcs Finish

			lda #TopY
			sta PosY

			lda #1
			sta Falling

			lda #0
			sta YSpeed_Frac
			sta YSpeed

			rts

		GoDown:	

			lda PosY_Frac
			clc
			adc YSpeed_Frac
			sta PosY_Frac

			lda PosY
			adc #0
			clc
			adc YSpeed
			sta PosY

			cmp #BottomY
			bcc Finish

		HitGround:

			lda #BottomY
			sta PosY

			jsr SetGround

	

		Finish:







		rts
	}

	SetGround: {

		lda #1
		sta Grounded

		lda #0
		sta Facing
		sta Frame
		sta Falling

		lda #3
		sta Landed


		rts
	}	



	CheckAbove: {

		lda WillJump
		bne Finish

		ldy #TopMiddleChar
		lda (ZP.ScreenAddress), y
		tay

		CheckMiddleAbove:

			lda CHAR_COLORS, y
			and #%11110000
			beq Air

			cmp #CHAR_SOLID
			bne NotSolid

			lda Grounded
			bne Finish

			lda Falling
			bne Finish

		Stop:

			lda #0
			sta YSpeed_Frac
			sta YSpeed

			lda #1
			sta Falling

		NotSolid:



		Air:




		Finish:

		rts
	}



	CheckBelow: {

		ldy #BottomMiddleChar
		lda (ZP.ScreenAddress), y

		tay

		lda WillJump
		bne Finish

		CheckMiddleBelow:

			lda CHAR_COLORS, y
			and #%11110000
			beq Air

			cmp #CHAR_SOLID
			bne NotSolid

		Solid:

			lda Grounded
			bne Finish

			lda Falling
			beq Finish

			jsr SetGround
			jmp Finish

		Air:

			lda Grounded
			beq Finish


		CheckLeft:

			ldy #BottomLeftChar
			lda (ZP.ScreenAddress), y
			tay

			lda CHAR_COLORS, y
			and #%11110000
			beq AirLeft

			jmp Solid

		AirLeft:

			ldy #BottomRightChar
			lda (ZP.ScreenAddress), y
			tay

			lda CHAR_COLORS, y
			and #%11110000
			beq AirRight

			jmp Solid

		AirRight:

			lda ZP.Row
			cmp #22
			bcs Finish

			lda #1
			sta Falling

			lda #0
			sta Grounded
			sta Frame

			jmp Finish


		NotSolid:


		Finish:





		rts
	}

	CheckLeft: {









		rts
	}

	CheckBounds: {

		lda PosY
		clc
		adc #255
		tay
		lda SpriteYToChar, y
		tay
		sta ZP.Row
		//cpy #24
		//bcs Finish

		lda PosX_LSB
		//clc
		//adc #8
		tax
		lda SpriteXToChar, x
		tax
		sta ZP.Column

		jsr PLOT.GetCharacter

		jsr CheckBelow
		jsr CheckAbove
		jsr CheckLeft



		Finish:

		rts
	}

	FrameUpdate: {

		jsr Control
		jsr CheckBounds
		jsr ApplyGravity
		jsr MoveUpDown
		jsr UpdateFrame
		jsr UpdateSprite





		rts
	}



}