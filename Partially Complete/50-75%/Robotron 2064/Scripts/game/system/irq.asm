
IRQ: {

	*= * "IRQ"

	.label OpenBorderIRQLine = 249
	.label MainIRQLine =255

	.label ResetBorderIRQLine = 0
	.label MultiplexerIRQLine = 20
	
	BackgroundColour:	.byte GREEN


	MultiIRQLines:	.byte 30, 1

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


		lda #<PLEXOR.MP_IRQ
		ldx #>PLEXOR.MP_IRQ
		ldy #0
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

	

	

		
		* = * "Main IRQ"
	
	
	MainIRQ: {

		:StoreState()

		
	
		SetDebugBorder(LIGHT_GREEN)

			lda #0
			sta $dc02

			ldy #2
			jsr INPUT.ReadJoystick

			ldy #1
			sty MAIN.PerformFrameCodeFlag
			jsr INPUT.ReadJoystick

			//jsr sid.play

			jsr $4028
			
		//	jsr $3028

		Finish:

			lda MAIN.GameMode
			cmp #GAME_MODE_LEVEL_COMPLETE
			beq NoIRQs

			FatterInter:

			
				ldy MAIN.MachineType
				lda MultiIRQLines, y
				tay

				lda #<PLEXOR.MP_IRQ
				ldx #>PLEXOR.MP_IRQ
				jsr SetNextInterrupt 

		NoIRQs:	

		DoneIRQ:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()



		rti

	}

	





}