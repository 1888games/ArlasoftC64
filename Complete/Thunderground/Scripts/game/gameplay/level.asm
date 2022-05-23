LEVEL: {


	* = * "Level"

	TopColours:		.byte GREEN, LIGHT_BLUE, BLUE, LIGHT_GREEN
	WallColours:	.byte ORANGE, CYAN, GRAY, BLUE

	CurrentLevel:	.byte 1, 0
	SubLevel:		.byte 0
	SetOfFour:		.byte 0

	Enemy_1:		.byte WHITE, WHITE, LIGHT_BLUE, LIGHT_BLUE
	Enemy_2:		.byte WHITE, LIGHT_BLUE,LIGHT_BLUE,LIGHT_BLUE

	Map:			.byte 0, 0, 0, 1
	AllVisible:		.byte 1, 1, 0, 1, 0
	VisibleCounter:	.byte 0

	TopColour:		.byte 0
	WallColour:		.byte 0

	BaseScoreID:	.byte 0
	Complete:		.byte 0
	CompleteProgress:	.byte 0
	CompletePixelAdd:	.byte 0
	Active:			.byte 0
	CurrentMap:		.byte 0

	TicksLeft:		.byte 92
	TickXPos_LSB:	.byte 0
	TickXPos_MSB:	.byte 1
	TickTimer:		.byte 40
	FollowLikely:	.byte 
	SoundTimer:		.byte 0
	TickTime:		.byte 40

	.label TickStartX = 46
	.label TickY = 190
	.label TickPointer = 19
	.label NumTicks = 99
	.label CompleteTime = 0


	Reset: {

		lda #1
		sta CurrentLevel

		lda #0
		sta CurrentLevel + 1
		sta Complete
		sta CurrentMap

		lda #0
		sta SetOfFour

		lda #0
		sta VisibleCounter
		sta SubLevel
		sta CompletePixelAdd

		lda #1
		sta Active

		jsr ResetTicks
		jsr TOKEN.Generate
	
		jsr SetupColours

		rts
	}


	NewLevel: {

		lda #0
		sta Complete
		sta CompletePixelAdd
		sta SoundTimer

		lda #1
		sta Active

		jsr ResetTicks
		jsr SetupColours


		rts
	}

	ResetTicks: {

		lda #TickStartX
		sta TickXPos_LSB

		lda #1
		sta TickXPos_MSB

		lda TickTime
		sta TickTimer

		lda #NumTicks
		sta TicksLeft

		rts
	}


	LevelComplete: {

		lda #1
		sta Complete

		lda #0
		sta CompleteProgress
		sta CompletePixelAdd

		lda #CompleteTime
		sta TickTimer

		lda #0
		sta PLAYER.Active
		sta ENEMY.Active
		sta ENEMY.Active + 1
		sta BOMB.Active
		sta BOMB.Active + 1
		sta PLAYER.PixelsRemaining

		rts
	}

	NextLevel: {

	
		Scoring:

			inc BaseScoreID
			lda BaseScoreID
			cmp #32
			bcc NoWrapScore

			lda #16
			sta BaseScoreID

		NoWrapScore:

			inc VisibleCounter
			lda VisibleCounter
			cmp #5
			bcc Okay

			lda #4
			sta VisibleCounter

		Okay:

		sed

		lda CurrentLevel 
		clc
		adc #1
		sta CurrentLevel

		lda CurrentLevel + 1
		adc #0
		sta CurrentLevel + 1

		lda CurrentLevel
		sec
		sbc #1
		and #%00000011
		sta SubLevel

		bne NotSetOfFour

		dec TickTime
		dec TickTime

		lda TickTime
		cmp #24
		bcs OkayTime

		lda #24
		sta TickTime

		OkayTime:

		inc SetOfFour
		inc BOMB.SPEED_Pixel

		lda BOMB.SPEED_Pixel
		cmp #6
		bcc NotSetOfFour

		dec BOMB.SPEED_Pixel

		NotSetOfFour:

		cld

		ldx SubLevel
		lda Map, x
		sta CurrentMap

		jsr TOKEN.Generate

		rts
	}


	UpdateTickSprite: {

		lda #TickPointer
		sta SPRITE_POINTERS

		lda #WHITE
		sta VIC.SPRITE_COLOR_0

		lda TickXPos_LSB
		sta VIC.SPRITE_0_X

		lda #TickY
		sta VIC.SPRITE_0_Y

		lda TickXPos_MSB
		beq NoMSB

		MSB:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On
			sta VIC.SPRITE_MSB
			jmp DoneMSB

		NoMSB:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off
			sta VIC.SPRITE_MSB


		DoneMSB:




		rts
	}


	SetupColours: {

		ldx VisibleCounter
		lda AllVisible, x
		sta BASES.ShowAll

		lda SetOfFour
		and #%00000011
		tax
		lda TopColours, x
		sta TopColour

		lda WallColours, x
		sta WallColour

		ldx SubLevel
		lda Enemy_1, x
		sta ENEMY.Colour

		lda Enemy_2, x
		sta ENEMY.Colour + 1


		rts
	}


	DrawNumber:{

		lda #2
		sta ZP.EndID

		lda CurrentLevel + 1, x
		bne FourDigits

		TwoDigits:

			dec ZP.EndID

			ldx #29
			ldy #22

			jsr PLOT.GetCharacter

			ldy #4	// screen offset, right most digit
			ldx #ZERO	// score byte index
			jmp InMills

		FourDigits:

			ldx #27
			ldy #22

			jsr PLOT.GetCharacter

			ldy #8	// screen offset, right most digit
			ldx #ZERO	// score byte index

		InMills:

		ScoreLoop:

			lda CurrentLevel, x
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			beq NoCheck

			cmp #0
			beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop

		PlotDigit: {

			//.break

			stx ZP.StoredXReg

			asl
			asl
			tax

			lda SCORE.NumberChars, x

			dey
			sta (ZP.ScreenAddress), y

			
			lda #WHITE
			sta (ZP.ColourAddress), y

			inx
			lda SCORE.NumberChars, x
			iny
			sta (ZP.ScreenAddress), y

			lda #WHITE
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #39
			tay

			inx
			lda SCORE.NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #WHITE
			sta (ZP.ColourAddress), y

		
			iny 
			inx
			lda SCORE.NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #WHITE
			sta (ZP.ColourAddress), y

			tya
			sec
			sbc #42
			tay

			ldx ZP.StoredXReg

			rts


		}

		Finish:

		rts

	}


	HandleComplete: {

		inc CompletePixelAdd
		inc CompletePixelAdd

		dec TicksLeft

		ldy #69
		jsr SCORE.AddScore

		lda TicksLeft
		bne Finish


		lda #0
		sta Complete
		sta Active

		
		jsr NextLevel
		jsr MAIN.NextLevel
	


		Finish:


		lda SoundTimer
		beq Ready

		dec SoundTimer
		jmp Exit

		Ready:

		sfx(SFX_COMPLETE)

		lda #16
		sta SoundTimer


		Exit:

		lda #CompleteTime
		sta TickTimer


		rts
	}


	FrameUpdate: {

		lda Active
		beq Finish

		lda TickTimer
		beq Ready

		cmp #255
		beq Finish

		dec TickTimer
		rts
		
		Ready:

			lda Complete
			beq GameContinues

			jmp HandleComplete

		GameContinues:

			lda #TickTime
			sta TickTimer

			lda TickXPos_LSB
			sec
			sbc #2
			sta TickXPos_LSB

			lda TickXPos_MSB
			sbc #0
			sta TickXPos_MSB

			dec TicksLeft

			lda TicksLeft
			bne Finish

			lda #255
			sta TickTimer

			jsr PLAYER.Died
			// LOSE LIFE HERE


		Finish:

			cmp #20
			bcs NoAlarm


			sfx(SFX_ALARM)


		NoAlarm:




		rts
	}

	


}