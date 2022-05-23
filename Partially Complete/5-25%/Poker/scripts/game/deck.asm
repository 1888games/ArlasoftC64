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

	CurrentCardID:	.byte 0
	CurrentlyDealing:	.byte 0

	DealingFlop:	.byte 0
	DealingTurn:	.byte 0
	DealingRiver:	.byte 0
	


	Shuffle: {

		ldx #0


		Loop:

			stx CurrentID

			lda #0
			sta Errors

			ChooseRandomCard:

				inc Errors

				lda Errors
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
				adc CurrentID

				cmp CurrentID
				bcc ChooseRandomCard
				beq ChooseRandomCard

				
				tay

				lda CardOrder, x
				sta Amount

				lda CardOrder, y
				sta CardOrder, x

				lda Amount
				sta CardOrder, y

				inx
				cpx #51
				bcs Finish
				jmp Loop

		Finish:

			rts



		//for (int i = 0// i < data.Length// i++)
//{
// swap(ref data[i], ref data[i+R.Next(data.Length-i)])//
//}
	}


	BurnCard: {

		inc DECK.CurrentCardID

		rts
	}

	GetNextCard: {

		ldx CurrentCardID
		lda CardOrder, x
		tax

		inc DECK.CurrentCardID

		rts

	}


	GetCurrentCard: {

		ldx CurrentCardID
		lda CardOrder, x
		tax

		rts


	}


	Update: {

		lda CurrentlyDealing
		bne DealingToPlayers

		lda DealingFlop
		bne DealFlop

		jmp Finish


		DealFlop:

			
		
		DealingToPlayers:

			lda SPRITE.BeingDealt
			clc
			adc SPRITE.BeingDealt + 1

			beq CheckNextCard

			jsr SPRITE.MoveCards
			jmp Finish

			CheckNextCard:

			jsr SPRITE.DealCard


			lda SLOTS.NextSlotID
			cmp #17
			bcc Finish



			lda #0
			sta CurrentlyDealing

			lda #TABLE.PreFlopBetting
			sta TABLE.Status

			jsr TABLE.ResetTimer


		Finish:	


			rts

	}



	


}