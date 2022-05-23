.namespace ROBOT {

	NewLevel: {

		ldx PLAYER.SpawnSide
		lda SpawnSectors, x
		sta SpawnSector

		jsr ResetData


		lda #0
		sta VIC.SPRITE_ENABLE
		

		ldx #0
	
		stx CurrentMoveRobot

		Loop:

			stx ZP.CurrentID

			jsr Generate

			ldx ZP.CurrentID

			inx
			cpx StartCount
			bcc Loop


		lda #1
		sta Active


		lda #255
		sta VIC.SPRITE_ENABLE

		rts
	}


	ResetData: {

		ldx #0
		ldy #BULLET.MAX_BULLETS

		Loop:

			lda #0
			sta SectorOccupied, x

			cpx #MAX_ROBOTS
			bcs SkipRobot

			lda #0
			sta CharY, x
			sta SpriteY, y
			sta SpriteCopyY, y
			sta SpriteX, y
			

			lda #255
			sta State, x

		SkipRobot:

			inx
			iny
			cpx #15
			bcc Loop


		rts
	}


	CalculateCount: {

		and #%01110000
		lsr
		lsr
		lsr
		lsr
		clc
		adc #MIN_ROBOTS

		//.break
	//lda #1
		sta StartCount
		sta Count

	
		rts
	}


	Generate: {

		// x = robot ID, y = sector

			lda #0
			sta SPEECH.Died

		SectorID:

			jsr RANDOM.Get
			and #%00001111
			cmp #15
			bcs SectorID

			tay
			lda SectorOccupied, y
			bne SectorID

			cpy SpawnSector
			beq SectorID

			lda #1
			sta SectorOccupied, y

			tya
			sta Sector, x

			jsr CalculateBlockedWalls

		XPosition:

			lda SectorCentreX, y
			sta PosX_LSB, x

			lda #0
			sta PosX_MSB, x

			//jmp YPosition

			jsr RANDOM.Get
			and #%00011111
			clc
			adc PosX_LSB, x
			sta PosX_LSB, x

			lda PosX_LSB, x
			sec 
			sbc #16
			sta PosX_LSB, x



		YPosition:

			lda SectorCentreY, y
			sta PosY, x

		//	jmp Sprite

		Again:

			jsr RANDOM.Get
			and #%00111111
			cmp #44
			bcs Again
			sec
			sbc #22
			clc
			adc PosY, x
			sta PosY, x


			jsr CalculateChars

			
		Sprite:	

			txa
			clc
			adc #BULLET.MAX_BULLETS
			sta SpriteID, x

			ldy SpriteID, x

			lda CurrentColour
			sta SpriteColor, y

			lda StartPointers
			sta SpritePointer, y
			sta PointerCopy, y

			lda SpriteX, y
			lda #0
			sta SpriteCopyX, y

			lda SpriteY, y
			lda #0
			sta SpriteCopyY, y

			lda #8
			sta SpriteWidth

			lda #11
			sta SpriteHeight

			jsr UpdateSprite

		Settings:

			lda #ROBOT_THINKING
			jsr ChangeState

			lda FrameSpeeds
			sta FrameSpeed, x
			sta FrameTimer, x

			lda #255
			sta PlayerDiffY
			sta PlayerDiffX

			lda Delay
			

			cmp #25
			bcs Okay

			lda #25

			Okay:

			sta WaitTimer, x



			jsr UpdateSprite
			jsr UpdatePointer



		rts
	}

	

	CalculateChars: {

		.label XReduce = 24
		.label YReduce = 50

		lda #0
		sta CharX, x


		CalcXOffset:


			lda PosX_LSB, x
			lsr
			lsr
			asl
			asl
			sta ZP.RobotID

			lda PosX_LSB, x
			sec
			sbc ZP.RobotID
			sta OffsetX, x

		CheckMSB:

			lda PosX_MSB, x
			beq LSB

		MSB:

			lda #58
			sta CharX, x

			lda PosX_LSB, x
			jmp Calc

		LSB:

			lda PosX_LSB, x
			sec
			sbc #XReduce

		Calc:

			lsr
			lsr
			clc
			adc CharX, x
			sta CharX, x


		DoY:

		
			lda PosY, x
			sec
			sbc #YReduce
			lsr
			lsr
			sta CharY, x
			asl
			asl
			sta ZP.RobotID


			lda PosY, x
			sec
			sbc #YReduce
			sec
			sbc ZP.RobotID
				
			sta OffsetY, x



		rts
	}



}