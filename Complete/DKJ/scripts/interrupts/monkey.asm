MONKEY:{

	#import "lookups/spriteData.asm"

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
	.label SpriteAddressStart = 64
	.label SpriteWidth = 24
	.label SpriteHeight = 21
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

		jsr SetColour

		Finish:

			jsr Reset
			
			rts


	}


	Reset: {

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
		lda #%00000000
		sta VIC.SPRITE_ENABLE

		lda #CYAN
		sta $d021

		lda #BLACK
		sta $d020

	
		jsr PINEAPPLE.Reset


		rts

	}

	SetColour: {

		lda #BROWN
		ldx #3

 		ColourLoop:
		
			sta VIC.SPRITE_COLOR_0, x
			cpx #ZERO
			beq FinishColour
			dex
			jmp ColourLoop
			
		FinishColour:
			rts

	}


	Draw:{

		jsr SetColour
		ldx CellID
	
		lda SPRITEDATA.WillFall, x
		bne CheckWhetherToSetFallFlag

		lda Invisible
		beq TopLeft
		
		lda VIC.SPRITE_ENABLE
		and #%11110000
		sta VIC.SPRITE_ENABLE
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
		bne TopLeft

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

	TopLeft:

		lda SPRITEDATA.TopLeftFrame, x
		cmp #BlankSprite
		beq TurnOffSprite1
		adc #SpriteAddressStart
		sta SPRITE_POINTERS + 0
		lda SPRITEDATA.XPosLSB, x
		sta VIC.SPRITE_0_X
		lda SPRITEDATA.YPos, x
		sta VIC.SPRITE_0_Y
		lda VIC.SPRITE_ENABLE
		ora #%00000001
		sta VIC.SPRITE_ENABLE
		jmp TopRight


	TurnOffSprite1:  // Don't - it's used by the cage

		//lda VIC.SPRITE_ENABLE
		//and #%11111110
		//sta VIC.SPRITE_ENABLE

	TopRight:

		lda SPRITEDATA.TopRightFrame, x
		cmp #BlankSprite
		beq TurnOffSprite2
		adc #SpriteAddressStart
		sta SPRITE_POINTERS + 1
		lda SPRITEDATA.XPosLSB, x
		adc #SpriteWidth
		sta VIC.SPRITE_1_X
		
		lda SPRITEDATA.YPos, x
		sta VIC.SPRITE_1_Y
		lda VIC.SPRITE_ENABLE
		ora #%00000010
		sta VIC.SPRITE_ENABLE

		lda SPRITEDATA.XPosMSB, x
		cmp #ZERO
		beq SetMSBBitOff1

		lda VIC.SPRITE_MSB
		ora #%00000010
		sta VIC.SPRITE_MSB

		jmp BottomLeft
		
		SetMSBBitOff1:

			lda VIC.SPRITE_MSB
			and #%11111101
			sta VIC.SPRITE_MSB
			jmp BottomLeft


	TurnOffSprite2:

		lda VIC.SPRITE_ENABLE
		and #%11111101
		sta VIC.SPRITE_ENABLE

		
	BottomLeft:


		lda SPRITEDATA.BottomLeftFrame, x
		cmp #BlankSprite
		beq TurnOffSprite3
		adc #SpriteAddressStart
		sta SPRITE_POINTERS + 2
		lda SPRITEDATA.XPosLSB, x
		sta VIC.SPRITE_2_X
		lda SPRITEDATA.YPos, x
		adc #SpriteHeight
		sta VIC.SPRITE_2_Y
		lda VIC.SPRITE_ENABLE
		ora #%00000100
		sta VIC.SPRITE_ENABLE
		jmp BottomRight


	TurnOffSprite3:

		lda VIC.SPRITE_ENABLE
		and #%11111011
		sta VIC.SPRITE_ENABLE


	BottomRight:

		lda SPRITEDATA.BottomRightFrame, x
		cmp #BlankSprite
		beq TurnOffSprite4
		adc #SpriteAddressStart
		sta SPRITE_POINTERS + 3
		lda SPRITEDATA.XPosLSB, x
		adc #SpriteWidth
		sta VIC.SPRITE_3_X
		lda SPRITEDATA.YPos, x
		adc #SpriteHeight
		sta VIC.SPRITE_3_Y
		lda VIC.SPRITE_ENABLE
		ora #%000001000
		sta VIC.SPRITE_ENABLE

		lda SPRITEDATA.XPosMSB, x
		cmp #ZERO
		beq SetMSBBitOff2

		lda VIC.SPRITE_MSB
		ora #%00001000
		sta VIC.SPRITE_MSB

		jmp Complete
		
		SetMSBBitOff2:

			lda VIC.SPRITE_MSB
			and #%11110111
			sta VIC.SPRITE_MSB
			jmp Complete


	TurnOffSprite4:

		lda VIC.SPRITE_ENABLE
		and #%11110111
		sta VIC.SPRITE_ENABLE

	Complete:
		
		//inx 
		//stx CellID
		rts


	}

	GetStatus: {

		ldx CellID
		lda SPRITEDATA.Row, x
		sta TEMP1

		lda SPRITEDATA.Column, x
		sta TEMP2

		lda SPRITEDATA.WillFall, x
		sta TEMP3

		lda SPRITEDATA.CanJump, x
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

		lda REGISTERS.JOY_PORT_2
		sta JOY_ZP2
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
			lda JOY_ZP2
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

			lda SPRITEDATA.WillFall, x
			cmp #ONE
			beq Complete

			lda #ONE
			sta JOY_RIGHT_LAST

			lda CurrentColumn
			cmp #MaxColumn
			beq Complete
			cpx #SingleVineLevelTwo
			beq Complete

			stx TEMP10

			ldy SPRITEDATA.SwingOverEnemyID, x
			sty EnemyKillPosition

			ldy #ZERO
			jsr CheckWhetherEnemies


			lda HitByEnemy
			beq NoHurdle


			lda #ONE
			sta JumpedOverEnemy

			NoHurdle:

			ldx TEMP10

			ldy SPRITEDATA.CheckWhenMovingRight, x
			sty EnemyKillPosition
			ldy #ONE
			jsr CheckWhetherEnemies
			lda HitByEnemy
			bne Complete

			//inc $d020
			inc CellID
			jsr SID.MoveMonkey
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
			lda SPRITEDATA.WillFall, x
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
			jsr SID.MoveMonkey
			lda #ONE
			sta JOY_LEFT_LAST
			lda #ZERO
			sta JOY_FIRE_LAST

			jmp ExitViaFire


			MoveLeft:

				lda #ZERO
				sta FireButtonUpThisFrame

				ldy SPRITEDATA.CheckWhenMovingLeft, x
				sty EnemyKillPosition
				ldy #ONE
				jsr CheckWhetherEnemies

				lda HitByEnemy
				bne Complete2

				dec CellID
				jsr SID.MoveMonkey
				jmp Complete2
		}

		Complete2:
			jmp Complete

		ExitViaFire:
			rts

		HandleFire:{

			lda #20
			sta FireCooldown
			
			lda SPRITEDATA.CanJump, x
			cmp #ZERO
			beq ExitViaFire


			// Jump!
			lda CellID
			adc #5
			sta CellID

			cmp #GetPineappleSpot
			bne NoPineapple

			jsr PINEAPPLE.StartFall

			NoPineapple:

			jsr SID.MoveMonkey

			ldy SPRITEDATA.Row, x
			beq CheckEnemyToRight

			ldy SPRITEDATA.CheckWhenMovingLeft, x
			sty EnemyKillPosition
			ldy #ZERO
			jsr CheckWhetherEnemies
			jmp Finish

			CheckEnemyToRight:

				ldy SPRITEDATA.CheckWhenMovingRight, x
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

			lda SPRITEDATA.OnVine, x
			cmp #ONE
			beq MoveDown

			cpx #ClimbDownLevelSpot
			bne Complete2
			

			MoveDown:

				lda CellID
				sbc #6
				sta CellID
				jsr SID.MoveMonkey
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
			bne Complete2

			lda CellID
			adc #5
			sta CellID

			jsr SID.MoveMonkey
			jmp Complete2
		}


		CheckWhetherEnemies:{

			ldx #ZERO

			EnemyLoop:

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

		jsr SID.DieSound
		lda #RED
		sta $d020
		lda #DeathTime
		sta HitByEnemy
		lda #ONE
		sta DisableControl
		rts
	}

	


}