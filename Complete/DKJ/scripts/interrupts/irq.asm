
IRQ: {

	.label IRQControlRegister1 = $dc0d
	.label IRQControlRegister2 = $dd0d

	.label Snapper1RasterLine = 130
	.label BirdRasterLine = 160
	.label Snapper2RasterLine = 197




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

		lda #<KeyCageMonkeyIRQ
		ldx #>KeyCageMonkeyIRQ
		ldy #1
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



	Snapper1IRQ: {

		

		:StoreState()

		//dec $d020

		ldy #2
		jsr ENEMIES.DrawEnemiesForRow

		clc
		dec MAIN.GameCounter
		bne NotYet

		lda MAIN.GameCounter + 1
		sta MAIN.GameCounter
		asl 
		sta MONKEY.DropTime
		lda #ONE
		sta MAIN.GameTickFlag

		NotYet:

		asl VIC.INTERRUPT_STATUS

		lda #<BirdIRQ
		ldx #>BirdIRQ
		ldy #BirdRasterLine
		jsr SetNextInterrupt

		//sta $d020

		:RestoreState()


	

		rti

	}

	BirdIRQ:{

		:StoreState()

		//dec $d020

		ldy #ONE
		jsr ENEMIES.DrawEnemiesForRow

		

		asl VIC.INTERRUPT_STATUS

		lda #<Snapper2IRQ
		ldx #>Snapper2IRQ
		ldy #Snapper2RasterLine
		jsr SetNextInterrupt

		//inc $d020

		:RestoreState()

		
		rti


	}


	Snapper2IRQ:{

		:StoreState()

		//dec $d020

		ldy #ZERO
		jsr ENEMIES.DrawEnemiesForRow

		asl VIC.INTERRUPT_STATUS

		
		lda #<KeyCageMonkeyIRQ
		ldx #>KeyCageMonkeyIRQ
		ldy #1
		jsr SetNextInterrupt

		//inc $d020

		:RestoreState()




		rti


	}


	MonkeyIRQ: {

		
		:StoreState()

		//dec $d020

		jsr MONKEY.Control
		jsr MONKEY.Draw

		asl VIC.INTERRUPT_STATUS

	
		lda #<Snapper1IRQ
		ldx #>Snapper1IRQ
		ldy #Snapper1RasterLine
		jsr SetNextInterrupt

		//inc $d020

		:RestoreState()

		rti

	}

	KeyCageMonkeyIRQ:{

		:StoreState()

		lda #ONE
		sta MAIN.PerformFrameCodeFlag

		lda MAIN.GameIsActive
		beq Finish

		//dec $d020


		jsr CAGE.Draw
		jsr KEY.DrawKey
	

		lda #<MonkeyIRQ
		ldx #>MonkeyIRQ
		ldy #88
		jsr SetNextInterrupt



		//inc $d020

		Finish:

	asl VIC.INTERRUPT_STATUS
	
		:RestoreState()

		rti


	}








}