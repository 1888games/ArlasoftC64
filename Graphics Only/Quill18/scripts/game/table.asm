TABLE: {


	Cards:				.byte 99, 99, 99, 99, 99


	BoardColumns:		.byte 12, 15, 18, 21, 24
	BoardRow:			.byte 10


	Pots:				.byte 0, 0, 0, 0
						.byte 0, 0, 0, 0
						.byte 0, 0, 0, 0 
						.byte 0, 0, 0, 0
						.byte 0, 0, 0, 0
						.byte 0, 0, 0, 0


	NumberOfPots:		.byte 1


	BetMade:			.byte 0


	Raiser:				.byte 0
	PlayerToAct:		.byte 0

	PlayerBigBlind:		.byte 0
	PlayerSmallBlind:	.byte 0
	Dealer:				.byte 0

	CurrentBet:			.byte 0, 0, 0

	BigBlindAmount:		.byte 0, 0, 32
	SmallBlindAmount:	.byte 0, 0, 16
	TotalBetAmount:		.byte 0, 0, 32

	PauseTimer:			.byte 30, 30


	.label PreFlopBetting = 5

	// 0 = Idle
	// 1 = Dealing Cards
	// 2 = Dealing Flop
	// 3 = Dealing Turn
	// 4 = Dealing River
	// 5 = Pre-Flop Betting
	// 6 = Post Flop Betting	
	// 7 = Post Turn Betting
	// 8 = Post River Betting
	// 9 = Decide pot winner(s)
	// 10 = Next Hand


	Status:			.byte 0
	TickChar:		.byte 5, 5
	TickCount:		.byte 0, 0
	TickTimer:		.byte 16,2



	Reset: {

		lda PauseTimer + 1
		sta PauseTimer

		jsr RANDOM.Get
		and #%00000111
		sta Dealer

		jsr MoveAroundTable

		lda CurrentID
		sta PlayerSmallBlind

		jsr MoveAroundTable

		lda CurrentID
		sta PlayerBigBlind


		jsr TEXT.DrawPot



		

	//	jsr DealNextHand

	
	//	jsr PLAYER.DecideMove

		//jsr TEXT.DrawCurrentBet


		rts


	}




	NextPlayer: {

		ldx PlayerToAct

		jsr ResetTimer	

		rts

	}


	UpdateTimer: {

		lda TickTimer
		beq UpdateBar

		dec TickTimer
		jmp Finish

		UpdateBar:

			lda TickTimer + 1
			sta TickTimer

			inc TickCount

			lda TickCount
			cmp #8
			bcc Draw

		NewChar:

			jsr DRAW.DeleteTimerChar

			lda TickCount + 1
			sta TickCount

			dec TickChar

			lda TickChar
			bpl Draw

		Timeout:	

			ldx PlayerToAct
			jsr PLAYER.Fold
			jmp Finish

			//.break
			nop


		Draw:

		jsr DRAW.UpdateTimerBar

		

		Finish:

		rts
	}


	ResetTimer: {


		lda TickChar + 1
		sta TickChar

		lda TickTimer + 1
		sta TickTimer

		lda TickCount + 1
		sta TickCount

		ldx PlayerToAct

		jsr DRAW.FillTimerBar

		rts

	}


	DealNextHand: {

		jsr PostBlinds
		jsr DealCards

		rts

	}

	Update: {

		lda PauseTimer
		beq ReadyToAct

		dec PauseTimer
		jmp Finish

		ReadyToAct:

		lda Status
		bne Finish

		lda #1
		sta Status

		jsr DealNextHand

		Finish:

		rts
	}



	DealCards: {


		lda #1
		sta DECK.CurrentlyDealing
		sta Status


		lda #0
		sta DECK.DealingRiver
		sta DECK.DealingFlop
		sta DECK.DealingTurn

		jsr TEXT.DrawArrows

		rts

	}


	PostBlinds: {

		ldx Dealer

		jsr DRAW.DrawDealerButton
		jsr PostSmallBlind
		jsr PostBigBlind


		rts


	}



	PostSmallBlind: {


		lda PlayerSmallBlind
		sta PlayerToAct

		lda SmallBlindAmount + 2
		sta CurrentBet + 2

		lda SmallBlindAmount + 1
		sta CurrentBet + 1

		lda SmallBlindAmount
		sta CurrentBet

		jsr MakeBet

		rts


	}



	PostBigBlind: {

		lda PlayerBigBlind
		sta PlayerToAct

		lda BigBlindAmount + 2
		sta CurrentBet + 2

		lda BigBlindAmount + 1
		sta CurrentBet + 1

		lda BigBlindAmount
		sta CurrentBet

		jsr MakeBet

		lda PlayerBigBlind
		jsr MoveAroundTable

		lda CurrentID
		sta PlayerToAct


		rts


	}



	MakeBet: {

	//	.break

		ldx PlayerToAct

		sed
		lda PLAYER.ChipsLow, x
		sec
		sbc CurrentBet + 2
		sta PLAYER.ChipsLow, x

		lda PLAYER.ChipsMed, x
		sbc #0
		sec
		sbc CurrentBet + 1
		sta PLAYER.ChipsMed, x

		lda PLAYER.ChipsHigh, x
		sbc #0
		sec
		sbc CurrentBet
		sta PLAYER.ChipsHigh, x


		lda PLAYER.BetLow, x
		clc
		adc CurrentBet + 2
		sta PLAYER.BetLow, x

		lda PLAYER.BetMed, x
		adc #0
		clc
		adc CurrentBet + 1
		sta PLAYER.BetMed, x

		lda PLAYER.BetHigh, x
		adc #0
		clc
		adc CurrentBet
		sta PLAYER.BetHigh, x

		lda Pots + 2
		clc
		adc CurrentBet + 2
		sta Pots + 2

		lda Pots + 1
		adc #0
		clc
		adc CurrentBet + 1
		sta Pots + 1

		lda Pots
		adc #0
		clc
		adc CurrentBet
		sta Pots



		cld

		jsr TEXT.DrawChips
		jsr TEXT.DrawBet
		jsr TEXT.DrawPot

		rts

	}

	MoveAroundTable: {

		sta CurrentID

		Loop:

			lda CurrentID

			clc
			adc #01
			cmp #8
			bcc NoWrap

			lda #0

			NoWrap:	

			sta CurrentID

			tax
			lda PLAYER.InGame, x
			beq Loop

		//	lda PLAYER.HandStatus, x
		//	cmp #2
		//	bcc Loop

		rts




	}


	NextHand: {

		lda Dealer
		jsr MoveAroundTable
		lda CurrentID
		sta Dealer

		lda PlayerBigBlind
		jsr MoveAroundTable
		lda CurrentID
		sta PlayerBigBlind

		lda PlayerSmallBlind
		jsr MoveAroundTable
		lda CurrentID
		sta PlayerSmallBlind

		lda #0
		sta Pots + 0
		sta Pots + 1
		sta Pots + 2
		sta Pots + 3
		sta Pots + 4
		sta Pots + 5
		sta Pots + 6
		sta Pots + 7
		sta Pots + 8
		sta Pots + 9
		sta Pots + 10
		sta Pots + 11
		sta Pots + 12
		sta Pots + 13
		sta Pots + 14
		sta Pots + 15

		lda #1
		sta NumberOfPots

		jsr TEXT.DrawPot

		rts



	}
}