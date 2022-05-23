CLOUDS:{

	.label TopLeft = 36
	.label TopRight = 33
	.label BottomLeft = 34
	.label BottomRight = 35

	.label TopRow = 0
	.label BottomRow = 3
	.label SkyCharacter = 16

	CurrentColumn: .byte 24, 7
	Row: .byte 0, 4
	Counter: .byte 0, 0
	MaxCounter: .byte 40, 32


	Reset: {

		ldx #0
		lda MaxCounter, x
		sta Counter, x

		inx
		lda MaxCounter, x
		sta Counter, x



	}

	Update: {

		ldx #0

		lda Counter, x
		bne DontMove

		lda MaxCounter, x
		sta Counter, x

		jsr MoveCloud

		jmp Cloud2

		DontMove:

		sec
		sbc #01
		sta Counter, x

		Cloud2:

		ldx #1

		lda Counter, x
		bne DontMove2

		lda MaxCounter, x
		sta Counter, x

		jsr MoveCloud
		jmp Finish

		DontMove2:

		sec
		sbc #01
		sta Counter, x


		Finish:
			rts



	}



	MoveCloud: {

		.label CloudID = TEMP9

		stx CloudID


		lda Row, x
		tay
		lda CurrentColumn, x
		tax
		lda #SkyCharacter
		jsr PLOT.PlotCharacter

		ldx CloudID
		lda Row, x
		tay
		lda CurrentColumn, x
		tax
		inx
		lda #SkyCharacter
		jsr PLOT.PlotCharacter


		ldx CloudID
		lda Row, x
		tay
		iny
		lda CurrentColumn, x
		tax
		lda #SkyCharacter
		jsr PLOT.PlotCharacter


		ldx CloudID
		lda Row, x
		tay
		iny
		lda CurrentColumn, x
		tax
		inx
		lda #SkyCharacter
		jsr PLOT.PlotCharacter
		

		ldx CloudID
		lda CurrentColumn, x
		sec
		sbc #01
		cmp #0
		bne NoWrap

		lda #38
		
		NoWrap:

		sta CurrentColumn, x

		
		lda Row, x
		tay
		lda CurrentColumn, x
		tax
		lda #TopLeft
		jsr PLOT.PlotCharacter

		ldx CloudID
		lda Row, x
		tay
		lda CurrentColumn, x
		tax
		inx
		lda #TopRight
		jsr PLOT.PlotCharacter

		ldx CloudID
		lda Row, x
		tay
		iny
		lda CurrentColumn, x
		tax
		lda #BottomLeft
		jsr PLOT.PlotCharacter

		ldx CloudID
		lda Row, x
		tay
		iny
		lda CurrentColumn, x
		tax
		inx
		lda #BottomRight
		jsr PLOT.PlotCharacter
	


		rts
	}




}