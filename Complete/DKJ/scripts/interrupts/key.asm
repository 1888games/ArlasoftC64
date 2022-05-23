KEY:{

	Frames: 	.byte 23, 22, 39, 38
	Positions:	.byte 0, 0, 1, 2, 3, 2, 1
	Position: 	.byte 0
	XPos:		.byte 150, 146, 138, 125
	YPos:		.byte 80, 81, 82, 82
	WillCatch:	.byte 0, 0, 0, 1, 1, 0, 0
	Active:		.byte 1
	ForceKey: 	.byte 0

	.label CaughtKeyFrame = 18
	.label MissedKeyFrame = 12
	.label InDitchFrame = 23
	.label OpenLockFrame = 24
	.label FallGracefullyFrame = 13
	.label TicksWhileUnlocking = 4
	.label TicksWhileFalling = 2

	Initialise: {

		jsr Reset
		rts

	}


	Reset:{

		lda #BLACK
		sta VIC.SPRITE_COLOR_4
		sta ForceKey
		lda #ONE
		sta Active

		rts

	}

	GoingForKey: {


		dec MONKEY.GoingForKey
		lda MONKEY.GoingForKey
		bne Wait

		ldy Position
		lda WillCatch, y
		beq MissedKey

		CaughtKey:

			lda #CaughtKeyFrame
			sta MONKEY.CellID
			jsr SID.MoveMonkey

			lda #ONE
			sta MONKEY.GotKey
			sta MONKEY.AtCage

			ldx CAGE.SectionsUnlocked
			inc CAGE.SectionsUnlocked
			lda #ONE
			sta CAGE.SectionUnlocked, x

			jmp Complete


		MissedKey:

			lda #MissedKeyFrame
			sta MONKEY.CellID 

			lda #TicksWhileFalling
			sta MONKEY.MissedKey

		Complete:

			lda #ZERO
			sta Active
			lda #ONE
			//sta ForceKey
		
		Wait:
			rts

	}
	


	MissedKey: {

		//lda #ZERO
		//sta Active

		lda #InDitchFrame
		sta MONKEY.CellID
		lda #TicksWhileFalling
		sta MONKEY.InDitch
		dec MONKEY.MissedKey

		rts

	}

	
	GotKey:{

		//dec $d020

		//lda #ZERO
		//sta Active

		lda #OpenLockFrame
		sta MONKEY.CellID
		lda #TicksWhileUnlocking
		sta MONKEY.Unlocking
		jsr SCORE.UnlockSection
		dec MONKEY.GotKey

		lda CAGE.SectionsUnlocked
		cmp #4
		bne Complete

		jsr SCORE.UnlockCage
		jsr CAGE.Smile

		Complete:
		
		rts

	}

	

	DrawKey2:
		jsr DrawKey
		rts


	LoseLife: {

		jsr LIVES.LoseLife
		jsr SID.MoveMonkey
		jsr MONKEY.Reset
		jsr Reset
		jsr CAGE.Reset
		jsr ENEMIES.RemoveClose

		lda LIVES.Value
		beq GameOver
		rts
	}

	
	InDitch:{


		dec MONKEY.InDitch
		lda MONKEY.InDitch
		bne Wait

		jsr LoseLife
		
		Wait:

		jsr SID.DieSound
		rts



	}

	GoingForKey2:
		jmp GoingForKey


	GameOver:{


		lda #1
		sta MAIN.GameIsOver

		lda #0
		sta MAIN.GameIsActive

		lda #MAIN.GameOverTimeOut
		sta MAIN.GameOverTimer

		rts

	}

	GotKey2:
		jmp GotKey

	MissedKey2:
		jmp MissedKey

	

	Unlocking:{

		dec MONKEY.Unlocking
		lda MONKEY.Unlocking
		bne Wait

	//	lda SCORE.KeyScore
	

		lda #TicksWhileFalling
		sta MONKEY.FallGracefully
		lda #FallGracefullyFrame
		sta MONKEY.CellID
		jsr SID.MoveMonkey



		Wait:

			rts

	}

	InDitch2:
		jmp InDitch


	FallGracefully: {

		dec MONKEY.FallGracefully
		lda MONKEY.FallGracefully
		bne Wait

		jsr SID.MoveMonkey
		jsr MONKEY.Reset
		jsr Reset
		jsr CAGE.Reset
		jsr ENEMIES.RemoveClose

		lda CAGE.SectionsUnlocked
		cmp #4
		bne Wait

		jsr CAGE.LockCage

		Wait:

		rts


	}


	Unlocking2: {

		jmp Unlocking
	}

	HitByEnemy: {

		lda #ZERO
		sta Active

		dec MONKEY.HitByEnemy
		lda MONKEY.HitByEnemy

		bne Wait

		jsr LoseLife
		rts

		Wait:

		jsr SID.DieSound
		rts


	}

	Update: {



		lda MONKEY.GoingForKey
		bne GoingForKey2

		lda MONKEY.GotKey
		bne GotKey2

		lda MONKEY.MissedKey
		bne MissedKey2

		lda MONKEY.InDitch
		bne InDitch2

		lda MONKEY.Unlocking
		bne Unlocking2

		lda MONKEY.FallGracefully
		bne FallGracefully

		lda MONKEY.HitByEnemy
		bne HitByEnemy

		lda Active
		beq NoKey
		
		MoveKey:

		inc Position
		lda Position
		cmp #7
		bne NoKey

		lda #ZERO
		sta Position

		
		NoKey:
			rts


	}

	DrawKey: {

		lda ForceKey
		bne SkipCheck

		lda #ZERO
		sta ForceKey

		lda Active
		beq NoKey

		SkipCheck:

		clc
		ldy Position
		ldx Positions, y
		lda Frames, x
		adc #64
		sta SPRITE_POINTERS + 4
		lda XPos, x
		sta VIC.SPRITE_4_X
		lda YPos, x
		sta VIC.SPRITE_4_Y

		lda VIC.SPRITE_MSB
		and #%11101111
		sta VIC.SPRITE_MSB
	
		//lda VIC.SPRITE_ENABLE
		//ora #%00010000
		//sta VIC.SPRITE_ENABLE

		NoKey:

		rts

	}



}