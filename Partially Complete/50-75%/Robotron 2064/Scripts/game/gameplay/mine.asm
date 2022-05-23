MINE: {

	* = * "Mine"

	.label MAX_MINES = 25
	.label CHAR_START = 31
	
	.label XBoundaryLeft = 8
	.label XBoundaryRight = 25
	.label YBoundaryUp = 6
	.label YBoundaryDown = 16

	ScreenAddress:	.fillword MAX_MINES, 0
	ColourAddress:	.fillword MAX_MINES, 0
	CharX:			.fill MAX_MINES, 0
	CharY:			.fill MAX_MINES, 0
	SpriteSpaceX:			.fill MAX_MINES, 0
	SpriteSpaceY:			.fill MAX_MINES, 0
	SpriteSpaceX_MSB:	.fill MAX_MINES, 0


	NumberToGenerate:	.byte 20
	CurrentType:		.byte 31

	CurrentID:			.byte 0


	Initialise: {

		ldx #0
		ldy #0

		lda NumberToGenerate
		beq Finish

		Loop:

			stx ZP.X
			sty ZP.Y

			jsr Generate

			ldx ZP.X
			ldy ZP.Y
			inx
			iny
			iny
			cpx NumberToGenerate
			bcc Loop



		Finish:



		rts
	}

	Generate: {

		
		StartOver:

			ldx ZP.X
			jsr SHARED.GetRandomCharPosition

			lda ZP.Row
			sta CharY, x
			tay

			lda ZP.Column
			sta CharX, x
			tax
		
			jsr PLOT.GetCharacter

			bne StartOver

		Okay:

			ldy ZP.Y
			ldx ZP.X

			lda ZP.ScreenAddress
			sta ScreenAddress, y

			lda ZP.ScreenAddress + 1
			sta ScreenAddress + 1, y
			
			lda ZP.ColourAddress
			sta ColourAddress, y

			lda ZP.ColourAddress + 1
			sta ColourAddress + 1, y

			jsr Draw
			jsr CalculateSpriteData

		rts
	}


	CalculateSpriteData: {

		lda CharY, x
		tay
		lda SpriteRowLookup, y
		sta SpriteSpaceY, x

		lda CharX, x
		tay
		lda SpriteColumnLookup, y
		sta SpriteSpaceX, x

		lda SpriteMSBLookup, y
		sta SpriteSpaceX_MSB, x

		rts
	}

	Draw: {

		lda CurrentType
		ldy #0
		sta (ZP.ScreenAddress), y

		lda #RED
		sta (ZP.ColourAddress), y


		rts
	}

	FrameUpdate: {


		SetDebugBorder(ORANGE)
		ldx #0

		Loop:

			stx ZP.X

			lda CurrentID
			asl
			tay
			sty ZP.Y

			lda ScreenAddress + 1, y
			beq NotMine
			sta ZP.ScreenAddress + 1

			lda ScreenAddress, y
			sta ZP.ScreenAddress

			ldy #0
			lda (ZP.ScreenAddress), y
			cmp #31
			bcc NotMine

			cmp #40
			bcs NotMine

			ldy ZP.Y
			lda ColourAddress, y
			sta ZP.ColourAddress

			lda ColourAddress + 1, y
			sta ZP.ColourAddress + 1

			ldy #0
			lda (ZP.ColourAddress), y
			and #%00001111
			clc
			adc #1
			cmp #8
			bcc Okay

			lda #2

			Okay:

			sta (ZP.ColourAddress), y

			//jsr CheckHumans




			NotMine:

			inc CurrentID
			lda CurrentID
			cmp NumberToGenerate
			bcc Finish

			lda #0
			sta CurrentID

			Finish:		

			ldx ZP.X
			inx
			cpx #3
			bcc Loop


		SetDebugBorder(DARK_GRAY)


		rts
	}

	CheckHumans: {

		ldx #0
		ldy CurrentID

		Loop:

			lda HUMANS.TurnCooldown, x
			beq ReadyToCheck

			dec HUMANS.TurnCooldown, x
			jmp EndLoop

			ReadyToCheck:


			lda SpriteY, x
			cmp #11
			bcc EndLoop

			sec
			sbc SpriteSpaceY, y
			clc
			adc #6

			cmp #12
			bcs EndLoop

			lda SpriteMSB, x
			cmp SpriteSpaceX_MSB, y
			bne EndLoop

			lda SpriteX, x
			sec
			sbc SpriteSpaceX, y
			clc 
			adc #6
			cmp #12
			bcs EndLoop

			
		
			jsr HUMANS.TurnAround



			EndLoop:

				inx
				cpx HUMANS.NumberToGenerate
				bcc Loop




		rts
	}

}