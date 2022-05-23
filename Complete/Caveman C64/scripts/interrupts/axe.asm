AXE:{

	IsCarrying: .byte 0
	BeingFired: .byte 0
	AxeMoveCounter: .byte 8, 8

	HandFrames: .byte 42, 43, 57, 55, 50, 99

	HandXPos: .byte 62, 97, 129, 159, 190, 99
	HandYPos: .byte 158, 145, 147, 147, 150, 107

	FramesPerColumn: .byte 3, 3, 3, 1

	Column: .byte 1
    Colour: .byte 7


    KillBirdPositions:
    		.byte 98, 98, 8, 4
    		.byte 98, 98, 9, 5
    		.byte 98, 98, 98, 98
    		.byte 98, 98, 98, 98

 
	Frames: 
			.byte 58, 46, 47, 45
	 		.byte 59, 72, 60, 77
	 		.byte 58, 59, 52, 62
	 		.byte 44, 59, 0, 0

	XPos: 	.byte 120, 105, 120, 105
			.byte 150, 135, 150, 135
			.byte 180, 200, 220, 240
			.byte 220, 240, 0, 0


	YPos:	.byte 115, 100, 85, 60
			.byte 115, 100, 85, 60
			.byte 115, 100, 90, 80
			.byte 115, 90, 0, 0

	.label SpritePointer = 5

	XToUse: .byte 0
	YToUse: .byte 0
	FrameID: .byte 0
	StartFrameID: .byte 0
	CurrentFrame: .byte 0

	

	Reset: {

		lda #3
		sta FramesPerColumn
		sta FramesPerColumn + 1
		sta FramesPerColumn + 2

		lda #1
		sta FramesPerColumn + 3

		rts

	}


	Draw:{

		lda IsCarrying
		bne PutInHand

		lda BeingFired
		bne GetThrowData

		lda MAIN.GameMode	
		beq TurnOffSprite

		// on tee

		lda HandFrames
		sta FrameID

		lda HandXPos
		sta XToUse

		lda HandYPos
		sta YToUse

		jmp SetupSprite

		GetThrowData:

			lda StartFrameID
			clc
			adc CurrentFrame
			tax 
			lda Frames, x
			sta FrameID
			lda XPos, x
			sta XToUse
			lda YPos, x
			sta YToUse

			jsr CheckWhetherHitDino
			jsr CheckWhetherHitBird

			jmp SetupSprite


		TurnOffSprite:  // Don't - it's used by the cage

			//inc $d020
			lda VIC.SPRITE_ENABLE	
			and #%11011111
			sta VIC.SPRITE_ENABLE
			jmp Finish

		PutInHand:

			ldx CAVEMAN.Position
			lda HandFrames, x
			sta FrameID

			lda HandXPos, x
			sta XToUse

			lda HandYPos, x
			sta YToUse


		SetupSprite:


			lda FrameID
			cmp #99
			beq TurnOffSprite
			clc
			adc #64
			ldx #SpritePointer
			sta SPRITE_POINTERS + 5
			lda XToUse
			sta VIC.SPRITE_5_X
			lda YToUse
			sta VIC.SPRITE_5_Y
			lda VIC.SPRITE_ENABLE
			ora #%00100000
			sta VIC.SPRITE_ENABLE
			lda Colour
			sta VIC.SPRITE_COLOR_5

			lda VIC.SPRITE_MSB
    		and #%11011111
   			sta VIC.SPRITE_MSB
   			
			jmp Finish

		Finish:

			rts
	}



	CheckWhetherHitBird: {

		lda KillBirdPositions, x

		cmp BIRD.Position
		bne Finish
		
		jsr SOUND.SFX_HIT
		jsr BIRD.KillBird

		jsr DespawnAxe

		Finish:
			rts

	}

	CheckWhetherHitDino: {



		ldy Column
		cpy #2
		bcc Finish

		lda DINO.Position
		cmp #1
		bne Finish

		lda FramesPerColumn, y
		cmp CurrentFrame
		bne Finish


		lda DINO.ToBeStunned
		bne Finish

		lda DINO.IsStunned
		bne Finish

		jsr DINO.Stun
		jsr SOUND.SFX_HIT

		jsr DespawnAxe

		Finish:

		rts
	}


	ThrowAxe:{

		
		// can't throw if not holding it
		lda IsCarrying
		beq Finish

		lda BeingFired
		bne Finish

		// can't throw if at stool
		lda CAVEMAN.Position
		beq Finish

		// can't throw if at egg
		cmp #4
		beq Finish


		lda CAVEMAN.Position
		sec
		sbc #1	// reduce to 0-3
		sta Column

		asl
		asl
		sta StartFrameID

		lda #ZERO
		sta CurrentFrame
		sta IsCarrying

		lda #ONE
		sta BeingFired
		jsr SOUND.SFX_LOW

		lda AxeMoveCounter + 1
		sta AxeMoveCounter



		Finish:
			rts


	}

	FrameCode:{

		lda BeingFired
		beq CheckWhetherCarrying

		dec AxeMoveCounter
		bne Finish

		jsr MoveAxe
		jmp Finish

		CheckWhetherCarrying:

			lda IsCarrying
			bne Finish
			jsr SpawnAxe

		Finish:

			jsr Draw
			rts


	}




	MoveAxe: {



		lda AxeMoveCounter + 1
		sta AxeMoveCounter

		ldx Column
		lda CurrentFrame

		cmp FramesPerColumn, x
		bne DontRemove

		jsr DespawnAxe
		jmp Finish

		DontRemove:

			inc CurrentFrame
			lda CurrentFrame

		Finish:

		rts

	}


	DespawnAxe: {

		lda #ZERO
		sta BeingFired

		rts

	}

	SpawnAxe: {

	
		lda MAIN.GameMode
		bne NoAutoCarry

		lda #ONE
		sta IsCarrying

		NoAutoCarry:

		rts
	}

	



}