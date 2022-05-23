TITLE: {

	TextRows:		.byte 4, 7, 10, 11, 14, 17, 19
					.byte 4, 7, 10, 14, 17, 19
	TextColumns:	.byte 9, 7, 6, 6,8, 6, 4
					.byte 12, 7, 11, 8, 6, 4
	TextColours:	.byte RED, CYAN, GREEN, GREEN, YELLOW, PURPLE, LIGHT_RED
					.byte RED, CYAN, GREEN, YELLOW, PURPLE, LIGHT_RED


	TextIDs:		.byte 0, 1, 2, 3, 4, 5, 6
					.byte 10, 11, 12, 4, 5, 6

	Section: 		.byte 0
	SectionTimer:	.byte 0
	Mode:			.byte 0
	LastID:			.byte 7, 13
	PlayerText:		.byte 11, 14


	.label PlayerSection  = 8
	.label SectionTime = 40
	

	Reset: {

		lda #SectionTime
		lsr
		sta SectionTimer

		lda #0
		sta Section

		lda #0
		sta Mode


		rts
	}




	DrawPlayerPrompt: {

		ldy #PlayerSection

		lda TextRows, y
		sta Row
		sta TextRow

		lda TextColumns, y
		sta TextColumn
		sta Column

		lda TextColours, y
		tax

		ldy MAIN.Credits
		cpy #1
		beq OnePlayer

		ldy #1
		jmp Draw

		OnePlayer:

		ldy #0

		Draw:

		lda PlayerText, y

		jsr TEXT.Draw

		rts
	}



	CoinMode: {

		jsr DRAW.ClearCentre
		
		lda #1
		sta Mode

		lda #7
		sta Section

		lda #10
		sta SectionTimer

		rts
	}


	FrameUpdate: {

		ldx Mode
		lda Section
		cmp LastID, x
		beq Finish

		lda SectionTimer
		beq Ready

		dec SectionTimer
		jmp Finish


		Ready:	

			lda #SectionTime
			sta SectionTimer 

			ldy Section

			cpy #PlayerSection
			bne NotPlayer

			PlayerPrompt:

				jsr DrawPlayerPrompt
				jmp Loop

			NotPlayer:

				lda TextRows, y
				sta Row
				sta TextRow

				lda TextColumns, y
				sta TextColumn
				sta Column

				lda TextColours, y
				tax

				lda TextIDs, y

				jsr TEXT.Draw

			Loop:

				inc Section	

		Finish:

		rts
	}



}