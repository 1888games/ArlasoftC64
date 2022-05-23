BLOCKS: {


	* = * "Blocks"

	BaseX:	.byte 02, 03, 04, 05, 12, 13, 14, 15, 22, 23, 24, 25
			.byte 02, 03, 04, 05, 12, 13, 14, 15, 22, 23, 24, 25
			

	BaseY:	.byte 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20
			.byte 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21


	Blocks:		.fill 24, BothBlocks
	EnemyID:	.fill 24, 99	

	.label BothBlocks = 3
	.label TopBlock = 2
	.label BottomBlock = 1
	.label NoBlock = 0
	.label ScrollChar = 26
	.label TotalBaseBlocks = 24



	TargetX:	.byte 02, 03, 04, 05, 06, 07, 08, 10, 11, 19, 20, 23, 24 // 13
				.byte 01, 02, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20, 21, 22, 23, 24, 25, 26 // 31
				.byte 02, 03, 04, 05, 06, 07, 08, 10, 11, 12, 13, 14, 15, 16, 17, 23, 24 // 48


	TargetY:	.byte 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03
				.byte 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04
				.byte 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05, 05


	Type:		.byte 03, 03, 03, 03, 03, 03, 02, 03, 03, 03, 03, 03, 03
				.byte 03, 03, 03, 03, 03, 02, 02, 03, 03, 01, 03, 03, 01, 01, 03, 03, 01, 01
				.byte 03, 03, 03, 03, 03, 03, 01, 02, 03, 03, 01, 01, 03, 03, 03, 03, 03


	Current:	.fill 48, 0




	ScrollStatus:	.byte ScrollChar

	BlocksLeft:		.byte 24
	BlocksBuilt:	.byte 0






	ResetBase: {

		lda #ScrollChar
		sta ScrollStatus

		lda #TotalBaseBlocks
		sta BlocksLeft

		rts


	}




	HandleScroll: {





	}



	GetAvailableBlock: {

		ldy #99

		CheckIfBlocksLeft:

			lda BlocksLeft
			beq Finish

		GetRandomBlock:

			jsr RANDOM.Get
			and #%00001111
			cmp #12
			bcs GetRandomBlock
		
		CheckWhichRow:

			ldy BlocksLeft
			cpy #12
			bcs CheckBlockStatus

			clc
			adc #12

		CheckBlockStatus:

			tay
			sta Amount

			Loop:

				lda EnemyID, y
				cmp #99
				bne EndLoop

				SendValueBack:

					txa
					sta EnemyID, y

					rts

				EndLoop:

					iny
					cpy Amount
					bne NotStuck

					ReturnError:

						ldy #99
						rts

					NotStuck:
						cpy #12
						bne NoWrap

						ldy #0
						cpy Amount
						bne Loop

						ldy #99
						rts

					NoWrap:

						cpy #24
						bcc Loop

						ldy #12
						cpy Amount
						bne Loop

						ldy #99
						rts

						
					NoWrap2:	

						jmp Loop


		Finish:

			rts



		
	}





	FrameUpdate: {

		lda ScrollStatus
		beq DoneScrolling




		DoneScrolling:





	}










}