.namespace BULLET { 


	RobotPixelSpeed:		.byte 1, 0
	RobotFracSpeed:			.byte 40, 210

	MaxBullets:				.byte 2


	GetAvailableID: {

		ldx #2

		Loop:

			cpx MaxBullets
			beq Found

			lda Frame, x
			bmi Found

			inx
			jmp Loop


		Found:



		rts
	}

	FireRobot: {

			

		GetID:

			lda MaxBullets
			cmp #3
			bcc Exit


			jsr GetAvailableID

		DoubleCheck:

			cpx MaxBullets
			bne Available
		Exit:

			rts

		Available:

			ldy #S_FIRE_ROBOT
			jsr SPEECH.StartSequence

			lda ZP.X
			tay
			clc
			adc #MAX_BULLETS
			sta IDThatFired, x

			lda ROBOT.Delay
			clc
			adc #8
			sta ROBOT.FireCooldown, y

			dec EnemyBullets

			ldy ROBOT.ShootFrame
			lda FrameLookup, y
			clc
			adc #StartRobotPointer
			sta SpritePointer, x
			sta Frame, x

			


			lda ROBOT.CurrentColour
			sta SpriteColor, x

			ldy ROBOT.ShootFrame

			lda IsDiagonal, y
			sta Diagonal, x

			tay

			lda RobotPixelSpeed, y
			sta BulletSpeed_Pixel, x

			lda RobotFracSpeed, y
			sta BulletSpeed_Frac, x

			ldy ROBOT.ShootFrame

			lda DirectionLookupX, y
			sta DirectionX, x

			lda DirectionLookupY, y
			sta DirectionY, x

			lda CollisionOffsetsX_R, y
			sta CollisionOffsetX, x

			lda CollisionOffsetsY_R, y
			sta CollisionOffsetY, x

			lda #2
			sta Delay, x

			lda #127
			sta PosX_Frac, x
			sta PosY_Frac, x

			

			jsr RobotPixelPosition
			jsr RobotCharPosition

		

		rts
	}





	RobotPixelPosition: {

		lda #0
		sta PosX_MSB, x

		ldy ROBOT.ShootFrame
		

		lda RobotOffsetY, y
		sta ZP.StoredYReg

		lda RobotOffsetX, y
		sta ZP.StoredXReg

		bpl Add

		Subtract:	

			
			ldy ZP.X

			lda ROBOT.PosX_LSB, y
			clc
			adc ZP.StoredXReg
			sta PosX_LSB, x

			lda ROBOT.PosX_MSB, y
			sta PosX_MSB, x
			beq NoWrapSub

			lda PosX_LSB, y
			bpl NoWrapSub

			dec PosX_MSB, x


		NoWrapSub:

			jmp DoY


		Add:

			ldy ZP.X

			lda ROBOT.PosX_LSB, y
			clc
			adc ZP.StoredXReg
			sta PosX_LSB, x

			lda PosX_MSB, x
			adc #0
			sta PosX_MSB, x

		DoY:

			lda ROBOT.PosY, y
			clc
			adc ZP.StoredYReg
			sta PosY, x

			rts


		rts
	}

	RobotCharPosition: {


		.label XChar = ZP.StoredXReg
		.label YChar = ZP.StoredYReg
		.label XOff = ZP.XDiff
		.label YOff = ZP.YDiff

		//.break


		lda ROBOT.CharY, y
		sta YChar

		lda ROBOT.CharX, y
		sta XChar

		lda ROBOT.OffsetX, y
		sta XOff

		lda ROBOT.OffsetY, y
		sta YOff

		ldy ROBOT.ShootFrame
		
		DoX:

			lda CharOffsetX_Pos, y
			bne GoRight


		GoLeft:	
		//	.break

			lda XChar
			sec
			sbc CharOffsetX_R, y
			sta CharX, x

			sec
			sbc DirectionLookupX, y
			sta CharX_2, x

			sec
			sbc DirectionLookupX, y
			sta CharX_3, x

			lda XOff
			//sbc #0
			sec
			sbc CharOffsetX_Fine_R, y
			sta OffsetX, x

		CheckOffsetLeft:

			bpl NoWrapOffsetLeft
			
			clc
			adc #4
			sta OffsetX, x

			dec CharX, x
			dec CharX_2, x
			dec CharX_3, x

			jmp CheckOffsetLeft

		NoWrapOffsetLeft:

			jmp DoY


		GoRight:

			lda XChar
			clc
			adc CharOffsetX_R, y
			sta CharX, x

			sec
			sbc DirectionLookupX, y
			sta CharX_2, x

			sec
			sbc DirectionLookupX, y
			sta CharX_3, x

			lda XOff
			//adc #0
			clc
			adc CharOffsetX_Fine_R, y
			sta OffsetX, x

		CheckOffsetRight:

			cmp #4
			bcc NoWrapOffsetRight

			sec
			sbc #4
			sta OffsetX, x

			inc CharX, x
			inc CharX_2, x
			inc CharX_3, x

			jmp CheckOffsetRight

		NoWrapOffsetRight:

		DoY:

			lda CharOffsetY_Pos_R, y
			bne GoDown


		GoUp:

			lda YChar
			sec
			sbc CharOffsetY_R, y
			sta CharY, x

			sec
			sbc DirectionLookupY, y
			sta CharY_2, x

			sec
			sbc DirectionLookupY, y
			sta CharY_3, x

			lda YOff
			//sbc #0
			sec
			sbc CharOffsetY_Fine_R, y
			sta OffsetY, x

		CheckOffsetUp:

			lda OffsetY, x
			bpl NoWrapOffsetUp
			
			clc
			adc #4
			sta OffsetY, x

			dec CharY, x
			dec CharY_2, x
			dec CharY_3, x

			jmp CheckOffsetUp

		NoWrapOffsetUp:

			rts


		GoDown:

			lda YChar
			clc
			adc CharOffsetY_R, y
			sta CharY, x

			sec
			sbc DirectionLookupY, y
			sta CharY_2, x

			sec
			sbc DirectionLookupY, y
			sta CharY_3, x

			lda YOff
			//adc #0
			clc
			adc CharOffsetY_Fine_R, y
			sta OffsetY, x

		CheckOffsetDown:

			lda OffsetY, x
			cmp #4
			bcc NoWrapOffsetDown

			sec
			sbc #4
			sta OffsetY, x

			inc CharY, x
			inc CharY_3, x
			inc CharY_2, x

			jmp CheckOffsetDown

		NoWrapOffsetDown:

		rts
	}


}