BRAIN: {

	* = * "Brains"

	.label MAX_BRAINS = 31

	SpriteID:		.fill MAX_BRAINS, 0
	Frame:			.fill MAX_BRAINS, 0
	MoveTimer:		.fill MAX_BRAINS, 0
	TargetID:		.fill MAX_BRAINS, 0
	FireTimer:		.fill MAX_BRAINS, 0
	Colour:			.fill MAX_BRAINS, 0

	NumberToGenerate:	.byte 0
	LastID:				.byte 0
	FrameLookup:		.byte 0, 1, 2, 1

	Frame_LookupX:		.byte 0, 3
	Frame_LookupY:		.byte 6, 9
	
	Speed:		.byte 8
	Progging:	.byte 0
	MaxFireTime:	.byte 0


	.label BasePointer = 37
	.label PixelsPerMove = 4

	.label MinX = 24
	.label MaxX = 26
	.label MinY = 50
	.label MaxY = 236
	.label ChanceOfRandom = 200




	
	Initialise: {

		ldx #0
		stx Progging
		stx ZP.Amount
		stx LastID

		lda NumberToGenerate
		beq Finish

		Loop:

			stx ZP.X

			lda ZP.MoveSpeed
			sta MoveTimer, x

			StaggerMoveTime:

				inc ZP.MoveSpeed
				lda ZP.MoveSpeed
				cmp Speed
				bcc Okay

				lda #0
				sta  ZP.MoveSpeed

			Okay:

				jsr SPRITE_MANAGER.GetAvailableEnemySprite
				txa

				ldx ZP.X
				sta SpriteID, x
				sta LastID

				lda #PURPLE
				sta Colour, x

				inc SPRITE_MANAGER.EnemiesActive

				jsr Generate	
				jsr FindNearestFamilyMember

				ldx ZP.X
				jsr GetFireDelay

				inx
				cpx NumberToGenerate
				bcc Loop

		inc LastID
			

		Finish:	

		


		rts
	}


	FindNearestFamilyMember: {
		
		.label ClosestDistance = ZP.Amount
		.label BrainSpriteID = ZP.Temp4

		lda #255
		sta ClosestDistance

		ldy ZP.X
		sta TargetID, y

		stx BrainSpriteID

		lda LEVEL_DATA.CurrentLevel
		cmp #4
		bne NotMikeyBug

		AllTargetMikey:

			lda #0
			ldx ZP.X
			sta TargetID, x
			rts

		NotMikeyBug:

			ldy #0

		Loop:
			lda HUMANS.Type, y
			bmi EndLoop
			lda SpriteMSB, y
			cmp SpriteMSB, x
			beq MSBEqual

			lda SpriteMSB, y
			beq HumanOnRightDiffMSB

		HumanOnLeftDiffMSB:

			lda #255
			sec
			sbc SpriteX, y
			clc
			adc SpriteX, x
			bcc CompareDistance

			lda #255
			jmp CompareDistance
		
		HumanOnRightDiffMSB:

			lda #255
			sec
			sbc SpriteX, x
			clc
			adc SpriteX, y
			bcc CompareDistance

			lda #255
			jmp CompareDistance

		MSBEqual:

			lda SpriteX, x
			cmp SpriteX, y
			bcc HumanOnRight

		HumanOnLeft:

			lda SpriteX, x
			sec
			sbc SpriteX, y
			jmp CompareDistance

		HumanOnRight:

			lda SpriteX, y
			sec
			sbc SpriteX, x

		CompareDistance:

			cmp ClosestDistance
			beq NewClosest
			bcc NewClosest

		EndLoop:

			iny
			cpy HUMANS.NumberToGenerate
			bcc Loop

			jmp Finish

		NewClosest:

			sta ClosestDistance

			tya
			ldx ZP.X
			sta TargetID, x

			ldx BrainSpriteID
			jmp EndLoop

		Finish:

		rts
	}



	GetFireDelay: {

		CheckMaxFire:

			lda MaxFireTime
			cmp #32
			bcs BigNumber

			cmp #16
			bcs MidNumber

		SmallNumber:

			jsr RANDOM.Get
			and #%00001111	
			jmp AddMin

		MidNumber:

			jsr RANDOM.Get
			and #%00011111
			jmp AddMin

		BigNumber:

			jsr RANDOM.Get
			and #%00111111

		AddMin:

			cmp MaxFireTime
			bcs CheckMaxFire

		sta FireTimer, x


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

		
		inc SPRITE_MANAGER.BrainsActive

		lda SpriteID, x
		tax

		lda #SPRITE_BRAIN
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

		lda #PURPLE
		sta SpriteColor, x

		NoTarget:

		
		rts
	}


	// MoveTowardsTarget: {


	// 	ldx ZP.X

	// 	dec TurnCounter, x
	// 	lda TurnCounter, x
	// 	bne NoDirectionChange

	// 	jsr DecideTurnTime
	// 	jsr GetDirection
	

	// 	NoDirectionChange:


	// 		lda #0
	// 		sta ZP.Amount

	// 		lda SpriteID, x
	// 		tay

	// 	CheckX:

	// 		lda XSpeed, x
	// 		beq CheckY
	// 		bmi GoLeft


	// 	GoRight:

	// 		lda #3
	// 		sta ZP.Amount

	// 		lda SpriteX, y
	// 		clc
	// 		adc #PixelsPerMove
	// 		sta SpriteX, y

	// 		lda SpriteMSB, y
	// 		adc #0
	// 		sta SpriteMSB, y
	// 		beq NoWrapRight

	// 		lda SpriteX, y
	// 		cmp #MaxX
	// 		bcc NoWrapRight

	// 		lda #MaxX
	// 		sta SpriteX, y

	// 		jsr GetDirection
	// 		jmp Finish

	// 	NoWrapRight:

	// 		jmp CheckY

	// 	GoLeft:

	// 		lda #0
	// 		sta ZP.Amount

	// 		lda SpriteX, y
	// 		sec
	// 		sbc #PixelsPerMove
	// 		sta SpriteX, y

	// 		lda SpriteMSB, y
	// 		sbc #0
	// 		sta SpriteMSB, y
	// 		bne NoWrapLeft

	// 		lda SpriteX, y
	// 		cmp #MinX
	// 		bcs NoWrapLeft

	// 		lda #MinX
	// 		sta SpriteX, y

	// 		jsr GetDirection
	// 		jmp Finish

	// 	NoWrapLeft:



	// 	CheckY:

	// 		lda YSpeed, x
	// 		beq Finish

	// 		bmi GoUp


	// 	GoDown:

	// 		lda #9
	// 		sta ZP.Amount
		
	// 		lda SpriteY, y
	// 		clc
	// 		adc #PixelsPerMove
	// 		sta SpriteY, y

	// 		cmp #MaxY
	// 		bcc NoWrapDown

	// 		lda #MaxY
	// 		sta SpriteY, y

	// 		jsr RandomDirection

	// 	NoWrapDown:

	// 		jmp Finish

	// 	GoUp:

	// 		lda #6
	// 		sta ZP.Amount
		
	// 		lda SpriteY, y
	// 		sec
	// 		sbc #PixelsPerMove
	// 		sta SpriteY, y

	
	// 		cmp #MinY
	// 		bcs NoWrapUp

	// 		lda #MinY
	// 		sta SpriteY, y

	// 		jsr RandomDirection

	// 	NoWrapUp:





	// 	Finish:

	// 	lda SpriteMSB, y
	// 	jsr UTILITY.StoreMSBColourY

	// 	ldx ZP.X
		
	// 	inc Frame, x
	// 	lda Frame, x
	// 	cmp #4
	// 	bcc Okay

	// 	lda #0
	// 	sta Frame, x

	// 	Okay:

	// 	jsr UpdatePointer




	// 	rts
	// }

	Process: {

		jsr RANDOM.Get
		cmp #50
		bcc TargetPlayer
	
		lda TargetID, x
		tay
		bmi TargetPlayer

		CheckHumanAlive:

			lda HUMANS.Type, y
			bpl TargetHuman

		HumanDead:

			ldx ZP.SpriteID
			jsr FindNearestFamilyMember

			ldx ZP.X
			lda TargetID, x
			tay
			bpl TargetHuman

		TargetPlayer:



			ldy #PLAYER.PlayerSprite 

		TargetHuman:

			ldx ZP.SpriteID

			lda SpriteMSB, y
			cmp SpriteMSB, x
			bcc GoLeft
			bne GoRight

		CheckLSB:

			lda SpriteX, y
			cmp SpriteX, x
			bcc GoLeft

		GoRight:

			lda #3
			sta ZP.Amount

			lda SpriteX, x
			clc
			adc #PixelsPerMove
			sta SpriteX, x

			lda SpriteMSB, x
			adc #0
			sta SpriteMSB, x
			beq NoWrapRight

			lda SpriteX, x
			cmp #MaxX
			bcc NoWrapRight

			lda #MaxX
			sta SpriteX, x

		NoWrapRight:

			jmp CheckY

		GoLeft:

			lda #0
			sta ZP.Amount

			lda SpriteX, x
			sec
			sbc #PixelsPerMove
			sta SpriteX, x

			lda SpriteMSB, x
			sbc #0
			sta SpriteMSB, x
			bne NoWrapLeft

			lda SpriteX, x
			cmp #MinX
			bcs NoWrapLeft

			lda #MinX
			sta SpriteX, x

		NoWrapLeft:


		CheckY:

			lda SpriteY, y
			cmp SpriteY, x
			bcc GoUp

		GoDown:

			lda #9
			sta ZP.Amount
		
			lda SpriteY, x
			clc
			adc #PixelsPerMove
			sta SpriteY, x

			cmp #MaxY
			bcc NoWrapDown

			lda #MaxY
			sta SpriteY, x

		NoWrapDown:

			jmp Animate

		GoUp:

			lda #6
			sta ZP.Amount
		
			lda SpriteY, x
			sec
			sbc #PixelsPerMove
			sta SpriteY, x

			cmp #MinY
			bcs Animate

			lda #MinY
			sta SpriteY, x

		Animate:

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

		ldy ZP.SpriteID

		lda ZP.Amount
		sta SpritePointer, y
	
		lda SpriteMSB, y
		jsr UTILITY.StoreMSBColourY


		rts
	}


	FrameUpdate: {

		//jsr CheckFrame

		SetDebugBorder(LIGHT_RED)

		//inc $d020

		lda NumberToGenerate
		beq Finish

		lda PLAYER.Active
		beq Finish

		lda PLAYER.Dead
		bne Finish

		ldx #0

		Loop:

			lda SpriteID, x
			bmi Next

			sta ZP.SpriteID
			tay
			stx ZP.X

			lda MoveTimer, x
			beq Ready

			dec MoveTimer, x
			
			jmp EndLoop

		Ready:

			lda Speed
			sta MoveTimer, x

			jsr Process
			ldx ZP.X
		
		EndLoop:

			lda MoveTimer, x
			and #%00000001
			beq NoCheck

			lda Colour, x
			clc
			adc #1
			and #%00001111
			sta Colour, x

			lda SpriteColor, y
			and #%10000000
			ora Colour, x
			sta SpriteColor, y


			//jsr CheckBullet

		NoCheck:
		
			ldx ZP.X

		Next:

			inx	
			cpx NumberToGenerate
			bcc Loop


		Finish:

		SetDebugBorder(DARK_GRAY)

		//dec $d020

		rts	

	}

}