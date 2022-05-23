IRQ: {


	* = * "IRQ"

	.label INTERRUPT_CONTROL = 				$d01a
	.label INTERRUPT_STATUS = 				$d019
	.label RASTER_INTERRUPT_VECTOR = 		$fffe

	.label MainIRQLine = 220
	.label ShakeIRQLine = 254


	Mode:	.byte 0


	//.label Colours = 5
	//TowerColours:	.byte PURPLE, LIGHT_BLUE, CYAN, LIGHT_RED, BROWN
	//TowerLines:		.byte 30, 70, 105, 160, 218

	.label Colours = 2
	TowerColours:	.byte BLACK, BLACK
	TowerLines:		.byte 62, 218


	TowerStatus:	.byte 0
	SIDCounter:		.byte 0


	DisableCIAInterrupts: {

		lda #<NMI
		sta $fffa
		lda #>NMI
		sta $fffb

		// prevent CIA interrupts now the kernal is banked out
		lda #$7f
		sta VIC.IRQ_CONTROL_1
		sta VIC.IRQ_CONTROL_2

		lda VIC.IRQ_CONTROL_1
		lda VIC.IRQ_CONTROL_2

		rts

	}

	NMI: {

		rts
	}


	Setup: {

		lda #0
		sta Mode

		sei 	// disable interrupt flag
		lda INTERRUPT_CONTROL
		ora #%00000001		// turn on raster interrupts
		sta INTERRUPT_CONTROL

		lda #<MainIRQ
		ldx #>MainIRQ
		ldy #MainIRQLine
		jsr SetNextInterrupt

		asl INTERRUPT_STATUS
		cli

		rts


	}



	SetNextInterrupt: {

		sta RASTER_INTERRUPT_VECTOR
		stx RASTER_INTERRUPT_VECTOR + 1
		sty VIC.RASTER_LINE
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+
		sta VIC.SCREEN_CONTROL

		rts
	}




	PerformEveryFrame: {


		lda MAIN.FramesPerSecond
		cmp #50
		beq Okay

		lda SIDCounter
		beq Skip

		Okay:

		jsr SidFrameUpdate
		

		Skip:

		ldx SIDCounter
		inx
		cpx #6
		bcc Okay2

		ldx #0

		Okay2:

		stx SIDCounter
	
		SetDebugBorder(2)
		
		inc ZP.FrameCounter

   		ldy #2
		jsr INPUT.ReadJoystick

		ldy #1
		jsr INPUT.ReadJoystick


		lda #1
		sta MAIN.PerformFrameCodeFlag

		Finish:

		

		rts
	}

	
	MainIRQ: {

		:StoreState()
			
		SetDebugBorder(2)

		jsr PerformEveryFrame
		
		lda MAIN.GameActive
		beq Paused
   
	 	GameActive:
		
			jmp Finish

		Paused:


		 CheckFireButton:

		 	ldy #1
		 	lda INPUT.FIRE_UP_THIS_FRAME, y
		 	beq Finish

		Finish:

		SetDebugBorder(11)

		asl INTERRUPT_STATUS


		:RestoreState()

		rti

	}




}