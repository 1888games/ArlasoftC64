ENEMIES:{

	#import "lookups/enemySpriteData.asm"

	Positions:	.byte 99, 99, 99, 99, 99, 99, 99, 99, 99

	TickCounter: .byte 0, 0, 0, 0, 0, 0, 0, 0
	FlaggedForDeletion: .byte 0, 0, 0, 0, 0, 0, 0, 0

	EnableFlags: .byte %00010000, %00100000,%01000000,%10000000
	MSBOffFlags: .byte %11101111, %11011111,%10111111,%01111111
	CurrentFlag: .byte %11101111

	CurrentEnemy: .byte 0
	CurrentSpritePointer: .byte 0
	CurrentEnemies:		.byte 0
	SpawnCooldown: .byte 0, 0		// snapper, bird
	TypeStartPosition: .byte 0, 6	// snapper, bird

	.label MaxEnemies = 7
	.label SnapperTurnFrame = 5
	.label SnapperFallFrame = 20
	.label SpawnCooldownTime = 4
	.label MoveRightThreshold = 13

	RemoveClose:{

		ldx #MaxEnemies
		dex
		clc
		
		ClearLoop:

			ldy Positions, x
			cpy #99
			beq EndLoop

			// should enemy be deleted when you die?
			lda ENEMY_SPRITEDATA.DeleteUponLanding, y
			beq EndLoop
			
			// enemy will be despawned when game restarts
			sta FlaggedForDeletion, x

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
		sta CurrentSpritePointer
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
			inx
			cpx #MaxEnemies - 1
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


		lda ZP_COUNTER
		and #%00000001
		lsr
		rol
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

		// Index passed in X
		lda #99
		sta Positions, x
		dec CurrentEnemies
		
		rts

	}


	DrawEnemiesForRow:{

		.label CurrentRow = TEMP6
		.label CurrentEnemy = TEMP7

		sty CurrentRow
		lda #ZERO
		sta CurrentEnemy
		sta CurrentSpritePointer
		ldx #ZERO

		EnemyLoop:

			// store enemy index as need x registerlater

			stx CurrentEnemy

			// stop if we already used four sprites on this row
			lda #4
			cmp CurrentSpritePointer
			beq EndLoop


			// Get position of enemy, if 99 is inactive
			lda Positions, x
			cmp #99
			beq EndLoop

			// transfer to X so we can lookup data for this position
			tax

			// Check whether enemy is on the right row for this interrupt pass
			lda ENEMY_SPRITEDATA.Rows, x
			cmp CurrentRow
			bne EndLoop

			// now ok to draw the enemy sprite
			jsr DrawEnemy
			jmp EndLoop

		EndLoop:

			// restore our enemy index and check if any more to process
			ldx CurrentEnemy
			inx
			cpx #MaxEnemies
			bcs Finish

			jmp EnemyLoop

		Finish:

			rts
	}


	DrawEnemy:{

		// Set sprite pointer
		clc
		lda ENEMY_SPRITEDATA.Frames, x
		adc #64
		ldy CurrentSpritePointer
		//sty $d020
		sta SPRITE_POINTERS + 4, y

		// Multiply by two because X&Y stored together
		

		// Check whether past 255 on X asix
		lda ENEMY_SPRITEDATA.XPosMSB, x
		beq SetMSBBitOff

		ldy CurrentSpritePointer

		// Get the flag to set MSB bit for this sprite and store
		lda EnableFlags, y
		sta CurrentFlag
		lda VIC.SPRITE_MSB
		ora CurrentFlag
		sta VIC.SPRITE_MSB

		jmp Finish

		SetMSBBitOff:

			// Get the flag to disable MSB bit for this sprite and store
			lda MSBOffFlags, y
			sta CurrentFlag
			lda VIC.SPRITE_MSB
			and CurrentFlag
			sta VIC.SPRITE_MSB
				
		Finish:
			tya
			asl
			tay

			lda ENEMY_SPRITEDATA.XPosLSB, x
			sta VIC.SPRITE_4_X, y

			lda ENEMY_SPRITEDATA.YPos, x
			sta VIC.SPRITE_4_Y, y
			inc CurrentSpritePointer
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

	Update:{

		jsr CheckCooldown

		lda KEY.Active
		beq Finish

		ldx #ZERO
		.label ZP_ODD_EVEN = TEMP1
		.label PositionID = TEMP2
		
		EnemyLoop:

			stx CurrentEnemy

			lda FlaggedForDeletion, x 
			bne Despawn

			lda ZP_COUNTER
			and #%00000001
			lsr
			rol
			sta ZP_ODD_EVEN

			
			lda TickCounter, x

			cmp ZP_ODD_EVEN
			bne EndLoop

			lda Positions, x
			sta PositionID
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

			ldx CurrentEnemy
			inx
			cpx #MaxEnemies
			bcs Finish

			jmp EnemyLoop

		MonkeyHit:

			jsr MONKEY.Kill
			//jsr KEY.LoseLife
			jmp EndLoop

		Finish:

			rts



	}


}