
IRQ: {

	*= * "IRQ"

	.label OpenBorderIRQLine = 249
	.label MainIRQLine =255

	.label ResetBorderIRQLine = 0
	.label MultiplexerIRQLine = 20
	
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

	SetLowInterrupt: {

		sta INTERRUPT_VECTOR
		stx INTERRUPT_VECTOR + 1
		sty VIC.RASTER_Y
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+

		sta VIC.SCREEN_CONTROL

		rts

	}



	BottomFatterIRQ: {

		:StoreState()

		SetDebugBorder(3)

			jsr INTER.BottomSprites
		
			FatterInter:

				ldy #MainIRQLine
				lda #<MainIRQ
				ldx #>MainIRQ
				jsr SetNextInterrupt


		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		//dec $d020

		rti

	}
	


	TopFatterIRQ: {

		:StoreState()

		SetDebugBorder(3)

			jsr INTER.TopSprites
		
			FatterInter:

				lda INTER.PosY + 2
				sec
				sbc #2
				tay
				lda #<BottomFatterIRQ
				ldx #>BottomFatterIRQ
				jsr SetNextInterrupt

		NoIRQs:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		//dec $d020

		rti

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

			//jsr sid.play

			jsr $3028

			lda #TRUE
			sta MAIN.PerformFrameCodeFlag
			
			inc ZP.Counter
	
		Finish:

			lda MAIN.GameMode
			cmp #GAME_MODE_TITLE
			beq NoIRQs


		NoSprites:

			lda MAIN.GameMode
			cmp #GAME_MODE_INTERSTITION
			beq FatterInter

			jmp NoIRQs

			FatterInter:

				ldy #10
				lda #<TopFatterIRQ
				ldx #>TopFatterIRQ
				jsr SetNextInterrupt

		NoIRQs:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		//dec $d020

		rti

	}

	





}