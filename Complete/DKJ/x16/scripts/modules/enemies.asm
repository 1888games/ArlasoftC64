ENEMIES:{

	Positions:	.byte 99, 99, 99, 99, 99, 99, 99, 99

	TickCounter: .byte 0, 0, 0, 0, 0, 0, 0, 0
	FlaggedForDeletion: .byte 0, 0, 0, 0, 0, 0, 0, 0

	CurrentEnemies:		.byte 0
	SpawnCooldown: .byte 0, 0		// snapper, bird
	TypeStartPosition: .byte 0, 6	// snapper, bird
	CurrentEnemy: .byte 0

	.label MaxEnemies = 8
	.label SnapperTurnFrame = 5
	.label SnapperFallFrame = 20
	.label SpawnCooldownTime = 4
	.label MoveRightThreshold = 13
	.label AddForObjectID = 25

	RemoveClose:{

		ldx #MaxEnemies
		dex
		clc

		.label EnemyID = TEMP8
		
		ClearLoop:

			stx EnemyID

			ldy Positions, x
			cpy #99
			beq EndLoop

			// should enemy be deleted when you die?
			lda ENEMY_SPRITEDATA.DeleteUponLanding, y
			beq EndLoop
			
			// enemy will be despawned when game restarts
		//	sta FlaggedForDeletion, x
			tya
			clc
			adc #AddForObjectID
			tax 
			ldy #ZERO
			jsr CHAR_DRAWING.ColourObject

			ldx EnemyID

			lda #99
			sta Positions, x
			dec CurrentEnemies


			EndLoop:

				cpx #ZERO
				beq Finish
				dex
				jmp ClearLoop

		Finish:
			rts
	}

	// Reset for new game
	Reset:{

		lda #ZERO
		sta SpawnCooldown 
		sta SpawnCooldown + 1
		sta CurrentEnemies
		sta CurrentEnemy
		sta TypeStartPosition

		lda #6
		sta TypeStartPosition + 1

		// Reset enemy positions to 99
		ldx #MaxEnemies
		dex
		lda #99
		clc

		ClearLoop:

			
			sta Positions, x

			lda #ZERO
			sta FlaggedForDeletion, x
			sta TickCounter, x
			cpx #ZERO
			beq Finish

			dex
			jmp ClearLoop

		Finish:
			rts

	}

	GetFreeEnemyIndex:{

		// Find the next available enemy to use
		ldx #ZERO
		Loop:

			lda Positions, x
			cmp #99
			beq Finish

			EndLoop:

				inx 
				cpx #MaxEnemies
				beq Finish
				jmp Loop


		Finish:
			rts
	}	


	Spawn:{	

		

		// y passed in with enemy type - 0 = snapper, 1 = bird
		// Maximum enemies on screen, quit?

		lda CurrentEnemies

		cmp #MaxEnemies
		beq Finish

		// Only just spawned enemy type, quit?
		lda SpawnCooldown, y
		bne Finish


		// return enemyID to use in X
		jsr GetFreeEnemyIndex

		cpx #MaxEnemies
		bcc Okay

		jmp Finish

		Okay:
		
			lda MAIN.FrameSwitch
			sta TickCounter, x
			
			// Get the initial position for this enemy
			lda TypeStartPosition, y
			sta Positions, x

			// final setup after spawning
			inc CurrentEnemies
			lda #SpawnCooldownTime
			sta SpawnCooldown, y

			lda #ZERO
			sta FlaggedForDeletion, x


		Finish:

			rts
	}



	DespawnEnemy: {

		txa
		pha

		ldy #ZERO
		lda Positions, x
		clc
		adc #AddForObjectID
		tax
		jsr CHAR_DRAWING.ColourObject

		pla
		tax

		// Index passed in X
		lda #99
		sta Positions, x

		clc
		dec CurrentEnemies


		
		rts

	}



	DrawEnemy:{

		//backup x

		cpx #99
		beq Finish

		txa
		pha
		
		clc
		adc #AddForObjectID
		tax

		jsr CHAR_DRAWING.ColourObject

		pla
		tax
			
		Finish:
			
			rts

	}


	

	CheckCooldown: {


		lda SpawnCooldown
		beq SnapperOk
		dec SpawnCooldown
		jmp Finish

		SnapperOk:

			lda SpawnCooldown + 1
			beq Finish
			dec SpawnCooldown + 1

		Finish:

			rts


	}



	Update: {

		jsr CheckCooldown

		lda KEY.Active
		bne KeyActive

		//inc VIC.BORDER_BACKGROUND

		jmp Finish


		KeyActive:

		.label PositionID = TEMP2

		ldx #ZERO

		EnemyLoop:

			stx CurrentEnemy

			lda FlaggedForDeletion, x 
			bne Despawn

			// delete enemy
			lda Positions, x
			tax
			ldy #ZERO
			jsr DrawEnemy
			ldx CurrentEnemy

			// only every other tick

			lda TickCounter, x
			cmp MAIN.FrameSwitch
			bne EndLoop

			lda Positions, x
			sta PositionID

			//inc VIC.BORDER_BACKGROUND

			// enemy not active, don't 
			cmp #99
			beq EndLoop

			cmp #SnapperTurnFrame
			beq TurnSnapper

			cmp #MoveRightThreshold
			bcc MoveRight

			cmp #14
			beq Despawn

			cmp #13
			beq Despawn

			tay
			lda ENEMY_SPRITEDATA.HitMonkeyCell, y
			cmp MONKEY.CellID
			beq MonkeyHit

			dey
			tya
			sta Positions,x

			jmp EndLoop


		Despawn:

			
			jsr DespawnEnemy
			jmp EndLoop


		TurnSnapper:	

			lda #SnapperFallFrame
			sta Positions, x
			jmp EndLoop

		MoveRight:
			
			tay
			lda ENEMY_SPRITEDATA.HitMonkeyCell, y
			cmp MONKEY.CellID
			beq MonkeyHit

			lda PositionID
			clc
			adc #ONE
			sta Positions, x

		
		EndLoop:

			// draw enemy again
			lda Positions, x
			tax
			ldy #ONE
			jsr DrawEnemy


			// check end of enemies
			ldx CurrentEnemy
			inx
			cpx #MaxEnemies
			beq Finish

			jmp EnemyLoop

		MonkeyHit:

			jsr MONKEY.Kill
			jmp EndLoop

		Finish:
			rts


	}

	


}