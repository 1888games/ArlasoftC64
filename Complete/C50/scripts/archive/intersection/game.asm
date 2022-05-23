GAME: {

	* = * "Game"
	.label CarPointer = 55
	.label RightPointer = 56
	.label DownPointer = 57
	.label UpPointer = 58

	.label StartSpeedLR = 250
	.label StartSpeedDU = 160
	.label MinGap = 45

	.label InterY1 = 112
	.label InterY2 = 156
	.label InterX1 = 154
	.label InterX2 = 201

	Show: {


		lda #0
		sta ZP.CarsInPlay
		sta ZP.CarsToSpawn
		sta VIC.SPRITE_ENABLE
		sta VIC.BORDER_COLOR

		ldx #4

		Loop:

			sta ZP.LaneSpeed_MSB - 1, x
			sta ZP.CarsInLane - 1, x
			sta ZP.Score - 1, x

			dex
			bne Loop


		lda #200
		sta ZP.SpawnSpeed
		sta ZP.SpawnTimer

		lda #1
		sta ZP.DirectionOn
		sta ZP.DirectionOn + 1
		sta ZP.DirectionOn + 2
		sta ZP.DirectionOn + 3


		lda #StartSpeedLR
		sta ZP.LaneSpeed
		sta ZP.LaneSpeed + 1

		lda #StartSpeedDU
		sta ZP.LaneSpeed + 2
		sta ZP.LaneSpeed + 3

		lda #MinGap
		sta ZP.MinTimer

		jsr DrawScore
		jsr DrawBest

		jsr SpawnCar
		jsr SpawnCar

		rts
	}



	DecreaseScore: {


	

		lda ZP.Score + 1
		beq DontDecrease

		sed

		lda ZP.Score
		sec
		sbc #1
		sta ZP.Score
		
		lda ZP.Score + 1
		sbc #0
		sta ZP.Score + 1

		lda ZP.Score + 2
		sbc #0
		sta ZP.Score + 2

		cld

		jsr DrawScore

		DontDecrease:



		rts
	}


	UpdateScore: {

		sed

		lda ZP.Score
		clc
		adc ZP.CarScores, y
		sta ZP.Score
		
		lda ZP.Score + 1
		adc #0
		sta ZP.Score + 1

		lda ZP.Score + 2
		adc #0
		sta ZP.Score + 2

		cld

		jsr DrawScore


		rts


	}


	DrawBest: {


		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
	
		ScoreLoop:

			lda ZP.Best,x
			sta ZP.Amount
			and #$0f	// keep lower nibble
			jsr PlotDigit
			lda ZP.Amount
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {

			clc
			adc #245
			sta SCREEN_RAM + 32, y

			dey
			rts

		}


		rts
	}
	

	DrawScore: {


		ldx #3

		Loop7:

			lda ZP.Score - 1, x
			cmp ZP.Best - 1, x
			bcc Skip
			beq CheckIfNext

			jmp SetHigh

			CheckIfNext:

				dex
				bne Loop7
				jmp Skip

		SetHigh:

		lda ZP.Score + 2
		sta ZP.Best + 2
		lda ZP.Score + 1
		sta ZP.Best + 1
		lda ZP.Score 
		sta ZP.Best

		 Skip:

		ldy #5	// screen offset, right most digit
		ldx #ZERO	// score byte index
	
		ScoreLoop:

			lda ZP.Score,x
			sta ZP.Amount
			and #$0f	// keep lower nibble
			jsr PlotDigit
			lda ZP.Amount
			lsr
			lsr
			lsr	
			lsr // shift right to get higher lower nibble
			jsr PlotDigit
			inx 
			cpx #3
			bne ScoreLoop

			rts

		PlotDigit: {

			clc
			adc #245
			sta SCREEN_RAM + 1, y
			

			dey
			rts

		}


		rts
	}
		






	UpdateSprite: {

		lda SPRITE_POINTERS, x
		sec
		sbc #CarPointer
		sta ZP.CurrentID


		CheckPastIntersection:

			lda ZP.IntersectionStatus, x
			cmp #2
			beq LaneOpen

			ldx ZP.CurrentID
			lda ZP.DirectionOn, x
			bne LaneOpen

			ldx ZP.X

			lda ZP.WaitingTime, x
			beq Furious
			dec ZP.WaitingTime, x
			lda ZP.IntersectionStatus, x
			cmp #1
			bne NotBlocking

			Furious:

			jsr DecreaseScore


			NotBlocking:

			

			rts


		LaneOpen:

		ldx ZP.CurrentID
		lda ZP.CarScores + 1, y
		beq Decrease

			sec
			sbc #1
			sta ZP.CarScores + 1, y
			jmp CheckDirection

		Decrease:

			lda #1
			sta ZP.CarScores + 1, y

			lda ZP.CarScores, y
			cmp #1
			beq CheckDirection

			sed

		
			sec
			sbc #1
			sta ZP.CarScores, y

			cld

		CheckDirection:

			ldx ZP.X
			lda ZP.WaitingTime, x
			cmp #250
			bcs NoImprove

			inc ZP.WaitingTime, x

		NoImprove:

		lda ZP.CurrentID

		bne NotRight

		jmp GoingRight

		NotRight:

		cmp #1
		beq GoingLeft

		cmp #2
		beq GoingDown

		GoingUp:	

		
			ldx ZP.X

			lda ZP.Position_SUB, x
			sec
			sbc ZP.Speed_LSB, x
			sta ZP.Position_SUB, x

			bcs NoWrap1B

			lda VIC.SPRITE_0_Y, y
			sec
			sbc #1
			sta VIC.SPRITE_0_Y, y

			NoWrap1B:

			lda VIC.SPRITE_0_Y, y
			sec
			sbc ZP.Speed_MSB, x
			sta VIC.SPRITE_0_Y, y

			cmp #36
			bcs NoExit1

			jsr RemoveCar
			jmp Finish

			NoExit1:

				cmp #InterY1
				bcs CheckInter1

				lda #2
				sta ZP.IntersectionStatus, x
				jmp NotInter1

			CheckInter1:

				cmp #InterY2
				bcs NotInter1

				lda #1
				sta ZP.IntersectionStatus, x

			NotInter1:

			jmp Finish
			

		GoingDown:

			ldx ZP.X

			lda ZP.Position_SUB, x
			clc
			adc ZP.Speed_LSB, x
			sta ZP.Position_SUB, x

			bcc NoWrap1D

			lda VIC.SPRITE_0_Y, y
			clc
			adc #1
			sta VIC.SPRITE_0_Y, y

			NoWrap1D:

			lda VIC.SPRITE_0_Y, y
			clc
			adc ZP.Speed_MSB, x
			sta VIC.SPRITE_0_Y, y

			cmp #250
			bcc NoExit2

			jsr RemoveCar
			jmp Finish


			NoExit2:

				cmp #InterY2
				bcc CheckInter2

				lda #2
				sta ZP.IntersectionStatus, x
				jmp NotInter2

			CheckInter2:

				cmp #InterY1
				bcc NotInter2

				lda #1
				sta ZP.IntersectionStatus, x

			NotInter2:


			jmp Finish
		

		GoingLeft:

		
			ldx ZP.X

			lda ZP.Position_SUB, x
			sec
			sbc ZP.Speed_LSB, x
			sta ZP.Position_SUB, x

			bcs NoWrap1A

			lda VIC.SPRITE_0_X, y
			sec
			sbc #1
			sta VIC.SPRITE_0_X, y

			NoWrap1A:

				bcs NoWrap2A

				dec ZP.PositionX_MSB, x

			NoWrap2A:

				lda VIC.SPRITE_0_X, y
				sec
				sbc ZP.Speed_MSB, x
				sta VIC.SPRITE_0_X, y

				bcs NoWrap3A

				dec ZP.PositionX_MSB, x

			NoWrap3A:

			lda ZP.PositionX_MSB, x
			bne NotInter3

			lda VIC.SPRITE_0_X, y
			cmp #8
			bcs NoExit3

			jsr RemoveCar
			jmp SetMSB


			NoExit3:

				cmp #InterX1
				bcs CheckInter3

				lda #2
				sta ZP.IntersectionStatus, x
				
				jmp NotInter3

			CheckInter3:

				cmp #InterX2
				bcs NotInter3

				lda #1
				sta ZP.IntersectionStatus, x
				

			NotInter3:

			jmp SetMSB


		GoingRight:

			ldx ZP.X

			lda ZP.Position_SUB, x
			clc
			adc ZP.Speed_LSB, x
			sta ZP.Position_SUB, x

			bcc NoWrap1

			lda VIC.SPRITE_0_X, y
			clc
			adc #1
			sta VIC.SPRITE_0_X, y

			NoWrap1:

				bcc NoWrap2

				inc ZP.PositionX_MSB, x

			NoWrap2:

				lda VIC.SPRITE_0_X, y
				clc
				adc ZP.Speed_MSB, x
				sta VIC.SPRITE_0_X, y

				bcc NoWrap3

				inc ZP.PositionX_MSB, x

			NoWrap3:

				lda ZP.PositionX_MSB, x
				beq NoExit4

				lda VIC.SPRITE_0_X, y
				cmp #89
				bcc NoExit4

				jsr RemoveCar
				jmp SetMSB


			NoExit4:

				lda VIC.SPRITE_0_X, y
				cmp #InterX2
				bcc CheckInter4

				lda #2
				sta ZP.IntersectionStatus, x
				jmp NotInter4

			CheckInter4:

				cmp #InterX1
				bcc NotInter4

				lda #1
				sta ZP.IntersectionStatus, x

			NotInter4:


		SetMSB:

			lda ZP.PositionX_MSB, x
			beq NoMSB

			MSB:	

				lda VIC.SPRITE_MSB
				ora MSB_On, x
				sta VIC.SPRITE_MSB
		
				jmp Finish

			NoMSB:  

				lda VIC.SPRITE_MSB
				and MSB_Off, x
				sta VIC.SPRITE_MSB


		Finish:

		rts
	}


	CheckSpawn: {

		lda ZP.MinTimer
		beq Ready

		dec ZP.MinTimer
		rts

		Ready:

		lda ZP.CarsToSpawn
		beq Finish

		dec ZP.CarsToSpawn
		jsr SpawnCar


		Finish:


		rts
	}

	CheckLanesUnlock: {

		ldx #4

		Loop:

			lda ZP.CarsInLane - 1, x
			bne EndLoop

			lda #1
			sta ZP.DirectionOn - 1, x

			EndLoop:

				dex
				bne Loop
				



		rts
	}

	FrameUpdate: {

		jsr DrawBest

		inc ZP.Counter

		jsr CheckLanesUnlock
		jsr CheckSpawn

		lda ZP.SpawnTimer
		beq Ready

		dec ZP.SpawnTimer
		jmp Sprites

		Ready:

			inc ZP.CarsToSpawn

			lda ZP.SpawnSpeed
			cmp #51
			bcc NoChange
			sbc #3
			sta ZP.SpawnSpeed

		NoChange:

		lda ZP.SpawnSpeed
		sta ZP.SpawnTimer


		Sprites:

		ldx #0
		ldy #0

		Loop:

			stx ZP.X
			sty ZP.Y

			lda VIC.SPRITE_0_Y, y
			beq EndLoop

			jsr UpdateSprite


			EndLoop:

			ldx ZP.X
			ldy ZP.Y

			iny
			iny
			inx
			cpx #8
			bcc Loop

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

		lda ZP.ColourAddress
		clc
		adc #40
		sta ZP.ColourAddress
		bcc NoWrap2

		inc ZP.ColourAddress + 1

		NoWrap2:


		rts
	}


	Toggle: {

		lda #10
		sta ZP.Cooldown

		lda ZP.DirectionOn, x
		beq TurnOn

		dec ZP.DirectionOn, x
		rts

		TurnOn:

		inc ZP.DirectionOn, x

		rts
	}

	CheckControls: {


		OkayToMove:

		lda ZP.Cooldown
		beq Ready

		dec ZP.Cooldown
		rts

		Ready:

		lda $dc00
		sta ZP.Amount

		// CheckFire:

		// 	and #JOY_FIRE
		// 	bne	CheckLeft

		// 	jmp Fire


		CheckLeft:

			lda ZP.Amount
			and #JOY_LEFT
			bne	CheckRight

			Left:

				ldx #0
				jmp Toggle

		CheckRight:

			lda ZP.Amount
			and #JOY_RIGHT
			bne	CheckUp

			Right:


				ldx #1
				jmp Toggle
			

		CheckUp:

			lda ZP.Amount
			and #JOY_UP
			bne	CheckDown

			Up:

				ldx #2
				jmp Toggle


		CheckDown:

			lda ZP.Amount
			and #JOY_DOWN
			bne	Finish

			Down:

				ldx #3
				jmp Toggle




		Finish:



		rts

	}	



	GetSpriteID: {

		ldy #0
		
		Loop:


			lda VIC.SPRITE_0_Y, y
			beq Found

			iny
			iny
			jmp Loop


		Found:


		rts
	}


	SpawnCar: {	


		lda ZP.CarsInPlay
		cmp #8
		bcc Okay

		inc ZP.CarsToSpawn

		rts

		Okay:


			lda #0
			sta ZP.EndID

			Retry:

			inc ZP.EndID
			lda ZP.EndID
			cmp #40
			bcc NoBlock

			inc ZP.CarsToSpawn
			rts

		NoBlock:

			jsr RANDOM.Get
			and #%00000011
			cmp ZP.LastSpawn
			beq Retry

		tax
		lda ZP.DirectionOn, x
		beq Retry
		
		txa
		sta ZP.LastSpawn

		pha
		jsr GetSpriteID
		pla

		
		tax
		inc ZP.CarsInLane, x
		lda ZP.LaneSpeed, x
		clc
		adc #10
		sta ZP.LaneSpeed, x
		bcc NoWrap

		inc ZP.LaneSpeed_MSB, x

		NoWrap:

		lda SpawnPositionX_LSB, x
		sta VIC.SPRITE_0_X, y

		lda SpawnPositionY, x
		sta VIC.SPRITE_0_Y, y

		lda #$99
		sta ZP.CarScores, y

		lda #250
		sta ZP.CarScores + 1, y

		lda SpawnPositionX_MSB, x
		sta ZP.Amount

		tya
		lsr
		tax

		lda ZP.LastSpawn
		clc
		adc #CarPointer
		sta SPRITE_POINTERS, x

		
		



		lda ZP.Amount
		beq NoMSB

		MSB:	

			lda VIC.SPRITE_MSB
			ora MSB_On, x
			sta VIC.SPRITE_MSB

			lda #1
			sta ZP.PositionX_MSB, x
			jmp PickAgain

		NoMSB:  

			lda VIC.SPRITE_MSB
			and MSB_Off, x
			sta VIC.SPRITE_MSB

			lda #0
			sta ZP.PositionX_MSB, x

		PickAgain:

		jsr RANDOM.Get
		and #%00001111
		beq PickAgain


		sta VIC.SPRITE_COLOR_0, x

		lda #127
		sta ZP.Position_SUB, x

		ldy ZP.LastSpawn
		lda ZP.LaneSpeed, y
		sta ZP.Speed_LSB, x

		lda ZP.LaneSpeed_MSB, y
		sta ZP.Speed_MSB, x

		lda #0
		sta ZP.IntersectionStatus, x

		lda VIC.SPRITE_ENABLE
		ora MSB_On, x
		sta VIC.SPRITE_ENABLE

		lda #MinGap
		sta ZP.MinTimer

		lda #250
		sta ZP.WaitingTime, x


		inc ZP.CarsInPlay


		rts



	}


	RemoveCar: {

		lda #0
		sta VIC.SPRITE_0_Y, y

		ldx ZP.X

		lda VIC.SPRITE_ENABLE
		and MSB_Off, x
		sta VIC.SPRITE_ENABLE

		dec ZP.CarsInPlay
		inc ZP.CarsToSpawn

		ldx ZP.CurrentID
		dec ZP.CarsInLane, x

		ldx #1
		jsr Crash


		jsr UpdateScore


		rts


	}



	FX_AD:
	.byte %00001001,  $21
	FX_SR:
	.byte %00001000,  $01
	FX_HI:
	.byte $19,  $05
	FX_LO:
	.byte $a1,  $50
	FX_WF:
	.byte $81, $21



	Crash: {

	   	lda #$08
		sta $d404

	    // Crank up volume
	    lda #$08
	    sta $d418
	    // ADSR Envelope Channel #1
	    lda FX_AD,x
	    sta $d405
	    lda FX_SR,x
	    sta $d406
	    // Frequency Channel #1
	    lda FX_HI,x
	    sta $d401
	    lda FX_LO,x
	    sta $d400
	    // Control Register Channel #1
	    lda FX_WF,x
	    sta $d404

	    rts

	}

	Reset: {
			lda #%00011011
	 		sta VIC.SCREEN_CONTROL
	 		rts

	 	}



	*= $0ec0 "Lookups"

	//SpawnPositionX_LSB:		.byte 0, 100, 184, 184
	//SpawnPositionX_MSB:		.byte 0, 1, 0, 0
	//SpawnPositionY:			.byte 154, 154, 1, 255


	SpawnPositionX_LSB:		.byte 0, 90, 160, 183
	SpawnPositionX_MSB:		.byte 0, 1, 0, 0
	SpawnPositionY:			.byte 126, 148, 35, 255

	MSB_On:		.byte %00000001, %00000010, %00000100,%00001000,%00010000,%00100000,%01000000,%10000000
	MSB_Off:	.byte %11111110, %11111101, %11111011,%11110111,%11101111,%11011111,%10111111,%01111111


	ValidColours:	.byte 9, 10, 11, 12, 14, 15
	CurrentColour:	.byte 0


}