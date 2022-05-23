GAME: {

	* = $0330  "Game"

	ScreenRowLSB:	.fill 25, <[i * $28]
	ScreenRowMSB:	.fill 25, >[i * $28]

	.label CharSetStart = 246
	.label StalacCharID = CharSetStart + 1
	.label BlankCharID = CharSetStart
	.label StalacDestroyID = CharSetStart + 4
	.label Ship = CharSetStart + 2
	.label BulletCharID = CharSetStart + 3
	.label BatCharID = CharSetStart + 8
	.label StalacDestroyEndID = CharSetStart + 7



	.encoding "screencode_upper"
	TopLeft: .text 	"SCORE"
	Middle:	 .text 	"LEVEL"
	Lives:	.text 	"LIVES"
	TopRight: .text "HIGH "
	GameOver:	.text "GAME OVER          "

	Show: {

		jsr TopRow

		jsr DrawLevel
		jsr SetupData
		
		rts
		
	}



	* = * "Setup Data"


	Clear: {


		ldx #39
		lda #0

		ClearLoop:

			sta ZP.Columns, x
			dex
			bpl ClearLoop


		rts
	}

	SetupData: {

		ldx #39

		Loop:	

			stx ZP.X

			lda ZP.ResetLevel
			beq NoReset

			NewColumn:

				jsr RANDOM.Get
				and #%00000111
				clc
				adc ZP.StartHeight
				sta ZP.Columns, x	

			NoReset:

				lda ZP.Columns, x
				beq EndLoop

				cmp #23
				bcc Okay

				lda #15
				sta ZP.Columns, x

			Okay:

				jsr DrawColumn

			EndLoop:

			ldx ZP.X
			dex
		
			bpl Loop


		ldx #81
		lda #0
		sta ZP.BatsInPlay
		sta ZP.BulletRow
		sta ZP.BulletColumn

		Loop2:

			sta ZP.FallingColumns, x
			sta ZP.LastColumn
			dex
			bpl Loop2

		lda #20
		sta ZP.ShipColumn

		lda #24
		sta ZP.ShipRow


		rts


	}

	* = * "Draw Column"


	DrawColumn: {

		cmp #25
		bcc Okay

		lda #1

		Okay:

		sta ZP.Row
		stx ZP.Column

		Loop:

			jsr CalculateAddresses

			ldy #0
			jsr DrawStalac
			
			dec ZP.Row
			bne Loop


		rts
	}

	* = $800 "Draw Stalac"

	DrawStalac: {

		lda #StalacCharID
		sta (ZP.ScreenAddress), y

		lda ZP.Column
		and #%00001111
		bne Okay

		lda #YELLOW

		Okay:
		sta (ZP.ColourAddress), y


		

		NotDead:


		rts
	}



	* = * "Draw Destroy"

	DrawDestroy: {

		lda #StalacDestroyID
		sta (ZP.ScreenAddress), y

		lda ZP.Column
		and #%00001111
		bne Okay

		lda #YELLOW

		Okay:
		sta (ZP.ColourAddress), y


		rts
	}

	* = * "CalculateAddresses"

	CalculateAddresses:{

		//get row for this position
		ldy ZP.Row
		cpy #25
		bcc Okay

		lda #24
		sta ZP.Row
		

		Okay:

		lda ScreenRowLSB, y
	
		clc
		adc ZP.Column

		sta ZP.ScreenAddress
		sta ZP.ColourAddress

		lda ScreenRowMSB, y	
		adc #0  // get carry bit from above
		sta ZP.RowOffset

		lda #>SCREEN_RAM
		clc
		adc ZP.RowOffset
		sta ZP.ScreenAddress + 1

		lda #>COLOR_RAM
		clc
		adc ZP.RowOffset
		sta ZP.ColourAddress + 1

		rts

	}


	//* = $0800 "Game Code continued"

	* = * "Draw Level"

	DrawLevel: {
	
		ldx #0

		lda ZP.Level
		cmp #10
		bcc NotTen

		lda #1
		sta SCREEN_RAM + 16
		inx

		lda #YELLOW
		sta COLOR_RAM + 16
		sta COLOR_RAM + 17

		NotTen:

		lda ZP.Level
		clc
		adc #49
		sta SCREEN_RAM + 16, x


		lda ZP.Lives
		clc
		adc #48
		sta SCREEN_RAM + 26, x

		rts
	}

* = * "Top Row"

    TopRow: {

    	ldx #0

    	Loop:

    		cpx #5
    		bcs Blank

    		lda TopLeft, x
    		sta SCREEN_RAM, x

    		lda Middle, x
    		sta SCREEN_RAM + 10, x

    		lda Lives, x
    		sta SCREEN_RAM + 20, x


    		lda TopRight, x
    		sta SCREEN_RAM + 30, x

    		jmp EndLoop

    		Blank:

    		lda #32
    		sta SCREEN_RAM, x
    		sta SCREEN_RAM + 10, x
    		sta SCREEN_RAM + 20, x
    		sta SCREEN_RAM + 30, x

    		EndLoop:

    		inx
    		cpx #10
    		bcc Loop


    	ldx #0

    	Loop2:

    		lda #WHITE
    		sta COLOR_RAM, x
    		inx
    		cpx #40
    		bcc Loop2



    	rts

    }

    * = * "StartFall"

	StartFall: {

		lda #0
		sta ZP.Amount

		Choose:

			lda ZP.Amount
			cmp #12
			bcs Finish

			inc ZP.Amount

			jsr RANDOM.Get
			and #%00111111
			cmp #40
			bcs Choose

			tax
			stx ZP.Column

			lda ZP.Columns, x
			beq Choose

			sta ZP.Row

		jsr ForceFall

		Finish:


		rts
	}

	 * = * "ForceFall"

	ForceFall: {

		ldy #0

		CheckNotFalling:

			lda ZP.FallingRows, y
			beq Found

			iny
			cpy #8
			bcc CheckNotFalling

			jmp Finish

		Found:

			lda ZP.Column
			sta ZP.FallingColumns, y

			lda ZP.Row
			sta ZP.FallingRows, y

			lda ZP.FallTime
			sta ZP.FallingTimer, y

			ldx ZP.Column
			dec ZP.Columns, x

			inc ZP.Falling

		Finish:


		rts
	}



 * = * "DisplayShip"

	DisplayShip: {

		lda ZP.ShipRow
		sta ZP.Row

		lda ZP.ShipColumn
		sta ZP.Column

		jsr CalculateAddresses

		ldy #0

		lda #Ship
		sta (ZP.ScreenAddress), y

		lda #WHITE
		sta (ZP.ColourAddress), y

		rts
	}


	 * = * "CheckFall"
 

	CheckFall: {

		lda ZP.Falling
		tax

		cpx #8
		bcs NoFallSpace

		SlotAvailable:

			jsr RANDOM.Get
			cmp ZP.FallChance
			bcs NoFallSpace

			jsr StartFall

		NoFallSpace:

			ldy #0

			Loop:

				sty ZP.Y

				lda ZP.FallingRows, y
				beq EndLoop3

				jsr UpdateFall

				EndLoop3:

				ldy ZP.Y
				iny
				cpy #8
				bcc Loop

		Finish:

		rts
	}

	 * = * "UpdateFall"


	UpdateFall: {

		cmp #25
		bcc Okay4

		lda #0
		sta ZP.FallingRows, y
		rts


		Okay4:

		sta ZP.Row

		lda ZP.FallingTimer, y
		beq Ready

		sec
		sbc #1
		sta ZP.FallingTimer, y
		rts

		Ready:

			lda ZP.FallTime
			sta ZP.FallingTimer, y

			lda ZP.FallingColumns, y
			sta ZP.Column

			jsr CalculateAddresses



			ldy #0
			lda #BlankCharID
			sta (ZP.ScreenAddress), y

			ldy ZP.Y

			lda ZP.FallingRows, y
			clc
			adc #1
			sta ZP.FallingRows, y
			sta ZP.Row

			cmp #25
			bcs Destroy

		Redraw:

			lda ZP.Column
			cmp ZP.ShipColumn
			bne NotDead

			lda ZP.Row
			beq NotDead

			cmp ZP.ShipRow
			bne NotDead

			jsr Dead


			NotDead:

			ldy #40
			jsr DrawStalac
			rts

		Destroy:

			ldy #0
			jsr DrawDestroy

			jsr BlowUpStalac


			NoExplosion:

				ldy ZP.Y
				lda #0
				sta ZP.FallingRows, y
				sta ZP.FallingColumns, y

				dec ZP.Falling


		rts
	}


	Restart: {

		lda #0
		sta ZP.GameMode
		sta ZP.BatsInPlay
		sta ZP.ResetLevel
		sta VIC.BORDER_COLOR
		sta ZP.Row
		sta ZP.Column

		lda ZP.NewDelay
    	sta ZP.NewTimer

		lda #5
		sta ZP.Cooldown

		jsr MAIN.Clear

		jsr Show
		
		.break

		jmp MAIN.Loop

	}



	 * = * "BlowUpStalac"

	BlowUpStalac: {

		ldy #0

		FindLoop:

			lda ZP.DestroyedRows, y
			beq Found

			iny
			cpy #16
			bcc FindLoop

			jmp NoExplosion

		Found:

			lda ZP.Row
			sec
			sbc #1
			sta ZP.DestroyedRows, y

			lda ZP.Column
			sta ZP.DestroyedColumns, y

			cmp ZP.LastColumn
			bne NoExplosion

			Choose:

			jsr RANDOM.Get
			and #%00111111
			cmp #40
			bcs Choose

			sta ZP.LastColumn

		NoExplosion:


		rts
	}	


	 * = * "CheckDestroy"

	CheckDestroy: {

		lda ZP.Counter
		and #%00000011
		beq Okay

		rts

		Okay:

		ldy #0

		Loop:

			sty ZP.Y

			lda ZP.DestroyedRows, y
			beq EndLoop

			sta ZP.Row

			lda ZP.DestroyedColumns, y
			sta ZP.Column

			jsr CalculateAddresses

			ldy #0
			lda (ZP.ScreenAddress), y
			cmp #StalacDestroyID
			bcc Destroy

			cmp #StalacDestroyEndID
			beq Delete

			clc
			adc #1
			sta (ZP.ScreenAddress), y
			jmp EndLoop

			Delete:

				lda #BlankCharID
				sta (ZP.ScreenAddress), y

			Destroy:

				ldy ZP.Y
				lda #0
				sta ZP.DestroyedRows, y

			EndLoop:

				ldy ZP.Y
				iny
				cpy #16
				bcc Loop




		rts
	}



	 * = * "DrawBullet"

	DrawBullet: {

		lda ZP.BulletColumn
		sta ZP.Column

		lda ZP.BulletRow
		sta ZP.Row

		jsr CalculateAddresses

		ldy #0

		Skip:


		lda #BulletCharID
		sta (ZP.ScreenAddress), y

		lda ZP.Row
		and #%00001111
		bne Okay

		lda #7

		Okay:

		sta (ZP.ColourAddress), y


		rts
	}


 * = * "DeleteBullet"

	DeleteBullet: {

		lda ZP.BulletRow
		sta ZP.Row

		lda ZP.BulletColumn
		sta ZP.Column

		jsr CalculateAddresses

		ldy #0
		lda #BlankCharID
		sta (ZP.ScreenAddress), y


		rts
	}



	* = * "UpdateBullet"

	UpdateBullet: {

		lda ZP.BulletRow
		bne BulletActive

		jmp Finish


		BulletActive:

		jsr DeleteBullet

		dec ZP.BulletRow
		lda ZP.BulletRow
		bne DontDestroy

		jmp Destroy

		DontDestroy:

		lda ZP.BulletColumn
		sta ZP.Column

		lda ZP.BulletRow
		sta ZP.Row

		jsr CalculateAddresses

		ldy #0
		lda (ZP.ScreenAddress), y
		cmp #StalacCharID
		beq HitStalac

		cmp #BatCharID
		bcs HitBat

		ldy #40
		lda (ZP.ScreenAddress), y
		cmp #BatCharID
		bcs HitBat

		ldy #0
		jsr DrawBullet.Skip
		rts


		HitBat:

		ldy #0

		BatLoop:

			lda ZP.BatRows, y
			cmp ZP.Row
			bne EndLoop2

			lda ZP.BatColumns, y
			cmp ZP.Column
			bne EndLoop2

			lda #0
			sta ZP.BatRows, y

			dec ZP.BatsInPlay

			ldy #0
			jsr DrawDestroy

			inc ZP.Row

			jsr BlowUpStalac
			jmp Destroy

	
			EndLoop2:

			iny
			cpy ZP.MaxBats
			bcc BatLoop

			jmp Finish


		HitStalac:

		CheckIfFalling:

		ldy #0

		Loop:

			lda ZP.FallingColumns, y
			cmp ZP.Column
			bne EndLoop

			lda ZP.FallingRows, y
			cmp ZP.Row
			bne EndLoop

			jmp Destroy

			EndLoop:

			iny
			cpy #4
			bcc Loop

		BlowUp:

			ldx ZP.BulletColumn
			dec ZP.Columns, x

			ldy #0
			jsr DrawDestroy

			inc ZP.Row

			jsr BlowUpStalac

			dec ZP.Row
			lda ZP.Row
			beq Destroy

			jsr RANDOM.Get
			and #%00000111
			bne Destroy

			jsr ForceFall


		Destroy:

			lda #0
			sta ZP.BulletRow




		Finish:

		rts
	}



	* = * "Fire"

	Fire: {

		lda ZP.BulletRow
		bne Finish

		lda ZP.ShipColumn
		sta ZP.BulletColumn

		lda ZP.ShipRow
		sec
		sbc #1
		sta ZP.BulletRow

		jsr DrawBullet

		ldx #0
		jsr Crash


		Finish:


		rts
	}


	* = * "DeleteShip"

	
	DeleteShip: {

		lda ZP.ShipRow
		sta ZP.Row

		lda ZP.ShipColumn
		sta ZP.Column

		jsr CalculateAddresses

		ldy #0

		lda #BlankCharID
		sta (ZP.ScreenAddress), y

		lda #WHITE
		sta (ZP.ColourAddress), y

		rts
	}




	* = * "CheckControls"

	CheckControls: {

		lda ZP.GameMode
		beq Okay3

		jmp Finish

		Okay3:

		lda $dc00
		sta ZP.Amount

		CheckFire:

			and #JOY_FIRE
			bne	NoFire

		jsr Fire

		NoFire:
		
		lda ZP.Cooldown
		beq Ready

		dec ZP.Cooldown
		rts

		Ready:

		lda $dc00
		sta ZP.Amount

	
		CheckLeft:

			lda ZP.Amount
			and #JOY_LEFT
			bne	CheckRight

			Left:

				lda ZP.ShipColumn
				beq Finish

				jsr DeleteShip

				dec ZP.ShipColumn

				jmp Move
			

		CheckRight:

			lda ZP.Amount
			and #JOY_RIGHT
			bne	CheckUp

			Right:

				lda ZP.ShipColumn
				cmp #39
				beq Finish

				jsr DeleteShip

				inc ZP.ShipColumn

				jmp Move
		

	CheckUp:

		lda ZP.Amount
		and #JOY_UP
		bne	CheckDown

		Up:	

			lda ZP.ShipRow
			beq Finish

			sec
			sbc #1
			sta ZP.Row


			lda ZP.ShipColumn
			sta ZP.Column

			jsr CalculateAddresses

			ldy #0
			lda (ZP.ScreenAddress), y
			cmp #BlankCharID
			beq Okay

			jmp Finish

			Okay:

			jsr DeleteShip

			lda ZP.Row
			sec
			sbc #1
			sta ZP.ShipRow

			jmp Move



	CheckDown:

		lda ZP.Amount
		and #JOY_DOWN
		bne	Finish

		Down:

			lda ZP.ShipRow
			cmp #24
			beq Finish

			clc
			adc #1
			sta ZP.Row

			lda ZP.ShipColumn
			sta ZP.Column


			jsr CalculateAddresses

			ldy #0
			lda (ZP.ScreenAddress), y
			cmp #BlankCharID
			beq Okay2

			jmp Finish

			Okay2:

			jsr DeleteShip

			lda ZP.Row
			clc
			adc #1
			sta ZP.ShipRow

		Move:	

			lda #3
			sta ZP.Cooldown

			jsr DisplayShip
	
		Finish:

		rts

	}	



	* = * "BatUpdate"

	BatUpdate: {

	
		ldy #0


		Loop:

			sty ZP.X

			lda ZP.BatRows, y
			sta ZP.Row
			beq EndLoop


			jsr UpdateBat

			EndLoop:

			ldy ZP.X
			iny
			cpy ZP.MaxBats
			bcc Loop


		rts
	}


	* = * "Dead"

	Dead: {
	
		lda #RED
		sta VIC.BORDER_COLOR

		lda #1
		sta ZP.GameMode

		lda #50
		sta ZP.NewTimer

		dec ZP.Lives
		lda ZP.Lives
		bne Okay

		lda #3
		sta ZP.GameMode

		ldx #0

		Loop:

			lda GameOver, x
			sta SCREEN_RAM + 10, x

			lda #1
			sta COLOR_RAM + 10, x

			inx
			cpx #20
			bcc Loop


		Okay:


		rts
	}

	* = * "DrawBat"

	DrawBat: {

	

		lda ZP.BatColumns, y
		sta ZP.Column
		and #%00000001
		sta ZP.Amount
		
		lda ZP.BatRows, y
		sta ZP.Row

		jsr CalculateAddresses

		ldy #0
		lda (ZP.ScreenAddress), y
		cmp #BlankCharID
		beq NoDestroy

		cmp #BatCharID
		bcs NoDestroy

		cmp #Ship
		bne DidntKill


		jmp Dead


		DidntKill:


		Destroy:

			ldy ZP.X
			lda #0
			sta ZP.BatRows, y
			dec ZP.BatsInPlay
			rts

		NoDestroy:

			lda #BatCharID
			clc
			adc ZP.Amount

			ldy #0
			sta (ZP.ScreenAddress), y

			lda #DARK_GRAY
			sta (ZP.ColourAddress), y


		rts
	}

 * = * "DeleteBat"

	DeleteBat: {

		lda ZP.BatColumns, y
		sta ZP.Column
		
		lda ZP.BatRows, y
		sta ZP.Row


		jsr CalculateAddresses

		ldy #0
		lda (ZP.ScreenAddress), y
		cmp #BatCharID
		bcc NoDelete
		
		lda #BlankCharID
		sta (ZP.ScreenAddress), y

		

		NoDelete:




		rts
	}

	 * = * "UpdateBat"

	UpdateBat: {

		lda ZP.BatTimer, y
		beq Ready

		sec
		sbc #1
		sta ZP.BatTimer, y
		rts

		Ready:

		lda ZP.BatSpeed
		sta ZP.BatTimer, y

		jsr DeleteBat

		ldy ZP.X

		

		CheckMove:

			lda ZP.BatDirection, y
			beq GoingRight	


		GoingLeft:

			lda ZP.BatColumns, y
			sec
			sbc #1
			sta ZP.BatColumns, y

			bpl Draw
			jmp Delete
	
		GoingRight:


			lda ZP.BatColumns, y
			clc
			adc #1
			sta ZP.BatColumns, y

			cmp #40
			bcc Draw
			jmp Delete

		Delete:

			lda #0
			sta ZP.BatRows, y
			dec ZP.BatsInPlay
			rts

		Draw:

			jsr DrawBat

		rts
	}

		* = * "BatSpawn"

	BatSpawn: {	

		lda ZP.BatsInPlay
		cmp ZP.MaxBats
		beq NoSpawn

		jsr RANDOM.Get
		cmp ZP.BatChance
		bcs NoSpawn



		ldy #0

		Loop:

			lda ZP.BatRows, y
			beq Found

			iny
			cpy ZP.MaxBats
			bcc Loop

			jmp NoSpawn

		Found:

			inc ZP.BatsInPlay

			jsr RANDOM.Get
			and #%00000011
			clc
			adc #21
			sta ZP.BatRows, y

			lda ZP.ShipColumn
			cmp #5
			bcc Right

			cmp #35
			bcs Left

			jsr RANDOM.Get
			cmp #127
			bcs Right

		Left:

			lda #0
			sta ZP.BatColumns, y
			sta ZP.BatDirection, y
			jmp Draw

		Right:

			lda #39
			sta ZP.BatColumns, y
			sta ZP.BatDirection, y


		Draw:

			lda ZP.BatSpeed
			sta ZP.BatTimer, y

			jsr DrawBat

		NoSpawn:




		rts
	}

	* = * "NonGameplay"

	NonGameplay: {

		lda ZP.NewTimer
		beq Ready

		dec ZP.NewTimer
		rts

		Ready:

		lda #2
		sta ZP.GameMode

		rts
	}


	* = * "CheckComplete"

	CheckComplete: {	

		ldx #0

		Loop:

			lda SCREEN_RAM + 40, x
			cmp #BlankCharID
			bne NotComplete

			inx
			cpx #40
			bcc Loop

			jsr NextLevel


		NotComplete:

		rts
	}

	* = * "FrameUpdate"

	FrameUpdate: {	

		lda ZP.WaitFire
		beq NoWait

			lda $dc00
			and #JOY_FIRE
			beq NoWait

			rts


		NoWait:

		lda #0
		sta ZP.WaitFire
		

		lda ZP.GameMode
		beq GamePlay

		jmp NonGameplay

		GamePlay:


		jsr CheckFall
		jsr CheckDestroy
		jsr DisplayShip
		jsr UpdateBullet
		jsr BatSpawn
		jsr BatUpdate
		jsr CheckComplete

		lda ZP.GameMode
		bne Finish

		lda ZP.NewTimer
		beq Ready

		dec ZP.NewTimer
		rts

		Ready:

			lda ZP.NewDelay
			sta ZP.NewTimer

			lda #0
			sta ZP.Amount

			Choose:


			lda ZP.Amount
			cmp #20
			bcs Finish

			inc ZP.Amount

			jsr RANDOM.Get
			and #%00000011
			beq RandomCol

			lda ZP.LastColumn
			jmp CheckValid

			RandomCol:

			jsr RANDOM.Get
			and #%00111111
			cmp #40
			bcs Choose

			CheckValid:

			tax
			lda ZP.Columns, x
			stx ZP.Column
			stx ZP.LastColumn
			sta ZP.Row
			beq Choose

			cmp #23
			beq Dead2

			bcs Choose

			jmp NotDead

			Dead2:

			jsr Dead

			NotDead:

			ldy #0

			CheckNotFalling:

				lda ZP.FallingRows, y
				beq EndLoop

				lda ZP.FallingColumns, y
				cmp ZP.Column
				beq Choose

				EndLoop:

				iny
				cpy #8
				bcc CheckNotFalling

			Found:

			inc ZP.Row
			inc ZP.Columns, x

			jsr CalculateAddresses

			ldy #0
			jsr DrawStalac

		Finish:

		rts
	}


	NextLevel: {

		jsr Clear

		lda #GREEN
		sta VIC.BORDER_COLOR

		lda #2
		sta ZP.GameMode

		lda #50
		sta ZP.NewTimer

    	inc ZP.Level

    	lda ZP.Level
    	cmp #2
    	bne NoSpeed

    	dec ZP.FallTime

    	NoSpeed:

	    	cmp #4
	    	bne NoSpeed2

	    	dec ZP.FallTime

    	NoSpeed2:

	    	lda ZP.StartHeight
	    	cmp #10
	    	bcs NoIncrease

	    	clc
	    	adc #2
	    	sta ZP.StartHeight

    	NoIncrease:

	    	lda #1
	    	sta ZP.ResetLevel
	    	sta ZP.WaitFire

	    	lda ZP.MaxBats
	    	cmp #6
	    	bcs NoBatIncrease

	    	inc ZP.MaxBats
	    	dec ZP.BatSpeed
	    	inc ZP.FallChance

    	NoBatIncrease:

	    	lda ZP.NewDelay
	    	cmp #11
	    	bcc NoDelayChange
	    	sec
	    	sbc #5
	    	sta ZP.NewDelay

    	NoDelayChange:



    	rts
    }



	FX_AD:
	.byte %00000011,  %00000011
	FX_SR:
	.byte %00110001,  $01
	FX_HI:
	.byte $70,  $01
	FX_LO:
	.byte $30,  $12
	FX_WF:
	.byte $41, $81



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
	
	
}