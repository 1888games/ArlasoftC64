.namespace BULLET {



	GetFreeID: {

		ldx #0

		lda BULLET.Frame, x
		bpl CantFire1

		rts

		CantFire1:

		inx
		lda BULLET.Frame,x
		
		rts
	}


	PlayerPixelPosition: {

		lda #0
		sta PosX_MSB, y

		lda PlayerOffsetX, x
		bpl Add

		Subtract:

			lda PLAYER.PosX_LSB
			clc
			adc PlayerOffsetX, x
			sta PosX_LSB, y

			lda PLAYER.PosX_MSB
			sta PosX_MSB, y
			beq NoWrapSub

			lda PosX_LSB, y
			bpl NoWrapSub

			lda PosX_MSB, y
			sec
			sbc #1
			sta PosX_MSB, y

		NoWrapSub:

			jmp DoY

		Add:


			lda PLAYER.PosX_LSB
			clc
			adc PlayerOffsetX, x
			sta PosX_LSB, y


			lda PLAYER.PosX_MSB
			adc #0
			sta PosX_MSB, y

		DoY:

			lda PLAYER.PosY
			clc
			adc PlayerOffsetY, x
			sta PosY, y

			rts

	}

	PlayerCharPosition: {

		DoX:

			lda CharOffsetX_Pos, x
			bne GoRight


		GoLeft:	

			lda PLAYER.CharX
			sec
			sbc CharOffsetX_P, x
			sta CharX, y

			sec
			sbc DirectionLookupX, x
			sta CharX_2, y

			sec
			sbc DirectionLookupX, x
			sta CharX_3, y

			lda PLAYER.OffsetX
			//sbc #0
			sec
			sbc CharOffsetX_Fine_P, x
			sta OffsetX, y

		CheckOffsetLeft:

			bpl NoWrapOffsetLeft
			
			clc
			adc #4
			sta OffsetX, y

			cpy #0
			beq Zero1

			dec CharX + 1
			dec CharX_2 + 1
			dec CharX_3 + 1

			jmp CheckOffsetLeft

			Zero1:

			dec CharX
			dec CharX_2
			dec CharX_3

			jmp CheckOffsetLeft

		NoWrapOffsetLeft:

			jmp DoY


		GoRight:

			lda PLAYER.CharX
			clc
			adc CharOffsetX_P, x
			sta CharX, y

			sec
			sbc DirectionLookupX, x
			sta CharX_2, y

			sec
			sbc DirectionLookupX, x
			sta CharX_3, y

			lda PLAYER.OffsetX
			//adc #0
			clc
			adc CharOffsetX_Fine_P, x
			sta OffsetX, y

		CheckOffsetRight:

			cmp #4
			bcc NoWrapOffsetRight

			sec
			sbc #4
			sta OffsetX, y

			cpy #0
			beq Zero2

			inc CharX + 1
			inc CharX_2 + 1
			inc CharX_3 + 1

			jmp CheckOffsetRight

			Zero2:


			inc CharX
			inc CharX_2
			inc CharX_3

			jmp CheckOffsetRight

		NoWrapOffsetRight:

		DoY:

			lda CharOffsetY_Pos, x
			bne GoDown


		GoUp:

			lda PLAYER.CharY
			sec
			sbc CharOffsetY_P, x
			sta CharY, y

			sec
			sbc DirectionLookupY, x
			sta CharY_2, y

			sec
			sbc DirectionLookupY, x
			sta CharY_3, y

			lda PLAYER.OffsetY
			//sbc #0
			sec
			sbc CharOffsetY_Fine_P, x
			sta OffsetY, y

		CheckOffsetUp:

			lda OffsetY, y
			bpl NoWrapOffsetUp
			
			clc
			adc #4
			sta OffsetY, y

			cpy #0
			beq Zero3

			dec CharY + 1
			dec CharY_2 + 1
			dec CharY_3 + 1

			jmp CheckOffsetUp

			Zero3:


			dec CharY
			dec CharY_2
			dec CharY_3

			jmp CheckOffsetUp

		NoWrapOffsetUp:

			rts


		GoDown:

			lda PLAYER.CharY
			clc
			adc CharOffsetY_P, x
			sta CharY, y

			sec
			sbc DirectionLookupY, x
			sta CharY_2, y

			sec
			sbc DirectionLookupY, x
			sta CharY_3, y

			lda PLAYER.OffsetY
			//adc #0
			clc
			adc CharOffsetY_Fine_P, x
			sta OffsetY, y

		CheckOffsetDown:

			lda OffsetY, y
			cmp #4
			bcc NoWrapOffsetDown

			sec
			sbc #4
			sta OffsetY, y

			cpy #0
			beq Zero4

			inc CharY + 1
			inc CharY_2 + 1
			inc CharY_3 + 1

			jmp CheckOffsetDown

			Zero4:


			inc CharY
			inc CharY_3
			inc CharY_2

			jmp CheckOffsetDown

		NoWrapOffsetDown:




		rts
	}


	FirePlayer: {

		* = * "FirePlayer"

		lda #255
		sta IDThatFired

		ldy ZP.BulletID
	
		ldx FIRE.Frame
		lda FrameLookup, x
		clc
		adc #StartPlayerPointer
		sta SpritePointer, y
		sta Frame, y

		lda IsDiagonal, x
		sta Diagonal, y
		beq Flat


		Diag:

			lda #PixelSpeed_Diag
			sta BulletSpeed_Pixel, y

			lda #FracSpeed_Diag
			sta BulletSpeed_Frac, y

			jmp DoneDiag


		Flat:

			lda #PixelSpeed
			sta BulletSpeed_Pixel, y

			lda #FracSpeed
			sta BulletSpeed_Frac, y

		DoneDiag:


		lda ROBOT.CurrentColour
		sta SpriteColor, y

		lda DirectionLookupX, x
		sta DirectionX, y

		lda DirectionLookupY, x
		sta DirectionY, y

		lda CollisionOffsetsX, x
		sta CollisionOffsetX, y

		lda CollisionOffsetsY, x
		sta CollisionOffsetY, y

		jsr PlayerPixelPosition
		jsr PlayerCharPosition
	
		lda #127
		sta PosX_Frac, y
		sta PosY_Frac, y


		lda #2
		sta Delay, y

		
	
		rts
	}


	

}