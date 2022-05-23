GRUNT: {



	* = * "Grunt"

	CharX:		.fill MAX_GRUNTS, 254
	CharY:		.fill MAX_GRUNTS, 254
	Frame:		.fill MAX_GRUNTS, 255
	Timer:		.fill MAX_GRUNTS, 30

	NumberToGenerate: .byte 1
	NumberRemaining:	.byte 1

	ScreenAddress:	.fillword MAX_GRUNTS, 0
	ColourAddress:	.fillword MAX_GRUNTS, 0

	SpawnProgress:	.fill MAX_GRUNTS, 0

	Direction:	.fill MAX_GRUNTS, 255
	Fill:		.byte 0
	Spawning:	.byte 0

	TopLeft:		.byte 27, 27, 27
	TopRight:		.byte 41

	BottomLeft:		.byte 28, 29, 30
	BottomRight:	.byte 42, 40, 42

	HeadFrame:		.byte 0
	HeadTimer:		.byte 0
	HeadFrames:		.byte 0, 1, 2, 1

	FrameAddress:	.word CHAR_SET + 58 * 8, CHAR_SET + 59 * 8, CHAR_SET + 60 * 8

	.label HeadAddress = CHAR_SET + 27 * 8
	.label ReduceTime = 225
	.label RandomMoveChance = 15

	SpawnTime:		.byte 1


	NextProcessID:	.byte 0
	ProcessTime:	.byte 6
	HeadTime:		.byte 6
	PerFrame:		.byte 8
	MaxGrunts:		.byte 0

	StartProcess:	.byte 0
	EndProcess:		.byte 0
	Processing:		.byte 0
	ProcessTimer:	.byte 0
	MoveProbability: .byte 0
	MoveLimit:		.byte 0
	MoveReduce:		.byte 0
	ReduceTimer:	.byte 0
	MaxOfGruntsAndSprites:	.byte 0

	// Stage1:		.byte 61, 58, 59, 0
	// Stage2:		.byte 65, 64, 63, 62, 67, 0
	// Stage3:		.byte 75, 73, 73, 72, 71, 70, 69, 68, 76, 77, 78, 79, 0
	// Stage4:		.byte 75, 73, 73, 72, 71, 70, 69, 68, 76, 77, 78, 79, 0
	// Stage5:		.byte 75, 73, 73, 72, 71, 70, 69, 68, 76, 77, 78, 79, 0
	// Stage6:		.byte 75, 73, 73, 72, 71, 70, 69, 68, 76, 77, 78, 79, 0

	Stage1:		.byte 76, 74, 75, 0
	Stage2:		.byte 80, 79, 78, 77, 82, 0
	Stage3:		.byte 90, 88, 88, 87, 86, 85, 84, 83, 91, 92, 93, 94, 0
	Stage4:		.byte 90, 88, 88, 87, 86, 85, 84, 83, 91, 92, 93, 94, 0
	Stage5:		.byte 90, 88, 88, 87, 86, 85, 84, 83, 91, 92, 93, 94, 0
	Stage6:		.byte 90, 88, 88, 87, 86, 85, 84, 83, 91, 92, 93, 94, 0


	YOffset1:	.byte -1, 1, 1
	YOffset2:	.byte -2, 1, 1, 1, 1, 1
	YOffset3:	.byte -5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	YOffset4:	.byte -11, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2
	YOffset5:	.byte -12, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	YOffset6:	.byte -13, 2, 2, 2, 2, 2, 4, 2, 2, 2, 2, 2


	.label XBoundaryLeft = 8
	.label XBoundaryRight = 25
	.label YBoundaryUp = 6
	.label YBoundaryDown = 16


	Stages:		.word Stage1, Stage2, Stage3, Stage4, Stage5, Stage6
	Offsets:	.word YOffset1, YOffset2, YOffset3, YOffset4, YOffset5, YOffset6




	Initialise: {



		jsr Reset

		lda NumberRemaining
		bne AreSome

			lda #1
			sta PLAYER.Active
			jmp NoneLeft

		AreSome:

			ldx #0

			lda #<YOffset6
			sta ZP.OffsetAddress

			lda #>YOffset6
			sta ZP.OffsetAddress + 1

			lda #<Stage6
			sta ZP.StageAddress

			lda #>Stage6
			sta ZP.StageAddress + 1

		Loop:

			stx ZP.X

			lda CharX, x
			cmp #255
			beq EndLoop

			jsr Generate

			ldx ZP.X

			EndLoop:

			inx
			cpx NumberToGenerate
			bcc Loop

		NoneLeft:

		jsr SOUND.Spawn

		lda #MAX_SPRITES
		sta MaxOfGruntsAndSprites
		cmp NumberToGenerate
		bcs Okay

		lda NumberToGenerate
		sta MaxOfGruntsAndSprites

		Okay:

		//lda #<ProcessSpawn
		//ldy #>ProcessSpawn

		//jsr TASK.AddFunction

		
		rts
	}

	NextLevel: {

		ldx #0

		Loop:

			lda #254
			sta CharX, x

			inx
			cpx #MAX_GRUNTS
			bcc Loop



		rts
	}


	Reset: {

	
		lda #0
		sta Processing
		sta ProcessTimer
		sta StartProcess
		sta MoveReduce

		lda #ReduceTime
		sta ReduceTimer


		lda PerFrame
		sta EndProcess
		rts

	}


	FrameUpdate: {

		lda PLAYER.Dead
		beq NotDead

		rts

		NotDead:

			//inc $d020

			lda Fill
			bmi GruntsReady

			rts

		GruntsReady:

		

			jsr AdjustDifficulty
			jsr CheckHead
			jsr Process



	//	dec $d020


		rts
	}

	AdjustDifficulty: {

			dec ReduceTimer
			beq Reduce

			rts

		Reduce:

			lda #ReduceTime
			sta ReduceTimer

			lda MoveLimit
			lsr
			cmp #1
			bcs NoReduce

			lda #1

		NoReduce:

			sta MoveLimit

		rts
	}

	

	Error: {

		jmp Generate.StartOver
	}


	Generate: {

		Init:

			lda #0
			sta Frame, x
			sta Fill
			sta Spawning

			lda #5
			sta SpawnProgress, x

		StartOver:

			ldx ZP.X
			jsr SHARED.GetRandomCharPosition

			lda ZP.Row
			sta CharY, x
			tay

		CalculateAddress:

			lda ZP.Column
			sta CharX, x
			tax

			jsr PLOT.GetCharacter

			bne Error

			ldy #41
			lda (ZP.ScreenAddress), y
			bne Error

			lda #65
			sta (ZP.ScreenAddress), y

			ldy #0
			sta (ZP.ScreenAddress), y

			lda ZP.X
			tax
			asl
			tay

		ReserveSpot:

			lda ZP.ScreenAddress
			sta ScreenAddress, y

			lda ZP.ScreenAddress + 1
			sta ScreenAddress + 1, y

			lda ZP.ColourAddress
			sta ColourAddress, y

			lda ZP.ColourAddress + 1
			sta ColourAddress + 1, y

			jsr RANDOM.Get
			and #%00011111
			sta Timer, x

		
			//jsr GetRowAndColumn	
		//	jsr DrawSpawn
	
		
		rts
	}


	DeleteSpawn: {

		ldx #0

		Loop:	

			stx ZP.CurrentID 

			lda ZP.Row
			bmi EndLoop

			cmp #25
			bcs Done

			tay


			ldx ZP.Column

			jsr PLOT.GetCharacter

			cmp #73
			bcc EndLoop

			cmp #95
			bcs EndLoop

			ldy #0
			lda #0
			sta (ZP.ScreenAddress), y

			EndLoop:

				inc ZP.CurrentID
				ldy ZP.CurrentID
				lda (ZP.StageAddress), y
				beq Done

				lda (ZP.OffsetAddress), y
				clc
				adc ZP.Row
				sta ZP.Row

				tya
				tax

				jmp Loop


			Done:


		ldx ZP.X



		rts
	}

	GetRowAndColumn: {

		lda CharX, x
		sta ZP.Column

		ldy #0
		lda (ZP.OffsetAddress), y
		clc
		adc CharY, x
		sta ZP.Row





		rts
	}

	DrawSpawn: {

		ldx #0
	

		Loop:	

			stx ZP.CurrentID 

			lda ZP.Row
			bmi EndLoop

			cmp #25
			bcs Done

			tay

			ldx ZP.Column

			jsr PLOT.GetCharacter

			bne EndLoop

			ldy ZP.CurrentID
			lda (ZP.StageAddress), y

			ldy #0
			sta (ZP.ScreenAddress), y

			lda #RED_MULT
			sta (ZP.ColourAddress), y


			EndLoop:

				inc ZP.CurrentID
				ldy ZP.CurrentID
				lda (ZP.StageAddress), y
				beq Done

				lda (ZP.OffsetAddress), y
				clc
				adc ZP.Row
				sta ZP.Row

				tya
				tax

				jmp Loop


			Done:

		ldx ZP.X



		rts
	}
	
	CheckHead: {

		lda HeadTimer
		beq Ready

		dec HeadTimer
		rts


		Ready:

		lda HeadTime
		sta HeadTimer

		inc HeadFrame
		lda HeadFrame
		cmp #4
		bcc Okay

		lda #0
		sta HeadFrame

		Okay:

		tay
		lda HeadFrames, y
		asl
		tay

		lda FrameAddress, y
		sta ZP.TextAddress

		lda FrameAddress + 1, y
		sta ZP.TextAddress + 1

		ldy #0

		Loop:

			lda (ZP.TextAddress), y
			sta HeadAddress, y

			iny
			cpy #8
			bcc Loop



		rts
	}


	AnimateSpawn: {

		lda SpawnProgress, x
		bmi Exit

		DeleteOld:

			asl
			tay

			lda Offsets, y
			sta ZP.OffsetAddress

			lda Offsets + 1, y
			sta ZP.OffsetAddress + 1

			lda Stages, y
			sta ZP.StageAddress

			lda Stages + 1, y
			sta ZP.StageAddress + 1

		jsr GetRowAndColumn
		jsr DeleteSpawn

		NextStage:

		dec SpawnProgress, x
		lda SpawnProgress, x
		bmi Done

		asl
		tay

		lda Offsets, y
		sta ZP.OffsetAddress

		lda Offsets + 1, y
		sta ZP.OffsetAddress + 1

		lda Stages, y
		sta ZP.StageAddress

		lda Stages + 1, y
		sta ZP.StageAddress + 1

		jsr GetRowAndColumn
		jsr DrawSpawn

		inc Spawning

		rts

		Done:

		jsr GetAddress
		jsr Draw




		Exit:


		rts
	}

	ProcessSpawn: {

		lda Fill
		bmi GruntsReady

		NotProcessing:

		lda ProcessTimer
		beq Ready

		dec ProcessTimer
		rts

		Ready:

	//	inc $d020

		ldx StartProcess

		Loop:

			stx ZP.X

			lda CharX, x
			bmi EndLoop

			jsr AnimateSpawn


			EndLoop:


				ldx ZP.X
				inx
				cpx EndProcess
				bcc Loop

		lda EndProcess
		clc
		adc PerFrame
		sta EndProcess

		lda StartProcess
		clc
		adc PerFrame
		sta StartProcess
		cmp NumberToGenerate
		bcc Okay

		jsr Reset

		lda Spawning
		bne NotDone

		lda #255
		sta Fill

		lda #1
		sta PLAYER.Active

		NotDone:

		lda #0
		sta Spawning

		Okay:

		//dec $d020

		SetDebugBorder(DARK_GRAY)


		GruntsReady:

		rts
	}



	Process: {

		ldx NextProcessID
		stx ZP.CurrentID

		Loop:

			lda CharX, x
			bmi EndLoop

			stx ZP.CurrentID

			lda Timer, x
			beq ReadyToMove

		NotReady:

			dec Timer, x
			jmp EndLoop

		ReadyToMove:

			jsr RANDOM.Get


			and #%00001111
			clc
			adc MoveLimit
			sec
			sbc MoveReduce
			bmi SetAtLimit

			cmp MoveLimit
			bcs OkayTime

		SetAtLimit:

			lda MoveLimit

		OkayTime:

			lsr
			sta Timer, x

			jsr Move

			ldx ZP.CurrentID

			EndLoop:

			lda $d012
			cmp #230
			bcc Okay

			inx
			stx NextProcessID

			jmp Done

		Okay:

			inx
			cpx NumberToGenerate
			bcc Loop

			ldx #0
			stx NextProcessID

		Done:




		rts
	}


	ChangeFrame: {

		inc Frame, x
		lda Frame, x
		cmp #3
		bcc Okay

		lda #0
		sta Frame, x

		Okay:

		rts
	}


	Move: {

		

		jsr ChangeFrame
		jsr GetAddress
		jsr Delete


		WillMove:

		txa
		asl
		tay

		CheckX:

			lda PLAYER.CharX
			sec
			sbc CharX, x
			beq CheckY
			bpl GoRight


		GoLeft:

			jsr RANDOM.Get
			cmp #RandomMoveChance
			bcc ForceRight

		ForceLeft:

			lda CharX, x
			beq CheckY

			dec CharX, x

			lda ScreenAddress, y
			sec
			sbc #1
			sta ScreenAddress, y

			lda ScreenAddress + 1, y
			sbc #0
			sta ScreenAddress + 1, y

			lda ColourAddress, y
			sec
			sbc #1
			sta ColourAddress, y

			lda ColourAddress + 1, y
			sbc #0
			sta ColourAddress + 1, y

			jmp CheckY

		GoRight:

			jsr RANDOM.Get
			cmp #RandomMoveChance
			bcc ForceLeft

		ForceRight:

			lda CharX, x
			cmp #32
			bcs CheckY

			inc CharX, x

			lda ScreenAddress, y
			clc
			adc #1
			sta ScreenAddress, y

			lda ScreenAddress + 1, y
			adc #0
			sta ScreenAddress + 1, y

			lda ColourAddress, y
			clc
			adc #1
			sta ColourAddress, y

			lda ColourAddress + 1, y
			adc #0
			sta ColourAddress + 1, y

			jmp CheckY


		CheckY:


			lda PLAYER.CharY
			sec
			sbc CharY, x
			beq Finish
			bpl GoDown


		GoUp:

			jsr RANDOM.Get
			cmp #RandomMoveChance
			bcc ForceDown

		ForceUp:


			lda CharY, x
			beq Finish

			dec CharY, x


			lda ScreenAddress, y
			sec
			sbc #40
			sta ScreenAddress, y

			lda ScreenAddress + 1, y
			sbc #0
			sta ScreenAddress + 1, y

			lda ColourAddress, y
			sec
			sbc #40
			sta ColourAddress, y

			lda ColourAddress + 1, y
			sbc #0
			sta ColourAddress + 1, y

			jmp Finish

		GoDown:


			jsr RANDOM.Get
			cmp #RandomMoveChance
			bcc ForceUp

		ForceDown:


			lda CharY, x
			cmp #23
			bcs Finish

			inc CharY, x

			lda ScreenAddress, y
			clc
			adc #40
			sta ScreenAddress, y

			lda ScreenAddress + 1, y
			adc #0
			sta ScreenAddress + 1, y

			lda ColourAddress, y
			clc
			adc #40
			sta ColourAddress, y

			lda ColourAddress + 1, y
			adc #0
			sta ColourAddress + 1, y
			

		Finish:

			jsr GetAddress
			jsr Draw



		rts
	}

	


	StartOver: {

		ldx ZP.X
		jmp Generate.StartOver

	}



	GetAddress: {

		txa
		asl
		tay

		lda ScreenAddress, y
		sta ZP.ScreenAddress

		lda ScreenAddress + 1, y
		sta ZP.ScreenAddress + 1

		lda ColourAddress, y
		sta ZP.ColourAddress

		lda ColourAddress + 1, y
		sta ZP.ColourAddress + 1

		rts

	}



	CheckAllEnemies: {


		lda NumberRemaining
		clc
		adc SPHEROID.NumberRemaining
		adc ENFORCER.NumberRemaining
		bne Finish

	//	jsr COMPLETE.Set

		Finish:


		rts
	}


	Kill: {

		inc MoveReduce

		sfx(SFX_GRUNT)
		jsr SOUND.KillGrunt

		lda #255
		sta CharX, x

		stx ZP.Temp3

		ldy #5
		jsr SCORE.AddScore

		ldx ZP.Temp3

		dec NumberRemaining

		lda NumberRemaining
		clc 
		adc #48
		//sta SCREEN_RAM + 3

		lda #RED
		//sta VIC.COLOR_RAM + 3

		lda NumberRemaining
		bne Okay

		jsr CheckAllEnemies

		Okay:

		rts
	}
	
	Draw: {

		lda Frame, x
		sta ZP.Amount

		ldy #0
		lda (ZP.ScreenAddress), y
		cmp #31
		bcc NotMine1

		cmp #40
		bcs NotMine1

		jmp HitMine

		NotMine1:

			ldy #40
			lda (ZP.ScreenAddress), y
			cmp #31
			bcc NotMine

			cmp #40
			bcs NotMine

		HitMine:

			jmp Kill


		NotMine:

			ldy #0
			lda TopLeft
			sta (ZP.ScreenAddress), y

			lda #RED_MULT
			sta (ZP.ColourAddress), y

			iny
			lda (ZP.ScreenAddress), y
			bne Skip1

			lda TopRight
			sta (ZP.ScreenAddress), y

			lda #RED_MULT
			sta (ZP.ColourAddress), y


		Skip1:

			ldy #40
			ldx ZP.Amount
			lda BottomLeft, x
			sta (ZP.ScreenAddress), y

			lda #RED_MULT
			sta (ZP.ColourAddress), y

			iny
			lda (ZP.ScreenAddress), y
			bne Skip2

			lda BottomRight, x
			sta (ZP.ScreenAddress), y

			lda #RED_MULT
			sta (ZP.ColourAddress), y

		Skip2:

		rts
	}

	Delete: {

		ldy #0
		lda #0
		sta (ZP.ScreenAddress), y

		iny
		lda (ZP.ScreenAddress), y
		cmp #13
		bcc Skip1
		lda #0
		sta (ZP.ScreenAddress), y


		Skip1:

		ldy #40
		lda #0
		sta (ZP.ScreenAddress), y

		iny
		lda (ZP.ScreenAddress), y
		cmp #13
		bcc Skip2
		lda #0
		sta (ZP.ScreenAddress), y


		Skip2:
		rts
	}

	CheckCollision: {


		ldx #0

		lda ZP.Row
		sec
		sbc #1
		sta ZP.Amount
			

		Loop:

			lda CharX, x
			bmi EndLoop

			cmp ZP.Column
			bne EndLoop

			lda CharY, x
			cmp ZP.Row
			beq Collide
		
			cmp ZP.Amount
			bne EndLoop

			Collide:		

				
				jsr GetAddress
				jsr Delete

				lda CharX, x
				sta ZP.Column

				lda CharY, x
				sta ZP.Row

				jsr GRUNT_PIECE.Add
				jsr Kill


				rts


			EndLoop:

			inx
			cpx NumberToGenerate
			bcc Loop


		rts
	}


	CopyChar: {





		rts
	}

}