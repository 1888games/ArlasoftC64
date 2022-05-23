DECK: {

			///   2	  3   4   5   6	  7   8   9   T   J   Q	  K   A
	Values:	.byte 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12   // 0-12
			.byte 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12   // 13-25
			.byte 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12   // 26-38
			.byte 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12   // 39-51


	Shown:	.fill 52, 1



	Suits:	.fill 13, 0   // Hearts
			.fill 13, 1	  // Diamonds
			.fill 13, 2   // Spades
			.fill 13, 3   // Clubs



	CardOrder:	.fill 52, i


	andys:	.fill 20, 63
			.fill 16, 31
			.fill 8, 15
			.fill 5, 7
			.fill 2, 3
			.fill 2, 3

	Maxes:	.fill 52, 52 - i

	CurrentCardID:		.byte 0
	CurrentlyDealing:	.byte 0

	DealingFlop:	.byte 0
	DealingTurn:	.byte 0
	DealingRiver:	.byte 0



	Shuffle: {

		ldx #0
		stx CurrentCardID


		Loop:

			stx ZP.CurrentID

			lda #0
			sta ZP.Errors

			ChooseRandomCard:

				inc ZP.Errors

				lda ZP.Errors
				cmp #100
				bcc Okay

				.break
				nop


				Okay:

				jsr RANDOM.Get

				and andys, x
				cmp Maxes, x

				bcs ChooseRandomCard
				clc
				adc ZP.CurrentID

				cmp ZP.CurrentID
				bcc ChooseRandomCard
				beq ChooseRandomCard

				
				tay

				lda CardOrder, x
				sta ZP.Amount

				lda CardOrder, y
				sta CardOrder, x

				lda ZP.Amount
				sta CardOrder, y

				inx
				cpx #51
				bcs Finish
				jmp Loop

		Finish:


			rts

	}



	BurnCard: {

		inc CurrentCardID

		rts
	}

	GetNextCard: {

		ldx CurrentCardID
		lda CardOrder, x
		
		inc CurrentCardID

		rts

	}


	GetCurrentCard: {

		ldx CurrentCardID
		lda CardOrder, x
		tax

		rts

	}




	


}