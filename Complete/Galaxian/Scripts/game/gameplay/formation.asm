FORMATION: {

	
	* = * "Formation"

	.label SR = 50
	.label SC = 20

	.label TransformStages = 5
	.label TransformTime = 20


	SpriteRow:	.fill 4, SR
				.fill 6, SR + (2 * 8)
				.fill 8, SR + (4 * 8)
				.fill 10, SR + (6 * 8)
				.fill 10, SR + (8* 8)
				.fill 10, SR + (10* 8)
				.fill 2, 0


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


	TypeToColour:		.byte YELLOW + 8, YELLOW + 8, PURPLE + 8, CYAN + 8
	TypeCharAdd:		.byte 0, 78, 0, 0

	CurrentRow:	.byte 255


	LeftMaxColumn:	.byte 3
	RightMinColumn:	.byte 21
	FrameAdd:	.byte 0, 8

	IllegalOffsetLeft:	.byte -4
	IllegalOffsetRight: .byte 4
	ScrollExtentRight:	.byte 26
	ScrollExtentLeft:	.byte 26

	FlagshipEnemyIDs:	.byte 1, 8, 9, 10




						      // 0         // 1      // 2       // 3
	TopLeftChars:		.byte 135, 135, 139, 139, 143, 143, 000, 166
						.byte 154, 154, 158, 158, 162, 162, 174, 147

	TopMiddleChars:		.byte 136, 136, 140, 140, 144, 144, 148, 148
						.byte 155, 155, 159, 159, 163, 163, 167, 167

	TopRightChars:		.byte 000, 158, 000, 162, 173, 147, 151, 151
						.byte 000, 139, 000, 143, 175, 166, 170, 170


	BottomLeftChars:	.byte 138, 138, 142, 142, 146, 146, 169, 169
						.byte 157, 157, 000, 000, 000, 000, 000, 150

	BottomMiddleChars:	.byte 137, 137, 141, 141, 145, 145, 149, 149
						.byte 000, 000, 160, 160, 164, 164, 168, 168


	BottomRightChars:	.byte 000, 000, 000, 000, 150, 150, 152, 152
						.byte 000, 142, 000, 146, 000, 169, 000, 000



	TopLeftChar:		.byte 184, 184, 188, 188, 192, 192, 208, 234
	TopMiddleChar:		.byte 185, 185, 189, 189, 193, 193, 209, 209
	TopRightChar:		.byte 000, 188, 000, 192, 196, 156, 212, 212
	BottomLeftChar:		.byte 187, 187, 191, 191, 195, 195, 000, 000
	BottomMiddleChar:	.byte 186, 186, 190, 190, 194, 194, 210, 210
	BottomRightChar:	.byte 000, 191, 000, 192, 000, 000, 211, 211


	//Spread_Order:	.byte 0, 3, 4, 11, 12, 19, 20, 29, 30, 39


		Type:	.byte          0, 0, 0, 0	// 0-1
				.byte       1, 1, 1, 1, 1, 1 // 2-7
				.byte    2, 2, 2, 2, 2, 2, 2, 2 // 8-15
				.byte 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 // 16-25
				.byte 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 // 26-35
				.byte 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 // 36-45
				.byte 4, 4, 4 // 40-42

		StartOffset:

				.byte          0, 1, 2, 3	// 0-1
				.byte       3, 0, 1, 2, 3, 0 // 2-7
				.byte    2, 3, 0, 1, 2, 3, 0, 1 // 8-15
				.byte 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 // 16-25
				.byte 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 // 26-35
				.byte 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 // 36-45
				.byte 4, 4, 4 // 40-42

		* = * "Offset"

		Offset:

				.byte          0, 1, 2, 3	// 0-3
				.byte       3, 0, 1, 2, 3, 0 // 4-9
				.byte    2, 3, 0, 1, 2, 3, 0, 1 // 10-17
				.byte 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 // 18-27
				.byte 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 // 28-37
				.byte 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 // 38-47
				.byte 4, 4, 4 // 40-42


	Home_Column:
				.byte 			  10, 12, 14, 16	
				.byte         07, 10, 12, 14, 16, 19
				.byte     05, 07, 10, 12, 14, 16, 19, 21
				.byte 03, 05, 07, 10, 12, 14, 16, 19, 21, 23
				.byte 03, 05, 07, 10, 12, 14, 16, 19, 21, 23
				.byte 03, 05, 07, 10, 12, 14, 16, 19, 21, 23
				
				.byte 9, 9


	Home_Row:	.byte 				0, 0, 0, 0	
				.byte 			2, 2, 2, 2, 2, 2
				.byte 		4, 4, 4, 4, 4, 4, 4, 4
				.byte 	6, 6, 6, 6, 6, 6, 6, 6, 6, 6
				.byte 	8, 8, 8, 8, 8, 8, 8, 8, 8, 8
				.byte 10, 10, 10, 10, 10, 10, 10, 10, 10, 10


	Relative_Row:	.fill 4, 0
					.fill 6, 1
					.fill 8, 2
					.fill 10, 3
					.fill 10, 4
					.fill 10, 5

	Relative_Column:	.byte   	   3, 4, 5, 6
						.byte 	    2, 3, 4, 5, 6, 7
						.byte    1, 2, 3, 4, 5, 6, 7, 8
						.byte 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
						.byte 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
						.byte 0, 1, 2, 3, 4, 5, 6, 7, 8, 9


   					//0  1  2  3  4  5  6  7  8  9
	Frames:		.byte 		   1, 0, 1, 0
				.byte 		1, 0, 1, 0, 1, 0
				.byte 	 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
				.byte 1, 0


				//              0  1  2  3
				//			 4  5  6  7  8  9
				// 	     10 11 12 13 14 15 16 17
				//    18 19 20 21 22 23 24 25 26 27
				//    28 29 30 31 32 33 34 35 36 37
				//    38 39 40 41 42 43 44 45 46 47

			StartIDs:		.byte 0, 4, 10, 18, 28, 38
			EndIDs:			.byte 3, 9, 17, 27, 37, 47


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
			cpx #48
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
		sta Frame
		sta Mode
		sta FrameTimer

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
		//clc
		//adc OffsetChars
		sta ZP.Column

		bpl Okay

		.break
		lda #ERROR
		nop


		Okay:

		lda Type, x
		tay
		lda TypeToColour, y
		sta ZP.Colour

		lda TypeCharAdd, y
		sta ZP.Temp4


		lda Offset, x
		asl
		sta ZP.Amount

		cmp #6
		beq LookLeft


		LookRight:

			cpx ZP.EndID
			beq AddFrame

			clc
			adc Occupied + 1, x
			sta ZP.Amount
			jmp AddFrame

		LookLeft:

			cpx ZP.StartID
			beq AddFrame

			clc
			adc Occupied - 1, x
			sta ZP.Amount


		AddFrame:

			cpx #4
			bcs NormalEnemy


		Flagship:

			ldy ZP.Column
			ldx ZP.Amount

			lda TopLeftChar, x
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			iny
			lda TopMiddleChar, x
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y

			iny
			lda TopRightChar, x
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #38
			tay

			lda BottomLeftChar, x
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y

			iny
			lda BottomMiddleChar, x
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y

			iny
			lda BottomRightChar, x
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y

			rts

		NormalEnemy:

			txa
			clc
			adc Frame
			tax

			lda Frames, x
			ldx ZP.CurrentID
			tay
			lda FrameAdd, y
			clc
			adc ZP.Amount
			sta ZP.CharID

		DrawChars:



			ldy ZP.Column
			ldx ZP.CharID
			lda TopLeftChars, x
			clc
			adc ZP.Temp4
			sta (ZP.ScreenAddress), y

			lda ZP.Colour
			sta (ZP.ColourAddress), y

			iny
			lda TopMiddleChars, x
			clc
			adc ZP.Temp4
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y

			iny
			lda TopRightChars, x
			clc
			adc ZP.Temp4
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y


			tya
			clc
			adc #38
			tay

			lda BottomLeftChars, x
			clc
			adc ZP.Temp4
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y

			iny
			lda BottomMiddleChars, x
			clc
			adc ZP.Temp4
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y

			iny
			lda BottomRightChars, x
			clc
			adc ZP.Temp4
			sta (ZP.ScreenAddress), y
			lda ZP.Colour
			sta (ZP.ColourAddress), y


		rts
	}
	

	ProcessIteration: {

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
			cmp #6
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
			cmp #2
			bcc Okay

			lda #0
			sta FrameCounter

			lda Frame
			eor #%00000001
			sta Frame

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
				cpy #48
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

		lda #-4
		sta IllegalOffsetLeft

		Loop:

			lda CHARGER.AliensInColumn, x
			bne DoneLeft

			dec IllegalOffsetLeft
			dec IllegalOffsetLeft

			EndLoop:

			inx
			cpx #4
			bcc Loop


		DoneLeft:

		ldx #9

		lda #4
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
			cpx #48
			bcc Loop2

		rts
	}
	

	
	ClearRow: {

		//inc $d020

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
		
			.for(var i=0; i<28; i++) {
				
				sta SCREEN_RAM + 400 + i
				sta SCREEN_RAM + 440 + i
			
			}

			//dec $d020

			rts



		Five:

			lda #0
		
			.for(var i=0; i<28; i++) {
				
				sta SCREEN_RAM + 320 + i
				sta SCREEN_RAM + 360 + i
			
			}

			//dec $d020

			rts


		Four:

			lda #0
		
			.for(var i=0; i<28; i++) {
				
				sta SCREEN_RAM + 240 + i
				sta SCREEN_RAM + 280 + i
			
			}

		//	dec $d020

			rts

		Three:

			lda #0
		
			.for(var i=0; i<28; i++) {
				
				sta SCREEN_RAM + 160 + i
				sta SCREEN_RAM + 200 + i
			
			}

			//dec $d020

			rts
			
			
		Two:

			lda #0
		
			.for(var i=0; i<28; i++) {
				
				sta SCREEN_RAM + 080 + i
				sta SCREEN_RAM + 120 + i
				
			}

			//dec $d020
			rts
			

		One:

			lda #0

			.for(var i=0; i<28; i++) {
				
				sta SCREEN_RAM + 000 + i
				sta SCREEN_RAM + 040 + i
				
			}

			//dec $d020
			rts

	}

}