

.namespace ENEMY {

	* = * "Enemies"

	.label LaunchWaveID= 24
	.label BottomCircleStartPoint = 220
	.label MaxY = 245
	.label MinY = 24
	.label MinYDisappear = 31
	.label MaxYDisappear = 235
	.label StandardEnemiesInWave = 8



	Explode: {

		lda ExplosionTimer, x
		beq Ready

		dec ExplosionTimer, x
		rts

		Ready:

			Okay:

			lda #FORMATION.EXPLOSION_TIME
			sta ExplosionTimer, x

			inc ExplosionProgress, x

			lda ExplosionProgress, x
			tay
			cpy #4
			bcs ExplosionDone

			lda ExplosionFrames, y
			sta SpritePointer, x

			lda #YELLOW
			sta SpriteColor, x

			rts

		ExplosionDone:

			lda #10
			//sta SpriteX, x
			sta SpriteY, x

			lda #0
			sta Plan, x

			rts

	}


	CreateExplosion: {

		ldx #0

		lda #PLAN_EXPLODE
		sta Plan, x

		lda #0
		sta ExplosionProgress, x

		lda ExplosionFrames
		sta SpritePointer, x

		lda #FORMATION.EXPLOSION_TIME
		sta ExplosionTimer, x

		lda #YELLOW
		sta SpriteColor, x

		rts
	}


	CheckShipCollision: {

		lda SHIP.Active
		beq Finish

		lda SpriteY, x
		cmp #SHIP.SHIP_Y - 7
		bcc Finish

		lda SHIP.PreviousX
		sec
		sbc SpriteX, x
		sec
		sbc #5
		clc
		adc #10

		cmp #15
		bcs CheckDualShip

		HitShip:

			jsr SHIP.KillMainShip

			lda #0
			sta BULLETS.PlayerShooting


			jmp KillShip

		CheckDualShip:

			lda SHIP.DualFighter
			clc
			adc SHIP.TwoPlayer
			beq Finish

			lda SHIP.PosX_MSB + 1
			sec
			sbc SpriteX, x
			sec
			sbc #5
			clc
			adc #10

			cmp #15
			bcs Finish

		HitDualShip:

			jsr SHIP.KillDualShip

			lda #1
			sta BULLETS.PlayerShooting


		KillShip:

			ldx ZP.EnemyID

			lda #10
			//sta SpriteX, x
			sta SpriteY, x

			lda #PLAN_INACTIVE
			sta Plan, x

			jsr Kill.Kamikaze

			ldx ZP.EnemyID
			

		Finish:



		rts
	}


	EnemyHitSFX: {

		lda ZP.Temp1
		sfxFromA()

		rts

	}


	

	

	Kill: {


		txa
		pha

		jsr STATS.Hit

		pla
		tax

		Destroy:

			lda #PLAN_EXPLODE
			sta Plan, x
			stx ZP.EnemyID

			jsr KillDive


			dec drone_max
			dec drone_max

			lda #0
			sta ExplosionProgress, x

			lda ExplosionFrames
			sta SpritePointer, x

			lda #FORMATION.EXPLOSION_TIME
			sta ExplosionTimer, x

			lda #WHITE
			sta SpriteColor, x
//
		Kamikaze:	

			lda Slot, x
			tay
			sta ZP.Amount

			lda #0
			sta FORMATION.Alive, y

			lda FORMATION.Type, y
			tay
			cmp #ALIEN_FLAGSHIP
			bne NotFlagship

			IsFlagship:

				sfx(1)
				
				inc CHARGER.FlagshipHit

				lda #0
				sta CHARGER.FlagshipActive

				lda #240
				sta CHARGER.AliensInShockCounter

				lda CHARGER.StartEscortCount
				beq NotRed

				cmp #1
				beq TwoHundred

			TwoEscorts:

				lda CHARGER.EscortKillCount
				cmp #2
				beq EightHundred

			ThreeHundred:

				ldy #9
				jmp DoScore

			EightHundred:

				ldy #10
				jmp DoScore


			TwoHundred:

				ldy #8
				jmp DoScore
				
			NotFlagship:

				sfx(2)

				cmp #ALIEN_RED
				bne NotRed

				lda CHARGER.FlagshipActive
				beq NotRed

				inc CHARGER.EscortKillCount

			NotRed:

				sty ZP.EnemyType
				
			NormalStage:

				lda ZP.EnemyType
				clc
				adc #4
				tay
				
			DoScore:

				jsr SCORE.AddScore

				ldx ZP.EnemyID

				ldy ZP.Temp2
				lda SCORE.PopupID, y
				tay
				beq NoPopup

				dey

				lda SpriteX, x
				sta ZP.Column

				lda SpriteY, x
				sta ZP.Row

				jsr BONUS.ShowBonus

				ldx ZP.EnemyID

			NoPopup:

		StillEnemiesToDock:




		rts
	}

	




}