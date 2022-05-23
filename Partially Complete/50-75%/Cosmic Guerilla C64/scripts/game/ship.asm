SHIP: {


	CharX:			.byte 0, 0, 0
	CharY:			.byte 23, 5, 9
	OffsetX:		.byte 0, 0, 0
	UpdateChars:	.byte 0, 0, 0
	MovedChars:		.byte 0, 0, 0
	PrevCharX:		.byte 0, 0, 0
	Active:			.byte 1, 0, 0

	BulletCharX:		.byte 0
	BulletCharY:		.byte 0
	BulletOffsetX:		.byte 0
	BulletDead:			.byte 0

	.label CentreCharX = 13
	.label BlankCharacterID = 32
	.label BulletTime = 1
	.label BulletMergeID = 193
	.label ExplodeCharacter2 = 142
	.label ExplodeTime = 10
	.label DeathTime = 79

	CharLookups:	.byte 77, 129, 132, 135
	BulletCharLookups:	.byte 28, 29, 30, 31

	BulletChar:		.byte 0
	BulletOverChar:	.byte 32

	BulletCharAddress:	.word $F000 + 1544


	BulletTimer:	.byte 2

	Masks:		.byte %00111111, %11001111, %11110011, %11111100

	IsDead:		.byte 0
	DeathTimer:	.byte 0
	DeathFrame:	.byte 0

	DeathLookups:	.byte 114, 117, 120, 123
					.byte 126, 150, 153, 156

	CurrentPlayer:	.byte 0
	Paused:			.byte 0


	Reset: {

		ldx #2

		lda #1
		sta Active

		lda #0
		sta Active + 1
		sta Active + 2
		sta IsDead
		sta DeathTimer

		lda #BulletTime
		sta BulletTimer

		lda BulletCharAddress
		sta BulletAddress

		lda BulletCharAddress + 1
		sta BulletAddress + 1
			

		Loop:

			lda #CentreCharX
			sta CharX, x
	
			lda #0
			sta OffsetX, x

			lda Active, x
			beq EndLoop

			jsr DrawShip

			EndLoop:

				dex
				bpl Loop


		rts


	}


	DestroyBullet: {

		lda BulletCharX
		beq NoDelete

		IsBullet:

			jsr DeleteBullet

		NoDelete:
		
		lda #0
		sta BulletCharX
		sta BulletDead


		rts
	}



	FrameUpdate: {

		lda IsDead
		beq NotDead

		Dead:

			jsr ProcessDeath
			jmp Finish

		NotDead:

			ldx #0

		Loop:	

			lda Active, x
			beq EndLoop

			lda UpdateChars, x
			beq EndLoop

			CheckDelete:

				lda MovedChars, x
				beq NoDelete

				jsr DeleteShip

			NoDelete:	

				jsr DrawShip
		

			EndLoop:

				inx
				cpx #3
				bcc Loop


			jsr HandleBullet

		Finish:

		rts
	}


	Alive: {

		lda #0
		sta IsDead

		ldx #0
		jsr DrawShip

		jsr BOMBS.DestroyAll
		jsr DestroyBullet

		jsr DRAW.SetColourRam

		rts


	}

	ProcessDeath:{

		lda DeathTimer
		bne StillDead

		AliveAgain:	

			jsr Alive
			jmp Finish

		StillDead:

			and #%00000011
			cmp #3
			bne EndProcess

			ldx #0
			jsr DrawShip

			lda DeathFrame
			beq MakeFour

			MakeZero:

				lda #0
				sta DeathFrame
				jmp EndProcess

			MakeFour:

				lda #4
				sta DeathFrame

		EndProcess:

		dec DeathTimer


		Finish:



		rts
	}	


	Destroy: {

		lda #1
		sta IsDead

		lda #DeathTime
		sta DeathTimer

		jsr DRAW.SetDeadColourRam
	

		rts
	}

	HandleBullet: {

		lda BulletCharX
		beq Finish

		IsBullet:

			jsr DeleteBullet
			jsr MoveBullet
			jsr DrawBullet

			Finish:

				rts
	}


	CheckCollision: {


		lda #0
		sta BulletChar


		ldy BulletCharY
		ldx BulletCharX

		jsr PLOT.GetCharacter

		sta BulletOverChar

		cmp #BlankCharacterID
		beq Finish

		BulletHitSomething:

			tay

			lda CHAR_COLORS, y
			and #%11110000
			sta CharType
			cmp #CHAR_TYPE_EXPLOSION
			beq Finish

			cmp #CHAR_TYPE_BOMB
			bne NotSolid

			cmp #CHAR_TYPE_SOLID
			bne NotSolid

			lda #BlankCharacterID
			sta BulletOverChar

			//jmp DoneCheck

			NotSolid:

			lda BulletCharAddress
			sta BulletAddress

			lda BulletCharAddress + 1
			sta BulletAddress + 1

			lda VIC.CharsetMSB, y
			sta TableAddress + 1

			lda VIC.CharsetLSB, y
			sta TableAddress

			ldy #7

			Loop:

				lda (TableAddress), y
				sta Amount

				ldx BulletOffsetX
				and Masks, x

				cmp Amount
				beq NoChange

				Hit:

					jmp DoneCheck

				NoChange: 

					dey
					bpl Loop

			DoneCheck:

				cpy #255
				beq NeedToMerge

				jsr HitObject
				jmp Finish

			NeedToMerge:

				ldx BulletOffsetX
				lda BulletCharLookups, x
				tay

				lda VIC.CharsetMSB, y
				sta CharAddress + 1

				lda VIC.CharsetLSB, y
				sta CharAddress

				ldy #7

				MergeLoop:

					lda (TableAddress), y
					ora (CharAddress), y
					sta (BulletAddress), y

					dey
					bpl MergeLoop

				
				lda #BulletMergeID
				sta BulletChar




		Finish:





		rts
	}



	HitEnemy: {

		ldx #0

		Loop:

			lda ENEMIES.CharY, x
			cmp BulletCharY
			bne EndLoop

			lda ENEMIES.CharX, x
			tay
			cpy BulletCharX
			beq Hit

			NotFirst:

			iny
			cpy BulletCharX
			bne EndLoop

			Hit:

				lda #ENEMY_MODE_DYING
				sta ENEMIES.Mode, x

				lda #0
				sta ENEMIES.Frame, x

				jsr ENEMIES.Draw
				jmp Finish

			EndLoop:

				inx
				cpx #ENEMIES.MAX_ENEMIES
				bcc Loop

		Finish:


		rts

	}

	HitObject: {

		ldy BulletOverChar
		lda CHAR_COLORS, y
		and #%11110000
		cmp #CHAR_TYPE_ENEMY
		bne NotEnemy

		Enemy:

			jsr HitEnemy
			jmp Finish

		NotEnemy:

			jsr HitSolid
			rts

		Finish:

		lda #0
		sta BulletCharX




		rts
	}


	HitSolid: {

		lda #1
		sta BulletDead

		lda #ExplodeTime
		sta BulletTimer

		lda #BlankCharacterID
		sta BulletOverChar

		inc BulletCharY

		rts
	}


	MoveBullet: {

		lda BulletTimer
		beq Ready

		dec BulletTimer
		jmp Finish

		Ready:

			lda BulletDead
			beq NotDead

			lda #0
			sta BulletCharX
			sta BulletDead
			jmp Finish

			NotDead:

			lda #BulletTime
			sta BulletTimer

			dec BulletCharY

			jsr CheckCollision

			
		Finish:


		rts
	}

	DeleteShip: {

		stx CurrentID

		GetData:

			lda PrevCharX, x
			sta Column

			lda CharY, x
			sta Row

		DrawChars:

			lda #BlankCharacterID

			ldx Column
			ldy Row

			jsr PLOT.PlotCharacter

			inx
			jsr PLOT.PlotCharacter

			inx	
			jsr PLOT.PlotCharacter

		Finish:

			ldx CurrentID

		rts



	}



	DrawShip: {

		// x = shipID

		stx CurrentID

		GetData:

			lda CharX, x
			sta Column

			lda CharY, x
			sta Row

		CheckIfPlayer:

			cpx #0
			bne NotPlayerOrDead

		CheckDead:

			lda IsDead
			beq NotPlayerOrDead

		Dead:

			lda OffsetX, x
			clc
			adc DeathFrame
			tax
			lda DeathLookups, x
			sta CharID
			jmp DrawChars

		NotPlayerOrDead:

			lda OffsetX, x
			tax
	
			lda CharLookups, x
			sta CharID

		DrawChars:

			ldx Column
			ldy Row
			lda CharID

			jsr PLOT.PlotCharacter

			inx
			clc
			adc #1

			jsr PLOT.PlotCharacter

			inx
			clc
			adc #1

			jsr PLOT.PlotCharacter

		Finish:

			ldx CurrentID

		rts
	}


	FireBullet: {

		lda BulletCharX
		bne Finish

		SetupData:

			lda #BulletTime
			sta BulletTimer

			lda CharY
			sta BulletCharY
			dec BulletCharY

			lda #BlankCharacterID
			sta BulletOverChar

			lda CharX
			sta BulletCharX

			lda OffsetX
			clc
			adc #3
			cmp #4
			bcc Okay

			inc BulletCharX
			sec
			sbc #4

		Okay:

			sta BulletOffsetX

		GetWhetherBaseAbove:

			ldx BulletCharX
			ldy BulletCharY

			jsr PLOT.GetCharacter
			cmp #86
			bcc NoBase

			cmp #98
			bcs NoBase

		HitBase:

			jsr PlayerHitBase

			lda #0
			sta BulletCharX
			jmp Finish

		NoBase:	


			lda #0
			sta BulletChar
			sta BulletDead

			jsr DrawBullet

		Finish:

			rts

	}

	PlayerHitBase: {




		rts
	}


	DeleteBullet: {

		lda BulletCharX
		tax

		lda BulletCharY
		tay

		lda BulletOverChar
		cmp #193
		bcc Okay

		lda #BlankCharacterID

		Okay:

		jsr PLOT.PlotCharacter

		lda BulletDead
		beq Finish

		lda #BlankCharacterID

		iny
		jsr PLOT.PlotCharacter


		Finish:

	
		rts
	}


	DrawBullet: {


		lda BulletCharX
		beq Finish

		sta Column

		lda BulletCharY
		sta Row

		lda BulletDead
		beq NotDead

		jsr DrawExplosion
		jmp Finish

		NotDead:

			ldx BulletOffsetX
			
			lda BulletChar
			beq NoMerge

			jmp MergedBullet

			NoMerge:

				lda BulletCharLookups, x

			MergedBullet:

				ldx Column
				ldy Row

				jsr PLOT.PlotCharacter


		Finish:

		rts

	}


	DrawExplosion: {

		//.break

		lda BulletOffsetX
		asl
		clc
		adc #ExplodeCharacter2

		ldx Column
		ldy Row

		jsr PLOT.PlotCharacter

		iny

		clc
		adc #1

		jsr PLOT.PlotCharacter


		rts
	}
}