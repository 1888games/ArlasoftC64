DINO:{


	Position: .byte 2
	IsStunned: .byte 0
	ToBeStunned: .byte 0

	Frames: .byte 34, 24, 33

	XPosLSB: .byte 234, 247, 18
	XPosMSB: .byte 0, 0, 1
	YPos: .byte 122, 94, 115

	StunCounter: .byte 10, 10
	Colour: .byte 3

	CharFrames: .byte 25, 26, 37
	SecondaryFrames: .byte 38, 39, 40

	StunFrames: .byte 24, 40
	DeathTimer:				.byte  99, 3

	Reset:{

		jsr DeletePreviousCharacters

		lda #ZERO
		sta IsStunned
		sta ToBeStunned

		lda #ONE
		sta Position

		jsr Update

		rts
	}


	Stun: {

		lda #ONE
		sta ToBeStunned

		lda StunCounter + 1
		sta StunCounter

		rts


	}


	DecideWhetherToMove: {

		jsr MAIN.Random

		cmp #85
		bcc Left

		cmp #170
		bcc Centre

		lda #2
		jmp Finish

		Centre:

		lda #1
		jmp Finish


		Left:

		lda #0
		jmp Finish
		
		Finish:

		sta Position

		rts
	}

	HideStun:{


		ldx StunFrames
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		ldx StunFrames + 1
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		rts


	}

	DrawStun: {

		jsr DeletePreviousCharacters

			// Set to stun position and draw stars

		ldx StunFrames
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		ldx StunFrames + 1
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		rts


	}



	DeathUpdate:{

		lda DeathTimer + 1
		cmp DeathTimer
		bcc Finish

		dec DeathTimer
		beq NextLife

		//jsr SOUND.SFX_EXPLODE

		jmp Finish

		NextLife:
			jsr MAIN.NextLife

		Finish:

		rts



	}

	Update: {

		lda ToBeStunned
		beq NotStunning

		// Now Set Stun positi
		dec ToBeStunned
		jsr DeletePreviousCharacters
		jsr SCORE.HitDino

		ldx Position
		lda SecondaryFrames, x
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		lda #ONE
		sta IsStunned

		jmp Draw

		NotStunning:

			lda IsStunned
			beq NotStunned

			//jsr DrawStun
			jsr HandleStun

			lda #2
			sta Position

			jmp Draw

		NotStunned:

			jsr DeletePreviousCharacters
			jsr DecideWhetherToMove

		Draw:

			jsr DrawHead

		//jsr DrawExtraSprite

		Finish:	

			rts



	}

	DeletePreviousCharacters:{

		ldy Position
		ldx CharFrames, y
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		ldy Position
		ldx SecondaryFrames, y
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		ldx StunFrames
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		ldx StunFrames + 1
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject



		rts
	}


	

	DrawHead: {	


		ldx Position
		lda Frames, x
		clc
		adc #64
		sta SPRITE_POINTERS + 4
		lda XPosLSB, x
		sta VIC.SPRITE_4_X
		lda YPos, x
		sta VIC.SPRITE_4_Y
		lda VIC.SPRITE_ENABLE
		ora #%00010000
		sta VIC.SPRITE_ENABLE

		lda Colour
		sta VIC.SPRITE_COLOR_4

		lda XPosMSB, x
		cmp #ZERO
		beq SetMSBBitOff

		lda VIC.SPRITE_MSB
		ora #%00010000
		sta VIC.SPRITE_MSB

		jmp Complete
		
		SetMSBBitOff:

			lda VIC.SPRITE_MSB
			and #%11101111
			sta VIC.SPRITE_MSB
		
		Complete:
			lda CharFrames, x
			tax 
			ldy #ONE
			jsr CHAR_DRAWING.ColourObject

			ldx Position
			beq DrawFire
			jmp Finish

			DrawFire:

				lda SecondaryFrames, x
				tax
				ldy #ONE
				jsr CHAR_DRAWING.ColourObject

			Finish:

			rts


	}




	HandleStun:{

		dec StunCounter
		bne CheckFlash

		lda #ZERO
		sta IsStunned

		CheckFlash:

			lda StunCounter
			cmp #3
			beq Hide

			cmp #1
			beq Hide

			jsr DrawStun
			jmp Finish
		
			Hide:	
				jsr HideStun
				jmp Finish

		
			Finish:

			rts


	}

}