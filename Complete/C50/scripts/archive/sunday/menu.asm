MENU: {

	.label TitleRow = 0
	.label TitleColumn = 10
	.label PlayerRow = 3
	.label PlayerColumn = 2
	.label HeadingRow = 2
	.label RatingColumn = 2
	.label RatingRow = 22
	.label MenuRow = 20
	.label MenuColumn = 2


	* = * "MENU TEXT"

	.encoding "screencode_upper"
	Title:		.text @"SUNDAY LEAGUE MANAGER\$00"
	Heading:	.text @"NO POS NAME DEF ATT REL WEA INF AGG\$00"

	Positions:	.text "GDMA-"

	Nums:		.text "10"
				.text "11"


	Ratings:	.text "DEF:"
				.text "MID:"
				.text "ATT:"


	Screen:		.text "CHOOSE    RECRUIT    PLAY"
	
	ArrowColumns:	.byte 9, 20, 28


	* = * "MENU CODE -- Show"



	Show: {	

		lda #4
		sta ZP.OppositionMidfield
		sta ZP.OppositionDefence
		sta ZP.OppositionAttack

		lda #12
		sta ZP.Possession
		sta ZP.Possession + 1

		ldx #255
		stx ZP.SelectPlayer2
		stx ZP.SelectPlayer1
		stx ZP.MinuteCounter
		inx

		stx ZP.SelectedOption

		DrawTitle:


			lda Title, x
			beq DrawHeading

			sta SCREEN_RAM +  (TitleRow * 40) + TitleColumn, x

			lda #3
			sta VIC.COLOR_RAM + (TitleRow * 40) + TitleColumn, x

			inx

			jmp DrawTitle

		DrawHeading:

		ldx #0
		stx ZP.Goals
		stx ZP.Goals + 1

		Loop:

			lda Heading, x
			beq Done

			sta SCREEN_RAM +  (HeadingRow * 40) + PlayerColumn, x

			lda #7
			sta VIC.COLOR_RAM + (HeadingRow * 40) + PlayerColumn, x

			inx
			jmp Loop

		Done:

		jsr PlayerList
		jsr DrawRatings
		jsr DrawOptions
		jsr DrawArrow
		jsr DrawSelectArrows

		lda #<OptionMode
		sta ZP.ControlAddress

		lda #>OptionMode
		sta ZP.ControlAddress + 1

		rts


	}


	DrawArrow: {

		ldx #0

		Loop:

			lda ArrowColumns, x
			tay

			lda #32
			cpx ZP.SelectedOption
			bne Clear

			lda #31

			Clear:

			sta SCREEN_RAM + (40 * MenuRow), y

			lda ZP.Mode
			clc
			adc #1
			sta COLOR_RAM + (40 + MenuRow), y
			inx
			cpx #3
			bcc Loop

		rts
	}


	OptionMode: {

		beq Left

		cmp #FIRE
		beq Fire

		Right:

			inc ZP.SelectedOption
			lda ZP.SelectedOption
			cmp #3
			bcc Okay

			lda #0
			jmp Okay

		Left:

			dec ZP.SelectedOption
			lda ZP.SelectedOption
			bpl Okay

			lda #2
	
		Okay:

			sta ZP.SelectedOption
			jmp Finish



		Fire:

			lda ZP.SelectedOption
			beq Choose

			cmp #1
			beq Recruit


		Play:

			lda #MODE_PLAY
			sta ZP.Mode

			lda #<PlayMode
			sta ZP.ControlAddress

			lda #>PlayMode
			sta ZP.ControlAddress + 1
			jmp Finish


		Recruit:


			lda #MODE_RECRUIT
			sta ZP.Mode

			lda #<RecruitMode
			sta ZP.ControlAddress

			lda #>RecruitMode
			sta ZP.ControlAddress + 1
			jmp Finish


		Choose:

			lda #MODE_SELECT_1
			sta ZP.Mode

			lda #0
			sta ZP.SelectPlayer1
			jsr DrawSelectArrows

			lda #<ChooseMode
			sta ZP.ControlAddress

			lda #>ChooseMode
			sta ZP.ControlAddress + 1
			
		Finish:

			jsr DrawArrow
			lda #14
			sta ZP.Cooldown

			rts

	}


	PlayMode: {

		inc SCREEN_RAM

		lda #14
		sta ZP.Cooldown

		rts
	}

	RecruitMode: {


		inc $d021

		lda #14
		sta ZP.Cooldown


		rts
	}

	ChooseMode: {

		cmp #DOWN
		beq Down

		Up:

			dec ZP.SelectPlayer1
			lda ZP.SelectPlayer1
			bpl Okay

			lda ZP.NumberPlayers
			sta ZP.SelectPlayer1
			dec ZP.SelectPlayer1
			jmp Okay

		Down:

			inc ZP.SelectPlayer1
			lda ZP.SelectPlayer1
			cmp ZP.NumberPlayers
			bcc Okay

			lda #0
			sta ZP.SelectPlayer1

		Okay:

			jsr DrawSelectArrows


		lda #14
		sta ZP.Cooldown


		rts
	}


	DrawSelectArrows: {

		ldx #0
		ldy #0

		lda #<COLOR_RAM + (40 * PlayerRow) + 37
		sta ZP.ScreenAddress

		lda #>COLOR_RAM + (40 * PlayerRow) + 37
		sta ZP.ScreenAddress + 1

		Loop:

			txa
			cmp ZP.SelectPlayer1
			bne NotRed

			Red:

			lda #RED
			jmp Colour

			NotRed:

			cmp ZP.SelectPlayer2
			beq Green

			lda #BLACK
			jmp Colour

			Green:

			lda #GREEN

			Colour:

			sta (ZP.ScreenAddress), y
			jsr MoveDownRow

			inx
			cpx ZP.NumberPlayers
			bcc Loop



		rts
	}

	DrawOptions: {

		lda #<SCREEN_RAM + (40 * MenuRow) + MenuColumn
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + (40 * MenuRow) + MenuColumn
		sta ZP.ScreenAddress + 1

		ldy #0

		Loop:

			lda Screen, y
			sta (ZP.ScreenAddress), y

			iny
			cpy #25
			bcc Loop




		rts
	}




	DrawRatings: {

		lda #<SCREEN_RAM + (40 * RatingRow) + RatingColumn
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + (40 * RatingRow) + RatingColumn
		sta ZP.ScreenAddress + 1

		ldx #0
		ldy #0

		Loop:
		
			lda Ratings, x
			sta (ZP.ScreenAddress), y
			iny
			inx
			cpx #12
			bcs Done
			cpy #4
			bcc Loop

			jsr MoveDownRow
			ldy #0
			jmp Loop

		Done:

		lda ZP.TotalDefence
		clc
		adc #48
		sta SCREEN_RAM + (40 *(RatingRow)) + RatingColumn + 5

		lda ZP.TotalMidfield
		clc
		adc #48
		sta SCREEN_RAM + (40 * (RatingRow + 1)) + RatingColumn + 5

		lda ZP.TotalAttack
		clc
		adc #48
		sta SCREEN_RAM + (40 *(RatingRow + 2)) + RatingColumn + 5



		rts

	}

	MoveDownRow: {

		lda ZP.ScreenAddress
		clc
		adc #40
		sta ZP.ScreenAddress

		bcc NoWrap

		inc ZP.ScreenAddress + 1

		NoWrap:


		rts
	}


	PlayerList: {


		lda #<SCREEN_RAM + (40 * PlayerRow) + PlayerColumn
		sta ZP.ScreenAddress

		lda #>SCREEN_RAM + (40 * PlayerRow) + PlayerColumn
		sta ZP.ScreenAddress + 1

		ldx #0
		stx ZP.CurrentPosition
		stx ZP.TotalDefence
		stx ZP.TotalMidfield
		stx ZP.TotalAttack

		Loop:

			stx ZP.X

			Number:

				ldy #0

				cpx #9
				bcc DrawNow

				txa
				sec
				sbc #10
				tax

				lda #49
				sta (ZP.ScreenAddress), y

			DrawNow:

				ldy #1
				txa
				clc
				adc #49
				sta (ZP.ScreenAddress), y

			CheckIfNewPosition:

				ldy ZP.CurrentPosition
				cpy #4
				beq NoChange

				lda ZP.X
				cmp ZP.Formation, y
				bcc NoChange	

				inc ZP.CurrentPosition
				iny

			NoChange:


			Position:

			ldx ZP.X
			cpx ZP.NumberPlayers
			bcc Okay2

			jmp EndLoop2


			Okay2:

			lda Positions, y
			ldy #4
			sta (ZP.ScreenAddress), y

			lda ZP.Selection, x
			asl
			asl
			tax

			ldy #7

			NameLoop:

				lda PLAYERS.Names, x
				sta (ZP.ScreenAddress), y

				cpy #7
				beq First

				cpy #8
				beq Second

				cpy #9
				beq Third


				Fourth:

					sta ZP.Amount
					clc
					adc ZP.Reliability
					sta ZP.Reliability

					lda ZP.Amount
					clc
					adc ZP.Violence
					sta ZP.Violence

					lda ZP.Amount
					clc
					adc ZP.Wealth
					sta ZP.Wealth
					jmp EndLoop

				Third:

					sta ZP.Reliability
					
					clc
					adc ZP.Influence
					sta ZP.Influence

					lda ZP.Attack
					clc
					adc ZP.Reliability
					sta ZP.Attack
					jmp EndLoop

				Second:

					sta ZP.Attack
					sta ZP.Violence
					clc
					adc ZP.Defence
					sta ZP.Defence
					jmp EndLoop

				First:

					sta ZP.Defence
					sta ZP.Influence
					sta ZP.Wealth	

				EndLoop:

				inx
				iny
				cpy #11
				beq Stats
				jmp NameLoop

		

			Stats:

				iny
				iny

				ldx ZP.Defence
				jsr DrawStat
				sta ZP.Defence

				ldx ZP.Attack
				jsr DrawStat
				sta ZP.Attack

				ldx ZP.Reliability
				jsr DrawStat
				sta ZP.Reliability

				ldx ZP.Wealth
				jsr DrawStat
				sta ZP.Wealth

				ldx ZP.Influence
				jsr DrawStat
				sta ZP.Influence

				ldx ZP.Violence
				jsr DrawStat
				sta ZP.Violence

			dey
			dey
			lda #31
			sta (ZP.ScreenAddress), y


			NoArrow:



			jsr AddStats

			EndLoop2:

			jsr MoveDownRow



			ldx ZP.X
			inx
			cpx #16
			beq Done
			jmp Loop


		Done:
				

		lda ZP.TotalDefence
		ldx ZP.TotalMidfield
		ldy ZP.TotalAttack

		lda ZP.TotalDefence
		lsr
		lsr
		lsr
		lsr
		sta ZP.TotalDefence

		lda ZP.TotalMidfield
		lsr
		lsr
		lsr
		lsr
		sta ZP.TotalMidfield
	
		lda ZP.TotalAttack
		lsr
		lsr
		lsr
		lsr
		sta ZP.TotalAttack

		
		rts
	}




	AddStats: {

		ldx ZP.CurrentPosition
		cpx #4
		bcs Finish


		cpx #0
		beq Goalkeeper


		cpx #1
		beq Defender

		cpx #2
		beq Midfielder

		Attacker:

			lda ZP.TotalAttack
			clc
			adc ZP.Attack
			adc ZP.Attack
			adc ZP.Violence
			adc ZP.Attack
			sta ZP.TotalAttack
			rts

		Midfielder:

			lda ZP.TotalMidfield
			clc
			adc ZP.Defence
			adc ZP.Attack
			adc ZP.Influence
			adc ZP.Violence
			sta ZP.TotalMidfield
			rts


		Defender:

			lda ZP.TotalDefence
			clc
			adc ZP.Defence
			adc ZP.Defence
			adc ZP.Violence
			adc ZP.Reliability
			sta ZP.TotalDefence
			rts

		Goalkeeper:

			lda ZP.TotalDefence
			clc
			adc ZP.Defence
			adc ZP.Defence
			adc ZP.Reliability
			adc ZP.Reliability
			sta ZP.TotalDefence
			rts

		Finish:


		rts
	}


	DrawStat: {

		
		lda PLAYERS.Data, x
		and #%00000111
		pha
		clc
		adc #49	

		sta (ZP.ScreenAddress), y
		iny
		iny
		iny
		iny

		pla
		clc
		adc #1



		rts
	}



}