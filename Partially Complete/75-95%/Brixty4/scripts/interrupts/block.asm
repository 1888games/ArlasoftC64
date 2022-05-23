BLOCK:{


	TopLeft:			.byte 1, 9, 15, 21
	
	BottomLeftSmall:	.byte 0, 31, 29, 27
	BottomRightSmall:	.byte 0, 32, 30, 28 

	.label LeftBlock = 5
	.label RightBlock = 6
	.label BottomLeft = 7
	.label BottomRight = 8

	// Data at given height 0 - 20
	TopType:		.byte 0, 3, 2, 1, 0, 3, 2, 1, 0, 3, 2, 1, 0, 3, 2, 1, 0, 3, 2, 1, 0
	CharHeight:		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3
	Colours:		.byte 1, 2, 2, 9, 9, 9, 9, 8, 8, 8, 8, 5, 5, 5, 13, 13, 13,  7, 7, 7, 7
					
	XPosition:		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	YPosition:		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	Height:			.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	IsShrinking:	.byte 0, 0, 0, 0, 0 ,0 ,0 ,0 ,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	IsFreeze:		.byte 0, 0, 0, 0, 0 ,0 ,0 ,0 ,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	IsExtraLife:	.byte 0, 0, 0, 0, 0 ,0 ,0 ,0 ,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	Colour:			.byte 0, 0, 0, 0, 0 ,0 ,0 ,0 ,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


	.label MaxHeight = 20
	.label StartColour = 1
	.label FreezeColour = 3
	.label LifeColour = 14

	.label EndMinX = 6
	.label EndMaxX = 34
	.label EndMinY = 6
	.label EndMaxY = 22

	.label MaxBlocks = 10
	.label NormalSides = 4


	BlocksOnScreen:	.byte 0
	StartShrinkChance:	.byte 9
	NewBlockChance: .byte 251
	FreezeBlockChance:	.byte 20
	ExtraLifeChance:	.byte 240
	GameFrozen: .byte 0
	FramesPerSection: .byte 16
	FreezeTime: .byte 0, 180

	SecondTimer: .byte 50, 50
	LevelTimer: .byte 20, 15

	NewBlockCooldown: .byte 0, 30


	MinX:	.byte 0
	MaxX:	.byte 0
	MinY:	.byte 0
	MaxY:	.byte 0

	CurrentRow:			.byte 0
	CurrentColumn:		.byte 0
	CurrentColour:		.byte 0
	CurrentID:			.byte 0
	CurrentCharID:		.byte 0
	ChangeColour:		.byte 0
	CurrentCharHeight:	.byte 0
	CurrentTopType:		.byte 0
	CurrentHeight:		.byte 0




	Reset: {	




		ldx #0
		lda #0

		sta NewBlockCooldown

		Loop:


			sta XPosition, x
			sta YPosition, x
			sta Height, x
			sta IsShrinking, x
			sta IsFreeze, x
			sta IsExtraLife, x
			sta Colour, x

			inx
			cpx #MaxBlocks
			beq EndLoop
			jmp Loop

		EndLoop:

		lda SecondTimer + 1
		sta SecondTimer

		lda LevelTimer + 1
		sta LevelTimer


		lda #10
		sta MinX

		lda #30
		sta MaxX

		lda #8
		sta MinY

		lda #21
		sta MaxY

		jsr CreateBlock
		jsr CreateBlock
		jsr CreateBlock

		rts


	}


	DeleteBlock: {

		dec BlocksOnScreen
		.label RowsToClear = TEMP12


		lda XPosition, x
		sta CurrentColumn

		lda YPosition, x
		sta CurrentRow

		lda Height, x
		sta CurrentHeight
		tay

		lda CharHeight, y
		sta CurrentCharHeight

		lda #4
		clc
		adc CurrentCharHeight
		sta RowsToClear

		.label LoopCounter = TEMP1

		lda #0
		sta LoopCounter

		Loop: {	

			lda CurrentRow
			sec
			sbc LoopCounter

			ldx CurrentColumn
			tay
			lda #0
			jsr PLOT.PlotCharacter

			ldx CurrentColumn
			inx
			lda CurrentRow
			sec
			sbc LoopCounter
			tay
			lda #0
			jsr PLOT.PlotCharacter

			inc LoopCounter
			lda LoopCounter
			cmp RowsToClear
			beq Finish

			jmp Loop

		}


		Finish:

			lda BlocksOnScreen
			bne NoNewBlock

			jsr CreateBlock


		NoNewBlock:

			rts

	
	}



	DrawUpdate: {


		lda FramesPerSection
		sta IsShrinking, x

		stx CurrentID

		lda Height, x
		sta CurrentHeight
		tay
		lda CharHeight, y
		sta CurrentCharHeight

		lda Colours, y
		sta CurrentColour

		lda XPosition, x
		sta CurrentColumn

		lda YPosition, x
		sta CurrentRow

		lda Height, x
		cmp #MaxHeight
		beq NoDelete

		lda TopType, y
		sta CurrentTopType
		bne NoDelete


		DeleteRowAbove:

			.label ReduceValue = TEMP11

			lda #ZERO
			sta ReduceValue

			lda CurrentHeight
			cmp #05
			bcs NoAdjust

			inc ReduceValue

			NoAdjust:
			
			ldx CurrentColumn
			lda CurrentRow
			sec
			sbc CurrentCharHeight
			sbc #04
			clc
			adc ReduceValue
			tay
			lda #0

			jsr PLOT.PlotCharacter

			ldx CurrentColumn
			inx
			lda CurrentRow
			sec
			sbc CurrentCharHeight
			sbc #04
			clc
			adc ReduceValue
			tay
			lda #0

			jsr PLOT.PlotCharacter

		NoDelete: 


			lda CurrentHeight
			cmp #04
			bcc UseSmall

			lda #BottomLeft
			jmp DrawBottomLeft

			UseSmall:

				tax
				lda BottomLeftSmall, x

			DrawBottomLeft:

				ldx CurrentColumn
				ldy CurrentRow

				
				jsr PLOT.PlotCharacter

				lda CurrentColour
				jsr PLOT.ColorCharacter


			lda CurrentHeight
			cmp #04
			bcc UseSmall2

			lda #BottomRight
			jmp DrawBottomRight

			UseSmall2:

				tax
				lda BottomRightSmall, x

			DrawBottomRight:

				ldx CurrentColumn
				inx
				ldy CurrentRow

				jsr PLOT.PlotCharacter
				lda CurrentColour
				jsr PLOT.ColorCharacter

				lda CurrentCharHeight
				beq FinishSides

				.label LoopCounter = TEMP1

				lda #0
				sta LoopCounter

			Loop:

				ldx CurrentColumn
				dec CurrentRow
				ldy CurrentRow

				lda #LeftBlock
				jsr PLOT.PlotCharacter
				lda CurrentColour
				jsr PLOT.ColorCharacter

				ldx CurrentColumn
				inx
				ldy CurrentRow
				lda #RightBlock

				jsr PLOT.PlotCharacter
				lda CurrentColour
				jsr PLOT.ColorCharacter

				inc LoopCounter
				lda LoopCounter
				cmp CurrentCharHeight
				beq FinishSides

				jmp Loop


		FinishSides:

		.label TopLeftUse = TEMP8

		dec CurrentRow
		ldy CurrentRow

		ldx CurrentTopType
		lda TopLeft, x
		sta TopLeftUse

		lda CurrentHeight
		cmp #5
		bcc Row2

		Row3:

			lda TopLeftUse
			clc
			adc #05

			ldx CurrentColumn
			inx

			jsr PLOT.PlotCharacter
			lda CurrentColour
			jsr PLOT.ColorCharacter

			ldx CurrentColumn
			ldy CurrentRow
			
			lda TopLeftUse
			clc
			adc #04

			jsr PLOT.PlotCharacter
			lda CurrentColour
			jsr PLOT.ColorCharacter

			dec CurrentRow
			ldy CurrentRow

		Row2:

		lda TopLeftUse
		clc
		adc #03

		ldx CurrentColumn
		inx

		jsr PLOT.PlotCharacter
		lda CurrentColour
		jsr PLOT.ColorCharacter

		ldx CurrentColumn
		ldy CurrentRow
		
		lda TopLeftUse
		clc
		adc #02

		jsr PLOT.PlotCharacter
		lda CurrentColour
		jsr PLOT.ColorCharacter

		dec CurrentRow
		ldy CurrentRow

		lda TopLeftUse
		clc
		adc #01

		ldx CurrentColumn
		inx

		jsr PLOT.PlotCharacter
		lda CurrentColour
		jsr PLOT.ColorCharacter

		ldx CurrentColumn
		ldy CurrentRow
		
		lda TopLeftUse

		jsr PLOT.PlotCharacter
		lda CurrentColour
		jsr PLOT.ColorCharacter




		rts
	}


	CheckWhetherClickedOn: {

		.label RowsToCheck = TEMP3

		lda MOUSE.MouseFireX
		beq Finish

		cmp XPosition, x
		beq MatchingColumn

		sec
		sbc #1
		cmp XPosition, x
		beq MatchingColumn

		jmp Finish

		MatchingColumn: 

			lda Height, x
			sta CurrentHeight
			tay
			lda CharHeight, y
			sta CurrentCharHeight

			lda YPosition, x
			sec
			sbc CurrentCharHeight
			sbc #03
			sta RowsToCheck

			lda YPosition, x
			tax

		Loop:

			cpx MOUSE.MouseFireY
			beq MatchingRow

			dex
			cpx RowsToCheck
			beq Finish
			jmp Loop


		MatchingRow:

			ldx CurrentID
			
			jsr DeleteBlock

			ldx CurrentID

			lda IsFreeze, x
			beq NoFreeze

			lda FreezeTime + 1
			sta FreezeTime
			jmp ResetBlock

			NoFreeze:

			lda IsExtraLife, x
			beq NoExtraLife

			jsr LIVES.AddLife
			jmp ResetBlock

			NoExtraLife:

				lda Height, x
				jsr SCORE.ScorePoints
				jsr SOUND.SniffSound

			ResetBlock:

			lda #ZERO
			sta Height, x
			sta YPosition, x
			sta IsShrinking, x
			sta IsFreeze, x
			sta IsExtraLife, x



		

		Finish:

		ldx CurrentID

		rts
		
	}

	CheckBlock: {

		stx CurrentID

		lda IsShrinking, x
		beq CheckStartShrink

		jsr CheckWhetherClickedOn

		lda FreezeTime
		bne Finish

		lda YPosition, x
		beq Finish
	
		CheckShrink:

			dec IsShrinking, x
			lda IsShrinking, x
			bne Finish

		Shrink:

			dec Height, x
			lda Height, x

			beq BlockDone


		StillShrinking:

			tay
			lda Colours, y
			sta CurrentColour
		
			jsr DrawUpdate

			jmp Finish


		BlockDone:

			jsr DeleteBlock

			jsr LIVES.LoseLife

			ldx CurrentID
			lda #ZERO
			sta YPosition, x

			jmp Finish

		CheckStartShrink:

			jsr RANDOM.Get

			cmp StartShrinkChance
			bcs Finish

			lda FramesPerSection
			sta IsShrinking, x

			//jsr DrawUpdate

			jmp Finish

		Finish:


		rts
	}


	UpdateTimer: {

		dec SecondTimer
		bne Finish

		lda SecondTimer + 1
		sta SecondTimer

		dec LevelTimer
		bne Finish

		lda LevelTimer + 1
		sta LevelTimer

		lda FramesPerSection
		cmp #8
		bcc Finish

		dec NewBlockChance
		dec FreezeBlockChance
		inc ExtraLifeChance
		dec FramesPerSection

		Finish:


		rts
	}

	Update: {	

		jsr UpdateTimer

		lda FreezeTime
		beq NoFreeze

		dec FreezeTime

		NoFreeze:
		
		ldx #0

		Loop:

			stx CurrentID

			lda YPosition, x
			beq EndLoop

			lda IsFreeze, x
			clc
			adc IsExtraLife, x
			beq NormalBlock

			SpecialBlock:

				jsr CheckWhetherClickedOn
				jmp KeepGoing

			NormalBlock:

				
				jsr CheckBlock

			KeepGoing:

			ldx CurrentID

			EndLoop:

				inx
				cpx #MaxBlocks
				beq Finish

				jmp Loop


		Finish:

		lda FreezeTime
		bne NoNewBlock

		lda NewBlockCooldown
		beq NewBlockOk

		dec NewBlockCooldown
		jmp NoNewBlock


		NewBlockOk:

		jsr RANDOM.Get

		cmp NewBlockChance
		bcc NoNewBlock

		jsr CreateBlock

		NoNewBlock:


		rts
	}


	DrawFullBlock: {

		inc BlocksOnScreen

		lda #StartColour
		sta CurrentColour

		lda IsFreeze, x
		beq NoFreeze

		lda #FreezeColour
		sta CurrentColour

		NoFreeze:

			lda IsExtraLife, x
			beq NoExtraLife

			lda #LifeColour
			sta CurrentColour

		NoExtraLife:

			ldx CurrentColumn
			ldy CurrentRow

			lda #BottomLeft
			jsr PLOT.PlotCharacter
			lda CurrentColour
			jsr PLOT.ColorCharacter

			ldx CurrentColumn
			inx
			ldy CurrentRow
			lda #BottomRight

			jsr PLOT.PlotCharacter
			lda CurrentColour
			jsr PLOT.ColorCharacter


			.label LoopCounter = TEMP1

			lda #0
			sta LoopCounter

		Loop:

			ldx CurrentColumn
			dec CurrentRow
			ldy CurrentRow

			lda #LeftBlock
			jsr PLOT.PlotCharacter
			lda CurrentColour
			jsr PLOT.ColorCharacter

			ldx CurrentColumn
			inx
			ldy CurrentRow
			lda #RightBlock

			jsr PLOT.PlotCharacter
			lda CurrentColour
			jsr PLOT.ColorCharacter

			inc LoopCounter
			lda LoopCounter
			cmp #NormalSides
			beq FinishSides

			jmp Loop


		FinishSides:

		dec CurrentRow
		ldy CurrentRow

		lda TopLeft
		clc
		adc #03

		ldx CurrentColumn
		inx

		jsr PLOT.PlotCharacter
		lda CurrentColour
		jsr PLOT.ColorCharacter

		ldx CurrentColumn
		ldy CurrentRow
		
		lda TopLeft
		clc
		adc #02

		jsr PLOT.PlotCharacter
		lda CurrentColour
		jsr PLOT.ColorCharacter

		dec CurrentRow
		ldy CurrentRow

		lda TopLeft
		clc
		adc #01

		ldx CurrentColumn
		inx

		jsr PLOT.PlotCharacter
		lda CurrentColour
		jsr PLOT.ColorCharacter

		ldx CurrentColumn
		ldy CurrentRow
		
		lda TopLeft

		jsr PLOT.PlotCharacter
		lda CurrentColour
		jsr PLOT.ColorCharacter


		rts
	}

	CreateBlock: {	

		ldx #0

		Loop:

		cpx #50
		beq Finish

		jsr GetFreePosition


		// if row = 0 then cancel, invalid position
		lda CurrentRow
		beq Loop

		tay
		ldx CurrentColumn
		jsr PLOT.GetCharacter

		bne HitMatch

		// check this char is blank
		lda CurrentRow
		sec
		sbc #6
		tay
		ldx CurrentColumn
		jsr PLOT.GetCharacter

		bne HitMatch

		jsr GetNextAvailableID

		cpx #MaxBlocks
		beq Finish

		stx CurrentID

		lda #MaxHeight
		sta Height, x

		lda CurrentColumn
		sta XPosition, x

		lda CurrentRow
		sta YPosition, x

		jsr ChooseBlockType

		ldx CurrentID



		jsr DrawFullBlock

		lda NewBlockCooldown + 1
		sta NewBlockCooldown



		Finish:

			rts


		HitMatch: 
			rts

	}



	ChooseBlockType: {

		lda #ZERO
		sta IsShrinking, x
		sta IsFreeze, x
		sta IsExtraLife, x

		lda BlocksOnScreen
		cmp #3
		bcc Finish

		jsr RANDOM.Get
		cmp FreezeBlockChance
		bcc FreezeBlock

		cmp ExtraLifeChance
		bcs ExtraLife

		jmp Finish

		ExtraLife:

			lda #ONE
			sta IsExtraLife, x
			jmp Finish
		
		FreezeBlock:

			lda #ONE
			sta IsFreeze, x
			jmp Finish


		Finish:

		rts


	}


	GetFreePosition: {

		lda #0
		sta CurrentRow
		sta CurrentColumn

		jsr RANDOM.Get
		and #%00001111
		asl

		cmp MinX
		bcc Finish

		cmp MaxX
		bcs Finish

		sta CurrentColumn

		jsr RANDOM.Get
		and #%00011111



		cmp MinY
		bcc Finish

		cmp MaxY
		bcs Finish



		sta CurrentRow

		Finish:	
			rts

	}

	GetNextAvailableID: {

		ldx #0

		Loop:

			lda Height, x
			beq Found
			inx
			cpx #MaxBlocks
			beq Found
			jmp Loop

		Found:

			rts

	}

}