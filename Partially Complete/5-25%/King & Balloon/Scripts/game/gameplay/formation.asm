FORMATION: {

	
	* = * "Formation"

	.label SR = 50
	.label SC = 20

	.label TransformStages = 5
	.label TransformTime = 20


	SpriteRow:	.fill 12, SR
				.fill 12, SR + (2 * 8)
				.fill 10, SR + (4 * 8)
				.fill 8, SR + (6 * 8)
				


	FormationSpriteX:

				.fill 48, 0

	Drawn:		.fill 48, 0

	.label ExplosionChar = 63
	.label EXPLOSION_TIME = 3
	.label UpdatesPerFrame = 8
	.label MAX_EXPLOSIONS= 3


	Column:		.fill 48, 0
	Switching:	.byte 0

	* = * "Alive"
	Alive:		.fill 48, 0

	TypeToScore:		.byte 4, 4, 2, 0, 3, 7
	


	Stop:			.byte 0
	Stopping:		.byte 0
	Starting:		.byte 0
	ScrollValue:	.byte 0


	DrawIteration:	.byte 0
	
	FrameTimer:	.byte 0


	* = * "Enemies Left"
	EnemiesLeftInStage:	.byte 0


	TypeToColour:		.byte RED + 8, YELLOW + 8, YELLOW + 8, WHITE + 8
	TypeToColour2:		.byte WHITE + 8, YELLOW + 8, YELLOW + 8, RED + 8
	TypeCharAdd:		.byte 0, 78, 0, 0

	CurrentRow:	.byte 255


	LeftMaxColumn:	.byte 3
	RightMinColumn:	.byte 21
	FrameAdd:	.byte 0, 8

	IllegalOffsetLeft:	.byte -2
	IllegalOffsetRight: .byte 2
	ScrollExtentRight:	.byte 26
	ScrollExtentLeft:	.byte 26

	FlagshipEnemyIDs:	.byte 1, 8, 9, 10


	// offset 0-3   // 0-63, 64-127, 128-191, 192-255     * 16
	// frames 0-2	// 0-15, 16-31, 32-47, 48-63   etc.   * 4
	// type 0-3     // 0-3, 4-7, 8-11, 12-15              * 4

						// off 0    1    2    3   0    1    2    3    0    1    2    3    0    1    2    3
						// type       red                 orange              yellow            white  
						// frame      0

	Mult64:				.byte 0, 64, 128, 196
	Mult16:				.byte 0, 16, 32, 48
	Mult4:				.byte 0, 4, 8, 12

	TopLeft:			.byte 094, 098, 102, 106, 110, 113, 116, 120, 094, 098, 102, 106, 094, 098, 102, 106   // f1
						.byte 123, 126, 129, 133, 137, 139, 142, 146, 123, 126, 129, 133, 123, 126, 129, 133   // f2
						.byte 149, 152, 129, 133, 161, 164, 142, 146, 149, 152, 129, 133, 149, 152, 129, 133   // f3


	TopRight:			.byte 095, 099, 103, 107, 111, 114, 117, 121, 095, 099, 103, 107, 095, 099, 103, 107
						.byte 095, 099, 130, 134, 111, 114, 143, 147, 095, 099, 130, 134, 095, 099, 130, 134
						.byte 150, 153, 156, 159, 162, 165, 168, 170, 150, 153, 156, 159, 150, 153, 156, 159
						

	BottomLeft:			.byte 097, 101, 105, 109, 097, 115, 119, 109, 172, 173, 175, 109, 097, 101, 105, 109
						.byte 125, 128, 132, 136, 125, 141, 145, 136, 177, 179, 181, 136, 125, 128, 132, 136
						.byte 151, 155, 158, 109, 151, 155, 158, 109, 183, 185, 158, 109, 151, 155, 158, 109
					

	BottomRight:		.byte 096, 100, 104, 108, 096, 100, 118, 122, 096, 100, 174, 176, 096, 100, 104, 108
						.byte 124, 127, 131, 135, 124, 127, 131, 135, 124, 178, 180, 182, 124, 127, 131, 135
						.byte 096, 154, 157, 160, 096, 154, 157, 160, 096, 184, 186, 187, 096, 154, 157, 160
						



* = * "Type"
	Type:	.fill 12, 0
			.fill 12, 1
			.fill 10, 2
			.fill 8, 3
			

		StartOffset:

				.fill 42, 0


		* = * "Offset"

		Offset:

				.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte       3, 0, 1, 2, 3, 0 // 4-9
				.byte    2, 3, 0, 1, 2, 3, 0, 1 // 10-17
				.byte 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 // 18-27
				.byte 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 // 28-37
				.byte 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 // 38-47
				.byte 4, 4, 4 // 40-42


	Home_Column:
				.byte 02, 04, 06, 08, 10, 12, 14, 16, 18, 20, 22, 24			 
				.byte 02, 04, 06, 08, 10, 12, 14, 16, 18, 20, 22, 24
				.byte     04, 06, 08, 10, 12, 14, 16, 18, 20, 22
				.byte 	  	  06, 08, 10, 12, 14, 16, 18, 20
				


	Home_Row:	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.byte 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
				.byte    4, 4, 4, 4, 4, 4, 4, 4, 4, 4
				.byte 	    6, 6, 6, 6, 6, 6, 6, 6
				


	Relative_Row:	.fill 12, 0
					.fill 12, 1
					.fill 10, 2
					.fill 8, 3

					
	Relative_Column:	.byte 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11  	
						.byte 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11  	
						.byte    1, 2, 3, 4, 5, 6, 7, 8, 9, 10
						.byte       2, 3, 4, 5, 6, 7, 8, 9
					

   					//0  1  2  3  4  5  6  7  8  9
	Frames:		
				.fill 42, 1


				//              0  1  2  3
				//			 4  5  6  7  8  9
				// 	     10 11 12 13 14 15 16 17
				//    18 19 20 21 22 23 24 25 26 27
				//    28 29 30 31 32 33 34 35 36 37
				//    38 39 40 41 42 43 44 45 46 47

			StartIDs:		.byte 0, 12, 24, 34
			EndIDs:			.byte 11, 23, 33, 41


	LeftSearchOrder:		.byte 18, 28, 38, 10, 19, 29, 39
							.byte 4, 11, 20, 30, 40, 5, 12, 21, 31, 41
							.byte 6, 13, 22, 32, 42, 7, 14, 23, 33, 43
							.byte 8, 15, 24, 34, 44, 9, 16, 25, 35, 45
							.byte 17, 26, 36, 46, 27, 37, 47


	RightSearchOrder:		.byte 27, 37, 47, 17, 26, 36, 46
							.byte 9, 16, 25, 35, 45, 8, 15, 24, 34, 44
							.byte 7, 14, 23, 33, 43, 6, 13, 22, 32, 42
							.byte 5, 12, 21, 31, 41,  4, 11, 20, 30, 40
							.byte 10, 19, 29, 39, 18, 28, 38



	Occupied:	.fill 48, 0


	ExplosionTimer: .fill MAX_EXPLOSIONS, 0
	ExplosionList:	.fill MAX_EXPLOSIONS, 255
	ExplosionProgress:	.fill MAX_EXPLOSIONS, 0
	ExplosionX:		.fill MAX_EXPLOSIONS, 0
	ExplosionY:		.fill MAX_EXPLOSIONS, 0

	ExplosionColour:	.byte WHITE + 8, YELLOW + 8, YELLOW + 8, YELLOW + 8


	Mode:		.byte FORMATION_UNISON

	Position:	.byte 0
	PreviousPosition: .byte 0
	Direction:	.byte 1
	SwitchingDirection:	.byte 0
	Speeds:		.byte 7, 12
	SpreadPosition:	.byte 0



	Frame:			.byte 0
	FrameOrder:		.byte 2, 1, 2, 1, 0, 1
	CurrentSlot:	.byte 255
	FrameCounter:	.byte 0

	ColumnSpriteX:	.fill 40, 24 + (i * 8)
	RowSpriteY:		.fill 25, 50 + (i * 8)
	

	TypeCharStart:		.byte 169, 181, 189, 189, 246, 232 
	Colours:			.byte YELLOW + 8, YELLOW + 8, PURPLE + 8, CYAN + 8, YELLOW + 8, GREEN + 8
	TransformColours:	.byte GREEN + 8, YELLOW + 8, GREEN + 8, CYAN + 8, YELLOW + 8, GREEN + 8

	TransformProgress:	.byte 0
	TransformTimer:		.byte 0
	TransformID:		.byte 255

	OffsetChars:		.byte 0



	Initialise: {

		ldx #0

		Loop:

			lda StartOffset, x
			sta Offset, x
			asl
			sta FormationSpriteX, x

			ldy Home_Column, x
			lda ColumnSpriteX, y
			clc
			adc FormationSpriteX, x
			sta FormationSpriteX, x

			
			lda #0
			sta Occupied, x
			sta Column, x
			sta Drawn, x
		
			inx
			cpx #42
			bcc Loop


		lda #0
		sta Position
		sta PreviousPosition
		sta CurrentSlot
		sta FrameCounter
		sta SpreadPosition
		sta Switching
		sta Stop
		sta OffsetChars
		sta SwitchingDirection
		sta Stopping
		sta Starting
		sta ScrollValue
	

		lda #1
		sta Direction
		sta Mode
		sta FrameTimer

		lda #2
		sta Frame

		lda #STAGE.NumberOfWaves * 8
		sta Alive



		lda #255
		sta TransformID
		sta DrawIteration
		sta CurrentRow


		rts
	}


	


		

	DrawEnemy: {

		// x = enemy ID
		// ZP.Row
		// ZP.Column > y

		.label ERROR = $04

		lda Column, x
		clc
		adc Home_Column, x
		sta ZP.Column

		bpl Okay

		.break
		lda #ERROR
		nop


	Okay:	

	GetFrame:	// 0-15, 16-31, 32-47, 48-63
		
		lda Frame
		tay
		lda FrameOrder, y
		tay
		lda Mult16, y
		sta ZP.Amount

	GetType:	// 0-3, 4-7, 8-11, 12,15

		lda Type, x
		tay
		lda TypeToColour, y
		sta ZP.Colour
		lda TypeToColour2, y
		sta ZP.Temp4

	GetOffset:	// 0-3

		lda Mult4, y
		clc
		adc ZP.Amount
		clc
		adc Offset, x
		sta ZP.Amount

	DrawTopLeft:

		ldy ZP.Column
		ldx ZP.Amount

		lda TopLeft, x
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

	DrawTopRight:

		iny
		lda TopRight, x
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y

	DrawBottomLeft:

		tya
		clc
		adc #39
		tay
		lda BottomLeft, x
		sta (ZP.ScreenAddress), y

		lda ZP.Temp4
		sta (ZP.ColourAddress), y

	DrawBottomRight:

		iny
		lda BottomRight, x
		sta (ZP.ScreenAddress), y

		lda ZP.Temp4
		sta (ZP.ColourAddress), y

		rts
	}
	

	ProcessIteration: {

		ldx DrawIteration
		cmp #4
		bcc Valid

		rts

	Valid:


		jsr ClearRow

		ldx DrawIteration
		lda StartIDs, x
		sta ZP.CurrentID
		sta ZP.StartID


		lda EndIDs, x
		sta ZP.EndID
		//inc ZP.EndID


		ldx ZP.CurrentID

		GetScreenAddress:

			lda Home_Row, x
			sta ZP.Row
			tay

			ldx #0
			sty ZP.Column
			jsr PLOT.GetCharacter

		ldx ZP.CurrentID

		Loop:

			stx ZP.CurrentID

			//lda Occupied, x
			//beq EndLoop

			MoveIt:

			//	ldx ZP.CurrentID

				lda Stop
				bne Okay

				lda Direction
				beq GoingLeft

				GoingRight:

					lda FormationSpriteX, x
					clc
					adc #2
					sta FormationSpriteX, x

					lda Offset, x
					clc
					adc #1
					sta Offset, x

					cmp #4
					bcc Okay

					lda #0
					sta Offset, x

					inc Column, x


					lda Column, x
					cmp IllegalOffsetRight
					bne Okay

				NoDec:

					inc SwitchingDirection

					jmp Okay

				GoingLeft:

					lda FormationSpriteX, x
					sec
					sbc #2
					sta FormationSpriteX, x


					lda Offset, x
					sec
					sbc #1
					sta Offset, x
					bpl Okay

					lda #3
					sta Offset, x

					dec Column, x
					lda Column, x
					cmp IllegalOffsetLeft
					bne Okay

				ReachedEdgeLeft:

				NoIncrease:
					inc SwitchingDirection


			Okay:

				ldx ZP.CurrentID
				lda Occupied, x
				beq EndLoop

				lda #1
				sta Drawn, x

				jsr DrawEnemy

			EndLoop:

				ldx ZP.CurrentID
				cpx ZP.EndID
				beq Done

				inx
			

			NotSwitching:

				jmp Loop


		Done:

		
		rts
	}

		
	FrameUpdate: {

	//	jsr CalculateEnemiesLeft

		SetDebugBorder(8)
		
		lda #0
		sta ZP.Temp4

		
		Ready:

		lda Mode
		beq Start

		jmp Finish
		
		Start:

			inc ZP.Temp4
			inc DrawIteration
			lda DrawIteration
			cmp #5
			bcc Okay

			lda #0
			sta DrawIteration

			lda Stopping
			sta Stop

			lda Starting
			beq NotStarting

			lda #0
			sta Stop

		NotStarting:

		
			lda #0
			sta Stopping
			sta Starting


			lda SwitchingDirection
			beq NotSwitching

			lda #0
			sta SwitchingDirection

			lda Direction
			eor #%00000001
			sta Direction

		NotSwitching:

			lda #1
			sta FrameTimer

			inc FrameCounter
			lda FrameCounter
			cmp #3
			bcc Okay

			lda #0
			sta FrameCounter

			inc Frame
			lda Frame
			cmp #6
			bcc Okay

			lda #0
			sta Frame
			//sta Frame

		Okay:

			jsr ProcessIteration

			lda DrawIteration
			bne Exit

			lda Stop
			bne Exit

			lda Direction
			beq GoingLeft

			GoingRight:

				lda ScrollValue
				clc
				adc #2
				sta ScrollValue

				jmp Finish

			GoingLeft:

				lda ScrollValue
				sec
				sbc #2
				sta ScrollValue

			lda IRQ.SidTimer
			bmi Finish

			lda DrawIteration
			cmp #1
			bne Finish

			jmp Start

		Finish:

			lda #0
			sta TextColumn
			sta TextRow

			ldy #YELLOW

			lda EnemiesLeftInStage
			ldx #0
			//jsr TEXT.DrawByteInDigits

		Exit:

		SetDebugBorder(0)


		rts
	}

	


	Hit: {

		
		stx ZP.FormationID

		jsr STATS.Hit

		ldx ZP.FormationID
	
		Destroy:	

			dec drone_max

			lda #0
			sta Occupied, x
			sta Alive, x

			sty ZP.FormationID

			lda Type, x
			tay

			lda #2
		//	tay
			//clc
			//adc #1
			
			sfxFromA()

			jsr SCORE.AddScore

			ldx ZP.FormationID

		NoDelete:

		


		rts
	}

	


	CalculateEnemiesLeft: {

		SetDebugBorder(9)

		ldy #0
		sty EnemiesLeftInStage
		sty CHARGER.HaveAliensInTopRow
		sty CHARGER.HaveAliensIn2ndRow
		sty CHARGER.HaveAliensIn3rdRow
		sty CHARGER.HaveAliensIn4thRow
		sty CHARGER.HaveAliensIn5thRow
		sty CHARGER.HaveAliensIn6thRow
		sty CHARGER.HaveBluePurpleAliens
		sty CHARGER.SwarmAliens
		sty CHARGER.InflightAliens
		sty CHARGER.AliensInColumn + 0
		sty CHARGER.AliensInColumn + 1
		sty CHARGER.AliensInColumn + 2
		sty CHARGER.AliensInColumn + 3
		sty CHARGER.AliensInColumn + 4
		sty CHARGER.AliensInColumn + 5
		sty CHARGER.AliensInColumn + 6
		sty CHARGER.AliensInColumn + 7
		sty CHARGER.AliensInColumn + 8
		sty CHARGER.AliensInColumn + 9
		sty CHARGER.AliensInColumn + 10
		sty CHARGER.AliensInColumn + 11

		iny

		FlyingLoop:

			lda ENEMY.Plan, y
			beq EndFlyingLoop

			cmp #RETURNING_TO_SWARM
			beq DontRemoveYet

			lda ENEMY.Slot, y
			tax

			lda #0
			sta FORMATION.Occupied, x

			lda FORMATION.Relative_Column, x
			tax
			inc CHARGER.AliensInColumn, x

			inc CHARGER.InflightAliens
			inc EnemiesLeftInStage

			jmp EndFlyingLoop

		DontRemoveYet:

			inc CHARGER.InflightAliens
			inc EnemiesLeftInStage

			lda ENEMY.Slot, y
			tax

			lda FORMATION.Relative_Column, x
			tax
			inc CHARGER.AliensInColumn, x

			EndFlyingLoop:

			iny
			cpy #MAX_ENEMIES
			bcc FlyingLoop


		ldy #0

		Loop:

			* = * "Hmm"

			lda FORMATION.Occupied, y
			beq EndLoop

			UpdateRowCounts:

				lda FORMATION.Relative_Row, y
				tax
				inc CHARGER.HaveAliensInTopRow, x

				cpx #2
				bcc UpdateColumnCounts

				inc CHARGER.HaveBluePurpleAliens
				
			UpdateColumnCounts:

				inc EnemiesLeftInStage
				inc CHARGER.SwarmAliens

				lda FORMATION.Relative_Column, y
				tax
				inc CHARGER.AliensInColumn, x

			EndLoop:

				iny
				cpy #42
				bcc Loop

			SetDebugBorder(0)

			lda ZP.Counter
			and #%00011111
			bne DontOverride

			jsr CalculateExtents

	DontOverride:

		rts

	}

	CalculateExtents: {

		ldx #0

		lda #-2
		sta IllegalOffsetLeft

		Loop:

			lda CHARGER.AliensInColumn, x
			bne DoneLeft

			dec IllegalOffsetLeft
			dec IllegalOffsetLeft

			EndLoop:

			inx
			cpx #6
			bcc Loop


		DoneLeft:

		ldx #11

		lda #3
		sta IllegalOffsetRight

		Loop2:

			lda CHARGER.AliensInColumn, x
			bne DoneRight

			inc IllegalOffsetRight
			inc IllegalOffsetRight

			EndLoop2:

			dex
			cpx #6
			bcs Loop2

		DoneRight:

		rts
	}


	ClearAll: {

		ldx #0
	
		Loop:

			stx DrawIteration

			jsr ClearRow

			inx
			cpx #6
			bcc Loop

		ldx #0

		Loop2:

			lda #0
			sta FORMATION.Occupied, x

			inx
			cpx #42
			bcc Loop2

		rts
	}
	

	
	ClearRow: {


		ldx DrawIteration
		bne NotOne

		jmp One

		NotOne:

		cpx #1
		bne NotTwo

		jmp Two

		NotTwo:

		cpx #2
		bne NotThree

		jmp Three

		NotThree:

		cpx #3
		bne NotFour

		jmp Four

		NotFour:

		cpx #4
		bne NotFive

		jmp Five

		NotFive:

			lda #0
		
			.for(var i=0; i<29; i++) {
				
				sta SCREEN_RAM + 400 + i
				sta SCREEN_RAM + 440 + i
			
			}

			//dec $d020

			rts



		Five:

			lda #0
		
			.for(var i=0; i<29; i++) {
				
				sta SCREEN_RAM + 320 + i
				sta SCREEN_RAM + 360 + i
			
			}

			//dec $d020

			rts


		Four:

			lda #0
		
			.for(var i=0; i<29; i++) {
				
				sta SCREEN_RAM + 240 + i
				sta SCREEN_RAM + 280 + i
			
			}

			

			rts

		Three:

			lda #0
		
			.for(var i=0; i<29; i++) {
				
				sta SCREEN_RAM + 160 + i
				sta SCREEN_RAM + 200 + i
			
			}

		

			rts
			
			
		Two:

			lda #0
		
			.for(var i=0; i<29; i++) {
				
				sta SCREEN_RAM + 080 + i
				sta SCREEN_RAM + 120 + i
				
			}

			
			rts
			

		One:

			lda #0

			.for(var i=0; i<29; i++) {
				
				sta SCREEN_RAM + 000 + i
				sta SCREEN_RAM + 040 + i
				
			}

			rts

	}

}