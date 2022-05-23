JUMPERS:{



	Position: .byte 99, 99, 99, 99, 99, 99
	Cooldown: .byte 0, 0, 0, 0, 0, 0
	Bounced:  .byte 0, 0, 0, 0, 0, 0
	DrawNextFrame:	.byte 0, 0, 0, 0, 0, 0

	.label TicksBetweenMove = 3
	.label StartCharacterID = 3
	.label OverallCooldownTime = 9

	NumberOfJumpers: .byte 0
	MaxJumpers: .byte 2
	SavedThisLevel:	.byte 0
	JumpersToSave: .byte 0


	.label JumpersAvailable = 6
	.label NewJumperChance  = 17

	OverallCooldown: .byte 0

	JumperID: .byte 0

	.label Trampoline1 = 6
	.label Trampoline2 = 14
	.label Trampoline3 = 20


	.label FallStartPosition = 23
	.label AmbulancePosition = 22

	.label JumperMoveSFXID = 2
	.label SaveSoundID = 8




	Update: {

		//inc $d020

		jsr MoveJumpers
		jsr CheckWhetherNewJumper

		//dec $d020
		
		rts

	}



	Reset: {

		lda #OverallCooldownTime
		sta OverallCooldown

		lda #0
		sta NumberOfJumpers
		
		ldx #0


		Loop:

			stx JumperID

			lda Position, x
			cmp #99

			beq NoDelete

			jsr Delete

			NoDelete:

				ldx JumperID
				lda #99

				sta Position, x

				lda #0
				sta DrawNextFrame, x

				inx 
				cpx #JumpersAvailable
				beq Finish
				jmp Loop


		Finish:

		jsr JUMPERS.CreateNewJumper


		rts

	}


	CheckDrawing: {

		ldx #0

		Loop:

			stx JumperID

			lda DrawNextFrame, x
			beq EndLoop

			lda #0
			sta DrawNextFrame, x


			jsr Draw

			ldx JumperID

			EndLoop:


				inx
				cpx #JumpersAvailable
				beq Finish
				jmp Loop

		Finish:

			rts



	}
	MoveJumpers: {


		ldx #0


		Loop:

			stx JumperID

			lda Position, x
			cmp #99
			beq EndLoop

			lda Cooldown, x
			beq ReadyToMove

			dec Cooldown, x
			jmp EndLoop

			ReadyToMove:

			jsr Delete

			ldx JumperID

			lda Position, x

			cmp #AmbulancePosition
			bne NoAmbulance

			jsr SavedMan
			jmp EndLoop

			NoAmbulance:

				cmp #FallStartPosition
				bcs OkayToDraw

				cmp #2
				bcs AlreadyJumped

			Jumping: 

				clc
				adc #1

			AlreadyJumped:

				clc
				adc #1


			CheckTrampoline1:

				cmp #Trampoline1
				bne CheckTrampoline2
				ldy #0
				jsr CheckWhetherSaved
				jmp OkayToDraw

			CheckTrampoline2:

				cmp #Trampoline2
				bne CheckTrampoline3
				ldy #1
				jsr CheckWhetherSaved
				jmp OkayToDraw

			CheckTrampoline3:

				cmp #Trampoline3
				bne OkayToDraw
				ldy #2
				jsr CheckWhetherSaved

			OkayToDraw:

				sta Position, x

				ldy #JumperMoveSFXID
				jsr SOUND.StartSong

				lda #1
				sta DrawNextFrame, x

				//jsr Draw

				ldx JumperID

			SetupNextTick:

				lda #TicksBetweenMove
				sta Cooldown, x
				
				lda #ZERO
				sta Bounced, x

			EndLoop:

				inx
				cpx MaxJumpers
				beq Finish
				jmp Loop

		Finish:


			rts


	}


	SavedMan: {

		pha

		inc SavedThisLevel
		lda SavedThisLevel
		cmp JumpersToSave
		bne NotComplete

		StoreState()

		jsr LEVELDATA.SetupNextLevel

		RestoreState()

		NotComplete:

		pla

			ldy #SaveSoundID
			jsr SOUND.StartSong

			ldx JumperID

			lda #99
			sta Position, x

			dec NumberOfJumpers

			lda NumberOfJumpers
			bne NoNew

			StoreState()

			jsr CreateNewJumper

			RestoreState()


		NoNew:


		rts
	}

	CheckWhetherSaved: {

		pha

		lda Bounced, x
		beq FallDown

		jsr SCORE.SuccessfulBounce

		pla

		jmp Finish

		FallDown:

		
		
		pla
		tya
		clc
		adc #FallStartPosition

		pha
		txa
		pha

		jsr Died

		pla
		tax
		pla
		//lda #0

		Finish:

		rts
	}



	Died: {

		jsr LIVES.LoseLife

		lda #ZERO
		sta MAIN.GameIsActive

		lda MAIN.DeathTimer + 1
		sta MAIN.DeathTimer

		SetBorderColour(2, 5)

		
		rts

	}


	CheckWhetherNewJumper: {

		
		lda OverallCooldown
		beq Okay

		dec OverallCooldown
		jmp Finish

		Okay:
	
		lda NumberOfJumpers
		cmp MaxJumpers
		bcs Finish

		jsr RANDOM.Get


		cmp #NewJumperChance
		bcs Finish


		jsr CreateNewJumper


		Finish:

			rts

	}


	Delete: {

		ldy #0
		
		lda Position, x
		clc
		adc #StartCharacterID
		tax

		jsr CHAR_DRAWING.ColourObject

		rts

	}

	Draw: {


		ldy #1
		
		lda Position, x
		clc
		adc #StartCharacterID
		tax

		jsr CHAR_DRAWING.ColourObject

		rts

	}


	GetNextAvailableID: {

		ldx #0

		Loop:

			lda Position, x
			cmp #99
			beq Found

			inx
			cpx MaxJumpers
			beq Found
			jmp Loop


		Found:

			rts

	}


	CreateNewJumper: {

		jsr GetNextAvailableID


		lda #0
		sta Position, x

		jsr RANDOM.Get
		cmp #150
		bcc SecondFloor

			inc Position, x

		SecondFloor:

		lda #OverallCooldownTime
		sta OverallCooldown

		lda #TicksBetweenMove
		sta Cooldown, x

		inc NumberOfJumpers

		jsr Draw

		rts


	}


}