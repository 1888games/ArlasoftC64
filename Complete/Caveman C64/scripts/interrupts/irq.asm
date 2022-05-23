
IRQ: {

	.label IRQControlRegister1 = $dc0d
	.label IRQControlRegister2 = $dd0d

	.label CavemanIRQLine = 200
	.label MainIRQLine = 10
	.label MusicIRQLine = 150

	DisableCIA: {

		// prevent CIA interrupts now the kernal is banked out
		lda #$7f
		sta IRQControlRegister1
		sta IRQControlRegister2

		rts

	}


	SetupInterrupts: {

		sei 	// disable interrupt flag
		lda VIC.INTERRUPT_CONTROL
		ora #%00000001		// turn on raster interrupts
		sta VIC.INTERRUPT_CONTROL

		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS
		cli

		rts


	}



	SetNextInterrupt: {

		sta REGISTERS.RASTER_INTERRUPT_VECTOR
		stx REGISTERS.RASTER_INTERRUPT_VECTOR + 1
		sty VIC.RASTER_Y
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+
		sta VIC.SCREEN_CONTROL

		rts
	}


	MusicIRQ:{

		//inc $d020

		inc VIC.BORDER_COLOR

		:StoreState()

		jsr SOUND.PlayMusic

		asl VIC.INTERRUPT_STATUS

		lda #<CavemanIRQ
		ldx #>CavemanIRQ
		ldy #CavemanIRQLine
		jsr SetNextInterrupt

		dec VIC.BORDER_COLOR

		:RestoreState()

		rti

	}

	MainIRQ: {

		
		//inc VIC.BORDER_COLOR

		:StoreState()
		
		lda #ONE
		sta MAIN.PerformFrameCodeFlag

		clc
		dec MAIN.GameCounter
		bne NotYet
	
		lda MAIN.GameCounter + 1
		sta MAIN.GameCounter
		asl 

		lda #ONE
		sta MAIN.GameTickFlag

		NotYet:

		asl VIC.INTERRUPT_STATUS

		lda #<MusicIRQ
		ldx #>MusicIRQ
		ldy #MusicIRQLine
		jsr SetNextInterrupt

		//dec $d020


		:RestoreState()

		//dec VIC.BORDER_COLOR


		rti

	}


	StartGame: {

		lda #ONE
		sta SOUND.MusicActive

		lda #ONE
		sta MAIN.GameIsActive

		ldx #55
		ldy #ZERO
		sty MAIN.WaitingForFire

		jsr CHAR_DRAWING.ColourObject
		rts
	}



	CheckFire: {



		lda MAIN.WaitingForFire
		cmp #1
		beq CheckButton

		dec MAIN.WaitingForFire
		jmp Finish

		CheckButton:

			lda REGISTERS.JOY_PORT_2
			and #JOY_FIRE
			bne Finish

		jsr StartGame

		Finish:
			rts
	}


	CavemanIRQ: {

	//	inc VIC.BORDER_COLOR
		
		:StoreState()

		//dec $d020

		lda MAIN.GameOver
		bne NotYet

		lda MAIN.WaitingForFire
		beq NotWaiting

		jsr CheckFire


		NotWaiting:

		lda MAIN.GameIsActive
		beq Paused

		jsr CAVEMAN.Control

		Paused:

		jsr CAVEMAN.Draw
	

		NotYet:

		asl VIC.INTERRUPT_STATUS
	
		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt

	//	inc $d020

		:RestoreState()

	///	dec VIC.BORDER_COLOR

		rti

	}
	






}