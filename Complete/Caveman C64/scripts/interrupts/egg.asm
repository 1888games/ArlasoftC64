EGG:{

	.label UseSpritePosition = 1
	.label LayingPosition = 2
	.label RelayingPosition = 4
	.label LayEggDelay = 3

	ObjectIDs: .byte 17, 42, 18, 19

	Position: .byte 2
	EggHatched: .byte 0
	EggStolen: .byte 0
	LayingEgg: .byte 1
	HatchCounter: .byte 8, 8
	DanceCounter: .byte 0, 4

	BabyShowing: .byte 1

	Reset:{


		lda #ZERO
		sta EggStolen
		sta EggHatched

		lda #ONE
		sta LayingEgg

		jsr DeleteEgg
		//jsr HideBabies

		lda #2
		sta Position

		rts

	}



	ShowBaby1: {

		ldy #ZERO
		ldx #46
		jsr CHAR_DRAWING.ColourObject

		ldy #ZERO
		ldx #43
		jsr CHAR_DRAWING.ColourObject

		ldy #ONE
		ldx #20
		jsr CHAR_DRAWING.ColourObject

		ldy #ONE
		ldx #44
		jsr CHAR_DRAWING.ColourObject

		ldy #ONE
		ldx #45
		jsr CHAR_DRAWING.ColourObject

		rts


	}


	ShowBaby2: {

		ldy #ONE
		ldx #46
		jsr CHAR_DRAWING.ColourObject

		ldy #ONE
		ldx #43
		jsr CHAR_DRAWING.ColourObject

		ldy #ZERO
		ldx #20
		jsr CHAR_DRAWING.ColourObject

		ldy #ZERO
		ldx #44
		jsr CHAR_DRAWING.ColourObject

		ldy #ZERO
		ldx #45
		jsr CHAR_DRAWING.ColourObject

		rts

	}


	HideBabies: {

		ldy #ZERO
		ldx #43
		jsr CHAR_DRAWING.ColourObject

		ldy #ZERO
		ldx #45
		jsr CHAR_DRAWING.ColourObject

		ldy #ZERO
		ldx #20
		jsr CHAR_DRAWING.ColourObject

		ldy #ZERO
		ldx #44
		jsr CHAR_DRAWING.ColourObject

		ldy #ZERO
		ldx #46
		jsr CHAR_DRAWING.ColourObject

		rts

	}


	Lay: {


		jsr DeleteEgg
		lda #LayingPosition
		sta Position

		lda #ZERO
		sta EggHatched
		sta EggStolen
		//jsr SOUND.SFX_LOW


		jsr DrawEgg

		rts


	}



	DeleteEgg:{

	
		ldy Position
		ldx ObjectIDs, y
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		Finish:

		rts
	}




	Update:{	

		lda DanceCounter
		beq NotDancing

		dec DanceCounter
		jsr SOUND.SFX_STEAL

		lda BabyShowing
		beq Baby2

		lda #ZERO
		sta BabyShowing
		jsr ShowBaby1
		jmp CheckIfDone

		Baby2:

			lda #ONE
			sta BabyShowing
			jsr ShowBaby2

		CheckIfDone:

			lda DanceCounter
			bne Finish

			lda #LayEggDelay
			sta LayingEgg
			jsr DeleteEgg
			jsr HideBabies

			rts

		NotDancing:

			lda LayingEgg
			beq NotLaying

			dec LayingEgg
			beq NowLayEgg

			jsr DeleteEgg

			NowLayEgg:

				jsr Lay
				jmp Finish

			NotLaying:

				lda EggStolen
				bne Finish

				lda EggHatched
				bne RollTowardsVolcano

				lda Position
				beq EggWaiting

		RollTowardsPlayer:

			jsr DeleteEgg
			dec Position
			beq StartCounter

			jmp Finish

		RollTowardsVolcano:

			//inc $d021
			jsr DeleteEgg
			inc Position
			lda Position
			cmp #RelayingPosition
			beq EggHatching

			jmp Finish

		EggHatching: 	

			//lda #12
			//sta $d021
			dec Position
			jsr DrawEgg
			jsr HatchEgg
			rts

		StartCounter:

			lda HatchCounter + 1
			sta HatchCounter
			//sta $d021
			jmp Finish

		EggWaiting:

			dec HatchCounter
			lda HatchCounter
			//sta $d021
		
			beq StartRollingBack

			jmp Finish

		StartRollingBack:

			lda #ONE
			sta EggHatched



		Finish: 

			jsr DrawEgg
			rts


	}


	StealEgg:{

		jsr DeleteEgg
		lda #ONE
		sta EggStolen
		sta CAVEMAN.CarryingEgg

		rts

	}



	DrawEgg:{

		lda EggStolen
		bne DontDraw

		DrawCharacter:

		ldy Position
		ldx ObjectIDs, y
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject


		DontDraw:

		rts
	}


	DrawSprite:{


		rts
	}

	HatchEgg:{

		dec EggHatched

		lda DanceCounter + 1
		sta DanceCounter
	
	
		rts
	}






}