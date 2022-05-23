ROUND_OVER: {

	// Quickest possible = 24

	* = * "Round Over"

					//    24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39   40   41   42   43   44   45   46   47   48   49   50   51   52   53   54   55   56   57   58   59   60   61   62   63   64   65   66   67   68   69   70   71   72   73   74   75   76   77   78   79   80   81   82   83   84   85   86   87   88   89   90   91   92   93   94   95   96   97   98   99  100  101  102  103  104  105  106  107  108  109  110  111  112  113  114  115  116  117  118  119  120  121  122  123  124  125  126  127  128  129  130
	TimeLookupH:	.byte $03, $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	TimeLookupM:	.byte $37, $30, $24, $18, $12, $06, $00, $94, $88, $82, $76, $70, $65, $59, $53, $48, $43, $37, $32, $27, $21, $16, $11, $06, $01, $96, $92, $87, $82, $77, $73, $68, $64, $59, $55, $51, $47, $42, $38, $34, $30, $26, $22, $19, $15, $11, $08, $04, $00, $97, $94, $90, $87, $84, $81, $78, $75, $72, $69, $66, $63, $60, $58, $55, $52, $50, $48, $45, $43, $41, $38, $36, $34, $32, $30, $28, $27, $25, $23, $21, $20, $18, $17, $15, $14, $13, $12, $10, $09, $08, $07, $06, $05, $05, $04, $03, $03, $02, $01, $01, $01, $00, $00, $00, $00, $00, $00
	TimeLookupL:	.byte $08, $75, $48, $27, $12, $03, $00, $03, $12, $27, $48, $75, $08, $47, $92, $43, $00, $63, $32, $07, $88, $75, $68, $67, $72, $83, $00, $23, $52, $87, $28, $75, $28, $87, $52, $23, $00, $83, $72, $67, $68, $75, $88, $07, $32, $63, $00, $43, $92, $47, $08, $75, $48, $27, $12, $03, $00, $03, $12, $27, $48, $75, $08, $47, $92, $43, $00, $63, $32, $07, $88, $75, $68, $67, $72, $83, $00, $23, $52, $87, $28, $75, $28, $87, $52, $23, $00, $83, $72, $67, $68, $75, $88, $07, $32, $63, $00, $43, $92, $47, $08, $75, $48, $27, $12, $03, $00
 

	Winner:		.byte 0
	Loser:		.byte 0

	Active:		.byte 0
	Stage:		.byte 0

	IsGameOver:	.byte 0
	FlashState:	.byte 0

	FlashTimer:	.byte 30
	Colours:	.byte 0, GREEN
	WaitTimer:	.byte 
	.label FlashTime = 25
	.label WaitTime = 95
	.label StartSeconds = 130

	PreviousBonus:	.byte 0, 0, 0
	Bonus:		.byte 0, 0, 0
	CurrentSeconds:	.byte 130
	
	PlayerScore:	.byte 0, 0, 0
	TempScore:		.byte 0, 0, 0
	Remaining:		.byte 0, 0, 0
	HitLevelTarget: .byte 0

	ExplosionOffset: .byte 0, 24
	ScoreColumns:	.byte 29, 5


	GameOverDirection:	.byte 0
	OverallWinner:	.byte 0
	ContinueSeconds:	.byte 7



	GameOverStartX:		.byte 45, 66, 87, 108
	GameOverPointers:	.byte 68, 69, 70, 71
	FrameTimer:			.byte 0
	XChange:			.byte 254, 255, 1, 2

	Reset: {

		lda #0
		sta HitLevelTarget
		sta Stage
		sta IsGameOver
		sta FlashState
		sta Active



		rts
	}


	Show: {

		sty Loser

		lda #FlashTime
		sta FlashTimer

		lda #1
		sta FlashState
		sta Active

		lda #0
		sta Stage

		lda #5
		sta ContinueSeconds

		lda ROCKS.Opponent, y
		sta Winner

		bne RightWins

		LeftWins:

		jsr PlayerOneWins
		rts

		RightWins:	

			ldx Winner
			lda PLAYER.CPU, x
			beq HumanWins

		CPUWins:

			lda #5
			sta Stage
			rts


		HumanWins:

			jsr PlayerTwoWins
			rts
	}


	ShowGameOver: {

		lda #0
		sta GameOverDirection

		lda #RED
		sta VIC.BORDER_COLOUR

		lda #<SCREEN_RAM + 42
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 42
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 42
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 42
		sta ZP.ColourAddress + 1
	
		ldx #0
		ldy #0

		Loop:

			stx ZP.X

		 	lda LOSE, x
		 	sta (ZP.ScreenAddress), y

		 	tax
		 	lda CHAR_COLORS, x
		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay

		 	ldy #0
		 	jsr MoveDownRow

		 	Okay:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop


		ldx #0
		ldy #0

		Loop2:

			stx ZP.X

		 	lda LOSE + 144, x
		 	sta (ZP.ScreenAddress), y

		 	tax
		 	lda CHAR_COLORS, x
		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay2

		 	ldy #0
		 	jsr MoveDownRow

		 	Okay2:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop2



		rts
	}	


	SetupGameOverSprites: {

	

			lda #250
			ldy #192
			ldx #255
		

			jsr ROCKFORD.Start

		



		rts
	}



	GameOverUpdate: {

		lda Stage
		cmp #6
		beq Sprites

		cmp #7
		beq SpritesLeft

		jmp Finish


		Sprites:

			lda #7
			sta Stage
			rts


		SpritesLeft:

			jsr ExitGameOver

		Finish:


		rts
	}


	UpdateSprites: {


		ldx #0
		ldy #0

		stx ZP.Okay

		Loop:

			lda FrameTimer
			beq Ready

			dec FrameTimer
			jmp NoFrameUpdate

			Ready:	

				lda #4
				sta FrameTimer

				inc SPRITE_POINTERS, x
				lda SPRITE_POINTERS, x
				cmp #72
				bcc NoFrameUpdate

				lda #68
				sta SPRITE_POINTERS, x

			NoFrameUpdate:


				jsr RANDOM.Get
				and #%00000001
				clc
				adc #1
				sta ZP.Amount

				stx ZP.X

				txa
				clc
				adc ZP.FrameCounter
				and #%00000011
				tax
				
				lda XChange, x
				beq NoX
				
				clc
				adc VIC.SPRITE_0_X, y
				sta VIC.SPRITE_0_X, y

				NoX:

				ldx ZP.X
				lda GameOverDirection
				beq GoingUp

				GoingDown:

					lda VIC.SPRITE_0_Y, y
					cmp #250
					bcs Finished

					clc
					adc ZP.Amount
					sta VIC.SPRITE_0_Y, y
					jmp EndLoop


					Finished:

						inc ZP.Okay
						jmp EndLoop


				GoingUp:

					lda VIC.SPRITE_0_Y, y
					sec
					sbc ZP.Amount
					sta VIC.SPRITE_0_Y, y

					cmp #100
					bcs EndLoop

					lda #1
					sta GameOverDirection


				EndLoop:

					inx
					iny
					iny
					cpx #4
					bcc Loop

		
		lda ZP.Okay
		cmp #4
		bcc NotYet

		lda #7
		sta Stage

		NotYet:




		rts
	}


	TwoPlayerUpdate: {

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		lda #0
		sta Active
		sta Stage

		lda OverallWinner
		beq NoWinner

		Winner:

			lda #GAME_MODE_SWITCH_MENU
			sta MAIN.GameMode
			jmp NoExplosion

		NoWinner:

			lda #GAME_MODE_SWITCH_GAME
			sta MAIN.GameMode
			jmp NoExplosion

		Finish:

			lda OverallWinner
			beq NoExplosion

			Explosion:

			jsr FullRandomExplosion

		NoExplosion:

		rts
	}


	FullRandomExplosion: {

			jsr RANDOM.Get
			cmp #18
			bcs Finish

			jsr RANDOM.Get
			and #%00001111
			clc
			adc #4
			sta ZP.Row

			jsr RANDOM.Get
			and #%00011111
			sta ZP.Column

			jsr RANDOM.Get
			and #%00001111
			sta ZP.BeanColour
	
			jsr EXPLOSIONS.StartExplosion

		Finish:


		rts
	}

	FrameUpdate: {

		lda Active
		beq Finish

		lda Stage
		cmp #8
		bcc Not2Player

		TwoPlayer:

			jsr TwoPlayerUpdate
			rts

		Not2Player:

			cmp #5
			bcc NotGameOver

			jsr GameOverUpdate
			rts

		NotGameOver:

			cmp #2
			bcs NotFlash

		Flash:

			jsr FlashText

			lda Stage
			beq Finish

			lda WaitTimer
			beq Ready

			dec WaitTimer
			jmp Finish

			Ready:

				lda #2
				sta Stage

				lda #1
				sta FlashState

				lda #StartSeconds
				sta CurrentSeconds
	
				jsr ColourText
				jsr ShowBottom
				jsr DrawOtherSide
				jsr CopyData
				jsr ShowTwoPlayerScore

				jmp Finish

		NotFlash:

			cmp #3
			bcs NotBonus

			jsr CalculateTimeBonus
			jsr DrawBonus

			lda Stage
			cmp #3
			bcs Finish

			jsr AddBonusToScore
			jmp Finish


		NotBonus:

			cmp #4
			bcs AllClear



			jsr AddScoreToRemaining

		AllClear:

			jsr Exit

		Finish:



		rts
	}	



	CopyData: {

		lda MENU.SelectedOption
		cmp #PLAY_MODE_2P
		bne Finish

		lda Winner
		beq Player1


		Player2:

			lda SCORING.PlayerTwo
			sta TempScore

			lda SCORING.PlayerTwo + 1
			sta TempScore + 1

			lda SCORING.PlayerTwo + 2
			sta TempScore + 2
			rts


		Player1:

			lda SCORING.PlayerOne
			sta TempScore

			lda SCORING.PlayerOne + 1
			sta TempScore + 1

			lda SCORING.PlayerOne + 2
			sta TempScore + 2
			rts



		Finish:



		rts
	}



	
	ExitGameOver: {

		NoContinue:

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq Finish

		lda #GAME_MODE_SWITCH_MENU
		sta MAIN.GameMode

		Reset:

			
		Finish:



		rts
	}

	Exit: {


		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		bne FireHit

		lda HitLevelTarget
		beq Finish

		jsr FullRandomExplosion
		jmp Finish

		FireHit:

		lda #GAME_MODE_SWITCH_CAMPAIGN
		sta MAIN.GameMode

		lda HitLevelTarget
		beq NextOpponent

		NextLevel:

			jmp Finish

		NextOpponent:

		Finish:



		rts
	}




	AddScoreToRemaining: {

		lda HitLevelTarget
		bne TryTen

		lda ZP.FrameCounter
		and #%00000111
		bne TryTen

		ldx #SFX_BLOOP
		sfxFromX()

	
		TryTen:

			sed

			lda PlayerScore
			bne NotFinished

			jmp TryThousand

			NotFinished:

			sec
			sbc #1
			sta PlayerScore

			lda HitLevelTarget
			beq DoRemain

			jmp Draw

			DoRemain:

			lda Remaining
			sec
			sbc #01
			sta Remaining

			lda Remaining + 1
			sbc #00
			sta Remaining + 1

			lda Remaining + 2
			sbc #00
			sta Remaining + 2

			cmp #$99
			bne Draw

			lda #0
			sta Remaining + 2
			sta Remaining + 1
			sta Remaining + 0

			jmp HitTarget


		TryThousand:

			lda PlayerScore + 1
			beq TryHundredThousand

			sec
			sbc #1
			sta PlayerScore + 1


			lda HitLevelTarget
			bne Draw

			lda Remaining + 1
			sec
			sbc #01
			sta Remaining + 1

			lda Remaining + 2
			sbc #00
			sta Remaining + 2

			cmp #$99
			bne Draw

			lda #0
			sta Remaining + 2
			sta Remaining + 1
			sta Remaining + 0

			jmp HitTarget


		TryHundredThousand:

			lda PlayerScore + 2
			beq Finished

			
			sec
			sbc #1
			sta PlayerScore + 2

			lda HitLevelTarget
			bne Draw

			lda Remaining + 2
			sec
			sbc #01
			sta Remaining + 2

			cmp #$99
			bne Draw

			lda #0
			sta Remaining + 2
			sta Remaining + 1
			sta Remaining + 0

			jmp HitTarget
			
		HitTarget:

			cld
	
			jsr LevelClear
			jmp Draw


		Finished:

			lda #4
			sta Stage

			jmp Draw

		Draw:

		cld

		ldx Winner
		beq Player1

		Player2:

			jsr DrawPlayerTwoScore
			jsr DrawPlayerTwoRemaining
			rts


		Player1:

			jsr DrawPlayerOneScore
			jsr DrawPlayerOneRemaining
			rts


		
	}




	TransferScoreToPlayer: {

		ldx Winner
		beq Player1

		Player2:

			lda PlayerScore
			sta SCORING.PlayerTwo

			lda PlayerScore + 1
			sta SCORING.PlayerTwo + 1

			lda PlayerScore + 2
			sta SCORING.PlayerTwo + 2

			jsr SCORING.DrawPlayerTwo

			rts


		Player1:

			lda PlayerScore
			sta SCORING.PlayerOne

			lda PlayerScore + 1
			sta SCORING.PlayerOne + 1

			lda PlayerScore + 2
			sta SCORING.PlayerOne + 2

			jsr SCORING.DrawPlayerOne

			rts


	}



	YouWin2P: {


		ldx #0
		ldy #0

		Loop:

			stx ZP.X

		 	lda TWO_PLAYER, x
		 	sta (ZP.ScreenAddress), y

		 	tax
		 	lda CHAR_COLORS, x
		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay

		 	ldy #0

		 	jsr MoveDownRow

		 	Okay:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop

		ldx #0
		ldy #0

		Loop2:

			stx ZP.X

		 	lda WIN_BOTTOM, x
		 	sta (ZP.ScreenAddress), y

		 	cpx #132
		 	bcs UseColour

		 	cpy #0
		 	beq UseColour

		 	cpy #11
		 	beq UseColour

		 	
		 	lda #0
		 	jmp Colour

		 	UseColour:

		 	tax
		 	lda CHAR_COLORS, x

		 	Colour:

		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay2

		 	ldy #0

		 	jsr MoveDownRow

		 	Okay2:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop2


		rts



		rts
	}


	PlayerTwoWins2P: {

	
		lda #<SCREEN_RAM + 42
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 42
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 42
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 42
		sta ZP.ColourAddress + 1

		jsr YouWin2P
		//jsr DrawPlayerTwoRemaining

		rts
	}


	PlayerOneWins2P: {

		lda #<SCREEN_RAM + 66
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 66
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 66
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 66
		sta ZP.ColourAddress + 1

		jsr YouWin2P
	//	jsr DrawPlayerOneRemaining
		
		rts
	}





	DrawOtherSide: {


		lda MENU.SelectedOption
		cmp #PLAY_MODE_SCENARIO
		beq Scenario

		TwoPlayer:

		lda Winner
		beq Player1_

		Player2_:

			jsr PlayerTwoWins2P
			rts


		Player1_:

			jsr PlayerOneWins2P
			rts


		Scenario:

		lda Winner
		beq Player1

		Player2:

			jsr PlayerTwoWinsOther
			rts


		Player1:

			jsr PlayerOneWinsOther
			rts


	}


	AddBonusToTemp: {

	
		sed
		clc
		lda PlayerScore
		adc Bonus
		sta PlayerScore
		lda PlayerScore + 1
		adc #ZERO
		clc
		adc Bonus + 1
		sta PlayerScore + 1

		lda PlayerScore + 2

		adc #ZERO
		clc
		adc Bonus + 2
		sta PlayerScore + 2
		cld


		rts
	}






	AddToRealScore: {

		ldx Winner
		beq Player1

		Player2:

			lda TempScore
			sta SCORING.PlayerTwo

			lda TempScore + 1
			sta SCORING.PlayerTwo + 1

			lda TempScore + 2
			sta SCORING.PlayerTwo + 2
			
			
			sed
			clc
			lda SCORING.PlayerTwo
			adc Bonus
			sta SCORING.PlayerTwo
			lda SCORING.PlayerTwo + 1
			adc #ZERO
			clc
			adc Bonus + 1
			sta SCORING.PlayerTwo + 1

			lda SCORING.PlayerTwo + 2

			adc #ZERO
			clc
			adc Bonus + 2
			sta SCORING.PlayerTwo + 2
			cld

			jsr SCORING.DrawPlayer
			
			rts


		Player1:

		
			lda TempScore
			sta SCORING.PlayerOne

			lda TempScore + 1
			sta SCORING.PlayerOne + 1

			lda TempScore + 2
			sta SCORING.PlayerOne + 2
			
			sed
			clc
			lda SCORING.PlayerOne
			adc Bonus
			sta SCORING.PlayerOne
			lda SCORING.PlayerOne + 1
			adc #ZERO
			clc
			adc Bonus + 1
			sta SCORING.PlayerOne + 1

			lda SCORING.PlayerOne + 2

			adc #ZERO
			clc
			adc Bonus + 2
			sta SCORING.PlayerOne + 2
			cld

			jsr SCORING.DrawPlayer
			

			rts

	}


	AddBonusToScore: {

		lda ZP.FrameCounter
		and #%00000111
		bne NoSfx
		
		ldx #SFX_MOVE
		sfxFromX()

		NoSfx:

		lda MENU.SelectedOption
		cmp #PLAY_MODE_2P
		bne AddToTempScore

		jsr AddToRealScore
		rts

		AddToTempScore:

		ldx Winner
		beq Player1

		Player2:

			lda SCORING.PlayerTwo
			sta PlayerScore

			lda SCORING.PlayerTwo + 1
			sta PlayerScore + 1

			lda SCORING.PlayerTwo + 2
			sta PlayerScore + 2
			
			jsr AddBonusToTemp
			jsr DrawPlayerTwoScore
			
			rts


		Player1:

			
			lda SCORING.PlayerOne
			sta PlayerScore

			lda SCORING.PlayerOne + 1
			sta PlayerScore + 1

			lda SCORING.PlayerOne + 2
			sta PlayerScore + 2
			
			jsr AddBonusToTemp
			jsr DrawPlayerOneScore

			rts


	}


	CalculateTimeBonus: {

		
		lda CurrentSeconds
		cmp #24
		bcc SetTo24

		cmp #131
		bcs SetTo130

		jmp GetBonus


		SetTo130:

			lda #130
			jmp GetBonus

		SetTo24:

			lda #24

		GetBonus:

			sec
			sbc #24

			tax

			lda TimeLookupL, x
			sta Bonus

			lda TimeLookupM, x
			sta Bonus + 1

			lda TimeLookupH, x
			sta Bonus + 2

		dec CurrentSeconds
		lda CurrentSeconds
		cmp ROCKS.GameSeconds
		bcc ReachedTarget

		jmp Finish

		ReachedTarget:

			lda ROCKS.GameSeconds
			sta CurrentSeconds

			lda MENU.SelectedOption
			cmp #PLAY_MODE_2P
			bne Not2Player

			TwoPlayer:

				lda #8
				sta Stage

				jsr AddBonusToScore

				ldx Winner
				inc SCORING.Rounds, x

				jsr CheckWinner

				ldx #4
				sfxFromX()

				jsr ShowTwoPlayerScore
				jmp Finish

			Not2Player:

				lda #3
				sta Stage

				lda #60
				sta FlashTimer

				lda #0
				sta HitLevelTarget

				jsr AddBonusToScore
				jsr TransferScoreToPlayer

		Finish:


		rts
	}

	CheckWinner: {

		lda #0
		sta OverallWinner

		Check1:

			lda SCORING.Rounds
			cmp SETTINGS.RoundsToWin
			bcc Check2

			lda #1
			sta OverallWinner

		Check2:

			lda SCORING.Rounds + 1
			cmp SETTINGS.RoundsToWin
			bcc NoWinner

			lda #2
			sta OverallWinner

		NoWinner:



		rts
	}

	ShowTwoPlayerScore: {

		lda MENU.SelectedOption
		cmp #PLAY_MODE_2P
		bne Finish

		lda #11
		sta ZP.TextRow

		ldx Winner
		lda ScoreColumns, x
		sta ZP.TextColumn

		lda SCORING.Rounds
		jsr TEXT.ByteToDigits

		ldy #RED 
		lda #0
		ldx #3

		jsr TEXT.DrawTallDigits

		lda #11
		sta ZP.TextRow

		ldx Winner
		lda ScoreColumns, x
		clc
		adc #5
		sta ZP.TextColumn

		lda SCORING.Rounds + 1
		jsr TEXT.ByteToDigits

		lda #0
		ldy #CYAN
		ldx #3

		jsr TEXT.DrawTallDigits

		Finish:


		rts
	}


	DrawBonus: {

		lda Winner
		beq Player1

		Player2:

			jsr DrawPlayerTwoBonus
			rts

		Player1:

			jsr DrawPlayerOneBonus
			rts

	}



	DrawPlayerOneBonus: {

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
	
		ScoreLoop:

			lda Bonus,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {

			cpy #0
			beq Skip

			asl
			adc #SCORING.DoubleCharStart
			sta SCREEN_RAM + 843, y

			clc
			adc #1
			sta SCREEN_RAM + 883, y

			ColourText:

				lda #CYAN

				sta COLOR_RAM +843, y
				sta COLOR_RAM +883, y

			Skip:

			dey
			rts

		}


		rts
	}


	DrawPlayerTwoBonus: {

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
	
		ScoreLoop:

			lda Bonus,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {

			cpy #0
			beq Skip

			asl
			adc #SCORING.DoubleCharStart
			sta SCREEN_RAM + 867, y

			clc
			adc #1
			sta SCREEN_RAM + 907, y

			ColourText:

				lda #CYAN

				sta COLOR_RAM +867, y
				sta COLOR_RAM +907, y

			Skip:

			dey
			rts

		}


		rts
	}



	RandomRow: {

		jsr RANDOM.Get
		and #%00000011
		clc
		adc #6
		sta ZP.Row


		rts
	}

	RandomColumn: {


		ldx Winner
		
		jsr RANDOM.Get
		and #%00000011
		clc
		adc #3
		clc
		adc ExplosionOffset, x
		sta ZP.Column


		rts
	}

	RandomExplosion: {

		jsr RandomRow
		jsr RandomColumn

		jsr RANDOM.Get
		and #%00001111
		sta ZP.BeanColour
		
		jsr RANDOM.Get
		and #%00000001
		clc
		adc #1
		tax

		jsr EXPLOSIONS.StartExplosion

		rts
	}	



	ColourText: {

		CheckSide:

			ldy FlashState
			lda Colours, y
			ldx #0

			ldy Winner
			beq LeftSide

		RightSide:

			Loop2:
				sta COLOR_RAM + 148, x
				sta COLOR_RAM + 188, x

				inx
				cpx #8
				bcc Loop2
			
			jmp Finish

		LeftSide:

			Loop:
				sta COLOR_RAM + 124, x
				sta COLOR_RAM + 164, x

				inx
				cpx #8
				bcc Loop


		Finish:



		rts
	}


	FlashText: {

		lda FlashTimer
		beq Ready

		dec FlashTimer
		rts


		Ready:

		lda #FlashTime
		sta FlashTimer

		jsr RandomExplosion

		lda FlashState
		beq TurnOn

		TurnOff:


			lda #0
			sta FlashState
			jmp Colour

		TurnOn:

			lda #1
			sta FlashState

		Colour:

			jsr ColourText

		Finish:

		rts
	}

	MoveDownRow: {


	 	lda ZP.ScreenAddress
	 	clc
	 	adc #40
	 	sta ZP.ScreenAddress

	 	lda ZP.ScreenAddress + 1
	 	adc #0
	 	sta ZP.ScreenAddress + 1

	 	lda ZP.ColourAddress
	 	clc
	 	adc #40
	 	sta ZP.ColourAddress

	 	lda ZP.ColourAddress + 1
	 	adc #0
	 	sta ZP.ColourAddress + 1


		rts
	}


	DrawPlayerOneScore: {


		lda #0
		sta ZP.Amount

		lda PlayerScore + 2
		bne NoIncrease

		inc ZP.Amount

		NoIncrease:

		cmp #$10
		bcs Okay

		inc ZP.Amount

		Okay:


		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
		stx ZP.Amount
		
		ScoreLoop:

			lda PlayerScore,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {

			cpy ZP.Amount
			bcs NotBlank

			lda #0
			sta SCREEN_RAM + 307, y
			sta SCREEN_RAM + 347, y

			jmp Skip

			NotBlank:
			
			asl
			adc #SCORING.DoubleCharStart
			sta SCREEN_RAM + 307, y

			clc
			adc #1
			sta SCREEN_RAM + 347, y

			ColourText:	
				
				lda #PURPLE
				sta COLOR_RAM +307, y
				sta COLOR_RAM +347, y

			Skip:

			dey
			rts

		}


		rts
	}


	DrawPlayerTwoScore: {

		lda #0
		sta ZP.Amount

		lda PlayerScore + 2
		bne NoIncrease

		inc ZP.Amount

		NoIncrease:

		cmp #$10
		bcs Okay

		inc ZP.Amount

		Okay:

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
		
		ScoreLoop:

			lda PlayerScore,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {

			cpy ZP.Amount
			bcs NotBlank

			lda #0
			sta SCREEN_RAM + 283, y
			sta SCREEN_RAM + 323, y

			jmp Skip

			NotBlank:
			
			asl
			adc #SCORING.DoubleCharStart
			sta SCREEN_RAM + 283, y

			clc
			adc #1
			sta SCREEN_RAM + 323, y

			ColourText:
			
				lda #PURPLE
				sta COLOR_RAM +283, y
				sta COLOR_RAM +323, y

			Skip:

			dey
			rts

		}


		rts
	}


	YouWinOther: {


		ldx #0
		ldy #0

		Loop:

			stx ZP.X

		 	lda WIN_RIGHT, x
		 	sta (ZP.ScreenAddress), y

		 	tax
		 	lda CHAR_COLORS, x
		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay

		 	ldy #0

		 	jsr MoveDownRow

		 	Okay:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop

		ldx #0
		ldy #0

		Loop2:

			stx ZP.X

		 	lda WIN_RIGHT + 144, x
		 	sta (ZP.ScreenAddress), y

		 	cpx #48
		 	bcc UseColour

		 	cpx #132
		 	bcs UseColour

		 	cpy #0
		 	beq UseColour

		 	cpy #11
		 	beq UseColour

		 	
		 	lda #0
		 	jmp Colour

		 	UseColour:

		 	tax
		 	lda CHAR_COLORS, x

		 	Colour:

		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay2

		 	ldy #0

		 	jsr MoveDownRow

		 	Okay2:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop2


		rts





	}


	LevelClear: {

		ldx #SFX_ROTATE
		sfxFromX()

		lda #1
		sta HitLevelTarget	

		ldx Winner
		beq Player1

		Player2:

		jsr PlayerTwoLevelUp
		jmp Draw

		Player1:

		jsr PlayerOneLevelUp

		Draw:

		ldx #0
		ldy #0

		Loop2:

			stx ZP.X

		 	lda WIN_RIGHT + 144, x
		 	sta (ZP.ScreenAddress), y


		 	cpx #84
		 	bcc UseColour
		 	
		 	lda #CYAN + 8
		 	jmp Colour

		 	UseColour:

		 	tax
		 	lda CHAR_COLORS, x

		 	Colour:

		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay2

		 	ldy #0

		 	jsr MoveDownRow

		 	Okay2:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop2


		rts



	}



	DrawPlayerOneRemaining: {

		lda #0
		sta ZP.Amount

		lda HitLevelTarget
		beq SomeLeft

		lda #6
		sta ZP.Amount
		jmp Okay

		SomeLeft:

		lda Remaining + 2
		bne NoIncrease

		inc ZP.Amount

		NoIncrease:

		cmp #$10
		bcs Okay

		inc ZP.Amount

		Okay:


		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
	
		ScoreLoop:

			lda Remaining,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {

			cpy ZP.Amount
			bcs NotBlank

			lda #0
			sta SCREEN_RAM + 667, y
			sta SCREEN_RAM + 707, y
			jmp Skip

			NotBlank:

			asl
			adc #SCORING.CharacterSetStart
			sta SCREEN_RAM + 667, y

			clc
			adc #1
			sta SCREEN_RAM + 707, y

			ColourText:	
				
				lda #CYAN +8
				sta COLOR_RAM +667, y
				sta COLOR_RAM +707, y

			Skip:

			dey
			rts

		}


		rts
	}


	DrawPlayerTwoRemaining: {

		lda #0
		sta ZP.Amount

		lda HitLevelTarget
		beq SomeLeft

		lda #6
		sta ZP.Amount
		jmp Okay

		SomeLeft:

		lda Remaining + 2
		bne NoIncrease

		inc ZP.Amount

		NoIncrease:

		cmp #$10
		bcs Okay

		inc ZP.Amount

		Okay:

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
		
		ScoreLoop:

			lda Remaining,x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {

			cpy ZP.Amount
			bcs NotBlank

			lda #0
			sta SCREEN_RAM + 603, y
			sta SCREEN_RAM + 643, y
			jmp Skip

			NotBlank:
			
			asl
			adc #SCORING.CharacterSetStart
			sta SCREEN_RAM + 603, y

			clc
			adc #1
			sta SCREEN_RAM + 643, y

			ColourText:
			
				lda #CYAN +8
				sta COLOR_RAM +603, y
				sta COLOR_RAM +643, y

			Skip:

			dey
			rts

		}


		rts
	}



	PlayerOneLevelUp: {


		lda #<SCREEN_RAM + 546
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 546
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 546
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 546
		sta ZP.ColourAddress + 1

		rts

	}

	PlayerTwoLevelUp: {


		lda #<SCREEN_RAM + 522
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 522
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 522
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 522
		sta ZP.ColourAddress + 1



		rts
	}


	PlayerTwoWinsOther: {

	
		lda #<SCREEN_RAM + 42
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 42
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 42
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 42
		sta ZP.ColourAddress + 1

		jsr YouWinOther
		jsr DrawPlayerTwoRemaining

		rts
	}


	PlayerOneWinsOther: {

		lda #<SCREEN_RAM + 66
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 66
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 66
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 66
		sta ZP.ColourAddress + 1

		jsr YouWinOther
		jsr DrawPlayerOneRemaining
		
		rts
	}



	PlayerTwoWins: {

		lda #GREEN
		sta VIC.BORDER_COLOUR

		
		lda #<SCREEN_RAM + 66
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 66
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 66
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 66
		sta ZP.ColourAddress + 1

		jsr YouWinTop
		jsr BlankBottom

	
		rts
	}


	PlayerOneWins: {

		lda #GREEN
		sta VIC.BORDER_COLOUR

		lda #<SCREEN_RAM + 42
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 42
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 42
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 42
		sta ZP.ColourAddress + 1

		jsr YouWinTop
		jsr BlankBottom

	
		rts
	}



	YouWinTop: {


		ldx #0
		ldy #0

		Loop:

			stx ZP.X

		 	lda WIN_LEFT, x
		 	sta (ZP.ScreenAddress), y

		 	tax
		 	lda CHAR_COLORS, x
		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay

		 	ldy #0

		 	jsr MoveDownRow

		 	Okay:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop

		rts
	}





	YouWinBottom: {

		 ldx #0
		 ldy #0

		 Loop2:

		 	stx ZP.X

		 	lda WIN_LEFT + 144, x
		 	sta (ZP.ScreenAddress), y

		 	tax
		 	lda CHAR_COLORS, x
		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay2

		 	ldy #0

		 	jsr MoveDownRow

		 	Okay2:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop2


		ldy #YELLOW
		ldx #3

		lda #1
		jsr TEXT.DrawTallDigits




		rts
	}

	BlankBottom: {


		 ldx #0
		 ldy #0

		 Loop2:

		 	stx ZP.X

		 	lda WIN_BOTTOM, x
		 	sta (ZP.ScreenAddress), y

		 	tax
		 	lda CHAR_COLORS, x
		 	sta (ZP.ColourAddress), y

		 	iny
		 	cpy #12
		 	bcc Okay2

		 	ldy #0

		 	jsr MoveDownRow

		 	Okay2:

		 	ldx ZP.X

		 	inx
		 	cpx #144
		 	bcc Loop2



		rts
	}

	PlayerOneWinBottom: {

		lda #<SCREEN_RAM + 522
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + 522
		sta ZP.ScreenAddress + 1

		lda #<COLOR_RAM + 522
		sta ZP.ColourAddress

		lda #>COLOR_RAM + 522
		sta ZP.ColourAddress + 1

		PlayerSprite:



		SetupText:

			lda #6
			sta ZP.TextColumn

			lda #15
			sta ZP.TextRow


		jsr YouWinBottom

		rts
	}


	PlayerTwoWinBottom: {

		GrabAddresses:

			lda #<SCREEN_RAM + 546
			sta ZP.ScreenAddress

			lda #>SCREEN_RAM + 546
			sta ZP.ScreenAddress + 1

			lda #<COLOR_RAM + 546
			sta ZP.ColourAddress

			lda #>COLOR_RAM + 546
			sta ZP.ColourAddress + 1

		PlayerSprite:



		SetupText:

			lda #30
			sta ZP.TextColumn

			lda #15
			sta  ZP.TextRow




		jsr YouWinBottom
		rts
	}





	ShowBottom: {

		lda ROCKS.GameSeconds
		jsr TEXT.ByteToDigits

		lda Winner
		beq Player1

		Player2:

			jsr PlayerTwoWinBottom
			jmp Finish

		Player1:

			jsr PlayerOneWinBottom

		Finish:


		rts
	}

	ShowRest: {

		lda Stage
		beq WinMode

		LostMode:

			lda #6
			sta Stage

			jsr ShowGameOver
			jsr SetupGameOverSprites
			rts


		WinMode:

			lda #1
			sta Stage

			lda #WaitTime
			sta WaitTimer
			rts



	}


}