MEN:{




	Position: .byte 0
	Cooldown: .byte 5
	DisableControl: .byte 0

	TrampolinePositions: .byte 5, 13, 19

	.label ObjectType = 0
	.label MaxPosition = 2
	.label MoveLeftSFXId = 1
	.label MoveRightSFXId = 3
	.label BounceSFXId = 4

	Reset: {


		lda #ZERO
		sta Position


	}


	DrawOrHide: {

		// y = 0 hide, y = 1 draw

		lda MAIN.GameOver
		bne Finish

		lda Position
		tax
		jsr CHAR_DRAWING.ColourObject

	 	Finish:

		rts


	}

	Draw: {


		ldy #1
		jsr DrawOrHide
		rts
	}

	DeletePriorCharacter: {

		ldy #0
		jsr DrawOrHide
		rts
	}



	CheckBounce: {


		.label TrampolinePosition = TEMP10


		ldy Position
		lda TrampolinePositions, y
		sta TrampolinePosition

		ldx #0

		Loop:

			lda JUMPERS.Bounced, x
			bne EndLoop

			lda JUMPERS.Position, x
			cmp TrampolinePosition
			bne EndLoop

			lda #1
			sta JUMPERS.Bounced, x

			ldy #BounceSFXId
			jsr SOUND.StartSong
				
			EndLoop:
				inx
				cpx #JUMPERS.JumpersAvailable
				beq Finish
				jmp Loop


		Finish:

			rts



	}

	Control: {

		jsr CheckBounce

		lda Cooldown
		beq Enabled

		dec Cooldown

		Enabled:

		lda DisableControl
		beq CheckJoystick

		rts

		CheckJoystick:

		ldy #2
		jsr INPUT.ReadJoystick


		HandleRight: {

			lda INPUT.JOY_RIGHT_NOW, y
			beq HandleLeft


			lda INPUT.JOY_RIGHT_LAST, y
			cmp #ONE
			beq Complete

			lda #ONE
			sta INPUT.JOY_RIGHT_LAST, y

			lda Position
			cmp #MaxPosition
			beq Complete


			
			jsr DeletePriorCharacter	
			inc Position		

			ldy #MoveRightSFXId
			jsr SOUND.StartSong
			
			jmp Complete


		//	jsr SOUND.SFX_HIGH
			jmp Complete

		}

		Complete: {
			rts
		}

		

		HandleLeft:{	

			lda INPUT.JOY_LEFT_NOW, y
			beq Complete

			// can't move left if in column 0
			lda Position
			beq Complete

			lda INPUT.JOY_LEFT_LAST, y
			cmp #ONE
			beq Complete

			lda #ONE
			sta INPUT.JOY_LEFT_LAST, y

		
			jsr DeletePriorCharacter
			dec Position

			Low:
				ldy #MoveLeftSFXId
				jsr SOUND.StartSong
				jmp Complete2
		}

		Complete2:
			jmp Complete

		
		
	}


}