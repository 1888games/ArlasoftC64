
IRQ: {

	*=* "---IRQ"

	.label IRQControlRegister1 = $dc0d
	.label IRQControlRegister2 = $dd0d

	.label FrameIRQLine = 210

	Mode:				.byte 0



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

		SetDefaultIRQ:

			lda #<FrameIRQ
			ldx #>FrameIRQ
			ldy #FrameIRQLine
			jsr SetNextInterrupt

		ReenableInterrupts:

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


	FrameIRQ:{ 

		:Storestate()

		CheckIfPaused:

			lda MAIN.GameActive
			beq Paused

		GameActive:

			lda #1
			sta MAIN.PerformFrameCodeFlag

			jmp Finish	

		Paused:



		Finish:
			asl VIC.INTERRUPT_STATUS

			SetDebugBorder(0)

			:Restorestate()

		rti


	}




}