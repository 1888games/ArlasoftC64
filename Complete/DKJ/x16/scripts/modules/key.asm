KEY:{

	ObjectIDs: 	.byte 49, 48, 47, 46
	Positions:	.byte 0, 0, 1, 2, 3, 2, 1
	Position: 	.byte 0
	WillCatch:	.byte 0, 0, 0, 1, 1, 0, 0
	Active:		.byte 1
	ForceKey: 	.byte 0

	.label CaughtKeyFrame = 24
	.label MissedKeyFrame = 12
	.label InDitchFrame = 18
	.label OpenLockFrame = 24
	.label FallGracefullyFrame = 13
	.label TicksWhileUnlocking = 4
	.label TicksWhileFalling = 2

	Initialise: {

		jsr Reset
		rts

	}


	Reset:{

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

			jsr MONKEY.Delete
			lda #CaughtKeyFrame
			sta MONKEY.CellID
			jsr SOUND.MoveMonkey

			lda #ONE
			sta MONKEY.GotKey
			sta MONKEY.AtCage

			ldx CAGE.SectionsUnlocked
			inc CAGE.SectionsUnlocked
			lda #ONE
			sta CAGE.SectionUnlocked, x

			jmp Complete


		MissedKey:
			jsr MONKEY.Delete
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
		jsr MONKEY.Delete
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

		jsr MONKEY.Delete
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
		jsr CAGE.UnlockCage



		Complete:
		
		rts

	}

	

	DrawKey2:
		jsr DrawKey
		rts


	LoseLife: {

		jsr LIVES.LoseLife

		jsr MONKEY.Reset
		jsr Reset
		jsr CAGE.Reset
		jsr ENEMIES.RemoveClose

		jsr SOUND.MoveMonkey

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

		jsr SOUND.DeathSound
		rts



	}

	GoingForKey2:
		jmp GoingForKey


	GameOver:{
		
		jmp MAIN.TitleScreen

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

		jsr CAGE.TurnOffMonkey

		lda #ZERO
		sta MONKEY.AtCage

		jsr MONKEY.Delete
		lda #FallGracefullyFrame
		sta MONKEY.CellID
		jsr SOUND.MoveMonkey



		Wait:

			rts

	}

	InDitch2:
		jmp InDitch


	FallGracefully: {

		dec MONKEY.FallGracefully
		lda MONKEY.FallGracefully
		bne Wait

		jsr SOUND.MoveMonkey
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

		//jsr SID.DieSound
		rts


	}

	Update: {


		ldx Position
		ldy Positions, x
		ldx ObjectIDs, y

		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		lda MONKEY.GoingForKey
		beq NotGoingForKey

		jmp GoingForKey

		NotGoingForKey:

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

		lda MONKEY.AtCage
		bne NoKey


		lda ForceKey
		bne SkipCheck

		lda #ZERO
		sta ForceKey

		lda Active
		beq NoKey

		SkipCheck:

		clc
		ldx Position
		ldy Positions, x
		ldx ObjectIDs, y
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject
		

		NoKey:

		rts

	}



}