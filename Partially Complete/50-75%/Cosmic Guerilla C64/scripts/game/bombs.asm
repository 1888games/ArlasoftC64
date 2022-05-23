BOMBS: {

	* = * "-Bombs"

	CharX:				.byte 0, 0, 0
	CharY:				.byte 0, 0, 0
	OffsetY:			.byte 0, 0, 0
	OffsetX:			.byte 0, 0, 0
	BulletTimer:		.byte 0, 0, 0
	CharUnderBottom:	.byte 0, 0, 0
	CharUnderTop:		.byte 0, 0, 0
	Dead:				.byte 0, 0, 0

	CharAdd:			.byte 1, 0, 1, 0
	BombCooldown:		.byte 0


	.label FirstBombCharID = 161
	.label BulletTime = 1
	.label ExplodeTime = 10
	.label BlankCharacterID = 32
	.label CooldownTime = 20
	.label ExplosionCharID = 34
	.label BottomCharID = 81


	MergedChars:	.byte 194, 196, 198



	Reset: {

		ldx #2
		lda #0

		sta BombCooldown

		Loop:	

			jsr ResetBomb

			dex
			bpl Loop

		rts
	}


	ResetBomb: {

		sta CharX, x
		sta CharY, x
		sta OffsetY, x
		sta OffsetX, x
		sta CharUnderBottom, x
		sta CharUnderTop, x
		sta Dead, x

		rts
	}


	GetNextFreeID: {

		ldy #2

		Loop:

			lda CharX, y
			beq Found

			dey
			bpl Loop

		Found:

		rts
	}


	FrameUpdate: {

		lda SHIP.IsDead
		bne Finish

		ldx #2

		lda BombCooldown
		beq Loop

		dec BombCooldown

		Loop:

			stx BombID

			lda CharX, x
			beq EndLoop

			lda BulletTimer, x
			beq Ready

			NotReady:

				dec BulletTimer, x
				jmp EndLoop

			Ready:

				lda #BulletTime
				sta BulletTimer, x

				lda Dead, x
				beq NotDead

			DeleteBomb:

				jsr Delete

				ldx BombID

				lda #0
				sta CharX, x
				sta Dead, x
				jmp EndLoop

			NotDead:

				jsr MoveBomb

			EndLoop:

			ldx BombID

			dex
			bpl Loop


		Finish:


		rts
	}


	MoveBomb: {

		jsr Delete

		ldx BombID

		IncreaseOffset:

			lda OffsetY, x
			clc
			adc #1
			cmp #4
			bcc NoReset

		ResetOffset:

			lda #0

		NoReset:

			sta OffsetY, x
			tay

		CheckWhetherMoveRow:

			lda CharAdd, y
			beq DrawNow

		MoveRow:

			inc CharY, x
			lda CharY, x

		CheckWhetherHitBottom:

			cmp #24
			bcc GetCharacterMovingInto

		HitBottom:

			tay

			lda CharX, x
			tax

			jsr PLOT.GetCharacter
			sta CharID

			jsr DestroyMerge

			CheckIfAlreadyDisplayingABang:

				lda CharID
				cmp #BottomCharID
				beq DrawNow

			DontDrawIfAlreadyDestroyed:

				ldx BombID
				lda #0
				sta Dead, x
				jmp DrawNow

		GetCharacterMovingInto:

			lda CharY, x
			tay

			lda CharX, x
			tax

			jsr PLOT.GetCharacter

		CheckIfBlank:

			cmp #BlankCharacterID
			beq DrawNow

		NotBlank:

			jsr CheckCollision


		DrawNow:

		ldx BombID

		lda SHIP.IsDead
		bne Finish
	
		jsr Draw


		Finish:


		rts
	}


	Destroy: {

		dec CharY, x
		lda #1
		sta Dead, x

		lda #ExplodeTime
		sta BulletTimer, x

		rts

	}






	DestroyAll: {

		ldx #2

		Loop:

			stx BombID

			lda CharX, x
			beq DontDelete

			jsr Delete

			DontDelete:

			ldx BombID

			jsr ResetBomb

			EndLoop:	

				dex
				bpl Loop

		lda #50
		sta BombCooldown


		rts
	}

	CheckCollision: {

		ldy #0
		sty Collided

		sta CharID

		GetCharType:

			tay
			lda CHAR_COLORS, y
			and #%11110000
			sta CharType

		CheckWhetherCanHit:

			cmp #CHAR_TYPE_EXPLOSION
			beq Missed

			cmp #CHAR_TYPE_ENEMY
			beq Missed
			
		GetCharMemoryAddress:


			lda VIC.CharsetMSB, y
			sta TableAddress + 1

			lda VIC.CharsetLSB, y
			sta TableAddress

		CheckPixelsAgainstBomb:

			ldy #0

			Loop:

				ldx BombID

				lda (TableAddress), y
				sta Amount

				lda OffsetX, x
				tax
				lda Amount
				and SHIP.Masks, x

				cmp Amount
				beq NoChange

				Hit:

					jmp DoneCheck

				NoChange: 

					iny
					cpy #8
					bcc Loop

		DoneCheck:

			cpy #8
			beq Missed

			jsr HitObject
			jmp Finish


		Missed:



		Finish:


		rts
	}


	HitObject: {

		ldx BombID


		lda CharType
		cmp #CHAR_TYPE_PLAYER
		bne NotPlayer

		Player:
			jsr Destroy
			jsr SHIP.Destroy
			jmp Finish
		
		NotPlayer:

			cmp #CHAR_TYPE_BASE
			bne NotBase

		Base:

			jsr BASE.HitByBomb

			jsr DestroyMerge
			jmp Finish

		NotBase:
	
			jsr Destroy
		// can only be solid or player




		Finish:

		rts
	}


	DestroyMerge: {

		ldx BombID

		lda #1
		sta Dead, x

		lda #ExplodeTime
		sta BulletTimer, x

		rts

	}




	DropBomb: {


		lda BombCooldown
		bne Finish

		jsr GetNextFreeID

		cpy #255
		beq Finish

		SetupData:

			lda #0
			sta Dead, y
			sta OffsetY, y
			sta CharUnderBottom, y
			sta CharUnderTop, y

			lda #BulletTime
			sta BulletTimer, y

			lda #CooldownTime
			sta BombCooldown

			lda ENEMIES.CharY, x
			clc
			adc #2
			sta CharY, y
			
			lda ENEMIES.CharX, x
			sta CharX, y

			lda ENEMIES.OffsetX, x
			clc
			adc #3
			cmp #4
			bcc Okay

			pha
			lda CharX, y
			clc
			adc #1
			sta CharX, y
			pla

			sec
			sbc #4

		Okay:

			sta OffsetX, y
			tya
			tax

			jsr Draw

		Finish:


		rts
	}



	Delete: {

		stx BombID

		lda CharX, x
		sta Column

		lda CharY, x
		sta Row

		lda CharUnderBottom, x
		cmp #193
		bcc Okay

		lda #BlankCharacterID

		Okay:
		sta CharID

		ldx Column
		ldy Row

		jsr PLOT.PlotCharacter

		ldx BombID
		lda CharUnderTop, X
		cmp #193
		bcc Okay2

		lda #BlankCharacterID

		Okay2:

		ldx Column
		dey

		jsr PLOT.PlotCharacter

		rts

	}

	Draw: {

		stx BombID

		lda CharX, x
		sta Column

		lda CharY, x
		sta Row

		lda MergedChars, x
		sta DestinationID

		lda Dead, x
		beq Alive

		Destroyed:

			lda OffsetX, x
			clc
			adc #ExplosionCharID
			sta Source1ID

			lda #BlankCharacterID
			sta Source1ID_b
			jmp GetCharUnderBomb

		Alive:

			lda OffsetX, x
			asl
			asl
			asl
			sta Amount

			lda OffsetY, x
			asl
			clc
			adc Amount
			adc #FirstBombCharID
			sta Source1ID
			clc
			adc #1
			sta Source1ID_b

		GetCharUnderBomb:

			ldx Column
			ldy Row

			jsr PLOT.GetCharacter
			sta Source2ID

			ldx BombID
			sta CharUnderBottom, x

			tay
			lda CHAR_COLORS, y
			and #%11110000
			cmp #CHAR_TYPE_BOMB
			bne UseCharUnder

			lda #BlankCharacterID
			sta CharUnderBottom, x

			UseCharUnder:

		MergeWithBomb:

			jsr DRAW.MergeChars

		DrawNewChar:

			ldx Column
			ldy Row
			lda DestinationID

			jsr PLOT.PlotCharacter

		GetSecondCharUnder:

			inc DestinationID
			lda Source1ID_b
			sta Source1ID

			dey

			jsr PLOT.GetCharacter
			sta Source2ID

			ldx BombID
			sta CharUnderTop, x

			tay
			lda CHAR_COLORS, y
			and #%11110000
			cmp #CHAR_TYPE_BOMB
			bne UseCharUnder2

			lda #BlankCharacterID
			sta CharUnderTop, x

			UseCharUnder2:

		MergeWithBomb2:

			jsr DRAW.MergeChars

		DrawNewChar2:

			ldx Column
			ldy Row
			lda DestinationID

			jsr PLOT.PlotCharacter

		rts
	}




}