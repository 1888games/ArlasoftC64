PINEAPPLE: {


	Position: 	.byte 0
	Rows: 		.byte 7, 11, 15, 19
	FallCountdown: .byte 0, 18
	EnemyHitPositions: .byte 98, 2, 10, 17
	EnemyKillPosition: .byte 0

	.label GameTickAddOnHit = 15
	.label FirstCharacter = 251
	.label BlankCharacter = 0
	.label Column = 20
	.label SCREEN_ADDRESS = VECTOR4
	.label COLOR_ADDRESS = VECTOR5
	.label NewPosition = TEMP1

	
	Reset:{

		ldx #ZERO
		stx Position
		jsr Draw
		rts

	}

	Update:{

		//c $d020

		lda FallCountdown
		beq Finish

		dec FallCountdown
		bne Finish

		jsr Delete

		inx
		cpx #4
		beq HitGround

		jsr StartFall
		jsr MovePineapple
		

		HitGround:


		Finish:
			rts

	}


	StartFall:{

		lda Position
		cmp #4
		beq NoFall

		lda FallCountdown + 1
		sta FallCountdown

		NoFall:

			rts

	}

	CalculateAddresses:{

		//get row for this position
		ldy Rows, x

		// Get CharAddress
		lda VIC.ScreenRowLSB, y
		clc
		adc #Column
		sta SCREEN_ADDRESS
		sta COLOR_ADDRESS

		lda VIC.ScreenRowMSB, y
		adc #$00
		sta SCREEN_ADDRESS + 1

		// Calculate colour ram address
		adc #>[VIC.COLOR_RAM-SCREEN_RAM]
		sta COLOR_ADDRESS +1

		rts

	}

	MovePineapple:{

		stx NewPosition
		cpx Position

		beq DontDelete

		jsr Delete

		DontDelete:

		ldx NewPosition
		stx Position
		jsr Draw
		jsr CheckPineappleHitEnemy
		rts

	}


	CheckPineappleHitEnemy: {

			ldy Position
			lda EnemyHitPositions, y
			sta EnemyKillPosition
			ldx #ZERO

			EnemyLoop:

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

				jsr ENEMIES.DespawnEnemy

				txa
				tay
				ldx ENEMIES.Positions, y
				tya 
				ldy ENEMY_SPRITEDATA.Rows, x
				tax
			
				jsr SCORE.HitEnemy
				clc
				
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
		ldx Position
		jsr CalculateAddresses

		// store character at address
		lda #FirstCharacter
		adc Position
		ldy #ZERO
		sta (SCREEN_ADDRESS), y

		lda #PURPLE
		sta (COLOR_ADDRESS), y

		rts
	}


	Delete:{

		// Get screen position
		ldx Position
		jsr CalculateAddresses

		lda #BlankCharacter
		ldy #ZERO
		sta (SCREEN_ADDRESS), y

		rts

	}


	


}