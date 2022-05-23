GENERATE: {

	.label MAX_PEEPS = 16

	Hats:		.fill MAX_PEEPS, 0
	Eyes:		.fill MAX_PEEPS, 0
	Ears:		.fill MAX_PEEPS, 0
	Noses:		.fill MAX_PEEPS, 0
	Mouths:		.fill MAX_PEEPS, 0
	Heads:		.fill MAX_PEEPS, 0
	Colours: 	.fill MAX_PEEPS, 0
	PosX:		.fill MAX_PEEPS, 0
	PosY:		.fill MAX_PEEPS, 0


	ClueTypes:		.fill 3, 0
	ClueIDs:		.fill 3, 0
	CluePointers:	.fill 3,0 

	MaxByType:	.byte 8, 16, 8, 8, 8, 4, 8
	AndByType:	.byte 7, 15, 7, 7, 7, 3, 7
	TypeSpriteStart:	.byte 64, 72, 88, 96, 104, 112

	SpriteAddressLookups:	.fillword MAX_PEEPS, $C400 + (64 * i)

	HatData:	.fillword NUM_HATS, 40960 + (64 * i)
	EyeData:	.fillword NUM_EYES, 41472 + (64 * i)
	EarData:	.fillword NUM_EARS, 42496 + (64 * i)
	NoseData:	.fillword NUM_NOSES, 43008 + (64 * i)
	MouthData:	.fillword NUM_MOUTHS, 43520 + (64 * i)
	HeadData:	.fillword NUM_HEADS, 44032 + (64 * i)

	Composite:	.fill 64, 0

	OptionsByType:	.byte NUM_HATS, NUM_EYES, NUM_EARS, NUM_NOSES, NUM_MOUTHS, NUM_HEADS, NUM_COLOURS


	NextPeepID:		.byte 0

	ColourLookup:	.byte CYAN, GREEN, BLUE, YELLOW, ORANGE, LIGHT_BLUE, PURPLE, GRAY

	PeepColours:	.fill MAX_PEEPS, 0

	SpriteX:	.byte 32, 59, 109, 141, 45, 90, 210, 174
	SpriteY:	.byte 92, 159, 120, 210, 111, 156, 124, 195

	CluePersonDone:	.byte 0
	MatchingClues:	.byte 0

	.label UseClueChance = 220

	Initialise: {

		lda #16
		sta SPRITE_POINTERS

		lda #CYAN
		sta VIC.SPRITE_COLOR_0

		lda #220
		sta VIC.SPRITE_0_X

		lda #100
		sta VIC.SPRITE_0_Y

		ldx #0
		ldy #0

		Loop:

			lda SpriteY, x
			sta VIC.SPRITE_0_Y, y

			lda SpriteX, x
			sta VIC.SPRITE_0_X, y

			stx ZP.StoredXReg

			txa
			clc
			adc #16

			ldx ZP.StoredXReg

			sta SPRITE_POINTERS, x

			inx
			iny
			iny
			cpx #8
			bcc Loop


		rts
	}


	NewLevel: {

		lda #0
		sta CluePersonDone

		jsr DecideMainTraits


		rts
	}

	DecideMainTraits: {
		
		GetRandom:

			jsr RANDOM.Get
			and #%00000111
			cmp #7
			bcs GetRandom

			sta ClueTypes		

		GetRandom2:

			jsr RANDOM.Get
			and #%00000111
			cmp #7
			bcs GetRandom2

			cmp ClueTypes		
			beq GetRandom2

			sta ClueTypes + 1

		GetRandom3:

			jsr RANDOM.Get
			and #%00000111
			cmp #7
			bcs GetRandom3

			cmp ClueTypes		
			beq GetRandom3
 
			cmp ClueTypes + 1	
			beq GetRandom3

			sta ClueTypes + 2


		ldy #0

		Loop:

			.break

			lda ClueTypes, y
			tax
			
			jsr RANDOM.Get
			and AndByType, x

			sta ClueIDs, y

			clc
			adc TypeSpriteStart, x
			sta CluePointers, y

			iny
			cpy #3
			bcc Loop



		rts
	}

	CheckIfClue: {

		ldy #255
		sty ZP.Amount

		cmp ClueTypes
		bne NotClue1

		Clue1:

		ldy #0
		sty ZP.Amount
		rts

		NotClue1:

		cmp ClueTypes + 1
		bne NotClue2

		Clue2:

		ldy #1
		sty ZP.Amount
		rts

		NotClue2:

		cmp ClueTypes + 2
		bne NotClue3


		ldy #2
		sty ZP.Amount

		NotClue3:

		rts
	}


// .label HAT = 0
// .label EYES = 1
// .label EARS = 2
// .label NOSE = 4
// .label MOUTH = 5
// .label HEAD = 6
// .label COLOUR = 7

	CreateNewPeep: {

		ldx #0
		lda #0
		sta MatchingClues

		ClearLoop:

			sta Composite, x

			inx 
			cpx #64
			bcc ClearLoop


		lda NextPeepID
		asl
		tax

		lda SpriteAddressLookups, x
		sta ZP.SpriteAddress

		lda SpriteAddressLookups + 1, x
		sta ZP.SpriteAddress + 1


		Head:

			lda #HEAD
			jsr CheckIfClue

			.break

			ldy ZP.Amount
			bmi UseRandomHead

		HeadIsClue:

			lda CluePersonDone
			beq UseSpecificHead

			jsr RANDOM.Get	
			cmp #UseClueChance
			bcs UseSpecificHead

			jmp UseRandomHead

		UseSpecificHead:

			lda ClueIDs, y
			asl
			tax
			jmp GetHeadData

		UseRandomHead:

			jsr RANDOM.Get
			and #%00000011
			asl
			tax

		GetHeadData:

			lda HeadData, x
			sta ZP.HeadAddress

			lda HeadData + 1, x
			sta ZP.HeadAddress + 1

			ldy #0

			Loop:

				lda (ZP.HeadAddress), y
				sta (ZP.SpriteAddress), y

				iny
				cpy #64
				bcc Loop


		Hat:

			lda #HAT
			jsr CheckIfClue

			ldy ZP.Amount
			bmi UseRandomHat

		HatIsClue:

			lda CluePersonDone
			beq UseSpecificHat

			jsr RANDOM.Get	
			cmp #UseClueChance
			bcs UseSpecificHat

			jmp UseRandomHat

		UseSpecificHat:

			lda ClueIDs, y
			asl
			tax
			jmp GetHatData


		UseRandomHat:

			jsr RANDOM.Get
			and #%00000111
			asl
			tax

		GetHatData:

			lda HatData, x
			sta ZP.DataAddress

			lda HatData + 1, x
			sta ZP.DataAddress + 1

			ldy #0

			HatLoop:

				lda Composite, y
				ora (ZP.DataAddress), y
				sta Composite, y

				iny
				cpy #64
				bcc HatLoop

		Eyes:

			lda #EYES
			jsr CheckIfClue

			.break

			ldy ZP.Amount
			bmi UseRandomEyes

		EyesIsClue:

			lda CluePersonDone
			beq UseSpecificEyes

			jsr RANDOM.Get	
			cmp #UseClueChance
			bcs UseSpecificEyes

			jmp UseRandomEyes

		UseSpecificEyes:

			lda ClueIDs, y
			asl
			tax
			jmp GetEyesData

		UseRandomEyes:

			jsr RANDOM.Get
			and #%00001111
			asl
			tax

		GetEyesData:


			lda EyeData, x
			sta ZP.DataAddress

			lda EyeData + 1, x
			sta ZP.DataAddress + 1

			ldy #0

			EyeLoop:

				lda Composite, y
				ora (ZP.DataAddress), y
				sta Composite, y

				iny
				cpy #64
				bcc EyeLoop

		Ears:

			lda #EARS
			jsr CheckIfClue

			.break

			ldy ZP.Amount
			bmi UseRandomEars

		EarsIsClue:

			lda CluePersonDone
			beq UseSpecificEars

			jsr RANDOM.Get	
			cmp #UseClueChance
			bcs UseSpecificEars

			jmp UseRandomEars

		UseSpecificEars:

			lda ClueIDs, y
			asl
			tax
			jmp GetEarsData

		UseRandomEars:

			jsr RANDOM.Get
			and #%00000111
			asl
			tax

		GetEarsData:

			lda EarData, x
			sta ZP.DataAddress

			lda EarData + 1, x
			sta ZP.DataAddress + 1

			ldy #0

			EarLoop:

				lda Composite, y
				ora (ZP.DataAddress), y
				sta Composite, y

				iny
				cpy #64
				bcc EarLoop

		Nose:

			lda #NOSE
			jsr CheckIfClue

			.break

			ldy ZP.Amount
			bmi UseRandomNose

		NoseIsClue:

			lda CluePersonDone
			beq UseSpecificNose

			jsr RANDOM.Get	
			cmp #UseClueChance
			bcs UseSpecificNose

			jmp UseRandomNose

		UseSpecificNose:

			lda ClueIDs, y
			asl
			tax
			jmp GetNoseData

		UseRandomNose:

			jsr RANDOM.Get
			and #%00000111
			asl
			tax

		GetNoseData:

			lda NoseData, x
			sta ZP.DataAddress

			lda NoseData + 1, x
			sta ZP.DataAddress + 1

			ldy #0

			NoseLoop:

				lda Composite, y
				ora (ZP.DataAddress), y
				sta Composite, y

				iny
				cpy #64
				bcc NoseLoop


		Mouth:

			lda #MOUTH
			jsr CheckIfClue

			.break

			ldy ZP.Amount
			bmi UseRandomMouth

		MouthIsClue:

			lda CluePersonDone
			beq UseSpecificMouth

			jsr RANDOM.Get	
			cmp #UseClueChance
			bcs UseSpecificMouth

			jmp UseRandomMouth

		UseSpecificMouth:

			lda ClueIDs, y
			tax
			jmp GetMouthData

		UseRandomMouth:

			jsr RANDOM.Get
			and #%00000111
			asl
			tax

		GetMouthData:

			lda MouthData, x
			sta ZP.DataAddress

			lda MouthData + 1, x
			sta ZP.DataAddress + 1

			ldy #0

			MouthLoop:

				lda Composite, y
				ora (ZP.DataAddress), y
				sta Composite, y
				
				iny
				cpy #64
				bcc MouthLoop


		ldy #0

		CompositeLoop:

			lda Composite, y
			and #%00000011
			sta ZP.Amount
			beq NoFourthPair

			lda (ZP.SpriteAddress), y
			and #%11111100
			ora ZP.Amount
			sta (ZP.SpriteAddress), y

		NoFourthPair:

			lda Composite, y
			and #%00001100
			sta ZP.Amount
			beq NoThirdPair

			lda (ZP.SpriteAddress), y
			and #%11110011
			ora ZP.Amount
			sta (ZP.SpriteAddress), y

		NoThirdPair:

			lda Composite, y
			and #%00110000
			sta ZP.Amount
			beq NoSecondPair

			lda (ZP.SpriteAddress), y
			and #%11001111
			ora ZP.Amount
			sta (ZP.SpriteAddress), y

		NoSecondPair:

			lda Composite, y
			and #%11000000
			sta ZP.Amount
			beq NoFirstPair

			lda (ZP.SpriteAddress), y
			and #%00111111
			ora ZP.Amount
			sta (ZP.SpriteAddress), y

		NoFirstPair:

			iny
			cpy #64
			bcc CompositeLoop


		Colour:

			ldx NextPeepID

			jsr RANDOM.Get
			and #%00000111
			tay
			lda ColourLookup, y
			sta Colours, x

			sta VIC.SPRITE_COLOR_0, x

			inc NextPeepID



		lda #1
		sta CluePersonDone
		

		rts
	}





}