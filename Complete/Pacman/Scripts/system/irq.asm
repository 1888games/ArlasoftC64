
IRQ: {

	*= * "IRQ"

	.label OpenBorderIRQLine = 249
	.label MainIRQLine =235

	.label ResetBorderIRQLine = 0
	.label MultiplexerIRQLine = 20
	
	.label SidTime = 5

	MultiIRQLines:	.byte 40, 48
	SidTimer:		.byte 5
	Frame:			.byte 0

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

		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS
		cli

		lda #255
		sta SidTimer
		
		lda MAIN.MachineType
		bne NoSkip

		lda #SidTime
		sta SidTimer

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

	OpenBorderIRQ: {



		:StoreState()

		OpenBorder:

			lda VIC.SCREEN_CONTROL 
			and #%11110111
			sta VIC.SCREEN_CONTROL 
			
		Finish:
	
			ldy #255
			lda #<D011_IRQ
			ldx #>D011_IRQ
			jsr SetNextInterrupt 
			

		asl VIC.INTERRUPT_STATUS
		:RestoreState()

		rti

	}



	ScreenOff:	.byte $ff
	


	D011_IRQ: {

		:StoreState()	

		SetDebugBorder(YELLOW)
		
		lda SCROLLER.D011
		and ScreenOff
		sta $d011
		
	
		lda VIC.SCREEN_CONTROL 
		ora #%00001000
		sta VIC.SCREEN_CONTROL 

		lda MAIN.GameActive
		
			ldy #0
			lda #<TOP_HUD.IRQ_Entry
			ldx #>TOP_HUD.IRQ_Entry
			jsr SetNextInterrupt

		

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()


		rti
	}



	BottomHud_IRQ: {

		:StoreState()

		SetDebugBorder(12)

		lda #<OpenBorderIRQ
		ldx #>OpenBorderIRQ
		ldy #249
		jsr IRQ.SetNextInterrupt

		SetDebugBorder(0)

		asl VIC.INTERRUPT_STATUS
		:RestoreState()
		rti

		:StoreState()
	
			jsr BOTTOM_HUD.Draw

			lda #<OpenBorderIRQ
			ldx #>OpenBorderIRQ
			ldy #249
			jsr IRQ.SetNextInterrupt

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)



		rti
	}


	
	SoundIRQ: {

		:StoreState()

		SetDebugBorder(11)

		
		lda IRQ.SidTimer
		cmp #SidTime
		beq SkipSound
		
		jsr sid.play
		jsr SFX_KIT_IRQ

		SkipSound:

		//jsr ACTOR.GHOST.ShowDebug

			
		lda #<IRQ.MainIRQ
		ldx #>IRQ.MainIRQ
		ldy #IRQ.MainIRQLine
		jsr IRQ.SetNextInterrupt


		DoneIRQ:


		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()


		rti





	}

	
	MainIRQ: {

		:StoreState()

		SetDebugBorder(3)

			lda #TRUE
			sta MAIN.PerformFrameCodeFlag

			lda #0
			sta VIC.SPRITE_ENABLE
			
			//sta VIC.SPRITE_PRIORITY

			lda #0
			sta $dc02
				
			jsr SCROLLER.IRQ_Update	

			ldy #2
			jsr INPUT.ReadJoystick
		
			inc ZP.Counter
	
		Finish:

			// ldy MAIN.MachineType
			// lda MultiIRQLines, y
			// tay

			// lda #<PLEXOR.MP_IRQ
			// ldx #>PLEXOR.MP_IRQ
			// jsr SetNextInterrupt

		lda MAIN.GameActive
		bne UseUsual


			
			lda IRQ.SidTimer
			cmp #SidTime
			beq SkipSound
			
			jsr sid.play
			jsr SFX_KIT_IRQ

			SkipSound:

		UseUsual:

			lda #<OpenBorderIRQ
			ldx #>OpenBorderIRQ
			ldy #249
			jsr IRQ.SetNextInterrupt


		DoneIRQ:




		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()


		rti

	}

	





}