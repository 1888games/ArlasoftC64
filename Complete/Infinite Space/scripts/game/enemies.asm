ENEMIES: {

	* = * "Enemies"

	.label MAX_ENEMIES = 10

	EnemyX0:
		.fill MAX_ENEMIES, 0
	EnemyX1:
		.fill MAX_ENEMIES, 0
	EnemyX2:
		.fill MAX_ENEMIES, 0
	EnemyY0:
		.fill MAX_ENEMIES, 0
	EnemyY1:
		.fill MAX_ENEMIES, 0
	EnemyActive:
		.fill MAX_ENEMIES, 0
	EnemyAnimIndex:
		.fill MAX_ENEMIES, 0
	EnemyDying:
		.fill MAX_ENEMIES, 0
	EnemyDeathIndex:
		.fill MAX_ENEMIES, 0
	EnemyDeathFrame:
		.fill MAX_ENEMIES, 0
	EnemyDeathTimer:
		.fill MAX_ENEMIES, 0
	EnemyType:
		.fill MAX_ENEMIES, 0
	EnemyWaveType:
		.fill MAX_ENEMIES, 0
	EnemySpeed_MSB:
		.fill MAX_ENEMIES, 0
	EnemySpeed_LSB:
		.fill MAX_ENEMIES, 0

	EnemiesThisWave:	.byte 10


	CurrentEnemyType:
		.byte $00
	CurrentWaveType:
		.byte $00
		*=*"EnemyCount"
	CurrentEnemyCount:
		.byte $00
	CurrentEnemyKillCount:
		.byte $00

	CurrentWaveNumber:
		.byte $00

	EnemyFrame:
		.byte $00
	EnemyFrameIndex: 
		.byte $00
	EnemyAnimationTimer:
		.byte $00, $03

	.label DeathTime = 3

	EnemyYAdd:	.fill 5, 5
				.fill 5, 100


	DeathFrames:
		.byte 36, 37, 38, 39, 40, 41, 42, 43
	EnemyStartFrames:
		.byte 24, 26, 28, 30, 32, 34
	EnemyFrameCount:
		.byte 2
	EnemyColors:
		.byte LIGHT_GREEN, GREEN, PURPLE, WHITE, CYAN, LIGHT_RED


	EnemyHeights:
		.byte 5, 6, 6, 7, 6, 7

	SectorTransition:
		.byte $00

	.label BulletPointer = 44
	.label BulletSpeed = 6


	BulletX_LSB:	.byte 0
	BulletX_MSB:	.byte 0
	BulletY:		.byte 0

	Reset: {


		ResetVariables:
			lda #$00
			sta CurrentEnemyCount
			sta CurrentEnemyKillCount
			lda #$00
			sta CurrentWaveNumber

			lda #1
			sta EnemiesThisWave

			lda #YELLOW
			sta VIC.SPRITE_COLOR_7

			lda #$00
			ldx #$00

		ResetData:
			sta EnemyX0, x
			inx
			cpx #[MAX_ENEMIES * 15]
			bne ResetData

			lda #$20
			sta SectorTransition

			jsr AddWave

			rts

	}

	AddWave: {

			lda MAIN.GameIsOver
			beq Okay

			jmp Finish

			Okay:
	
			lda #$00
			sta SectorTransition
			inc CurrentWaveNumber
		
			jsr RANDOM.Get
			and #%00000011
			sta Amount

			lda #MAX_ENEMIES
			sec
			sbc Amount
			sta EnemiesThisWave
			sta CurrentEnemyCount

			ldx #0
			stx CurrentEnemyKillCount
			stx EnemyFrameIndex

			

			Loop:

				jsr RANDOM.Get
				and #%00000111
				cmp #$06
				bcs Loop
				sta EnemyType, x

				jsr RANDOM.Get
				and #%00001111
				sta EnemyWaveType, x


				jsr RANDOM.Get
				sta EnemySpeed_LSB, x

				cmp #120
				bcs Randomize

				lda #1
				sta EnemySpeed_MSB, x
				jmp XAgain

				Randomize:

				jsr RANDOM.Get
				and #%0000001
				sta EnemySpeed_MSB, x

				//jsr InitialiseWave

				XAgain:

				jsr RANDOM.Get
				cmp #89
				bcc XAgain
				sta EnemyX1, x

				Again:

				jsr RANDOM.Get
				and #%0111111
				cmp #100
				bcs Again

				clc
				adc #50
				clc
				adc EnemyYAdd, x
				sta EnemyY1, x


				lda #$01
				sta EnemyActive, x
				sta EnemyX2, x
				sta EnemyX0, x

				lda #$00
				sta EnemyDying, x
				sta EnemyDeathIndex, x
			

				inx
				cpx EnemiesThisWave
				bcc Loop

			Finish:

			rts
	}


	UpdateBullet: {

		lda BulletX_LSB
		clc
		adc BulletX_MSB
		beq Finish

		MoveBullet:

			lda BulletX_LSB
			sec
			sbc #BulletSpeed
			sta BulletX_LSB

			lda BulletX_MSB
			sbc #00
			sta BulletX_MSB

			beq CheckX

			cmp #255
			beq Destroy

			jmp Finish

			CheckX:

			lda BulletX_LSB
			cmp #5
			bcs Finish

			Destroy:

			lda #0
			sta BulletX_LSB
			sta BulletX_MSB


		Finish:

		rts
	}

	UpdateBulletData: {

		lda #BulletPointer
		sta SPRITE_POINTERS + 7

		lda BulletX_LSB
		sta VIC.SPRITE_7_X

		lda BulletY
		sta VIC.SPRITE_7_Y

		lda BulletX_MSB
		beq MSB_Off

		MSB_On:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + 7
			sta VIC.SPRITE_MSB
			jmp Done

		MSB_Off:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 7
			sta VIC.SPRITE_MSB

		Done:

			rts

	}

	CheckAnimation: {

		CheckTimer:

			dec EnemyAnimationTimer
			bpl Finish

		Ready:

			lda EnemyAnimationTimer + 1
			sta EnemyAnimationTimer

			ldx EnemyFrameIndex
			inx
			txa
			cmp EnemyFrameCount

		Reset:

			bne ApplyFrame
			lda #$00

		ApplyFrame:

			sta EnemyFrameIndex	
		
		Finish:


		rts
	}



	SpriteUpdate: {

		sta StoredXReg
		tax
		clc
		adc #5
		sta EndID

		lda #0
		sta CurrentID

		Loop:

			stx StoredXReg

			lda EnemyActive, x
			beq EndLoop

			CheckWhetherDying:

				lda EnemyDying, x
				beq NotDying

			Dying:





			NotDying:


			EndLoop:

				jsr DrawSprite

				inc CurrentID
				ldx StoredXReg

				inx
				cpx EndID
				bcc Loop



		rts

	}


	CheckHitShip: {

		ldx StoredXReg

		lda EnemyActive, x
		beq Finish

		lda EnemyDying, x
		bne Finish

		lda SHIP.IsDying
		bne Finish

		lda EnemyX2, x
		bne Finish

		lda SHIP.PosY
		ldy EnemyY1, x

		lda SHIP.PosY
		sec
		sbc EnemyY1, x
		clc
		adc #6
		cmp #12

		bcs Finish	

		CheckX:

			sec				// set carry for borrow purpose
			lda EnemyX1, x
			clc
			adc #8
			sec
			sbc SHIP.PosX_LSB
			sta Diff_LSB

		cmp #24
		bcs Finish


		jsr SHIP.Destroy

	

		Finish:


		rts
	}


	DestroyWave: {

		ldx #0
		lda #0

		Loop:

			sta EnemyActive, x

			inx
			cpx #MAX_ENEMIES
			bcc Loop

			jsr AddWave

			rts


	}
	

	CheckBullet: {

		lda SHIP.BulletX_LSB
		clc
		adc SHIP.BulletX_MSB
		beq Finish

		lda EnemyActive, x
		beq Finish

		lda EnemyDying, x
		bne Finish

		jsr CheckFire

		CheckY:

			
			lda SHIP.BulletY
			sec
			sbc #7
			sec
			sbc EnemyY1, x
			clc
			adc #6
			cmp #12

			bcs Finish

		CheckX:

			sec				// set carry for borrow purpose
			lda EnemyX1, x
			clc
			adc #7
			sec
			sbc SHIP.BulletX_LSB
			sta Diff_LSB
			lda EnemyX2, x				//; do the same for the MSBs, with carry
			sbc SHIP.BulletX_MSB		//; set according to the previous result
			sta Diff_MSB

		bne Finish

		lda Diff_LSB
		bmi Finish

		cmp #20
		bcs Finish

		lda #0
		sta SHIP.BulletX_LSB
		sta SHIP.BulletX_MSB
		sta EnemyDeathTimer, x

		lda #1
		sta EnemyDying, x

		sfx(SFX_DESTROY)	

		lda EnemySpeed_MSB, x
		tax

		lda #0

		Loop:

			clc
			adc #5
			dex
			bpl Loop
			

		jsr SCORE.ScorePoints

		inc CurrentEnemyKillCount

		Finish:

			rts

	}


	CheckFire: {

		lda BulletX_LSB
		clc
		adc BulletX_MSB
		bne Finish

		jsr RANDOM.Get
		cmp #50
		bcs Finish

		lda EnemyX2, x
		bne MSB

		LSB:

		lda EnemyX1, x
		cmp #100
		bcc Finish	

		MSB:

		lda EnemyX1, x
		cmp #60
		bcs Finish

		lda EnemyY1, x
		sec
		sbc SHIP.PosY
		clc
		adc #50

		cmp #100
		bcs Finish

		lda EnemyX1, x
		sec 
		sbc #5
		sta BulletX_LSB

		lda EnemyX2, x
		sbc #0
		sta BulletX_MSB

		lda EnemyY1, x
		clc
		adc #5
		sta BulletY


		Finish:


		rts
	}

	FrameUpdate: {	

		jsr CheckAnimation
		jsr UpdateBullet
		jsr UpdateBulletData
		
		ldx #0

		Loop:

			stx StoredXReg

			jsr CheckBullet
			jsr CheckHitShip

			ldx StoredXReg

			lda EnemyActive, x
			beq EndLoop

			lda EnemyDying, x
			beq MoveX

			lda EnemyDeathTimer, x
			beq Ready

			dec EnemyDeathTimer, x
			jmp EndLoop

			Ready:

			lda #DeathTime
			sta EnemyDeathTimer, x

			ldy EnemyDeathIndex, x
			lda DeathFrames, y

			sta EnemyDeathFrame, x
			iny
			cpy #$05
			bne !Apply+
			ldy #$04
			lda #$00
			sta EnemyActive, x
			dec CurrentEnemyCount
		!Apply:
			tya
			sta EnemyDeathIndex, x

			jmp Skip


			MoveX:

				
				lda EnemyX0, x
				sec
				sbc EnemySpeed_LSB, x
				sta EnemyX0, x

				lda EnemyX1, x
				sbc #0
				sta EnemyX1, x

				lda EnemyX2, x
				sbc #0
				sta EnemyX2, x

				lda EnemyX1, x
				sec
				sbc EnemySpeed_MSB, x
				sta EnemyX1, x

				lda EnemyX2, x
				sbc #0
				sta EnemyX2, x



				bne Skip

			CheckIfOffScreen:

				lda EnemyX1, x
				cmp #4
				bcs Skip
				lda #$00
				sta EnemyActive, x
				dec CurrentEnemyCount

			Skip:

			EndLoop:

				inx
				cpx EnemiesThisWave
				beq Finish

				jmp Loop

			Finish:


			lda CurrentEnemyCount
			bne NoNewWave

			lda CurrentEnemyKillCount
			cmp EnemiesThisWave
			bcc NoBonus

			lda #200
			jsr SCORE.ScorePoints


			NoBonus:

			jsr AddWave

			NoNewWave:
	

		rts


	}

	DrawSprite: {

			ldx StoredXReg

			lda CurrentID
			asl
			tay

			lda EnemyActive, x
			bne Draw
			lda #$00
			sta VIC.SPRITE_2_X, y
			sta VIC.SPRITE_2_Y, y
			jmp Finish

		Draw:

			lda EnemyType, x
			sta CurrentEnemyType

			lda EnemyDying, x
			beq Normal
			lda EnemyDeathFrame, x
			bne Set
		Normal:

			ldx CurrentEnemyType
			lda EnemyStartFrames, x
			clc
			adc EnemyFrameIndex

			
		Set:
			ldx CurrentID

			sta SPRITE_POINTERS + 2, x

			ldx StoredXReg
			
			lda EnemyX1, x
			sta VIC.SPRITE_2_X, y
			lda EnemyY1, x

			sta VIC.SPRITE_2_Y, y

			ldy CurrentEnemyType
			lda EnemyColors, y

			ldx CurrentID
			sta VIC.SPRITE_COLOR_2, x

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 2, x

			ldx StoredXReg
			ldy EnemyX2, x
			beq MSB_Off

			MSB_On:	

			ldx CurrentID
			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + 2, x
			jmp Skip

			MSB_Off:

			ldx CurrentID
			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 2, x

		Skip:
			sta VIC.SPRITE_MSB

		//	jsr CheckVsBullets

		Finish:
			

			rts
	}




}