STAGE: {

	* = * "Stage"

	ReadyNextWave:		.byte 0

	CurrentStage:	.byte 0, 0
	StageIndex:		.byte 0
	Players:		.byte 1
	ChallengeStage:	.byte 2, 0

	CurrentPlayer:	.byte 0
	CurrentWave:	.byte 0
	TransformTypes:	.byte 0, 0

	TransformType:	.byte 0

	CurrentWaveIDs:	.byte 0, 0



	StartX:		.byte 0, 0
	StartY:		.byte 0, 0

	SpawnSide:	.byte 0
	SpawnTimer:	.byte 0// set to 250 to test

	SpawnedInWave:		.byte 0
	SpawnedInStage:		.byte 0


	Every:		.byte 0
	Bullets:	.byte 0
	EveryCounter:	.byte 0

	DelayTimer:	.byte 0

	KillCount:			.byte 0, 0
	WaveKillCount:		.byte 0, 0
	TransformsKilled:	.byte 0

	MaxExtraEnemies:	.byte 0
	ExtraEnemies:		.byte 0


	ExtraEnemyIDs:		.byte 0, 0, 0, 0

	//SpriteAddresses:	.fillword 6, SPRITE_SOURCE + (i * (16 *  64))
	TransformSpriteIDs:	.byte 1, 3, 4
	ChallengeSpriteIDs: .byte 0, 0, 0, 1, 2, 3, 4, 5
	SoftlockProtect:	.byte 0, 0
	SoftlockTimer:		.byte 255

	.label SpawnGap = 8
	.label NumberOfWaves = 5
	.label DelayTime = 40
	.label WaveYAdjust = 8
	.label NumChallengeStages = 8





	NewGame: {

		lda #0
		sta CurrentWave
		sta CurrentStage
		sta CurrentStage + 1
		sta ReadyNextWave
		sta TransformTypes
		sta TransformTypes + 1
		sta TransformType
	
		sta SpawnedInWave
		sta SpawnedInStage
		sta Every
		sta Bullets
		sta EveryCounter
		sta DelayTimer
		sta SpawnTimer
		sta MaxExtraEnemies
		sta SoftlockProtect
		sta SoftlockProtect + 1

		lda #255
		sta ChallengeStage
		sta ChallengeStage + 1
		sta SoftlockTimer

		lda #250
		sta SpawnTimer

		lda #0
		sta CurrentStage


		rts
	}



	GetStageData: {


		lda #250
		sta STAGE.SpawnTimer

		lda #0
		sta CurrentWave
		sta SpawnedInWave
		sta SpawnedInStage
		sta KillCount
		sta KillCount + 1
		sta TransformsKilled
		sta WaveKillCount
		sta WaveKillCount + 1
		sta MaxExtraEnemies
		sta ENEMY.NextSpawnValue

		lda #DelayTime
		sta DelayTimer

		dec CurrentWave

		lda #0
		sta ZP.Amount

		lda #1
		sta STAGE.ReadyNextWave

		rts
	}



	MoveIntoFormationMode: {

		lda #1
		sta FORMATION.Switching

		lda #0
		sta SpawnedInWave

		lda #255
		sta SpawnTimer

		rts
	}



	TestFormation: {

		lda #NumberOfWaves * 8
		sta FORMATION.Alive

		lda #NumberOfWaves
		sta CurrentWave


		ldx #0

		Loop:

			lda #1
			sta FORMATION.Occupied, x
			sta FORMATION.Alive, x

			inx
			cpx #48
		//	cpx #1
			bcc Loop


		jsr MoveIntoFormationMode

		lda #0


		ldy CHARGER.ExtraFlagships
		//ldy #2
		cpy #1
		beq SkipOne

		cpy #2
		beq SkipTwo

		lda #0
		sta FORMATION.Occupied + 2
		sta FORMATION.Alive + 2

		SkipOne:

		sta FORMATION.Occupied + 1
		sta FORMATION.Alive + 1

		SkipTwo:

		sta FORMATION.Mode


		lda #0
		sta FORMATION.Switching


		rts
	}


	* = * "Check Complete"

	CheckComplete: {	


		lda FORMATION.EnemiesLeftInStage
		bne LevelNotComplete

		lda SHIP.Active
		beq LevelNotComplete

		lda DelayTimer
		beq FinishLevel
			
		dec DelayTimer
		rts

		FinishLevel:

			lda BULLETS.ActiveBullets
			clc
			adc BOMBS.ActiveBombs
			//sta SCREEN_RAM + 718
			bne LevelNotComplete

		LevelComplete:

			lda #0
			sta FORMATION.Mode
			sta CHARGER.HaveAggressiveAliens

			lda #1
			sta CHARGER.LevelComplete

			jsr KillDive.Force

			inc CurrentStage

			lda CurrentStage
			cmp #255
			bcc NoWrap

			lda #0
			sta CurrentStage



		NoWrap:	

			lda SHIP.Speedrun
			beq NormalStage

			lda #0
			sta LIVES.DoSpeed

			lda #1
			sta SHIP.GameOver

			jsr StopDrone

			jmp END_GAME.Initialise
	
		NormalStage:

			lda #GAME_MODE_PRE_STAGE
			sta MAIN.GameMode

			lda #1
			sta PRE_STAGE.Progress
			sta SpawnTimer
			sta PRE_STAGE.NewStage


		LevelNotComplete:




		rts
	}


	FrameUpdate: {

		lda SpawnTimer
		cmp #250
		bne NoSkip

		jmp TestFormation

		NoSkip:

		//jsr CheckSoftlock
		
		jsr CheckComplete

		rts

	}








}