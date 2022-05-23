BLOCK: {


	.label StartSpritePointer = 15
	.label CentralIndex = 16
	.label StartPlayerX = 43
	.label StartBlankX = 227
	.label MaxX = 232
	.label BlankBlockID = 13
	.label MinBlockX = 67
	.label FireBlockPixelsPerFrame = 8
	.label PixelsPerKnockBack = 4
	.label GameOverPosition = 67
	.label StartComboFrame = 31
	.label MaxSpeed = 10
	.label StartSpeed = 20

	PosX_LSB:	.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0

	ObjectIDs:	.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0

	NextObjectID:	.byte 1
	// 			//.byte 43, 67, 91, 115, 139, 163, 187, 211
	// 			//.byte 43, 67, 91, 115, 139, 163, 187, 211


	// PosX_LSB:	.byte 0, 0, 0, 0, 155, 179, 203, 227
	// 			.byte 0, 0, 0, 0, 155, 179, 203, 227
	// 			.byte 0, 0, 0, 0, 155, 179, 203, 227
	// 			.byte 0, 0, 0, 0, 155, 179, 203, 227
	// 			.byte 0, 0, 0, 0, 155, 179, 203, 227
	// 			//.byte 43, 67, 91, 115, 139, 163, 187, 211
				//.byte 43, 67, 91, 115, 139, 163, 187, 211


	Values:		.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 0 // for when bottom right is merged and need to check right

	// Values:		.byte 0, 0, 0, 0, 4, 11, 13, 13
	// 			.byte 0, 0, 0, 0, 8, 9, 13, 13
	// 			.byte 0, 0, 0, 0, 9, 6, 13, 13
	// 		//	.byte 1, 2, 3, 4, 5, 6, 7, 13
	// 			.byte 0, 0, 0, 0,  10, 11, 13, 13
	// 			//.byte 4, 1, 2, 6, 5, 3, 7, 9
	// 			.byte 0, 0, 0, 0, 8, 10, 13, 13
	// 			.byte 0 // for when bottom right is merged and need to check right


	Row_Y:		.byte 59, 99, 139, 179, 219


	MoveInto:	.byte 0, 0, 1, 1, 1, 1, 1, 1
				.byte 0, 0, 1, 1, 1, 1, 1, 1
				.byte 0, 0, 1, 1, 1, 1, 1, 1
				.byte 0, 0, 1, 1, 1, 1, 1, 1
				.byte 0, 0, 1, 1, 1, 1, 1, 1
				.byte 0

	MoveIntoLeft:	.byte 0, 1, 1, 1, 1, 1, 1, 0
					.byte 0, 1, 1, 1, 1, 1, 1, 0
					.byte 0, 1, 1, 1, 1, 1, 1, 0
					.byte 0, 1, 1, 1, 1, 1, 1, 0
					.byte 0, 1, 1, 1, 1, 1, 1, 0


	Rows:		.byte 0, 0, 0, 0, 0, 0, 0, 0
				.byte 1, 1, 1, 1, 1, 1, 1, 1
				.byte 2, 2, 2, 2, 2, 2, 2, 2
				.byte 3, 3, 3, 3, 3, 3, 3, 3
				.byte 4, 4, 4, 4, 4, 4, 4, 4
				.byte 5

	Columns:	.byte 0, 1, 2, 3, 4, 5, 6, 7
				.byte 0, 1, 2, 3, 4, 5, 6, 7
				.byte 0, 1, 2, 3, 4, 5, 6, 7
				.byte 0, 1, 2, 3, 4, 5, 6, 7
				.byte 0, 1, 2, 3, 4, 5, 6, 7




	//1		2		3		4		5		6		7		8		9		10		11		12 		13	
	//2		4		8		16		32		64		128		256		512		1024	2048	4096	Blank
	//0		2		4		8		14		22		32		44		58		74		92		112				

	Scoring:		.byte 0, 0, 2, 4, 8, 16, 32, 64, 96, 128, 160, 192, 255


	Colours:		//.byte 0, 13, 5, 3, 6, 14, 4, 2, 10, 8, 9, 15, 1, 12

					.byte 0, 6, 13, 5, 3, 7, 14, 4, 2, 10, 8, 9, 15, 12, 1
	StartBlocks:	.byte 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3
					.byte 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 1, 2

	RowStart:		.byte 0, 8, 16, 24, 32
	Times2:			.byte 0, 2, 4, 6, 8, 10, 12, 14

	FramesPerPixel:	.byte 24
	MoveTimer:		.byte 0

	SecondTimer:	.byte 0, 50
	IncreaseTimer:	.byte 0, 15

	IsBlockBeingFired:	.byte 0
    FireBlockValue:		.byte 0
    FireBlockPosX:		.byte 0
    FireBlockRow:		.byte 0
    FireBlockCanMove:	.byte 0

  	MergeCheckQueue:		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    MergeCheckProgress: 	.byte 0
    MergeCheckQueueSize:	.byte 255


    MergeTimer:		.byte 0, 13
    IsMerging:		.byte 0

    CheckMergeChain:		.byte 0

    BlocksToMerge:		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    NumBlocksToMerge:	.byte 0

    MergeBlocks:	.byte 0

    BlocksOffset:	.byte 0
    NewColumnRequired: .byte 0

    DisplayComboSprite: .byte 0
    ComboTimer: .byte 0, 9

    Combos:	.byte 0


	NewGame: {


		ldx #0
		stx CheckMergeChain
		stx NumBlocksToMerge
		stx NewColumnRequired
		stx Combos
		stx MergeBlocks
		stx IsMerging
		stx IsBlockBeingFired
		stx MergeCheckQueueSize
		stx BlocksOffset
		stx DisplayComboSprite

		Loop:

			lda #0
			sta Values, x
			sta PosX_LSB, x

			inx
			cpx #40
			beq EndLoop

			jmp Loop


		EndLoop:


		lda #StartPlayerX

		sta PosX_LSB
		sta PosX_LSB + 8
		sta PosX_LSB + 16
		sta PosX_LSB + 24
		sta PosX_LSB + 32

		lda SecondTimer + 1
		sta SecondTimer

		lda #StartSpeed
		sta FramesPerPixel
		sta MoveTimer

		lda IncreaseTimer + 1
		sta IncreaseTimer

		jsr GetNewPlayerBlock
		jsr GetNewBlankColumn





		rts
	}



	GetNewPlayerBlock: {


		lda #0
		sta DisplayComboSprite

		jsr RANDOM.Get
		and #%00011111

		tax
		lda StartBlocks, x


		ldx #CentralIndex

		sta Values, x

		lda #StartPlayerX
		sta PosX_LSB, x

		lda NextObjectID
		sta ObjectIDs, x

		inc NextObjectID

		rts


	}


	GetNewBlankColumn: {

		ldx #7

		Loop:

			lda #BlankBlockID
			sta Values, x

			lda NextObjectID
			sta ObjectIDs, x
			inc NextObjectID

			lda #StartBlankX
			sta PosX_LSB, x

			txa
			clc
			adc #8
			tax

			cpx #47
			beq Finish
			jmp Loop


		Finish:


			rts

	}



	SetComboSprite: {

		pha

		tax
		lda Colours, x

		sta VIC.SPRITE_COLOR_0

		pla

		clc
		adc #StartComboFrame

		sta SPRITE_POINTERS

		lda #12
		sta VIC.SPRITE_0_X

		lda #%00000001
		sta VIC.SPRITE_MSB
		sta $d01d
		sta $d017


		lda #200
		sta VIC.SPRITE_0_Y

		lda #1
		sta DisplayComboSprite

		lda ComboTimer + 1
		sta ComboTimer
		

		rts

	}


	UsualY: .byte 139

	DrawRow: {

		ldx #0

		lda DisplayComboSprite
		bne DontMoveSprite0

		stx VIC.SPRITE_0_X + 0

		lda Row_Y, y
		sta VIC.SPRITE_0_Y

		// cpy #2
		// bne SkipCheck

		// cmp UsualY
		// beq SetUsual

		// .break
		// nop

		// SetUsual:

		// 	sta UsualY

		SkipCheck:

		lda #0
		sta VIC.SPRITE_MSB
		sta $d01d
		sta $d017

		jmp ClearSprites

		DontMoveSprite0:

		lda ComboTimer
		beq MoveCombo

		dec ComboTimer
		jmp ClearSprites

		MoveCombo:

		lda ComboTimer + 1
		sta ComboTimer

		dec VIC.SPRITE_0_Y
		inc VIC.SPRITE_COLOR_0
		lda VIC.SPRITE_COLOR_0
		bne ClearSprites

		lda #1
		sta VIC.SPRITE_COLOR_0

		ClearSprites:

		ldx #0	// reset sprite positions so that unused sprites won't be seen

		stx VIC.SPRITE_0_X + 2
		stx VIC.SPRITE_0_X + 4			
		stx VIC.SPRITE_0_X + 6
		stx VIC.SPRITE_0_X + 8
		stx VIC.SPRITE_0_X + 10
		stx VIC.SPRITE_0_X + 12
		stx VIC.SPRITE_0_X + 14

		lda Row_Y, y
		sta VIC.SPRITE_0_Y + 2
		sta VIC.SPRITE_0_Y+  4
		sta VIC.SPRITE_0_Y + 6
		sta VIC.SPRITE_0_Y + 8
		sta VIC.SPRITE_0_Y + 10
		sta VIC.SPRITE_0_Y + 12
		sta VIC.SPRITE_0_Y + 14

		// y = row

		lda RowStart, y
		tay

		ldx #0

		Loop:

			stx Column 

			lda Values, y
			beq EndLoop

			// Get Colour
			tax
			lda Colours, x

			ldx Column
			sta VIC.SPRITE_COLOR_0, x

			lda Values, y
			clc
			adc #StartSpritePointer
			sta SPRITE_POINTERS, x

	 		XPosition:

	 			// load X position and store in correct sprite register
	 			lda Times2, x
	 			tax
	 			
				lda PosX_LSB, y
				cmp #MaxX
				bcs EndLoop

				sta VIC.SPRITE_0_X, x

			EndLoop:

			ldx Column

			inx
			iny
			cpx #8
			beq Finish
			jmp Loop


		Finish:


		rts


	}







	MoveFireBlock: {

	
		lda IsBlockBeingFired
		bne Okay

		jmp Exit


		Okay:

		lda #0
		sta FireBlockStoppedAt


		ldx FireBlockRow

		lda RowStart, x
		tax
		stx FireBlockIndex

		lda Values, x
		sta FireBlockValue

		lda PosX_LSB, x
		clc
		adc #FireBlockPixelsPerFrame
		sta NewFireBlockPosition


		CheckCollision:

		inx
		ldy #1

		Loop:


			lda Values, x
			beq EndLoop

			lda PosX_LSB, x
			sec 
			sbc NewFireBlockPosition

			cmp #27
			bcs EndLoop




			 HitDifferentBlock:

			 stx FireBlockStoppedAt
			 sty FireBlockStopColumn
			 jmp Finish

			// pla

			EndLoop:

				iny
				inx
				cpy #8
				beq Finish
				jmp Loop

		Finish:

			ldx FireBlockStoppedAt
			beq CanMove

			ldy FireBlockStopColumn
			
			cpy #1
			bne NoSpaceCheck

		 	lda Values, x
		 	cmp FireBlockValue
		 	bne NoSpace

			NoSpaceCheck:

			 	dex
				stx FireBlockStoppedAt
				dec FireBlockStopColumn

			    ldy FireBlockIndex

			    cpx #40
			    bcc Okay2

			    .break
			    nop


			    Okay2:

				lda Values, y
				sta Values, x

			

				lda FireBlockStopColumn
				beq DontSetZero

				lda ObjectIDs, y
				sta ObjectIDs, x

				lda #0
				sta Values, y
				sta ObjectIDs, y

				lda #StartPlayerX
				sta PosX_LSB, y

				inx
				lda PosX_LSB, x
				sec
				sbc #24
				dex
				sta PosX_LSB, x

			DontSetZero:

			jmp FinishBlockStop

		NoSpace:

			jsr MAIN.GameOver
			jmp Exit

		FinishBlockStop:

			lda #0
			sta IsBlockBeingFired

			lda #2
			sta CONTROL.CurrentBlockPosition

			///ldx FireBlockStoppedAt
			//lda MoveIntoLeft, x
			//beq NoMerge

			lda #1
			sta CheckMergeChain

			NoMerge:

			sfx(0)

			//jsr GetNewPlayerBlock

			jsr KnockBack
			jmp Exit


		CanMove:

			lda NewFireBlockPosition
			ldx FireBlockIndex
			sta PosX_LSB, x

			lda #0
			sta Combos



		Exit:

		rts



	}



	ResetAfterMerge: {

		lda #0
		sta IsBlockBeingFired

		lda #2
		sta CONTROL.CurrentBlockPosition


		jsr GetNewPlayerBlock
		
		rts


	}





	KnockBack: {


		lda #PixelsPerKnockBack
		sta PixelsToKnockBackNow

		lda Values +6
		cmp #BlankBlockID
		beq NoClamp

		lda #StartBlankX
		sec
		sbc PosX_LSB + 7
		jmp Check

		ClampLoop:

		dec PixelsToKnockBackNow

		Check:

		cmp PixelsToKnockBackNow
		bcc ClampLoop

		NoClamp:

		ldx #0

		lda BlocksOffset
		sec
		sbc PixelsToKnockBackNow
		sta BlocksOffset

		Loop: 

			//lda Values, x
			//beq EndLoop

			lda Columns, x
			beq EndLoop

			lda PosX_LSB, x
			clc
			adc PixelsToKnockBackNow
			sta PosX_LSB, x

			EndLoop:

				inx
				cpx #40
				beq Finish
				jmp Loop

		Finish:

			rts


		



	}

	



	CheckingUp: {

		ldx FireBlockStoppedAt
		stx CheckChainCurrentBlock

		Loop:

			ldx CheckChainCurrentBlock

			cpx #8
			bcc Finish

			txa
			sec
			sbc #8
			sta CheckChainCurrentBlock

			tax

			lda Values, x
			ldy FireBlockValue

			cmp FireBlockValue
			bne Finish

			// found match

			txa
			ldy NumBlocksToMerge
			sta BlocksToMerge, y

			inc NumBlocksToMerge

			jmp Loop


		Finish:

		rts

	}

	CheckingDown: {

		ldx FireBlockStoppedAt
		stx CheckChainCurrentBlock

		Loop:

			ldx CheckChainCurrentBlock

			cpx #32
			bcs Finish

			txa
			clc
			adc #8
			sta CheckChainCurrentBlock

			tax

			lda Values, x
			ldy FireBlockValue

			cmp FireBlockValue
			bne Finish

			// found match

			txa
			ldy NumBlocksToMerge
			sta BlocksToMerge, y

			inc NumBlocksToMerge

			jmp Loop


		Finish:

		rts


	}

	CheckingLeft: {

		ldx FireBlockStoppedAt
		stx CheckChainCurrentBlock

		ldy FireBlockStopColumn
		sty CheckChainColumn

		Loop:

			dec CheckChainCurrentBlock
			dec CheckChainColumn

			ldy CheckChainColumn
			beq Finish

			ldx CheckChainCurrentBlock

			lda Values, x
			ldy FireBlockValue

			cmp FireBlockValue
			bne Finish

			// found match

			txa
			ldy NumBlocksToMerge
			sta BlocksToMerge, y

			inc NumBlocksToMerge

			jmp Loop


		Finish:

		rts

	}


	CheckingRight: {

		ldx FireBlockStoppedAt
		stx CheckChainCurrentBlock

		ldy FireBlockStopColumn
		sty CheckChainColumn

		Loop:

			inc CheckChainCurrentBlock
			inc CheckChainColumn

			ldy CheckChainColumn
			cpy #8
			bcs Finish

			ldx CheckChainCurrentBlock


			lda Values, x
			ldy FireBlockValue

			cmp FireBlockValue
			bne Finish

			// found match

			txa
			ldy NumBlocksToMerge
			sta BlocksToMerge, y

	
			sta IndexOfMergedBlock
			inc ColumnOfMergedBlock
			

			inc NumBlocksToMerge

			jmp Loop


		Finish:

		rts
	}

	CheckChain: {

		// FireBlockStoppedAt = index
		// FireBlockStoppedColumn = how far along
		// FireBlockValue

		lda #0
		sta NumBlocksToMerge

		lda FireBlockStoppedAt
		sta IndexOfMergedBlock

		lda FireBlockStopColumn
		sta ColumnOfMergedBlock


		jsr CheckingUp
		jsr CheckingDown
		jsr CheckingLeft
		jsr CheckingRight

		lda NumBlocksToMerge

	
		beq NoMerges

		Merge:

			lda #0
			sta CheckMergeChain
	
			lda #1
			sta MergeBlocks

			lda MergeTimer + 1
			sta MergeTimer

			jmp Finish

		NoMerges:



			lda #0
			sta CheckMergeChain

			lda Combos
			bne NoSound



		//	sfx(0)
	

			NoSound:

			jsr CloseGaps

			lda CheckMergeChain
			bne Finish
			
			jsr GetNewPlayerBlock


		Finish:


		rts



	}



	CloseGaps: {

		ldx #1
		ldy #2
		
		Loop:

			lda MoveInto, y
			beq EndLoop

			lda Values, x
			beq EndLoop

			lda Values, y
			bne EndLoop

			lda Values, x
			sta FireBlockValue
			sta Values, y

			lda ObjectIDs, x
			sta ObjectIDs, y
			

			lda #0
			sta Values, x
			sta ObjectIDs, x

			sty FireBlockStoppedAt

			lda Columns, y
			sta FireBlockStopColumn

			lda #1
			sta CheckMergeChain

			jmp Finish

			EndLoop:

				inx
				iny
				cpx #40
				beq Finish
				jmp Loop


		Finish:

			rts





	}

	MergeNextBlock: {	

		

		dec NumBlocksToMerge

		ldx NumBlocksToMerge
		cpx #16
		bcs AllBlocksMerged

		lda BlocksToMerge, x
		tay

		ldx IndexOfMergedBlock
		txa
		cmp BlocksToMerge, x
		beq AllBlocksMerged 

		lda ObjectIDs, x
		cmp ObjectIDs, y
		bne NotTheSame

		
		//jmp Finish

		NotTheSame:


			    cpx #40
			    bcc Okay2

			    .break
			    nop


			    Okay2:


		inc Values, x

		lda Values, x
		cmp #13
		bcc Okay

		lda #12
		sta Values, x

		Okay:

		jsr SetComboSprite

		cpy IndexOfMergedBlock
		beq DontDeleteMergeTarget

		lda #0
		sta Values, y
		jmp NextBlock

		DontDeleteMergeTarget:

		lda #0
		ldy FireBlockStoppedAt


			    // cpy #40
			    // bcc Okay3

			    // .break
			    // nop


			    // Okay3:


		sta Values, y

		NextBlock:

			jsr KnockBack

			lda MergeTimer + 1
			sta MergeTimer

			jmp Finish

		AllBlocksMerged:

			lda IndexOfMergedBlock
			sta FireBlockStoppedAt

			lda ColumnOfMergedBlock
			sta FireBlockStopColumn

			ldx IndexOfMergedBlock
			lda Values, x
			sta FireBlockValue

			tax
			lda Scoring, x

			jsr SCORE.ScorePoints

			inc Combos


			ldx Combos
			cpx #9
			bcc SfxOk

			ldx #1
			stx Combos

			SfxOk:

			sfxFromX()

			jsr CloseGaps

			lda #1
			sta CheckMergeChain

			lda #0
			sta MergeBlocks
			sta NumBlocksToMerge
		

		Finish:



		rts

	}


	MoveBlocksRight: {

		//inc $d020

		ldx #39
		ldy #38


		Loop:

			lda MoveInto, x
			beq EndLoop
			
			lda Values, y
			sta Values, x

			lda #0
			sta Values, y

			lda PosX_LSB, y
			sta PosX_LSB, x

			lda ObjectIDs, y
			sta ObjectIDs, x


			EndLoop:

				dex
				dey
				cpx #1
				beq Finish
				jmp Loop


		Finish:


			rts




	}



	MoveBlocksLeft: {

	//	inc $d020

		ldx #2
		ldy #1


		Loop:

			lda MoveIntoLeft, y
			beq EndLoop
			
			lda Values, x
			sta Values, y

			lda PosX_LSB, x
			sta PosX_LSB, y

			lda ObjectIDs, x
			sta ObjectIDs, y


			EndLoop:

				inx
				iny
				cpx #40
				beq Finish
				jmp Loop


		Finish:

			jsr GetNewBlankColumn

			rts



	}



	CheckBlocksOffset: {

		lda BlocksOffset
		cmp #26
		bcc Finish

		cmp #54
		bcc MoveAllBlocksLeft

		NoveAllBlockSRight:

			jsr MoveBlocksRight


			Okay:


			lda BlocksOffset
			clc
			adc #25
			sta BlocksOffset
			jmp Finish

		MoveAllBlocksLeft:


	
			jsr MoveBlocksLeft

			lda BlocksOffset
			sec
			sbc #25
			sta BlocksOffset



		Finish:

			rts


	}



	CheckGameOver: {

		ldx #1

		Loop:

			lda Values, x
			beq EndLoop

			lda PosX_LSB, x
			cmp #GameOverPosition
			bcs EndLoop

			jsr MAIN.GameOver
			jmp Finish

		EndLoop: 

			txa
			clc
			adc #8
			tax

			cpx #41
			beq Finish
			jmp Loop

		Finish:

			rts



	}


	CheckTimer: {

		lda SecondTimer
		beq SecondUp


		dec SecondTimer
		jmp Finish

		SecondUp:

			lda SecondTimer + 1
			sta SecondTimer

			lda IncreaseTimer
			beq IncreaseSpeed

			dec IncreaseTimer
			jmp Finish



		IncreaseSpeed:

		//	inc $d020

			lda IncreaseTimer + 1
			sta IncreaseTimer

			dec FramesPerPixel
			lda FramesPerPixel
			cmp #MaxSpeed
			bcs Finish

			lda #MaxSpeed
			sta FramesPerPixel


		Finish:

			rts

	}

	MoveBlocks: {

		jsr CheckTimer

		jsr CheckGameOver

		lda MAIN.GameIsOver
		bne Exit

		lda CheckMergeChain
		beq NoMergeChain

		jsr CheckChain
		jmp Exit

		NoMergeChain:

			lda MergeTimer
			beq NotPaused

			dec MergeTimer
			jmp Exit

		NotPaused:

			lda MergeBlocks
			beq NotMergingNow

			jsr MergeNextBlock
			jmp Exit

			NotMergingNow:
	
			lda MoveTimer
			beq Okay

			dec MoveTimer
			bne Finish

			jsr CatchAll
			jmp Finish


		Okay:

		

		lda FramesPerPixel
		sta MoveTimer

	

		inc BlocksOffset
		jsr CheckBlocksOffset

	//	lda BlocksOffset
	//	jsr SCORE.SetScore

		//inc $d020

		ldx #0

		Loop:


			lda Values, x
			beq EndLoop

			lda PosX_LSB, x
			cmp #MinBlockX
			bcs MoveIt

			BlockReachedPlayer:

			jmp EndLoop

			MoveIt: 

			dec PosX_LSB, x
		

			EndLoop:

				inx 
				cpx #40
				beq Finish
				jmp Loop



		Finish:

		
		jsr MoveFireBlock

		Exit:

		ldx #0
		lda Values, x
		sta SCREEN_RAM + 84

		inx
		lda Values, x
		sta SCREEN_RAM + 87

		inx
		lda Values, x
		sta SCREEN_RAM + 90

		inx
		lda Values, x
		sta SCREEN_RAM + 93

		inx
		lda Values, x
		sta SCREEN_RAM + 96

		inx
		lda Values, x
		sta SCREEN_RAM + 99

		inx
		lda Values, x
		sta SCREEN_RAM + 102

		inx
		lda Values, x
		sta SCREEN_RAM + 105
		
		inx
		lda Values, x
		sta SCREEN_RAM + 284

		inx
		lda Values, x
		sta SCREEN_RAM + 287

		inx
		lda Values, x
		sta SCREEN_RAM + 290

		inx
		lda Values, x
		sta SCREEN_RAM + 293

		inx
		lda Values, x
		sta SCREEN_RAM + 296

		inx
		lda Values, x
		sta SCREEN_RAM + 299

		inx
		lda Values, x
		sta SCREEN_RAM + 302

		inx
		lda Values, x
		sta SCREEN_RAM + 305

		inx
		lda Values, x
		sta SCREEN_RAM + 484

		inx
		lda Values, x
		sta SCREEN_RAM + 487

		inx
		lda Values, x
		sta SCREEN_RAM + 490

		inx
		lda Values, x
		sta SCREEN_RAM + 493

		inx
		lda Values, x
		sta SCREEN_RAM + 496

		inx
		lda Values, x
		sta SCREEN_RAM + 499

		inx
		lda Values, x
		sta SCREEN_RAM + 502

		inx
		lda Values, x
		sta SCREEN_RAM + 505

			inx
		lda Values, x
		sta SCREEN_RAM + 684

		inx
		lda Values, x
		sta SCREEN_RAM + 687

		inx
		lda Values, x
		sta SCREEN_RAM + 690

		inx
		lda Values, x
		sta SCREEN_RAM + 693

		inx
		lda Values, x
		sta SCREEN_RAM + 696

		inx
		lda Values, x
		sta SCREEN_RAM + 699

		inx
		lda Values, x
		sta SCREEN_RAM + 702

		inx
		lda Values, x
		sta SCREEN_RAM + 705

	inx
		lda Values, x
		sta SCREEN_RAM + 884

		inx
		lda Values, x
		sta SCREEN_RAM + 887

		inx
		lda Values, x
		sta SCREEN_RAM + 890

		inx
		lda Values, x
		sta SCREEN_RAM + 893

		inx
		lda Values, x
		sta SCREEN_RAM + 896

		inx
		lda Values, x
		sta SCREEN_RAM + 899

		inx
		lda Values, x
		sta SCREEN_RAM + 902

		inx
		lda Values, x
		sta SCREEN_RAM + 905




		

		rts
	}


	CatchAll: {

		ldx #1
		ldy #2

		Loop:

			sty Column

			lda MoveIntoLeft, x
			beq EndLoop

			lda Values, x
			beq EndLoop

			cmp #13
			beq EndLoop

			cmp Values, y
			beq StoreY

			cpx #31
			bcs EndLoop

			txa
			clc
			adc #8


			tay

			lda Values, x
			cmp Values, y
			beq StoreY

			jmp EndLoop


			StoreY:	

				//.break

				//.break

				sta FireBlockValue
				sty FireBlockStoppedAt

				iny
				lda Values, y

				iny
				lda Values, y



				lda Columns, y
				sta FireBlockStopColumn

				lda #1
				sta CheckMergeChain
				jmp Finish


			EndLoop:

				ldy Column

				inx
				iny
				cpx #38
				beq Finish
				jmp Loop



		Finish:	

			


			rts


	}

}