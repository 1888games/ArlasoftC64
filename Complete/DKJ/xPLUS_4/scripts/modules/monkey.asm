MONKEY:{

	CellID:		.byte 0
	IsFalling:	.byte 0
	MovedThisFrame:		.byte 0
	GoingForKey: .byte 0
	FireCooldown: .byte 0
	GotKey: .byte 0
	MissedKey: .byte 0 
	Unlocking: .byte 0
	InDitch: .byte 0
	AtCage: .byte 0
	FallGracefully: .byte 0
	DisableControl: .byte 0
	HitByEnemy: .byte 0
	Invisible: .byte 0
	JumpedOverEnemy: .byte 0
	DropTime: .byte 0


	.label BlankSprite = 99
	.label KeyJumpSpot = 14
	.label JumpForKeyFrame = 19
	.label ClimbDownLevelSpot = 17
	.label ClimbUpLevelSpot = 11
	.label SingleVineLevelTwo = 22
	.label MaxColumn = 5
	.label DeathTime = 4
	.label GetPineappleSpot = 21
	.label UpTreeSpot = 22


	Initialise: {


		Finish:

			jsr Reset
			
			rts


	}


	Reset: {

		jsr Delete

		lda #ZERO
		sta GoingForKey
		sta DisableControl
		
		sta FireCooldown
		sta GotKey
		sta MissedKey
		sta Unlocking
		sta IsFalling
		sta InDitch
		sta AtCage
		sta FallGracefully
		sta HitByEnemy
		sta CellID

		lda MAIN.GameCounter + 1
		sta MAIN.GameCounter

		lda #%10000000
		sta VIC.BORDER_COLOUR  // border colour

		jsr MONKEY.Draw
		jsr PINEAPPLE.Reset


		rts

	}




	Draw:{

		ldx CellID

		cpx #23
		bne Okay

		lda #17
		sta CellID

		Okay:

		lda MONKEYDATA.WillFall, x
		bne CheckWhetherToSetFallFlag

		lda Invisible
		beq DrawCharacters

		jmp Complete

	CheckWhetherToSetFallFlag:

		lda IsFalling
		bne CheckWhetherToDrop
		sta ZP_COUNTER
		lda #ONE
		sta IsFalling
		jmp Complete

	CheckWhetherToDrop:

		lda ZP_COUNTER
		cmp DropTime
		bne DrawCharacters

	
		lda JumpedOverEnemy
		beq DontAwardPoint

		jsr SCORE.JumpEnemy

		DontAwardPoint:

			sec
			lda CellID
			sbc #6
			sta CellID
			tax
			lda #ZERO
			sta IsFalling
			sta JumpedOverEnemy

		DrawCharacters:

			ldx CellID
			ldy #ONE
			jsr CHAR_DRAWING.ColourObject

	Complete:
		
		//inx 
		//stx CellID
		rts


	}

	GetStatus: {

		ldx CellID
		lda MONKEYDATA.Row, x
		sta TEMP1

		lda MONKEYDATA.Column, x
		sta TEMP2

		lda MONKEYDATA.WillFall, x
		sta TEMP3

		lda MONKEYDATA.CanJump, x
		sta TEMP4
		rts

	}


	ResetFlags: {



		lda #ZERO
		sta JOY_FIRE_NOW
		sta JOY_RIGHT_NOW
		sta JOY_LEFT_NOW
		sta JOY_UP_NOW
		sta JOY_DOWN_NOW

		.label temp = TEMP1
		.label JOYSTICKSELECT1 = %00000010 

		GetJoystick:

		jsr gatherJoystick1
		sta temp
		jmp gatherJoystick2
	
		gatherJoystick1:
		lda #$ff
		sta $fd30
		lda #JOYSTICKSELECT1
		sta $ff08
		lda $ff08
	
		rts

		gatherJoystick2:

			jsr gatherJoystick1
			cmp temp
			bne GetJoystick

		sta JOY_ZP1

		rts

	}



	Delete:{

		ldx CellID
		ldy #ZERO
		jsr CHAR_DRAWING.ColourObject

		rts
	}

	Control: {

		lda FireCooldown
		beq Start
		dec FireCooldown

		Start:

		jsr GetStatus

		.label CurrentRow = TEMP1
		.label CurrentColumn = TEMP2
		.label WillFall = TEMP3
		.label CanJump = TEMP4
		.label EnemyKillPosition = TEMP5
		.label FireButtonUpThisFrame = TEMP6

		lda #ZERO
		sta FireButtonUpThisFrame 

		lda DisableControl
		bne Complete

		jsr ResetFlags

		// Check whether fire button released this frame
		CheckFire:

			// Check i fire held now
			//.break
			lda JOY_ZP1
			and #JOY_FIRE
			bne CheckFireUp

			// Fire held now
			lda #ONE
			sta JOY_FIRE_NOW
			sta JOY_FIRE_LAST
			sta FireButtonUpThisFrame
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

			lda JOY_ZP1
			and #JOY_RIGHT
			bne RightUp

			jmp HandleRight
			
			RightUp:
				lda #ZERO
				sta JOY_RIGHT_LAST

		CheckLeft:

			lda JOY_ZP1
			and #JOY_LEFT
			bne LeftUp

			jmp HandleLeft

			LeftUp:
				lda #ZERO
				sta JOY_LEFT_LAST


		CheckUp:

			lda JOY_ZP1
			and #JOY_UP
			bne UpUp

			jmp HandleUp
			
			UpUp:
				lda #ZERO
				sta JOY_UP_LAST

		CheckDown:

			lda JOY_ZP1
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

			//inc VIC.BORDER_BACKGROUND

			lda JOY_RIGHT_LAST
			cmp #ONE
			beq Complete

			lda MONKEYDATA.WillFall, x
			cmp #ONE
			beq Complete

			lda #ONE
			sta JOY_RIGHT_LAST

			lda CurrentColumn
			cmp #MaxColumn
			beq Complete
			cpx #SingleVineLevelTwo
			beq Complete


			ldy MONKEYDATA.SwingOverEnemyID, x
			sty EnemyKillPosition
			ldy #ZERO
			jsr CheckWhetherEnemies

			


			lda HitByEnemy
			beq NoHurdle

			lda #ONE
			sta JumpedOverEnemy


			NoHurdle:

			ldx CellID
			ldy MONKEYDATA.CheckWhenMovingRight, x
			sty EnemyKillPosition
			ldy #ONE
			jsr CheckWhetherEnemies
			lda HitByEnemy
			bne Complete

			
			//inc $d020
			inc CellID
			jsr SOUND.MoveMonkey
			jmp Complete

		}

		HandleFire2: {

			jmp HandleFire
		}

		HandleLeft:{

			// can't move left if in column 0
			lda CurrentColumn
			beq Complete

			// can't move left if up tree on top row
			cpx #UpTreeSpot
			beq Complete

			// can't move if falling
			lda MONKEYDATA.WillFall, x
			cmp #ONE
			beq Complete

			// check if jumping for key
			cpx #KeyJumpSpot
			bne NotInKeyJumpSpot
			
			lda FireButtonUpThisFrame
			bne GoForKey

			jmp ExitViaFire

			NotInKeyJumpSpot:

			lda JOY_LEFT_LAST
			cmp #ONE
			beq Complete

			lda #ONE
			sta JOY_LEFT_LAST
			jmp MoveLeft
			
			GoForKey:

			lda #JumpForKeyFrame
			sta CellID
			lda #2
			sta GoingForKey
			sta DisableControl
			jsr SOUND.MoveMonkey
			lda #ONE
			sta JOY_LEFT_LAST
			lda #ZERO
			sta JOY_FIRE_LAST

			jmp ExitViaFire


			MoveLeft:

				lda #ZERO
				sta FireButtonUpThisFrame

				ldy MONKEYDATA.CheckWhenMovingLeft, x
				sty EnemyKillPosition
				ldy #ONE
				jsr CheckWhetherEnemies

				lda HitByEnemy
				bne Complete2

				dec CellID
				jsr SOUND.MoveMonkey
				jmp Complete2
		}

		
		ExitViaFire:
			rts
Complete2:
			jmp Complete

		HandleFire:{

			.label PrevCell = TEMP8
			stx PrevCell

			lda #20
			sta FireCooldown
			
			lda MONKEYDATA.CanJump, x
			cmp #ZERO
			beq ExitViaFire


			// Jump!
			lda CellID
			clc
			adc #6
			sta CellID

			cmp #GetPineappleSpot
			bne NoPineapple

			jsr PINEAPPLE.StartFall

			NoPineapple:

			jsr SOUND.MoveMonkey

			ldx PrevCell

			ldy MONKEYDATA.Row, x
			beq CheckEnemyToRight

			ldy MONKEYDATA.CheckWhenMovingLeft, x
			sty EnemyKillPosition
			ldy #ZERO
			jsr CheckWhetherEnemies
			jmp Finish

			CheckEnemyToRight:

				ldy MONKEYDATA.CheckWhenMovingRight, x
				sty EnemyKillPosition
				ldy #ZERO
				jsr CheckWhetherEnemies

			Finish:

			jmp ExitViaFire
		}

		HandleDown:{

			lda JOY_DOWN_LAST
			cmp #ONE
			beq Complete2

			lda #ONE
			sta JOY_DOWN_LAST

			lda MONKEYDATA.OnVine, x
			cmp #ONE
			beq MoveDown

			cpx #ClimbDownLevelSpot
			bne Complete2
			

			MoveDown:

				lda CellID
				sec
				sbc #6
				sta CellID
				jsr SOUND.MoveMonkey
				lda #ZERO
				sta JumpedOverEnemy
				jmp Complete
		}


		HandleUp:{

			lda JOY_UP_LAST
			cmp #ONE
			beq Complete2

			lda #ONE
			sta JOY_UP_LAST

			cpx #ClimbUpLevelSpot
			beq Climb

			jmp Complete

			Climb:

			lda CellID
			clc
			adc #6
			sta CellID

			jsr SOUND.MoveMonkey
			jmp Complete2
		}


		CheckWhetherEnemies:{

			ldx #ZERO

			EnemyLoop:

				//.break

				lda ENEMIES.Positions, x
				cmp EnemyKillPosition
				beq HitEnemy
				jmp EndLoop

			HitEnemy:


				cpy #ONE
				bne DontKill

				jsr Kill
				jmp Finish

				DontKill:
				lda #ONE
				sta JumpedOverEnemy
				jmp Finish


			EndLoop:

				inx
				cpx #ENEMIES.MaxEnemies
				beq Finish
				//stx $d021

				jmp EnemyLoop

			Finish:

				

				rts

		}




	}


	Kill:{

		jsr SOUND.DeathSound
		//lda #LIGHT_RED


		lda #%00010010
		sta VIC.BORDER_COLOUR
		
		lda #DeathTime
		sta HitByEnemy
		lda #ONE
		sta DisableControl
		rts
	}

	


}