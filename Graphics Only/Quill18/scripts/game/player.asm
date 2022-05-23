PLAYER: {



	Cards:	.fill 16, 99


	ChipsLow:	.byte 0, 0, 0, 0, 0, 0, 0, 0
	ChipsMed:	.byte 0, 0, 0, 0, 0, 0, 0, 0
	ChipsHigh:	.byte 0, 0, 0, 0, 0, 0, 0, 0

	BetLow:		.byte 0, 0, 0, 0, 0, 0, 0, 0
	BetMed:		.byte 0, 0, 0, 0, 0, 0, 0, 0
	BetHigh:	.byte 0, 0, 0, 0, 0, 0, 0, 0

	TotalBetLow:	.byte 0, 0, 0, 0, 0, 0, 0, 0
	TotalBetMed:	.byte 0, 0, 0, 0, 0, 0, 0, 0
	TotalBetHigh:	.byte 0, 0, 0, 0, 0, 0, 0, 0

	ToCall:		.byte 0, 0, 0




	// 0 = out of game
	// 1 = all in
	// 2 = yet to act
	// 3 = folded
	// 4 = checked
	// 5 = called
	// 6 = bet
	// 7 = raised

	PlayerID:	.byte 0
	InGame:		.byte 0, 0, 0, 0, 0, 0, 0, 0
	HandStatus:	.byte 0, 0, 0, 0, 0, 0, 0, 0
	AllIn:		.byte 0, 0, 0, 0, 0, 0, 0, 0
	HandShown:	.byte 0, 0, 0, 0, 0, 0, 0, 0


	Name:	.text "tony"
			.text "dave"
			.text "mike"
			.text "phil"
			.text "carl"
			.text "bill"
			.text "paul"
			.text "jeff"
			.text "    "
	


	Reset: {

		ldx #0
		stx PlayerID

		Loop:

			lda #0
			sta ChipsLow, x
			sta ChipsHigh, x
			sta AllIn, x
			sta HandShown, x

			lda #%00010101
			sta ChipsMed, x

			lda #1
			sta InGame, x

			lda #0
			sta HandStatus

			inx
			cpx #8
			beq Finish
			jmp Loop

		Finish:

			rts

	
	}	




	DecideMove: {

		ldx TABLE.PlayerToAct
		ldy TABLE.PlayerBigBlind

		jsr CalculateAmountToCall

		ldy #6
		jsr IncreaseBet


		jsr TABLE.MakeBet



		rts
	}	


	CalculateAmountToCall: {

		sed

		lda TABLE.TotalBetAmount + 2
		sec
		sbc TotalBetLow, x
		sta ToCall + 2

		lda TABLE.TotalBetAmount + 1
		sbc #0
		sec
		sbc TotalBetMed, x
		sta ToCall + 1

		lda TABLE.TotalBetAmount
		sbc #0
		sec
		sbc TotalBetHigh, x
		sta ToCall

		cld




		rts
	}


	Fold: {

		lda #3
		sta HandStatus, x

		jsr TEXT.ClearBet

		jsr SPRITE.FoldCards


		rts
	}

	Call: {

		lda ToCall + 2
		sta TABLE.CurrentBet + 2

		lda ToCall + 1
		sta TABLE.CurrentBet + 1

		lda ToCall
		sta TABLE.CurrentBet


		jsr TABLE.MakeBet




		rts
	}



	IncreaseBet: {

		sed

		Loop:

			lda TABLE.CurrentBet + 2
			clc
			adc TABLE.BigBlindAmount + 2
			sta TABLE.CurrentBet + 2

			lda TABLE.CurrentBet + 1
			adc #0
			clc
			adc TABLE.BigBlindAmount + 1
			sta TABLE.CurrentBet + 1

			lda TABLE.CurrentBet
			adc #0
			clc
			adc TABLE.BigBlindAmount
			sta TABLE.CurrentBet

			dey
			beq Finish
			jmp Loop

		Finish:

			cld

		jsr TEXT.DrawCurrentBet


		rts
	}



	Update: {

		lda TABLE.Status
		beq Finish

		cmp #5
		bcc Finish


		ldx TABLE.PlayerToAct
		jsr TEXT.CycleArrows

		jsr TABLE.UpdateTimer



		Finish:




		rts



	}



}