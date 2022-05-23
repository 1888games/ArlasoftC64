ENEMIES: {

	* = * "-Enemies"

	.label MAX_ENEMIES = 32

	CharX:		.fill MAX_ENEMIES, 0
	CharY:		.fill MAX_ENEMIES, 0
	OffsetX:	.fill MAX_ENEMIES, 0
	Mode:		.fill MAX_ENEMIES, 0
	Frame:		.fill MAX_ENEMIES, 0
	MovedChars: .fill MAX_ENEMIES, 0
	PrevCharX:	.fill MAX_ENEMIES, 0
	Side:		.fill MAX_ENEMIES, 0

	RowsOccupied:		.fill MAX_ENEMIES, 1

	CloseFormationOrder:	.byte 1, 3, 5, 7, 31, 29, 27


	.label MinX = 2
	.label MaxX = 24
	.label DyingFrame = 38
	.label DeadFrames = 10
	.label BombDropChance = 110

	CharLookups:	.byte 98, 100, 102, 104
	OverallMode:	.byte 0
	NextEnemyID:	.byte 0
	AddForFrame:	.byte 0, 8
	AllDead:		.byte 0
	FrameTimer:		.byte 2

	GameSpeed:		.byte 2

	DestroyedPerSide:		.byte 0, 0
	EnemiesOut:		.byte 0




	Reset: {


		ldx #MAX_ENEMIES
		dex
		ldy #0
		sty DestroyedPerSide
		sty DestroyedPerSide + 1
		sty OverallMode

		Loop:

			sty StoredYReg

			LeftEnemy:

				lda #MinX
				sta CharX, x

				lda #0
				sta OffsetX, x
				sta Mode, x
				sta Frame, x
				sta Side, x

				lda #1
				sta RowsOccupied, x

				tya
				sta CharY, x

				jsr Draw

			RightEnemy:

				ldy StoredYReg
				dex

				lda #MaxX
				sta CharX, x

				lda #3
				sta OffsetX, x

				lda #1
				sta Side, x
				sta RowsOccupied, x

				tya
				sta CharY, x

				jsr Draw

			EndLoop:

				ldy StoredYReg

				iny

				dex
				bpl Loop

		ldy #3

		Loop2:

			jsr RandomEnemyOut
			
			Skip:

				dey
				bpl Loop2


		Finish:

			rts


	}


	RandomEnemyOut: {


		LoopUntil:

		jsr RANDOM.Get
		and #%00011111
		tax

		CheckLevelWithBarriers:

			lda Mode, x
			cmp #ENEMY_MODE_FORMATION
			bne LoopUntil

			lda CharY, x
			cmp #12
			bcs LoopUntil

			cmp #3
			bcc LoopUntil
				
			jsr MoveEnemyOut

	   Skip:


		rts
	}

	FrameUpdate: {

		lda SHIP.IsDead
		bne Finish

		lda EnemiesOut
		bne HasEnemies

		jsr RandomEnemyOut

		HasEnemies:

		lda FrameTimer
		beq Ready

		dec FrameTimer
		jmp Finish



		Ready:

		lda GameSpeed
		sta FrameTimer

		lda #0
		sta EnemyCount
		sta AllDead

		ldx NextEnemyID

		Loop:

			stx StoredXReg

			jsr UpdateEnemy	

			inc EnemyCount

			ldx StoredXReg

			inx
			cpx #MAX_ENEMIES
			bcc Okay

			ldx #0

			Okay:

			jsr FindNextEnemy

			lda EnemyCount
			cmp #2
			beq Finish

			lda AllDead
			beq Loop


			.break
			nop




		Finish:


	


		rts
	}




	CloseEnemyFormation: {

		stx StoredXReg

		lda CharY, x
		sta Amount

		lda Side, x
		tay
		lda DestroyedPerSide, y
		cmp #7
		bcs Finish

		tay

		lda CloseFormationOrder, y
		sec
		sbc Side, x
		tax

		lda CharX, x
		sta PrevCharX, x

		jsr Delete

		lda Amount
		sta CharY, x

		jsr Draw


		Finish:

			ldx StoredXReg
			lda Side, x
			tax
			inc DestroyedPerSide, x





		rts
	}

	FindNextEnemy: {

		stx StartID

		Loop:

			lda Mode, x
			cmp #ENEMY_MODE_DEAD
			bne Found

			inx

			cpx StartID
			beq AllDead

			cpx #MAX_ENEMIES
			bcc Loop

			ldx #0
			jmp Loop


		AllDead:

				.break
				nop

				lda #1
				sta AllDead


		Found:

				stx NextEnemyID

		rts
	}


	UpdateEnemy: {
		
		lda Mode, x
		cmp #ENEMY_MODE_DEAD
		bne NotDead

		jmp Exit

		NotDead:

			lda CharX, x
			sta PrevCharX, x

			lda Mode, x
			cmp #ENEMY_MODE_DYING
			beq Dying

			lda Frame, x
			beq MakeOne

		MakeZero:

			dec Frame, x
			jmp CheckMove

		MakeOne:

			inc Frame, x
			jmp CheckMove

		Dying:

			lda Frame, x
			beq Dead

			dec Frame, x
			jmp NoDelete

			Dead:

			dec EnemiesOut

			lda #ENEMY_MODE_DEAD
			sta Mode, x
			sta MovedChars, x


			jsr Delete	
			jsr ENEMIES.CloseEnemyFormation

			ldx StoredXReg

			lda #0
			sta CharX, x
			sta CharY, x
						


			jmp Exit

		
		CheckMove:

			lda #0
			sta MovedChars, x


			lda Mode, x
			cmp #ENEMY_MODE_FORMATION
			beq NoMove

			cmp #ENEMY_MODE_SLOW_RIGHT
			beq SlowRight

			cmp #ENEMY_MODE_SLOW_LEFT
			beq SlowLeft

			jmp DrawEnemy

			SlowRight:

				lda OffsetX, x
				cmp #3
				beq NextCharRight

				MoveRight:

					inc OffsetX, x
					jmp CheckBomb

				NextCharRight:

					lda CharX, x
					cmp #MaxX
					beq DrawEnemy

					inc CharX, x
					inc MovedChars, x
					lda #0
					sta OffsetX, x

					jmp CheckBomb


			SlowLeft:



				lda OffsetX, x
				beq NextCharLeft

				MoveLeft:

					dec OffsetX, x
					jmp CheckBomb

				NextCharLeft:

					lda CharX, x
					cmp #MinX
					beq DrawEnemy

					dec CharX, x
					inc MovedChars, x
					lda #3
					sta OffsetX, x

					jmp CheckBomb

			CheckBomb:

				jsr CheckDropBomb
				jmp DrawEnemy


		NoMove:

			CheckWhetherToLaunch:

				lda CharY, x
				cmp #12
				bcs DrawEnemy

				cmp #3
				bcc DrawEnemy

				jsr RANDOM.Get
				and #%00011111
				cmp #15
				bne DrawEnemy

			Launch:

				jsr MoveEnemyOut

			DrawEnemy:

				lda MovedChars, x
				beq NoDelete

				jsr Delete


		NoDelete:

			jsr Draw

		Exit:



		rts
	}



	MoveEnemyOut: {

		inc EnemiesOut

		lda CharX, x
		cmp #10
		bcc Left

		Right:

			lda #ENEMY_MODE_SLOW_LEFT
			sta Mode, x
			jmp Finish

		Left:

			lda #ENEMY_MODE_SLOW_RIGHT
			sta Mode, x

		Finish:

		rts


	}

	CheckDropBomb: {

		lda CharX, x
		cmp #3
		bcc NoDrop

		cmp #24
		bcs NoDrop

		jsr RANDOM.Get
		cmp #BombDropChance
		bcs NoDrop

		jsr BOMBS.DropBomb

		ldx StoredXReg

		NoDrop:




		rts
	}

	Delete: {

		// x = shipID

		stx CurrentID

		GetData:

			lda PrevCharX, x
			sta Column

			lda CharY, x
			sta Row

			lda #SHIP.BlankCharacterID

		DrawChars:

			ldx Column
			ldy Row

			jsr PLOT.PlotCharacter

			inx
			
			jsr PLOT.PlotCharacter

		Finish:

			ldx CurrentID

		rts
	}


	Draw: {

		// x = shipID

		stx CurrentID

		GetData:

			lda CharX, x
			sta Column

			lda Frame, x
			tay
			lda AddForFrame, y
			sta Amount

		

			lda CharY, x
			sta Row

			lda Mode, x
			cmp #ENEMY_MODE_DYING
			bne NotDying

			lda OffsetX, x
			asl
			clc 
			adc #DyingFrame

			sta CharID
			jmp DrawChars

			NotDying:

				lda OffsetX, x
				tax

				lda CharLookups, x
				clc
				adc Amount
				sta CharID


		DrawChars:

			ldx Column
			ldy Row
			lda CharID

			jsr PLOT.PlotCharacter

			inx
			clc
			adc #1

			jsr PLOT.PlotCharacter

		Finish:

			ldx CurrentID

		rts
	}





}