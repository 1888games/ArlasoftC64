BIRD: {

	Patterns: .byte 4, 9, 10, 11, 7, 6, 5, 8
			  .byte 4, 9, 10, 11, 7, 6, 5, 8
			  .byte 4, 9, 10, 11, 7, 6, 5, 8
			  .byte 4, 9, 10, 11, 7, 6, 5, 8
			  .byte 4, 9, 10, 6, 5, 8, 99, 99
			  .byte 4, 9, 10, 6, 5, 8, 99, 99
			  .byte 4, 9, 6, 5, 8, 99, 99, 99
			  .byte 4, 9, 5, 8, 99, 99, 99, 99
 

	.label NumberOfPatterns = 6
	.label StartPoint = 4
	.label SwoopDecisionPoint = 8
	.label SwoopPoint = 3
	.label MissPoint = 2
	.label SequenceLength = 8
	.label StarCharacter = 224


	IsActive: .byte 1
	Position: .byte 99
	SequenceID: .byte 0
	ReadyToSpawn: .byte 1
	Pattern: .byte 0
	JustKilled: .byte 0
	SpawnTimer: .byte 2, 2	
	ReplaceCharacter: .byte 0
	PreviousPosition: .byte 0



	Reset: {	

		jsr DeletePriorCharacter

		lda #99
		sta Position

		lda #ZERO
		sta SequenceID
		sta Pattern

		lda #ONE
		sta ReadyToSpawn

		lda #2
		sta SpawnTimer

		rts

	}


	Update:{

		// if inactive do nothing
		lda IsActive	
		beq Finish2

		// if spawn timer not zero, decrement and do nothing
		lda SpawnTimer
		beq NotWaitingToSpawn

		// reduce spawn timer, if now zero then ready to spawn
		dec SpawnTimer
		bne Finish2

		// Ready to spawn
		lda #ONE
		sta ReadyToSpawn
		jmp Finish2

		NotWaitingToSpawn: 

			lda JustKilled
			beq NotJustKilled

			// Just Killed, show star and setup spawn timer
			dec JustKilled

			jsr MAIN.Random
			lsr
			lsr
			lsr
			lsr
			lsr

			sta SpawnTimer

			lda Position
			sta PreviousPosition

			lda #99
			sta Position

			//jmp Finish2

		NotJustKilled:

		jsr DeletePriorCharacter

			// spawn has been setup, let's go
		lda ReadyToSpawn
		bne Spawn

		// Bird not on screen, don't draw
		lda Position
		cmp #99
		beq Finish

		lda SequenceID
		beq NotReadyToSwoop
		
		// Bird at point where decision to be made
		lda Position
		cmp #SwoopDecisionPoint
		beq SwoopDecision

		// Bird on way out of screen
		cmp #StartPoint
		bcc FlyOutOfScreen

		jmp NotReadyToSwoop

		Finish2:
			jmp Finish

		SwoopDecision:{

			jsr CheckWhetherToSwoopOrMiss
			jmp Draw

		}


		FlyOutOfScreen: {

			// if less than two then despawn	
			cmp #2
			bcc Despawn

			cmp #SwoopPoint
			bne Finish

			lda CAVE.EggOnStool
			sta Position

			jsr CAVE.EggStolen
			jmp Draw

			Finish:

			dec Position
			dec Position

			jmp Draw
		}


		NotReadyToSwoop: {

			clc
			inc SequenceID
			// get pattern ID, multiply by 8
			lda Pattern
			asl
			asl
			asl

			// add the sequence and get the next positon
			clc
			adc SequenceID
			tax
			lda Patterns, x

			sta Position
			jmp Draw

		}



		Spawn:

			jsr MAIN.Random
			and #$07
			sta Pattern

			lda #ZERO
			sta SequenceID

			lda #StartPoint
			sta Position
			dec ReadyToSpawn
			jmp Draw

		Draw:

			jsr DeletePriorCharacter
			jsr DrawBird

		Finish:

			rts




	}

	DrawBird: {

		ldx Position
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		rts

	}


	KillBird: {


		jsr SCORE.HitBird
		jsr Despawn
		rts

	}


	DeletePriorCharacter:{

		ldx Position
		cpx #99

		beq DontDelete
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		DontDelete:

		rts
	}

	Despawn:{

		jsr DeletePriorCharacter
		

		lda #ONE
		sta JustKilled

		//lda #ONE
		//sta ReadyToSpawn

		rts

	}


	CheckWhetherToTakeEgg: {

			


		rts
	}


	CheckWhetherToSwoopOrMiss: {

		lda CAVEMAN.Position
		beq DontGoForEgg

		lda CAVE.EggOnStool
		beq DontGoForEgg

		jsr MAIN.Random

		cmp #50
		bcc DontGoForEgg

		lda #SwoopPoint
		sta Position
		rts

		DontGoForEgg:

			lda #MissPoint
			sta Position
			rts


	}



		

}