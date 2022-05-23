MATCH: {





	Process: {

		lda ZP.MinuteCounter
		beq Ready

		dec ZP.MinuteCounter
		rts


		Ready:

		inc ZP.Minute
		lda ZP.Minute
		sta SCREEN_RAM

		dec ZP.Possession
		dec ZP.Possession + 1

		lda ZP.TotalMidfield
		clc
		adc ZP.OppositionMidfield
		sta ZP.Amount

		GetRandom:

			jsr RANDOM.Get
			and #%00001111
			cmp ZP.Amount
			bcs GetRandom

			cmp ZP.TotalMidfield
			bcc YourPossession

		TheirPossession:

			lda #$51
			sta SCREEN_RAM + 3

			lda #32
			sta SCREEN_RAM + 2

			lda ZP.OppositionAttack
			clc
			adc #5
			sec
			sbc ZP.TotalDefence
			sta ZP.Amount
			beq Min
			bpl Okay

			Min:

			lda #1
			sta ZP.Amount

			Okay:

			jsr RANDOM.Get
			and #%00011111
			cmp ZP.Amount
			bcs Finish

			Chance2:

			jsr RANDOM.Get
			and #%00011111
			cmp ZP.Amount
			bcs Finish	

			inc ZP.Goals + 1
			


			jmp Finish


		YourPossession:

			lda #$51
			sta SCREEN_RAM + 2

			lda #32
			sta SCREEN_RAM + 3

			lda ZP.TotalAttack
			clc
			adc #5
			sec
			sbc ZP.OppositionDefence
			sta ZP.Amount
			beq Min2
			bpl Okay2

			Min2:

			lda #1
			sta ZP.Amount

			Okay2:

			jsr RANDOM.Get
			and #%00011111
			cmp ZP.Amount
			bcs Finish

			Chance:

			jsr RANDOM.Get
			and #%00011111
			cmp ZP.Amount
			bcs Finish	

			inc ZP.Goals
			
		Finish:

		lda #20
		sta ZP.MinuteCounter

		lda ZP.Goals
		clc
		adc #48
		sta SCREEN_RAM + 36

		lda ZP.Goals + 1
		clc
		adc #48
		sta SCREEN_RAM + 38


		rts



	}


	rts
}