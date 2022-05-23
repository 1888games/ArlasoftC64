
IRQ: {

	*= * "IRQ"

	.label OpenBorderIRQLine = 249
	.label MainIRQLine =255

	.label ResetBorderIRQLine = 0
	.label MultiplexerIRQLine = 20
	
	BackgroundColour:	.byte GREEN

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

		//lda #<MainIRQ
		//ldx #>MainIRQ
	//	ldy #MainIRQLine
		//jsr SetNextInterrupt

		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS
		cli

		rts


	}



	SetNextInterrupt: {

		sta INTERRUPT_VECTOR
		stx INTERRUPT_VECTOR + 1
		sty VIC.RASTER_Y
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+
		sta VIC.SCREEN_CONTROL

		rts
	}

	

	

	
	
	
	MainIRQ: {

		:StoreState()

		//inc $d020

		SetDebugBorder(3)

			lda #0
			sta $dc02

			ldy #2
			jsr INPUT.ReadJoystick

			//ldy #1
			//jsr INPUT.ReadJoystick

			jsr sid.play

		//	jsr $3028

			lda #TRUE
			sta MAIN.PerformFrameCodeFlag
			
			inc ZP.Counter
	
		Finish:

			lda MAIN.GameMode
			cmp #GAME_MODE_TITLE
			beq NoIRQs

			FatterInter:

				ldy #59
				//lda #<GameIRQ
				//ldx #>GameIRQ
				//jsr SetNextInterrupt
				jmp DoneIRQ

		NoIRQs:	

				lda #0
				sta ZP.CurrentID

				//ldy #TITLE.StartRow
				//sty ZP.CurrentRow
				//lda #<TITLE.TitleIRQ
			//	ldx #>TITLE.TitleIRQ
				//jsr SetNextInterrupt


		DoneIRQ:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		//dec $d020

		rti

	}

	





}