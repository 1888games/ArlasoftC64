CAVEMAN:{


	Frames: .byte 56, 75, 30, 29, 40, 41

	XPos: .byte 75, 104, 135, 164, 198, 228
	YPos: .byte 141, 141, 150, 152, 142, 141

	Position: .byte 0
	DisableControl: .byte 0
	CarryingEgg: .byte 0

	.label ObjectType = 6
	.label MaxPosition = 5

	Colour: .byte 10
	Cooldown: .byte 5


	Reset:{

		jsr DeletePriorCharacter

		lda #CYAN
		sta $d020

		lda #ZERO
		sta CarryingEgg

		lda #ONE
		sta Position
		rts
	}

	Draw: {

		lda MAIN.GameOver
		bne Finish

		//top frame
		clc
		ldx Position
		lda Frames, x
		adc #64
		cpx MaxPosition
		beq DontSetTopFrame

		sta SPRITE_POINTERS

		DontSetTopFrame:

		// bottom frame
		clc
		adc #08
		sta SPRITE_POINTERS + 1

		lda XPos, x

		cpx #MaxPosition
		beq DontSetTopX

		sta VIC.SPRITE_0_X

		DontSetTopX:
		sta VIC.SPRITE_1_X

		lda YPos, x
		cpx #MaxPosition
		beq DontSetTopY

		sta VIC.SPRITE_0_Y

		DontSetTopY:
		clc
		adc #21
		sta VIC.SPRITE_1_Y 

		lda VIC.SPRITE_MSB
		and #%11111100
		sta VIC.SPRITE_MSB

		lda VIC.SPRITE_ENABLE
		ora #%00000011
		sta VIC.SPRITE_ENABLE

		lda Colour
		cpx #MaxPosition
		beq DontSetTopColor

		sta VIC.SPRITE_COLOR_0

		DontSetTopColor:
		sta VIC.SPRITE_COLOR_1

		lda Position
		clc
		adc #27
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject
		jsr DrawEgg


		Finish:

		rts


	}




	DrawEgg: {

		lda CarryingEgg
		beq NoEgg

		lda Position
		beq NoEgg

		//cmp #5
		//beq NoEgg

		lda Position
		clc
		adc #12
		tax
		ldy #ONE
		jsr CHAR_DRAWING.ColourObject

		NoEgg:
			rts



	}


	DeletePriorCharacter:{

		lda Position
		clc
		adc #27
		tax
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		lda Position
		beq DontDeleteEgg

		lda Position
		clc
		adc #12
		tax
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		DontDeleteEgg:

		rts
	}

	ResetFlags: {

		lda #ZERO
		sta JOY_FIRE_NOW
		sta JOY_RIGHT_NOW
		sta JOY_LEFT_NOW
		sta JOY_UP_NOW
		sta JOY_DOWN_NOW

		lda REGISTERS.JOY_PORT_2
		sta JOY_ZP2
		rts

	}



	Died: {



		jsr LIVES.LoseLife

		lda #ZERO
		sta MAIN.GameIsActive

		lda DINO.DeathTimer + 1
		sta DINO.DeathTimer

		//jsr SOUND.SFX_EXPLODE

		lda #RED
		sta $d020

		rts

	}

	CheckKilledByDino:{

		lda Position
		cmp #MaxPosition
		bne NotKilled

		lda DINO.Position
		bne NotKilled

		jsr Died

		NotKilled:


		rts
	}


	
	Control: {

		lda Cooldown
		beq Enabled

		dec Cooldown

		Enabled:

		lda Position
		cmp #MaxPosition
		bne NoEggCheck

		jsr CheckEggPickedUp
		//jsr CheckKilledByDino

		NoEggCheck:

		.label FireButtonUpThisFrame = TEMP6

		lda #ZERO
		sta FireButtonUpThisFrame 

		lda DisableControl
		bne Complete

		jsr ResetFlags

		// Check whether fire button released this frame
		CheckFire:

			// Check i fire held now
			lda JOY_ZP2
			and #JOY_FIRE
			bne CheckFireUp

			// Fire held now
			lda #ONE
			sta JOY_FIRE_NOW
			sta JOY_FIRE_LAST
			jmp CheckRight

			// Fire not held now
			CheckFireUp:

				lda #ZERO
				sta JOY_FIRE_NOW

				lda JOY_FIRE_LAST
				sta FireButtonUpThisFrame 

				lda #ZERO
				sta JOY_FIRE_LAST


		CheckRight:

			lda JOY_ZP2
			and #JOY_RIGHT
			bne RightUp

			jmp HandleRight
			
			RightUp:
				lda #ZERO
				sta JOY_RIGHT_LAST

		CheckLeft:

			lda JOY_ZP2
			and #JOY_LEFT
			bne LeftUp

			jmp HandleLeft

			LeftUp:
				lda #ZERO
				sta JOY_LEFT_LAST


		CheckUp:

			lda JOY_ZP2
			and #JOY_UP
			bne UpUp

			jmp HandleUp
			
			UpUp:
				lda #ZERO
				sta JOY_UP_LAST

		CheckDown:

			lda JOY_ZP2
			and #JOY_DOWN
			bne DownUp

			jmp HandleDown
			
			DownUp:
				lda #ZERO
				sta JOY_DOWN_LAST

		NothingPressed:

		Complete:	
			lda FireButtonUpThisFrame
			bne HandleFire2
			rts

		HandleRight: {

			lda JOY_RIGHT_LAST
			cmp #ONE
			beq Complete

			lda #ONE
			sta JOY_RIGHT_LAST

			lda Position
			cmp #MaxPosition
			beq Complete
		
			jsr DeletePriorCharacter

			.label EggStolen = TEMP7

			lda EGG.EggStolen
			sta EggStolen
	
			inc Position
			jsr CheckEggPickedUp

			lda EggStolen
			cmp EGG.EggStolen
			beq NoEgg

			jsr SOUND.SFX_STEAL
			jmp Complete


			NoEgg:

			jsr SOUND.SFX_HIGH
			jmp Complete

		}

		HandleFire2: {

			jmp HandleFire
		}

		HandleLeft:{

			// can't move left if in column 0
			lda Position
			beq Complete

			lda JOY_LEFT_LAST
			cmp #ONE
			beq Complete

			lda #ONE
			sta JOY_LEFT_LAST
			jmp MoveLeft

			MoveLeft:

				.label EggsBefore = TEMP4

				lda #ZERO
				sta FireButtonUpThisFrame

				jsr DeletePriorCharacter
				dec Position

				lda CAVE.EggsInCave
				sta EggsBefore

				jsr CheckEggDelivered
				jsr CheckAxePickedUp

				lda EggsBefore
				cmp CAVE.EggsInCave
				beq Low

				jsr SOUND.SFX_BONUS
				jmp Complete2

				Low:

					jsr SOUND.SFX_LOW
					jmp Complete2
		}

		Complete2:
			jmp Complete

		ExitViaFire:
			rts

		HandleFire:{


			jsr AXE.ThrowAxe
			jmp ExitViaFire

		}

		HandleDown:{

			lda JOY_DOWN_LAST
			cmp #ONE
			beq Complete2

			lda #ONE
			sta JOY_DOWN_LAST

			jmp Complete
		}


		HandleUp:{

			lda JOY_UP_LAST
			cmp #ONE
			beq Complete2

			lda #ONE
			sta JOY_UP_LAST

			jmp Complete2
		}
	}

	CheckEggPickedUp:{

		lda Position
		cmp #MaxPosition
		bne NoPickup


		lda EGG.EggStolen
		bne NoPickup

		lda EGG.Position
		bne NoPickup

		jsr EGG.StealEgg



		NoPickup:

			rts

	}

	CheckAxePickedUp: {

		lda MAIN.GameMode
		beq NoPickup

		lda Position
		bne NoPickup

		lda AXE.IsCarrying
		bne NoPickup

		lda AXE.BeingFired
		bne NoPickup

		lda #ONE
		sta AXE.IsCarrying

		NoPickup:
		rts


	}

	CheckEggDelivered: {

		lda Position
		bne NoDelivery

		lda CarryingEgg
		beq NoDelivery

		jsr CAVE.AddEgg
		dec CarryingEgg

		NoDelivery:
			rts


	}
}