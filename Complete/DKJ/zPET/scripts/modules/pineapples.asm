PINEAPPLE: {


	Position: 	.byte 0
	Positions: 	.byte 50, 51, 52, 53
	FallCountdown: .byte 0, 14
	EnemyHitPositions: .byte 98, 2, 10, 17
	EnemyKillPosition: .byte 0

	IsFalling: .byte 0

	.label GameTickAddOnHit = 15
	.label FirstCharacter = 105
	.label BlankCharacter = 0
	.label Column = 11
	.label NewPosition = TEMP1

	
	Reset:{

		lda #ZERO
		sta Position
		sta IsFalling
		jsr Draw

		rts

	}


	StartFall:{

		lda IsFalling
		bne Finish

		lda Position
		bne Finish

		lda #ONE
		sta IsFalling

		lda FallCountdown + 1
		sta FallCountdown


		Finish:
		
		rts

	}



	Update: {

		lda IsFalling
		beq Finish

		lda FallCountdown
		beq ReachedNextPosition

		dec FallCountdown
		jmp Finish


		ReachedNextPosition:

			jsr CheckPineappleHitEnemy
			jsr Delete
			inc Position
			lda Position
			cmp #4
			bcc StillFalling

			jmp EndFall

			StillFalling:
			jsr Draw
			jsr CheckPineappleHitEnemy

			lda FallCountdown + 1
			sta FallCountdown
			jmp Finish


		EndFall:

			lda #ZERO
			sta IsFalling

		Finish:

		rts



	}

	

	CheckPineappleHitEnemy: {

			ldy Position
			lda EnemyHitPositions, y
			sta EnemyKillPosition
			ldx #ZERO

			.label EnemyID = TEMP9

			EnemyLoop:

				stx EnemyID

				lda ENEMIES.Positions, x
				cmp EnemyKillPosition
				beq HitEnemy
				jmp EndLoop

			HitEnemy:

				lda MAIN.GameCounter
				adc #GameTickAddOnHit
				sta MAIN.GameCounter
				lda FallCountdown
				adc #GameTickAddOnHit
				sta FallCountdown

				lda ENEMIES.Positions, y
				tay
				lda ENEMY_SPRITEDATA.Rows, y
				tay 

		
				
				jsr SCORE.HitEnemy
				lda #ZERO
				sta MONKEY.JumpedOverEnemy

				ldx EnemyID
				jsr ENEMIES.DespawnEnemy

				
				jmp Finish

			EndLoop:

				inx
				cpx #ENEMIES.MaxEnemies
				beq Finish
	
				jmp EnemyLoop

			Finish:

				rts
	}

	Draw:{

		// Get screen address
		ldy Position
		lda Positions, y
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		rts
	}


	Delete:{

	// Get screen address
		ldy Position
		lda Positions, y
		tax
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		rts

	}


	


}