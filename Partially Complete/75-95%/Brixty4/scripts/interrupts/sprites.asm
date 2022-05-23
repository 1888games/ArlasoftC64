SPRITES:{

	XPosLSB: 	.byte 0, 0, 0, 0, 0, 0, 0, 0
	YPos: 		.byte 0, 0, 0, 0, 0, 0, 0, 0
	XPosMSB: 	.byte 0, 0, 0, 0, 0, 0, 0, 0
	ObjectType: .byte 0, 0, 0, 0, 0, 0, 0, 0
	ObjectID: 	.byte 0, 0, 0, 0, 0, 0, 0, 0
	Frame: 		.byte 6, 2, 4, 1, 5, 3, 7, 0
	YSpeed:		.byte 0, 0, 0, 0, 0, 0, 0, 0
	YCounter:	.byte 0, 0, 0, 0, 0, 0, 0, 0


	MSBFlagsOn: 	.byte 1, 2, 4, 8, 16, 32, 64, 128
	MSBFlagsOff:	.byte 254, 253, 251, 247, 239, 223,191, 127

	FrameCounter: .byte 0

	// 0 = Sniffable    1 = Enemy   2 = powerup
	ObjectTypes: .byte 0, 0, 0, 1
	ObjectColours: .byte 7, 15, 2, 1

	.label StartOfSmells = 0
	.label StartOfEnemies = 4
	.label StartOfPowerups = 4
	.label MaxYSpeed = 1
	.label FramesPerFrame = 4
	.label StartChanceOfSprite = 5
	.label MaxChanceOfSprite = 6

	ChanceOfNewSprite: 	.byte 25
	Cooldown: .byte 10

	.label FramesPerSpeed = 80
	.label ChanceOfSmell = 120 // less than
	.label ChanceOfPowerup = 245 // more than
	.label CooldownSet = 10




	Reset: {

		.label SpriteIndex = TEMP1

		lda #StartChanceOfSprite
		sta ChanceOfNewSprite

		lda #255
		sta VIC.SPRITE_MULTICOLOR

		lda #3
		sta VIC.SPRITE_MULTICOLOR_2

		ldx #ZERO
		stx VIC.SPRITE_MULTICOLOR_1
		stx Cooldown



		Loop:	

			stx SpriteIndex

			txa
			asl
			tax
			lda #255
			sta VIC.SPRITE_0_Y, x

			ldx SpriteIndex
			sta YPos, x


			lda #0
			sta YSpeed, x
			sta YCounter, x
			
		
			inx
			cpx #8
			beq Finish

			jmp Loop

		Finish:


		jsr GetFirstAvailableSprite
		jsr DecideWhatToDrop

		lda #CooldownSet
		sta Cooldown


		rts

		
	}


	GetFirstAvailableSprite: {


		ldx #ZERO


		Loop:

			lda YPos, x
			cmp #250
			bcs Finish

			inx
			cpx #8
			beq Finish

			jmp Loop


		Finish:

			rts



	}


	UpdateSpritePointer: {

		.label FrameID = TEMP3

		lda Frame, x
		sta FrameID

		lda ObjectID, x
		asl
		asl
		asl // x = 0, 8, 16, 24, 32, 40, 48, 56
		clc
		adc #64
		clc
		adc FrameID

		sta SPRITE_POINTERS, x


		rts
	}

	DecideWhatToDrop: {

		.label SpriteID = TEMP5
		stx TEMP5

		cpx #8
		bne DontFinish

		jmp NoSprite

		DontFinish:

		pha
		txa
		asl
		tay
		pla

		lda #25
		sta VIC.SPRITE_0_Y, y
		sta YPos, x

		lda #ONE
		sta YSpeed, x

		jsr MAIN.Random
		cmp #190
		bcc NormalSpeed

		lda #2
		sta YSpeed, x

		NormalSpeed:

		lda #FramesPerSpeed
		sta YCounter, x

		jsr MAIN.Random

		clc
		adc #75
		sta XPosLSB, x
		sta VIC.SPRITE_0_X, y   

		lda #ZERO
		adc #0
		sta XPosMSB, x

		cmp #0
		beq NoMSB

		MSB:

			.label FlagOn = TEMP2

			lda MSBFlagsOn, x
			sta FlagOn

			lda VIC.SPRITE_MSB
			ora FlagOn
			sta VIC.SPRITE_MSB

			jmp ChooseType

		NoMSB:

			.label FlagOff = TEMP2

			lda MSBFlagsOff, x
			sta FlagOff

			lda VIC.SPRITE_MSB
			and FlagOff
			sta VIC.SPRITE_MSB


		ChooseType:


		jsr MAIN.Random

		cmp #ChanceOfSmell
		bcc GenerateSmell

		cmp #ChanceOfPowerup
		bcs GeneratePowerup


		GenerateEnemy:

			lda #3
			sta ObjectType, x

			// jsr MAIN.Random
			// cmp #120
			// bcc Cheese

			// cmp #200
			// bcs Fish

			// Sock:
			// 	lda #2
			// 	jmp GetObject

			// Fish:

			// 	lda #1
			// 	jmp GetObject

			// Cheese:	
			// 	lda #0
				
			// GetObject:

			sta ObjectID, x
			jsr UpdateSpritePointer
	

			jmp Finish
			
			


		GenerateSmell:

			lda #0
			sta ObjectType, x

			jsr MAIN.Random
			cmp #120
			bcc Cheese

			cmp #200
			bcs Fish

			Sock:
				lda #2
				jmp GetObject

			Fish:

				lda #1
				jmp GetObject

			Cheese:	
				lda #0
				
			GetObject:

			sta ObjectID, x

			jsr UpdateSpritePointer


			jmp Finish


		GeneratePowerup:

			jmp GenerateSmell

			lda #2
			sta ObjectType, x

			jmp Finish




		Finish:

			lda #CooldownSet
			sta Cooldown

			lda ObjectID, x
			tay
			lda ObjectColours, y
			sta VIC.SPRITE_COLOR_0, x

		NoSprite:

		rts
	}






	Update: {

		dec Cooldown
		lda Cooldown

		cmp #12
		bcc Okay

		lda #ZERO
		sta Cooldown

		Okay:

		lda Cooldown
		bne NoSprite

		jsr MAIN.Random

		cmp ChanceOfNewSprite
		bcs NoSprite

		jsr GetFirstAvailableSprite
		jsr DecideWhatToDrop

		NoSprite:


		jsr UpdatePositions


		rts

	}



	UpdatePositions: {


		inc FrameCounter
		lda FrameCounter

		cmp #FramesPerFrame
		bne DontResetCounter

		lda #ZERO
		sta FrameCounter

		DontResetCounter:
		
		.label SpriteID = TEMP1
		.label YToAdd = TEMP2

		ldx #0

		Loop:

			lda YSpeed, x
			beq EndLoop

			sta YToAdd

			lda FrameCounter
			bne DontUpdateFrame

			lda Frame, x
			clc
			adc #01
			cmp #8
			bne DontReset

			lda #0

			DontReset:

				sta Frame,x
				jsr UpdateSpritePointer

			DontUpdateFrame:

				lda YPos, x
				clc
				adc YToAdd
				sta YPos, x

				pha
				txa
				asl
				tay
				pla

				sta VIC.SPRITE_0_Y, y

			CheckWrap:

				cmp #251
				bcc NoWrap

				lda #ZERO
				sta YSpeed, x
				jmp EndLoop

			NoWrap:

				lda YCounter, x
				bne ReduceCounter

				lda YSpeed, x
				cmp #MaxYSpeed
				bcs EndLoop

				lda #FramesPerSpeed
				sta YCounter, x

				lda YSpeed, x
				clc
				adc #01
				sta YSpeed, x

			ReduceCounter:

				lda YCounter, x
				sec
				sbc #01
				sta YCounter, x

			EndLoop:

				jsr CheckHitSnout

				inx
				cpx #8
				beq Finish
				jmp Loop


		Finish:

			rts
	}



	CheckHitSnout: {

		lda YPos, x
		cmp #180
		bcc Finish

		cmp #200
		bcs Finish

		.label Column = TEMP6

		lda XPosMSB, x
		beq NoMSB

		lda #31
		jmp GetColumn

		NoMSB:

		lda #0

		GetColumn:

		sta Column

		lda XPosLSB, x
		lsr
		lsr
		lsr
		sec
		sbc #4
		clc
		adc Column

		//.break
		sta Column

		ldy SNOUT.NosePosition
		dey
		cpy Column
		bne NoSniff1

		jsr SniffRange

		NoSniff1:

		iny
		cpy Column
		bne NoSniff2

		jsr SniffRange

		NoSniff2:

		iny 
		cpy Column
		bne CheckHit

		jsr SniffRange

		CheckHit:

		lda SNOUT.NosePosition
		cmp Column

		bcc NoHit

		jsr HitSnout

		

		NoHit:


		Finish:

		rts

	}



	SniffRange: {

		.label Points = TEMP4

		lda SNOUT.SniffTimeRemaining
		beq Finish

		lda ObjectType, x
		bne Finish

		lda #255
		sta YPos, x

		pha
		txa
		asl
		tay
		pla

		sta VIC.SPRITE_0_Y, y

		lda SNOUT.NosePosition
		sta Points

		lda YSpeed, x
		tay
		lda Points
		cpy #2

		bne NoMultiple

		asl
		asl

		NoMultiple:

		jsr SCORE.ScorePoints
		jsr SOUND.SuccessfulSniff

		lda #ZERO
		sta YSpeed, x

		//inc $d020

		Finish:

		rts
	}

	HitSnout: {

		lda ObjectType, x
		beq NotDead

		jsr SOUND.HitSound
		jsr MAIN.GameOver


		NotDead:

		rts
	}

}