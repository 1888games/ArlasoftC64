GAME: {


	.label StartRow = 2
	.label NUM_CARDS = 52
	.label CardsInRow = 13
	.label NodesInRow = 12
	.label NUM_NODES = 36

	TopLeft:		.byte 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17
					.byte 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17
					.byte 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17
					.byte 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17

	TopRight:		.fill 9, 4
					.byte 14
					.fill 3, 4
					.fill 9, 4
					.byte 14
					.fill 3, 4
					.fill 9, 4
					.byte 14
					.fill 3, 4
					.fill 9, 4
					.byte 14
					.fill 3, 4





	BottomLeft:		.fill 13, 18
					.fill 13, 103
					.fill 13, 64
					
					.fill 13, 131

	BottomRight:	.fill 13, 19
					.fill 13, 104
					.fill 13, 65
					.fill 13, 132


	Columns:		.fill 13, 1 + i * 3
					.fill 13, 1 + i * 3
					.fill 13, 1 + i * 3
					.fill 13, 1 + i * 3

	Rows:			.fill 13, StartRow
					.fill 13, StartRow + 3
					.fill 13, StartRow + 6
					.fill 13, StartRow + 9

	Colours:		.fill 13, RED
					.fill 13, BLACK
					.fill 13, RED
					.fill 13, BLACK

	AnimateStatus:	.byte 255
	Timer:			.byte 0


	TopLeftX:		.byte 1, 2
	TopRightY:		.byte 1, 2
	BottomRightX:	.byte -1, -2
	BottomLeftY:	.byte -1, -2

	SelectedNode:	.byte 0

	SelectedRow:	.byte 0
	SelectedColumn:	.byte 0
	Cooldown: 	.byte 0

	Minutes:		.byte $05
	Seconds:		.byte $00

	SecondsTimer:	.byte 50


	.label AnimateTime = 6
	.label StartSpriteX = 46
	.label StartSpriteY = 80
	.label CooldownTime = 5
	.label EndX = 54
	.label EndY = 128

	SpriteX:	.byte StartSpriteX
	SpriteY:	.byte StartSpriteY
	SpriteX_MSB: .byte 0
	Consecutive:	.byte 0
	LastNode:		.byte 0
	Matches:		.byte 0

	StartMatches:	.byte 0


	* = * "Order"

	Order:			.fill NUM_CARDS, i




	NodeTopLeft:	.fill 12, i
					.fill 12, i + (CardsInRow * 1)
					.fill 12, i + (CardsInRow * 2)
				
 
	NodeTopRight:	.fill 12, i + 1
					.fill 12, i + (CardsInRow * 1) + 1
					.fill 12, i + (CardsInRow * 2) + 1
			

	NodeBottomLeft:	.fill 12, i + (CardsInRow * 1)
					.fill 12, i + (CardsInRow * 2)
					.fill 12, i + (CardsInRow * 3)


	NodeBottomRight:	.fill 12, i + (CardsInRow * 1) + 1
						.fill 12, i + (CardsInRow * 2) + 1
						.fill 12, i + (CardsInRow * 3) + 1



	Level:		.byte 1

	Completed:	.byte 0



	NewGame: {

		lda #1
		sta Level

		lda #0
		sta Completed




		rts
	}


	Reset: {

		lda #255
		sta AnimateStatus
		sta LastNode

		ldx #0
		stx Consecutive

		Loop:

			txa
			sta Order, x
			inx
			cpx #NUM_CARDS
			bcc Loop

		rts
	}


	UpdateSprite: {

		lda ZP.Counter
		and #%00000001
		bne Skip

		jsr RANDOM.Get
		sta VIC.SPRITE_COLOR_0

		Skip:

		lda SpriteX
		sta VIC.SPRITE_0_X

		lda #17
		sta SPRITE_POINTERS

		lda SpriteY
		sta VIC.SPRITE_0_Y

		lda SpriteX_MSB
		beq NoMSB

		MSB:


		 	lda VIC.SPRITE_MSB
		 	ora #%00000001
		 	sta VIC.SPRITE_MSB
		 	jmp EndMSB

		NoMSB:

		 	lda VIC.SPRITE_MSB
		 	and #%11111110
		 	sta VIC.SPRITE_MSB

		EndMSB:




		rts
	}


	DrawMinutes:{

		ldx #20
		ldy #18

		jsr PLOT.GetCharacter

		ldy #4	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #1
		sta ZP.EndID

		InMills:

		ScoreLoop:

			lda Minutes
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			//beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			//.break

			stx ZP.StoredXReg

			asl
			asl
			tax

			lda NumberChars, x

			dey
			sta (ZP.ScreenAddress), y

			
			lda #RED
			sta (ZP.ColourAddress), y

			inx
			lda NumberChars, x
			iny
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #39
			tay

			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

		
			iny 
			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

			tya
			sec
			sbc #42
			tay

			ldx ZP.StoredXReg

			rts


		}

		Finish:

		

		rts

	}

	DrawSeconds:{

		ldx #26
		ldy #18

		jsr PLOT.GetCharacter

		ldy #4	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #1
		sta ZP.EndID

		InMills:

		ScoreLoop:

			lda Seconds
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			//beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			//.break

			stx ZP.StoredXReg

			asl
			asl
			tax

			lda NumberChars, x

			dey
			sta (ZP.ScreenAddress), y

			
			lda #RED
			sta (ZP.ColourAddress), y

			inx
			lda NumberChars, x
			iny
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #39
			tay

			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

		
			iny 
			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

			tya
			sec
			sbc #42
			tay

			ldx ZP.StoredXReg

			rts


		}

		Finish:

		

		rts

	}

	DrawLevel:{

		ldx #20
		ldy #16

		jsr PLOT.GetCharacter

		ldy #4	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #1
		sta ZP.EndID

		InMills:

		ScoreLoop:

			lda Level
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			//beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			//.break

			stx ZP.StoredXReg

			asl
			asl
			tax

			lda NumberChars, x

			dey
			sta (ZP.ScreenAddress), y

			
			lda #RED
			sta (ZP.ColourAddress), y

			inx
			lda NumberChars, x
			iny
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #39
			tay

			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

		
			iny 
			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

			tya
			sec
			sbc #42
			tay

			ldx ZP.StoredXReg

			rts


		}

		Finish:

		

		rts

	}

	DrawMatches:{

		ldx #20
		ldy #20

		jsr PLOT.GetCharacter

		ldy #4	// screen offset, right most digit
		ldx #ZERO	// score byte index

		lda #1
		sta ZP.EndID

		InMills:

		ScoreLoop:

			lda Matches
			pha
			and #$0f	// keep lower nibble
			jsr PlotDigit
			pla
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
	NextSet:
			inx 
			cpx ZP.EndID
			bne NoCheck

			cmp #0
			//beq Finish

		NoCheck:

			jsr PlotDigit

			cpx ZP.EndID
			beq Finish

			jmp ScoreLoop


		PlotDigit: {

			//.break

			stx ZP.StoredXReg

			asl
			asl
			tax

			lda NumberChars, x

			dey
			sta (ZP.ScreenAddress), y

			
			lda #RED
			sta (ZP.ColourAddress), y

			inx
			lda NumberChars, x
			iny
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

			tya
			clc
			adc #39
			tay

			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

		
			iny 
			inx
			lda NumberChars, x
			sta (ZP.ScreenAddress), y

			lda #RED
			sta (ZP.ColourAddress), y

			tya
			sec
			sbc #42
			tay

			ldx ZP.StoredXReg

			rts


		}

		Finish:

		

		rts

	}

		
	AnimateChange: {

		lda Timer
		beq Ready

		dec Timer
		rts

		Ready:

		ldx AnimateStatus

		TopLeftCard:

			lda NodeTopLeft, x
			tay

			lda Order, y
			tax

			lda Colours, x
			sta ZP.Colour

			lda Rows, y
			sta ZP.Row
			tay

			lda Columns, y
			ldx AnimateStatus
			clc
			adc TopLeftX, x
			sta ZP.Column
			tax

			jsr Draw

		TopRightCard:

			lda NodeTopRight, x
			tay

			lda Order, y
			tax

			lda Colours, x
			sta ZP.Colour

			lda Rows, y
			ldx AnimateStatus
			clc
			adc TopRightY, x
			sta ZP.Row
			tay

			lda Columns, y
			sta ZP.Column
			tax










		rts
	}


	Control: {

		lda Cooldown
		beq Ready

		dec Cooldown
		rts



		Ready:

		ldy #1


		CheckLeft:

			lda INPUT.JOY_LEFT_NOW, y
			beq CheckRight


			lda #CooldownTime
			sta Cooldown


			lda SpriteX
			sec
			sbc #24
			sta SpriteX

			lda SpriteX_MSB
			sbc #0
			sta SpriteX_MSB

			dec SelectedNode

			lda SelectedColumn
			sec
			sbc #1
			sta SelectedColumn
			bpl NoWrapLeft

			lda #11
			sta SelectedColumn

			lda #EndX
			sta SpriteX

			lda #1
			sta SpriteX_MSB

			lda SelectedNode
			clc
			adc #12
			sta SelectedNode

		NoWrapLeft:


		CheckRight:


			lda INPUT.JOY_RIGHT_NOW, y
			beq CheckUp

			lda #CooldownTime
			sta Cooldown

			inc SelectedNode

			lda SpriteX
			clc
			adc #24
			sta SpriteX

			lda SpriteX_MSB
			adc #0
			sta SpriteX_MSB

			lda SelectedColumn
			clc
			adc #1
			sta SelectedColumn
			cmp #12
			bcc NoWrapRight


			lda #0
			sta SelectedColumn

			lda #StartSpriteX
			sta SpriteX

			lda #0
			sta SpriteX_MSB

			lda SelectedNode
			sec
			sbc #12
			sta SelectedNode



		NoWrapRight:


		CheckUp:

			lda INPUT.JOY_UP_NOW, y
			beq CheckDown

			lda #CooldownTime
			sta Cooldown


			lda SelectedNode
			sec
			sbc #12
			sta SelectedNode

			lda SpriteY
			sec
			sbc #24
			sta SpriteY

			lda SelectedRow
			sec
			sbc #1
			sta SelectedRow
			bpl NoWrapUp

			lda #2
			sta SelectedRow

			lda #EndY
			sta SpriteY

			lda #CooldownTime
			sta Cooldown

			lda SelectedNode
			clc
			adc #36
			sta SelectedNode

		NoWrapUp:


		CheckDown:


			lda INPUT.JOY_DOWN_NOW, y
			beq Finish

			lda #CooldownTime
			sta Cooldown


			lda SelectedNode
			clc
			adc #12
			sta SelectedNode

			lda SpriteY
			clc
			adc #24
			sta SpriteY


			lda SelectedRow
			clc
			adc #1
			sta SelectedRow
			cmp #3
			bcc NoWrapDown

			lda #0
			sta SelectedRow

			lda #StartSpriteY
			sta SpriteY

			lda SelectedNode
			sec
			sbc #36
			sta SelectedNode

		
		NoWrapDown:



		Finish:

		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq NoFire	

		ldx SelectedNode

		jsr RotateNode
		jsr DrawAll
		jsr CheckComplete



		NoFire:


		rts
	}

	CalcMatches: {

		ldx #0
		stx Matches

		Loop:

			lda Order, x
			sta ZP.Amount

			cpx ZP.Amount
			bne NoMatch

			sed

			lda Matches
			clc
			adc #1
			sta Matches

			cld

			NoMatch:

			inx
			cpx #NUM_CARDS
			bcc Loop



		rts
	}

	CheckComplete: {

		jsr CalcMatches

		lda Matches
		cmp #$52
		bcc NotComplete


		jsr LevelComplete


		NotComplete:



		jsr DrawMatches

		rts
	}

	// 100 per minute
	// 1 per second



	LevelComplete: {

		ldy #1
		jsr SCORE.AddScore

		lda Seconds
		sta SCORE.ScoreL

		lda Minutes
		sta SCORE.ScoreM

		ldy #0
		jsr SCORE.AddScore

		lda #30
		sta Timer

		inc Completed

		jsr AddMatches



		rts
	}

	UpdateClock: {

		lda SecondsTimer
		beq Ready

		dec SecondsTimer
		rts


		Ready:

		lda #50
		sta SecondsTimer

		sed

		lda Seconds
		sec
		sbc #1
		sta Seconds
		cmp #$99
		bne NoWrap

		lda Minutes
		sec
		sbc #1
		sta Minutes

		bpl NoEnd

		jmp LevelFailed

		lda #$0
		sta Seconds

		lda #$0
		sta Minutes



		NoEnd:

		lda #$59
		sta Seconds

		NoWrap:

		cld

		jsr DrawMinutes
		jsr DrawSeconds




		rts
	}


	AddMatches: {

		lda Matches
		cmp StartMatches
		beq Finish
		bcc Finish

		Loop:

			lda $d012
			cmp #100
			bne Loop

			inc $d020

			ldy #2

			jsr SCORE.AddScore

			sed
			
			lda Matches
			sec
			sbc #1
			sta Matches
			cld

			cmp StartMatches
			bne Loop

		Finish:


		rts
	}


	LevelFailed: {

		lda #$0
		sta Seconds

		lda #$0
		sta Minutes

		cld

		jsr DrawMinutes
		jsr DrawSeconds

		lda #30
		sta Timer

		inc Completed

		jsr AddMatches

		


		rts
	}

	HandleComplete: {

		lda Timer
		beq Ready

		inc $d020

		dec Timer
		rts

		Ready:

		lda #0
		sta Completed

		inc Level

		lda Level
		cmp #$11
		bcc Okay

		FireLoop:

		lda #RED
		sta $d020

		ldy #1
		lda INPUT.FIRE_UP_THIS_FRAME, y
		bne Okay

		jmp FireLoop

		Okay:

		lda #BLACK
		sta $d020

		jsr SetupLevel


		rts
	}


	FrameUpdate: {

		lda Completed
		beq NotComplete

		jmp HandleComplete

		NotComplete:

			jsr Control
			jsr UpdateSprite

			lda AnimateStatus
			bmi NoAnimate

			jsr AnimateChange

		NoAnimate:

			jsr UpdateClock



		rts
	}

	RandomNode: {

		lda LastNode
		bmi NewRandom

		lda Consecutive
		beq NewRandom


		jsr RANDOM.Get
		and #%00000001
		bne NewRandom

		ldx LastNode
		jmp Ready

		NewRandom:

		jsr RANDOM.Get

		and #%00111111
		cmp #NUM_NODES
		bcs NewRandom

		tax
		sta LastNode

		Ready:

		inc Consecutive

		lda Consecutive
		cmp #3
		bcc Okay

		lda #0
		sta Consecutive

		Okay:

		jsr RotateNodeOpposite

		rts
	}


	SetupLevel: {

		lda #$05
		sta Minutes

		lda #$00
		sta Seconds

		jsr Reset

		TryAgain:

			lda Level
			asl

			tax

		Loop:

			stx ZP.X

			jsr RandomNode

			ldx ZP.X

			dex
			bne Loop

		jsr CalcMatches

		lda Matches
		sta StartMatches
		cmp #$52
		bcc Okay

		jmp TryAgain

		Okay:

		jsr DrawAll
		jsr CheckComplete
		jsr DrawMatches
		jsr DrawMinutes
		jsr DrawSeconds
		jsr DrawLevel




		rts
	}

	DrawAll: {

		ldx #0

		Loop:

			stx ZP.X

			jsr GetNormalData
			jsr Draw

			ldx ZP.X
			inx
			cpx #NUM_CARDS
			bcc Loop




		rts
	}	


	GetNormalData: {


		ldx ZP.X
		lda Order, x
		sta ZP.CurrentID
		tax

		lda Colours, x
		sta ZP.Colour

		ldx ZP.X

		lda Rows, x
		sta ZP.Row
		tay

		lda Columns, x
		sta ZP.Column
		tax

		rts
	}


	Draw: {

		jsr PLOT.GetCharacter

		ldx ZP.CurrentID
		lda TopLeft, x
		ldy #0
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y


		lda TopRight, x
		iny
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y


		lda BottomRight, x
		ldy #41
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y


		lda BottomLeft, x
		dey
		sta (ZP.ScreenAddress), y

		lda ZP.Colour
		sta (ZP.ColourAddress), y



		rts

		




	}


	RotateNodeOpposite: {

		StoreTopLeft:

			lda NodeTopLeft, x
			tay
			lda Order, y
			sta ZP.Amount


		BottomLeftUp:

			lda NodeTopRight, x
			tay
			lda Order, y
			sta ZP.Temp1

			lda NodeTopLeft, x
			tay
			lda ZP.Temp1
			sta Order, y

		BottomRightAcross:

			lda NodeBottomRight, x
			tay
			lda Order, y
			sta ZP.Temp1

			lda NodeTopRight, x
			tay
			lda ZP.Temp1
			sta Order, y

		TopRightDown:

			lda NodeBottomLeft, x
			tay
			lda Order, y
			sta ZP.Temp1

			lda NodeBottomRight, x
			tay
			lda ZP.Temp1
			sta Order, y

		TopLeftAcross:

			lda NodeBottomLeft, x
			tay
			lda ZP.Amount
			sta Order, y





		rts
	}

	RotateNode: {

		StoreTopLeft:

			lda NodeTopLeft, x
			tay
			lda Order, y
			sta ZP.Amount


		BottomLeftUp:

			lda NodeBottomLeft, x
			tay
			lda Order, y
			sta ZP.Temp1

			lda NodeTopLeft, x
			tay
			lda ZP.Temp1
			sta Order, y

		BottomRightAcross:

			lda NodeBottomRight, x
			tay
			lda Order, y
			sta ZP.Temp1

			lda NodeBottomLeft, x
			tay
			lda ZP.Temp1
			sta Order, y

		TopRightDown:

			lda NodeTopRight, x
			tay
			lda Order, y
			sta ZP.Temp1

			lda NodeBottomRight, x
			tay
			lda ZP.Temp1
			sta Order, y

		TopLeftAcross:

			lda NodeTopRight, x
			tay
			lda ZP.Amount
			sta Order, y



		rts
	}











}