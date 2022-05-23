PLAYER: {



	Jumping:		.byte 0
	OnGround:		.byte 1
	Shooting:		.byte 0
	MovingRight:	.byte 1
	FacingRight:	.byte 1

	Speed_Y_MSB:	.byte 0
	Speed_Y_LSB:	.byte 0
	Speed_X_MSB:	.byte 0
	Speed_X_LSB:	.byte 0

	.label Gravity_MSB = 1
	.label Gravity_LSB = 50
	.label WalkSpeed_MSB = 2
	.label WalkSpeed_LSB = 50

	Pos_X_MSB:	.byte 0
	Pos_X_LSB:	.byte 160
	Pos_Y:		.byte 160


	WalkFrameID:	.byte 0
	WalkTimer:		.byte 0, 6

	SpriteFrame:	.byte 16

	.label ShootFrame = 20
	.label AddIfFacingLeft = 6
	.label WalkFrame = 16




	Reset: {

		lda #1
		sta OnGround

		lda #0
		sta Jumping
		sta Shooting
		sta Speed_X_MSB
		sta Speed_X_LSB
		sta Speed_Y_MSB
		sta Speed_Y_LSB

		lda VIC.SPRITE_MULTICOLOR
		and #%11111100
		ora #%00000010
		sta VIC.SPRITE_MULTICOLOR

		lda #BLUE
		sta VIC.SPRITE_COLOR_1

		lda #WHITE
		sta VIC.SPRITE_COLOR_0

		rts
	}





	Draw: {

		lda Pos_X_LSB
		sta VIC.SPRITE_0_X
		sta VIC.SPRITE_1_X

		lda Pos_Y
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y

		lda Pos_X_MSB
		beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora #%00000011
			sta VIC.SPRITE_MSB
			jmp DoneMSB

		NoMSB:

			lda VIC.SPRITE_MSB
			and #%11111100
			sta VIC.SPRITE_MSB

		DoneMSB:

			lda SpriteFrame
			sta SPRITE_POINTERS
			sta SPRITE_POINTERS + 1
			inc SPRITE_POINTERS


		rts
	}




	HandleJump: {




		rts
	}



	HandleShooting: {





		rts
	}

	HandleWalk: {





		rts
	}


	HandleFall: {




		rts
	}


	ProcessControls: {

		ldy #1

		// CheckLeft:

		// 	lda INPUT.JOY_LEFT_NOW, y
		// 	beq CheckRight

		// 	lda INPUT.JOY_LEFT_LAST, y
		// 	bne CheckDown

		// 	jsr MAP.MoveLeft

		// CheckRight:

		// 	lda INPUT.JOY_RIGHT_NOW, y
		// 	beq CheckDown

		// 	lda INPUT.JOY_RIGHT_LAST, y
		// 	bne CheckDown

		// 	jsr MAP.MoveRight




		rts
	}

	CalculateFrame: {

		
		lda Shooting
		beq NotShooting

		IsShooting:

			lda #ShootFrame
			sta SpriteFrame
			jmp CheckDirection

		NotShooting:

			lda Speed_X_MSB
			clc
			adc Speed_X_LSB
			beq GetWalkFrame

			lda WalkTimer
			beq SwitchFrame

			dec WalkTimer
			jmp GetWalkFrame

			SwitchFrame:

				lda WalkTimer + 1
				sta WalkTimer

				lda WalkFrameID
				beq SwitchTo2

			SwitchTo0:

				lda #0
				sta WalkFrameID
				jmp GetWalkFrame

			SwitchTo2:

				lda #2
				sta WalkFrameID

			GetWalkFrame:

				lda #WalkFrame
				clc
				adc WalkFrameID
				sta SpriteFrame

		CheckDirection:

			lda FacingRight
			bne DontFlip

			lda SpriteFrame
			clc
			adc #AddIfFacingLeft
			sta SpriteFrame

		DontFlip:

		rts
	}

	Update: {	

		jsr CalculateFrame
		jsr Draw
		rts

		jsr ProcessControls

		CheckJumping:

			lda Jumping
			beq NotJumping

			jsr HandleJump
			jmp Finish

		NotJumping:

			lda Shooting
			beq NotShooting

			jsr HandleShooting
			jmp Finish

		NotShooting:

			lda OnGround
			bne NotFalling

			jsr HandleFall
			jmp Finish

		NotFalling:

			jsr HandleWalk

		Finish:


		rts
	}
}