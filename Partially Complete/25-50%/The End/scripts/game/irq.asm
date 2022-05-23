
IRQ: {

	* = * "-IRQ"

	.label IRQControlRegister1 = $dc0d
	.label IRQControlRegister2 = $dd0d

	.label MainIRQLine= 230
	.label MothershipIRQLine = 36
	.label EarlyEnemiesIRQLine = 20
	.label MothershipColourLine = 59
	.label EnemiesIRQLine = 74

	.label OpenBorderIRQLine = 249
	.label CloseBorderIRQLine = 255


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



	MothershipIRQ: {

		:StoreState()

		jsr MOTHERSHIP.DrawSprites


		lda #<MothershipColourIRQ
		ldx #>MothershipColourIRQ
		ldy #MothershipColourLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)


		:RestoreState()

		

		rti


	}

	MothershipColourIRQ: {

		:StoreState()

		jsr MOTHERSHIP.ColourBottomHalf

		lda #<EnemiesIRQ
		ldx #>EnemiesIRQ
		ldy #EnemiesIRQLine
		jsr SetNextInterrupt

		SetDebugBorder(0)

		asl VIC.INTERRUPT_STATUS

	
		:RestoreState()

		rti



	}


	EarlyEnemiesIRQ: {

		:StoreState()

		SetDebugBorder(13)

		jsr ENEMY_DRAW.SetSpritesEarly

		lda #<MothershipIRQ
		ldx #>MothershipIRQ
		ldy #MothershipIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti


	}

	EnemiesIRQ: {

		:StoreState()

		SetDebugBorder(14)

		jsr ENEMY_DRAW.SetSprites

		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti



	}



	
	MainIRQ: {

		:StoreState()

		jsr PLAYER.DrawShip

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

			jmp Finish

		Paused:

			jmp NoIRQ

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

		lda #<OpenBorderIRQ
		ldx #>OpenBorderIRQ
		ldy #OpenBorderIRQLine
		jsr SetNextInterrupt




		NoIRQ:

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(11)

		:RestoreState()

		rti

	}

		


	OpenBorderIRQ: {

		:StoreState()

 		lda $d011
		and #$f7
		sta $d011

		lda #<CloseBorderIRQ
		ldx #>CloseBorderIRQ
		ldy #CloseBorderIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti


	}

	CloseBorderIRQ: {

		:StoreState()

		lda $d011
		ora #$08
		sta $d011

		lda #<EarlyEnemiesIRQ
		ldx #>EarlyEnemiesIRQ
		ldy #EarlyEnemiesIRQLine
		jsr SetNextInterrupt

		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti


	}






}