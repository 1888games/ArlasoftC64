.namespace CHARGER {

	* = * "Chargers"


	SwarmAliens:			.byte 0
	FlagshipHit: 			.byte 0
	DifficultyExtraValue:	.byte 0  // max = 7
	DifficultyBaseValue:	.byte 0  // max = 7
	DifficultyCounter1:		.byte 0
	DifficultyCounter2:		.byte 0

	CanAlienAttack:			.byte 0

	AttackMasterCounter:		.byte 0
	AttackSecondaryCounters:	.fill 15, 0


	AttackCounterDefaults:	.byte $05, $2F, $43, $77, $71, $6D, $67, $65
							.byte $4F, $49, $43, $3D, $3B, $35, $2B, $29

							//.byte 04, 39, 56, 99, 94, 91, 86, 84
							//.byte 66, 61, 56, 51, 49, 44, 36, 34

	* = * "Have Alien"
	
	HaveAliensInTopRow:		.byte 0
	HaveAliensIn2ndRow:		.byte 0
	HaveAliensIn3rdRow:		.byte 0
	HaveAliensIn4thRow:		.byte 0
	HaveAliensIn5thRow:		.byte 0
	HaveAliensIn6thRow:		.byte 0
	NotUsed:				.byte 0, 0
	Repeated:				.byte 0

	HaveBluePurpleAliens:	.byte 0

	FlagshipMasterCounter_1:	.byte 0
	FlagshipMasterCounter_2:	.byte 0
	FlagshipSecondaryCounter:	.byte 0
	EnableFlagshipSecondary:	.byte 0
	ExtraFlagships:				.byte 0
	FlagshipSurvivorCount:		.byte 0

	FlagshipOrRedCanAttack:		.byte 0


	InflightAlienShootRangeMult:	.byte 0
	InflightAlienShootExactY:		.byte 0

	HaveAggressiveAliens:		.byte 0
	AliensInShockCounter:		.byte 0
	InflightAliens:				.byte 0
	NextLevelCounter:			.byte 0
	LevelComplete:				.byte 0
	TimingVariable:				.byte 0

	AliensAttackRightFlank:		.byte 1
	FlagshipEscortCount:		.byte 0
	StartEscortCount:			.byte 0
	EscortKillCount:			.byte 0
	FlagshipActive:				.byte 0

	AliensInColumn:			.fill 10, 0

	NewGame: {


		jsr Reset

		lda #0
		sta ExtraFlagships

		lda #50
		sta DifficultyCounter1

		lda #7
		sta DifficultyCounter2

		lda #1
		sta DifficultyBaseValue

		rts
	}

	Reset: {

		lda #0
		sta FlagshipHit
		sta HaveAliensIn6thRow
		sta HaveAliensIn5thRow
		sta HaveAliensIn4thRow
		sta HaveAliensIn3rdRow
		sta HaveAliensIn2ndRow
		sta HaveAliensInTopRow
		sta HaveBluePurpleAliens
		sta FlagshipOrRedCanAttack
		sta HaveAggressiveAliens
		sta AliensInShockCounter
		sta LevelComplete
		sta FlagshipSurvivorCount
		sta FlagshipEscortCount
		sta DifficultyExtraValue
		sta FlagshipActive


		lda #$8
		sta FlagshipMasterCounter_2

		lda #$30
		sta FlagshipMasterCounter_1


		lda #48
		sta SwarmAliens

		jsr ResetFlagshipSecondary
	
		ldx #0


		Loop:

			lda AttackCounterDefaults, x
			sta AttackMasterCounter, x

			inx
			cpx #16
			bcc Loop

		rts
	}



	ResetFlagshipSecondary: {

		lda #90
		sta FlagshipSecondaryCounter

		lda #45
		sta AttackMasterCounter

		lda #1
		sta EnableFlagshipSecondary



		rts
	}

	FrameUpdate: {

		SetDebugBorder(6)


		lda MAIN.GameMode
		cmp #GAME_MODE_PLAY
		beq GameStuff

			jsr HandleLevelComplete
			rts
		//	jmp UpdateCounters

		GameStuff:

			lda #0
			sta Repeated

		Repeat:

			jsr HandleFlagshipAttack
			jsr HandleSingleAlienAttack
			jsr HandleLevelDifficulty
			jsr SetAlienAttackFlank

			jsr CheckIfAlienCanAttack
			jsr UpdateFlagshipCounters
			jsr CheckIfFlagshipCanAttack
			jsr CalculateMinimumShootingDistance
			jsr HandleAlienAggressiveness
			
			jsr HandleShockedSwarm

			lda IRQ.Frame
			sec
			sbc MAIN.MachineType
			adc Repeated
			bpl DontRepeat

			inc Repeated

			jmp Repeat

		DontRepeat:

	
		SetDebugBorder(0)
		rts
	}

	SetAlienAttackFlank: {

		lda FORMATION.ScrollValue
		bpl ScrolledRight

		ScrolledLeft:	

			lda #0
			sec
			sbc FORMATION.ScrollValue
			sta ZP.Amount

			lda FORMATION.ScrollExtentLeft
			lsr
			lsr
			sec
			sbc ZP.Amount
			bcs RandomOkay

			lda #1
			sta AliensAttackRightFlank
			rts

		ScrolledRight:

			lda FORMATION.ScrollExtentRight
			lsr
			lsr
			sec
			sbc FORMATION.ScrollValue
			bcs RandomOkay

			lda #0
			sta AliensAttackRightFlank
			rts


		RandomOkay:

			jsr RANDOM.Get
			and #%00000001
			sta AliensAttackRightFlank

		rts
	}

	HandleLevelDifficulty: {

		lda SHIP.Active
		beq Finish

		lda FlagshipHit
		bne Finish

		dec DifficultyCounter1
		bne Finish

		lda #60
		sta DifficultyCounter1

		dec DifficultyCounter2
		bne Finish

		lda #20
		sta DifficultyCounter2

		lda DifficultyExtraValue
		cmp #7
		beq Finish

		inc DifficultyExtraValue

		Finish:



		rts
	}



	HandleLevelComplete: {

		CheckComplete:

			lda LevelComplete
			beq Finish

			lda NextLevelCounter
			beq Ready

			dec NextLevelCounter
			rts

		Ready:

			jsr StopDrone

			lda #0
			sta LevelComplete
			sta DifficultyExtraValue
			sta TimingVariable

			inc DifficultyBaseValue
			lda DifficultyBaseValue
			cmp #8
			bcc Okay

			lda #7
			sta DifficultyBaseValue

		Okay:	

			lda FlagshipSurvivorCount
			sta ExtraFlagships

			lda #0
			sta FlagshipSurvivorCount



		Finish:

		rts
	}

	HandleAlienAggressiveness: {

		// this also does background noise, come back to it

		lda SHIP.GameOver
		bne Finish

		lda #0
		sta HaveAggressiveAliens

		lda SwarmAliens
		cmp #4
		bcs Finish

		inc HaveAggressiveAliens

		jsr StopDrone

		Finish:

		rts
	}


	HandleShockedSwarm: {

		lda FlagshipHit
		beq Finish

		Shocked:

			lda HaveAggressiveAliens
			bne DecreaseShock

			lda HaveBluePurpleAliens
			beq DecreaseShock

			lda InflightAliens
			bne Finish

		DecreaseShock:

			dec AliensInShockCounter
			bne Finish

			lda #0
			sta FlagshipHit

		Finish:

		rts
	}

// // HAVE_ALIENS_IN_ROW_FLAGS is an array of 6 bytes. Each byte contains a bit flag specifying if there are any aliens on a given row.
// HAVE_ALIENS_IN_ROW_FLAGS            EQU $41E8
// NEVER_USED_ROW_1                    EQU $41E8
// NEVER_USED_ROW_2                    EQU $41E9

// HAVE_ALIENS_IN_6TH_ROW              EQU $41EA         // flag set to 1 if there are any aliens in the bottom row (blue aliens)
// HAVE_ALIENS_IN_5TH_ROW              EQU $41EB         // flag set to 1 if there are any aliens in the 5th row (blue aliens)
// HAVE_ALIENS_IN_4TH_ROW              EQU $41EC         // flag set to 1 if there are any aliens in the 4th row (blue aliens)
// HAVE_ALIENS_IN_3RD_ROW              EQU $41ED         // flag set to 1 if there are any aliens in the 3rd row (purple aliens)
// HAVE_ALIENS_IN_2ND_ROW              EQU $41EE         // flag set to 1 if there are any aliens in the 2nd row (red aliens)
// HAVE_ALIENS_IN_TOP_ROW              EQU $41EF         // flag set to 1 if there are any aliens in the top row (flagships)


	CalculateMinimumShootingDistance: {

		ldx #7
		ldy #4

		lda DifficultyBaseValue
		bne SetMultiplier

		SetEasy:

			lda #1
			sta InflightAlienShootRangeMult

			lda #132
			sta InflightAlienShootExactY

		Loop:

			lda HaveAliensInTopRow, x
			bne Finish

			dex
			lda HaveAliensInTopRow, x
			bne Finish

			dex
			inc InflightAlienShootRangeMult

			dey
			bne Loop

			rts

		SetMultiplier:

			lda #1
			sta InflightAlienShootRangeMult

			lda #157
			sta InflightAlienShootExactY

			jmp Loop


		Finish:


		rts
	}


	CheckIfFlagshipCanAttack: {

		lda EnableFlagshipSecondary
		beq Finish

		dec FlagshipSecondaryCounter
		beq Finish

		lda #0
		sta EnableFlagshipSecondary

		lda SHIP.Active
		beq Finish

		lda SHIP.Dead
		bne Finish

		lda HaveAliensInTopRow
		beq Finish

		lda #1
		sta FlagshipOrRedCanAttack

		Finish:


		rts
	}

	UpdateCounters: {

		dec FlagshipMasterCounter_1
		beq Finish

		lda #60
		sta FlagshipMasterCounter_1

		dec FlagshipMasterCounter_2
		beq Finish

		lda #5
		sta FlagshipMasterCounter_2

		jsr ResetFlagshipSecondary

		Finish:

		SetDebugBorder(0)

		rts
	}


	CheckIfAlienCanAttack: {

			lda #0
			sta CanAlienAttack

			lda SHIP.Active
			beq Finish

			lda SHIP.Dead
			bne Finish

			lda SwarmAliens
			beq Finish

			lda FlagshipHit
			bne Finish

		Allowed:

			jsr CalculateDifficulty
			jsr CalculateIfCanAttack

		Finish:	

			rts

	}


	UpdateFlagshipCounters: {

		CheckAllowed:

			lda SHIP.Active
			beq Finish

			lda HaveAliensInTopRow
			beq Finish

			lda FlagshipHit
			bne Finish

		CheckMasterCounter1:

			dec FlagshipMasterCounter_1
			bne Finish

		MasterCounterExpired:

			lda #60
			sta FlagshipMasterCounter_1

			lda HaveBluePurpleAliens
			bne AreAliens 

			lda #2
			jmp SetAttackTimers

		AreAliens:

			dec FlagshipMasterCounter_2
			bne Finish

		Master2Expired:

			inc FlagshipMasterCounter_2
				

		GetDifficulty:
		
			lda DifficultyExtraValue
			clc
			adc DifficultyBaseValue
			beq Finish

		CalculateCountdownBeforeAttack:


			lsr
			lsr
			and #%00000011
			eor #%11111111
			clc
			adc #10
			sec
			sbc ExtraFlagships
			sta FlagshipMasterCounter_2

		SetAttackTimers:

			asl
			adc #0
			asl
			adc #0

			sta FlagshipSecondaryCounter

			asl			
			adc #0

			sta AttackMasterCounter

			inc EnableFlagshipSecondary
			jmp Finish


		Finish:

		rts
	}


	CalculateIfCanAttack: {

		lda #0
		sta CanAlienAttack

		DecrementMaster:

			dec AttackMasterCounter
			lda AttackMasterCounter
			beq DecrementSecondary

		CantAttackYet:
	
			rts

		DecrementSecondary:

			lda AttackCounterDefaults
			sta AttackMasterCounter


			ldy ZP.Amount
			ldx #0

		Loop:

			dec AttackSecondaryCounters, x
			bne NotZero

		
			inc CanAlienAttack

			lda AttackCounterDefaults + 1, x
			sta AttackSecondaryCounters, x


		NotZero:

			inx
			dey
			beq Finish

			jmp Loop


		Finish:

		lda CanAlienAttack

		rts
	}

	

	CalculateDifficulty: {

		CheckDifficulty:

			lda DifficultyBaseValue
			cmp #2
			bcs CalculateCounters

			//lda #0

		CalculateCounters:

			clc
			adc DifficultyExtraValue
			and #%00001111
			clc
			adc #1
			sta ZP.Amount // 1-16

		rts
	}


	HandleFlagshipAttack: {

		
		InitialCheck:

			lda FlagshipOrRedCanAttack
			beq Exit

			lda SwarmAliens
			beq Exit

			lda SHIP.Active
			beq Exit

			jmp CheckSlot

		Exit:	

			rts

		CheckSlot:

			lda #0
			sta FlagshipOrRedCanAttack

			lda ENEMY.Plan + 1
			bne Exit

		WhichSide:

			lda AliensAttackRightFlank
			bne RightSide

		LeftSide:

			jmp FlagshipLeft


		RightSide:

			jmp FlagshipRight


		rts
	}

	FlagshipLeft: {

		ldx #0

		Loop:	

			lda FORMATION.Occupied, x
			bne FoundFlagship

			EndLoop:

				inx
				cpx #4
				bcc Loop

			rts
				

		ldx #4

		RedLoop:
			
			lda FORMATION.Occupied, x
			bne FoundRed

			inx
			cpx #10
			bcc RedLoop

			rts

		FoundRed:

			jmp TryInitInflightAlien

		FoundFlagship:

			lda AliensAttackRightFlank

			stx ZP.SlotID

			ldy #1
			sty ZP.EnemyID
			sta ENEMY.ArcClockwise, y

			jmp StartFlagshipAttack

		rts
	}

	FlagshipRight: {

		ldx #3

		Loop:	

			lda FORMATION.Occupied, x
			bne FoundFlagship

			EndLoop:

				dex
				bpl Loop

		ldx #9
		
		RedLoop:
			
			lda FORMATION.Occupied, x
			bne FoundRed

			dex
			cpx #4
			bcs RedLoop

			rts

		FoundRed:

			jmp TryInitInflightAlien

		FoundFlagship:

			lda AliensAttackRightFlank

			stx ZP.SlotID
			ldy #1
			sty ZP.EnemyID
			sta ENEMY.ArcClockwise, y

			jmp StartFlagshipAttack

	}


	StartFlagshipAttack: {

	
		jsr StartAlienAttack

		lda #0
		sta ZP.C
		sta EscortKillCount
		sta FlagshipEscortCount

		lda #1
		sta FlagshipActive

		txa
		clc
		adc #6
		tax 

		ldy #3

		Loop:

			sty ZP.StoredYReg
			stx ZP.X

			lda FORMATION.Occupied, x
			beq EndLoop

			jsr StartEscortAlien

			lda ZP.C
			cmp #2
			bcs Done

			EndLoop:

				ldx ZP.X
				ldy ZP.StoredYReg

				dex
				dey
				bne Loop

				rts


		Done:

		lda ZP.C
		sta FlagshipEscortCount
		sta StartEscortCount


		rts
	}

	StartEscortAlien: {

		ldy ZP.C

		lda ENEMY.Plan + 2, y
		bne Finish

		LaunchEscort:

			tya
			adc #2
			sta ZP.EnemyID

			tay

			lda AliensAttackRightFlank
			sta ENEMY.ArcClockwise, y

			jsr StartAlienAttack

			inc ZP.C

		Finish:

		rts
	}


	




	HandleSingleAlienAttack: {

		CheckFlag:

			lda CanAlienAttack
			bne CanAttack

		Exit:

			rts

		CanAttack:

			lda SwarmAliens
			beq Exit

		Difficulty:

			lda DifficultyBaseValue
			clc
			adc DifficultyExtraValue
			lsr
			cmp #4
			bcc Skip

			lda #3

		Skip:

			clc
			adc #1

		ScanBetween1_4_Slots:

			tay
			ldx #7

		Loop:

			lda ENEMY.Plan, x
			beq Found

		
			dex
			dey
			bne Loop

			rts

		Found:

			lda AliensAttackRightFlank
			stx ZP.EnemyID
			sta ENEMY.ArcClockwise, x
			beq Left

		Right:

			jmp SingleRight


		Left:

			jmp SingleLeft

		rts
	}

	TryInitInflightAlien: {

			stx ZP.SlotID

			ldx #7
			ldy #4

		Loop:

			lda ENEMY.Plan, x
			beq Found

			dex
			dey
			bne Loop

			rts

		Found:

			lda AliensAttackRightFlank
			stx ZP.EnemyID
			sta ENEMY.ArcClockwise, x

			ldx ZP.SlotID
			
			jmp StartAlienAttack

		rts






		rts
	}



	SingleRight: {

		//.break

		// x = Slot

		ldy #0

		Loop:	

			lda FORMATION.RightSearchOrder, y
			tax
			lda FORMATION.Occupied, x
			beq EndLoop

			lda HaveAliensInTopRow
			beq CanChooseRed

			lda FORMATION.Type, x
			cmp #ALIEN_RED
			beq EndLoop

			CanChooseRed:

			jmp StartAlienAttack

			EndLoop:

			iny
			cpy #44
			bcc Loop


		rts
	}

	SingleLeft: {


		ldy #0

		Loop:	

			lda FORMATION.LeftSearchOrder, y
			tax
			lda FORMATION.Occupied, x
			beq EndLoop

			lda HaveAliensInTopRow
			beq CanChooseRed

			lda FORMATION.Type, x
			cmp #ALIEN_RED
			beq EndLoop

			CanChooseRed:

			jmp StartAlienAttack

			EndLoop:

			iny
			cpy #44
			bcc Loop



		// x = slot

		rts
	}

	StartAlienAttack: {

		lda #0
		sta FORMATION.Occupied, x
		sta FORMATION.Drawn, x

		ldy ZP.EnemyID
		lda #PACKS_BAGS
		sta ENEMY.Plan, y

		txa
		sta ENEMY.Slot, y

		rts
	}






}