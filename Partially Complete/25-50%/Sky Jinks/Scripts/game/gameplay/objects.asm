SpriteMSB:	.fill MAX_SPRITES, 0
SpriteFrac:	.fill MAX_SPRITES, 0

OBJECTS: {


	.label OBJECT_GATE = 0
	.label OBJECT_TREE = 1
	.label OBJECT_BALLOON = 2
	.label OBJECT_CLOUD = 3

	Pointers:		.byte 017, 019, 020, 029
	Sprites:		.byte 001, 001, 002, 003
	XOffset:		.byte 000, 000, 000, 024
	YOffset:		.byte 000, 000, 021, 000
	ShadowPointers: .byte 018, 038, 022, 026
	ShadowXOffset:	.byte 002, 002, 006, 024
	ShadowYOffset:	.byte 020, 020, 025, 026
	Colours:		.byte 255, LIGHT_GREEN, BLUE, WHITE
	

	NextGate:		.byte 0


	GateColours:	.byte BLUE, RED
	StartX:			.byte 40, 192


	PosX_LSB:		.fill MAX_SPRITES - 6, 0
	PosX_MSB:		.fill MAX_SPRITES - 6, 0
	PosY:			.fill MAX_SPRITES - 6, 0
	PosY_Frac:		.fill MAX_SPRITES - 6, 0
	PosX_Frac:		.fill MAX_SPRITES - 6, 0



	ObjectList:				.byte 0, 0
	ListLength:				.byte 2
	NextSpriteID:			.byte 0
	SpriteIDS:				.fill MAX_SPRITES - 6, i

	DistanceTravelledFrac:		.byte 0
	DistanceTravelled:			.byte 0


	.label StartY = 20

	SpeedPixel:			.byte 1, 1
	SpeedFrac:			.byte 100, 200


	.label LAST_SPRITE = MAX_SPRITES - 5

	GenerateGate: {

		ldy #OBJECT_GATE

		lda #StartY
		sta PosY



		lda #150
		sta PosX_LSB

		lda #127
		sta PosX_Frac

		lda #0
		sta PosX_MSB

		ldx NextGate
		lda GateColours,x 
		sta ZP.Colour

		lda StartX, x
		sta PosX_LSB

		Again:

		jsr RANDOM.Get
		and #%0111111
		bcs Again

		clc
		adc PosX_LSB
		sta PosX_LSB

		lda PosX_MSB
		adc #0
		sta PosX_MSB
		
		jsr SetupSprites

		lda NextGate
		eor #%00000001
		sta NextGate

		rts
	}


	GetSpriteID: {

		ldx NextSpriteID
		txa

		inx
		cpx #LAST_SPRITE
		bcc Okay

		ldx #0
		Okay:

		stx	NextSpriteID
		tax

		rts
	}

	FrameUpdate: {

		lda DistanceTravelledFrac
		clc
		adc SpeedFrac
		sta DistanceTravelledFrac

		lda DistanceTravelled
		adc SpeedPixel
		sta DistanceTravelled

		cmp #180
		bcc Nope

		jsr GenerateGate

		lda #0
		sta DistanceTravelled
		sta DistanceTravelledFrac

		Nope:

		ldx #0
		ldy PLANE.Speed

		Loop:

			lda SpriteY, x
			beq EndLoop

			lda SpriteFrac, x
			clc
			adc SpeedFrac, y
			sta SpriteFrac, x

			lda SpriteY, x
			adc SpeedPixel, y
			sta SpriteY, x

			cmp #245
			bcc Okay

			lda #0
			sta SpriteY, x

			Okay:



		EndLoop:

				inx
				cpx #MAX_SPRITES - 5
				bcc Loop





		rts
	}

	SetupSprites: {

		// y = objectType

		lda #0
		sta ZP.Amount

		SpriteLoop:

			sty ZP.CurrentID

			jsr GetSpriteID

			lda Pointers, y
			clc
			adc ZP.Amount
			sta SpritePointer, x

			lda PosY
			sta SpriteY, x

			lda ZP.Colour
			sta SpriteColor, x

			lda PosX_LSB
			sta SpriteX, x

			lda PosX_MSB
			sta SpriteMSB, x

			ldy ZP.Amount
			beq NoOffset

		Offsets:

			lda XOffset, y
			clc
			adc SpriteX, x
			sta SpriteX, x

			lda SpriteMSB, x
			adc #0
			sta SpriteMSB, x


			lda YOffset, y
			clc
			adc SpriteY, x
			sta SpriteY, x

		NoOffset:

			ldy ZP.CurrentID

			lda SpriteMSB, x
			beq NoMSB2

		MSB2:

			 lda SpriteColor, x
			 ora #%10000000
			 sta SpriteColor, x
			 jmp Shadow

		NoMSB2:

			lda SpriteColor, x
			and #%01111111
			sta SpriteColor, x


		Shadow:

			jsr GetSpriteID

			lda ShadowPointers, y
			clc
			adc ZP.Amount
			sta SpritePointer, x

			lda PosY
			clc
			adc ShadowYOffset, y
			sta SpriteY, x

			lda PosX_MSB
			sta SpriteMSB, x

			lda PosX_LSB
			clc
			adc ShadowXOffset, y
			sta SpriteX, x

			lda #DARK_GRAY
			sta SpriteColor, x

			lda SpriteMSB, x
			adc #0
			sta SpriteMSB, x

			beq NoMSB

		MSB:

			 lda SpriteColor, x
			 ora #%10000000
			 sta SpriteColor, x
			 jmp DoneMSB

		NoMSB:

			lda SpriteColor, x
			and #%01111111
			sta SpriteColor, x

		DoneMSB:

			

			inc ZP.Amount

			lda Sprites, y
			cmp ZP.Amount
			beq Done

			jmp SpriteLoop

		Done:




		rts
	}






}