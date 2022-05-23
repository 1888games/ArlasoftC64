RESET: {
	

	EnemyData: {

		lda #0
		sta ENEMIES.CurrentMovementID
		sta ENEMIES.CurrentMovementTime
		sta ENEMIES.CurrentMovementTime + 1
		sta ENEMIES.CurrentXSpeed
		sta ENEMIES.CurrentXDirection
		sta ENEMIES.CurrentYSpeed
		sta ENEMIES.CurrentXFrames
		sta ENEMIES.CurrentXFrames + 1
		sta ENEMIES.CurrentYFrames
		sta ENEMIES.CurrentYFrames + 1
		sta ENEMIES.CurrentFrame
		sta ENEMIES.CurrentFrames
		sta ENEMIES.CurrentRows
		sta ENEMIES.CurrentColumns
		sta ENEMIES.CurrentDrawRow
		sta ENEMIES.CurrentWaves
		sta ENEMIES.CurrentWaves + 1
		sta ENEMIES.CurrentWaves + 2
		sta ENEMIES.CurrentWaves + 3
		sta ENEMIES.CurrentWaves + 4
		sta ENEMIES.CurrentWaves + 5
		sta ENEMIES.CurrentWaves + 6
		sta ENEMIES.CurrentWaves + 7
		sta ENEMIES.CurrentWaveLength
		sta ENEMIES.CurrentStartFrame
		sta ENEMIES.CurrentGapX
		sta ENEMIES.IsDiceLevel
		sta ENEMIES.CurrentGapY
		sta ENEMIES.CurrentOddOffsetX
		sta ENEMIES.CurrentXStart_LSB
		sta ENEMIES.CurrentYStart_LSB
		sta ENEMIES.CurrentXStart_MSB
		sta ENEMIES.CurrentYStart_MSB
		sta ENEMIES.CurrentFramesPerFrame
		sta ENEMIES.FrameCounter
		sta ENEMIES.EnemiesReady
		//sta ENEMIES.LevelActive
		//sta ENEMIES.LevelActive + 1

		ldx #0

		XLoop:

			sta ENEMIES.PosX_LSB, x
			sta ENEMIES.PosX_MSB, x

			sta ENEMIES.OrigPosX_LSB, x
			sta ENEMIES.OrigPosX_MSB, x

			inx 
			cpx #18
			beq FinishX
			jmp XLoop

		FinishX:

		ldx #0

		YLoop:
		
			sta ENEMIES.PosY_LSB, x
			sta ENEMIES.PosY_MSB, x

			sta ENEMIES.OrigPosY_LSB, x
			sta ENEMIES.OrigPosY_MSB, x

			txa

			sta ENEMIES.IRQ_Data, x

			inx 
			cpx #8
			beq FinishY
			jmp YLoop

		FinishY:

		lda #0
		sta ENEMIES.RowFirstEnemyIndex

		lda #5
		sta ENEMIES.RowFirstEnemyIndex + 1

		lda #10
		sta ENEMIES.RowFirstEnemyIndex + 2

		lda #15
		sta ENEMIES.RowFirstEnemyIndex + 3

		lda #20
		sta ENEMIES.RowFirstEnemyIndex + 4


		lda #25
		sta ENEMIES.RowFirstEnemyIndex + 5

		lda #30
		sta ENEMIES.RowFirstEnemyIndex + 6

		lda #40
		sta ENEMIES.RowFirstEnemyIndex + 7


	

		rts
	}


	
}