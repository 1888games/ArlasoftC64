VOLCANO:{


	IsActive: .byte 1
	Position: .byte 0

	CharFrames: .byte 21, 22, 23

	.label LavaCrackChar = 41
	.label MaxPosition = 3


	Start:{

		ldx #LavaCrackChar
		ldy IsActive
		jsr CHAR_DRAWING.ColourObject

		rts

	}


	Stop:{

		ldx #LavaCrackChar
		ldy #ZERO
		sty IsActive
		jsr CHAR_DRAWING.ColourObject

		rts

	}

	Update:{

		lda IsActive
		beq Finish

		// Delete old chars
		ldx Position
		lda CharFrames, x
		tax
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		 inc Position
		 lda Position
		 cmp #MaxPosition
		 bcs ResetPosition

		 jmp Draw

		 ResetPosition:

		 lda #ZERO
		 sta Position

		 Draw:

		 ldx Position
		 lda CharFrames, x
		 tax
		 ldy #ONE
		 jsr CHAR_DRAWING.ColourObject


		Finish:

			rts
	}



}