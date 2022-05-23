
IRQ: {

	*= * "IRQ"

	.label OpenBorderIRQLine = 249
	.label MainIRQLine =254
	
	.label ResetBorderIRQLine = 0
	.label MultiplexerIRQLine = 1
	.label SidTime = 5

	MultiIRQLines:	.byte 50, 35
	SidTimer:		.byte 5
	Frame:			.byte 0

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

		lda #255
		sta SidTimer
		
		lda MAIN.MachineType
		bne NoSkip

		
		lda #SidTime
		sta SidTimer

		//lda #16
		//sta STARS.StarsUse

		//lda #8
		//sta STARS.StartIDs + 1


		NoSkip:


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


	//SoundID: .byte 35

	MainIRQ: {

		:StoreState()

		SetDebugBorder(2)

		ResetBorder:	

			lda #0
			sta $dc02

			ldy #2
			jsr INPUT.ReadJoystick

			lda #255
			sta $dc02

			lda #0
			sta $dc03


            lda #%11011110    
            sta $dc00         
            lda $dc01          
            and #%00000010
           	bne OnePlayer
               
			//ldy #1
			//jsr INPUT.ReadJoystick

		 //	lda INPUT.JOY_LEFT_NOW, y
			//beq OnePlayer

			jsr MAIN.nmi
			

		OnePlayer:

			lda #TRUE
			sta MAIN.PerformFrameCodeFlag
			
			inc ZP.Counter
		
	
		Finish:

			
			ldy MAIN.MachineType
			lda MultiIRQLines, y
			tay


			lda #<PLEXOR.MP_IRQ
			ldx #>PLEXOR.MP_IRQ
			jsr SetNextInterrupt 

		NoSprites:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)


		:RestoreState()

		rti

	}

	





}