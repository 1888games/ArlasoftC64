
IRQ: {

	.label IRQControlRegister1 = $dc0d
	.label IRQControlRegister2 = $dd0d

	.label MainIRQLine= 218

	.label TopIRQLine = 0
	.label BottomIRQLine = 135

	MusicTimer: .byte 0, 6


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



	TopIRQ: {

		:StoreState()

		SetDebugBorder(3)

		lda MAIN.GameIsOver
		bne NoUpdate

		lda #0
		jsr ENEMIES.SpriteUpdate

		NoUpdate:

		lda #<BottomIRQ
		ldx #>BottomIRQ
		ldy #BottomIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(11)

		:RestoreState()

		rti
	}


	BottomIRQ: {

		:StoreState()

		SetDebugBorder(3)

		lda MAIN.GameIsOver
		bne NoUpdate

		lda #5
		jsr ENEMIES.SpriteUpdate

		jsr ENEMIES.FrameUpdate


		NoUpdate:

		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(11)

		:RestoreState()

		rti
	}



	
	MainIRQ: {

		:StoreState()

		jsr sid.play

		SetDebugBorder(2)
		
		inc ZP_COUNTER

   		ldy #2
		jsr INPUT.ReadJoystick

		lda #1
		sta MAIN.PerformFrameCodeFlag
		
		lda MAIN.GameActive
		beq Paused
   
	 	GameActive:
		
			lda #<TopIRQ
			ldx #>TopIRQ
			ldy #TopIRQLine
			jsr SetNextInterrupt
			jmp Finish

		Paused:

			 lda MAIN.GameIsOver
			 beq Finish
			
			 lda MAIN.GameOverTimer
			 beq CheckFireButton

			 dec MAIN.GameOverTimer
			 jmp Finish

		 CheckFireButton:

		 	ldy #1
		 	lda INPUT.FIRE_UP_THIS_FRAME, y
		 	beq Finish

		Finish:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(11)

		:RestoreState()

		rti

	}

	





}