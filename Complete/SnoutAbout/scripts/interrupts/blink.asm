BLINK: {

	TopLeftFrames: .byte 1, 45, 47, 57
	TopRightFrames: .byte 2, 46, 48, 58
	BottomLeftFrames: .byte 3, 3, 49, 3
	BottomRightFrames: .byte 6, 6, 50, 6

	Rows: .byte 17, 17, 18, 18
	Cols: .byte 2, 3, 2, 3
	Position: .byte 0

	.label ChanceOfBlinking = 4 // out of 255
	.label ChanceOfGlancing = 254 // out of 255
	.label TimePerFrameBlink = 5
	.label TimeForGlance = 45
	.label MinimumGap = 30

	Blinking: .byte 0
	Timer: .byte 0

	Reset: {

		lda #ZERO
		sta Blinking
		sta Timer
		sta Position


	}

	CheckWhetherToBlinkOrGlance: {

		lda Timer
		beq NotCoolingDown

		dec Timer
		jmp Finish

		NotCoolingDown:

		jsr MAIN.Random

		cmp #ChanceOfBlinking
		bcc Blink

		cmp #ChanceOfGlancing
		bcs Glance

		jmp Finish

		Blink:

		
			lda #TimePerFrameBlink
			sta Timer

			lda #ONE
			sta Blinking
			sta Position

			jsr DrawEyes
			jmp Finish

		Glance:

			ldx #3
			stx Position
			lda #TimeForGlance
			sta Timer
			jsr DrawEyes


		Finish:

		rts


	}

	Update:{

		lda Blinking
		beq NotBlinking


		IsBlinking:

			// check whether to do next frame
			dec Timer
			lda Timer
			bne Finish

			NextFrame:

			
				ldx Position
				inx
				cpx #3
				beq ResetEyes

				lda #TimePerFrameBlink
				sta Timer
				stx Position
				jsr DrawEyes
				jmp Finish

			ResetEyes:

				ldx #ZERO
				stx Position
				stx Blinking
				ldx #MinimumGap
				stx Timer
				jsr DrawEyes
				jmp Finish


		NotBlinking:

			lda Position
			cmp #3
			bne NotGlancing

			Glancing:

				dec Timer
				lda Timer
				bne Finish

				jmp ResetEyes

		NotGlancing:

			jsr CheckWhetherToBlinkOrGlance


		Finish:

			rts


		
	}


	DrawEyes: {

		ldx Position
		lda TopLeftFrames, x
		ldx #2
		ldy #17
		jsr PLOT.PlotCharacter

		ldx Position
		lda TopRightFrames, x
		ldx #3
		ldy #17
		jsr PLOT.PlotCharacter

		ldx Position
		lda BottomLeftFrames, x
		ldx #2
		ldy #18
		jsr PLOT.PlotCharacter

		ldx Position
		lda BottomRightFrames, x
		ldx #3
		ldy #18
		jsr PLOT.PlotCharacter
		
		
		rts

	}


}
