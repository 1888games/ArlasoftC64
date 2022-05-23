HULK: {

	* = * "Hulks"

	.label MAX_HULKS = 31

	SpriteID:		.fill MAX_HULKS, 0
	
	XSpeed:			.fill MAX_HULKS, 0
	YSpeed:			.fill MAX_HULKS, 0
	Frame:			.fill MAX_HULKS, 0
	MoveTimer:		.fill MAX_HULKS, 0
	StalkID:		.fill MAX_HULKS, 0
	TurnCounter:	.fill MAX_HULKS, 0	


	NumberToGenerate:	.byte 0
	LastID:				.byte 0
	FrameLookup:		.byte 0, 1, 2, 1

	Speed_Lookup:		.byte 255, 1
	Frame_LookupX:		.byte 0, 3
	Frame_LookupY:		.byte 6, 9
	
	Speed:		.byte 10


	.label BasePointer = 25
	.label PixelsPerMove = 4

	.label MinX = 24
	.label MaxX = 26
	.label MinY = 50
	.label MaxY = 236
	.label ChanceOfRandom = 200

	Initialise: {

		ldx #0
		stx ZP.Amount
		stx LastID

		lda NumberToGenerate
		beq Finish


		Loop:

			stx ZP.X

			lda ZP.Amount
			sta MoveTimer, x

			StaggerMoveTime:

				inc ZP.Amount
				lda ZP.Amount
				cmp Speed
				bcc Okay

				lda #0
				sta ZP.Amount

			Okay:

				txa
				clc
				adc HUMANS.NumberToGenerate
				sta SpriteID, x

				sta LastID

				jsr Generate
				inc SPRITE_MANAGER.LastEnemySprite
				jsr RandomDirection


				ldx ZP.X

				jsr DecideTurnTime

				inx
				cpx NumberToGenerate
				bcc Loop

		inc LastID
			

		Finish:	

		


		rts
	}

	DecideTurnTime: {

		jsr RANDOM.Get
		and #%00011111
		clc
		adc #1
		sta TurnCounter, x

		rts
	}

	Generate: {

		lda #0
		sta Frame, x

		jsr SHARED.GetRandomCharPosition
	
		jsr CalculateSpriteData
	
		rts
	}

	CalculateSpriteData: {

		
		inc SPRITE_MANAGER.HulksActive

		lda SpriteID, x
		tax

		lda #SPRITE_HULK
		sta SpriteType, x

		ldy ZP.Row
		lda SpriteRowLookup, y
		sta SpriteY, x

		lda ZP.Column
		tay
		lda SpriteColumnLookup, y
		sta SpriteX, x

		lda SpriteMSBLookup, y
		sta SpriteMSB, x

		jsr UTILITY.StoreMSBColourX

		lda #BasePointer
		sta SpritePointer, x

		lda #GREEN
		sta SpriteColor, x

		lda #255
		sta StalkID, x

		jsr RANDOM.Get
		cmp #192
		bcs NoTarget

		jsr HUMANS.GetNextTarget
		jsr GetDirection

		sta StalkID, x

		NoTarget:

		
		rts
	}

	// get targeted human
	// add -15 to 16
	// calculate if in bounds, if not switch to up or down / left or right
	// calculate which side of hulk and set speed
	// 
		

	MoveLeftRight: {

			lda #0
			sta YSpeed, x

			jsr RANDOM.Get
			bpl Reduce

		Increase:

			and #%00001111
			clc
			adc SpriteX, y
			sta ZP.Column

			lda SpriteMSB, y
			adc #0
			sta ZP.MSB
			beq XValueOK

		CheckRightBounds:

			lda ZP.Column
			cmp #SpriteMaxX
			bcc XValueOK

			jmp MoveUpDown

		Reduce:

			and #%00001111
			sta ZP.Amount
			lda SpriteX, y
			sec
			sbc ZP.Amount
			sta ZP.Column

			lda SpriteMSB, y
			sbc #0
			sta ZP.MSB
			bne XValueOK

		CheckLeftBounds:

			lda ZP.Column
			cmp #SpriteMinX
			bcs XValueOK

			jmp MoveUpDown


		XValueOK:

			lda SpriteID, x
			tay

			lda SpriteMSB, y
			cmp ZP.MSB
			beq CheckLSB
			bcs GoLeft

		GoRight:

			lda #1
			sta XSpeed, x
			rts


		GoLeft:

			lda #255
			sta XSpeed, x
			rts


		CheckLSB:

			lda SpriteX, y
			cmp ZP.Column
			bcc GoRight

			jmp GoLeft


		rts
	}


	MoveUpDown: {

			lda #0
			sta XSpeed, x

			jsr RANDOM.Get
			bpl Reduce

		Increase:

			and #%00001111
			clc
			adc SpriteY, y
			sta ZP.Row

		CheckDownBounds:

			cmp #SpriteMaxY
			bcc XValueOK

			jmp MoveLeftRight

		Reduce:

			and #%00001111
			sta ZP.Amount
			lda SpriteY, y
			sec
			sbc ZP.Amount
			sta ZP.Row

		CheckUpBounds:

			cmp #SpriteMinY
			bcs XValueOK

			jmp MoveLeftRight

		XValueOK:

			lda SpriteID, x
			tay

			lda SpriteY, y
			cmp ZP.Row
			bcs GoUp

		GoDown:
			lda #1
			sta YSpeed, x
			rts


		GoUp:

			lda #255
			sta YSpeed, x
			rts


	}

	GetDirection: {

		lda StalkID, x
		bpl IsHuman

		jmp RandomDirection

		IsHuman:

			tay
			lda HUMANS.Frame, y
			cmp #4
			bcc IsAlive	

		IsDead:

			lda #255
			sta StalkID, x

			jmp RandomDirection

		IsAlive:

			lda XSpeed, x
			bne UpDown

		LeftRight:

			jmp MoveLeftRight

		UpDown:

			jmp MoveUpDown

		rts
	}

	RandomDirection: {

		ldy ZP.X

		jsr RANDOM.Get
		cmp #ChanceOfRandom
		bcc TargetPlayer

		Random:

			lda XSpeed, y
			bne UpDown

		LeftRight:

			jsr RANDOM.Get
			and #%00000001
			tax

			lda Speed_Lookup, x
			sta XSpeed, y

			lda Frame_LookupX, x
			sta ZP.Amount


			lda #0
			sta YSpeed, y
			rts

		UpDown:

			jsr RANDOM.Get
			and #%00000001
			tax

			lda Speed_Lookup, x
			sta YSpeed, y

			lda Frame_LookupY, x
			sta ZP.Amount

			lda #0
			sta XSpeed, y
			rts

		TargetPlayer:

			lda SpriteID, y
			tax

			lda XSpeed, y
			beq TargetX

		TargetY:	

			lda #0
			sta XSpeed, y

			lda PLAYER.PosY
			sec
			sbc SpriteY, x
			bpl GoDown

		GoUp:

			lda #255
			sta YSpeed, y
			rts

		GoDown:

			lda #1
			sta YSpeed, y
			rts


		TargetX:

			lda #0
			sta YSpeed, y

			lda PLAYER.PosX_MSB
			sec
			sbc SpriteMSB, x
			bpl GoRight
			bmi GoLeft

			lda PLAYER.PosX_LSB
			sec
			sbc SpriteX, x
			bpl GoRight

		GoLeft:

			lda #255
			sta XSpeed, y
			rts

		GoRight:

			lda #1
			sta XSpeed, y

		Finish:




		rts
	}


	Process: {

		ldx ZP.X

		dec TurnCounter, x
		lda TurnCounter, x
		bne NoDirectionChange

		jsr DecideTurnTime
		jsr GetDirection
	

		NoDirectionChange:


			lda #0
			sta ZP.Amount

			lda SpriteID, x
			tay

		CheckX:

			lda XSpeed, x
			beq CheckY
			bmi GoLeft


		GoRight:

			lda #3
			sta ZP.Amount

			lda SpriteX, y
			clc
			adc #PixelsPerMove
			sta SpriteX, y

			lda SpriteMSB, y
			adc #0
			sta SpriteMSB, y
			beq NoWrapRight

			lda SpriteX, y
			cmp #MaxX
			bcc NoWrapRight

			lda #MaxX
			sta SpriteX, y

			jsr GetDirection
			jmp Finish

		NoWrapRight:

			jmp CheckY

		GoLeft:

			lda #0
			sta ZP.Amount

			lda SpriteX, y
			sec
			sbc #PixelsPerMove
			sta SpriteX, y

			lda SpriteMSB, y
			sbc #0
			sta SpriteMSB, y
			bne NoWrapLeft

			lda SpriteX, y
			cmp #MinX
			bcs NoWrapLeft

			lda #MinX
			sta SpriteX, y

			jsr GetDirection
			jmp Finish

		NoWrapLeft:



		CheckY:

			lda YSpeed, x
			beq Finish

			bmi GoUp


		GoDown:

			lda #9
			sta ZP.Amount
		
			lda SpriteY, y
			clc
			adc #PixelsPerMove
			sta SpriteY, y

			cmp #MaxY
			bcc NoWrapDown

			lda #MaxY
			sta SpriteY, y

			jsr RandomDirection

		NoWrapDown:

			jmp Finish

		GoUp:

			lda #6
			sta ZP.Amount
		
			lda SpriteY, y
			sec
			sbc #PixelsPerMove
			sta SpriteY, y

	
			cmp #MinY
			bcs NoWrapUp

			lda #MinY
			sta SpriteY, y

			jsr RandomDirection

		NoWrapUp:





		Finish:

		lda SpriteMSB, y
		jsr UTILITY.StoreMSBColourY

		ldx ZP.X
		
		inc Frame, x
		lda Frame, x
		cmp #4
		bcc Okay

		lda #0
		sta Frame, x

		Okay:

		jsr UpdatePointer





		rts
	}

	UpdatePointer: {



		lda Frame, x
		tay
		lda FrameLookup, y
		clc
		adc #BasePointer
		clc
		adc ZP.Amount
		sta ZP.Amount

		lda SpriteID, x
		tay

		lda ZP.Amount
		sta SpritePointer, y


		rts
	}


	HulkShot: {

		tya
		tax

		lda #0
		sta BULLET.CharID, x
		jsr BULLET.DeleteBullet

		ldx ZP.X

		jsr RANDOM.Get
		and #%00001111
		clc
		adc #8
		sta MoveTimer, x

		rts
	}


	CheckBullet: {

		ldy #0
		ldx ZP.X

		lda SpriteID, x
		tax

		Loop:

			lda BULLET.CharID, y
			beq EndLoop

			
			lda BULLET.BulletSpriteMSB, y
			sec
			sbc SpriteMSB, x
			bne EndLoop

			lda BULLET.BulletSpriteY, y
			sec
			sbc SpriteY, x
			adc #8
			cmp #16
			bcs EndLoop

			lda BULLET.BulletSpriteX, y
			sec
			sbc SpriteX, x
			adc #7
			cmp #14
			bcs EndLoop


			jmp HulkShot

			

			EndLoop:

			iny
			cpy #4
			bcc Loop





		rts
	}
	
	FrameUpdate: {

		//jsr CheckFrame

		SetDebugBorder(CYAN)

	//	inc $d020

		lda NumberToGenerate
		beq Finish

		lda PLAYER.Active
		beq Finish

		lda PLAYER.Dead
		bne Finish

		ldx #0

		Loop:

			stx ZP.X

			lda MoveTimer, x
			beq Ready

			dec MoveTimer, x
			
			
			jmp EndLoop

			Ready:

			lda Speed
			sta MoveTimer, x

			jsr Process
			

			EndLoop:

			lda MoveTimer, x
			and #%00000001
			beq NoCheck


			jsr CheckBullet


			

			NoCheck:
			


			ldx ZP.X
			inx	
			cpx NumberToGenerate
			bcc Loop


		Finish:

		SetDebugBorder(DARK_GRAY)

	//	dec $d020

		rts	

	}


}